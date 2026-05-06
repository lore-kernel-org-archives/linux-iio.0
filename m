Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92E4218B3
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069970; cv=none; b=Zftfi0pe9pPIYOGVndDLGLlmdBZmcKr7EHj2PJjZRsUsvSqAoYvIypVQPWf3tI7VzMFrWudxEYar6Q9JAtnO5BWPdMZ3CKSb4/BevsEbka5UvSx1RgtHQD5wavj+S8FU7GrobwekJ329lTVGovbO6Boh0aHvor6ADz33GcT8jeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069970; c=relaxed/simple;
	bh=WEYp9Pc0nIkcN+xiiA1sakOUxmN97k9d9UtFeOmdugw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BY786Q6sHz1/NbTdLYdSpe3V3kl+hdDJ+zS0VzObENzjfs9kvhA5/QS8vtPlgRCkGAOap+b8S/8+C+Oe07KE2H+IIYhqcOEHDaoH1XP4gN5d6Mh7Q0ZG3cLAXAkCCorZMcAK/uOpLNnRhObRuUs42vXLVe7vYtCjOvA52VoX0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0LYvXeq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0LYvXeq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-449de065cb3so4021912f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778069967; x=1778674767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ky0aM7E+PpEfVJyxjQiWZoXt7cbpeu7WIfgg1hOUvWE=;
        b=o0LYvXeqnxoCGEX67GwRVKjo3GblJyccEPOt+tAslGVlejoFPhL+u4tgXdoUNHmE2H
         /qV9IJXutBJwrJqrXR8qSRKNqId8sXftB6HDjVhRp1eMnDAd/epQejCWMoNtLm2sbVOR
         +AwqPCQHJPCIdF6UC/nI4SdTGA2KT6f6FMleA7ycEOpv0OUE8FihTMP2MtSQGeLx3FfY
         LtB1DZ82qsAeaUZAZHERyX5GUAlNp15DL90vP0CYVUox9TwA7xhIF2vv36eUlMJgyCni
         aPwN1m4UNyoeU69eWN8jwDhWCblmykCUbSqthf1vyy+fh8aIq3TCwM63k7xoQjpiHOvT
         F7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778069967; x=1778674767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky0aM7E+PpEfVJyxjQiWZoXt7cbpeu7WIfgg1hOUvWE=;
        b=jTLVu71dL/PMVOjHCrMKkDDlkUlZlHbbO3AdVcXGBVkusImc50OTgjo6vGL/JRDjyN
         vHrt6tLn06FVXpjBcX0ZGlej6XUdUVOhUgVCzrdiHqJneoXv/h+t0XGh9ykvfczIiZb0
         eD9X3xaybo+mQrBg6RUpU3ozVISELAVqKSaS6CbrQizsB4Gu0opTV4XT4FNjRAz5KCNB
         3AylXIZy7MU1M4uVh73ygURhSd/YfPmJRGxNVjXlzJBgD6of7jdGN0Gw2Kgl/B0tILRF
         FYNwlOjm974OcFv7OHz/XzpOT+B8igsDyt4jjk84L4Q6ZxT4J/wZG6wzvAMH2LlxGp/L
         IodA==
X-Forwarded-Encrypted: i=1; AFNElJ8qphaEFBdP7vwZEO0EtKU6gpVExEeCki+ebfcXtoSlXzrvzMtDY1DLYV3qCGFpk0PAptR/bq5qI20=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1wX+Y9tXsN0J1Ux/9S3/jbI/0Ux9rZVoCTaN/9Bp1KXMmY0k
	1L7XDr7bbK06fP7FkMc68NTSoKEkMHrUoFNnoljWGNZEtqIsimwBu1Lg
X-Gm-Gg: AeBDievjGRxWG9IrMv0hWXt6iEIDL0XDMIlLOLQDd9+CiuWWSAdo/mlGmuh1cpr2tU9
	S5tibLK08gYnKJHRp+UDhBveLcs5rxIz3wksKVobOKeMeZLF38FSwiXC/4irozX9v3E84OqUhK8
	e8dzyG9gkn+KkRUbeZnQeGyBxzNBA1cEjAlrUP9H4s2rZB2BlQXK8XZXBNG9I4Id9sjwNpLML1j
	mxROR6Xg9A90MUWYXxdujiO9aYB9p5RGHibx5I6rTamAVqyh/bJOJXCkdQ0Lovos1OLOncaN5Y4
	SSxoQKgppuC6O1AWQBdgUPi6HHnrtnNQ2x1rIQFkk84nFdnsYSwTGm6OzGRBBAHWowq9WxLxPwz
	5DM9oUCk6STEpOKfx+Lk9eBWg7KcHLQJcECJw6+IUsJHL0qi2hPH+JmNXdtJoSXfDMlsWluJg4D
	gBdzYd65SzOSR9AGCS790GNJIl+NH5xubTlP7CfsyL
X-Received: by 2002:a5d:5f90:0:b0:44a:8c10:40dc with SMTP id ffacd0b85a97d-4515b9f3c74mr5875556f8f.18.1778069966515;
        Wed, 06 May 2026 05:19:26 -0700 (PDT)
Received: from [192.168.37.44] ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm12046902f8f.7.2026.05.06.05.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 05:19:26 -0700 (PDT)
Message-ID: <1c02501f-c9f5-4b94-bc9e-a6f1f07209f7@gmail.com>
Date: Wed, 6 May 2026 14:19:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: light: tcs3472: devm conversion, wait time,
 locking cleanup
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20260506094311.222500-1-aldocontelk@gmail.com>
 <afsWI3MKoWZS4mL3@ashevche-desk.local>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <afsWI3MKoWZS4mL3@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/26 12:21, Andy Shevchenko wrote:
> On Wed, May 06, 2026 at 11:43:08AM +0200, Aldo Conte wrote:
>> This series of changes modernizes the tcs3472 driver by completing the
>> devm conversion and updating the locking style to use an automatic
>> guard (mutex). Furthermore, it implement control of the WAIT state,
>> resolving a TODO.
>>
>> Patch1: Converts the driver to use device-managed resource allocation.
>> This removes the need for an explicit remove() callback, since cleanup
>> is now handled automatically. It also adds a new function called
>> tcs3472_powerdown_action() that powers down the chip when the driver is
>> unloaded, removed or when probe fails after the chip has been enabled.
>>
>> Patch2: adds support for the wait time resolving the old TODO comment.
>> The user can control the WTIME indirectly by writing to the
>> sampling_frequency attribute. Changing the sampling
>> frequency attribute results in a change to the wtime while preserving
>> the current integration time.
>> Similarly, if the user has previously set a sampling frequency and
>> then changes the integration time, the driver re-computes WTIME so the
>> previous frequency is preserved. The patch also handles the deactivation
>> of wtime when the requested frequency is very high, as well as the
>> extension of wtime to its maximum values (by enabling the use of WLONG)
>> when the requested frequency is very low.
>>
>> Patch3: converts the remaining mutex_lock()/mutex_unlock() pairs to
>> guard(mutex).
>>
>> All patches have been tested on a Raspberry Pi 3B with a TCS3472
>> connected to I2C-1 at address 0x29. Sampling frequency and integration
>> time changes have been exercised checking the value of WTIME and
>> consequently WEN and WLONG. Raw RGBC reads, calibscale, integration_time
>> and threshold events continue to work as before.
> 
> Thanks for contribution, unfortunately this series needs much more work
> and more preparatory patches as well. I have reviewed the current series.
> Please, follow and address (or comment why it can't be done as suggested).
> 

Thank you for your review.
These mistakes are undoubtedly due to my still limited experience. I 
will start working on them right away.

Best regards,
Aldo Conte
