Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16E184
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697565; cv=none; b=cQ7ADQnNrs5IXS2dGnlME006mvLQ+bRyhrdK3wyFtOn4IpYOQ0/8OPt3MuEUc6U6huP+AwGo5teUyFTC50PfObTO+kKduOEkZ1Vvw3nfN3eG7phG9yDsZQTYP0UsnALxmLlVQEokI8aDHwvUxRsJyewLgSt1N+Q2C+gLJaj4A1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697565; c=relaxed/simple;
	bh=yRaoIX+Gxw5W4NOc1GOUXDnqw2CxdICPvpu3Ivq2vUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCRUvM6K9OX959SqW5Y5kQ8FJbRhbjfPxPOdGU9pgnZUsC2gzjHeMD5feqtXetwahhQ26LTm8nY+BP7WDUqmJ54bWCBDb02KcNc039yAYApoJwIPInJ/YN7fJh2wVA59Y/UGesOlAw4rHCaYOoJHO7KnkDjoxzQ9BDMNjuSnkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=iC+dirAN; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="iC+dirAN"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4a4c6081f9fso537807b6e.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785697562; x=1786302362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kw69Z0wzWemMAZPaY5Skc4txf5IJBcX28PQN2HOehxQ=;
        b=iC+dirANL25Ekmh5lDF8Bp6+HT/MLxhTYwsmzOQoeCHY+IOkRVu71zSWSg/Xt3FGw3
         HleJwHwUW0N1tBzSuIWljyhXAX65Oql+XR8h7kv2eJF4hSS1gADMes635cd0tDtduGKD
         KAW9vJspzJqfwcfKWv5CZLjecBkMGJ/AggN7nFpUdJ33kKyD6JJq6+nE7b4rrjD+ABSr
         Psbtv7n87YysR3BKXY7tAggR+P7vaO7jb5pP9lCwnoAKajyB4tMPRfnV182cA4qKc/vd
         WjlBdXXYetB99BJw5Q96XYtrGDhzA+xPk2T87lundV0lPyQafXPO1QI/Ggvd8i59DkI3
         GCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785697562; x=1786302362;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kw69Z0wzWemMAZPaY5Skc4txf5IJBcX28PQN2HOehxQ=;
        b=PIUyAQHIZ1uHw8Ep1IZrVXr4JS7WR8jkDBn/mQ8nUjneu6e2trCu4byIqFVASUQRBU
         waqS/ImVpSzSgwHIxpYegUIRFrgfZ02+eNXoy0JCdSij652Dm68JOSYqiY2+fcxb66Rr
         CZp7DU/FDVRqIOCxwWiAgTY87jyDSTTutaO0r0jQE1EWc5CQk/JyT4vY2o7DqBRgv7Ro
         J5ELi4TcF4HO6qDPE+i4O76HnwC2jMWkPQs5PR/WkKekyG1qzCQe0VcUTSd4QAbRsTfa
         KjZ8KuuPziyBv6VgdxyYYLqVHTLShvum6BjtzR9ClsEZ6fbm9uPZQ1nUzrOUa3+zguy5
         Pa+A==
X-Forwarded-Encrypted: i=1; AHgh+RpgeYfpJdBswLunXdeNP5c9KXC1B1sf54UBG4og4MpFmpQqszvvcsa96iiUWbOe4xiYAHMcFa/+1AE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6fBcFRQQoXBsQzhkj+9RyV9lVv0oMnUBUwz+f0ArVVT6tpkc
	SpfrwL4BORUrU+VhwycrukT+JRIfhPnhqXMcltH/SvL/jykRk5feV9/WLy/SuMnxkR0=
X-Gm-Gg: AR+sD1221zW08lRPiSzcCltxbsgtW8HKDBoKVf1O2JJt5MTbwZtT7UI1ll8jCU70q2G
	tOyPE0prwx8u+8xkeNhyz3JUCHkj9F7IuXILw0ZSJD9syb8N9LRyjR68AFWq5aBnwLsgMkT6DhN
	Fn4DT+BpchQumYxKFvXEIEO5VKtP0TFoSSgwxSY0HYU5BFcwXOgTDpbkQBOEonVMv2bQl3woa3i
	5YSF4mLjhJfalIY+Dk52f64md6bRbzuEEIHAAWk92IOG28wkrnxvL2HaDk2re+HU2OTXS8vMhUB
	T5EXSjLdQN+JAc1Ninu6lRiScmXvvHE6myj0GaSwHKctYD8YhSjZL91BVOp5yzpQB499NEEKMFH
	Nf6NVcCVlmLfFC7NXEwnjsznodKlx/js+6BddwZOwdfdGAvuohrwpOhKBYR/lOsfGUWcobaev1u
	cKompDFzJ/rF6M+QCBV+gmBkfWadewdmdPEtkwSL3IRy6Ac2BR3i8H2O2gbc4tkpLCcq3IM2sqQ
	dTUxOHgP49HR49BIEbnX11KBviMbaSj/9Yra2E=
X-Received: by 2002:a05:6808:2384:b0:4a4:da68:9434 with SMTP id 5614622812f47-4af5e329152mr11191023b6e.14.1785697561734;
        Sun, 02 Aug 2026 12:06:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58d13152sm5530140b6e.6.2026.08.02.12.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 12:06:00 -0700 (PDT)
Message-ID: <3562a294-d74f-4a03-839d-c861df604914@baylibre.com>
Date: Sun, 2 Aug 2026 14:05:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
 <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-3-eb13da38e8fc@baylibre.com>
 <20260802191753.2c98d7bb@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802191753.2c98d7bb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 1:17 PM, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 18:48:12 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
>> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
>> mode the ADC itself is starting each conversion, so we add a trigger
>> based on the DRDY interrupt to read each sample. This mode is also
>> limited in that only one channel can be enabled at a time since the
>> chip does not have a sequencer or simultaneous sampling capability.
>> Continuous mode will only be used when this new trigger is the current
>> trigger.
>>
>> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> There is some follow on stuff in here from the earlier suggestion to
> check the status register even when datardy involved
> 
>> ---
>>  drivers/iio/adc/ti-ads112c14.c | 146 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 144 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
>> index c6d83298c312..5147d10785fb 100644
>> --- a/drivers/iio/adc/ti-ads112c14.c
>> +++ b/drivers/iio/adc/ti-ads112c14.c
>> @@ -9,6 +9,7 @@
>>   */
>>  
>>  #include <linux/bitfield.h>
>> +#include <linux/bitmap.h>
>>  #include <linux/cleanup.h>
>>  #include <linux/completion.h>
>>  #include <linux/crc8.h>
>> @@ -18,6 +19,7 @@
>>  #include <linux/i2c.h>
>>  #include <linux/iio/buffer.h>
>>  #include <linux/iio/iio.h>
>> +#include <linux/iio/trigger.h>
>>  #include <linux/iio/trigger_consumer.h>
>>  #include <linux/iio/triggered_buffer.h>
>>  #include <linux/interrupt.h>
>> @@ -257,6 +259,7 @@ struct ads112c14_measurement {
>>  struct ads112c14_data {
>>  	const struct ads112c14_chip_info *chip_info;
>>  	struct regmap *regmap;
>> +	struct iio_trigger *drdy_trig;
>>  	/* Synchronizes access to register value fields. */
>>  	struct mutex lock;
>>  	int drdy_irq;
>> @@ -280,11 +283,32 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
>>  	struct iio_dev *indio_dev = private;
>>  	struct ads112c14_data *data = iio_priv(indio_dev);
>>  
>> -	complete(&data->drdy_completion);
>> +	if (indio_dev->trig && iio_trigger_using_own(indio_dev))
>> +		iio_trigger_poll(data->drdy_trig);
> 
> Even for this path we should be checking it wasn't a spurious interrupt.
> If that's happening in a threaded interrupt we'll then call iio_trigger_poll_nested()
> and the handler will happen in the interrupt thread.   So the overhead
> of that check should just be the check.
> 
For now, I think we'll not bother with checking for spurious interrupts.
The only reason it should happen is electrical noise (or disconnecting
wires on a live system). And we can add it in a follow up patch if we
decide we need it. The overhead of an extra read for each sample might be
a bit much at the higher sample rates. So we'll want to implement the
higher sample rates first anyway.

We can read the status along with the data in a single transfer, so that
might be a more efficient way to do it too.

