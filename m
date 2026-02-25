Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617873D3306;
	Wed, 25 Feb 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032036; cv=none; b=GDs8gDpATvUra0tw2h7c/luV/xeWLzejI6aaCAyC7QuIsIpWklZSxHW8ZBx/eSrS2tENqGD/qMKT918fpwnMQ5AzUbbg21Vk4f6dV1v4tKAudllEmCSmCV6EreyAI1F5SpzipL5QzJiVDPf6iJoWQ+imsx8u3oJRzLzc7KM1cUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032036; c=relaxed/simple;
	bh=V8MzGUT+bM4JV1T5iyOmz2+36GCLGBLH4pMA+K1iZFo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O338dId4fu8RhJ29EafSxc0COnROHK3IZEUO8URWf75m64OXRp4i0Q9bFanQpYgfuNWvTseqLJ8hBVLT0G80D4L0klWUra1wMC+uyxE6exJKYnHTNzcwudakRko9DCK5ICHqzwQFRqp0BWTKkwZcZbwTU3WMeiAb2BKKHeonEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZSZQsjpV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZSZQsjpV"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9KOwP818778;
	Wed, 25 Feb 2026 10:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=VFqtw48VNI+0DA4oFvA/iT4mBc7
	/NOQtClsttaK22Bc=; b=ZSZQsjpVLM2uMZHwxxEA7YbI5EYhGm7Bkbn3zh5ba2V
	7574vaDzJ+PqJmF/4TGBdIa1mi1daqWgtvTtNFB3PLcc9w7rbPHC92W4NccLNWCr
	M9ba/xffLefdVRaoARqUyn1rgb5ure8wNMT4YD96lnv0cVbGEHoUcHtLz4zmKjVV
	PWYlWMuMIQJrjJsvn4b6qqMJYL0ypYBIPus/S1WUWnitIKjd35xb2+JK5n3SFs98
	6khGt+rE3V2bfC3kp3Frqwvytu0Lz2UgVFwpDyu66HVBctzQq7+xYAQ8qmI3Jt1a
	FctlkVKTOlhyeDRqrSS0hi0wA1lu32jisj0/Thk2stw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p0d54s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 10:06:46 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61PF6j07024629
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Feb 2026 10:06:45 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 25 Feb 2026 10:06:45 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 25 Feb 2026 10:06:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 25 Feb 2026 10:06:45 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61PF6Yno006794;
	Wed, 25 Feb 2026 10:06:37 -0500
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
Subject: [PATCH v3 0/6] iio: use dev_err_probe in probe path for ADI drivers
Date: Wed, 25 Feb 2026 17:05:46 +0200
Message-ID: <20260225150615.274078-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: w-UbwMk9cM-iynZ9jWVXbKW0jfFy8Bhm
X-Proofpoint-GUID: w-UbwMk9cM-iynZ9jWVXbKW0jfFy8Bhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0NSBTYWx0ZWRfX5mC31ob4kCTa
 QUeZEf/wTdUZcS+usywKTUlyYpXVWDpMGNcWBsAtKlYVqUJeB3vfS9H9cIvPwhPPr4n5z4oacVV
 Ido1w/v+jGlTS4HqrLGgt4izZ1jcQXGEdYjnmeakgBX2z2c6iwAYTIiy9l4JZPuHhCrZMMmoRZt
 xoSO+O8sIyY/Bpi+bX6G4RIaqLxvJhNDHAFySQoXIvj+2wV3x66aIz3/yv6IItgJ1EG9uGeC/vG
 2NwBazdhXAgQroZ2TQFhZiBAzyyPGwUIqE8X9FLe6XksSPh3D0Yskpr9h4fp6enMqKMXvmqpxmN
 5FGEEyNkO10IYXazqz7ECS8MNV8YCpogDdn+C8S8pjMXgbon7LT4nblarJ5Oeg0WMKIUvI9u51i
 fE+5k3N8Y0/fSGDEqIoKa9CQoqeT4MVlt+ROtCspAQhTsP99zH1HaE8jIlfdCkzHxwIqlN00V6J
 fMXmZYFEC10cPoiiuTA==
X-Authority-Analysis: v=2.4 cv=Fq4IPmrq c=1 sm=1 tr=0 ts=699f1006 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=4Sk7iA3Kb7Xp59SBBbgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250145

Use dev_err_probe() consistently in the probe path of several ADI IIO
drivers. This simplifies error handling and ensures proper logging of
deferred probes.

Each driver is updated by introducing a local struct device variable to
simplify repeated &spi->dev / &client->dev references, and converting
error paths to use dev_err_probe().

Drivers updated:
 - adrf6780
 - admv1014
 - admv1013
 - adf4377
 - ad7293
 - admv8818

Changes in v3:
 - Squash the struct device variable introduction and dev_err_probe()
   conversion into a single patch per driver.

Antoniu Miclaus (6):
  iio: frequency: adrf6780: add dev variable and use dev_err_probe
  iio: frequency: admv1014: add dev variable and use dev_err_probe
  iio: frequency: admv1013: add dev variable and use dev_err_probe
  iio: frequency: adf4377: add dev variable and use dev_err_probe
  iio: dac: ad7293: add dev variable and use dev_err_probe
  iio: filter: admv8818: add dev variable and use dev_err_probe

 drivers/iio/dac/ad7293.c         | 32 +++++------
 drivers/iio/filter/admv8818.c    | 61 ++++++++++-----------
 drivers/iio/frequency/adf4377.c  | 57 +++++++++----------
 drivers/iio/frequency/admv1013.c | 51 ++++++++---------
 drivers/iio/frequency/admv1014.c | 94 +++++++++++++++-----------------
 drivers/iio/frequency/adrf6780.c | 60 ++++++++++----------
 6 files changed, 168 insertions(+), 187 deletions(-)

-- 
2.43.0

