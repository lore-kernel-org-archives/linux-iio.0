Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E93D3B3;
	Thu, 12 Feb 2026 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900402; cv=none; b=Bx3dPCGyCR7noXIAympPIWeE9Z6rjNJgnNB4cLmS4Dr3Wgq8o1TIZNKtPQiemPkk35u3kY7Pv3QobsMs3h5V0oVpJfwhiq+9OjP3IUYbNZ0hxXc7sOwSWrF53d1vCWfFzi0sK/BKg8PBYVO85eNFr1me/UhSvtCuSbNU9EeaD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900402; c=relaxed/simple;
	bh=OZ/1ERdJ0fKvV2ivV8e4dPvCaH4+Tzu6kQ/PNIu/RxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsaKZJnjaj383lDzfZu81SRb5dEw3RFte+gigf6tql4NUfQUt0wmWfsuOw1S4KlnIJq68PdMjk93MtlOEqrV9aMRPTFVeTewmD+y9j/YuW1TjZ7g/PcCblQ2dFCP5Gk161pT0r5zyDu67b0JXmXe74lrqqln+HBbbYhvunk2VME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FLs5u0kw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FLs5u0kw"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C5x9Ue3223275;
	Thu, 12 Feb 2026 07:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r7iyv
	6/9xiC+a8G3HJk5Ak0+nlcm+H4ZobXX9N53Yw8=; b=FLs5u0kwo97rXHPiu472s
	F0GxpbNwg1ab+deszxYEC0gZcVYzIhdtIS2ERVXcFwU0biEgR4weqeeplA3Zze7O
	3FkyjWXHRW4ozYtMkgN/EBvWXKerjRC3mAJ51AGCu97Lf/6TTAWu36IVImTAoVwG
	SZSiarrOwn2AKVEmw9h8tK9NKViDUFDjXrSJX/vabti+AGcVpuBk2Ijf1aV0drjj
	Sz2nJdiUWY75gstozZvcpg7M0W4st5kd9O+iVGa1zXQWnuBJ8UyJMy8AjMCWNAYp
	L73mzho6pWWtvb7GxyUciGrPiu9/buciFBf8mUfOPQwNW9fI3tKoJBzLycJGY7f3
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c8crwfb2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 07:46:34 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61CCkXNK014033
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Feb 2026 07:46:33 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 12 Feb 2026 07:46:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 12 Feb 2026 07:46:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 12 Feb 2026 07:46:32 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61CCkKmT028003;
	Thu, 12 Feb 2026 07:46:28 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
Date: Thu, 12 Feb 2026 14:46:07 +0200
Message-ID: <20260212124609.24745-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212124609.24745-1-antoniu.miclaus@analog.com>
References: <20260212124609.24745-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: CRQx2X0dUYX-NKYiOmSGM8K86aubTp6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA5NiBTYWx0ZWRfX0Ya7fWCQUQk2
 pVLyStU02tg/byUGstczc+BRLMj7efbR3MwGRfeA/2A3AxsbiYs1r5T+J3viiRH/DsLSnzuyyLj
 BXnUqoFFhDoA00TABeKhwzZcDXv0kW0NHwT2MIK43IlGCdHUyAfmEWhMAEFPUgIVg8Uz7v/W/wI
 kJLvuLg5JtooBP2B+RyrUPfVp++6cmERqwOtpuOCqgfvHH6ILQ+5zta2sgO+Ui9xZnmztgB+0yr
 1zFMAoJUWvUXAcSSqDN9H8sXHm8upomp01vzjFkiwWEtjAZseI9CCbTsKYWxcazqtdodiSUPGme
 fj001c9MglLBxLWePXtILn7kmRFLU8+8GNUV9bb6nSOrPocFAjM/mRGtVpeQv7ZRkLmuCJwzrZs
 ULQs5Z0LyjNfZ1IwsmB8h6O9HIMj2oEJYrzIdhhRLWAX9I4qO2L0NKGJ3WpCDtu99AtiZFheYrE
 jJs9+51dFe/joa/59qQ==
X-Authority-Analysis: v=2.4 cv=fPo0HJae c=1 sm=1 tr=0 ts=698dcbaa cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=jpAYIt_UsUcvgembpXsA:9
X-Proofpoint-ORIG-GUID: CRQx2X0dUYX-NKYiOmSGM8K86aubTp6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120096

sizeof(num) evaluates to sizeof(size_t) (8 bytes on 64-bit) instead
of the intended __be32 element size (4 bytes). Use sizeof(*meas) to
correctly match the buffer element type.

Fixes: 8f3f13085278 ("iio: sps30: separate core and interface specific code")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/chemical/sps30_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index f692c089d17b..c92f04990c34 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -171,7 +171,7 @@ static int sps30_i2c_read_meas(struct sps30_state *state, __be32 *meas, size_t n
 	if (!sps30_i2c_meas_ready(state))
 		return -ETIMEDOUT;
 
-	return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, meas, sizeof(num) * num);
+	return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, meas, sizeof(*meas) * num);
 }
 
 static int sps30_i2c_clean_fan(struct sps30_state *state)
-- 
2.43.0

