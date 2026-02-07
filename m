Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374DD5FDA7
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770489790; cv=none; b=l5Ph6R3MWNz1OXWKOD48LEl5f003fIxzJs7g9KDbZyiYeUbQXWO8zmwG+Q0j2fGoNGQYh5cv7gbotXFtVw+f1N4xqzAsk8XttlRjJn7C5N0KpfSXMf2cvwkqnQi63E0PyBTT5YBvtYEwY3Q+266fcI9v5yheh4M/SnFkNr05T14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770489790; c=relaxed/simple;
	bh=eobRWPX7V3mhzQ/jJ2aUjX2QqhN/EpRejhH5y6xfzB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNj4zV5Hfn8YKRMG+yr6J9JvM3V7yDMcW7cBOW/Yl9n/TnuuXSRzGVjJPcGFhOOosGQ0A/4IcUq6eLgQ5falvQxm6wFsILxIdGUOwJg4+ursImwR7UZmhwa+kaAZ3YA5Ht4k81p91pSwxWSHBJqN3gkefAZMxllL028e4uOLwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J1UF2IPM; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J1UF2IPM"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d122733808so694886a34.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770489789; x=1771094589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prJ1YgnM4mOIBKQF9u4CXqDRUwbdBQdcuDtFU8rMz6k=;
        b=J1UF2IPMwXCnQQDsKsX8Fk/cmOOoSBdnju3x2xy4ffWCbpuEYZS8Zr7gIO6VJgT3A4
         TsZM6V1Dg7uEHz26lyhEND8AU4gi7DHN8c3qyufeGrqhWMQkuT3lMRenMcsB3Dwo0as8
         a5nn+4OGW+sMUpSMIoGN0ujBh1cVODcmvwnWvfKrAsKagesmUmdPuYGwTDYZj5gOPNix
         ECS1qhwXvZASFlRFw+JNWV5slGRmfci31tP+6Y8/o10ZRKrNEk5AhP0g/F09/OouJ+8c
         OsEqk1TNrk0OMqlO9aBMpOV6UrTeiE/346tYLZ9hrAKd1oQ/BPs5q38ONO5MQFMxuNaD
         gK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770489789; x=1771094589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prJ1YgnM4mOIBKQF9u4CXqDRUwbdBQdcuDtFU8rMz6k=;
        b=hKJuppn8E2Qn2bZrsTQ7ivlYOB3whKeGI46jQ/bBXwczyCzwPVf9X4As+fVi1IhbFu
         PqLTNutxksJMDLi9Tn2zOFGhzKldMQb0Qlt+dJtBwg9qSJtU+05i6tTCI1wAyPTMPR/s
         iUSSvEN3dkRdfYYij3/x5DoOW0Y1HD10SrUm00OKibUCy+6TVgm8oPGEG1Kg0IiHKdf0
         yujtcpYZHmYMn4tCRvLAaJDQ5fJcfTTtglCKfWicXolihHoedaUkysJkYTE+Vau07kfp
         3hlmmVgommy1yXRFcXLmbKk6hD47Va6g1ONboyt/jyPgXeAc3FovSFkTamuDHREjczY+
         k8AQ==
X-Gm-Message-State: AOJu0Yx5HVwGNwgEL0Ro3AuIZjgO8TL+mOayyhRBV7M33dYNY73fqrzq
	r5ZAqDkVK2g9f8lPxYh3e2EPxHFKvPCUH5Udv+e3/Jmn1Ym6MGNGDX6xGmQKkceo2FE=
X-Gm-Gg: AZuq6aLD3ZkIiC1bqk/z0LHy5G9dcS8+gSZZfs4qSvZCq9JPbZ2g8gl/9xINw370HCt
	aN4Mn9wcguv6vlujiL+XBp/KGy0RF0Xu0YhLAsEfbsPHBeUbTcsX+1/Uh/ETpNb7u5+mFzbZWtB
	9vUrewi1OeKRQ6y7Bfm9lZpSs3IrwmRcPRzJKjLl4nbhaaZ+yCILrVyUXjTkLsjIrOi8osr9AF9
	o4RZZa5j9vxnyf2dfYC95bSxlSdsV3XSdAIuj/dI+bLvR5FWq6AfponpHEYU2KMhCxoj/0AFtlR
	+H1XutcJVr/z5NEW/eBxKbOI5iyMJVYGPISaSBdA1cVPMisiRI1LwfA2o8AX+WE8mmVvDSlDDWs
	3/QgGwe+YhO1Dw6WEzv9HE9AEmZnuyNrTYCU4/IP90OaaNqWEaYtBzN12st7FAU6jHV48cVw1zo
	NRzNhXRl9BqavfXA/Mom3/uxW01bG1l0ydFzB8Z4cZxtUqCHVbHC0FzYytGg==
X-Received: by 2002:a05:6830:3687:b0:7cf:da7d:5041 with SMTP id 46e09a7af769-7d46447f75dmr3415181a34.21.1770489789192;
        Sat, 07 Feb 2026 10:43:09 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:74a6:843b:f33:21ae? ([2600:8803:e7e4:500:74a6:843b:f33:21ae])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46470dec3sm4260081a34.9.2026.02.07.10.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 10:43:08 -0800 (PST)
Message-ID: <45cbf569-6046-46a7-9a76-7411e89af99a@baylibre.com>
Date: Sat, 7 Feb 2026 12:43:08 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
To: Tomas Melin <tomas.melin@vaisala.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
 <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 6:24 AM, Tomas Melin wrote:
> Add capability checks for operation with backends that do not necessarily
> support full set of features, but are otherwise compatible with the device.
> This ensures a fully functional device, but with limited capabilities.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  drivers/iio/adc/ad9467.c | 67 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 59c3fa3bcc9b..7a3db36121b0 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -913,7 +913,9 @@ static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
>  		return ret;
>  
>  	guard(mutex)(&st->lock);
> -	return ad9467_calibrate(st);
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return ad9467_calibrate(st);
> +	return 0;
>  }
>  
I would appreciate a blank line before and after the if statement
if we end up needing a v7.


