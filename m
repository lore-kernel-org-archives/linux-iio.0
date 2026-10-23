Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794862;
	b=BX2CcWcD1FdXMAWQqIOfvWdoIhnC46BgbBGX0jRtwnZWiuRN+32U1U3XuucehGMOD1sa
	 bDpoIUop1shsfJRAtNTz5U/Hk/4RKa4Pyv1ob5Twi580lOppUnZD6IJqAUJteBzTHzoCq
	 xJ1l4jAAmfvqftJA/EO0q8qeQ6N9IRooLPhi7fFjqli/l7/MOwUYbWqmUoh33aSCCvzx4
	 WKtmUY+L7NaWuxC7YtYR/nIrxW6jP8WFri26IgXs3IiNC2j7+EA43CSdZTIEEoERohDNo
	 KmA5NVrgys2CIz+Y6Si1SX/y5fMAcdbMfbDxQDSExeN0FGNYAzfGZZfqp84SeOPfZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794862;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ObbKecr+kFdX2uk4+VYZMp13nNf8ZrplnumHG1MI49g=;
	b=42JhuuiYTdjtWnZQVnk06S5LgfJbL/g6R9HXJlohRbA+sn8YwBV6WdPyoyYkE4ZF+Sib
	 hgV7wlG85gEAJNFzLTN6Yntn3I2RDCasCJTNBisMSeAnF/hsesW6b+d+nvLVq4ji5i0AZ
	 qZyNCeqhAkSGrcizCTMcC6C1FoMzAWwZm+cpqvg0Fd+aysmW47yuoJqNrz9bVqUOok58h
	 bNxDty3RFywClFZJ8+/Avju7oMQuHDSXuvQA1seuGAQazskhYbbBvnSMfEJR+4lsiH5cH
	 99+nlfP1q8YiGGHXmsYWfEaJenblo1VQYe1p+B4gB6pMYXojSITDugNcEIu/x5CPJvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OLY8lHWx;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=VstQHqLA;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62543606A31A;
	Fri, 23 Oct 2026 22:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62543606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OLY8lHWx;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=VstQHqLA
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLuj9w1124307;
	Fri, 23 Oct 2026 18:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ObbKecr+kFdX2uk4+VYZMp13nNf8ZrplnumHG1MI49g=; b=OLY8lHW
	xmeoppWpZw9w7JoS0Kh7NICyYOaRolGzeFu6b1K+b+V62JNeVa15YKi4x8bunG6P
	vLAh6WQajIpA9wwOJ1DEJ462buc1ZTkp2JDZiPU5SQAvyypJp8mGvQfJFXY5Idpn
	uA/9Os7wnFXuGa9+4vPxj/ki1uanTtQjbbksJ+aXt0e+MpBC9EnvSgI0Kehqdc8H
	VFfbL/IFPODhrcqD9LsfZpa4OVqCKx4Cel+g/E0tO7NgftxQQ24yoDEfbQY9neIs
	Jv/S6OaGMmRJRDiAJ1gyEoR947ZI0Fm4byacE2q34ZtrxBEFkBHik5OQXROatHF1
	gLl+q5RTrnXAvog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ObbKe
	cr+kFdX2uk4+VYZMp13nNf8ZrplnumHG1MI49g=; b=VstQHqLA+DrrtIJYq23iJ
	VtKxTpivCrq5sSSndqoqC4VGk5vXwYV/EH58JHBczZEuH7JKlMtWqcb0MGr77ThS
	JitPXvZrZm5M+h6xO9In89h3Rh8bHAE+9WFzkpfozy7okOU7p3uIDG5FQ2uj4hJm
	ZodepNZ9E/K57mI7n/qtT7ln+IBDqijNSUIQeeu8CKUcIVTqRa/gdVZJ17kLVn3Q
	j74ApcZ1K2VC/SCwaJQ+xvp98aHCrC5rOyQWdye9x9Wuj8B3N4grFGcsby63SGbN
	8CqrJBcRLwHChkIko65a1f8oXjY7ICwSC7LWHfLA+YS5sPYN9iXaB2sMkN2EEpRW
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hgcnbs31x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:34:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMYFf7017505
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:34:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 23 Oct
 2026 18:34:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:34:15 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMXx3V005814;
	Fri, 23 Oct 2026 18:34:02 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>
Subject: [PATCH v6 03/16] iio: adc: ad4134: Apply reset recovery wait time
Date: Fri, 23 Oct 2026 19:33:54 -0300
Message-ID: <08d800f8864524ec881473ba8a4153cd5fc4e8d1.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfXxivppv+JjCZh
 Uvx18ycLIs+8Ijh6oAa+mHnDGeJiRRZGBaquXGLQJ5geE1fdTd7lU8Nw3FlsFgxoLVp9mGezC8L
 7dSbdWsxQ0qkEPXKsjUpKyxOJGEpMLbov5Bev5CRHan//jY6lLX37Sf3n6d5mOqGEvppULMgT8q
 n9xDY7pRkZ+Q4BsRK1dBnTtyY78SxCkHqpHrzvTSC1qn2If9PSKAkRfKlOIPjTgl+pQX7qV8jpS
 1ZdMkYgMhEEqfOYjZB7luknd5xjv+TOev67hqil87bWwsrEDfM3UYm3InqYAuI7OmsPzK7KL/I8
 Oe7MsV26EU9a7Gjwl9Vfd6dRONlPe+qrfgiO6plhcyvgVC2G98lPZWUm8cMrmKLPPD152KGgh1Z
 xYsQitZvN6U55nFns/Jj81eKbrrCI3Yl4yf0uf655xG5JoF6lWM+FXlVJgXYybEa0UHfrap4Qx8
 3F74tcRiuk7in7bPAEQ==
X-Proofpoint-GUID: QQ76oFcXj_DC-ybGxbDHD1Xt2Cm3v3it
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX14D/NkxIIrCo
 pjQPrJJ7Qg6hd51e10dSJdg61fjKo8DaaZn+pbeqLPGtEwUbnzO8JVkRurppetn6CXK03+pyx6q
 SgIriU26uI5vItwqCN0lg1XM3A1w4/fv0t8za8T++UHQGbWkeI3d
X-Proofpoint-ORIG-GUID: QQ76oFcXj_DC-ybGxbDHD1Xt2Cm3v3it
X-Authority-Analysis: v=2.4 cv=N9e8hG9B c=1 sm=1 tr=0 ts=6adbe0e8 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=AjmT5er7jcb1s6dkjgUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230088

Add a reset recovery wait time to avoid any SPI transfer from running too
soon during device probe.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6:
- Correct reset time to microseconds.

 drivers/iio/adc/ad4134.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 40b27b01f126..7d9e0706bea4 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -26,7 +26,7 @@
 #include <linux/unaligned.h>
 #include <linux/units.h>
 
-#define AD4134_RESET_TIME_US			(10 * USEC_PER_SEC)
+#define AD4134_RESET_TIME_US			10
 
 #define AD4134_REG_READ_MASK			BIT(7)
 #define AD4134_SPI_MAX_XFER_LEN			3
@@ -442,6 +442,7 @@ static int ad4134_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(rst),
 				     "failed to get and deassert reset\n");
 
+	fsleep(AD4134_RESET_TIME_US);
 	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
 
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
-- 
2.53.0

