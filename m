Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59949 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab0KSMLx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2010 07:11:53 -0500
Message-ID: <4CE66B10.80605@cam.ac.uk>
Date: Fri, 19 Nov 2010 12:18:24 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: RFC: more consitent DAC sysfs attributes naming
References: <544AC56F16B56944AEC3BD4E3D591771312EE15286@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771312EE15286@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/19/10 08:33, Hennerich, Michael wrote:
> Hi Jonathan,
> 
> I wonder if it would make more sense to use this...
> 
> drivers/staging/iio/dac/dac.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
> index 55005ee..62620ed 100644
> --- a/drivers/staging/iio/dac/dac.h
> +++ b/drivers/staging/iio/dac/dac.h
> @@ -2,5 +2,9 @@
>   * dac.h - sysfs attributes associated with DACs
>   */
> 
> +/* Deprecated */
>  #define IIO_DEV_ATTR_DAC(_num, _store, _addr)                  \
>         IIO_DEVICE_ATTR(dac_##_num, S_IWUSR, NULL, _store, _addr)
> +
> +#define IIO_DEV_ATTR_OUT_RAW(_num, _show, _addr)                               \
> +       IIO_DEVICE_ATTR(out##_num##_raw, S_IWUSR, _show, NULL, _addr)
Yes, that seems like the logical equivalent to in0_raw to me.
> 
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
> Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
> 
> 

