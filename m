Return-Path: <SRS0=EqOy=7Q=atomide.com=tony@kernel.org>
Date: Mon, 14 Aug 2017 09:22:20 -0700
From: Tony Lindgren <tony@atomide.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-i2c@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-usb@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-ID: <20170814162219.GX8569@atomide.com>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
 <20170813133700.tv4ka7anvbzcplr7@ninjato>
 <20170814064247.qvggx4ito4vgjqvs@dell>
 <20170814084340.65morabelapfegph@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170814084340.65morabelapfegph@ninjato>
List-ID: <linux-iio@vger.kernel.org>

* Wolfram Sang <wsa@the-dreams.de> [170814 01:43]:
>=20
> > > Given the triviality of the change for non-MFD subsystems, can we app=
ly
> > > this for 4.14?
> >=20
> > I can't apply anything without Acks for *all* of the subsystems above.
>=20
> Well, there are cases when you can. Those should be exceptions and well
> justified, of course.
>=20
> > My suggestion would be to collect the Acks you've received up until
> > this point and identify which SS's are still lacking in change log
> > section of a RESEND.
>=20
> I agree, though, that I can try a second round to get the acks.

As long as it's been compile tested with omap2plus_defconfig:

Acked-by: Tony Lindgren <tony@atomide.com>
