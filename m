Return-Path: <jhovold@gmail.com>
Date: Thu, 3 May 2012 19:31:59 +0200
From: Johan Hovold <jhovold@gmail.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rob Landley <rob@landley.net>, Richard Purdie <rpurdie@rpsys.net>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mfd: add LM3533 lighting-power core driver
Message-ID: <20120503173159.GH15752@localhost>
References: <1336040799-18433-2-git-send-email-jhovold@gmail.com>
 <20120503103848.GB3955@opensource.wolfsonmicro.com>
 <20120503112803.GA15752@localhost>
 <20120503113801.GE3955@opensource.wolfsonmicro.com>
 <20120503150040.GC15752@localhost>
 <20120503152407.GK3955@opensource.wolfsonmicro.com>
 <20120503165437.GF15752@localhost>
 <20120503165748.GS3955@opensource.wolfsonmicro.com>
 <20120503171402.GG15752@localhost>
 <20120503172309.GT3955@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120503172309.GT3955@opensource.wolfsonmicro.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 03, 2012 at 06:23:10PM +0100, Mark Brown wrote:
> On Thu, May 03, 2012 at 07:14:02PM +0200, Johan Hovold wrote:
> 
> > Assigning a current sink to a control bank corresponds, then, to
> > setting, for example, output_lvled3 to (led) 1.
> 
> This seems sensible enough, though it does feel like what we're offering
> up to the LED subsystem is relly the LED control banks rather than the
> LEDs themselves - or some mix of this and other stuff.

Exactly. That's why I've tried to refer to the led devices as "logical
leds" as they may be connected to more than one output (the physical
leds).

Johan
