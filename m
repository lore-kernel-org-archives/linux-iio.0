Return-Path: <SRS0=jTSI=BS=free-electrons.com=alexandre.belloni@kernel.org>
Date: Thu, 19 Oct 2017 13:14:17 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
	nicolas.ferre@microchip.com, linux-iio@vger.kernel.org,
	lars@metafoo.de, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ludovic.desroches@microchip.com, jic23@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: at91-sama5d2_adc: add optional
 dma property
Message-ID: <20171019111417.7rzdnkvtukzzhl2u@piout.net>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
 <1507703732-29175-2-git-send-email-eugen.hristev@microchip.com>
 <20171013215142.vlfhzzzetmc7resq@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013215142.vlfhzzzetmc7resq@rob-hp-laptop>
List-ID: <linux-iio@vger.kernel.org>

On 13/10/2017 at 16:51:42 -0500, Rob Herring wrote:
> On Wed, Oct 11, 2017 at 09:35:28AM +0300, Eugen Hristev wrote:
> > Added property for DMA configuration of the device.
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > index 552e7a8..5f94d479 100644
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
> -names is pointless when there is only one.
> 

You didn't reply to the question I had previously about that: What if at
some point, we have multiple dmas in the same binding?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
