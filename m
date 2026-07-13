Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E2385521
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980070; cv=none; b=cf51bU1hdPeyZi2JqP2h0okknCdC5bsqIol11Nmc8s2o/YmUFGRmqX04+Mav/Qzvjgiph5KzP/QSpTE9kmx0hp+u1kX9/p2ra0URTubvQj2yHrFHaq4kDV0EPkmrWMjqhJo+FK4lPvcjhjkTiSvr32u+qtzm8QVAfY3Id0nzkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980070; c=relaxed/simple;
	bh=3i0VmZi+LYMFWsCmT0fJCkxvyZBQrgI6JxUuL2Gd5fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYnPk2wf+ZqRvQFEh5/ud7ct0EPr7oA8EJ9Vp0XaO61Fi4G5GbFPOZIZFLDxEzFIPD6X+oAvzvBfBYGUqoTP4EKZ9UepD1DcTkzLXTqhQiOM4yEqAqnIuOTb1G1gMYz04TKAHq8ylcVyT5yh++QsqLWIMgKpUoKJ1iK1LgpcQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSJuPC+O; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSJuPC+O"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a45b3f0becso776103b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980068; x=1784584868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QrTVE/Mu6/5riJy+kNkxdxgxE9eXKFOB14tMMq5+tOs=;
        b=QSJuPC+Osxa1zhROFSKc6xuqXv8jnlOsGwCrGi7dnJ/Sj4ptyQZ4u5Zi5Gp32v7Ucm
         Iw3nlAA7R1/pelg/qcMlbFo32ZJuXk40oXl+3+3PMEJC6ihGDaJYhgEwvuJX2cRuRb6Y
         SkUhE4ZeyvMdsQKw8g6YxARln7PpYO5+7Q1jJOlyH02I2//+wLFbSm+Bzl7n+fFutRuM
         XnBOLVgozCHNpnbQ+U+a6sEYsELIcVyveSicfEGSe+FojvNO583rnrwrNH1DZzAET67u
         w/m1rFaplRKkTHlF+4w19rqduHHPbHJR74aY7UI7CRDamUnis3p0r31OnJ42u8Kx3iGS
         U09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980068; x=1784584868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QrTVE/Mu6/5riJy+kNkxdxgxE9eXKFOB14tMMq5+tOs=;
        b=lqrGxLDUf/rqUqGsCBVbTSOoMIIvWQaye7NQZHT5j4vvsRsYN1hdnkA7JrQpVffIo5
         uznaU49zy6WKPv1tHKGJDa+5yQotIy+6M1+fQiOjdk47Mgoi0hrpW8odMKKQaWxu6XGc
         9IMLbSjdt7KJ7PsPDGKqgQhdie3/7Cxh0jHySbf0cj23Xrv+tkwUFuywpkC/lv7Ht4/A
         xdqaxnXKn/bwIIIK1tk2W5cu+uKd/5z5opqt/ei7T2HsVfoTsjPOGqNSB3rJDXZIaBsS
         Y7yD3LXfvXlErMrFjHqIUCYJ8ItRljtyvhQopFoWLQGVCSBRCk3ThZZpEw/4HgN4O9CQ
         nHcg==
X-Gm-Message-State: AOJu0YyI90LXK+/eX2m9bbg57TQt6DpYGh0a8HbtOFwLImw7yhE5YUou
	4tVWtyULDubvRxmtauw+SeWV00BBdIxfvKSvlbIED2sNKQNO+90ZeCOZ4xUd+w==
X-Gm-Gg: AfdE7cmcdOnSS46ZOykX8zLPx7UvZoR2SsExufigCu5fvS47w66O8QI5NTc81/zXaAh
	CQItmCtXlSP3vr8P93+K6gRZoIaL5YjeO5sbFEkBEhqemORZdd3pdRhGCFWD/Bfl6GO326PBj6I
	MrEZDvMmt+5gqb3VUPjWsqI3Rpygi6NxEnH3NG6u8VitfadryflHFfxwj8+O4on/xvH2rp+b7a+
	U4vaoj8vTXV2DNC2o00JzlWnnXxZqJhbppdhg60dHLwvqGlr9pSe6Xmj5l4z0DZ0gJPlz1wt1Oy
	Nh36ZMwqbAabgrSR100OQfXX38CzITs6+sAzTLy/GnhEP2kJApLmMPtVmYWQxkPmO42DK0lNX79
	8HOLvJpOXOSpE2EP6F+r3wafMH+OwwZM4yZbQsdQIcjSFjd1TTXn1nFqbVby6hKGU2jRMOgay8d
	087PbSAVEu60I=
X-Received: by 2002:a05:6808:c3f3:b0:497:e15d:207d with SMTP id 5614622812f47-4a42b0012f9mr7109311b6e.40.1783980067884;
        Mon, 13 Jul 2026 15:01:07 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm12939785b6e.3.2026.07.13.15.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:01:07 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v16 03/10] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Mon, 13 Jul 2026 16:58:33 -0500
Message-ID: <20260713215842.69097-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713215842.69097-1-macroalpha82@gmail.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the ICM42607 and ICM42607P inertial measurement unit.

This device is functionally very similar to the icm42600 series with a
very different register layout.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index f6f97ea03038..d62aa4f285cc 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -30,6 +30,8 @@ properties:
       - invensense,icm42600
       - invensense,icm42602
       - invensense,icm42605
+      - invensense,icm42607
+      - invensense,icm42607p
       - invensense,icm42622
       - invensense,icm42631
       - invensense,icm42686
-- 
2.43.0

