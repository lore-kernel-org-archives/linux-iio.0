Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862F288535
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202022; cv=none; b=gsuhC1sh+8bNEvr4BuKDsHoKj+0TEW4lHJ68ZHSMqGv0GPLUZkIx66OX5fCrOki43mw/VMuRfYggSMkyLxcMdWAYwvxCxJZPfDtKXjZ41+BwCctwgBfxMCMfNW/fiD5PWl6oybHBmCzuAV/ZyffiilQC9x/1EI0ICoLPPM2D+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202022; c=relaxed/simple;
	bh=1r2rhfIfNAgeLhcVd3Fth5KFSw3s1U6wlg1lx3h0/WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWbfOdluAC3FzbaMTeCjzZOANZX9Tv3muSYgbwOI7p2jpbR2LhX84t3BBab9Ss5PzLXOJAkEXeLHhQ1L1RVERzoJbkObzir7RywJNc5HnTjQZTFFElJi3VBV9c8GWBBufzZL80Ki++EaIG+REuyYYKa/VJXRkf8xZPLSHGmBmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ldve9TyS; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ldve9TyS"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65f59501dacso1913356eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 13:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769202020; x=1769806820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uNYqV1avZyh+foZ5DUAwLH7I+zAmKYfxKTdgaxSmkU=;
        b=Ldve9TyS0QCbDpUGtwD85pYHkxCQEH8HRyFPVZQiX//V3F9pFHSlgF+KYeeyez8AFC
         ULUvjGTX/tVsKJmOr3WmMD0zQPxNgVTeBbANxQlcvCie/zHY9a3Z8e/tHwF4GEoJadAs
         ehQeWqOeO/to/tJO5K74hVa/O6VNXI86jc5iirQEQqw2/ZRnR9VIETaaGwz7Iy7HCoRp
         GmCocc9tPyT/7X9u4YdZRZw4B10GNCZfTamrpzm9sDnLm9vkNLuWuWheuMor4Q9MLOoq
         UUi+yL6a5Oax5/dVjyJ73034mpdZgOl3Hx7kZhRAfnjgKX+H6Xw77OKgwGa7BZcVOR6L
         nqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769202020; x=1769806820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uNYqV1avZyh+foZ5DUAwLH7I+zAmKYfxKTdgaxSmkU=;
        b=eMKF/oDFL1aM/2q4SfHP+7sG03AE3V6uPw0PzOr4uLf76OoK9HZ2am8HdqEQmPKXnd
         50ApbgaZxCISOy1GUx6FsZKZBX/pPUslmuthd2+25sTMCW0nutxezWthI0krh4/sAFwo
         NwNT2T6wsbla8vSUgSfT2sl+A+pQQ47PhYIRE8fecYJH7f6YpIN2j1EyOM1bBl9gmq9M
         S9CwpbIJ7tQr1rKyfU9AdfC+cLjqUZgzYwsTviDQm3+S5JReWARuubMCKOZQpwQP/W6a
         /JdmWJZ7NAe1w0HHYZ7w2Cxw1z0Ra8jog3E0yACPeM4z12zFvg/QovCnMI9FGXQR2Ruq
         Jg3g==
X-Forwarded-Encrypted: i=1; AJvYcCUAS9EDCTnew25W1uuiVpgHjIxbMCJvp97YUcUwr2Zrcd+bsScfhQVuz638YPoX05fWNyYFlJfSseQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF2zzNR/XglmMne0NFglcDH+6i3lfJSpG+U7dnnks0T0cR+V9/
	PIcpmURvUUy4HmsQi8IGFz6yKnz7hZbBJrSvlmY0m1sB+3DMzb1xalX0in1K8tQZ+DI=
X-Gm-Gg: AZuq6aL3BlwJi2ze2/4jTSmbNfP5RmaJiWUvjtaF8rGYBT7no2EG286GtFEbPuPRSsO
	o6IjlWr46P3sSH0CB4Sj1JENKR1t0+bWJu7QHD/t9zy++1+xT7JaRIS0VyznrsUcddKhVn7JG52
	GN5b1EDMfIuzjYLBMdWuFqzMjU9VkeudBAKr89IaYZuxaPOkNMImiEi56g8aktGlzsyq/bldHk8
	IdzeB0XxZSRUmI3Tq3S/E0xjnBiGpzOOOemiyi7J/CzapAOdRkT51x8H0eocbVJmTW2EdJkbCBG
	h2lxKK4gpeXGWEN7dPMDOfkSCCA033rcBDkAqlwIZxq/juzZkWhCdnQhF18Kq5ei9tSAxui2fWh
	5DMlG0rqUaT0o8WZ6Cmd3yHkQjBouLOAqtrqA1l7M3jyYU7HsOWP9zOd3SW6xwdWeJDheBMSSS4
	A5DjlYpokA2IWhItbeaG5KB8P1uuM4vhwLXQV6r1jAF6jK9dvuUCQxkLSAeA==
X-Received: by 2002:a05:6820:160b:b0:662:b9f0:175a with SMTP id 006d021491bc7-662cab7d3a9mr1810028eaf.59.1769202020243;
        Fri, 23 Jan 2026 13:00:20 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:198f:2b50:c48:1875? ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408afba74bfsm2239703fac.13.2026.01.23.13.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 13:00:19 -0800 (PST)
Message-ID: <7126e6f2-c116-40c6-8657-1cddc36903dc@baylibre.com>
Date: Fri, 23 Jan 2026 15:00:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Thomas Gleixner <tglx@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Puranjay Mohan <puranjay@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, Gustavo Silva <gustavograzs@gmail.com>,
 Nishant Malpani <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com> <20260123164711.0000379c@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260123164711.0000379c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 10:47 AM, Jonathan Cameron wrote:
> 
>>> +++ b/drivers/iio/accel/adxl372.c  
>>
>>> +		ret = devm_request_irq(dev, st->irq,
>>> +				       iio_trigger_generic_data_rdy_poll,
>>> +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
>>> +				       indio_dev->name, st->dready_trig);
>>>  		if (ret < 0)
>>>  			return ret;  
>>
>> Interestingly that this driver ignores the flags from firmware... Seems to me
>> like a bug (not in your patch, obviously). Ditto for other drivers doing similar
>> things.
>>
> 
> It's indeed a bug but one of those historic ones we can't fix without
> high risk of regressions :(
> 
> 
Sounds like we should add a "don't copy this because ..." comment while we
are touching this.
