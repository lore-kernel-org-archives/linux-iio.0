Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A513932F4
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673132; cv=none; b=bo9npDiKyhyRGaoZkU6tITW5iyaa3+uyOaF8tRIrhqV1RJHtspDzeyG12AVv8t+59RlI0+Wv1lvLaQ/rspoYeJgRqxsvcb/xlLa3v61LOQ4AlgB+SbR8qkRqEYARwgfF/hTNLnyBaCR1p9OKgMQA/7FmbU6oU9p4rC1APiUULiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673132; c=relaxed/simple;
	bh=J52sXQFy1d+pN+ZbLoCpmzMDgrEsc/3CaV7dc1H96XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq/N7QZeHU9RjOQFuuccQNk4mlKj1gEaDmooOY4Ul750vHibTval6AEQaOfePtzuDj29TFg1mWiz13pLPX0XnLD3e3XEYji5gt0PO1tWbkKYUH+8q2G6UY5uWSVvF38Gixu+wP3ztFq5hN4fPTzBwrod3bCe1cDTuyPfuFKLFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g0X4Vq4H; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g0X4Vq4H"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-417c34b0509so2125280fac.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773673129; x=1774277929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6W3ta1EmaKi/KvddroOldqnVJ7a0ddbxWZg37STItE=;
        b=g0X4Vq4HfQfcTUsBD5w7wjC6Maacj3kIix+UyiTsc1IS7zAg4CifEJeQz+9+z32TxW
         BjR68xhBSzA6cFnOsllxIH1xdBZUWCkaGFrbVCsKxcsM+ZHDt1gTOI7ystn1bDxSXM5X
         2PZOo7zzLHs1zWGU3hl/NKWMTaLu09Ahp4vpjoCwlw3XEVtff+PjH7/u/ZDLl2PKe6gF
         P2l7SRTsQs4vGtwdUkmP/f+hRizE8JbRJX7kgbmtMqj0N1X2vnxMwcCba+4FMcOpOdpw
         cG7bOMgFTsWhANRLHtOoom9XYyMfGdhrQ4Ruio8Zj7BuSwqcnOt2hTFQivR1tlm/INqz
         kLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673129; x=1774277929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6W3ta1EmaKi/KvddroOldqnVJ7a0ddbxWZg37STItE=;
        b=WLd0NVXTrPLSudZVEn+KIv/K5LS0NlH+45XTJ4Yopb8QHcE8lHhxf4iqNhvoMDDCdb
         r6qvbzbV90Z28MJwYUKffXT+2KjflKuxTrXTRHp7O7wqvbdpTHmlS5NkRegHFPc+UAzv
         UiAo7E+c0Oe8WvOMOuaFhkNjtvfR0yCoWaoTaTInw7EZ8Yw1Nsl5elAJgSaKyTVMlZf5
         5UgCkfEglf9l/V/x/kGYO3JI50L8onyRzA3mzwP0dmmKzcE+c3AX3WU25wH2HDMw6G8H
         2MIvEv93Dd+k5EtLueCIce1Z/39IBK72/sBHPo+SRnjlvSCo8M8AUyCNJA3FrC9p7BG5
         AEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA9JQ38MkhJfnteXOLI803IU5kas1hgsSD5gzTksFZ2Nv/ikrJ14cJXNZkl9SnA8+Y0rLf4Ky/qoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZ4JHhgZN1RLc9kUmrvir2asX++xb6ZBUwCyLBAs9dZdz+6aX
	jurSDPlF/Do4gfG8E36v//QcZrcpnqAY14HsmhZVf4SC1+tBp8X8szduHX5UD+DXJkg=
X-Gm-Gg: ATEYQzyiPLv03lETbD/9/gmJhEi8nLCWKxMEJrm1+SLOkj6qePdYWg56cgz28IXnhhG
	ysVnwHXN30Dbzd3IZCuG+9X8dMOKYSjzhVHLNhBJci6S+4TbLQzvFcRPZtZFjz1LNiNV1Qd0RH4
	i0iS9zZvkiioL7n4UZSkHG71WKXZtB6h7x9FzCvWn0bhHjLoWIyjN2JcizzQOHhwxI9XgjVDc9l
	/nKXXXriLVLJvr6UlDUoznjrQ4/Y09HgXBchcR3/3fHWO/tsFgyajtEvhfnmQuaoGH4Ese9WeFz
	y6f0bvW4c18ALN+zVM+GvymoQG3qj3u3uIz/NeqGyOrg6BeFH2goXYoRZAiEKbax0JFz5iquJcQ
	4+clHw1nv0Dnx3pamnWymyPiFV9pWZFIfbYkexhei5pbVuB4tjce+Tls64pkU2RyGRE2lOu0lJC
	gMc3v9J6YWbkr88YhPhre09gXbZ2Q40Z7iWyHXNNqZl4bGGCkkApk7AQoEMBl+2EHkrUwILycs2
	w==
X-Received: by 2002:a05:6870:44d3:b0:417:3c76:6582 with SMTP id 586e51a60fabf-417b9174e0amr8669148fac.7.1773673128824;
        Mon, 16 Mar 2026 07:58:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm17421386fac.16.2026.03.16.07.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:58:48 -0700 (PDT)
Message-ID: <f08de112-db5f-483a-bfb7-9e928c3107fd@baylibre.com>
Date: Mon, 16 Mar 2026 09:58:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
 <abfpAcN3qDKe4zdd@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <abfpAcN3qDKe4zdd@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 6:26 AM, Andy Shevchenko wrote:
> On Sat, Mar 14, 2026 at 04:12:24PM -0500, David Lechner wrote:
>> Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
>> when writing the timestamp in the rx_buf.
>>
>> The previous implementation would have been fine on architectures that
>> support 4-byte alignment of 64-bit integers but could cause issues on
>> architectures that require 8-byte alignment.
> 
> ...
> 
>> +	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2] __aligned(IIO_DMA_MINALIGN);
>>  	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
> 
> ...
> 
>> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
>> -					   iio_get_time_ns(indio_dev));
>> +	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
>> +					      sizeof(*st->rx_buf) *
>> +					      TI_ADS7950_MAX_CHAN,
> 
> Hmm... Wouldn't this benefit from array_size() macro?

I don't think so. This is a compile-time constant. array_size() is
a function that handles overflow, and there is no risk of overflow
since it is a constant.

> 
>> +					      iio_get_time_ns(indio_dev));
> 

