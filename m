Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE030C142;
	Tue,  6 Oct 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310644; cv=none; b=BXk0Irs7KvptKdDxgx2UP09UwN6WCKuahhhTS4DomvXSaD/jIfp/o9qEf/EbMDh9sPKA1fZneZidUJq5cimmhCHZJimyJI7K3WvMVkjVP6v8qCvLHk/76IVCKsmp65c5s9mSXgfGHaSCSCnzMwNaMRhbPA3u+8Rf2oxN1TgM/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310644; c=relaxed/simple;
	bh=ydMADG+LX6rJKALJOVxeC9B7XSqPKAy6NFScyM8Dliw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X21zPtnWUsDTlMmAtlrETp2n5VgJrHRVqZKX+w0fGFYhzIYAZbXKuA6vj/+mH7sSeXPdCAhHkklFfi0C9XAExpec0MPi5z8y+e2DinpI/fvYBZQ9mVQOVGQe42onpxDvEX8z9SzCpFL485AKIRboz5x67SxiatAlKoK7ozPIRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=YNWT+t7c; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GpVt1dnm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="YNWT+t7c";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GpVt1dnm"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HhLxb2187768;
	Tue, 6 Oct 2026 14:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=eh2kkCJ8BRxyasNO8J2ZhARI9sNv2+0K5TWSMXlXSfw=; b=YNWT+t7
	cFPUTH+i3KnTdwL1k/0Nkce9uO8sMQpY/ZDz5xPCxSUmIYdiGdrp9DZkg3s/TV+e
	FEeReQXAjOxICN3hgZAFPNE0hRC5VNI178izoAv3TUnp+cXFv68mGupcQxxiEznF
	LpWDW4PsXps7nuq0R9zX/zWE9H8QUpFyaS594Ud5myGPgZIH0UXgGDR5zXPMvJhP
	HiVoiKYHU4Yij80Vydp+AgNPj44MtWgjKNBFdbk1Lz7KvckERxbQ/vJ/fgYcexGi
	aBGd5EGfoEqEzdJM5NuYoB86VS0rlaMw5hNN2DyYuPn9kELV9uMpgPVBArZmYpMQ
	9nCH+F6xO09htvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eh2kk
	CJ8BRxyasNO8J2ZhARI9sNv2+0K5TWSMXlXSfw=; b=GpVt1dnmhAdFLOYG/yFsn
	0F5uH/MATlnez8MeBgz/Jyd4SsZBk962CSdEHviR70nLMd4GXjbGTgtXzx0vCkqe
	gU3Ri1ntEAzEW0BfJ7TEJYmKy5c5pOfAWn7njYPMil+Kp6Gn6DS5b5sJDliEIpzF
	GUhY6LJeyA3kFpexYCGaWJsbPaqnIChiLrFQ9XUOQhbgRocn0FkqugdgWgozdKT+
	grGZ/7Z5d1HIA0U4pF895imWK3mVqKI9FrlryMubwF6e5MbTO4oljxsXVUuk+I92
	yLXTztqcXAP0RlukaZe6hc9Q+b8leT2NvS/HCh+V0uL1lhl8vyjuQEXZ+D+t89DK
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4en5far3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:17:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 696IH30W021603
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:17:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:17:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:17:03 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IGlNM000991;
	Tue, 6 Oct 2026 14:16:49 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v4 03/13] iio: adc: ad4134: Update include list to comply with IWYU principles
Date: Tue, 6 Oct 2026 15:16:42 -0300
Message-ID: <fe182b812315d23ed3d889cca08aa44ab36bb6ef.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX7l3xkfpwVoHq
 rw2SmB/NfJp0gDsCh8WICMqkmtYJ8Pvpkx4dr+8A9SaOhrvm5fh8STs+DRUPQ0VquXgH0PeVGqN
 Kc3yoBEANuCegiphAN0Db3M9S0YxghLAOX7G9YWPvrdfQnuQvAwg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfXyWu4e8kepqSt
 /I2s6/NHHrcGFVimo0eJTknx8aCoDh4gsjEiOyiupqNyUZMFDa4a62GqxhpDWfkcwI/fK3G9oHp
 C2jMzr4rc+yev4V1AKQOURZV1D/+vDga4Z5+bmIuyytg46AEJO3i4wS9nXaeQcPjJU9NJA30Cu8
 vZSRqxVpm929I1IRG/DlP10+vaiISALwCjCIjQjgdAfa05o9ecChcRQ5eTcl1Kl8cJ/Ah87T9kw
 jS80Vu+uKNnUOMLYwnFRYrwdxDd+96mPWmZ6n/xvJfhTV7aHIGDOFxMy6GKGin3sKd0A4rKx6sd
 Mxtaa6Salyzkjyyfnfvm8lpAYjRQSNvkpSODsUg4z2jxvj5Cbvdn2P44lUH9zJPaH//jOs4SEt3
 ceNjxNROEvbCBELXc4BvtcC0p8Vy3JG/LuXL1t56fDODEuAEh9SbC2qSShF3uJq8ExGyStk1cXo
 Iwg+wLjTX37CNV+Stfw==
X-Proofpoint-GUID: jXt_zg-3zMUlFyLfIxHHA7bFIemY_KUd
X-Authority-Analysis: v=2.4 cv=DdCCOftW c=1 sm=1 tr=0 ts=6ac53b20 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=gWXB6eRzw52pz-VW4roA:9
X-Proofpoint-ORIG-GUID: jXt_zg-3zMUlFyLfIxHHA7bFIemY_KUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060072

Add includes that were missing (according to include-what-you-use tool)
to comply with include what is used principles. Namely, add time64.h for
USEC_PER_SEC.

Remove time.h which is covered by time64.h and iio/types.h which is
covered by iio/iio.h.

While updating the list, organize it to follow current IIO include list
convention.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v4.

 drivers/iio/adc/ad4134.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 6fdeb27d7a42..4c8adb8efe4e 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -14,18 +14,18 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
-#include <linux/time.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
 
+#include <linux/iio/iio.h>
+
 #define AD4134_RESET_TIME_US			(10 * USEC_PER_SEC)
 
 #define AD4134_REG_READ_MASK			BIT(7)
-- 
2.53.0

