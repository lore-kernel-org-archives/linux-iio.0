Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32987 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcFUXpS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2016 19:45:18 -0400
Date: Tue, 21 Jun 2016 16:42:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-hwmon@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: MCP9808 iio or hwmon
Message-ID: <20160621234246.GA23912@roeck-us.net>
References: <20160613220843.GA4235@d830.WORKGROUP>
 <CAEnQRZBZcQZRYGbk-6Eh5sN7_D90HTZPPo=uOSSZF2obB5VD+w@mail.gmail.com>
 <CAEnQRZC9ES6dGyUdycW=nRuA=6yRa=i01BWBLt7uFsieE-74OQ@mail.gmail.com>
 <57600656.7030902@roeck-us.net>
 <20160621222609.GA2464@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160621222609.GA2464@d830.WORKGROUP>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jun 21, 2016 at 03:26:11PM -0700, Alison Schofield wrote:
> On Tue, Jun 14, 2016 at 06:27:50AM -0700, Guenter Roeck wrote:
> > On 06/14/2016 01:22 AM, Daniel Baluta wrote:
> > >[fixing IIO, hwmon lists emails]
> > >
> > >On Tue, Jun 14, 2016 at 11:20 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> > >>On Tue, Jun 14, 2016 at 1:08 AM, Alison Schofield <amsfield22@gmail.com> wrote:
> > >>>
> > >>>I was working on an iio driver for MCP9808 when Jonathan took notice
> > >>>and suggested we have the iio or hwmon discussion.
> > >>>
> > >>>So, where should this sensor driver reside?
> > >>>
> > >>>http://ww1.microchip.com/downloads/en/DeviceDoc/25095A.pdf
> > >>>
> > >>>It's a digital temp sensor with user programmable registers for
> > >>>sensing applications.  Supports shutdown, low power modes,
> > >>>specifying of event & critical output boundaries.  Can support
> > >>>8 sensors on a single serial bus. Touted as 'ideal for sophisticated
> > >>>multi-zone temperature-monitoring applications.'
> > >>
> > >>This is debatable, looking to the datasheet this driver could reside
> > >>in both places.
> > >>
> > >>Because this sensor has Industrial utility (e.g freezers, refrigerators) I
> > >>am inclined to say we should support it in IIO.
> > >>
> > 
> > Literally every sensor has that utility.
> > 
> > Alternatively, you might consider adding its device ID to the jc42 driver.
> > If you want to be fancy, you could add optional support for resolution
> > selection to the driver.
> > 
> > Guenter
> 
> Hi Guenter,
> I'm using the mcp9808 with the jc42 driver by instantiating it.
> 
> I've added the device ID info so that the .detect callback can recognize
> it, but can't figure out how to test that.  When/how does that .detect
> get called?  I am using the Diolan.
> 
Not sure if it works, but try to load the the jc42 driver using modprobe
first, and _then_ insert the diolan adapter.

Guenter
