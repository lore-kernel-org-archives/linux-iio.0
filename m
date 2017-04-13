Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33464 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756048AbdDMUWR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2017 16:22:17 -0400
Date: Thu, 13 Apr 2017 15:22:15 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: stm32-dac: Add support for
 STM32 DAC
Message-ID: <20170413202215.4ka4ca57kx2ttbzl@rob-hp-laptop>
References: <1491839390-2449-1-git-send-email-fabrice.gasnier@st.com>
 <1491839390-2449-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491839390-2449-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 10, 2017 at 05:49:49PM +0200, Fabrice Gasnier wrote:
> Document STMicroelectronics STM32 DAC (digital-to-analog converter).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - use 'reg' instead of 'st,dac-channel' property
> - remove alignment from description
> ---
>  .../devicetree/bindings/iio/dac/st,stm32-dac.txt   | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt

Acked-by: Rob Herring <robh@kernel.org>
