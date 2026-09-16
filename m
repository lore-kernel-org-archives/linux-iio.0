Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E74D7D3A;
	Wed, 16 Sep 2026 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578140; cv=none; b=IMo68+nAzpLWi7zxeIACq6wW5QfU36NyP5VEdbmAW6860GmUQaoUM8ysNOqS3eD4lChX36pT+UxwxLuaXT4RASg7gLo6aKAEeA9qatxZyX/QFRYWSC/DTC37Rkcp5ADeunLihn7lcQfWFZWxpbm8QuDK2aQ+MHRNKaYWNXekVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578140; c=relaxed/simple;
	bh=WMkx2ZgxLx8/KLkGlppHTXMaHci61Qz8TbZ3301O9ns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9dKua9CDEbuQsh/S7Ve8fFmHp39AqxwealDO/a6sPPSAwP4JF3JxzsXSmUR/858YyglEKIt7m+1YtGISrurOwBHylAQONS2UOCjsb69ks4s0w2LvAjVA9sg4ngNOh2fQktMKtZfYjZVoUfPrPYefpqCiDJbRMlE+eut49bB6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bVA6NWGu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bVA6NWGu"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFfoiB3708920;
	Wed, 16 Sep 2026 13:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=PbvHUZ2JnPOZj8DQTTNV1LsPz0X
	DlUJQ9KrGo4lO9g8=; b=bVA6NWGuL+iiCPq3KBcsZAN1tUutHPAWu4BB8kcA2Kz
	zMIQsbN891BT9Vc89ys4u9JxP/82ghLGJDFYiRBk3/GnyE1iAuzukit+vvVB79bR
	YRrTAVHQpwUHy0htDhsTKuvoXZT2tuQXFaJLBE1+4b532KZSvxFYgMvtqIJBn1TX
	1Sxg8A6lQcRk3WPQgJTmQ9kzMlPsEkPxgTanvBWI1PAF6Auaonn1xfHjOcrbOtBv
	ih2BGv+wJzdL5fMv4b5TESQjr+6q342fR5+LDi2FXn4dG0VrIJ6cQBqulvp+bj8y
	KYQnPlcY9Q2UyQ9PwVlGv/kMGDQDyFFN/KUR4bXbj5g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c5wh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:01:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68GH1ppU044973
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 13:01:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 13:01:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 13:01:50 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GH1ev3004347;
	Wed, 16 Sep 2026 13:01:42 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 1/1] iio: adc: ad7173: Fix digital filter configuration
Date: Wed, 16 Sep 2026 14:01:34 -0300
Message-ID: <6de8050f5cc2b1632d7c72e4d290a484dbe53d31.1789577939.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzMiBTYWx0ZWRfX07albRHZ77A9
 HWsGN9kvRsT20lLHYONwXA9Eh/VHBLMYfC5cIvHUK9BAzFnmvE/AepYXgbdahRLA64GrxBuuESQ
 OA1zOEhVkZmyeAKmBuqJLpMFVoXmxCZLLOshVDJMvXPC4BsTivH8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzMiBTYWx0ZWRfXx354D6BpE2s/
 kWhn+9HTRpIQGXeVhhPnXgWWy/NkcwvziOxVMlCnPAIONgCtNTbUa/Drl4QJnHqChzmZSLCBXfK
 O9AkQc6w79s1c8QV8iu9y9zMAOY3sKKDd1zA8y/0p9kfPAMGtnkmMvcX8+BOKFITu/AGbKrE8DO
 ulbipgBhGPgJ0FCjP5hxQ25F/Y7IBjxQr7EIKHJ15RbiroAx2mEJlYzK/nn8fVD7I1GEO62d/Sf
 1NXPKlTud8gWhS74SNYNn63XXdd1lh8TIhHWhwQ1h6HDJleNuHh95o8+ZHhbjK8HYSulkWcaXIG
 hPLJgstsR77k5N34aJho0iYc+wccMTJJlNhbux04jZGjcDtEQJ45b2tXcVOUC11pKc5kvo+e6Iw
 7jvfwuPajXxMjhSBHylFa8j6H38+qCpXtKDJftixulrEAeQCwR0/Uy82gGt0oHKnGrsGYvYXdOa
 ebiqGR5weSlB1jSz3CQ==
X-Proofpoint-GUID: gmxgHepPpDu2KYGFloHLM3MIOSuhk2a6
X-Proofpoint-ORIG-GUID: gmxgHepPpDu2KYGFloHLM3MIOSuhk2a6
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aaacb80 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=p_faiGwhFiJgV_uZocsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160232

Filter enable and filter type selection masks were swapped on data
preparation for filter configuration register write. Use the correct masks
to set each property of post filter configuration.

Fixes: bb688cd9f772 ("iio: adc: ad7173: support changing filter type")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7173.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index eb47175a0528..faebb7b34a15 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -775,9 +775,9 @@ static int ad7173_load_config(struct ad7173_state *st,
 
 	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
 			       FIELD_PREP(AD7173_FILTER_SINC3_MAP, 0) |
-			       FIELD_PREP(AD7173_FILTER_ENHFILT_MASK,
-					  post_filter_enable) |
 			       FIELD_PREP(AD7173_FILTER_ENHFILTEN,
+					  post_filter_enable) |
+			       FIELD_PREP(AD7173_FILTER_ENHFILT_MASK,
 					  post_filter_select) |
 			       FIELD_PREP(AD7173_FILTER_ORDER, 0) |
 			       FIELD_PREP(AD7173_FILTER_ODR_MASK,

base-commit: 9c464e7473f762cee4c031a09da04f65a1c65d49
-- 
2.39.2

