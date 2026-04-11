Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404130EF92
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775932732; cv=none; b=ttURTy/IJziyMAuDzTkEw47BqztX6TJ4/bTBSgUVkfCALTy2HSVkS3dwUwK0HJf5i5Q5nFyo3FtK1CoqGDiP8Se26JrnOkc6cqxXw3+Y2RMAijSFAvp0v5K3a4FdJzDZklt63ve0G4U8bgHkdeuv9kf9Yn4icmwtW96venMY15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775932732; c=relaxed/simple;
	bh=G32kimuHQulcIRtvbX70KIJe9/8qb/w1NZjaE6M/Yag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmuELtFj+LeppiDdoXm82HNyKEC4dgzbN/MxwzdmruMSMzOmLGKBnjo/kojW5ruZGJ0DVm+gF9H2pxYF9sWHTbco6En2u5e8wKxXLolSlsYWl5Kg/OZDrsNlW+mQbyWwTJtKwSpMYYdCkTjZB5zP+YCx8REUuxkDcv12w2jT0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Qgk9QQbI; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Qgk9QQbI"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-68a2f93b42eso1137945eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775932730; x=1776537530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvRlNKmzBLvAqyEhUGRKAEPOoty+E4bUWcZT3jLP1DY=;
        b=Qgk9QQbIPSgsGrhzywPBaAnO+mM5pC6JvlrRsIaOhcjTgvsAeZVQyJCohDg2lFUcyp
         WGdndSTQ2+vq54qI+n9vvShY4AaFlUSkZzEowW5uz5FdksMFpMwoBZ2h18aZH1q3KAAl
         NuLmnteGCSvhL8MJGJOySU1lWIwng+/oMeaFPDsb/U3moIGAr19Iz8Dxnuc7GEk4XYXG
         vz0Y8uxfsa4spEvXCBajLvDIlzg6NsmVzFHP4wzAJpcdq4FmRw2VYsSC19cML60sFAMO
         n+SvhrcFzKgqn6rLxUERspmTcB3ZeJ17EiMObY9/VzVeUPzx74oraMFNNQUbbzv1k5l/
         Wuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775932730; x=1776537530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvRlNKmzBLvAqyEhUGRKAEPOoty+E4bUWcZT3jLP1DY=;
        b=S3n3X2+VEk/T8BMl1/zm80OYdvS8YMcYXifRAtf/W86AFDHAFE6mD2HaquSwwVUA6q
         8/al3Ndjat8YEAj/syvTQwpRYGKii4g8w3I1DVN4cNlVULnZMz5V93LgamhDAagTe9F6
         /O7IOB2HX+IaTN0P+MT4oV1bADgL4bWKBQPDtKUB4aYoHZqfjtoTbQ1jbLghO2U1U6QO
         3zr6FlXtett1tsYfjz6pErf5EMUMkTBh6IZXy1evHYSRDCAF616mHxI3lbI8U6LavXzS
         Ldv0z8YN8I8H9cLfORiAdzsSSp5UekP5b4YiaKiTaxKOTf/BBdbvAsgUhqrCHkTAhecL
         QPsw==
X-Forwarded-Encrypted: i=1; AJvYcCXb00XcPLHZAnCZCdcYTpLvN560hfh9IO8QZbOjorrFU7XrAXvCQgh296lpb0ujOwsTm2vqRedXsHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJs0FbySjSbsRsjYbIjI+OUQPoF6eYgCTvwQH5Q68LiruOYJN
	Nx7hZKUmKIJ3DnHnvcSoLGQS1W+ZkGURjf3ljanyEgTMdei1D82hdeG+c/Krm8auCLU=
X-Gm-Gg: AeBDies2itBbWzZ5Lk4/8sFWX+JnXcJpefMoDAmkPvSPv9SGtMtGx7r21BXRefFEjZg
	nXXf2ACTTGqLEiUuzVHiN1AP7f5LyXPNXncJVaCBOW8O1AMeu5syZABcUlBfWvGJ+qyr1QFcNBf
	vlCEx0QlS6Ka90x2noVFu2RcYeXDbs29OVplXTttxD9lVTkIZEgTreCISF0/FWy9Z4D1KirDgkT
	xgTk3dXZ8BqRQv0FCTuOsQGM/uiMoS/frrH28jNNNTi8ksHYH8F8dsEljHCmDAf6MB3MVyZJIrL
	WKLX6NVuPzeG1RDN6NvCYaRHTFgghBILDjenFQmrvHCQ8B3PxTVL4Dz1ffSvhpTDVaoeF84Uf9p
	pXzwPBQdZ0kB/OPeWBsu2GM9C+6vY2G9Gg5YPIImnp8HrRzlc1S9/gdJANHMUxwxwomU1wueOb8
	V52e0gmB7mbvjXTrWHHL4ryVIMuKRS++ylpKbEDlbctx7hgrxM8Q3SRUeqeRmkEFkSd0ts12jxE
	w==
X-Received: by 2002:a05:6820:c086:b0:67e:2fe1:2764 with SMTP id 006d021491bc7-68be7de90femr2387447eaf.36.1775932729767;
        Sat, 11 Apr 2026 11:38:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d2e5:c81c:5b23:fe55? ([2600:8803:e7e4:500:d2e5:c81c:5b23:fe55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb20c0fsm4808905fac.11.2026.04.11.11.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 11:38:48 -0700 (PDT)
Message-ID: <693b0f48-9b2f-4989-89ff-280e3a9e1338@baylibre.com>
Date: Sat, 11 Apr 2026 13:38:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise
 math
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Dan Carpenter <error27@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 gregkh@linuxfoundation.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
 <20260411085848.75381-3-joshua.crofts1@gmail.com>
 <adokoNfP-Ueg4yQ7@stanley.mountain>
 <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/26 5:47 AM, Joshua Crofts wrote:
> On Sat, 11 Apr 2026 at 12:38, Dan Carpenter <error27@gmail.com> wrote:
>>>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>>>  {
>>> -     unsigned long long freqreg = (u64)fout *
>>> -                                  (u64)((u64)1L << AD9832_FREQ_BITS);
>>> +     u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS)i;
>>                                                            ^
>> This extra i char is something I really dread as a vim user.  :P
> 
> Damn, that's embarrassing... Should I wait 24 hours before submitting a fix
> even if it's this trivial? Thanks.
> 

The risk of not waiting though is now you have a review tag on v2
and you've already sent a v3 without it.
