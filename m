Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A643ED5B2
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821330; cv=none; b=Wdk3C9bmc8SQ6mNHhWNsOWKNgT0dSZ2v52knuNAHGdVG2dVOVDiC1uSjrtkxSspn5VjaSOVUfWb5j09/1g6O4yqPI5J4NVo+10Gf647u4MZpzCe/fi8oTsz0koGSHkdUg7MbXR0IwlgRILyjXzjyplyjour4krxGSI8M4ofAvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821330; c=relaxed/simple;
	bh=ONMuFW5EI8/RP0a/b2yROQE5ScuQZO1jXKqHS+L/EAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cweKeRFZMKM9hoCol7qqelMgY7rD6bOGQAfWciTPyKuY0tpk+/UYhzU7hbmDyvRRtA0VctCX4DzBcaWSNTSlr5+ZPJOo87sA1Nv27OBsWehZiJY4Qgj7JCn4VH7nUlVaD2evi0/Ix+983GTUXZq2lqdPJUyraQrSVilj60juoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dze2Zrv+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dze2Zrv+"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3995e22ef81so5181421fa.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782821327; x=1783426127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kJ9tc/96xskuFmv4hVq+DCV3Ln9QfqN1toGcCy1OAs=;
        b=dze2Zrv+xbMQdAeWIHdS/Qq93aPXXeVJY3Wf2zIZbHr0cc9/jHrP2THjGSOLtCG5WQ
         gLEv63V6odk0yx3H0SIBxKeb29/3AS4quGAzlorhVkXa472T0AI+R64OICrvn/PU7Eso
         FyRWtgdEmQpwqs8a4tZ7JH8Oin33EqawmZeKknqDnlt8yAxlp2w1MVx/zcqBfcFq9FT2
         g/w0F/YfDt2NzXDsQZ5ZfYmlpBXXfdB/SvEGyCyPlRedpp0NHG40HtmLaCIhXRoJCtWv
         Iafs6osFPcC4bcqIAiqSFvoyz0qsNyVCqLtenB/Yr0AUCXxiNmZU3L9p4jdwLP56b47H
         KWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782821327; x=1783426127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kJ9tc/96xskuFmv4hVq+DCV3Ln9QfqN1toGcCy1OAs=;
        b=WMetvSgbCWcVXu019Ge0YkQ6vj/0Vx4cUXT9R6ifN04BcuLIOqa9ZjsuL8sYAJkCBt
         DGO9QBu3h5rtiXXQp88Eu51LVGYTNBlBSMc5572saJ/JOyGg02OlL8/jPzCJ2QUpRlpM
         iNDB1yRzh5fl3ed4y0n4RPXDNqYrVq0XyvevXwmxZBZRvVr/T4l386Cjuau7nOgiCqtM
         HUx0SjjrjkhW4dv2ff+ytT+jotOLKMFAxMRU0zvPyULMRxMhYWRg4WXV2KEOf1Cx6wnF
         TDRKWv3jOEiolciUeQ5finVDX1gay78fPPtZGWm5PwKvownJ2RYDHb7OTWcWvudhAFy4
         aRfg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9fTrw/JKeUzG//qWiUY+H6Ly8/skOk4VeHlN4IC4fBtVNfbtsqAUm2KE/7rh31Zc7WBpeEN62bTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyImZfeLkpoKWOhT4j135Gn7sk7i/ZQ/WKlJ13WKImWRXuYsnVJ
	nV+TQ3tIDgyQO0WHwzPiHZ3KwLXHh6ZKp3e4FanC2t5w7A1qYyfkB5rA
X-Gm-Gg: AfdE7clEzJ7/1+7Ubb1bDkj+40kjhsDuSuPbN0wyqeAOHD0Iq7BJMlo6P9jAPJiCc5U
	gqgOIuYCnkE421/bTbv7Hfzex3lGzyPFYRWgJfL9JmpjpaW8/Dl9dhOSWjUk/T6e31gJ84uGBy5
	h/ZW668+lwVcAlGEX26wqgArgTEfpfJ5JPTn3Toy4R3osNc+upDG/bIhiFu2ay1LkVURcnE5q/K
	AtwP1Zsuzdnlof2kuYo3YwbO4ag47Ivq2vVM8eZM7p9i/V9P9Q2sm6UDprPf1KTKgOwR1IuZrpZ
	dGV/RofDnF607nPrwM6PHpQy3yFwNankDA0YRYyy+kpqGyq/ftGxx3xBjI66rLg2m6J2UW2hOor
	/NBErBWm9XKwgQ4NGIwW8fEuLcYeiclU1KIjJxwqOWSvTgnJKMtB74z4Dgf4PAbe0xNYkCh8a00
	uVTqHtGNPBrvJnL6sG+i+HNUJaY1G2o7SBlkqALH3yEcGyusxqRVm5LkiaVdmlgaxTLbpQbw==
X-Received: by 2002:a05:651c:150c:b0:399:7aad:889d with SMTP id 38308e7fff4ca-39b24973227mr4052271fa.12.1782821326539;
        Tue, 30 Jun 2026 05:08:46 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b1da1d279sm4767611fa.21.2026.06.30.05.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:08:45 -0700 (PDT)
Message-ID: <e966a0dd-d8ef-4009-b609-546a48bd16f4@gmail.com>
Date: Tue, 30 Jun 2026 15:08:42 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, duje@dujemihanovic.xyz,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
 sakari.ailus@linux.intel.com, wens@kernel.org
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-2-jakubszczudlo40@gmail.com>
 <ajpO9zaZbIl3x1uC@ashevche-desk.local> <20260629235118.1abc4067@jic23-huawei>
 <akOqIVDibovrbBAK@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <akOqIVDibovrbBAK@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/06/2026 14:36, Andy Shevchenko wrote:
> On Mon, Jun 29, 2026 at 11:51:18PM +0100, Jonathan Cameron wrote:

// snip

> 
>> 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);
>> 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>> 	if (ret)
>> 		return ret;
> 
>> //note that we 'could' do what some other users of ACQUIRE_ERR()
>> //have allowed
>> 	if ((ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
>> 		return ret;
>>
>> I'm open to hear if people think we should allow this or not.
> 
> I'm against that. The style is prone for errors and readability issues.

I used to use assignments in conditions a lot, long long time ago, when 
I worked in another company, far far away :)

Andy, I promise you, you would get used to it ;)

But for now I agree with Andy. As long as assignments in conditions are 
a No No everywhere else, then doing an odd exception sounds, as 
exceptions sound, unexpected. So, even if I am not strongly against 
assignments in conditions overall, I believe that doing it just in one 
odd case, indeed brings us readability issues.

Just my random 5 (or so) cents.

-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
