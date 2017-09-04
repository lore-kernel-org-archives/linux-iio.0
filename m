Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36854 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753613AbdIDNqg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2017 09:46:36 -0400
Received: by mail-wr0-f169.google.com with SMTP id j3so1752704wrb.3
        for <linux-iio@vger.kernel.org>; Mon, 04 Sep 2017 06:46:36 -0700 (PDT)
Date: Mon, 4 Sep 2017 14:46:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: benjamin.gaignard@linaro.org, jic23@kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        vilhelm.gray@gmail.com
Subject: Re: [RESEND PATCH v3 2/9] mfd: Add STM32 LPTimer driver
Message-ID: <20170904134620.gdabswhptjbgweqk@dell>
References: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
 <1503914654-19963-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1503914654-19963-3-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 28 Aug 2017, Fabrice Gasnier wrote:

> STM32 Low-Power Timer hardware block can be used for:
> - PWM generation
> - IIO trigger (in sync with PWM)
> - IIO quadrature encoder counter
> PWM and IIO timer configuration are mixed in the same registers so
> we need a multi fonction driver to be able to share those registers.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Lee's remarks: various comments, max register define, s/Low Power/Low-Power,
>   clock name, removed reset, add kernel doc for stm32_lptimer struct
> ---
>  drivers/mfd/Kconfig               |  14 +++++
>  drivers/mfd/Makefile              |   1 +
>  drivers/mfd/stm32-lptimer.c       | 107 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stm32-lptimer.h |  62 ++++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/mfd/stm32-lptimer.c
>  create mode 100644 include/linux/mfd/stm32-lptimer.h

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
