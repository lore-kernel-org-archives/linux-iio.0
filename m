Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4943F871E;
	Tue, 14 Jul 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020738; cv=none; b=NTfl2dPQcHtFqBIqmx91Uk658DRwR/PASRlgk7ii4bUGon1hRoqgglhV1Mv832+N9mkLUlBhAskATKDg+yiFj6C5kA/VUL+JjIEQHFG+nCWg1keE3vB0Kah9CoC/+5g4jVbvl0i/xuDbtlxsps/dQ9LiwoUBZzaR9hWWAmmeDNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020738; c=relaxed/simple;
	bh=Zi6N8bIuff3paVGAjvofcG6eQ/Z/gHBbiE/CAef321M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTyJmP7g+h1+5gfu95bKPU/WfKrSozns7ShyJ4VlNo9dIQBhVJqdkb/oaXd9qxNhL7mS6EcfAK7Uu6vVA1kQFibc2fvNdFTl2Lra+p5DbxUVVOcI5PJS+eEMDUW3GjqldtAOm7lODt0DpLqhmECJ3PcxVxpKw54qtJqQdnL3MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 068c91687f6511f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:55e18a86-ee78-4dd7-8ecd-6bbc48107d77,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:b3d406fb4e48f1e4d0889e71ceb5159a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 068c91687f6511f1aa26b74ffac11d73-20260714
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1318479589; Tue, 14 Jul 2026 17:18:50 +0800
From: Can Peng <pengcan@kylinos.cn>
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] iio: dac: ad5446: fix OF module device table
Date: Tue, 14 Jul 2026 17:18:45 +0800
Message-ID: <20260714091846.136278-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad5446 I2C driver exports its OF match table with
MODULE_DEVICE_TABLE(OF, ...).

The device table type is used by modpost when generating module aliases,
and scripts/mod/file2alias.c matches the lowercase "of" type.  Using
"OF" prevents the OF table from being recognized, so no OF module alias is
generated for the I2C driver.

Use the lowercase "of" type so OF-based module autoloading works.

Fixes: 876d94024087 ("iio: dac: ad5446: Separate I2C/SPI into different drivers")
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/iio/dac/ad5446-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5446-i2c.c b/drivers/iio/dac/ad5446-i2c.c
index 9797fc3e57a9..286695e240c3 100644
--- a/drivers/iio/dac/ad5446-i2c.c
+++ b/drivers/iio/dac/ad5446-i2c.c
@@ -83,7 +83,7 @@ static const struct of_device_id ad5446_i2c_of_ids[] = {
 	{ .compatible = "adi,ad5622", .data = &ad5622_chip_info },
 	{ }
 };
-MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
+MODULE_DEVICE_TABLE(of, ad5446_i2c_of_ids);
 
 static struct i2c_driver ad5446_i2c_driver = {
 	.driver = {
-- 
2.53.0

