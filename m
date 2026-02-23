Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3898AD2C;
	Mon, 23 Feb 2026 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863787; cv=none; b=LLCfAGdyVTinjT9jxJvwpTueuJM4Odgq0OFqE+fzYtE9ZCZTrCZlOJy+QnpS2NUGwu7lyezv/lNEl5HWmYdEav9viePvOyLjCRtuNObvp3aDimSHINFGz0YdQLcSF86mneOtba/TUAtV+NvecXCR0wVW010djeqrNBHIWKmDzPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863787; c=relaxed/simple;
	bh=u/7dLPAmNMLUHBHw7sI5FHrAcPv/sHwIa9mHV9MPhvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW0BU8UGaEE4VxikiNGVrNwbD4ozazjkkB8dPpokNrGI15bneNASR987Q0RpOhXkgTP8li+eEuzTAIbUhpTJpWiOhod2tu6FnoDeMqqWseQ3JjiQoEdMnBcoMtB4uIXCtxLWGK8ByL8hbqVsC7efQzV5iSDx/35o0oI8pMuwo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0G5Lxdob; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0G5Lxdob"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NF8w5J2840275;
	Mon, 23 Feb 2026 11:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ToDkI
	2R21I2lUpWIhjW7wpciLKadu5m8PoR2VZK2NOA=; b=0G5LxdobTjCmfMEI9Hmi5
	ajarxEaDsdaUOaSM6MNe4cZ3B/PHE1801PWwdRzwAWpTp4bHuDO7QtO+pq1Kz2RG
	hZHgETT9sZfBz65yIpGJJFxoyoJA6Gkc0DekTYoUvHlNlQMtWSX0zn/K5bEXNPVP
	0/PIWy4lWDcD6pVIVzTb4uOxwVxx1iJf/8aQLCjj8lOa//aAoUJ6T3XPOGG2cZTt
	tKmGt8cJOyCR4eQ8rerqbI7FLjD0k3EtbyY5PkO85N6eSzRYo3fbH2AF3hTyXJr4
	eN7bnl7T5pkdMWqNE686u/RZ/T/VUlCPFkwFwDFUMIbyEtPHOxYxi99x7XgDITk2
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbbngp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:22:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NGMkxc031810
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 11:22:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 11:22:46 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 11:22:46 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NGMJUe015342;
	Mon, 23 Feb 2026 11:22:37 -0500
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
        Mark Brown <broonie@kernel.org>,
        Sebastian
 Reichel <sebastian.reichel@collabora.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 3/5] iio: backend: add devm_iio_backend_get_by_index()
Date: Mon, 23 Feb 2026 18:21:02 +0200
Message-ID: <20260223162110.156746-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223162110.156746-1-antoniu.miclaus@analog.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: zqEHoZvXYpZhpQseQTovT-STVemzcx8z
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699c7ed7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=2hSsElJEpLNoggoceKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zqEHoZvXYpZhpQseQTovT-STVemzcx8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0MCBTYWx0ZWRfXyBJC4FbPKCaQ
 afHxC7CA95QRKbBS8KHOqW2ELloPlzGJ54OlYMX7ZksXxsr0NfRnnr1UMDLpQ1HH8d21d9jpeL/
 SIIAzCaiwxa5JhpSilqmMeQXbulQqMHHUipehV5mQiyvunjltCq2E6qddsouXqUFgbH8K3ZsmYs
 jAG4BJ7CZBTCx1xC4CGwSFqqSXSwd2z8YahJGDe4Px6GJeejnquYWKKX1VHYkJgIB8fLLavqnve
 9XZMkBiWmxJTkbCWCJRlbaoWOjE7m3MVVoxTyfriEZlL3uyvnryqnQsyisIcBmtoSmXavZXVOZh
 zsyXrs+gKxJ1E4QD80cXnUBZZwCipL8xEfpvinHNY+r+OML5OIrOBhUwyfip3E3y9QXiGg9NBDk
 mTLPj4sNO+fUH3aG5bS/Xx3T1HcEBLcSZOXTAE9A0a6BM+n+HK1m8+EYXJjJB+zoq4MowTRU0ua
 YYCBrJoEQYtOm4SEG/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230140

Add a new function to get an IIO backend by its index in the
io-backends device tree property. This is useful for multi-channel
devices that have multiple backends, where looking up by index is
more straightforward than using named backends.

The new function directly uses the index to find the backend reference
in the io-backends property, avoiding the need for io-backend-names.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
  - Add Reviewed-by from Nuno Sá

 drivers/iio/industrialio-backend.c | 61 ++++++++++++++++++++----------
 include/linux/iio/backend.h        |  2 +
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 447b694d6d5f..d90a3a0b17c6 100644
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
-	struct fwnode_handle *fwnode_back;
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
-	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
 	if (IS_ERR(fwnode_back))
 		return dev_err_cast_probe(dev, fwnode_back,
 					  "Cannot get Firmware reference\n");
@@ -977,21 +968,35 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 		if (!device_match_fwnode(back->dev, fwnode_back))
 			continue;
 
-		fwnode_handle_put(fwnode_back);
 		ret = __devm_iio_backend_get(dev, back);
 		if (ret)
 			return ERR_PTR(ret);
 
-		if (name)
-			back->idx = index;
+		back->idx = index;
 
 		return back;
 	}
 
-	fwnode_handle_put(fwnode_back);
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
+static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
+							 struct fwnode_handle *fwnode)
+{
+	unsigned int index = 0;
+	int ret;
+
+	if (name) {
+		ret = device_property_match_string(dev, "io-backend-names",
+						   name);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		index = ret;
+	}
+
+	return __devm_iio_backend_fwnode_get_by_index(dev, fwnode, index);
+}
+
 /**
  * devm_iio_backend_get - Device managed backend device get
  * @dev: Consumer device for the backend
@@ -1008,6 +1013,24 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
 
+/**
+ * devm_iio_backend_get_by_index - Device managed backend device get by index
+ * @dev: Consumer device for the backend
+ * @index: Index of the backend in the io-backends property
+ *
+ * Get's the backend at @index associated with @dev.
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

