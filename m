Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD82D5C7A
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696965; cv=none; b=hrBFyiHJgsXxBnSIXzj4cbu9LmRn65dLTmYD+NxyKOmd9THzJ+500Aeg/tVt/U5wjldQj0HRx6sNfl/hqjJKMzrvWnJoevdj/4M2RkYiUeyZiS6a3Q8/wt173Osmit641t4+/jLGfY2gl151AYzygapCilbDdWHX0HfPot0Lu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696965; c=relaxed/simple;
	bh=zEAiE3kPlRXxoM76UgYmzsJQQa17QofmTRzN3CaoHi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5wWp3EaLGBcjw8byeOg+9wLjzmdigdas53xNiyLVp7Zzs44KPD18CV1h+BSzJS8+tMsp1+52OyYegwEaJC3FRy/ysKzWiw0+qPPC5UBzcWGj6B4MIRckJWhVFXujVpk9rnbu1ufIp/2vq5TtEJ0Qg/FSooNHVEZcTXwoWFg6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fuDX4wiC; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fuDX4wiC"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664c6304683so1082401d50.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783696962; x=1784301762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fq+XFsMldhTIedidEpRwBTF62wZYqBTX0O43nDV5nY=;
        b=fuDX4wiCvJl0OXReHuIkSDOXH13C9wSdo5jc3rUJGhIHNjZC54G8iViCMNtkrIC66+
         yJhaDgHU5p05Zspaff+9tIEwvxFVlnA1BFBPQLSB5yi/ydXo+haTXWeqgIUaZ7gXlu4J
         fpEdX7VvPkEciL+0wUrnIn5Q3RLnCn2WFzfmo4icoe7qPivKTzJRtQ+5Z8ZIyC7skTC1
         NTmMsAi7rkcdK3MkbLEdwJ1+i93sUhDnkujKvpKWt07UI0Yu//NH1340mgOIS4yWDIbC
         7tW1yZXeI/U+1FFBkyLXWvnPIqGPmS1RK2XaFOuor2jzixEef+KNpKOgf5vBtbW3dS3Y
         FCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696962; x=1784301762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fq+XFsMldhTIedidEpRwBTF62wZYqBTX0O43nDV5nY=;
        b=B47VDfUB3reOfGF4ZvKw7QuAKtdiPtPFH3XUk0jaBSNuhE5HmSK3mVkLJC85IvgXiC
         FH2aWDCzbvm+GebYuIZ6db+GRL17Jpi14amh2RE2pM4u7Qe6OxU3eztjdzcdWEsQfCat
         tiNhi1jlVsLk+m4V5EODEQIjtDyFrKb4Zc2HI25g6nHZL230eYk6ybYImYkdCbU/xgZq
         U80UmFd17bO5t0S/dew3pDZD69VGL7Axu1NXv/LLDxfsEoNmRyrY71pEHRA7XEJPNf7D
         T+UKk+p+EtrjSnyVSvNNVkaYDgpFwZOdL/uuEVjMThIWOqpFAeAi1KjeDYGEJzPx1eKZ
         KrGA==
X-Forwarded-Encrypted: i=1; AHgh+RoW3bJklnnrtU0zhjwGY1J7UHPf+N5NBVaYSw0KYI3vtZhpwJsrZQzJvzpexpljfprbsu/zCzg3c4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpqpfopsnpTnHyH1FsSPI/3GFVm3wsY8qKvlV9dFuvQdhfkSd
	2Q/xRoZPDPgYMWBV7ZUoQQhMx78kK2cTHBT/Q7CBRzTMe/zGCwOd1vxOJYTGNWeif/M=
X-Gm-Gg: AfdE7cm2+KuyugeXERPemj4eXtXqUe6+50Hynl731TRD1jBmlRwCaPAa47M43/aCVMp
	HlgTUVtOu9nr69cpTy4VLKv2ZJbTmi8N+Iujl27YBKAA41rfE037jMobthMgf5DomsyFayMGs/5
	ZFJIgg3wDkidBg+E9y5rCW2gXvUzKOzuGhhg8xGBFyNbWjTvim1GMWDWu7moePJf91InJ6+Okp0
	yIoCYPWuUiVXbhmWDzPUdZyDs7RVQRRINmldVMXi5hj/AEJ+38EwC0z77anLaHy20mEmfUuftZX
	tZ8L5eDN8RnZyXTo4vV/sbdB0UfbblbDnTpPCn7nme6s+HyEdqoaRl3xK2x3sz4rto1cOHo75Mn
	hDzHLXn+dqfcKNpGHwtHX63i92S2mAn4lgaRPts93qhELwseZtAnQwnw6gAqk70mh9iChrsbtdo
	r18bFpnVVJwxLdyPEd5oQKwbAVNH56UnsgPNMXdPibiDuq9msCswcbY6/5/hRz
X-Received: by 2002:a05:690e:c4d:b0:667:bb94:18d9 with SMTP id 956f58d0204a3-667bb94431bmr4012272d50.13.1783696961677;
        Fri, 10 Jul 2026 08:22:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1b03:95c:fbd4:4d00? ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c212f14sm47997107b3.42.2026.07.10.08.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:22:41 -0700 (PDT)
Message-ID: <f6e95f0e-2e42-41c5-9af4-977a3a945381@baylibre.com>
Date: Fri, 10 Jul 2026 10:22:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: validate firmware size
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
 <20260710165400.00005108@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710165400.00005108@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 9:54 AM, Joshua Crofts wrote:
> On Fri, 10 Jul 2026 20:07:12 +0545
> Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:
>> @@ -1058,6 +1065,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
>>  	}
>>  
>>  	ret = hx9023s_send_cfg(fw, data);
>> +	release_firmware(fw);
> 
> Why not move this after the if? Keep the call/retval check coupled.

Because the if branch contains a goto and would therefore skip calling
release_firmware() in case of error.

> 
>>  	if (ret) {
>>  		dev_warn(dev, "Firmware update failed: %d\n", ret);
>>  		goto no_fw;
>>
> 
> Otherwise this looks good. Feel free to add my tag with the v2:
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

