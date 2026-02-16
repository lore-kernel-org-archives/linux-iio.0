Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D530CDB0;
	Mon, 16 Feb 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247855; cv=none; b=u6p8dQlm1IEAFz6Vk4qeu+fEs1fFUvXZeuv6VzbJqLfE7DJkU6GW8620gZ7cK44z2DrMXEbYUDmrF+oMZJqou+rcfVx0EBUaeSPJNecCcsEGDxdzVgmifRQmUR6isoef6sIOJHLpHy1pfFXqAAL52/I/TRwJu3cZUBDr3dJefuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247855; c=relaxed/simple;
	bh=/zy9uQTgm9LSTatUlHVi02xJB1WTssZZhquV6eNN1uQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OyK/iYmCA4sxT2i4meRQMsE7iq8p0L/zdrIWtciCVZknivEdo0DK7hyidYEy3BYmBg2ZcM3fCHWxm5as7sDsxNAho5lSwlILYkIbTiclsY16U+XVEgfi6HPfS2MMdW4GbJayw8fObKZvaaTM1LqkNtS2rMWsDFAv+uSuJkB588c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X38IEj9X; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X38IEj9X"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G9fWNQ3758125;
	Mon, 16 Feb 2026 08:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+9sf0dbpUl2lsH6Q5ofo7tCc1KK
	4DnGS89mv+ykXUJY=; b=X38IEj9XKJaRzI/1Ot+hg8yi6DlAnF8We9ydGY6PW73
	gNL9uS67jlIycufYSH5IdXpyagHA+KeFILeJXLq7IVkdAdjbqtpXS8f3F3DlorFy
	BKIeiGXc03cEAPSwmv+ICOBzt4+pNg+YPX7r0DyyAlm9IZsHBFruGZeflU6IhXj/
	Uvd8q1uqNNK+dmwCMztiN8pIziUE6Y9CcwW3uwUOJL/mJoUp7WMU0m+3tKLz/RMh
	lrgPJ6M/3lkvTrGfGMWX7in0p/dHCY7hQhVgL7LgaYlqqA0B5fp4dA40wcDz6W5t
	CF/l2WV/C8K+YuHlkg13/f4pPbDw2/jiUEDIVEP6g5w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4capu4eyh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 08:17:29 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GDHSNM004223
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 08:17:28 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 08:17:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 08:17:28 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GDHHT5011700;
	Mon, 16 Feb 2026 08:17:20 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3] iio: magnetometer: si7210: simplify probe with devm_regulator_get_enable_read_voltage()
Date: Mon, 16 Feb 2026 15:17:04 +0200
Message-ID: <20260216131714.90508-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDExMSBTYWx0ZWRfX4wW6Twr0eHO4
 aO/HI742ttt03F+mShv/6qxu+arwcX+Tk0KZ9g/qiMljcm1DqgHDfXsQwz/WKaxkb62+lXHfGNl
 RkeFKSc7+E8yjpzqRdgcYIpIThZ7VyEGroONyiezpbY3YCqvLuXGAzR2jk9u5E48+u8AXgZLkbv
 doC2ezIAz2mm+gLeDWFf9tXvxsQhA/UGK568IiC2T76kio12kkB5CbkZ02EQoex68ZvkaU65LJa
 IuJGF38tcSPRcCnSViDWsRNFh9hSv/mAIpWqAVBVudt/QjwfN3g4fFR9a9vaxre2Q6TBuVhUs/F
 Jt77dPzaK9Mxs3gtxl53WKMnZhCxy9S7YLGLg7IYwWM8AyN604Cif0Mll8ynYeq4GCuenVNaT91
 O6wdf5QieCyu5qTuE2Q4MBuWHR64OrIgIt1lvoYi4Pdfj2zWj9c4qhssREesL1fhSAL+yQi04XK
 eLHA6Dvn4QPd+0Ixslg==
X-Proofpoint-ORIG-GUID: 4TazA8Whhhcx37ZU_3tV8-Z0vL1eMhvt
X-Proofpoint-GUID: 4TazA8Whhhcx37ZU_3tV8-Z0vL1eMhvt
X-Authority-Analysis: v=2.4 cv=EZnFgfmC c=1 sm=1 tr=0 ts=699318e9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=2vWDxPHOmwhglf-1WF0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160111

Simplify probe by using devm_regulator_get_enable_read_voltage() to
get, enable and read the regulator voltage in a single call, caching
the value at probe time.

This is a functional change as VDD voltage is now read once at probe
rather than dynamically on each temperature measurement. However, in
real deployments it is very rare for VDD to change after initial probe.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
 - reorder vdd_uV struct member placement (after fetch_lock instead of
   at the end) to maintain proper struct field ordering
 - update commit message to clarify the functional change

 drivers/iio/magnetometer/si7210.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
index 27e3feba7a0f..2a36abd1c99d 100644
--- a/drivers/iio/magnetometer/si7210.c
+++ b/drivers/iio/magnetometer/si7210.c
@@ -128,8 +128,8 @@ static const struct regmap_config si7210_regmap_conf = {
 struct si7210_data {
 	struct regmap *regmap;
 	struct i2c_client *client;
-	struct regulator *vdd;
 	struct mutex fetch_lock; /* lock for a single measurement fetch */
+	unsigned int vdd_uV;
 	s8 temp_offset;
 	s8 temp_gain;
 	s8 scale_20_a[A_REGS_COUNT];
@@ -221,12 +221,8 @@ static int si7210_read_raw(struct iio_dev *indio_dev,
 		temp *= (1 + (data->temp_gain / 2048));
 		temp += (int)(MICRO / 16) * data->temp_offset;
 
-		ret = regulator_get_voltage(data->vdd);
-		if (ret < 0)
-			return ret;
-
 		/* temp -= 0.222 * VDD */
-		temp -= 222 * div_s64(ret, MILLI);
+		temp -= 222 * (data->vdd_uV / MILLI);
 
 		*val = div_s64(temp, MILLI);
 
@@ -396,14 +392,11 @@ static int si7210_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
 				     "failed to register regmap\n");
 
-	data->vdd = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(data->vdd))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vdd),
-				     "failed to get VDD regulator\n");
-
-	ret = regulator_enable(data->vdd);
-	if (ret)
-		return ret;
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vdd");
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get vdd regulator\n");
+	data->vdd_uV = ret;
 
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.43.0

