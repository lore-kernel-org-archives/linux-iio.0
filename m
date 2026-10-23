Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794915;
	b=UEDJzstfKrF2/ZubdZGWYj9+OlknGCvZ4hCu0mPC1pdzen5nwx404mFIt/L9gyY4gk1Y
	 5vfrmwIbBskOoQI9g+uMvFoi4uo/OrxlYbj9/7agGxkQ7/DvsbNU0aBkQ4CU8Ie4kRnwr
	 HdQYniDlAsLojLaOjesTjRURNDafm6ghU4Qnl4LRF//q2KIuLJmByQ8szhc6kxkxPX0rU
	 zXjBjF9nBop0BFnFPghbqWou04801d2maoLqgu8d+Tuykc18tRfZssq2MfFIFdcOEjwrP
	 tatdatauEsPbwfyYCVfgcPbdLGUBSccNfgdlrDk85TuM/swuOD27E1py7/Xtp0cCzKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794915;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0ZdzEHd4XqFhPs+L+Q8WqwX0ivdUsuqGiLsRGebPCcU=;
	b=jRa2F4M44w8u49AWX01TifZD9BxGbJ6kiryk3jtpUkZslDfSs3WYYzUJP4CGOAytHvGg
	 RFSVY/E4vFIHNkzcx8t33fzUt6cGawaClsbmgV6BS4xKQuwEA5NLopdxvJ9CEUuxDgwnj
	 bwvYdf2unIYThXOM6aCydFSmRjNuB55G5a2bFcGxgv4PKmIl9yw5dhCNaZH/+UTg5LMec
	 AZSBZPidtqqazJ4L+pyhzduCa5mCh6da80zhQM/lUGCEmjAwraJTQDUAHpSioyQB4yPoA
	 b0yXHhwurq5RbogOpiTZJadMVWyK07prfZPuSoXTGiOlajrXE9I8yW9Ckdr7ql6injw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=fJEZWXQ5;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=qzUhoQYa;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E6606A31B;
	Fri, 23 Oct 2026 22:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D1E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=fJEZWXQ5;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=qzUhoQYa
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLuiPU1124304;
	Fri, 23 Oct 2026 18:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=0ZdzEHd4XqFhPs+L+Q8WqwX0ivdUsuqGiLsRGebPCcU=; b=fJEZWXQ
	5kbDG5ywt2L5UsjXruwXWVlmXrIfPx8ulPY4oP9Ddl3oWTsXWRgI+dp8Wl66DuRv
	TMru35oJOKAIwyyNg/rmXlko9KBVr68wdwk4oAuwGQNVPpcFDAPnaf6UGBaS61zK
	iwJTRp9LnzN07DPLqsdBP+zIdg8jWMY/si6wY9o8jtvXhJ8xA3YH8nhLF2K1Hmuq
	n+WJaMP9DbuF9Wbh92J+nN44UN6iVnQPrpi9dMlk8OC5iBWGk4BauVysFmApb9Xb
	RphTZmRpdkIiBP9bCDSILp1kTHj6ERy167gjCL947kNcRsrQ0ZFb9Qgi93+/HCMV
	+XRpi8eIDKoMyHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0ZdzE
	Hd4XqFhPs+L+Q8WqwX0ivdUsuqGiLsRGebPCcU=; b=qzUhoQYaq7hYBgXvFRaWC
	MWn/qXhZGQs46dEVbw/+w48B/8LLvDCJgEgZZfKNXQ8NobQkAC75lSk3M5lc5cnc
	O7gGLkzwSWgh/a/NqP1MS7KupEtUrgr7AHbn56j+8kt0QE/+30aZZpY5VJjMq/PG
	7oGFDj4ImbjL4u3K6hyZ9Q3PE0ZgBs2alBM3m3vThQA8HUSC9VAVgKtCBVZz2SyI
	Y0xIUuMTZuXRbGDVO/KjjH2EAuJuzjjQKrwOlpOtOUjLxS7UbFTpdl7EZgE/MLgR
	oSsQFk7YfKjaSPTVTW0XolGsJk7MqOJ7gkuxqeXozvVuanzwstB9YFDriVsQ65/C
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hgcnbs353-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:35:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMZ9at017575
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:35:09 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:35:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:35:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:35:09 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMYtgc005831;
	Fri, 23 Oct 2026 18:34:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 06/16] iio: adc: ad4134: Protect conventional device access from debug accesses
Date: Fri, 23 Oct 2026 19:34:50 -0300
Message-ID: <0789a1dae09581f06bd88757ddbda3531e165efb.1792792325.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfXzo+CPtisjomS
 B3xpChQ/6QyzVmF0oKaoCVU+r4uCumOFm/ukKz5+C+LLNJx/JOJ39AK1w95Fd22ypqX2+6sxZmf
 bn12nUAYFi6xBQB8wiVRRIVDwNiMOAgUo8ekjWpdcEOxgnpYZqKkT+nBYhMQWXKbWgs5hCLSWo/
 810f7iNvVCQ4IZqIm+AaLzzEzwTKt5vCXqm1X43+Mhg6T70hF7KWc4fHz652/93BtuPKqSa3pEj
 YEGDevIacso1o5Rb3IOKmaHcnxE1FEUynQMWpHa3+BXy3XOAtOgHSlsC/APJUdi+93oRIoAflv7
 YnRiOGB8NR5wxP/GItP8ofejJtXT5iyfpg5ivOEcs9Ad0Krq6aD6v3yI30DtuOg5N8uf6HFIqel
 TBMDIjcMrFgPEWGZOFqVxRzRuOEFlc74DL6eYUaJuSw7kkRRufs+1U5xlTlV2N6QK33mB0duLa1
 5TEx5E421P0as+10cuw==
X-Proofpoint-GUID: 2WLWpp8zWKHgjXxOOgqXuAdmcwLwc0yl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX+2qt2yFyWjNk
 5wUlSXat5wrUmyMgj0PTq1vsKgDIi+d3aIDMXmK4Z5iQdUsfZspzStJCciaQAbFmedsbS2SoBco
 j2RjKvD0Yj2jCBV469VuYWVT9qGBr/EUBlP84FcEFMKQtEY/yk5i
X-Proofpoint-ORIG-GUID: 2WLWpp8zWKHgjXxOOgqXuAdmcwLwc0yl
X-Authority-Analysis: v=2.4 cv=N9e8hG9B c=1 sm=1 tr=0 ts=6adbe11e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=T1MFQnt5No6DS8_TW_kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230088

AD4134 sample read operations may more than one transfer to complete and
are expected to run atomically to avoid triggering any DCLK count error.
Though, register access made from debugfs interface may scramble data if
they are run amidst sample read operations and read/write/modify cycles.

Require debug access to acquire device synchronization locks before
running any transfer requested from debugfs interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6:
- Better explanation for requiring debugfs synchronization.

 drivers/iio/adc/ad4134.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 1cfa8066f13f..71f626bbe9be 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -302,6 +302,12 @@ static int ad4134_debugfs_reg_access(struct iio_dev *indio_dev,
 {
 	struct ad4134_state *st = iio_priv(indio_dev);
 
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->sync_lock);
+
 	if (readval)
 		return regmap_read(st->regmap, reg, readval);
 
-- 
2.53.0

