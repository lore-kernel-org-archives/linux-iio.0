Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7237A481
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045124; cv=none; b=g/UVIGcBeFFLazfX2ilKDo/FYUHgQlD0b3SmgCvIqL8C2ISjeqxCtTy1RLusEHJSOvVuOG8a7y9h/TKT0ZTfQ088QXme5XYTS3mfACv5Dj/vkes2GET5meEpxSNdxgq0RuKY6k2IsEOhyKwQKsN0gN+9YQi0sPHZQcwjQdbHhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045124; c=relaxed/simple;
	bh=pCj2ne7t7DkFEsf1NLDwuY6/314P01aVxJWXOtIFe5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tvKY/QW785L9cTInb2z+WZjzGyLVhFzNIRDcCg4Q7j6jwTgw81pGBXM8zDHble4Vo9GNEx+MyQCXih8ehiwDZDKRKkC3vvp1BmPl1LyTN6Avu3ugoLKUUKLFlWC3Sa2OJNyQw1JS8bLRLbhLnMhUMbfuUQfGz3ltMEI1pMazGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qf4gS/Gf; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qf4gS/Gf"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6611c3b147eso3290587eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770045120; x=1770649920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=blBZowIYxmGQt/qp8Zqs7qxe8LPuadPVWAo6HXJFncM=;
        b=qf4gS/GfJ0EpE6hdfJtK6zpPq1hQVklMD5vt3/P0jG90UB8R4dLyxwHjKIWaXNwX7v
         KVZnmG175E2EGyZ2yelCCY9f/L8pMQ37u2PQM6Ns2PRDb713O/Qhf2t1mCQTXyRWfHPZ
         SaWL1RRBukFtSDGrt2C7Dv/5oUe8h+NXqNICIyUjC/eFmTootZirD+72NlIGk2Soojaa
         xsmkRfcsT98P3I2in15Le+rcwuzfoyyV9xIAg9fiVwIPTppS9vFZacTHJbrZRNHKK5I3
         uv7xefnMP2e4P9qwprfifWv7q3RJ3QKKHjMfLy6372JFmexS0m3ksWDRGO07n53C7P1x
         ZI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045120; x=1770649920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blBZowIYxmGQt/qp8Zqs7qxe8LPuadPVWAo6HXJFncM=;
        b=qhwGRuldf6YxLdDpD92Yt/cQS5XElZ673BRXyE7nPrRHk5nEFq3wglKmn6M6m7qcUh
         EItWs9FeSnE3NC8+jkfYoyLPIS0wi/E3O/4pByQYjtoLCHt+1i3HhaKAYJtJ6geKEeZM
         eey5boGgAqJqVUt+gWlfKXgLacyiZQJIYs56aoN5OA6PkH47lxsd4BlqFB8mRv9lm6vo
         xeGaQ3Id3lQpuMCV+ohSDOSLEk/5tLewvj3Y/8lsjCtiBNYJyK+0MoI7pNYYrm1dLBGJ
         9ftPmrko23iE6Vm7g6IC1fhz93dN45WFZs5PvofGeQMRQAP5gJ9PI6eQ2lSCgaE6SVrV
         ksSw==
X-Forwarded-Encrypted: i=1; AJvYcCXOSYxKmffwoJpZ0ow/dmZa2ODMBhczxXA5AbbBTdDA1+PkWdcATFjXwQdj0WA/carxVGPlKkvbf70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIXwqd9cWnNx59t7I92DzqbL/cBqoL4jwih8oFhx/aiNXNFkk
	L+jIpffy7koGzAwHgDa3Ch0YfTPjbXoBsn8nDKOSwj02L1t9p0DuOYCartVz6CEZwyc=
X-Gm-Gg: AZuq6aJ3fvW45oIbkqK7FwEpqTckGOY6+iYHEFThiTYnMIrXhUFilrd4GmSLOK4Ewxs
	rHV3J/XHjNFcUYHDjLHwPqhAitRt6FC7/ApGpe1bL6l4FPqt9p5rbbdfRKkdBdksoiTVVPO2byo
	BWIzTZkNWhLtXoHQKCqNELXD77NxaBPr2zIxWpCrcLa/b/BHk/yHqjfIZyOVu1/wZGUurCG9io5
	aaZE0930oK+hjZXkMAVw5Ov1NomsQdPL+X7seJuvYm4MsVAsEr5CNLbFyeMn5gfm8VAr8CYp6JS
	6jjmjH8275ldumZSB9AAZHdGc9hGkLuZAnw5+0uQNEAORivLg2XkQLFptDgs2ITbNOfRtzYnVPm
	06n0JoupHEe1w8fLkv3kkUkjbn8h4KiDidU7MnQbjdZSahE0pgSq85TYwIkcdDPvXnwC5lpMsG4
	EXjuqIlUyZeL+dmVqkBZ0x3PoqLn5goBdAu4rGREP0iZ7TADd3RmkkEkmT8jFqUtDNWrAabq8=
X-Received: by 2002:a05:6820:1621:b0:663:c86:e9e2 with SMTP id 006d021491bc7-6630f043bb8mr5049423eaf.35.1770045120281;
        Mon, 02 Feb 2026 07:12:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f99447b5sm10006110eaf.2.2026.02.02.07.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 07:11:59 -0800 (PST)
Message-ID: <01eb6fc5-4a71-4877-8a62-ef397a1036c9@baylibre.com>
Date: Mon, 2 Feb 2026 09:11:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: at91_adc: change at91_ts_sample to return
 void
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260202115733.21382-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202115733.21382-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 5:57 AM, Antoniu Miclaus wrote:
> The return value of at91_ts_sample() is never checked by its caller.
> Change the return type to void to make this explicit. The error
> conditions are already logged via dev_err() which provides sufficient
> visibility into hardware issues.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

