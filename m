Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD431A065
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814156; cv=none; b=TE0r5Wtcyu+I5Qo/s1Z7Di2lJl4Z1qY2vfnOEtfIwWjLVPQDrCoM3vDGMtVn2l8wV2GYKZLnQrjEbyVB25VgGUPZxDc0HsFVsg9HA+ZqgJ2G54jDXCANJaeZEm7TVhCOEMW2HY4QU/o5LTW9hiac1Mb47LysDl5I5h6ccAPsgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814156; c=relaxed/simple;
	bh=0vCetBQc/RgR282rGyH6o5vXIBU7+7jTBsdkWgjaAkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9r+OKNSeGi7weivJKtAI5vNto/4zgJAUUzfcgNkS6ap7N5sePwhpwJrwFMrrYGjbkHK8PlhzO/nQ6qPbJog8392HDYe5X3YVw64SQAxtv9sI7R8nPJLGuoiFK2IFpTw3+OPG4FVdnHWBRMdsRleh6AajUQ3hu2KbLoLqBxVpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq0cSHpC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq0cSHpC"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c6b3f71648so18377125ad.2
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 13:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814155; x=1782418955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvYpMoq3VW0fKqjPGnaW7LsX6jXZOIA+8rdGT75spEY=;
        b=Bq0cSHpC/V+OCdzZglYdppH+kal0UvqVlUIgw5THV3RY13/Z0Db3N/HRoto2kffH/p
         YUXiUyrOEXS4bPzCBfjNgzS3HkyFKITFcRAilFrSNkZT5lRHRdsXEsNtBrdo9HawSXJb
         YspGM9Pe19AXhVBQasroCs1NjD2GafZW6ROmP0/QaK3JZ9mZyGlZhcj/7NXphrA+ifUO
         OOKG8rJd5nvryJhNHpi+bryWvBYMgJpIURqHSa6WuSqOuHwDXP0ERQKJbuy6p0T+KQ1t
         T0hzFNLA52iF3j1TgbbD1HJiTpAK+iMCZ2S7PIoPoP3OM3QCgqWQrJogsBvSQYgF2zyt
         T7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814155; x=1782418955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvYpMoq3VW0fKqjPGnaW7LsX6jXZOIA+8rdGT75spEY=;
        b=KW9gklSvoXeC5eMbMbDC2wHoWDggsVdfqd7rfJ5X4Tp0OruNrd+mdwtANZDLyNBIkZ
         ZYonOBXgbj9ydnaXj/m4cSeTRsR4xyLTEjuxp1MO7QMhs78kIVfoQcJRFdLO4jzBElC7
         WTUodxieJFjWbWdDPlUus1aQJHG1Kn4Oc3buCYxF1eosZRMxkkt0saGNu50/ynuiNtKL
         r9UuqYVxsqQWrFYKPSNJgAAHPWPWacZOohV8MTjepPUMa2kd/bK228rUQJfjq9h4RMFW
         wa/Oku6dIH1onw2dFcPkVlDjRdlcKL4ASqapDWf4m8+vaOf5xtC5iBEGiKJoSqAZmiOF
         bi7w==
X-Gm-Message-State: AOJu0YzBrXa5b18jM+JAdzU1NVoLft6R9gljZsas3/QCL/9eQTYiOSL4
	wjnSNwFtRNoD8TTqBRMb6qgVOE6IH2UTG7D2uX5bNQLK0FPKRK6iSXw=
X-Gm-Gg: AfdE7ckz4Qbyyxe5M/CqwKUcSkKqm5TDhu5rrePQJ/ah/QAGUmynMWv3CcWoejuFamN
	CK9UMs3AZOUmJbZo7ZLFjO4aFaecdd25iRR39Ws/zvHAcenV/0Rb+8X1RymbBjIrM2AYeD6KsTJ
	6Ffpl4eJIvcRJkDeZGHHmllscg0ZK7kvsgVOoB0Fe+udCFfY9+NREPju+81sE4BWoiRgdkreB51
	PdY7AeXlEaW04tmWwZtwo8QXiyOcWsD6w+M5fvzdw8lYC1bthrPzFecy48IxUoJuVizkVVBszkw
	Z+BZbqclBuoCZNbHUrCdBNchiITWc6K/kARsHFskuDH2n5RphvBesFHshBWSJDJJ7BbfR7MY2es
	oUftneAcnZkH/NLYnYwdDZEAt7VJRpIw2OrWlVSOvwqz8k8SPglG7fobOGsHMsvgQhq0sA6zony
	wl+Dk0+4mTDheD7BfCDoTABtwwDUljGFgxEyg0BqwgQGO9SYj39xEq5r8Z0w==
X-Received: by 2002:a17:903:1248:b0:2c1:42d2:40a with SMTP id d9443c01a7336-2c718cc902bmr9301895ad.9.1781814155016;
        Thu, 18 Jun 2026 13:22:35 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.62.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c72089c1e1sm116205ad.11.2026.06.18.13.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 13:22:34 -0700 (PDT)
Message-ID: <d8b7df8c-56ae-47f0-9d92-830110511252@gmail.com>
Date: Fri, 19 Jun 2026 01:52:30 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add support for Melexis
 MLX90393
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618160141.11409-1-nikhilgtr@gmail.com>
 <20260618160141.11409-3-nikhilgtr@gmail.com> <ajQpq1yzA-ig2c7s@monoceros>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <ajQpq1yzA-ig2c7s@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18-06-2026 10:55 pm, Uwe Kleine-König wrote:
> Hello,
>
> On Thu, Jun 18, 2026 at 09:31:41PM +0530, Nikhil Gautam wrote:
> Please make that:
>
> 	{ .name = "mlx90393" },
Thanks for pointing this out. I'll update it in v3.
> I guess you want
>
> 	.id_table = mlx90393_id,
Yes, that's correct. I'll add the missing .id_table entry in the next 
version.

Thanks for the review!

Best regards,
Nikhil
