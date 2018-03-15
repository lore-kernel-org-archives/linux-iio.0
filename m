Return-Path: <SRS0=fMG9=GF=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180315063238.3303b8d1@bbrezillon>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180315063238.3303b8d1@bbrezillon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 10:09:43 +0100
Message-ID: <CAK8P3a151M35ywHyABt2KFypPaiZROYuL10ztChwjSwqS9haHg@mail.gmail.com>
Subject: Re: [PATCH 00/47] arch-removal: device drivers
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>,
	Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, wg@grandegger.com, mkl@pengutronix.de,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jiri Slaby <jslaby@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shaohua Li <shli@kernel.org>,
	linux-watchdog@vger.kernel.org,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>,
	linux-pm@vger.kernel.org,
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-edac@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	Linux Media Mailing List <linux-media@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd <linux-mtd@lists.infradead.org>, Networking <netdev@vger.kernel.org>,
	linux-can@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	"open list:SOFTWARE RAID (Multiple Disks) SUPPORT" <linux-raid@vger.kernel.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 15, 2018 at 6:32 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hi Arnd,
>
> On Wed, 14 Mar 2018 16:35:13 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Hi driver maintainers,
>>
>> I just posted one series with the removal of eight architectures,
>> see https://lkml.org/lkml/2018/3/14/505 for details, or
>> https://lwn.net/Articles/748074/ for more background.
>>
>> These are the device drivers that go along with them. I have already
>> picked up the drivers for arch/metag/ into my tree, they were reviewed
>> earlier.
>>
>> Please let me know if you have any concerns with the patch, or if you
>> prefer to pick up the patches in your respective trees.  I created
>> the patches with 'git format-patch -D', so they will not apply without
>> manually removing those files.
>>
>> For anything else, I'd keep the removal patches in my asm-generic tree
>> and will send a pull request for 4.17 along with the actual arch removal.
>>

>
> If you don't mind, I'd like to take the mtd patches through the MTD
> tree. As you've probably noticed, nand code has been moved around and
> it's easier for me to carry those 2 simple changes in my tree than
> creating an immutable branch.
>
> Let me know if this is a problem.

Sounds good, I've removed the two patches from my tree now.
I've already sent a version of those that is based on your latest tree to
you for inclusion.

      Arnd
