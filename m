Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E2258EFF
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771468178; cv=none; b=sQffG6y7LBlDBZOIV+Gls5J6M4l2F3yVHVOkNqKOR5rfBkviwYslVhCFHL8tJIcOXozMwrMybjIhfCyizGH+kIgYNNGBiAp1sAIdPMzZV8I5zmC1FeHSNH2qMrozmtGXEgeyBQRwHa6Ab0MdbRLZsCL9eLpDfX/zFNMVmmsXz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771468178; c=relaxed/simple;
	bh=y62dQmcfzA7x9evjRbkFtEx6ixLGw521fZkusri9NRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UclDmCrE1PZVSIq3udOWp6VvN8+3Z5wVw1VLsonbSH675yYuaXDTy8KoqkgowCEMNZV1TTUoGEg3OC6BWQ0as8lOwmBRJ9pGWacgxXvTeuFeTohF6fFg3VQdh1vGbQoP4JvqNeUILoDfo2I2pXWC4+hEKXybRBsmubUTHhS0BKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD5GMvFt; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD5GMvFt"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127380532eeso1049266c88.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 18:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771468176; x=1772072976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHHqKD+lhoCXs9icmscKR43kyWRRP9aoACTlazkgEzo=;
        b=gD5GMvFtQFpyHTDte6hhs+IOOyx7YzSQOK4eitReKF9YL0pOJILFEn/uXBdg0P6Co0
         Jna8xo3xOn81L0uZhO3IDF++OKPezmRIOsTHNrtJNdKeyucCeNX0o3VetiuDSxI3vKxE
         M/+T68ZkbKO9obt34sQyjZVqFfF14M62ANHJqOzO0hTy0RBC2p9BwLOXjUXfyffABHB0
         qfqk6+NRnrC0AqhDG/baOlrfd/o3hsbbYpKbReUuy19I3tsZN59kAIFq0cwDbutudzKT
         tbhnX+rKpJa7TNE4TnWNRqYUJhe43KtoIyMBHwIfCSdAUzxA7qSohXYF6/IgeYbUO84+
         4/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771468176; x=1772072976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHHqKD+lhoCXs9icmscKR43kyWRRP9aoACTlazkgEzo=;
        b=N6dh3NyiYN5Ncfj0s1HVkBq3N+ZjvN1685JV3YRL9g+TV9edfx/rp26lEg1ugISlLf
         kkqoCjUu7cIv2Gf5NgPunVjuJXHgX7ANWWCSE0BoFJf4ISsMsom3ZTvONMKdNC+ckWPb
         fy+jvqbqCHQjtbqosysaKFe4MLJDASxkvCjwwP5D7e60lJvfPeBLq5DNsakZGniJfBUq
         Oy1uORNiEhihvxKpR0jklobwIV9T9q6LLKWjiyqgIA9PWDtj3nOv+lh8JwV+oqhGFTYA
         X/XKvh5bqNoRX3UM/5S2xZdHzvKW9lKpZKnf6ijr7AUzN7TUaMOA40Rx6b1KdVv6f5po
         sNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCbMWE03eBMotXIgCxuz66nwZFwvoCHj3z36AoDZh9aizULS3MILHSQiOiyyujnNNExCDmiMXfZRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeho+iMIUW3N6riJQswTqmPPvV4y7m7C7cjp2X1DmnxxGcUVnC
	PO1JXEPhVj+isNBdA/8hkxhoLeALf3WokXBfO4ygjTzGujyepyjvLGSh
X-Gm-Gg: AZuq6aIHbpINakf8c4LME516Q47xUumZLwhiwggBJIDHuk0SL1uj9ZyTKCYD8soFPVZ
	ggc308vGhbxx1/xhxYHt9gfRGShdaRk4PHADOjKrWMcoidACVmWtfct3Ezgmc00+HfmaHqYOU6X
	l+lIyKY8VRpVR0VQ95GHMzYk2w+6OGslwAAY8fcmgYPEW9Wx3jC7u+wzfE2GDMZb/bNAP97xnuD
	vUs9F6QKiW7J8wD0FdkYxGgZG5Na5YWxmkSSr4A9YauvqLz4Fgdp3aNGeatU1OxxfEOEwU3AUQx
	yB9u73+bUQAcpEGdnw3IkNYuwjGq+CqHS3FSUrAylbo38OabOGprjCmV76apH3Lw/BZVX0bQM4C
	3ZLgNhXL3UrfoII83OKgpzeeccylSN1Y0i4bc7itmm602jyAQIjKEdRR+gsLHwrha4qfNA9Nxia
	Eodsuz++gdfalP0N3d5uin0yKZPBCMndhmSkqVxqMfbT6qcMYJnIIvZV4JLeaJYZwcN8uTVkfY+
	5jtC32+kcSbA+k=
X-Received: by 2002:a05:7022:248b:b0:127:3b1b:c816 with SMTP id a92af1059eb24-12759a36a1bmr2420480c88.20.1771468175930;
        Wed, 18 Feb 2026 18:29:35 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577bcasm19609433eec.12.2026.02.18.18.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 18:29:35 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 0/4] ti-ads7950: fix gpio handling and facelift
Date: Wed, 18 Feb 2026 18:29:24 -0800
Message-ID: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original reason for this series is to make sure ti_ads7950_get()
returns result in range [0, 1] or a negative error code to comply with
gpiolib requirement.

During review David noticed the fact that the function also clobbers
gpio state. Fixing that lead to adding cleanups using guard() and devm.

v2:

- style fixes in #1 (per David)
- fix to not clobber state (#2, new)
- #3 and #4 (new)


Dmitry Torokhov (4):
  iio: adc: ti-ads7950: normalize return value of gpio_get
  iio: adc: ti-ads7950: do not clobber gpio state in ti_ads7950_get()
  iio: adc: ti-ads7950: switch to using guard() notation
  iio: adc: ti-ads7950: complete conversion to using managed resources

 drivers/iio/adc/ti-ads7950.c | 206 +++++++++++++++--------------------
 1 file changed, 90 insertions(+), 116 deletions(-)

Thanks.

-- 
Dmitry

