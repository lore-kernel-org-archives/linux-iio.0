Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECDF3D0906
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173130; cv=none; b=TmoTapQTZY3iNK8K1X2n4dYbMH+f5IgHJkerL/QZ1+U2ZV1CEu0H9GC7VAiTirGTpYVvyuqYYzpEzlZPSQhx+M8K78P/P8CmR2KieCrS+I478hOEi3keFQM+KFiinDjA38KeGB/aJdru+6cWwCD0A1upkTSFtdY6E4uDzsSqeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173130; c=relaxed/simple;
	bh=Z7KkLhRFeePaDbwSTDbKrcgBLW7TjWvswDGzCPD4kT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dKXJZuEmKqCILo2A5DvoUx75mCQo/cOwdOQJobKDybVtD1t8Q0wiDYV27f547AtsM29mTXFLSB3RyemZPe7jd4LeFnJ76UhTtp5q3HiI2+GaVhXprNVPqhUv5uEjA9EAF8NctOQXx1i1vnoiudrbOct1AROW7BnVVBUi1bMJhQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv7aEvua; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv7aEvua"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8296dabef74so6713263b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173128; x=1773777928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJVrvD1HBF3SziwDh/X6OiTy3x6h8raUxjDiyEKbXMI=;
        b=Cv7aEvuaTJjlxE6ToeboD/dDUlVCCmRlWL5q/si49UqpzZ96jRfnNWm2XQV4AwJL5c
         no0+uC8+/RWx81OE263dpcQte+5LSDSQVoKAGcLVZCHAdr5VaVOM9HmFDFv4et65+fbk
         DFeHEl6WRIURP3d2Umu4KmBrEtKb32xdsnTm1qyEEYyodR+wUnINWtFDwVvlihaPKPch
         PHQ7pIUlNNc9C8jXmuE1T48kR1/+uLbMOS5fy/qCTeoFg2KMQKrjkHEXcj06j6/MUe3m
         UFeFXROmlbG1RMAggqW3+Nel9ovYOm+G8T6puzTipRzoPytkaCWcXjPN/WqMzmRQksIb
         GqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173128; x=1773777928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJVrvD1HBF3SziwDh/X6OiTy3x6h8raUxjDiyEKbXMI=;
        b=DyNmlDyVvHbgaUpwBQPOGjf7YOwXF1d9AUIp9uKlE44hWpKlHWfMmnbU8bbZthNekB
         K5tWLk/NIWid8GuSS6rSlaM0tU6vOWI6WKqXL4Jiz+2g61FwerCOR5WV2s98RV28zN9P
         H+WYDD3N5Imly2/U0Uve7AAmhjqa+SP5V7OtHqWvQpOGr+j5HNRSK/9qvKeO1zjzTaLF
         pXbggvLMR+EsLvT6OjiibsSAxVISSzl6haad+lvaMR7v3gt7SUn0TyhevoizAKZ7JDP+
         6p6p+Dv/Je5zGPcW0TKJXh3D17V0mPp+sgaDWUVNppMMQ+YCUkLYML0OV1AHirV08bEs
         P/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkRpxzKpgy8vhpdo+jwQuHITXf2bECzRLRTK4EkpGUkDadgqMniALKvM47l9UsyzZS/FquJvD+y/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymD0dDvz3XJPIWXzUpL5Kul+b5SxsxzHvkQhSfIRbZdKO3qdmQ
	fI3yi57yE9HLj7xEsuujvXZ8dqI0WY6IXRoYi1/TGFdFXd+Jf+xnpjI0
X-Gm-Gg: ATEYQzz20eR4NKZGKCMQuE6ihHDYKfXrMwJ1T3kXOUJuAxiLlT/C8diplgfvz0l3hIQ
	59TUtfwWp3+TAWbTIB8kcCIMhW0IamfASKqaAEazSe3tWOEpQTdb/ziiU7+mDvjQJgdm/uD+E9+
	trvR2Qs/S38781QoZjPnlXwGwY4il3F4H4lIYmy+F6fu2/ud/darI+FFbUIt2Q/gXmW+9qLRYdl
	8CVhmiTlfEyQn+YQA+ZmfVdVzl29D5blu5LWmpa9kAryARQKriiBjhVz2E3rnmukkk76krg4mfQ
	4AGXLIMF7Z6+V0noJt7Foatw2cnyI1lUV7zrRvcB1/E6LZ08ofWcluKPqgqD+yxV/T4/EWu8VKR
	ZaVsBnc7YkoBik6QiB68X0iXFbt6pUCyA2xKNLwBH7GTiWg3eZCrKq4D7SAZm2bkcpuJvTVo5MR
	fU+m0bYWxzZc32C2qrSpbmquHE2Pv2O3MIznQzFS0q4PsRMIvP
X-Received: by 2002:a05:6a00:4fc7:b0:829:8bb4:1030 with SMTP id d2e1a72fcca58-829f7104ca1mr127969b3a.42.1773173128160;
        Tue, 10 Mar 2026 13:05:28 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm101660b3a.13.2026.03.10.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:05:27 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	m.tretter@pengutronix.de,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	kernel@pengutronix.de,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com,
	maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org,
	ribalda@chromium.org,
	straube.linux@gmail.com,
	dan.carpenter@linaro.org,
	lukagejak5@gmail.com,
	ethantidmore06@gmail.com,
	samasth.norway.ananda@oracle.com,
	karanja99erick@gmail.com,
	s9430939@naver.com,
	tglx@kernel.org,
	mingo@kernel.org,
	sun.jian.kdev@gmail.com,
	weibu@redadmin.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	sanjayembeddedse@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH 0/7] drivers: Simplify cleanup paths using __free
Date: Wed, 11 Mar 2026 01:35:06 +0530
Message-Id: <20260310200513.2162018-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi all,

This patch series replaces manual cleanup and explicit kfree() calls with
the __free attribute from <linux/cleanup.h>. This modernizes the memory
management style and simplifies common error paths without altering any
functional behavior.

The __free attribute provides automatic scope-based cleanup, making
resource management clearer and reducing the chances of missing cleanup
on early returns.

No functional changes are intended in this series.

Testing:
  - Compiled with W=1
  - Build-tested on i86_64

Based on:
  <linux-v7.0-rc2>

Feel free to share your valuable input in context of the cleanup API.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (7):
  staging: greybus: simplify cleanup using __free
  iio: ssp_sensors: simplify cleanup using __free
  iio: st_sensors: simplify cleanup using __free
  media: mediatek: vcodec: simplify cleanup using __free
  media: chips-media: coda: simplify cleanup using __free
  media: allegro: simplify cleanup using __free
  staging: rtl8723bs: simplify cleanup using __free

 drivers/iio/common/ssp_sensors/ssp_spi.c      |  9 +-
 .../iio/common/st_sensors/st_sensors_core.c   |  7 +-
 .../media/platform/allegro-dvt/allegro-core.c | 95 +++++--------------
 .../platform/chips-media/coda/coda-bit.c      |  4 +-
 .../platform/chips-media/coda/coda-jpeg.c     | 39 ++++----
 .../mediatek/vcodec/common/mtk_vcodec_dbgfs.c |  3 +-
 drivers/staging/greybus/camera.c              | 27 ++----
 drivers/staging/greybus/loopback.c            | 35 +++-----
 drivers/staging/greybus/raw.c                 |  6 +-
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 13 +--
 drivers/staging/rtl8723bs/hal/sdio_ops.c      | 37 ++------
 11 files changed, 78 insertions(+), 197 deletions(-)

-- 
2.34.1

