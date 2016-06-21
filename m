Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34393 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcFUVhS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2016 17:37:18 -0400
Date: Tue, 21 Jun 2016 16:37:16 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Vaussard <florian.vaussard@heig-vd.ch>
Cc: Peter Rosin <peda@axentia.se>,
	Florian Vaussard <florian.vaussard@gmail.com>,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: potentiometer: mcp4531: Add device tree binding
 documentation
Message-ID: <20160621213716.GA4370@rob-hp-laptop>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492137-32683-3-git-send-email-florian.vaussard@heig-vd.ch>
 <f763a2ea-6a82-a8f6-4afb-d09dba240927@axentia.se>
 <5768F180.4080601@heig-vd.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5768F180.4080601@heig-vd.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jun 21, 2016 at 09:49:20AM +0200, Florian Vaussard wrote:
> Hello,
> 
> On 06/21/2016 09:38 AM, Peter Rosin wrote:
> > On 2016-06-21 08:55, Florian Vaussard wrote:
> >> Add the device tree documentation for all the supported parts. Apart the
> >> compatible string and standard I2C binding, no other binding is currently
> >> needed.
> >>
> >> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> >> ---
> >>  .../bindings/iio/potentiometer/mcp4531.txt         | 84 ++++++++++++++++++++++
> >>  1 file changed, 84 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt
> >> new file mode 100644
> >> index 0000000..b052299
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt
> >> @@ -0,0 +1,84 @@
> >> +* Microchip MCP453X/454X/455X/456X/463X/464X/465X/466X Digital Potentiometer
> >> +  driver
> >> +
> >> +The node for this driver must be a child node of a I2C controller, hence
> >> +all mandatory properties for your controller must be specified. See directory:
> >> +
> >> +        Documentation/devicetree/bindings/i2c
> >> +
> >> +for more details.
> >> +
> >> +Required properties:
> >> +	- compatible:  	Must be one of the following, depending on the
> >> +			model:
> >> +			"microchip,mcp4531-502"
> >> +			"microchip,mcp4531-103"
> >> +			"microchip,mcp4531-503"
> > 
> > *snip*
> > 
> > I'm not directly opposed, but I have used the following and DT booting
> > works like a charm here.
> > 
> > 		mcp4651-104@28 {
> > 			compatible = "mcp4651-104";
> > 			reg = <0x28>;
> > 		};
> > 
> 
> I was not aware that the i2c subsystem had a facility to match the compatible
> string against i2c_device_id. Good to know.
> 
> > But, I suppose some DT documentation is not bad, and my understanding of
> > the device instantiation process and the i2c/dt interactions are not
> > complete, so my DT snippet might be an abomination? I'll leave the
> > decision if this is needed to someone with more experience on how other
> > drivers handle this.
> > 
> 
> Your compatible string is missing the vendor ID (microchip). This is the only
> objection that I can see to your proposition. Let's wait to hear from a DT
> maintainer.

I2C subsystem happens to ignore the vendor prefix in matching. You 
should not rely on that and provide proper compatible strings.

Rob
