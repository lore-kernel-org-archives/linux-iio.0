Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D3224AF0;
	Fri, 30 Jan 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781045; cv=none; b=aHz2ydYa25uAeS5K7Tuy7jluLJyMTJhJ2Ry9uUSygSeGsqLCq6wkp/3lI782+m0J+XZoDJxceyBVYSmwtyBWLzKjE88zMhYujRnL7Rhk73Fzs82TzCZjdr1tJLX9D3k4K9Enpu1focdiawcWwYPCgUPv+fJILZbcoHmMrSxTjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781045; c=relaxed/simple;
	bh=TONDAoRWPpHIYXHdcUkr4x4Ar6RaBcSAmU/I61UCynM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UueI9JsMwqCKRzJ1ddHleq7sYNQXagyaWgXwoX3FeI5J7rLeLvQg2fE/MCOcDmzU/3mFv+S+x932cMoYzp4lg0CM2WtEKU9JuSwfIpJLJG6ECft30XQ/HDuFYtz+5oLsoCBm3PBBvwRupu+rUADTZl50i0WlfMsxUQJPkXWuxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J6k/jQva; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J6k/jQva"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U9qNmQ2649131;
	Fri, 30 Jan 2026 08:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=lCs0ztbD37VAQhfwkYsp/1ckJmB
	2qZmM6fj3m4T1UmM=; b=J6k/jQvaeCOY6pRyTlzSHx90OmLShHacdpFH2eMU/9r
	ppUntAx56/fHskAE/KVdKqPshrsynj8vxjOfGYb+zFSwOknu8Vu3ATI2DMtkq/eD
	rAZv6p+OwAR4w4aPO41HdrdABHWDiEKj9Km1TvFPzSLqb4hmFtrwVY/FIh/pJNpj
	6tk3Xz5mzD90BMeN8Upk4lUJgG0GMKKz00MQ3MgZ/dJH8wRG6YYoBqCTDSqo+xWO
	Cwlx/zMH6gx3bl8b2TF2XTJlXkyPMnKLgk7r43HjyK+HTWGHrp3xZv9O6XPySxPX
	hv9BbOgThtAiQLcxEJt7pbpq/z6DRZsuFXThOi/iI1g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c04895uqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 08:50:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60UDoRue060749
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Jan 2026 08:50:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 30 Jan
 2026 08:50:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Jan 2026 08:50:27 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60UDoFv5030878;
	Fri, 30 Jan 2026 08:50:17 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: frequency: admv4420: return proper error code from admv4420_calc_parameters()
Date: Fri, 30 Jan 2026 15:50:05 +0200
Message-ID: <20260130135005.136363-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExMiBTYWx0ZWRfX0tBXLy7AnIhT
 M+ENf/fYx/H5m8ZE0gl1AS52jaWllNUlzOkJjYYn4Cqo1IQDiR1ovUmaazRu121AzzQ1dn3vIty
 +5wgdtzQsdODI0WkwmplqiGzL550Vr1/bMMBNLxoxAL/TUFkA+8Dcpu8UY/rZQsX34CDiA/3lpW
 zdW1mXb5HebCBCcNHu98lk2QQsNtcfdzNnFrDtNeveKvhGpJ6dY3FgTAV6Hl8ZT5CbJBlLMQiFL
 kBmP6mHMcEwunjBVGUviuovDQcUqD5WUywteX2uoUPOfT4gRcrb8maB5/keLfns+ex/d+dbBXUh
 +V6Z95MkpHT7gNjndxZ4buJQTBJYHGRahrKt+9Ri+jExD+QNdIeodEAFidSuvfdK9WFCPY9M4Lp
 X8boyvIicY3AF9NnpFV7D8ubLILUvfvR2pXIKNql/veBOKlH5eLki231LQEKSNxJzFyDXPqDWLC
 6fkcSBZ0akeWDcgkcDw==
X-Proofpoint-GUID: O8QEPwbouF-qabtBaPW2PjJymtC4_tgw
X-Proofpoint-ORIG-GUID: O8QEPwbouF-qabtBaPW2PjJymtC4_tgw
X-Authority-Analysis: v=2.4 cv=dq/Wylg4 c=1 sm=1 tr=0 ts=697cb724 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=ZICjsZaYWP5pXq6_K6EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300112

Return -EINVAL instead of -1 when no valid PLL parameters solution is
found. Using standard kernel error codes ensures consistency and proper
error propagation through the call chain.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv4420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
index 3ae462b4f5c9..8748d9747639 100644
--- a/drivers/iio/frequency/admv4420.c
+++ b/drivers/iio/frequency/admv4420.c
@@ -243,7 +243,7 @@ static int admv4420_calc_parameters(struct admv4420_state *st)
 		st->n_counter.n_counter = 1;
 	}
 	if (!sol_found)
-		return -1;
+		return -EINVAL;
 
 	st->n_counter.int_val = div_u64_rem(st->n_counter.n_counter, 10, &st->n_counter.frac_val);
 	st->n_counter.mod_val = 10;
-- 
2.43.0

