Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE633ACF17
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808061; cv=none; b=qm3jdSMuuY4LsBFHcgkNUSwQAqTFpqHs3lWfSy2LV2E2xDlVdF1a40EvXYf/4BoP3xKvdPXrmxHO/Dsasga6RizoA9NeNez1H4apbBUEOwM0BzrQBe7B/8fdwAYWtm6Lttp+BAcm56roFIP+TmoIPSmKlkWCPI3ix+6KSv5s1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808061; c=relaxed/simple;
	bh=/c9JtJB4/EwtiTl1447JfgPRLUEGCF3b4/y7pPL6ubQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o955SqyPjBFNBypM1M0b5LDQfTX2IicEAK44L4yfTQdsxr/k4LRNxkcvAfMJORjLmihOeB/4QQJxTGlowAkOe61ywFBvoEBO50dGJVfl9qthqHsTWUda053EZx87pabWQaBljlyk88cKVWbfjFadrvYrGvZTb5pAWQ+l8pimLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cw+C8qvA; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cw+C8qvA"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c7d04890so7921637a34.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772808058; x=1773412858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THD80hlf8XaTsIpSXXAxV527PDB99KYPvzGDQ4EfwSY=;
        b=Cw+C8qvA4Fs0DVqlkJt3CFkYN7nLlHYTuDNo1NVtpBsDSWwRPWqfudChnJace2kxLS
         O0zc3BZoXowhtqpF9mdJFyH181PcYAzrLy66UKdl8Na4TpZ8CULnNgSlhGYheZZsGAnd
         Rk9UKOWPrvGoRuReO3HUQkUEhJS/ZgQAvjW32EToZyqt6fN4YMBLKX1fXevHqxUmyUgV
         g0tJnJsqzXcG3PAKrVR8jSdZ90vdk65te8k8f3Hi5hy8lE8dYnAvS/1KORX81VJzNgTv
         2oSW0AgnaIE9/ztoj73PTUKANMzT+jEYDLjki4d91q/fKnz9PTnzw4rCjV6QOp6bkJo5
         PyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808058; x=1773412858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THD80hlf8XaTsIpSXXAxV527PDB99KYPvzGDQ4EfwSY=;
        b=s5z4Nqa9edHoYEbjKvBDulJMLG8V9fHoKLdr6HKomXwLHO/gyygcuWxOZEOTF7ds2N
         CNT56imdVjTyjHMnaRTEO+QsX0gBr4S5WAe9gth2KsHcvZGcAj/c1vvQSKNwDm66mQ2v
         T5yPGarMefDhNXRK9FtjQLvjxcCO/IcrgVSP+cWk46hGS94RAn4ujE5I7eldl7UWPmn9
         3YaaxkPpjMrzKzJS97++E9EJUJan6AgBL9H4r6SZWaYPU+57zXo5KxRFJ2RtLbeJy5rO
         1s8jnNh5jnmLraJS+DnSuMQfZbwJPdAETyqKKrs1LmJkmrIBfIchZStJUD+QBEWE3Zzh
         4N6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoN47uLIFhsSXLDM0/JRa+nNpWafrGKU4LymikGftuj4RjtiDpIW6N1KS96wYMJv0Uh7BW6P5Tr1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/3JQeSsjsour9DYQVrdsETPXQU+co76GtTWfdxEpuIhZvSdYS
	hPeOmX190Hep19bp9LzEI09wLdNwB4Y20ajnvcjQVZ7Fb4NHs1gGntF2kbd5WOjAE+Q=
X-Gm-Gg: ATEYQzwwHvG/2eEEDN3Kcrh3CogokEt4RbB4yxJuxvo8plrXodTkOt4BmCjElHA06fQ
	aGLhCYiMSgZJ+4wf3POmhMLSj0rOqiZ7zrp/I3U6kuLLsJcgtZ0P/X3CDPw/jYCnv7q1GoUoDqa
	egVji8o6GpCO7/XZCZUS8N3Ri6OsMqA4dNNCcMJmpfAG0egQu6Re5yacVz5vFxL9ekosKyaFqXB
	qNtztzcC+3HT6TNJL1lo8TtQgozxqbi60bNJNgMJu9fT2awIJqYjoQGIKmHSq36lzbaTpjfv+WS
	UVaFyvfUch5MwwgkY2//VtO9Lvlaab1G/CpmGRGLMciMXF8I0QW94999kXswL/WwQxC/VRRl9ha
	49YddA3F+y4dkW+QxyV267VM4PLWOQDrR2PZM+an8MbT7H+OWCp/0H/aTCI/4KvbmDQ0bdFplSb
	GdsX3FTBhtSOw3MucT1LIngGYZdDdTjIWvZ5ZNYhc/3MFJz84jg63GNqM6H4CGDJzR5qoEEhDte
	Q==
X-Received: by 2002:a05:6830:919:b0:7c7:60aa:6496 with SMTP id 46e09a7af769-7d726eee06fmr1527052a34.4.1772808058250;
        Fri, 06 Mar 2026 06:40:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6d78:b98b:fc05:ddbe? ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d728c5b5f8sm1017090a34.3.2026.03.06.06.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 06:40:57 -0800 (PST)
Message-ID: <8a3f7f55-8d76-476b-9768-5c5a3c4a570e@baylibre.com>
Date: Fri, 6 Mar 2026 08:40:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: max1363: Fix leading space indentation
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260306134332.746728-5-giorgitchankvetadze1997@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260306134332.746728-5-giorgitchankvetadze1997@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 7:43 AM, Giorgi Tchankvetadze wrote:
> Fix leading space indentation in the device enum (found by checkpatch).
> 
> No functional change.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---
>  drivers/iio/adc/max1363.c | 74 +++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index d35f4487b2f9..75af10bc37de 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -638,43 +638,43 @@ static const struct iio_chan_spec max11646_channels[] = MAX1363_2X_CHANS(10);
>  static const struct iio_chan_spec max11644_channels[] = MAX1363_2X_CHANS(12);
>  
>  enum { max1361,

We should also move max1361 to a new line if we are cleaning this up.


>  };
>  
>  static const int max1363_monitor_speeds[] = { 133000, 665000, 33300, 16600,


And would be nice to move these values to a new line too to keep the style
consistent.

