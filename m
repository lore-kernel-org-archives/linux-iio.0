Return-Path: <tony@atomide.com>
Date: Mon, 4 Apr 2016 15:35:47 -0700
From: Tony Lindgren <tony@atomide.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, Paul Walmsley <paul@pwsan.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: new driver for the ROHM BH1780
Message-ID: <20160404223546.GC8755@atomide.com>
References: <1459326847-9444-1-git-send-email-linus.walleij@linaro.org>
 <5700E7AF.6040903@kernel.org>
 <CACRpkdYkqzvu_fMcDPy8i0OCpGdGQ39S534HbCQL8T93gadKmQ@mail.gmail.com>
 <20160404074239.GT7800@tbergstrom-lnx.Nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160404074239.GT7800@tbergstrom-lnx.Nvidia.com>
List-ID: <linux-iio@vger.kernel.org>

* Peter De Schrijver <pdeschrijver@nvidia.com> [160404 00:43]:
> On Sun, Apr 03, 2016 at 06:30:49PM +0200, Linus Walleij wrote:
> > On Sun, Apr 3, 2016 at 11:51 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > > On 30/03/16 09:34, Linus Walleij wrote:
> > 
> > >> I want to phase out the old misc driver, but don't know how that
> > >> should properly be handled. The driver has an old (totally
> > >> undocumented) sysfs ABI for raw measurements, should I add
> > >> this as backward-compatibility and symlink the device to the old
> > >> location?
> > >
> > > Good question.  I guess we unfortunately do need to jump through the hoops as
> > > who knows what userspace code there is out there using that interface.
> > > At least it is small!
> > 
> > The maintainer Hemanth seems to have disappeared.
> > 
> > Let's ask some of the OMAP and ex-OMAP people, I think they know
> > or know who knows...
> > 
> > Tony, Peter, Paul: drivers/misc/bh1780gli.c has a funky sysfs ABI.
> > It is only used in arch/arm/boot/dts/omap4-sdp.dts as far as I can
> > tell. What device is this, and more importantly, who is running it
> > and with what userspace? I'm happy to go and patch that userspace
> > if I can just get a pointer to whoever is developing it. Sailfish?
> 
> Sailfish has never used OMAP4 afaik. OMAP4 sdp is a TI dev board, so maybe
> someone from TI knows what this is for?

Adding linux-omap to Cc. I suggest do a minimal patch to remove the
sysfs interface, then revert the patch if needed. I don't think
people are using it.

Regards,

Tony
