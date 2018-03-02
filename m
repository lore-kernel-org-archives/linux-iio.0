Return-Path: <SRS0=mObs=FY=gmail.com=robherring2@kernel.org>
Date: Fri, 2 Mar 2018 10:25:13 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, lars@metafoo.de,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org,
	arnaud.pouliquen@st.com
Subject: Re: [PATCH] dt-bindings: iio: adc: stm32-dfsdm: fix types, add
 missing pinctrl
Message-ID: <20180302162513.umh2a2g4io3x26uz@rob-hp-laptop>
References: <1519384260-23875-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519384260-23875-1-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Feb 23, 2018 at 12:11:00PM +0100, Fabrice Gasnier wrote:
> - Add missing pinctrl description. Support is made optional as dfsdm
>   may use internal sources (e.g. via registers)
> - Fix typo in IIO STM32 DFSDM filter "MANCH_F" description.
> Basically, this should be "falling edge = logic 0", not "1" that applies
> to "MANCH_R".
> BTW, make the description complete by describing both rising/falling
> edges as described in reference manuals.
> 
> Fixes: 6c82f947fc97 ("IIO: add DT bindings for stm32 DFSDM filter")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
