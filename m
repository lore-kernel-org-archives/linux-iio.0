Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631743176EE;
	Mon, 24 Aug 2026 03:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787543747; cv=none; b=RFFf01S/G0FgxUGhnYVnOl4nnI2A7nfV+nqUV4Sfp59EYXqKPR+t2yo4PBswklwei+TK4opCkig5rC/QKwrgSbrUacWRYg2at1H9AqwJCXed2ev1M4GVyPm4mRO767M3ZJGpjMwm2xrqCVZE88jLGTNipXOeSDsLithqZJwIEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787543747; c=relaxed/simple;
	bh=OaIdKja4JLE/Prwwg0w8Yzo5vXyXMgl7pumKIc+t6oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TA6RFSOWEholdqAibVg8Qm/XtwpUQkXfoLGrOEylHcHVcXrhOIh5I44w2f8FxU5tcf2v4RIcO5Gk2LU0nXcqWIKTJyPMNWq1v9iQuq6hnrWy4H0NCsVuZ0azUJ0FqGBc/7PH3GFdiQuMiQMERDlmkMjDsjx/gw5E84iG2TQJEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aa55a4a49f6f11f19a56ed5b684f684d-20260824
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:bb7486bd-34bc-48f2-b348-bc9b8aa0b76a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:920bc81f8664f2d09a03a1f4d859d5b0,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50,E
	DM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa55a4a49f6f11f19a56ed5b684f684d-20260824
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1169046848; Mon, 24 Aug 2026 11:55:37 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH togreg v4 1/2] iio: imu: inv_icm42607: propagate runtime suspend errors
Date: Mon, 24 Aug 2026 11:55:30 +0800
Message-Id: <20260824035531.141429-2-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260824035531.141429-1-lilinmao@kylinos.cn>
References: <20260824035531.141429-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime suspend callback returns success when updating PWR_MGMT0
fails.  The PM core then marks the device suspended even though the
shutdown outcome is unknown.  If the write did not reach the sensor, the
sensors remain running and draw power while the device is idle.

The condition need not persist.  If the bus error clears, a later sensor
access either reads the current PWR_MGMT0 value from hardware or retries
programming the requested enabled mode, allowing normal operation to
resume.

Return the underlying errno to the PM core.  -EAGAIN and -EBUSY retain
their transient-error semantics; other errors put runtime PM into an
error state and cause later PM acquires to fail until the status is
explicitly reset.  In the normal idle case, a successful system suspend
can perform that reset.  This leaves the transient-versus-fatal
classification to the PM core and matches the sibling ICM-42600 driver.

Keep a void wrapper for the managed teardown action, where errors can
only be logged.

Fixes: 3007c1530f96 ("iio: imu: inv_icm42607: Add PM support for icm42607")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
Changes since v3:
- Expand the commit message with the practical effect and the recovery
  behaviour, as requested.  No code change.

This was found by code inspection.  No ICM-42607 hardware or
fault-injection setup was available.

 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 190e998f7b8ef..0da362967f63b 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -537,9 +537,8 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
 	return 0;
 }
 
-static void inv_icm42607_sensors_off(void *_data)
+static int inv_icm42607_sensors_off(struct inv_icm42607_state *st)
 {
-	struct inv_icm42607_state *st = _data;
 	const struct device *dev = regmap_get_device(st->map);
 	int ret;
 
@@ -552,6 +551,13 @@ static void inv_icm42607_sensors_off(void *_data)
 					 st->conf.accel.mode);
 	if (ret)
 		dev_err(dev, "Unable to turn off sensors\n");
+
+	return ret;
+}
+
+static void inv_icm42607_sensors_off_action(void *data)
+{
+	inv_icm42607_sensors_off(data);
 }
 
 static void inv_icm42607_disable_vddio_reg(void *_data)
@@ -619,7 +625,7 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	 * Ensure if sensors get turned on at some point, they're turned off
 	 * as part of teardown.
 	 */
-	ret = devm_add_action_or_reset(dev, inv_icm42607_sensors_off, st);
+	ret = devm_add_action_or_reset(dev, inv_icm42607_sensors_off_action, st);
 	if (ret)
 		return ret;
 
@@ -688,8 +694,7 @@ static int inv_icm42607_runtime_suspend(struct device *dev)
 	 * however the tradeoff is that an unused sensor won't be
 	 * turned off until the entire chip is no longer in use.
 	 */
-	inv_icm42607_sensors_off(st);
-	return 0;
+	return inv_icm42607_sensors_off(st);
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {
-- 
2.25.1

