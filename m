Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35666 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbEDKuq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 06:50:46 -0400
Received: by widdi4 with SMTP id di4so116654971wid.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2015 03:50:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430730785-17833-2-git-send-email-ao2@ao2.it>
References: <1430730785-17833-1-git-send-email-ao2@ao2.it>
	<1430730785-17833-2-git-send-email-ao2@ao2.it>
Date: Mon, 4 May 2015 13:50:45 +0300
Message-ID: <CAEnQRZC6J267=Q8Dbu1X4U5pgH4pP5XKbHkk-uW=rk9yrK-xOA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI id
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 4, 2015 at 12:13 PM, Antonio Ospite <ao2@ao2.it> wrote:
> This id has been seen in the DSDT of the Teclast X98 Air 3G tablet based
> on Intel Bay Trail.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: linux-iio@vger.kernel.org

Looks good to me.

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/accel/kxcjk-1013.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 51da369..5b7a860 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1418,6 +1418,7 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
>  static const struct acpi_device_id kx_acpi_match[] = {
>         {"KXCJ1013", KXCJK1013},
>         {"KXCJ1008", KXCJ91008},
> +       {"KXCJ9000", KXCJ91008},
>         {"KXTJ1009", KXTJ21009},
>         {"SMO8500",  KXCJ91008},
>         { },
> --
> 2.1.4
>
