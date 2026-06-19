Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC352DB785
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880494; cv=none; b=TPDZqjp9XX/o0FZ6ahP5woXAWB2GU2bK6v9J8JhoIWpjfgtZYEJYQvAhbMQ81+QJlkosahFNKgxeVUSJD2Zn0fhM6ZHse/x+5HbMryoQKf8NgJBNsSUyvdQd3B6c0PpPuAWDGQ3HeEp+BE0fu3wZMDJ/2zHANyAn9YoRIX5QEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880494; c=relaxed/simple;
	bh=T16CAkRcPrCYYuEGKBgz2aVoKlV51H85ukzx9bmZNYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irFUqMdYFMxP2OAjJi5B5HPHkmZkopqIl3OzssN57CCBrfNSzxzc2E+syrywqdVrnBX+An+oH6wcUtBrH8cMjooOnCeveImsHHw6YNSbK5Gwa8A0aHSJwFfy+xbsDL5kydNZ770Ekk0Jhm+AAkRBXWhPFrvmdshS7aWfGsyTd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bzvI74mD; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bzvI74mD"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a0de515e54so413696eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781880492; x=1782485292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeUoNQ+ueS4ifg/7qGanjhe97BGVmwF4SnofeQb3fOs=;
        b=bzvI74mDrZlJT3p4Y11W98P8CoXTQ5o19AQEYlKT6YZ9DZikBnG5jSQOGqqudQvLG0
         KbbXu1GloFHtFNGO/k06D1FEE0yKZtTniuMr3HKr64ulxtxMvsCtR5WEAphexHz1Jyip
         SLouR5PX4AICnSzpopLOkDwy9ql3/0i7W5QK89f0q3TDNRlaBSLEJxu3TVNepDQq6ahM
         0TMEZE04P2HztTevS/jSdwhLnC879/eo1UaVQ7CD6IVPFMmjTMj6oErNb+Qf1pI1ZBf+
         8O3FrI0yiRGgsEElhcaEUqrvqWjdeX//bGQyuZVmpQM50tIO+YfLZuy6Iqjif0jzTPGz
         2kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781880492; x=1782485292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeUoNQ+ueS4ifg/7qGanjhe97BGVmwF4SnofeQb3fOs=;
        b=e4hnxqwiS6nkv5yPHUqn8gBRVCWWpwFTCFMLf5zZOlWQ2kwCAw76X83seQS1iiWAd9
         WcmgIUGMXz45DIQypfexow50i4OhpHz6rn3QdNv16zEKGXPiqvKQmoLD0KnZ4qR3Q/mN
         15fVeStYtD1Ozrr9H72en0nk9XoUDM/cMDnbhGS8z8Ud1ek0SL4zRAGuKhek1IoBWR7G
         HgaPdQ0zeoikKSFyc/msYyRxEBd3cChlALw/YVxJEYQHoisyRtusagP4GXjtfgNgSFxL
         BNIFMD19oJD2cXhum8NcmO8bbF2sA6hQJlLC+WR7vV38LMrzIM4Kl8/wHcjrT2Yg3E2s
         9Bog==
X-Forwarded-Encrypted: i=1; AFNElJ+9i1WEmxcv3EH2ZKZIqIBVpLrH5HpraFoUZI6hEd4nak25x6+t2Va42zsZxAp8lLPiHg2nPN69p0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6r44VtVVqEnKek6n37sHIerkCiIuNJD0Ox1UejbcnRvrzA2Xc
	eSAOaHNKiVXOUbMzDgHKpwwbbMDuf7GRmgJd5lPwSNecbVSsczu4Tg9nrA4LmI2PAFg=
X-Gm-Gg: AfdE7ckUY6NOCS/ONnw826sTAo24AjlwP6Pw30koh9YFuGQv+RdcST5DDbRMRHzuLCY
	4SSCSmXi7f017EpoLVJAXbeIRYTq3/MeSNpKjl2XflBSIgqaOUnh9gGctSXZqEJX610iswT0d6x
	KyAQP3DxfKJMyD6pGWdyXxxZpscaPet7MsNhJrZO1sa3ItdJR9pPAZEGqJgsXOLMdjuMjlCFvSH
	E8PgheJLdrKo48dQzZCxg/yc5sg7Whh5y/C3NjHXVsBcn9IYQB3Umc23j1ypV8wRFcI6DRkoW62
	9xS0RzYw8cTJ0M8jSevaXcy1uW5b47CydRgLndDUz8EOWF+GZVOnCAeQQC4owu9FdYUvi3m3ghd
	RdFiLvxT06IIyvxeF1PSViyNJAUW9W+5PCpLWYY77vwuXdHEUDm9HBvgVLHCAPtHAPnS8tj4hRR
	IHDux9zDQa9HfL1KMye6vBO9YSPVWwfqtKhma/325JH7Iype+DWoSlGcUOOQ==
X-Received: by 2002:a05:6820:4c82:b0:69e:3fd:5c7f with SMTP id 006d021491bc7-6a0d9fb8209mr2127496eaf.5.1781880492001;
        Fri, 19 Jun 2026 07:48:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dd8:d93b:3cde:c07? ([2600:8803:e7e4:500:dd8:d93b:3cde:c07])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0475e3sm20637fac.16.2026.06.19.07.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:48:11 -0700 (PDT)
Message-ID: <6b773354-6615-4cae-b7ad-d083d59133c8@baylibre.com>
Date: Fri, 19 Jun 2026 09:48:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] use dev_err_probe for probe time error
To: Prashant Rahul <prashantrahul23@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.or
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <20260618231543.413771-1-prashantrahul23@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260618231543.413771-1-prashantrahul23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 6:14 PM, Prashant Rahul wrote:
> Using dev_err_probe as it simplifies error handling and ensures consistent
> error reporting.
> 
> Errors are logged when enabling the regulator or adding the cleanup action
> fails, but not when buffer setup fails. This adds that missing log.

Isn't this a v2 of [1]? It should have a changelog and link to the previous
discussion (and start a new thread instead of being in reply to the previous
revision).

[1]: https://lore.kernel.org/linux-iio/20260616130612.73122-1-prashantrahul23@gmail.com/

No need to send a new version for that, but keep it in mind for future
submissions.

> 
> Prashant Rahul (5):
>   iio: adc: ti-adc081c: use dev_err_probe for probe time error
>   iio: adc: ti-adc084s021: use dev_err_probe for probe time error
>   iio: adc: ti-adc108s102: log buffer setup failure in probe
>   iio: adc: ti-adc161s626: log buffer setup failure in probe
>   iio: adc: ti-adc0832: log buffer setup failure in probe
> 
>  drivers/iio/adc/ti-adc081c.c    | 6 ++----
>  drivers/iio/adc/ti-adc0832.c    | 2 +-
>  drivers/iio/adc/ti-adc084s021.c | 3 +--
>  drivers/iio/adc/ti-adc108s102.c | 2 +-
>  drivers/iio/adc/ti-adc161s626.c | 2 +-
>  5 files changed, 6 insertions(+), 9 deletions(-)
> 
> --
> 2.54.0

