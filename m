Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:34699 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755346AbcKVQx0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2016 11:53:26 -0500
Subject: Re: [PATCH 5/7] add bindings for stm32 IIO timer drivers
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
Date: Tue, 22 Nov 2016 17:53:18 +0100
MIME-Version: 1.0
In-Reply-To: <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/22/2016 05:13 PM, Benjamin Gaignard wrote:
> Define bindings for stm32 IIO timer
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/iio/timer/stm32-iio-timer.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> new file mode 100644
> index 0000000..b80025e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> @@ -0,0 +1,33 @@
> +timer IIO trigger bindings for STM32
> +
> +Must be a child of STM32 multifunctions timer driver
> +
> +Required parameters:
> +- compatible: must be one of the follow value:
> +	"st,stm32-iio-timer1"
> +	"st,stm32-iio-timer2"
> +	"st,stm32-iio-timer3"
> +	"st,stm32-iio-timer4"
> +	"st,stm32-iio-timer5"
> +	"st,stm32-iio-timer6"
> +	"st,stm32-iio-timer7"
> +	"st,stm32-iio-timer8"
> +	"st,stm32-iio-timer9"
> +	"st,stm32-iio-timer10"
> +	"st,stm32-iio-timer11"
> +	"st,stm32-iio-timer12"
> +	"st,stm32-iio-timer13"
> +	"st,stm32-iio-timer14"

We can't do this. This is a binding for a driver, not for the hardware.

