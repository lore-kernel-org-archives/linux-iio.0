Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716632;
	b=VKIsAYyl/KMa5a1ggQV2cTBUmkix/4cSTchh8gpTu8LC/ofdY127CyLvxUOWSeAZUoLT
	 DVkzh3ELKlpI3m8S9692xs2EhXSX5dZXxYMIIkCU7z9owfgQ5OyGQw/guJyqR0M3FqzYc
	 JcFtYT3fsqhUNeUse1/k/yhPQBw/VoDJSEntPn9yshI3BzJrzneEQLl/6SccDBZVltgcV
	 pTWv8L1/Ezxq6KdNA2Hh8cCzGC94Frc5nNEeCvyUWLi8zgmdP/TQaPjJsXamSt/5i9Vxm
	 HKTpUNlFeOmcFCAYwaQXKFHz7LTz4tQzLgv7ojr/pX/+b+t7+yKS06Ab6aCmqGsGu0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1gBGEBA/kCwvv6nk9Cr2bAVirfmjgnvI1gsCajKX6m0=;
	b=NKE4EX5GNVkI127N22a04rKtVgVxy8d+3Bg8gJM1hw+mnbdVcHpmRo5t9LGIvRC0L7tu
	 uOkkR3yfEF6W6DSN7fKKmkqozkRyrBHSBYTTrvDROpYlin9/NSQKE03HwoC6DYnX2RhIL
	 XxfnntyWD4rjwwxd4+J2KOOwVXsC3zQd0vwiU+rEyToKWH0UCEPChTelGFRPH2pkb8wUS
	 0D48M8ePfj4XZ0r6FmX21Ygx+/swlvx2atPHeuJPYqzgT5UVjjutI9e2xDOxD3rjaNdn4
	 LbKgGxHGqyiLU5zZLbBU+cNN5wiZjXwPrYG4a0jkRX69bagDDCtdHCYbxiDd3i0XcTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrp2S7rC;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D70606A327
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 04:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56D70606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrp2S7rC
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so2283276a91.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 20:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794716632; x=1795321432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gBGEBA/kCwvv6nk9Cr2bAVirfmjgnvI1gsCajKX6m0=;
        b=hrp2S7rCpc3NtC+9tEUSX2iT1GBBANgngGjdkJvbFsoSD4a24/oae1w8tizQ0VWLVd
         7tSthvH7ce2wr1TIGSob9YvRd+xsl7o9eWfOeElAdFDcJE0Z9xmcS8X56Nq7s1lOblVH
         FeX4aA6J2pIsDgdx9FvBLk4zVYEUVIlFPx73bA9DBJ4yflep0HPhHAdl/+gK6sa/mArT
         Sew0Ob33/iw3xtpndyrDmEvnTrKVkg5XiKHO8Yfu25XRQ4/JFG7jHPGemrzGU4cvKJhZ
         zAUhsiaPyiwjGTXnaQzylAw7sdhVNRFdOIyTJ6C6NBYycAmNh9csYvqXW3awfBG2ptOK
         G3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794716632; x=1795321432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gBGEBA/kCwvv6nk9Cr2bAVirfmjgnvI1gsCajKX6m0=;
        b=BFGJz12ldxhmwvMHihvJ6+64u7Jg28a2vKfatRI00SQ/R4fHNPS2czKISrDMxz54WG
         ctN9vSr+qwMdS98HkCCnt1LAnR/X9Y3HBv7to/MKAlJ2y6yqtp1ykzdm+iqEegHRI54t
         KLchxuahXNRGfoBQMDdjWhM/LrEOsA38mvbE6MDFxe8KC43tmnKjRfT/QUIMZayiORXV
         sV+zaCEFvTz2+QhyhyJY60mCiAyn1KJNV0hEJFEyINZMWRsFNwtaX8UBt3Kqa0jVnh+e
         EfWSb/GZmdhGxOTTjClIIKIPBN9fwpCsN4wfLHPsL2bAjd32Crc7oD52H7f/b9sfDYsF
         EVbA==
X-Forwarded-Encrypted: i=1; AL+hErGpGIw6fkoUm0385gq+mpF2+dSt8334Tlkjf6HZS+kPgqH1R2a86Ii1zSdCn1/FSDGWCFcObp7m5tk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LXy/kHuThXzyC4LQSZg9UActRj+k5rYrmRkbrQIfZZ0s9mefi
	qWRNintD8cLiBhR5v3mUpjbQ5WXhp4dmMmjFF56KELKvtEOw5jvMqAmA
X-Gm-Gg: AYBFou2sqg3g5+Exa0piYxKJjgg9z2dNmUxHT5fI6yZWdY8Rgn40QJtKkFL+A763+mj
	MMsz+VryXV1zYgsbaJufd4mG7zoF2D9LemyeFxEh4l/dyhDfP8tyZBwHgPbIenZe1wTPjyf1AIk
	Jxm8/1n+GxB4PkZ1nccAK7hIF0S42gXau8FLixd6V/+OTXYu1P+Q3ftu13vPDzgZGkbciBxoSKM
	IMq14LlXQ/Wi/9D3++AeANcpWn4wcxfOUSYZVOQ3KoTzlj7/EKpu0gPhbwOiVpbvMAzoY9oJ7/a
	oCuyPkoFE+Q4K6OCrsopHvc2Rsfo/R1kOq6ShImO8U01ta+2qr/Pl2TwuZMHVjRRdAAkiBesv9a
	FQyzZdRnwt919i1tr9AQzaICrdKLeAmIg8RSsniUi/ykUBvQ8xT50By8GFMJwz+WNUhMwz3Vo9H
	BXT445TjoZEf3pv4S04VeNuzuzdqdqT+iX4U50N0egZnU3vFk3RnqqWWUmNApL1d9+TIJSOkV50
	r2BVqXcWhisULuVR3QzAqHpVWM/JWOfVu1lzvJlr68S09k5Hc4QN5h0M49NcuyOrveSKcctJW34
	yuYzLlW+AS+8s2lTZhr91WlKkapU8IWmSFew3ivtFSCTxpeOQCtbWmR1y/8hN/qsvpjSGgBNTOB
	/4eL7p+fmjlJmK06OfxDdzm4gyAzKLRIbL+IwOPIwTVYFbdRZmrordreAoIU1mjZp9CJjBW3Zb8
	Fj9g==
X-Received: by 2002:a17:90a:c88b:b0:3a6:e901:e79b with SMTP id 98e67ed59e1d1-3b1b0b665e4mr7165716a91.15.1794716631680;
        Sat, 14 Nov 2026 20:23:51 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae8be5adsm10972872a91.0.2026.11.14.20.23.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 20:23:51 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: fix use-after-free in current_trigger_store() on concurrent writers
Date: Sun, 15 Nov 2026 14:23:43 +1000
Message-ID: <20261115042343.87716-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114235118.4414bd1f@jic23-hlaptop>
References: <20261109095728.59024-1-yuz08559@gmail.com> <20261114235118.4414bd1f@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 14 Nov 2026 23:51:18 +0000, Jonathan Cameron wrote:
> Probably goes back a long way but please check and reply to this
> thread with a suitable tag.

It goes back to the original trigger code: the mlock drop before
reading oldtrig and putting it is already there in

Fixes: 1637db44413e ("Staging: IIO: Trigger support added to core.")

Thanks,
Yu
