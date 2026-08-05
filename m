Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248D3F9A1C;
	Wed,  5 Aug 2026 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927792; cv=none; b=Np+LFY4wmlILsAAyKiL+Q9beiezXCw2aZuP/e7pHTjRI0bIAqayAnamq6EwKXas6T4TcHMZ0xSyQUVV5P9vDWmqs74QPOhlDqDuj7aphCaqiPU36UY661L6wmv5GJCTkdfJO7989+uDusq4eM7HxEsy221kPxQDvJJcz3IsJRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927792; c=relaxed/simple;
	bh=lDENA6J9KMSu46VHtIYqK914IPiNKRvreU1gKOW6LKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ddg8Ehwnibxbn6JD9A9BrP8eARMnxAgd6juVV2qLcqpM7gWL58fZrwCJy4YnLb2DjN0dr4CzT1xdh1G0fvtThOWA9vQBOE/veoeuqniulnJ8EV/N9fjrDSMjfGx8pLrRH1qERcJ04mlBRq9/C4c9y3bcFiMtzSNN2u/SarYbf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3880bd0c90bd11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ae55e5b6-6109-4d36-81ef-2f55f735cfc6,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:27b9eeac4b96a84773bbc7052178abf1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3880bd0c90bd11f1aa26b74ffac11d73-20260805
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 247699715; Wed, 05 Aug 2026 19:02:59 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] iio: flow: slf3s: restart measurement if VDD disable fails
Date: Wed,  5 Aug 2026 19:02:55 +0800
Message-Id: <20260805110255.504576-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

slf3s_suspend() stops continuous measurement before disabling VDD. If
regulator_disable() fails while the supply remains enabled, the system
sleep transition is aborted. Since the PM core does not call the
corresponding resume callback for a device whose suspend callback failed,
the sensor remains idle after the system returns to the running state and
subsequent reads fail.

Attempt to restart continuous measurement on this error path. Preserve the
regulator error and warn if restarting the measurement also fails.

Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/iio/flow/slf3s.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
index dfa7c14090454..75ee82fbd3295 100644
--- a/drivers/iio/flow/slf3s.c
+++ b/drivers/iio/flow/slf3s.c
@@ -462,6 +462,7 @@ static int slf3s_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct slf3s_data *sf = iio_priv(indio_dev);
+	int restart_ret;
 	int ret;
 
 	guard(mutex)(&sf->lock);
@@ -470,7 +471,16 @@ static int slf3s_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	return regulator_disable(sf->vdd);
+	ret = regulator_disable(sf->vdd);
+	if (!ret)
+		return 0;
+
+	restart_ret = slf3s_start_meas(sf, sf->medium);
+	if (restart_ret)
+		dev_warn(dev, "failed to restart measurement after suspend failure: %d\n",
+			 restart_ret);
+
+	return ret;
 }
 
 static int slf3s_resume(struct device *dev)

base-commit: 0efaefce4e95a3331550329c0078b2fb38b3ff1f
-- 
2.25.1

