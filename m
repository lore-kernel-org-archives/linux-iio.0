Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33092 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755773AbcK1Vor (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2016 16:44:47 -0500
Date: Mon, 28 Nov 2016 15:44:44 -0600
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 5/7] add bindings for stm32 IIO timer drivers
Message-ID: <20161128214444.wyek4zjyy2sbynzh@rob-hp-laptop>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
 <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
 <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
 <20161122171820.GL10134@dell.home>
 <CA+M3ks7MgnUJoDoNG157+MbdhgbqwzRmhPcD-uQKC7_DJVAK6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+M3ks7MgnUJoDoNG157+MbdhgbqwzRmhPcD-uQKC7_DJVAK6A@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 23, 2016 at 09:17:58AM +0100, Benjamin Gaignard wrote:
> If it is ok for you I will add "id" parameter in mfd driver and
> forward it to the sub-devices drivers
> to be able to distinguish the hardware blocks

Please don't top post.

No, it's not okay. If the counter sizes are different, then have a 
property for the counter size. Describe how they are different without 
numbering them. If you can't describe the differences, then it shouldn't 
matter which ones the OS picks to use.

> 2016-11-22 18:18 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> > On Tue, 22 Nov 2016, Benjamin Gaignard wrote:
> >
> >> [snip]
> >> >> +     "st,stm32-iio-timer5"
> >> >> +     "st,stm32-iio-timer6"
> >> >> +     "st,stm32-iio-timer7"
> >> >> +     "st,stm32-iio-timer8"
> >> >> +     "st,stm32-iio-timer9"
> >> >> +     "st,stm32-iio-timer10"
> >> >> +     "st,stm32-iio-timer11"
> >> >> +     "st,stm32-iio-timer12"
> >> >> +     "st,stm32-iio-timer13"
> >> >> +     "st,stm32-iio-timer14"

I doubt the h/w manual calls these "IIO timers".

> >> >
> >> > We can't do this. This is a binding for a driver, not for the hardware.
> >> >
> >>
> >> Unfortunately each instance for the hardware IP have little
> >> differences like which triggers they could accept or size of the
> >> counter register,
> >> and I doesn't have value inside the hardware to distinguish them so
> >> the only way I found is to use compatible.
> >
> > Can't you represent these as properties?
> >
> > --
> > Lee Jones
> > Linaro STMicroelectronics Landing Team Lead
> > Linaro.org │ Open source software for ARM SoCs
> > Follow Linaro: Facebook | Twitter | Blog
> 
> 
> 
> -- 
> Benjamin Gaignard
> 
> Graphic Study Group
> 
> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro: Facebook | Twitter | Blog
