Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF303191D3
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772902562; cv=none; b=dgBra7hyJm1MnVw8LWGxtcT8/vHo19NTwOXroUhuHUWgdhussBee1eCf7J8yxmVS1LTJbLoLtaCPO8B/u6VWtpt6qO4rYWRL7N1NOU1fP6iKONrC5WfkrGdSllHNYByzrjQLuKk85a8YhQDGKbZWaDjJBZmxCsLe6HtuGMWRGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772902562; c=relaxed/simple;
	bh=WPUg4rBGvjsjQn/sUqpjp7/URqmpCG9VUSIoqX5wYXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0ldvQjclM69Mo9MrFV3YEAME+wt9iI436ZQTz5RNYUnhtrJSWtelNqthngylxLtpQ7A3LlqAXDmDxyix/H9UxpPaGgBg8Qe2V7FqY6t8PYu1I8QShzTZT15ZlM5LC+cWFABptV8P7rTX8PSJkeMDk22I6mQQCFHeNStXA/xFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uC2Zei7r; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uC2Zei7r"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67ba5921b84so264731eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 08:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772902559; x=1773507359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Ex7K8txUyjeJezn3Qxas8NuzxfgLHxlDFDlvFe0P1w=;
        b=uC2Zei7rBYpxIyw2FyPRgPij58gwZLEED4OnkLuJExJcm0ju3w4lK+X/ea9MUQnigN
         ytQMShjLALBpTgnXjwnmyxUOtnIVkBUVFGykjJ0aH+/1Y+4Dn648O4wCKuVVT6vn/EQm
         PB1z0pQ070Qb/itmrfgiPSz2lQ8ARUQbm5umeJI+uQTMgP/GEOTr2pBCSueT4uMqkN0q
         UxJilm8RBjPxV/IWCPFIrRC6X773Hj+uOOFg1889h9E1ROufC50ilXNZ7NCGGKzClbLE
         /XPyPpt6wLWGolByzd39DJhOpLfONxcc+CZAeM8L8Zx+scQ8o5bBfBb9d9NUs1qqIKUY
         zyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772902559; x=1773507359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ex7K8txUyjeJezn3Qxas8NuzxfgLHxlDFDlvFe0P1w=;
        b=mgbE7ViPPaKORXXT+7nAxIWtVtvz2zzutXujVaJQ7GLt4fWxEehxdxRQdmuGFMEF+l
         KwFTmZxvg+XB4DVsqvU9Ps/y2fFK0ZST7DG2axtNH6mmWn27cSuEb0L8dHA51QYaHQo/
         0nLiYnAoYhfFh4m06tvs7KjuefSp71dKvDKG2MOIhdM5390b/1eXrbqsHaMjWlBN5AEk
         a0YaXEKBL3KAYbicOLIXFCUVDUbMFGwDZIAS3ZYeiaeJ+Fk/aTDeg/5eJxc1zbkR1XpE
         DGBvmcFx/FpmALPs2Xht9oph14qiQQ4QHYPL7tfIqOiviH2PL98J1JLa7loIyp3INItP
         y6gQ==
X-Gm-Message-State: AOJu0YwO6BWqFjptsKI7u+TXElBJOqyurHepW/5KdIvhmx8MyZyy1V+e
	lc9iN3BlVnh3y2rHPbC1iqSA8IJ5W+qFvHDuTqzt3Jbssh7obquwW8bEPzPlQHGrs7g=
X-Gm-Gg: ATEYQzwpBD8oH2wodCBqCx/TUMvX4jJoR2yEDhcitqe3sjw+tg7v4jriqaz1NCOBWmn
	CLiJUe+HDuK4xteqQX12JOZ1RLOyZimWLT6A8ipMvFMM5Mf36zfJOGF6P+Ncho+tinZoptnHMcx
	UFOh4gm/T3B1DCgVPu6gZpQBKsoI/HQslX5YUARispUSUxdlT0MQQ7j+SVOuzZUdeWgRZeGhAc3
	Fx32hqDJ9Vh1uE0DZGUqW3RRFUVO3KFxH8HuYY5H+FQUS5YUT8CK7wYR2CcV0dqMNZi6WhNqP44
	qmgi1Js7leZGk+unCoARY1d/3uSYXfBMscVAhQg0oiabR0e2sjMxodczFMocu1pxS6HFBsNcjJF
	4KqHicVVc+LMbNfZT+ZsfMCMxOOQH1SPFXnIYI2Zifb7ofYJgJ1UluqgxEnkj1oMFqJnOdB/FqF
	XzBzwPGgxnvA6M8vBwm4UsAbL0JIJ35VYjV0OUZNjuj/dFpYWXuk2nY10IWm53Z427J/DB/EKy1
	Q==
X-Received: by 2002:a05:6820:1b19:b0:67a:47b:59f8 with SMTP id 006d021491bc7-67b9bc4f1d5mr4002681eaf.11.1772902559376;
        Sat, 07 Mar 2026 08:55:59 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1be6sm4417071fac.7.2026.03.07.08.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 08:55:57 -0800 (PST)
Message-ID: <d0ec6a2f-6d30-4774-8950-15dd3c4b020b@baylibre.com>
Date: Sat, 7 Mar 2026 10:55:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
To: Sirat <email@sirat.me>, Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260303090253.42076-1-email@sirat.me>
 <20260303090253.42076-2-email@sirat.me>
 <20260303-strike-froth-a2e082b8b59e@spud>
 <CANn+LW+kWoTnw32Db_T4t4JCCcCRtUead53i5tmc7Xeme=9X-w@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CANn+LW+kWoTnw32Db_T4t4JCCcCRtUead53i5tmc7Xeme=9X-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/3/26 1:49 PM, Sirat wrote:
> Hi Conor,
> 
> On Wed, Mar 4, 2026 at 1:12 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Tue, Mar 03, 2026 at 03:02:40PM +0600, Siratul Islam wrote:
>>> Add device tree binding documentation for the STMicroelectronics
>>> VL53L1X Time-of-Flight ranging sensor connected via I2C.
>>>
>>> Signed-off-by: Siratul Islam <email@sirat.me>
>>> ---
> 
>>> +  vdd-supply: true
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>
>> Are you sure the supply is not mandatory?
>>
> 
> It is mandatory. The driver uses non optional devm_regulator_get().
> Will make the binding
> match in v2.
> 
> Thanks,
> Sirat

From the point of view of the devicetree, it doesn't matter what
the driver does. It matters that the chip can't work without
power. ;-)
