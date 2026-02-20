Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46198346AC6;
	Fri, 20 Feb 2026 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593206; cv=none; b=sLzuu7aBZPx0SzLvQ/uAGHgGnzU78YYpph8N6D5r7YtMx4+AYWaRxopletA5NIhOBeFtGhsPF37mEr1GnOQ+q+ijKrH+b54djwKrVbeoQ1/v/LRA2ytkxHIjz1FEDbffU0jmz3u8KDaPUV6tRgsdDmZina18iWVuUnQ9rX9AYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593206; c=relaxed/simple;
	bh=wLhJLSu0aVKoGTWm/9Egmm8iOfhh9dXCdrrthOGhdwQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCqoZ6pllAjZqKQY/e4FbIq8XaqZ4PHEmTF3M+fTRQOAsJmtjtJ9EAg86OGhmpoz/J0tUfSDq8hEChXWraFV0nRNZfNCJI1COOkyJJ5eDsmUt7ShWx0QPzzLw2eHQP3mMsVhOzoM7XrGW/jGJW9WZoKY9Rd1RlcrX4SSMFhmsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sZDk8GZE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sZDk8GZE"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87Eoj3823368;
	Fri, 20 Feb 2026 08:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DEuFm
	NafNVsXKll4VaSZ6Pz+4oDilUnQ2SU67Xp29do=; b=sZDk8GZEFMFrps0jpeEeK
	BUiRD1yfQVQorxwffhKwsA0EYMVb9aIXyHCcFZ92gdnKfiqy7nTzR1KVEOt7uFg6
	a4IpOwtNKWvqjkuI3TVMNpisA3K5+z2/IIIQTTEB4n/bkph4EY4ynvLLUZAJWVkb
	ZJ4f2idomo6RXIdNxJj7+VmgFewPP3FQ3nY4e2JbEYOfoNyE3qDSaEVGVXLwwYAf
	4qhRA3fyhmlrBS00gaY/OYvSKS2nwtAOMZQr/Ih0ZzpmH3sdIr4FY0cPds6iOSJd
	U3u7OvrEtrWeU70Sm5tmFmsUNYRhtRFeth/y3tHFQ+FOSxdWyV7hYwP7Dn4Yg0x3
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ce0xvw0hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:13:10 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDD9Qj064737
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:13:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:13:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:13:09 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDCsHS009613;
	Fri, 20 Feb 2026 08:13:03 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] iio: frequency: adrf6780: use dev_err_probe in probe path
Date: Fri, 20 Feb 2026 15:11:39 +0200
Message-ID: <20260220131151.74329-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220131151.74329-1-antoniu.miclaus@analog.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AeK83nXG c=1 sm=1 tr=0 ts=69985de6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=QrChBGosppEjk4s3f_0A:9
X-Proofpoint-ORIG-GUID: RNYexWOfVUYrzW2yAn6mSeBvdNp8v7Zb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExNSBTYWx0ZWRfXwn/IHCt2JoGf
 ZzVFEBVmFRiJLy2EK6Py7Ts/8h+8m02s5+mPo+H49NvFfwTean2OjD9eUSOs4uGHINsp9N4lIEe
 cN8/tA/L2na5O4bYhCvlekWJILEE/il7Ed+5xgzjJNc89B5tLZJoDv7hhB99wEIkIUPlIW7q+ll
 0j1OmPVaBu/jCi8rbLMd8Ba9eTJdmAZNlJIc7whoF3TV9G5OvO1T0Hf9yE2Nz9M6TqdATxKV58k
 uP/dz3uSHDavxLjRtA08y8C2l+4A0T1mr2q++m5q6Ot1CAJMFaoP9mgirwsFadRas0LvbSL5M0H
 tStuJVANp8N7G72orPedrWOOOBsR/RZccCNyn6DdHScFONo6KrHmdqpZwgkgBGhicgAd2wf8sGB
 49ZQEICpmcDPSjfipQl2qMNpsKqODwwuBw1YEcgFsa/Eo5Fw/Y0z0DG7WgLW2ECmxGRi+h3N6iZ
 2LLXboN/lF0YG1Y6kDA==
X-Proofpoint-GUID: RNYexWOfVUYrzW2yAn6mSeBvdNp8v7Zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200115

Replace dev_err() + return with dev_err_probe() in adrf6780_reset()
and adrf6780_init(), which are called during probe. This simplifies
error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adrf6780.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index a7a21f929970..bdb922667bc2 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -351,18 +351,16 @@ static int adrf6780_reset(struct adrf6780_state *st)
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
-	if (ret) {
-		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "ADRF6780 SPI software reset failed.\n");
 
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "ADRF6780 SPI software reset disable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "ADRF6780 SPI software reset disable failed.\n");
 
 	return 0;
 }
@@ -383,10 +381,9 @@ static int adrf6780_init(struct adrf6780_state *st)
 		return ret;
 
 	chip_id = FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
-	if (chip_id != ADRF6780_CHIP_ID) {
-		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != ADRF6780_CHIP_ID)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "ADRF6780 Invalid Chip ID.\n");
 
 	enable_reg_msk = ADRF6780_VGA_BUFFER_EN_MSK |
 			ADRF6780_DETECTOR_EN_MSK |
-- 
2.43.0

