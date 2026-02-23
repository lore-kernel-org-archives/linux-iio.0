Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE117366542;
	Mon, 23 Feb 2026 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852492; cv=none; b=kGc83FHyLBPqinoHnkvB6ecF/H+mQJiH8n0PXinnwL7wxEeo0ziv0K6ExPQRNVLGkzn5ZbCG3hrCp/tG/bYgp/MhnREJ8FlFVKmTIvNdG9El8InqMaRUUqCJpQr7rgHXrM89z+/4ODZIXXOWfPP6HgW1QQG6Mi0gm2nTz9XNHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852492; c=relaxed/simple;
	bh=f7qRelyTQPMpOzUWCqlAHIWT85zbQLtEjblo5ylvL6c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cZUPEJqO/AH7LLddsKfHVVUXlXlhk/Gfea1QvElZwJ/JsGeD5fy0wuV4NTeE5GNb5XaaQaFQafYOW5tzNtyVCky7Lh//to9lr6REYP/qdskTBUkzqL32OP0JeMd1l0nztHeWErTcnYwkqbHGW6YvLHTixMAH+O2MsBhKA+nyThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BJZIZv2c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BJZIZv2c"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCW8aX1742937;
	Mon, 23 Feb 2026 08:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=K9Qy7ynBT/7BFJUmJ15js7hIww6
	8tBgK8rOw/siqNAA=; b=BJZIZv2cL80VTbLZ4cX4Mdw7O4LDrQEJs/kd4WnYhkm
	KR6JXg5KIGJ9VjDOGHIj4iU/0J46LL6hD3CBo4N/fumq5RpCr97ZS3xFJ4T5na/4
	LVBR3bT/2b+3KdCAJty9vPU7hvbx4letVC/fy9BLGzUz4JSwvAKKKbveOqIJclRY
	4vfRyDaVNrgi33OB4B4JaAdQlicRMZfVBE6t82Qz6UhLfUgmLw9PIROcRdV1kmFx
	6IJCx0P4RIdohWVcSe3xPy51jVM5MM6WyFcGVRLsNeTHScFIhjh6VygnFRSA7+vp
	jv4FqHnsDw6hIPWPdaK4SXf5a1WW9EkbYO7EjqbbnSA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4k2w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:35 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEYLW009721
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:34 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 08:14:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:34 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXW006594;
	Mon, 23 Feb 2026 08:14:24 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/12] iio: use dev_err_probe in probe path for ADI drivers
Date: Mon, 23 Feb 2026 15:13:51 +0200
Message-ID: <20260223131418.55414-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX8P8Yh6q5CUz1
 ZilTyWZWXhoD4gn0e48OVem7iOE/c/O4a6BVVi4xq6VbGBdoWYi3nIo4Q0HOQIN5FLTlFyZ2wcX
 dEKurbJqhONNxE8/c9TqoPLu/yjYhD+nN9UKx9M/Xg+Zrr3fL3FbfG9tIGH2dq0BqcO/gv0ZCp3
 WuFV6g2TU+XfS/jtDKqkPxkdGSrxbOEwd0YrjL9x/EpilKWnKsN6g4nxWwXkxjdXLRHCYYHpsS3
 JEpy47wyhoG0uJiXHIbr4jeh55zzU8DxsP8oMKKh3N6jF2lXNoY+uaTiB38zONzC7Tkiqg3mf1h
 6EEJbkEHDhYAsnHifiFw3TnezvBdrxtF/ORsh3d0l3M0YFiVMcECnwrcuNt3nHI532mIYlRilWN
 Hlv/p6kpUQtOHZ7rXXnfEZnaATOipHqkHuCmq50t1iKVc1otFDUsk8GysYoMrZJ3cUuiKECG9G6
 zDHPviMLgYf8b4x1YYw==
X-Proofpoint-ORIG-GUID: DmEwiaIkm3Q_ZPqgxkMtTXGOAtz6rRgT
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c52bb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=0diNNnJFd80vb9pQVC0A:9
X-Proofpoint-GUID: DmEwiaIkm3Q_ZPqgxkMtTXGOAtz6rRgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230113

Use dev_err_probe() consistently in the probe path of several ADI IIO
drivers. This simplifies error handling and ensures proper logging of
deferred probes.

Each driver is updated in two patches: first introducing a local
struct device variable to simplify repeated &spi->dev / &client->dev
references, then converting error paths to use dev_err_probe().

Drivers updated:
 - adrf6780
 - admv1014
 - admv1013
 - adf4377
 - ad7293
 - admv8818

Changes in v2:
 - Split each driver update into two patches: one precursor for introducing the
   struct device variable, and one for the dev_err_probe() conversion.(as
   Jonathan Cameron suggested).
 - Dropped ade9000 patch (already accepted).

Antoniu Miclaus (12):
  iio: frequency: adrf6780: introduce struct device variable
  iio: frequency: adrf6780: use dev_err_probe in probe path
  iio: frequency: admv1014: introduce struct device variable
  iio: frequency: admv1014: use dev_err_probe in probe path
  iio: frequency: admv1013: introduce struct device variable
  iio: frequency: admv1013: use dev_err_probe in probe path
  iio: frequency: adf4377: introduce struct device variable
  iio: frequency: adf4377: use dev_err_probe in probe path
  iio: dac: ad7293: introduce struct device variable
  iio: dac: ad7293: use dev_err_probe in probe path
  iio: filter: admv8818: introduce struct device variable
  iio: filter: admv8818: use dev_err_probe in probe path

 drivers/iio/dac/ad7293.c         | 32 +++++------
 drivers/iio/filter/admv8818.c    | 61 ++++++++++-----------
 drivers/iio/frequency/adf4377.c  | 57 +++++++++----------
 drivers/iio/frequency/admv1013.c | 51 ++++++++---------
 drivers/iio/frequency/admv1014.c | 94 +++++++++++++++-----------------
 drivers/iio/frequency/adrf6780.c | 60 ++++++++++----------
 6 files changed, 168 insertions(+), 187 deletions(-)

-- 
2.43.0

