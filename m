Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E73C1978;
	Mon, 30 Mar 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869655; cv=none; b=LVy61aOTsNkCy3o8y8/MrO3XNGjImiCu/9TXNKCZKLkwgIiGQVTs4a7A0tGParIi+sFPQ+0pfEQLVgG55ZHBP10p2ZsjTu7a/s7XH8zJBvN9Dm9Jmk0w984gi/nwT1hjvansptGo2QxN6Ch3Haxc3EU7i7dJkLhxIAkWP6Qf+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869655; c=relaxed/simple;
	bh=XTljGyw+hxGeUlLZjchoprpe0eFiDErQwTYjr5JGP1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjfupAcYyf73vfo3y7GjQqG8B+396rWtak7BnoQ1fRj0w2WyPffxwjbH1ifpUcDOGnhD7uXZ69Zb8QUpDI0+jTKrf3PVCOGFXu6qPi/tBRym5K4htsI/9x0D9Bgox/DOigUJqp64i26bQlDOsLmYCLChH9AikoMbOvBqcd4Z1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DvKYuD3i; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DvKYuD3i"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAw5u33972984;
	Mon, 30 Mar 2026 07:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=1PQEm2TP4SF2cDsGk5nFsX4u9We
	5Vj8HkFLxXJ20GQw=; b=DvKYuD3iF/a88PHDYj+1UHDDmJTpk7NW14cetT0kmmq
	6hG8QFurZtVSU0GLJ/oImuqIZG85AWEHNtgCoCShfeTWqaut16g7+ArrZU1jvfXr
	J7z9NG5OKOGO6VV7u3cofRG44irkPJd6wS/PAa7tTPF3D5w8fq422iX2UakhD/ip
	QF6J7gMFCrSOmn88e8h9jbk/GFiAZYyNZPPc1FAieYpFehQ404PWcjZ4ILLpqGSy
	in2sFEiEOY8T1WH50ZEbjtQ9g+sHnflnDudY3L6mOE5Dps6WBZkUIDMiFFVTazqi
	4LwW7ZCJEzk8u92uvlDCPXN0O3JghHUffOetGVGOqHQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d7gkv9kec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKSeM026858
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 30 Mar
 2026 07:20:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:28 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgT014225;
	Mon, 30 Mar 2026 07:20:16 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 00/13] iio: adc: use dev_err_probe in probe paths
Date: Mon, 30 Mar 2026 14:18:43 +0300
Message-ID: <20260330111856.121589-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: dgl6OTza_aWr4FlXvFo92di4TYX0AdGt
X-Proofpoint-ORIG-GUID: dgl6OTza_aWr4FlXvFo92di4TYX0AdGt
X-Authority-Analysis: v=2.4 cv=TeqbdBQh c=1 sm=1 tr=0 ts=69ca5c7d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=KXr34PXq5RCSTuAH7G8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX7k+nOfaaV0Q9
 2ghvxaqjFTb8UFLvNR9i/L4PoBfpwz7F/PmACOriPtP+RBfTo8OUbY/xj9AXRlxcHT+Q3wRu2Zb
 w+0n7RkOT8BydEI5eY/7HJkOPI58/hJVFZw03D+dPDeqdagUplbL59gIc9PPE7in5+CmCkY7B6v
 0LHZ39n9XGTcSMQCvnjLTX0FrByb9bWx+W6LT0H1eJ2q43SXkARtBBOA0qRFynXmDzkoiEetWjw
 wnOqbmNMH1yotvbvx/jX14N/IcXgMbr681B/v9hLC6foU6c41RJpaJmLFIGlnRYrj3FR/fVkhmS
 PAi3Dg6ODNe7yKqEUpk5CR0L9NBx9EVaZCs/JrzyUdAQinhcs3/sSCZEkYdxOfpzqX+1rU3V+7E
 tfahGpwFkDVDvcDyAG0wMBxrIhK6giTdF9iLSFusvAInXqoi3n5h+tYBlsJSyQVVzGI82Ba56s1
 Ak8u4913YiZLI/F4P9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

This series converts dev_err() calls to dev_err_probe() in the probe
paths of various IIO ADC drivers. This ensures proper handling of
deferred probing and simplifies error handling.

Where needed, a local struct device pointer is introduced first to
reduce repeated &spi->dev dereferences throughout the probe function.

Drivers addressed:
  - ad7949, ad7780, ad7793, ad7292, ad7791, ad7280a, ad7768-1,
    ad9467, ad4062

Antoniu Miclaus (13):
  iio: adc: ad7949: use dev_err_probe
  iio: adc: ad7780: add dev variable
  iio: adc: ad7780: use dev_err_probe
  iio: adc: ad7793: add dev variable
  iio: adc: ad7793: use dev_err_probe
  iio: adc: ad7292: add dev variable
  iio: adc: ad7292: use dev_err_probe
  iio: adc: ad7791: add dev variable
  iio: adc: ad7791: use dev_err_probe
  iio: adc: ad7280a: use dev_err_probe
  iio: adc: ad7768-1: use dev_err_probe
  iio: adc: ad9467: use dev_err_probe
  iio: adc: ad4062: use dev_err_probe

 drivers/iio/adc/ad4062.c   |  7 +++---
 drivers/iio/adc/ad7280a.c  |  4 ++--
 drivers/iio/adc/ad7292.c   | 16 ++++++-------
 drivers/iio/adc/ad7768-1.c |  6 ++---
 drivers/iio/adc/ad7780.c   | 46 ++++++++++++++++----------------------
 drivers/iio/adc/ad7791.c   | 19 ++++++++--------
 drivers/iio/adc/ad7793.c   | 30 +++++++++++--------------
 drivers/iio/adc/ad7949.c   | 25 ++++++++-------------
 drivers/iio/adc/ad9467.c   |  9 ++++----
 9 files changed, 69 insertions(+), 93 deletions(-)

-- 
2.43.0

