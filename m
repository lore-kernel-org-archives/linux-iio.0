Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3931313E1A
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073300; cv=none; b=EHF7eaFONd4NYHRB+eTB8+SveEX2lfNnzJcZmL0ze9H/HC5/2zU0nO+18SO2m94HXQ/dl0ajY49H6QYSqx29JQFCpv8ddeMoj8AF8FO4k7134lA62duxUGEPcLPLJ1cHTvE6rDqOAPL797dwdiCNfa4PME9XWiq21j+3bpzCPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073300; c=relaxed/simple;
	bh=Z6GqiyZap0TxD9V8wqrG7540asWNXM6u1cBE0RODAqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvS/Or04jYoYw98Q4kjlIFUPv8AJAeoh0/q7L0ohweLoph6nN2/xT/NTLXnJmPn1RIwggKuNgJCCZw/cZkfFt0SdEKqZYBAP8R28doKT11COrfa/YwhOkMgjr80CzDEL+cZN8SLuVZLKNq28/FNdXXIngnK1G2DVRw2f3lgIZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gGGJb/lb; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gGGJb/lb"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45f04f1348cso3068663b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 15:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770073298; x=1770678098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCzpKsUtNwK5udm8CfpcSaSMileQmrqYxikfvGaGy2w=;
        b=gGGJb/lbZHxEdJf7JMnu6796aYjujU4HwxL3l+r+e8lg6eDZVjT3W2y+o7/oSCW1rB
         7reF0434HRIYBG8zkIIyMmB8jKV7hZuZePZwB3xuxOCWTKz95ed6ZVIiRzOza2AT87qB
         w8ivnNWqsKPVH6142JZXxIpAvEZ3iJU79O1SE66FpMY+kes45/I8oba6VS1zXXWbHoYY
         VnPgndPSV4YFodsDHtOQsRgA9DHdB2HhEs/OZMYzmAs0caQjE3nSkMiT3TTsZbwvkjIj
         P2KP+zvO+TRh36iVpk6bcGxun098gCi9TDpDsc366tYS8rHlLk+h+KEmsLE0R3KeXhNS
         aasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770073298; x=1770678098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCzpKsUtNwK5udm8CfpcSaSMileQmrqYxikfvGaGy2w=;
        b=O7Y+CiS4DFT3DN/XuY72I5MA46bDGRXkUCil8flrfwYgne74o4LP/EmA4gD9qt9I0+
         wSgJuLG01BLY+A+t1A/vZtR5j3b7Gm2YWuN5S8mp4M8QUAuEItFyAG32cgTY1xyjSe9A
         PH1N7P6PP+QDPK0l0CMXd9kxMfYK/g9urcz0z2KTN7c/2nSGfb61FWZ9Te/8EB6vTWHy
         YwhYxRRwSXKk1s7V2fqhEK9TmKbS4x4rXOtcDI2rCjG/x7WlYqp7ZHp/M8sXLnF9GYXt
         SSWXoBeg13j/eEtu3ArIyfJTkbupl7mPnsSzUWjSRUw2C3jVslyC1BquiMr1PSR+HXjg
         S+ag==
X-Forwarded-Encrypted: i=1; AJvYcCX/r4LWFciMsm/MsE1G9ExXJFfQ70u2O3y+OBZctWtBJq/13D4gPlQeX4+kknqiR+65SLx0VHHat+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxnoJ7GyXhn92HDff/fHmkj06be95AIL5+azTkkxWmCsbb+9C
	cw/wnRPNsk71lAYcNf7Gm9fwOgJvGkQ7ZBpGV1qcJc6nC/bRURz0uuetDCznJOyBRyJyfKCtPRf
	Yqek4
X-Gm-Gg: AZuq6aKlR5hxUkUhNw003JGAC8l2TVA8dMf/Hmpv/b1bJCEzs3JBFtR7tZr0E4GMZtz
	8nv7hdNJWIcjVys5x47ykKC497zx74yp93Wln1hhw3qtg6OkfJZ48jCCC54loYLZUDWbfOot3rV
	qxFQKpBR1d4CGGt6ZYcuY67NNGh/PFi2eohdBYsfgwijXcMgUkBzm547SzqEKXVICTIwLHtEOZ8
	1yuPmUsHS2oMquj6USAWhm2Y96yLLexs/2vG17j7iYLI5TCBq70CJN3XXgDW+aQ3mTZgJ8icH58
	k5o2CTTncYGM7or5JoKfCLOcedXf6l/xMcIzbHdihF5bh0+5YRH8KmLPL4DLTEaf4S3xj3ltlGw
	bWv//UQlvEBM/d3w2YalY0Hg6bIlnvTJTV7fvBO6BRXeh1m2oFS+t2f3g8WFI/K3C4ZvdXi1YW2
	jdQeb1DXTHOzXUrKX7a+G+1d3IRGt8dX5/SUovb/ncKKe8ANxrY3ctL4FpvfG5
X-Received: by 2002:a05:6808:1313:b0:450:d0d8:aed0 with SMTP id 5614622812f47-45f34d0d02amr5853054b6e.40.1770073297618;
        Mon, 02 Feb 2026 15:01:37 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08d894f5sm10614525b6e.5.2026.02.02.15.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 15:01:37 -0800 (PST)
Message-ID: <38793c4d-e79a-4896-8b25-e20bc8ecbb74@baylibre.com>
Date: Mon, 2 Feb 2026 17:01:36 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 1/5] iio: sca3000: cache SPI device ID in probe
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
 andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-2-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202194033.627967-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
> Store the spi_device_id at probe entry and reuse it for the name and
> chip info instead of calling spi_get_device_id() repeatedly.

Even better would be to replace spi_get_device_id() with
pi_get_device_match_data() and turn sca3000_spi_chip_info_tbl[]
into individual structs that are used directly as the match
data pointers.

> 
> Reuse the local dev pointer for resource managed helpers. While at it,
> reshuffle variable list in a reverse Christmas tree order.

The dev cleanup sounds like a second unrelated change that can be split
out from the spi_get_device_id() changes.

