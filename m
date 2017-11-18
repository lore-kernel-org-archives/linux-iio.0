Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030230AbdKRQHS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Nov 2017 11:07:18 -0500
Date: Sat, 18 Nov 2017 16:07:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com,
        linux-iio@vger.kernel.org, lars@metafoo.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: at91-sama5d2_adc: add optional
 dma property
Message-ID: <20171118160712.36414451@archlinux>
In-Reply-To: <20171115152746.w4giwt7kdqm4i3yl@rob-hp-laptop>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
        <1510750608-8697-2-git-send-email-eugen.hristev@microchip.com>
        <20171115152746.w4giwt7kdqm4i3yl@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 15 Nov 2017 09:27:46 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Nov 15, 2017 at 02:56:45PM +0200, Eugen Hristev wrote:
> > Added property for DMA configuration of the device.
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > ---
> >  Changes in v3:
> > None, but we discussed on the ML about whether we should have "dma-names"
> > present in the binding even if it's only one.
> > The helpers in the kernel to retrieve the channel info rely on the
> > presence of this property, so I am resending the patch based on this.
> > If another solution is better, please advise and I can try it and
> > resend the patch.  
> 
> Really the kernel APIs should accept a NULL name and return the DMA 
> channel when there is only one. This is how the clk_get API works for 
> example.
> 
> >  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)  
> 
> In any case, not really a big deal.
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

