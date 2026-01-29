Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78740387359;
	Thu, 29 Jan 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695986; cv=none; b=HKmRDhs45Y+rq5LdRcytKUqfHq3/eMW493M0uhrVL66wX58suJHU3qLIUyV2s7kYLOcjQJuDf44Hmil3K26r7+EqB++h3f2c/iJ092+8GIN2nzv/LD6P1Sdk469alEgj4JufCW+vpx8oZr0MinHBvVexZiFhd8PPHCr2cBrXZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695986; c=relaxed/simple;
	bh=RLw4TTDI+Tw3c1siSqcUqw6LmAhMYcqM8e946xYN6DQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbEcGdzVTkHCx+bMY25xGTtjoylnds9V7DxyQsh8UaxcN+7Kjs82+MCDqPgCWgFjOGVCl05XO+4rhlf8lbxw8QTJ+vvG158pMDY6xJsLFQiEegN/JSyOlcg9l5wpeVhVMt8LS+5flOnLRtLJEuFpdu9FTjLW+5C5Hia+GQV0Mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ne+fF5Nf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ne+fF5Nf"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TACjpj3441956;
	Thu, 29 Jan 2026 09:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dR+xD
	+kJVx1PqDQaGcu/x42NJeFIOIKssIzwqICupJ8=; b=Ne+fF5Nf9ls4aSyxg9FlZ
	IDvC59Vnp6HaCuOUtSqqsC1sedfZurkr+ssn0fTvkkgZdwjSYjG1PoS87Pgdf+lL
	JjOWPiyZq2E/Ud59ZJ50hMxlw1S3DLBFjDPLT0qfkASZrrJ+OV2SM7V6P4w3BrkE
	dPs0kOXHRT5Jcobci9jd9xtUt0vQnVbGeGpAeUcXZx1IaBBCjScydrph3IOXOIe5
	NHl6Jr4wyQpl/s29lVqMR8iHmsgJMgJfQL5fC3yZSKO9LLBBNwrt40dSfbWjYcN3
	t/qgK+TqGl617WUdoJbNZAXjS3bmlN3yM/l4fb1Au/zN8uHoXuosPgf5NUSXYgoq
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4byfcdnubb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 09:12:44 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TEChFj033307
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 09:12:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 09:12:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 09:12:43 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TECNWK031872;
	Thu, 29 Jan 2026 09:12:39 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] iio: accel: sca3000: remove unused last_timestamp field
Date: Thu, 29 Jan 2026 16:11:59 +0200
Message-ID: <20260129141205.106285-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129141205.106285-1-antoniu.miclaus@analog.com>
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA5NiBTYWx0ZWRfX7mkPmOB4eX0f
 CUDlsm6qvn9KNkOmYZjNWP3u8NfpNNTGOw2nWvOuhHSNasg97NjuVlkimjv79B090e+MhkAZRh5
 0SEHG7l4Ll8YsihV9SxLhMRLi/asgM+fhIal6Nr/nxGMcNLbvAfXu/ZZm0n/NgTe0v1llwOLlmc
 KNWX9LdX1jzDU9pYMszCMBPwZL4K0Borw3yEAzXW3rKkv+WR6wfqQ8E7Wqs1s0s5g+3zMxCYIJz
 tY3mPkwGRL/B2YUXo+I7NnSmm8UHC+2we6b7oYpf54wFWDwH8qyZrc4FCVLF0lTa0p52MeHmbrd
 +SP9O6izjcGisZFUXqquC/UEiVGedzVDKGBCR3ocmFVdi86AXWD3EM30q4hhjwaEs8cyerRF/bw
 +3t1wTCBKkrNhuL14rOuneA5yBKVzrnJc1yFyMZiMO+B8LhiOD04TZmJ5boyxmYO0gJL1xmG3AK
 CKH6kH4sf+998frm1Tw==
X-Authority-Analysis: v=2.4 cv=TqDrRTXh c=1 sm=1 tr=0 ts=697b6adc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=IT2rJupvHceithpKudAA:9
X-Proofpoint-ORIG-GUID: DeGOYdOg6Vh4V9JOa9Baxt0KQwB_kvv-
X-Proofpoint-GUID: DeGOYdOg6Vh4V9JOa9Baxt0KQwB_kvv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290096

Remove unused last_timestamp field from sca3000_state
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/accel/sca3000.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index bfa8a3f5a92f..950b4c672484 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -153,7 +153,6 @@
  * struct sca3000_state - device instance state information
  * @us:			the associated spi device
  * @info:			chip variant information
- * @last_timestamp:		the timestamp of the last event
  * @mo_det_use_count:		reference counter for the motion detection unit
  * @lock:			lock used to protect elements of sca3000_state
  *				and the underlying device state.
@@ -163,7 +162,6 @@
 struct sca3000_state {
 	struct spi_device		*us;
 	const struct sca3000_chip_info	*info;
-	s64				last_timestamp;
 	int				mo_det_use_count;
 	struct mutex			lock;
 	/* Can these share a cacheline ? */
-- 
2.43.0

