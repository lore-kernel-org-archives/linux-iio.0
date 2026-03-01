Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62F301472
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772403182; cv=none; b=Vnk/L2vty4gu/jMFX5B2RX5+h7Ax2pV0KJeCgD+IE3dQNYbbuQelZEXYy4ywq4MHh8v/18NkYhgQAxHPxTGi4JE9Ike0+s/P7oRwRIy725d+8zbYGcp9uTq7dd3TvhptU8foM1IaM6g+v9c7g3A6EbUeaRW4+Js0J4vqTwZ8pss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772403182; c=relaxed/simple;
	bh=xF5U2dWpirnXZi5IzRk2tCjBpbbkXFLPIm9/tdPDn/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qn9Tx77f9pmLXNIdhFjANnS5bNECa0Tg0qj6qU32Yeqdv/hKEgnjyyhQ7blHDTcSbLgGbIUNI2XvCg1S6wbHn9JVBhBcZSe0HTzIAkdeAWQnBqEtd0/spzvuk3U0LObypx4yitmwFeatqOLj1DuCghmQN9sB1ZvGGkcOL/0D/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WW4Zb3o5; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WW4Zb3o5"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4648447e29bso1550102b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772403178; x=1773007978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=teqasxvRauJYkxOr6gI0GhxAVEgI4Si0h9bfm5grL0E=;
        b=WW4Zb3o5wMsHdGCX6W+oy37RspLOYzdRswXbGCQ6BW1UdzkoidN5jok5wJtvZi7a20
         OFwyONqebfynNQP+Id/humhrd4ALLKXt8wBTD3IWh4m0q0fa3mCVruqCssE+YtS1pAZ0
         /oLYChl8N0/QtuAN1gOUlmS/K2F1qTWIBS3EhZPfLbGXZWU5WTn53Hcd+i62XjjS2EPP
         5CsGYJhU0Ekh17+WA2Kh1DfpDIQgfCWqWBsy1pgyGYloBdDcZjFFDo5If7uPdu2smuAj
         tGHhZRSFvJxFJqoH7viJkN59dJvjPqVFycasSOXBVLIVa9KG9ysi1XZkadCpeMZmC/Lw
         0Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772403178; x=1773007978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teqasxvRauJYkxOr6gI0GhxAVEgI4Si0h9bfm5grL0E=;
        b=LBxVH1eZDxOgVTvNlT/grkbYV4jJZoIkebwxNVB8Y7tVQitUuyoLEGYvxVjKZb0c7M
         Nxv/afIKb1V4FmExx8hV8amFF3BGpSrRuMkgt5hjqm9RtpL5NLMGW5P4r9q6iMmc+OW3
         tv7UGagkxbUtUAvE4jajQr6b0FfnPW4dLw78Jl7gr709x759Boo3Q/EzO+3xcB63oX0V
         mgvun561TZ+tu+0Qg7VUURLVqcbHL74kUhaNCj38YjdoQpHW8n3YHB5BcrnAcSZGCPN6
         ox3qI2VsOB5F35Hau2r6Hm4yw/uh9gEH4QEKMWsLIsyIeo/FB/4tiqPzGiuMmcyS8oXY
         m/zg==
X-Forwarded-Encrypted: i=1; AJvYcCWLdhubA14Kk6Y5uOT6LPJtknDO7XQ+y3pG4GVhCzga7V7ffoJuYcjkSFWBTtqMdpKaX9ucwZj8qZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5JdmremfC0KyM/ZSAO4sEYKcp933C4CsprzxAz2DBSQhmVEE
	R6N3cdkBf+BPFrPO2Wqqpql0IuqkgRPWYbO/f1caAeG4UAJRBR78Oyak0t0qvFl7U/k=
X-Gm-Gg: ATEYQzxjmD58MJ9P6OhO1Qcl+wBqf14O76SRO45cudwlDwkI9z1AhdSLPVvSxkVTi5J
	uxdRARdUyRK1ioyyatMtG/D5gsVHy7pJ+ngQEKoqloUvQgPIjtFfj9U0nPexoEY7XUroy7sNU5x
	bwULmx9dnDkmepErkbXThH0cEMDkbidtcZM7uhPEVj52MAf+kiyXzzRRRYnwiI5BHSArfY/BG29
	F+YeZ82A/F1AFaAHqNM0/xW7R5QTM3hPRQON88oPlpALGGA+m3gAqu6UkBQGhhQeC374WHuacb4
	oqVIjlSMx0uFiMsAXFI5aCqhCLvVnmlyWnxGf3oRR4ZeRCWXmlgx1uQ1T1qlrroq7zzk6DpjW8u
	+QCBKJGfaRs5YEnb3jCLKSL4Lsu0NTTsvm8z+S01SLyE03j2vjIFNoRpTPtQyilIplrbzaHv9ME
	t3iE9MazilsZ574NrFJiRFU4OpN4AJt/HIOxqgrwjNIFf6f6gipizWbkotICBzTmuj7WmzgcUW0
	A==
X-Received: by 2002:a05:6808:144a:b0:45c:881c:e0a8 with SMTP id 5614622812f47-464befbc11emr5242555b6e.61.1772403178525;
        Sun, 01 Mar 2026 14:12:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8b9c:d657:204d:5a5f? ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf259a7sm10330710fac.3.2026.03.01.14.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 14:12:57 -0800 (PST)
Message-ID: <f99052a9-0b56-4257-94f0-f1eface9e838@baylibre.com>
Date: Sun, 1 Mar 2026 16:12:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: orientation: hid-sensor-rotation: use ext_scan_type
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260214-iio-hid-sensor-rotation-cleanup-v1-1-3aec9a533c0f@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260214-iio-hid-sensor-rotation-cleanup-v1-1-3aec9a533c0f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/26 3:25 PM, David Lechner wrote:
> Make use of ext_scan_type to handle the dynamic realbits size of the
> quaternion data. This lets us implement it using static data rather than
> having to duplicate the channel info for each driver instance.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This is something I noticed we could do while looking at an unrelated
> bug. I'm not sure I have hardware I could test this on, so it is only
> compile-tested. It would be good to get a Tested-by: from someone before
> applying this. Also, I'm not sure if 8, 16 and 32-bit data are all
> possible, so if someone knows, please chime in.
While looking at some bugs in this driver, I found in the code where
we can be certain that only 16 and 32-bit are used. And I figured out
a way to test with /dev/uhid. So I will drop the 8-bit case, test it
and send a v2.

