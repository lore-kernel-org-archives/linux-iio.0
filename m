Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720344CF57
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208092; cv=none; b=NX1EYcxi2xgRFBrXD8QnXGHI+pUR3BRwLPvHIjmsUx8kNQqwGGVL5yqRLKtvRm2Fm2JFMNRk6MmdTGVJBi5PI/JNxS9RU4ZIEr/ycECTtFjChlc9s271xFCLQN46QgJLMJcYc6fcsI3y8d9N6m8mPthnbAUYLjpdvmzmF5obkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208092; c=relaxed/simple;
	bh=mqX00e9QqpKUg+RRh3jJF+qJ43RITeuZ7hqJgrXs+QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QigekGTZE3J3O+MXWpY5XDk1R0nS43VUOVcJMldUjmYcp4KFPQDuhzlI5f0Q0j+hnW7X7YWnjidcB/MKxd+alJpHXL+QelAPMbG87IvIUSYjHQBGsnnUH638A1eT7uu7YKUSFM+fXD99+GcyDQByLzhskDUfMEquAiebXkfCBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HLuzmuI2; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HLuzmuI2"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c3896e32so1164468a34.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 08:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772208088; x=1772812888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELIM1XoC6sP2e7/ym7kBeZvkexkVxufY/yi6CFO2Qxk=;
        b=HLuzmuI2HcGU+s266n+87i0T+0IZsffCHOodKrBHuiDs+mZNFQcv+qOhyv9GERLCQ1
         3PE0SGDHO+RrFMTvgrrNZzXo4MYDgJyayb870mUIctYQV3ll537C3chUBIJwKkrpKKoT
         o52ihGqNLGxFb3AWdPgOG1Va977TGeldCE6pQfP8qx2sUzlakjaNuDf0+e6lda+GtWAR
         4uHGmxsJBiFhEnfpA3PLiP4lvB32KzkPrE3eX2ltSj1d36SIt50uYyNmFKE40401uXis
         4Q2m3h+FBN/CI3Jh7SYoEa+7Eluh9VAg279om0rV4xM/o7KJxFPtdQjZcbKhuOttliCe
         mbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208088; x=1772812888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELIM1XoC6sP2e7/ym7kBeZvkexkVxufY/yi6CFO2Qxk=;
        b=wknA/jHfIrqSnwNanOFV/QT3efdPI8qBt9deDkD5997p5nvRrxw38gultGX6JVA/2U
         KXy2jBeQ/my50yw6kEnBw4XoHoTm/jLiuha6EbSp5WxsA7R86fhBCX33/19qfSmbEWOV
         +idwkWLMItVh0c3tvBoOA0w2ORp1/ZQmSFANi6hGjZRDUpt5c9vW93acgNvmEUSpaCln
         eSGBVr8BB76O973b1rFrwPT30auB/GbIX06BL19Vr5myHbNF3n5Etrw6+bGiTA04juEr
         wZDB5FrOM3rFjhcl9UbS9mUkGeiOnDh+qjvgCXYUerflJW9gSxlA0/XrJWdkyQFAVKyh
         CLfg==
X-Forwarded-Encrypted: i=1; AJvYcCXhiMRvyxiVP2KCiPILgukw5RJCewZF8oFgm0XPujQ0Vfm3T9WIZuAqmci3OD/tLOGV1QhULf0E2fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoa5CO7d4vuthabigfUWAdFOv2i5obJGl5eYkkhlMCRBAhd6OE
	K/SZO0zWbN5xJL58K/4rhY8HIiQnu5MSL1Dc0r37eyAHPYmK9Xcv5H33dyKdk5FQnOY=
X-Gm-Gg: ATEYQzzsUj8WzQBOfZ+a0YBlSBMIPzKbb6dWVDRpTUUdBPHKcQ26t7TuS3I903QQi7i
	5qMXijThLseVi+UkFroTRDjGVOSmhFEIrIu/ekNXNBLEGgFJbgM40t8IxJcCY6gxAmyt5ebx4UY
	B4tHt6SI2mND3LLAKt1PRcXXzNg4JvRLyuqIByg9hNrGaXKNyG+Ic3uZ4dzZqiU5l1obPoIPRug
	QMC+hY8VVXM4RmNtnGHNCVsW461Mge03JGLRUMnFpNz7McPIx86WbsTlziCP+xjD+AECoNZMUXT
	FvdsDLEdsO3fTEiiLh0CBQaUMBE4IWRNW+4lCfzxvTcLvB+0lsuNr0pE6W2F8rBV39UmDbZEZJj
	OAGsOC7NGfs3PJwBjAsYQVTD2lBgWwkX5nwoUkXcY7WMEBezdV+AnUlN9e+mx4/ShdPrtGqSFFw
	DqMPnrQKe+aaR3LyL2ZHHS7rcHiN12fYC4s9uJFdfaiWg56gT6Ubmo1aQ9FLRwAlRVqzvWfQyDo
	g==
X-Received: by 2002:a05:6870:3412:b0:3ea:ff22:3dde with SMTP id 586e51a60fabf-41626ec9ae4mr1759503fac.24.1772208087776;
        Fri, 27 Feb 2026 08:01:27 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:876a:e36c:76c7:e6d4? ([2600:8803:e7e4:500:876a:e36c:76c7:e6d4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2c9fc2sm4979058fac.18.2026.02.27.08.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:01:27 -0800 (PST)
Message-ID: <3c4964b1-9592-401b-a44b-22dace6cf81c@baylibre.com>
Date: Fri, 27 Feb 2026 10:01:25 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: filter: admv8818: Add missing error code
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-2-ethantidmore06@gmail.com>
 <DGPJFWN3WNIG.1DDAHDOZ7TTK@gmail.com> <aaFCWLknDa9MSzXS@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aaFCWLknDa9MSzXS@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 1:06 AM, Andy Shevchenko wrote:
> On Fri, Feb 27, 2026 at 12:42:11AM -0600, Ethan Tidmore wrote:
>> On Fri Feb 27, 2026 at 12:14 AM CST, Ethan Tidmore wrote:
> 
> ...
> 
>> Just realized I should have used -EIO for the error code. Will wait
>> however on reviews before v2.
> 
> Why -EIO? Is it used in the same situation in other cases in this driver?
> 

I think EIO makes sense here. We are reading from a chip. And if the
values we read aren't one of the expected values, the mostly likely
reason is the chip is malfunctioning or noise on the wires.
