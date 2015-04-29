Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35809 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbbD2K2o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2015 06:28:44 -0400
Message-ID: <1430303320.2525.95.camel@hadess.net>
Subject: Re: [PATCH 1/3] iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI id
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date: Wed, 29 Apr 2015 12:28:40 +0200
In-Reply-To: <1430298111-20127-2-git-send-email-ao2@ao2.it>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
	 <1430298111-20127-2-git-send-email-ao2@ao2.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2015-04-29 at 11:01 +0200, Antonio Ospite wrote:
> This id has been seen in the DSTD for the Teclast X98 Air 3G tablet

DSDT.

> based on Intel Bay Trail.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/accel/kxcjk-1013.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c 
> b/drivers/iio/accel/kxcjk-1013.c
> index 51da369..5b7a860 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1418,6 +1418,7 @@ static const struct dev_pm_ops 
> kxcjk1013_pm_ops = {
>  static const struct acpi_device_id kx_acpi_match[] = {
>       {"KXCJ1013", KXCJK1013},
>       {"KXCJ1008", KXCJ91008},
> +     {"KXCJ9000", KXCJ91008},

I'm guessing it's not a polling one, right?

>       {"KXTJ1009", KXTJ21009},
>       {"SMO8500",  KXCJ91008},
>       { },
