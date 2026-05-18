Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEE264A97
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115725; cv=none; b=oSfGpXfxVN49c66hLPvKQ0BVsjGOuNy9eQR4Yf5RrdTvcavcig0B+7Jdo9RFrsNMOlHF/AMSMvz43Ue15VzFXmUnWzF2dFh+0Ch4AQD1HLXBv1kzBwmvFPN9XA4OFgQEvznJ8h9Ahz51C7bl0QAMfCWEULkImk3yJRKdsf9FXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115725; c=relaxed/simple;
	bh=694/ZdiavJ7DydhU+SVNbEbk/6jkXDD+6gREkL+zvQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGeSSptSpvRGNqerFIeb9WTl74u+ovJaFVMQL9orxjb+yAiteYas/5A723TyEYax6CztIbk4c+6OVH8j6BczuxI5a9DcoMffjE+d363lbLZG6MQMZA9HMTY0QpSv7jwi2iCcR1I4xmTn/p3kuiRAc2rRyC/Q4QE2t97RnacgzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CU1MVzeQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CU1MVzeQ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dca4debedaso2560684a34.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779115721; x=1779720521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwdgIOicbMMbCteOkWbKsZaB7QekYyPKrlRSTDWJHvY=;
        b=CU1MVzeQBnBqlIN79WLO1HAuRSfweQ92N84yXW4yHo2dQbPZf1D7GnOgBwkEHYdHis
         GVgB+A40oL2sA4qgCZZnqVrfQtzcW6ZaL3UA+PX9AFzV9tNK1GDHbthGi/Xjm7xGuxVq
         W1YnQi+8o60qPLl0SHoGeW8R0heIINNaHUZjnq7vvjM7E4JfRlyYZnvqMaKPy+DoT7Gt
         +td9xZNp81LYNYBopsxE9GhIraVTvKKUqiLb0GVCeXPPDGqAnQw6kqtjFqVUbAVezXiN
         zhwnMn6NrGvbDmh9FIZLKe3duFytCCO8oQELZK/UtdiAmGIc2cZrA8W2vh7EvKHqlzyC
         DD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115721; x=1779720521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwdgIOicbMMbCteOkWbKsZaB7QekYyPKrlRSTDWJHvY=;
        b=Gmt2DVNnxWvr7MiJqJj1koexPzhvMZYkAdiWShln85dfiV8NgKk8lbDeGO6LZhzBba
         hzONNaiZaaaAvqwkyqmGhR2K+AbByMqLtHnoysJ46VSDoIJhJYfzjmjVdiOAwRUWij+u
         4RRUU/WdkPLp/2kVZnKfXC88k/eQGAIMTduJL0B96U3It8RoIG+H6GkF9wVaf7H36SPf
         RxLPosT2GvqQN/A7nj4GTE3/w4uTB4UhfKHkGjnaocnZ1Io8LnjLH/xTAVW8LOyGwEyW
         xwxcp7b5MfXTqNaBOnMvs+0ivApI/80jLFsSe84kWe2MBdehKk2O0f7Sak1RnvHrXk7U
         EOpQ==
X-Gm-Message-State: AOJu0YyhfqtNKtZTilfjenl5p9zwil4h+vkHys+NqqmTDzTn1s6kY8Ol
	IU5GJA2ke7h0ODsuDQaKcL6e45IMcmchISrFVel6RzxWEi1nrcCh8uX3Z4ihvybsvg8=
X-Gm-Gg: Acq92OE1VNBgiqLAW7kOEwbjOUTzU5hvHqQK2vGu4jlfL6Rcma99flcHowblAiXayCF
	O0Cxeur8/F5jeqtybd/SaKMiI920kow31LrB5kk8qMA81MbcWvLAcsIGeqAluh5HL7OzALafDsK
	y+/mBdwjrPp77T9Nm6pZjYZlcndcovokiGTD/559BDQGPLCQS08YFyBUaTD5gxy3o3U/CbKl1rc
	SBsPClo1vClU+7XU/HTaqqDged/5GFYQzGfHDIA/yvJVTML7aoDqFJVnFz7IAm6rwbzyvisS/d+
	I13ErHHSsVrJrWq/bu+3G74IPlB1rCAo5b98WHhnfjsw6x6xDLwB/z2wWskhpqphndsZUWLiwZb
	HaOZMv1i+GCSu9uXAjh7qYLHL/woWNfqDcsgvt/bRJuEge3jIiK1ZNVWs+U+vgoN+7vQHlBcgU1
	4jNZtrci6N5bjGQBPK82LXzaSBKbmguG4OlDGX9tQYu3bXaQBTFUWxcaALWtOpHLHpAD6/H4JPX
	A==
X-Received: by 2002:a05:6830:668e:b0:7d7:f146:8738 with SMTP id 46e09a7af769-7e4f2b80067mr11001106a34.12.1779115721373;
        Mon, 18 May 2026 07:48:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3be6:1187:fed4:378b? ([2600:8803:e7e4:500:3be6:1187:fed4:378b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b819156sm7945993a34.7.2026.05.18.07.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:48:40 -0700 (PDT)
Message-ID: <2a0c777d-05ef-4721-b8ed-88297630ea94@baylibre.com>
Date: Mon, 18 May 2026 09:48:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: light: veml6030: fix channel type when
 pushing events
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
 <9bb6db05-43c7-4bdf-88b0-b92525ad5cc9@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <9bb6db05-43c7-4bdf-88b0-b92525ad5cc9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/18/26 8:12 AM, Matti Vaittinen wrote:
> On 13/05/2026 07:49, Javier Carrasco wrote:
>> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
>> Use the correct channel type.
>> This bug was introduced in the first version of the driver.
>>
>> When at it, fix minor checkpatch code style warning (alignment).
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>   drivers/iio/light/veml6030.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
>> index 745cf3ad7092..855f052b60c2 100644
>> --- a/drivers/iio/light/veml6030.c
>> +++ b/drivers/iio/light/veml6030.c
>> @@ -871,9 +871,11 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
>>       else
>>           evtdir = IIO_EV_DIR_FALLING;
>>   -    iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
>> -                    0, IIO_EV_TYPE_THRESH, evtdir),
>> -                    iio_get_time_ns(indio_dev));
>> +    iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>> +                               0,
>> +                               IIO_EV_TYPE_THRESH,
>> +                               evtdir),
>> +            iio_get_time_ns(indio_dev));
>>         return IRQ_HANDLED;
>>   }
>>
> 
> Is this change reflected to the user-space? If so, is it safe? We shouldn't break the ABI, right?

On things like this, we will sometime risk breaking userspace in hopes
that no one was actually depending on it. If no one notices that we
broke it, did we really break it?

> 
> 
> Yours,
>     -- Matti
> 
> ---
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~

