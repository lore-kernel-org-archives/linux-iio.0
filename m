Return-Path: <broonie@sirena.org.uk>
Date: Wed, 7 Sep 2011 20:07:52 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@nvidia.com>, Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>,
	Russell King <linux@arm.linux.org.uk>,
	Andrew Chew <AChew@nvidia.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2 1/4] i2c: Add irq_gpio field to struct i2c_client.
Message-ID: <20110907190752.GB24703@sirena.org.uk>
References: <1314895964-15964-1-git-send-email-swarren@nvidia.com>
 <4E60985B.6010901@cam.ac.uk>
 <74CDBE0F657A3D45AFBB94109FB122FF04B327A55D@HQMAIL01.nvidia.com>
 <201109021805.27569.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201109021805.27569.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 02, 2011 at 06:05:27PM +0200, Arnd Bergmann wrote:

> It would not fit well if we expect gpio numbers to be local to
> a gpio controller, with no unique global identifier for them, similar
> to how dma channels in the dma-engine subsystem are handled.

Or perhaps moving to a clk API style lookup?
