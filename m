Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:38580 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdKSUql (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Nov 2017 15:46:41 -0500
Received: by mail-io0-f194.google.com with SMTP id h205so13014291iof.5
        for <linux-iio@vger.kernel.org>; Sun, 19 Nov 2017 12:46:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509133543-4597-5-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net> <1509133543-4597-5-git-send-email-pmeerw@pmeerw.net>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Sun, 19 Nov 2017 12:46:40 -0800
Message-ID: <CAJCx=gkw=bwi2C-2sZAVMyKSDFpyY79Bi8qScB_J5vZ_OjavqA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] iio: health: max30102: Fix mode config values
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
> Table 4 of the datasheet specifies the mode control, these are not
> individual bits; add multi LED mode
>
> Add multi-LED mode and fix MODE_MASK (3 bits wide, not 2)

Yeah this much cleaner than the macros I had defined

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/health/max30102.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 6ca6182..13d5312 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -60,9 +60,10 @@
>  #define MAX30102_REG_FIFO_CONFIG_AFULL         BIT(0)
>
>  #define MAX30102_REG_MODE_CONFIG               0x09
> -#define MAX30102_REG_MODE_CONFIG_MODE_SPO2_EN  BIT(0)
> -#define MAX30102_REG_MODE_CONFIG_MODE_HR_EN    BIT(1)
> -#define MAX30102_REG_MODE_CONFIG_MODE_MASK     0x03
> +#define MAX30102_REG_MODE_CONFIG_MODE_HR       0x02 /* red LED */
> +#define MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2  0x03 /* red + IR LED */
> +#define MAX30102_REG_MODE_CONFIG_MODE_MULTI    0x07 /* multi-LED mode */
> +#define MAX30102_REG_MODE_CONFIG_MODE_MASK     GENMASK(2, 0)
>  #define MAX30102_REG_MODE_CONFIG_PWR           BIT(7)
>
>  #define MAX30102_REG_SPO2_CONFIG               0x0a
> @@ -287,11 +288,10 @@ static int max30102_chip_init(struct max30102_data *data)
>         if (ret)
>                 return ret;
>
> -       /* enable SPO2 mode */
> +       /* enable HR + SPO2 mode */
>         ret = regmap_update_bits(data->regmap, MAX30102_REG_MODE_CONFIG,
>                                  MAX30102_REG_MODE_CONFIG_MODE_MASK,
> -                                MAX30102_REG_MODE_CONFIG_MODE_HR_EN |
> -                                MAX30102_REG_MODE_CONFIG_MODE_SPO2_EN);
> +                                MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2);
>         if (ret)
>                 return ret;
>
> --
> 2.7.4
>
