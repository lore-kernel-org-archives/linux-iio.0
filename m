Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f169.google.com ([209.85.210.169]:33310 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbcLGKq4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2016 05:46:56 -0500
Received: by mail-wj0-f169.google.com with SMTP id xy5so356752685wjc.0
        for <linux-iio@vger.kernel.org>; Wed, 07 Dec 2016 02:46:55 -0800 (PST)
Date: Wed, 7 Dec 2016 10:50:02 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v4 6/7] IIO: add STM32 timer trigger driver
Message-ID: <20161207105002.GA3625@dell.home>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-7-git-send-email-benjamin.gaignard@st.com>
 <20161206131635.GJ25385@dell.home>
 <CA+M3ks6fxCucmaY0OgpMb_opA=YLrowijJ0YQ+imeprhWg6N_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+M3ks6fxCucmaY0OgpMb_opA=YLrowijJ0YQ+imeprhWg6N_w@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 06 Dec 2016, Benjamin Gaignard wrote:

> [snip]
> >> +
> >> +static const char * const triggers0[] = {
> >> +     TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,
> >> +};
> >> +
> >> +static const char * const triggers1[] = {
> >> +     TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,
> >> +};
> >> +
> >> +static const char * const triggers2[] = {
> >> +     TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,
> >> +};
> >> +
> >> +static const char * const triggers3[] = {
> >> +     TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,
> >> +};
> >> +
> >> +static const char * const triggers4[] = {
> >> +     TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,
> >> +};
> >> +
> >> +static const char * const triggers5[] = {
> >> +     TIM6_TRGO, NULL,
> >> +};
> >> +
> >> +static const char * const triggers6[] = {
> >> +     TIM7_TRGO, NULL,
> >> +};
> >> +
> >> +static const char * const triggers7[] = {
> >> +     TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,
> >> +};
> >> +
> >> +static const char * const triggers8[] = {
> >> +     TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,
> >> +};
> >> +
> >> +static const char * const triggers9[] = {
> >> +     TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,
> >> +};
> >> +
> >> +static const void *triggers_table[] = {
> >> +     triggers0,
> >> +     triggers1,
> >> +     triggers2,
> >> +     triggers3,
> >> +     triggers4,
> >> +     triggers5,
> >> +     triggers6,
> >> +     triggers7,
> >> +     triggers8,
> >> +     triggers9,
> >> +};
> >
> > What about:
> >
> > static const char * const triggers[][] = {
> >         { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL },
> >         { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL },
> >         { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL },
> >         { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL },
> >         { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL },
> >         { TIM6_TRGO, NULL },
> >         { TIM7_TRGO, NULL },
> >         { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL },
> >         { TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL },
> >         { TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL }
> > };
> 
> I can't because the second dimension of the array isn't fix.
> I could have between 2 and 6 elements per row... to create a dual dimension
> array I would have to add NULL entries like that:
> 
> #define MAX_TRIGGERS 6
> 
> static const void *triggers_table[][MAX_TRIGGERS] = {
> { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,},
> { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,},
> { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,},
> { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,},
> { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,},
> { TIM6_TRGO, NULL,     NULL,     NULL,     NULL,     NULL,},
> { TIM7_TRGO, NULL,     NULL,     NULL,     NULL,     NULL,},
> { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,},
> { TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,     NULL,     NULL,},
> { TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,  NULL,     NULL,},
> };

It was just an idea, not a tested implementation.

I don't understand why you have to pad with NULLs, but either way, it
looks much better than before and saves lots of lines of code.

> >> +static const char * const valids0[] = {
> >> +     TIM5_TRGO, TIM2_TRGO, TIM4_TRGO, TIM3_TRGO, NULL,
> >> +};
> >> +
> >> +static const char * const valids1[] = {
> >> +     TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO, NULL,
> >> +};
> >> +
> >> +static const char * const valids2[] = {
> >> +     TIM1_TRGO, TIM8_TRGO, TIM5_TRGO, TIM4_TRGO, NULL,
> >> +};
> >> +
> >> +static const char * const valids3[] = {
> >> +     TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO, NULL,
> >> +};
> >> +
> >> +static const char *const valids4[] = {
> >> +     TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO, NULL,
> >> +};
> >> +
> >> +static const char * const valids7[] = {
> >> +     TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO, NULL,
> >> +};
> >> +
> >> +static const char * const valids8[] = {
> >> +     TIM2_TRGO, TIM3_TRGO, NULL,
> >> +};
> >> +
> >> +static const char * const valids9[] = {
> >> +     TIM4_TRGO, TIM5_TRGO, NULL,
> >> +};
> >> +
> >> +static const void *valids_table[] = {
> >> +     valids0,
> >> +     valids1,
> >> +     valids2,
> >> +     valids3,
> >> +     valids4,
> >> +     NULL,
> >> +     NULL,
> >> +     valids7,
> >> +     valids8,
> >> +     valids9,
> >> +};
> >
> > Same here.
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
