Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541C3590D8
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771693635; cv=none; b=Ci1Ll6u25TW+ggdo++BW7GiHqocooU1Sa4BUNq+01+Ywz9KWshp/h22lTgeHeqnIBxyIJaFi3xGjD8kLtX3VrBpXBzdSfRZET/thNS/Jwt//NzbkfIxF4AQGp2zlHFpy7/NYRGTHrz3y2RuGMTrwX0qs02E7LR5Qm9BMcXrVyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771693635; c=relaxed/simple;
	bh=7hX5ObVgc+z5d80aOlRN7dM27T5qBFbqi0RU0q7F6FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC52Dk8aKYXFpm7Bx1Mx4faISP11yrjH3LXhxDLzN92r6MCBrRE76YcOPvI2rQMUUjqTTq7L5onZkMYlZwKbcCdz0yzOp2F554pn3WbaKSuKt44hXNWCBkug1EJ2lVImOXYbszeHFV6W2UrGmT+VyN1QKxdgJDLBVpjllEA/Noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sd7KUom3; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sd7KUom3"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d19d3c7208so2155289a34.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771693631; x=1772298431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zs4ezPRFXzZ0tFdqRXtRb0zbUDD8vrtMcp60HCD0xbw=;
        b=Sd7KUom3cu4nGKq8U2v3nkkTEZDsxEnpTwLGp6aPkkUODxb90c6rsb7WYwX8fXiLrM
         OGhXEdleHOTZCIwSY6oLFAAFdjntGRUbJ4Ropv5Y+8AUWDWIGBc3BqTe8wITc91uNQL3
         RyGzQyGOEGAsDKJ/McUjT6tJA9o4XTWD8+N0LFibvSnFjb2MHa2PMj3Si+IWhs3JmpYN
         JoRAqQSI1kaB8W4Z45ZC6ZxFtdYMdYxrOMZzOXk1AL3BSVQmuqbECoNIxRj7907G9fKs
         stvQx7EbMDx8Yb3JjS7gHelV/DK9DGyvCm2gIYXoG6g0ZNIJjw8qJaOGnAEkYbqwxwm1
         +jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771693631; x=1772298431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zs4ezPRFXzZ0tFdqRXtRb0zbUDD8vrtMcp60HCD0xbw=;
        b=Uwsrxhr8G95QzKtKsRb5rhIWxVy/5r/G+R1zMW8slgoiiSEnHT/eo44pvBqQmojB+z
         ZOvIegLve9dWvKOM1mdqoqFEfEaTEVgs4HH0X4/IJdBIlc0Cbm9qeqooDnxwO/UmDyjw
         UAxZUbzDMrADu09OB0Lcj0WeTvvpwkJ3nWO0B5PmmY043j8hKAAB763vnF60LZnv+DCR
         M1VGko3YZv0m5m1eIogzze1oXdBtZTIvB2XYD079u2JTwrx+3c+GhSBNvAS7pcmPFO9R
         qkc65R6J7pYq/oUGe0NGkZJLrgdBc/gzdMecGVJT2gIYbszJ7sJr0tyvUeEZt5tC8tfe
         dTxw==
X-Gm-Message-State: AOJu0YyAdfzETMk+nZh8oteL+w6dS8PyGWatZP3G4Ox5kSiMghsb2YOP
	96EKVIctzTPHnur6DQ/i0stq7aormTRhd//DsLUM0RwkiQzyb2pqNP8GiIKAifM2ioCAR9ZS0pN
	q5iYb
X-Gm-Gg: AZuq6aIqNsJijWNbbT2ja0R47p+ReGatLmtsUv1veJm2zMjTdezjYtCxKaCc2nOuGYJ
	3XvgqVkLkmlTH5KHKEbscZLu5KZ1WXGOE4AmRQH2AQRNm4ytnqeWeLpyN1tliYam90O6GU3Te1A
	OWPAmLdD8PZKoUAcselce7kHV83XR8WdEwF4NExc4aqs+4OEec0iaPuGl25qy/wC3GeuvbGKTiA
	oLYr/QsOg4urUApDl3DOldrLTqdiS0jh7nxCTZdO2Cuso1tH+p4tanjDGFnzlAhXjRU9Kgg0gCp
	aeQB8n7w1z2r71jVfD8mmeIlyvPHfe2WBtGDq6PMQhcxpe4vNZZnqOfOIZaislAJ/cmVTOS99GZ
	XbvS9hsBMnUC2EqeJ8lw0LdTcY21YpKe+1d0VexdjcfdLnn8PJZ6mYwzUAFAnRLjrEtGxaA4He3
	JUlKZy/ohFrRWXkut5+hC3J9CWnS4frjgOXebNxBcLni5qlO+bZWgVOZfv8diEmXzWBaWX3f89D
	9Ms6rbq
X-Received: by 2002:a05:6830:6a92:b0:7cf:dbb4:320a with SMTP id 46e09a7af769-7d52bfbc92emr2199243a34.27.1771693631566;
        Sat, 21 Feb 2026 09:07:11 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0725b9sm2787850a34.26.2026.02.21.09.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 09:07:11 -0800 (PST)
Message-ID: <e49877b5-2a8d-43d5-9f8b-de37cde9cdcc@baylibre.com>
Date: Sat, 21 Feb 2026 11:07:10 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iio: core: Clean up device correctly on
 viio_trigger_alloc() failure
To: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260221073301.105080-1-salah.triki@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260221073301.105080-1-salah.triki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/26 1:32 AM, Salah Triki wrote:
> Once we called device_initialize() we have to call put_device()
> on it. Refactor the code to make it in the right order.

This could be a bit more clear. Something like ...

Move device_initialize() after all error paths in viio_trigger_alloc().
Previously, we should have been calling put_device() on any error path
after device_initialize(), but failed to do so.

Rather than adding put_device(), we can just move device_initialize()
to avoid needing to unwind it on error.

Additional trig->dev initialization is also moved with this just to
keep the code organized.


> 

Did we decide this doesn't need a Fixes: tag?

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
No need to send a new revision for this right away. If Jonathan is
in the mood, he might fix it up for you.

With the commit message improved:

Reviewed-by: David Lechner <dlechner@baylibre.com>

