Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34704 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdAUUym (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 15:54:42 -0500
Date: Sat, 21 Jan 2017 14:54:40 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com
Subject: Re: [PATCH 4/7] Documentation: dt: iio: stm32-adc: optional dma
 support
Message-ID: <20170121205440.s32egtpu5tmlbkdi@rob-hp-laptop>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
 <1484832854-6314-5-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484832854-6314-5-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 19, 2017 at 02:34:11PM +0100, Fabrice Gasnier wrote:
> STM32 ADC can use dma. Add dt documentation for optional dma support.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
