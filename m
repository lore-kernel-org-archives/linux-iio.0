Return-Path: <SRS0=D9cW=JW=it-klinger.de=ak@kernel.org>
Date: Fri, 6 Jul 2018 08:21:47 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Rob Herring <robh@kernel.org>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, mchehab@kernel.org, davem@davemloft.net,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	linus.walleij@linaro.org, rdunlap@infradead.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: hx711: add clock-frequency property in DT
Message-ID: <20180706062147.GA1950@arbeit>
References: <20180704123638.GA30535@arbeit>
 <20180705213019.GA12792@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180705213019.GA12792@rob-hp-laptop>
List-ID: <linux-iio@vger.kernel.org>

Hi Rob,

please see explanation below. Thanks.

Rob Herring <robh@kernel.org> schrieb am Thu, 05. Jul 15:30:
> On Wed, Jul 04, 2018 at 02:36:38PM +0200, Andreas Klinger wrote:
> > Add clock-frequency property for hx711 ADC
> > 
> > This is the frequency of PD_SCK. It affects only the high value duration
> > since low value duration is not relevant and we are not able to switch
> > faster than the minimum duration specified.
> > 
> > After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
> > This is necessary because of parasitic capacities on the wiring.
> 
> s/capacities/capacitance/

I'll change. 

> 
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > index b3629405f568..4bee51d536e1 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > @@ -8,11 +8,21 @@ Required properties:
> >  		See Documentation/devicetree/bindings/gpio/gpio.txt
> >   - avdd-supply:	Definition of the regulator used as analog supply
> >  
> > +Optional properties:
> > + - clock-frequency:	Frequency of PD_SCK
> > +			This setting affects the duration of the high value
> > +			phase of the clock (PD_SCK). The low value phase is
> > +			not affected since it is not relevant for the
> > +			measurement.
> 
> That's not how frequency works. The high time should be equal to the low 
> time. If you have parasitic capacitance affecting the rise time, then it 
> is going to affect the fall time too.
> 
> Perhaps there could be some reason not to have a square wave, but I 
> didn't see one in the datasheet.

When PD_SCK goes high the ADC sets DOUT to the corresponding value. Only after a
rising edge DOUT is set. The falling edge doesn't matter.

The parasitic capacitance is occuring only on DOUT line, but not on PD_SCK. The
difference is that PD_SCK is driven by the microcontroller, and DOUT by the ADC. 

So after i set the rising edge on PD_SCK i have to wait until DOUT reaches its
value. Datasheet says this can take at maximum 0.1 us. This might be true, but
without wiring between ADC and microcontroller. With wiring of a 10 m cable i
saw 1 us on the oscilloscope.

If required i can post a screenshot of the oscilloscope.

The code which is executed in the driver on PD_SCK during low value takes much
more than the requested 0.2 us (measured 0.56 us). Of course i can make it a
square wave with equal low and high time, but i don't see it's needed and it'll
slow down the communication speed.

Out of my frequency generator i can get a rectangular waveform with different
low and high times and it's still called frequency. A don't have another
expression for it. 

Do you have a suggestion how to call this attribute in the DT if frequency is
not suitable?

> 
> > +			Minimum value allowed is 20 kHz because of maximum
> > +			high time of 50 microseconds.
> 
> So 10kHz should be minimum.
>

Because the low time is very short (0.5 us) in comparison to the high time
(50 us) in the actual waveform i neglected it.

Andreas

> > +
> >  Example:
> >  weight@0 {
> >  	compatible = "avia,hx711";
> >  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> >  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> >  	avdd-suppy = <&avdd>;
> > +	clock-frequency = <100000>;
> >  };
> >  
> > -- 
> > 2.1.4

-- 
