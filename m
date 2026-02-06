Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D93D301F;
	Fri,  6 Feb 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383386; cv=none; b=FbDJvY+SJaBTHtmIKh4EQfvCSYJPyOWLnDegx2+nZE5jrjYXZFFp7OPLSgrwgnv20umqMh5dIgoP2/ZBjS10j/vxm7e6Dv0MTNDjZO1M4hA8dIjkjxuSky1o5remCv8xY1z7cwfX4Fda0UvTu+6y6ngBd4dXK2uovi4DiFfA8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383386; c=relaxed/simple;
	bh=MZnYBDEvAqTT9GG5XekxJRklffQpIZLJnCEpA8PZMAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gt01WWIPYCeYsX5tUny1qh/n/bCI9pCF7k27X12aK0aDvwgEIYvYfj6pkAFdNOFKnE7X15aT6wCrEJpA2DzparZQ0ojMIpOUgZqBy1V6d07DfrIEnAUgl3w6pXfd6vfKUkJ/6Kp02aCzn98b5B+hFqmmvkzQeXMgcPvocGcjSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fSJGshS1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fSJGshS1"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6168AYiC2060053;
	Fri, 6 Feb 2026 08:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oVuSM
	tz+I3oC3v1ThEko7ys4szGhPALLLpkRZR3mho4=; b=fSJGshS1laXfzcQtKCkFn
	BObqE22OnL05wT+dZNvwJR87ZZjjFA8pG3rhX4XlzDaNXyJvsj93SXvtUgD7L5/r
	5AdmOCjY94FnrY6F/fpVY9YkxAcn1EMPRzKrqb4FsAcJAlfJUP4M5TF239KIXhWM
	kJ41dJ00W6BHOpMgcOIYNx0GGcXNTlPoNN2UK3eDakIDIV/SNubD8MuOLhI/zBw5
	jepcQPi43fu51wIHxz4I+RKVCmaCsQA+O/hg4x1OrN0slIoRwvSaMb5dZO6ZTSOU
	emJVZvHIBOJ5N06uR5+EjHYPW+/cYkDjFW6zh7RVCnFaIghV/jzuoyriXV3qnGFG
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c4ygqut9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 08:09:30 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616D9TYv038240
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 08:09:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Feb
 2026 08:09:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 08:09:28 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616D91JN024213;
	Fri, 6 Feb 2026 08:09:22 -0500
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
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] iio: adc: ad4080: add support for AD4088
Date: Fri, 6 Feb 2026 15:08:25 +0200
Message-ID: <afcd7b733511ddf5e96d0b539fd3593edf3d8c45.1770382796.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770382796.git.antoniu.miclaus@analog.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1VKmOoX35JViruwru6_Aw5XalK0Z9Ona
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MyBTYWx0ZWRfX0Z5hpXdfdqQp
 Mrbx2EWXCewZx6iV28vFGZ6mVXQu4l1LhjwhjrCw6h2DjyOHkpf3yEWMmk8WBa/fFpH1LcDE7dN
 hJFJVLVllE3VZ02mXD2Q7wQyAy6UK3+YsxGfoNi7RGJqRTya5sxllRXlSmKoUD7EC5QCZGeBXA2
 NT+kuJNk0QbIknW6UAxwufkIT3k+qnNEVMFtq1oKvD6RmcBWpXa5ra/hteuGDmaMW1LXIMs74Od
 gMe5LLekTsS1cQYp29JOI9+9SexJkx1ObXZ6HlZ9gpV5EtqSUDjB5aw4sx538CrU1Esd3+B5qlM
 1+95YOoxkS/xSssVZR/HizS5vOuMHX0dzwPlGtODIOMiOfrE0p+PFv3crVIC+ZqKozWXwwA39eW
 eeUy14jnfPjIxYfWnipqHJXhxKns5ZijcpZ5Ny8vpsUtw3ky+iiDWt7PzHgWHw1OlyQnQUKCIOw
 M7Ze4dKZiwN3yZGNkbA==
X-Proofpoint-ORIG-GUID: 1VKmOoX35JViruwru6_Aw5XalK0Z9Ona
X-Authority-Analysis: v=2.4 cv=CLUnnBrD c=1 sm=1 tr=0 ts=6985e80a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=a684mxaoogWhblhQtjcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060093

Add support for AD4088 14-bit SAR ADC. The AD4088 has the same
resolution as AD4087 (14-bit) but differs in LVDS CNV clock count
maximum (8 vs 1).

Changes:
- Add AD4088_CHIP_ID definition (0x0058)
- Create ad4088_channel with 14-bit resolution and 16-bit storage
- Add ad4088_chip_info with lvds_cnv_clk_cnt_max = 8
- Register AD4088 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 728df626f09e..fc261d3d7687 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -133,6 +133,7 @@
 #define AD4085_CHIP_ID						0x0055
 #define AD4086_CHIP_ID						0x0056
 #define AD4087_CHIP_ID						0x0057
+#define AD4088_CHIP_ID						0x0058
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -456,6 +457,8 @@ static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16)
 
 static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
 
+static const struct iio_chan_spec ad4088_channel = AD4080_CHANNEL_DEFINE(14, 16);
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -536,6 +539,16 @@ static const struct ad4080_chip_info ad4087_chip_info = {
 	.lvds_cnv_clk_cnt_max = 1,
 };
 
+static const struct ad4080_chip_info ad4088_chip_info = {
+	.name = "ad4088",
+	.product_id = AD4088_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4088_channel,
+	.lvds_cnv_clk_cnt_max = 8,
+};
+
 static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
@@ -698,6 +711,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4085", (kernel_ulong_t)&ad4085_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
+	{ "ad4088", (kernel_ulong_t)&ad4088_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -711,6 +725,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4085", &ad4085_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
+	{ .compatible = "adi,ad4088", &ad4088_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

