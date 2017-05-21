Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37595 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbdEUNwX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 09:52:23 -0400
Subject: Re: [PATCH] iio: light: ltr501 Fix interchanged als/ps register field
To: Franziska Naepelt <franziska.naepelt@idt.com>
Cc: linux-iio@vger.kernel.org
References: <d42349ae-0202-38aa-2f24-610180772ab5@idt.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5e0f4afc-ee45-f74c-f4a1-ec895d217eef@kernel.org>
Date: Sun, 21 May 2017 14:52:21 +0100
MIME-Version: 1.0
In-Reply-To: <d42349ae-0202-38aa-2f24-610180772ab5@idt.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/05/17 11:41, Franziska Naepelt wrote:
> The register mapping for the IIO driver for the Liteon Light and Proximity
> sensor LTR501 interrupt mode is interchanged (ALS/PS).
> There is a register called INTERRUPT register (address 0x8F)
> Bit 0 represents PS measurement trigger.
> Bit 1 represents ALS measurement trigger.
> This two bit fields are interchanged within the driver.
> see datasheet page 24:
> http://optoelectronics.liteon.com/upload/download/DS86-2012-0006/S_110_LTR-501ALS-01_PrelimDS_ver1%5B1%5D.pdf
> 
> Signed-off-by: Franziska Naepelt <franziska.naepelt@idt.com>
> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Hi Franziska,

I think your email client is replacing all the tabs with spaces which
means this won't apply.  I've just done it by hand, but you might want
to look into this in future.  There are some hints in the kernel
documentation.

Anyhow, applied to the fixes-togreg branch of iio.git with a fixes
tag added and marked for stable (stable is up to me but ideally
you'd have figured out when this broke and added a fixes tag).

Not bad for a first patch ;)  Hopefully the first of many.

Thanks,

Jonathan
> ---
>   drivers/iio/light/ltr501.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index b30e0c1..67838ed 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -74,9 +74,9 @@
>   static const struct reg_field reg_field_it =
>                   REG_FIELD(LTR501_ALS_MEAS_RATE, 3, 4);
>   static const struct reg_field reg_field_als_intr =
> -                REG_FIELD(LTR501_INTR, 0, 0);
> -static const struct reg_field reg_field_ps_intr =
>                   REG_FIELD(LTR501_INTR, 1, 1);
> +static const struct reg_field reg_field_ps_intr =
> +                REG_FIELD(LTR501_INTR, 0, 0);
>   static const struct reg_field reg_field_als_rate =
>                   REG_FIELD(LTR501_ALS_MEAS_RATE, 0, 2);
>   static const struct reg_field reg_field_ps_rate =

