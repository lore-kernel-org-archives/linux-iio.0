Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33128 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760930AbdDSIak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Apr 2017 04:30:40 -0400
Received: by mail-qt0-f178.google.com with SMTP id m36so13372118qtb.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Apr 2017 01:30:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491566026-302-1-git-send-email-fabrice.gasnier@st.com>
References: <1491566026-302-1-git-send-email-fabrice.gasnier@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Wed, 19 Apr 2017 10:30:39 +0200
Message-ID: <CA+M3ks6fujDoxhQqA8VS6x+pFcHJPEZ4p8J+Ci0YnAcoCuhy_Q@mail.gmail.com>
Subject: Re: [PATCH] iio: stm32 trigger: fix sampling_frequency read
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-04-07 13:53 GMT+02:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
> When prescaler (PSC) is 0, it means div factor is 1: counter clock
> frequency is equal to input clk / (PSC + 1).
> When reload value is 8 for example, counter counts 9 cycles, from 0 to 8.
> This is handled in frequency write routine, by writing respectively:
> - prescaler - 1 to PSC
> - reload value - 1 to ARR
> This fix does the opposite when reading the frequency from PSC and ARR:
> - prescaler is PSC + 1
> - reload value is ARR + 1
>
> Thus, PSC may be 0, depending on requested sampling frequency (div 1).
> In this case, reading freq wrongly reports 0, instead of computing and
> reporting correct value.
> Remove test on !psc and !arr.
>
> Small test on stm32f4 (example on tim1_trgo), before this fix:
> $ cd /sys/bus/iio/devices/triggerX
> $ echo 10000 > sampling_frequency
> $ cat sampling_frequency
> 0
>
> After this fix:
> $ echo 10000 > sampling_frequency
> $ cat sampling_frequency
> 10000
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 994b96d..5ee362b 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -152,10 +152,10 @@ static ssize_t stm32_tt_read_frequency(struct device *dev,
>         regmap_read(priv->regmap, TIM_PSC, &psc);
>         regmap_read(priv->regmap, TIM_ARR, &arr);
>
> -       if (psc && arr && (cr1 & TIM_CR1_CEN)) {
> +       if (cr1 & TIM_CR1_CEN) {
>                 freq = (unsigned long long)clk_get_rate(priv->clk);
> -               do_div(freq, psc);
> -               do_div(freq, arr);
> +               do_div(freq, psc + 1);
> +               do_div(freq, arr + 1);
>         }
>
>         return sprintf(buf, "%d\n", (unsigned int)freq);
> --
> 1.9.1
>
Acked-by: Benjamin Gaignard <benjamin.gaignard@st.com>
