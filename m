Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1838F63D;
	Mon, 28 Sep 2026 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598495; cv=none; b=dzWZROTRSDbIQdBSyImq5j7aqSBtLr5+YQrL1oOK1TMwW2ktmEpxMlSByivFYl+LMzpBmLCu7PZeCnoE2dh1Uyrogw9tesDTr0UtJaivMU3nLK/Z7MfDGzKMqH8EpFAcy5/NUqvwwDQuAyK3KNk4uRxZfiAekjUjEQ7IX/LWugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598495; c=relaxed/simple;
	bh=3A8OIzGsSser6k5tFBHt4HB2SvU3Fdk92+CNDbJI9j0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CtxiepiIbjkJQAoAgBx0tUNB1jzK4VG06HpXG+syEPBjMcR0V3YYdwqeA1Z3aWThuLESH0z0dhRDrwOLqmGf0QVmmAd8AWEyJ77pcaCzrmFCjY/JEBUWn9XOTY45mMeESA9dBQDe5JwLjZVh6NfXa4xH4JQvvax7JDSEYzWCreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wHF83kuF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wHF83kuF"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9HLwG2986077;
	Mon, 28 Sep 2026 06:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=QEN1a57WHMXsB4WfIQVYIYE7nm5
	5qeeJYvsctp+TFM4=; b=wHF83kuFt/zKQViBbzMkomn3YEVlGDdwXYhF9GLJaqZ
	sbIqpDkVoRcIwXndo0hp0GVoAIHc3CG4VfEJg9VWIDsXXT0auWKwUPo+alW0Jh42
	Jm5pUOWu/d4ptaNE9Bt2L1tuP9OVPkZy8xTCV5MPI+omn3PCPv8svQAIxLK7y7T5
	xinfMPqhzbdou3kW4qmZuFxx//TZA1q7CSoYaxm5jLAtwhdIGpSw2K9bzmAz20Vo
	Mdlt8DiXyfGY4cNATNTcJrlH/0dGGHHmQFgDIPbS3ab8M0LMTH4WQKWBGKcwNdIw
	rTnXlpmp7yd/9IG15aPXrxgNzvtTd5uzeiTka53znCA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gxay1srvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:57:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68SAvCAX022829
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 06:57:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 28 Sep
 2026 06:57:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 28 Sep 2026 06:57:12 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68SAv0fE015531;
	Mon, 28 Sep 2026 06:57:03 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: ad4080: add support for AD4886
Date: Mon, 28 Sep 2026 13:48:04 +0300
Message-ID: <20260928104806.9330-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MyBTYWx0ZWRfX5HPkPA+f7MUh
 eu401A7BRrKcAO8aWY3TZ5JqBxvkkO53xf1c4zURQzKPhrg9oWcPtKw9ovZbD+m85W8drmvoMSk
 cT6J1t3OrhEwYXrwegOUqMameb+FYTaO9Bc/dpXvmptehx3pWo3ZgpgiJBm2/gBgaHb2djLRY58
 DcQr3ho8lBRdjQK4m5XEObqAGQAUo0LC2CCKh7MuvPZR6UeZu4oQqo/bVVzXSIVGvxRp50vUq9Z
 fRfWk/qGNc166aKbSD99U5jE/mPHJvZ/AEvyzSA9PdFXrwn7szgMeYkymEfQVzCGmhpmdGCmtG0
 5JuqmJy6DS5CiM2cYOXD4vSPto+hGM3EbdymoUaddqHbmlW+Mm6IP5SRyBOu/EfBHDZB0TKl/IB
 BSqwSkpG/FjahdsNMxvZ09QsSlDWq7kPOU6oWteQ85MR326bzrHDI0QWVokrhPfjg1X/5Eu5wBw
 BpNN61S+z/iK9AXoTjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MyBTYWx0ZWRfXxO7DTW6iHGZo
 Ldqe2KsJmIouvDH28HD64DqvYvWe0sPv+WefCmHqnFr7O1us8UhxNl5YbFCXpRRqQ5o6BYQ5ifv
 EIWqc/dltEmHsg0vuMJ4Fu/DxUqZX0aj5zS+/V2/uLCWdjDy/gnj
X-Proofpoint-GUID: TW-7altV-kjw_Yr_lvrpCkZIAS4WoW1s
X-Proofpoint-ORIG-GUID: TW-7altV-kjw_Yr_lvrpCkZIAS4WoW1s
X-Authority-Analysis: v=2.4 cv=Bd9NQbt2 c=1 sm=1 tr=0 ts=6aba4809 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=jGVxvDO5Txcv-dmjKuQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280043

Add support for the AD4886, a dual-channel, 14-bit, 40 MSPS SAR ADC in
the AD4080 family. The AD4886 is the dual-channel variant of the AD4086
and, like the AD4885, has two independent ADC channels, each with its
own SPI configuration interface, so the part requires two chip selects
and two io-backends. It differs from the AD4885 in resolution and
therefore uses the same maximum LVDS conversion clock count as the
AD4086.

The first patch adds the devicetree binding compatible string; the
second adds the driver support (chip ID, channel spec, chip info and
device-table entries).

Antoniu Miclaus (2):
  dt-bindings: iio: adc: ad4080: add AD4886 support
  iio: adc: ad4080: add support for AD4886

 .../bindings/iio/adc/adi,ad4080.yaml           |  2 ++
 drivers/iio/adc/ad4080.c                       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)


base-commit: 873ba60d7f2e52a171845ca290cf366878864b1e
-- 
2.43.0

