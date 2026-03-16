Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16F391825;
	Mon, 16 Mar 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661559; cv=none; b=a+u5zPAlzS6OGB0wEs04dNSISsOpLx16Rip/+NPAnV8BurxaI/63pn3FfGmS072anGjiNVYOqyyXZ9/NTcBBxpuVNeQjjD67dvySxRq88veQipICfwr6LiIj1AICifDLkom+5X4MTu57W4QVez4YAxbfDCOEo1mKMe6dagCjsIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661559; c=relaxed/simple;
	bh=zE/hcFkKxNGck65BXRhtOyG8zpLx1DaKOheS/NXhgq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjicaCFBD7qqyM/a26lZwwRs4F/H7Qpn2ILycNXBYhZ3rb0mTOA3DLSOLgpPhe+BkBaGvAAIkb5+r7JQqbd5JSJagVwqDSoQ2oh9ISMCxJ470l5Ok2QXG6yHJzzZp0HrVZ+ft9baeD4TY5X2cJi/HGjexraX68SckQgytnHcywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uDGNfrH7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uDGNfrH7"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9rl032123203;
	Mon, 16 Mar 2026 07:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=86Af3
	xInLfn0sBXyvNWZg1w7iuY2PaG6WzuXeavJVBw=; b=uDGNfrH7dwxylq5rs9z7x
	g3DWdVupLCQmeRCBu0Fj48bEAY3QWJgVKVCzvVcj9fEoLWdnHHoXhRwDxYJ9OXUn
	c94FLnGuc3gKO7zHtXSSmNQHDKtBRdLE9sQNtcx2enmGKZgw4RZS+3iZAvfvntL8
	GjV7DwEIW0yduv/aN+s2IEnCfODMWxfs/v2cEqXlN6RBUUQxmDz+8Fk99djMXZX0
	ExGw0NAbdha4HugPg9JpTg638WHl8EmllgwNd5q329svvvrlF/oeboH89cJwolnp
	LJR+zyCGaV4q21NF+2cIMN/y2oCkVLH+Rx1NCAnqiw6SCNy9jEfONwMXmrphpZMQ
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1h1f08j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 07:45:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62GBjeTH002714
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Mar 2026 07:45:40 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Mar 2026 07:45:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Mar 2026 07:45:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Mar 2026 07:45:39 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62GBjS3H022990;
	Mon, 16 Mar 2026 07:45:30 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <cosmin.tanislav@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
Subject: [PATCH v2 3/5] iio: adc: ad4130: Add SPI device ID table
Date: Mon, 16 Mar 2026 08:45:26 -0300
Message-ID: <63f625f4f19c33f937bace7a37b921a0e4810559.1773311639.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1773311639.git.Jonathan.Santos@analog.com>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4utaH45w4Pd8RpNX5YE3GAYPnFI3WBoz
X-Authority-Analysis: v=2.4 cv=FP8WBuos c=1 sm=1 tr=0 ts=69b7ed65 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=ijA5dNRdcb88KqkhJh4A:9
X-Proofpoint-GUID: 4utaH45w4Pd8RpNX5YE3GAYPnFI3WBoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4OCBTYWx0ZWRfX1Vz4qKzA16Wx
 9tJxgwT2CpXY4zBK0I52PN1M4LDHFxv8RJI+yqjdbOTGGHSaPm3nurqdvo+UtP5jLTe1FoKwoVc
 pUrS7g31XZBTrgFrDgUjRCpFDBUDrx5b7SxYvPcSwHFvmj/Q9ALVYjQbKji73Nw5Dj1OJHIatKO
 wzznZfXy2cEajVWRGQJdgSfjHaoN3TJMFpugDsEuhtRSYWdkOFONE80mCMnHF6vpmFL0DvWK3QK
 TVpLGC7ur91tEhT1+hI7tTG5Ma0yEoI/ODAl8mBTeygwdes6pIzh69FJ7AKVJdoMYjGB7UpkLxT
 PyDnYn/hTKIk8+zAksyCmPH/Fw3Oo1IICp/tZeunJFF2Ncr8yXqIvk10YoqNYHOpTg3FsoySll4
 6fr5DLTcc9i/410TYy+fwJJ/AE2SN50FmM3ZRhwh4HYaXTxGFTkZI/IXpkshAfdkDM841BzGIvC
 FXK7xsxWkKgaX8HUCrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160088

Add SPI device ID table to enable non-device tree based device binding.
The id_table provides a fallback matching mechanism when of_match_table
cannot be used, which is required for proper SPI driver registration.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* New patch.
---
 drivers/iio/adc/ad4130.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 5567ae5dee88..94cb6af0c4c5 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -2109,12 +2109,19 @@ static const struct of_device_id ad4130_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad4130_of_match);
 
+static const struct spi_device_id ad4130_id_table[] = {
+	{ "ad4130", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4130_id_table);
+
 static struct spi_driver ad4130_driver = {
 	.driver = {
 		.name = AD4130_NAME,
 		.of_match_table = ad4130_of_match,
 	},
 	.probe = ad4130_probe,
+	.id_table = ad4130_id_table,
 };
 module_spi_driver(ad4130_driver);
 
-- 
2.34.1

