Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43158 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab3BBJ3Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 04:29:16 -0500
Message-ID: <510CDC6A.7000002@kernel.org>
Date: Sat, 02 Feb 2013 09:29:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/11] Partially revert "staging:iio:gyro:adxrs450 make
 more use of spi_read and spi_write."
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 02:27 PM, Lars-Peter Clausen wrote:
> This partially reverts commit cb4496876f03631eff913b3c608c964d48d61eb9. There is
> no apparent reason why we should split a transaction which consists out of
> multiple transfers into multiple transactions each having one transfer. While
> this works it introduces a bunch of unnecessary context switch and additional
> setup costs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Whole series applied to togreg branch of iio.git.

Thanks,
> ---
>  drivers/staging/iio/gyro/adxrs450_core.c | 48 ++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
> index f0ce81d..318e8c9 100644
> --- a/drivers/staging/iio/gyro/adxrs450_core.c
> +++ b/drivers/staging/iio/gyro/adxrs450_core.c
> @@ -34,8 +34,21 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
>  				    u8 reg_address,
>  				    u16 *val)
>  {
> +	struct spi_message msg;
>  	struct adxrs450_state *st = iio_priv(indio_dev);
>  	int ret;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = st->tx,
> +			.bits_per_word = 8,
> +			.len = 4,
> +			.cs_change = 1,
> +		}, {
> +			.rx_buf = st->rx,
> +			.bits_per_word = 8,
> +			.len = 4,
> +		},
> +	};
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADXRS450_READ_DATA | (reg_address >> 7);
> @@ -46,13 +59,10 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
>  	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
>  		st->tx[3]  |= ADXRS450_P;
>  
> -	ret = spi_write(st->us, st->tx, 4);
> -	if (ret) {
> -		dev_err(&st->us->dev, "problem while reading 16 bit register 0x%02x\n",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	ret = spi_read(st->us, st->rx, 4);
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfers[0], &msg);
> +	spi_message_add_tail(&xfers[1], &msg);
> +	ret = spi_sync(st->us, &msg);
>  	if (ret) {
>  		dev_err(&st->us->dev, "problem while reading 16 bit register 0x%02x\n",
>  				reg_address);
> @@ -105,8 +115,21 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
>   **/
>  static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
>  {
> +	struct spi_message msg;
>  	struct adxrs450_state *st = iio_priv(indio_dev);
>  	int ret;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = st->tx,
> +			.bits_per_word = 8,
> +			.len = 4,
> +			.cs_change = 1,
> +		}, {
> +			.rx_buf = st->rx,
> +			.bits_per_word = 8,
> +			.len = 4,
> +		},
> +	};
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADXRS450_SENSOR_DATA;
> @@ -114,13 +137,10 @@ static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
>  	st->tx[2] = 0;
>  	st->tx[3] = 0;
>  
> -	ret = spi_write(st->us, st->tx, 4);
> -	if (ret) {
> -		dev_err(&st->us->dev, "Problem while reading sensor data\n");
> -		goto error_ret;
> -	}
> -
> -	ret = spi_read(st->us, st->rx, 4);
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfers[0], &msg);
> +	spi_message_add_tail(&xfers[1], &msg);
> +	ret = spi_sync(st->us, &msg);
>  	if (ret) {
>  		dev_err(&st->us->dev, "Problem while reading sensor data\n");
>  		goto error_ret;
> 
