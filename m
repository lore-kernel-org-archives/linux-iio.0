Return-Path: <SRS0=3sSe=C3=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, "thierry.reding\@gmail.com" <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-gpio@vger.kernel.org
Subject: Re: [RFC] Periodic Output, Timestamped Input
In-Reply-To: <CACRpkdY+72nz9gK=kSESoNdM+xicx-rnpKNz-UbYZ+TFLUXpbA@mail.gmail.com>
References: <87ineapo5w.fsf@linux.intel.com> <CACRpkdY+72nz9gK=kSESoNdM+xicx-rnpKNz-UbYZ+TFLUXpbA@mail.gmail.com>
Date: Wed, 29 Nov 2017 15:56:00 +0200
Message-ID: <87shcxw5n3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Linus Walleij <linus.walleij@linaro.org> writes:
> Hi Felipe,
>
> this is nice and interesting technology!
>
> I am quoting the whole mail over to linux-pwm and Thierry
> as well as  linux-iio and Jon Cameron for consideration. My comments
> at the end.
>
> On Thu, Nov 16, 2017 at 10:29 AM, Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
>>
>> Hi Linus,
>>
>> Before I put a lot of code down, I wanted to get a feeling from you as
>> to how you'd like two new features to be implemented.
>>
>> In a future platform we may have two new features in our GPIO
>> controller which allows for periodic assertion of GPIO Output
>> (controlled by HW, we just program the interval) and Timestamping of
>> GPIO Input events.
>>
>> I was thinking that we could use pin config for that. Something along
>> the lines of:
>>
>> @@ -700,6 +700,12 @@ static int intel_config_set_debounce(struct intel_p=
inctrl *pctrl, unsigned pin,
>>         return ret;
>>  }
>>
>> +static int intel_config_set_output_periodic(struct intel_pinctrl *pctrl,
>> +                                           unsigned pin, unsigned perio=
d_ms)
>> +{
>> +       return 0;
>> +}
>> +
>>  static int intel_config_set(struct pinctrl_dev *pctldev, unsigned pin,
>>                           unsigned long *configs, unsigned nconfigs)
>>  {
>> @@ -726,6 +732,13 @@ static int intel_config_set(struct pinctrl_dev *pct=
ldev, unsigned pin,
>>                                 return ret;
>>                         break;
>>
>> +               case PIN_CONFIG_OUTPUT_PERIODIC:
>> +                       ret =3D intel_config_set_output_periodic(pctrl, =
pin,
>> +                               pinconf_to_config_argument(configs[i]));
>> +                       if (ret)
>> +                               return ret;
>> +                       break;
>> +
>>                 default:
>>                         return -ENOTSUPP;
>>                 }
>> modified   include/linux/pinctrl/pinconf-generic.h
>> @@ -90,6 +90,9 @@
>>   * @PIN_CONFIG_SLEW_RATE: if the pin can select slew rate, the argument=
 to
>>   *     this parameter (on a custom format) tells the driver which alter=
native
>>   *     slew rate to use.
>> + * @PIN_CONFIG_OUTPUT_PERIODIC: this will configure the pin as an
>> + *     output periodic toggle. The argument is period in
>> + *     microseconds.
>>   * @PIN_CONFIG_END: this is the last enumerator for pin configurations,=
 if
>>   *     you need to pass in custom configurations to the pin controller,=
 use
>>   *     PIN_CONFIG_END+1 as the base offset.
>> @@ -117,6 +120,7 @@ enum pin_config_param {
>>         PIN_CONFIG_POWER_SOURCE,
>>         PIN_CONFIG_SLEEP_HARDWARE_STATE,
>>         PIN_CONFIG_SLEW_RATE,
>> +       PIN_CONFIG_OUTPUT_PERIODIC,
>>         PIN_CONFIG_END =3D 0x7F,
>>         PIN_CONFIG_MAX =3D 0xFF,
>>  };
>>
>> As for timestamp of input, we would likely request the input as an IRQ
>> and use the IRQ to read whatever register, wherever it may be.
>>
>> Do you have any comments about this? Should I go ahead with current
>> assumptions?
>
> So the first thing: periodic assetion of a GPIO, sounds awfully lot
> like PWM does it not? I guess the output is a square wave?

Well, possibly. But that's not the idea of the feature. The idea is to
synchronize time. Say you program GPIO to fire at every 1 ms, a remote
processor/accelerator/etc can synchronize its own time to this 1 ms
tick.

That's at least my understanding.

> While it is possible to model things like this as pin config, have you
> considered just adding a PWM interface and present it to the kernel
> as a PWM (possibly with a separate resource, in DT we use &phandle
> but in ACPI I guess you Intel people have something else for PWM)?
> If need be we can ask the ACPI people.

Sure, however the same feature is also used for timestampped input :-)

Say another processor is the one asserting a GPIO every 1 ms. I can
sample it as quickly as possible, but we're bound to face SW
overhead. When the timestamp is latched, then the overhead can be
accounted for.

> For the other thing: timestamping of GPIO events, we already
> support timestamps for userspace GPIOs, but all it does is use
> the kernel time, see gpiolib.c:
>
> static irqreturn_t lineevent_irq_thread(int irq, void *p)
> {
>         struct lineevent_state *le =3D p;
>         struct gpioevent_data ge;
>         int ret, level;
>
>         ge.timestamp =3D ktime_get_real_ns();
>         level =3D gpiod_get_value_cansleep(le->desc);

this is running as a thread with interrupts enabled, AFAICT. This means
this thread can be preempted at least on PREEMPT_RT kernels, so your
timestamp can be wrong, right?

>         if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE
>             && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
>                 if (level)
>                         /* Emit low-to-high event */
>                         ge.id =3D GPIOEVENT_EVENT_RISING_EDGE;
>                 else
>                         /* Emit high-to-low event */
>                         ge.id =3D GPIOEVENT_EVENT_FALLING_EDGE;
>         } else if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE && level) {
>                 /* Emit low-to-high event */
>                 ge.id =3D GPIOEVENT_EVENT_RISING_EDGE;
>         } else if (le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE && !level)=
 {
>                 /* Emit high-to-low event */
>                 ge.id =3D GPIOEVENT_EVENT_FALLING_EDGE;
>         } else {
>                 return IRQ_NONE;
>         }
>
>         ret =3D kfifo_put(&le->events, ge);
>         if (ret !=3D 0)
>                 wake_up_poll(&le->wait, POLLIN);
>
>         return IRQ_HANDLED;
> }
>
> IIO already has a variety of timestamps to use, see
> drivers/iio/industrialio-event.c.
>
> What is on my TODO is to unify GPIO event timestamping with that
> of IIO.
>
> If there is further a *hardware* timestamp, that would be yet another

yes, it's done by a high resolution timer

> alternative timestamp, so we should first extend to use the different
> timestamps supported by IIO and then add "hardware-native"
> timestamping to the mix IMO. Unless there are other ideas.
>
> Lars-Peter Clausen may have a better idea of what to do here, he
> has run a few complex use cases like GNUradio (IIRC) using
> timestamping. Also I think sensorfusion-type scenarios use these
> timestamps quite a lot.

I see... I wonder if the SW timestamping is suffcient here. Has anybody
done any sort of jitter analysis with heavy loaded CPU for this feature?

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAloevHAACgkQzL64meEa
mQbSRQ//efQMXt7b+kqgs5w3uR+O+gtBm8YNf7+Splp4/pqK7Y+GvQkQyh6TrR2x
DBkCKAShnn2P0T+rOYr+7+Q/ULFneFfYle8ou+KIjZ3uieTQY9XZwOYGum6SdkkC
r6qOtACUrwL20KZrkqLjmBpDxrrwV5LlGDJm0Sw+umMRyrOIkMYjBwsoRdEMUVgG
r+VnsMR+NDus7ddx0ecuraNgsf4AjjD2ZxLCeQwtOnGz33xA0YmB7+0ioyXSmTqH
mLBRxrfNtGfK4/yIG99WsRNehctdq+wPdlA8co5x3F2w8OdmWa3SjcgT4pmGR0ms
L589zRsN65CkCiGpTLgJ9f3V6TW/ehclxS/ZN8POb4e0tN75fzuxrBGnIhEE9zBs
4Nq9jXydzv0Y5tzXKGCcvlsLTKKp1S9SrJ8yb6xf4EdP6XY1uXPRy3T1t1P8UowA
hn5firVrqMee+RUikdEZ/RGoHhKfyFZmELGkGsimaEs4611fBa4R5rjJ4GU0+C8f
ULnm5ndDzoEUKkyQKFxJZpZ8orvcETKa/lSD3dWGIJyjXWEa0ATCVPGKq6aKLDId
UqCYF2jH0C01KbPazVdx+daTIguAr2wPPAFbS0jfKbGGCyK0nAq/r18jdXjJSmZy
TkBXwUETiTlrFHNvXvuQtjnAUcUZgo4tSKd26t32cFftqIHtWZM=
=9lZG
-----END PGP SIGNATURE-----
--=-=-=--
