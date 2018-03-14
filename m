Return-Path: <SRS0=+kjq=GE=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Mar 2018 23:45:54 +0100
Message-ID: <CAJZ5v0jsoxWRiwPOCJH6AAz-MiccOuicD8peCevLRMbTfc7LEg@mail.gmail.com>
Subject: Re: [PATCH 00/47] arch-removal: device drivers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>, Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, boris.brezillon@bootlin.com,
	cyrille.pitchen@wedev4u.fr, wg@grandegger.com, mkl@pengutronix.de,
	alexandre.belloni@bootlin.com, Mark Brown <broonie@kernel.org>, jic23@kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Jiri Slaby <jslaby@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, shli@kernel.org, linux-watchdog@vger.kernel.org,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-ide@vger.kernel.org,
	Linux PM <linux-pm@vger.kernel.org>, linux-crypto@vger.kernel.org,
	"open list:EDAC-CORE" <linux-edac@vger.kernel.org>, linux-gpio@vger.kernel.org,
	linux-i2c <linux-i2c@vger.kernel.org>, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, netdev <netdev@vger.kernel.org>,
	linux-can@vger.kernel.org, Linux PWM List <linux-pwm@vger.kernel.org>,
	linux-rtc@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
	"open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, linux-raid@vger.kernel.org,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 14, 2018 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Hi driver maintainers,
>
> I just posted one series with the removal of eight architectures,
> see https://lkml.org/lkml/2018/3/14/505 for details, or
> https://lwn.net/Articles/748074/ for more background.
>
> These are the device drivers that go along with them. I have already
> picked up the drivers for arch/metag/ into my tree, they were reviewed
> earlier.
>
> Please let me know if you have any concerns with the patch, or if you
> prefer to pick up the patches in your respective trees.  I created
> the patches with 'git format-patch -D', so they will not apply without
> manually removing those files.
>
> For anything else, I'd keep the removal patches in my asm-generic tree
> and will send a pull request for 4.17 along with the actual arch removal.

Please include the cpufreq patches into that and you can add ACKs from
me on them if that helps.

Thanks!
