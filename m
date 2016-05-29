Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34114 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbcE2Swv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:52:51 -0400
Subject: Re: [PATCH 1/2] iio: bh1780: dereference the client properly
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1464162027-24612-1-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <92834887-0e44-8bf6-a30b-7d47464af360@jic23.retrosnub.co.uk>
Date: Sun, 29 May 2016 19:52:48 +0100
MIME-Version: 1.0
In-Reply-To: <1464162027-24612-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/05/16 08:40, Linus Walleij wrote:
> The code in runtime_[suspend|resume] was assuming that the
> i2c client data was the bh1780 state container, but it contains
> the IIO device. So first dereference the IIO device from the
> i2c client, then get the state container using the iio_priv()
> call.
> 
> Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the fixes-togreg-post-rc1 branch of iio.git and marked for
stable.  Thanks,

Jonathan
> ---
> I have no idea how this screwed up in the submission, but I
> guess I managed to test it with CONFIG_PM disabled or something.
> Sorry!
meh, happens to us all from time to time ;)
> ---
>  drivers/iio/light/bh1780.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
> index f83595334ff1..5fd432df2c8f 100644
> --- a/drivers/iio/light/bh1780.c
> +++ b/drivers/iio/light/bh1780.c
> @@ -226,7 +226,8 @@ static int bh1780_remove(struct i2c_client *client)
>  static int bh1780_runtime_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> -	struct bh1780_data *bh1780 = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct bh1780_data *bh1780 = iio_priv(indio_dev);
>  	int ret;
>  
>  	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_POFF);
> @@ -241,7 +242,8 @@ static int bh1780_runtime_suspend(struct device *dev)
>  static int bh1780_runtime_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> -	struct bh1780_data *bh1780 = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct bh1780_data *bh1780 = iio_priv(indio_dev);
>  	int ret;
>  
>  	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_PON);
> 

