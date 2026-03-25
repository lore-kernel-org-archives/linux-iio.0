Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D82459C9
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448581; cv=none; b=hKOfbFB72mVyQF2T4TWhpfecxr1SU6TMtz/dkCr3XLiXuQ+KXNViQcQwhzCxPlkSxbt/SZHxPW0NxsEGZhLzyAD9wlm8pmJB3D5rrLyBeXAD9f84GdVBU9SUS0/5zMkZ/HuBZ7wgPagjropDxgg9xLLxyDgNElVenqSBqmlLWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448581; c=relaxed/simple;
	bh=P3GOM2tYOwGAAeiUbad7aXmyG9Tm1tInWTUjDGlxHZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oePwMJtc/KvI7zfwVibQSu1ojy20rxPVL7IDxWg6E+l4tFrkPcR/hnfygylEXYltSx6gl7WxrVqaBaHgR/XW4rhcNHgdgGB7fq5tLgf/NCyjq9uLqn5N1HE+IPIwucFjremGgOg5j8GUKz38hQEe8Ri8XIreEs3GOkA/ToGM+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0G8SVNi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0G8SVNi"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so5886728f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774448579; x=1775053379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHKFLA/L1MMV9YEm1+Gc7+MEDgWALzJilMnFds5xMvY=;
        b=d0G8SVNiL3zB7qndKP9SoJm48RSx4R5YZMy80HyNLB2VkufQQkLftJOLdg3k8KiLqq
         8qMj3FYHtMI2T5vK+bHNAQbGnYK4Oaw7E3bt+ZxiFdvmWiPox2DSB50dOrxqKseqZi9F
         RJIjd9sNbKWlW9ddDf3JPXabhsLYFKE72k7DvDSqUaTG/j4Kwk43/ghmyrOQB52Iv3YW
         dkrBEqSOynmi2/AB5i7zGS8YcOsS2DBFiHmXNyFZmBjb0FGnqvPDB7JBIeNeddeLJ7Bd
         VUa1dwXnK38LptUTsO0kycQoLo+qxX4AnS8RVJjZQoQV/Wlv+jETeCh0UHozkI6h7CIa
         TV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774448579; x=1775053379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHKFLA/L1MMV9YEm1+Gc7+MEDgWALzJilMnFds5xMvY=;
        b=BDqfUOMtXvwMxXFgTPvuNeXn+6a7ciSDx2OiIwjfBGhHYX67cfNbrsF9l/viiqEKq+
         HKlZOHCWirHf3V5wQnTx1z/TStoNh0e+UDfPGWy5kNvnGAP+/VYI/XnXpVDeMjcj3gON
         E2y+l+9uxT3xq+94ShxoYSmtGTsfKqos1FPn1DjeC1CuM/j4TxQmOC/Yf4j6TB/3Kac1
         9YaTB2pgrmNUt3PR6Z8X4/UEt3FIeIi3XJxOhrgIqZZXRM/0i9402R/NcpmWl0mzM9po
         Jcv9UqMe2OrvAfmF6jfbhpPCIOOsx+55AII25lqVBi5iLiP0nt0LIQMwc9O1lhbEsceE
         pMHw==
X-Gm-Message-State: AOJu0YyNNUUBJp+tDwWqG6wBVptDCvWozQYSUHEr43fN9sP3J/vL0l7P
	4jS0wFYdAScuC52nBP6YtSXZdQ6ruqoXB2Fc3zwo6ZcOvcup1+j4b+6JnDlRWkPeZ5M=
X-Gm-Gg: ATEYQzy7jOZ+xEy3k0pX2Giib9zHb2b06xLAw7emAmAlceoS0AyJVSqhBiE/uBD8Oii
	vd+Oy+DLcKwp8VMsb2J4z7tQSKPWLozWevDa9ebPDQG7U1lHoJ5fbpVtiKMJR/OlFzxGdiZGTs6
	6PNlNGWqzD7B/ldH1wc5hcBMSHpfoN4omP7ngTqYF4lwa4igUvRyE36qo3x5QqPbwHzCYLww9op
	+9YPBGF+Y0KGdbbsIbjKzKSezzewG4+tu/+CWfOE0xbr+1RU38m/4XO2NZAacgDdvCCsDDcQwc9
	+RhtsfJ+q/qZb22UvfA+QXuF5NakjNMOl9Cwswd96jZ7WaGF0sjgOsZ2eBFqCV2fCfQxVRmCyWK
	Ur+DLM//ck3vCBcWmrqr8m6FTE+2uRyesXhqUUYK/u7IODUs+nVW1uk9rKfsdA6Se709ZNr8Su6
	r/+3ofLRF78f0/Kprc3GgVrhpBqRsQRhuK4T5JbNyRZk27ejHfAFoRd51dyRlAfw==
X-Received: by 2002:a05:600c:45c4:b0:485:5981:1411 with SMTP id 5b1f17b1804b1-48716071b48mr53530165e9.23.1774448578926;
        Wed, 25 Mar 2026 07:22:58 -0700 (PDT)
Received: from ?IPV6:2a00:10:8f5a:ad01:f856:f975:7cf:79d7? ([2a00:10:8f5a:ad01:f856:f975:7cf:79d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ee57esm126358445e9.14.2026.03.25.07.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 07:22:56 -0700 (PDT)
Message-ID: <891e9fa4-3a84-4a26-80f0-8503e71aee5c@gmail.com>
Date: Wed, 25 Mar 2026 15:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org
References: <20260324193626.77231-1-twoexem@gmail.com>
 <acPNhGlmTJk4pfRG@ashevche-desk.local>
 <2ac6cca6-a7c5-4892-93d9-49f850953511@gmail.com>
 <acPU86AwRJPUb22L@ashevche-desk.local>
 <71a591fa-d103-4043-a313-e796483e8709@gmail.com>
 <acPsxval-nfltuVP@ashevche-desk.local>
Content-Language: de-DE, en-US
From: =?UTF-8?B?TWlsYW4gTWnFoWnEhw==?= <twoexem@gmail.com>
In-Reply-To: <acPsxval-nfltuVP@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 15:10, Andy Shevchenko wrote:
> Hmm... But it has different HID? Can you also cut'n'paste that
> device description from DSDT?

Hi Andy,
the LSM6DSO is a combined unit that only has one hardware ID. The DSDT 
only has the GYRO node, there is no separate node for the accelerometer. 
The only other node besides GYRO in that DSDT section is for the ambient 
light sensor.

Best regards,
Milan Misic
