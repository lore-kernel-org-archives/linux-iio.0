Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:55121 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0JGMqT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2010 08:46:19 -0400
Message-ID: <4CADC26A.4@cam.ac.uk>
Date: Thu, 07 Oct 2010 13:51:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: greg@kroah.com, drivers@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ring_generic: provide IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT
References: <1286454273-6598-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1286454273-6598-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/10 13:24, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
I'm guessing a user of this is following soon?

Ideally the patch title would mention the SIGNED UNSIGNED
defines as well, but they are so simple it doesn't really
matter.
> 
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/ring_generic.h |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
> index abd52ea..728aa41 100644
> --- a/drivers/staging/iio/ring_generic.h
> +++ b/drivers/staging/iio/ring_generic.h
> @@ -292,6 +292,23 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
>   **/
>  #define IIO_CONST_ATTR_SCAN_EL_TYPE(_name, _sign, _bits, _storagebits) \
>  	IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits);
> +
> +/**
> + * IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT - attr to specify the data format of a scan el
> + * @name: the scan el name (may be more general and cover a set of scan elements
> + * @_sign: either s or u for signed or unsigned
> + * @_bits: number of actual bits occuplied by the value
> + * @_storagebits: number of bits _bits is padded to when read out of buffer
> + * @_shiftbits: number of bits _shiftbits the result must be shifted
> + **/
> +#define IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT(_name, _sign, _bits, \
> +					       _storagebits, _shiftbits) \
> +	IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits \
> +		       ">>"#_shiftbits);
> +
> +#define IIO_SCAN_EL_TYPE_SIGNED         's'
> +#define IIO_SCAN_EL_TYPE_UNSIGNED       'u'
> +
>  /*
>   * These are mainly provided to allow for a change of implementation if a device
>   * has a large number of scan elements

