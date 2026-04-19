Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87F40DFC4
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776601953; cv=none; b=b8AloUhWuATQ3ysSmKLUf3XDXS6eGUK76kCopTJn1Y9pZe7/bfq3ljI+orUUSPa9V10Zd8IPah9ZRnqA3vziDYyH6BNnJ3sAcDOcz0KFQ8D47X0v4lCDUuex8ObkzKqpJ6JSES2cd0DLrf12FJTFs6zLCs3NYzf+X7j4MMstJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776601953; c=relaxed/simple;
	bh=O1ag5EBLrOGEiOwMEDVBQfuHnHGNOsL705NsZCXPJD8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZCItxLcwT4DUUr7l4be8F6WrxDIy3Sax2yW8ZW1bqryjjEY6Ril/C6nWira4/UvFUXg3xGQVzAd4+dOMUxuXVElCAVpNvS+32CC/59wslQ87SR63/6iP34Apg1Wmr+x7RYNwD6Ez2c3+1FHbKzUb9MuyG9iC0CYKZczVdHqhzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riiBAWNj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riiBAWNj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so1352775a91.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776601952; x=1777206752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jXJewRU3Od3iPUGYFlu+DspDkNEPgXY5EKiUzPvN9X4=;
        b=riiBAWNjWYiudJMl5Pp7Jmr2oD8F0XmxmL4aiMr+Wcbf6NFbeaSHPpSJXrjC7eUz/l
         mr2IFxHmbqlvp67kxR+UKHC/z7/ltOt+DZN2y4f0FpWtNiDSNjzOvbbIa9Ixqa22T9zi
         BMvLjCns9NBmHtxazYnIjbAoSvurUF2JPhARUAXA+obRUMxq2h0tEq45cKc/4RpUc27j
         FLupid+pyA+J11uBiaDiqroEDuQ5ebtDRaXiQl6CxuRD0+zOvodom2Uz1Duin2nNzTY9
         00ZjqmUzI/m+G8NDxI/Rgna1RuWYurcE/PD7OHXXgXzPz7GLvTgoA5elBCsnPq2JSsyQ
         tAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776601952; x=1777206752;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXJewRU3Od3iPUGYFlu+DspDkNEPgXY5EKiUzPvN9X4=;
        b=EPGvXfKpy09LXj/eCL3ycGmgJzhMFrgXTVUGKcPcro3Xr9/NTr+XUll4V4sSikEn0o
         N9ipAfVNpTDwr1rVHzL50vVuhl6N1EdnS8oNuuCsBCrEjvAxWks2HqxAPpV8etSm7SOv
         h2xf3Mt9dMB2IN4yLFzgZPYuoBFBlr0KODKc1fk5YKVDHvwHds2v2OumMUTtay0IiWj8
         ynxcaE+vFo/tDchgtDEsYgpjdndlU99sJPwxT5F1jysA/0iKl9iv4WB04CNT/x9hiNzT
         Hx1ktU1qWU5fSw0U07pk/X4zEy8NL3G5jw83cFtjed0v3X1pLiYaMrZ0duSXNquvHWPr
         Fcyg==
X-Forwarded-Encrypted: i=1; AFNElJ80Cv4YSTU1dD8R6q28QNvHZMIPbkhYKrh0dQjhIypBVCx9xbGlL7WuUh1vzMRMAfa5hfvT6jxN71c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZa/6i60ctNfdwvwTQegEWbFig63FGnlzNRG8Qyf1kJ3hjHno
	nsQEAx9sFsoIPI940lUH9D8mRQPTupfWSeVsWe2e8q2wGyqPDXiyStuW
X-Gm-Gg: AeBDiesn3gx1bJbJ8CXsbqjPhekFdJLu5Uqg1is4y08XhCr4jCxRGiK6x2VOIVOxBJ3
	0upOUkwJsE+832BnOaqz/AdmakhL1xvQZzOw+vxobNfGlFkR8xRHf2T9G920zPSUxfWgS5SQrhs
	lrO+Jzq7YlshTSsMHWL372vQdmRB4pTUFFeK0B05oe/xVaJgz0Wu5vPFrvlGBhXQ71/2M8Nmrjz
	0VPUiPwrZGxdC2EVMdAE0cHWlfzlvdm++teogV8Cleb8gbTxxpfO2+Hwo04bhCiAfuGAmrSH6nr
	/hwcbzritXVGfCAOZ2jjYbz/KTFDmabBixQ3ZOKcmoh+jgggAFx09j0ZbUQcWQt0WVzcmDiCA2o
	B9pyZV2cm7E0Z7dpPTGqciVXLXOBHxd+d9RTSTvmmaDWlynxcRCtp7KGeme3VzfoR+9O1eeLk0e
	2StyfDDk1NBIz8fKeOobcjoyKrIeJQwzL81bPwNHwwCC9q7s26EsYN4Q==
X-Received: by 2002:a17:90b:4e85:b0:35f:bf23:bd78 with SMTP id 98e67ed59e1d1-36140461d2dmr10534992a91.16.1776601951737;
        Sun, 19 Apr 2026 05:32:31 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac16:b3b:3927:d65:a5c:bf50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141898ebasm7543209a91.7.2026.04.19.05.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 05:32:30 -0700 (PDT)
Date: Sun, 19 Apr 2026 18:02:26 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 tglx@kernel.org, christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_4/7=5D_iio=3A_ssp=5Fsensors=3A_dr?=
 =?US-ASCII?Q?op_duplicated_wdt_timer_and_work_cleanup?=
User-Agent: Thunderbird for Android
In-Reply-To: <ad9ak9zVRZXxlEqY@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com> <20260415050749.3858046-5-sanjayembedded@gmail.com> <ad9ak9zVRZXxlEqY@ashevche-desk.local>
Message-ID: <2CA4C4F2-6BC8-4970-B2D7-FCC67DE16C41@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15 April 2026 2:59:55=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 15, 2026 at 10:37:46AM +0530, Sanjay Chitroda wrote:
>
>> The SSP remove path cleans up the watchdog timer and associated work
>> both via ssp_disable_wdt_timer() and through explicit timer and work
>> teardown=2E
>>=20
>> Remove the duplicated timer_delete_sync() and cancel_work_sync()
>> calls and rely on ssp_disable_wdt_timer() as the single cleanup helper
>> to simplify the remove path=2E
>>=20
>> No functional change intended=2E
>
>=2E=2E=2E
>
>>  	ssp_enable_mcu(data, false);
>> -	ssp_disable_wdt_timer(data);
>> -
>>  	ssp_clean_pending_list(data);
>> =20
>>  	free_irq(data->spi->irq, data);
>> =20
>> -	timer_delete_sync(&data->wdt_timer);
>> -	cancel_work_sync(&data->work_wdt);
>> +	ssp_disable_wdt_timer(data);
>
>Hmm=2E=2E=2E I'm not sure it doesn't change the behaviour=2E First of all=
, the
>difference is that IRQ handler may be involved in the timer and/or work=
=2E
>
>This patch needs much better investigation conducted and commit message
>provided with explanation of all possible race conditions and why they
>don't happen=2E Also I am not sure if this dup is a mistake or deliberate
>action (again, it's all related to the timings of IRQ handler, timer job,
>and work and how they are relies on each other data/flow)=2E
>

Thank you Andy for the input=2E
You are right patch has changed teardown ordering by moving watchdog stop =
after free_irq(), so "no functional change" is wrong=2E

I will send next series change by removing duplicate timer/work cleanup af=
ter free_irq()=2E

Race analysis,
- wdt_timer can queue work_wdt
- free_irq() handle IRQ, but does not cancel timer/work=2E Therefore timer=
/work needs to explicitly cancelled before IRQ release=2E

Along with change I will also add analysis in commit message=2E

>
