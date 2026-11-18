Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039669;
	b=fX6FaarH+1FX7b2lRo6Mp7gOXB7MjI2QjR4qaZh8uWbS3gFt0g+P8HjpmKQsKEum0pKy
	 UGsr/oEUDCwsAZ12do22Xb3i/3xW/ecBVCGkq8JlA8eshIX/Q729Ia7rft1MtXtpxCjut
	 cQ4tVt1M4tRxLRL/YEi4fGz5yEZEqFjOAgK6jVcilb0tPOGr0O+osRYHhmpzfaX1NS+av
	 cjoTFFjiYpCH+J5BFpem0OI9TKhzto3WVQZ4/LNz2IHicgIqQpF+8BI4H0m795BViNjs2
	 YPIJFf+KYPt3CKo/IuSPDQNTMgeJSVLtmthGllalcBnSLlD5A26fGyrpHmYDLmc+39Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=eGiTz5a4RWzDfrU+6uE44Y9DQD7JN0lrvIFzNORDJ0I=;
	b=UWPbyDAPiWe7pR4ZnmWHIl0RlXyj+2rCkPzMEtYgXFzgI7b0t9QkRTDdbsTcRIgBbR9E
	 2WSB7MrCCX5BeUxaDKqmXrYUbyVjjJOivbiE4al/kM5NgALpjsUkaxO5ZyhuiMyyC/g5O
	 xpKv++KsABlnhTaRRxAGj944RY63U8m/X4t5iucO90D/K+mFic33ta/UPh7YYVqzGGq+4
	 MAi0sq9MUpz1UnSTiPg5Q3BywGmLkHvlVHbvmBMHqZfiNvSbcsurgB+95ioZ2EECb6XOT
	 v1JuSjH6GPMvb/mEKl03xILeYQ0QeJlC14m+txf9fZxyg77JJ3qVC7la5jPcIkR2OyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v8L9PHOr;
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915F606A338
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 22:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4915F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v8L9PHOr
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-862ac6a951dso548816a34.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 14:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795039668; x=1795644468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGiTz5a4RWzDfrU+6uE44Y9DQD7JN0lrvIFzNORDJ0I=;
        b=v8L9PHOrcf6EifRvOUzF1B/yU+AHRT/pt16rArYrVplOhD1uNp54Hi2sayarkYNx4y
         SGKwZwsGeY3hymNTokhMwV0Is8nFmSWK/C/srm39x4AXDlVBGrEtzfqhphZpiqG4cyNh
         OPhlfAsx3SNGvrgsWDjYaXdgOd1mdB/TkK5PrT6ZktQ446jnF/xC/82kilWjejCQ5emf
         LzJa/Exf7jivcmHArr7VqwzQdV1ODOubkngAVZlJCsPV29HLCt0BcCH7Hj97N6+6YhWx
         vx6vhtZhkipbMCTd9j0Bu/Kr6GW85nw+GLNcCm2oxh/y8+g+KEfcdwvHewCfCCfkTQ+G
         uB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795039668; x=1795644468;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGiTz5a4RWzDfrU+6uE44Y9DQD7JN0lrvIFzNORDJ0I=;
        b=fCjMLCxZ1nVQnKvetxW/FvwL7NEsxu6zEBoREX+SkLLwfWuNdyV3ewWM3Qv046fxPq
         ohVbMVZLw8ZzJKBZkVz5ic47F5fO4kqaV9ZhPb7YwMY/xQejLY61Zv4hjZM/tt6Ry6+s
         yrlQhn35p3vhPD8NG4G9sEAJsdSHzmHnZd9ny24RDbDWKu1FNRBv0PUJeZNrDL8f0NSt
         K01t9/tmtV4W2bhTlt6kcI6LlTPWJoyQ7S9ig6NZ9G3rg9HvRncy4mLUiCixicz5rc8J
         qsm/Q93P3GE1Dq0896N+HFuTJ+nhzNK4YkCg5WETomj/NUpK1mB/XmabPoILdmZqGX2r
         jMlA==
X-Forwarded-Encrypted: i=1; AL+hErFdhqCDqVQAoR8dVKbPw9jhHYq3hRXykLEUTEEnJ04aMujcVkyGxgn7ULLZCcnVhTjvp/A/wbABfz8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wkSm/pUuXLPmCYX+UyWic0dIAvfRP9XxFGfKF+oNPzeSUQ8wE
	IYVvLp/RIGi9xYdPmj7/knEEApdafI+F4SeKxbPUOrmPQyZ78Uj1HNRv
X-Gm-Gg: AYBFou0zfpXvohvclHDhMFMW8JdWHqLq6mw0NCNbV8OOZ4fAZoBmDvJmTW5mY4rLmTL
	ERplm5/o4YMyHkb68QZpDoFUoRH543aRCKJ7wjk1YO4QMY6j1aP7dwlKG28UGbgIMDM2Ydprwok
	m05z290WlupX6yOeWIJxV4ijOHHzq2Yez25kRx43otnCEwqe4JP+YLiUBJ1oz4Ru7nwWatv+/e5
	DM0VO1+7lfqbA1Xk5DwDL90nZMCCk3nWpcqOP3DOY5OPGvNqsAiOaaUvZLE4JLHCNmXjXxVQZYt
	FBcUGlqACOA68b5O58l0pHz1840IU1jZGPFgvpQO8NLTlncbATmTZd7womln2INMzhY//duV/v0
	la9VHIWO2LtoYuo/KR3uyK3HVUwmPtiCLrD+lAvKBIsDAO3fPiTIBaxC7ssrHbPyurSER4153pf
	aKoz53dZZyqs3d7xlQsMXb1Mi8tKWsnZRFve4wsjB1DwvsvoPwe9fiVoEmY1C/New+AL8pr4Hyo
	8YCSQQoY4SIZzTJMGSV5bJDs8Hdmhz+DxmhgT6T4gY293do04o9tBub3glvYRB8bKrqzGSYGsn0
	QRNMxhovpz8DOeBx6OPS/zdPucGsQAkVixH45D15HTMjz9YIQKj0eB0rNsRx88ohhyRmvIprFIm
	sedfsx7qCYPsqsX0PiT1VZlLkPZSLuScaVBb0+ol7MA==
X-Received: by 2002:a05:6830:3495:b0:829:9992:20f0 with SMTP id 46e09a7af769-862f08c9ce4mr4131980a34.28.1795039667975;
        Wed, 18 Nov 2026 14:07:47 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f021aae9sm3024029a34.18.2026.11.18.14.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 14:07:47 -0800 (PST)
Message-ID: <2fb4e011-8ee8-408b-8684-f3bb8e1ac624@gmail.com>
Date: Wed, 18 Nov 2026 16:07:45 -0600
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] iio: adc: add mt6397 PMIC AUXADC support
To: Jonathan Cameron <jic23@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
 <89c8cadb-0ccb-4aac-9b95-89f355beb24a@collabora.com>
 <60eeaaf9-57db-4ca7-b4f5-bdec111dcdbb@collabora.com>
 <4c64aa52-2b75-427e-8f26-c2ef7fc5b822@gmail.com>
 <20261118215144.301c2467@jic23-hlaptop>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261118215144.301c2467@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 3:51 PM, Jonathan Cameron wrote:
> That's indeed a common solution to cases where a binding header
> is involved. So I'd do this - then chase with a patch next cycle
> to use the define.
>
> J

I jumped the gun a bit and sent out v3 of the suez dts earlier today 
with the proposed change [1]. Should be all ready for AngeloGioacchino.

[1] 
https://lore.kernel.org/all/20261118-rbrue-suez-upstreaming-amazon-suez-dts-v3-1-c1a8b0febf35@gmail.com/

Thanks,
Ryan Brue
