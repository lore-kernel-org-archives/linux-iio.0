Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DC2D97B7;
	Sat, 21 Mar 2026 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087373; cv=none; b=gBa/DzRLyQzqB8W6DiyEWE6ciCw64qkblCOrhwzzj7RAbO/jjMEG8vWcnxNGK1kGg8yGa8+i8bl765XEFCUMuPmSYE1+TKrTXWQPwZizb0BRLy2kbXog/9ZUwMxjj/40JxTFnKMZ52INLPCCrXE44abRlJI9iymueCuOD+BjLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087373; c=relaxed/simple;
	bh=7R6owjllIurRuOy/a/0tsRmwkHUz+OD4YhSJ8bKYlM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRibFbTJyELUJdzgAh2l+x1CLchuEeLA0Yx93SjDcE9ut188aVgz3xwdEgxq6L2DqjlfVVePorzCTpvvX/p3tFhc+HpXSh+CK7zSrf52dl1YAskPDv/R7b14WiKrRjUf6baQSBxRn4LE613oOBXetLVYjLSxlcqku4cj/MkXbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OKE6wh7R; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OKE6wh7R"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L8sWJi2959650;
	Sat, 21 Mar 2026 06:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9o+VI
	rFKFEoi3ex1+qa4kT+Sm8ZMif/U0tmdbm1hYH4=; b=OKE6wh7R0oTutv8s+75e/
	Tj7tG1p4jg175AY59aapYv8aLvtWDJF9E8pg/o0zDg46vbPGYlJmvTNKut6mRzvZ
	cVubXztTkhqVDx/rFKXH42G0tgqdJS7Capb3kCFvJFE8I+S7AovXDuOWETIITNqt
	kMjLM9C8dIm+GoZr8iDuDch4ASyFMJDVpN9+HAjTw+MEHZdSGaBkyl8drI9eAsqm
	NDFh3O2Sa274lWpkbvv7I2bu54aexVBRGv+vJ4abNU/zdIciMiYH2d75dkaOjtcp
	yzOG6heltkoc1lwsO41vk6QeP/c0CBdIsC+5DV621YwJvXid0cZgLYNlTC2M/Y1o
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1r81r460-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 06:02:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62LA2Sea041101
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 21 Mar 2026 06:02:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:02:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:02:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 21 Mar 2026 06:02:28 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62LA29Ur016218;
	Sat, 21 Mar 2026 06:02:20 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
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
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v7 1/4] iio: backend: use __free(fwnode_handle) for automatic cleanup
Date: Sat, 21 Mar 2026 12:01:51 +0200
Message-ID: <20260321100154.1258-2-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4MSBTYWx0ZWRfX84UjF1iwN1eB
 hZUjiIsv/UFs8ej/8MlpVMraW1pWG9azO1RlmHlB6JJfqcse8naU5Rp57Xq17AQ3jFiOhiIdrte
 P8hqrDazkYRMlk//ftmorrPUcAwBUHXlyJFYiu89GyfwnHApZX0IBeCfzXOFhsaRWS1FtDruIRL
 O/afvgcQQqHpGZqfs1OStQBL0iDkCM6FyVaHDL3DK/WvTpQS3lGdTM89wHUfyII8wCB2XU5ArVY
 rYfH2JZ5AJ8WrEFJy3PRvxGjcNgu6pMEedX1EIytiW+cqiLwYTTGE6yg67pLDfOcc9/DfoCVoFk
 Iq5gEaKKyqgso+S1EKEEsD4/2Ia7gBk29qUeJd/8sy8OPZj9IJhbjE5vAkWa48+e1Y2aL440j0k
 OVky5DTOdOCGfZ3g6UNGdKE2o+EzxUwOugMwnBX9hDV4G+wBjx+KnbO7mFf393FDBG/Vl/Yg1QZ
 uCqB29I6jx6+o18Mv+A==
X-Authority-Analysis: v=2.4 cv=edIwvrEH c=1 sm=1 tr=0 ts=69be6cb5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=QyXUC8HyAAAA:8
 a=gAnH3GRIAAAA:8 a=gz9ygkcBebfFgqQ7jsUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Om_C4U5dVwlZC4o_8xA37zDwoZKAqBXV
X-Proofpoint-GUID: Om_C4U5dVwlZC4o_8xA37zDwoZKAqBXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210081

Convert __devm_iio_backend_fwnode_get() to use the __free(fwnode_handle)
cleanup attribute for the fwnode_back variable, removing the need for
manual fwnode_handle_put() calls. Move the declaration closer to its
first use, narrowing its scope.

No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v7:
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

