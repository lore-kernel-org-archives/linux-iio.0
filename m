Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754843AbdGJUvL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Jul 2017 16:51:11 -0400
Date: Mon, 10 Jul 2017 21:51:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: iio: stm32-dac: add support for
 STM32F4
Message-ID: <20170710215105.126409dc@kernel.org>
In-Reply-To: <1499693040-12994-2-git-send-email-fabrice.gasnier@st.com>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
        <1499693040-12994-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 10 Jul 2017 15:23:57 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Introduce new compatible to support STM32F4 DAC (Digital-To-Analog
> converter) variant.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore it.

Simple addition of a supported part so, whilst welcome review
from Rob / Mark isn't really necessary I think.

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
> index bcee71f..bf2925c 100644
> --- a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
> @@ -10,7 +10,9 @@ current.
>  Contents of a stm32 dac root node:
>  -----------------------------------
>  Required properties:
> -- compatible: Must be "st,stm32h7-dac-core".
> +- compatible: Should be one of:
> +  "st,stm32f4-dac-core"
> +  "st,stm32h7-dac-core"
>  - reg: Offset and length of the device's register set.
>  - clocks: Must contain an entry for pclk (which feeds the peripheral bus
>    interface)

