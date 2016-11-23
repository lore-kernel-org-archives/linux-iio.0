Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36499 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932992AbcKWISA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 03:18:00 -0500
Received: by mail-qk0-f169.google.com with SMTP id n21so6167420qka.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2016 00:17:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161122171820.GL10134@dell.home>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
 <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de> <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
 <20161122171820.GL10134@dell.home>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Wed, 23 Nov 2016 09:17:58 +0100
Message-ID: <CA+M3ks7MgnUJoDoNG157+MbdhgbqwzRmhPcD-uQKC7_DJVAK6A@mail.gmail.com>
Subject: Re: [PATCH 5/7] add bindings for stm32 IIO timer drivers
To: Lee Jones <lee.jones@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, robh+dt@kernel.org,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If it is ok for you I will add "id" parameter in mfd driver and
forward it to the sub-devices drivers
to be able to distinguish the hardware blocks


2016-11-22 18:18 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Tue, 22 Nov 2016, Benjamin Gaignard wrote:
>
>> [snip]
>> >> +     "st,stm32-iio-timer5"
>> >> +     "st,stm32-iio-timer6"
>> >> +     "st,stm32-iio-timer7"
>> >> +     "st,stm32-iio-timer8"
>> >> +     "st,stm32-iio-timer9"
>> >> +     "st,stm32-iio-timer10"
>> >> +     "st,stm32-iio-timer11"
>> >> +     "st,stm32-iio-timer12"
>> >> +     "st,stm32-iio-timer13"
>> >> +     "st,stm32-iio-timer14"
>> >
>> > We can't do this. This is a binding for a driver, not for the hardware=
.
>> >
>>
>> Unfortunately each instance for the hardware IP have little
>> differences like which triggers they could accept or size of the
>> counter register,
>> and I doesn't have value inside the hardware to distinguish them so
>> the only way I found is to use compatible.
>
> Can't you represent these as properties?
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
