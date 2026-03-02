Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0036230D0F
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468110; cv=none; b=cVPuqcjZz12CJyeRZZjZX0bJCZgU2adEK4bhd3mPnoN4DJqxuv0IFIWjKTvlgq70arqmup7WtLY3w+dGMWOKWDuLtE41NmkQuU7/zfdp4oSg85UrMqHv+HMbm+8R0jQ1rIV3XQeuhTZW+iC2wpZuZfA+OUjTVJVuDrykBcHvxNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468110; c=relaxed/simple;
	bh=8GD2iWJim7kYdz0G3J09qCaIKjDGwlSkBDVLBsaUGvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePpb5kbVuERkcOmq778ZmxjQBA71EUDtyGfQqyiOn09xzbeuq41yRzJIRYWjzH3LYc8DONq9jQ3Tu5Oh90b424tWNq6U3VG+R7V3a8Zv3C+TreQm7ktI6Y+SZU0y3f+Y7Ter3UjMy/JPCH5a2XM3j8cDVcl7Bwp6M+8kBGIEUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FNggyPq6; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FNggyPq6"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c4b494fcso2929865a34.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772468105; x=1773072905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jr7yd0FVfAcPCwKFpMsPFjSUxY3s3eXmkELD2qfsYR0=;
        b=FNggyPq6ALrEZsgW3L+USUCGRljGj09hl1lqmpyrxHaV3kyw+NqIJdE4IgrcZDyXWf
         DbYtRNR/d7rixVS2b6U0sCUTg1W3dSwgvDhMgakvfkTJjWDKvmwVts327wjeTDcSDbi0
         HW0msZooPu15QOwaLyKzZ69iUZe4MLE8v9BM6J9lBexdMuMAJf7Pi9ZHgbhLAvgYI/ML
         pPFp00zP3OO9OvOUBtuvLXmt56LJyBg3j8QHSVfO3CVYSgugtYQbGw6bY/hFWcaEA1dE
         ZYjSbTM5JbGuYNuepgJvEhaCFnWyQ3t7l5cz/DBwObahxI0Nj3D+kNdz69wZ6M+JxvJv
         XFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468105; x=1773072905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jr7yd0FVfAcPCwKFpMsPFjSUxY3s3eXmkELD2qfsYR0=;
        b=iGaFRUEFtRxuK3GmDs0dh4y1RKaAQu/QDB8tZBQzKR0BuUyXTp+pdvI5dz/+Oc/Pzm
         fHL/PRQ2KRQ2+OtZRBEqjey0ptq0sg6deb00EUMyDZUZom3S2m1382E4wfuzU/8O+RK8
         FIsk73PDXsWA71Ff93KTgBvgrImfQdw2g22z96oNhVkHgtiRTGM7Puna2Mji8A/8fVtD
         7jo5+UPMZ610h9F1Kd1t84jWMW8t/akFkt7dmkOjr7HqdWM5ssOItntrX3HPc/wZ3VYw
         9QNQ/r8SpLUG86XzzOy5psQ836xCIBrHe/x4rvA224/BMBFK2veiw9HkHNhbpOC7lFTj
         EpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlHPDTbLujgAZLcLyq7I89C9fqzBL5GyDKU/Z+2MAGiKCyiVCO7xcZ5R6oGJJU7KGy19vl6ZlQt5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxetnFnwhwZMv9cxIXVnrGCjANVWf1dH0/cqn8RWfcBwZqLRgnI
	nqDMaRa0UI9AO4bVTCwkNRbZ5qHcCVzFCW+Ix01n8NztdX/Qfd39zv3t5L5Md3PJXTs=
X-Gm-Gg: ATEYQzzXVPO14p3f/uw5UyNWbwDDcKgTEkFQ05Hs1hmIrIU8e0p6npDGCFyGkZ/KqJu
	57wMqxpRnO1BCFZrLvsMVHu6jY9+PoiL9oN2ktLZ9gS9d3UaWfHIf4acGGYJadsdTw4SH5h7czq
	35TdtnBIdWB0VmRsj+uatqBAXKgPo+cn4IL1c5PEoyTPWeNJhuWxTRfEUZUQr5FjqPfkxRr4XTS
	LR9FZ75KtzApv6qFyiXv3N+sCmV5+PxCk1RIES12BjcVcRPuVgHbld3il1GZXSTv4ZgPqA77eqZ
	oFVntVz39z0JVJFC4jIIr/yE1m15KGM9r3og33LJuOM5Cx0oBSewnmo76Svf1a5xfAbMrbvMvai
	l2LmlHgQVXqlbA8KPkLy9T5py4pPpYjVjH1jzeVu38wFARi7dg4fNGq8P7eA4txJccaB+PKjXf3
	eIGzCn8S3hzPmo1tlZdd4nD8Znq/fS6TcJ1rvytegk7NETaLhjEC7K1r6vSQZ8Do2hW8A5fIgHt
	w==
X-Received: by 2002:a05:6830:45c:b0:7d5:96a9:3883 with SMTP id 46e09a7af769-7d596a939f9mr4361431a34.23.1772468105614;
        Mon, 02 Mar 2026 08:15:05 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586625e4esm10996129a34.15.2026.03.02.08.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:15:05 -0800 (PST)
Message-ID: <d918c909-e5c9-4a9b-99e2-d458392d72c5@baylibre.com>
Date: Mon, 2 Mar 2026 10:15:04 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ti-ads1119: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
To: Felix Gu <ustc.gu@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260303-ti-ads1119-v1-1-71b54880edf3@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260303-ti-ads1119-v1-1-71b54880edf3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 10:00 AM, Felix Gu wrote:
> Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> in IRQ request and gives a warning if there is no threaded handler.
> 
> Since there is no threaded handler, replace devm_request_threaded_irq
> with devm_request_irq, and replace IRQF_ONESHOT with IRQF_NO_THREAD.
> 
> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

Although I would swap the order of paragraphs in the commit
message. The second one is the real problem (so should go first)
and the first one is just how the problem was found.
