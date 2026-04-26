Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3823EAB4
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202682; cv=none; b=tl+O2rpHDYRrM41DXpRyH8r+lwsKvaUwsNJftcQWBzOt5Miq9F0tF+BSBcdDadnsdr9dBmWdDbp/MbQEFwi/Tyj/38MDqf05NT7EgP01jWM6q506Tu6K+36l+IaRPe4FRAuU+/mFPGaU2F7AWLNDi0xA59YDQZ+8rPdVOeEIXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202682; c=relaxed/simple;
	bh=/jmB0fipwl8okFB2Vmucadgw0UcFEpeu5ZevPPsDyIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEuh2pjmMlsCvW2m0iqC9Pq0M3HMJbgdrmGzyTvZU4Ldcgdk9sVYCaKTo00p+XhP6nXYQ0sZc0oTQYAdqmxWbpINnstBil6QyKBR08HlKZHwGFcvZbbV9OjEUxg2LsH+ARw5ILuPq2hBpZipFVBvUakoyACj6dx1a5rT7lEOwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnUXevz9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnUXevz9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb05b1875so5385308f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 04:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777202679; x=1777807479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz1CIrJzu+0kl09RZSfojpdkCNsJ2tTjzUAFrodJSzI=;
        b=fnUXevz9mAyz1nq5vTa7976D3x684OZUY/EHfoTTR1jbn8U0ZoixnLR2QtSira48F7
         4TU4TRwDDqENNNRNNab5WSteKAOzkW9X0auPQk8bg7BwYtrKhv7AIXzUaE2c4DA70dxd
         MKVCyqBfRk/bepU2HZA8XgZ2NdsiTLkrywexdE9ThJ5YcRiFtdjRbdweGA+mxODzUotE
         wn2z6OxGHMF10GZpvoVaPCTkEY2UMXyudyym3FnBV7SriNzKuRBLPuXWc/GMZjdHlsCN
         k4fBj6OSTV85i9qSPUI8vAer8/MI7aQUQqVJpY1xK1yPMJ24vmfWtR4sWHZhgDX5fUTw
         4N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777202679; x=1777807479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wz1CIrJzu+0kl09RZSfojpdkCNsJ2tTjzUAFrodJSzI=;
        b=mQi/QhzEjQkOuaFFo4GSlseKiyce9FD/par8/8wi41u3FENygLRRUGDvI9WfyjCFTw
         zrSKZzBXrZDbiRsNUWaSKogjG8DusEMvdG8XgKKlUPNImlycA9q7/mZmb6TGoWHqv7Z/
         Y9UVt1DwTunNT2vNksi8Sg7+hOugkSGBDy/aSTaPgXiD1l3e4Uogjolyx7IT+4TLaliy
         RLG7NLP/agGdwEEThNssqOt1cPM/veYWwHuGcZBfedhVySa9CHjEEpKvADO5LVUq2Ehl
         sYcRfsTros/LxBd5F9gO4ti0w+Yocp8koyz3zgD7VF7+eTYcizzg7A0IKsDsPWHtMeFg
         j3Tw==
X-Forwarded-Encrypted: i=1; AFNElJ8mfqGxQBt68fyV1TSIqpZPJ8rBCQ1SDjadamKYRiaFDa5IXoQb04h8jKj1525HkPqgNDGdC/X+BS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntV0CEYc/JYAeV2amNJNaAyv7VMhPf/2hd9O58nQrKKJeVJDk
	4tG89LEwRBGqty8jf3NeTa7b2ybTnYYYPzo+dHXchSjowUIXlhVd6bOT
X-Gm-Gg: AeBDievU4v6c9zrM1BjqnoA1IkH6Z//9VixtlqRWpyJr7hflFa6cIATr5AREI6eQYtK
	wozYxsqbyN6alrLJLQzPkwkwkTuC3Tsp2ABIV8UKgM30BXrUpgnSUXW2d5v9XGY1SVP5gPeXJNC
	FmDwGKtFgJfB5zO81O+gzHwkd/EhTVoMOMYgOVuq6BQWGT79rcoVldo6uv8aQsHFka7hWQ4wawN
	InP150sL6nWx7Pf82Jd4MNqVxJODM26/IfOlAflunAmz58kc3D6wRvwHyzQIRVppyrriBoyOfzA
	egcNShQLi89h3Lq8uaQUtHOL+8EfKalHoQoGoTeyrYbKvql3gy/qlZjbxWVVih8ev9VcJGfcvZF
	bfWNmxU82n0nq4CN36vwlziG/9w2A7xJ3E8Qovj+1wAQqLs5OO28+q68eU+dW3dZ4a9gwCQC4b8
	PKMxFCpdl6lmQNz6dRBFKjPuNQAMjPsZddh3np
X-Received: by 2002:a05:6000:186c:b0:43d:7946:badd with SMTP id ffacd0b85a97d-43fe3e0be7bmr60192582f8f.35.1777202679120;
        Sun, 26 Apr 2026 04:24:39 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm33285999f8f.15.2026.04.26.04.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:24:38 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>,
	Rob Herring <robh@kernel.org>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v3 1/3] iio: imu: inv_mpu6050: fix unbalanced regulator_disable calls, when probe fails
Date: Sun, 26 Apr 2026 14:23:32 +0300
Message-ID: <20260426112334.3938774-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
References: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a probe functions after all regulators are enabled, runtime pm
is enabled. Before probe function finishes, runtime pm triggers and
disables vddio regulator. When probe function fails after that,
inv_mpu_core_disable_regulator_action tries to disable already
disabled by runtime pm vddio regulator causing following backtrace:

  inv-mpu6050-i2c 1-0068: trigger probe fail -19
  WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac/0x600
  Call trace:
   _regulator_disable+0x2ac/0x600 (P)
   regulator_disable+0xac/0x148
   inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_mpu6050]
   devm_action_release+0x4c/0x88
   release_nodes+0xd8/0x178
   devres_release_group+0x214/0x3c8
   i2c_device_probe+0x6fc/0x9b0
  ...
  inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5

vddio state is handled in two places: pm_runtime and
inv_mpu_core_disable_regulator_vddio_action devm action.
inv_mpu_core_disable_regulator_vddio_action has to check, whether
regulator is disabled by pm_runtime already. But this information is
available only after pm_runtime state is initialized by
pm_runtime_set_active during a probe. So
inv_mpu_core_disable_regulator_vddio_action has to be called only
after pm_runtime is properly initialized. To handle cases, when probe
fails before pm_runtime is enabled, explicitly disable regulators
in error paths.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Fixes: 07c12b1c007c ("iio: imu: mpu6050: add support for regulator framework")
---

Changes in v3:
 - make patch to be the first patch of the patchset for easier backporting
 - update commit message to fix Andy's comment
 - don't move pm_runtime_set_active from pm_runtime initialization,
   move activation of inv_mpu_core_disable_regulator_action instead

Changes in v2:
 - minimize call trace in commit message
 - include specific driver name in patch subject

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 25 ++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5796896d54cd8..49fdf33adec99 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1862,6 +1862,7 @@ static int inv_mpu_core_disable_regulator_vddio(struct inv_mpu6050_state *st)
 static void inv_mpu_core_disable_regulator_action(void *_data)
 {
 	struct inv_mpu6050_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
 	int result;
 
 	result = regulator_disable(st->vdd_supply);
@@ -1869,7 +1870,8 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
 		dev_err(regmap_get_device(st->map),
 			"Failed to disable vdd regulator: %d\n", result);
 
-	inv_mpu_core_disable_regulator_vddio(st);
+	if (!pm_runtime_status_suspended(dev))
+		inv_mpu_core_disable_regulator_vddio(st);
 }
 
 static void inv_mpu_pm_disable(void *data)
@@ -1976,23 +1978,15 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return result;
 	}
 
-	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
-				 st);
-	if (result) {
-		dev_err(dev, "Failed to setup regulator cleanup action %d\n",
-			result);
-		return result;
-	}
-
 	/* fill magnetometer orientation */
 	result = inv_mpu_magn_set_orient(st);
 	if (result)
-		return result;
+		goto error_vddio_off;
 
 	/* power is turned on inside check chip type*/
 	result = inv_check_and_setup_chip(st);
 	if (result)
-		return result;
+		goto error_vddio_off;
 
 	result = inv_mpu6050_init_config(indio_dev);
 	if (result) {
@@ -2018,6 +2012,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	result = pm_runtime_set_active(dev);
 	if (result)
 		goto error_power_off;
+
+	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
+					  st);
+	if (result)
+		return dev_err_probe(dev, result,
+				     "Failed to setup regulator cleanup action\n");
 	pm_runtime_get_noresume(dev);
 	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_DELAY_MS);
@@ -2114,6 +2114,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
 error_power_off:
 	inv_mpu6050_set_power_itg(st, false);
+error_vddio_off:
+	inv_mpu_core_disable_regulator_vddio(st);
+	regulator_disable(st->vdd_supply);
 	return result;
 }
 EXPORT_SYMBOL_NS_GPL(inv_mpu_core_probe, "IIO_MPU6050");
-- 
2.53.0

