Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60297 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab0KSMMR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2010 07:12:17 -0500
Message-ID: <4CE66B28.5080103@cam.ac.uk>
Date: Fri, 19 Nov 2010 12:18:48 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging: iio: dac: more consistent DAC sysfs attributes
 naming
References: <1290167170-24090-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1290167170-24090-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/19/10 11:46, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Align DAC sysfs attributes naming with the convention used by ADC
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/dac.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
> index 55005ee..d9384c9 100644
> --- a/drivers/staging/iio/dac/dac.h
> +++ b/drivers/staging/iio/dac/dac.h
> @@ -2,5 +2,9 @@
>   * dac.h - sysfs attributes associated with DACs
>   */
>  
> +/* Deprecated */
>  #define IIO_DEV_ATTR_DAC(_num, _store, _addr)			\
>  	IIO_DEVICE_ATTR(dac_##_num, S_IWUSR, NULL, _store, _addr)
> +
> +#define IIO_DEV_ATTR_OUT_RAW(_num, _store, _addr)				\
> +	IIO_DEVICE_ATTR(out##_num##_raw, S_IWUSR, NULL, _store, _addr)

