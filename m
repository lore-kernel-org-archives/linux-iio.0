Return-Path: <SRS0=Nv/z=H2=gmail.com=robherring2@kernel.org>
Date: Mon, 7 May 2018 11:28:31 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, alexandre.torgue@st.com, mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com, lars@metafoo.de, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: stm32-adc: add support for
 STM32MP1
Message-ID: <20180507162830.GA11497@rob-hp-laptop>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
 <1525247091-18143-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525247091-18143-2-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 02, 2018 at 09:44:49AM +0200, Fabrice Gasnier wrote:
> Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
> Introduce "st,stm32mp1-adc" compatible to handle variants of this
> hardware such as vregready flag, interrupts, clock rate.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Update dt-bindings following Rob's remark: STM32MP1 ADC has two
>   interrupt lines
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
