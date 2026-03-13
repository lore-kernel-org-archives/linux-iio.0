Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411038AC71;
	Fri, 13 Mar 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403101; cv=none; b=tLL2uhxx4kVxU+bVBRz9+DhDu+O3kQOiRUay7BqlV666H7IyNeeA0DClNF/vwqlGas42Wr0a4nSX8dyd0ttu2NjvTH0EkV42JlV7VIbV/MX4aCRWccAnfU/rLeUNkao9kjzBT3KT9fcQswPG7hk5yIj/dCrkfGBcVm2YPXlQKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403101; c=relaxed/simple;
	bh=pbBIiFJ9qpUgWwO/pWLmss++ygs6eyJ4cmmh6fNv+X4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DTbqK4REm/coS+RRyY+wL9MI6jHQYFTHbnhloM6EvUfrWkiTaEEIeoAU6FE0jvSLoqHWYqiOsmpY4qLt8OGh4nRh10ucdyNWAcRggVGd7jk7VFBO6JWDbDfoylG1ynueZo9w3lOC8oh8bX79n3yxLVkvEDKkrVpa2AWDvtNTQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bIirsyb8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bIirsyb8"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DBbIfB3650978;
	Fri, 13 Mar 2026 07:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=VULEOX4fstfwuuNPNbIChm96X6i
	DBdo/qmCRAhnnujc=; b=bIirsyb8BOtxtemjkX27LhLVww1NlXZzG72Y2l3EGc6
	/ey4lbWOIiyzso44jX3mPCwdKteeoi0ivekyPVipReUCsYEawZqpgwjsss8w6G2v
	iTuYnqNlemmrDz3iR0Tz2Ok/9FeSg92vNvS//ShxvcTmRPIS7Y0/rLbGY6TwDJBW
	wLKz4BBGOjc0kXUgYJLx3UkK+C/bSApf0J+hF5kVdGcaEiYf4FSdeS/qkeKpfluE
	8aALLeXKh/CgUVEYZm+zOUB1/6NLJ5BJgZrKn/Drgjkyf5hLRyzfD1B9IsQ0U1DT
	Lu3DPurBOe0kxT0p55DOuEW6pQ7kmo2AJ+7AbxAu6FA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh6bf11n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:58:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBw3Qc017516
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:58:03 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:58:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:58:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:58:03 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBvrv0024538;
	Fri, 13 Mar 2026 07:57:55 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 0/4] iio: frequency: use dev_err_probe for admv4420 and ad9523
Date: Fri, 13 Mar 2026 13:57:40 +0200
Message-ID: <cover.1773050333.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: 1LC0yHeIFvxAI9X7mJ4hrRTenHt_jrrW
X-Authority-Analysis: v=2.4 cv=c6amgB9l c=1 sm=1 tr=0 ts=69b3fbcc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=sWZcez0mZggHddJyeykA:9
X-Proofpoint-GUID: 1LC0yHeIFvxAI9X7mJ4hrRTenHt_jrrW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX6j4HhVGIJq7Q
 wXCVY4rSY3Uf2DgDGX3QhVxVzjaTReoO3s4GUU/CG4Fv75R1nx4QMH00DwWixH1wse1XWaBOybC
 eDrzpGWMaoxNjmwweFadh7xfm8se3GNMT2Nu7Kl8vHYN9/URxLIq5vkVqhSZ5Uj5Jl0k5TU3+xa
 RsXOWBISX7/vVpoJbGgbXgvc444I6ii51+Fz5HYn8smqPlPkCPBJKPAJ6ouc0aY6XfXjxxTxCDP
 3smbfvKiAhqcFYicCDJlosbkIeEntxiWwHkJweBJjO42xW8YbD45Sts35Pmtw6QzH99niyFz43u
 hYdpnbqePswB0EWQEyY0Rlf7Q2hZ95YhQ+JfqPfwsk/MfcqdHi5mLr9o+9Z4TCSAmZNJdflyCL7
 m/QblgRxMRRKOpGMcRgDE58jARs1Jky8AiQXLe3Q280wlICI+/9oMuuSHW4LtDIdaneoyCZmxdz
 rAiyP2hrgDVTyfDahdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130095

Use dev_err_probe() instead of dev_err() in the probe paths of the
admv4420 and ad9523 frequency drivers.

Each driver update is split into two patches:
 - First patch introduces a local struct device variable in the probe
   function and replaces &spi->dev references in non-error paths.
 - Second patch converts dev_err() calls to dev_err_probe() in the
   probe path.

No lines are edited twice across patch pairs.

Changes in v2:
  - Fix vco_freq_hz format specifier from %lld to %llu (patch 2)
  - Split pdata declaration and assignment in ad9523_probe() (patch 3)
  - Leave dev_err(&spi->dev, ...) untouched in patch 3, let patch 4
    handle the full dev_err_probe(dev, ...) conversion

Antoniu Miclaus (4):
  iio: frequency: admv4420: add dev variable
  iio: frequency: admv4420: use dev_err_probe
  iio: frequency: ad9523: add dev variable
  iio: frequency: ad9523: use dev_err_probe

 drivers/iio/frequency/ad9523.c   | 22 ++++++++++----------
 drivers/iio/frequency/admv4420.c | 35 +++++++++++++++-----------------
 2 files changed, 27 insertions(+), 30 deletions(-)

-- 
2.43.0

