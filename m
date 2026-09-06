Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACB355819
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725829; cv=none; b=AgcyUUkPO8ozyhPPb5scX8Phj6lVycFECV1V96ezv5/pFyCHk+s+2f4PVRWDAlVZ1EN1OaykhCM7kho8bB/m/Yl6nuL96Yb/j5R9ydIswxo0J+qyLQY6Q4fNvgYHAEzWCIG1uXrbEyG1eC0qjPkGg7vzhOgVDn4gV3lBshSMI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725829; c=relaxed/simple;
	bh=ykDPNgeE6ALCDtG9dIbJeisPavXCkocBpXkJWK5BPFc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=YWVRYH/VjzygGykSJEIstPhGvRkV7c1MJvgJw+JrEWbk4cutHFnQAwKBI45dM9DVH2lFrE7SOY5wJIYUwAgrx8Qxq1/2nFLuyIu1fd44THbFF8O/Ce9l3JKjMsnVftYgmIJuao9KAZlCluJ3LhwG7RNIqXvSPNdoN1EiBHJKo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0lW3qV8; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0lW3qV8"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-783047c8464so2148238137.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 13:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725827; x=1789330627; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G71y+UDrFIT1z0z2AwWCoqvpruo2h+SQeZ7yG6rfDDQ=;
        b=d0lW3qV8vMIQtpRJeOctIwZxiPL2OxRw1xN07JnLut9Vo2HpQXUX55E8Fjjg9QZo2g
         tyWZ1ELwuiSNuFlQiF2Zv7MjYBkTrQMEcXv3UdHrfz2z7MfkcvMcfZG7LVAsafZFrIGx
         icKTK9qz31pjtB4M09VVN1le5eGejZ/umhDVAtQiEKSdYjDzHgPLmv4yOuDTjF7oqD9u
         m2UwNuGhKwSA+8oS7YtLnKY0Nh7L8J/v0SRihhZ2wdTkRX1meKX3LowDkjGlF07udSaw
         K9eDe6yFpFuuI8x3yJlwy2mb1VO1D8HJO4koVHnSicGP4RX1xr7tRBHsZ/R4aQWbF7GE
         qlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725827; x=1789330627;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G71y+UDrFIT1z0z2AwWCoqvpruo2h+SQeZ7yG6rfDDQ=;
        b=bO23+O/IJNF2Wj/u4eJzUtU04RdPilsHbYNyBFILKL7H3+rIrk246edWanPd9kcgN8
         G+GUn5yWY61FjA0nUMmYGY5JvWrXRgsygMfPHr3C2xKaDI4CGGgX8sujvZLmMrIrnkhq
         vkbWsT7uym9ZrKqRZxfogWwOHCMfx4infdkHx+qKRHclLIExtq+oY+ULvTQFnWBV2GID
         MUGhFORk3URqv3GbooDgslHr93zhthboCKvkVx2cbTYxGv6h37YutYzHVLB1r5h4LU3U
         G8cGH29SZK5RE4B9dNew2N1dcarEI3ZgZMqkW8GUOG5OgU0wRphfT81/U9tBacCmil6G
         wuVA==
X-Forwarded-Encrypted: i=1; AKwUvBxLulf44AQ7mth10JIQiXon5R+vzOaosNW55CSwSRDhcyK0Hrc62WUgsRIlSjwaoCH4tC+j32gY75M=@vger.kernel.org
X-Gm-Message-State: AFuF++mtUIC3MHHU/9aCQ1+d5iAI0jve5U6KZwCqDsMYzllzda1y5U7q
	bicqIcsx5MiNsrBlbwi75xGZIdv/ZeiNqkr39c4TcaniKLayxpm39697
X-Gm-Gg: AYBFou3dYhGLIFz50pMaZ2VKT7FE/47KmfbFBrmsZ6+k1dQ+WaAXo7/pTeHhra+IABg
	OzgW3vr+9eZq4L7hWy3xCmOqAatK8/MGPMBCAAjrjA5Mzm0SnxR7AXBvVaHqcNC2c9TjHm6UVE2
	5gMlXkgHyi3GFm2xStLSrNWYM9AoepjvxmFxVgZ7zyxNPkMSr6rhZI3FO4qpEyKiiCgyxp/feIH
	Q2pITk1ilsTEEiuaXNunLm7Yp3qdDQOdEVNqpHhsNRYHDaDfzo5KEWOCllaZ79B6JJZjeaS3hne
	tDoFqFVPZKdAUHMFVIyz+djdqJIO/xEVM0hFupFWrG2Ygc4fp0ncx170qFATaCFK1fePh9At9Sg
	8fFFdwlA5ZMQNvug+UyU+bMrvnZZIIcd4clFvL+IF8mayFHFIYMNjsAWo3rDnS2vvty9OMGg4Xn
	72sMLG6Kn/9TJYHgimJmSGEmwzOAfF9BgVaZSCIodPVwctpsPcnw==
X-Received: by 2002:a05:6102:5e91:b0:784:b882:9567 with SMTP id ada2fe7eead31-78a4a9d9306mr7941864137.6.1788725826886;
        Sun, 06 Sep 2026 13:17:06 -0700 (PDT)
Received: from localhost ([2800:40:44:f1f5:f400:4c49:91c1:9905])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a478bb21esm5787085137.1.2026.09.06.13.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 13:17:06 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 17:17:02 -0300
Message-Id: <DL8IDULL3UOW.1ASCQ859X5KV9@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/10] iio: adc: ti-ads1262: support per-channel
 sampling frequency
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-4-1dc27e9c0260@gmail.com>
 <20260830032237.6c143d59@jic23-huawei>
In-Reply-To: <20260830032237.6c143d59@jic23-huawei>

On Sat Aug 29, 2026 at 11:22 PM -03, Jonathan Cameron wrote:
> On Fri, 28 Aug 2026 01:38:19 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Add per-channel sampling frequency support. The "available" attribute is
>> assigned per-channel too, in order to eventually support per-filter
>> availability.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
>>  struct ads1262 {
>>  	struct spi_device *spi;
>>  	struct regmap *regmap;
>>  	struct gpio_desc *start_gpiod;
>> +	size_t num_channels;
>> +	struct ads1262_channel *channels;
>
> __counted_by_ptr() usable here?

I didn't know about that tag :o I'll use it.

>
>>  	/* protects concurrent SPI transfers */
>>  	struct mutex xfer_lock;
>>  	/* protects channel state */
>> @@ -185,6 +195,8 @@ struct ads1262 {

--=20
Thanks,
 ~ Kurt

