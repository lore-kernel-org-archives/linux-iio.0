Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30CE76026
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673756; cv=none; b=tEVsCBAvjYnFRcH4cEaUhn8gbL9ZT4mNTaCrCGvNr+zzB4LiSln3YedYuD3kRcbqxL7YnzZaEVOmcLgyHhKMb2MTH1/tryJgMiA4Lq5YuBwsjCqyOVuiFzsbDyjMrLmD7amqv86jZy30EbYdIzjtW7PGeIBV3PCf3xc9tQu0i9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673756; c=relaxed/simple;
	bh=cDaGDI3r+xzke3jPoXhYv5x6ipCPebf/2XgP43K54Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LA9OTQsFVlaZUVf+KTPlQGtn5YDoIul7fvILrWEAotA/sDwsuKHV60typs8HBsZ9YfWEKu56bOtq09JLfl7QrThbtil5YAk0TPqnKcIKkGs6ZlSUqpAkDM6ifw3TWcUNL6GM/xgzj1lZw/2qVGQBXVSQn4Rp+w6H5P4icknm+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MsLOYTt7; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MsLOYTt7"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7de4be15125so9208358a34.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673753; x=1780278553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSxXz0fJUl/u0yNVKSTnYM+nC+klyCfC7mCOal5YHEI=;
        b=MsLOYTt7oBUNtiWE7DS7EDLTn37a50TlCzkQch4DouV6ogHSTt/IBaH1NmbWEI0eWI
         T7XNQFYyUHpjSBKSJl8X9fOwZLqIBgo31bucdHsUijdRJ0+z2im8BKh5PSz5CrhJlwZA
         8f8Osqpeiwq3NHc+8m6z178+VhO//HkA9m9IwD+eTAGc4Q6K2jKdEz+6cBIpGIi9Vx3M
         W897PdmGGH3SEY4yxAHWLddQnZKT24+oDJEKcqSgyjssIAohkB30jgZOpLM/t8D0XIyv
         WuJyC7LwyV0iGVI6i7+k2COOKqSDVD7NKHiFua5uSLgC8UE7bbpsVXuVc7cqBVp29Iic
         bYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673753; x=1780278553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSxXz0fJUl/u0yNVKSTnYM+nC+klyCfC7mCOal5YHEI=;
        b=mLPEgrPLal8xLE4A5DIB1lve6ytFTUaUBqCXqYyIK884uhfrEXPUflryP2HfuivLSO
         hmXiQ6GED2Yf5ncg1ExwNHg3NhQ+rUFtAB41Iuv3da9FnMOcgVF8MNyxzN7gj0rp+/77
         9FqQarm9/TbJZS1shDmoBKnNKnO6dwrrpl12qUi/0KvURn6pgkbm2UTZ6YuvI8iHNEFO
         vs1km9JwrKANWQ8U7qvoZx4FxX+wfJ2RXlB9QgEEOx+psrAqfQTppJC/whqzDnfrDPoY
         hAYOfqO+7bwzYF6k2q1Qc3p3h/bKM3t471JiEzuH0nUv4HDHCd6fb8DP8LHAsZ6pk+Fn
         kZ4w==
X-Gm-Message-State: AOJu0YwtWLKXM346EvSRkVw23oOzdZ/8BkY2SJpkjbe1EoJ04XXdDHQr
	df0fuOZnFOgKOCb+rZUqQkM+LXfRYO/QrHJ5DVYHKiySWSUo94TLEApsVEFms4sM0iY=
X-Gm-Gg: Acq92OGUOWc6ws0srpjoumwcct7q9yx2niDny2bAGBj0A85yw/rj/5GkNv3ii85fWSh
	hB9J10auQ+Cc4a7qbHOkISN9stkZQzTdczqrjx71IEJQvXKaEZS3593DQEwhdkplysqYUftVP5z
	xNjvbtYc0iPf7RzcEecys+F2fNLtANC5zJRT5bR3nqFHOHPOVoMplhqA4Ai3GrEhTb1t4Qm9lQu
	x+YC+w3+AOjQoxynpqLoqUjhwJTi/qcDzsDKBntDuCvMuNKPCdnpU1FI/HdRgabgONVWoofesUE
	ej4YpPuNALQTT73qqt1t2LqGFQZFyCSJUHqy+cplfv1dG1GyYsugcxs1K25st6Jt95MiH27R4tk
	t2OVwq6DGCyR0+lG/S+TflibLzmEL+BaZ9/Sq4tKI6UQYXyQuyS34j5xDFElPKOSBVE6F1RDv23
	SUz+xyuM8buYfmGF0UO65zRnd4KhFRxkPHHZ9GfjMOUl98K8VN3ehXv5r+RHGY5fI+151zcnuvJ
	w==
X-Received: by 2002:a05:6830:6682:b0:7dc:dd58:50a1 with SMTP id 46e09a7af769-7e5fee5ef73mr8197143a34.15.1779673753669;
        Sun, 24 May 2026 18:49:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:713b:3006:84c3:c1bb? ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606459dadsm6267227a34.4.2026.05.24.18.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 18:49:12 -0700 (PDT)
Message-ID: <3c12da03-6c62-4045-b831-e7b07c0ecb5d@baylibre.com>
Date: Sun, 24 May 2026 20:49:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: cros_ec_baro: simplify timestamp channel
 definition
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20260525014654.2399354-1-dlechner@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260525014654.2399354-1-dlechner@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/26 8:46 PM, David Lechner wrote:
> Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
> manually filling in the struct iio_chan_spec fields. This makes the code
> less verbose and mistake-prone.
> 
FYI, there was a server error when doing b4 send, so this last patch
didn't get sent with the rest. I missed the [PATCH v2 9/9] when editing
it manually to send again.

