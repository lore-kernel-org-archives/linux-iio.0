Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831D31D375;
	Fri, 20 Feb 2026 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593203; cv=none; b=YcMsZSwSVycsWfZf5vxic55FdvrIOPjLQzSMi0KZlD6Kj06F4TCHTO0RAWTzpzNEL2uD6DjquRAdRRZRHWS1S9cQCmLOSiphD/X3YrUPomyP+wWr8zaShQB7pBfWf7ERtZYE4D4sOru0kzaMtY9BGSKCVLAcxzrqTwj/1GMrIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593203; c=relaxed/simple;
	bh=cLjCo+mu/lPz7LnfScWmnzqtMOQ54eInHIH0e59C32g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HyjEdr0stX810cMwl119ABDjXJ8aU+I/6sQfwyrw73+yB36EKxGc2hlYqNKd0GRDHuRMK+c5SrzUEBdAIFUbc2LZ/TD/D/+4mn+lfjRltnje5YmUZPTQm4971HvTaetx6RcqaLMq15NudfwR0+mHzj9VGAl4HHS2DkXQXa6gFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TJblm2pK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TJblm2pK"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K897r5898207;
	Fri, 20 Feb 2026 08:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=8jdjFHyBsQW2XkEbTszZc46YQ8x
	t6xL7SzkY3rmZl/c=; b=TJblm2pKoZuussmCT4jOWV6hfQP1CONqa60YSKgcjgD
	JTdqpKkmu092D3NoMoz62SRt+yYpNersxQ8c1TLqXCGpNzOl82Wag3EdwiW0fb0/
	hEt9nUim43Q8lk9qapcafR9L+99XAeKhsN3B6swD0bngIUS4R4t3i+mkZWY5Z2B4
	IIUs8J/F0M9frhGJjE+GRfwlNUBvktKNe8J1/kEjilHNJHt/ACBeeWk8KsPtpUEJ
	AXQMmDVYw6fMN7ossbewzswsEXbWdlUI/XKqAKbeRpTdX2sm3msDCf+fpJCzfLft
	7RT++U9V1tRBXtTqZMjihj+8KUiIMZJtXg/GwmHWJ5g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ce69kkrme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:13:05 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDD4uA064734
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:13:04 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:13:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:13:04 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDCsHR009613;
	Fri, 20 Feb 2026 08:12:57 -0500
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
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] iio: use dev_err_probe in probe path for ADI drivers
Date: Fri, 20 Feb 2026 15:11:38 +0200
Message-ID: <20260220131151.74329-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Z//h3XRA c=1 sm=1 tr=0 ts=69985de1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=IA88mgySg3KGAzZw5awA:9
X-Proofpoint-ORIG-GUID: uIVN4lmIrfweuSdAZ8NU-tEMMb7FBalS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExNSBTYWx0ZWRfX2w4fBS8opqQq
 XEXzgUAETkZzsZniWbjt01OIf1UcT3gDDTbYVxp2ff1zRz7fVMzCYY6302pGNhyxwCufU70p/6R
 hFA/mz2JLUGoU5mrb1mFUPa8p4Rp36pWlCIkKy43y9eHYINciLX3or5hOfLmLsjwCs9cTX02kDH
 F02uTpbWTskGtmvuGuiN9ngIl0jpnSpelvlUHqAmhotkF3l1pt/sNw0ZXqqXlvwOUbiZRALd4tN
 jDlGxCnUdjhmHx0Fmd9J3ed8BN2+CFhfxNMX4/dZ7HLNlnw2vuw7rlVB1Gj+AXuqeDeLg+5GQmi
 xHFw9Zqq/jPuyXQ9gqXPVL17XXofh2H1MHaUN5Z3jBihrYSvZAkijwTIDan+mKBcLSotIuvXA0f
 9IILCbdlJob8u4yJ3r3OLHQ4AbZ8aKXhW+woJ5m6lpzpjbX6oKKbLfUP7bFbYhZzPy4sPg+1nPn
 rsC/c6c4Jb7bqT2ssLw==
X-Proofpoint-GUID: uIVN4lmIrfweuSdAZ8NU-tEMMb7FBalS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200115

Use dev_err_probe() consistently in the probe path of several ADI IIO
drivers. This simplifies error handling and ensures proper logging of
deferred probes.

Drivers updated:
 - adrf6780
 - admv1014
 - admv1013
 - adf4377
 - ade9000
 - ad7293
 - admv8818

Antoniu Miclaus (7):
  iio: frequency: adrf6780: use dev_err_probe in probe path
  iio: frequency: admv1014: use dev_err_probe in probe path
  iio: frequency: admv1013: use dev_err_probe in probe path
  iio: frequency: adf4377: use dev_err_probe in probe path
  iio: adc: ade9000: use dev_err_probe in probe path
  iio: dac: ad7293: use dev_err_probe in probe path
  iio: filter: admv8818: use dev_err_probe in probe path

 drivers/iio/adc/ade9000.c        |  7 ++--
 drivers/iio/dac/ad7293.c         |  7 ++--
 drivers/iio/filter/admv8818.c    | 38 +++++++++----------
 drivers/iio/frequency/adf4377.c  | 28 ++++++--------
 drivers/iio/frequency/admv1013.c | 22 +++++------
 drivers/iio/frequency/admv1014.c | 63 ++++++++++++++------------------
 drivers/iio/frequency/adrf6780.c | 21 +++++------
 7 files changed, 80 insertions(+), 106 deletions(-)

-- 
2.43.0

