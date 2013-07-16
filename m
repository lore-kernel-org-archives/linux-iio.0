Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47775 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933036Ab3GPQ5P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 12:57:15 -0400
Message-ID: <51E57B6A.5090608@kernel.org>
Date: Tue, 16 Jul 2013 17:57:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] staging:iio:adt7316: Don't expose the chip reset
 to userspace
References: <1373987283-32657-1-git-send-email-lars@metafoo.de> <1373987283-32657-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1373987283-32657-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/16/2013 04:08 PM, Lars-Peter Clausen wrote:
> There is no reason why userspace should want to trigger a manual reset of the
> device, so remove this functionality.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/addac/adt7316.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 506b5a7..1e13568 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -551,31 +551,6 @@ static IIO_DEVICE_ATTR(enable_smbus_timeout, S_IRUGO | S_IWUSR,
>  		adt7316_store_enable_smbus_timeout,
>  		0);
>  
> -
> -static ssize_t adt7316_store_reset(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> -{
> -	struct iio_dev *dev_info = dev_to_iio_dev(dev);
> -	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	u8 config2;
> -	int ret;
> -
> -	config2 = chip->config2 | ADT7316_RESET;
> -
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> -	if (ret)
> -		return -EIO;
> -
> -	return len;
> -}
> -
> -static IIO_DEVICE_ATTR(reset, S_IWUSR,
> -		NULL,
> -		adt7316_store_reset,
> -		0);
> -
>  static ssize_t adt7316_show_powerdown(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -1675,7 +1650,6 @@ static IIO_DEVICE_ATTR(bus_type, S_IRUGO, adt7316_show_bus_type, NULL, 0);
>  static struct attribute *adt7316_attributes[] = {
>  	&iio_dev_attr_all_modes.dev_attr.attr,
>  	&iio_dev_attr_mode.dev_attr.attr,
> -	&iio_dev_attr_reset.dev_attr.attr,
>  	&iio_dev_attr_enabled.dev_attr.attr,
>  	&iio_dev_attr_ad_channel.dev_attr.attr,
>  	&iio_dev_attr_all_ad_channels.dev_attr.attr,
> @@ -1719,7 +1693,6 @@ static struct attribute *adt7516_attributes[] = {
>  	&iio_dev_attr_all_modes.dev_attr.attr,
>  	&iio_dev_attr_mode.dev_attr.attr,
>  	&iio_dev_attr_select_ex_temp.dev_attr.attr,
> -	&iio_dev_attr_reset.dev_attr.attr,
>  	&iio_dev_attr_enabled.dev_attr.attr,
>  	&iio_dev_attr_ad_channel.dev_attr.attr,
>  	&iio_dev_attr_all_ad_channels.dev_attr.attr,
> 
