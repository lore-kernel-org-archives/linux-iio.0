Return-Path: <SRS0=zXS0=5M=gmail.com=robherring2@kernel.org>
Date: Wed, 7 Jun 2017 15:09:40 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
	pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
	benjamin.gaignard@st.com
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: stm32-adc: add support for
 STM32H7
Message-ID: <20170607200940.j6i2mtyc3nu4hwkj@rob-hp-laptop>
References: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
 <1496050100-25854-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496050100-25854-2-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, May 29, 2017 at 11:28:16AM +0200, Fabrice Gasnier wrote:
> Document support for STM32H7 Analog to Digital Converter.
> Main difference is regarding compatible, clock definitions and new
> features like differential channels support:
> STM32H7 ADC block has two clock inputs, common clock for all ADCs.
> One 'bus' clock for registers access, and one optional 'adc' clock
> for analog circuitry (bus clock may be used for conversions).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - remarks from Rob: one compatible per line, s/unused/not present/
> - document resolutions available on stm32h7
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 28 ++++++++++++++++------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
