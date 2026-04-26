Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DE1A073F
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777231756; cv=none; b=LHKqtmszxFZmxN1QF2kn/rUpsGuYbJMR5f/luJGIC6DTwCT7jA4/edeffNMpxFVb1dh+lWl9o6bBmBkJ23px9VB3KDOirGQcB822VbBoIJ7CMKcUpGlUhd+19qG9LWTvNmcuwG0Pf12Oqqbs1XRNuJTJj7zAQKsJqKtNkT6UefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777231756; c=relaxed/simple;
	bh=POpQMQBlE295LN+3sTMuYYH1WfIvOJPxoW7QTuXQYEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Seln3ifIeFwqmZR61uTJuoQhSIMaOLuKKyl247wCZsViwOAiMWiqSk3j26/v36gG4bGhz9a5pkrP6835SLigpN/pCfcm6eykzkygQy3T0zfu6+KXlgXsHPLme9/z5ZcqJQUmcK8SrBViSzdcVJUx6oa6sGS0wlW18ZEagA02te4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=RNtFAEl8; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="RNtFAEl8"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6949f3eeaf6so2195031eaf.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777231752; x=1777836552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xO6idpzKV/hYgG6KlKes6NFUVxMLSVYmIDt1/xiipIc=;
        b=RNtFAEl8EtiIQUwBNiCz35H1bOOozhNTawm8HhQVdlrt3FF4CkMCG3UdLzy3dj5/WD
         rs3oQYE2SfjU/axAx4FX2MmLr/KehTJ+F3ClY0bQnxr9e5Kp3Iv98fra9UUtU0PfZ5Nr
         3zZJpx2cq4QXQH+bnybBh3uqhMrInJrlsOjHSGRpbK+TQCoOsVm0CVEFgivZXdtWT6fb
         6V2VzppWoPQBrlquFJ/9In/73S7FmczZ1lz2Sj512l1mBeM4MaFjkQuI8w4QVa9SSry/
         EEewDAGeTE2X159pQpJF/oZAIXQj5S1j0eQnkEwPLpfC1oIDRCCVQiOb+a36gDNl9bf5
         37JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777231752; x=1777836552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO6idpzKV/hYgG6KlKes6NFUVxMLSVYmIDt1/xiipIc=;
        b=H1kHGwd3wpuSMvYBENlIqmVAHDwZVb5Yy0zCchNF3mx8WZt6MFTUMsoM1YsYk1Xx3y
         BM7jVhUayf7DJ3NXmx71NtfwQsaicHC5OYL/37ASc5jTtu7ieidDs20oKjkr29u7dQGh
         LieCRkiG4JiM6lAiJ69C/PjW9t/h6KN8knk+wBkhVzY4Pia/NN8aUXGE2vipJMz0Gy7y
         10azcJesYCgt51JgQ1c2iGrZhHuVc1xnhtlnjJACGR4IDVp9aN13heob4Qc1XKqusogH
         ugQ0EY+addAKz1TAF80npZVLbMj7MSeTDRMBW0xJ+eOm9NXyyPCnBSfaWwE01foU8x5g
         xWEg==
X-Forwarded-Encrypted: i=1; AFNElJ+Q3zdEdMWZipDYfFOblTbohm/mi0YvPYm4N+vRjurd7xhANZ3juah6ugMPNV2QwdToxxEHLk/tc9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPDIjjwGqcxej7npkFg2DvoGIlmwHy+NfmRIfbirO8y//FwGH
	vOsymj4nlXjCjRIjlTBS2k6PhVFN9qRW9VrfFrdmeiWqiyztlVU/GLXz5teuXiqIkrM=
X-Gm-Gg: AeBDiev1aZm8O68MFY2qKjdcod83mJONK4CQgflbbrCks9u79m/v/iXd8LjOhmlrAxo
	ulZB8/OPhKZvMjnNyRnxlz5VnBb9nr397GgWS6H+J2exGF6hB8Y+4bh3PJNT1Ma0bxbJjL98eXC
	YZ1Sio7KRscifulVyKC1Q9zRVZoUGc2oUDPhCW9moBm6dChXDUrS9ZGy6SdQH9P8h15kmSaMV1i
	zAy4f2ibWuIrASSJ36FoNwKfyTed54nksCKgGw3pVLZLQOPvuYjPohiv+j/4dqKcjs5ZxYkVpe/
	toF1iqdCdHwxM9Sh4BlGLrdQzco+NuC9EzgYYsEiGXiyr6ujome+UUKTvzitwTtmyDOmQv/JjN5
	PIA2sfbv0z4iv//RaBGXW43G9pCoHlzQnaGyBpi1Yv0tV0886Tt3+RMH09OU/F99g/9xdTjNvCs
	s6teITEEWJ5Km74fpUXIS1/Itti4FNrPKNRKeBXB70VDXQ6kF7gmUNLpYt9tKXawoekIYPum2YN
	R5RcZ5HOMgT
X-Received: by 2002:a05:6820:16a1:b0:696:2c6f:b99b with SMTP id 006d021491bc7-6962c6fc187mr4200872eaf.21.1777231752445;
        Sun, 26 Apr 2026 12:29:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:81f8:ef7d:a711:d99a? ([2600:8803:e7e4:500:81f8:ef7d:a711:d99a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464e5e58csm18999415eaf.1.2026.04.26.12.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 12:29:10 -0700 (PDT)
Message-ID: <5e974f6d-2e08-4db5-bab4-2ebefc050e1e@baylibre.com>
Date: Sun, 26 Apr 2026 14:29:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: light: tsl2591: simplify tsl2591_persist
 functions via lookup table
To: LucasRabaquim <lucas.rabaquim@usp.br>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com, andy@kernel.org,
 Matheus Feitosa <matheus.feitosa@usp.br>, linux-iio@vger.kernel.org
References: <20260419003557.45287-1-lucas.rabaquim@usp.br>
 <20260419123604.591dc3ec@jic23-huawei> <aeXZY2Nj71Em7Z6y@ashevche-desk.local>
 <CAOWnv8HjVGVsg2d8kDt9LyUVp-HbnaWzAxZ_6egw+KtNmEpv7A@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAOWnv8HjVGVsg2d8kDt9LyUVp-HbnaWzAxZ_6egw+KtNmEpv7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/26 2:24 PM, LucasRabaquim wrote:
> Thank you, Jonathan, David, and Andy, for the feedback, and apologies
> for our eagerness to send a new patch right after the first one.

Another lesson to learn. :-)

Please don't top-post. Make your reply inline in the context where it
make sense and trim out everything else. (There wasn't much to trim in
this one though since it was already trimmed.)


>> ...
>>
>>>> +static const struct tsl2591_persist_entry tsl2591_persist_table[] = {
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_ANY,  1  },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_2,    2  },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_3,    3  },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_5,    5  },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_10,   10 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_15,   15 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_20,   20 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_25,   25 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_30,   30 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_35,   35 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_40,   40 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_45,   45 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_50,   50 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_55,   55 },
>>>> +   { TSL2591_PRST_ALS_INT_CYCLE_60,   60 },
>>>> +};
>>
>> Instead, make this to be an index of the just an array of u8:s.
>>
>>         ...
>>         [TSL2591_PRST_ALS_INT_CYCLE_30] = 30,
>>         [TSL2591_PRST_ALS_INT_CYCLE_35] = 35,
>>         ...
>>
>> ...
>>
>>>>  static int tsl2591_persist_cycle_to_lit(const u8 als_persist)
>>>>  {
>>>> -   switch (als_persist) {
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_ANY:
>>>> -           return 1;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_2:
>>>> -           return 2;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_3:
>>>> -           return 3;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_5:
>>>> -           return 5;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_10:
>>>> -           return 10;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_15:
>>>> -           return 15;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_20:
>>>> -           return 20;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_25:
>>>> -           return 25;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_30:
>>>> -           return 30;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_35:
>>>> -           return 35;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_40:
>>>> -           return 40;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_45:
>>>> -           return 45;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_50:
>>>> -           return 50;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_55:
>>>> -           return 55;
>>>> -   case TSL2591_PRST_ALS_INT_CYCLE_60:
>>>> -           return 60;
>>>> -   default:
>>>> -           return -EINVAL;
>>>> +   int i;
>>>> +
>>>> +   for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
>>
>> Besides the style of
>>
>>         for (unsigned int i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
>>
>>>> +           if (als_persist == tsl2591_persist_table[i].cycle)
>>>> +                   return tsl2591_persist_table[i].lit;
>>>>     }
>>
>> ...this loop now not needed at all.
>>
>>         if (als_persist < 1 || als_persist >= ARRAY_SIZE(tsl2591_persist_table))
>>                 return -EINVAL;
>>
>>         return tsl2591_persist_table[als_persist];
>>
>>>> +   return -EINVAL;
>>>>  }
>>
>> ...
>>
>>>>  static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
>>>>  {
>>>> -   switch (als_persist) {
>>>> -   case 1:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_ANY;
>>>> -   case 2:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_2;
>>>> -   case 3:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_3;
>>>> -   case 5:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_5;
>>>> -   case 10:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_10;
>>>> -   case 15:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_15;
>>>> -   case 20:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_20;
>>>> -   case 25:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_25;
>>>> -   case 30:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_30;
>>>> -   case 35:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_35;
>>>> -   case 40:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_40;
>>>> -   case 45:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_45;
>>>> -   case 50:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_50;
>>>> -   case 55:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_55;
>>>> -   case 60:
>>>> -           return TSL2591_PRST_ALS_INT_CYCLE_60;
>>>> -   default:
>>>> -           return -EINVAL;
>>>> +   int i;
>>>> +
>>>> +   for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
>>>> +           if (als_persist == tsl2591_persist_table[i].lit)
>>>> +                   return tsl2591_persist_table[i].cycle;
>>>>     }
>>>> +
>>>> +   return -EINVAL;
>>>>  }
>>
>> Ditto.
>>

Here is where putting the reply makes sense where we can see the
relevant previous discussion above and the new discussion below.

> 
> Regarding the use of a u8 array indexed by
> TSL2591_PRST_ALS_INT_CYCLE_*: we see it would work very well in
> tsl2591_persist_cycle_to_lit(). However, we don't think the solution
> applies to tsl2591_persist_lit_to_cycle(), since it would require
> another array that, to use the index initialization, would allocate 61
> memory positions with only 15 relevant values actually stored.
> 
> We thought of the following, albeit possibly fragile, solution to
> follow Andy's suggestion:
> 
> static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
> {
>     if(als_persist > 60 || als_persist < 1)
>         return -EINVAL;
>     if(als_persist % 5 == 0) // Valid values between 5 and 60 inclusive
>         return (als_persist/5) + 3;
>     if(als_persist < 4) // Cases for 1, 2 and 3
>         return als_persist;
>     return -EINVAL;
> }
> Otherwise, to keep the array indexed by TSL2591_PRST_ALS_INT_CYCLE_*
> approach we think it would still need a for-loop based solution for
> tsl2591_persist_lit_to_cycle(). We would like to hear your thoughts
> before committing to any direction for a possible new patch.
> 
> With Best Regards,
> Lucas Rabaquim
> 

Personally, I would go with looping over the lookup array since there
isn't a simple formula that works for all values.


