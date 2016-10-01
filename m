Return-Path: <lorenzo.bianconi83@gmail.com>
Date: Sat, 1 Oct 2016 19:15:49 +0200
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH 2/2] Documentation: dt: iio: humidity: add hts221 sensor
 device binding
Message-ID: <20161001171548.GB22409@lorenzobianconi.net>
References: <1474919741-21316-1-git-send-email-lorenzo.bianconi@st.com>
 <1474919741-21316-3-git-send-email-lorenzo.bianconi@st.com>
 <01eba341-2323-52c9-cb86-32da09526a36@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01eba341-2323-52c9-cb86-32da09526a36@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Oct 01, Jonathan Cameron wrote:
> On 26/09/16 20:55, Lorenzo Bianconi wrote:
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> Please cc the device tree list and maintainers on the next version.
> This is simple enough I 'can' take it without their Ack, but
> nice to keep them informed.

Ack. I will cc in v2

Regards,
Lorenzo

> 
> Jonathan
> > ---
> >  .../devicetree/bindings/iio/humidity/hts221.txt       | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> > new file mode 100644
> > index 0000000..46a152c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> > @@ -0,0 +1,19 @@
> > +* HTS221 STM humidity + temperature sensor
> > +
> > +Required properties:
> > +- compatible: should be "st,hts221"
> > +- reg: i2c address of the sensor / spi cs line
> > +
> > +Optional properties:
> > +- interrupts: interrupt mapping for GPIO IRQ. It should be configured with
> > +	      flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING
> > +- interrupt-parent: should be the phandle for the interrupt controller
> > +
> > +Example:
> > +
> > +hts221@5f {
> > +	compatible = "st,hts221";
> > +	reg = <0x5f>;
> > +	interrupt-parent = <&gpio0>;
> > +	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
> > +};
> > 
> 

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch; unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp; umount; make clean; sleep
