Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055980;
	b=i/4eRWDazSgECqaIGURMUb5fG4DNaBzaTW/wHPJZghJymTExSh2Wzv0PIXbK0xtlIA9m
	 SAtwY5u5gusBDH0OTdWoKGf7kECYL1PdoplLOJMzVzrAExA02GYUtJ4DsZlmqMk8zR66U
	 rnnCPCxALEPqtp02IChs3gZHqxOsbgkC40IrqyDBGkPykfNeEipQfJw4+PndmkQbB+Cmq
	 u4D3ldk4cm3XmTHozhhiiZAEhWGYUwnDtWtavMO5HplcbvoYWxXPuTG0lIqp/KGVKqh7o
	 eNRwwF0JmohlWsxLatnVq/O1Qf7hKmnWK2uXYsSe9dnhoNnSlzKyFrVmgFj4LGWDH0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gY4vfhXvGtWf5ec8KRpu0ASs+NWkE270HzH3emenf9A=;
	b=bJSl/n8GCygwhfAOlWq4AAyNTjs/viiQvz+BSgshnk8TeZfH1APvPXxqrOB6UsVbUhIV
	 tyQsQv0UgE3wqEJLNvcaKlzAhF4IxwEUdBnB5Q3JBYquiT6ubXZt+zQWBclFCM1YjElAg
	 XJfkHcX35+NPY2FPrU01uH341NCMsJBTFDjtUXSoPHsZABs40EDqFr4auvojr5EH8Sp3O
	 W7AefyeUfkzDWGn4LMS/phDwjSxlyMJMORBGDUvT/R1MdBEGORzHH+iP89VskZntfNa5t
	 z7al7bq7C5NoYa8hrT3ZNnNYLVMfgXba9tky+Rj4YGb2sz5v59vsGIJMtMb/611cnxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZZHkbh1N;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F34606A32F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F34606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZZHkbh1N
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPQAo4038499;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gY4vfhXvGtWf5ec8KRpu0ASs+NWkE270HzH3emenf9A=; b=ZZHkbh1Nv5azY7q0
	TKCoiwknyDottLcO7Brb5ndi2olU7SlSaGJN/TLzVQEvdp0/aNW0t9F89y3aGmuj
	bOcQ9e6J/kvOLJiLwMMX9A/FgBOyOjuFtWjlg9a9BhQCNiM0lUNvFae4S90q8mlx
	7FMwh/Gu9BwIYugbLG9ANtWFzXlmPYm0v659KUYtKxv5ZEYz0LKR4J1dIRLpp7bD
	KICDDthTbZ3YbqNyDhyaW2b8G/Q9EAMhzAWGJrcBnHPHurhCbGQPf/M/5T5uhloJ
	GIXygkaKlvIh/nuN6t95DS7+iDX5/RAMe6hKW2IqITyPOkYflPGrAXxp7AJrGL0D
	+i2CXg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm8yss-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN611W260018;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QN61IZ259926
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 5E8892562F; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 25/39] iio: potentiostat: lmp91000: use iio_push_to_buffers_with_ts() with a scan struct on stack
Date: Mon, 26 Oct 2026 16:05:43 -0700
Message-ID: <20261026-iio-v1-25-8b136778eedf@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9cwpiIdUwyfX
 4PzsaUoAxZyKU25fqeUs0orGiOjFeKZhnRU665rIMXvIbcCpc1ovUR8LBtbJwTBAGtQaOzkpnXp
 u6WIr63MVm99GCCtDqRnC9UNrBlkImM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX8eQetwDYobpR
 15dYNVPfgKh4ly8LLtNNPpBJHTTR1pPebsNJeWKquj2I8pRRHoK2MwF2ev8R1e+J9anIshupi0h
 wBN9d7vGPM1xX0NfoCmybwML02KfaQ5XkIw0/G0na/2WAAb9+jL6ach027IOoVA52sogQJH4M8Q
 NMdM2t/kGDweLA1tIu0R8Diw4KSmBrw/o84VGFyaBhiJi07nmI7r8hWhpj0Q968rGByBYtYtzFb
 AXUCS5yzddWp3mg1Ng4SAQcjdAwcTaoxd30zJN8X2beKU5SKsY3uZm+sgflvrcsDqEnhyVeXUyf
 t8LMd0Plpwhm3hq2vO5RmQYFvrR0VNtxeSOwxMaPtJf4oTEKbc5SEpLA3xFMoepbEdYRfTZtSi1
 xZDzUZsDVLn5Yd+zl8taW7UBTBPtv9rr62wMMcpNpeYHmo8Uy2hb9QkcVG0BhFMme2l2mbQcioZ
 r9Yh93NqkwkgZ8csbCg==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VGXy3j-TzBo9dPgtwsUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: H35KFRzJNGOKd-9U5_0wwECKHede6eSE
X-Proofpoint-GUID: H35KFRzJNGOKd-9U5_0wwECKHede6eSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Move the scan buffer out of struct lmp91000_data and make it local to
lmp91000_buffer_handler(), as it has no need to persist between calls.

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/potentiostat/lmp91000.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 00cb3fea97ca..53f181cbc0b8 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -70,8 +70,7 @@ struct lmp91000_data {
 
 	struct completion completion;
 	u8 chan_select;
-	/* 64-bit data + 64-bit naturally aligned timestamp */
-	u32 buffer[4] __aligned(8);
+	u32 buffer[2];
 };
 
 static const struct iio_chan_spec lmp91000_channels[] = {
@@ -135,15 +134,17 @@ static irqreturn_t lmp91000_buffer_handler(int irq, void *private)
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct lmp91000_data *data = iio_priv(indio_dev);
+	struct {
+		s32 chan;
+		aligned_s64 ts;
+	} scan = { };
 	int ret, val;
 
-	memset(data->buffer, 0, sizeof(data->buffer));
-
 	ret = lmp91000_read(data, LMP91000_REG_MODECN_3LEAD, &val);
 	if (!ret) {
-		data->buffer[0] = val;
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-						   iio_get_time_ns(indio_dev));
+		scan.chan = val;
+		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+					    iio_get_time_ns(indio_dev));
 	}
 
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

