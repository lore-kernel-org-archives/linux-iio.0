Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34169 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdARMh0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 07:37:26 -0500
Received: by mail-qk0-f178.google.com with SMTP id a20so11585452qkc.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2017 04:37:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118113759.GA16826@ulmo.ba.sec>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
 <20170118100817.GF18989@ulmo.ba.sec> <CA+M3ks64VEE8a0oeiA8J-T5FDzwWTo=pdaMACy+pz7EyOQY-Jg@mail.gmail.com>
 <20170118113759.GA16826@ulmo.ba.sec>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Wed, 18 Jan 2017 13:37:24 +0100
Message-ID: <CA+M3ks4b7SVVz-SH633BEP8b4Ap+5rsG8zND51iq4EPLSY74hQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-01-18 12:37 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> On Wed, Jan 18, 2017 at 12:15:58PM +0100, Benjamin Gaignard wrote:
>> 2017-01-18 11:08 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
>> > On Thu, Jan 05, 2017 at 10:25:40AM +0100, Benjamin Gaignard wrote:
> [...]
>> >> +static u32 active_channels(struct stm32_pwm *dev)
>> >> +{
>> >> +     u32 ccer;
>> >> +
>> >> +     regmap_read(dev->regmap, TIM_CCER, &ccer);
>> >> +
>> >> +     return ccer & TIM_CCER_CCXE;
>> >> +}
>> >
>> > This looks like something that you could track in software, but this i=
s
>> > probably fine, too. Again, technically regmap_read() could fail, so yo=
u
>> > might want to consider adding some code to handle it. In practice it
>> > probably won't, so maybe you don't.
>>
>> TIM_CCER_CCXE is a value that IIO timer can also read (not write) so
>> I have keep the same logic for pwm driver.
>
> Would that not be racy? What happens if after active_channels() here,
> the IIO timer modifies the TIM_CCER register?

IIO timer only read this register not write it so no racy condition here

>
>> >> +     ret =3D stm32_pwm_config(chip, pwm, state->duty_cycle, state->p=
eriod);
>> >> +     if (ret)
>> >> +             return ret;
>> >> +
>> >> +     if (!enabled && state->enabled)
>> >> +             ret =3D stm32_pwm_enable(chip, pwm);
>> >> +
>> >> +     return ret;
>> >> +}
>> >
>> > Would it be possible to merge stm32_pwm_disable(), stm32_pwm_enable(),
>> > stm32_pwm_set_polarity() and stm32_pwm_config() into stm32_pwm_apply()=
?
>> > Part of the reason for the atomic API was to make it easier to write
>> > these drivers, but your implementation effectively copies what the
>> > transitional helpers do.
>> >
>> > It might not make a difference technically in your case, but I think
>> > it'd make the implementation more compact and set a better example for
>> > future reference.
>>
>> hmm... it will create a fat function with lot of where
>> enabling/disabling/configuration
>> will be mixed I'm really not convince that will more compact and readabl=
e.
>
> I don't object to splitting this up into separate functions, I just
> don't think the functions should correspond to the legacy ones. One
> variant that I think could work out nicely would be to have one
> function that precomputes the various values, call in from ->apply()
> and then do only the register writes along with a couple of
> conditionals depending on enable state, for example.

Ok I will change functions prototype so they will not be like legacy ones
but I will keep the current split.

>
>> >> +static const struct pwm_ops stm32pwm_ops =3D {
>> >> +     .owner =3D THIS_MODULE,
>> >> +     .apply =3D stm32_pwm_apply,
>> >> +};
>> >> +
>> >> +static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
>> >> +                                 int level, int filter)
>> >> +{
>> >> +     u32 bdtr =3D TIM_BDTR_BKE;
>> >> +
>> >> +     if (level)
>> >> +             bdtr |=3D TIM_BDTR_BKP;
>> >> +
>> >> +     bdtr |=3D (filter & TIM_BDTR_BKF_MASK) << TIM_BDTR_BKF_SHIFT;
>> >> +
>> >> +     regmap_update_bits(priv->regmap,
>> >> +                        TIM_BDTR, TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_=
BDTR_BKF,
>> >> +                        bdtr);
>> >> +
>> >> +     regmap_read(priv->regmap, TIM_BDTR, &bdtr);
>> >> +
>> >> +     return (bdtr & TIM_BDTR_BKE) ? 0 : -EINVAL;
>> >> +}
>> >> +
>> >> +static int stm32_pwm_set_breakinput2(struct stm32_pwm *priv,
>> >> +                                  int level, int filter)
>> >> +{
>> >> +     u32 bdtr =3D TIM_BDTR_BK2E;
>> >> +
>> >> +     if (level)
>> >> +             bdtr |=3D TIM_BDTR_BK2P;
>> >> +
>> >> +     bdtr |=3D (filter & TIM_BDTR_BKF_MASK) << TIM_BDTR_BK2F_SHIFT;
>> >> +
>> >> +     regmap_update_bits(priv->regmap,
>> >> +                        TIM_BDTR, TIM_BDTR_BK2E |
>> >> +                        TIM_BDTR_BK2P |
>> >> +                        TIM_BDTR_BK2F,
>> >> +                        bdtr);
>> >> +
>> >> +     regmap_read(priv->regmap, TIM_BDTR, &bdtr);
>> >> +
>> >> +     return (bdtr & TIM_BDTR_BK2E) ? 0 : -EINVAL;
>> >> +}
>> >
>> > As far as I can tell the only difference here is the various bit
>> > positions. Can you collapse the above two functions and add a new
>> > parameter to unify some code?
>>
>> Yes it is all about bit shifting, I had try unify those two functions
>> with index has additional parameter
>> but it just add if() before each lines so no real benefit for code size.
>
> How about if you precompute the values and masks? Something like:
>
>         u32 bke =3D (index =3D=3D 0) ? ... : ...;
>         u32 bkp =3D (index =3D=3D 0) ? ... : ...;
>         u32 bkf =3D (index =3D=3D 0) ? ... : ...;
>         u32 mask =3D (index =3D=3D 0) ? ... : ...;
>
>         bdtr =3D bke | bkf;
>
>         if (level)
>                 bdtr |=3D bkp;
>
>         regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
>
>         regmap_read(priv->regmap, TIM_BDTR, &bdtr);
>
>         return (bdtr & bke) ? 0 : -EINVAL;
>
> ?

ok done


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
