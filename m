Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623265;
	b=HPNxLw3na7KmCCGJIZfFwikpxTLO+/9FLL4c4/PQ9lt1c5OSIdohKt7RaN+g41pCf45M
	 K7x52NNQBKUpTnmnccobO+qq/IPsSK16flL8kx1fAZp4XOxb2xm2qNFoDcYf+MOHDg/0w
	 Tqy5qsiV4eD0C55Ve/WQgyUQmSFq5sPhBd5FlMwx5iHJ0aFch2sA4YEQYdvEKPo335h60
	 ez13VPjI6LsW4qGPWV3SmsD1lNa3cejZGVi2SIlWodVRSsVLO2RGM29E3NI4oVO84amal
	 zcYRFQoebXUHtFYWDJJKfdGrW2KO3F4iCz+aKLVK8nhJyapD6mu9NwazWmpdtoeBQqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M/HCi2uN/jq/lVCP/nbhRVGKxJtO5i3puDSAhzll2fQ=;
	b=Xh16i2/TwO0c6tfDDnwYk1Mw2C2ORvQJuL82S0iMVdA5+O0cJzkjkzy8QmCaiJEjQtzI
	 cyK0yNedAYu+lN97cDzN8h2FZ3QWyUcDSb/bxNDqIZxwfgjEM0tYilQxbWVlGzbZTh+EO
	 cIPI84jWAlt/bmFuZHuYzNGDuyElPkGyg02pD1PKvCXsdiWMewcF3pNbEwz6VS+t6rDKC
	 3MO3D4EJ1zPh3ptpgMnvYW1LwOuoPslzly+GqxFBp4qTQO9WQOHOXe8ipx97A0tZSiXj4
	 xIsTsnxgx7hZDXsQ4KosPXoIneegYkpOhUNsKTKoN7WxugJdGmwhKU0WKLaIMZKswaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LULCyG0N;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703E606A31A
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 22:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9703E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LULCyG0N
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35ef6b49813so1650346eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792623264; x=1793228064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M/HCi2uN/jq/lVCP/nbhRVGKxJtO5i3puDSAhzll2fQ=;
        b=LULCyG0NF8XpZRm6yFjaDBqK8WHmyzAGJg9YsvXN/iSa8G+WPnlvofYQhtYGP4qwJP
         VthbE2b9UlAWO7kz+Vd0PFLMrkgETeaIRIxi6+wd4eGQGro1eh6jlgG0sqyy/FRI1jRZ
         4XjgjgDtLLg53RSkMPNR1pUlM0h7h3DpMZfhSDAsk0Tt1/y7yCuxgnyIITci1scL8ujC
         iPqAUnlWI/xazld+rvOfOlRKcV/5fcjXNeJQbgs5ppmm/IXHb6hXFWKDvXSV3PQfOegg
         ZVkWreLBGibUbs+x5pVK7G2leAFuFlXVBz/mt2CTmKiEqDDMpJkhiPOg6nOUFCnqdeUC
         0/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792623264; x=1793228064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/HCi2uN/jq/lVCP/nbhRVGKxJtO5i3puDSAhzll2fQ=;
        b=pSWrrCJxRxFYEEL1EthbYxQVzyVobcQ+JXTBTMrV8rxxnPiobU0FrYLho7tUXZ90oE
         BrWJr3s/2RqoKjYCnfxsYfc0xwn3HfMlh5ov7ac/L9kPcGtYeemJ2b9YnqnECbH5okus
         E+q0c5CtPB1I57VxNyUIZj9uFpgj4BiRXOT5nG8n68T4RxVixQwDr27Tw3GwxzEy1XqN
         Zm/h5Q9DKJmoeJlHASjVDPn0usrMsRLkaB8qAISHfApZCXL1VNy96qbCD30GIp0Ix0vd
         UGQ5lOf9b4SHQZl93K8WDhbx5Mtwe/tloAwVfbRvZHMIPuSTFrgrH6e5GvTm5BRUshwe
         HKhg==
X-Forwarded-Encrypted: i=1; AKwUvBzD/ZwqJBJG6E86z3VQPJLRYESDBefIHvTdHe96eQ9ii73ZQ4z29HM7m5VO0VaJkQJzGz0eaYT2p2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvzWZvchZBM0EU6xomvU9nc8sR0XN/eqKJ1KsWvBopNcrrWs60
	NilvKlmqFrn0PKqvrr43FtCKFB5PRSVdAhxOI6WWJ6+59plS/JxObCTd
X-Gm-Gg: AYBFou3tk1fRZE7nN72tJhbBonYcZvxQH5BuquEkDPrUL+riekTa9/htz6y24bQqtMO
	tYzrNh8jsEHp2kueQnHikEPPC925+a3oip+3CiCf4n8AQjpTBylNoTZef6pyBBQgbR23cavN9cE
	jc2wRaI81tn4Nd7grsBrMfIq550DOeCSxbcHbQZNjre0/vA9Y3qEc1IOR/XOzzHHDQynqu1vqqV
	Zmub7DWhpHU4U+10i6uZfD92Fto62hgJPyF3TYz3YSNCDosQFWYsZbdgwmx3Ie1YSKAKeLB782X
	m3eC2O2+inOaKt3dP93Z+zig+YSwhWx6zyIRHmXUVRxRgvSchXNdzua1Yqr/HXr2b5/N1RF4AhK
	OVhIxchgIJm7EikukLgJvmdVylS7j/vp1YXeNVUZaVc36WhS4eOeVaPWMXnZ5N7a3k2lWLkf6wI
	G/VpcpfDbOp9E0o0Cndpk4Rf42MVrlEgBOs7RgyolyHNE/65BHjZaHJcwLCtVRtsaFWq8gTDe1O
	UpY4SfgTw/gAhUoE9twMlnWEuWfBZvb+xj6vKamQAnGyaMt9W6N/HkzoeVh5MN5s6uQisSkorH4
	xeolzpyybt2/sSvaKgLQg1m2cA8tGb2mTY7Ryuyk7TdoNjQuN1iN4jqJunXxgml6vF9++3hZwu6
	dxT58iNtRRkVf
X-Received: by 2002:a05:7300:e9cf:10b0:365:b147:b458 with SMTP id 5a478bee46e88-3674b52acb8mr5389019eec.3.1792623263512;
        Wed, 21 Oct 2026 15:54:23 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368ee692656sm439219eec.28.2026.10.21.15.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:54:22 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: proximity: sx9324: fix out-of-bounds read of scan
Date: Thu, 22 Oct 2026 04:24:11 +0530
Message-ID: <20261021225417.626946-1-kapoorarnav43@gmail.com>
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

The scan period of the SX9324 is selected by the 5 bit wide
SX9324_REG_GNRL_CTRL0_SCANPERIOD field, so it has 32 possible values.
sx9324_scan_period_table[] however only has 16 entries, it was copied
over from the SX9310 driver where the field is only 4 bits wide.

sx9324_wait_for_sample() indexes the table with the raw field value, so
all the codes from 16 to 31 read past the end of the array. The default
value of the register is SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS (0x16,
i.e. 22), so the out-of-bounds read happens with the default
configuration of the device. It is only avoided when the device has an
interrupt line, as the wait is only done in the polling case.

The value read is then used as the duration of an msleep() call, so the
sensor is polled with a completely random delay.

Fill the table with the scan periods of all 32 codes, which are the
periods documented for the corresponding sx9324_samp_freq_table[]
entries, and add a static assertion to keep both tables in sync.

Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 13b4ef2896e3..36ab83d3f493 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -279,11 +279,20 @@ static const struct {
 	{ 0, 250000 },  /* 11111: 4 s */
 };
 
+/*
+ * The scan period of the SX9324 is selected by the 5 bit wide
+ * SX9324_REG_GNRL_CTRL0_SCANPERIOD field. The values below are the scan
+ * periods in ms of the corresponding sx9324_samp_freq_table[] entries.
+ */
 static const unsigned int sx9324_scan_period_table[] = {
-	2,   15,  30,  45,   60,   90,	 120,  200,
-	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
+	1, 2, 4, 6, 8, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50,
+	56, 62, 68, 74, 80, 90, 100, 200, 300, 400, 600, 800, 1000,
+	2000, 3000, 4000,
 };
 
+static_assert(ARRAY_SIZE(sx9324_scan_period_table) ==
+	      ARRAY_SIZE(sx9324_samp_freq_table));
+
 static const struct regmap_range sx9324_writable_reg_ranges[] = {
 	/*
 	 * To set COMPSTAT for compensation, even if datasheet says register is
