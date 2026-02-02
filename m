Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA172D8792;
	Mon,  2 Feb 2026 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034457; cv=none; b=I8/b8npztGRG4ffwDdhTrNLHMumRRdTFQngA7fWw/QkKnfWHJeJ/R+0J3IUdPdumIeQqk/7Rdkv3ea7nEuD6i7ttzCMCCaCWRLdfmjYVG7NbUsScyqTDJpmFHR6GZu3vrsNMa5amlIlGkWc44WmSJer0tNf97cPFnrc32TQEcmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034457; c=relaxed/simple;
	bh=jCwz3ZuDUnlxovKMyWmfX42vKLteBDJkGR6hAKTfeiE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NsLE4P0uUxXe4zimkzlrWTWQr4oEuqbme7Y1pRMtPpSoOYdcUXlOGDVmM1R6SuN9lxm2NzeBdf5eDZm0oLfShjI0KGW0n5odB0KxPE3c3C7GWA0uHzo2swibn+qwcwYvBGJK9hHIt0ss5N264etpN1C0lEzeYSy9Z7/BRUuAyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A1olbFIU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A1olbFIU"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61290ZT2348455;
	Mon, 2 Feb 2026 07:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=MeD7yFv1cHirGdysCykTkD4BKqS
	8tbrB6+joc3E5HNk=; b=A1olbFIUWTaUo/r3chj5am8xnkrEADThskGxECshDpB
	9DA8bEroOhOyqQoX8WxX04qb8k54viWy5sr5TZk+Gvv7nDAxLfX4jeyRX3PUGnX/
	9OCec2/lg3z8KV2D1OtrQenNXsPzetxUvWy0iZ4+bB6p4muJ4F+u1aeL6WwdaOSm
	Wv7CEsf90NZrlsGJGF1GWQJMNjnsJeMa2JfehJvyymx14Iw/BH9g3Bsm3PzDPv11
	Nk7wYoTYoA87wmhTuWm/hV+VcH84ap35K/ozq4dk9xIUDlrlXDdSf+7ZxhwI/2Od
	+dc8z9MdSiOvsbp9MsxXJ+6xYX8dOoPhst0fd/0PXVA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c2b8wtscs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 07:07:51 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612C7osw053862
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 07:07:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 07:07:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 07:07:50 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612C7Zwa006857;
	Mon, 2 Feb 2026 07:07:38 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Waqar Hameed <waqar.hameed@axis.com>,
        chuguangqing <chuguangqing@inspur.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: light: ltr501: return proper error code from ltr501_get_gain_index()
Date: Mon, 2 Feb 2026 14:07:12 +0200
Message-ID: <20260202120715.25625-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MiBTYWx0ZWRfX8FKucwIj6LyE
 AkiRdn1kFBt3EYiCUs/RRNOYqA2/jH7EAMCwYHrIq9az0fHsj4Bymq7KmZIMys3XS1VdT3kH1kN
 cutfkbwjJu4oQvqoI9ia0MpqPyGaa4BeSDsfBWkO3Eyr4oT9SFinAIBLBSgnIQAmwxV/PZPICpQ
 tdKA2Q7/NRSnKNzI5Q1WNAdlbt8IKxQ2IjWAyL52P6udgJB5S5hd9pQ9L0SZ49uDCJPo4Rfg15U
 fShrGRjtnY7j5dWVbM9eYpNOi2d9f9fr8TNjKT1zGkjRiPEoTXjWf0WrPz8NGrrpkbj9x1urO3O
 oPygZ+wA3u8nYban4KOXrU5prSPSlBpVbVZa8hSK7aQwhN8euNnv78YRpryeinbBbWCkFkZmm6s
 Grr17pqeXE3qn0bRES9UyLrNh63HIhtpMkhCBfBko7qJnlQMwZCv/3F9aoPW73mXmEVPOjvmbVX
 JwpvZJCVS8HrMd1xkjw==
X-Proofpoint-ORIG-GUID: AQW4a7KfOuhFl489fZM-M70cDeRf9gxY
X-Authority-Analysis: v=2.4 cv=SK5PlevH c=1 sm=1 tr=0 ts=69809397 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=8a6jEeoJ9GT98JlJLVwA:9
X-Proofpoint-GUID: AQW4a7KfOuhFl489fZM-M70cDeRf9gxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020092

Return -EINVAL instead of -1 when no matching gain value is found
in the gain table. Update the callers to propagate this error directly
rather than overwriting it with -EINVAL.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
 - Update callers to propagate the error directly instead of
   overwriting it with -EINVAL.

 drivers/iio/light/ltr501.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 022e0693983b..4d99ae336f61 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -754,7 +754,7 @@ static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,
 		if (val == gain[i].scale && val2 == gain[i].uscale)
 			return i;
 
-	return -1;
+	return -EINVAL;
 }
 
 static int __ltr501_write_raw(struct iio_dev *indio_dev,
@@ -773,7 +773,7 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
 						  info->als_gain_tbl_size,
 						  val, val2);
 			if (i < 0)
-				return -EINVAL;
+				return i;
 
 			data->als_contr &= ~info->als_gain_mask;
 			data->als_contr |= i << info->als_gain_shift;
@@ -785,7 +785,7 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
 						  info->ps_gain_tbl_size,
 						  val, val2);
 			if (i < 0)
-				return -EINVAL;
+				return i;
 
 			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
 			data->ps_contr |= i << LTR501_CONTR_PS_GAIN_SHIFT;
-- 
2.43.0

