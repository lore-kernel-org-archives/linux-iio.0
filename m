Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769F314D23;
	Mon, 16 Feb 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254717; cv=none; b=SGtNVmQswmBGv2Rg928pWOuARMtBBtv0XsWaU9UVDTX5FyowVp/7ItZUWjZnL+r6Gd8HYX/fWQdjvNzfAT9oYOsItOq8uVtsuGnVECc+gHMa7OpsIks5cp5boggVltSPNT7wllzPY+jtnwU3FZeU6l6JWbfudSOVv2mTV2ahMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254717; c=relaxed/simple;
	bh=V2UhE7AQ1pweQO+m/RqdrE1U5kBNKnDMgrzrQXIip0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fv6nDqSa0E+3BhPoPSrqEZ4eK3ki4sWs3bTxsQbddnQYXN41WkWKK5ZLf/7Pl6S8v6eS/o62TDbF1MVKYLt1hvVLybFw/V9qGv8l+K3Z7mjuh9BxGx7GHR0ztnT2dVfJzahXGpg+47kkVFzCSpqmuIw1lvPs1iw5o8eY7IO9DcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vVElV3yP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vVElV3yP"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G9qT1T1305905;
	Mon, 16 Feb 2026 10:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=m7sNZVihJxPVQjhrCP/BH/s5I9l
	O/zkYTuI0twVq/7Y=; b=vVElV3yPJowe/wpR0rEe9cGPd7D/uGqJtRr4A8AVxqM
	/VD4oFj04uManxDT8n4xwdH/dCmN1RlaUoJhf76ll7ADKMRlR7dkwRqcA6myMEiv
	ZUWImCKNJFiurfCQc6yWW/pvcryRY9y/e/zG5dp2GU2rn9zKXkJ8RmPoOlknG2p6
	ACVNThRgKrJGDIj9dYmzhxxlIUKFcAUb6qhXY3cYuTgFzORzBb6Z+qwsbv4Dd3M7
	E0f9M908Kx2rwwAvnu1dVzO14adyxjvczdld6RhBpolN4fHdZ8c/qvWPbx2Aulj5
	kvulu5cZX80aZJFxuh49epu3kg9LkR3tmIWsaUJ/D0g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4caks2g1s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:11:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GFBesC021583
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 10:11:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 10:11:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 10:11:40 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GFBT9B017396;
	Mon, 16 Feb 2026 10:11:31 -0500
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
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] iio: adc: ad4080: add support for AD4082, AD4085 and AD4088
Date: Mon, 16 Feb 2026 17:11:09 +0200
Message-ID: <20260216151112.139359-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOSBTYWx0ZWRfX06Q1V6arXviY
 kk+YHaS4p6YmYBgUnXfGKP7mdvzv40AeRd/xHUXzXzZ/vcj8/Oshqu6/T5ZfB6F82r6gqqXxjJ7
 bMJxv4O0nL+GS3CUuhTHFsH53XXAPa5VLeu0sQR2Woy/R5nK2elVmm5NqqNZN513LQuNziDZqrm
 8q8l6t7zR1NctaTGV+iMKBYun2aUEqsrUr9ztV/ectPJ7iAO9YJO6UwC99M/hv3FWSptJHq3Qx8
 OxGarJsp2P1hTebD7/0Mp8CisUgDDwmnzrv9wpDpYXBb+l3tSQl81wSkT6mgB4rAgFDFFCBFumH
 lFnHH+1B1SuoR6ZzVr/0F8lgqq/+LJjAedwPrgAvDHIuh/qi1/Qlug5ZpK/bZQ5pkyzgMmyNvyY
 oL6rr7QoOz9hiYHRelddwVaWgIpcmbZ7m9HJvSO2QwDocjX81xYerQUfcyLjiLKzzOhjkgzJ43P
 fje3QICP5MJ3NtNBv2Q==
X-Proofpoint-ORIG-GUID: 1J3YMqVVt6fo21xqGF1INjfNoIhQfJMQ
X-Proofpoint-GUID: 1J3YMqVVt6fo21xqGF1INjfNoIhQfJMQ
X-Authority-Analysis: v=2.4 cv=TYSbdBQh c=1 sm=1 tr=0 ts=699333ad cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=4GZ7O7lbiYnNbMRglawA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160129

Add support for AD4082, AD4085 and AD4088 SAR ADCs to the existing
ad4080 driver:

- AD4082: 20-bit SAR ADC with LVDS CNV clock count max of 8
- AD4085: 16-bit SAR ADC with LVDS CNV clock count max of 8
- AD4088: 14-bit SAR ADC with LVDS CNV clock count max of 8

These devices share the same register map as AD4080 but differ in
resolution and LVDS CNV clock count maximum values.

Changes in v3:
  - Merged individual per-device dt-bindings patches into a single
    patch.
  - Merged individual per-device driver patches into a single patch.
  - Collected Acked-by tag.

Antoniu Miclaus (2):
  dt-bindings: iio: adc: adi,ad4080: add support for AD4082, AD4085 and
    AD4088
  iio: adc: ad4080: add support for AD4082, AD4085 and AD4088

 .../bindings/iio/adc/adi,ad4080.yaml          |  3 ++
 drivers/iio/adc/ad4080.c                      | 45 +++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.43.0

