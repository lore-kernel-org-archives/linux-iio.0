Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DA2765D7
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787509778; cv=none; b=qLArQgYNiAYgdJFd0PBS3nZMYyRprcququXEvUTteFys+MavCA6vAx2bCH0VLtR/LTARMhKKz8lV/lDeWuupC31W0HL4zwZ+R9Hp5tyO2NdvwPK5PBOOlcBJ42/sGtq7b80Ujn3c8CH9YuXvLjAPIORt1lKlmqGyP0UXdO6/568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787509778; c=relaxed/simple;
	bh=R8Hc6noLelEsApZK5qb9i50lk78dKe0CiyLEReg9/Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h7OocIhRYoUURo2USHkfio/K7M2JNKQ+EspvC25v9pFUAB7YAzNwfbE1hOEkNTghTOZs5lG/ZnxOK0HEIrmxwQ3xBG7gn+5x5H41qa0/eKiGyxVQ3atbnDZk3JBjEcB1aIIxXyhgRIuZGycu6Wd1lrB+bkPyMwyNykt3TeS+s9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=f/ffq9No; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="f/ffq9No"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-446f87b6de1so3995530fac.3
        for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787509775; x=1788114575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PwVbbct/Lw3Ar4yPDA0xTDROCNpyH8W4YF+42txm7ro=;
        b=f/ffq9NoWAvVBf4MgPsOPuMH42NJkKKGD36sXvTHsJ6iyIFFI7CmCaLEGzJORLgQcc
         akYMmIOv5BXBdSSn87uQepSjZd3efj2460yRKaPJacn4QV2L5VjGo4ijF8dq5X11E1ub
         52H/JIJiAe2i+J29CauXZfpL9X1Hh5TI3DGFmT83QvHR7QGXQqLoTs3Kb+7cnNiSAfi3
         7l43vNiLm691oeJLjIAuIKCu5N59IIqlJ102NrpzEc/r/URrxF2g/Gjh2ccKBPjUzuNs
         s84U8gW+nkxOeURgAi7Q1+vcZvkj3lHMyHQX2iUJ+YvFK9xEeATM3lUCNeI63Ggd9gY9
         8PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787509775; x=1788114575;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PwVbbct/Lw3Ar4yPDA0xTDROCNpyH8W4YF+42txm7ro=;
        b=odCFuMNpP/bsggQfAIT5H5qPfYkiNRSnnyqqTVOBmSmYWbIsfSNoFVHIPP02kK2BY+
         S5df47due22OAwOX6XF/8yx4Z6nkXi2uq2tNeCc23rDK8lN3yMXEz9kqjkplK0nNcyVk
         Ojd2CRTzTRLewL74FTOA+PRUUSCrWfXchmjzryUgcbqLZwHDAc+5AHtPLxG/G4UensjI
         hrzNRy8PtRFC32joiDYrgMwErDjKzp3GVZv9wYDuFEYd0I0OHilbqsGehswwLTl82XvS
         dfiiwYYKBmaOzKIbLUhfPvg7QuFKAbmNs8UWZ8sEt+1uylTXanqXKm4CLMWGXSFU/yam
         Fhjg==
X-Forwarded-Encrypted: i=1; AHgh+RoM3JeK4ETvFoSNgnv2tBnfeYvBQxg+J20cuiZ9OiflXM3JiGA63JH1HE8bQNak6kUxdecTgkpN870=@vger.kernel.org
X-Gm-Message-State: AFuF++l8DrnuYJXSUXc6qTDYgiw4+M0zUp8TX/yt8/NKPzpg1o1i/8En
	PNAQVxQrPukdHNyINCciNE705tK10/RH6KTg6WRG9p3aX2JoeYn2yYpiHj4pZxq47CQ=
X-Gm-Gg: AR+sD105zqSqGfHDsuQnThdi3RA2MrYWEDQ2FlP+ypUnIFQQu6OntsP1u8S/ldjQNlx
	2I/pJfMghDJU81xCmWmlLe0Yl60jhZXfoh4pQQZHGAzhULTV7TwdkTNSaS4V2akp/L2e8IF7n/e
	MY4RxfAvUXrpOGASUrhlRRKZt6g64ItroX2jCcyUMKzH9365Mi9m8zgV6Q2pC+DsINHc/BpR/0y
	+KNyx6Yx97wwZy6qkg9kYkG1hbj2PrBO9mWy+BXTszNiKJFJt3zobxdqHkYQgUSn2pmoqp+50Og
	oTwsiy+YutvSLuDL0zItOtwU02TqWQAFRCHM5RE86f0uCcoKvjhjN7J+Bi76k1XudeG6Gco4i99
	e+F6ofC3JN4A1WbN9RKQLKD40RMNiuFMkfFeXOdSmR7gzWSBIMX+SEIjE2sbIiKDzmw8Ag1yVhW
	L0TtdJ/9BUF4nngw1WdbAr4I5cPZ7/SvYbIhl9DoXJqJiZC3Ltlfm4H7TyIyS7MkxclCrvXjsXB
	nHdclAUrFfU1q6xSpTKBR+PWEx1qjVsP254owU=
X-Received: by 2002:a05:6820:151a:b0:6a1:47ad:d18e with SMTP id 006d021491bc7-6b159199686mr21356582eaf.2.1787509775218;
        Sun, 23 Aug 2026 11:29:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e427:2c2b:7b9e:e073? ([2600:8803:e7e4:500:e427:2c2b:7b9e:e073])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4638352cba7sm3481549fac.13.2026.08.23.11.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 11:29:33 -0700 (PDT)
Message-ID: <0b03fc0f-8032-47b2-ac97-f2d93c1c5bdf@baylibre.com>
Date: Sun, 23 Aug 2026 13:29:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
To: Salah Triki <salah.triki@gmail.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux@analog.com, linux-kernel@vger.kernel.org
References: <20260823045205.25554-1-salah.triki@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260823045205.25554-1-salah.triki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 11:52 PM, Salah Triki wrote:
> ad4030_set_avg_frame_len() computes avg_log2 = ilog2(avg_val) before
> validating avg_val, and the subsequent range check only rejects
> negative values or values above the maximum supported OSR. It does
> not reject avg_val == 0, nor values that are not exact powers of 2.
> 
> - avg_val == 0 passes the check (0 is not < 0 and not > max), so
>   ilog2(0) is called with an undefined/garbage result.
> 
> - Non-power-of-2 values (e.g. avg_val == 3) also pass the check and
>   silently get rounded down by ilog2() to the nearest lower power of
>   2, so userspace can write a value to the oversampling_ratio sysfs
>   attribute that does not match what actually gets programmed into
>   hardware, without any error being reported.
> 
> Only powers of 2 in [1, 65536] are valid OSR values, as listed in
> ad4030_average_modes[]. Validate avg_val fully before computing its
> log2, using is_power_of_2() and requiring avg_val > 0.

There is no rule in IIO that says we can't round values when writing
attributes. Users are expected to read the attribute after writing to
see what actually took effect. So this patch doesn't seem justified.

> 
> This issue was identified with assistance from Claude AI and manually
> verified against the code.
> 
> Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")

Actually, this could break existing users that depend on the current
behavior. It certainly doesn't fix anything.

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes since v1:
>    - Added note stating the issue was identified with assistance from
>    Claude AI and verified manually.
>    - Removed initialization of avg_log2 at declaration.
> 
>  drivers/iio/adc/ad4030.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
