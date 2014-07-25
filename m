Return-Path: <gnurou@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6059032.T3tqvLkWTo@wuerfel>
References: <1406214298-20062-1-git-send-email-acourbot@nvidia.com> <6059032.T3tqvLkWTo@wuerfel>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Fri, 25 Jul 2014 10:32:45 +0900
Message-ID: <CAAVeFuLK2qf1n6ipnW1tK_ur2_j7NOWLegMWYAQGwKw85fnwpA@mail.gmail.com>
Subject: Re: [PATCH] gpio: extend gpiod_get*() with flags parameter
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>, Sebastian Reichel <sre@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>,
	Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>,
	Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>,
	Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Johannes Berg <johannes@sipsolutions.net>, "John W. Linville" <linville@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>, Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>,
	Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>, Pavel Machek <pavel@ucw.cz>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jean Delvare <khali@linux-fr.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org,
	linux-mmc <linux-mmc@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-omap@vger.kernel.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 25, 2014 at 1:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 25 July 2014 00:04:58 Alexandre Courbot wrote:
>> I'm not sure how this could be applied harmlessly though - maybe through
>> a dedicated branch for -next? Problem is that a lot of new code is not
>> yet merged into mainline, and conflicts are very likely to occur. Linus,
>> do you have any suggestion as to how this can be done without blood being
>> spilled?
>
> There is a trick that we sometime use in this situation,
> though it has to be done carefully:
>
>> diff --git a/Documentation/gpio/consumer.txt b/Documentation/gpio/consumer.txt
>> index 7ff30d2..a3fb1d7 100644
>> --- a/Documentation/gpio/consumer.txt
>> +++ b/Documentation/gpio/consumer.txt
>> @@ -29,13 +29,24 @@ gpiod_get() functions. Like many other kernel subsystems, gpiod_get() takes the
>>  device that will use the GPIO and the function the requested GPIO is supposed to
>>  fulfill:
>>
>> -       struct gpio_desc *gpiod_get(struct device *dev, const char *con_id)
>> +       struct gpio_desc *gpiod_get(struct device *dev, const char *con_id,
>> +                                   enum gpio_flags flags)
>>
>>
>
>
> -       struct gpio_desc *gpiod_get(struct device *dev, const char *con_id)
> +       struct gpio_desc *__gpiod_get(struct device *dev, const char *con_id,
> +                                       enum gpio_flags flags);
> +
> +#define __gpiod_get(dev, con_id, flags, ...) __gpiod_get(dev, con_id, flags)
> +#define gpiod_get(varargs ...) __gpiod_get(varargs, 0)
>
> This will allow both variants to be called, and any users of the three-argument
> version will pass zero as the fourth argument (or whatever you choose there).
>
> Once the conversion is complete, the macros can be removed.

Wow, that works great, thanks! Indeed, this will allow me to send more
localized patches and to not spam half of the kernel developers. Sorry
about the noise.

Let's close this thread, I will submit the gpiolib update with this
trick first, then update each user before eventually removing the
macros.

Thanks,
Alex.
