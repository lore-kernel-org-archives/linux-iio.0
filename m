Return-Path: <SRS0=TOvs=CF=microchip.com=Ludovic.Desroches@kernel.org>
Date: Tue, 7 Nov 2017 10:02:16 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
CC: Rob Herring <robh@kernel.org>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: at91-sama5d2_adc: add optional
 dma property
Message-ID: <20171107090216.zpn3elitrfditm5y@rfolt0960.corp.atmel.com>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
 <1507703732-29175-2-git-send-email-eugen.hristev@microchip.com>
 <20171013215142.vlfhzzzetmc7resq@rob-hp-laptop>
 <20171019111417.7rzdnkvtukzzhl2u@piout.net>
 <CAL_JsqLPMeF9EtcCO3eZn+7DbyAQcxzNYEpAiFvQoe1=ytpELQ@mail.gmail.com>
 <5f171202-6a6a-2055-cb5c-c0c687f60f86@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5f171202-6a6a-2055-cb5c-c0c687f60f86@microchip.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 07, 2017 at 10:49:41AM +0200, Eugen Hristev wrote:
> 
> 
> On 20.10.2017 00:58, Rob Herring wrote:
> > On Thu, Oct 19, 2017 at 6:14 AM, Alexandre Belloni
> > <alexandre.belloni@free-electrons.com> wrote:
> > > On 13/10/2017 at 16:51:42 -0500, Rob Herring wrote:
> > > > On Wed, Oct 11, 2017 at 09:35:28AM +0300, Eugen Hristev wrote:
> > > > > Added property for DMA configuration of the device.
> > > > > 
> > > > > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > ---
> > > > >   Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
> > > > >   1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > > > > index 552e7a8..5f94d479 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > > > > @@ -17,6 +17,11 @@ Required properties:
> > > > >     This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
> > > > >     IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
> > > > > 
> > > > > +Optional properties:
> > > > > +  - dmas: Phandle to dma channel for the ADC.
> > > > > +  See ../../dma/dma.txt for details.
> > > > > +  - dma-names: Must be "rx" when dmas property is being used.
> > > > 
> > > > -names is pointless when there is only one.
> > > > 
> > > 
> > > You didn't reply to the question I had previously about that: What if at
> > > some point, we have multiple dmas in the same binding?
> > 
> > Then add dma-names at that point and rx has to be first. If you know
> > there's other channels, then add them now. Don't evolve the bindings
> > needlessly based on what a driver supports.
> > 
> > Would another channel make sense here? Maybe multi-channel rx in which
> > case your naming wouldn't be setup for that. But "tx" on an ADC?
> > 
> > Rob
> 
> Hello Rob,
> 
> I can keep only "dmas" and remove "dma-names", but then, the API used by
> the drivers that request channels requires a name parameter
> (dma_request_slave_channel), and it will look always inside the
> "dma-names" property to match the name and find the proper channel, and
> it will fail in this case.
> 
> Looking in the general dma binding (dma.txt) I can see that both
> properties are marked as required for a client driver, so that's why
> I added both.
> 

I don't understand why dma-names should be removed. For sure, if we have
only one channel, it becomes useless but the helpers to get a dma channel
rely on dma-names property.

Ludovic

> I can either keep dma-names; or try to find the channel properties by
> looking directly into the OF node and create the dma_chan struct inside
> my driver (maybe call some xlate function for the DMA controller), but
> still need to get the DT property. A complicated option would be to
> actually create an API inside the dmaengine to find a channel without
> name.
> 
> Which approach you think it's best to pursue ?
> 
> Thanks,
> Eugen
> 
> 
> 
> > 
