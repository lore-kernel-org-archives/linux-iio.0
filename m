Return-Path: <lee.jones@linaro.org>
Date: Fri, 25 Jul 2014 07:52:50 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alexander Shiyan <shc_work@mail.ru>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Samuel Ortiz <sameo@linux.intel.com>,
	Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Jiri Slaby <jslaby@suse.cz>,
	Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Brian Austin <brian.austin@cirrus.com>,
	Paul Handrigan <Paul.Handrigan@cirrus.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Pavel Machek <pavel@ucw.cz>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jean Delvare <khali@linux-fr.org>, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org,
	alsa-devel@alsa-project.org, gnurou@gmail.com
Subject: Re: [PATCH] gpio: extend gpiod_get*() with flags parameter
Message-ID: <20140725065250.GF7063@lee--X1>
References: <1406214298-20062-1-git-send-email-acourbot@nvidia.com>
 <20140724161052.GA15615@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140724161052.GA15615@kroah.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, 24 Jul 2014, Greg Kroah-Hartman wrote:

> On Fri, Jul 25, 2014 at 12:04:58AM +0900, Alexandre Courbot wrote:
> > The huge majority of GPIOs have their direction and initial value set
> > right after being obtained by one of the gpiod_get() functions. The
> > integer GPIO API had gpio_request_one() that took a convenience flags
> > parameter allowing to specify an direction and value applied to the
> > returned GPIO. This feature greatly simplifies client code and ensures
> > errors are always handled properly.
> > 
> > A similar feature has been requested for the gpiod API. Since GPIOs need
> > a direction to be used anyway, we prefer to extend the existing
> > functions instead of introducing new functions that would raise the
> > number of gpiod getters to 16 (!).
> > 
> > The drawback of this approach is that all gpiod clients need to be
> > updated, but there aren't that many and the moment and this results in
> > smaller (and hopefully safer) code.
> > 
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > ---
> > This change will be difficult to apply without breaking things, but
> > let's try to do it right. Hopefully the benefit will outweight the
> > disturbance.
> > 
> > This is a patch against -next to list and update all current gpiod
> > consumers. Updates are trivial at first sight, but it would be nice to
> > get as many acks as possible from the respective subsystem maintainers.
> > 
> > I'm not sure how this could be applied harmlessly though - maybe through
> > a dedicated branch for -next? Problem is that a lot of new code is not
> > yet merged into mainline, and conflicts are very likely to occur. Linus,
> > do you have any suggestion as to how this can be done without blood being
> > spilled?
> 
> Do this in 3 steps, not all at once.
> 
> Make a new function that takes the new argument, get that merged
> 
> Submit patches that convert drivers over to use the new function.
> 
> Once all of those are merged, remove the old function.
> 
> That way there are no "flag days" needed, and everyone is happy you
> don't send out emails with 40+ people in the To: and Cc: lines :)

+99999

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
