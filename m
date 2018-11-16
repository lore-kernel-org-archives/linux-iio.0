Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQEPr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:15:47 -0500
Date: Fri, 16 Nov 2018 18:02:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Chris Coffey <cmc@babblebit.net>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: potentiometer: Add Microchip
 MCP41xxx/42xxx
Message-ID: <20181116180218.61aabbe5@archlinux>
In-Reply-To: <20181114100141.GA1214@x220.localdomain>
References: <20181114095241.27037-1-cmc@babblebit.net>
        <20181114095241.27037-2-cmc@babblebit.net>
        <20181114100141.GA1214@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 14 Nov 2018 11:01:41 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> On lis 14, 2018 09:52, Chris Coffey wrote:
> > This patch adds device tree documentation for the Microchip
> > MCP41xxx/42xxx family of digital potentiometers.  
> 
> Hi
> 
> One note inline.
> 
> > Signed-off-by: Chris Coffey <cmc@babblebit.net>
> > ---
> >  .../bindings/iio/potentiometer/mcp41010.txt        | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> > new file mode 100644
> > index 0000000000..17565acace
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> > @@ -0,0 +1,29 @@
> > +* Microchip MCP41010/41050/41100/42010/42050/42100 Digital Potentiometer
> > +  driver
> > +
> > +Datasheet publicly available at:
> > +http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
> > +
> > +The node for this driver must be a child node of a SPI controller, hence
> > +all mandatory properties described in
> > +
> > +        Documentation/devicetree/bindings/spi/spi-bus.txt
> > +
> > +must be specified.
> > +
> > +Required properties:
> > +	- compatible:  	Must be one of the following, depending on the
> > +			model:
> > +			"microchip,mcp41010"
> > +			"microchip,mcp41050"
> > +			"microchip,mcp41100"
> > +			"microchip,mcp42010"
> > +			"microchip,mcp42050"
> > +			"microchip,mcp42100"
> > +
> > +Example:
> > +mcp41010: potentiometer@0 {
> > +	compatible = "mcp41010";  
> 
> Missing company name in compatible.
Also don't need (or want) the precursor
mcp41010: for an example.

potentiometer@0 {
	compatible = "microchip,mcp41010";
	reg = <0>;
	spi-max-frequency = <500000>;
};

> 
> > +	reg = <0>;
> > +	spi-max-frequency = <500000>;
> > +};  
> 
