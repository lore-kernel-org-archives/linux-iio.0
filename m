Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897D46D556
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934393; cv=none; b=mlJptxUpoepnaBx8yCR5QfxNjfLKO340DvqLQQOLhJCxMv96JcrQFU1+MLJnfM86u5Yz4xr4JY0Rs8rvGr79N0LMbKaU4kchLt/PLGsXHLtaJFXfUSbv7RXcHSg3bZuEjaHLFucepuc7IsvqplSfLudzo6oWVEWUCin60sx8paA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934393; c=relaxed/simple;
	bh=BYe6zc82GTs3J/SUP4vWeJClhRuTndcNfqQt85wuyms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maUYc49XnYQkW2gxnqhhUT66JwIIPeV5K2RYe/wWjPCAu5Hu9QjXl3a/IfblCaqdacfFE3r9SYiuEp3O72htBFxIEHtUgA4/wp/e/OKpOKkTbmg7QmHhHRTK3DkTvDLxD3dEOD7msSQOMcGhEGgRZt1+a58H/qRdI/M/dlR3Q8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=e1Ty7GZ3; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="e1Ty7GZ3"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4960fb63c75so603971b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785934386; x=1786539186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bpxSNiQeQ7TmkvPjHCYe2jjUsLTGYc3Ttja2z5fpQU=;
        b=e1Ty7GZ3REH4oOFzCK4YmcPLmL5ikBo/raQ7uAj23tHE7J3FNOMBvm1L4V9diaYFb4
         WmnOHv2RCTS9dFbqkR5J0rJ/CAdKzc32avRVACF4p3Tw2thyfXSnV/n2TkdGTbDaq2YQ
         LY+mHPWr+N7+KozYgr7seuvGkz87EW+mL/7LUXXBERGO65BOgQEaO2enApfPeBp1DYmH
         /HQxeAkFymaS0wSz8Of1dM+oyZy+V2DngkMDDCS219knNCsXg4N34NMbAoYmgeo3fXrA
         TqjjPv6VVuAPrBiitf9GaOm53/KRSu3dlmRdSjDoHomq8h2w5bPXf7jUXjbZYbhDWD7J
         wUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934386; x=1786539186;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bpxSNiQeQ7TmkvPjHCYe2jjUsLTGYc3Ttja2z5fpQU=;
        b=at/qWdnG3IuDi1ZzWERBj80qy1M/Tz6vtIB97tt0aPzMgY26N7L2PlhnL+AKLXMokP
         2968dV4adZoQboqXCzcWvATcph8FefsPq8ZP+rPM4w+9LFIXMJOaifvtRGa0POxv2lZy
         x3SMRK+eSrLtwmBW5Rflhy0YRO9AbIdVajFsd4SLRxeV1KwYox3iw7Z191mssnvalVsG
         2LcBVZ5LSIFJ5c3hVbfXuU8fiN64oGVqWX2hLn1pn4h0KjH3s8I/LksV2wjUgHItmpVo
         8GDfmpVdqq6C+fp5YAOveQE541Xu1YFzxeou2CTrgb3EPI297otgGS7mQC1dPJ/I0oia
         8S4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrf/owhfbyQ4XhrG75tKQfl5a6jfcFtuAKQTH6i1PCjtNvu1mQ7NBXH0g1PG3nBwtAJb6ks1Lr0Dwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRX/+ncSJvKt+GUSG/QnHnZZhA2ajnMiE5gTlygRI9IXg7BjP
	VkgIFoqi6wiwvnKppBRWT1jOv2s69FBkhGxLN1N9R7x3Y5nXY8pS+PWFlj45I/RY8XU=
X-Gm-Gg: AR+sD10LmuUh4xG+64fMiQB9KeA0B9EKSXWuzoeDG7wK2k8MyRiKCoHj3//e9H7lVYP
	AuKRu0TQjqBnMLJsq0q33EPy/JqKiUO8R/p2s+oFSzXiQ9C04bp4Ms1XFpLCdTJvCsQG59SDmSi
	+4ztTPYZsk0/inhEe7tjJtVinf0AaHZK1x8kIcK6NHMkC2HIQAun8KbPIBRtvuFuD+me8+vL4kq
	gf5hXf2m6bxeBhVKInheutWESl2OuN75gnjjRfqa2+esR2JuPDHeDUJterWCkdci1jrne8DTWcR
	LHnPWnDJPQsS1n48pwevDXxJCne2O9m7zRNuXE+089oO+a4NdFR97hl2DrSABY2LPh9W95n4L1r
	e1UZVkHNr4yDd+6m9kXF9HsFthXIf/lgwNgbvpvXzjL4590hVC+UZABb+F7TCa3c2wj0bi5oa6s
	zL0QPNQLDQiAiG9cy08uIRTgZpte0+EubQG854aUi4aQyNA1qtLwyRVYLDz1DQZbPvkHrq/fsYb
	Qlzda8hzPzLd8kkoaERjfrHgXvCOpmYLXFGIVM=
X-Received: by 2002:a05:6820:4b07:b0:6a3:7a25:c09b with SMTP id 006d021491bc7-6ae96ef02c6mr3601813eaf.20.1785934386181;
        Wed, 05 Aug 2026 05:53:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ebef:9550:d591:36ac? ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae94054df8sm2649815eaf.12.2026.08.05.05.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 05:53:05 -0700 (PDT)
Message-ID: <2f9d39b3-efc2-4d50-98f2-71bc19e78ab6@baylibre.com>
Date: Wed, 5 Aug 2026 07:53:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
To: Daniel Schaefer <dhs@frame.work>, Jonathan Cameron <jic23@kernel.org>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Jiri Kosina <jikos@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Sven_Vaink=C3=BCla?=
 <sven@xn--vainkla-r2a.ee>, linux@frame.work
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
 <b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com>
 <20260727221338.29f1da9b@jic23-huawei>
 <CAAjcXz45hB7+4wns0L=2VKeAeq2UaPhwHa11vPgFJux7Q1WLRg@mail.gmail.com>
 <CAAjcXz5Y7W69LaUsFg323rTsd7waaSnLkD=dJYJvOCwPV2Apmg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAAjcXz5Y7W69LaUsFg323rTsd7waaSnLkD=dJYJvOCwPV2Apmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 8:23 PM, Daniel Schaefer wrote:
>>  I'll queue it up on the testing branch of iio.git but more eyes welcome if
> anyone has time to take a look.
> 
> Sorry I'm not sure what that means. Is the patch applied or
> should I send another one with commit message update?

It means that it is accepted/applied.

The iio/testing branch is the first step where various CI bots
will do some automatic checks. If they find something, you will
be notified. Otherwise nothing more for you to do (unless a serious
concern is raised later).

And it means there is still time for further review too in case
anyone wants to add their e.g. reviewed-by tag.
