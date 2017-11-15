Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:54530 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932411AbdKOP1s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Nov 2017 10:27:48 -0500
Date: Wed, 15 Nov 2017 09:27:46 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com,
        linux-iio@vger.kernel.org, lars@metafoo.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
        jic23@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: at91-sama5d2_adc: add optional
 dma property
Message-ID: <20171115152746.w4giwt7kdqm4i3yl@rob-hp-laptop>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
 <1510750608-8697-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510750608-8697-2-git-send-email-eugen.hristev@microchip.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 15, 2017 at 02:56:45PM +0200, Eugen Hristev wrote:
> Added property for DMA configuration of the device.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Changes in v3:
> None, but we discussed on the ML about whether we should have "dma-names"
> present in the binding even if it's only one.
> The helpers in the kernel to retrieve the channel info rely on the
> presence of this property, so I am resending the patch based on this.
> If another solution is better, please advise and I can try it and
> resend the patch.

Really the kernel APIs should accept a NULL name and return the DMA 
channel when there is only one. This is how the clk_get API works for 
example.

>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

In any case, not really a big deal.

Acked-by: Rob Herring <robh@kernel.org>
