Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D9311C11
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777134499; cv=none; b=CQjLKDfxzMlhmc76+wyOKQA7KgIgcihHXCXKHZcwcwFuJig2Z0pXMborA6PhAw8qNJ6Ji6TMjLvD80oALPFYeUjgwy3kCU9/pc/0nF1w1oihgy3ZWcdWdmParin61nX6yoqWcL+lZFY1PfdgzYIuD9I4LOrgIcex1WOJ6NqWDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777134499; c=relaxed/simple;
	bh=6DVVigE0PE5bZsJsEGVrxZ9Go5QlF2xfyHOTvDQpYRo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jQOfDE8VKDoUxGaAcVo79GvnGK1qZ6gHd+FkqN2R38xFFxPlHnNtlvGB4Kqz3+E8VQsHjSoB8NwTwzPtTzZ2OvyxtAVsMWe2TrqInvo/lF9/FJpOFj0zWjD4A8KyC57eLcTBz2hdN41DkdXChSh4yN4ok64R2za0NkegCPjqL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZADEpldY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZADEpldY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso91576595e9.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777134496; x=1777739296; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9qRHIfL1jxJZA/tBUCetdPoUQG0AW6VTxcp8Jo3jUI=;
        b=ZADEpldYEaE15Ge7g9a8qeAykqu/9mhQGiQ0aDGfWxzG3N3j+F3EK6SiUbPErlQu6v
         TM9aGWQ73NQCLU5O//96Lpfkm4VkZ/w/ktGus+UeHWNlXtB2z/kN0n/faA0OEgzM7neX
         MGcO3hAsBT+jACtp9aSnGlQ5pxtI3ityPCVKq47UzAcP/ICzItu0OOGC9uFPbWb0zkgq
         RZd1+KDbmIf1ijb1LIULbbXzKOw4xfPN9OD+lVj2x+2qwwvrZ2Hi6sUnNpu7CGYPUDGu
         /y2zfTrRfZaEIknENZL3jDUjNJjTBOVzVA7SMucAroMaUHCvg16diIYV2op1GymFEFb7
         PaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777134496; x=1777739296;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9qRHIfL1jxJZA/tBUCetdPoUQG0AW6VTxcp8Jo3jUI=;
        b=H8tfkgJ2Ww1nhWtrIu65oIug9ZPwdbiHEQ5ReX65m3NACYsDXoFIZLAB+cM6SyXKjR
         ae4/A0MRh11zO1vdlM3ocMR1cpKZgbWAVfl9jp0d0noR/NKe/XYH14ba2qfhA+f8swpO
         EU2q5wKKMl4HHkaK+tKZ/6glOIxFusFgsCOiVrWMTtX1UCXlrL68xL3OQHIrktq4iMGj
         bQnefUwW2mrlqZC8K9cJJ1aOeEqbIIzx3B/Ul6rH+cqSnD4/HArsGpPJNa1uytvsAwW1
         NY+zbcf003x9CkQPHcsy5vC7KMw8VdliZCs4wv8KKYJx3gNnqBpYb1fnwpJDqYCG3raZ
         OSWQ==
X-Gm-Message-State: AOJu0YzC/U5KB/7MWgT3UZXkSx4FtBI+ILuMoFHr2mHprLAAhkMt+SKR
	kF2pqin2rhkq7nWwn7OF9iFOjdTwlfDluQ5v5KKMA0ugDZrUEZ588emEkiGaig==
X-Gm-Gg: AeBDiesQkbHekrS5nqalpDLs7KjrzaAVGgyi5mwjWehjjOh8QsvEUr3NmRewBihh7Hu
	hDPdlQA2nVEir2soK/QAQ3ZIyC2tDZP8uKwDcNFDgntBlFN2twW2O2Nss3grSeFw6eZEFD4aukc
	2Y46+DYYIGgV/yVU4gP8mDUGl5oEY3/+ulH0JXLh1pNcozw4fPSQfzmRk+7vTBmU2NM2VKEh00o
	Qs1/5JpwDdg0G+zKwnWGF1x3iKGHgB24/bZYJOf4wGHWebIJazJbb7k7hjYTtl2j0w6ngYJcTSs
	zYtd4yRXHTTQj5BZVPlAghHckqaymR5YASn7a/dIdd7zOGWUYYurtvlf6hkrOjpv4VmqjkuZehx
	7Ymsr7JpzL7dk94nipuShL3IA5c1szhHNIj6CV1ty/BAMhIKFg2Zv2yFsdjSUU1aa4/Xf3VxK+C
	IumRQ3v1KohL36DUc5NK/l2qLJk6aTXVPh4+VgaA==
X-Received: by 2002:a05:600c:8b55:b0:48a:57e1:d8cc with SMTP id 5b1f17b1804b1-48a57e1d8d4mr300699755e9.9.1777134496309;
        Sat, 25 Apr 2026 09:28:16 -0700 (PDT)
Received: from [10.40.226.70] ([78.213.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78d1bcsm292950385e9.5.2026.04.25.09.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 09:28:16 -0700 (PDT)
Message-ID: <73d2183e-dffe-4ae4-9312-c544e0079f3a@gmail.com>
Date: Sat, 25 Apr 2026 18:28:14 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
From: Aldo Conte <aldocontelk@gmail.com>
Subject: [RFC] iio: light: tcs3472: implementing wait time TODO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'd like to resolve the wait time TODO in tcs3472.c.

The TCS3472 has a WTIME register and WEN bit that insert a low-power
wait state between RGBC cycles. The register is already defined in the 
driver but never used.
I noticed that tsl2772.c enables wait with a fixed default and no
userspace control. However, I think exposing the wait time to
userspace would be more useful to tune the power/responsiveness tradeoff.

My plan would be to expose it via an ext_info attribute in
microseconds, following the same convention as integration_time.
Does that sound acceptable, or would you prefer a simpler approach
with just a fixed default like tsl2772?

I also plan a following patch converting the driver to devm.

Thanks,
Aldo

