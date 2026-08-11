Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC9430307;
	Tue, 11 Aug 2026 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444399; cv=none; b=fiS3NgRECCtTUK3YCVc1iXpWPSKmqsLi0enRtlv7eVZ19U56vMCouA9BuB/dxzJ9XwlX6upX4gprdSXDza390UXFMVUW65c5UWypkn133E8cJciXtQWGqk/GGIeIUcPO8f2toPtTPSWicY9UeV5XnGYCtI+T4vvLox4m7RHQdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444399; c=relaxed/simple;
	bh=wRKiIHOYfNWaiV+wzW6bKNOe+boTVJjFJ9e+y9QsR2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p00RTrJdUBVNUPYxZdiVxMta/hrlX3EGsf6hRbpNr6VGQKKQcD/GftSF5dhv+63+rjxkVkYlktW9FPZM7fx01EfqUN8bN6TVWs68DpjP5qPWsvkkRmjon9SOWxIl7oLh6PWe2nGv8ITzr5XMRg41fo8o94iLsYF4/6PlFlGWbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0c663064957011f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:492cb541-11b1-46ee-b5d0-2ed4688887b2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:ed744ca82c082ee069fe46422292937d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c663064957011f1aa26b74ffac11d73-20260811
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 157396301; Tue, 11 Aug 2026 18:33:10 +0800
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
Subject: [PATCH togreg v3 2/2] iio: imu: inv_icm42607: restore runtime PM on system resume errors
Date: Tue, 11 Aug 2026 18:33:01 +0800
Message-Id: <20260811103301.1157404-3-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811103301.1157404-1-lilinmao@kylinos.cn>
References: <20260811020345.950137-1-lilinmao@kylinos.cn>
 <20260811103301.1157404-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_force_suspend() leaves runtime PM disabled after it succeeds and
expects pm_runtime_force_resume() to restore runtime PM management during
system resume.

The resume callback returns early if enabling the vddio regulator or
synchronizing the register cache fails, skipping the matching
pm_runtime_force_resume() call. Runtime PM consequently remains disabled
after the system has resumed, so runtime autosuspend can no longer turn off
sensors enabled afterward.

Call pm_runtime_force_resume() on both error paths. Keep the first error as
the return value and report a runtime PM restore failure separately.

Fixes: 3007c1530f96 ("iio: imu: inv_icm42607: Add PM support for icm42607")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
Changes since v2:
- Restructure inv_icm42607_resume() along the lines Andy suggested:
  handle the error case in its own block and call
  pm_runtime_force_resume() directly on the success path.  No
  functional change.

Changes since v1:
- Split the device side of inv_icm42607_resume() into a helper so the
  PM bookkeeping stays in the wrapper.  No functional change.

 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 0da362967f63b..f4ef75da22c76 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -664,9 +664,8 @@ static int inv_icm42607_suspend(struct device *dev)
 	return 0;
 }
 
-static int inv_icm42607_resume(struct device *dev)
+static int inv_icm42607_resume_core(struct inv_icm42607_state *st)
 {
-	struct inv_icm42607_state *st = dev_get_drvdata(dev);
 	int ret;
 
 	ret = inv_icm42607_enable_vddio_reg(st);
@@ -675,9 +674,25 @@ static int inv_icm42607_resume(struct device *dev)
 
 	/* Sync the regcache again after regulator shutdown. */
 	regcache_mark_dirty(st->map);
-	ret = regcache_sync(st->map);
-	if (ret)
+
+	return regcache_sync(st->map);
+}
+
+static int inv_icm42607_resume(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	ret = inv_icm42607_resume_core(st);
+	if (ret) {
+		int rc;
+
+		rc = pm_runtime_force_resume(dev);
+		if (rc)
+			dev_warn(dev, "Failed to restore runtime PM state: %d\n", rc);
+
 		return ret;
+	}
 
 	return pm_runtime_force_resume(dev);
 }
-- 
2.25.1

