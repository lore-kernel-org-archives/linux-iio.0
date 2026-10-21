Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601581;
	b=MwTfB0p43XvEq/kZBXaSK0nI+aanP6drhDuf2iVjXuecCScgDu673aKwFBR1GIoIOUxD
	 Wb5yx2OQUAX+CYyT3rEvk23Jt7uyvdslVvJMwj+XTnc6nSQCWnJ8d1Q6iJZMxDA7fK0yC
	 O9cDHEyG246Lle7no3MqDfsD7mIDQfaL43F1XiJpAhtZNfI35LLLUHwCVUQubSUwhc8OV
	 HFgcZlbP1NZCn/xkcosttgDPvm659b7z9A2odg+jdowMOZ6liSpGgR6yCKAk/GdXIneBw
	 QsJfaSktS593j3yGIunf2aVoOseQ8HN2BC4N8/y7WbcbjjdGYbR0D8eE5Y9oNVpvGXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pKVlIvSF3bgj4NKmyst/GQOZtuCqamm6OCIrIl39yS8=;
	b=TGNLAFKkBC717yVLBzpBEkEmTI/TrynZQWZmYf82bHcrZq/+jOq4ELYQPeOFeplnpkOw
	 vtR8lmeJClXCUtPxwrbVlrlSNI5Em53NX+UNwpZbfb/sW3oYSgq9vF59c/hgVM/chgoHm
	 0ZItayO3QDXKUtlwPWy7wZYL4/kwuGr3QLVZ6D9p/85nvfyv1/aQ36FCAupWLp7N2Mqoq
	 b3Lxm454j6l5MbHP0pPUo3sue1Pc5qlq6D43ZuDh9DkBfDyKlsg7/wbznG5AuvP7zNLux
	 LnVj0ixHK4LZCVtUBu0yTajUMMokxr8B/iYQANwD0rbVFFGSbSo1p67IREOJ4S5AfXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qmbwvlpD;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F315606A320
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 16:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F315606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qmbwvlpD
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so1193695c88.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601580; x=1793206380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pKVlIvSF3bgj4NKmyst/GQOZtuCqamm6OCIrIl39yS8=;
        b=qmbwvlpDjjnvN+ojyDVZMh4S/iXYFHextf/p4m9ZyuKDJw8yp4XS5IVGfxc7T0kIwz
         HBuaORpQGk3pTdC1lnVV0qHf/leap+KQONIw/DTJpmbK40VFfvr0Pq7U0GS+JIvTgXEG
         2YquSH2LTMrcpTsI3MreKRpqLGekFDCqH9eVgfchdHPNBQHlWsB+cGebsi/zY+9vSlo8
         rJJxdvmqHFAk1xm0RwcKaKhslv0n643FcuctDdz9lZgj6/Lu7IZjhMO6EW9HPjdXR7Rg
         HlFF9KYbxy96QZGw6Mrl1K7YoL5YKGEwyI/Rjfgqu/FynbzUzjspX2rWXDL4KgmmIyac
         Wx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601580; x=1793206380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pKVlIvSF3bgj4NKmyst/GQOZtuCqamm6OCIrIl39yS8=;
        b=gEahIJsq5sTCEPcO3W3IzVKj4zf9THaNgvxoYFv05GjNdYJDiDACm/ndBH9N+0r2Nn
         l/t0YnSSUjvU25B3PGX3zDjTBffjudnpDDf/Bocr2dFPcXqsZjfcTHIJSkK3snZjr4zO
         IDIuy8Ht/BxRjnSQkNLOOjcjWH8dHTlXxLYGPB1uOmJvj4f8WKZXBN/OR5p/dEG7eRc0
         OtXJyBITKqlIycGyq0n5qSkasVgWpBhxlxdjHMU+WvqIBCF/yMlc15Z5FPKJkGKLv+qg
         eDLytF6kwqjTL2EfKbzTjkKzrjyq2zFpZ8uo3phIzzNXCff7sQjogWueI5lF2kC+01R4
         3FmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfpFw0IfGJLTRFYtaKdTysJ+ozOXVbqj8ijSrzOwDsjrN3tz5nNmck5BpC/2/Usvo9ZcUDbOjb0Zg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIONznPZUA4kbfXrZPpo/NRhiZP93h+N12h4VYJeqXPtH14+kD
	hj83/62NI/Lyll5wyUB5N4hEHz08z0yLxeW30a8OdiMgjnTFyNjFpgHm
X-Gm-Gg: AYBFou1etm1IzVu2QrqHtDWo1S3ahW1ekohfrIqme+TxavR6WST9cmO5JUAhaOxUR2p
	avl/6u/iQ2qWDC6vLQRYEGDoeGbpW5xdMI84Cldhla80biixcabLlrSMwaNorAm43HTVAjY1zaB
	/z0rjbNlBlfGC7jtt6VDqO6svsqqqtVvln9ctmL3gghhL0s7vdiacF0vxqobHIjhMDJ31AHOkZF
	8XamYHrb4NY5Q+ehyzzUf09u3dNdbsIJqjsU+qBub3OmfbmyziT3s+j/Z8FksoMOqsWP804Ijll
	IbiNxvE3AhIxytUB5ZrMKbcYxK4U5YeT2IqwMJM4gAEeLEryrGtms2utjyaTuQ3tsCGh2A0y8Pj
	8c17tZwPKWhmZRt/ZkucpiI+83uy8BqX95CqRZzVRc0KEMIXMB0ptdDCPDRvYLBE3wd7bq4gwGq
	iFXtu+TpdQHfKS3pjT7R7E6UOTHpvkPGaf9TT9+qBBU5uy4DHHk8sk0h9AyHGSNuDW7wlPs+rfj
	kud/MX7zqsfcy9n0t8OMHxd2WlD3xKUYB/gWmps8AsFGD8gpxylLMWPqVT+EciuEht5Vm6GGHpM
	eXIIPYCUozzLUjgnVgC44A==
X-Received: by 2002:a05:701b:260c:b0:18a:6c40:1a35 with SMTP id a92af1059eb24-190a4e0f52emr2922497c88.20.1792601580385;
        Wed, 21 Oct 2026 09:53:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e02901fsm7779991c88.22.2026.10.21.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:52:59 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:52:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, Rachna Patil <rachna@ti.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev
Subject: Re: [PATCH 28/28] mfd: ti_am335x_tscadc: Remove redundant
 ti_tscadc_dev_get() helper
Message-ID: <atjtywLzWKxoddD7@google.com>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-28-lee@kernel.org>
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
In-Reply-To: <20261021121245.3111563-28-lee@kernel.org>

On Wed, Oct 21, 2026 at 12:09:50PM +0000, Lee Jones wrote:
> Now that ti_tscadc_dev_get() is a single-line wrapper around
> dev_get_drvdata(p->dev.parent), remove the bespoke helper and retrieve
> the parent driver data directly in the child ADC and touchscreen
> drivers.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c           | 2 +-
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
