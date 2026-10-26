Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792993878;
	b=iCInW/Ceg/XqUvL3UU9jfqY9M3tmeAgK5Z1TPxBZzjIM4PPKnxMciKkDx7YosYH1xLwI
	 gVqB+BwnZOSio9d1t0Mml9K5fHzSy4b4Pm6dMuxiab0zhz8Jma2/rvaYm2QUCYj11mJfq
	 esLVuiPB0fI7wPM0suCG7CkgPLY7IBR3qm56MyncwvRxTt28xKyA0j5BiTaHx/DbY5/W5
	 jcG4n4DKJBuyZLT++kyutQIBim4q7o9ntlmuKLjrEZ7ld1d5z+Dk+SWpA+GGPuEVMSHF8
	 Hfbd//KULWgm7RcfjL5l6AQ3xboLA4jZIDYD/LRrp4KmFt9cqygoZvaYKUERqSmhhaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792993878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pIYmeiFuvjcdTNw5HWM6jYGl5dGLFIjavdG7cGYxLu4=;
	b=eVWkdQbGCEhylaYGOuCuQM0efOZSsf3hPEvkXtZlhjjm4dKUrBRVsKL0Ep4J55luNm2A
	 H3h7ZEmY33pKyXRpufI0Kf51P0R5VSdgnEfI0ttH42sAVS7L2hkT/XXG0+ctJy2v2gq9r
	 tzh59Yq38EbUe/fBAoJNRdptzAtDdxgekP06DLQakCtVADOV4Ha447aWuAqF1dRHCnuW3
	 VPCOUUrp10g5mjRREIDydxA3MiOMmd/Amlw6Ib7q/fvou1+iNNPgRolEybXHaMafm3iF2
	 0sfUoFxddBJ6WTPgUEwxluh4rfdyWXlXtw2wtHHf7MyJ8AFx4kMhebjD4L3rQTdoRDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L1RY5X3O;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DFB606A321
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 05:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25DFB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L1RY5X3O
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so14886125e9.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 22:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792993876; x=1793598676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIYmeiFuvjcdTNw5HWM6jYGl5dGLFIjavdG7cGYxLu4=;
        b=L1RY5X3OEu/ECGw/km+1vHQJOw9GyiOk+368VjlgLjqvCd1Uul1o9+T3KpR39CUcz6
         eOzyv7yDZgnAahPejnM5CMs4NVVzgfJ4rhKYuQEImNVXDT3heDdWoslgf2QJKrQ6y/hd
         ndugS/lJQGhKDKPa5SqfrEeDnU1HBSinY6JPN0CNkcMnvNRRPJPmTPXE1wfDbLzyORkC
         Hn2ZCPPegcME0t9bfWOQw9qIxBjK23WJ3mcCxpfxL6QgTFd9vBQRrHaY4B5666Yrmd6L
         iYwJGA8nY5WqJhGvV/jOxvpKSZKL36PJsSyjv7Zh8C8DWdwpHwRmghWi9clC3GCSvweC
         zT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792993876; x=1793598676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pIYmeiFuvjcdTNw5HWM6jYGl5dGLFIjavdG7cGYxLu4=;
        b=UmO851KdMX85wUVX99O7qzJvap21T2/CFuFavkJmF3R7oVKMfWMWPz3JZYmxHipvQg
         PcVg/YLfqQDEZ2LWUMTlKGfAhDcaXetkZYZSdRaM0lcRkYcXhlwUK+yeE4MCVapCW9NB
         t4WVeBwmYR297IRWknzaN6fD7hWlv9IM5g2VOWEv7OGD9+dMWpPZcSCPYQQtNiPzgsvA
         R2PHTaZyCu+X0edRkWIOqsiXzLsbGjP4z9FPSAprfUFlYMEoK9ljJEIc9FSjJErzkucc
         LuT8ar7x2F30SppyPmaEQzQ+uCoxBwiQ8DzVD8FKclS1KcN8+AEpT8CuD/CI+9Itacbe
         ohCQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+KON0sHU3fAFVoEUkyE2xTi4N5SwmQRs/vY8HBui35s6lSKrvVYGASykKNLcl07HBOcZ+Ns0Q6YM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJVBS27IE+eRF9CM2Db83PQVin0O3luAG2CTtCsLJF8igNLM64
	tl2W5hEkpr264oVujf/qoxeZEmNzuuOXVDftTerqqzSh3gacVLkG7g6IDz07G+TD
X-Gm-Gg: AYBFou2fhMnD8szgTG1O053NEuSR+Pq6ykjCoiWFnOpeKxTPI4BprIwc5kolXnwQ11W
	r5dPU1RxPMxYzTfXL0FO0x+QsEKHhLRR9uF2Ny8sJWDcL2tZdHbT0XKKdGRydHzqjGeKlQPnQI1
	ZJMr1tMVG+1zRiy+t/13B/1/ghafZsBZAPDCWOgUUUdNvpqa70RIu+1eUBPuTv8hyxfD4tIOG9N
	+d9KTZZv8VhXJHLf9yDhs6h6HNfPUoxaekuU81rkH3PSjYV60HiLV2b0cH59fyOFYbeInLXpo6R
	vElF+Q5eF6+62wbFc3Q6IKiSuSYqzC9Pnhbh1OrW6InxKg8wJNghAAsLpdAAp/CIqQq1VkdE+5n
	YopPfplA81ecfJmmF1tQUW2MPWuUT6qwqFDBIBUq7mS7dtoAtcjEo3Px0sazOBThfGaN9vutIcR
	xRmmcLsXuGtt0fcb1DWRPqJThts5LiUMPwcRn0qfb5Du7luglCThZiZfT9utSBmWLCQZOyYFVn6
	BwcUqJtwshgiocAwL56g/HDn7s3vRl6wJ10lm8k0fnrHGv6Dco+dv33V55At/Haf6G+p1WacOhJ
	5bJTTP81oq8PEvuulhMUlsYPB3nAmOAbvw==
X-Received: by 2002:a05:600d:82e5:b0:4a1:cd83:b23e with SMTP id 5b1f17b1804b1-4a35aae3e29mr133995505e9.0.1792993876421;
        Sun, 25 Oct 2026 22:51:16 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.250.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm13877419f8f.34.2026.10.25.22.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:51:15 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: iio: add documentation for ti-ads1015 driver
Date: Mon, 26 Oct 2026 07:51:11 +0200
Message-ID: <20261026055111.4572-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021202210.7d70429b@jic23-hlaptop>
References: <20261021202210.7d70429b@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:22 PM, Jonathan Cameron wrote:=0D
>On Wed, 21 Oct 2026 09:33:50 +0300=0D
>Flaviu Nistor <flaviu.nistor@gmail.com> wrote:=0D
>=0D
>> Add documentation for the ADS1015 ADC IIO driver, which describes channe=
ls,=0D
>> IIO attributes, threshold events and ABI usage examples.=0D
>> =0D
>Hi Flaviu=0D
>This is missing the 'why'?=0D
>=0D
=0D
Hello Jonathan,=0D
=0D
the "why" seems to be a misunderstanding on my side. I had the impression t=
hat is it a=0D
good practice (even expected) that each driver also has a documentation (as=
 I see a much=0D
higher driver doc coverage in hwmon subsystem for example). When I have sen=
d a patch for=0D
this driver adding label support I observed that it has no documentation.=0D
Now is clear that this is no the case (at least for IIO subsystem), so plea=
se ignore=0D
this patch. Sorry for the noise.=0D
=0D
Best regards,=0D
Flaviu=0D
=0D
>We don't tend to add per driver documentation unless there are some=0D
>oddities or unique aspects that aren't described by more generic=0D
>documentation.  The actual features are all discoverable so documenting=0D
>those rarely makes sense.=0D
>=0D
>If you have a reason that it makes sense to document this specific=0D
>driver then state that clearly in this patch description.=0D
>=0D
>Thanks,=0D
>Jonathan=0D
>=0D
>=0D
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>=0D
