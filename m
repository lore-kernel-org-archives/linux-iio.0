Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BEA3F1AD5
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297158; cv=none; b=XkxxiclS6PJnJWzK0iwZ76v3VoOFCqD8seoOLpoE4LOjxCqndehEg6SIUd3pRv/GoAZyZAKwS3vqn+/AMMyX5fnljKinp1nP6KoES9whute223b7uJja7oCzlWY1gMYZDoxmqZowLGaKd3ESC/9vF6H6gauCKShYO1ChJ1wQdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297158; c=relaxed/simple;
	bh=a+4pkVQFgDvE9l0EyyTH7FWgaU21dziFoD+rVTEcJBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O99wl9QzblV5OznKAaBtkY0wjqyawFCbsy61q3Jw/50hV+7xmfDdPbwNWOsCWSRu93GWrVTBaFNnRCpyfmvuuwBZN0P1xb5cd3NCp1HT72dgf4K83Px4NMlO1rO4A2skfnoRiYJC2PUl5+3Uyo3FKwFiw6nUegkTks38Bf1cvKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti+mQ687; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti+mQ687"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49021532ebdso20472645e9.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 10:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779297155; x=1779901955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VNpxJpZImBs2DL2eNAsFduxFIRxVVChzzo7ko081ns=;
        b=Ti+mQ687Amjhw8vR/V6Ytlujk0CrxqiLvevF+tWHS9U9lyOs/wcHnHSJaMOpvoIGFz
         Oy0T1Lo90IJj0DTRsqluYL95Jf276MlvsFK5cFysTkILQ2Yg/GGYZtxWWcpakJUzeeXm
         et2HZkWFuWMSYk28TTGhm5lqOWndNqI4MAz4L6VOjC9YpN5HGts9BY8x2OMu4Lv1CxEh
         /a3SKhgSQr7Mk5Ylw1ir1yohs/FawjEoAVsmufoHo02kWweuYY5DahIFthh0DtPk2Cxn
         IpXwNx+V/QyfasH6QUA2ZNLhVKxSiXruqkhIk51emZvd/oEvfBFWtDaNEZAhtkt+I2NG
         pvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297155; x=1779901955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VNpxJpZImBs2DL2eNAsFduxFIRxVVChzzo7ko081ns=;
        b=UoMUBpHuxiSOMY+J6f4FYQeed05gaWKrWDwAdtD/BYdu08MMoXc4CEBKR5FdvbLp3q
         lSS7xgrxt0n14V7ti7xKZq+r43VLP88uz5txys39jvHsluXqthGVUqfWqGoUkGL1GI35
         wWRQ+E6Sb/quVAKtKo4IDucqOa7auOzVzLBjNxt15Gzsgmyk6pUDQgU/k7ctvfewnVhA
         wEtuQTy4ZJ/IVCSwU66NGR5SIlmCC9bTeinGHJuSXOKraJBGwb73LH18VjsEFpE0ElHG
         4vDI/kj96pw+75Te7rSu1vGehTOIzgIAZXEcc7zYbeD9lfBSksYAHHuFfeXw8v/PcX+F
         7hFw==
X-Forwarded-Encrypted: i=1; AFNElJ9RgJDHKO7P1bCTPFVCHhL4d4nhFaY4YpCuwuNZ85mpzo0ylH3EdRW0L0eWqgekj3DJLl2YDHT2u+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7nUv7XZkrvahQdxqClvOYVoLhkQXr5Yi0kfJaZ5oVbRuAnQ4
	H1rWCVcFOftTXUib9Gtp8XeXPWwCoJGytLOuBx88GqLo4/EsybXEE91T
X-Gm-Gg: Acq92OFtGKk0O6+WF+3Eu5sPcroL2CcJGxM/WXu3x8ZedIeXJAW8rbVP3culFbWpwy/
	L/POvjwHsky7+dVHsUlG6BY6ZIxW+CUrHbdsi8pY533xUE/aR3z9zXidf7tpDYN2IkmHkEC71Ii
	QSbUGgw/HZ1MkTxAANP8Bo0xdmiQxEL4X8jmiDYGt8tZlRHX9nVhdwAuHLtRUkKpWJoEWLBa9Y6
	lRHH0VloAQrO8VqmwQZiGghaxxS4SC9XmpQiNc60cnmaNuPyFcE8+1/bev7PfomZFU1GKeFct74
	EPTkawvp5XgAYePRT771W/4ID8AjoXSTfRxNGDa6uFFcemCbn8CzNTElfI5abeRX3B0u7a2Ks4j
	UUilloMHQMqkexeyFrPB/sgHpU3BmThCWLf8j3o31/+RJ2LeZfNsstOHR+DgDMJ3QPcIGPZPhFB
	5CIVmYzn3UL43DR12IEu5dU3hcVvKT5Ukf3nPnMo+JJkC5K34C2jkZwkQHc/fwWqJIjlwIR3w=
X-Received: by 2002:a05:600c:4e4e:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48fe5fd4747mr410414845e9.6.1779297154567;
        Wed, 20 May 2026 10:12:34 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:f1ee:c5d:74e4:6e19? ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fead15bf3sm135251275e9.6.2026.05.20.10.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 10:12:34 -0700 (PDT)
Message-ID: <7f56ee25-11ad-4dcf-87bc-a353bed3f914@gmail.com>
Date: Wed, 20 May 2026 19:12:32 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-6-aldocontelk@gmail.com>
 <agRfMWL9BughLT2x@ashevche-desk.local>
 <36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
 <agS70Dph8-zQT-e6@ashevche-desk.local> <20260515190517.70bb0ba5@jic23-huawei>
 <1c87362a-bba8-45b8-a836-153f468815c4@gmail.com>
 <20260516132555.64e27d62@jic23-huawei>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <20260516132555.64e27d62@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/05/26 14:25, Jonathan Cameron wrote:
> On Sat, 16 May 2026 13:04:13 +0200
> Aldo Conte <aldocontelk@gmail.com> wrote:
> 
>> On 15/05/26 20:05, Jonathan Cameron wrote:
>>> On Wed, 13 May 2026 20:58:40 +0300
>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>
>> ...
>>
>>>
>>> I would add for this that, to reduce churn it's fine to add the
>>> struct device *dev = ... bit and use it in new devm calls. Just do the
>>> remainder in the follow on commit.
>>>    
>>>>
>>>>   
>>>    
>>
>> Hi Jonathan, Andy and all!
>>
>> Thanks for your reviews! they’re teaching me so much!
>> If I understand correctly, I need to wait a week before submitting version v3
>> such that other reviewers can comment right?
>>
>> I’d like to take this opportunity to suggest two alternative lists of what
>> version v3 might look like in terms of patch order:
>>
>> First option does not consider the "== NULL with !" patch and so:
>> 1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug fix)
>> 2. iio: tcs3472: sort headers alphabetically (same)
>> 3. iio: tcs3472: convert several functions to use guard(mutex)() (modified)
>> 4. iio: tcs3472: use devm for resource management (slimmed down)
>> 5. iio: tcs3472: use locale struct device * for remaining cases (NEW)
>> 6. iio: tcs3472: implement wait time and sampling frequency (revised)
>> 7. iio: tcs3472: move standalone return to default case (same as v2)
>>
>> Second version will consider it:
>> 1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug fix)
>> 2. iio: tcs3472: sort headers alphabetically (same as v2)
>> 3. iio: tcs3472: convert several functions to use guard(mutex)() (modified)
>> 4. iio: tcs3472: replace == NULL with ! (NEW, optional)
>> 5. iio: tcs3472: use devm for resource management (slimmed down)
>> 6. iio: tcs3472: use locale struct device * for remaining cases (NEW)
>> 7. iio: tcs3472: implement wait time and sampling frequency (revised)
>> 8. iio: tcs3472: move standalone return to default case (same as v2)
>>
>>
>> What do you think?
> Either is fine but swap the last two patches.  The wait time one is
> more complex than that trivial cleanup so might take more revisions.
> 
> I frequently pick up the first part of series just to avoid people
> having to keep sending the same unchanged code to the list (that I've
> often forgotten about completely by the next version!)
> 
> Jonathan
> 
>>
>>
>> Thanks,
>> Aldo
> 

Hi Jonathan,

I have two quick questions.

First, Uwe's "[PATCH v2 0/7] iio: Rework i2c_device_id initialisation" also 
touches tcs3472.c. My series modifies the same file for unrelated reasons. 
Should I wait for Uwe's series to land and rebase on top, or is it fine to send 
now and let you handle the overlap? How does it work in  case?

Second, the first patch in my series fixes missing power-down on probe failure 
(goto err_powerdown). Do I need to add the “Fixes” tag?

Thanks for your time.

Aldo Conte

