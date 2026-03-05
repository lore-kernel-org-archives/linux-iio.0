Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594BC30FF37;
	Thu,  5 Mar 2026 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710781; cv=none; b=nzTCw5iuNeq7AZ3pfkMBwExAzEBMVZ1+Pe84WVWkzuOcZ6DfiimRpez2b9SrStrem1OEpBA2Q8WW045PG6xWwddhCHAm5D9YP8WQAwCZDD1ACSx86ZE8UYnCNLlK+68c/c66mrwfpHUSeMo0RI/9S2TfQALTN5F0emThEC1qtPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710781; c=relaxed/simple;
	bh=z/xRQFer/p4MfTxUwzjvW1HTtR5z0oK2b1U/IkIieh8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foe15KxIbZLxLclfr25xKEGSD4HU8S1DgYNEEry3KWW3H89Mca8esDyLFShSk3INv076+IoCYl1rPQcI0LMaVyJxIkAuu0qPamIMecWQ6+4GtZ+J5IEcFIP7Gju7id5BVWq+twxdJvgi4RU6Qs5z7Y9ojIfd1SezARpt1x8+jlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Tnve7UZs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Tnve7UZs"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6256IqsO3363757;
	Thu, 5 Mar 2026 06:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Dd5Ng
	3VZYhWmndQwnDhgA2XgpKq1jauET+/Or+ynVrI=; b=Tnve7UZstcCiolRjrxknN
	j2gs1UUBTFRj90lJo3CRtVsIT6xT/i8uBKHgUYwAUqbRYm/i2PMFypaU+dvS/zAp
	+zUcqITYe3TG0AIJkjd57l/gYTezfcoK8ecsZu1RdwSn4JiwmPjpBdjjThdoYxUz
	DzLxOKpT9c5YDpqTxzLZWiIPHkE+vGVgzPW1yY2fQSkOKfTwmrUXFYC3JzFdBxd9
	+01hbtCheiyrUVZAheH8JDcEi/p0sn3DESyx/759hy2hn9POQ9U4z9QnaUzdhhmi
	7n1e36wnAdNYS547yej40O5wDKTlvKxWk6Gt62j/GISOLrg3z1bCYJKB8gMyqGyo
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cpdywwvr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 06:39:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 625BdLNs058590
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Mar 2026 06:39:21 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Mar 2026 06:39:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Mar 2026 06:39:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Mar 2026 06:39:21 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 625BcrWG005601;
	Thu, 5 Mar 2026 06:39:16 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
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
Subject: [PATCH v5 2/4] iio: backend: add devm_iio_backend_get_by_index()
Date: Thu, 5 Mar 2026 13:37:28 +0200
Message-ID: <20260305113756.47243-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305113756.47243-1-antoniu.miclaus@analog.com>
References: <20260305113756.47243-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Mc9hep/f c=1 sm=1 tr=0 ts=69a96b6a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=p0FdBKtcRgJ3IcjSWdMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SgJjQpWjlIsGOmhddG0j3t0ZzIZmkZFj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA5NSBTYWx0ZWRfXxH9vR3GHUahY
 asLsuJ4ULCkZH3kaF1OmzKWlu8qCVUq0adrgN7vWcbXHe2QOGPK/m4apLJp3KLWTnlx16GnsZ8+
 7wZbCs2bzFtufMfsW1epgbv6F27NeaWUcxjkKvxPEfWasPOVm3MGyXNfMpy4FeAnWvUa7+F4JUd
 Wf6q+LCHtgOZxyzo7vwgMYv38cjdmKisrSNR9VMNkWHiNZv9HuUdyqw7n92mbm06a4bvcrmmIOw
 Qy5z0z3Im58NWp6cV0dM7KiVLQTEhPeFKFU6hNxOD3wTqJyL+ahDoH/rLlhxaJPyKdq5IGj420n
 RxPILwEwrfYquYAgLC05z7Do1HNYfo7k+OL//7cobwMZCihftVAygnClP2FXbfBtidb99B/Xoua
 pBoSk+on3LOOs+29BeX6FAq3De7KKDl5F3UFdUo5F2WCF/ikXlpdD1YuR51dbGaQ/k0A1HmpDwa
 T6STYL/897WlARJwGMw==
X-Proofpoint-GUID: SgJjQpWjlIsGOmhddG0j3t0ZzIZmkZFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050095

Add a new function to get an IIO backend by its index in the
io-backends device tree property. This is useful for multi-channel
devices that have multiple backends, where looking up by index is
more straightforward than using named backends.

Extract __devm_iio_backend_fwnode_get_by_index() from the existing
__devm_iio_backend_fwnode_get(), taking the index directly as a
parameter. The new public API devm_iio_backend_get_by_index() uses
the index to find the backend reference in the io-backends property,
avoiding the need for io-backend-names.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v5:
  - Split __free(fwnode_handle) cleanup into a separate patch
  - Fix "Get's" -> "Gets" typo in kernel-doc

 drivers/iio/industrialio-backend.c | 60 +++++++++++++++++++++---------
 include/linux/iio/backend.h        |  2 +
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 58f7e1426095..ab56e964bce4 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -949,25 +949,16 @@ int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, "IIO_BACKEND");
 
-static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
-							 struct fwnode_handle *fwnode)
+static struct iio_backend *
+__devm_iio_backend_fwnode_get_by_index(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       unsigned int index)
 {
+	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
+		fwnode_find_reference(fwnode, "io-backends", index);
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
-	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
-		fwnode_find_reference(fwnode, "io-backends", index);
 	if (IS_ERR(fwnode_back))
 		return dev_err_cast_probe(dev, fwnode_back,
 					  "Cannot get Firmware reference\n");
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

