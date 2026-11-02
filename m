Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654164;
	b=PGJ8do7hE41VwOeHHyTiWXPqbewQ5d21zb82t1BAjkr6UiuV529gGTdp2qu80Pruyhp1
	 pyNj7aNQCRB8EXGoIr2/uu49SFAPVGwsu+5pTTqKZeWQbd9uFVUYkQsGmrXRPFbZGrbS2
	 Jd/r/OA0a1cVtifsBzavnWA5JVl/sVNrQBVgdADB37+AE5SK7SX8fZjx04EUeCweaouAX
	 uiXKbOgV+eoLBLxw3jQjefQAagMv2ArSnDM7MRdHqTJ2N/mducl1vSV4thOCqWojXrnLq
	 p01SM17TrU0Ew4dXwJ+sDl0SluLr2TWRuUor5vCJPNLgTNwrR7W0mA6Uu2AD2JeNkwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=VaQ4mY5L5yPvzObTP46rUUyQYF+3IVm7RJ9iuidlpa4=;
	b=uSJpPG8gL/GXgcFyENbTz6FE/dePpYyaqkWkLlNw3v65Ywpjyl460Cc0vNmkp43nTBb8
	 n9PoAgMUeDNEdil6r0S7kwpkaoNvj+criab856wwQ0PSHINDSfG79AdDbTTkI+uuxJdST
	 fRQ1fxqg3DI3r8ZJLRlkLGwcm+6prw2V8dKnGTOhMgVgE1gHp5QvFNFleY6LhAT3SHwUj
	 m/aAlE2tbAHgOo/QTFavkzLkG33930Jw3gAIGmUYo26H+1zLx9o6+hLWp+vLVc5/4Pl60
	 ylJl/z1y1AEXS9KJgJEdymR2UhKxb7t0OsbnHdJ0hWUjr9MnR1v+DlgSa9Uu2ldbybA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Tv+7ae6q;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3C606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 21:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68A3C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Tv+7ae6q
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15dd124bbe7so4775688c88.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793654162; x=1794258962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VaQ4mY5L5yPvzObTP46rUUyQYF+3IVm7RJ9iuidlpa4=;
        b=Tv+7ae6qFwJUrAkkvyIFZ26J2lYxiAmmLc0CaTjSOjF+KSqWztMzk+NOQACrq81a4r
         gQjTBn8Yh08fg6/UgxnavjLITlrMd3FL6soeyH6B+afiYoJ5H4audZFQGOj9/ziptdvd
         VF8A8Nr4HeodvQdeSWNH6bjDaon/cspwZlubw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654162; x=1794258962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VaQ4mY5L5yPvzObTP46rUUyQYF+3IVm7RJ9iuidlpa4=;
        b=ktAVF8ZOubD4Yq7+/XKiYX7EJ4pcVWcANnXhi/5DcZftPiuYmzhjvoCjUdSoIiMlUT
         2wPpAuUve2eujdvdY1tyhU4fq7T0UpYT8n1JcADDua5NRup2OxlUcvGc5a5DiWNhUQlV
         awVnHywllyDrUfj1qgU72lQAMdr7OShTtjynNkFDvBqnBYuIkbuYEqoBBMmDh0SkdGXZ
         Z6qtgchP5HjVcG+P8bsvvI4qADxXJIkoNvCSnZkihWKkzGu1kF4sZ9QItKx3D192WRYa
         2xNoQ9fkTBZlSTvo65Dcm5HFRGr2aZw2VoRYS0jOdOfOWOZxPgXXLmo8DdP1I6flrO1J
         sQnw==
X-Gm-Message-State: AFq9FYI9fo+dOTvPy/ChF383BDrAtt+pRmz5GUm00QiM5/me5aM4LqTh
	RoiPmELvnpFIkYN/ZMRLuuE627tXY2gyPlY/HFUu/M+yo7oUf0dvo6ZhsC7sbJaACw==
X-Gm-Gg: AYBFou2IfvIqzTkV6D5Ob3sA0kejutdjE48dfvTxfplWlOxrdNqAjO5CifKaVmvh+l4
	vBSYBhHjujY9LWS8dd9BWvSi5fnEHWQ8Sw/IPVWzHXsUna2swQxkuDl21704IXAD45f/c+82Aft
	3KcQyK06FKkEizsvT2q4AblJA2skXrBtOxjWlGRzTWf8GsbZX9xjIvLWRFSI53xxozRPg1fn5du
	WGtsFNDEAg+TvVicyOtFiKh64D9Yh8g2WJCIfyaGB9YdMIkH/dWvCSn7hLFzXdEZOm8fH5q8ztk
	D/O3ceBM7jYN5pDokIbTgkf2NmHIOEkP9ZX94F3ntPr9B2dXs1YsMRhb91x3g9IOeJgqoDGHVF6
	gmn7GXCkCQmsvNHhrkNoAPcbdeVtH+VdH10ByG9Ev9FVTs2Id1RBjsPnygpq999YdbF+/hPxDSb
	7udvJMfcw851n4GB0SyNOmCZfjaRT5MKgag84TFM8O97p4KSatlZa56Rfae7OQlzDBwOkjYr6YJ
	UceBO7WG+ym6drS8k5Kw2gHdimtIU1dp0DBHW6QigV3BgCX/hW7+drcmXVp54awdxkiVEtHLjyv
	TbLwDlhqmFBz5JomeZDMhnXbL0bUzrytNBBCk1Q9G9owplK3JH3Mf6MLtjSDmwQkcR0=
X-Received: by 2002:a05:7022:eb55:10b0:168:3243:c90c with SMTP id a92af1059eb24-1ac59dd356cmr17871485c88.15.1793654162136;
        Mon, 02 Nov 2026 13:16:02 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:c57d:c93d:3543:aab5])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1ac1854d925sm63953172c88.7.2026.11.02.13.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 13:16:01 -0800 (PST)
Date: Mon, 2 Nov 2026 13:15:59 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3] iio: gyro: bmg160: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <auj9j3sbYa4sVoil@google.com>
References: <20261102014830.679216-1-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102014830.679216-1-jic23@kernel.org>

Hi Jonathan,

On Mon, Nov 02, 2026 at 01:48:30AM +0000, Jonathan Cameron wrote:
> From: Brian Norris <briannorris@chromium.org>
> 
> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value, and inline
> bmg160_set_power_state() now that it behaves the same with and without
> CONFIG_PM and is otherwise trivial.
> 
> Now the return value of the cleanup is ignored, also switch various
> paths to use PM_RUNTIEM_ACQUIRE_AUTOSUSPEND() in conjunction
> with guard(mutex)() futher simplifying the code.
> 
> While at it, I notice that bmg160_write_event_config() and
> bmg160_data_rdy_trigger_set_state() mismanage the runtime PM reference
> count intentionally, relying on racy autosuspend behavior for
> correctness. I refactor this to manage refcounts properly instead.
> I use guard() for the mutex, to make this less error prone.
> 
> Additionally, bmg160_write_raw() had one error path where a
> pm_runtime_resume_and_get() failure would also drop a runtime PM
> refcount (pm_runtime_put_autosuspend()), which potentially leads to
> underflow. I fix that.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
> I'm continuing to nibble away at Brian's series applying some of the
> additional changes Andy asked for (that Brian quite reasonably stated
> were beyond what he was going to take on!)  Just this one today.
> 
> v3: Make use of ACQUIRE magic in various paths as enabled
> by dropping the return value.
> 
> With this posted, I'll mark it changes requested in patchwork.
> 
> https://patchwork.kernel.org/project/linux-iio/patch/20261021165858.v2.10.I5918e916cbe48281c13e5734733a3281e7be8841@changeid/
> 
> ---
>  drivers/iio/gyro/bmg160_core.c | 237 +++++++++++++--------------------
>  1 file changed, 94 insertions(+), 143 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index b007f46d3fd6..a48e01ecc367 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c


> @@ -759,42 +700,37 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
>  				     bool state)
>  {
>  	struct bmg160_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
>  	if (state && data->ev_enable_state)
>  		return 0;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
>  	if (!state && data->motion_trigger_on) {
>  		data->ev_enable_state = 0;
> -		mutex_unlock(&data->mutex);
>  		return 0;
>  	}
> -	/*
> -	 * We will expect the enable and disable to do operation
> -	 * in reverse order. This will happen here anyway as our
> -	 * resume operation uses sync mode runtime pm calls, the
> -	 * suspend operation will be delayed by autosuspend delay
> -	 * So the disable operation will still happen in reverse of
> -	 * enable operation. When runtime pm is disabled the mode
> -	 * is always on so sequence doesn't matter
> -	 */
> -	ret = bmg160_set_power_state(data, state);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> +	if (state) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to resume: %d\n", ret);
> +			return ret;
> +		}
>  
> -	ret =  bmg160_setup_any_motion_interrupt(data, state);
> -	if (ret < 0) {
> -		bmg160_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> +		ret = bmg160_setup_any_motion_interrupt(data, true);
> +		if (ret < 0) {
> +			pm_runtime_put_autosuspend(dev);
> +			return ret;
> +		}
> +	} else {
> +		ret = bmg160_setup_any_motion_interrupt(data, false);
> +		if (ret < 0)
> +			return ret;
>  
> -	data->ev_enable_state = state;

This is an unexpected (to me) delta vs v2: you've stopped setting
data->ev_enable_state here. I think that's a regression.

This is also one reason I think it's unwise to make so many changes
together here. One person's "churn" (to apply several patches to similar
code) is another person's "hard to review / easy to make mistakes".

Brian

> -	mutex_unlock(&data->mutex);
> +		pm_runtime_put_autosuspend(dev);
> +	}
>  
>  	return 0;
>  }
