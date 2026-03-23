Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9893AE6F7
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276790; cv=none; b=S92MMZWxYzDFuH3aeJ1vb2sNNg70zw7tVy0twf+pdnJEHOphm2eo1m842J4Wn/FuWYX3R1488YOQ6a1CgASzxP1sSSjR3k3G+GXO3o9DvSr0RHwcsRm7eHvlrQAb1L6htlhBLtwYII8D3frKD1wO1Mmr3ucDelorTzKtjrpggkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276790; c=relaxed/simple;
	bh=/Vc04mp+YvGzxnIgYBmQ5LjwPSfRG5KdQa8ysQAw3eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hx/P3xTPVYAV/UApYywWoEOjSfe3jpEeM+lycl/S0qsk3BjGX0UQ1LmJL4zYpol01tD7GCOsELLEwxDGLxsVTyMb0w6Cqfs27szLht4BQGUeol1bMq8WSDG5pCdc8pPztGofRBcDtoc7svO82Ziuem9Eb/xEdkHKbRAZ02X4T5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=muhWkSEE; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="muhWkSEE"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d7f92bde91so1527505a34.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774276786; x=1774881586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JeALHOS5PAPURwj6AYWeAG7dI7olikWsM+DOIkL5mk=;
        b=muhWkSEEOIr0r1HABPGLoDEiNYbOGYBkiqu3R9H0q/8y9dIbXK5R0ru+2mkMPr5oGS
         Ctl11GOTGM+0aq7Wk4IrDrqQOO0Q5b8CaKWT99ziIzWJeBw6MNkQNtEeXc465JkYlNdK
         WVatuNlhS6lGwLigm4APXJRe1Q9FxLiBWVZl/Ac29CykT7MOBBcNxUCaZzTt9XgF6HW2
         c2Ys7ntNSFyFl1BqiTNIx251F+5P7h81ajm19LVQkxKGiWXP7b8xkM7Wx8Y5EClOym8V
         kvu+wEkOKbXH5d0YnL+tteJzRwtoZotR2TSu+bgVrFVUCMnmLjf9s5PlM1fysG8/RruH
         /18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276786; x=1774881586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JeALHOS5PAPURwj6AYWeAG7dI7olikWsM+DOIkL5mk=;
        b=d9o9oW1Ntnwp5c59NOUjFDpugXKrBgOk07Kj9FBy+/LjGYPj0/HuFiVLZ6LdDetJdd
         hPKg1KJ9hs3t03txM6+31ABJZJLEZ5BDqWMCaX0GCt/m+dryaK4tG4ZXhIkxz9+mE/33
         pMKodyJjRTLpdQwBepfPZpbXy/lG4xuu/4R8oaoEeABVTMc9vyHiBp5kblnJQgsRfbN4
         E/IiDtuzwMFuI6bvTvkr23selwR6LNc0h7Cf4cR3noGSBIe+qhslSL6NUhOsgN/Ok55j
         FHicY5+1wBmE7eROQVeA/JlC8ozkga/fGERSofxtjXmFYaFw8maHEf/AM8O5A0tuz+u5
         CX0g==
X-Forwarded-Encrypted: i=1; AJvYcCUuwzlGjPJ7oKb6DT7hvhxVvdMNW6Dsind38seiF+fQx/8BfvHWPX1lkGi3gUOAj4uy7ktoVFuNQUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0378tMcNkOfSWpOlKcA63jGzobQV3VymHdNUdtNNlAVeVh0WF
	8juPD1cENgiWO/+m8SOI9Ts5KnFhdd/jAcbsRcWyMPjK0UcFxw4Kee90MMgxmAapVMQ=
X-Gm-Gg: ATEYQzzpxsCrHEN2bIidZWhwVR9EFk+cWyktJ4gKMYfh9373N5uBoiA/NsumMX7FeAD
	7LI7ZcKxabktHiaoIZXZa8UicuL5dUfCaQaY+92dG2sQ6s6KGt+NBLooV62n6uNOzW9xsOxi2dn
	Hu7aDoWki1gyr0O27HlG7ybmKGL2S8CS37toBMA21a1w+gsLuIQyGhe9RBqmuoDGFt0RMpKXe9H
	l1dlYnzrK9wanj34n3FK1jeN7ZdKw3aj4nDt3mJAj3/gvm6yQL/uEMsUIopP8Jtchs/Y8xaoHZr
	e/JyCJwq3+Oo5FatBUG5+S4h8Ca1E+qiiDlZ5jYQnaRVM2kscmP2BEKm597Xycax/hfRuODKI6o
	eYdRcp2JU1q81N2gFCRyLaCwz8muLUxUmNZbtF5l2zfjRZyP8+yCSHk+ZZbaY9jJyE3ji7PV2DG
	GL4x7+84IExl5U1crlQVlD12llsvzFdtuQsRSpZxVSIRzdbuvI+44iSWLZjKjwCAi24ahHR8E=
X-Received: by 2002:a05:6820:8ca:b0:67b:aca0:3d96 with SMTP id 006d021491bc7-67c22fc295bmr8670885eaf.65.1774276785962;
        Mon, 23 Mar 2026 07:39:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:964:f712:dbc7:4119? ([2600:8803:e7e4:500:964:f712:dbc7:4119])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252c892dsm6680581eaf.4.2026.03.23.07.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:39:45 -0700 (PDT)
Message-ID: <eaaee132-d5ff-42ff-9f68-5d6736127caf@baylibre.com>
Date: Mon, 23 Mar 2026 09:39:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages during
 probe
To: Archit Anant <architanant5@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260318092715.42538-1-architanant5@gmail.com>
 <20260318092715.42538-4-architanant5@gmail.com>
 <20260321182710.1621d1aa@jic23-huawei>
 <CADJHxWADo9rA8vt6EEVLXSBb9EqXvyBg=L_YmusaMdtRnOr0rQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CADJHxWADo9rA8vt6EEVLXSBb9EqXvyBg=L_YmusaMdtRnOr0rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/23/26 7:22 AM, Archit Anant wrote:
> On Sat, Mar 21, 2026 at 11:57 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Wed, 18 Mar 2026 14:57:14 +0530
>> Archit Anant <architanant5@gmail.com> wrote:
>>
>>> Reading the regulator voltage via regulator_get_voltage() can be a slow
>>> operation.
>>
>> Whilst that might be true, it isn't a reason for this change.
>> Sysfs reads that would cause it to be read are never a particularly
>> fast path anyway. So drop this first sentence.
>>
>>> Since the reference voltages for this ADC are not expected to
>>> change at runtime, it is inefficient to query the regulator API every
>>> time userspace reads the IIO_CHAN_INFO_SCALE attribute.
>>>
>>> Determine the active reference voltage (either VREF or VCC) during
>>> probe() and cache it in the state structure. This improves the
>>> performance of ad799x_read_raw() and removes the dependency on the
>>> regulator pointers during fast-path reads.
>>>
>>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>>> Suggested-by: David Lechner <dlechner@baylibre.com>
>>> Signed-off-by: Archit Anant <architanant5@gmail.com>
>>
>> A suggested alternative approach inline.
>>
>> Thanks,
>>
>> Jonathan
>>
>>> ---
>>>  drivers/iio/adc/ad799x.c | 24 ++++++++++++++++--------
>>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
>>> index 7504bcf627da..ae2ad4bd37cc 100644
>>> --- a/drivers/iio/adc/ad799x.c
>>> +++ b/drivers/iio/adc/ad799x.c
>>> @@ -30,6 +30,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/bitops.h>
>>> +#include <linux/units.h>
>>>
>>>  #include <linux/iio/iio.h>
>>>  #include <linux/iio/sysfs.h>
>>> @@ -135,6 +136,9 @@ struct ad799x_state {
>>>       u16                             config;
>>>
>>>       unsigned int                    transfer_size;
>>> +
>>> +     int                             vref_uV;
>>> +
>>>       IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
>>>  };
>>>
>>> @@ -302,14 +306,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>>>                       GENMASK(chan->scan_type.realbits - 1, 0);
>>>               return IIO_VAL_INT;
>>>       case IIO_CHAN_INFO_SCALE:
>>> -             if (st->vref)
>>> -                     ret = regulator_get_voltage(st->vref);
>>> -             else
>>> -                     ret = regulator_get_voltage(st->reg);
>>> -
>>> -             if (ret < 0)
>>> -                     return ret;
>>> -             *val = ret / 1000;
>>> +             *val = st->vref_uV / MILLI;
>>>               *val2 = chan->scan_type.realbits;
>>>               return IIO_VAL_FRACTIONAL_LOG2;
>>>       }
>>> @@ -828,9 +825,20 @@ static int ad799x_probe(struct i2c_client *client)
>>>                       ret = regulator_enable(st->vref);
>>>                       if (ret)
>>>                               goto error_disable_reg;
>>> +                     ret = regulator_get_voltage(st->vref);
>>
>> For vref I don't think we need to keep the regulator around, so you should
>> be able to use devm_regulator_get_enable_read_voltage() with checking
>> for -ENODEV to identify it simply isn't there.
>>
>> It would need a tiny bit of reordering though or a custom
>> devm_add_action_or_reset() registered callback to ensure that regulator
>> disable for vcc happens in reverse sequence of what happens on setup.
>>
>> Anyone think there are actually ordering constraints on these regulators?
>> Would be fairly unusual for this sort of device, but not impossible.
>> If not, cleanest option might be;
> ...
>> Then no need to undo anything by hand in remove() and no need to keep
>> a pointer to any regulators around for later.
> 
> I completely agree that devm_regulator_get_enable_read_voltage() is
> the cleanest approach.
> 
> However, as I noted briefly in the v5 changelog (which I should have
> highlighted better), the driver currently relies on those regulator
> pointers (st->reg and st->vref) in the ad799x_suspend() and
> ad799x_resume() callbacks.
> 
> If we drop the pointers from the state structure, we lose the ability
> to disable the regulators during system sleep.
> 
> If keeping power management active during suspend is still desired for
> this driver, I believe we are forced to keep the pointers and use the
> devm_add_action_or_reset() pattern.

Yes, this is the best we can do with current regulator APIs.

> 
> If you prefer, I can drop the manual regulator control from the PM
> callbacks entirely (or drop the PM callbacks altogether), which would
> allow us to use the cleaner devm_regulator_get_enable_read_voltage()
> helper.

We can't do this unless we can be 100% sure we don't break existing
users who might be depending on power management working as-is.

> 
> Let me know which path you prefer for v6!
> 

