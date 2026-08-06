Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283B47A0DA;
	Thu,  6 Aug 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030948; cv=none; b=Vxj3+DMSRSJEoSBVj2hboMeM5MJgUuoaoWhBnQ8TIibrlvTFQ1EQQmkEuiyPPRVOYX1RxiBLz6qLmtijfflvY3ZRSJGlKe0K0iYel6cQqdw0wkk2z6BFOeXt2jbeo81A9VXMB3Y40PEg8zT3s6cKWqsYgZjCra+cz82kIg/+cA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030948; c=relaxed/simple;
	bh=vCQ4zk/7TsszIXYdGJAehIA0dZS4zuEvaqQDNSqXRk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NTriS2AeSvShDD2Yq077hysXI5fdpkMadZ1vIVy62yCwLSkg/vpsxlZQa5alR0mp607I846MjF8YdksU9VOGYZQgkssDvCpA2K5thxU1gd9cETHBN4fMD3bzUCo5uKoXoE/rJXfpOxrnkyThZq0EgFhIpIffptolWbQs5CPJMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0NZnan38; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0NZnan38"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EqFrP4057001;
	Thu, 6 Aug 2026 11:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PeRG3
	Lstnxpw1Y7OeLdIz7GKXdXl7eDAPDbdun9o4wI=; b=0NZnan38UbDKXr2E2RS5l
	4blb1Fad8vsP7n0SiGqcSrBolpPjICW9ovVahI2cAmQYd3Eg5ka3zb5DviFStzJe
	EFi9FlYxt0GbZr8xC7uHZEPopJfFoBwixM7LqWBUCeC+jOr4XhndiCbnTo/qYCZ5
	O0Uv62y3UwHWsqBfdjyhyC99UHqLZ+3zVkMrkyxBtGwqzYf/AOdEU/hvpfwbb0GF
	DlUC00alXB3NVoswZ2yztAkg+8c4SgKio5gGQXzt+D+nGA6O2N855JPJ4J0lOxCl
	ZAgyKR1o3ZW//eKXtRDPUBrlAnAy+JH0lEZ3/Mis5dqsw2ye03aaR4zTzY+2KFzg
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvp4ttnp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:42:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 676FgBC8007041
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Aug 2026 11:42:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 6 Aug
 2026 11:42:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:42:11 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 676Ffcga008127;
	Thu, 6 Aug 2026 11:42:03 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 6 Aug 2026 17:41:22 +0200
Subject: [PATCH v2 3/7] iio: adc: adi-axi-adc: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260806-ad7768-driver-v2-3-027ac5e2a641@analog.com>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
In-Reply-To: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786030898; l=2723;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=vCQ4zk/7TsszIXYdGJAehIA0dZS4zuEvaqQDNSqXRk4=;
 b=dyZn2wi+UWZjW1prv/UYD0J/UK04J8azwUzS2Ep2a5HglNQ+paEWmMoa/gsroXB7wodWEeOP7
 x4K+fdbIfYKC/+eW8UERihzFQkRchWyueloa5JVhrpnI/ORZPtWDIPI
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -Gu_O4Xe6EXHYsL36kEiWZOpwoCRWJXz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX/MurkZq2yxw2
 geZbn+Ee7ErUr8Ih01KRETxVs84Hvlt1PzyXByc7gTL1kERww7V3/xsQ4AnYJe8cforw7SxFk2x
 va+8gqZeLXSQi2N4M/N4RhZ8y0Moq7v//Dcst/7OPDFfVpFtDYicWt0LSy9C8JPJ8yZOoMJqrmr
 BfKgXBYy1gS3D279FPU7VhAw1ca+JvZR9zVA83t1ED71PI7hwRtJOhQ7k3IxzUGF+oUm1Lyz6CC
 e/ZUsyCIQ1Vwb9f1m5t58QUrssaU/b+3qPesTFCJIsh547ksdGvA8tqrNjxe62xpYb1fnuSqoJg
 lhx4pGtzO1qwQKc0dExkRYwq4V6aFwA7NrpYzqffjl0pGXDNwYlp+p8cPzwc0Iyo0A/VKFmRakR
 EemMvN61mQqXi3ynC7wqd5Ov6AoBB78m8L1ZwBUUmo24hhEz9LOkjJfy/ZGPCjkqiQ0Ln3de3Ux
 R2rycW03/JY0EBl53HQ==
X-Authority-Analysis: v=2.4 cv=CIYamxrD c=1 sm=1 tr=0 ts=6a74ab54 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=xcMXqGzQfnDy9uQaBxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -Gu_O4Xe6EXHYsL36kEiWZOpwoCRWJXz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX4TvYZypBJ4fX
 TY2RP+keiaJVi+Y7Z0Z+EEvcKcyZGiY0buAIMDwdO0z1/V8fPR9G6GmccLwzxXeQQQ8oOFl2lBj
 uNMh19qUmFBBSKtSHxDRnrsx4iB1PqVDPOnHRvTeORamquWh/tDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1011 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060121

Add support for enabling and disabling Cyclic Redundancy Check (CRC)
processing in the AXI ADC backend. CRC provides data integrity verification
for high-speed ADC data streams, ensuring reliable data transfer between
the ADC frontend and backend processing systems.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 26b9c75bd4d8..a9e25e09880e 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -47,6 +48,9 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+/* Bit 8 is common to all AXI ADC cores; bits 7-0 are per-HDL-project. */
+#define    ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK	BIT(8)
+
 #define   AXI_AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
 #define   AXI_AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AXI_AD485X_PACKET_FORMAT_20BIT	0x0
@@ -567,6 +571,22 @@ static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
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
@@ -615,6 +635,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+	.crc_enable = axi_adc_crc_enable,
+	.crc_disable = axi_adc_crc_disable,
 };
 
 static const struct iio_backend_info adi_axi_adc_generic = {
@@ -684,6 +706,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.43.0

