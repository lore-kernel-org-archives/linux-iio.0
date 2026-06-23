Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B4248867
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256063; cv=none; b=BPlmTE/pUqBHonBQUaebG9f0W3zQwLQ24cChC/Z7YZyZ3J+Pw5zCpR/gQegztzQH2Qg5GJ1g8qKGLb1HX+dvr4y7yM+bOKdNF2lwdZ9+cpahRnh3jkNO9Cj4ViByz++t9xzu1Egp1XT5K0nyhPbf/92E6pSvWv4eO9vJVohOJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256063; c=relaxed/simple;
	bh=Th3M91vLEzz4QsKEAF44aVXS/vKeaClDHR0cuSVmgV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qLXsOeemdIxH4UbSVXo4PVrWU9ucPm8W56+QL4nPcvHeg/J7p9NibJzYAUZYBu36dJKrv5U7g4KXtNcsZiYp7lxnHMPJ8mZexOeUKLk/zKMD3QBF2klJRIO9krh0NF5yVb3maVd9nRieq61M3Dyoo/tiHBtxpAz0sdarwuoYAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RjfW6j1B; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RjfW6j1B"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e92c443cbcso301825a34.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782256061; x=1782860861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FF7cw5Yy+S7hLKfjPxOoTaPYvYHLSl3mlqulkut8dFI=;
        b=RjfW6j1B2498R1oPv1UQspk/DNcE1IjaL9pkYJEUjAjH1dIUACvKdnWeQfPcQOXVRn
         6TUAHnxlPdKg1X/r45lHNKTjTN30eg0gwbvO65FvKLC1kklw6arN+ep3BQdDH7CAXFrm
         3b1Z2gORS6RCvxtSpM+txZv3T0xZ+Das1uVRKUysdEPUQWsVGZSdQiII2obSciDZoyki
         ok7iwwRWlUrZ46RMnpRK6MWhkZYATF6XGHeZnn1D1oVnNb5r/fL448hgLQuusHulxHr9
         yalbSUjz7aQzNeN5RBzL2DPjECYU0rddPV84RceK58oRJMO/9APDyyG7Gw116huhZu2E
         kXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782256061; x=1782860861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF7cw5Yy+S7hLKfjPxOoTaPYvYHLSl3mlqulkut8dFI=;
        b=CO/UhkObRIlBD0UAXn55lho1rldlyKewfAweZKCtobUjfO5LTd6tAJZfDz7CMbLE4Q
         4caVo1BUWU/tQ4WgEK6lwk9IWkty/ypfeWPNquccAnWbbfuniJiK7w2L30H8LHVHIKul
         ahwWcaZ3L0E2vyK0beGJo/Q3xQRVUOP47P9vubC4a3REbv0NvR8MXf/k52icU5/u54Ch
         ezns/dZCHm1Pz0hH6GCTfxDjj9YanAfgK4VVC70JH+uoanMXgcrD8dQQywPeESe4jmpb
         cUDmZyg0GPwz0/KWU5Nfl36zcy3VKmphrfUJBo2Xc0N3rounz1W6Fyjc40b4tJDD5XnW
         +YMA==
X-Forwarded-Encrypted: i=1; AFNElJ+MxvQt7d13qOwPeXro6iktFpYRJQVdRPeyDXqn2FGqOTO8GPHGf/UjBrB/RqYmqOn8S0uGfDN5kv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDl26+Y8PBPZ6McHqKIdm5tJZKWvCwCIUhKG9GEhs1RHBt6Hnb
	HFw09vzWUBgF4Uk2k/R6UHzLtz7wUUEAIwOfPge1Awb8gHZEvbNSOWv3CkCoMcMG/3U=
X-Gm-Gg: AfdE7cmofQX22Ba6gFFBzyg7ReddGdLKEkU+xigIM/sphVzDPK9NQ4dtr/z9+Zclq9p
	U9VeY7tWoSf4AlB657ge61XHtpfzssH62jiii+Shu8Z1YyrRNSyH4o5q+ZYL/9GTSVRq9/+hmDI
	6ZmmI+oSF1Wz/iOkEcOZQe/Zzp3B71uQfd8plTszNUo6EDeT5dKl7Ix8DmelcLprmZ/foh/3X4I
	oLBmIcA3wnmUouOe7I8j1yPrmneykzhF22nu2oHyZimenWfcJ6FWMWi8D95AT2bAvhApkw1kx2E
	oJOS1J60FIvMlsKBn51TQHOauGR8MLGuGx1pMhldliAwTGxTwGrLbLoaM2IN31NDlpN0/O/xGdw
	RLp3O4zWSPsh3lBl8At/yNKxRToOpLuL1mwWQWOgHT0iN6Gk8vCc2kP4DQKDerK0uH7G5MO5boX
	JcHcUBOSt2WKm7rlLehXvEm8HNo4pfYcmAtOcO9d2YIHxXJt8di3B/cuQE6iBp3cAtZW7+kQDST
	A==
X-Received: by 2002:a05:6830:6c11:b0:7e6:ed97:ce6e with SMTP id 46e09a7af769-7e9868d2c27mr1014776a34.19.1782256060796;
        Tue, 23 Jun 2026 16:07:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:68dc:b788:b3ac:e34e? ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94424f2e2sm9998156a34.17.2026.06.23.16.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 16:07:40 -0700 (PDT)
Message-ID: <3caf5748-0da2-4f11-a0ff-d3dd5fdf339f@baylibre.com>
Date: Tue, 23 Jun 2026 18:07:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad4080: configure backend data size
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260623090717.3296-1-antoniu.miclaus@analog.com>
 <20260623090717.3296-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260623090717.3296-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 4:07 AM, Antoniu Miclaus wrote:
> The AXI backend needs to know the ADC word width in order to pack the
> sample data correctly on the bus. During channel setup, program the
> backend packet format via iio_backend_data_size_set() using the channel
> resolution, so the data is transferred according to the device's
> realbits.
> 

Do we need a Fixes: tag?

> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/adc/ad4080.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 8d2953341b15..8feb0c7f7fcb 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -698,6 +698,11 @@ static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
>  	if (ret)
>  		return ret;
>  
> +	ret = iio_backend_data_size_set(st->back[ch],
> +					st->info->channels[0].scan_type.realbits);
> +	if (ret)
> +		return ret;
> +
>  	if (!st->lvds_cnv_en)
>  		return 0;
>  

