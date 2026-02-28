Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C192D97A6
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296572; cv=none; b=tTEL3X5O89fQramkDl4eozgRsKYzKQ3UNRPrw4PHizWnXx1o18wDTvcrSQzXN1V9mOntzswJvGQQEbnvXzXOMdaRZMyfOuWejPwNXcSp8XSTt/YDnIjodnsqPX3P/wkgPsvV/oPYXaHHadh98HLMwydSo3NlCWPjDzZ05s3KgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296572; c=relaxed/simple;
	bh=4gcfGObXSx3wVEtaxrRj6nkbe2efcioVYFA7FMCSXl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFAjEz4ycZkmguPlQzUdrJi7AgUnjquzpBlj0y6RxaoP29ljB4fFdmi4PSpQmhryIPsLDqTw7xx18VQhwqZHb37zxuTgC43AnL+OWA1e8NeFwtS7l0w8uXtSMq91UAFvkmnhpZSjWd0DDozl+4fH9E6b6lG2GFjl9OT42aYqZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cMMoPEBP; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cMMoPEBP"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c68f0e47so1944717a34.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772296569; x=1772901369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5UAYUNa8P9OtlEZx3C2SAvKtXQXXGGrC6y42DX/Yss=;
        b=cMMoPEBPoWMm7KXarrGWLJyHBN5ga7+TJNxkz6hcySewOdenEbsQzzx4O1UzAroHZr
         sBQt9iCrtOxTqLSjAKYwWZEZXJLt2Pou/4HQikR0tchpzoklsxsKJG+ySAyAYF/b4Wrr
         OYrywNmo0YmpLHgzyHf5/W+WRc1lJHvmCj4+PVpnQ7jT7SRjH0GbwEDCLq1lJ4x2wi4j
         yX/nJ7HDZjWMDx3vA1X9fvtmIkMMNyEHGBIn7ZcRMjWJLrWK2aEuJyAh3v1gu/7e57iI
         kcWxLoKbA21dJuh+CM2roABQZMqsKQTbkZ/y+10jvXMudJ0tM28V7X4VbCIV5B4y62s+
         cg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772296569; x=1772901369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5UAYUNa8P9OtlEZx3C2SAvKtXQXXGGrC6y42DX/Yss=;
        b=OnPF6R+I37Ysn6W12PF+ObRwPM7gIumwE3C2fQtu5a1GrwFW2awtSrSHIOd8bQ4CcV
         DsOoCXlSm/MXkEFaJ/Aem0L1Bj0lxdPdqREqWFBTq/+filaPEC2wEGZdA+acyDfcx+KF
         ei3HrGw9OrNnebYIKNxmGapFUZpO/PAwawRqEqr+wUjuj9aMUcWXEUqQQTYEZQQ4GBr3
         xpYavaxon+LK4XDoQ9/9EH6ax/P6ZUQmj9OLg57x6HeHIvLuitYU0PBuRi3QsLLLJjRS
         5peo0sYTR1drXV//Otnzk3waglFdvy84R/ipYchGZ9Of5seFYarbzCrm9Ws8vrp0J/yE
         VwJA==
X-Forwarded-Encrypted: i=1; AJvYcCVEhuIIGqNGN03/Cu6mcUFS7gb5SCIqpZvK0Lnj+AaIePlGSpjwmIqcI+2EKnUqL0E51sWf89qAa+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEU2gxs+TzHBNr1LuebwSt/tfNnpzXzIA/hEdSaVMiUk0jdvLA
	PTP8kVD1R3iSUIDBFI5lZYh6lVWxn453RPZpwD5FJ/uYFyU8/ouP7Lg1L6vrlfmIRpA=
X-Gm-Gg: ATEYQzw76iUavw7MVSZUF7eRd+FKe0XIpnJi41HR4aJRCq/CBvMFuHOWYse8WtLcNaz
	IdLL/g1i2djOtdHBnRvMReEaFM/UuN2zjTJ70O+GSjD3Vn0d8kuewtIWPFbNqQUtuUyt83gMZ9I
	YjBI8pdWuV2kG5hhCWpsdypDnqM6upMLSeVaTR43R1kBBoLiUQY3cvqrLOdTOFhDRMd8DZ3PgER
	AQMSvUY9ZaDGoCVbpGTXbXaTvlCnL6W/K4MFIYiILfMv/Ub8+o7YEsq+Kyesz+9XYY7i05ykN+k
	vmg0POK9zw1X/l3353yA+A7JsTlZnNYEdcjf0DeDFD2/2KVWz+fiqBHL4elYSk7vFGT794tLZNU
	ENuuoXifUTN9oABHnSrc7YB8rTR5s6FN1+pY9R26e8j1IlO4Iw+i/ab+LzJaKsrH6itJqPy90pP
	35x1qUEF8qiQRT4sBOMpF2UJMeLHzupLKzFgwzAWmQ5F1/tygqzqPRnSeErai3gfLQeSECGY/zU
	w==
X-Received: by 2002:a05:6830:8297:b0:7cf:ccc0:db0a with SMTP id 46e09a7af769-7d591c1837cmr4602862a34.33.1772296569634;
        Sat, 28 Feb 2026 08:36:09 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1031:c44e:9f1f:17c1? ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586625e4esm6798748a34.15.2026.02.28.08.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 08:36:09 -0800 (PST)
Message-ID: <641c4d59-4cfd-49b6-b6de-692db48db1c7@baylibre.com>
Date: Sat, 28 Feb 2026 10:36:08 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad799x: use devm_iio_device_register and devm
 buffer setup
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260228154515.16639-1-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260228154515.16639-1-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/26 9:45 AM, Archit Anant wrote:
> Convert the driver to use the device-managed versions of
> iio_device_register() and iio_triggered_buffer_setup().
> 
> This simplifies the error handling in ad799x_probe() by removing the
> 'error_cleanup_ring' goto label. It also removes the need to manually
> call iio_device_unregister() and iio_triggered_buffer_cleanup() in
> ad799x_remove().
> 
Since we are doing this, why not also handle the regulators and
rx_buf so that we can drop the remove() function completely?
