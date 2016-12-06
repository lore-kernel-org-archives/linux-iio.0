Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37753 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbcLFMyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 07:54:15 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so124435282wmt.0
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 04:54:14 -0800 (PST)
Date: Tue, 6 Dec 2016 12:57:25 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v4 7/7] ARM: dts: stm32: add STM32 General Purpose Timer
 driver in DT
Message-ID: <20161206125725.GG25385@dell.home>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-8-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1481027929-13704-8-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 06 Dec 2016, Benjamin Gaignard wrote:

> Add General Purpose Timers and it sub-nodes into DT for stm32f4.
> Define and enable pwm1 and pwm3 for stm32f469 discovery board
> 
> version 4:
> - remove unwanted indexing in pwm@ and timer@ node name
> - use "reg" instead of additional parameters to set timer
>   configuration
> 
> version 3:
> - use "st,stm32-timer-trigger" in DT
> 
> version 2:
> - use parameters to describe hardware capabilities
> - do not use references for pwm and iio timer subnodes
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi      | 276 +++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/stm32f469-disco.dts |  28 ++++
>  2 files changed, 303 insertions(+), 1 deletion(-)

This now looks really neat.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
