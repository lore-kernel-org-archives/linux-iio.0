Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46555 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab3FOJo5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jun 2013 05:44:57 -0400
Message-ID: <51BB826F.8010906@kernel.org>
Date: Fri, 14 Jun 2013 21:51:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/7] staging:iio:ad7291: Remove userspace reset
References: <1371225508-32190-1-git-send-email-lars@metafoo.de> <1371225508-32190-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1371225508-32190-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/14/2013 04:58 PM, Lars-Peter Clausen wrote:
> There is no reason why userspace should want to trigger a manual reset of the
> device, so remove this functionality.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git
> ---
>  drivers/staging/iio/adc/ad7291.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index a3a3a2f..782e100 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -127,29 +127,6 @@ static int ad7291_i2c_write(struct ad7291_chip_info *chip, u8 reg, u16 data)
>  	return i2c_smbus_write_word_data(chip->client, reg, swab16(data));
>  }
>  
> -static ssize_t ad7291_store_reset(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7291_chip_info *chip = iio_priv(indio_dev);
> -
> -	return ad7291_i2c_write(chip, AD7291_COMMAND,
> -				chip->command | AD7291_RESET);
> -}
> -
> -static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, ad7291_store_reset, 0);
> -
> -static struct attribute *ad7291_attributes[] = {
> -	&iio_dev_attr_reset.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ad7291_attribute_group = {
> -	.attrs = ad7291_attributes,
> -};
> -
>  static irqreturn_t ad7291_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -569,7 +546,6 @@ static struct attribute_group ad7291_event_attribute_group = {
>  };
>  
>  static const struct iio_info ad7291_info = {
> -	.attrs = &ad7291_attribute_group,
>  	.read_raw = &ad7291_read_raw,
>  	.read_event_config = &ad7291_read_event_config,
>  	.write_event_config = &ad7291_write_event_config,
> 
