Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752457AbdHIXae (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 19:30:34 -0400
Date: Thu, 10 Aug 2017 00:29:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: timer: stm32: add support for
 STM32H7
Message-ID: <20170810002910.6b8c4a15@archlinux>
In-Reply-To: <1501751654-14153-2-git-send-email-fabrice.gasnier@st.com>
References: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
        <1501751654-14153-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 11:14:12 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> STM32H7 has slightly different triggers than previous versions.
> Introduce st,stm32h7-timer-trigger compatible to handle this new variant.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing.
Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> index 55a653d..b565ced 100644
> --- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> @@ -4,7 +4,9 @@ Must be a sub-node of an STM32 Timers device tree node.
>  See ../mfd/stm32-timers.txt for details about the parent node.
>  
>  Required parameters:
> -- compatible:	Must be "st,stm32-timer-trigger".
> +- compatible:	Must be one of:
> +		"st,stm32-timer-trigger"
> +		"st,stm32h7-timer-trigger"
>  - reg:		Identify trigger hardware block.
>  
>  Example:

