Return-Path: <SRS0=Qva0=53=gmail.com=robherring2@kernel.org>
Date: Thu, 22 Jun 2017 16:25:39 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org,
	thierry.reding@gmail.com, mark.rutland@arm.com,
	alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
	benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: update STM32 timers clock names
Message-ID: <20170622212539.l3yblwqurahdvlqq@rob-hp-laptop>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
 <1497453196-31470-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497453196-31470-3-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 14, 2017 at 05:13:15PM +0200, Fabrice Gasnier wrote:
> Clock name has been updated during driver/DT binding review:
> https://lkml.org/lkml/2016/12/13/718
> Update DT binding doc to reflect this.
> 
> Fixes: bf2d8581b1b3 (iio: Add bindings for STM32 timer trigger driver)
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
