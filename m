Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07655405AC5
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373361; cv=none; b=gjuN3L4Rs97ALXfk+1Ha1cj1xY0x3AgVEnKcCvaiTcw7haYbcKrNivisLpFfMyPOx9Nmdr2gvnvkj1F3Chd/j0cHwXjvpyk+UoXiy87GT14AZVlGHbawr00ffSKxjvpAUzthrhJvLp6X2LbV34XhXWqwJfVh7azIljPed1aen8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373361; c=relaxed/simple;
	bh=+ZEbCLyLoc1U+1Me6J7mvrYpkghwfgGTcKlIxBiMGjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4efbUh6xyAyndu9TuoZ0mmOAXvWv4yZnAfykJjzmaDtGLftjHH/LyQGdLNsAuFNhxSjwhH9X5VVXftrDU0fSnZLAcA0g29S2xTCpjMJeeeUAwHjl/7s74xIZ6MBrYn75X3+hIHLVDc7SgFhb22XowGYuikk0MBl+FOFwebBaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gig/XURb; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gig/XURb"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d77b179b52so1125083a34.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774373359; x=1774978159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhy7rQIQOTUlhyX3h0JAVHxGs6BVrDyegAUb4sJpE/k=;
        b=gig/XURbyRAsg/bb8Zyf7Wtsozf4/11Hsf/+ggaOK+YgLbT67Cgf0Db1awJU/+Nosa
         NFnyeuDEzCyqBlTO9kq/2Zm0h/XIAzB3jmS7VmtmE9iYRYTBA1B2aCSJ8YBxW60FTHUk
         YvpRfuoRQ4pWbOrOIl26SNA+BjfJXqTbcVSPoyU+CgbCPo9w7VTGlz1BMsYjek0wQebr
         GYt5OO8fjV+1aUksClRqTPZ11kqtuBlFkjQVtsjLVoDZw2hNI0TTqyGBwn/HuI0mqZbs
         LjnoL7LyXLJGuJT9IWUvd0PWDLSmaDrhQPmSt7boBFzZb3XFrnmvehylwKOeV9r1axAP
         pWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774373359; x=1774978159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhy7rQIQOTUlhyX3h0JAVHxGs6BVrDyegAUb4sJpE/k=;
        b=pUw4C6Uiqsa/gdWJdv87Badop5eMDpgxr8z4Bw/8QvavRhM9KuUwATN3qrccZygkhB
         M0L4aV+peR+st/kmDP+sC3xvptaJz+vmyfEKZLaF8l22XUkg1uiJ843ij2P4podWOdK+
         Bd3U6aGUjjkH4WWVydgPmQHf6JM99EXZUC7tyYcU3wVse9FxFOGJLrz93Dx+Ixf6IHWx
         UjgYnhtxrnKq6XVEYbjLPVOxGcUfCsWtJSK5tugPpM9ZZ46L7obPxhf74rnQS504pmTT
         O/iaJkQmqCivf11t5rUQWU9EGOb7LCGMB8ox+tJbbcE8L+312mqYAa8FOKrMmut2gCR3
         65bg==
X-Gm-Message-State: AOJu0YzC4ikDGOaHkoX8Y9NBTjQj/35m6H79JtYAbctATD88A0GzEcxy
	I5bx+GgRS00IgJ27EZwEVE1QEfcW3y8OS0inPQxzrheTCpQ9LZ666jM8HA+LgR/qQWY=
X-Gm-Gg: ATEYQzyPZlLyL1CgSHjqu2pcgEkQOeAXWj2XbUl/29PDmuKDYjHNC8DM7gRgJjqeuhR
	Z7FQWWPaZeYPsiemwwKLTfCl6MZBNbLE28Md/vOjThjYpVqvcYvCEWjarhTtbCzejYU0sQWBHht
	/aS2fJrHvHBhvBaQJ1lCjBMsfDvddDutmChH7pMPXGmicuZxYvZEAJgJq69+SgjmF9d/trQPOQP
	oifbsH3+Fb5YoSPkQmeHoiDhhMvpe98r72R1PdlK57KOhyV752feWjIOJzshOUw7xpu/HON7CS/
	2Dp+7CY+QNbw64sGuOa7pOucxd2amBYEjoACt9RgjHDOI4p5qboD9Law67ZRO9RHsaAx+L0VQUJ
	XITNP14ElBIq6WD7kkxBnh/BoGpNxvrb8nbgwekVuLEPr/yNVvAwexGnBH0G/e83lR0Cs4/vYqA
	ildeOJwkwOwixqfozqu06pOZdETcxDRFjc/TGKsGy2zRxJBqyZe1sqMxUbnWGxDRBP4aCS+Ug=
X-Received: by 2002:a05:6820:985:b0:67b:bc25:2670 with SMTP id 006d021491bc7-67dff42078dmr407150eaf.26.1774373358893;
        Tue, 24 Mar 2026 10:29:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8a85:a776:3f75:a1d? ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a5f99sm14342917fac.2.2026.03.24.10.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 10:29:18 -0700 (PDT)
Message-ID: <c1d99a64-ea4e-4cd5-9b1e-0972a5e0d61c@baylibre.com>
Date: Tue, 24 Mar 2026 12:29:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
To: Sirat <email@sirat.me>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260319190738.151614-1-email@sirat.me>
 <20260319190738.151614-3-email@sirat.me>
 <8502eb51-53c9-4f1b-92d0-21b06fa4802e@baylibre.com>
 <CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
 <b1da32d2-e1f7-4fea-82a7-a40e8073a100@baylibre.com>
 <20260322110319.7d7558f3@jic23-huawei>
 <CANn+LWJwPUiCkz_godEeBvZnXEXzNmCW_-ou=wHL+kjfn0zF_Q@mail.gmail.com>
 <CANn+LW+OPP2riP1d=zZKz8MnTk2yo2CL3qn17_LYD=1SmCAQgw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CANn+LW+OPP2riP1d=zZKz8MnTk2yo2CL3qn17_LYD=1SmCAQgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/24/26 10:17 AM, Sirat wrote:
> On Sun, Mar 22, 2026 at 7:52 PM Sirat <email@sirat.me> wrote:
>>
>> On Sun, Mar 22, 2026 at 5:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>>
>>> On Sat, 21 Mar 2026 19:37:58 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>
>>>> On 3/21/26 5:39 PM, Sirat wrote:
>>>>> On Sat, Mar 21, 2026 at 11:09 PM David Lechner <dlechner@baylibre.com> wrote:
>>>>>>
>>>>>> On 3/19/26 2:07 PM, Siratul Islam wrote:
>> ...
>>>>
>>>> If you do a buffered read, which stop ranging when it is done,
>>>> then how can the direct read work after that?
>>>>
>>>> Can we just start and stop ranging momentarily for a direct
>>>> read?
>>> If the latency is high, then worth considering whether autosuspend
>>> and runtime pm can help. That way a burst of reads will see low
>>> latency after the first one but we won't be wasting power when
>>> no one cares.
>>>
>>> J
>>>>
>>>> Otherwise, is seems like we would want to have ranging always
>>>> enabled.
>>>>
>> Maybe we should go with continuous ranging then since it's the
>> vendor-intended behaviour.
>> Since there is no hardware single-shot mode, by design, I think the
>> driver should just behave
>> as the hardware intended.
>>>>
>>>
> Just for the record, I'm dropping postenable, and keeping predisable
> for only the cleanup.
> 
> Thanks,
> Sirat

predisable must clean up anything done in postenable. So it doesn't
make sense to have predisable without a postenable.

If there is something unusual going on here, it will need comments
with a clear explanation of why it still works when it is breaking
the convention.


