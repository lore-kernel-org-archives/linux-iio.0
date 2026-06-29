Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C32DB788
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759351; cv=none; b=luFza7ODZXScGUQ7LSmLKaa0OapE20WyD7YSJZgan5dGvxFOYt+m67ZKFhxBQysgsFKznRbswIYgXtfmcv94YLzOmmKeMgkkgmVHZii2GWz3V1w6L/zz5WnVL/1TwqGKyZ+ouMXdWXxbW3B3SpPDJVs2MOFM2g7j6CoaqApyGnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759351; c=relaxed/simple;
	bh=/tygSJ+Tz4c71hbnSUm6Y1+0DuA4LX1ppuFQ3tGuM2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfInBqinGeNmGtPwpOKFD6GQTyvbz1QS2TuOyRCLFweb5NHU9/XE4oIRP9KdfMkwRE9nkLh3KN6yVALVmAeOu/2gOQYk0u1Y/Kp3mVnHKYBm/0hEHMpJjMwOTc+I6WzKVliP4O1xpEKdZnjqQDB8hgHxenVhllbR5VnGFLYyEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=S6WHVo05; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="S6WHVo05"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9c6ae2a79so1373389a34.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782759349; x=1783364149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACK0vFthHW+jDVGTIXTjlhgZggTZeawplRcDp+RV9vM=;
        b=S6WHVo05v2RFcTru6gdeyY7VWJdY2lYOWekq8VBumRvcJXAUICpCAsqAWDYAN60qcD
         KxLxWDvarwmdSrnugo7AApFhOGuE50ddUEG3Qg7A1HKg7Cr8JSPnisIRBaWgzWhb/sv1
         u1+E7nuSouy649d+e6QAbZiVA0LdkqxyBe5iyP8aJqE4N1j6dfKyICeBhFcz2Q1oqO/D
         Y6KdX7ezn75L5ZkO6PUPG2ipqx8oHOa1/cTGcrsY6t9UP1Z8QgnG+SsWEk279l+P0kX+
         hlsBHpxZj3fvvVMghUQFQPHMEhwv5rScyrPeIgGtC/Z+u6yL3GKwFibdx8yI7qjL2LIb
         Vseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759349; x=1783364149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACK0vFthHW+jDVGTIXTjlhgZggTZeawplRcDp+RV9vM=;
        b=kLpzcuIv/X+GVJPu0Nc1ft2Sa9XuLN/+GJ2Nd+h/im/BHJjOaJyHtJik58uw7YStnJ
         mwfZgFJgghrKDOkCryO0Eg3GOqg492EUJ+iMLeyReL1hiOJ7Dugnj8wjAOwawr88+6lL
         kfsifak13hdUMKHwEcEpvZIyp83lgFB9RjobCzGp+UdIGVynIpP+k2Sfwc3fNCDG6XsG
         RYaEUhht3IS9HeHHpPpWGsqj8T3mJlcfuQhPpXaoSAZS62RDNHh9TH7d75DHXZkcakFw
         0tfdvu1ovphvc23cZqQqommdg7SgYRj5Di3/UcYnBPQ+jStHQFwlIsvQDwqLQJF1PrUl
         YneQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vMYycXpJBnGaEaAu6v6SWGDlvrwajPL/EhWozKr+3tHPbE9dGgMqHwq1MMrsQqL3iU/LGpZosRao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3Ig6qqjUX42O0BRR3QaLBcvraL0e3g0y6piQnMF/7qpPXrVx
	YMZB9lI0S74S3QB/c1rLorwek1kRqV2uVSms0YqmoHK2fE5kmHydkc+oT60VPiIIttU=
X-Gm-Gg: AfdE7cno4nZIJg5/291Plnm1RAZdjTpizMusJm39ZXByo+/KtcpW8Z3L96UMDpPPXZc
	gHMvmN0g09MfGgqw0ExRIbwrh4VcDl1kzBo2MDyd9zoVAFbLGF7Y3kq17+E2pHbq501cqfA7LrW
	k7w1r+UL2Gp/jR19uB/sqwIxZxxZMrBOErWeMT+JfFB4j0vaZJfbUSsH316+1Z51xPjLxcG69yL
	qonmt0d9hijylwUXewEpe/vdT/agH7oRK9zBvCtRbuHFf1eeVg5hU7SUIV0haz/AceQmOvVjesC
	aC+pEAwdI7J5QmV7LCGnEK3PFQeR3odRnCH6rANQEDujDFfnSzIB+qFzIdMbB0vP6gD38jc5Lki
	ETeK+zhWxfii/dE4ZbUmKl2nRzPWF2AOA9efxYFQ+803DYIOv/ZzYiW0KdK1F4oBSusz33j6d/7
	MxhNo5JxNpLQy7QR7esug3xxbV6lzgHLiHMG8vWwkVHIe1B49zyMzvsfWTySTYOlg=
X-Received: by 2002:a05:6830:6d26:b0:7e6:ed97:ce52 with SMTP id 46e09a7af769-7e9ec724d6emr557381a34.20.1782759348858;
        Mon, 29 Jun 2026 11:55:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3533:aa22:9a69:df1c? ([2600:8803:e7e4:500:3533:aa22:9a69:df1c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2ba18esm461442a34.16.2026.06.29.11.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:55:48 -0700 (PDT)
Message-ID: <2cdb9cd4-8e6c-4bdf-b14e-2191b104d229@baylibre.com>
Date: Mon, 29 Jun 2026 13:55:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
 robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-2-jakubszczudlo40@gmail.com>
 <5e96801b-50dc-4752-8e00-1a80984ed997@baylibre.com>
 <20260629193329.34fab6e3@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260629193329.34fab6e3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 1:33 PM, Jonathan Cameron wrote:
> On Sat, 27 Jun 2026 17:31:24 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 6/22/26 5:15 PM, Jakub Szczudlo wrote:
>>> When device is suspended and it is in single mode then changing
>>> datarate doesn't make it actual wait for new measurement, so to
>>> be sure that read after change is correct functions that changes
>>> datarate and gain will wait for new data.
>>>
>>> Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
>>> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
>>> ---
>>>  drivers/iio/adc/ti-ads1100.c | 74 ++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 70 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
>>> index 9fe8d54cce83..e3c801381434 100644
>>> --- a/drivers/iio/adc/ti-ads1100.c
>>> +++ b/drivers/iio/adc/ti-ads1100.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/init.h>
>>>  #include <linux/i2c.h>
>>> +#include <linux/iopoll.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/property.h>
>>>  #include <linux/pm_runtime.h>
>>> @@ -43,6 +44,9 @@
>>>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
>>>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>>>  
>>> +/* Timeout based on the minimum sample rate of 8 SPS (7.5s) */
>>> +#define ADS1100_MAX_DRDY_TIMEOUT_US	7500000
>>> +
>>>  struct ads1100_data {
>>>  	struct i2c_client *client;
>>>  	struct regulator *reg_vdd;
>>> @@ -123,10 +127,49 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>>>  	return 0;
>>>  }
>>>  
>>> +static bool ads1100_new_data_not_ready(struct ads1100_data *data)
>>> +{
>>> +	int ret;
>>> +	u8 buffer[3];
>>> +
>>> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));  
>>
>> Do we actually need the cast here? char * is like void * and should not need it.
> Hi David,
> 
> Any more background on this?  The void * implicit cast thing is in the
> c standard.  I don't think there is anything equivalent for char *
> 
> Thanks,
> 
> Jonathan

Oops, I must have been mixing that up with special type punning
rules for char.

According to [1], char is not compatible with either of signed char
or unsigned char.

[1]: https://en.cppreference.com/c/language/type#Compatible_types
