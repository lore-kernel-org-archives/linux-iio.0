Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010DF1E32CF;
	Thu, 29 Jan 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698996; cv=none; b=OCwQKhCI3oRW9Bt3IkM5gESzKgVdg1Uzsx6Pul6vuQDIyeJm4Je1iK3RIuhQdgqcX4DJ4rPMI2bUZ7Ao/TuoNKtNfDFjXVTG+TSx+5uvWkyQtpjGGAjEoMXSkMagvvJNZv3uV+ADwDd+rOVwdBIF9LUa19gr2wM3GqrlsufA3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698996; c=relaxed/simple;
	bh=TT+wAztiLr+FdJp74eI3A2Pbo4z9SEhUjHNOtuUJ8Co=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLH5tjr8eGOlb7jV22plY9FusLO/rkt9PGHRmDCxLSCgWSOCNUKMsW3SFZVRF2FDRFeM9bLkzjQAq234ropm8Pwc5O8PArCzjNoiiy9o/vauCLW2zP2byOZ7QXu1g+q35+3I3gp18RMagxiKiMhrTVn4sdgF4NvQ5SaqzyS+bcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UsXVSzHy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UsXVSzHy"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T8eK4Z2649191;
	Thu, 29 Jan 2026 10:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=wlaaqQnbt/HHqvEk88HO/3eEKsd
	2iq3fX+rYna6zPMw=; b=UsXVSzHy30A32vv+jqLwKASrDfKVt3ViBdF/kkR3d5x
	KDWw9p+4/Chl9PXBZEjy3EZD3pvOahmIAEYDvUDU+mE9iuJXmb7titqHkMOT6aiS
	etVPsBUL33QyZCDszC3cGwemNt+toyDC/T1832Ps94cKptUsOCKWhtK1/UYEovzo
	OUlihq5Q4KnSn4HJ09mU/4ccQBX4OOITijeXPa0oV+XMEnjB8Fd0q+mfAd8noG28
	9Ri1b4NC/2yG8KpzsNydtiNVA0MW82aerK9rrjIdGGNd6cYpxsSl1SgRKNEcu3n1
	E0YBWD+BI6Q9vz3jD8pOw3KRhLccSY2M5E/yklQckNQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c04891agr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 10:02:50 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TF2nuP039056
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 10:02:49 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 10:02:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 10:02:49 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TF2aeP001997;
	Thu, 29 Jan 2026 10:02:39 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Manuel Stahl
	<manuel.stahl@iis.fraunhofer.de>,
        Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: gyro: itg3200: Fix unchecked return value in read_raw
Date: Thu, 29 Jan 2026 17:01:45 +0200
Message-ID: <20260129150151.127713-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwMyBTYWx0ZWRfX3GlbjO17Js4T
 SKSkkIytH5w5Cdu7jeVQIKB3LlZmP5lhP1lZiCIJ4PWgJ/9p6qCodGxDSnduXqscwQEBWFzCXCH
 IcvghahjJ6F+7dxJhh3yRH3HpGDFodq6s/wXSiARzRee7+cM0CESSaSnOyNw/HY/VxTdLMk8TAy
 2OzevkJj6XuC1+hD5+uxCJsb0p4BGfeoNsN2S0R9usSmQtx9FOBJRc9YxHCdqjUrA3A/phh3RlU
 61AenkzfkUcJ8mSWj7jtcdQyHe+a6Ha2mi6mVdOjp5F90UABC8pHImtdxNn4jlYqHbaERK95dta
 EfxoRT9P/0iBhvJldXvrRQwa5duRoHboLkU5e3zhBWp0Fg6HtqF001Q48YWfBgLII2oN9AbfIrH
 cVPdr01Eq1cg8tjiZka3m/+rmJFADWVXcbG2LkL6G4CHCiHnQ3jPGYUn89VOqzrDq3I5hd19C3i
 c/OkKxRue47xaZGN7SQ==
X-Proofpoint-GUID: Dws5CP10YRORqsvimQLCmWAQcsSPCPO8
X-Proofpoint-ORIG-GUID: Dws5CP10YRORqsvimQLCmWAQcsSPCPO8
X-Authority-Analysis: v=2.4 cv=dq/Wylg4 c=1 sm=1 tr=0 ts=697b769a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=BgFCvWlFNng4UHtJon4A:9 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290103

The return value from itg3200_read_reg_s16() is stored in ret but
never checked. The function unconditionally returns IIO_VAL_INT,
ignoring potential I2C read failures. This causes garbage data to
be returned to userspace when the read fails, with no error reported.

Add proper error checking to propagate the failure to callers.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/gyro/itg3200_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index cd8a2dae56cd..bfe95ec1abda 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -93,6 +93,8 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		reg = (u8)chan->address;
 		ret = itg3200_read_reg_s16(indio_dev, reg, val);
+		if (ret)
+			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-- 
2.43.0

