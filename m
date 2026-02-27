Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02233D6693;
	Fri, 27 Feb 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200952; cv=none; b=TJ8IKPgWrJlkEJHUUcG42nsAUq3JC9JR6vNzHvYtpJAq8a++myqNGpBm3MDkPW1lXntOz5NI3Ih0gWPe1XsA/+3TR8qL2vaX+KYQ980VBZPHS33XDyD0mKGEcJJncGtQEQe96s2mR86BztjWtsKPFjpTGMgAxPfoROJcdmRxdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200952; c=relaxed/simple;
	bh=8C58AROml961/chowjotBtIgfNRyr47qN7yUPLIWvPM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGMs3BPU24MKjRyoDkuDg0okLhKrEZHEDszq8xe/Io7zLhY5K5vZ9ouLp9WtGJyBZY9Yr9j7QgwDfNBGHXCIhwG8MjkYIdaoGE1+BuAIVaBP8dh5kFiv3aTBfAnTcNZN5uk8V7TPxQKrq9Wd58CBlJ/Df/OCr5d9WLFRzpvSGMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Z1mWSTfe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Z1mWSTfe"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RDnAAU2503426;
	Fri, 27 Feb 2026 09:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=I3VvfHYHtEUqytfLJL7r63y71nW
	3+C43BVGZ15hotAk=; b=Z1mWSTfenDbjp7k6+o8+XiffGxKNOmtv61GsogQMv7N
	QKgA+eQkwc1qsUFZm0KGHdFzr2WjftRQ33IaKzsV/KtWzoRjB0OgFnK1YVy2qxLp
	vYs9E3Rs8sV52Vw5UxK/1oM45xGiKL6TbtoRwfsijVQPRWUZZQe4xmvKWvTpRp+5
	9gVZRRAtISJYk3DVDOtgPyURsCDtCNDSajz6fcuEdZ3Ty8LfOamJ6ETDipUb1uxy
	WaIiCN3YRx48wbd+SMEfTawFI3GyYbL3WCIlcwIFj32fLtpXyJNGTxTwid9mUoPj
	UGvxLODLrO9RVQTthj/PhEgOSV7eoMYu4iS1gx2SpsQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cjbw3yk6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:08 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE27xe064784
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:07 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:07 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3m001982;
	Fri, 27 Feb 2026 09:01:57 -0500
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
Subject: [PATCH v4 00/12] iio: use dev_err_probe in probe path for ADI drivers
Date: Fri, 27 Feb 2026 16:01:29 +0200
Message-ID: <20260227140152.77529-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfX9kjcP9sz506o
 tZ4YdfWKtkRCmj+5MW1E1UtOR0IbVkJoZakNOz7ReUv8Ia2gXebCHyqZG/tBuRmnlMn99gSYDUu
 /aWZ86Piky1t2F2lVMoumY/qEg8EqNhrmm9y5pS84BgUpjBk6pElUbnkLhap8yLlhLhvcaRKbp2
 q06VVgmfEK2G7jjOhNcuhUq+d8uQq1HkUvlSStKip+6n3NdI10Zh8IeBV9G/fJN6noaeN5ctc3k
 SN7s4bHec2DHWRBFjDIkb83FKeeqLjgAxFyqMUD1nX2ouYuDAHoYVGbUBBhIcv8+5cwZj+k4CDo
 3/UhmA4nuII7bZhgGK0DLSUbSyzQ3fpJEu0G+xJid0rmNTaxt/9iCqO5KdgDgT+sDi5M95JfEPm
 LE61RVWgqplefUtLCq6vpNP4ctxBSXIXJBDj6prdYEEaGGDLWWmWD47sWhD8UdFR/qNFZ2P1Qfx
 lVINYYMi4U3LfoRMEMA==
X-Authority-Analysis: v=2.4 cv=AtXjHe9P c=1 sm=1 tr=0 ts=69a1a3e0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=-A2P3oIxMkWH6bpARaoA:9
X-Proofpoint-ORIG-GUID: iIYamwy3jz1_tsbrlb_Ga-ffbOoRGUWe
X-Proofpoint-GUID: iIYamwy3jz1_tsbrlb_Ga-ffbOoRGUWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270124

Use dev_err_probe() consistently in the probe path of several ADI IIO
drivers. This simplifies error handling and ensures proper logging of
deferred probes.

Each driver is updated in two patches: first introducing a local
struct device *dev variable alongside the existing spi variable to
replace &spi->dev references in non-error paths, then converting
dev_err() error paths to use dev_err_probe().

Drivers updated:
 - adrf6780
 - admv1014
 - admv1013
 - adf4377
 - ad7293
 - admv8818

Changes in v4:
 - Split each driver update back into two separate patches: one for
   introducing the struct device variable and one for the dev_err_probe()
   conversion. No lines are edited twice cross patch pairs, error-only
   functions get dev introduced in the "use dev_err_probe" commit.

Antoniu Miclaus (12):
  iio: frequency: adrf6780: add dev variable
  iio: frequency: adrf6780: use dev_err_probe
  iio: frequency: admv1014: add dev variable
  iio: frequency: admv1014: use dev_err_probe
  iio: frequency: admv1013: add dev variable
  iio: frequency: admv1013: use dev_err_probe
  iio: frequency: adf4377: add dev variable
  iio: frequency: adf4377: use dev_err_probe
  iio: dac: ad7293: add dev variable
  iio: dac: ad7293: use dev_err_probe
  iio: filter: admv8818: add dev variable
  iio: filter: admv8818: use dev_err_probe

 drivers/iio/dac/ad7293.c         | 31 ++++++-----
 drivers/iio/filter/admv8818.c    | 56 +++++++++-----------
 drivers/iio/frequency/adf4377.c  | 56 ++++++++++----------
 drivers/iio/frequency/admv1013.c | 43 +++++++--------
 drivers/iio/frequency/admv1014.c | 89 ++++++++++++++------------------
 drivers/iio/frequency/adrf6780.c | 60 +++++++++++----------
 6 files changed, 155 insertions(+), 180 deletions(-)

-- 
2.43.0

