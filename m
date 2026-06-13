Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88CD3A1E92
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365164; cv=none; b=oDpA0yL0Ri2rNKnJm4idhE03+Zuq2C5SSooo44GTo/xGflb6/P7E3X3SvIb/2nPfvTa/kcKNAjpzJvMuLRkcf4be29heqTzvAB/DHkPBkJvlQKifZJhwCI+CvkejOPRRDtbKSzWUQxf345KZ90vfKu4FDZ6ETYWQehvigSn+N54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365164; c=relaxed/simple;
	bh=/z/uJcHq7PBaTOzrKCVMvYfLipWmodz6FmZdNMRkdKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZnZCEWc473cNhYejhrmbKFibbx0hOQJhnG0PTf7FlR5KKWR+yy/vzvVGu+OObt4Y33CNMMrumZpAUhNCqGFc7VHZhc4QUeSmDlZPO0JNxpOdz8NfK/eZYcsnVFmTnwgloomnNxbBb5mrtAONGi0zVq+npd3FdWl+RdSzmomkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BLFwYYyW; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BLFwYYyW"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43f5927e70aso765817fac.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781365160; x=1781969960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKts3zC1pZWU/tdG0AkBqX+GZ23M67qUNv4e5eCuZeQ=;
        b=BLFwYYyWjMvpuCXkNHGjs1CbUiUmOMtg/NUZSf0JLuaZmks9+JYFzV9AM44TkBCoKi
         a+ZT+s5Co3UmuADrGXt2FPwKgFRjzP7Z59epyQN6xBuVDzopCKulqSMt+K5aUCns6d8W
         WRFtl8gvGjLpos5CMj0s/YPFRL2oRwvZiHF/yRG+SdDHHvu6xcNAXlDBYWB96Pza2PsK
         Y5Ww8dm48LvQ9J7lmqNvfLPp8Ec57H/8ivVDYCgEkkkhmbeGGcODIDd5sggz5C2jJCFH
         iAUU1OdEofKF+GQxUgnIHSriFR8dvMxvEBSvhEe6U0gtlazDJWl3+tkOn7KB/ANKq8bg
         lpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781365160; x=1781969960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKts3zC1pZWU/tdG0AkBqX+GZ23M67qUNv4e5eCuZeQ=;
        b=TvFPab39ANEpLvVngnoOEOYsougLnZHRFaKHSp/9XlLRtYwsTB+NUmLGqKn/qLGWDn
         +3XxGdDi08WgLjEsLwQRDqNrjrSUybpJp6OL1KJBm2TmatziVmIihxHrkuvkgRrStaoh
         KHlgIjkBrxbe3a+5aC+pZ9/5BIDT8IAB+2AJGEG4yjLJmp6z8VrZTAvW4YPcMDMzmqtx
         r8BzKItzSei/OmdJ8cOldn+R3flSfoHKzHFLo/uiT0p72f6luZs/W3qUaL2y8OTvPgsk
         +LyCoJ74rD6wwousypgpiAVfYnxjm6bzgHMpzoTEIuqalENsrrwpQxDoV8EOQFEMY6L8
         4nmw==
X-Forwarded-Encrypted: i=1; AFNElJ85scrV+4hqrVYsGNTuJPDSJLCU/A/IQDLC4FYL6s5YCSqKOUa8wdXjtBSwZuvGzOnLs8GHrfyNuc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9YcamROJpfmHKSLUjj2ouO/x6cxzHZEfY7fG7k86NEykB3Zz
	K4f4ryKhy9QP3Cn800rTiUjtmNgydMYBBlzL/FZ96ql75CWaaNpd2hi/Z8j239UvVg0=
X-Gm-Gg: Acq92OFTEKIYE93zUDU/OK0rvXv5+uYmpDzdCVKO8oyh7RT0sZ4dALn0lk05BwV/jjj
	1YIAKEHiMfSSIZhTdczDzZ5gd3OwWepe+ZfonQOfbHviLYHCyDag6Lc82LZJHeNG3hCkVzEGoDj
	3uCd7XyYkiqmP8Ka6adoJ46naCvtKqgFjBJ8/WmMCt2jdR5bfYAMEHJEze+Ic67LWBDDVXqWc0X
	FRP/F3MCqyLMWtIgMwnfDj4IyVgj78wXbBf0XKcejZqA1qVPeD0Lo3vZ2WXFBqY7OILwcgusy93
	v002pj2RLqVnWUGrFaJ/lGb7jLPJi9sQLPdo4y8zoq7FbT6/Gbb4EN7VvoI5F3nXeOzijraH14E
	5af8rtM/8l2iH/3VfYEWMFE7T2KKmMvT+FesBGRGe+1wFTqKkAaeRyHXNgcTtpOIVomA/pgyzx3
	/u/9dHlmwIHIyYoR68kU45n31ZcAamCzkoZZVXe8781OtqhotUx3PM9hXQEx0D610xA+ltOcMiT
	g==
X-Received: by 2002:a05:6820:618:b0:69e:43a2:348 with SMTP id 006d021491bc7-69edc6d4369mr4531364eaf.33.1781365160437;
        Sat, 13 Jun 2026 08:39:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:cb9a:87cc:1314:fef5? ([2600:8803:e7e4:500:cb9a:87cc:1314:fef5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69ed8575597sm3832633eaf.12.2026.06.13.08.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 08:39:19 -0700 (PDT)
Message-ID: <0b57442c-c1fa-4c06-992b-28cbd046a7c2@baylibre.com>
Date: Sat, 13 Jun 2026 10:39:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: add QST QMC5883L
 Sensor
To: Jonathan Cameron <jic23@kernel.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Siratul Islam <email@sirat.me>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612124557.13750-1-email@sirat.me>
 <20260612124557.13750-3-email@sirat.me> <20260612151324.0000704d@gmail.com>
 <20260612144529.7521b4f8@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260612144529.7521b4f8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 8:45 AM, Jonathan Cameron wrote:
> On Fri, 12 Jun 2026 15:13:24 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
>> On Fri, 12 Jun 2026 18:45:26 +0600
>> Siratul Islam <email@sirat.me> wrote:
>>
>>> +QST QMC5883L 3-Axis Magnetic Sensor
>>> +M:	Siratul Islam <email@sirat.me>
>>> +L:	linux-iio@vger.kernel.org  
>>
>> There's no point in having the IIO list in your MAINTAINERS
>> entry, get_maintainer.pl would return it automatically based
>> on the driver file's path.
> True, but I'm not sure there is a standard convention for whether
> lists should be added in this case or not.  
> 
> One of those things where we should decide on an answer perhaps
> and stick to it.  Andy, Nuno, David, Dt folk what do you think?
> 

Given that the vast majority of MAINTAINERS entries already have
L:, it seems like it would be easiest to just stick with that
convention.

Even if we cleaned up the 140+ IIO entries that don't strictly
need L: linux-iio@vger.kernel.org but already have it, people
still may just copy the convention from other entries.
