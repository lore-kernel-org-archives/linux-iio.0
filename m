Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Johannes Berg <johannes@sipsolutions.net>, "John W. Linville" <linville@tuxdriver.com>
 , "David
  S. Miller" <davem@davemloft.net>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Pavel Machek <pavel@ucw.cz>, Jean Delvare <khali@linux-fr.org>, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org, alsa-devel@alsa-project.org, gnurou@gmail.com
Subject: Re: [PATCH] gpio: extend gpiod_get*() with flags parameter
Date: Thu, 24 Jul 2014 18:23:39 +0200
Message-ID: <1496956.3bpx902hFg@avalon>
In-Reply-To: <1406214298-20062-1-git-send-email-acourbot@nvidia.com>
References: <1406214298-20062-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Hi Alexandre,

Thank you for the patch.

On Friday 25 July 2014 00:04:58 Alexandre Courbot wrote:
> The huge majority of GPIOs have their direction and initial value set
> right after being obtained by one of the gpiod_get() functions. The
> integer GPIO API had gpio_request_one() that took a convenience flags
> parameter allowing to specify an direction and value applied to the
> returned GPIO. This feature greatly simplifies client code and ensures
> errors are always handled properly.
> 
> A similar feature has been requested for the gpiod API. Since GPIOs need
> a direction to be used anyway, we prefer to extend the existing
> functions instead of introducing new functions that would raise the
> number of gpiod getters to 16 (!).
> 
> The drawback of this approach is that all gpiod clients need to be
> updated, but there aren't that many and the moment and this results in
> smaller (and hopefully safer) code.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> This change will be difficult to apply without breaking things, but
> let's try to do it right. Hopefully the benefit will outweight the
> disturbance.
> 
> This is a patch against -next to list and update all current gpiod
> consumers. Updates are trivial at first sight, but it would be nice to
> get as many acks as possible from the respective subsystem maintainers.
> 
> I'm not sure how this could be applied harmlessly though - maybe through
> a dedicated branch for -next? Problem is that a lot of new code is not
> yet merged into mainline, and conflicts are very likely to occur. Linus,
> do you have any suggestion as to how this can be done without blood being
> spilled?
> 
>  Documentation/gpio/consumer.txt                    | 26 ++++++++---
>  drivers/gpio/devres.c                              | 24 ++++++----
>  drivers/gpio/gpiolib.c                             | 53 +++++++++++++------
>  drivers/gpu/drm/panel/panel-ld9040.c               |  7 +--
>  drivers/gpu/drm/panel/panel-s6e8aa0.c              |  7 +--
>  drivers/gpu/drm/panel/panel-simple.c               | 16 ++-----
>  drivers/hsi/clients/nokia-modem.c                  |  7 +--
>  drivers/i2c/muxes/i2c-mux-pca954x.c                |  4 +-
>  drivers/iio/accel/kxcjk-1013.c                     |  6 +--
>  drivers/input/keyboard/clps711x-keypad.c           |  6 +--
>  drivers/input/misc/gpio-beeper.c                   |  6 +--
>  drivers/input/misc/soc_button_array.c              |  2 +-
>  drivers/media/i2c/adv7604.c                        |  6 +--
>  drivers/mfd/intel_soc_pmic_core.c                  |  2 +-
>  drivers/mmc/core/slot-gpio.c                       |  6 +--
>  drivers/net/phy/at803x.c                           |  4 +-
>  drivers/power/reset/gpio-poweroff.c                | 21 ++-------
>  drivers/tty/serial/serial_mctrl_gpio.c             |  2 +-
>  drivers/video/backlight/pwm_bl.c                   |  6 +--
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 12 ++---
>  .../omap2/displays-new/panel-lgphilips-lb035q02.c  |  6 +--
>  .../omap2/displays-new/panel-sharp-ls037v7dw01.c   |  7 +--
>  include/linux/gpio/consumer.h                      | 38 ++++++++++++----
>  net/rfkill/rfkill-gpio.c                           | 16 ++-----
>  sound/soc/codecs/adau1977.c                        | 11 ++---
>  sound/soc/codecs/cs4265.c                          |  5 +-
>  sound/soc/codecs/sta350.c                          |  9 ++--
>  sound/soc/codecs/tas2552.c                         |  4 +-
>  sound/soc/jz4740/qi_lb60.c                         | 10 +---
>  sound/soc/omap/rx51.c                              | 29 +++---------
>  sound/soc/soc-jack.c                               |  9 ++--
>  31 files changed, 160 insertions(+), 207 deletions(-)
> 
> diff --git a/Documentation/gpio/consumer.txt
> b/Documentation/gpio/consumer.txt index 7ff30d2..a3fb1d7 100644
> --- a/Documentation/gpio/consumer.txt
> +++ b/Documentation/gpio/consumer.txt
> @@ -29,13 +29,24 @@ gpiod_get() functions. Like many other kernel
> subsystems, gpiod_get() takes the device that will use the GPIO and the
> function the requested GPIO is supposed to fulfill:
> 
> -	struct gpio_desc *gpiod_get(struct device *dev, const char *con_id)
> +	struct gpio_desc *gpiod_get(struct device *dev, const char *con_id,
> +				    enum gpio_flags flags)

I assume you mean enum gpiod_flags here and in the rest of the documentation.

>  If a function is implemented by using several GPIOs together (e.g. a simple
> LED device that displays digits), an additional index argument can be
> specified:
> 
>  	struct gpio_desc *gpiod_get_index(struct device *dev,
> -					  const char *con_id, unsigned int idx)
> +					  const char *con_id, unsigned int idx,
> +					  enum gpio_flags flags)
> +
> +The flags parameter is used to optionally specify a direction and initial
> value +for the GPIO. Values can be:
> +
> +* AS_IS or 0 to not initialize the GPIO at all. The direction must be set
> later
> +  with one of the dedicated functions.
> +* INPUT to initialize the GPIO as input.
> +* OUTPUT_LOW to initialize the GPIO as output with a value of 0.
> +* OUTPUT_HIGH to initialize the GPIO as output with a value of 1.

Pretty please, could you at least prefix that with GPIOD_ ? Those names are 
too generic.

How about renaming them to GPIOD_AS_IS, GPIOD_IN, GPIOD_OUT_INIT_LOW and 
GPIOD_OUT_INIT_HIGH in order to match the GPIOF_ flags ?

>  Both functions return either a valid GPIO descriptor, or an error code
> checkable with IS_ERR() (they will never return a NULL pointer). -ENOENT
> will be returned @@ -49,11 +60,13 @@ GPIO has been assigned to the
> requested function:
> 
>  Device-managed variants of these functions are also defined:
> 
> -	struct gpio_desc *devm_gpiod_get(struct device *dev, const char *con_id)
> +	struct gpio_desc *devm_gpiod_get(struct device *dev, const char *con_id,
> +					 enum gpio_flags flags)
> 
>  	struct gpio_desc *devm_gpiod_get_index(struct device *dev,
>  					       const char *con_id,
> -					       unsigned int idx)
> +					       unsigned int idx,
> +					       enum gpio_flags flags)
> 
>  devm_gpiod_get_optional() and devm_gpiod_get_index_optional() exist as
> well.
> 
> @@ -72,8 +85,9 @@ Using GPIOs
> 
>  Setting Direction
>  -----------------
> -The first thing a driver must do with a GPIO is setting its direction. This
> is -done by invoking one of the gpiod_direction_*() functions:
> +The first thing a driver must do with a GPIO is setting its direction. If
> no +direction-setting flags as been given to one of the gpiod_get*()
> functions, this +is done by invoking one of the gpiod_direction_*()
> functions:
> 
>  	int gpiod_direction_input(struct gpio_desc *desc)
>  	int gpiod_direction_output(struct gpio_desc *desc, int value)

-- 
Regards,

Laurent Pinchart
