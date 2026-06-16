Received: from outbound7.mail.transip.nl (outbound7.mail.transip.nl [136.144.136.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4F3644A2;
	Tue, 16 Jun 2026 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614942; cv=none; b=mfQ02ARJrkyvZk8MDOMZqzuSjOXo3Sy34KM/KbBq80LEoy4hcIluOEjDxfqSAgzPVJ5VBFqIgbCPkQNcrcUBzbzx29eZiuXDdN0uGF0UUz6VPHCQm5wWAhOHRz5ieyFzFj736Ditug5yIwpSzBRu58bvvRx06TaEvlvqxmKu1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614942; c=relaxed/simple;
	bh=ptFCoVl4ejPQq6L4t3OjIwSPGRB4OMjQlhaTVIC6B98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZ+BtFjJDrtbOP4EpJVacZ+ndTfpGWUwwhEmAO8j12qOGtmb0x5Y8DVEq2qBhV81x0vDF1jZa9rkAeXHIIIUloTVhstkuYZc7L+70K+1MHWxPFPx4jUAy9v3oUIjf+gIXUwaSt/ZuGWmXE46nkwvV2w/HvOUZpD6Jjj2LNBeZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=stD0q1WY; arc=none smtp.client-ip=136.144.136.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="stD0q1WY"
Received: from submission12.mail.transip.nl (unknown [10.103.8.163])
	by outbound7.mail.transip.nl (Postfix) with ESMTP id 4gfnFY08WVzQvxwW;
	Tue, 16 Jun 2026 15:02:09 +0200 (CEST)
Received: from [127.0.1.1] (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission12.mail.transip.nl (Postfix) with ESMTPA id 4gfnFX1Qrpz3SJ37Q;
	Tue, 16 Jun 2026 15:02:08 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
Date: Tue, 16 Jun 2026 15:02:06 +0200
Subject: [PATCH v2 3/3] iio: magnetometer: st_magn: honour
 st,fullscale-milligauss DT property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-3-063edcf74e60@herrie.org>
References: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
In-Reply-To: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Denis Ciocca <denis.ciocca@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Denis Ciocca <denis.ciocca@st.com>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, devicetree@vger.kernel.org, 
 Herman van Hazendonk <github.com@herrie.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781614923; l=4762;
 i=github.com@herrie.org; s=20240417; h=from:subject:message-id;
 bh=ptFCoVl4ejPQq6L4t3OjIwSPGRB4OMjQlhaTVIC6B98=;
 b=nsmHBF4qPcS6fWpU4qhjDeRybgbXWZTf8rrNPKTaeVu4nPQ1Puhoyx6JWvWFYIKNKBj5NfiwK
 oF6vgd/TsUSB5vvBuFD6bCODUShiEf54RQX1aUA7JVhPYuAxn3cy/0Q
X-Developer-Key: i=github.com@herrie.org; a=ed25519;
 pk=YYxdq8fb5O9vhkW3n2dCH044FPZZO5718v/du7fRhFw=
X-Scanned-By: ClueGetter at submission12.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1781614928; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=X+nCpIryhHub4FcQjDYfT4e8eh2iGorvyop023rL09I=;
 b=stD0q1WYODJbp98Nn08n1Jnf+vCkO7w+K4rFGAe6NtQUEO6VpZkQhDt9mrKF1FwZL561zR
 jD76ALv1lvYA871V2qK5PRXJh6Nm1uuwYkR+npWzJljR16i8K+h1F9DomoyOojPva+Serx
 mxYJpFyf8iMj8pYCW4TprNqpuctf9ztsRAbopPqql4tSyfzrw4b2oLHRjaPo7qWLkFJt3S
 bTWtKT26LYP6HyahjBkNkS+L2xoD+bpXfQdZBhSdN/VUY1MxnoZnnwSuhWOl3lnn7D1DIx
 rz0aToPacdiBCt9oz7uGm7yZLqlO9PNJR+TKIuCiiciajG8LJMBpkDO6+DQtsw==
X-Report-Abuse-To: abuse@transip.nl

The ST magnetometer core's common probe hardcodes fs_avl[0] -- the
highest-sensitivity full-scale supported by the chip -- as the
starting range. For the LSM303DLH that is +/-1.3 G; for the
LSM303DLHC and LSM303DLM it is +/-2 G; for the LIS3MDL it is +/-4 G.

That is the right default for "minimal noise floor at a desk", but
it leaves no margin for boards that pick up appreciable DC bias from
nearby PCB structures. On the HP TouchPad (apq8060 / tenderloin) the
LSM303DLH magnetometer is mounted close enough to the surrounding
power planes that X reads back as the chip's 0xF000 overflow
sentinel (== -4096 raw, the value the chip publishes when the ADC
saturates) on every sample at the chip-default range, while Y and Z
fall well within the +/-1.3 G window.

Parse the st,fullscale-milligauss device-tree property (documented
separately in dt-bindings/iio/st,st-sensors.yaml) in the
magnetometer common probe to select the initial fs_avl entry by its
mg value. The DT binding pins the accepted value set per compatible
via allOf/if-then enum clauses, so a malformed mg value fails
dt_binding_check rather than reaching the driver. Sensors with a
fixed full-scale (fs.addr == 0: LSM303AGR, LIS2MDL, IIS2MDC) have no
register to switch and the property is rejected outright for them
in the binding; the parse block is additionally gated on fs.addr as
defence in depth against stale DTBs.

Per-sensor mg ranges are listed in st_magn_sensors_settings[]. For
LSM303DLH and LSM303DLHC/DLM the valid values are 1300, 1900, 2500,
4000, 4700, 5600 and 8100; for LIS3MDL, LSM9DS1-magn and LSM303C-magn
they are 4000, 8000, 12000, 16000.

Empirical scale sweep on the HP TouchPad confirmed that on this
board any fs_avl >= 1 produces non-saturated X readings:

    scale (0.001 G/LSB)  | X raw    Y raw    Z raw
    --------------------+-------------------------------
            1.100        | -4096    44       46    (X saturated)
            0.855        |  -547    37       37    (clean)
            0.670        |  -433    94      103    (clean)
            0.450        |  -266    44       71    (clean)
            0.400        |  -235    34       65    (clean)
            0.330        |  -196    27       56    (clean)
            0.230        |  -145    15       40    (clean)

2500 mg is the natural choice for tenderloin: comfortably outside
the saturation regime while keeping useful precision for compass
applications.

Assisted-by: Claude:claude-opus-4-7 sparse smatch clang-analyzer coccinelle checkpatch
Assisted-by: Sashiko:claude-opus-4-7
Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/iio/magnetometer/st_magn_core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index ef348d316c00..6f369e8dddea 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/sysfs.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -608,6 +609,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 	struct device *parent = indio_dev->dev.parent;
 	struct st_sensors_platform_data *pdata = dev_get_platdata(parent);
+	const char *propname;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -628,6 +630,36 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
+	/*
+	 * Skip fixed-FS chips (fs.addr == 0): no register to switch.
+	 * The binding rejects the property on these compatibles too;
+	 * the gate guards stale DTBs.
+	 */
+	propname = "st,fullscale-milligauss";
+	if (mdata->sensor_settings->fs.addr &&
+	    device_property_present(parent, propname)) {
+		struct st_sensor_fullscale *fs = &mdata->sensor_settings->fs;
+		u32 fs_mg;
+		int i;
+
+		err = device_property_read_u32(parent, propname, &fs_mg);
+		if (err)
+			return err;
+
+		for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
+			if (!fs->fs_avl[i].num)
+				break;
+			if (fs->fs_avl[i].num == fs_mg) {
+				mdata->current_fullscale = &fs->fs_avl[i];
+				break;
+			}
+		}
+		if (mdata->current_fullscale->num != fs_mg)
+			dev_warn(parent, "%s=%u not supported, using %u\n",
+				 propname, fs_mg,
+				 mdata->current_fullscale->num);
+	}
+
 	if (!pdata)
 		pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
 

-- 
2.43.0

