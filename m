Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751149AbdL2NYv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 08:24:51 -0500
Date: Fri, 29 Dec 2017 13:24:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: humidity: hts221: move common code in
 hts221_core
Message-ID: <20171229132447.1bd5a172@archlinux>
In-Reply-To: <1953687a7f71cbc6a65d51d412c86fa4a5b93f3f.1514042380.git.lorenzo.bianconi@redhat.com>
References: <cover.1514042380.git.lorenzo.bianconi@redhat.com>
        <1953687a7f71cbc6a65d51d412c86fa4a5b93f3f.1514042380.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 23 Dec 2017 18:16:20 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Move duplicated i2c/spi probe code in hts221_probe()
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
This is fine.  Will pick up when patch 2 is ready.

Thanks,

Jonathan 

> ---
>  drivers/iio/humidity/hts221.h      |  3 ++-
>  drivers/iio/humidity/hts221_core.c | 18 ++++++++++++++++--
>  drivers/iio/humidity/hts221_i2c.c  | 18 ++----------------
>  drivers/iio/humidity/hts221_spi.c  | 18 ++----------------
>  4 files changed, 22 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index 51d021966222..c581af8c0f5d 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -61,7 +61,8 @@ struct hts221_hw {
>  extern const struct dev_pm_ops hts221_pm_ops;
>  
>  int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val);
> -int hts221_probe(struct iio_dev *iio_dev);
> +int hts221_probe(struct device *dev, int irq, const char *name,
> +		 const struct hts221_transfer_function *tf_ops);
>  int hts221_set_enable(struct hts221_hw *hw, bool enable);
>  int hts221_allocate_buffers(struct hts221_hw *hw);
>  int hts221_allocate_trigger(struct hts221_hw *hw);
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index daef177219b6..d3f7904766bd 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -581,12 +581,26 @@ static const struct iio_info hts221_info = {
>  
>  static const unsigned long hts221_scan_masks[] = {0x3, 0x0};
>  
> -int hts221_probe(struct iio_dev *iio_dev)
> +int hts221_probe(struct device *dev, int irq, const char *name,
> +		 const struct hts221_transfer_function *tf_ops)
>  {
> -	struct hts221_hw *hw = iio_priv(iio_dev);
> +	struct iio_dev *iio_dev;
> +	struct hts221_hw *hw;
>  	int err;
>  	u8 data;
>  
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*hw));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, (void *)iio_dev);
> +
> +	hw = iio_priv(iio_dev);
> +	hw->name = name;
> +	hw->dev = dev;
> +	hw->irq = irq;
> +	hw->tf = tf_ops;
> +
>  	mutex_init(&hw->lock);
>  
>  	err = hts221_check_whoami(hw);
> diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
> index f38e4b7e0160..2c97350a0f76 100644
> --- a/drivers/iio/humidity/hts221_i2c.c
> +++ b/drivers/iio/humidity/hts221_i2c.c
> @@ -66,22 +66,8 @@ static const struct hts221_transfer_function hts221_transfer_fn = {
>  static int hts221_i2c_probe(struct i2c_client *client,
>  			    const struct i2c_device_id *id)
>  {
> -	struct hts221_hw *hw;
> -	struct iio_dev *iio_dev;
> -
> -	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*hw));
> -	if (!iio_dev)
> -		return -ENOMEM;
> -
> -	i2c_set_clientdata(client, iio_dev);
> -
> -	hw = iio_priv(iio_dev);
> -	hw->name = client->name;
> -	hw->dev = &client->dev;
> -	hw->irq = client->irq;
> -	hw->tf = &hts221_transfer_fn;
> -
> -	return hts221_probe(iio_dev);
> +	return hts221_probe(&client->dev, client->irq,
> +			    client->name, &hts221_transfer_fn);
>  }
>  
>  static const struct acpi_device_id hts221_acpi_match[] = {
> diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
> index 57cbc256771b..55b29b53b9d1 100644
> --- a/drivers/iio/humidity/hts221_spi.c
> +++ b/drivers/iio/humidity/hts221_spi.c
> @@ -80,22 +80,8 @@ static const struct hts221_transfer_function hts221_transfer_fn = {
>  
>  static int hts221_spi_probe(struct spi_device *spi)
>  {
> -	struct hts221_hw *hw;
> -	struct iio_dev *iio_dev;
> -
> -	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*hw));
> -	if (!iio_dev)
> -		return -ENOMEM;
> -
> -	spi_set_drvdata(spi, iio_dev);
> -
> -	hw = iio_priv(iio_dev);
> -	hw->name = spi->modalias;
> -	hw->dev = &spi->dev;
> -	hw->irq = spi->irq;
> -	hw->tf = &hts221_transfer_fn;
> -
> -	return hts221_probe(iio_dev);
> +	return hts221_probe(&spi->dev, spi->irq,
> +			    spi->modalias, &hts221_transfer_fn);
>  }
>  
>  static const struct of_device_id hts221_spi_of_match[] = {

