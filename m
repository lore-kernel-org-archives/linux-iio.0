Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3138D6A4;
	Fri, 13 Mar 2026 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403182; cv=none; b=qXKo5WZfkZr+bOUYo99NGqtypltCuPHzpGb3/cjGNn4AAhm+bJVTod4mIpalHg69/I+P0fifHJIYrU+CcTL+CyUP0gwoCLYuuG3/6rQ10ngE39DZsC0WLNNZ1qZcb2HyCus/UKYqpvNMpZvqKgbX1zo/z05UG8Yt8j+1/llxwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403182; c=relaxed/simple;
	bh=OoaHEFl3SU+bqGRSineHC9PGyYdGsGIaLfRT6AoldIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYVIJx0Snov2Gr0p262mM9v61WaYaed9ekA4a1wGKzsC+/mQteNtKlZy18UqWiR6jEzRXcameH7PqUZiRhBdZn+3SqASX9gRDAKqkzIf1Rb/Xs+oj6w/b/uiAb5jNFqvbuIOVSWKaEuPpRPsTg/Poa4Ic8DbPxpK2+TPuvK+1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=edL+Rw/+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="edL+Rw/+"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7Q8EQ3650594;
	Fri, 13 Mar 2026 07:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kNjZm
	fOg1sSXJsG9MMSy2olxlb3MQIpjyys3sHd6STM=; b=edL+Rw/+jGJhQym5l5bkZ
	+bd7AlrjxtLN/gyfXpxCe6Thc13Ko6L+L2LKDaC+xMEJd103IVQ73rv/5/UHPYgS
	AOZBLMAu12+1VBlFfVbeGF2sX7/3ot0nOZlAt1gjjdoFPVHhsEBPditoZC8RhGT5
	ciVnnGKtFzEeG0bsst4J5zsPciciIILHMes7ZgSWPktEXsiWwjFvTftkeGu19BD/
	1s1Te0E/zBViSuikkefX3D2aLOxhJlQpwff60IbSYwRfXbgeNk4MIHs18NdX2J8f
	6Phmmh1aTRkJlS2xY286yzvmM2pYVZmx2iJbJIQNoohNog6JZ3V0DQVDrRm945eJ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh6bf15d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:59:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBxMG1017659
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:59:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Mar
 2026 07:59:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:59:22 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBx4aA024568;
	Fri, 13 Mar 2026 07:59:15 -0400
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
Subject: [PATCH v6 1/4] iio: backend: use __free(fwnode_handle) for automatic cleanup
Date: Fri, 13 Mar 2026 13:58:50 +0200
Message-ID: <20260313115856.87763-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313115856.87763-1-antoniu.miclaus@analog.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: uLe2DZyo9TT_jdTkBLvXdYkaa6sNQShx
X-Authority-Analysis: v=2.4 cv=c6amgB9l c=1 sm=1 tr=0 ts=69b3fc1b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=g1vAQDKs6yiEOBqkthEA:9
X-Proofpoint-GUID: uLe2DZyo9TT_jdTkBLvXdYkaa6sNQShx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX0adO7XnuvzS6
 oe+4gHRykbI6cV5JBtQbJ2q0NiCz02M10B1b0WXWjsl4prSnbPn7dPuGo0jzHIODFsJF6qcH5Qu
 hNEccz9FmQqxBTL/QARBEDB+x0iVV3Eaj7oD2Zn4Goejh5iAFSBPFzhtVWmqXhG3W0z9Af6O8gf
 FN0ZflqqCNC16NClQTMr29PNCj/8P29R0rxoO7btQHueJSNvfuWQS4cUkY0HIuc0ng6YWQXmXo2
 fJ/NOZleb2RMVF2HPHO+4kYWu7fIh4xq8JAzEl9uTU7Kam+RtIEfZXGMDHQwrgCGHDdRw9pUPYu
 84GxPgtIxMVukRcwdLQIGdW8PqZGLSWrrccHV5eCTXnHboLr1EaEFQR9ttTAiRXoWsZemFypllk
 bStpPsLOCr9sHMD7IhoDKZsB8wx/Ipl1M0HRlX9DnqSvEd53lAKSiaDs5IjiNH3V5cBUV+ekH4U
 Ui231mjV6CD6XvuCH4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130095

Convert __devm_iio_backend_fwnode_get() to use the __free(fwnode_handle)
cleanup attribute for the fwnode_back variable, removing the need for
manual fwnode_handle_put() calls. Move the declaration closer to its
first use, narrowing its scope.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v6:
  - No changes

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

