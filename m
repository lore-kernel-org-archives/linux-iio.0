Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AE3BC667;
	Tue, 26 May 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806839; cv=none; b=fEFQePtbD2Iqth1sOn1n7DbWM+u6WMa35Ja1zFAwFzY0+TZeAnXeJ5FPsIUAdWJpal/Ro/aaP2JdcJP6t8mGUF+gIvUGE5Nk6WJPW0p+sZg//Q3JWRVNPPWE70oxcINrj0DWIcUy1mYzVfZNREESpuPuAaTemOttdfz77b7sGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806839; c=relaxed/simple;
	bh=leioawCi/HKpIgqFqTfrzJTERfPSqwvLQpyxDu8ZI8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2wj0okxcj0cLiEszH7mKjli6auDxzNAjgPah8zGS7IAmrAeIFCvzsqbqyF2ctqeO2uc8F0Fe0Q4fshUsz++w7YZ+YxwGSLgg25mefTAt7DZbCGX6mCsqlmOvJgBh/9xNuQX17n9KuAcaJqvJSSbM4OglSovldguj+VtQnwVG7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAE8B1RN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAE8B1RN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E611F000E9;
	Tue, 26 May 2026 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806837;
	bh=V2+9s6TsBSpGfuJ8AoJnuQ0uWywtRmpKsWp7+xB4BqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SAE8B1RNnJze0b4G+0RGQqK1TjdhNvbMR7scoR8DpzVqX43yW9jS0QPhemD30wRvC
	 3ZDYu/VyjJPmtCLPbLL+R1jwsicscVmq+cuMzWa3OIwQIV4ER1Pxp4z//z+XV8nHb9
	 kqrImDYFvOV6dst3T2JfW98PuQAhzwde5QqSpyxDrVdeEmS8RT0CzaasqGoWyFB63d
	 Fa48vBVej5TBteF27UqPaq7UU8u2CnGH2oU/cU3/ESO4AilxPXAEndoUMQq+/FgRHL
	 FdLJt48gTbLW/op4qhVkiwYMmZI/em9aaxCWZHsEuj+xVo92paKqwUMmY3JBGrGrzG
	 aEoUzsnChlDKA==
Date: Tue, 26 May 2026 15:47:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v4] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <20260526154709.7dfa5f0c@jic23-huawei>
In-Reply-To: <20260523182531.10146-2-m32285159@gmail.com>
References: <20260523182531.10146-2-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 13:25:32 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
> 
> Add new helper function scd30_trigger_handler_helper_locked() containing
> the critical section for scd30_trigger_handler(). After moving
> scd30_trigger_handler()'s critical section into the new helper, tune up
> control logic to return ret early and not memcpy() if it's an error
> condition.
> 
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Just some naming things inline.

I thought about just changing them and applying but decided
I'd rather you took another look to make sure you agree
with the suggested changes (and if you do send me a v5)

Thanks,

Jonathan

>  static ssize_t calibration_forced_value_store(struct device *dev, struct device_attribute *attr,
> @@ -424,11 +430,13 @@ static ssize_t calibration_forced_value_store(struct device *dev, struct device_
>  	if (val < SCD30_FRC_MIN_PPM || val > SCD30_FRC_MAX_PPM)
>  		return -EINVAL;
>  
> -	mutex_lock(&state->lock);
> -	ret = scd30_command_write(state, CMD_FRC, val);
> -	mutex_unlock(&state->lock);
> +	guard(mutex)(&state->lock);
>  
> -	return ret ?: len;
> +	ret = scd30_command_write(state, CMD_FRC, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
>  }
>  
>  static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> @@ -579,24 +587,36 @@ static irqreturn_t scd30_irq_thread_handler(int irq, void *priv)
>  	return IRQ_HANDLED;
>  }
>  
> +/* Meant ONLY for scd30_trigger_handler() */

No need to say this in a comment. The code naming is clear enough. However...

> +static int scd30_trigger_handler_helper_locked(struct iio_dev *indio_dev,
> +					       int *scan_data, int arr_size)

Avoid using _locked() in naming.  It isn't clear to readers if that
means it is locked already, or will lock..  Also somewhat unnecessary
here. We don't need the function name to say why there is a helper.

arr_size would normally mean array size - i.e. how many ints
there are in scan_data.  Here it is the size of scan_data - probably
also make it a size_t

So this whole thing becomes

static int scd30_trigger_handler_helper(struct iio_dev *indio_dev,
					int *scan_data, size_t scan_data_size)





> +{
> +	struct scd30_state *state = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&state->lock);
> +
> +	if (!iio_trigger_using_own(indio_dev))
> +		ret = scd30_read_poll(state);
> +	else
> +		ret = scd30_read_meas(state);
> +	if (ret)
> +		return ret;
> +	memcpy(scan_data, state->meas, arr_size);
> +	return 0;
> +}
> +
>  static irqreturn_t scd30_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> -	struct scd30_state *state = iio_priv(indio_dev);
>  	struct {
>  		int data[SCD30_MEAS_COUNT];
>  		aligned_s64 ts;
>  	} scan = { };
>  	int ret;
>  
> -	mutex_lock(&state->lock);
> -	if (!iio_trigger_using_own(indio_dev))
> -		ret = scd30_read_poll(state);
> -	else
> -		ret = scd30_read_meas(state);
> -	memcpy(scan.data, state->meas, sizeof(state->meas));
> -	mutex_unlock(&state->lock);
> +	ret = scd30_trigger_handler_helper_locked(indio_dev, scan.data, sizeof(scan.data));
>  	if (ret)
>  		goto out;
>  

