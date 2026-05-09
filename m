Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE747128816
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778358462; cv=none; b=hOAQcOiXOCtYm/Pg9WL9a6mosA/a+0qqKho4z/8Bo+UAwjoWWMcn4rvGAclXAMpeU1iGnGarXJDy1UvqKMjqolGESRW1JxwOoI1yTP/A0IvrNpHXhny6s8Z5uF0Q1vZ5FQFkg6RmPTq+An3HugJuud2R8XjIkDZXwZHnQiMtq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778358462; c=relaxed/simple;
	bh=BXGE2LEKWBZnOm/6Fcn9tkapQ4L2093rEDy619RLO1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzBqZRtREljcnkIx9sDVOI3NHfKXVSjAW/8ds2NN3sTAxJzF9BIHBT2tLPf+TdhQY9I91oo2IxUbzW1gkKSoGobC7FWYTEjBBeo5I0qBWYXx+QIHttCgpOeV939wFBOOf68KIlOiEQcacQzpP8+4urQDn1+Xq5r2vl0LxaZRuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ELvjROb3; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ELvjROb3"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4670464029eso1807305b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778358459; x=1778963259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f892GKIVoGJjwr2qfzZ9p6O68IlVvJJpuGUJC1Sd1qk=;
        b=ELvjROb3YvsgpwvDAPmZptcVHuklqh2xbePHkXcWdaZJWEOdVG7zLyBosG4YhTI51U
         yhNxbLO9B0dutEf2AO53VSa/p5Hy2Rpj74WDGbhdyG3sMOVoWlR7MlFuGEgWC+K3c0Wc
         lZGsIRxss6D6fbP1u+24N8veWAyUtzMgALs97TPVTJuBnaGH/yaLVor2m0wj52taxab4
         /HojUAzK3qiw41RTtrKndi0/RTkPH5wwMrlGTnrvJy7oVLDwW1foPYDRcq1F1A1NDQ0A
         Gkjl/Atutj6jx8254fK/Q7/d/16KkJDjD5rG1qXrHh4xb9feqTDhf0I/BdlmxZ3g+GCx
         pqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778358459; x=1778963259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f892GKIVoGJjwr2qfzZ9p6O68IlVvJJpuGUJC1Sd1qk=;
        b=oZ51VImKUAVSUSSN4mfOBjxDDlFEVHm9Spmo8YnN2sDkZqhu2aA2ySRSWmpJmAzF0n
         txhslkmFJ/s6aKxEceiueKvWHQVbnXCNiH+thOUNYy+CRzAiJ+Oxu1g2lWM2jh212da1
         2LLq7rVBbFTAbaJxS5tO/15RWnoHo41m4t/bAEUluz4sYbDZMxCGQGP2VyCxPi06ETMo
         pkm0xS2LZwKN6MLo9Nq7ouyuGCSePlIRPGELL9SXsVxwC1bNKxX4xgGzu73XxjcQDDQ8
         f+UEunfKD4qyigbXLAjxkSxclBj/zTJJXR/3nvfoxWmN3ujBCdkGOmJCEJjeIb7I8M1r
         tnDA==
X-Forwarded-Encrypted: i=1; AFNElJ8Xt46hfKAdPoIKl3u9lnUkqLMqU8ejw1MS9YjSg1Fxu6ZbyYFGW1yo62GR59OzMD4mvfuWXav2kIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDP+LUkholonlVTyKiBmWSh/dpzE+kDFSGG3bUqnckaaW85dO
	ToA/TifJHruDMgCSY0AgJusFn/lsR6+ywYcHXz82NLFEETGv9PxwS+GWPF5LIpAr7Tc=
X-Gm-Gg: Acq92OF83ybtVK7CzaYaX5YK890YHvOM88QbFrXK2QSmTgWHkAS4wAe3YcD83o0lVMx
	A4Z9g0TtXFkpuGX1Qt853haHqfWDJOaT19Bxh7N19YjCUSriz2Jn2TCx/SkbSeuIujqSaSRmQ4Z
	0fQfw+xEyRIfxoCSfRmDKrB/t4IgN215E6QUe2VXXXt9Ou5a9JV3QrCIsMaSTXnfkD2Hy0PIdR6
	4F6q/wdIH5djQ3QbMmRWoPn6QSgjK2PI+NSTW0lMRHxsRaUivWTr5WVRYg38xUsFFv0peaLhP0+
	W+vhbElY5R3wq9/X16FDLB7qbd4ZgD91r2GyszCiG3AHf6uqU1G1EhfmQBkdJ2+fuTp5ZiUT2oN
	lO1ujC7UJ63tjjZT8shHKp5T4IhcEqrzS3F4O0t/6q9gFg5pUg/Gp2rbv8Zcc6ytKOsnLgOqylU
	FqgerCn9pmgqtXTQ4dsscRNa37rY49O6iSKZya2lGqtemI3DNp4dIuhm+TQ41PYGitWCA74ffZk
	w==
X-Received: by 2002:a05:6808:181a:b0:467:1e5:6768 with SMTP id 5614622812f47-480425a5105mr9549836b6e.43.1778358458818;
        Sat, 09 May 2026 13:27:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f9dsm17344625b6e.16.2026.05.09.13.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 13:27:37 -0700 (PDT)
Message-ID: <f6189816-a157-466d-80bc-3f338c13d69b@baylibre.com>
Date: Sat, 9 May 2026 15:27:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: ti-ads1298: Fix incorrect timeout
 comment
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, mike.looijmans@topic.nl, nuno.sa@analog.com,
 andy@kernel.org, andriy.shevchenko@intel.com
References: <20260509151959.3475-1-shofiqtest@gmail.com>
 <20260509151959.3475-3-shofiqtest@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509151959.3475-3-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 10:19 AM, Md Shofiqul Islam wrote:
> At the lowest supported data rate of 250Hz, one conversion period is
> 4ms, not 40ms. Fix the comment to correctly reflect the timing.
> The 50ms timeout value itself is correct as a conservative margin.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1298.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index cf5f954206..186bda3087 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -210,7 +210,7 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
>  		return ret;
>  	}
>  
> -	/* Cannot take longer than 40ms (250Hz) */
> +	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
>  	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));

I would say "lowest sample rate" so we know which rate it is talking about.

However, there could be latency in the kernel delaying the interrupt from
firing. The kernel latency can be much larger (I've seen 100s of ms on old
single core ARM CPUs). So I think we should mention that in the comment as
well so that no one is tempted to set it to msecs_to_jiffies(5) (or 4). Even
if that works most of the time on a fast machine, we may need the longer
timeout on slower machines.


>  	if (!ret)
>  		return -ETIMEDOUT;

