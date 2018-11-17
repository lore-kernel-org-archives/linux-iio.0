Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.babblebit.net ([37.139.8.208]:47876 "EHLO
        mail.babblebit.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRGne (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Nov 2018 01:43:34 -0500
Date: Sat, 17 Nov 2018 20:25:41 +0000
From: Chris Coffey <cmc@babblebit.net>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: potentiometer: Add Microchip
 MCP41xxx/42xxx
Message-ID: <20181117202541.zm3blmbddxwloneh@deb-660>
References: <20181114095241.27037-1-cmc@babblebit.net>
 <20181114095241.27037-2-cmc@babblebit.net>
 <20181114100141.GA1214@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181114100141.GA1214@x220.localdomain>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 14, 2018 at 11:01:41AM +0100, Slawomir Stepien wrote:
> On lis 14, 2018 09:52, Chris Coffey wrote:
> > This patch adds device tree documentation for the Microchip
> > MCP41xxx/42xxx family of digital potentiometers.
> 
> Hi
> 
> One note inline.
> 

Hi Stepien,

Thank you for the reviews. One comment below.

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
> 

Gah! A classic case of my mind seeing what it wanted to see, instead of
what was actually there.

> > +	reg = <0>;
> > +	spi-max-frequency = <500000>;
> > +};
> 
> -- 
> Slawomir Stepien
