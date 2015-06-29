Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:36018 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbbF2H4W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jun 2015 03:56:22 -0400
Received: by lacny3 with SMTP id ny3so115158286lac.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2015 00:56:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <06cf34cbbfd8c82272c885ff3aab8f44dc72cb41.1435487041.git.knaack.h@gmx.de>
References: <cover.1435487041.git.knaack.h@gmx.de>
	<06cf34cbbfd8c82272c885ff3aab8f44dc72cb41.1435487041.git.knaack.h@gmx.de>
Date: Mon, 29 Jun 2015 10:56:20 +0300
Message-ID: <CAEnQRZCYQE-DPb+x1Xj2eR6bxNvk5b6hCJLLiLSHqVjN2=Kqfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio:light:ltr501: fix regmap dependency
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jun 28, 2015 at 1:31 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> The use of regmap in commit [1] requires REGMAP_I2C to be selected, in
> order to meet all dependencies.
>
> [1]     2f2c96338afc9f90aa5a0fca04ece1a5c389ee31
>         "iio: ltr501: Add regmap support."

The standard way to do this is:

Fixes: 2f2c96338afc ("iio: ltr501: Add regmap support.")

>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Otherwise,

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 730fa80..1f1e103 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -199,6 +199,7 @@ config SENSORS_LM3533
>  config LTR501
>         tristate "LTR-501ALS-01 light sensor"
>         depends on I2C
> +       select REGMAP_I2C
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         help
> --
> 2.3.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
