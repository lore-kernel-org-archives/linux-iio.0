Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926E375AC4
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917589; cv=none; b=ZlIS/t79D7bbksLX7LxhKkqgZpWqc6qJFP6rZ4mYxgyQdOUKfoUoz+svAOPW1PxQRP9y0EQHj7DAjOgcJ4zf1wH8l7Pm4XwVesWGvAewSPN6/iVUJH6yF8dMEA3qOrBStI4z2assTdHleNmgalwVe7noFplPMCWVarkRaYV+x8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917589; c=relaxed/simple;
	bh=GRPY48Aa9FpxnnKsJcyzTy/OFANTJJLSsDtZUcY8Z+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6oExDGsVzTT6m+XmwtXKDwxh+4tvsfe+PEKh+enNxJUWvta6tW+AAhoL1+XpkDu5u4mn+5ADhc3AzGpQQh5q/2XUUujcrPj0Q9lQKO0bt9Gy0hPsZwqTrNNgJWQvPpHiSfH75OzSVGvmVLxCIvYHOb/FU2Vj0KEvCAU3qixqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyz3w4Pd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyz3w4Pd"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c742723c863so435218a12.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773917588; x=1774522388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3w6izYfrairSJ55395BwrKF4lapRGrqNyaG/W4OCKE=;
        b=fyz3w4Pd+Ug3siwCOR4Adz8eOl5axEXvBxQqYDafh9IalJNm3EVgvfdTotxDTf9K6T
         mzAwAws+zW/TTrMYHDs/WTiIFa6BEXPcJATUbJ1KtJefnISF67YEzTXR457vMq53HjAm
         9sngy5AGL+i+1ouOrYm41TkbaIyKCcX0pzgc6hCX6wAoDYW5AW15HThxFqXztLbvJ/xE
         x38haklgNvMOYmwQtWFPpVA7GAXUAjaOxsiyMVhmhUKYkr/6oPuIbP++dwo3axndMAwm
         gIB0pStS3iEGINe2afucnlE1YxaV9nSHZufxC+y4rh4pUDozQme4Lkp5Zcrl7CT/1ag1
         Y6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773917588; x=1774522388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3w6izYfrairSJ55395BwrKF4lapRGrqNyaG/W4OCKE=;
        b=Qli/YyBKSXBQ3IIapocBh03yO08F47y6G3BQZlWyA3GZwb02bkWY8+GoEHlFneEUJV
         /wTQf+iPLkIIkZdWqMiYy4+fXpm3Ge6zPRFcuWqqeK4BN6loSG7FwHzi+rQqPmER7Ne+
         1N8E7iWRlwPzGHv2NjeR8zsT2XUsV4obyRaLSrCB129GaNTPLw1lqJFcaLjuQTngIgoF
         7eOwNutaPqSo2UZsS54f7UTyF1pn2jdJBaQEjKq67Ui+8NaPgrlLsWxJNb5+JLSW4XaP
         6NFFWAiCDx2+1T+ksD9ScLLYXxYaxzaf1xW9RWIvDSP+/9IHiIbF1YkpxcSEYaWOJnTa
         LqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJTj5fAxlATip+MhUvih0i2CmxxrpdeUtz80Q3PzZvbR/YtCapJSv78Y+iXxh2+vQe4Cgl9As8yQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX/O3BKmDqCY/5A34hZnggQf0zYoTfWyYvFE+EslADcd+Ax/Y
	gTvCmK6L28oQmdZp/cvceOFNA835zuGfOIMtpc/iJLYEuZ7/FlaQGsdP
X-Gm-Gg: ATEYQzz1eDqWKYHofVrBtOX1Xxw731gkCIEed+wX8ompnbM+OIkjqzZnU/Af56SMovR
	1sgn8T/JU3N7n2UGasgdzLawJo43a5IP7E8rwBGP/4nAVjx6WwV+qMO006ZhM+dskGxi3Lq7wGi
	jNdZVTAoYiIkh8hzMH9cokCpqsR8MLgubUNnpS6DdfwWPw4YKhCmLA/fQu203RoW+JI0MBDsMzU
	iWe9DpY/HL2BnmpN2vOApaDo7nXqGF85uNVAE5xsJOPtMJJB1XgGKHjnlbCHDbze7hQuORZ5Dvj
	r+xUqHWPscVt1JRbcIyOwGHXtGByBDN0Rp9L1Z0+bFQz/3fmVAaXdUw/EpndLsIkhRmQcey4eQ1
	JEhdk4oeEa8uh2FxZNislEmWcXyoyn+7uJp7VxKAA2fqLclei6tUEdmAJEfB2J0TMliJ8SkjeW3
	+qqwT12RbGmR4UY1+jCaJOrKaCfczPjFs=
X-Received: by 2002:a05:6a20:6a1a:b0:398:6fd3:7696 with SMTP id adf61e73a8af0-39b9a048bfemr6537821637.59.1773917587866;
        Thu, 19 Mar 2026 03:53:07 -0700 (PDT)
Received: from [192.168.0.106] ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e58522csm5653942a12.31.2026.03.19.03.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 03:53:06 -0700 (PDT)
Message-ID: <f08030fc-ebbc-41b3-9237-a3a646ddd7e3@gmail.com>
Date: Thu, 19 Mar 2026 16:23:01 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] iio: ad_sigma_delta: replace deprecated
 iio_push_to_buffers_with_timestamp()
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316172735.11430-1-atharvd440@gmail.com>
 <20260316172735.11430-3-atharvd440@gmail.com>
 <20260316181943.50acd1a3@jic23-huawei>
Content-Language: en-US
From: Atharv Dubey <atharvd440@gmail.com>
In-Reply-To: <20260316181943.50acd1a3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 3/16/26 23:49, Jonathan Cameron wrote:
> On Mon, 16 Mar 2026 22:57:27 +0530
> Atharv Dubey <atharvd440@gmail.com> wrote:
>
>> iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
>> iio_push_to_buffers_with_ts(), which takes the buffer size as an
>> argument and helps avoid potential buffer overflows.
>>
>> Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
> Hi Atharv,
>
> Thank for you for your patch.
>
>
>> ---
>>   drivers/iio/adc/ad_sigma_delta.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
>> index 7852884703b0..73f3069da987 100644
>> --- a/drivers/iio/adc/ad_sigma_delta.c
>> +++ b/drivers/iio/adc/ad_sigma_delta.c
>> @@ -636,7 +636,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>>   	 * once, there is no need for sample number tracking.
>>   	 */
>>   	if (sigma_delta->active_slots == 1) {
>> -		iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
>> +		iio_push_to_buffers_with_ts(indio_dev, data, sizeof(data), pf->timestamp);
> What is sizeof(data) and why is that the right value to pass as the new parameter?
>
>>   		goto irq_handled;
>>   	}
>>   
>> @@ -662,8 +662,8 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>>   
>>   	if (sigma_delta->current_slot == sigma_delta->active_slots) {
>>   		sigma_delta->current_slot = 0;
>> -		iio_push_to_buffers_with_timestamp(indio_dev, sigma_delta->samples_buf,
>> -						   pf->timestamp);
>> +		iio_push_to_buffers_with_ts(indio_dev, sigma_delta->samples_buf,
>> +				sizeof(sigma_delta->sampkes_buf), pf->timestamp);
> Likewise. What value does the new parameter take?
>
> I'm not going to review any more of this version of the series given these are
> both incorrect in the first patch.
>
> Jonathan


You are right, both the fixes are incorrect let me try more on this. 
I'll send a smaller patch series first and mark it as an RFC.

>
>>   	}
>>   
>>   irq_handled:
>   

Regards,
Atharv

