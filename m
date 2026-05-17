Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326430E851
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779049707; cv=none; b=mWt9LpszluyLvuxY5f9a6dfWIbwLoO4L+cAwmOtPcNtN3dJO3oh5tSN1qPhzAX2Zc9FGnphQonjkefiOSUDX5MODxJwaFH0wYFNr7+C52NDuwxafFQXkBmxi0cbJ1+k2/vr1DE/MD9on3XadVVQ7b2p9LkpxGGa1Rb/D5aF7Mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779049707; c=relaxed/simple;
	bh=TfH3mebqGdarguuuYyHFAQAgVU0MPwFuKF0xD/rxr8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGJ8Ih8ZpEAzVZkw/qlHrhnaI3FvUZTkMr/SM0pggtfgEHFmUaUKngyoEfOMeF254wisIlFlT8qv0z0hR4CyckRAu163O6KlUAWNyQG39a0mUUvNxpVnsWRYR875iditDfbjC/4bkxlQsM5vzdOv+vANzFzBxlPHwuEAxACDqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=0jPnodMk; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="0jPnodMk"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-48270f099d5so1392482b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779049704; x=1779654504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Z68gGNxfq6iDTV2nCWXatC0CvTWumwI6Opr30zc3J4=;
        b=0jPnodMkGBuJS9tK3WYbqjIgcQVIsIcxW0LQ/XmuuyaHDMdD0GZNs9X19AVEzw9OoF
         bL7Ot8DzMOZHUYT6cXQ6LkPx/A2rk0ScEO0eLhpfLRfLhKp4oE0WFLHkUsJ8n/L4Nbo9
         2oDH+xl1OeSNqxxCGFcabYdq/RbEDQ6/iY3ehIiaF82HULiX8likyKpcgwupnU+c0B3W
         jJ537D1pudJcLjNLmrn0pCIAbe43zMEHKeVnBNxkvQQLYArBcHAMqjyqiYRRzWuuJcJw
         SUCdAzzsPf8lX8D1XubGxilcdHHI4stHcSFk1DWJNPhoLy2KeFNemK7P1LPBqx4NCn9t
         7UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779049704; x=1779654504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z68gGNxfq6iDTV2nCWXatC0CvTWumwI6Opr30zc3J4=;
        b=oTya5ZV34G+bUuU+XuqtKD49S9FTaPKDbkp+lb9sGE6xXNM4/Gi+d1873I+ROSTFvk
         uxteWoiVv3Eis8XW2uC6l3NJ1/cPxLf7vXt6GC2Uj2/HDoHU0p95p3GE2mViVW+pYq43
         NitBWAaEKBEk5UamFuAMDGgyMOPwDSUf6mHxO/J4tuNgfs76vXLEjpUTOyaNNpp16p02
         FvJ1NHKOGLLcqeyl/x2X5h3bWeiTXUphHKs9tfLhXYG25BWfZAxa5OeobnoEGs8FdMIa
         ZUldcj5e8IoaYKeYDuPHNiynF6QZCvmiLFg+NtGBmFUiqLRD6jQKGDz0CPnS1len3vWz
         ZiVA==
X-Forwarded-Encrypted: i=1; AFNElJ/lrGCXNvS7L4X7ngQhIS2/6mYtnfgPgooOcaUlUfKnseyrR4WZ3IuOeYbaXes6NKpFQZZZFU3vEZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwISOiX4XeNIN0Cz1I3VYAwW4kBmn42fDzaVFUX0LaEgRhZkPW
	DkUc4uPd0Kcu3FgkcnxdrJO2yx5sjs5t6oNKE8QhlgDpeXTotjkIQKvqOZTt93bCMGY=
X-Gm-Gg: Acq92OHOh6RONlbEmI42NwsTyQrWSE+sKWPc02UbgbSAFbMLnia9cgxETSQc42H0sQi
	cF+S2WtAEjM9qFtqedK61dSXw//w0nCeLKDE8wQ7rESMA2UfSEyzD8U74WPi91ab9UB3YPtMRY9
	Pi0OWQnOupfV4+ioK3kH1G6tTpOXdY4MNBFG/tZwOnLqBNtpDS3xM+OdHLFqcc5xci6ibFT2R9O
	SzZlHpajFxvxGw3UPPSetKcN0llgvJKD0Kid61DrWD6KqR00yLrOe9DyZG+WY1hmtzl7MNMDqH3
	35KFwBiZBMfquXWEV6T8FduKKEhP7GCr6CcBlQmgPYS0zMOeCdBUYrz5zmRfKEMMSzQQauK+Bh/
	U1xylMPYUxyuh722xtE1zkqoJzWe18PO6sWS9ch+CkhYEVc1kr0tHU/MUv0teXezWZFCMCI4zdX
	BPYTB8qpJeJDBW4k1VWy8A54RJ/JDNTx55Ue7/p4NQYV2+nMZjgemEBvOFIWLn+S1dM/OAC0A=
X-Received: by 2002:a05:6808:e409:b0:482:4dbd:4fe1 with SMTP id 5614622812f47-482e57ce234mr6049210b6e.45.1779049704393;
        Sun, 17 May 2026 13:28:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a4b:ddf0:f61:f58d? ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4f04fsm6341703a34.27.2026.05.17.13.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 13:28:23 -0700 (PDT)
Message-ID: <166a6262-0ad4-4957-9729-863e2694e81d@baylibre.com>
Date: Sun, 17 May 2026 15:28:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] iio: magnetometer: add driver for QST QMC5883P
To: Hardik Phalet <hardik.phalet@pm.me>, Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org,
 skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
 <20260420144534.0e47c06a@jic23-huawei> <DIL6ZC7KKYMN.36KGJXKDRGFB0@pm.me>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DIL6ZC7KKYMN.36KGJXKDRGFB0@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/26 2:17 PM, Hardik Phalet wrote:
> On Mon Apr 20, 2026 at 7:15 PM IST, Jonathan Cameron wrote:
>> On Sun, 19 Apr 2026 22:32:09 +0000
>> Hardik Phalet <hardik.phalet@pm.me> wrote:
>>
>>> This series adds an IIO driver for the QST QMC5883P, a 3-axis
>>> anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC,
>>> communicating over I2C. To my knowledge there is no existing
>>> upstream driver for this device (see "Prior-art register-map check"
>>> below).
>>>
>>> The driver supports:
>>>   - Raw magnetic field readings on X, Y and Z axes
>>>   - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G),
>>>     selectable via IIO_CHAN_INFO_SCALE
>>>   - Four output data rates (10, 50, 100, 200 Hz), selectable via
>>>     IIO_CHAN_INFO_SAMP_FREQ
>>>   - Four oversampling ratios (1, 2, 4, 8), selectable via
>>>     IIO_CHAN_INFO_OVERSAMPLING_RATIO
>>
>> I'm suspicious about this one based on a very quick read of the datasheet.
>> Conventional oversampling would involve running the internal sampling
>> engine at a multiple of the sampling frequency, and then averaging the
>> results.  The datasheet describes this as:
>> "Over sample Rate (OSR1) registers are used to control bandwidth of an
>>  internal digital filter. Larger OSR value leads to smaller filter bandwidth,
>>  less in-band noise and higher power consumption. It could be used to reach a
>>  good balance between noise and power. Four over sample ratios can be selected,
>>  8,4,2 or 1."
>>
>> That sounds like a boxcar filter to me not oversampling (which would be
>> a combination of box car and reducing the output data rate).
>>
>> If possible, can you enable the data ready output and put a scope on it
>> to see if that changes frequency when OSR or OSR2 are modified.
>>
>> Trickier to do would be looking at the noise levels whilst playing with
>> these filters and see if they at least match with standard filter types.
>>
>> If we can't figure these out, then it may be a case of picking something
>> that works well and hard coding that rather than letting userspace
>> change things in a fashion that might not match the ABI.
> 
> I could not arrange a oscilloscope. So wrote a small standalone tool that drives
> the chip directly over /dev/i2c-N (skipping the driver) on a Pi 4 and
> characterised all three fields in CTRL_1 with timing + noise measurements.
> Summary:
> 
>   Field    Bits     Role per measurement
>   ODR      [3:2]    output rate, accurate to ~3% of nominal in Normal Mode
>   OSR1     [5:4]    low-pass filter (bandwidth control), no rate change
>   OSR2     [7:6]    N-sample averaging, no rate change (real oversampling)
> 
> 1. DRDY interval vs each field (median of 500 samples per setting,
>    ms; SCHED_FIFO, pinned CPU):
> 
>    vary ODR (OSR1=1, OSR2=1):
>      ODR=10 Hz  -> 100.9 ms       ODR=100 Hz -> 10.30 ms
>      ODR=50 Hz  ->  20.5 ms       ODR=200 Hz ->  5.14 ms
> 
>    vary OSR1 (ODR=200 Hz, OSR2=1):
>      OSR1=1 -> 5.142 ms           OSR1=4 -> 5.139 ms
>      OSR1=2 -> 5.143 ms           OSR1=8 -> 5.141 ms
> 
>    vary OSR2 (ODR=200 Hz, OSR1=1):
>      OSR2=1 -> 5.142 ms           OSR2=4 -> 5.142 ms
>      OSR2=2 -> 5.140 ms           OSR2=8 -> 5.141 ms
> 
>    ODR is the only knob that changes the rate.
> 
> 2. Per-axis noise stddev (2000 samples, sensor still, ratios vs N=1):
> 
>    vary OSR1:                   vary OSR2:
>      OSR1=1 -> 1.000              OSR2=1 -> 1.000
>      OSR1=2 -> 0.723              OSR2=2 -> 0.706
>      OSR1=4 -> 0.544              OSR2=4 -> 0.494
>      OSR1=8 -> 0.416              OSR2=8 -> 0.333
> 
>    Reference for N-sample averaging (1/sqrt(N)):
>      1.000 / 0.707 / 0.500 / 0.354
> 
>    OSR2 matches within measurement noise; OSR1 trails the curve,
>    which is the expected signature of a bandwidth-limiting filter
>    on non-white input noise.
> 
> So to my understanding, OSR2 is true oversampling. OSR1 is a filter.

The datasheet says that power consumption changes based on OSR1,
so that makes me think that OSR1 is really oversampling since it
would take more energy to do more conversions in the same amount
of time. (Note 1 on table 2.1)

Another chip by the same mfg that looks like it has the same OSR1/
OSR2 has a bit more info in the same table [1]. It looks like OSR2
affects the sensitivity (and calls OSR2 a low pass filter instead
of "down sampling rate").

[1] https://www.qstcorp.com/upload/pdf/202601/CF382A94E1424763B3DE87DC967757FC.pdf

> 
> v4 plan, pending your input on (c):
> 
>   (a) Add an OSR2 regmap_field and expose it as
>       IIO_CHAN_INFO_OVERSAMPLING_RATIO with values {1, 2, 4, 8}.
>   (b) Drop the OVERSAMPLING_RATIO mapping on OSR1.
>   (c) For OSR1, two options:
>         i)  expose as IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY.
>             The public datasheet does not give cutoff frequencies,
>             so I'd have to either characterise them empirically and
>             document them in the driver, or use placeholder values
>             derived from the OSR1 setting alone (which feels wrong).
>         ii) hard-code OSR1=1 in chip_init and not expose it. Loses
>             the noise-vs-bandwidth tradeoff but keeps the ABI clean.
>       Slight preference for (ii) unless you'd rather see the filter
>       knob exposed.

It sounds like we already figured out that OSR2 is just a moving average
so might as well implement IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY.

>   (d) Keep ODR mapped to IIO_CHAN_INFO_SAMP_FREQ as in v3.
> 
> One other finding worth mentioning: the datasheet's setup examples
> (sec 7.1, 7.2, 7.3) all write 0x06 to register 0x29 before entering
> an active mode, with the comment "Define the sign for X Y and Z axis".
> This register is not listed in the documented register map but the
> write is required for axes Y and Z to come out with the documented
> orientation. v4 will add this write to chip_init().
> 
> If you have other measurements you'd like to see before v4, happy to
> run them.
> 
>>
>>>   - Runtime PM with a 2 s autosuspend delay
>>>   - System suspend/resume delegated to the runtime callbacks
> 
> Best regards,
> Hardik

