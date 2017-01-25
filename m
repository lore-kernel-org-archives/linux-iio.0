Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58250 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdAYSXo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jan 2017 13:23:44 -0500
Date: Wed, 25 Jan 2017 18:23:33 +0000
In-Reply-To: <20170125100858.GA16202@dell>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com> <20170123121222.GJ16020@dell> <CAOesGMhx6ZWekgW01-7GRcMiWtAohcfGdcu1FhkP=bTfsjBCmQ@mail.gmail.com> <20170124081244.GP16020@dell> <CAOesGMhauUd0mPuUsRZnEWrAfQZj3Di_YwvxtD1rXr7B9fgqdw@mail.gmail.com> <20170125100858.GA16202@dell>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [GIT PULL] Immutable branch between MFD, ARM, IIO and PWM due for the v4.10 merge window
To: Lee Jones <lee.jones@linaro.org>, Olof Johansson <olof@lixom.net>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <DC96044D-44CE-4D3E-92B2-1C1C73E45FFA@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 25 January 2017 10:08:58 GMT+00:00, Lee Jones <lee.jones@linaro.org> wrote:
>Jonathan, Thierry,
>
>On Tue, 24 Jan 2017, Olof Johansson wrote:
>> On Tue, Jan 24, 2017 at 12:12 AM, Lee Jones <lee.jones@linaro.org>
>wrote:
>> > On Mon, 23 Jan 2017, Olof Johansson wrote:
>> >> On Mon, Jan 23, 2017 at 4:12 AM, Lee Jones <lee.jones@linaro.org>
>wrote:
>> >> > Arm, IIO and PWM Maintainers,
>> >> >
>> >> > Enjoy!
>> >> >
>> >> > The following changes since commit
>7ce7d89f48834cefece7804d38fc5d85382edf77:
>> >> >
>> >> >   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
>> >> >
>> >> > are available in the git repository at:
>> >> >
>> >> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
>ib-mfd-arm-iio-pwm-v4.10
>> >> >
>> >> > for you to fetch changes up to
>94df449273475980a39f1bf47f1e3d2b07ce6577:
>> >> >
>> >> >   ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco
>(2017-01-23 12:06:28 +0000)
>> >> >
>> >> > ----------------------------------------------------------------
>> >> > Immutable branch between MFD, ARM, IIO and PWM due for the v4.10
>merge window
>> >> >
>> >> > ----------------------------------------------------------------
>> >> > Benjamin Gaignard (8):
>> >> >       dt-bindings: mfd: Add bindings for STM32 Timers driver
>> >> >       mfd: Add STM32 Timers driver
>> >> >       dt-bindings: pwm: Add STM32 bindings
>> >> >       pwm: Add driver for STM32 plaftorm
>> >> >       iio: Add bindings for STM32 timer trigger driver
>> >> >       iio: Add STM32 timer trigger driver
>> >> >       ARM: dts: stm32: add Timers driver for stm32f429 MCU
>> >> >       ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco
>> >> >
>> >> >  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  29 ++
>> >> >  .../bindings/iio/timer/stm32-timer-trigger.txt     |  23 ++
>> >> >  .../devicetree/bindings/mfd/stm32-timers.txt       |  46 +++
>> >> >  .../devicetree/bindings/pwm/pwm-stm32.txt          |  35 ++
>> >> >  arch/arm/boot/dts/stm32f429.dtsi                   | 275
>++++++++++++++
>> >> >  arch/arm/boot/dts/stm32f469-disco.dts              |  28 ++
>> >> >  drivers/iio/trigger/Kconfig                        |   9 +
>> >> >  drivers/iio/trigger/Makefile                       |   1 +
>> >> >  drivers/iio/trigger/stm32-timer-trigger.c          | 342
>++++++++++++++++++
>> >> >  drivers/mfd/Kconfig                                |  11 +
>> >> >  drivers/mfd/Makefile                               |   2 +
>> >> >  drivers/mfd/stm32-timers.c                         |  80 +++++
>> >> >  drivers/pwm/Kconfig                                |   9 +
>> >> >  drivers/pwm/Makefile                               |   1 +
>> >> >  drivers/pwm/pwm-stm32.c                            | 398
>+++++++++++++++++++++
>> >> >  include/linux/iio/timer/stm32-timer-trigger.h      |  62 ++++
>> >> >  include/linux/mfd/stm32-timers.h                   |  71 ++++
>> >> >  17 files changed, 1422 insertions(+)
>> >> >  create mode 100644
>Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>> >> >  create mode 100644
>Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>> >> >  create mode 100644
>Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> >> >  create mode 100644
>Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>> >> >  create mode 100644 drivers/iio/trigger/stm32-timer-trigger.c
>> >> >  create mode 100644 drivers/mfd/stm32-timers.c
>> >> >  create mode 100644 drivers/pwm/pwm-stm32.c
>> >> >  create mode 100644
>include/linux/iio/timer/stm32-timer-trigger.h
>> >> >  create mode 100644 include/linux/mfd/stm32-timers.h
>> >>
>> >> May I ask why you're creating an immutable branch of all this
>contents?
>> >>
>> >> We should get the dts/dtsi contents like usual from any
>maintainer;
>> >> just the DT updates in a branch.
>> >>
>> >> Sometimes (but less and less due to us discouraging the use) we
>need
>> >> an immutable branch that includes dt-include updates. But I don't
>see
>> >> any of those in this contents.
>> >>
>> >> I.e. I guess I can see the need between mfd and downstream trees
>> >> (iio/pwm), but not the DTS contents at this time. Or am I missing
>> >> something here?
>> >
>> > I agree with you.  However, since one of the STM32 Maintainers
>Acked
>> > the DTS patches, and the other one hasn't been heard from for
>months,
>> > I took that to mean he wanted me to apply and take them through the
>> > MFD tree.
>> >
>> > A misunderstanding or misaction perhaps, but this is the normal
>> > assumption.
>> 
>> It seems to be a misunderstanding in this case, since there are other
>> additions in the stm32 tree this release cycle so we should only pick
>> up DTS changes through our tree.
>> 
>> By now, I think it should be pretty well known that we nearly never
>> want DTS contents merged through any other tree. Ever.
>> 
>> So, please revoke your branch and take those out. We'll take them
>> through the normal flow. Thanks!
>
>That okay with you?
Bit late from me but fine. I tend to only pull in these branches when stuff to go on top turns up.
Not happened with this set yet!


J

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
