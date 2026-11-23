Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441309;
	b=ATFdZUgT4akaXB/8JYWDCLltqCU3VTSo49nId1I98/k3c5Vpet7VXy+2JzOsoLpXsLap
	 hTFjVcBCVstghSzQET3mISZrzUXNnSfI9luQY+cAVWjisv4GZaJUseU6Hqw1uer2ArS1O
	 bjB1rKIaezi+CAPeQpAR8YwbOQrt4Uj4cJp0SQGdWWUDjRyTImUzLfTYaUEf4ia785SpY
	 Xh3FkV5r2Uemwe/u7p9kJ4XZb0hFWcsImzECdYYOLUgpQrKn9VqfMvKff3sRVG6XPKJzR
	 dJ0vtLS83BNADA0FbHJsFMl+WOYNchOUGD71eB9UA1kEIPMhr4dGyoGxvO5T/Ey5qAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441309;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OfUQG0hIlRCU2lWDqx8AQM7i0FOxlUbopxLtGav1S8I=;
	b=QF94kiDBtwhdWQLSgSL7tM6MtzAAj53Q0kktiD/yW2a4XjqkdoTi3adwfa5vjuKZXz2C
	 dfD9pNIYpaaE31zUxD87ZGzV48TTutWt0EEXiFZYn+F8BElahh7D3U3n4xu4FWG76CzC7
	 DiRq7CKyFZdWcG3GUNWM0Yvj5l5bFXiXI1OQdsisFxh7Byg2kiRVrmvH6pFXwpDWQ4kf2
	 47hzNJw36QzhEhXxNm1USzVmIfrubJuFXA9Ac5M1HFFweZJz66ZLYX2b3pECC4wATtC2e
	 QNM2YSMqes3H5H3E4LjXLX0VPh4jAVpxBWJrstKDX58nFSzb2LhH8/V/MFsEyp7NhdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ph0NGALv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9E4EB606B53B;
	Mon, 23 Nov 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ph0NGALv
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6F91C1F000D3;
	Mon, 23 Nov 2026 13:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795441309;
	bh=OfUQG0hIlRCU2lWDqx8AQM7i0FOxlUbopxLtGav1S8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ph0NGALvgJ6621gLVBUDxpyOtR116nbgvX0Xz+SeVGMmN1mSDrPPpPOqxov/QpsOm
	 5dzSMOVvNtZkEWuhmlNi/oEqaavEHtHc7n0aJDHdESU5SgbtP6Fx2benaJ9YeWvUUH
	 lm1zomPR7U6eJhzvjGS+m//YQtH+lU7uVAETCFwuczLPZMZF9G5lNSiS1xLnscDeW4
	 AvlF1blkqjClLo06CrxhCkkb25CmgU5neVR1wv/vkeq7YAiT2oWrvZGD4q/jSKMMRr
	 uHgRlSYYigdYK2Dh+2qwuGi3NXMbk6D9wbaqOSBGWpqeUAtqVwtg/G0yYHo30HObQT
	 we9Cku3bTx1UA==
Date: Mon, 23 Nov 2026 14:41:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Joshua Crofts <crofts@kernel.org>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Message-ID: <awQ9oGse6orrsCDj@monoceros>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261119112437.197306-2-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="piy3wfen7flpu6zb"
Content-Disposition: inline
In-Reply-To: <20261119112437.197306-2-Nicolae-daniel.Deaconescu@analog.com>


--piy3wfen7flpu6zb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
MIME-Version: 1.0

On Thu, Nov 19, 2026 at 01:24:15PM +0200, Nicolae-Daniel Deaconescu wrote:
> A consumer that must meet minimum times, or place an edge relative to the
> cycles of a clock a PWM gates, can't do that with the waveform API alone:
> rounding goes down, and the margin a minimum needs is the PWM step, known
> only to the provider.
>=20
> Let the provider report the rate of the clock its timing derives from and
> the clock cycles per step. A consumer then works in whole steps and rounds
> up when converting to nanoseconds, instead of reading the rate from a clo=
ck
> it gets on its own, which breaks if the PWM divides its clock.
>=20
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analo=
g.com>
> ---
>  drivers/pwm/core.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pwm.h | 34 ++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 2a050ff4608b..a63b8f65a43d 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/pwm.h>
>  #include <linux/list.h>
> +#include <linux/math64.h>
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> @@ -325,6 +326,68 @@ int pwm_get_waveform_might_sleep(struct pwm_device *=
pwm, struct pwm_waveform *wf
>  }
>  EXPORT_SYMBOL_GPL(pwm_get_waveform_might_sleep);
> =20
> +/**
> + * pwm_get_waveform_step_might_sleep - Query the granularity of the wave=
forms
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @step: output parameter
> + *
> + * Stores in @step the clock rate the timing of @pwm is derived from and=
 how
> + * many cycles of that clock one step lasts. Period, duty length and duty
> + * offset are multiples of that step, so a waveform that is asked for in=
 whole
> + * steps, and is within the range of the hardware, is not changed by rou=
nding.
> + * Compute the length of n steps in nanoseconds as
> + * n * @step->clk_cycles_per_step * NSEC_PER_SEC / @step->clk_rate_Hz an=
d round
> + * it up, because pwm_round_waveform_might_sleep() and
> + * pwm_set_waveform_might_sleep() round down. The product can exceed 64 =
bits, so
> + * compute it with mul_u64_u64_div_u64_roundup().
> + *
> + * The values can change when a clock changes its rate, so they are only=
 valid
> + * as long as the provider's input clocks are not reconfigured.

That function seems to be conceptually bogous. Some drivers change their
input clock when configuring a given setting. Also not all hardware
implementations have such a step value (see e.g. the tegra driver. There
the duty can be configured to i/256 * period (for i in 0..256), so the
step value for duty differs from the step value for period).

> + *
> + * Context: May sleep.
> + * Returns: 0 on success, -EOPNOTSUPP if the provider doesn't report it =
or a
> + * negative errno.
> + */
> +int pwm_get_waveform_step_might_sleep(struct pwm_device *pwm,
> +				      struct pwm_waveform_step *step)
> +{
> +	struct pwm_chip *chip =3D pwm->chip;
> +	const struct pwm_ops *ops =3D chip->ops;
> +	int ret;
> +
> +	might_sleep();
> +
> +	if (!pwmchip_supports_waveform(chip) || !ops->get_waveform_step)
> +		return -EOPNOTSUPP;
> +
> +	guard(pwmchip)(chip);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
> +		/*
> +		 * Catch any drivers that have been marked as atomic but
> +		 * that will sleep anyway.
> +		 */
> +		non_block_start();
> +		ret =3D ops->get_waveform_step(chip, pwm, step);
> +		non_block_end();
> +	} else {
> +		ret =3D ops->get_waveform_step(chip, pwm, step);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	if (!step->clk_rate_Hz ||
> +	    step->clk_rate_Hz > mul_u32_u32(step->clk_cycles_per_step, NSEC_PER=
_SEC))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pwm_get_waveform_step_might_sleep);
> +
>  /* Called with the pwmchip lock held */
>  static int __pwm_set_waveform(struct pwm_device *pwm,
>  			      const struct pwm_waveform *wf,
> @@ -1710,6 +1773,12 @@ static bool pwm_ops_check(const struct pwm_chip *c=
hip)
>  		if (!ops->apply)
>  			return false;
> =20
> +		if (ops->get_waveform_step) {
> +			dev_warn(pwmchip_parent(chip),
> +				 ".get_waveform_step() needs .write_waveform()\n");
> +			return false;
> +		}
> +
>  		if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
>  			dev_warn(pwmchip_parent(chip),
>  				 "Please implement the .get_state() callback\n");
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b11ae91723f8..c52f4c9153c2 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -76,6 +76,34 @@ struct pwm_waveform {
>  	u64 duty_offset_ns;
>  };
> =20
> +/**
> + * struct pwm_waveform_step - granularity of the waveforms a PWM can gen=
erate
> + * @clk_rate_Hz: rate of the clock the PWM's timing is derived from
> + * @clk_cycles_per_step: number of those clock cycles one step lasts
> + *
> + * The period, the duty length and the duty offset of a waveform are mul=
tiples
> + * of one step, which lasts @clk_cycles_per_step / @clk_rate_Hz seconds.=
 A PWM
> + * that divides its input clock in hardware has @clk_cycles_per_step > 1=
=2E A
> + * waveform that is asked for in whole steps, and is within the range of=
 the
> + * hardware, is not changed by rounding.
> + *
> + * The step is the same for every waveform and for the period, the duty =
length
> + * and the duty offset, so a provider whose granularity depends on the
> + * requested period (for example through a prescaler) can't describe its=
elf
> + * with it. One step also has to last at least 1 ns, otherwise rounding a
> + * length in nanoseconds up can add a whole step.
> + *
> + * A consumer that needs a minimum time, or that has to place an edge re=
lative
> + * to the cycles of the clock a PWM channel gates, can use this to ask f=
or
> + * the next possible value instead of one that is rounded down, and to c=
ompute
> + * the frequency a rounded period results in without the error of the
> + * nanosecond resolution of struct pwm_waveform.
> + */
> +struct pwm_waveform_step {
> +	unsigned long clk_rate_Hz;
> +	unsigned int clk_cycles_per_step;
> +};
> +
>  /*
>   * struct pwm_state - state of a PWM channel
>   * @period: PWM period (in nanoseconds)
> @@ -287,6 +315,9 @@ struct pwm_capture {
>   * @round_waveform_fromhw: convert a driver specific waveform presentati=
on to struct pwm_waveform
>   * @read_waveform: read driver specific waveform presentation from hardw=
are
>   * @write_waveform: write driver specific waveform presentation to hardw=
are
> + * @get_waveform_step: optional, report the granularity of the waveforms=
=2E Called
> + *	with the chip locked, so it must not sleep on an atomic chip and shou=
ld
> + *	report a cached clock rate instead of calling clk_get_rate()

The part about clk_get_rate() is an implementation detail that doesn't
need to be mentioned after "must not sleep" was stated.

>   * @apply: atomically apply a new PWM config
>   * @get_state: get the current PWM state.
>   */
> @@ -305,6 +336,8 @@ struct pwm_ops {
>  			    void *wfhw);
>  	int (*write_waveform)(struct pwm_chip *chip, struct pwm_device *pwm,
>  			      const void *wfhw);
> +	int (*get_waveform_step)(struct pwm_chip *chip, struct pwm_device *pwm,
> +				 struct pwm_waveform_step *step);
> =20
>  	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
>  		     const struct pwm_state *state);
> @@ -394,6 +427,7 @@ static inline void pwmchip_set_drvdata(struct pwm_chi=
p *chip, void *data)
>  /* PWM consumer APIs */
>  int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_wa=
veform *wf);
>  int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_wave=
form *wf);
> +int pwm_get_waveform_step_might_sleep(struct pwm_device *pwm, struct pwm=
_waveform_step *step);
>  int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct pw=
m_waveform *wf, bool exact);
>  int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state);
>  int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *sta=
te);

I didn't understand what you want to achieve with this function. For
some PWMs it might help to select a configuration matching your needs.
"some" and "might" in the previous sentence are bad, so you need to fall
back to the already existing rounding functions to make your driver
generic. And then please use the existing functions already now. (That
doesn't mean I oppose extending the pwm core for that, new helpers are
fine iff they work independant of the underlying hardware.)

For example the already existing callbacks allow to compute for a given
period P and duty_cycle D the next bigger implementable duty cycle value
D' such that configuring D' and P yields a duty_cycle bigger than D.

Best regards
Uwe

--piy3wfen7flpu6zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEQpcACgkQj4D7WH0S
/k5n/wf/Z4nW6w8kpUfDZfFpHvhb3vn+jXJ4YZImAJhcfFLWVyhnttqXVirhK5zp
JfWhz7f5pqU1uQcoDGWoBnNQ22WY5ZKqg07nDqBoWrUvSscV+LFZdmbIRmwGlJT3
dUPkx4EF38FGdIvIlgolVwalmtbagh0SyPMWp+jM7ACf9gCjzA2+Ndt72SqzQ1ft
iSOoepiQengajmqlz8mxFgZFi/YyX6L/lrc0S2/ZeZA05G5sYcdoJK/nahb369F9
6pZ0fd5KdYSbyq3tgdIB5Xi7WELZctT8OPWGD0kZ1bEZo17hvUlrHyoUB0idWY0D
hC4OE3FZIuC1n4ErtVypFEmgdk75oQ==
=NSy7
-----END PGP SIGNATURE-----

--piy3wfen7flpu6zb--
