Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1038F245;
	Fri, 13 Mar 2026 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403183; cv=none; b=MoWugNzI9pNchne4daPdk9Zw9nPoa697ZmojNZj8+YizARThhhSp0f7OYG9Uri8FPxSppFe/lXGEy+hXOcA4nwYeTqpbo2yl6hlUfMAxOJgPqRjt6xr5ymvmrXVsxpudQrabDJIYMQaI/oYd2iyiQWxXb0L9lRWaewQf1mbFYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403183; c=relaxed/simple;
	bh=7St3euCNNBWN453kNHgqv+4rZOSRqENO+QU/0EUoehQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nV4DgHusfq0mOklVQPBP2k9c0pnT3N/KyoZ33U6dFPi2jhkvRGyzZZ4LikIHcj443a+BQGqEsJHkVKi5VutpuWn/JoDAXa0Bfr0KkkUMUn8xujPGPKIS9hqPCaQrgzJtbc0M7srAuDL3xdjdzpAfuXi9VkJc23w/JDbpnzvLJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r7GyEM1z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r7GyEM1z"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DBAgNf2000247;
	Fri, 13 Mar 2026 07:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gWB+q
	mDw0F5IFMn4FI6sIZem38nEzSFmG1cUa19WX+o=; b=r7GyEM1z1hnAopnRzxCiC
	84HuFY2X9O283x1KOol1abtwLM54Ilz+FlM256q4jU27plr3Wry/YdjQ+GAeMryR
	N82/MoUzACgttQewo7HPBt7ZWeLrImc9xC1H9rx2/aBwM2s0ZBoAjhLpRXa9XyIh
	rM75OF6nxnnxVO4wZ73nHzdIKGQi6rJE1lknLvvUljaPrkeOpksT1q9zGBzu4xEj
	sPMrXtD4/5hcmI7Y2UQYzXoSBmY7NG+aq+7A829PfA1aPy8GTeSJzJ42vmM3jUB9
	fZf7qEypbdypE2pfwEijYHIDcO5uI2h3cCYxtYj7CzgzsrAP98av6rqRgzV4Zq8y
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh5wpvap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:59:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBxNl2017663
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:59:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Mar
 2026 07:59:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:59:23 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBx4aB024568;
	Fri, 13 Mar 2026 07:59:18 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
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
Subject: [PATCH v6 2/4] iio: backend: add devm_iio_backend_get_by_index()
Date: Fri, 13 Mar 2026 13:58:51 +0200
Message-ID: <20260313115856.87763-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313115856.87763-1-antoniu.miclaus@analog.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX7myOk9qeR6P5
 HDa7T8c9lQx7PZCVRNba0dOJhWatGvR6ZNePikHU6qtQyIq2WNrcEBz7C7MqjySxji+Sp5KJs7y
 NVj8M8ZML15T9q1UrnilY5FqiUC79vF8/N/wo8tIxNc/wshAYiLm1cJHoyCZLZGI3BShhUVgXJq
 5c9A5DECllwBNyLI/aRIFmyD7p2bAHBU5NNMbkteL3XMv6hq4tfrGXpnu+8jkfReAJjm57lOWEL
 dHyDM3iBaRz4Jpaf/HuBGqOLAAnKC7fkRutr/dbN1WAC97PSfRfa1JZFbGs8VlrYfFeFZSEpqK4
 pPl0Obo5KkKy6r9p+yGMEYoDhotOAIhfc0cP3X8G5Pxd0TkLb0EwjTxPCtlc7T4dedpywbflJ1B
 TrsuWASHWGoPxY1y56cLJkblCZSRtKhHJ9HGA5bicAIJP7BvjsUYniXIun/ac3YOvoegLMBYPL4
 o4ZtQJA8zdDpcpISy2w==
X-Proofpoint-ORIG-GUID: 7zqf2IUKbGu7OxegBNmFXKrhCYUBV12i
X-Proofpoint-GUID: 7zqf2IUKbGu7OxegBNmFXKrhCYUBV12i
X-Authority-Analysis: v=2.4 cv=K+Qv3iWI c=1 sm=1 tr=0 ts=69b3fc1c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=p0FdBKtcRgJ3IcjSWdMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130095

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
Changes in v6:
  - Move fwnode_back declaration back to inline position above
    IS_ERR() check

 drivers/iio/industrialio-backend.c | 56 ++++++++++++++++++++++--------
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 58f7e1426095..b5ab93221acd 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -949,23 +949,14 @@ int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, "IIO_BACKEND");
 
-static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
-							 struct fwnode_handle *fwnode)
+static struct iio_backend *
+__devm_iio_backend_fwnode_get_by_index(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       unsigned int index)
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
@@ -981,8 +972,7 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 		if (ret)
 			return ERR_PTR(ret);
 
-		if (name)
-			back->idx = index;
+		back->idx = index;
 
 		return back;
 	}
@@ -990,6 +980,24 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
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
@@ -1006,6 +1014,24 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
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
+struct iio_backend *devm_iio_backend_get_by_index(struct device *dev,
+						  unsigned int index)
+{
+	return __devm_iio_backend_fwnode_get_by_index(dev, dev_fwnode(dev),
+						      index);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_by_index, "IIO_BACKEND");
+
 /**
  * devm_iio_backend_fwnode_get - Device managed backend firmware node get
  * @dev: Consumer device for the backend
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 7f815f3fed6a..8f18df0ca896 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -237,6 +237,8 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *devm_iio_backend_get_by_index(struct device *dev,
+						  unsigned int index);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
 						const char *name,
 						struct fwnode_handle *fwnode);
-- 
2.43.0

