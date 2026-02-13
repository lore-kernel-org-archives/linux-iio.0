Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE2363C50;
	Fri, 13 Feb 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994294; cv=none; b=isDJ5VsZ2INmuAc3wkOYnt25eP50pN7yFPNsfRHN/UO4eREAg5zNfF5MOA+pUKXp1gpeUlOeLrZsyjpg+w83fygfyZ5NwoWmJGNqfd9nWt/ibbzYEDGqw2BYpLLH7GyWwB2Tn6AP3SsEA2ArmyXT9jLkUdIdvYhuuM8gq/DK5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994294; c=relaxed/simple;
	bh=VwmAMigC6xAaa8o0AvSl5/BWbUC3ynvJhG1eLuQ8bXw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wj/vY/eWwABxkgRX/uqckfPd+wFj5AeceT5iOJ8I5wJm3MSABE1KkciLR7koU8pSM3nRJ+Z+VHhGmwZtA+ArtqG/x3TN6yCpEvEw/hKEfRbdAbFXOencvykXzjp9AJowRX13R4V8Li+mwmgqHMxD5N4Q7MMJYJxcpT+eXgDTSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=im7uBeHg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="im7uBeHg"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DEEwDc1628471;
	Fri, 13 Feb 2026 09:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iNi2y
	yJGkEglasWu+SA+JVBk9HCkheX9kpCHjg3/tcY=; b=im7uBeHgOMl6sIZq+cBUJ
	jiG6dq0gBdUQWp6Hh7LuDmGQ9el7ypVCvqYQnA667OVjQLipqurstK5G+DPVHyM9
	+MHHq/MY6whC6SjYQtAuuoBhRm60MM7Oa4+SWpmYLlF2jNmDXt3sqEcY/CZjTw6y
	oVtmn/8j59AFtf4Hp1Ai2H7KfYQ8HcEA9JhgJzipvhvPFOjQ4IP8DYCZYv5LFHcI
	SolWbaduabcFYmRtLaYiaDbw8CrSUfwBytI62r7GgR0QO+nSXTVAPj2l7iy3tWNG
	+i9Za6npOC/z7rJY4fSrjd/wUEoV5QGitQOrUQR4rRBYpCeq460MTbUvkjr3BcWq
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ca5j504ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:51:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DEpEL1041670
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:51:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Feb
 2026 09:51:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:51:14 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEop6J018676;
	Fri, 13 Feb 2026 09:51:09 -0500
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
        Mark Brown <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v3 3/5] iio: backend: add devm_iio_backend_get_by_index()
Date: Fri, 13 Feb 2026 16:47:35 +0200
Message-ID: <20260213144742.16394-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213144742.16394-1-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNSBTYWx0ZWRfX5MI5JTEAFdbE
 YwRT6EAP+Jd9UNq6DOUu/4sJ3VykmWE0knvsVqVFpoBRlPEc07DPJYfJTkSMS63zqWSPXmBNYnr
 kz1pyc4dPvpVRXkwE//QUDvdF2IevG30KfdBe2fNEaArJDJGd0nqDKGtuX27bqXlAd4vJWtJXaE
 6w/nywNCGa8yiz7Z2rI1FcSsjT5efKatSPTbfiXVvjf2YTe+7+pUBK2GmIEEJwYUfUyWjAT6JAV
 SYAhD6COQli/Wr80B3LaJlTrYNkSt0P1h6ZQFg1QVvzELNSgJwN+k4YLAGHQrgHmzLaFpuCdER8
 fZskSnVqYwbGtdRzXx32u0e2y48KYVst/NNkY8n/iugBv/shUfJmarFrN/5S6nsd0/E6h1XRXrd
 lYW9DdAU9QPq7qseTYPh5EBmPjBV+wAkagUkWVkquKsQBTN3xszalgCMbYDwFljW+wE8GEIpdyn
 asoiFrpxdc0T4+Ee15w==
X-Proofpoint-GUID: ZvGHo8pv9uZhsEOjORlJEgjW93W4sfyt
X-Proofpoint-ORIG-GUID: ZvGHo8pv9uZhsEOjORlJEgjW93W4sfyt
X-Authority-Analysis: v=2.4 cv=CPsnnBrD c=1 sm=1 tr=0 ts=698f3a63 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=2hSsElJEpLNoggoceKAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130115

Add a new function to get an IIO backend by its index in the
io-backends device tree property. This is useful for multi-channel
devices that have multiple backends, where looking up by index is
more straightforward than using named backends.

The new function directly uses the index to find the backend reference
in the io-backends property, avoiding the need for io-backend-names.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
  - Refactor __devm_iio_backend_fwnode_get() to reuse
    __devm_iio_backend_fwnode_get_by_index() instead of duplicating
    the lookup logic
  - Use __free(fwnode_handle) for automatic cleanup instead of manual
    fwnode_handle_put()
  - Set back->idx unconditionally in the by_index path

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

