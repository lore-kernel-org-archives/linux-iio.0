Return-Path: <linux@roeck-us.net>
Date: Sat, 2 Feb 2013 08:13:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [RFC 11/11] iio/adc: (max1363) Add basic OF bindings and
 external vref support
Message-ID: <20130202161305.GC10386@roeck-us.net>
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
 <1359668588-13678-12-git-send-email-linux@roeck-us.net>
 <510CEB68.5000205@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510CEB68.5000205@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Feb 02, 2013 at 10:33:12AM +0000, Jonathan Cameron wrote:
> On 01/31/2013 09:43 PM, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Mostly fine.  Comments below are on the fact I'd prefer
> a reference voltage coming from a regulator than being
> a bit of platform data.
> > ---
> >  Documentation/devicetree/bindings/iio/max1363.txt |   54 +++++++++++++++++++++
> >  drivers/iio/adc/max1363.c                         |   54 ++++++++++++++++-----
> >  2 files changed, 95 insertions(+), 13 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/max1363.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/max1363.txt b/Documentation/devicetree/bindings/iio/max1363.txt
> > new file mode 100644
> > index 0000000..6d22861
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/max1363.txt
> > @@ -0,0 +1,54 @@
> > +Device Tree bindings for MAX1363 and compatible ADC controllers
> > +
> > +This binding uses the common IIO binding[1].
> > +
> > +[1] Documentation/devicetree/bindings/iio/iio-bindings.txt
> > +
> > +Required properties:
> > +
> > +- compatible, shall be one of the following:
> > +	"maxim,max1361"
> > +	"maxim,max1362"
> > +	"maxim,max1363"
> > +	"maxim,max1364"
> > +	"maxim,max1036"
> > +	"maxim,max1037"
> > +	"maxim,max1038"
> > +	"maxim,max1039"
> > +	"maxim,max1136"
> > +	"maxim,max1137"
> > +	"maxim,max1138"
> > +	"maxim,max1139"
> > +	"maxim,max1236"
> > +	"maxim,max1237"
> > +	"maxim,max1238"
> > +	"maxim,max1239"
> > +	"maxim,max11600"
> > +	"maxim,max11601"
> > +	"maxim,max11602"
> > +	"maxim,max11603"
> > +	"maxim,max11604"
> > +	"maxim,max11605"
> > +	"maxim,max11606"
> > +	"maxim,max11607"
> > +	"maxim,max11608"
> > +	"maxim,max11609"
> > +	"maxim,max11610"
> > +	"maxim,max11611"
> > +	"maxim,max11612"
> > +	"maxim,max11613"
> > +	"maxim,max11614"
> > +	"maxim,max11615"
> > +	"maxim,max11616"
> > +	"maxim,max11617"
> > +
> > +- reg: shall be the I2C device address
> > +
> > +Required properties for IIO bindings:
> > +- #io-channel-cells: from common IIO bindings; shall be set to 1.
> > +
> > +Optional properties:
> > +- vref: Reference voltage in mV. If the provided reference voltage matches
> > +	the internal reference voltage, the internal reference voltage is used.
> > +	Otherwise it is assumed that an external reference voltage is used,
> > +	and the chip is programmed accordingly.
> 
> Why not use a regulator? It has a nice device tree map and if it's just a fixed
> voltage, we have the fixed regulator driver for them.  This is pretty common
> throughout IIO (unsuprisingly) and we've been generally getting with platform
> data that does this in favour of regulators.  Back when we started out, the
> regulators framework was new so providing an alternative was pretty much
> required.  Now it's pretty universal.
> 
Makes sense' I'll look into it.

Thanks,
Guenter
