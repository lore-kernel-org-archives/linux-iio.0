Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3D389DE8
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862300; cv=none; b=HnUa36OD+Fe3jFRcNbyiYt4+ysiX/wJWCAj0AEfPCgkrCsmirrp5ksF3uYHLrlvQbc1flGTMCOhynslwJvbXBsHR+AQ87GExt0MIrMQsKKeU6OHjUJcC+aKuCk4tomdMNCXe/cr0LfSDh5rUpoQ7vBJUqZN6NfsKW0QlKw7ELNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862300; c=relaxed/simple;
	bh=M4bWTGLnCLaO+TO/85lAruv89fU7oLMOasdBJRCH6vY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sKTRbdO/ibUGMgCIgWWze+noTbvj6PZQ+2MHt4DFGG5TXL8ll3reaUH2NVy15qgcnY740XlcrdbIY5mJ42aAHqNewXdfH61CmpG3zyK/6YK9u3P6PzyWxKDjwusi7oPoTysjYVxxJXoNSXz6qYoTPOTzSQb8N69BFnxiqNp0m24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU1XxFj2; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU1XxFj2"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5509478eec.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774862298; x=1775467098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7pksNBDBw8CfIH5nUCqG+cUSF8B7PMFDRBSVThR3J7Q=;
        b=FU1XxFj2gLcILmP/wBxWKAl1cSyTsLw+NuYyjVKo6mzpmdcnljqAzTDePU301fnWPK
         mWXojTEWXlcFJ7+RBae4qKvH8zVtT+HsrobMxZWdzuqSKWboJ8ODbsErvr+O8MuwP0YK
         mQCHeRIzO+Q90rrmwY4snBS2mioI0ePn1gsz5bjc3K+pbek3WFmpWPgmf/LpKewXSz0i
         uq8aHTT/7h0N9yKBPax8IX4Q2AjW/0WhjE5bpXrlnnU85hLP7rfdhqoZWjMTS8c6HwSg
         /DPH6or3IOtJ/8qhdeKOugTSaHAMFWvTNudsKvRzTr7uhMR3Ykt78wAEwRfCdFdjQs5w
         3iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862298; x=1775467098;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pksNBDBw8CfIH5nUCqG+cUSF8B7PMFDRBSVThR3J7Q=;
        b=oOCfoDGEoyCpZynfezBdKEyEahEjzj9qtR1oYRziQsDgA3Al8sVZmmYU6hf9wwGZxl
         rUlHCte1yrP3Uwc1tkjKBoCXwlwZ1dFNczgaGoGlh+7A2qARiYcUd/1x3zhqF0gKwGV2
         uooPWdJ8ukbLI9jSrj4RqJjMFnLpM7V7zreCBXr3A4bsgYDuzvlTzy4pIeGkPTOLqRHA
         0qefJ1C26anP7kTrSgjzdDJkwSPu52W9QXYCmyAUfsy6HVwXpbJtwUCb+9ueTVixZx0u
         TTiE2JiJDLp7QQKsmV3Z02s21rnV8iIdByARi9wo3fuQIAvN2Cu/Gi87sQqrEvAv2I0B
         3aqg==
X-Forwarded-Encrypted: i=1; AJvYcCWvuYku5tx4+cs4FBkfCuM6mA32FFtPE5OchbGlb06izE+91rBB3O+hkl4t/ws2/DeqgMvn+41S8+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlzEWfn+hkvOp8wZmhl9MHwv9gRMsVdD11+uWV6ucCJRKqAjbF
	EdMsFBYxy9xc1Z8xNy/6f5zMbQZJGWQmSbNFS9+84KpULdjHL5KI6cWE
X-Gm-Gg: ATEYQzz0WFf9lM1WqFRB98U1SAgfB3Nf9DX7if2q4jRbsmH2SbziXvApLgSEQK53LIf
	nB5EQglhPmYE4XpJjxPH6P9xRtPDoezO15oZuMBQi5GT1fcdvIDAg0R3r3DHINq5b7CggmoPeSp
	xzWiDrCgXRUP1R/UBxmaa/yyrbUGcaQI6xTsyg6vWuhjRWsbM0SpV3OwM6vNGajfv/Y51U4kBAa
	8Rlb2mluTk6Y3zY9YXOfYOU1mul+mK7sNkWy8olCnfF6rjUb6j7pocZ24UBYqoaxYGqr7HAUuSo
	72GFE9/RDmivpzwTOvv300xjWEi3rr33HWpJlgl6CXbieqbaR4bbScSYWK8JEcaPCAkjLxvYpqN
	b+ja8nUHB6qdpErBdY3x1ng7Vuar35P0jIKv2aWivw+dvcxeInk89jno3o9Jp0bfPA6TVh1g0Ox
	WxoNpdIIVmRxHcGNm9iGvUu8KhfijTSbl7tJ9K443n8AA=
X-Received: by 2002:a05:7300:3215:b0:2c5:9595:661b with SMTP id 5a478bee46e88-2c595956c37mr2016783eec.0.1774862298269;
        Mon, 30 Mar 2026 02:18:18 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2601:647:5e00:4acd:93d2:64c6:bab4:293d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9c088sm6473690eec.21.2026.03.30.02.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 02:18:17 -0700 (PDT)
Date: Mon, 30 Mar 2026 02:18:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
CC: =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/4=5D_iio=3A_adc=3A_ti-ads7?=
 =?US-ASCII?Q?950=3A_switch_to_using_guard=28=29_notation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMRc=Mc0hMh2vL1qPo2SdKqvOKDEJaXm6rGKYeuA6mc8va2FWA@mail.gmail.com>
References: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com> <20260329-ti-ads7950-facelift-v4-1-c568c508c49a@gmail.com> <CAMRc=Mc0hMh2vL1qPo2SdKqvOKDEJaXm6rGKYeuA6mc8va2FWA@mail.gmail.com>
Message-ID: <0A3A1E2F-0A03-46C1-A7B8-A56B4610359D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 30, 2026 2:15:42 AM PDT, Bartosz Golaszewski <brgl@kernel=2Eorg> w=
rote:
>On Mon, 30 Mar 2026 00:47:06 +0200, Dmitry Torokhov
><dmitry=2Etorokhov@gmail=2Ecom> said:
>> guard() notation allows early returns when encountering errors, making
>> control flow more obvious=2E Use it=2E
>>
>> Reviewed-by: David Lechner <dlechner@baylibre=2Ecom>
>> Signed-off-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>> ---
>>  drivers/iio/adc/ti-ads7950=2Ec | 83 +++++++++++++++++-----------------=
----------
>>  1 file changed, 31 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads7950=2Ec b/drivers/iio/adc/ti-ads795=
0=2Ec
>> index 028acd42741f=2E=2E6e9ea9cc33bf 100644
>> --- a/drivers/iio/adc/ti-ads7950=2Ec
>> +++ b/drivers/iio/adc/ti-ads7950=2Ec
>> @@ -299,18 +299,19 @@ static irqreturn_t ti_ads7950_trigger_handler(int=
 irq, void *p)
>>  	struct ti_ads7950_state *st =3D iio_priv(indio_dev);
>>  	int ret;
>>
>> -	mutex_lock(&st->slock);
>> -	ret =3D spi_sync(st->spi, &st->ring_msg);
>> -	if (ret < 0)
>> -		goto out;
>> -
>> -	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
>> -					      sizeof(*st->rx_buf) *
>> -					      TI_ADS7950_MAX_CHAN,
>> -					      iio_get_time_ns(indio_dev));
>> -
>> -out:
>> -	mutex_unlock(&st->slock);
>> +	do {
>> +		guard(mutex)(&st->slock);
>
>Am I missing something? Why isn't it just a:
>
>	scoped_guard(mutex, &st->slock) {
>		=2E=2E=2E
>	}

Maintainer's preference=2E It was a scoped guard in the first iteration=2E=
=20

Thanks=2E=20

--=20
Dmitry
