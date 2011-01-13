Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:6437 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629Ab1AMUcp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 15:32:45 -0500
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Roland Stigge <rst@work-microwave.de>,
	"greg@kroah.com" <greg@kroah.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Roland Stigge <stigge@antcom.de>
Date: Thu, 13 Jan 2011 20:32:38 +0000
Subject: RE: [PATCH] iio: Fixpoint formatted output bugfix
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324BFF4271@LIMKCMBX1.ad.analog.com>
References: <1294940256-21253-1-git-send-email-rst@work-microwave.de>
In-Reply-To: <1294940256-21253-1-git-send-email-rst@work-microwave.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Roland Stigge wrote on 2011-01-13:
> Fix some ADC drivers' _scale interface to correct fixpoint formatted
> output
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: "Jonathan Cameron <jic23@cam.ac.uk>"
Acked-by: "Hennerich, Michael" <Michael.Hennerich@analog.com>

> diff --git a/drivers/staging/iio/adc/ad7476_core.c
> b/drivers/staging/iio/adc/ad7476_core.c index deb68c8..b8b54da 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c +++
> b/drivers/staging/iio/adc/ad7476_core.c @@ -68,7 +68,7 @@ static ssize_t
> ad7476_show_scale(struct device *dev,
>       /* Corresponds to Vref / 2^(bits) */
>       unsigned int scale_uv = (st->int_vref_mv * 1000) >> st-
>  chip_info->bits;
>
> -     return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
> +     return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv %
> 1000);
>  }
>  static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7476_show_scale, NULL,
> 0);
>
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index 6309d52..89ccf37 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -432,7 +432,7 @@ static
> ssize_t ad799x_show_scale(struct device *dev,
>       /* Corresponds to Vref / 2^(bits) */
>       unsigned int scale_uv = (st->int_vref_mv * 1000) >> st-
>  chip_info->bits;
>
> -     return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
> +     return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv %
> 1000);
>  }
>
>  static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad799x_show_scale, NULL,
> 0);

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


