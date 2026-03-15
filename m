Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3820C461
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591506; cv=none; b=CglxtnMWsx7wplNqL4hdA6tgb9mNm2Ntnl+ObpoUyotACtk7Ybknt0lCCHT6qRvwZpdtiRGWx6an8SXnrMEL8CXMR70puR397MQ3AlIfkdekCgbMXcl3UzB8CgjF4tSKevvBMLDa0vqcx6FB1t2waBFy2k2wGYS49oXKfxA7NmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591506; c=relaxed/simple;
	bh=F3ScU4ei0dPC2uTa6fWGvYi5DmKd43wSXk1cq6nJDOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VidQ+aLff+VbbXLCkQzL9EYjFT3LzzMEuKkzxInnUx0MZm2UBlE9HLAoD5sVg3TnlZQpXW3+8pO+zk2RqocJfWzOd76PTMXF9Ys9wR7Q6jR1mxZYT0QSuFDzojeUIQE8M4n/3lsz2PFFYlyx8R/0HIgeAMCrTA7+gHCWX9iFKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1lx6+knw; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1lx6+knw"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46704fbf62dso2433120b6e.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773591502; x=1774196302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qAeOjm0ouHGpcjjkksiT+wnuJqg4kY01XS+8zm226o=;
        b=1lx6+knwOulAxI+Ta+0tralAfuYyvwFi5dJNog79kXUdnoEXuMLU7UJ4nReVjiVsug
         LBYJagO2HAuNFUzcQZ/T8HpGdXvdjvZ8mo8P4/0r8xX5mpLk7jqxZMYzMxw0V9ycZNt+
         Yc9M4e/O/PQ6VEq1KvTM8+DmzGTvSGX0eLfuIHDq7+PeVXmw0pk9tIIK+GqCSdw/jOM+
         ZPcya++ZgFe51bMCcCA+wCDLVD3fZgYI9f5IlhsEU9CObhi3EYgDknALT0aBXq19h59Q
         Dzxu5BCcIdE7dc18ncDN270635MirgEVNqQDhc5+lVahm1qQY7UWazgHJHSeZOlke6ir
         ccnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773591502; x=1774196302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qAeOjm0ouHGpcjjkksiT+wnuJqg4kY01XS+8zm226o=;
        b=K0pG9CbCpDo3FeNvxknhJDz27Dx4IkUHuwapDTkopCrPtbjSW7tWUg7eCVNn1YxkPR
         0chcTA29D6T8bTXcuVyLXdKOlDZ5J7T1JyY/6Gp/LhvT3NZ1T9uVC5Q8qKglxBVjlseY
         d4u/RzdurdvQU1eX/33wMHgtZY9D3eStaB3je67HE5yGjDZ9tGITcEPW25rmZ3nvS4RS
         apRaF1c+wRFg3rLTiKllx2Pp9uZS3hJu65wjcpdIoABfQv7Urx+rPRJ0qQfk1Z0nn1q9
         9TnBtPYSBfkx2s627AS8+xVi5n5c7/OBW8oc1yWEH7Bu/uzeD2i9mvn67RA6syYBB7Ts
         inMA==
X-Forwarded-Encrypted: i=1; AJvYcCWW/ANN+GhGbI0S/6/fkOH9Do4rI7rz/u5VsVqpdx//2Ebf/NExFKl6Gr2UZofVCGYIqcyMLux/nZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9c64xs8XobkJM1xg9jlh5pKrZTJ2wdQQTS4r0uRSMjRv2CiZ
	Z9UQvO082roNlGsDWxjZ3X/EtYGvsMhjZR0m4uj+e4JCo+Ek9B0AA3WRgW3Bqiop4Fg=
X-Gm-Gg: ATEYQzztyVAqe3ZMIn+5Qb1CML82+zioJ6nmHvNO5OGD2/x5pZ7DvB4dx1FupLZAOEI
	ISYLWfl0dV15XjKsEv/t8xgDm4QblaTwGlJamkUUAbV/xKM4FeGhAFqVxqPwyG4nvmZ8mYvtL5l
	Qb2imASmXje6xoUya0S1lXOHK8l44GtQv1hwJ7q9S4u2ilBnja0RgnZ1JmC3fy1Z4HfFDBdos9A
	5qyqnHwykQyWlMvZ7F3og1qwCU1QruztHKaH50RSIe8xS+rufKakCFgYL2ZnvBBts7JNUDqfnAT
	GyqJzwof5SjeTZWJkBlMVVym8RaxdX2GP3F/TOPCfAoBTT80mEwkBONt98TIwCiR1U0PvVLJVrr
	ycqi19yH7Jaj0sLhrkOvJUQ5sWhsLwZU/azwaAWUUPsX6yzynXjyXMDqFU3CtMr6B7muIWos2/4
	b6+96KsQk9VO9va6IbtAf8vRQSXvXfAiTxCtLUjHj6AP7QFOKPw6JHP+1yRWE8iMNQMMNwyogEW
	w==
X-Received: by 2002:a05:6808:10d4:b0:467:2a6e:adaa with SMTP id 5614622812f47-4675714bdfemr5600582b6e.26.1773591501922;
        Sun, 15 Mar 2026 09:18:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f27f:adf2:8637:6bb9? ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342ef6fesm8196889b6e.14.2026.03.15.09.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 09:18:20 -0700 (PDT)
Message-ID: <16d93b99-00a0-4cc3-909f-26aba8082af6@baylibre.com>
Date: Sun, 15 Mar 2026 11:18:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: fix ADXL355 temperature signature value
To: Andrej Valek <andrej.v@skyrain.eu>, linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, puranjay@kernel.org,
 jonathan.cameron@huawei.com
References: <20260313092413.35912-1-andy@skyrain.eu>
 <a2e56b5c-ef76-4a6a-9ffc-e8fe259a7153@baylibre.com>
 <25c766b7-d66a-4638-9995-b5936ca87b7a@skyrain.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <25c766b7-d66a-4638-9995-b5936ca87b7a@skyrain.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/15/26 10:35 AM, Andrej Valek wrote:
> Ah, I see, I described it wrongly.
> 
> On 14.03.2026 21:22, David Lechner wrote:
>> On 3/13/26 4:24 AM, Andrej Valek wrote:
>>> From: "Valek Andrej <andrej.v@skyrain.eu>"
>>>
>>> Temperature was wrongly represented as 12-bit signature, confirmed by DS.
>> signature == signed integer?
> Correct, temperature is wrongly represented as signed 12-bit number, while it has to be unsigned.
>>
>> DS == datasheet?
> Yes
>>
>>> Even if the temperature is negative, the value in the register stays
>>> unsigned.
>> And IIO_CHAN_INFO_OFFSET will be negative.
> Not sure what do you mean by this. I can only say, that output type was "be:s12/16>>0" and should be "be:u12/16>>0". So when some upper layer wanted to represent the number it "overflowed", while the bits have been masked.

Mostly I was talking to myself on this point. No action is needed here.

>>
>>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>>> ---
>>>   drivers/iio/accel/adxl355_core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
>>> index 1c1d64d5cbcb2..8f90c58f41008 100644
>>> --- a/drivers/iio/accel/adxl355_core.c
>>> +++ b/drivers/iio/accel/adxl355_core.c
>>> @@ -745,7 +745,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
>>>                         BIT(IIO_CHAN_INFO_OFFSET),
>>>           .scan_index = 3,
>>>           .scan_type = {
>>> -            .sign = 's',
>>> +            .sign = 'u',
>>>               .realbits = 12,
>>>               .storagebits = 16,
>>>               .endianness = IIO_BE,
>>
>>
> Conclusion = Should I send a new version with "fixed" description?

Sometimes, for small tweaks, Jonathan will just fix it while applying the
patch. So wait for for his feedback.

You can also see the status of the patch in patchwork at [1]. If the State
changes to "Changes requested", then you know a new version is expected.
Right now, it says "New" which means he hasn't looked at it or made a
decision yet.


[1]: https://patchwork.kernel.org/project/linux-iio/patch/20260313092413.35912-1-andy@skyrain.eu/

> 
> BR,
> Andy

