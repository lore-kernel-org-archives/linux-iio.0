Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794823;
	b=mos0w51AYlyS0i5WTBZY1FUg0hj8LWhQPlyFDEcaV67kxrFDdjzKMgZKkyQxcryBNCFt
	 eXTH1mpxHWTj5UziHjJmWTh0YR6wDqbQyachnhVlz5ek0dolzOVpHxzM2NWMVGy3kJA5T
	 RyapVe1NxI8CIEUU7eiHfcKZChjPeonbzVy2aQSaejteqP3svnW2QggMdng5GGkY8KmeA
	 cAU+WsVrjwifIawpFW1onDVODWaXjUwoKmoOudRiXMy4zoJQ6phKohq0z4dWLZi6UqsIS
	 Kw+Nci2pQOl0h4sbj7jU+qe/gZm0GlG0QNnleRE8l13wakuz/9fUWUnpvwm2+vCFlLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794823;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TDK+XBGHp8oiC00M/EZpOPAbbNtTtUEvVk/w9qE7hmw=;
	b=xpCpnuGUlN3WR69znr5ijHhmGhxvz2ORmnYnNET/WXeamHl8r+BSaQgQbQVKQ6gGZW5V
	 DjfqbQFjPjuVONIYn9wucKEsBddzS/u5t2nGbR06AOFKfmolce89PAZokGVRBZhh9OokO
	 Gkd0gG5Yg7Ax9Lwm8Ksf3MQ3NBLGDF1eQeLL15WjIZPgZPOo8FVbiEuEqzsHRqW6rKzBV
	 YuBnkK8tQzckW+J8VcIsZo4/dKZvhaILG16Mdbz0sOhzrRpwEaHX3toCwVnPH35VnTpd1
	 00+58As5fz7tS6DIXupGHvEg6dzZey4HhuVQwJ96B2r6s38VRfyq1G/ffgh9Snh19UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Z8izQPfA;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=y+o2Oq+B;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9B606A328;
	Fri, 23 Oct 2026 22:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F9B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Z8izQPfA;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=y+o2Oq+B
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLuiPH1124304;
	Fri, 23 Oct 2026 18:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=TDK+XBGHp8oiC00M/EZpOPAbbNtTtUEvVk/w9qE7hmw=; b=Z8izQPf
	AmsWxxy2mz546h5P1zX+WrKMyVVpnz37DbtHenIv9ahto9DesPfi0cwB/cn2kDhh
	6Vk6dJxi4ZihGGzudHL2ZhHFTpkzkAX4uERd+Qfa6Ovj4tFa+55UV09Ap59oS33u
	7KR6OMnBDzxzdbBbpzbmqhkyLBQp3esJ/vLTeDza+Pa98fSpKvrcPDQ1V9gLbYrg
	zTCcFPf6D4Hv3dfJxIgIB+NvJRErewEGRqaHp5L/OCO0f3//0oHqaGog3D/XASA3
	mSMgdr/36N1tLwaiDoqlg+rgaESKpIEEgW7IkvUn4sPTGFp+S+/vZ6o+i5qvHj6f
	XCgmP5avchn1aEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TDK+X
	BGHp8oiC00M/EZpOPAbbNtTtUEvVk/w9qE7hmw=; b=y+o2Oq+BtMLI0yMaozpO0
	qXxlOTRhB9nYMOaw0EOQiJ42cDW/fYBSc6RZYsS1ouq+rkscL6MG2UZbYCKFegdA
	0UXzJObOeBZTlwGUClyjDtp9riL4SK0hkoJnPDx8Nbzj5uOP4XfNBQsScbQPFXXZ
	9vzpfQ6ZKVnZ6kBQPM/QbwzVKK9gMDSacPC4YTH4SP+95XXE99JKkFZ6Y344alM6
	p29XJIcC6GGWrWGyFUIcHfGqFzp1goxTeO9l1me1li21P7lX5NitjDU7yHIG38Xt
	pXGjGnT8yES8Us8odSDxIHbwufGR5XgK5YoTfDj7BmenNRVtrhx1dZJu+/MQKBTo
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hgcnbs309-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:33:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMXa3Z017466
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:33:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:33:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:33:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:33:36 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMXMSo005804;
	Fri, 23 Oct 2026 18:33:25 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 01/16] iio: adc: ad4134: Adjust register map range
Date: Fri, 23 Oct 2026 19:33:17 -0300
Message-ID: <0e42166b03db5572c25c571c8c9147b95ce33564.1792792325.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfXymnjvYnSDblN
 weNCIcmXiVLPD9YmOk2UECGYrnP65x7Z3IR6beyRrvr+UKFXy//gRffrciBn+pzqbJb9VAVe/C4
 Gvyy4zlEfh4kmHdOqI04dLHlzAD6O+d6HeUCyp0aBBYGl3UwiypzSFz3WXMXECEhqIolivZvFs1
 tHMmawtfxfQb2Dtlq4Gjv8+5Sn3tTy/a1TUFvAk8ZjARqxV0QBnRYjbLbCw0psK3Z439StseP41
 9BIpBE1Ybln8BwpqlA4dsQY2SvihbneJ8vgGw4o3bBwy3I8My9ajTJ+eCPTxLEjRcZf22N0WQnH
 YlR5TMXkFwkruidhm+oj7Tk0OA93eG51KRImRjTV4UPZxjS1EKvJmI7c21n9WW82hy0wQMWmzDJ
 Eqm3MPItVqo7M5C5DhYDORRYeaFflXBZcyknHzYtDMKKL0UMiiDHsZ7PlEUthG61SsJupnNwvGY
 kyUAqcSgEfLx2AG1Kfw==
X-Proofpoint-GUID: PjM889hdkpr_9KhoxCOi8H__kqutTkfH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfXxxkxg6kx/0Q8
 BnEeKeN1QJFRVligkPAKEeR5f2g0H0DhK1oM9Kbivu2l56TGlvPDDr76PgnyGmnRFwWqGWpXc6L
 xoR+VoN7S6YU7FFkxvUG9V1SErqaespAQHS3YaGcb1NHfPhPw9jz
X-Proofpoint-ORIG-GUID: PjM889hdkpr_9KhoxCOi8H__kqutTkfH
X-Authority-Analysis: v=2.4 cv=N9e8hG9B c=1 sm=1 tr=0 ts=6adbe0c1 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=xatGmy-HaK2A-VLG5J8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230088

Due to a off-by-one mistake, privileged users would be able to read from an
unsupported register address when reading device registers through a debug
interface. Correct the off-by-one mistake at the high register map range to
prevent access of unsupported addresses.

Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v6.

 drivers/iio/adc/ad4134.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 70f80bf1825f..8400c3934925 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -111,7 +111,7 @@ static const struct regmap_range ad4134_regmap_rd_range[] = {
 	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_SILICON_REV_REG),
 	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_PW_DOWN_CTRL_REG),
 	regmap_reg_range(AD4134_DEVICE_STATUS_REG, AD4134_AIN_OR_ERROR_REG),
-	regmap_reg_range(AD4134_CH_VREG(0), AD4134_CH_VREG(AD4134_NUM_CHANNELS)),
+	regmap_reg_range(AD4134_CH_VREG(0), AD4134_CH_VREG(AD4134_NUM_CHANNELS - 1)),
 };
 
 static const struct regmap_range ad4134_regmap_wr_range[] = {
@@ -244,7 +244,7 @@ static const struct regmap_config ad4134_regmap_config = {
 	.reg_write = ad4134_reg_write,
 	.rd_table = &ad4134_regmap_rd_table,
 	.wr_table = &ad4134_regmap_wr_table,
-	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set)),
+	.max_register = AD4134_CH_VREG(AD4134_NUM_CHANNELS - 1),
 };
 
 static int ad4134_read_raw(struct iio_dev *indio_dev,
-- 
2.53.0

