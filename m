Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16370175A8F
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772409461; cv=none; b=k5WuB/uuhmsVGdnpAHSx7LA3vR992t/QzULp4wPdNc41+CSzViUT8hpOlxXJHoIemP24Rh8dSJAgMJOl3iaPAyd7lNhBl5BO/fmDJTMEP9Y7KZuz0tfC9GT2ahDr03DsO0Wkr+hUXxifXDpwt8ovNYmYov9e1WkbqGcw6vOIMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772409461; c=relaxed/simple;
	bh=PPjWPhAV/CMGlf4h8hqTpGQ1qdiPBHEGZfh0eQ+NN8g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nfMlaWwOOOACtErqljdRHPZ5+P5boc0H2W1zVdKs5FBb68RUA+fHjumUINm7OEAu2EIhRkc46Z0urVD7ceXPrqNirQeCvPx+jKGvY0+MkrnZD1RWT5DHhk1qjy2rfCgq82z70O1OwjU001BJ6FWRahUd2IFqnQCFn1zpWd8ACRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vttZYeKZ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vttZYeKZ"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-463b3697846so4100661b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 15:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772409459; x=1773014259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QudNWS8bzG3eo+FT5ClTdDynuy54B2E9XpJYEYAcw4M=;
        b=vttZYeKZXqwJgdE0pTjZU2tcxov8Tl9oRWgo8Vd0EHaq7P/fk5JP3O6R54IxBsFsUc
         JApgvM1BzRIop7/ao9vz8TK8NssFRPSAx2iHMuY32E5szhkawXxSLd72S6qyTvSp9orl
         vHhyEweg+Be/jZv0V2ME/633CBhC00PwLPQqLpKKnngyTACO4r/2lV3VsitND9FGXZiX
         LH4Ux02ZqOZUIpLcQko2vaVsC9EHkF8gerCsfYejQgq0c/Ft05JVTQRar3K2Q7g8ffXL
         tmlqV77MT9fClR6XylfDqhmzPx44XI6K17DV+RGL6ZyGjaQqvX0E4ga/l5sQRKtA8vvR
         sQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772409459; x=1773014259;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QudNWS8bzG3eo+FT5ClTdDynuy54B2E9XpJYEYAcw4M=;
        b=ldobRldLW7MmQx59CjU5H4tMapyuAUVkR/JBNZCEzmyM8wAkOJuXzUZrIG02hRX8bq
         ETbtfFHNju0mPINPp7r1BL4eBFjMmtrcGJ+W+ttTKTScN8aPO0cuHvV9IMDhFAC+f4Qn
         KAYV36VrpOTEfEHHy/TfqvMiYY9pVJcXJq3pfYXGEnbyUHGn1S+OD/k5SjcvjuiUyaPG
         fzAJp4bH9Br1azFuD/VcXIeTIQp09USCuSPpvCeQBlCYUv5SNBm6YCmBVOKaMVb+gxcl
         qEnpeV45DGR434UZei4nkDKMvefGuJXmGpsIg4EJbmG9yZYDFaYb2ecDfCDENCXOeDHU
         ZaeA==
X-Forwarded-Encrypted: i=1; AJvYcCW7a1t/YGkD1VTxvHwslhE+51oGM94AHSEaY6Z+FVkSVJt1CMyDsfaXVYKxjoxYerQgqZFbUWU+1Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUuXRrrPn0A6LqxKcD2jAu3pSzJZcGV5rtuZZtexdVT96kbKi
	I7rkXiPhN+2uv82yS4d2KGTEXDh+XJldXfk93MumvbWbpPbGYd3abJFY0CN5ndL6Gx8=
X-Gm-Gg: ATEYQzzzOmZfyyBtx//zMb/mfEBbH3MmuynHpAi1mxfd8kwelXY8JEyJe28w1SowzU1
	eNFl/GDjT5TdO+/pc2pmNZLx+zOLRZAiVHkwOFBdSh3mvVQ2t6de22duwzzv5yV+RWiinvb/u09
	2t4+yu+ooyV1AXDudZnC16S+kaiS+i3zMKcEzrlwtqB22FCcdq4D+5NA7/HCujzbTgLfMIr39wl
	UcuVHpV79ELS1+r1q/KpMdz9yjH/Xlif3TOoJ6jXH1wpLp2p84j51qv7E1tS4V3rJOhZYJmimnb
	MTrfrGfHZ8jUSIkwPSRKlVoX/Q6q7zbSN7XJvW8Mv0KRv5myJ9T9KH/+//+h79XoSTa7raDQ1Qy
	Ns1qbDT9kZR6EpLD4ekyoVKS229s5/I0RMAnLKc/Tecp66r7l0zgycnaTJbQ2Tr5ifT//ghtipE
	Nn3pXtyM7PzfFLFiCjkRPLnciNUCrTlgUFVBmkHIUJCqS2/9or1lI96bCtMeD4OtA/SzFizNTgU
	xda83ADFa6F
X-Received: by 2002:a05:6820:1614:b0:679:a54e:3f8b with SMTP id 006d021491bc7-679fb510141mr5356459eaf.19.1772409459184;
        Sun, 01 Mar 2026 15:57:39 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8b9c:d657:204d:5a5f? ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2be9ab7sm8014857eaf.4.2026.03.01.15.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 15:57:38 -0800 (PST)
Message-ID: <bdf054d4-aadf-470c-88c4-26d0cc630fc8@baylibre.com>
Date: Sun, 1 Mar 2026 17:57:37 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20260113120541.YVf2vRA3@linutronix.de>
 <20260202232741.13380-1-spasswolf@web.de>
 <20260203083826.1gOzxrwt@linutronix.de>
 <0a3433112f0bec3d5bd76c7ae9b6774b455203a6.camel@linux.intel.com>
 <20260207154218.2053c98c@jic23-huawei>
 <ec6ff19b-f8c8-405b-bfaf-02da522782fd@baylibre.com>
Content-Language: en-US
In-Reply-To: <ec6ff19b-f8c8-405b-bfaf-02da522782fd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/26 5:17 PM, David Lechner wrote:
> On 2/7/26 9:42 AM, Jonathan Cameron wrote:
>> On Tue, 03 Feb 2026 09:29:25 -0800
>> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>>
>>> On Tue, 2026-02-03 at 09:38 +0100, Sebastian Andrzej Siewior wrote:
>>>> On 2026-02-03 00:27:40 [+0100], Bert Karwatzki wrote:  
>>>>>
>>>>> The warning appears because iio_triggered_buffer_setup_ext() (in 
>>>>> drivers/iio/buffer/industrialio-triggered-buffer.c) is called with
>>>>> thread = NULL
>>>>> during the probe of the iio device and calls iio_alloc_pollfunc()
>>>>> (in drivers/iio/industrialio-trigger.c) with thread = NULL and type
>>>>> = IRQF_ONESHOT.
> 
> 
> I noticed this while testing hid-sensor-rotation.
>     

...

> 
> I saw that Jonathan mentioned some other more thorough approaches in
> a later reply, but here is the "quick fix" I came up with.
> 
I later found [1] that has an alternate fix, so no need to reply
about my "solution" here.

[1]: https://lore.kernel.org/linux-iio/20260220224514.471348-1-srinivas.pandruvada@linux.intel.com/
