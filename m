Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdA2Xga (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 18:36:30 -0500
Date: Mon, 30 Jan 2017 00:35:14 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: lee.jones@linaro.org, linux-input@vger.kernel.org,
        pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, harald@ccbib.org,
        fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
        marex@denx.de
Message-ID: <1356490394.76350.1485732914272@email.1und1.de>
In-Reply-To: <7ceea639e53d0517a3073229989f4f4ef0b17b84.1485711797.git.ksenija.stanojevic@gmail.com>
References: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
 <7ceea639e53d0517a3073229989f4f4ef0b17b84.1485711797.git.ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v13 2/5] iio: adc: mxs-lradc: Add support for adc driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Ksenija,

> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 29. Januar 2017 um 19:04 geschrieben:
> 
> 
> Add support for sixteen-channel 12-bit resolution ADC and its functions,
> which include general-purpose ADC readings, battery voltage measurement,
> and die temperature measurement.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
> ...
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> new file mode 100644
> index 0000000..cc8d6af
> --- /dev/null
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -0,0 +1,843 @@
> ...
> +
> +#define SHOW_SCALE_AVAILABLE_ATTR(ch)					\
> +static IIO_DEVICE_ATTR(in_voltage##ch##_scale_available, S_IRUGO,	\
> +		       mxs_lradc_adc_show_scale_avail, NULL, ch)
> +

checkpatch complains here:

ERROR: Macros with complex values should be enclosed in parentheses
#498: FILE: drivers/iio/adc/mxs-lradc-adc.c:343:
+#define SHOW_SCALE_AVAILABLE_ATTR(ch)					\
+static IIO_DEVICE_ATTR(in_voltage##ch##_scale_available, S_IRUGO,	\
+		       mxs_lradc_adc_show_scale_avail, NULL, ch)

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
#499: FILE: drivers/iio/adc/mxs-lradc-adc.c:344:
+static IIO_DEVICE_ATTR(in_voltage##ch##_scale_available, S_IRUGO,	\

total: 1 errors, 2 warnings, 869 lines checked

But the iio values on Olinuxino Maxi looks good.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
