Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514C34B682;
	Thu, 29 Jan 2026 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707564; cv=none; b=hV2lyr+0DAFyu80T7BkhvhjhSV/8+ElILiRikfn2Do4wONHvix067WpSmipXWQMuLbg4lZG9GHo5bJVcMB+o42MNGMD1WjOAjHLLqSL7FqI04HWz3Dd1Bd/hTwIAUTmvziRIu7LzvPMJfwz5RNdo85L9MycWR7oz0W9smfWUo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707564; c=relaxed/simple;
	bh=vBcafRU0D6rRVpaHgFY/WwSScCAdyhAe6jlAqM+Oi9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFCZXrWCRxhdIS8RN+JVxirj3KxAPwHrRTKa6BM8Z0dNjKpGIuD1R8Vr1JYF4YEbAxRNY0nQCyEKYGIKt992jQKHZPJSmfWYNZI967nR2JbHpTTy5LDHlkXCCKKya0wiSHMY5fToDEOYU632fMIkoOERocMQcZCXj4NFhBzUVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=C1M7x7lY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="C1M7x7lY"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDomew009068;
	Thu, 29 Jan 2026 12:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=A8KKZ
	ScvIjDJZy7W4HYFQlRFgQ/p613RVmaa7fHhFFo=; b=C1M7x7lYNwRrczb1K4+L4
	tOPqONapCLXt3b7VJHGEOcTX1ht0AKAvcUW1TZ06Ibp391qxtCzLGOUzkNPD59JV
	OzjVqENVVV3qTFfIrVb69lSUyfoHmuJB2zMYRs8DseovqSWC5UQxl1ptn43Ym8W2
	OerlJzfXMpHlRDIMP0YM/mN5FjPNMW1/vIZzWgYfjq3ADJgt9cZamyz+j+5Fg3Cz
	BHmEd5dDGPsXT29NGtf4JZQAnUVya37Z9UnzbdabmQhvAwMdZReinwwfcKOWN3cb
	ISHapi6/pEHDUzLyIcXdZ6H2tv6JQXSWA5LvJqqzxUAuEscE4iD/ijlLLOGJQlGj
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c08su8w3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:25:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THPig4056055
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:25:44 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 12:25:44 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 12:25:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:25:44 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5rt008516;
	Thu, 29 Jan 2026 12:25:38 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam
	<festevam@denx.de>, Chen-Yu Tsai <wens@kernel.org>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: dac: adi-axi-dac: remove unused int_tone field
Date: Thu, 29 Jan 2026 19:22:05 +0200
Message-ID: <20260129172340.34216-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: EHswqTd4oNJjgQzHHaZZu_RO0yxjjJen
X-Proofpoint-GUID: EHswqTd4oNJjgQzHHaZZu_RO0yxjjJen
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfX04OGGCFvr4bd
 rHWIWPPMximqhTlkVFHyI+6CzOCvU6rJ0YS8WDkFyDmwvLvh/dzwplWr7E9NMf6Q4TVlDJeZF6M
 ZCWnn6FIRehn/qYNpE85FE4b0EBvMppHpZ8S31QICUdgzZnXyb40Dv9KFfzrwAeP+bFJGygvTZv
 GKfxkm7aKM/yp5FRlkKdh/QqH3CG9sqwPLqziVDmFcDORUUC5QBxcRdWI+ATVM82vEpqXSHltf3
 92uyaiuxzJDUHMXeSUVueRQIpLJ1eLugJjgp7lYx+nU0ND0whUUHHW0V3ohzfxCerSQ3wm0YBcc
 z2GoeVSj3du/q0FQ3u18L3jMpdO2UgM+eMmfShPu6r29gDAPFZ0jQSPUPKCx7slmQ50Tuy/Djxq
 mS+R/FiAXTDae2V8xsvnIOBsApfvWwwcY/ofV01fzb0Gyz6vHzHpZ2nO1vuXFVE8TFYKi4X2VPx
 fq4MOWbKSYmdwfcXmIA==
X-Authority-Analysis: v=2.4 cv=IsgTsb/g c=1 sm=1 tr=0 ts=697b9819 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290122

Remove unused int_tone field from axi_dac_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 9cc895bbe51a..1ca725c5dedc 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -114,7 +114,6 @@ struct axi_dac_state {
 	const struct axi_dac_info *info;
 	u64 dac_clk;
 	u32 reg_config;
-	bool int_tone;
 	int dac_clk_rate;
 };
 
-- 
2.43.0

