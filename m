Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455308;
	b=yUvdSRvZRBQBW83KiS3+WaQMUHBxkcwZJwEyEmJTNIZqcbkFEwiRDjvHktiWxlKL3t9y
	 uTYpEvIgBT3eAMNz+Rw2dzN71cIgyQLDgTxN/7oK43d3TRzbYWKNO0N/n7OAKqpgvH6PO
	 7tsqOzskrvoADPu+982zSBKoIUmrgNCBPpu4I32pxDhmS0NC6M+5z1ypV1EOaGpakuwW9
	 +xTQhLoZ3lsZYvtH9FUksGRKJbbg/o66omnLbaHFMuxD+A4qJ95Kxnyvl2abC5jXlnkPc
	 UTJ42MRf/1RmJo/88PmjgCz7lsjFydLLtfdMiqDINmP1G+5eZhnWBdurqF6OtNuVFYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=bipnXXOP6GEac7VhzrWgQysb5XbdawIYcGpzXVL1ASg=;
	b=CU4s9+536GP9eEoz3Mv95l/l8oylV8sD3yyfGmD5X8jzs7r0RPt32Z1cGIebtyBO8kij
	 UwnRWfabvBDVosMLbCiIbCLR+AA8wMXzJgP2BwX9myH026CjVU2amqEpHdeusCUe5MZB0
	 OeH85cDX3ulNN7ENZCv+6hkYw5o/mQvdIfC0hwXUD1LZVTo6iUayCteaETtmWvhv+T7Ys
	 S58QOVc9x6DGW1JqFbYSm5VHjhmbL7FJSJGuepqPiZcs5G7lDdPH8T5nM5zGDZgZCZlpG
	 ttfBU3DGxd2yZYa6oZDWxkXSNPwif8HOVJvKOMz21N3Fgi8CPRj1wohh31Y8Zkbih/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fH6SuyH+;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F37606A31F
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 17:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26F37606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fH6SuyH+
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so33595635e9.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 09:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795455306; x=1796060106; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bipnXXOP6GEac7VhzrWgQysb5XbdawIYcGpzXVL1ASg=;
        b=fH6SuyH+GAwKxjbaDzVOjRZqrGQU9AGITxGNf7rkedt03na7jbquWkibUTZecf8WT4
         iFKaebptewviIItuq+30wSBqYaSc3NDBD2/nBrJ5bYIWO1KTBgtyYFZBK833MFEI6vER
         pchYm3ZY11joBAOjjZNLD0+KFUYKgvN4MkRgnDA5iN/usm4fcFLLissoQpPs9Vy0PQD/
         yh9Jo1rHlbH0iLAzc/aaIk7GP02n7g8+izEw0TwI35iMm/wNLOweqqhgUHt0xD/LvMlo
         Nz2l2a/telv3TzE+NOO/6DmZMgH9qKJL5gLsslQIFFrVpdobd/KYe0LyZWGGgGw5CXry
         Qk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455306; x=1796060106;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bipnXXOP6GEac7VhzrWgQysb5XbdawIYcGpzXVL1ASg=;
        b=UHFyB54LqnkIAm3mc/hploq/9bjYzDm3hwVEIYiI6yziFQIAIgfzSpegQY+tAgeSKi
         jZvgB4Kcuzv3qZsAFoNxPPKUTrcoPjt3X/j8UZTSBqzzJNCRZ7TbgUmexPJac3YHWC82
         UmF6gd4Bdw5TY9Wa4LbOItUbh9VgPzuBaRFYoQ9l9QRcK+6omjK2Bo/YlzwXcNzTam9V
         Lg5RI75JKNnW8lVIEMLPC9QuobqU4tT/ufk843qMkGnhbmcsIpGnUea1i0eIvMoffz1f
         5NYlYwZ9enmMwVkzmu2QmmrUpuguSf9+QlNjZTFen9SseM6qhVKu3wRIB90KWvtQTWlJ
         qZ2A==
X-Forwarded-Encrypted: i=1; AL+hErEN6lw8vnIcIPHlivTrIxzmjezkE56KeKOwXaOKb5Tn/DiDLm27xa1OI7KpoIokx0rIlFKrbLluwFQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7iispk5mCTKYEWaiB1nusgUmaXtRcTbmwDDjVWBQ6FayG8aAV
	dSgCOANYY4641+1Z9xPT+yP/0tkdLAQOtJYnvSYPkYMnwP6cc8HpKqNaBRRuXJm9tmk=
X-Gm-Gg: AZFdTZddqN50I0Q1pcvgCvDTo+sNYUgQuDJxYrPaIFzAm9mwkDEWaxfQGWItFMa+dZu
	+a924GiwYtOSdp8HgkIWo9T1CFrxjzGFpic7bG9OnXAIHsVx2WgbjJpR1cIPKxNrNK+tfYyUd1/
	U7KUsCj7luGyMX9ZZfvFncTy6o/yTt++3D+UMWP4Be3ibCNLHGahxO0CKLiJf9I4XE5WuOTWBqF
	9N32DwKjieMgYZ2OKtjJJ4XK4tKKV5fL2MOQ/9zrHqR5ppJw+cpgc+qrRdINh8bmpT57tkd++c7
	KOfyyH4IKEeMXW95DYxlYAkrXnMUAsCR+x9OcUivFPMJXgSxBoxRdqXTWWFrddxFAsgl3VNETeH
	IerN7XgXce95Hc88UZGYXCipWuTAWRngtEs/APdGjIJIFFrcDAeROoMSgbX4sJai1dEfCf+7S06
	NS0Im6/f1jfnyow4b7Zhhcih9R/jdt6RRIUxHzeQ09+0fa8dUoFyk0cTYHTumBlJ/I6iCTYdu3r
	LMwhmsEMB17LkwV2OCuDPUPMg6Xjzsb3isJ+FomNgccRnq+eeM4u8I3gMs1uIW4w0440ssam1b8
	ixsd9dI+uVutS14vWP7KFufBSxpAkomqbPN9fVSNeWkWd4X/qrY5HTM0BtZ6fOTV2mmqLR+e97v
	Edi0Kb5fejN3zqEayQmY=
X-Received: by 2002:a05:600c:820c:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4bb887876c0mr279140365e9.0.1795455306378;
        Mon, 23 Nov 2026 09:35:06 -0800 (PST)
Received: from localhost ([2a00:2381:fd67:101:aee4:8c07:a9a3:c706])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm291142275e9.0.2026.11.23.09.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 09:35:05 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 17:35:04 +0000
Message-Id: <DN2RSBZYE9CU.1T1IA1OH8S0UC@linaro.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Sam Protsenko" <semen.protsenko@linaro.org>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: adc: exynos_adc: add Exynos850 support
From: "Alexey Klimov" <alexey.klimov@linaro.org>
X-Mailer: aerc 0.20.0
References: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
 <20261001-exynos850_adc-v1-2-791b3516bb9d@linaro.org>
 <ar9elr1_tuFhJi1r@ashevche-desk.local>
In-Reply-To: <ar9elr1_tuFhJi1r@ashevche-desk.local>

On Fri Oct 2, 2026 at 8:34 AM BST, Andy Shevchenko wrote:
> On Thu, Oct 01, 2026 at 04:09:13AM +0100, Alexey Klimov wrote:
>> Abstract the read_value() operation in driver data exynos_adc_data to
>> support SoC-dependent data register read callbacks.
>> Add the exynos850_adc_data struct that describes Exynos850 ADC ops.
>> It also requires its own hardware initialization and exit routines.
>> Add them as well.
>
> Split this to at least two patches:
> - add .read_value() callback and switch existing users
> - add new user

Thanks! Sure, will do.

Best regards,
Alexey

