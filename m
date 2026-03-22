Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853F303A0A
	for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774139885; cv=none; b=owFBz3IEEm264gm4EqjgLY9PRLA936IHv2V6d1E3Ui3AJLOU/+DjkC4c0QHDe49GQaM7NRAOAXRRHshBr2cE9pVLceME1aLcgqyGhOuR3ebc15hj2erEqXrdpNOhzxtjVk/cyZh/DZx/6XftP+wPm9g743JwEw7iwDte7QNDaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774139885; c=relaxed/simple;
	bh=6dLhB2ydoQBAqJPB1raZlJyeJqk0XqP+WELLlaK0rKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWa9Ru48M6t3FnIpggBwNxQVmomWLEi46llyKTJWz6vRNJvr4kYF7fob1vSfhMwwmzuP4DvvB7cPdVHuTsiZhNjX1uBT0nMb/MjHmQbBhAnwyhHwhyxKcj77ffB6mGTSPT+YVvuK+PUzLuNSjQ5pzL5q2iBMiCccO1a/DQFzi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=m20yiiym; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m20yiiym"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4670464029eso1183734b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774139883; x=1774744683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZkURIzaUVIDe1R8WHRcSdusVPoS3d/IbkclZRm0aAU=;
        b=m20yiiymSwTNb5PCtfbOHTPDJwyRUu81ZGCoAiLBlO9tP/GemtwbjWh4LJqIbMd5ps
         Hdbvf+8lZ79Bz1EC8BgOx1jhgAgyaPhYtUNhV/azDXqr85lbMpIDQPwMyPcHoHI1jrEQ
         I8gKyKiGeOF8Yr08ik45Vj6Bj2NTBsEHuEZuOVtwsa+/K/CrMiCDiFxaKW/ap0WOPemd
         2wVBL7gbn/kaHkcy3ETvNdErTI2y9vMsXuDNzegwKepsSBVHFWsoBRLdVl30PmbkFfCT
         W6NMSDurky8EuPKCjOL8YwVUxrDMJDsz48gawrXQi2djNewXwhi3njA6TxsfnFBNvEnl
         KZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774139883; x=1774744683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZkURIzaUVIDe1R8WHRcSdusVPoS3d/IbkclZRm0aAU=;
        b=hG9xR5UD+3ZzlJAaDhfalMtr+cEG9wEstVKQj9nUajyvAE9/x4lhdHKgjIHSVNA6ow
         1M/1Divg9NzsnaDr4UdRp2LjxaQsBxdHBK0RJcitFbUihndpxTqOdCgl0bqUugTlFY2c
         6dNcBVp2TsVnZYq8EZ5QZJTxtkxveo1D/fU9jO+UbARYwf9xcqrpnfYf10KfJrmm7464
         jz7Je/UrFQTm+ysqDRVsOhYfgsGkBUDKOOUbyR3tJX4IE02cMeUnUAopioKaXz9zRmUD
         q+fH4sfKh+PAA+EWJevTxQEJeEMFtD9G6e5xWPe/ksAO4fkLcVlQr+uy0BkE3UIINAha
         VbPw==
X-Gm-Message-State: AOJu0Yy2oIzT3jDFY6t3/JaU0s+ehHVQTEtvXpbhhQ/V+B3i7AYiacfa
	rwv4gIfFFKf9XQnev3Lbkb5+5sv4UYbGSlkXv8Ue8ui4S12dvchYEFCdKm27acJX5A0=
X-Gm-Gg: ATEYQzzpDXkolwtmvtv6iIawbUzwbqr9FeYvFHOa5rD3lfAOI4HdDSkaPHqfnlH+gBG
	iDEcOFlEm5QHYZQMq1S5J7/wR4QRxWhFxxqM54sV1lnIX1IrKixr4x8vZra9yJka7r3KzPaw/Q6
	1W0gv45C2RSbj5tTPb5Y/lCuBmAcV1IQXbF3dGyGU5dQmSXKuhXysA9mkQg4BtrZ3AQC58FxMfS
	6ale89gIBcz8/UZjDkVgIkxF9Wxf8xEK5kP8vjldq3e+BM6lXhGnqvhTeAo311BILr1cmsSc0ua
	+L3TZlkerY6KF8FYpGB/xk3goC8cYovHdRajMiEpCXaB5KwuRFicc6F5vgaqAE6f99Q40mCC3Ev
	ETPpyb96w0yR/dDDvdkc+wGcjHZMmZUWOQbd115mk83U04IpzNBvHe//icMuqCCY1nbHYjmfFRg
	IZ5ADz7ch5KeYxLH/iad0i2fw+CM69mfmWd7ktL4tKDyDPSJPSmb8mU4165TjkDgSFYZK7aZI=
X-Received: by 2002:a05:6870:45a6:b0:3ec:4f31:42a with SMTP id 586e51a60fabf-41c10eff5ddmr5416367fac.7.1774139882771;
        Sat, 21 Mar 2026 17:38:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:fb84:df2:aafb:553d? ([2600:8803:e7e4:500:fb84:df2:aafb:553d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14d63aa9sm5915411fac.10.2026.03.21.17.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 17:38:01 -0700 (PDT)
Message-ID: <b1da32d2-e1f7-4fea-82a7-a40e8073a100@baylibre.com>
Date: Sat, 21 Mar 2026 19:37:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
To: Sirat <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260319190738.151614-1-email@sirat.me>
 <20260319190738.151614-3-email@sirat.me>
 <8502eb51-53c9-4f1b-92d0-21b06fa4802e@baylibre.com>
 <CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/21/26 5:39 PM, Sirat wrote:
> On Sat, Mar 21, 2026 at 11:09 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 3/19/26 2:07 PM, Siratul Islam wrote:
>>> Add support for the STMicroelectronics VL53L1X Time-of-Flight
>>> ranging sensor with I2C interface.
>>>
...

>>> +
>>> +     ret = vl53l1x_start_ranging(data);
>>> +     if (ret)
>>> +             return ret;
>>
>> Why start ranging here? It looks like this is controlled during buffer
>> enable/disable.
>>
> The VL53L1X (unlike L0X) does not have a single-shot mode. So every
> measurement requires the device
> to be running (Autonomous mode according to the datasheet). Starting
> ranging once
> in probe allows the direct read path to work without any additional
> start/stop logic inside read_raw().
> This keeps that path simple and low-latency. The buffered/triggered
> path independently controls
> ranging via postenable/predisable, so there is no conflict.

If you do a buffered read, which stop ranging when it is done,
then how can the direct read work after that?

Can we just start and stop ranging momentarily for a direct
read?

Otherwise, is seems like we would want to have ranging always
enabled.

>>
>>
> I will address the rest of your review in the next version.
> 
> Thanks,
> Sirat

