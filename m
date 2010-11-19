Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:52634 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab0KSOAP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2010 09:00:15 -0500
Message-ID: <4CE68476.2040501@cam.ac.uk>
Date: Fri, 19 Nov 2010 14:06:46 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/3] staging: iio: dac: Update drivers to use new attribute
 naming
References: <1290170090-31015-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1290170090-31015-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/19/10 12:34, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Remove depreciated macro from header
Might be slightly preferable to do this as two patches, one to move to the new
naming and a second to deprecate the header.  Doesn't really matter though as there
is only the one user in tree.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/ad5624r_spi.c |   16 ++++++++--------
>  drivers/staging/iio/dac/dac.h         |    4 ----
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
> index 705ff50..c0d7de9 100644
> --- a/drivers/staging/iio/dac/ad5624r_spi.c
> +++ b/drivers/staging/iio/dac/ad5624r_spi.c
> @@ -180,10 +180,10 @@ static ssize_t ad5624r_write_internal_ref_mode(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> -static IIO_DEV_ATTR_DAC(0, ad5624r_write_dac, AD5624R_ADDR_DAC0);
> -static IIO_DEV_ATTR_DAC(1, ad5624r_write_dac, AD5624R_ADDR_DAC1);
> -static IIO_DEV_ATTR_DAC(2, ad5624r_write_dac, AD5624R_ADDR_DAC2);
> -static IIO_DEV_ATTR_DAC(3, ad5624r_write_dac, AD5624R_ADDR_DAC3);
> +static IIO_DEV_ATTR_OUT_RAW(0, ad5624r_write_dac, AD5624R_ADDR_DAC0);
> +static IIO_DEV_ATTR_OUT_RAW(1, ad5624r_write_dac, AD5624R_ADDR_DAC1);
> +static IIO_DEV_ATTR_OUT_RAW(2, ad5624r_write_dac, AD5624R_ADDR_DAC2);
> +static IIO_DEV_ATTR_OUT_RAW(3, ad5624r_write_dac, AD5624R_ADDR_DAC3);
>  
>  static IIO_DEVICE_ATTR(ldac_mode, S_IRUGO | S_IWUSR, ad5624r_read_ldac_mode,
>  		ad5624r_write_ldac_mode, 0);
> @@ -199,10 +199,10 @@ static IIO_DEV_ATTR_DAC_POWER_MODE(2, ad5624r_read_dac_power_mode, ad5624r_write
>  static IIO_DEV_ATTR_DAC_POWER_MODE(3, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 3);
>  
>  static struct attribute *ad5624r_attributes[] = {
> -	&iio_dev_attr_dac_0.dev_attr.attr,
> -	&iio_dev_attr_dac_1.dev_attr.attr,
> -	&iio_dev_attr_dac_2.dev_attr.attr,
> -	&iio_dev_attr_dac_3.dev_attr.attr,
> +	&iio_dev_attr_out0_raw.dev_attr.attr,
> +	&iio_dev_attr_out1_raw.dev_attr.attr,
> +	&iio_dev_attr_out2_raw.dev_attr.attr,
> +	&iio_dev_attr_out3_raw.dev_attr.attr,
>  	&iio_dev_attr_dac_power_mode_0.dev_attr.attr,
>  	&iio_dev_attr_dac_power_mode_1.dev_attr.attr,
>  	&iio_dev_attr_dac_power_mode_2.dev_attr.attr,
> diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
> index d9384c9..1d82f35 100644
> --- a/drivers/staging/iio/dac/dac.h
> +++ b/drivers/staging/iio/dac/dac.h
> @@ -2,9 +2,5 @@
>   * dac.h - sysfs attributes associated with DACs
>   */
>  
> -/* Deprecated */
> -#define IIO_DEV_ATTR_DAC(_num, _store, _addr)			\
> -	IIO_DEVICE_ATTR(dac_##_num, S_IWUSR, NULL, _store, _addr)
> -
>  #define IIO_DEV_ATTR_OUT_RAW(_num, _store, _addr)				\
>  	IIO_DEVICE_ATTR(out##_num##_raw, S_IWUSR, NULL, _store, _addr)

