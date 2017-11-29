Return-Path: <SRS0=0yTT=C3=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87ineapo5w.fsf@linux.intel.com>
References: <87ineapo5w.fsf@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Nov 2017 14:31:26 +0100
Message-ID: <CACRpkdY+72nz9gK=kSESoNdM+xicx-rnpKNz-UbYZ+TFLUXpbA@mail.gmail.com>
Subject: Re: [RFC] Periodic Output, Timestamped Input
To: Felipe Balbi <felipe.balbi@linux.intel.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Felipe,

this is nice and interesting technology!

I am quoting the whole mail over to linux-pwm and Thierry
as well as  linux-iio and Jon Cameron for consideration. My comments
at the end.

On Thu, Nov 16, 2017 at 10:29 AM, Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
>
> Hi Linus,
>
> Before I put a lot of code down, I wanted to get a feeling from you as
> to how you'd like two new features to be implemented.
>
> In a future platform we may have two new features in our GPIO
> controller which allows for periodic assertion of GPIO Output
> (controlled by HW, we just program the interval) and Timestamping of
> GPIO Input events.
>
> I was thinking that we could use pin config for that. Something along
> the lines of:
>
> @@ -700,6 +700,12 @@ static int intel_config_set_debounce(struct intel_pinctrl *pctrl, unsigned pin,
>         return ret;
>  }
>
> +static int intel_config_set_output_periodic(struct intel_pinctrl *pctrl,
> +                                           unsigned pin, unsigned period_ms)
> +{
> +       return 0;
> +}
> +
>  static int intel_config_set(struct pinctrl_dev *pctldev, unsigned pin,
>                           unsigned long *configs, unsigned nconfigs)
>  {
> @@ -726,6 +732,13 @@ static int intel_config_set(struct pinctrl_dev *pctldev, unsigned pin,
>                                 return ret;
>                         break;
>
> +               case PIN_CONFIG_OUTPUT_PERIODIC:
> +                       ret = intel_config_set_output_periodic(pctrl, pin,
> +                               pinconf_to_config_argument(configs[i]));
> +                       if (ret)
> +                               return ret;
> +                       break;
> +
>                 default:
>                         return -ENOTSUPP;
>                 }
> modified   include/linux/pinctrl/pinconf-generic.h
> @@ -90,6 +90,9 @@
>   * @PIN_CONFIG_SLEW_RATE: if the pin can select slew rate, the argument to
>   *     this parameter (on a custom format) tells the driver which alternative
>   *     slew rate to use.
> + * @PIN_CONFIG_OUTPUT_PERIODIC: this will configure the pin as an
> + *     output periodic toggle. The argument is period in
> + *     microseconds.
>   * @PIN_CONFIG_END: this is the last enumerator for pin configurations, if
>   *     you need to pass in custom configurations to the pin controller, use
>   *     PIN_CONFIG_END+1 as the base offset.
> @@ -117,6 +120,7 @@ enum pin_config_param {
>         PIN_CONFIG_POWER_SOURCE,
>         PIN_CONFIG_SLEEP_HARDWARE_STATE,
>         PIN_CONFIG_SLEW_RATE,
> +       PIN_CONFIG_OUTPUT_PERIODIC,
>         PIN_CONFIG_END = 0x7F,
>         PIN_CONFIG_MAX = 0xFF,
>  };
>
> As for timestamp of input, we would likely request the input as an IRQ
> and use the IRQ to read whatever register, wherever it may be.
>
> Do you have any comments about this? Should I go ahead with current
> assumptions?

So the first thing: periodic assetion of a GPIO, sounds awfully lot
like PWM does it not? I guess the output is a square wave?

While it is possible to model things like this as pin config, have you
considered just adding a PWM interface and present it to the kernel
as a PWM (possibly with a separate resource, in DT we use &phandle
but in ACPI I guess you Intel people have something else for PWM)?
If need be we can ask the ACPI people.

For the other thing: timestamping of GPIO events, we already
support timestamps for userspace GPIOs, but all it does is use
the kernel time, see gpiolib.c:

static irqreturn_t lineevent_irq_thread(int irq, void *p)
{
        struct lineevent_state *le = p;
        struct gpioevent_data ge;
        int ret, level;

        ge.timestamp = ktime_get_real_ns();
        level = gpiod_get_value_cansleep(le->desc);

        if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE
            && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
                if (level)
                        /* Emit low-to-high event */
                        ge.id = GPIOEVENT_EVENT_RISING_EDGE;
                else
                        /* Emit high-to-low event */
                        ge.id = GPIOEVENT_EVENT_FALLING_EDGE;
        } else if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE && level) {
                /* Emit low-to-high event */
                ge.id = GPIOEVENT_EVENT_RISING_EDGE;
        } else if (le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE && !level) {
                /* Emit high-to-low event */
                ge.id = GPIOEVENT_EVENT_FALLING_EDGE;
        } else {
                return IRQ_NONE;
        }

        ret = kfifo_put(&le->events, ge);
        if (ret != 0)
                wake_up_poll(&le->wait, POLLIN);

        return IRQ_HANDLED;
}

IIO already has a variety of timestamps to use, see
drivers/iio/industrialio-event.c.

What is on my TODO is to unify GPIO event timestamping with that
of IIO.

If there is further a *hardware* timestamp, that would be yet another
alternative timestamp, so we should first extend to use the different
timestamps supported by IIO and then add "hardware-native"
timestamping to the mix IMO. Unless there are other ideas.

Lars-Peter Clausen may have a better idea of what to do here, he
has run a few complex use cases like GNUradio (IIRC) using
timestamping. Also I think sensorfusion-type scenarios use these
timestamps quite a lot.

Yours,
Linus Walleij
