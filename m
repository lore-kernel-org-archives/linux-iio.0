Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE32D593E
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672008; cv=none; b=EdjL4wr3DWI+Ze6x0O8w15YsFnVCV5DYtU21YRqY08Rc9xq+6PAMUGNTPlbU0ZYQvB9kWuC820axusCSzXFfaRojkxy9PoSbfTrFBjsK6IaLx8L6xrsPsu1Uv3em+nSNQm5LhM4P4jbHeVHoq9itoh1qqAryDe7sFKS4DawvXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672008; c=relaxed/simple;
	bh=vEYLEgxSP2lKTubzSOozjBJXghbkFgCp32WXaWPfZAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rf30roIHlELP7T3C6s6HkcwQxz8Gff+6w0ophmQgwGWivThIUjMX3TYatjm5ebh4m44Sbyx4p4ttR8KxOHSEj6UDN9P4nvMZv4hsH7v7lYAO48qXpiCIYOlLoSLlJHFMpnFzRa1VdYIvs60eeb4KcL6gr9/cbNN4/lNb4wgArQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kE27gOpp; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kE27gOpp"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4671cbce2feso1950479b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773672006; x=1774276806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TY2FRwYMmIT8/sc67W9gdAYCf1hET0rE5ocPkZNHes=;
        b=kE27gOpp4Xyaf7htH7N7ROdaN2s700kjqB4HL3s9GvyvPOcdco5tX2JcQkWzWU86U0
         gqI0/NCtYGkT4A/Q62jHY3ly3nqRBQLn/2DGDkk1w3moFsa6bM1qLUs2FsCHb6aMigk7
         kBGU/YpYwXqz+87AAOv+kltnQnjBUwVfnMrhQq9IoU+KaC/J/v8Li5mhmKPhfDlb/FGz
         MrsJ8O9V6h44AIXOVaaJxxx9kFQv3a8KJpcTsIaQQZwVbJpoEHL+qgrf2W9OblPwwbIE
         K7Qt8LrSsQiTzI48aKtXT07QGbl/9M3oYVuA+oDkpcq0UW8dQ5JAjscucM7vEl08Oraa
         +YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773672006; x=1774276806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TY2FRwYMmIT8/sc67W9gdAYCf1hET0rE5ocPkZNHes=;
        b=eje4tXS/oQ8QVnKCw6smVG5WKxW2/XEBu2DEh9pFsiINcsRJg0eXArOUFK/Hx/cILu
         oBuWzk74gy2+6ch2sYCU7CBV6QCzn7sOOENIrGy2crRprTfnq2c0+QgMm4juvyst4vbM
         IVS8ODbmHltYR3NhsxsSt6LMGr8mwZICpV26b5C4VIgtSSJN0ElzTikuk7gku9mNBW01
         P/XrZUfPm2KdaxY4nbxH+89sCrm5idjAwOsyfeQS75QaeSPHveaE5guNoUv9CTnNpja+
         SHHNIF2U3jEKU7ho545c71zwiwgYPqLzD49PzzJavyeoFNp1FaPABQW144McfUfh5yuM
         4C+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkTXYvJxRb5jeh1rwdLmjPbRNUI91g3YUUJQzqVTYfRTcArSo8LczdcubsGZfX+Z0soG12KcTYdOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFq7h7wbwGd2BozXQqzK/As3rRt39LO79L8tkX6hsw4vpgP1Nw
	J/XjPzZH29MV9fV6hRFdXbr5y+W7wg12xWB3atG3ABOD0wqwVSfORETWgYn41jeiJWFD0S7w4dl
	4dvLJ
X-Gm-Gg: ATEYQzxlXovrbKzd6toPGYaYmCtxCi52v8KNLMfL3YKXAQnGl8sV8w9vNw/zWlv2EoH
	AF2D7hineHYwVS2c82pC57x7VtZM66XxIaO8o3+CBjHGdoAmTdYmIxZeJ3xhu58D/DxqE12FyGz
	vqE/6mwyP+l+9SODyO5B8z4DOfEp/J+3eKxa3mHq9gd6EykMtZTzaM4ZiMCu4Ql9YwS1qIAtfgO
	iKH4qQNvMlftwVNagt7eaShjQF2/2w69vqF5YtaIS7XPNCqONEEeKDf9rHqZzuoHVj5PobF/Axy
	QxvHmhE1lDgm0CInw3oPrYMqFh/F/RRccudY3NAlccZ63bSdYM0azUCiLxLIAbXadVB5W1z7I+f
	NBmOEg0o65nFO8UBna5vvlUa/tjQ+n3QeyNQCfrZioh0+MI5EmLr/Jq5Fv0V4tkddPzB6f64EVp
	koiuVa5d+AlFn2vr+glBp4txzS7YLAxndU3wbbhE7phrmWL2GauSXx30OxpO1pYqdXhyLFtxvae
	w==
X-Received: by 2002:a05:6808:1a21:b0:467:13b5:8ae6 with SMTP id 5614622812f47-4675704ae1cmr6692339b6e.4.1773672005878;
        Mon, 16 Mar 2026 07:40:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46734340842sm9561589b6e.18.2026.03.16.07.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:40:05 -0700 (PDT)
Message-ID: <ef64fc38-51ff-4785-8b50-22f9c7a9683b@baylibre.com>
Date: Mon, 16 Mar 2026 09:40:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: vcnl4035: fix scan buffer on big-endian
To: Markus Elfring <Markus.Elfring@web.de>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Parthiban Nallathambi <pn@denx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260314-iio-light-vcnl4035c-clean-up-scan-buf-v1-1-400d273eb026@baylibre.com>
 <06cc64e8-38e1-4940-b129-75c74b7058fb@web.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <06cc64e8-38e1-4940-b129-75c74b7058fb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/16/26 5:42 AM, Markus Elfring wrote:
>> Rework vcnl4035_trigger_consumer_handler() so that we are not passing
>> what should be a u16 value as an int * to regmap_read(). This won't
>> work on bit endian systems.
> …
>           big?
> 
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v7.0-rc4#n34

Jonathan always adds the Cc: stable@ when appropriate, so I've gotten
in the habit of leaving it out.

> 
> Regards,
> Markus

