Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908F396591
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779081698; cv=none; b=dSQlsPBFgA7pVLr8/9uxUdaACuiz0xe1hlqDyGhzSV5I+9uoK//y5eZpXZMOXWPtaDUJ7NU+OwfJiFZVDDg54QIJxCzhYm1vlBUSXvEvPhWYFGc3B1aba5e0MaBPj7og3c/ewXpzfdcHm9uxtko9KNKOmhx6nyBzM6jmIT/+BQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779081698; c=relaxed/simple;
	bh=vNdKnsYYZlKkKhRJ8ehWd4hcpi7UO7QeQ3RXo2YHBqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3YSVvoLFP9h23aq2G36b6mY+sL+3no9Fxqi0bH0mHR8eWYBbTNmLRmHbsviM0/NslD+Ei3cm/R8O8TJn7NZn1NBcKnSA/3tIP6G5crkJh9Ea35HUzEDaYFisHr/4qalNuOPK74J2a9oestkRteDUcqP/+qF5lfMEDZnH3SeiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4+i1Ho2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4+i1Ho2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso2386968e87.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 22:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779081680; x=1779686480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COvqQNzUKLRtL3QdO0fWmfEMf02deV0mUukamXhTeL4=;
        b=O4+i1Ho2ZPlGtLDsYR83zal+utYP1A/8ULtF3LhaUZm1ZSrLId4v1xiuH0tL7TundM
         mCCcKMvLWP/N0uHWhBl+HOyGZw8jgLLij5y/QDPGYJl1cylLXXYyeESBqSLrAKZ/fAfl
         SCqUHmJOtYexiOkSxPsXdXruFC6excpJcNubHoC1I4TNN64FWyki5qjiHq/y6/+uTSRI
         8NL9+e1c4XsfXaMnaXUp3Y9bwMFLbc1+6vSavocVV3oaHUS9U5eRySQDpO9FYfHHkXtI
         6DOL4nr7UsrVi0wZ/DFZR1FB159hTz5Bf5aoDwtuZxj2vunEMiXHglBu4akFXY+ncbEe
         9HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779081680; x=1779686480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COvqQNzUKLRtL3QdO0fWmfEMf02deV0mUukamXhTeL4=;
        b=ADhkzJHbxypoiVVwSqjPABDnMd8gG8K40i1X0IUUVZVRvNodTRt37VEBiABv9HNn4t
         o6U/J3lbeAC2X1IOdZzrIVz0p3JMzxP1i749oL0OCrefYaXWfFMNb9P3USNGn0LJcHbM
         rL7Ht+jXVhZyt67MY1lv3rqxAhp5Q1GfucsXDDgNozv5qZXMyN/ifmZ7X0tzjCkYOh9/
         yxrMpror1GbYFjKsHWqSBovfAxHPuz6FM+UQ2FkFKmkkh5dOPSKxvxdcq4UOcOSk3G7m
         PMukYAw2UJLIPHTd+ANTOiaEPQllZultGhz2LDogIshlTdwQAV42E60BNPGTXZPMVyOd
         7FnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Zf3qeLJBmbcUgxM+sZE3z2EJcK/RDa2wl9vk1FsmLQTKjUhzN91e+uiaHQXZKatbwQze3MhGncJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIRvK2IH1AV55rfyUshWxME8ZMGhNmgluyDYB+Fly0m56mqFD
	hs/ek4wMj31H12N/Mg69rIi7rSopvwk2HlUWZBR2vjnSpQ9uja/bhi5n
X-Gm-Gg: Acq92OHXmpqRgG9NJinYS3aTt+NYOGQp0YS5Kt31PUfX6uBpQCUNls9vBOkbhYb6E5U
	L3RlsbMbnc38O/trzgaae0/JVx/2l/HNrJXZjlWS2ugWjRD2faMDKn7Hkuvqr5tMDmpc0jljemH
	UC+4dJZgUX2il4M9El0wVXWDYPJ8y7Th1LfPRUWDZsshqqb/3bPmXVqYDsO0Q+WSUUer5hpHzzo
	1i6yJvIQSc0V6s+ErJQeJvEW7mIbWedJVT49b02Ni/WOwe2QkReXBLMRPBGXxDMLBTep0W1T07F
	CBXY2xkPCG2iEEfVybfxJ+EyNdRUxxMr73eBbLONd0A4/P/9+gRhp9l23Wn7y/rSbuAr0+FtMve
	iuz1GDNZrg6UYBwTFxXZgcxlFBg58PaVscx52yB5XQ4VKAPhACrtPUtG112h31HIkvSba/cO5TW
	qeDM7SVJbwNvs+9vlsvByAlw+P5Qsm9Lj3YSxhgc+fbRT51NPXEz3GdVOTwK2PM1aGOJySQ1FzK
	YUH7axcEQxxN3PaHkk=
X-Received: by 2002:a05:6512:1193:b0:5a8:fc93:85c1 with SMTP id 2adb3069b0e04-5aa0e73c325mr3744302e87.32.1779081679717;
        Sun, 17 May 2026 22:21:19 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882cf497sm10171221fa.16.2026.05.17.22.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 22:21:18 -0700 (PDT)
Message-ID: <3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
Date: Mon, 18 May 2026 08:21:17 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
To: David Lechner <dlechner@baylibre.com>,
 Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/05/2026 20:12, David Lechner wrote:
> On 5/17/26 11:08 AM, Stepan Ionichev wrote:
>> bm1390_trigger_handler() has three error returns:
>>
>> 	if (ret || !status)
>> 		return IRQ_NONE;          /* status read failed */
>> 	...
>> 	if (ret) {
>> 		dev_warn(...);
>> 		return IRQ_NONE;          /* pressure read failed */
>> 	}
>> 	...
>> 	if (ret) {
>> 		dev_warn(...);
>> 		return IRQ_HANDLED;       /* temp read failed */
>> 	}
>>
>> None of them call iio_trigger_notify_done(). The success path at the
>> end does, so on a single transient regmap or pressure-read error the
>> trigger never sees its use_count decremented, and the
>> !atomic_read(&trig->use_count) guard in iio_trigger_poll_chained()
>> drops every subsequent dispatch for that trigger. The buffered-data
>> flow stays wedged until the trigger is detached.

I don't really know the intended logic of the use_count, so I'll leave 
this to those who understand it better. I'll just add some thoughts this 
invoked.

I think it is not really nice to require (or trust) drivers to call the 
"iio_trigger_notify_done()" if the handler fails. Maybe it would be 
better to do something like:

void iio_trigger_poll_nested(struct iio_trigger *trig)
{
         int i;

         if (!atomic_read(&trig->use_count)) {
                 atomic_set(&trig->use_count, 
CONFIG_IIO_CONSUMERS_PER_TRIGGER);

                 for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
                         if (trig->subirqs[i].enabled)
                                 handle_nested_irq(trig->subirq_base + i);
                         else
                                 iio_trigger_notify_done(trig);
                 }
		atomic_set(&trig->use_count, 0); /* Clear the use_count if drivers 
didn't */
         }
}

to prevent this class of problems once and for all. But yeah, wiser 
minds have designed this - so let's hear some other opinions as well :)

>>
>> The IRQ_HANDLED return on the temperature path additionally leaves
>> the temp branch's last partial state in &data->buf.temp without
>> pushing the sample, which is the existing intended behaviour; only
>> the missing notify_done() needs fixing.
>>
>> Funnel all returns through a single 'done' label that calls
>> iio_trigger_notify_done() before returning the saved irqreturn_t.
>>
>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
>> ---
>>   drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
>> index 08146ca0f..c18352399 100644
>> --- a/drivers/iio/pressure/rohm-bm1390.c
>> +++ b/drivers/iio/pressure/rohm-bm1390.c
>> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>>   	struct iio_poll_func *pf = p;
>>   	struct iio_dev *idev = pf->indio_dev;
>>   	struct bm1390_data *data = iio_priv(idev);
>> +	irqreturn_t result = IRQ_HANDLED;
>>   	int ret, status;
>>   
>>   	/* DRDY is acked by reading status reg */
>>   	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
>> -	if (ret || !status)
>> -		return IRQ_NONE;
>> +	if (ret || !status) {
>> +		result = IRQ_NONE;
> 
> IRQ_NONE means that the interrupt wasn't handled, so it won't be cleared
> and the handler will likely just run again immediately. So it probably
> isn't the right thing to be returning in the first place.

This is exactly why IRQ-none is returned, and what it is used for. If 
the problem with bus-access / device persists, the kernel will (after 
XXXX fails indicated by IRQ_NONE - don't remember exact numbers) disable 
the IRQ from the host side, and emit the, ass-saving, "nobody cared" -print.

This is (in my opinion) the only RightThing(tm). (Especially so, if the 
device is accessed from the fast handler, and is system is single-core). 
There is a tremendous difference when debugging a system which just 
hangs in IRQ loop forever (and you can't get no contact to it), and when 
debugging a system which, after a relatively short hang-up, let's you 
see the magic "nobody cared" -print telling a misbehaving IRQ was disabled.

Furthermore, if the status register read failure was a temporary one, 
then we should be getting new IRQ as soon as the handler exists. This 
should then successfully handle the IRQ.

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
