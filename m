Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC50220F49
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018951; cv=none; b=s7xTMZv5CSNxZidm+2WuR+F0wufdzIZNnbT18lS24IlUR7ZFIsCsc74hRMdlJGaG2o3BxgUNWYdL3OtAQoaa2/oFJCMs8A0iCNLRa+RxeqLRCgvesMHrrvZkNTamWnouI8XJWaQgBHXGCUda3ZyGukEBmkUnCASaMBSq5/ZmCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018951; c=relaxed/simple;
	bh=vD8vZKY8J69i0DzAp2CAyu1D36+3leEwVe0IcwbmB/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtYuIzyztMpF26WH4VXztPmyBKqJk16b60nrOu1aD1OEIjkXa9qfqKEq5OQR1JJLvIlxvhWWkUB85MhrbLc5JNYKoiABrojkAXwMMKAIF/MWxHuMyEQSvEZCMhntfTdW0PID6SJz1zTVjgKQzPkVsXCT+A3BxspTjZO5tcnnwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=SGDohzX0; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="SGDohzX0"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so2324590fac.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776018947; x=1776623747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bX5T7sHPLQlkIbxvbr+ch6FIRfggUIUExunJpIW9pA0=;
        b=SGDohzX0EJGmeqzKupu+gcI2AP/R6TQWZQheuqgNoVpPY0hTUtcMFktbX1vOuWmlQq
         xLYmy91atgHoYdS4IDRkvhgdok568cdZQZKLBz28h6DS97GISI7YUCJUcddmpXeVoBce
         zUDtksW/hQBQ2vnkBVJBYxEnn2Rs9btM9/2Zeg99Sv/QR1z2mVVIREL5BL5jke04BDyg
         iWT7uAHqvPb0uF12baimhkKeNJZwfC2P0lDAIARBCkKju8DXFL8Hvyb+amDojDjpl1Ve
         yZR5wRNlYr9nmIMcftRBHkMAzAL2BaPmt7SiY7yYPUqTUizJADXEwPMGf284QUxJywvB
         rzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776018947; x=1776623747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX5T7sHPLQlkIbxvbr+ch6FIRfggUIUExunJpIW9pA0=;
        b=OHR17tkA09Uvun0HlaojFp01MqPTe0Ce9VaWRbRbqoVoT6n0Z2S29MUOPabYprex9x
         DPV8H40W57PK33UNj7lmfC2jXzpJMdzHNbZ8FfPsqXJ3kfg+sFpllKk5hJFVLivPdsSj
         9EmPK7owrgbY7A+pwTUtKM3NCX5RPjo5EdU4PIxEwsWXea5MhHrKMW5W26T94TzO10dj
         DVELLca3vopYnUHRN9ak1FBow/D5fcHAcSdBuux4knx/pAjaGkuxbzaLFei6N4GFvMS3
         KWklUmI9nbpUlJdeRqsGl7r/jOPmN3BWWYKZ1TP9NPWWjgDaLCA3/aJ19hHTI3tkmCWQ
         oWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz5Clh5h0BDIfPDYBEEWFleZ84a0HP8nOZQoC0SunypGW0ArP+wwdqOPXvuoenY3x92NKE6S3XEUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bGnvuKzhLFj+AwFD7hcAX961Ttpem4sw5gzqHJ1aSHgQW9I8
	mnvMVcmTe6DZMy4yReiumyViZtQswc61AbjWhTvSY/iK9zoYNVzRGvWyULlIOPD6vAw=
X-Gm-Gg: AeBDiet9lk0c6AkH+q17ncH+LS4Tsw1tjuX0Uu2xHWe4CNwd24OULBwvMmSDh4cdAHh
	Vh2jSs9m3o1n3Jv8iDvCTYrdldhGTPAG+T5yR1JR/XriizC0vXEHkWxr0AMv4vx14c0mqymicb1
	ykThro7Zh2cIf331jjNZJJoBTxNZfKTHOP6OtIEQviKsVrIXDwftdiFt532ocRaK36fSmYiMXkp
	Z7QfwkhGiyRI10yzbsL2NpwR5wNYDxfYMoEANIVaYtiw5FhNy40lJQj74tL1I1V74N6nWsibpcx
	k7HUoTPnyeqbInuaZm8wdbqvwxGsYxqTaS6L12ko0zlqKC8IyJV3XOkYkGNWzS3gLGnmgwJwErg
	8Ih2E/8WMp4sPU14iIbVU0EjUPJzBu3MQcd1cRa+iAUzmruvyFDMA1wCIAfEzEeqU46rypQFBxr
	V80j2FN2pneq7+DjUxMfwCiNmpx6X/O/x9etmLinRt5lHf/NMkVX9y1LPwvvBE6gwUqbZIsdc3i
	w==
X-Received: by 2002:a05:6871:c929:b0:417:49da:7ff8 with SMTP id 586e51a60fabf-423e1160952mr5924271fac.34.1776018947024;
        Sun, 12 Apr 2026 11:35:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5c13:5a8e:1b91:8035? ([2600:8803:e7e4:500:5c13:5a8e:1b91:8035])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd420bd2sm6693505fac.6.2026.04.12.11.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 11:35:46 -0700 (PDT)
Message-ID: <856787c1-76d8-4818-839f-64490a64a990@baylibre.com>
Date: Sun, 12 Apr 2026 13:35:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: dac: mcp4821: add configurable gain support
To: Nikhil Gautam <nikhilgtr@gmail.com>, jic23@kernel.org
Cc: anshulusr@gmail.com, linux-iio@vger.kernel.org
References: <acYb1XOmw1yoyu_4@nik>
 <20260327061802.13043-1-nikhilgtr@gmail.com>
 <45f6a6dc-e027-4616-8cea-9be8d006521a@baylibre.com>
 <d47f93f4-e536-4fd4-a7c0-74d69f50fe55@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d47f93f4-e536-4fd4-a7c0-74d69f50fe55@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/12/26 10:23 AM, Nikhil Gautam wrote:
> Hi David,
> 
> Thanks a lot for the detailed review and suggestions.
> 
> I understand the issues you pointed out. I will resend the next revision
> as a new thread instead of replying, to avoid breaking tooling.
> 
> I will also split the unrelated changes into separate patches, starting
> with moving the state initialization, and handle spelling fixes
> independently.
> 
> Regarding the gain handling, your suggestion to use an integer value
> instead of a boolean makes sense. I will update the implementation to
> store the gain directly and simplify the logic accordingly.
> 

To save time, you don't need to comment on things you agree with. It
makes it hard to find any important parts where you might be asking
for additional feedback.

And trim out irrelevant quoted bits when replying. It saves time too.

And please don't top post.

>>> +static const int mcp4821_gain_avail[] = {1, 2};
>> The attribute is the scale attribute, not gain, so these need to
>> be: { MCP4821_VREF_MV, 2 * MCP4821_VREF_MV } combined with...
>>
>>>   -    return 0;
>>> +static int mcp4821_read_avail(struct iio_dev *indio_dev,
>>> +                  struct iio_chan_spec const *chan,
>>> +                  const int **vals, int *type, int *length,
>>> +                  long info)
>>> +{
>>> +    switch (info) {
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +        *vals = mcp4821_gain_avail;
>>> +        *type = IIO_VAL_INT;
>> ... IIO_VAL_FRACTIONAL_LOG2.
>>
>> The idea is that the scale_available attribute should return the same
>> values as the scale attribute.

Instead, reply inline where the context makes sense like this:

> I am thinking to return (2048/4096) Values based on gain selected
> instead (1/2) Values in scale_available, so that user will have clear picture which gain
> to be selected, else for (1/2) Values he always has to refer the driver.
> 

We have to follow the IIO ABI of what these attribute mean so that all drivers
work the same. We can't make up new rules for this driver.

For a 12-bit chip, `cat iio\:device0/out_voltage_scale_available` for this
driver should return `0.5 1` since the scale is either 2048 / (1 << 12)
or 4096 / (1 << 12).

These are exactly the values that must be written to
`iio\:device0/out_voltage_scale_available` to change the scale. And then
`cat iio\:device0/out_voltage_scale_available` must read back exactly what
was written.


