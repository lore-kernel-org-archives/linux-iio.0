Return-Path: <SRS0=PhTt=7M=gmail.com=robherring2@kernel.org>
Date: Thu, 10 Aug 2017 12:12:17 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, lars@metafoo.de,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org,
	benjamin.gaignard@st.com
Subject: Re: [PATCH 1/3] dt-bindings: iio: timer: stm32: add support for
 STM32H7
Message-ID: <20170810171217.gxms3ect2gpbizba@rob-hp-laptop>
References: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
 <1501751654-14153-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501751654-14153-2-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Aug 03, 2017 at 11:14:12AM +0200, Fabrice Gasnier wrote:
> STM32H7 has slightly different triggers than previous versions.
> Introduce st,stm32h7-timer-trigger compatible to handle this new variant.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
