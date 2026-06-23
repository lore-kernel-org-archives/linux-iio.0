Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360D3D564B
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226582; cv=none; b=hYlDUD1g8xEcMhYiNCR0HOWYwxXHUn/KCweACAgEqMfHI2NIEqDzVA/9M9Y2qnmoqibTIn+BRUQcQwrv7P12fQH/iby++OW+LGP/cKlp2PskwJMvje8/KYHCU/dRSRpC8qgh+ACIoVGBErKyz6ao2g6syTl+iUibvHF73RYg2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226582; c=relaxed/simple;
	bh=kVZ+9IWhNV4lT8kS4yH4u/IZnllEGeqNEfejbbqMXN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gj0Da0SGow6gkxeLJrlpxoX4GcrK1Plu5kIMgiHB+yU8+RrMnvgsjLdoilneqlaLgKDzmBQV8DJ1muvdm443pi4Dpty7gYszUIlZqgYjMkN2OIXfrQ2bnoGJWUs4Vzm4Xvg5muvfEdMO+One0POfVodjDmwQ6Xo7efn6jWQAqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=X0te6KiT; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="X0te6KiT"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69ec2ebec61so3758813eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782226579; x=1782831379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBR4LPNfVyazbxo/Mzs9Oj1Os+Qc19g/PybcVUcNeLk=;
        b=X0te6KiTJ70FjOG4BWGvaNWxRaFYU8DWtjUA0SpCVASSZncmh3Fhy203Z5wK5CxlhQ
         e+Sy+Nh5mArpEDaXzIkVY8iwpWLg9xd2QEK0vD8cw+fa+95JM9KRnz90eRWMLBmxSGaa
         CS7ZajcuPh+Zd0rEEymJbSAiAQTv4mHAU7e/8H/fzs6TrsYCgPK4psvR+uPwRe9dtxcp
         vaELRefihxrlVsFqPTSn87WsyCZL1p4Wdg/zTiL+Z19EzdUX5zRbFI0ecTFCKzPhqwe3
         NdlBBsYJulBDmTF/wuBC66q4cZWTawel+8tvA6PY6PAFb1LJAef9buWvXR/Wpj9Um1bH
         sRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226579; x=1782831379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBR4LPNfVyazbxo/Mzs9Oj1Os+Qc19g/PybcVUcNeLk=;
        b=nl9B5Qs+zuE/A8V5vj7V7VCTtsJzyqK417grPcr4rCfQ682JJ0e6LRByYbGFDnlioH
         Jh0INLgn2xx2SSiQuVro1PJA1cd6JcmSJfY6Ytm5Fj8hZw5OCGtJSbBYATd8UngHfxj6
         Mk+b0kI0iWW73A5i3WlL8MwkB1MmLe4FqMGl97jHaXdg5PSZ1FB26vhvK9A6Z67ht02K
         li4Jz94rfWF/UvdRtsPz+ZXVl1P2LCiCM0QHd46Ksg2BUAbXlqFzFiPrdJOXtyNNdTlW
         czMD4FqnpJ67vvQYEgHcFUas56OsazdKl+QMr1JRlXUxVxH87T7An6iO4/CsJ0xE/drC
         HmHg==
X-Forwarded-Encrypted: i=1; AFNElJ/526DXfmSaduEMkZk5H/SVgeHfy8tNhL8H4Un4AHVVKkRmT2ZKXK4ICITqNWvxphR8mVtAsnPfoOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2L4OEeXlLCtQogDzY7RBKy0upJUWYA3Ld+FK6UQQjm6M4Kv9
	MslFlwuyVMEPGINqOs9Nj5GSUs9ICXFfPmpiIgYVfQD6q2zWIHh+CiH7mQNPvg1BxF0=
X-Gm-Gg: AfdE7ck2LE/oLwAWaFnSKpMyHVWPJJIEZApzMOaeaeaISWf5SKv60e8HxF4d9W8+Wib
	ti9jgf+ye2njf1/6BY238MI9pYI+YB+VjnPB6UfhCokRxYt1B9mCOiNQonyPnfDfNdFIIL+r//k
	AfJ+G2YfxSJzZnqFm53PuhEi934kWY/XP69oDmMk+pFXAVOGNNildpVpo4aXXCkVs6yf0KBXwz2
	QtdIdyZY06GBTdwa/RZ+fxHU1/q+uOJS7PgDDoH5GwsaUTzf+bZsJJHvYynV9LorLh53/uFH+J3
	GkIGQ0HLFs1bEZP96nDwfKSuGGC38Kyj4ylYHrlV+wX7hcsm3fBzi9Cb6ywl+6qmkMcHLlbCrVp
	rOzYNZ/gBQ0462cx3YHKYw0IeWLiPXvJWnUxQEkfJmFrT2psBNibTji+BCKgeuA4DWPajSvSlPs
	4UoLZvG/BhG/+vQA2nCbalFRL/I/0iJw8DIXKTa9cq0BzumNa1bmwotR+tU7zs3eBmSM78hxQEp
	g==
X-Received: by 2002:a4a:edca:0:b0:69b:36d5:dd52 with SMTP id 006d021491bc7-6a0d8bd514cmr15216027eaf.9.1782226579611;
        Tue, 23 Jun 2026 07:56:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6526:8577:6be9:cb7b? ([2600:8803:e7e4:500:6526:8577:6be9:cb7b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0e7219sm8668009fac.17.2026.06.23.07.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 07:56:19 -0700 (PDT)
Message-ID: <da800798-e902-44ac-b245-b31aed199e92@baylibre.com>
Date: Tue, 23 Jun 2026 09:56:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: ti-ads7138: Disable STATS_EN bit while reading
 conversion results
To: Paul Geurts <paul.geurts@prodrive-technologies.com>,
 andriy.shevchenko@intel.com
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 tobias.sperling@softing.com
References: <ajY0pjnnzQX0IQm1@ashevche-desk.local>
 <20260623125235.2154290-1-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260623125235.2154290-1-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 7:52 AM, Paul Geurts wrote:
>> On Fri, Jun 19, 2026 at 09:42:08AM -0500, David Lechner wrote:
>>> On 6/19/26 4:00 AM, Paul Geurts wrote:
>>>> The device might update channel data while it's read by the host,
>>>> providing a data race. Disable the update of the channel stats before
>>>> reading the values.
>>>
>>> This description seems a bit short on details. It looks like this
>>> driver doesn't support buffered reads. So if we disable statistics
>>> during a direct read, why would we want to enable statistics in
>>> the first place?
>>
>> I believe this patch is initiated by
>> "Until a new conversion result is available, previous values can be read from
>> the statistics registers. Before reading the statistics registers, set STATS_EN
>> to 0 to prevent any updates to this register block."
>> from the datasheet.
>>
>> I would rather like to know if this is IRL problem, or just a datasheet reading
>> based code.
> 
> This is indeed the part of the datahseet I got the solution from. Our real life
> scenario was that the register read from the RECENT register was constantly
> flipping between values 0x24F0 and 0x2500. Due to the STATS_EN not being
> cleared, we occasionally read 0x2400 and 0x25F0. So this is based on a real
> life problem.

Thanks, this is the kind of description we want in the commit message.

> 
>>
>>> (This driver suffers from the comments say "what" rather than "why"
>>> /* Enable statistics and digital window comparator */ so it is hard
>>> to say what the original intention was.)
>>>
>>> Can you explain more what this race condition is about and what
>>> happens before the fix vs. after the fix? People generally do this
>>> with two columns showing concurrent function calls.
>>>
>>> It seems to me like disabling statistics would break IIO_CHAN_INFO_PEAK.
> 
> I think it indeed could break the PEAK value. But I think the data race is a
> bigger issue. I'm not sure using the statistics at all is a good idea for
> this device, but I'm also not sure there is another option. TBH, I don't
> really have the time now to properly fix all of this. I just saw and
> quickly fixed this, and thought it would be good to let you know this is
> an issue.

Now that it has been explained in more detail, I can see that your fix
is correct. And we should also do the same when reading IIO_CHAN_INFO_PEAK
and IIO_CHAN_INFO_TROUGH.

This would make it so that we could never get the peak and trough from
the same time period though since each read would reset all 3 values. Not
sure if that is important or not.

> 
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> br,
> Paul

