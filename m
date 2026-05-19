Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970538A733
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171883; cv=none; b=kqerWEHAxDcxmZWbFnhAgkQ87Mg9ACUukoSs3idjS+V+jrLx2Xs1kK2L+JhHwj4/xKRY8DZH6jV6TqBmazm7xTD8kcNdQE8VaTl6/V9e8c5GdrQcmNNwtfyWpoyLPwPEoBzWJlj66iTHuuFNTLRlGVDjKiE6l1M3lBiyy8vOCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171883; c=relaxed/simple;
	bh=ETi7lwNArEN5RcmsW98Yn9KiVogT7wbUsiY5AWvxxY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXFYLfpPL8TeWVj9s7oF5LpPpc1aCB05RLqdSqnBXSlJen8L3lSgGtQq1VlbYdqze734GIord6Hm3gNYUqjlxqbhFjagsCXUMskj7AWOMFUHZZ1jHbJFDzpAkA7jgWNWoljl9TKOEayJf77TlGDCzRozHfgQNa/OBGUnBxF/lm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd6D9Xxo; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd6D9Xxo"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-392445f11c5so35810801fa.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 23:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171879; x=1779776679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfehn+9PkhGKFVZuq9YJWpl/FHglNOxtCRjIV6IYwkY=;
        b=fd6D9XxoencoRpTa13HKfDogDPwSX/ivrNv/ZDdFDQeVGRcvoVUoNfUjw322R4zzSC
         m9hGE45xxaF/CGRhJGS+IxKbESma80/5MbM4NW7Nm4Krbc9vBrrMryvYj5LFQ/fIEOI8
         8kE+LhmQtw5wBQu1qAA/LJijNKlTJc+7KnslQigKPAhkCfk+YKfPz80aieKrljHiaFoO
         Cwovu5bD8AUj4qDV+l/E2JomKnl43Fj5WFg/ULZ1PP236Q8vCDlvESQGRmttQptATszr
         KVTlKNUNMceZd1eHzcFKYi6U3Vy7p5tUUspnC9b8Rd0rDtHmsOcTxe2wILgUXEncszKg
         3QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171879; x=1779776679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfehn+9PkhGKFVZuq9YJWpl/FHglNOxtCRjIV6IYwkY=;
        b=MjiWs9dMH5Gcaxy9z98rssPmXj6vPeTgPLRfJD5Yzij+AJn2czdkrsInwKZQGr8nx+
         LbLnKuilqz7Fy9xvkyPgA3viP7m4XCaBYXRtzhrogISRIQENtYfSQl6AiDGP1muGazC0
         7TNxPh71s28X/ZOyDG1R4i5tIZFQ/IqVC4rrKGKH4SIG/2nCBP2yyFULQrcuGPgrGvQW
         flXL7eZxZpVPhYgsjfcsxzZtJg7TXJTtytyOzPz1czPGcIApxavBIc/ci4uU1Y8gkd8n
         SD/GNYphGoJ9QcXbkSXVWU34uUZFFu/0e4BDM7mkVPkg4uhSw7kiOYjwRkrwl6RXbJoN
         tJgA==
X-Forwarded-Encrypted: i=1; AFNElJ+4hbFRWSSCHxQQN9BBZSXMuht3XAQ1Pn6recEPYnHRFWq6Zr53/SVcV2TM/sFhfrcSy+8IZB7/VTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUyT2XWLI8qEHGG0UkWhsSX5qTm0uQgRZRMfdaexQVDTCwN1G
	zMuou4zOiPAadfJtwiQeculm4/yA1sjwXxSgNkMGa7syAid16nJFrDFa
X-Gm-Gg: Acq92OEhbxz3pyNL3m6IMd6DFB+qm6KIRoa9Lkvab/ctjwEt87HmuEtkD6WUT7BXepE
	m9IENzF4ohSIU4JlktZKnee6j27RmY3WafikwH6pWrLjlpiCAjPM8pIDBtpTcsfb+RCs9r+lDKS
	beTRnCL61LR1zzQQpAgseYCZz2SU0FImaWkLVr1We9zD/CRYegV2J/uiKQRfS1xo9zICThFaCPv
	8GcluRRB+F5lsWPJ41wYQa7S+gRdmXPrjMwP8XhalRfzN87J0n8IirpSshfs2ycS34V9yCkUwvu
	jkEo/dHB8JgxP76UeXShxwHwaO/oEGLwjutoaHh5SzPi2aB6X/X7PURMPcJx9F3CJeNVW3txATU
	yQGnVVIjJeuDO34uvlieBv8Prhc67JEWN73bMn6PNWqNsviZOsHpTkvPNo7iKGzOUgR/TokLX5p
	IPeS1qt5PBlKROArGVZlR7WKN0AttSUEQ2MLlgrlVUO/rI7GXYLzN6wJD2JjYCte81XPz/8yqWG
	Z0mTtz6GzRuVAltYuM=
X-Received: by 2002:a2e:8e70:0:b0:38e:9b7e:edd7 with SMTP id 38308e7fff4ca-3945b6098f7mr35935391fa.17.1779171879360;
        Mon, 18 May 2026 23:24:39 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887df055sm17666761fa.39.2026.05.18.23.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 23:24:38 -0700 (PDT)
Message-ID: <16cf96a8-f559-4f2d-a50c-1c6a14ddf63c@gmail.com>
Date: Tue, 19 May 2026 09:24:37 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: light: veml6030: fix channel type when
 pushing events
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
 <9bb6db05-43c7-4bdf-88b0-b92525ad5cc9@gmail.com>
 <2a0c777d-05ef-4721-b8ed-88297630ea94@baylibre.com>
 <20260518162255.107faee8@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260518162255.107faee8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/05/2026 18:22, Jonathan Cameron wrote:
> On Mon, 18 May 2026 09:48:39 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 5/18/26 8:12 AM, Matti Vaittinen wrote:
>>> On 13/05/2026 07:49, Javier Carrasco wrote:
>>>> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
>>>> Use the correct channel type.
>>>> This bug was introduced in the first version of the driver.
>>>>
>>>> When at it, fix minor checkpatch code style warning (alignment).
>>>>
>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>>> ---
>>>>    drivers/iio/light/veml6030.c | 8 +++++---
>>>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
>>>> index 745cf3ad7092..855f052b60c2 100644
>>>> --- a/drivers/iio/light/veml6030.c
>>>> +++ b/drivers/iio/light/veml6030.c
>>>> @@ -871,9 +871,11 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
>>>>        else
>>>>            evtdir = IIO_EV_DIR_FALLING;
>>>>    -    iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
>>>> -                    0, IIO_EV_TYPE_THRESH, evtdir),
>>>> -                    iio_get_time_ns(indio_dev));
>>>> +    iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>>>> +                               0,
>>>> +                               IIO_EV_TYPE_THRESH,
>>>> +                               evtdir),
>>>> +            iio_get_time_ns(indio_dev));
>>>>          return IRQ_HANDLED;
>>>>    }
>>>>   
>>>
>>> Is this change reflected to the user-space? If so, is it safe? We shouldn't break the ABI, right?
>>
>> On things like this, we will sometime risk breaking userspace in hopes
>> that no one was actually depending on it. If no one notices that we
>> broke it, did we really break it?
> 
> If it's a bug we often just break ABI compatibility anyway.  If we get a report
> we'll make it spit out both events (and someone doesn't handle an extra one
> we point them at the docs - that hopefully exist ;) - that say you must handle
> ones you don't expect).

Well, you guys are the ones being grilled if the brown thing hits the 
fan. ;) So, if you're willing to take the risk, then I am not complaining :)

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
