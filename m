Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6D389E16;
	Sat, 28 Mar 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774698223; cv=none; b=jl430+Lro9130w5Gf/Y0Uptnizo6CKxBAxiw54OqWNIFkN4rcOlymmm+x+5IYLcRKrRw45J2sbOOEnlERdAlyXhC2AdhIPhR8uuNsuMPUgpd9tp9aegS56aop1KASweVSURFgx6zGGjaPgUlHnjJnIlA3G56AIgwY7jVkDhB/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774698223; c=relaxed/simple;
	bh=EbMfcuT3CHZlu1XjAAaJ4l4qzIGRFox2tdnlCaFSWcM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unLaGM22Bc8t8icsA8oUM65leNusvhL2DHFFB+tX7FEFgNyaKSNlGlmVv7pc+bOYZJT2ppufflxAuJTkac6SqqQIrT5cLo2cf7XJsSYiKC59o0syjlYtFVi/NQzNmmXXdYoWS9W34K8bbLGM7JXZOw8Z861mdXXWQE1g48rykMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D8awfcBV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D8awfcBV"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S61j8s1744122;
	Sat, 28 Mar 2026 07:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jzIiY
	k/L4ymSXxDd4i94JpVQU/rAfCVXb/aCp8CcXc4=; b=D8awfcBVaqLAOb9p2SA6+
	KebT96KakrJCl9DjG0MWIbgYbhzXtH/3DPjgL31vOdRl92j2Xt1dDHd0mAjsiOK3
	LEAEC+6NUaTtaXh0cEUTi92SqamRpN8LUPd0/Prk8B3za7FzKcsSDa0Il3U0D8iH
	Eie7gz101hutiVP/POUkOj0iDwrvmUp2D8jscdXbqVzXJR2G5K2T+ZT4kL2Vh7hN
	QAd92v25eNxdMihcuFre5PknTUnm5ganV4U4Uh24lpEUtQF4CyQcPuFdF42JcKGx
	phodNmEu7Gfxc0nH4SP+e/c91nD/lS7dZVC04lGJJinLn3UctNCZFjArdoJPQWCH
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d60uhj00s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 07:43:09 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62SBh8Rj037551
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 28 Mar 2026 07:43:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 28 Mar
 2026 07:43:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 28 Mar 2026 07:43:08 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62SBgofv013745;
	Sat, 28 Mar 2026 07:43:03 -0400
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
Subject: [PATCH v8 1/3] iio: backend: add devm_iio_backend_get_by_index()
Date: Sat, 28 Mar 2026 13:40:48 +0200
Message-ID: <20260328114050.46848-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328114050.46848-1-antoniu.miclaus@analog.com>
References: <20260328114050.46848-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Z8jh3XRA c=1 sm=1 tr=0 ts=69c7becd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=p0FdBKtcRgJ3IcjSWdMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: AFy83_c4YAqg0X-uBzHLJDQhreNnMOKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDA4NSBTYWx0ZWRfX7Vu/2/AV+gPh
 OQYSHg71RtHpwhyHgU6SBu5DhhJkocHCBUrww+HDDGmPToqrt6rFi0SIxiesd6zBwEEY+eLuMvo
 awjR/UDdd+stuplFDhukCp3hG0s9iwsp2JxALmblL0Xqq9ai13l02PefpI0lEXZFnpoyATbPvSP
 vfI3dO92uae6CCCsvsab8TOTGmW/HtZtcEu9lsxlB7NJQYuKLE72eq44IwF7u224uu8zHLFyW6Z
 ohaNhCZ49AZKlp50MGR9PhRdhAgbY6Dw9wNHzssSqjJIasubIQmZ7AbB4oOWt4x/USCNT1W/lPU
 HMJCqG4jMHchWWuFFCCbkyyb1rZleu3Cg1a6f4V+lygz1KU92qEpmMwn33uyz0d1sT49hkfEtAB
 12HkQn/kRPt/R/yG9Y9v03T1/evMfgFaSwvp7P/nkH8DTgfqoP6jBYBzGAZNU00qTTHxWjQPYjE
 dKUSJen+PvVHoypbZkQ==
X-Proofpoint-GUID: AFy83_c4YAqg0X-uBzHLJDQhreNnMOKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603280085

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
Changes in v8:
  - No changes

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

