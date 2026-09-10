Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961A568550;
	Thu, 10 Sep 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061861; cv=none; b=sgpj/JcFGOUVYiFmu/0UEmMxjCOhLijohoVAfIbftIa0YHv3pYG33VrGIhvNVuK6JzPqAFPTve4Z0vL5K+WNUNhiNgTvR8MiewzmaRvaoVeqetiy3FqOJ4lGboATdRPIUWx43F9VnIizYaQmEEMVrZMw/HUbDt7DLwACI3yn36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061861; c=relaxed/simple;
	bh=9U3ZkBZOT0Bl66QSM9ctgUcEGlj948n+eirxEEksq7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tM3+67ToScd5Ta9Yi3dePS5YwCDBHlFSPoUOjQwkotAWDMcbx72deleh1RmDDS/ThqMN/sH3kOdHnJJVeCUWKIlk8iKvirA9Kts9PJPPJBNl6eir7aAywKu4m524Djjn5cgUOgpcWs87wMCLKOzYzrP6X5/SGaxyAdhu9cTuL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eMfS/s1E; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eMfS/s1E"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7G6O3263777;
	Thu, 10 Sep 2026 13:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/fLlw
	wIH4FuW6mKbSN23ldhiq5zEMnS/TMI1O212qdc=; b=eMfS/s1EaupP2uo24W7Ip
	4e01/gDxo5NalshNdJTvXNKEd2pRMfSU3jpD/zzaHW2SzVj/9WD4RWItlPgV/k4g
	wF+rnP/C6K+KTyGJgZ78CXWWM4ivqfzvHej2Nt/ofHb1UfXs2AANIP6qD4AD/3QH
	gNpo+YfiOJ3DfHljZkFgHgMNo57WDqWeywYZvUca+PtIZgsi6SG+39gpMQDwxMPO
	wN+oLaO8Vblw9JPXK2zDbgcAPnAWSiWQ41h0eWqDiQndIv4s/o5VvdPs/HkAarxI
	15qAeR5PGuyl30tJuqHFErzSNN/hkwan+Udjnc2q3hjWocaEuDmNDVVFtGI9VFlx
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxcd0v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHb9Em038776
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 10 Sep
 2026 13:37:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:09 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSa018832;
	Thu, 10 Sep 2026 13:37:03 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:22 +0200
Subject: [PATCH v7 04/17] iio: adc: adi-axi-adc: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-4-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=2263;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=9U3ZkBZOT0Bl66QSM9ctgUcEGlj948n+eirxEEksq7c=;
 b=RhzyMQx7Q8mUvSf8YnF39oys+nR0JkWZ6tiUbqDp2GORB/aFyFS4uI8wx5x4HfWIcoQnLubAm
 l4km2a8Xf7EC0JvRKbTsSy1fFzEEH0trFsrCh//B0y3RM8DA4TtHcNv
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PZFqFShd c=1 sm=1 tr=0 ts=6aa2eac7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=xcMXqGzQfnDy9uQaBxsA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: oJ1odNfbFKkZH7jYTYOZC-W4wpkU5vG7
X-Proofpoint-ORIG-GUID: oJ1odNfbFKkZH7jYTYOZC-W4wpkU5vG7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfXwAjcUVNdQZa7
 5lj4T5podBrQmmdSvfw2lwlpKRUCxCuU8RYVFRXvhUEwJC/rRMARLe3DM9aIAlKy5AnZbHzBHYg
 S90nL3rpmGB+gJPjlOl+8eBG/bUPrgFxUaeEOKp/1KKOs2afdYlJYSeWFFBhETyPlap1SrAX9KM
 shGzH8t2CBIG2WOdhgsq9iKvcnUsG6u2u/P4ZEPY+6nlMwkOi9xy94zCVx6OdYQ2JzjbItMGmSQ
 a0tzz1l+mrrurBepw7Vs5/d9YQkNDhzhOMpUIuiJ7J9T7vV1WQQJ72xV3T/5wGII2dTib/LlmLr
 2pl7uGejQYY4/zVSbM60EgaV9YcJRi47PnrNEgabf6xq2L/cvsklKvUzuzOD8gGskI0RTo2iLkV
 8VIOba4fqHTBfhqhRzm88jXtTKX5hxAjBwzqZEn2YiR6L22DyICEHm/C2huNTO1SSW2c1m7T1De
 bc94fCZFmKJN580q4xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX8Pc0WBfJzHFg
 9sdoB8oxoqmNbovIk/FwnovK1meAMq8Lg+fDGfaCfjHq1MwtoG7r3ah+JrX73rwASemJ3+FFyKL
 BslwgCmTczMQtyjiqzGa0pZ5gohGC9gYHMNDHhPnlK1Jr2VlKKOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

Add support for enabling and disabling Cyclic Redundancy Check (CRC)
processing in the AXI ADC backend. CRC provides data integrity verification
for high-speed ADC data streams, ensuring reliable data transfer between
the ADC frontend and backend processing systems.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index fc7cc92b35f0..8b7c45d51dbe 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -47,6 +47,9 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+/* Bit 8 is common to all AXI ADC cores; bits 7-0 are per-HDL-project. */
+#define    ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK	BIT(8)
+
 #define   AXI_AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
 #define   AXI_AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AXI_AD485X_PACKET_FORMAT_20BIT	0x0
@@ -596,6 +599,22 @@ static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int axi_adc_crc_enable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+			       ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK);
+}
+
+static int axi_adc_crc_disable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				 ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK);
+}
+
 static const struct regmap_config axi_adc_regmap_config = {
 	.val_bits = 32,
 	.reg_bits = 32,
@@ -644,6 +663,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+	.crc_enable = axi_adc_crc_enable,
+	.crc_disable = axi_adc_crc_disable,
 };
 
 static const struct iio_backend_info adi_axi_adc_generic = {

-- 
2.43.0

