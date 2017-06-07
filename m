Return-Path: <SRS0=ILwk=5M=atomide.com=tony@kernel.org>
Date: Tue, 6 Jun 2017 23:22:00 -0700
From: Tony Lindgren <tony@atomide.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
	Marcel Partap <mpartap@gmx.net>,
	Michael Scott <michael.scott@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature
Message-ID: <20170607062200.GD3730@atomide.com>
References: <20170523005146.726-1-tony@atomide.com>
 <20170523005146.726-2-tony@atomide.com>
 <20170524201831.3504c42d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170524201831.3504c42d@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

* Jonathan Cameron <jic23@kernel.org> [170524 12:22]:
> On Mon, 22 May 2017 17:51:44 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Looking at the register dumps from Android kernel on droid 4, I noticed
> > the values with the mainline kernel don't match. Let's fix this by
> > initializing the ADC registers to what Android does.
> > 
> > For getting correct values from the battery thermistor, we need to
> > toggle the CPCAP_BIT_THERMBIAS_EN when measuring battery temperature
> > to get correct battery temperatures. And looks like we also need to
> > wait a little bit before reading the battery temperature as otherwise
> > the results are inaccurate.
> > 
> > Cc: Marcel Partap <mpartap@gmx.net>
> > Cc: Michael Scott <michael.scott@linaro.org>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> Applied to the togreg branch of iio.git and will be shortly pushed
> out as testing for the autobuilders to play with it.

Not seeing these in your togreg brach or in next? The
branch I just checked is the one below, maybe I'm looking
at a wrong branch or something.

Regards,

Tony

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg
