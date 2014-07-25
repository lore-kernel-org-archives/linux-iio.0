Return-Path: <gnurou@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1496956.3bpx902hFg@avalon>
References: <1406214298-20062-1-git-send-email-acourbot@nvidia.com> <1496956.3bpx902hFg@avalon>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Fri, 25 Jul 2014 10:36:43 +0900
Message-ID: <CAAVeFu+R+UWtxftWBM3qghNnf9O6SOf5AeNC-qemG7W05hiuAQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: extend gpiod_get*() with flags parameter
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>, Sebastian Reichel <sre@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>,
	Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>,
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
	Jean Delvare <khali@linux-fr.org>,
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

On Fri, Jul 25, 2014 at 1:23 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> diff --git a/Documentation/gpio/consumer.txt
>> b/Documentation/gpio/consumer.txt index 7ff30d2..a3fb1d7 100644
>> --- a/Documentation/gpio/consumer.txt
>> +++ b/Documentation/gpio/consumer.txt
>> @@ -29,13 +29,24 @@ gpiod_get() functions. Like many other kernel
>> subsystems, gpiod_get() takes the device that will use the GPIO and the
>> function the requested GPIO is supposed to fulfill:
>>
>> -     struct gpio_desc *gpiod_get(struct device *dev, const char *con_id)
>> +     struct gpio_desc *gpiod_get(struct device *dev, const char *con_id,
>> +                                 enum gpio_flags flags)
>
> I assume you mean enum gpiod_flags here and in the rest of the documentation.

Indeed, thanks for pointing it out.

>
>>  If a function is implemented by using several GPIOs together (e.g. a simple
>> LED device that displays digits), an additional index argument can be
>> specified:
>>
>>       struct gpio_desc *gpiod_get_index(struct device *dev,
>> -                                       const char *con_id, unsigned int idx)
>> +                                       const char *con_id, unsigned int idx,
>> +                                       enum gpio_flags flags)
>> +
>> +The flags parameter is used to optionally specify a direction and initial
>> value +for the GPIO. Values can be:
>> +
>> +* AS_IS or 0 to not initialize the GPIO at all. The direction must be set
>> later
>> +  with one of the dedicated functions.
>> +* INPUT to initialize the GPIO as input.
>> +* OUTPUT_LOW to initialize the GPIO as output with a value of 0.
>> +* OUTPUT_HIGH to initialize the GPIO as output with a value of 1.
>
> Pretty please, could you at least prefix that with GPIOD_ ? Those names are
> too generic.
>
> How about renaming them to GPIOD_AS_IS, GPIOD_IN, GPIOD_OUT_INIT_LOW and
> GPIOD_OUT_INIT_HIGH in order to match the GPIOF_ flags ?

Yeah, you're right, the possibility of name collision is quite high here.

Thanks,
Alex.
