Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93741F7FD
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439154; cv=none; b=dAC/1qYwFEXZYgaE4NrlIRgCYKYKz0q6qqQkjPu/VzaKa03ZpKibHh4tk+bnAHTtiJZnKfcHbau8s9BDjvboCQZjiF9UHKIyZdkvYBIcBIF1tH9OUQLCB880OQHZvXr6FIzKe/DUtKp+nkALO8y7dWyUUslx1WyraS3b2ra6Kfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439154; c=relaxed/simple;
	bh=UzLwZP70uzDv9SFwbJOJr15PuAm1qjXhbukeM7u/sWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luAbOBpPZqpNrVrX9kEzFaEnHzZ/OeAHzv8I9ZFNpGaV4PEvn5A1sHLThaVVGtv1EdDH1ngQVG9TM+vyXNj0NXl50MpVx5mxnVgITiEitNUp4BZ7nHCEhOzxVYD8AIJZWAcd55A4UPWexeT+JYKKFBONSuxsZsQjOfzWQ8ZrDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgBZJPP6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgBZJPP6"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso2379371e87.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786439151; x=1787043951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DU1otr6dgirGY+XPSCMtF93xxpfUdnySuEs4cDuWz/8=;
        b=fgBZJPP6Fc2YCSnCGvKsi/ZeGuIRf9TODigz53D9YLcnqvhMxWJmmlMFeLxOjSJ0W2
         ZtHSqjy07PN9uFyjManaYMoyNx4Dl6pxxROvM1dNTVzFd410emAG1m35zYj/08du/bCC
         GGaQlIm1slqqHbM6GWKKame1QCI13h21o51rj+LrmbyYpNoKTjF/oJF/O7mbbrGm0k10
         nqARImJ7Jvmc9specd2X1RWd8bI4wAos6LFdo0ADbNAlAFBtJRhp1Q4E4ZeS3Oz5eZrQ
         o2NW5MxZqV+mejGmWO/deZ2KAwEhxJnX437lHarK9dasFt0Z0hIOOfK+/fIt+yaDG+qs
         llIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439151; x=1787043951;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DU1otr6dgirGY+XPSCMtF93xxpfUdnySuEs4cDuWz/8=;
        b=gdLiI8Yzy51udsdnhqstz3E088MxfwGFmA4jxCCTSeNqAPwQ9IsD1quEf9B8DhEgwH
         kGq3BPXy0rQFp439ilVh3he/QeGGg8Y2M935x4986U/IzemSR3Yy3wDn7Sh18hHqEqgj
         32kbgyw5ce6UUfn+D96TCnK8c6RYivx1GbIDtURNVCZTFUPrjgEA11m1BhhouedjnjOr
         ebHUbCnBiQMQjx5LzRVb7A8N0rwWUsbTjFx7w1pSSP2a+pa3rGJlNIfcYhJyr4rWGPp8
         zkJ65R4f5MYYxipYzH/s3xII+MM/czR4Ln4p2tTP4qCtPOcfx7dDJLMPC4BHGM5yNO4y
         ruug==
X-Forwarded-Encrypted: i=1; AHgh+Rq/9KBxM7kJbSKwsvFK/IfVb+Fnv2+IplWabbQJ96KDyLD9fr99RG0X/rQyH1iMseX8HbV/eokB4TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18Bu/v+5pKYI4IrZdVHy69KMFIpzvKUKtsh/c6Joqp25s+QHs
	2RlByn7uvJ1qKv5WEUaWy8fNyjz2LM5YFJ5n1LznNekNknNPJSGMmNPI
X-Gm-Gg: AR+sD10eup2PeySW3WuUkc0Xd6IZ9GwjyO8k9TG2hd6xPbieTSYRpD52tZsQFHN+Y+s
	t4CCVB0PyCMJzKJ32nrQxJDSyNj6lsu2wtxKI5Fe4fsA/OvRBEhQSMcFUt3Pgy24RiWr8R3a0yH
	43C1EHOcbQjRVFbEg4Q9ZYyZtb0bPbUBIytV0jXleVkemc5bWbMmAxWUNGLhaCczw0XGy8xob3C
	DOo8ElYxVP9vZbk2qRdl4Cdkimq+F6HdpI/JxyxNaBRd0yuYZoqBhQTEm1ImHQYNhBhQ27+Yqf9
	QivFO3ZqwnbDXIO6IIGb3J7nqQanHpxXYiyVDpbp93zm9lj6HbR3ZMeXmeejalA/tLkX822E9vY
	riyQHZmel/bNkWWDiuJLqWzPyjMUNEePTFqKdP+0cU7FoNxEXXFh1hJgs1/U/nPJ3eThRS5dMCe
	j/FoXEvCe0MjC9QfoX8NGRr0MRpZkJ6zuUt5TgVFmxZo3c+4OsZv+hpX0+BNGuZlX5/f6ffCXqm
	nTfgZyAbpYydmOqzRFd04y9ZJqBsmvv4PAdEXSYTCyUxA==
X-Received: by 2002:a05:6512:3d18:b0:5b2:991f:90d1 with SMTP id 2adb3069b0e04-5b448629434mr310199e87.26.1786439150563;
        Tue, 11 Aug 2026 02:05:50 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4486c0505sm158848e87.6.2026.08.11.02.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 02:05:49 -0700 (PDT)
Message-ID: <247b0e35-f49e-4bec-abd4-4a2c3dd49a2d@gmail.com>
Date: Tue, 11 Aug 2026 12:05:47 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
 <anovRGxtsyJZ8cO9@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <anovRGxtsyJZ8cO9@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 23:06, Andy Shevchenko wrote:
> On Mon, Aug 10, 2026 at 10:53:07AM +0300, Matti Vaittinen wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The BM1390 tries to initialize the AVE_NUM to 110b at the start-up. The
>> field location is not taken into account, and value is written unsifted.
>> This causes the AVE_NUM to be initialized to zero.
>>
>> Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.
> 
> Can it be FIELD_PREP_CONST()?

Can you please elaborate why it should in this case?

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
