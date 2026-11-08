Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178591;
	b=uKwM4OOx+VRWUUu2BpijS7OR1dL6752qHOMqNot3+diX73Im370hClvf1tkA9wQEggud
	 1Xul4hV6oU8gA0iQBE+m6jGuiNcmTAW6aUuPnCOUn/uSAK7yUFaLTEoGurEa/EiXK/Dso
	 yvsIdYiCnL+cToGf0SdF5wKTc6RL7L20G+VU0K75I4ueHKmvlqk2GP8yE2oDz3vW2nTb8
	 MDvIlDO7IVNaze+z8XZV94G73tkI4fxikOEHiKljsPgxpT9e4M6FNxGoP6prVbfsb5baR
	 g1uOrut+N1C3o5wBBkpQr/mSAzYMwQq+9W/8nrtYmBIbhq78kvFJrvFFYZIsusw2DZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ong8M8NnsMoNWNiK2IwB98XwGEmnJ9d7Cx6T8KGpqG4=;
	b=iEnXrtqJjyoTTcprHey5n2wdAo+1xk9SCuD2r3WuLxjY6lP7uJb/IX1UIZmCg3mjSlkc
	 NO/it3hSAGCwKHaY/n6l78rG9UXFexdA3Nltv44U7moLwL6s8IiaHicEtQG0/ZZwfVpXZ
	 Q1IWx8KTAuibdjCQhkxUdE9jWh9c5omdCs0wPmiwzHPEEK0WsjEt/SV0CFkVb5pY79JKJ
	 GvPIypPhlVZ+5KsfDVl3dhcRyxdU4ffe+x5y54jiIsDr1a+nKqDx74nam+BIyh2bKIrCE
	 t+TbCdECAchcqD/x7DhgxquUlKK/Hmd2dWzA8TlnaoaCoTPCUkODrN2deIzHJ24JM5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oTIm5aO/";
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B303606A320
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 22:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B303606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oTIm5aO/
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b31261e8a9so1774587b3.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 14:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794178590; x=1794783390; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ong8M8NnsMoNWNiK2IwB98XwGEmnJ9d7Cx6T8KGpqG4=;
        b=oTIm5aO/zi5YcfOC6auPAsCQAocZYKj2aWt9GAeuuh5RcAFgrDzNETk6vzkRSzxuSQ
         +sz1j2M1fgmBXHqcnQa2tt01gzYQDAHRcSDVIznDW43MwetiRLNrGMrFxN5tuynNVrro
         BHESRr1qkclxcWS1vGyr4puumC39kywqq7YNawpFoqOpctspnIWmRIwHtPPSTctOAYQQ
         WpFxWpUAfbXrowcxTVSJZxcKGNipPCtcnxMDfX8P4i4q4Fn4ihOpVUuh8nVWwWHCPbvD
         nCs7eSSXzMX5oHYX6IgfT9cxTb/LOZ7Ja0hB1DVq965T4HwW/IfjcwrOxna/xJw8KUsk
         LNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794178590; x=1794783390;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ong8M8NnsMoNWNiK2IwB98XwGEmnJ9d7Cx6T8KGpqG4=;
        b=VQ2p+QG/wFnpveiQ56SXkGQlBwJ0D3BM9rA86aISltyqUXCG1aoFxv9Arq/qP2ieEw
         LV6cyx3uKlzjlBfGXGebh8ox+nEJOvK2/pPG2r0R3lj8gQOGVzKaGn7QSZ2zC1GSCVCu
         7XR2xIlvblrGNOst76aTrMppM66Qo4pk0XgPx7LzQRgceTzaGttbcwHzwU/153luiPRn
         p6mcwCarhUu0HWKHGdDQc4htjIAAYoI9fe9l6Z6sz+Uaa9Kg0y0ewoLjhpw5aFTynMOX
         Au/1E/paOgzAZ792VWH2IcyfL1NC2PUwJpU2wcdfVBJggVTButnl0tBt2bgSBR3Ut7/l
         bKgg==
X-Forwarded-Encrypted: i=1; AL+hErFfgN7TDrCZFUqGkjWWG+bn/UhSLEwUh3rrKPjB9EGer7TMFsi4I4DLCDvQtnXifurO7k2VJBl1yo4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OkeV3x9fSvfl3S+sC7eCrh0KRRsg6MgoNDTm7MUfnlgtLVZ5b
	5OyVE7QdUXMG5XUR8lEWnnK0hbIiZ/ER6FBtZ5ggWL8qN+nwvU6yKKE5CmlFwQ==
X-Gm-Gg: AYBFou2ZwsiuqjfQuVZCpkPIMosLUZSN2+8MqxWz/oo9hRJvubyFAcZD/VnSiApTUqH
	xWzNRT25Iq9K+rfJ1gQWuGLC0MrUQzvVzW3yjzesfZLT51dag0E2MxcxQq3l5hh6d2ozO5fkP5A
	QHSkAfeW4O27G4hBWZax4znGxWjpqXsAikUc1x18BD8SMeo01iL4L2+LV8BL4er5EKcfUtUWWh4
	CnwlTWoj1j3ozGqjv+UVKqc17MiHi9hs2CCZWc7EK779XvMBP0+/fnSvkOyi9PiRuW+bO2Chamn
	rv6qUUj8+tbsHnOsi2fVGmD9vGVCdY6ElOj9N61rNuFTJGsPhL+KD6q1TRjoxz/d9ZSR/2XemN1
	cCu7aQWkZ4d7RRGxrchFbE2xyBie8Vb6oboGyb/kfVaHx6czmhI1Iia15ccyTjJk+vrG8F8oEuM
	UBCxYvUBp7UV4Dro056GZdDCsg56h1pncZyi50YWumCMuAqRKo9zcszCgH9RkLuXYuiItglO7+/
	p/YKd23hfCmlUkzJfS8Q536N3EgaGnd1RibBpqqyvQ0cM14KbonguZabxi31RK6RyLznkK3Pfvf
	UO+HyAs/tkOOUi0lYAFzSHArZ9ca
X-Received: by 2002:a05:690c:660d:b0:8b2:bb94:8cb2 with SMTP id 00721157ae682-8b36cb31f80mr15270887b3.35.1794178590140;
        Sun, 08 Nov 2026 14:56:30 -0800 (PST)
Received: from [192.168.100.70] ([2800:40:44:f1f5:f400:4c49:91c1:9905])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b36be7d88dsm22485597b3.39.2026.11.08.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:56:29 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 08 Nov 2026 19:55:51 -0300
Subject: [PATCH] iio: adc: ti-ads1262: use umin() for excitation array
 lengths
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-ti-ads1262-excitation-umin-v1-1-65929a66394d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORtoiivqq4iH2KUawSpNNwZj7
 746j9/h/xcwKSoGl26BIpOafnIDHTqIT84PQR2awTsfiNwJqyIPRj54lDlq5doKHN+akft05kC
 ud8cEbfAtknTe59fb3zbeXxLr7wjrugEADYzlfgAAAA==
X-Change-ID: 20261108-ti-ads1262-excitation-umin-a5f9a610504f
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=EO3cEjfaSpMTJmz44W6v6HuhGs+DvNb3D0mEU0wKIOM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkf/v7OXJ996Ldf+/m5rC12UzyKbxtoB61htvtu+2pnw
 UO/pKLmjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjI8wWMDHsqP8k2RDf9MO7U
 /D9R3OqzjutORcH5dxXTH204+dvRcSojw/ULc5bYKMxLvL1WRUZuovzBHe/uHJoWpqjsk/b0y93
 Ad6wA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

min() rejects mixing the signed count with the unsigned ARRAY_SIZE()
unless the compiler can prove count is non-negative, which fails on
some configs and breaks the build. count is already checked to be
non-negative, so use umin().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610241549.J9R32Wf7-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202611080814.7RmHoQ6e-lkp@intel.com/
Fixes: b0b43a26dfc9 ("iio: adc: ti-ads1262: support excitation currents")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 66a7fedfefde..58a8eacc6ef5 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -1807,7 +1807,7 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 		pins[0] = ADS1262_IDACMUX_NO_CONN;
 		pins[1] = ADS1262_IDACMUX_NO_CONN;
 		ret = fwnode_property_read_u32_array(node, "excitation-channels",
-						     pins, min(count, ARRAY_SIZE(pins)));
+						     pins, umin(count, ARRAY_SIZE(pins)));
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "%pfwP: failed to read excitation-channels\n", node);
@@ -1820,7 +1820,7 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 		mags[0] = 0;
 		mags[1] = 0;
 		ret = fwnode_property_read_u32_array(node, "excitation-current-nanoamp",
-						     mags, min(count, ARRAY_SIZE(mags)));
+						     mags, umin(count, ARRAY_SIZE(mags)));
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "%pfwP: failed to read excitation-current-nanoamp\n",

---
base-commit: b70566610b48ba49dec636019da4d696db64b085
change-id: 20261108-ti-ads1262-excitation-umin-a5f9a610504f

-- 
Thanks, 
 ~ Kurt

