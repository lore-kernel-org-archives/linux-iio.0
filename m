Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FB20D4E9
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121236; cv=none; b=lQTrNZ3d2ARCbs9OVFxrN/8z7Sx+N5OnI/z5cgYiYxtMA5m/TEZ5b/Xf7Pgg16I1yuAN3PTUE+I0B7JslSCb8WuBrPFTAISIldVxd5PdQXR47UNc8gPu0gd88u3V/5vJDZP2e1IwXY2mbBzCsTJJRwKfFS15nfnO5GpoVQUlnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121236; c=relaxed/simple;
	bh=lOCZbhE3NKkdYTlRDV1FldKTuUpoHr7tpaEtvwGYBkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfCUeXzAeRWF8o/vQ7QRl+N2F6AJSuYZwwVff2knIUh3S0Oc4YG0awOLBBh739kOd4JuFeiI8xiaUhTUQo3gIK0WsmY02yvV50OqEJKWJ7Kpzu27Ytsg8Xs6Tt0ZH1tO9s5kc1eFj6MSCqvVfEOgF0+zXlbVUfie5DbxEpqkc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d5U9TlQT; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d5U9TlQT"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-467fd082ffeso628732b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774121233; x=1774726033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qx+nu7/Wx18RNPJ/e4nhvsPL7FRVDVMDYIX30C/ItEs=;
        b=d5U9TlQT8u1jBLg1KrRvoZL7kwRs6XxbPOd2sAxosapRwFY970AVTAFYaiHj8eDPIt
         hofcRgV7qwWtLhHRxXyQWZRAhLh7tMzpty9P1Aw0+iSkFlFuC7nOitX4IWeX5VQGQ8wk
         b1kQ4fAaBGs9ij/TIJgoHxTiC92DORZa3PJZBwB4gmf0tYXm9Zi/olj0pOHrTKhe6ECG
         m8y96pwfZX3Pt3HQ0G/cMHik/sIiAGRVLqJsHmJ/uw1A5+rL/8RVBEHnUv/WmlvZKew1
         4Gnhax8u88KMWcgkDh+5Q4cFJj0v2Efka8Bm8fv6yQEG5Sr/MB6QSnoMYFz/hBm85S8n
         DB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774121233; x=1774726033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx+nu7/Wx18RNPJ/e4nhvsPL7FRVDVMDYIX30C/ItEs=;
        b=OXRAX6TedoCyIkPjZgJ9WBKHKgtSfVXO0H23rs0+5QpFOA+V6okSZMXD09s9o4MEh/
         obHOpM1OW3GpNlTKOKn4WzJFxqGKny9NPCaey1Hp6VcP+yB6V72RQo3WVizvvR1ErlyQ
         mpJ1MSN7X5HTPVKFPWnE7n1+a2vBf2zhHwFAGQ4L5uIrmTa6x1Qy2HNG0CO9sL2QSr2o
         qRukcIfD29zYJCd8S/qhFIA5Q1SE1wYpE8Z/yXpVARqw47h0AV1hbLXAE0VbD9zEYMnu
         NO2ql+JwB7buuP46IvBjYVD35oNKIwvROXyd057vlBEKuZgZXceDtMaaB3CW1qzLJ/8/
         2uIg==
X-Forwarded-Encrypted: i=1; AJvYcCU3zl3TL/P8OedUYsgW/ARdn9WakSzFxgi2LDJrmH4RRBQJB6YYS8awtqPdUuyouMmszy/tDjUJmXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYu9sfH/tjZZOkQvEh7E4QduKcZsQMQonsI2LfS6PVCZlF0pk
	5noscyncqDCo2WWsXaHqxiZiTM9Qk0y/27+zPbSuXd+XtLXi/P+APcaDhWqLvh5iJAQ=
X-Gm-Gg: ATEYQzzb+7lWFZoLLx5FuBbRGamIbueCkOpsvZ7J9geeH1fUi073Xge7/eu0dfagaoz
	xRF0tS/9JuBFBnW9ngEmtdiC4UHYj1VzEWMLkfLXU1fZnMqrooMxve5x7yCZVm0SAL/aaG4RyLN
	f1Xg9N6d5qJc9xg8eze452ibjbotTsKU5+5Ccu+/pQggC7IIXGyObB2nCyp5bGEKwBBTmq1UlZ5
	qYwgjMqxnDqVQbiwwNe/TxpcwWTfzNPEkmPdF1h8JtcWpsvU2gQ6LKulM5kNLTh7IdepU0LU4sj
	ClX4s5cuEIWi3qBKS6jBpyeKzRUo2xZIx/m3ZAzjKoQA83dEcOKs/G35/fqJY1TvHOR+whAoDz2
	Wt47DkS+3ZXNYwYj5fROhTDbPiXL+kFzSl9+8c9l+kQvOmZxjMYsbsecG8XWa6C/uQhsV5fj9db
	pskT1+Tky1pkYHJ1SUTzGcO0PqqEKvm1zsfwEn/m3UQnM6caRvSveRp6EQbk8/eqfHXRLF68Nc3
	k+Kj1zHCIJ1
X-Received: by 2002:a05:6820:2909:b0:67d:e184:979a with SMTP id 006d021491bc7-67de1849afbmr760543eaf.7.1774121233367;
        Sat, 21 Mar 2026 12:27:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8e89:f58e:e4e6:5567? ([2600:8803:e7e4:500:8e89:f58e:e4e6:5567])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252e0d18sm3488414eaf.7.2026.03.21.12.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 12:27:11 -0700 (PDT)
Message-ID: <0269d645-633e-4ad0-8326-ecdd5f4f47fd@baylibre.com>
Date: Sat, 21 Mar 2026 14:27:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
 <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
 <20260316183117.4dde7386@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260316183117.4dde7386@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 1:31 PM, Jonathan Cameron wrote:
> On Sat, 14 Mar 2026 18:13:32 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add a DMA-safe buffer and use it for spi_read() instead of a stack
>> memory. All SPI buffers must be DMA-safe.
>>

...

>> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
>> index 1d427548e0b3..6416d6a7ada0 100644
>> --- a/drivers/iio/adc/ti-adc161s626.c
>> +++ b/drivers/iio/adc/ti-adc161s626.c
>> @@ -70,6 +70,7 @@ struct ti_adc_data {
>>  
>>  	u8 read_size;
>>  	u8 shift;
>> +	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
> On this. There is new generic infrastructure for marking these.
> https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/dma-mapping.h#L720
> https://lore.kernel.org/all/01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com/
> 
> Would look like
> 	__dma_from_device_group_begin();
> 	u8 buf[3];
> 	__dma_from_device_group_end();
> 
> Do you think we should adopt them rather than doing our own thing?

I have mixed thoughts on this.

Pros:
* This would make it more obvious it should be at the end of the struct
  but doesn't hurt if it isn't.
Cons:
* It is more verbose.
* There doesn't seem to be __dma_to_device_group_begin(), so it isn't
  clear what we should do for tx buffers.

> Slowly though I don't want the noise of a mass conversion.
> 
> As normal, advantage of standard infrastructure is cutting down
> in subsystem specific magic.
> 
> I 'think' result is the same (though it also forces the trailing padding if anything
> comes after this and needs it).

