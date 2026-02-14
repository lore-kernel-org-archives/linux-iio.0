Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D329992B
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771094176; cv=none; b=blauHnniobLS0j2CAgii9pBCerDk+RmJVNTl7NtiVIRgL4+amBkTZN4xzK61TJOr19MuFc3UUUuJxlH2wwgtpOgooSNl+uL2djJNxB8DiZd3OWCR3A6oJ7G1fMqtVrCNyRGjysPNL7yopFwKAWSXMjqsVeWpVAaIm0yvJz9yR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771094176; c=relaxed/simple;
	bh=x8Yj7Q0c68ZMZ3ZvqB26h8g0lDn4W5MGUUK7ijQtFCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLUUyDYoDwq+hQqVGxRUda+H2cL5l2nVv6ipS5lMobfKQv65DcIR2HsPyLe+LfYJc6eZR8zYoTAqZM0rS5cvhU4VaPhXfCXgyujnhrkm8ns/jz9M5ByICyACVmGppJj5P5dk+8VwtBAT8V5pjwCleTDDPAYd22jpZiMo29pnOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CPz2SDrK; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CPz2SDrK"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40ed9a23aaeso646985fac.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771094174; x=1771698974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xp/G6UxSOewPZ/dZenFt7c0qcaCzMyXcTcB/83ucCM0=;
        b=CPz2SDrKTJc5nZdhm9H7K/yb8RpljaC+tRsxKMnPJTV7m06ifuj/SmLZdelISBNlsw
         9QRGPV+aEehs4Y9j6gel4t/uOH1lkfPMB6urHMUeoKq17WCgbkDCLmj6ZSXhDBh5JcWO
         1KQxLjdICT5yRtSoPLMMMwElu1BK6NUKmtAzQ2GeABv4LBQrvhHt2otZ2eGp7naKM1Mg
         qMogZOAsreEsTvziUjUJTmTiE6jpRb1ID+LHDNRn1jdct8YEErFL8TjI0IW3g8/NlYUz
         iVSgkU/VHc764NvbP49HxHcKlxZ7LV4tSHxBQwbnhnqArdkliUmP+Yhm34543Iul778A
         65bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771094174; x=1771698974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp/G6UxSOewPZ/dZenFt7c0qcaCzMyXcTcB/83ucCM0=;
        b=hDUJMPodXbpsJlTY/Qvw+g5/T9sqKNEVJn7BmwpVHg5dye1WQ7JElgYHA7ygtRltXB
         RcDkj3uISpivc6cmtM6c9B4+uBw4dcK/Nz6Mr6Gzk6P5SRl2SBzbhYm+kbCrSAw6o7aE
         z92hQsPByRDa+1CObYO6oiWCe+RNjBuJavE/gn6GxCInNr5OsDOYh72SC4ngl8i+pZr/
         qp2Mdg9oI6lZW7Al6VYCk/8BnlOGuV8zguS7AwiPJSq2cB1uzPUGrwurnHotaYIYVkpp
         AKMJ8T1CaBq/Hix7mYC3QzWYgx/91i7w06SfkrQ72IoJNJwD6dtP4YBhxvatIN/Xyr4g
         FBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfXeo3wbgxdEpNXGyTwzDalOFhAUsPpW0bpQfvHfLKPM4yIKR1LrXZRKt5+kbYttVQ87iMg0QoSBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkthfNpgyeoEbeu5R8VwlYMMWfJpCdFu4ju42lpWUDr69onbUx
	gA0hwlRfhZKUZ/mYxLeCoVRJ46chT88i6H/y0UZgHRuXjT5kQB6oiJc0oJVAi2usENY=
X-Gm-Gg: AZuq6aKiSDzV0tWBiY4Lk6eIGy9hyvO4DUKgxp2hUD6az3VZWhDdPyBadc0KN36XWEl
	vK0cUAkvH9yZ8SzLvX+KMQgJluraSZpNOnJpUUSkB8JNuQ8jNSVOb9m+rTaYWctRRQnL2lxNV4t
	kXViyFeTEwQstIY6VYRDtF6Ex4IDLJLl2D4C45giRYl7EOTOr4l7Toi2MZGQwQngHpmRq4emZpO
	/r8sRWt1vKG0xsJVTETc/vuDPsho5OkyOPF6VFbi3NC0dS08hMbCJ5CjHA6hX6EsTDr2grA/lzU
	zVTwMtgmNTt4uOWGPoQz0i5XRj4hxHRefS9N7JDxT8nYke0C3+h4rgPUox0XKao3xLDRIFSnsOO
	fSMBTOTZ6aUFQ0Z7eJ7rx31BXuLgw0Jpwq/NQMuVjYFDSyJO6ljsiompwQTlStJe96rXm00/ktO
	GQn6JhDolRgkk0quHogGZ43UlJ1JD9HxwyjSOndI6Fr33qe0Z+mApkUox7+EredtHSwnNkDA==
X-Received: by 2002:a05:6871:28b:b0:3ec:a08c:9707 with SMTP id 586e51a60fabf-40f0d8b9548mr1662215fac.42.1771094174364;
        Sat, 14 Feb 2026 10:36:14 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:109:393c:254e:962e? ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaeeab492sm10045095fac.5.2026.02.14.10.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 10:36:13 -0800 (PST)
Message-ID: <ea759fc8-6664-4838-872b-c393424e4cf4@baylibre.com>
Date: Sat, 14 Feb 2026 12:36:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: max5522: use
 devm_regulator_get_enable_read_voltage()
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260210175137.44178-1-antoniu.miclaus@analog.com>
 <aYuIftCDo5O0IF9F@smile.fi.intel.com> <20260214182052.14c6f8ee@jic23-huawei>
 <aZC_ab454PTqFPsO@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZC_ab454PTqFPsO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/26 12:31 PM, Andy Shevchenko wrote:
> On Sat, Feb 14, 2026 at 06:20:52PM +0000, Jonathan Cameron wrote:
>> On Tue, 10 Feb 2026 21:35:26 +0200
>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>> On Tue, Feb 10, 2026 at 07:51:27PM +0200, Antoniu Miclaus wrote:
> 
> ...
> 
>>>> +	state->vref_mv = ret / 1000;  
>>>
>>> "1000" --> "(MICRO / MILLI)" ?
>>> (yes, this way with the parentheses).
>>
>> I know I've argued against proliferation of the X_PER_Y macros
>> but this one does seem to be very common. Maybe it's time to bring in
>>
>> MICROVOLTS_PER_MILLIVOLT even if it's longer than the open coded version?
>>
>> Andy, what do you think?  I do worry that people will see it as fine
>> to add many many others if we start with this one though. So maybe not.
> 
> IIRC (sorry, if I am wrong) it was you who objected in the first place
> and I proposed that from day 1 discussing the "(MICRO / MILLI)" approach
> a year (?) or so ago. Answering to the Q: I am in favour of having that
> definition.
> 
>> Anyhow, doesn't need to be in this series.
> 
> True.
> 

How about MICRO_PER_MILLI? Then we won't have to add a new one
for every different type of unit.
