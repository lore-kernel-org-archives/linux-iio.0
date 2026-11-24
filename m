Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513598;
	b=PO+i+QV3xJWw0I1Wz0a366tzR5wnkEJXFICiI27Be7Y+ylWvhcKGFq/8hsU45PRClmJg
	 JtKfNCB7smU+29JF8H9xSDV1clLvHaDoWLa1lVCUuunmW8ZpHRROaSXwZJd64+1Iogt9g
	 Did4JIHDw2Sl/Xn9ESHuku32F0tz5M2/PTVs/hnbEmcUZQbvHTnXEA9Zt/TPIU/nVA4J5
	 NyvZnuVC+xLKRNslF4jYdu23jL9vuOK27Drot75ylVb67NHYnUsu+2qSoSn+dSiepPceo
	 Lh58GtHgxydEfM+5XO/evpURe+F+P7DLhXV+WQJ7C3Tuo2SQyIpiVypEHYPuCkmEtaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dw2szGzhNZKbIRuCqz5QNq1//TAtEEWAm+O/VeExQnI=;
	b=uzaHj2P5omzM20FLrR2GawO4Q6QoTWIwxbEzWnAOVD+Dz2TEvrHvqqXKyOVt06HFM9d7
	 ZkkaaI0t1eBuYqeEbswiXhb8GlhxEg9pRrhebLtIduGmo29QaPg0/6FeCMT52BYuIdr65
	 9gRrV3qe/zEwwMOG0nDccwHuVenwwnbzhHAbcVMVc12CrVXnD2jjl93YiUEYYExSInjeK
	 naIFrHx8FeKXd2QlVWB2+Y3vZfdGy4LIfgKuXhkXm9B6FGMYMRm22ha2QUfSaSNpwhXMf
	 9WynOg0oWd6QgX5+aungTVKcgBj3/nlCBfPxjH/8TObBaUhOVXpwOHuXiq4HvIsc//w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XrTkkVIJ;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0B606CC03
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 09:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6A0B606CC03
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XrTkkVIJ
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so37290715e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 01:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795513594; x=1796118394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dw2szGzhNZKbIRuCqz5QNq1//TAtEEWAm+O/VeExQnI=;
        b=XrTkkVIJOxi9g1abZS5IU2PN3XbVXZxOdgQbHNuwB3hQFXIzjJe6KLtEEbcyKD4dxD
         XiBMBMPe3jMdueNkFlAO2uTMJQNxVvmQnkxW49siEpTgg3ZdP8eigBhpc452GIPle7Ll
         qhSM1xVYjNGoftUNMqBbx0oyIcl/1rlCZqV5J1gdgdaX+nmZW9vEcvywix0MTFtiXzwl
         qQ/SUyiPazIzGlSYtBrFPsn0XGK6d/f99GFjwxicWHtDNp/TupiR3f8QiPIwMLskRXCP
         oAAcZP9jFFDk2H2KyOcc0tDXnzDTOpRft6ibynSlFrnhrYDO3gcg7FLblBPZNUb3vOAh
         ActA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513594; x=1796118394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dw2szGzhNZKbIRuCqz5QNq1//TAtEEWAm+O/VeExQnI=;
        b=np6fPC5jN0y+BdQ0XKc9Gl2zum57pw3ZdPxpmQvmF3cqJ4eU74K8HBkC9F4+Wz6bRk
         SA00VqE3t7QGExvmKEQmbgBhyZnypTXQWwakaR1S/8/yxBus+HkpHC6gwt1a0Toxo6nd
         D61HEwhA+bsN7AeWpGU99wZPer5sfuASUjNYojCzsANTyYU2c3O0fsprpUXBvgtAEnlL
         H6kq4zvFwDkX8kmLafNz/w1fxOU2/KjvLuQ7dzMRIHsMokbgFZndV/sO7iCM+ZG+FjiI
         TFF1K+jjTyLAtzat7KSGe0pseayy4AFkjPbk5RY5JN72uT8bE7FObzd8gy5LL6pTLu41
         Etbw==
X-Forwarded-Encrypted: i=1; AL+hErGyZnfRsh0lILJxx9ulsPXbbCkmPtGTNTXQOO0WG3XxUOYc6xFpU66eePhPrlif6G8lhS6KUoVY5K4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BC27Xp4SKu20hIhkDuQUdZYp0mVv0YpSs0jdmy0CyQTnJimCu
	NgbX/cCpLrUqWs560x7u1ZEAWmS5UFs+9i/yHpcfgW+v7N7ZB7p3YcJBcQIjVaYahk8=
X-Gm-Gg: AZFdTZf7GcfUILtRC4gGHGZqD8VGy04vBnfUFLzBvdKOWSKcg/9gNlcO2npUsF357nX
	6H8G/qodEEtLQmIra4Md61buZJ9EM6Dtj2Apz5Kh+rRtAMvxnjvrEyTTHl7ZdXEciL+VqqFiLpA
	0GjRK/WzUHsYL2a6LoeH4sE7SK16TjLI1wkxm/ELj08EUPoiWbWuTV5fqNYQuagqGf6lmmH/rgy
	ixJjf1MPfK9CufosC9C41OiaRoTd/nyo4y+vnzkruFgvkVS1zWb9YIrsmjalxqr8QUYVDgAzEZ3
	TIFygHRcykaF7KlGp2uFMBCH+HmRtZAQVUtTW26oFJvdS/vCuWvhYGmhO8X4qTu50w/XpWq0tIu
	8vA8ilYrXBXvap3VNd3jzfxlbFNipcz6JiD0vqoKHKJ6KbwhMkQ3lYMGn0FACFPft9vW4kv9Y4V
	QuRMAADX1PvvippKSp6VrObh+hqA7B32Ht4KnaUBjWgWfB0b8TL3wqGZA5o/YSdXEwfxusLpZzB
	BDOdRHZIey6F/0oHTBGfOAiTxFj3Vkdnm62viW6o+LE4Sr1h233P37UDClaBp6KRkT46LYweKwQ
	wLh6SjBhWRMQH1kG93omqtSNBg6haT0xEH0+nirmIwj9Pip4TlUT4w6fFduNn7NqHHfCrZejcun
	49jDfn9rRZdI=
X-Received: by 2002:a05:600c:820d:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4bb887c2ca3mr296620815e9.4.1795513594081;
        Tue, 24 Nov 2026 01:46:34 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm431782555e9.15.2026.11.24.01.46.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 01:46:33 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] iio: magnetometer: mmc5633: Binding, supply and mount matrix
Date: Tue, 24 Nov 2026 10:46:28 +0100
Message-ID: <20261124094632.8879-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
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

The MMC5603 and MMC5633 are listed in trivial-devices.yaml, but boards
need to describe their supply and orientation. Patch 1 gives them a
binding of their own. These bindings are also used by PebbleOS, which
is where the need came from.

Patches 2 to 4 add the matching support to the driver. I have no board
running Linux with these sensors, so they are only compile tested (W=1);
feel free to take only patch 1 if you prefer.

Changes in v5:
- List the datasheets under the section in the tSR comment, and give
  tOp the same full reference instead of pointing at tSR's (Andy)
- Add Andy's Reviewed-by to patches 2 and 4

Changes in v4:
- Describe tSR and tOp where they are defined, citing both datasheets
  by revision, page and section, and drop the older tSR comment at its
  use (Andy)

Changes in v3:
- Reference the datasheet timings tOp and tSR in comments, with the
  tSR one in a new patch 2 (Jonathan)

Changes in v2:
- Cover the MMC5633 too, including its I3C connection (Jonathan)
- Add supply and mount matrix support to the driver (Jonathan)
- Drop the mention of the missing I/O supply (Jonathan)

v4: https://lore.kernel.org/all/20261123202616.17334-1-gerard@teslabs.com/
v3: https://lore.kernel.org/all/20261123194943.57601-1-gerard@teslabs.com/
v2: https://lore.kernel.org/all/20261122190836.66111-1-gerard@teslabs.com/
v1: https://lore.kernel.org/all/20261122093412.71604-1-gerard@teslabs.com/

Gerard Marull-Paretas (4):
  dt-bindings: iio: magnetometer: Add MEMSIC MMC5603 and MMC5633
  iio: magnetometer: mmc5633: Reference the datasheet for the SET/RESET
    wait
  iio: magnetometer: mmc5633: Enable the VDD supply
  iio: magnetometer: mmc5633: Add mount matrix support

 .../iio/magnetometer/memsic,mmc5633.yaml      | 61 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 --
 drivers/iio/magnetometer/mmc5633.c            | 44 +++++++++++--
 3 files changed, 101 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml


base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.45.2

