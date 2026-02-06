Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83969318BA5;
	Fri,  6 Feb 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394088; cv=none; b=mO+kRM93cMWrUHHBMkWxhh8GC9ib2OhXVJ7IhbNR1zjBHiUXsjyGtNxKP/hiTPtVgrXfn7gtEQjBLerD4OoSoRcfzKUd75A5bjpJzzkol/Ow1G5xnIZIm4kx6MouDz63UOD4us8HPfykRUrNf/rELtvAqzxdq9DjrrMaElLrPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394088; c=relaxed/simple;
	bh=gUFNeiRe8VlWcTt7/ZpjKDl9rspSkpeHKX+epwrPkMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYm+RkSqU8BFltXa0rMeyRf12Dtyz3tkcg7YylAJ0SrQsc22pzLlNLWDCxGkSShLnWUmMHtJiZHwwsuLu5QBdHJuzs3iqtwKA2dlJixt0P9WPf9nSOA0DCleipMIMUhnWEabDGw/tNUOgtm8acCetZXJ1Ygr8kHBUUWKhzjlw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RBjayxo5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RBjayxo5"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6169sMkQ897366;
	Fri, 6 Feb 2026 11:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VFbCV
	GNdv2yThIeAGDi2mdyQ+gW2WPqNqQTksbU/6Jk=; b=RBjayxo5bFhvJpUZuW+8F
	3OusLlJcF4aVQ4Fh+Rda9kYjggb6hOCvVsx1KF3ROCOD3F7htRUVPYMMJVJpjvZS
	vKtLtL516MZrDI4BRKhY2oSHq2U4ulpE9KEMmUZxh0IMujpOTC63YEYJrZ90veSq
	tqWz8216GmcOG3I07eKv8mzZi0BqtprBXO4fn202iYV33DrpvKNjTEgyEtjms8A/
	pq9Gnnqcg1RLw8LRoOKeR+WWgNHnDc3BjecDOsUhxDKPsM0n1idRbdKIHSmPbK+p
	awb+F4CszLhGzbFXyDeT3GyT151+I/GIev3xPpyGzlzpnczmIiri1Co6XGldaBvh
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c5e32h4ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 11:07:44 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616G7h3P057147
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 11:07:43 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 11:07:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 11:07:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 11:07:43 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616G7MAm000370;
	Fri, 6 Feb 2026 11:07:36 -0500
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
        Mark Brown <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 2/4] iio: backend: add devm_iio_backend_get_by_index()
Date: Fri, 6 Feb 2026 18:07:14 +0200
Message-ID: <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770393792.git.antoniu.miclaus@analog.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: JJ-AgCM_M_qyH0cFBrszPr9GlaYrv-wB
X-Proofpoint-ORIG-GUID: JJ-AgCM_M_qyH0cFBrszPr9GlaYrv-wB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDExNyBTYWx0ZWRfXyGfleE23ghY6
 dWOwcRS4F75XVjwfFjOSUCfoYSaB/9OENdQmH6+nvf2EZORgcihnZvdDbz5CFh6lMo7W9NM0wfq
 ern4XD6cqU/li2OuU5DcbfwPpfLgRCKjaMvrmvyZEla5tX2ZQ5imfaqkg1qFYrfR3B63YgKJgku
 8CZs2MWwiWF2n4QXZYtDM/LHjTg1Kez8BD5lkXizi+qq72+xfzrmLdwdefOQv2VvSpn7jN0bVvp
 VngA8dbFbF4+l+le224lBJsJeHjQ7rKNKvgxrnNKfq8ZXcrReeyp/GCC7E2NtRG/Z7f4LxF8O5o
 R5+YNJEks+upnIKGYQi89g1rotkUZ9ZhXDBVwFllyGXjzyDyvVsYYGHaMNVRxxp3R8UK/MakO62
 ej+h5RIG8jUp0FYbr1orhJWnPhoQYAngmVO/rDIPp1avACjT/3SIMrsFMAbl/HK99xwjxSm99Uc
 JP/ewpu1h1SCAfwRTYg==
X-Authority-Analysis: v=2.4 cv=NPzYOk6g c=1 sm=1 tr=0 ts=698611d0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=uDLBfjgilch4dD8VpdgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060117

Add a new function to get an IIO backend by its index in the
io-backends device tree property. This is useful for multi-channel
devices that have multiple backends, where looking up by index is
more straightforward than using named backends.

The new function directly uses the index to find the backend reference
in the io-backends property, avoiding the need for io-backend-names.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/industrialio-backend.c | 51 ++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 447b694d6d5f..3b692d48481e 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -1008,6 +1008,57 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
 
+static struct iio_backend *
+__devm_iio_backend_fwnode_get_by_index(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       unsigned int index)
+{
+	struct fwnode_handle *fwnode_back;
+	struct iio_backend *back;
+	int ret;
+
+	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
+	if (IS_ERR(fwnode_back))
+		return dev_err_cast_probe(dev, fwnode_back,
+					  "Cannot get Firmware reference\n");
+
+	guard(mutex)(&iio_back_lock);
+	list_for_each_entry(back, &iio_back_list, entry) {
+		if (!device_match_fwnode(back->dev, fwnode_back))
+			continue;
+
+		fwnode_handle_put(fwnode_back);
+		ret = __devm_iio_backend_get(dev, back);
+		if (ret)
+			return ERR_PTR(ret);
+
+		back->idx = index;
+
+		return back;
+	}
+
+	fwnode_handle_put(fwnode_back);
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
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

