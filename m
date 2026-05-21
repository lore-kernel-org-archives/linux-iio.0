Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A093812F1;
	Thu, 21 May 2026 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332268; cv=none; b=Pm68rY+Bjjcic1i9gSqE1WcIusb02K3/27InBKkfObp9jjXsbcXcrWeIvQkvN4B6nAHgZq2j9gO/6T2qfpEMTwoyqhwOxLfE+1QLHqkUl6SM/lzwc+xVZxnN3T+4Wdu4SSFy13NlJqWf4E/dwsScZL2aP+ijMuUryseI8OWapDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332268; c=relaxed/simple;
	bh=2oJ2yqnu8oDpPBrB0B1iv6ZPrKCkuXOQO3/RZOGi6hw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WSs0lQGEoG61AzQiha0An+TnkfNAflR4gV4blcbm0OPcHWwnAxXbzNPlVYO3YPTB2Ju+HmtL9z12fSgLE24TuEVXUPru3DeunIGqeXxz6PcaihQc1FWSepXHwxQikIw9a3fRtNzaSY9Lj0tn1tA/HCLU6pzW8SJs2YpTQGBlszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d38c9c8c54c011f1aa26b74ffac11d73-20260521
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ba7bed4a-64e2-4a3d-aba6-4a4f2be26e6e,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:ba7bed4a-64e2-4a3d-aba6-4a4f2be26e6e,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:b0aa13dab25bef30b4916f52bc42b50f,BulkI
	D:260521105739XDDKLBYR,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d38c9c8c54c011f1aa26b74ffac11d73-20260521
X-User: lihongtao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <lihongtao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1472495926; Thu, 21 May 2026 10:57:38 +0800
From: Hongtao Lee <lihongtao@kylinos.cn>
To: William Breathitt Gray <william.gray@linaro.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongtao Lee <lihongtao@kylinos.cn>
Subject: [PATCH] tools/counter: Fix fd leak in counter example
Date: Thu, 21 May 2026 10:56:43 +0800
Message-Id: <20260521025643.140972-1-lihongtao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After open /dev/counter0, it's necessary to close(fd) before return.

Fixes: 086099893fce ("tools/counter: Create Counter tools")
Signed-off-by: Hongtao Lee <lihongtao@kylinos.cn>
---
 tools/counter/counter_example.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/counter/counter_example.c b/tools/counter/counter_example.c
index be55287b950f..2f0f35e88fe0 100644
--- a/tools/counter/counter_example.c
+++ b/tools/counter/counter_example.c
@@ -57,12 +57,14 @@ int main(void)
 		if (ret == -1) {
 			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
 				strerror(errno));
+			close(fd);
 			return 1;
 		}
 	}
 	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
 	if (ret == -1) {
 		perror("Error enabling events");
+		close(fd);
 		return 1;
 	}
 
@@ -70,11 +72,13 @@ int main(void)
 		ret = read(fd, event_data, sizeof(event_data));
 		if (ret == -1) {
 			perror("Failed to read event data");
+			close(fd);
 			return 1;
 		}
 
 		if (ret != sizeof(event_data)) {
 			fprintf(stderr, "Failed to read event data\n");
+			close(fd);
 			return -EIO;
 		}
 
-- 
2.25.1

