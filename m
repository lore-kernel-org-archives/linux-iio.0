Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F43BB673;
	Wed,  5 Aug 2026 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902113; cv=none; b=FNfjm4w96WEqOhsoLsDOl8REQdoEuwucUgV49FeNAd+1ZXTmrhw4x9YkuRFEQGi64vLVBnmKIcDJ1b0rAFKNLmGsoX2qWENO1nFDV++kldjVUn+pB7IJKCEdBaszdyLVM6SGzdyHVGoSka9kWKbGm4bQhTdImSIlKEJVVeLqWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902113; c=relaxed/simple;
	bh=jpponM22kwc+ZQsfh04FxiQ9hHnCEPtFyF3eUVRPVNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Si3tpf/DgWIb5TAjOWeVVuqw3IFtxWQC+5k3JhmEPoD/Kgwm1KxBhw/uVQ111a2lXqz+X7ZpuQbx2zHOkmH2uK40Hd9degkA0yXWsFezax+3nlIUtQJZyQjo/iLc5Stjg43TH/XmMf/UouA2YKJ0q6iVgWpea63a33h/qy/3bbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7145d2a8908111f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9a89467e-bdcb-44ae-9a6e-cc7ef5f5f1fa,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:abb9e765255de9f71e71bebdc7ebb1df,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7145d2a8908111f1aa26b74ffac11d73-20260805
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1122949321; Wed, 05 Aug 2026 11:55:05 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH togreg 2/2] iio: imu: inv_icm42607: restore runtime PM on system resume errors
Date: Wed,  5 Aug 2026 11:54:51 +0800
Message-Id: <20260805035451.487465-3-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260805035451.487465-1-lilinmao@kylinos.cn>
References: <20260805035451.487465-1-lilinmao@kylinos.cn>
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
Based on iio.git togreg at 0efaefce4e95.

 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 0da362967f63b..5384596dd8d79 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -667,19 +667,26 @@ static int inv_icm42607_suspend(struct device *dev)
 static int inv_icm42607_resume(struct device *dev)
 {
 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	int resume_ret;
 	int ret;
 
 	ret = inv_icm42607_enable_vddio_reg(st);
-	if (ret)
-		return ret;
+	if (!ret) {
+		/* Sync the regcache again after regulator shutdown. */
+		regcache_mark_dirty(st->map);
+		ret = regcache_sync(st->map);
+	}
+
+	resume_ret = pm_runtime_force_resume(dev);
+	if (ret) {
+		if (resume_ret)
+			dev_warn(dev, "Failed to restore runtime PM state: %d\n",
+				 resume_ret);
 
-	/* Sync the regcache again after regulator shutdown. */
-	regcache_mark_dirty(st->map);
-	ret = regcache_sync(st->map);
-	if (ret)
 		return ret;
+	}
 
-	return pm_runtime_force_resume(dev);
+	return resume_ret;
 }
 
 static int inv_icm42607_runtime_suspend(struct device *dev)
-- 
2.25.1

