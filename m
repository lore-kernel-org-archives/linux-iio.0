Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33779 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbdASTb0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 14:31:26 -0500
Date: Thu, 19 Jan 2017 13:31:19 -0600
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: lee.jones@linaro.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v8 5/8] IIO: add bindings for STM32 timer trigger driver
Message-ID: <20170119193119.kejcwpqrqo735mxh@rob-hp-laptop>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
 <1484749251-14445-6-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484749251-14445-6-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 18, 2017 at 03:20:48PM +0100, Benjamin Gaignard wrote:
> Define bindings for STM32 timer trigger
> 
> version 8:
> - reword "reg" parameter description
> 
> version 4:
> - remove triggers enumeration from DT
> - add reg parameter
> 
> version 3:
> - change file name
> - add cross reference with mfd bindings
> 
> version 2:
> - only keep one compatible
> - add DT parameters to set lists of the triggers:
>   one list describe the triggers created by the device
>   another one give the triggers accepted by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt

Acked-by: Rob Herring <robh@kernel.org>
