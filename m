Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793542530;
	b=wiSEt6XEweh+mM6Sz1FNh7nrgJ01Vn/2Wsg0RDmFMTDvyTPpz4mseQxGGmZVq8CImIX+
	 MxtiUK6+uVSZyRWaUBIG/ZaP2N8U3MRSRo8bhqngPqJ5V0gyN3hnbJR+j/ZjBKVCTVhYX
	 sYEvf1bm1r5KSFMPUxaGqY2eAm94x9DRwCOtXnephRGKjzwOtTxHd5ucSkG0RMNwIUHNV
	 DnocRubf2pO9gbaM9G/mavttOAeKXRro4vUJyUQEvp0/rhlY6ml5nzwLC09AJTbpXCjiK
	 8pGREfCB3c0+n01P6ZCK7FeihH2ywhLzbpEo0SpMAAJ/VnSfTM8bO14evS6nWlKZNkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793542530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=i+HyPC3h0+CjA+c2wC2QKJxSGQ6LFt99JUqVEiYe5TM=;
	b=cKdzjXyG2qp+MrsZd8nlAwWEKYYrpza83HZOIM86H0tuRvixz6s/KYeG5LwW1t6l/dRu
	 SxK71cew/YDCdy7Xl5C0WT23CXs03VaaO8htoW1z0g06eM6AKBE3/1AdzzvzWUOlkNS2x
	 eq8x2uVjlbl8bQTiGDhcRR5waGT2sxrvqrPVVMil9Q6pL9+xIF/Gziyfj0ZMiNU4zj6fC
	 HuZzX7ZtqQp+TdgyXdj/VmDlK9iy3MIXOEPm5Nn41TamGLcP7Y908Nm0eHAPfOk3/rirO
	 EcQs171ldDqoYFkDbF4SyCKWD/Tj8kT0ABDZpvc3JFGQnxjRIYed8WxWYmkAuHsuMMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v/0dqfDh";
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69575606A324
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 14:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69575606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v/0dqfDh
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b4f7d3cd98so964235a12.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 06:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793542529; x=1794147329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+HyPC3h0+CjA+c2wC2QKJxSGQ6LFt99JUqVEiYe5TM=;
        b=v/0dqfDh/LLX8QuRh45hi2LGiNbiGbswWBbiecwizZ7IU5+c+Mj8bdNQZs8JkVPT/Z
         mk5A4AAKTV5wdg8mRDxqoIEHPsbaykj+7nFV329SfGhcfdAtFWx5RBCv1NXQcnfDL3yP
         +EP5Je/iBDNzFe70NuX/EghwgVSEbDM39NNh4W96uEkY11yLRaR7LD9TGNbd+DocD8zN
         O2V/TtKTu8g+juww1i8It23ymEObXfH7rIRurTQ2Bylvr8jvYzD/1sGbRgiXlPKE5J+F
         cz9op2k6jamY3DwOWtxxWrdLKljI9M0a6r8xZs9L7tYIRafDql7+MAbA3NW4a9jBvgBs
         cKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793542529; x=1794147329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+HyPC3h0+CjA+c2wC2QKJxSGQ6LFt99JUqVEiYe5TM=;
        b=d/6bPNVlG48V7n42L8Vf2zhhbP+q8xamXjycjh39qBAmamDBbcDqWtx3V42CPFvjqM
         TMiQ4qjRE9WJsogrIoCIhAl343qDpYRNlyWHWY58gwMxE47DinNQbP4Os7zxed6T60wb
         deQBMoIOkdHkpxRPCo8J1QuHQB3MRsjfAHnUo+ZKVqVSU4+2DFCcd0x0E0u7tXr0PS7b
         aeGaIcG1yD5TX848H7ihq3UDXL0PCdo4pfQCpsWhjCOsQTMce9FReDIdNptHDspwyBCw
         L/rd6031SB9S0j6PPYG/y+BQaoxwk7gd2Twf1rM1hZMCLPuu/5IlBl1VHkLaTJiCC63U
         b0xg==
X-Gm-Message-State: AFq9FYKpZgr82NiJBQZb0jb0DDaaQKLA0cs8JNXkagFEbPyV/UfNo6Di
	VKH94YOQh5M4ia8cQ/AOP1y3wF/BK7ro6ahjUiFYcHAwYu3r6q+O8WbS
X-Gm-Gg: AYBFou1oJmM00fNMnItxYIUyeerv9UHo8ca102FfZJry1pONZ1/hrUzNrTQLZrHanZM
	emBTk/ksZ1ajCWOA2u4KH6v0K73MkScs0LNRVsHQsqF5cwdMaUZUIDn8iAVvH5/ddn2QI560BM+
	FHPjvdu9WfkljZl216FLOLC4KtidFzg84uB5SFlRJBPAW8IyrBCPc4aWSGWDBMpSz45lbeLrep1
	UPGLBfOvQzHKvLqieVjerG3ySBxCwB2Yu6ob9YQ7et/pIseuNKgPIJHyZ2LZlGAPANEVf8GOSs1
	1YXSlX3a6ARrQXtHqVC9yvEVrD/lhWdva+EOKZu9UaNiC32HpIJbjwxag45BdDEJ5Zw5krNItpz
	ysXf8NjV17ZL9UHyB6Dvma9SNLpxoD/0VBI7bSzzoEIrFeqbYA0IuTr0ai2WByV0k/dqVTvhDVh
	D+5Iyuj1C8g3TxHUxIJEY1Q5Pi8C6eFs2+qF8ucGHpmJFXpkE1PTBfmmGwL0cOiawZucZBtKQVj
	cGOEspQeIGnxQT5M4XaXe4GXwhehb0eeY/GrhggP/GAIZVdnowmqrbzthQ5epasK50T8QHubJYO
	0J5oF29XkcmPK/WG6pDMXolY2QjdvsP610sXHcqiaygdPHb73Q==
X-Received: by 2002:a17:907:961a:b0:c31:91f9:60b7 with SMTP id a640c23a62f3a-c4ca7a69731mr631054166b.34.1793542528615;
        Sun, 01 Nov 2026 06:15:28 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18ec5sm281769266b.12.2026.11.01.06.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:15:26 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] iio: light: ltr501: Add LTR-659PS-01 prox sensor support
Date: Sun,  1 Nov 2026 16:15:05 +0200
Message-ID: <20261101141507.119186-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
nearly identical to the LTR-559ALS-01, but omits all elements related to
ambient light sensing.

Svyatoslav Ryhel (2):
  dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
  iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor

 .../bindings/iio/light/liteon,ltr501.yaml     |  1 +
 drivers/iio/light/ltr501.c                    | 58 +++++++++++++++++++
 2 files changed, 59 insertions(+)

-- 
2.53.0

