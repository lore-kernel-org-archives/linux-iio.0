Return-Path: <SRS0=/l9A=72=free-electrons.com=alexandre.belloni@kernel.org>
Date: Thu, 24 Aug 2017 13:54:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
	nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
	linux-iio@vger.kernel.org, jic23@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 1/3] Documentation: dt: iio: at91-sama5d2_adc: add
 optional dma property
Message-ID: <20170824115406.wououixl3zrj2dni@piout.net>
References: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
 <1502368499-6739-2-git-send-email-eugen.hristev@microchip.com>
 <20170817151059.ptnzqsrzray26zlr@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817151059.ptnzqsrzray26zlr@rob-hp-laptop>
List-ID: <linux-iio@vger.kernel.org>

On 17/08/2017 at 10:10:59 -0500, Rob Herring wrote:
> On Thu, Aug 10, 2017 at 03:34:57PM +0300, Eugen Hristev wrote:
> > Added property for DMA configuration of the device.
> 
> "dt-bindings: iio: ..." is preferred for subject.
> 
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > index 552e7a8..5f94d47 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > @@ -17,6 +17,11 @@ Required properties:
> >    This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
> >    IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
> >  
> > +Optional properties:
> > +  - dmas: Phandle to dma channel for the ADC.
> > +  See ../../dma/dma.txt for details.
> > +  - dma-names: Must be "rx" when dmas property is being used.
> 
> *-names is pointless when there's only one.
> 

Hypothetical question: what if at some point we have multiple dmas? Then
we would have the choice between breaking the backward compatibility or
handling the absence of dma-names in the driver which is less than
ideal.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
