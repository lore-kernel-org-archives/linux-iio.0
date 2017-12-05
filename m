Return-Path: <SRS0=eyJT=DB=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz =?utf-8?Q?Go=C5=82as?=
 =?utf-8?Q?zewski?= <bartekgola@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, "thierry.reding\@gmail.com" <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, linux-gpio@vger.kernel.org
Subject: Re: [RFC] Periodic Output, Timestamped Input
In-Reply-To: <CACRpkdabNMHgs_ywzrgSg-AgQL1wtQN8SaxuZtCruiXnfrXGQw@mail.gmail.com>
References: <87ineapo5w.fsf@linux.intel.com> <CACRpkdY+72nz9gK=kSESoNdM+xicx-rnpKNz-UbYZ+TFLUXpbA@mail.gmail.com> <87shcxw5n3.fsf@linux.intel.com> <CACRpkdabNMHgs_ywzrgSg-AgQL1wtQN8SaxuZtCruiXnfrXGQw@mail.gmail.com>
Date: Tue, 05 Dec 2017 11:20:59 +0200
Message-ID: <87609ltts4.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Linus Walleij <linus.walleij@linaro.org> writes:
> On Wed, Nov 29, 2017 at 2:56 PM, Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
>> Me:
>>> For the other thing: timestamping of GPIO events, we already
>>> support timestamps for userspace GPIOs, but all it does is use
>>> the kernel time, see gpiolib.c:
>>>
>>> static irqreturn_t lineevent_irq_thread(int irq, void *p)
>>> {
>>>         struct lineevent_state *le =3D p;
>>>         struct gpioevent_data ge;
>>>         int ret, level;
>>>
>>>         ge.timestamp =3D ktime_get_real_ns();
>>>         level =3D gpiod_get_value_cansleep(le->desc);
>>
>> this is running as a thread with interrupts enabled, AFAICT. This means
>> this thread can be preempted at least on PREEMPT_RT kernels, so your
>> timestamp can be wrong, right?
>
> Yes, it can be off. What we should do to get i better is
> something like what I did in:
> drivers/iio/gyro/mpu3050-core.c
>
> Here I have both a hard and a soft IRQ handler (fast/slow if
> you like) and take the timestamp in the hard IRQ, then use
> it in the thread.
>
> This should be done identically in gpiolib to increase precision
> in the general case.
>
> I was thinking about it already when implementing it but it fell
> out of my mind. I'm putting in on my TODO. (CC to bartosz
> who might be interested, he's using these ABIs quite a bit.)

fair enough. In that case, it'll probably be easier to implement
HW-based timestamping with something like below:

modified   drivers/gpio/gpiolib.c
@@ -731,7 +731,11 @@ static irqreturn_t lineevent_irq_thread(int irq, void =
*p)
 	struct gpioevent_data ge;
 	int ret, level;
=20
=2D	ge.timestamp =3D ktime_get_real_ns();
+	if (le->desc->flags & FLAG_HAS_HW_TIMESTAMP)
+		ge.timestamp =3D gpio_get_hw_timestamp(le->desc);
+	else
+		ge.timestamp =3D ktime_get_real_ns();
+
 	level =3D gpiod_get_value_cansleep(le->desc);
=20
 	if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE
modified   drivers/gpio/gpiolib.h
@@ -206,6 +206,7 @@ struct gpio_desc {
 #define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
 #define FLAG_IS_HOGGED	11	/* GPIO is hogged */
 #define FLAG_SLEEP_MAY_LOSE_VALUE 12	/* GPIO may lose value in sleep */
+#define FLAG_HAS_HW_TIMESTAMP 13 /* GPIO has HW-based timestamping */
=20
 	/* Connection label */
 	const char		*label;

We may even extract ktime_get_real_ns() to gpio_get_timestamp() and do
the branching in that function, like:

modified   drivers/gpio/gpiolib.c
@@ -731,7 +731,7 @@ static irqreturn_t lineevent_irq_thread(int irq, void *=
p)
 	struct gpioevent_data ge;
 	int ret, level;
=20
=2D	ge.timestamp =3D ktime_get_real_ns();
+	ge.timestamp =3D gpiod_get_timestamp(le->desc);
 	level =3D gpiod_get_value_cansleep(le->desc);
=20
 	if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE
@@ -3155,6 +3155,14 @@ int gpiod_get_value_cansleep(const struct gpio_desc =
*desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
=20
+u64 gpiod_get_timestamp(const struct gpio_desc *desc)
+{
+	if (desc->flags & FLAG_HAS_HW_TIMESTAMP)
+		return gpiod_get_raw_timestamp(desc);
+	else
+		return ktime_get_real_ns();
+}
+
 /**
  * gpiod_get_raw_array_value_cansleep() - read raw values from an array of=
 GPIOs
  * @array_size: number of elements in the descriptor / value arrays
modified   drivers/gpio/gpiolib.h
@@ -206,6 +206,7 @@ struct gpio_desc {
 #define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
 #define FLAG_IS_HOGGED	11	/* GPIO is hogged */
 #define FLAG_SLEEP_MAY_LOSE_VALUE 12	/* GPIO may lose value in sleep */
+#define FLAG_HAS_HW_TIMESTAMP 13 /* GPIO has HW-based timestamping */
=20
 	/* Connection label */
 	const char		*label;

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlomZPsACgkQzL64meEa
mQZR8hAAhXWq/g+B9J8Exm+vSrodbhsQA83tlB+PAGNOHicWlIsGoCO86DD0ofiZ
5RzJTdMcyEnwXPuP9/UXfQkzV6DxsBDYcDf6cwTM1T8fdTcQdldm/P36XS+ODKgt
wBhsMAvvhbqswi+Kr/zONrZsEYirhYaIhA39Ur5FpkbpEOko3OyBTISWIjEUheN9
wRkqw7siKJatt5g54zfG/lmkP+B7CpJWxmpBNzG/O3EWXqCsGwqyYg8AMvoyn9eH
PR3+yS1mK+4BV5B4rZpmXOQLaUIq1DW33ANthqwqzA79xcwE3oVeVceK8f2aOXVz
GkhH++fLUzq2ayDyU3ThMXIHWC4X7O56FyrWcDBZSkjwKr0ZI4DhDWITQrjxkbim
z08bWS+kVBiV3NTbhVJoaGl+PiSdOOTcXzM3zkXZYVXBd7hh9U87Sy5dB3Xjw8i2
aNYEsJbDKi4KQtc5qfaufvOnYLNISLlH6cuyRkVoQCHMjROyRu/TrKah46pmKURn
jl8CijmacQRgixCs9+bCfkMwK1OzeYgBVvVr3aTMnpw+3CTL05A9rRcZ24yja0MO
gQpx0WaaeLLxTa7XjKxz/SRcjZmQaNH98xp/g2kEakOGhY7HEHt4O9NQYdugERCw
5XWMLt/lFyMtXJEUzGi/al30muMp604sCuJZ0b2XNlCgPD/wHOY=
=Lpak
-----END PGP SIGNATURE-----
--=-=-=--
