Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90D3570A3;
	Thu, 12 Feb 2026 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900402; cv=none; b=qpq1cfwR16rwnpzTGgwZ+iwMkJ/6ICVuG8TZTEmWLpwFEpr7s5iocUQWnv169M38Pee7kZxnaypfgCiSQQVfVJcVLLVN8VgitcvJvH0WPHjx6IY1J3YnvGQG9Ff1xOVCLxxWVth5cpeyHtvdhyIM5Jaga2CL/TJlgpaD+A34FZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900402; c=relaxed/simple;
	bh=O6448uk3StCb+Zt3OXOYapsWzwKSisS1QDXgdOMrFFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmiH+FaasM6GWlDOrUSLZWZkGYm5nJrh6p6z3B+uymreZy1KfHvYPUOEu8LsiEtSngtTr4U4jReyMJBO/0nFljo5nJsHcgB8kTCokCXoRvJRT2dJ+kF0Pl5YEbFOQp9p00F0PFblvtqJwH7pcZFgBHThmi27gR+1zta8bWnFgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Tisb+K7J; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Tisb+K7J"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CCJY83861524;
	Thu, 12 Feb 2026 07:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dwjvu
	baDJoSI210F/kU/XUD8m3NqB0oNfXzD5ZwyoBs=; b=Tisb+K7JZ8mUHFLJQ1WIG
	llf2S4Hga5lA8dqtuksIIiIPMgf5FnJHzwdNYQy962u8dHLPU75sbDT8PZ4XSclv
	Q+Mv076mQzYmOyNcwWdR8LnIPCg86pYeLNrz+3G5u12m+FYktzbNQmihN2m0Dg+F
	zYdiTmPgnA0Igb8P2pzTS4lC/LXo9drDueVLKBnSDGdDZsTgBwzsQDCTXcc8M6cg
	bRoumCH85dMZdv8cCL/Ri9ehrSPekq64Bb9CvCBYNKbujjbQkurcnJd5DCXAXf2c
	sADofViriMZkfrzTrvGbprFh62x5uL613dcxPHvru+kotOdDun1LqMqkflOSzgK0
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c8hn2xeh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 07:46:35 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61CCkY8t014036
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Feb 2026 07:46:34 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 12 Feb 2026 07:46:34 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 12 Feb 2026 07:46:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 12 Feb 2026 07:46:34 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61CCkKmU028003;
	Thu, 12 Feb 2026 07:46:30 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] iio: chemical: sps30_serial: fix buffer size in sps30_serial_read_meas()
Date: Thu, 12 Feb 2026 14:46:08 +0200
Message-ID: <20260212124609.24745-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212124609.24745-1-antoniu.miclaus@analog.com>
References: <20260212124609.24745-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: h9-eYO7Elg5Md9t5JESMj35niqlYojZE
X-Authority-Analysis: v=2.4 cv=AdC83nXG c=1 sm=1 tr=0 ts=698dcbab cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=YFdKGvmGAyMV0UaXN6oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA5NiBTYWx0ZWRfX7ORcdKyYDrrB
 bw3F5qK3usLTlIUpOOY7SsQ/Gg86d0cmc7IQs5bx5Ela3OGKUm5l4gWjHXptO+n2yPqoYu+vrDg
 9Rh8F8gK3EBhEXXwStKG4tTGKJ3qwolXdot6fjflKwsNAMKXb4JmAPIysn7xhaTE/PTFSD+2fZT
 TSgON3pLEPmI4p1rv8paTo8aFqkC8SzP5/4zYVs7LdIvVmaSYeDKqfriz2VRLD8stUwq4+DNqVW
 VU43AZev8e9Lu1MDtIbeQ+vYIkZmvM0k0wqO9qz05HgPIhmS95kIgBxStH9abqt1ZRaDEH8kmsT
 TyVcttQ12Y3kY1YY2vM6LRbMmkhe68dQmXGqV/CkNWJsCd5Nc+hC1gb/1F4CJi9wGoTSILRo3XA
 lGGmxixBiguDg9KADLdS/bgAQLsdVHlIzddGPn34jsL/0IN2/aA3O52Vwlzc5bbdfnNIEbmOZeU
 bTuBUkrfZVN1waj9dlA==
X-Proofpoint-GUID: h9-eYO7Elg5Md9t5JESMj35niqlYojZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120096

sizeof(num) evaluates to sizeof(size_t) which is 8 bytes on 64-bit,
but the buffer elements are only 4 bytes. The same function already
uses sizeof(*meas) on line 312, making the mismatch evident. Use
sizeof(*meas) consistently.

Fixes: b2e171f5a5c6 ("iio: sps30: add support for serial interface")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/chemical/sps30_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
index 008bc88590f3..a5e6bc08d5fd 100644
--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -303,7 +303,7 @@ static int sps30_serial_read_meas(struct sps30_state *state, __be32 *meas, size_
 	if (msleep_interruptible(1000))
 		return -EINTR;
 
-	ret = sps30_serial_command(state, SPS30_SERIAL_READ_MEAS, NULL, 0, meas, num * sizeof(num));
+	ret = sps30_serial_command(state, SPS30_SERIAL_READ_MEAS, NULL, 0, meas, num * sizeof(*meas));
 	if (ret < 0)
 		return ret;
 	/* if measurements aren't ready sensor returns empty frame */
-- 
2.43.0

