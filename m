Return-Path: <paul@pwsan.com>
Date: Thu, 7 Apr 2016 18:51:36 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, Tony Lindgren <tony@atomide.com>,
  Peter De Schrijver <pdeschrijver@nvidia.com>,
  "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
  Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
  Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3] iio: light: new driver for the ROHM BH1780
In-Reply-To: <CACRpkdYkqzvu_fMcDPy8i0OCpGdGQ39S534HbCQL8T93gadKmQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1604071849540.19674@utopia.booyaka.com>
References: <1459326847-9444-1-git-send-email-linus.walleij@linaro.org> <5700E7AF.6040903@kernel.org> <CACRpkdYkqzvu_fMcDPy8i0OCpGdGQ39S534HbCQL8T93gadKmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sun, 3 Apr 2016, Linus Walleij wrote:

> On Sun, Apr 3, 2016 at 11:51 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On 30/03/16 09:34, Linus Walleij wrote:
> 
> >> I want to phase out the old misc driver, but don't know how that
> >> should properly be handled. The driver has an old (totally
> >> undocumented) sysfs ABI for raw measurements, should I add
> >> this as backward-compatibility and symlink the device to the old
> >> location?
> >
> > Good question.  I guess we unfortunately do need to jump through the hoops as
> > who knows what userspace code there is out there using that interface.
> > At least it is small!
> 
> The maintainer Hemanth seems to have disappeared.
> 
> Let's ask some of the OMAP and ex-OMAP people, I think they know
> or know who knows...
> 
> Tony, Peter, Paul: drivers/misc/bh1780gli.c has a funky sysfs ABI.
> It is only used in arch/arm/boot/dts/omap4-sdp.dts as far as I can
> tell. What device is this, and more importantly, who is running it
> and with what userspace? I'm happy to go and patch that userspace
> if I can just get a pointer to whoever is developing it. Sailfish?

If it's only used in the OMAP4 SDP DT file in upstream, then you probably 
don't need to worry much about who's using it... Sounds like you should 
just fix it.


- Paul
