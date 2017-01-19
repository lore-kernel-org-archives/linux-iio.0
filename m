Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33226 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754514AbdASTfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 14:35:46 -0500
Date: Thu, 19 Jan 2017 13:35:25 -0600
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v8 0/8] Add PWM and IIO timer drivers for STM32
Message-ID: <20170119193525.jufn5vh4huap7umm@rob-hp-laptop>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
 <20170119084355.GF3718@dell>
 <CA+M3ks7UchJ3QdQrHO6rSsc4YNhNEmLejoeRBVNhn=2biSn=cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+M3ks7UchJ3QdQrHO6rSsc4YNhNEmLejoeRBVNhn=2biSn=cQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 19, 2017 at 05:02:11PM +0100, Benjamin Gaignard wrote:
> 2017-01-19 9:43 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> > On Wed, 18 Jan 2017, Benjamin Gaignard wrote:
> >

> >> Benjamin Gaignard (8):
> >>   MFD: add bindings for STM32 Timers driver
> >>   MFD: add STM32 Timers driver
> >>   PWM: add pwm-stm32 DT bindings
> >>   PWM: add PWM driver for STM32 plaftorm
> >>   IIO: add bindings for STM32 timer trigger driver
> >>   IIO: add STM32 timer trigger driver
> >>   ARM: dts: stm32: add Timers driver for stm32f429 MCU
> >>   ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco
> >>
> >>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  29 ++
> >>  .../bindings/iio/timer/stm32-timer-trigger.txt     |  23 ++
> >>  .../devicetree/bindings/mfd/stm32-timers.txt       |  46 +++
> >>  .../devicetree/bindings/pwm/pwm-stm32.txt          |  35 ++
> >>  arch/arm/boot/dts/stm32f429.dtsi                   | 275 ++++++++++++++
> >>  arch/arm/boot/dts/stm32f469-disco.dts              |  28 ++
> >>  drivers/iio/trigger/Kconfig                        |   9 +
> >>  drivers/iio/trigger/Makefile                       |   1 +
> >>  drivers/iio/trigger/stm32-timer-trigger.c          | 342 ++++++++++++++++++
> >>  drivers/mfd/Kconfig                                |  11 +
> >>  drivers/mfd/Makefile                               |   2 +
> >>  drivers/mfd/stm32-timers.c                         |  80 +++++
> >>  drivers/pwm/Kconfig                                |   9 +
> >>  drivers/pwm/Makefile                               |   1 +
> >>  drivers/pwm/pwm-stm32.c                            | 398 +++++++++++++++++++++
> >>  include/linux/iio/timer/stm32-timer-trigger.h      |  62 ++++
> >>  include/linux/mfd/stm32-timers.h                   |  71 ++++
> >>  17 files changed, 1422 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> >>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
> >>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >>  create mode 100644 drivers/iio/trigger/stm32-timer-trigger.c
> >>  create mode 100644 drivers/mfd/stm32-timers.c
> >>  create mode 100644 drivers/pwm/pwm-stm32.c
> >>  create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
> >>  create mode 100644 include/linux/mfd/stm32-timers.h
> >
> > Let me know when you have all your Acks.
> >
> > I would be happy to take this through the MFD tree.
> 
> Some Acks are still missing on DT patches, I hope that Rob could find
> to review them
> after that it will ok :-)

I've acked all the bindings. stm32 maintainer needs to ack the dts 
files.

Rob
