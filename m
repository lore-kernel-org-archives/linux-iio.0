Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF332E7657
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741945; cv=none; b=e8KUcvgW4uqMuYF9Y6FKwkYeF3733bTCeVbe/mZBeWRCdNWt4E/iPtyMalgobWryEVdyOjnCe43vuUJiZBhGepftytG1MPYPZxO9VQ6/36UxbjBfewTLjWHtcuSvJN+IA373YW/UDtcUuqqg2L06jWu5BLR8oy+bvg4powi1n1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741945; c=relaxed/simple;
	bh=jflO+h77l5hCKpuSGsC+NJK2xLN6Lv+FUfY/QtI5Q9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cei52Hn6Kr53V7XaIVxDeUxOJ8eN2EUBUIn1hRMGeTtsGtWzOyaha4CZM75ddinuXGyGgj44PIg4eLOW0x/SfgB9odvCzJsmlTqX/6WZVLPh5ieS1f60XiNHCgmVeObM8kg/aD56vV8dVVLoWEJufNjpakg9WM9bbk30Wchpni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WPFvsIGG; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WPFvsIGG"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ea611d1a4so75829fac.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770741942; x=1771346742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oI2/srRdfJUB5ychoQIsRom7VtloN/SQlK8U2PiMXo=;
        b=WPFvsIGGRA0lvAkXhbjSqwKaE7mxQCalCnFjHaoZORbeqixmFqQQlR6xLOBTSjXAS8
         ZuoWE+xpv59jdLJDaQ3KP6Unmvzy3pyMuyxS1TLhXEdG2vqbdNbMIsv2jYd5Ksi+CsWR
         pKnYeTr2rXCRoivlH4i+0joPkulOCtsEMdDLGzepZQx/1XkAUJJzNO/zn9foGEl0oz17
         wTyM1FJpF0dafaDvWken+JM5otDCChtWG35nRrTffMeijqEkHEmL/29NryWmw/c2d5xo
         ITY7g36/hg2wDeuOeItSP2srcmnS+2TS43BDv6DlWBSwCkH8uF2lexaeTmcSSD7gkBkr
         HAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770741942; x=1771346742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oI2/srRdfJUB5ychoQIsRom7VtloN/SQlK8U2PiMXo=;
        b=w4O540w1xdEJBvX2xjiJJlSEiMbJX+ZgtDf6ALhcAD+YniOObAOy83ScvA+tYD2veI
         bVZGlzkxoz6idbjCUYyNjzgi6OAAe2/h52p3nrlI88kDzeSpzTTligjnUJkICrwWB3qo
         6a/NQrRGIK/vZL7FeHhs6NBmSBqyHNeLXSg2yIA1jSHaj36crYU5JCx4eqfwCP5QvVRF
         vz+/TSAhmueOyew0XSfwA02dXl2Pp8XJ/ss7eCAQnifNjaeUEY3PW2xJxROof+viF090
         Uo1Ihj6qxNOWdAnWj0/VOrtZyp/YJICA0ie+1G3eQw9ZPVWwHN0K7gxMB8TDv7FzAKBG
         fboQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMo1uLYOnt2s/h38Q3Zc0NcGBVcze0gX7EEMBgozjCqDElBemOSScWrYg3tCZyBSI3ySkt6mhiNRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2T3Pp1mCsIw9ft08Qv4pYMD9j34FWtfwQjQA6FHYS7MJWliSC
	egJm0ZFp0mOnOMKSyf8fYrkgeDQTAufyAcEypAAFAhrwik9LBx0o+kH8p0EtMYgEcVQ=
X-Gm-Gg: AZuq6aK9/aeDw1nbACqyKryLrBm2rOnPN/lu3qxKC89wX4hH7N3P686+mnrJhKddrcK
	mjK1VyKwqEPM1hTYO6rFunaCWfGRasCsAabEwhVBSjdJFelLCLLXDMKa07evP2dxvK2dOf1gHZL
	/Hj0AMwVKcfxC1wMEtZ51pcmwztNS0FHWdA0PZ6C0gUp6SJW0Mzin3PgJfi0/fiYNRkyh2CPbFc
	ur0IMxjQERl4UF4crhXQW5MeYq7+mvUCD+/F8o+A08A+ILu/AB/E8/kmsy5LGIZ3ZkrvRof1GGZ
	9x2LbGMXyG9gAhHMnnWU7LYgg+BeBG2Hq/WNsZ32FyqGf0bhSzYyo2PU/CEUwndo1Zwqh6Ymcb6
	aPgxWeojyaxLk+Gno0C1ri7bEaYit/eX5stSTtDhacFswJTzaF1BC0o2YlgZTE8GHlL0mTqHVhT
	MJikJzQHlqIOKJzuPMAgVvsAoTZ2LNbpEakwpizhS8WK0D0im7/kDSI5dqe+iCwe1ja4kEi47MJ
	yj80TnSGeQ=
X-Received: by 2002:a05:6870:5cc5:b0:409:4195:5c25 with SMTP id 586e51a60fabf-40a96cab343mr7279214fac.20.1770741941669;
        Tue, 10 Feb 2026 08:45:41 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:97d4:ac5c:3288:2238? ([2600:8803:e7e4:500:97d4:ac5c:3288:2238])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a99355b7fsm10253452fac.8.2026.02.10.08.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 08:45:41 -0800 (PST)
Message-ID: <81fa8ae9-3c72-482f-a998-911acaa89a8f@baylibre.com>
Date: Tue, 10 Feb 2026 10:45:40 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iio: dac: ad5504: Inquiry regarding voltage scale
 calculation
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
References: <20260210121032.4630-1-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260210121032.4630-1-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/26 6:10 AM, Taha Ed-Dafili wrote:
> Greetings everyone,
> 
> I've been reviewing the ad5504 driver and comparing it with
> the datasheet, and I want to verify my understanding of a potential
> discrepancy.
> 
> Datasheet:
> 
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad5504.pdf
> 
> The Issue:
> 
> The driver currently uses the vcc regulator voltage to calculate the
> output scale. However, the datasheet (Rev B, Page 1) states the device has
> an integrated precision reference. The output range (0-30V or 0-60V) is
> determined by the R_SEL pin, not the supply voltage.
> 
> If my understanding is correct, using vcc for scaling is flawed.
> For example, a 40V supply currently results in a ~9.7mV scale
> (40V / 4096), whereas the hardware output (in 30V mode) is fixed
> at ~7.32mV (30V / 4096).
> 
> My Questions:
> 
> 1. Is it correct to replace the VCC-based scaling with fixed constants?

Yes, I think you are reading the datasheet correctly. I'm guessing past
users just put in raw values and didn't use the scale attribute.

> 2. To support the 60V range, the driver needs to know the state of the
> `R_SEL` pin. What is the preferred way to handle this hardware
> configuration in the bindings?

This is another one of those cases where the pin could be hard-wired or
controlled by a GPIO. We don't have to implement both cases in the driver,
but we should try to make the DT bindings complete.

properties:
  output-range-gpios:
    description:
      A GPIO connected to the /R_SEL pin to select the output voltage
      range.
  output-range-volts:
    description:
      Hard-wired /R_SEL pin state. 30 V when pin is high and 60 V when
      pin is low.
    enum: [30, 60]
    default: 60

allOf:
   # Can't have GPIO and hard-wired at the same time.
   - if:
       required: output-range-gpios
     then:
       output-range-volts: false
   - if:
       required: output-range-volts
     then:
       output-range-gpios: false
    

> 
> If you can confirm this and provide guidance on the binding, I would
> be happy to prepare a patch to address it.

And we should fix other trivial missing things in the bindings while we
are at it.

vlogic-supply: true

clear-gpios:
  description: GPIO that controls the /CLR pin

ldac-gpios: true

> 
> Thanks,
> Taha

