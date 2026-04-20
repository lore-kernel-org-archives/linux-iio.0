Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9639478C;
	Mon, 20 Apr 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679991; cv=none; b=WwJ3ZAU2EMTI9s3AC7xCyObuTtzBQS67y9QdykdPFJOdDSOHJPa/BPZ7MKAq5lANTotkNzvtwFDezSZZ6Gf4ySvP+y9yBk8H3ea/VM2fdCNKA+2yOoS3AerFTp031UcGttHqL7r3mFbgrm5OLdI+H89nwp5Nrw39k+VNd43ERQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679991; c=relaxed/simple;
	bh=hMuhE74fEfzq2kSQLc0fcLDuT38xnIfRWj0LRq+z+Lw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjhWApmBkkSIYu/m0M8l+Gqc2cbceu2NHvS26s9ChfEunN4hnqw+9BFqTZjhoLIa9KnDxzUc85p3cnx1XCE6YL4gA5w9dVMDc1fXSPoRIlhEralyS0bjeKhRqUTHNeYt/L106pLmq7bk4QtsqJdiMyVdVdmTiuwB6WnQVXV8rZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ly1LKF7t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ly1LKF7t"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K5Y4gl2512401;
	Mon, 20 Apr 2026 06:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vAuwk
	+tvkNzIu7lLeB4jlfv1Pi5uG3RKE/nAozNZ4Co=; b=ly1LKF7tTOMsgBWmnEhSw
	kkak9nZpJujQBAEhvcKh8X7pgDFevX3acWDzfDP/YF6jwjAUxY+ylJF/9lw51JBh
	gJgISAoWuazdleJcQKt0jzCGdmB34Oj9138kIxXvh1E4zRHzQLmqmWLk3fTFWe2c
	49BXJxfW2lvdbWAuJJsSFanm3U/WaQy2l4RcrNr0w2oTDpRK6CKC25Zv6MQO5kT8
	d2N5uQoR0DNzPbjYiZ51uNXzrVOVlg1lSlogN0LequHXFD1hEAd/KbKHw1dYP5ck
	2QqQCYjDR43sTRpTu/rkH6CvPScGZTjanWpKFM8SjRIbNCpkU2HTgDjEGMl4brGc
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dmu9f33k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:12:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63KACjER007707
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 06:12:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Apr
 2026 06:12:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Apr 2026 06:12:45 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63KACUKO006189;
	Mon, 20 Apr 2026 06:12:40 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
Subject: [PATCH v9 1/3] iio: backend: add devm_iio_backend_get_by_index()
Date: Mon, 20 Apr 2026 13:12:23 +0300
Message-ID: <20260420101225.4173-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420101225.4173-1-antoniu.miclaus@analog.com>
References: <20260420101225.4173-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -4RQdcWviTtvgqUmKDiR8UoTwgIWxZti
X-Proofpoint-ORIG-GUID: -4RQdcWviTtvgqUmKDiR8UoTwgIWxZti
X-Authority-Analysis: v=2.4 cv=TZumcxQh c=1 sm=1 tr=0 ts=69e5fc1e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=p0FdBKtcRgJ3IcjSWdMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5OSBTYWx0ZWRfX/AoKSjW3gHLu
 6E7FEf77/o36uXKiHw0siIgeNQgYnuk3kL/tK9BjFdrwiB4ck8K1b8IrX0btqiBXQEn1yGNUys3
 4QRzz2mbC1WYg3bYAYCysHzLWbr4Ay5h0C5OZuE138toA287w6n9GEd9vLNjMS0els+uh8Ri1Rr
 txGYOphXeBWBDTMhTx5UkL8migtnEXf9ZvItISSrtuZ0mfRh6xoM7LnihYLeRRTGmaTJr0XQFhK
 T6T4AIRcKBpnuPJUSKTe35KTjCnBVVBzyUsgMMOyom8dstLXDOFGcHdcLvavj/+5RP8roJBV+rH
 j5XGYF13rWDmbXobE2cDa95jkljj/5O0/dgL1lRNNlhqoDQsLzbUPm8bDIKfA8cNP1DBuZ2bXYO
 CdCaQL9/7+CZMCluJ/WozMhFbvSOnQ7EVnxBqKRvqlwDj4+vJ9rgsJIuhzj5Nu/IWekHHI4QUq3
 PW17FADYcJM3dSc2lyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200099

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
Changes in v9:
  - No changes

 drivers/iio/industrialio-backend.c | 53 +++++++++++++++++++++---------
 include/linux/iio/backend.h        |  1 +
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 10e689f49441..138ebebc9c0d 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -964,23 +964,13 @@ int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address)
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
@@ -996,8 +986,7 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 		if (ret)
 			return ERR_PTR(ret);
 
-		if (name)
-			back->idx = index;
+		back->idx = index;
 
 		return back;
 	}
@@ -1005,6 +994,24 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
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
@@ -1021,6 +1028,22 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
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
index 4d15c2a9802c..3f95ed1fdf9e 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -261,6 +261,7 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *devm_iio_backend_get_by_index(struct device *dev, unsigned int index);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
 						const char *name,
 						struct fwnode_handle *fwnode);
-- 
2.43.0

