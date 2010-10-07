Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:53492 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab0JGOdZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2010 10:33:25 -0400
Message-ID: <4CADDB86.3080507@cam.ac.uk>
Date: Thu, 07 Oct 2010 15:39:02 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: greg@kroah.com, linux-iio@vger.kernel.org, drivers@analog.com
Subject: Re: [PATCH] staging: iio: adc: ad799x drop in_precision in favor
 of new in_type
References: <1286460850-17804-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1286460850-17804-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/10 15:14, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> -drop in_precision in favor of new in_type -
> This also fixes the bug from the scan elements move (as a side effect)
> -add sign and storagebits to struct ad799x_chip_info
> -properly mask the results based on ad799x_chip_info:bits
> 
> staging: iio: adc: ad799x misc fixed per iio list review
> 
> remove new line
> remove storagebits from struct ad799x_chip_info
> use defined storagebits value for in_type
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad799x.h      |    4 +++-
>  drivers/staging/iio/adc/ad799x_core.c |   33 +++++++++++++++++++++------------
>  drivers/staging/iio/adc/ad799x_ring.c |    2 +-
>  3 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
> index 2325929..81a20d5 100644
> --- a/drivers/staging/iio/adc/ad799x.h
> +++ b/drivers/staging/iio/adc/ad799x.h
> @@ -13,7 +13,7 @@
>  #define  _AD799X_H_
>  
>  #define AD799X_CHANNEL_SHIFT			4
> -
> +#define AD799X_STORAGEBITS			16
>  /*
>   * AD7991, AD7995 and AD7999 defines
>   */
> @@ -97,6 +97,8 @@ struct ad799x_state;
>  struct ad799x_chip_info {
>  	u8				num_inputs;
>  	u8				bits;
> +	u8				storagebits;
> +	char				sign;
>  	u16				int_vref_mv;
>  	bool				monitor_mode;
>  	u16				default_config;
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index 2589856..35fad73 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -123,17 +123,18 @@ static AD799X_SCAN_EL(5);
>  static AD799X_SCAN_EL(6);
>  static AD799X_SCAN_EL(7);
>  
> -static ssize_t ad799x_show_precision(struct device *dev,
> +static ssize_t ad799x_show_type(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
>  {
> -	struct iio_dev *dev_info = dev_get_drvdata(dev);
> -	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
> -	return sprintf(buf, "%d\n", st->chip_info->bits);
> -}
> +	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = ring->indio_dev;
> +	struct ad799x_state *st = indio_dev->dev_data;
>  
> -static IIO_DEVICE_ATTR(in_precision, S_IRUGO, ad799x_show_precision,
> -		       NULL, 0);
> +	return sprintf(buf, "%c%d/%d\n", st->chip_info->sign,
> +		       st->chip_info->bits, AD799X_STORAGEBITS);
> +}
> +static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad799x_show_type, NULL, 0);
>  
>  static int ad7991_5_9_set_scan_mode(struct ad799x_state *st, unsigned mask)
>  {
> @@ -211,11 +212,11 @@ static ssize_t ad799x_read_single_channel(struct device *dev,
>  		if (ret < 0)
>  			goto error_ret;
>  
> -		data = rxbuf[0] & 0xFFF;
> +		data = rxbuf[0];
>  	}
>  
>  	/* Pretty print the result */
> -	len = sprintf(buf, "%u\n", data);
> +	len = sprintf(buf, "%u\n", data & ((1 << (st->chip_info->bits)) - 1));
>  
>  error_ret:
>  	mutex_unlock(&dev_info->mlock);
> @@ -473,7 +474,7 @@ static struct attribute *ad7991_5_9_3_4_scan_el_attrs[] = {
>  	&iio_const_attr_in2_index.dev_attr.attr,
>  	&iio_scan_el_in3.dev_attr.attr,
>  	&iio_const_attr_in3_index.dev_attr.attr,
> -	&iio_dev_attr_in_precision.dev_attr.attr,
> +	&iio_dev_attr_in_type.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -499,7 +500,7 @@ static struct attribute *ad7992_scan_el_attrs[] = {
>  	&iio_const_attr_in0_index.dev_attr.attr,
>  	&iio_scan_el_in1.dev_attr.attr,
>  	&iio_const_attr_in1_index.dev_attr.attr,
> -	&iio_dev_attr_in_precision.dev_attr.attr,
> +	&iio_dev_attr_in_type.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -543,7 +544,7 @@ static struct attribute *ad7997_8_scan_el_attrs[] = {
>  	&iio_const_attr_in6_index.dev_attr.attr,
>  	&iio_scan_el_in7.dev_attr.attr,
>  	&iio_const_attr_in7_index.dev_attr.attr,
> -	&iio_dev_attr_in_precision.dev_attr.attr,
> +	&iio_dev_attr_in_type.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -671,6 +672,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7991] = {
>  		.num_inputs = 4,
>  		.bits = 12,
> +		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>  		.int_vref_mv = 4096,
>  		.dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
>  		.scan_attrs = &ad7991_5_9_3_4_scan_el_group,
> @@ -679,6 +681,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7995] = {
>  		.num_inputs = 4,
>  		.bits = 10,
> +		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>  		.int_vref_mv = 1024,
>  		.dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
>  		.scan_attrs = &ad7991_5_9_3_4_scan_el_group,
> @@ -687,6 +690,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7999] = {
>  		.num_inputs = 4,
>  		.bits = 10,
> +		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>  		.int_vref_mv = 1024,
>  		.dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
>  		.scan_attrs = &ad7991_5_9_3_4_scan_el_group,
> @@ -695,6 +699,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7992] = {
>  		.num_inputs = 2,
>  		.bits = 12,
> +		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>  		.int_vref_mv = 4096,
>  		.monitor_mode = true,
>  		.default_config = AD7998_ALERT_EN,
> @@ -706,6 +711,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7993] = {
>  		.num_inputs = 4,
>  		.bits = 10,
> +		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>  		.int_vref_mv = 1024,
>  		.monitor_mode = true,
>  		.default_config = AD7998_ALERT_EN,
> @@ -717,6 +723,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7994] = {
>  		.num_inputs = 4,
>  		.bits = 12,
> +		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>  		.int_vref_mv = 4096,
>  		.monitor_mode = true,
>  		.default_config = AD7998_ALERT_EN,
> @@ -728,6 +735,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7997] = {
>  		.num_inputs = 8,
>  		.bits = 10,
> +		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>  		.int_vref_mv = 1024,
>  		.monitor_mode = true,
>  		.default_config = AD7998_ALERT_EN,
> @@ -739,6 +747,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7998] = {
>  		.num_inputs = 8,
>  		.bits = 12,
> +		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>  		.int_vref_mv = 4096,
>  		.monitor_mode = true,
>  		.default_config = AD7998_ALERT_EN,
> diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
> index d0217f8..c6871fa 100644
> --- a/drivers/staging/iio/adc/ad799x_ring.c
> +++ b/drivers/staging/iio/adc/ad799x_ring.c
> @@ -53,7 +53,7 @@ int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask)
>  		mask >>= 1;
>  	}
>  
> -	ret = be16_to_cpu(ring_data[count]) & 0xFFF;
> +	ret = be16_to_cpu(ring_data[count]);
>  
>  error_free_ring_data:
>  	kfree(ring_data);

