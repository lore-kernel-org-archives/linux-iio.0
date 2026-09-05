Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8E37C0FD;
	Sat,  5 Sep 2026 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570817; cv=none; b=L0VHxBt4ZUzkqpSoyMFHIcPndDW1IhltmkGNOnlUq+ncli5RKyqRRIehE5S8m6+OEopki4HWbJ5WfyqmtSdONVJ+TzbkskGcV7XU57r7PJNujWoupgoAH+sDTBev6wZDDOPnXJt+Q0HsuKLDIwJWp9cBUGsoGxyer9btbL1xSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570817; c=relaxed/simple;
	bh=dnDgREOsIu5gsLEIgA21mvtCTdYSfSaHQ2v1OoLdUEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhL5uZLHqgAY9LqoZte845H455wad5VjJ973xTUW8FgiAa9gaS7xhLuh+BxIf0a5A6aTs15BhBlMUmtVVi+BCYFFgNUUxvbQC3tb1Q974J8p0ZFdSPspN/mozpDmnFpvuJZRYPtCdCUDAz2dVdBTMhSaitzDCfjue/8y4nR6YO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3/ccAQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3/ccAQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE281F00A3D;
	Sat,  5 Sep 2026 01:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570816;
	bh=7ZOcGQ+was0TtjEfcbmEVy67dZ/1OlBNFQ+Jrh265c8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f3/ccAQagFEY2UrWtyHgUKsXmMxvV8zE0CHX4KYG6LmF3a8zQ6bCmbjmTU+HcaN5p
	 Xw9vMriIHme+p1GToXsF0/KFj9UZWPeyTuV6vnN/l35igQHS/HgtzbjcamBTk5O72V
	 CRR2vDkZ+a+MoIHOWZrNwEWyFM9zwOpEFlAIRCQcU31CeJWe74AZRK8IHTbfW3Mcw+
	 xRxJxkCxgUKSqUNt3tl0V1DqKaDBPx6rbymNTNVqsKht/eUZjlygrpyozVxC82GpQt
	 ztBI7jFH5twVHAKq9/YVKxlVCC/ibBxxHw6yhZB7tU1WVars+BfmlcOdCgX5B3jAE3
	 Nk/GJhJOWINqw==
Date: Sat, 5 Sep 2026 02:13:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Maxwell Doose <maxwell@maxwelld.cc>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Li Youhong <dayou5941@163.com>, Li Youhong
 <liyouhong@kylinos.cn>, Brendan Higgins <brendan.higgins@linux.dev>, David
 Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/2] iio: flow: slf3s: keep the vdd supply balanced
 across suspend/resume
Message-ID: <20260905021330.2943f35e@jic23-huawei>
In-Reply-To: <20260904-iio-slf3s-pm-regulator-kunit-v1-1-5ea61e6d6db2@gmail.com>
References: <20260904-iio-slf3s-pm-regulator-kunit-v1-0-5ea61e6d6db2@gmail.com>
	<20260904-iio-slf3s-pm-regulator-kunit-v1-1-5ea61e6d6db2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 21:24:25 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> slf3s_resume() enables vdd and then restarts the measurement.  When the
> restart fails it returns an error with the supply still on, and
> slf3s_suspend() bails out before regulator_disable() when the stop
> command fails.  Both paths leave the driver's idea of the power state and
> the regulator use count out of sync.
> 
> The PM core only runs the resume callback when the preceding suspend
> callback returned 0 (device_suspend() sets power.is_suspended on success
> only, and device_resume() bails out when it is clear), so the enable
> count cannot climb above one.  The damage is different:
> 
>  - After a failed restart the sensor stays powered but idle.  Every
>    following suspend then fails too, because the idle part NACKs the
>    stop command and slf3s_suspend() returns early - the system can no
>    longer suspend at all until the driver is rebound.

That resume errors don't stop the state transition is rather annoying
and leads to all this complexity being needed. Given how few
drivers go to this level of complexity I suspect it is mostly luck
if any recover from a failure in these callbacks.   All bets
are pretty much off if your power supplies are returning errors
so I guess that is kind of fair enough!

> 
>  - If regulator_enable() itself fails during resume, the next suspend is
>    free to run.  Should the stop command succeed there, the driver calls
>    regulator_disable() on a supply it never enabled, which trips
>    "unbalanced disables" in the regulator core and aborts the system
>    suspend with -EIO.  The devm cleanup has the same problem on unbind.
> 
> Track the supply state in the driver and drive regulator_enable() and
> regulator_disable() from that state only.  A stop command that fails no
> longer keeps the supply on: it is cut right afterwards anyway.
> 
> Reported-by: Li Youhong <liyouhong@kylinos.cn>

Given Li Youhong has been proposing patches for this I'd definitely like
their input on this one.

> Closes: https://lore.kernel.org/linux-iio/20260901025010.356735-1-dayou5941@163.com/
> Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  drivers/iio/flow/slf3s.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
> index dfa7c1409045..37f40685e9d9 100644
> --- a/drivers/iio/flow/slf3s.c
> +++ b/drivers/iio/flow/slf3s.c
> @@ -110,6 +110,7 @@ static const struct slf3s_variant slf3s_variants[] = {
>   * @vdd:	supply regulator, disabled while suspended
>   * @variant:	pointer into @slf3s_variants for the detected device
>   * @medium:	currently active calibration medium
> + * @vdd_on:	tracks whether @vdd is currently enabled by this driver
>   * @lock:	serialises the multi-step command/response exchanges
>   * @crc_table:	pre-computed CRC-8 lookup table for SLF3S_CRC8_POLY
>   */
> @@ -118,6 +119,7 @@ struct slf3s_data {
>  	struct regulator *vdd;
>  	const struct slf3s_variant *variant;
>  	enum slf3s_medium medium;
> +	bool vdd_on;
>  	struct mutex lock;
>  	u8 crc_table[CRC8_TABLE_SIZE];
>  };
> @@ -382,6 +384,12 @@ static void slf3s_disable_vdd(void *data)
>  {
>  	struct slf3s_data *sf = data;
>  
> +	guard(mutex)(&sf->lock);
> +
> +	if (!sf->vdd_on)
> +		return;
> +
> +	sf->vdd_on = false;
>  	regulator_disable(sf->vdd);
>  }
>  
> @@ -416,6 +424,8 @@ static int slf3s_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
>  
> +	sf->vdd_on = true;
> +
>  	ret = devm_add_action_or_reset(dev, slf3s_disable_vdd, sf);
>  	if (ret)
>  		return ret;
> @@ -453,10 +463,8 @@ static int slf3s_probe(struct i2c_client *client)
>  }
>  
>  /*
> - * The sensor has no low-power state of its own, so stop the measurement
> - * and cut the supply while suspended.  Resume powers it back up, waits
> - * out the power-up time and restarts with the medium that was active
> - * before.
> + * The sensor has no low-power state, so stop measuring and cut the supply.
> + * Resume powers it up again and restarts the previous medium.
>   */
>  static int slf3s_suspend(struct device *dev)
>  {
> @@ -466,9 +474,16 @@ static int slf3s_suspend(struct device *dev)
>  
>  	guard(mutex)(&sf->lock);
>  
> +	/* A failed resume may have left the supply off, nothing to do then. */
> +	if (!sf->vdd_on)
> +		return 0;
> +
> +	/* The supply goes away below anyway, so a failed stop is not fatal. */

Not true.  This consumer of the power supply says I don't need it any more
so maybe if no one else is using it and the power supply even supports
being controlled will the power turn off.  So this remains an error that
should be reported.

>  	ret = slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas);
>  	if (ret)
> -		return ret;
> +		dev_warn(dev, "failed to stop measurement: %d\n", ret);
> +
> +	sf->vdd_on = false;
>  
>  	return regulator_disable(sf->vdd);

Sashiko calls out that we have no idea if this succeeds. So vdd_on
may end up out of sync.

>  }
> @@ -485,9 +500,17 @@ static int slf3s_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	sf->vdd_on = true;
> +
>  	fsleep(SLF3S_POWER_UP_DELAY_US);
>  
> -	return slf3s_start_meas(sf, sf->medium);
> +	ret = slf3s_start_meas(sf, sf->medium);
> +	if (ret) {
> +		sf->vdd_on = false;
> +		regulator_disable(sf->vdd);

This could also leave us out of sync if that disable fails.

> +	}
> +
> +	return ret;
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(slf3s_pm_ops, slf3s_suspend, slf3s_resume);
> 

