Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F7F282F22;
	Sat, 21 Mar 2026 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087376; cv=none; b=Lk9PouvlglXteuocuhpnMdNhaqed8aHxqRu4QZ+eMUpP9vqK65Ba4nfR6gYNDqGn7dFz0jVROP+rxe/AUbq3ihvSWKFNWLgETrY6sQRwES9UVv5j5I4ivqecG35rQ6rSaYOJDC0JsQ1RPr/AdVhNVZsfXBr4EWJg1U+2rNVhTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087376; c=relaxed/simple;
	bh=jGkOwOO5CqDyiJrf0G0lz+I/hv0D/jqDYzdd0R9wcJU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5qGF5oT+X87O4TbzkWmYTGSw3EOp4Hi87SvcTe7XandSq0xXWUU1lUCoPyiNURypD6W6ttc5Fy7xdFsvsId7e9dCu1Exm1DvEleRuVWy1ctS+xiN+Fy83D2cVNrItwMNrlkZJFJ1m2uP4DonoRzgC5aQVPcvCVMK7JhedSVVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QGMXnmJR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QGMXnmJR"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L4qAn84102191;
	Sat, 21 Mar 2026 06:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wY2AF
	v6hgn1n1fU6mZFfUacBN20yY07Cps0vkOIDmpI=; b=QGMXnmJR/bEAmBGLLVYsY
	ALw1T7saa7pMQqs1XdUp5NgIbWOOMKvSFCdlIIoXuWqV/LtNoY7yVYqkJXtF2ER6
	3nXp0Qz0xc+2oZEzcUTsh/gc4kSWJKjNB8Z4llRt85y1Y1NWqrxDOJ5cdDERzYOQ
	lnZitB0HqsFwusc8TYPM9YXedUH+t7CpuBPiCzHS+a8rAPkc39qUShy6ki0bql9h
	DBHKlozQ2Q+Qab2h7bKydFxCbK7GjS5wlkZpXCddIYvQuDe4KLbwfxGEvuccjtiQ
	UzBFRZV1T2XumH0xAZLvuGD1LSVdG30yjXzocs9QNX1IYD+vs3Er2g7W20XrWAYU
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cyxn24msv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 06:02:32 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62LA2V0X041107
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 21 Mar 2026 06:02:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 21 Mar
 2026 06:02:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 21 Mar 2026 06:02:31 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62LA29Us016218;
	Sat, 21 Mar 2026 06:02:24 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/4] iio: backend: add devm_iio_backend_get_by_index()
Date: Sat, 21 Mar 2026 12:01:52 +0200
Message-ID: <20260321100154.1258-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321100154.1258-1-antoniu.miclaus@analog.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PejyRyhd c=1 sm=1 tr=0 ts=69be6cb8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=p0FdBKtcRgJ3IcjSWdMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: pDNEY73SWf2QiPiZD-eYPEl4fzHyHMl8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4MSBTYWx0ZWRfXxyrseqnb5J8t
 dPn9a9oLmxrMicM3DK/jEIfKhP+pupf2g+j+bbGtFLpVg6Pp+9OjZQPaF3eLdAkyZt8DjQ0GmtE
 eYYINrCQ53kVLomj6DY5VbJLApApBwd4zHaPh/atH1hIs43CFBtxym7GNhLkTNqqCV1nH28qo9i
 IztXIy5cDDJoQgq1VoTY7RUNyLluajeVbgkbh2Dc9btqWuY01aOOaEOUJkDoBEYSEuZ1v8xKRvN
 amXIpINszUvLBTe+G8vKKVYiMgW3+/X6qvVpxDLcjBlZD+MtsTbCwx5wHV+xbcS5kguQTNG241M
 rD2LIev5jWRebrgc7ZV3h1B/Lout6MKi23kgrDVcJtPXCb+asOHJ38Fo1AWQuonlWsdOCtBFsF4
 vzqjKbQR6PCPDDi8tpN0bE5Faw3+ax8ZjqW5KISQB0Zh7JAjvYLo91QTJ5bg6avD1spRsh45Y3t
 287EtdZG3Jg6kdWuMlQ==
X-Proofpoint-ORIG-GUID: pDNEY73SWf2QiPiZD-eYPEl4fzHyHMl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210081

Add a new function to get an IIO backend by its index in the
io-backends device tree property. This is useful for multi-channel
devices that have multiple backends, where looking up by index is
more straightforward than using named backends.

Extract __devm_iio_backend_fwnode_get_by_index() from the existing
__devm_iio_backend_fwnode_get(), taking the index directly as a
parameter. The new public API devm_iio_backend_get_by_index() uses
the index to find the backend reference in the io-backends property,
avoiding the need for io-backend-names.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v7:
  - Use 100-column limit consistently for function signatures

 drivers/iio/industrialio-backend.c | 53 +++++++++++++++++++++---------
 include/linux/iio/backend.h        |  1 +
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 58f7e1426095..d6e922c65347 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -949,23 +949,13 @@ int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, "IIO_BACKEND");
 
-static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
-							 struct fwnode_handle *fwnode)
+static struct iio_backend *__devm_iio_backend_fwnode_get_by_index(struct device *dev,
+								  struct fwnode_handle *fwnode,
+								  unsigned int index)
 {
 	struct iio_backend *back;
-	unsigned int index;
 	int ret;
 
-	if (name) {
-		ret = device_property_match_string(dev, "io-backend-names",
-						   name);
-		if (ret < 0)
-			return ERR_PTR(ret);
-		index = ret;
-	} else {
-		index = 0;
-	}
-
 	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
 		fwnode_find_reference(fwnode, "io-backends", index);
 	if (IS_ERR(fwnode_back))
@@ -981,8 +971,7 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 		if (ret)
 			return ERR_PTR(ret);
 
-		if (name)
-			back->idx = index;
+		back->idx = index;
 
 		return back;
 	}
@@ -990,6 +979,24 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
+static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
+							 struct fwnode_handle *fwnode)
+{
+	unsigned int index;
+	int ret;
+
+	if (name) {
+		ret = device_property_match_string(dev, "io-backend-names", name);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		index = ret;
+	} else {
+		index = 0;
+	}
+
+	return __devm_iio_backend_fwnode_get_by_index(dev, fwnode, index);
+}
+
 /**
  * devm_iio_backend_get - Device managed backend device get
  * @dev: Consumer device for the backend
@@ -1006,6 +1013,22 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
 
+/**
+ * devm_iio_backend_get_by_index - Device managed backend device get by index
+ * @dev: Consumer device for the backend
+ * @index: Index of the backend in the io-backends property
+ *
+ * Gets the backend at @index associated with @dev.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *devm_iio_backend_get_by_index(struct device *dev, unsigned int index)
+{
+	return __devm_iio_backend_fwnode_get_by_index(dev, dev_fwnode(dev), index);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_by_index, "IIO_BACKEND");
+
 /**
  * devm_iio_backend_fwnode_get - Device managed backend firmware node get
  * @dev: Consumer device for the backend
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 7f815f3fed6a..ce2263d4c2de 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -237,6 +237,7 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *devm_iio_backend_get_by_index(struct device *dev, unsigned int index);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
 						const char *name,
 						struct fwnode_handle *fwnode);
-- 
2.43.0

