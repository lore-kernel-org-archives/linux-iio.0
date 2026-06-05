Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77E3D1713
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650626; cv=none; b=akXNq56Uz1uUnWvfxe8DlLqbEmB86FLjJvlw4ts2W/y8XW5MPVCJm2JwLi5n8m4eKEtrV93JJ0IwI6pkrNXxPTQ1iq691ap0hjmHubY9EHuZXe+YfKvvZXx5cOVf1Xfe6yoc46tMAIAmAgP0fcALJVDDNE5dLq6olEJJJNCg1rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650626; c=relaxed/simple;
	bh=TN+eHTxvvsictDRYnCMOe3Qu306A72uP6lr108XfwUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMWPFaB5F5Txabf2CZ1xVFE1tXS0KmxwS1fzvt/z9BuWjotn/3484UZdIMxHG5qnvdPLXHpwuAtzUAB21+1XN8h8IJIuhVohu7/caGlQ8DfVnN8dGEcys5X099kymGuVuLvOvOZE9TbgeNCscq8n0QWwEx3XsBrL5t8zVOly+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/l8a5AI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/l8a5AI"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-396771119c4so17745131fa.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780650623; x=1781255423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhv+pKU2kF3hG29Q3S1s36oUyTDUZoZ+HjUkHkt6cXo=;
        b=b/l8a5AIYYZxaJR4200RtrBFj6NScb3h9dbZIG4d3ymEWz1w9BkmqZJgV4T2/7y+uL
         SdzIQ8tltmd+2/iiIlB9DhHyiU4t6L+v96sCNZf7YLvMyBSdPGofUxgSl9vfr5lK52tx
         HtnEO2lQm9qtq5ucNDRhrINNjPOusRJTEpvRTm7XHZhduTIh8hHcvDjeSc9EHtm99hGZ
         46I3+7dHaEa3JEC968i49wozmQOVWI6sFyfWWSAfB74VfooakMSrd293HxwrfV0BoMHP
         qKjXaA5Ig/bqkP53GAC8Dm3n6vBC5+WTWFSo6MGvXmfgvcyIAxYu6qg7g3jdHYyo4tJh
         TJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650623; x=1781255423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yhv+pKU2kF3hG29Q3S1s36oUyTDUZoZ+HjUkHkt6cXo=;
        b=Sab2BGqTOzqfAb9PB0P8u2AsJ6WaQCj8GF4FQ+RWVJRKBVZ6dnoAIQMpyHXqzyyL4u
         shFVAqvJ/5FknNKqTjEyDdLnvL2+4yonzBKoIK3dCZLhlRna+e1BGp3MWQcRYbeHqucS
         SKYviCdtSCi3MSbA1Z5Km4vQ7OOsSfmLy/xcc5TOtWxW+AYY8OZv8+hTcHOREG3t+ZgV
         5dXNvoorC7PEE6xlrsVy4uvbARBZwr4fh4xKDp92bTQuixbzV9nE5AwlVoZ1I4+Ir7Gw
         9waOFxzLMeHq3b0cvABHskRmcKhC7LIrC2v9qlLu8zYdyHXiHj6iuDRHldI2mFktaR+x
         U3Gg==
X-Forwarded-Encrypted: i=1; AFNElJ+cqCXxsllGzfvfCrGVx9c8tWkOWwSfTKbHEKPpTIZzI5bOnO/SCs5RaMnDgB+easrKO/AWbQrIyUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzouT7xhorFrw4m2ghFJhiB33xdoRiuYNlynlMnedLPLw4pJ4be
	Nno1pGVdWrRA/OBs25qXdtV6jEnOAXz5YLQonHZTM48+w5raQmvTBsAq
X-Gm-Gg: Acq92OGtJEBso6Hqj/fqja2E0gdb7InhefLLlUjHOUJLumaluWbd+g+EL92wQpD5LSr
	8aHWCXRVAeWBDIQj3UAlWMMGWB2fqs4J4Pf/a0j/V5/ZYkmnjKGxVj8PeGmZI/cNH/2FDRKXftZ
	N4nJttGkHVrXMSXFzYXn+inLU9dr4ilzForFezlN3WMDHgaNYtHkpAzxs5tH/7vL1y25CIJvPWJ
	P9Xxc/k9DnY4ortTuqvp93Uk1Ly1ZGHSql5/j5qiCYnFX7lUqsyRTuWbEhbermghRtcXuKLKhB3
	tDGmbqhaxddlpDOfnYArxgSxQK0xUVmWKbEGg3ncHQFDOuyDUkmgaDnxfQz55lyg9c/bxjhubg2
	gFuITU7mmAYPee16upXwZFCyeURxRiwnhxnXxR/3RR3ftKpTQe0f7M1KOtrlVLbxPjBQkYFDuvD
	QRbwH2DwYzrXvlaLfdf8hVJI6X36GcBmsFbv8CNbP9xwDHtjpHf2ezmQ==
X-Received: by 2002:a05:6512:378e:10b0:5aa:116c:4127 with SMTP id 2adb3069b0e04-5aa87bd862fmr679527e87.41.1780650623083;
        Fri, 05 Jun 2026 02:10:23 -0700 (PDT)
Received: from new-nest ([2a05:3580:f312:6c00:1b49:dfce:283c:7307])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9903e9sm1705914e87.69.2026.06.05.02.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:10:22 -0700 (PDT)
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
Subject: [PATCH v4 1/3] iio: imu: inv_mpu6050: fix unbalanced regulator_disable() calls, when probe fails
Date: Fri,  5 Jun 2026 12:09:38 +0300
Message-ID: <20260605090940.1103750-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
References: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a probe function after all regulators are enabled, runtime PM
is enabled. Before probe function finishes, runtime PM triggers and
disables vddio regulator. When probe function fails after vddio
regulator is disabled by runtime PM,
inv_mpu_core_disable_regulator_action() tries to disable already
disabled by runtime PM vddio regulator causing following backtrace:

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

vddio state is handled in two places: runtime PM and
inv_mpu_core_disable_regulator_vddio_action() devm action.
inv_mpu_core_disable_regulator_vddio_action() has to check, whether
regulator is disabled by runtime PM already. But this information is
available only after runtime PM state is initialized by
pm_runtime_set_active() during a probe. So
inv_mpu_core_disable_regulator_vddio_action() has to be called only
after runtime PM state is initialized. To handle this correctly
runtime PM active status is set just before vddio regulator setup.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Fixes: 07c12b1c007c ("iio: imu: mpu6050: add support for regulator framework")
---

Changes in v4:
 - update commit message to address Andy's comment
   about functions, callbacks and runtime PM names
 - move pm_runtime_set_active just before vddio regulator is enabled
   as it was proposed previously in v2.

Changes in v3:
 - make patch to be the first patch of the patchset for easier backporting
 - update commit message to fix Andy's comment
 - don't move pm_runtime_set_active from pm_runtime initialization,
   move activation of inv_mpu_core_disable_regulator_action instead

Changes in v2:
 - minimize call trace in commit message
 - include specific driver name in patch subject
 - move pm_runtime_set_active just before vddio regulator is enabled

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5796896d54cd8..8c8b4f9a8ff63 100644
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
@@ -1970,6 +1972,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 	msleep(INV_MPU6050_POWER_UP_TIME);
 
+	/* set pm_runtime active early for disable vddio resource cleanup */
+	result = pm_runtime_set_active(dev);
+	if (result)
+		return result;
+
 	result = inv_mpu_core_enable_regulator_vddio(st);
 	if (result) {
 		regulator_disable(st->vdd_supply);
@@ -2015,9 +2022,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	/* chip init is done, turning on runtime power management */
-	result = pm_runtime_set_active(dev);
-	if (result)
-		goto error_power_off;
 	pm_runtime_get_noresume(dev);
 	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_DELAY_MS);
-- 
2.53.0

