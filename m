Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652C363094
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009129; cv=none; b=l2/Z0I6FD4V3Hc2xFqNAKM5rJwyQRFE15vE2LGSB/sRBXCBIwwHy/H67HOW61rHPw31NLp4/w8QtdlyAHRHO8s0JBsbC+rdcnrZsrbyz5EdwPXfSYhgnKuezSAWPcSEstJQHZbTQ/q0LIw4t0vgcZCwjNK9uciweB+wpO4Qj5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009129; c=relaxed/simple;
	bh=LEpJIASbHNo4X0RPo2iaoIfrZXYAPZp+t9oyvvouKa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoddF19P5FN7ommHsa4ndJ4VBqqmSqnvqzZrUQ5BhKEkHPrB4eljz0fQajDul8luQJHKfAVK4HPtQdUBOkWInJpfJQhCVq7zMKRMN7uYXfvobOfgnCWXVPly7qHqGOQ8UdOmYlwnXKzU4SNQxeTUE+GHtFytaDHdWNnqLL7NvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKyh92HE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKyh92HE"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1528094f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786009126; x=1786613926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Koyhdo7RJnHdsfW4+qUediSvR3LtaQvEYPXMpeVJrM=;
        b=hKyh92HEMlekwbSpJKEphFpApJPE45lkuPIKCb3TH19uFCMQkwy1Cl0Hr5Pvi/9pWb
         rQOUeTXBWJShnVyd1+OtHXxmHn8j6V8F9SULZrcXGgE0VpXgRcLzPKC7W7sAeOFqIkyA
         lIwqgg4XitT/xmFCMw0iRxhC+5ZyXRLif4oDINXLt9XEUAYmbTFuE8r9ISfLkemsY+T1
         TToVzbD7XU9htmvyMVuh8301cbMSlkUZtUKZMt/HffNcJVZ/ps0iVsYa8dTdiWvYOjh0
         tMiEnPppETbWLtgVUqoZV4vulI63kzCYtwFo8RDiOR6fnEe2KnM04Luas7pWdsYjnC6n
         VZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009126; x=1786613926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4Koyhdo7RJnHdsfW4+qUediSvR3LtaQvEYPXMpeVJrM=;
        b=RUElY5QwdY+oYipaN+OnIpsLWBLIf4ocDj7y6n803Kc6h+BFoWy3lu5jsw3W/aSl+T
         27kDAXfHp5K6ymDSw4vlU9BvmIIT7OPtlcfaieejNv1EeYRv3yoq2UtpBqLaubyh7SLh
         A1qWKvabTYC/j97KKfC0mpuboCTKv+AcL9qJjE9ELqnchmyjPZJx1x8RmI4co5qbrty9
         zmwufhlLHzUZrU95KCeudbn65leXzDop6qkO8civv4++smWr032VODIIVdoE8M6GS8sz
         fhDmPfOVlS2focW4iEwmsFH6CXFtJJlIj8NoCcxfnUlzea1ZUONSjmDkttK9r80PopDO
         2gfw==
X-Forwarded-Encrypted: i=1; AHgh+RpyeEWXC/piRmUSROSIcKQOxRJ26hdCq+oXOIhjSg2BQb79gr7IA0Xdtk30Kck0bwh3lEEhuWl87cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2oUEF5D2QUE1WVW6vYfzEd2l51iZX1WPDPdSuQC5gBjEXjBr1
	DQ7sC5cUIoG/P3ykLKByr8YONQe+1JIPzkOPrddJKOBAAvsP3JFJp/O3
X-Gm-Gg: AR+sD13HzU0arlHLBnN7Hmli6ISiRV3ZZAgSafs23In2M7zmdVNgj14K8lrB8GTUyuU
	jIWD2AcQlpa4k75UaTYwDQ9dtA2nD+nm0MNxQt9O7kdm2rDBRts5KjSDfqJ599U9ha6cleS76RJ
	/T3ukJ5P63Nk8FMGlA/sEBhFgEDJyjU3WWjvq8Y9wGUnZrKsStFCC0Pf7e8TksWbX/x7kHgPnMA
	EoB3qI2U0fp2ch0d6xaROdjfCrhQHzHKUYl/wv73PML8YcU53safKl8e28c2vmbr0YfzuQEZS2l
	r3P+3PmGaY29yOZexPO1gMq6dFI5teO8DugWmZldKZU8aW/GG+OiF7xyc67FI02GwJXgNoFK8mU
	nKjj6DIJmLJVRJn6vXY5ECKfpzKl9mflIHv6eBgv0Q+7D2GROEaR3FQJqeJd2pS0/46mzppjzoW
	DmV0PyDu0Gwzsu1rkukQQQjO4NtUMQ6+5TOptqdn1TyRhFkUk7s0cqtNZd4vJ2ih6Jn+lxQMBLp
	98=
X-Received: by 2002:a05:6000:491d:b0:47f:ec8a:214f with SMTP id ffacd0b85a97d-47fec8a2195mr21488851f8f.15.1786009125602;
        Thu, 06 Aug 2026 02:38:45 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79a718bsm5239336f8f.5.2026.08.06.02.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:38:45 -0700 (PDT)
Date: Thu, 6 Aug 2026 10:39:56 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, Wadim Mueller <wafgo01@gmail.com>, 
	Maxwell Doose <maxwell@maxwelld.cc>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
Message-ID: <anRUF3ucjK7n4iN-@nsa>
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805110255.504576-1-lilinmao@kylinos.cn>

On Wed, Aug 05, 2026 at 07:02:55PM +0800, Linmao Li wrote:
> slf3s_suspend() stops continuous measurement before disabling VDD. If
> regulator_disable() fails while the supply remains enabled, the system
> sleep transition is aborted. Since the PM core does not call the
> corresponding resume callback for a device whose suspend callback failed,
> the sensor remains idle after the system returns to the running state and
> subsequent reads fail.
> 
> Attempt to restart continuous measurement on this error path. Preserve the
> regulator error and warn if restarting the measurement also fails.
> 
> Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/iio/flow/slf3s.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
> index dfa7c14090454..75ee82fbd3295 100644
> --- a/drivers/iio/flow/slf3s.c
> +++ b/drivers/iio/flow/slf3s.c
> @@ -462,6 +462,7 @@ static int slf3s_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct slf3s_data *sf = iio_priv(indio_dev);
> +	int restart_ret;
>  	int ret;
>  
>  	guard(mutex)(&sf->lock);

Side note and not related to this patch but, AFAIK, there's no point in the
locking the mutex on the PM callbacks.

> @@ -470,7 +471,16 @@ static int slf3s_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	return regulator_disable(sf->vdd);
> +	ret = regulator_disable(sf->vdd);
> +	if (!ret)
> +		return 0;
> +
> +	restart_ret = slf3s_start_meas(sf, sf->medium);
> +	if (restart_ret)
> +		dev_warn(dev, "failed to restart measurement after suspend failure: %d\n",
> +			 restart_ret);
> +
> +	return ret;

I'm also not sure about the above. If the regulator fails to disable I
would say things are already in a bad state anyways. Is there any strong
reason to do `slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas)` before
disabling vdd? I would assume that without vdd things will terminate
anyways. Asking because if we just disable it then the above stops
being a question. Though I do understand it's better to gracefully
terminate things. Just not sure if there's any added value for that in
this path.

Just my 2 cents. No strong feelings so if the driver author is fine with
this, also looks like a sensible change.

- Nuno Sá

>  }
>  
>  static int slf3s_resume(struct device *dev)
> 
> base-commit: 0efaefce4e95a3331550329c0078b2fb38b3ff1f
> -- 
> 2.25.1
> 
