Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:50552 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJGW2F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Oct 2018 18:28:05 -0400
Date: Sun, 7 Oct 2018 16:20:20 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: Add PNI RM3100 device tree binding.
Message-ID: <20181007162020.6535767e@archlinux>
In-Reply-To: <20181007161808.44a61d45@archlinux>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181002143812.3661-3-songqiang1304521@gmail.com>
        <20181007161808.44a61d45@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 7 Oct 2018 16:18:08 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue,  2 Oct 2018 22:38:11 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> > ---
> >  .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> > new file mode 100644
> > index 000000000000..4677690fc5d0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> > @@ -0,0 +1,20 @@
> > +* PNI RM3100 3-axis magnetometer sensor
> > +
> > +Required properties:
> > +
> > +- compatible : should be "pni,rm3100"
> > +- reg : the I2C address or SPI chip select number of the sensor.
> > +
> > +Optional properties:
> > +
> > +- interrupts: data ready (DRDY) from the chip.
> > +  The interrupts can be triggered on rising edges.  
> From Phil's response this appears to be incorrect and
> it's actually a level sensitive interrupt.
> I haven't checked the data sheet to confirm this.
> 
> That'll bring all sorts of pain if you have a host that can only
> do edge sensitive so I'm hoping that's not true for you
> (edge sensitive only interrupts on hosts are pretty unusual
> though it cause me a lot of problems when I started out
> with IIO years ago :(
> 
> The docs aren't super clear on this.  The subtlety is
> whether there is a guaranteed 'low' time between reading the
> data and it going high again due to another reading.  This usually
> only matters if you are running very quickly though so may be
> fine here.
> 
> This will only become relevant with continuous mode if you
> add support for that later (I think!)
I realised just after I sent this that I was being unclear.

If you aren't doing continuous mode and hence have a fairly
strong guarantee of a decent gap between reads, you may be
able to get away with supporting either LEVEL or EDGE
interrupts.  In continuous mode, it is necessary to have
a minimum low time for EDGE interrupts to work.

Jonathan
> 
> Jonathan
> 
> > +
> > +Example:
> > +
> > +rm3100: rm3100@20 {
> > +	compatible = "pni,rm3100";
> > +	reg = <0x20>;
> > +	interrupt-parent = <&gpio0>;
> > +	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> > +};  
> 
