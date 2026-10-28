Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793168178;
	b=lIK4hm5LMpWBDiAYBKcTd0L+3yxGxU36xTVTa/RmXGoA2H4UfD1tApnbdM/U9YuaenAy
	 G9GB2zgVh7OzlC1Dv7JELVHwpRaEQEurKrT9b4OI/49x7xYQseUdGbljJV+CzD+pQMcl9
	 fd6uJPK6HkJRmTQWmO/ei5U1lfeift4+az02TZmlp6vd9jIDjmRczQxt+ddJwGBtS4sWJ
	 O8KQm52h63AXefXqkK2L4rY2+1srONvfOhnkm+NC7mpsOFsdX1amVkAd1SNXLFFaocnJu
	 Rp0oSm9Gktg0FRr8wqoWQXkTdeSSMStCiTcMMUi7SCIPtch53HLrd8IHvY1/wxcVDYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793168178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=upb2yDjK+Sz2Or79oIRzVU6fGyWUl+WecZ9r73Zp7qs=;
	b=SpzdbwVdQ19VxCrC8EeQIqOaf3wyqBLGgCLZKVqGw9gTdGtossQpAkM0cbQz6ruu6Qwc
	 ps0GPo2y593bCzRkd6gy2UkLO75/Z/+GZutoRZ/paxfgAQ5azb+th6NS/gjKhVr6QskDr
	 uclo7Wqm1QSWm2+7edGgl9jDRu7Bhvx8kVuAaVeNm3Cb1B+uzZrCpPeUUW0fY71m/38wv
	 KkR8mEYHE0pJUGV28nr9l+RU2VN8zKmrvpzXnzXosNClwwmqrA9sSuw/LcHX5AuvhnAY9
	 hU/Tr72vxpO7QhuIF50ueF57R29LSh6QwdNxg0SkxeiPrsMhgAzRso2nJ0W0/WNCeLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xVrrS+rA;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A8606A31A
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 06:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B98A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xVrrS+rA
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so652677e87.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 23:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793168176; x=1793772976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upb2yDjK+Sz2Or79oIRzVU6fGyWUl+WecZ9r73Zp7qs=;
        b=xVrrS+rA48dR++IWDoeT0yzgI8xGj6gmsCuXugY9JkQg8WgACbfDsXwKUBfsfE+oO4
         xWeUg+T12a7Bbfsb5wCcdiLCdoMQu5a5u77uLDQJ2AYHQiH8zXrGn9/9sXY008GV+gQR
         Rvf6zK1RU7ithcxnnEsZgKBC8J6OXzVYOYbWHsEVuUJS3FGX4oFYxfsqQyMBoUUaIJzn
         p5Gg4diO74fqYRoEQqGKbXmrpJGDvWGUg+MQpMwxlvGGVncK5E6Z9c3jw3DJOAi9sncu
         baKYmGIraPwobQ9M63jnTuEVNUa+cPVrVO+L33aJu2tm42cwY6MIQ2pZE5R883rrFRCg
         qSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793168176; x=1793772976;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=upb2yDjK+Sz2Or79oIRzVU6fGyWUl+WecZ9r73Zp7qs=;
        b=FaYw8l2M9Ax2G0UVLG0c6/PYJ//PW0qzfEN0t21HqSZ3JMO4DTMTbOv7qX0aaiI94S
         TRGkKePy/YTQr/Qn1Z/X7BvHKhx03eD5wQNE2WR5rSkj8R9vsJ9xTpYmgEahbFZCayNi
         HOiyT0qBHXJpa6b008UcleQDmXWPa5DFiIoUNdiFmVr23RqnnzF8w4dIN6flOl5Itd4B
         Lqypg1QOutqGd55Qjen49XBxDt0dbWqehbN0bc534QvZBaxgvU7Al6BaAFZxbRLxPeQo
         uyVhho9UCWaadpseqjWq0KlLLnqGCS1ezMYlJaWXwuB71xlTQrwe2siQeuHdILqd0WD0
         EKxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwssOK9eVLJk8KiI3nIbmJbL22idWLw/qu9kkuyIy7jOhkRGO23NWatEQQKVCycwpcLOcuqEUgKNhg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIG9Awlkt1KPAqQyWVLwvw4SqxF7NuexI+v2R2jTDeOoPRJp3Vc
	STk0CULdH+rPiMNAiSjUu7BYrOppgGcKZIrFK9JjC/AAngI5Uh4UOSp3
X-Gm-Gg: AYBFou0OYYkVB1HkL/P/+9wrjjwQizpvltEWVdoSt+l503WERzeQLEFw2yyBmULBQSE
	uRXP5wrHwEUnHh2w7mWPR4erMoLdVEv6WwhcUOlaevzYD19ceo8VuO71g4qYpLrh+u38p9IqFBA
	PKSPQ838EXqyLjHkhZkCePiYyn48B0OpdKKBrTJo0/twywLxqdgMatvVYzWianY2tUAfB18U6wt
	H2uwKTnNQxwZktvj6cf9TyLGW+5aBLs+RGv49w1w+Koh704K1iZ0h/zCuihcJmvSrF61Yq8UO6G
	aiBZz2rh4pXUoqDGwPTxhhUjnlZRpN9Kpidmh8epeKl1qrKTadQRSGR9lREJ3pJuIkD+G2ydRnH
	F/ysxJtJOeevweBj1+sowz3C6Ie/EQ3cpb+CZaWET/nsYo+cGhQSGFvy4uw9yQYGpN9rpTqRP5K
	4hidMo71hXfHFsyAiZ6VEDU1Ga3dz1ehSFISxcGzA9jKBGGz281/qVFaahOtCA8S1Acjy03Fn6D
	ey/M50kE5h8gNVYmllCrjwzyYb6E3KIp/ge/lN/FFzedRQ6rHLt+UqnYxza9GYhM7X/24JV52tL
	oF5K7J7FnfiLsm9zZWNylWLxhIr5/rwYCr2RLWqRjICkYT4oWOYhCC2RYq/RAXsMW6x2oMswvjm
	3E4p/yzJzDA==
X-Received: by 2002:a05:6512:3a82:b0:5be:4be3:bb8f with SMTP id 2adb3069b0e04-5bfcad787eamr578392e87.19.1793168175751;
        Tue, 27 Oct 2026 23:16:15 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfca47f9f2sm400912e87.8.2026.10.27.23.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 23:16:14 -0700 (PDT)
Message-ID: <9e9a2f4b-b6d6-4faf-95f2-e227b41d27eb@gmail.com>
Date: Wed, 28 Oct 2026 08:16:11 +0200
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
Subject: Re: [PATCH v4 4/9] iio: accel: kionix-kx022a: annotate the lock
 helpers
To: Rupesh Majhi <zoone.rupert@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Guenter Roeck <groeck@chromium.org>, Jagath Jog J <jagathjog1996@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Jinseob Kim <kimjinseob88@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Remi Buisson <remi.buisson@tdk.com>
Cc: chrome-platform@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marco Elver <elver@google.com>, Bart Van Assche <bvanassche@acm.org>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
 <20261027124954.110697-5-zoone.rupert@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261027124954.110697-5-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2026 14:49, Rupesh Majhi wrote:
> kx022a_turn_off_lock() returns with data->mutex held when it succeeds,
> and kx022a_turn_on_unlock() releases it. Annotate both so context
> analysis follows the lock into the callers.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
