Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35826 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdGNOlm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jul 2017 10:41:42 -0400
Date: Fri, 14 Jul 2017 09:41:39 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: stm32-dac: add support for STM32F4
Message-ID: <20170714144139.n7qqqmtvjyfysrwj@rob-hp-laptop>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
 <1499693040-12994-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499693040-12994-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 10, 2017 at 03:23:57PM +0200, Fabrice Gasnier wrote:
> Introduce new compatible to support STM32F4 DAC (Digital-To-Analog
> converter) variant.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
