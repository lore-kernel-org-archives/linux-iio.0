Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35118 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbBMIAj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Feb 2015 03:00:39 -0500
Received: by mail-wi0-f180.google.com with SMTP id h11so10094887wiw.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2015 00:00:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1423774815-26816-3-git-send-email-roberta.dobrescu@gmail.com>
References: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>
	<1423774815-26816-3-git-send-email-roberta.dobrescu@gmail.com>
Date: Fri, 13 Feb 2015 10:00:37 +0200
Message-ID: <CAEnQRZDQ5iAP5_VGFk4b+RvRtbTmY6PVKEP01PPAmYUuCtvkhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: gp2ap020a00f: Select REGMAP_I2C
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 12, 2015 at 11:00 PM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> This patch adds missing 'select' statement for gp2ap020a00f driver.
> Without regmap_i2c, we get the following error when loading the module:
> Unknown symbol devm_regmap_init_i2c.
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index e0ed374..a224afd 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -73,6 +73,7 @@ config CM36651
>  config GP2AP020A00F
>         tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
>         depends on I2C
> +       select REGMAP_I2C
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         select IRQ_WORK
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
