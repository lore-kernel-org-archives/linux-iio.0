Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC525242D6A
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777218710; cv=none; b=eYaq3NHGkfVDyxga8nl7fiJA8mWsDB2zfLiBzk8pNHeEu9JV1Ndhr/JtAtMAVvi0yP5ytORd62gQ2BhCZnajQDy5P4T6BHPu1P2YmCCajp6vkgqZL0XVwGKJwHpnZjiPup7JzmIdwE0kZIC5cwZJ3L/hRsfE+qzKUY53hA02qng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777218710; c=relaxed/simple;
	bh=EGLW9HMGfDx7ABXSJupibq38R2kkRECXGJU1FQpiFcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwymScQRQX7aUaArG5Dj1Ap/b4/k7BXzMtPLU8VHvgO12gEK3jVLPZ2wcDYAclKMgNQh9i7mViFQIKmvXIlqvAndMcECRQyiV04DJSNsDIL8th7Uur8V08a5I3NnpksZwlbmXcYC2u/dh5ab9wrbSzFvlLZHocREzlcmu7wCSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=sGGSB3Od; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="sGGSB3Od"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dcd689829eso5304919a34.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777218707; x=1777823507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5yp0qqqjCS8shohW7HVmXUI57qedX3zOWcwCIXrCqk=;
        b=sGGSB3Od+CmY9qtXUpDl6xGiwUltQUXoyLhn1PxqEqFMB/X0o+pgJbkaektGEjkCEM
         Y9L0Dcv49zZ5v1N0wXs7Hvn8o/NY5arTjJ5ODQV2Tml36l6mUETS1KUjtjkM8XMqE4qT
         dQlQWu4CHk4jub7Uz0YId3VmfGU1sRPxncB93S1tjPSLvQZEbRQJcUKhdrzJ7nluz4Dg
         oGX6zmE8oeZEJCNv1LD75J+eDsxMyU45S5A8OIf3UxeHO/io3pZaJXBptgDpahxa0oSQ
         j1y66shVjjk0RXVbSV439wWSAMyVFpUjQmHsc9CGDtS0eZCMW7+hrUVfDjt/gaRxkJif
         x5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777218707; x=1777823507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5yp0qqqjCS8shohW7HVmXUI57qedX3zOWcwCIXrCqk=;
        b=JRn7gH08oelEe7JaMBTCG+YsLIP5UuAcThkIgKjVe9+E1w4FkNpUjlDcS1KXyhfiKx
         EQh5YVdGUQIs29RBW3SqrxhXOw69Q3vjOgaybFmesWpEjXvlyKqPy7KOnR5RpoVYwZpz
         P2Yt4k9nKjIZTq+0zqUQNngG+pI++ARX9bdJ4rdHXLNG+hEdesAu543yVUOgSFa3kppt
         WTdw01q96F0f3yrIy3eDeCrl4hlXQqg1uG6KPDD5X3xWb3I1nJQoTcGPDONWld1dQNRS
         dneWpi4bnPSEb+eXLZqUJZsYWGBJxP68RgnzWnYta2Be9pvOjY2NtG/WymOVFzouHqJP
         ZGiA==
X-Gm-Message-State: AOJu0Yykk8hqlmRTr1a/AucpjPYlbkOOVSPbhsRFN77MX25V1es++MvM
	vbkafSuvoKgb/bWPz6AcOsyIAqWD/2U0A25DqCtW624q5P1W/A6O87ypBtsSm6LHL/M=
X-Gm-Gg: AeBDiespoffC9N2bjYrcJq1xmOAslgNxYR5Ee9pK5KC2z9DSC8JGj062WRo9Y7na9mV
	1+vehkzlKKg7HQwBXJwPPKrfUNZ0jLZlq7H2tlhcBNqCpo9JaKzpDbnKSQBkjkRCKJHr013MgKh
	s9FXTh+lO09wZp2WaJn/BZH3MajhdRlTde88OjMlNtMv4omhkGUiy9dABr3c6XqSUA5r2cKu3nK
	/qy/28JdPAUAtZJY54RJ1MF3419fgDyG4ZXB6/Ybiwc1diOtsdL7zJzEtU+CstL9PVyvaJcHy9i
	gMMN7u74BSs6M4ehSV1XgObe43BGV5ztvJXYgBYoafoFFOb2NMP1v7nPpVKTMsDt4QWcGL3bbC8
	lG1zRnz72yu3sCwfouazrZw1Y1/9JuvM4v1xXwiBF2KqPt4whib2umxBtaaER8vyseqKMIXroNd
	n5nUlJZpzvVBl7ssD0Kjlf1iA9HyQXJ3NyThjxnUCWU7yHqB5Kf9y8vJ2dCdi6AhOw26cWTo/FS
	wlkR5e8oIaCAd7cT79soEY=
X-Received: by 2002:a05:6830:82a4:b0:7d7:d504:cc6d with SMTP id 46e09a7af769-7dc9521cf45mr25725828a34.21.1777218706961;
        Sun, 26 Apr 2026 08:51:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:81f8:ef7d:a711:d99a? ([2600:8803:e7e4:500:81f8:ef7d:a711:d99a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc892c515sm18410305a34.21.2026.04.26.08.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 08:51:46 -0700 (PDT)
Message-ID: <b4f7044a-b7b9-4a76-ac47-7fddeba0a091@baylibre.com>
Date: Sun, 26 Apr 2026 10:51:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iio: light: tcs3472: implementing wait time TODO
To: Aldo Conte <aldocontelk@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
References: <73d2183e-dffe-4ae4-9312-c544e0079f3a@gmail.com>
 <46fd475f-8d54-4419-a195-d66c947fcc1b@baylibre.com>
 <3d4a4dbd-6618-4b63-ade1-d68155bac3ac@gmail.com>
 <4bff0c2c-f054-4098-a299-8030078f9b2c@baylibre.com>
 <20260426114823.2badc4ed@jic23-huawei>
 <6604fd99-342f-4b3a-bf05-69ae425b4e4b@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6604fd99-342f-4b3a-bf05-69ae425b4e4b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/26 9:37 AM, Aldo Conte wrote:
> On 4/26/26 12:48, Jonathan Cameron wrote:
>> On Sat, 25 Apr 2026 18:11:23 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
>>
>>> On 4/25/26 2:00 PM, Aldo Conte wrote:
>>>> On 4/25/26 18:49, David Lechner wrote:
>>>>> On 4/25/26 11:28 AM, Aldo Conte wrote:

...

> I'll start with the devm conversion and follow up with the
> sampling_frequency implementation.
> 
> Is it ok to make a patch series?
Sure. :-)

If it was me, I would send the devm one first and work on the new
feature while I was waiting for review on the first one. But maybe
you are really fast and will get it done all in one day.
