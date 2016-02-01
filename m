Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48414 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbcBAUCg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 1 Feb 2016 15:02:36 -0500
Date: Mon, 1 Feb 2016 14:01:44 -0600
From: Andreas Dannenberg <dannenberg@ti.com>
To: Rob Herring <robh@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<jic23@kernel.org>, Alexander Koch <mail@alexanderkoch.net>,
	<knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.ne>,
	<mhornung.linux@gmail.com>, <fengguang.wu@intel.com>
Subject: Re: [PATCH] iio: light: opt3001: Add device tree binding
 documentation
Message-ID: <20160201200143.GE9016@LTA0797059A>
References: <1454094180-2688-1-git-send-email-dannenberg@ti.com>
 <20160201151848.GA11967@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160201151848.GA11967@rob-hp-laptop>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 01, 2016 at 09:18:48AM -0600, Rob Herring wrote:
> On Fri, Jan 29, 2016 at 01:03:00PM -0600, Andreas Dannenberg wrote:
> > Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> > ---
> >  .../devicetree/bindings/iio/light/opt3001.txt      | 26 ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/opt3001.txt b/Documentation/devicetree/bindings/iio/light/opt3001.txt
> > new file mode 100644
> > index 0000000..55b9cb3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/opt3001.txt
> > @@ -0,0 +1,26 @@
> > +* Texas Instruments OPT3001 Ambient Light Sensor
> > +
> > +The driver supports interrupt-driven and interrupt-less operation, depending
> > +on whether an interrupt property has been populated into the DT. Note that
> > +the optional generation of IIO events on rising/falling light threshold changes
> > +requires the use of interrupts. Without interrupts, only the simple reading
> > +of the current light value is supported through the IIO API.
> 
> Seems like you could poll and do the threshold changes in s/w. Anyway, 
> that's all irrelevant to the DT binding.

True that. The recent addition of polling mode to the driver did not
consider this use case so until somebody has a strong need for this and
adds the needed code at least we have this limitation documented.

Regards,
Andreas


> 
> Acked-by: Rob Herring <robh@kernel.org>
