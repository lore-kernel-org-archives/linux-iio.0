Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34077 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbLESaa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2015 13:30:30 -0500
Subject: Re: [PATCH v2 2/2] iio: ina2xx: provide a sysfs parameter to allow
 async readout of the ADCs
To: Marc Titinger <mtitinger@baylibre.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1448884155-2546-1-git-send-email-mtitinger@baylibre.com>
 <1448884155-2546-3-git-send-email-mtitinger@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56632D45.40903@kernel.org>
Date: Sat, 5 Dec 2015 18:30:29 +0000
MIME-Version: 1.0
In-Reply-To: <1448884155-2546-3-git-send-email-mtitinger@baylibre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/11/15 11:49, Marc Titinger wrote:
> This can lead to repeated or skipped samples depending on the clock beat
> between the capture thread and the chip sampling clock, but will also spare
> reading/waiting for the Capture Ready Flag and improve the available i2c
> bandwidth for reading measurements.
> 
> Output of iio_info:
> ...snip...
> 4 device-specific attributes found:
>   attr 0: in_oversampling_ratio value: 4
>   attr 1: in_allow_async_readout value: 0
>   attr 2: integration_time_available value: 140 204 332 588 1100 2116 4156 8244
>   attr 3: in_sampling_frequency value: 114
> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
Missing one thing.
ABI Docs in Documentation/ABI/testing/sysfs-bus-iio-ina2xx-iio.txt

> ---
>  drivers/iio/adc/ina2xx-iio.c | 48 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-iio.c b/drivers/iio/adc/ina2xx-iio.c
> index 99fb73c..7575a12 100644
> --- a/drivers/iio/adc/ina2xx-iio.c
> +++ b/drivers/iio/adc/ina2xx-iio.c
> @@ -117,6 +117,7 @@ struct ina2xx_chip_info {
>  	s64 prev_ns;	/* track buffer capture time check, for underruns*/
>  	int int_time_vbus; /* Bus voltage integration time uS */
>  	int int_time_vshunt; /* Shunt voltage integration time uS */
> +	bool allow_async_readout;
>  };
>  
>  static const struct ina2xx_config ina2xx_config[] = {
> @@ -333,6 +334,33 @@ _err:
>  }
>  
>  
> +static ssize_t ina2xx_allow_async_readout_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%d\n", chip->allow_async_readout);
> +}
> +
> +static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> +	bool val;
> +	int ret;
> +
> +	ret = strtobool((const char *) buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	chip->allow_async_readout = val;
> +
> +	return len;
> +}
> +
> +
>  #define INA2XX_CHAN(_type, _index, _address) { \
>  	.type = _type, \
>  	.address = _address, \
> @@ -399,11 +427,12 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  	 * GPIO a triggered buffer could be used instead.
>  	 * For now, we pay for that extra read of the ALERT register
>  	 */
> -	do {
> -		ret = regmap_read(chip->regmap, INA226_ALERT_MASK,
> -				  &alert);
> -		if (ret < 0)
> -			goto _err;
> +	if (!chip->allow_async_readout)
> +		do {
> +			ret = regmap_read(chip->regmap, INA226_ALERT_MASK,
> +					  &alert);
> +			if (ret < 0)
> +				goto _err;
>  
>  		alert &= INA266_CVRF;
>  		trace_printk("Conversion ready: %d\n", !!alert);
> @@ -454,7 +483,8 @@ static int ina2xx_capture_thread(void *data)
>  	 * Poll a bit faster than the chip internal Fs, in case
>  	 * we wish to sync with the conversion ready flag.
>  	 */
> -	sampling_us -= 200;
> +	if (!chip->allow_async_readout)
> +		sampling_us -= 200;
>  
>  	do {
>  		buffer_us = ina2xx_work_buffer(indio_dev);
> @@ -477,6 +507,7 @@ int ina2xx_buffer_enable(struct iio_dev *indio_dev)
>  		     1000000/sampling_us, chip->avg);
>  
>  	trace_printk("Expected work period: %u us\n", sampling_us);
> +	trace_printk("Async readout mode: %d\n", chip->allow_async_readout);
>  
>  	chip->prev_ns = iio_get_time_ns();
>  
> @@ -518,7 +549,12 @@ static int ina2xx_debug_reg(struct iio_dev *indio_dev,
>  static IIO_CONST_ATTR_INT_TIME_AVAIL \
>   ("0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244");
>  
> +static IIO_DEVICE_ATTR(in_allow_async_readout, S_IRUGO | S_IWUSR,
> +		       ina2xx_allow_async_readout_show,
> +		       ina2xx_allow_async_readout_store, 0);
> +
>  static struct attribute *ina2xx_attributes[] = {
> +	&iio_dev_attr_in_allow_async_readout.dev_attr.attr,
>  	&iio_const_attr_integration_time_available.dev_attr.attr,
>  	NULL,
>  };
> 

