Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452ED3B6362
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289198; cv=none; b=n7XuWTeF4E/+9pO95LlKbJfO4GRFPv2eW7fv1vRxKbyIAy7Y75LJFx6CepCBC5rg7xT0Y/mFXClc0BhdHZP2EPy1yl6FtV/t97zRMykkNZ40ZfWLnbt9dWYccA7aCj5C/IUX8rKrqS0nQASzyDw0qkvvr8jaDZuXh5jinEzpgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289198; c=relaxed/simple;
	bh=kEiZHKJqit4MGPY+b2Ld1n2nTYLDwv8qfRcBrOW6l7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XDrsSyqRzvBJRTjId29tnd56qIMq9Om5s+ghZ+8Izq+cMwzOFZLy+n5rwjSiMS9/RtSMUvOvi/v+TpsHxP8WYwIfFmmdkw2G6hmXzWVWL64ELo1lrt7/0VJC6ace3k6zyW7GvmjqrahZRZJd9W1BfgLIm7aGNRFhJxczj2Pd6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouJHjCOZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouJHjCOZ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso3757271b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777289197; x=1777893997; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRULM3iCCqXJE5g/4xg/Q1GMtMSkkTbAvywHS3WulkU=;
        b=ouJHjCOZsweVL9lNg2Usp4v33wgjXRnZuvFIyiuofEQdzgQjpsjxl+ogijdpPMIB3d
         W50c8GbxyjpiczmvXO21r0QMa2lvl1NUs3D4JU/7BP5AkSPZpGBrsytPbPJ3HNxSp9x2
         Dc1a4rRU6iPHdg4ZHL9UYXONncG/u3Zrlowvhd9Z1jr5wMOCQ8JyDfhf1y9VcQsPxAHj
         nYC+Y/UsKIsbOCUh0JS9OL9/+j4u8CVUIrWM5hJgPkqrDG9MzE2aUE9t8riOI2oREsPg
         VapYhFTVVtg7Yj6MsaEQe7aC5wfO/t5/1wXOYBQ89FlCck6wlEhIrxSQG+fj4QJru1vG
         SUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289197; x=1777893997;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRULM3iCCqXJE5g/4xg/Q1GMtMSkkTbAvywHS3WulkU=;
        b=QWkCgF+eoiOwdnyjL/qBXtNfyrKZ6bOk66EqsybQkNdxCU3LaUgSDzGIX17OlKT/qE
         4ECzPZFzwPwWyk7jbRzhIcY4aepqmMo5vvpXCZvSMJHmJMwKEx9c6QppfeYNCh/BANv/
         FVschQgf/R2D5GoYV+IL7wJMRT97+2BUZIwSamc8Vg00U1JfYTc/oulGuNOVKA8V24O8
         gm84vTsRdIK2QMHOR31mwjs3/bOkGjrQCIrrNbRn0bBovnkxQmRVVDE5zNLUmg9HUkI1
         mUJ+5V1fRTb68Y3mUvSpfB/63ZGUADh4vPM2qnuE2UjGSkxVBy513aAj69+3f6UZewxR
         GsNw==
X-Gm-Message-State: AOJu0YwTa9eq97V5B49UZONeEGAwhSJIpNX5HkeGGYBBfi4+vG3/9sQi
	Igm4u9tAQABYp9y6wjvpAoZo+qvm939AII5Ll3gjEVGwDd19nvKEHetx
X-Gm-Gg: AeBDietibIJf2J3LfwDQzaHumirlsV8JKL4IbjKiYFbn+8+0uLzFrvrlFujam97KZ2Y
	eCtHe9V+A9cjI4VB0E0latxe8ae+hM0P7mhShgnzhQQT9DUD07OGWf9KDgx/i+NDMiB8Hv+3Gug
	nu4fvgN2weQPl6DDOKO+0D7MT3Tay4fVhGhvl+eLl98P/37ML6K7ZYAyd65WKgAIz+tnVJrtifn
	BpRFXHcyxT0E2hwfWtHEB9RoYZ5A0jJ8uwBB5snSF2FFEAQ3+YjRyY2A6VHns50wzE/LAletllK
	fqStolntXfNS75wWhys2r3IxiOvKZoO7XwL7OuvDbe82f+AlzKXKHa3qB5n9Zcz9diPPl3YsiNK
	OrPA6Hju0x6IH/dvRD/5NVHXcdTgcaBagdYQ8XPm/2tTB10PQviCwAwuKjoEH6IgOVGbynrV3HF
	aILlozI5a7qIEv8peXOYB5nSGxut93QZu6IQ40E3D6VFQDdB81iNchKxnTQeI1I4cHoystl8/Z1
	F5XxsTDNDkX8FN+0ZLJrzs5nv09qJo=
X-Received: by 2002:a05:6a00:3019:b0:82f:8b84:50c0 with SMTP id d2e1a72fcca58-82f8c973bf6mr46567455b3a.45.1777289196476;
        Mon, 27 Apr 2026 04:26:36 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe40dasm31504074b3a.40.2026.04.27.04.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:26:36 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 27 Apr 2026 19:26:31 +0800
Subject: [PATCH v2] iio: adc: meson-saradc: fix calibration buffer leak on
 error
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-meson_saradc-v2-1-8981c56fd05e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOZH72kC/1XMQQrCMBCF4auUWRtppkmwrryHFEmTsR2wTUkkK
 KV3NxZcuPwfvG+FRJEpwblaIVLmxGEugYcK3GjngQT70oA1mlqhFhOlMN+SjdY7oZXtnUbf9o2
 Eclki3fm1c9eu9MjpGeJ717P8rj/I/ENZCikMtabH9oRONZdhsvw4ujBBt23bByPCEXmoAAAA
X-Change-ID: 20260425-meson_saradc-54abc52d9b31
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777289193; l=1435;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=kEiZHKJqit4MGPY+b2Ld1n2nTYLDwv8qfRcBrOW6l7Y=;
 b=OgBTJVEKI4XrARc7cMlcqcU7gP8GsABoiiF9yu7IVEyF9y6+My2J18Bx+/02Bvsj4MdK4S/nU
 QSfZVGrBreDD30Ae6PJwlEGnW3XjAo8m8gDqfw2XihWA8ZQPKwIUPfM
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

meson_sar_adc_temp_sensor_init() allocates a buffer with
nvmem_cell_read(), but the old code leaked it if
syscon_regmap_lookup_by_phandle() failed.

Fix this by adding missing kfree(buf).

Fixes: d6f2eac64403 ("iio: adc: meson: no devm for nvmem_cell_get")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Switch to a minimal fix according to Jonathan's comment.
- Link to v1: https://lore.kernel.org/r/20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com
---
 drivers/iio/adc/meson_saradc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 23991a3612bd..000e39ca5c62 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -817,9 +817,11 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 	}
 
 	priv->tsc_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "amlogic,hhi-sysctrl");
-	if (IS_ERR(priv->tsc_regmap))
+	if (IS_ERR(priv->tsc_regmap)) {
+		kfree(buf);
 		return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
 				     "failed to get amlogic,hhi-sysctrl regmap\n");
+	}
 
 	trimming_bits = priv->param->temperature_trimming_bits;
 	trimming_mask = BIT(trimming_bits) - 1;

---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260425-meson_saradc-54abc52d9b31

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

