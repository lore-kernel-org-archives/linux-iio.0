Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20293655D1;
	Fri, 28 Aug 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931081; cv=none; b=KnWwKrRjMV3ECE4q+UGQahmTO4Hckgf6B6muFTGNTy6Aip8bb5oVv8w40wAFpr2oVlNkj8OD1XY9jn9zJ6K74sDYHGd1YhpI0iijvCFwOFRiINlymWNU7c6USUBhf531kfIIIIoDY7L/5rhc0xDmeZP5bLYXjfQNqmdUbCntB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931081; c=relaxed/simple;
	bh=UwP+dmRFvcH7A5rH99QtWcNaXeLF8l4I/UN2JTuonu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TENtIuSbA0ER4mPlWnikFx3tJG9r81c7fjOY9Oj1v+lJHCRFdx0vqxRi98ZPNA+oE1bPxI41IN7lnSIj+3kJ1WocS6t2Xa9ODzg19qynoQ9mHVmYLXpHnjHaK67w2iQ/79WKhzXjGBA/2cxq/V6AhK6qgqgZZBGuqMj/uDbtFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yJyUzGwl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yJyUzGwl"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWT281593725;
	Fri, 28 Aug 2026 11:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VALWG
	5kao0/CcRlNfBD3HmtSJumaY1d7RGNLx6GvpUU=; b=yJyUzGwlkdkUN0Rm6XH6e
	vMZ5fXB+ZJ9qYYndYdkXx/dwsVv/uDTMnbuKOqIwZAW3Nb6zkDLch0LPK4uSePP6
	XRWVTizZU+nIPSWF/8B5xo30YDbnonchcQq2qQpFlijyGySVH3SI7A831FsDwnjQ
	ihWitftyQaZcvNqW7YdjfWEfdxz6QpQ9N1ChiQ7nF8QAAYuREFPyyfKtYi1mWcLp
	F7OY3ZNmBnL20itYcX2k4GDkvQY49yc/A30+1iKIqoEGgTONdDg4w6Ox/mV9YZle
	hwp7DH5CFOWxlqYvHLXCh/fDw3+zeEfEUCMuNKZj/aCac/XFFD6r8jg3e0zwOHu4
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbaebgvc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFV7Y2012978
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Aug
 2026 11:31:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:07 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3j031424;
	Fri, 28 Aug 2026 11:31:01 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:27 +0200
Subject: [PATCH v5 04/20] iio: adc: adi-axi-adc: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-4-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=2263;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=UwP+dmRFvcH7A5rH99QtWcNaXeLF8l4I/UN2JTuonu4=;
 b=n2tHuNRi0eQ+u2B7qLUT/luxby4ZKQ8gOGygW4ySWd+F/g2KHB/e+GD9qBZpLQEd/9rOfVSut
 SK8AsG6KcwvAPXlQ+WiWTi4V4LuZvhfgPxGv1YWsnC0t4Ttauf9b88S
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX+PRCpmIwt5Uz
 Ea8QavTx32C6oY8p3hUdEgxUDM+O8Xc37iAYKgKNo/KX9NFU7wtOBrQRsDTXIiutOw0j7SX+paT
 y5Fzz+FSqFkHTYxfkjp0fhSOIEJzRPIrzcN5KnR6/qd2kDEKGsYq
X-Proofpoint-ORIG-GUID: vYszla2ijZ31eJ8zxLulVLRfFrwkwFtI
X-Proofpoint-GUID: vYszla2ijZ31eJ8zxLulVLRfFrwkwFtI
X-Authority-Analysis: v=2.4 cv=WMtPmHsR c=1 sm=1 tr=0 ts=6a91a9be cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=xcMXqGzQfnDy9uQaBxsA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXxbH3QYRAsgBx
 8Gy2KQR8eV6Fi44DeHmYJ45rw9Uakea5FpvJCHkJA8gHx24uOmqLUFHuFvnYH8AyF2AbQMbE6qd
 59TKjIG32ZZBWUD2WPXgKQJPGhJGqDCgxc1g70TTqycy3VtDoQp9RphNZx7QiG1KyeC7HQO0AX6
 0by0yzAj8AGorPgbawGaGLiz8GZ2RJMjNw4xTmjJNiiKmLjiNX8G4EWL3Pj98kw6IN+4xrvQY8J
 jJEK7HzmbYbZyxGAjK1u2+dZMgniJRjGDB5HAre/4HRMBMyZPFT3scqB2efRHUPa6xsDiWlnQcA
 8I4QywLGAtgwmJK1QZo13wSdN/h6p+cc9Q17TCzhYmvd82VrxBncababCuQHUAOkeVI91/gOFiE
 q7hOW+DQC2UfN7YSXxKRPmKI0ZarOan0oiR8ulYqBQoEBbiE0wl26PKU590fswumG2O89H5Km0J
 UJXHgmMt3aOWsiXnxvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

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
index b5e59b1871b6..e8f149e230e7 100644
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
@@ -567,6 +570,22 @@ static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
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
@@ -615,6 +634,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+	.crc_enable = axi_adc_crc_enable,
+	.crc_disable = axi_adc_crc_disable,
 };
 
 static const struct iio_backend_info adi_axi_adc_generic = {

-- 
2.43.0

