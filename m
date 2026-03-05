Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBF21ABC9;
	Thu,  5 Mar 2026 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710782; cv=none; b=u/hMimVjj1dtyqvg66hoy31NzO/YFrNXNVHwM3FnAoJG+aeFy8uJ9tSNF3RVywp1qgK19diyhXpa+FWxTwGGcSBpycNCYT91BKsmJK3yPnVir3fqFfhcUJ0+rNYGERXXRzSMbQMNUvYBPglAnqo1vj4IOl59/uusxNGAFi4BUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710782; c=relaxed/simple;
	bh=DmmiiSsNDhuL/BSe9g2fSIJhAQGy13WjmNXPZSvKnxo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryTZ9b9HH2mxZyQWwxr8Z2O5YV7DGF59DqEoNQl6R/qFPqJ7g4ikMRAygW7R4CuuOziRN0+Na4gHBdVAKoiKgB9KKDTyIayOulTdOsQc+guFhIhLLB8qsIzcZ3tI6Ke37ZA3wKREaocIwM1aj4ixJRRd4xPUEbYTYNhotezEwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=i8c9eK36; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="i8c9eK36"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625BdAIT3331032;
	Thu, 5 Mar 2026 06:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=41G9b
	GPmdwANeal6HZ9LtWNWIQYGs3t7kf8+NVz6eBI=; b=i8c9eK36XTSBcYMQ86Uo/
	kv7ZHzdseT2c9D1CYYvKaExHF9CWStVu4Qtl9z3qqbKCB16c24ZzhhCAby+nKo6l
	wVf+doyodbatTOIEofENKUWjUDv7fT5GvTsL++grbf3LBBN49/128i/mxLofNdnP
	7ECQDycF6a0UTzrraLTMdSB7am3pIeT/YuyaaNl4h2nZmy8BsVz27qVlLzNsxAZI
	boj1+M/6CRpjphijnjUuZO1Yp/bIOkFq5RJ75CBfuVSPrKQMOjsSse3J7mQ1Tiqg
	ya1bMEhet8rmU+80sf2/xQCA1gLRb3wG2WKYiTPGx9q4BL+n9w2hng9tJkv70O/k
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cpb6jpm0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 06:39:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 625BdGJ7058587
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Mar 2026 06:39:16 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 5 Mar
 2026 06:39:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Mar 2026 06:39:16 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 625BcrWF005601;
	Thu, 5 Mar 2026 06:39:09 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/4] iio: backend: use __free(fwnode_handle) for automatic cleanup
Date: Thu, 5 Mar 2026 13:37:27 +0200
Message-ID: <20260305113756.47243-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305113756.47243-1-antoniu.miclaus@analog.com>
References: <20260305113756.47243-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J4inLQnS c=1 sm=1 tr=0 ts=69a96b65 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=g1vAQDKs6yiEOBqkthEA:9
X-Proofpoint-GUID: Jm4o-R2PJZ1pW20CpaG3YFhEGYrj09pS
X-Proofpoint-ORIG-GUID: Jm4o-R2PJZ1pW20CpaG3YFhEGYrj09pS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA5NSBTYWx0ZWRfX5S9Ih1smejwy
 XIG4oTS3mkYcwR7fFC6+T8qE8Sodel+vR+7T7ZYm2T8c/mU1UpoPuOwKDCN+volVi1BF/St6Z3H
 pesS1OA0JpBPyspYl51yhnajFyaSvC7RFLNj0qd041sP9mdvRX0pzi30M5dzAZ9y4FYuKQyQXmB
 g+7z21cownjkMuKYl2CUE5QNTRRJxhSiI/Z875gbe8swHDUqUVv9KqdaZz7QBfi2I/+YdoH8L4b
 1IMeC1/rMj1pwuykFc3jo3+XmGnOHm7oMBCGsx5KaAKRTs+N/vSPCXrXlyPfGBuU9/EPgx8o/uH
 /63yzAuuJfhUubltMJ9X0lIbb8VSzZnPB9j9MI/doklDatEQT6uHkqMVCOl25KdAhbCnZ5hnU/d
 nTpdJb4/HNs65MVzQgCKDBoQ6zyenCguUYyH3zNydrgZwCZ8l39HzVX2Ed+cFlIHl32N2BML+d2
 ki289y8hKxs9jdhDrLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603050095

Convert __devm_iio_backend_fwnode_get() to use the __free(fwnode_handle)
cleanup attribute for the fwnode_back variable, removing the need for
manual fwnode_handle_put() calls. Move the declaration closer to its
first use, narrowing its scope.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/industrialio-backend.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 447b694d6d5f..58f7e1426095 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -952,7 +952,6 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, "IIO_BACKEND");
 static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
 							 struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *fwnode_back;
 	struct iio_backend *back;
 	unsigned int index;
 	int ret;
@@ -967,7 +966,8 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 		index = 0;
 	}
 
-	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
+	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
+		fwnode_find_reference(fwnode, "io-backends", index);
 	if (IS_ERR(fwnode_back))
 		return dev_err_cast_probe(dev, fwnode_back,
 					  "Cannot get Firmware reference\n");
@@ -977,7 +977,6 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 		if (!device_match_fwnode(back->dev, fwnode_back))
 			continue;
 
-		fwnode_handle_put(fwnode_back);
 		ret = __devm_iio_backend_get(dev, back);
 		if (ret)
 			return ERR_PTR(ret);
@@ -988,7 +987,6 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 		return back;
 	}
 
-	fwnode_handle_put(fwnode_back);
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
-- 
2.43.0

