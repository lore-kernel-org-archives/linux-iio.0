Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23673DA5C3;
	Tue, 14 Jul 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019034; cv=none; b=l4OimqMdJVOzJ0EwC4e6SeqrLZKqXL5DkjOh1NX94QuP4xNCkHlxEZY58kyko+iVOq1Anz43d1WQ2OUu4tMu3+TCcoD8sXECZBsM6UEIEIcLOX35H/osdLMaHo/MokV4PnjlZaf8hrZYLOgn2skrupO0Q8Q9yuGZs40Vcs+TMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019034; c=relaxed/simple;
	bh=sUWSCKA62yOPR/TNh9L8EOAEo9GsQjFG8fjYQkO8kxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l1ATeTzDjnzS0oRJNSp4/fgRxgHq4KGpi3ekhrp/W++xjK9EXpn4aanBxCp2mflRTgFvJ449Yo7wKardBciS5ENwHrRar0Kt5k1pLpSkq+wb1r1hOnty8A3eAPF2RqXUdSesYguaGssl8IDGDXlMX69X1hi5adj1aGNaT4tDssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0df7f8f67f6111f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:296d752c-dbb1-445c-849f-b461fe26e3a9,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:16ca95fbab60b1cb772e4df97726a883,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0df7f8f67f6111f1aa26b74ffac11d73-20260714
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2127962445; Tue, 14 Jul 2026 16:50:24 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: nuno.sa@analog.com,
	jic23@kernel.org
Cc: olivier.moysan@foss.st.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>
Subject: [PATCH] iio: backend: fix typos in kernel-doc for iio_backend_interface_data_align()
Date: Tue, 14 Jul 2026 16:50:19 +0800
Message-Id: <20260714085019.3109889-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two spelling mistakes in the kernel-doc comment:
"initates"->"initiates" and "proccess"->"process".

Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/iio/industrialio-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 4763e224ebc6..d19400057108 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -851,7 +851,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
  * @back: Backend device
  * @timeout_us: Timeout value in us.
  *
- * When activated, it initates a proccess that aligns the sample's most
+ * When activated, it initiates a process that aligns the sample's most
  * significant bit (MSB) based solely on the captured data, without
  * considering any other external signals.
  *
-- 
2.25.1

