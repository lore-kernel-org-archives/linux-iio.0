Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304146;
	b=pmpY3rd4Nb4yYUeKYH3u3vEBxPPT6wscBvwCAEfa7w8fIfBJrfQ4/Fdav03D0PUuF/VA
	 gMkborM28q1RS3/7z4U+Vwd1vndeB1rhb9b91InNF4aSwLTIjMVDpsb3NU++htR9Lh+aa
	 F2wKy0T6m93xk2ygadlsXLA//C/lhEhznewtxBhs5ZDKnkCUpMVLIV/RCwh10yoOey0Am
	 3akfMC8VBMt9n8QvzScItpsB6xHtaYq86LBx02c5q0mvfnMDs/PEazTMPNke8m5QqNPeY
	 wIc+MWcr3XHcqVpFamOZ24a8r1azqbtQj7sCZPCxdfmDOtNxjWiXY0t3AS3+Po+XurA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304146;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ygid2aXBVv/PMHiBZSaeXvMNpwKQR0Q1uS6msPaF4GI=;
	b=KEC9Gj3eEKOX+juCULM4egHk+M06txEfGWCc9ujS/uq4R+ssAlks5Qc7bfPd1JSo9NQ9
	 BvScs3157K/TGAm+QRYxncYQBTlfOvB8Ug0gdZObK+SBgTl+4EfjIAbarZcmDOW2EhwDE
	 4HIEvZ9CuTHSUJ+gnRbeXQLP5odO/QV9Xnb43nls02PUJVu3F9/1y2ENPECtqwjgtN9qX
	 Q1QViL1wQTAQ6qZ+ioVkuqX+q4FcPeHPjlGeo17vJnN4cICMJpvTywqJc30btF2geovP+
	 6xL6ZGB6DLtudbVPCOp3eYrMNjLAnK77JoPryO65mrjUvd1kWuDRbn5OS01oSR/WBnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3dJr6vW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7016606A32A;
	Sat, 21 Nov 2026 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3dJr6vW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269951F000C4;
	Sat, 21 Nov 2026 23:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795304146;
	bh=Ygid2aXBVv/PMHiBZSaeXvMNpwKQR0Q1uS6msPaF4GI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k3dJr6vWy83ZksuGhx0k5kyiY5KWrWBqYvdZucHmojpaK+7ztYizKzqIpJ2SKU45u
	 LsWt2v3OOFfYCZrce1+ZCaLPrBlaEJl/uopWQQvfYxeAfSElnS7mxBwEMCwbDQK0Ua
	 e1OGa+kh4KBVkAWoj2jvydlDyowt2Oxcr51axNi3KAoNMnyI19cT+vcpsaBYKGZ72a
	 7lMLXmdg1sr0hogCFo/fes0XYI9R5S8RGJJnvut14q9eT8oUIKB32mYWOensaXUuGu
	 EH9oU1m2vveJatslqhs1fsb2Ae49RymjJsIuu8RntwwuH+MGqeutFpEsb+eNcYnQEk
	 Ha0aj/CvxV0zA==
Date: Sat, 21 Nov 2026 23:35:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Joshua Crofts <crofts@kernel.org>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] pwm: core: add
 pwm_get_waveform_step_might_sleep()
Message-ID: <20261121233543.55426e1e@jic23-hlaptop>
In-Reply-To: <20261119112437.197306-2-Nicolae-daniel.Deaconescu@analog.com>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261119112437.197306-2-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 13:24:15 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> A consumer that must meet minimum times, or place an edge relative to the
> cycles of a clock a PWM gates, can't do that with the waveform API alone:
> rounding goes down, and the margin a minimum needs is the PWM step, known
> only to the provider.
> 
> Let the provider report the rate of the clock its timing derives from and
> the clock cycles per step. A consumer then works in whole steps and rounds
> up when converting to nanoseconds, instead of reading the rate from a clock
> it gets on its own, which breaks if the PWM divides its clock.
> 
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> ---
>  drivers/pwm/core.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pwm.h | 34 ++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
> 
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
> @@ -325,6 +326,68 @@ int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf
>  }
>  EXPORT_SYMBOL_GPL(pwm_get_waveform_might_sleep);
>  
> +/**
> + * pwm_get_waveform_step_might_sleep - Query the granularity of the waveforms
> + * Cannot be used in atomic context.

Odd to have that second bit here in the kernel-doc. Particularly as you have
a Context entry below saying the same thing below and a name of _might_sleep.

> + * @pwm: PWM device
> + * @step: output parameter
> + *
> + * Stores in @step the clock rate the timing of @pwm is derived from and how
> + * many cycles of that clock one step lasts. Period, duty length and duty

Can this be a cross reference to the docs in for the structure?
Nice to not duplicate stuff where possible.

> + * offset are multiples of that step, so a waveform that is asked for in whole
> + * steps, and is within the range of the hardware, is not changed by rounding.
> + * Compute the length of n steps in nanoseconds as
> + * n * @step->clk_cycles_per_step * NSEC_PER_SEC / @step->clk_rate_Hz and round

I'd tweak the wrap to just have the formula on a line on its own.

> + * it up, because pwm_round_waveform_might_sleep() and
> + * pwm_set_waveform_might_sleep() round down. The product can exceed 64 bits, so
> + * compute it with mul_u64_u64_div_u64_roundup().

I don't understand this. I was thinking it was an implementation detail that
should not be in these docs anyway, but I can't immediately spot it at all.
So rewrite or drop.


> + *
> + * The values can change when a clock changes its rate, so they are only valid
> + * as long as the provider's input clocks are not reconfigured.
> + *
> + * Context: May sleep.
> + * Returns: 0 on success, -EOPNOTSUPP if the provider doesn't report it or a
> + * negative errno.
> + */
> +int pwm_get_waveform_step_might_sleep(struct pwm_device *pwm,
> +				      struct pwm_waveform_step *step)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	const struct pwm_ops *ops = chip->ops;
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

Wrap comments to 80 chars unless it helps readability to not do so.

> +		 */
> +		non_block_start();
> +		ret = ops->get_waveform_step(chip, pwm, step);
> +		non_block_end();
> +	} else {
> +		ret = ops->get_waveform_step(chip, pwm, step);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	if (!step->clk_rate_Hz ||
> +	    step->clk_rate_Hz > mul_u32_u32(step->clk_cycles_per_step, NSEC_PER_SEC))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pwm_get_waveform_step_might_sleep);
> +
>  /* Called with the pwmchip lock held */
>  static int __pwm_set_waveform(struct pwm_device *pwm,
>  			      const struct pwm_waveform *wf,
> @@ -1710,6 +1773,12 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
>  		if (!ops->apply)
>  			return false;
>  
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
>  
> +/**
> + * struct pwm_waveform_step - granularity of the waveforms a PWM can generate
> + * @clk_rate_Hz: rate of the clock the PWM's timing is derived from
> + * @clk_cycles_per_step: number of those clock cycles one step lasts
> + *
> + * The period, the duty length and the duty offset of a waveform are multiples
> + * of one step, which lasts @clk_cycles_per_step / @clk_rate_Hz seconds. A PWM
> + * that divides its input clock in hardware has @clk_cycles_per_step > 1. A
> + * waveform that is asked for in whole steps, and is within the range of the
> + * hardware, is not changed by rounding.
> + *
> + * The step is the same for every waveform and for the period, the duty length
> + * and the duty offset, so a provider whose granularity depends on the
> + * requested period (for example through a prescaler) can't describe itself
> + * with it. One step also has to last at least 1 ns, otherwise rounding a
> + * length in nanoseconds up can add a whole step.
> + *
> + * A consumer that needs a minimum time, or that has to place an edge relative
> + * to the cycles of the clock a PWM channel gates, can use this to ask for
> + * the next possible value instead of one that is rounded down, and to compute
> + * the frequency a rounded period results in without the error of the
> + * nanosecond resolution of struct pwm_waveform.
> + */
> +struct pwm_waveform_step {
> +	unsigned long clk_rate_Hz;
> +	unsigned int clk_cycles_per_step;
> +};

For this to go through IIO (or an immutable branch if needed) I'll obviously
need PWM tags.

Thanks,

Jonathan

