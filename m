Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BBA32A3FD;
	Mon,  2 Mar 2026 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454340; cv=none; b=B++Elvyw9OQSIyavw4i+sMiLV99pnRUHkRKVC4yxwCq6auOsHZEYoj25ybNBHEYrtkhaq0umntVyhNBBLrAokJhocYwxYhV2pP7yYhxqZEwyJaqkR8FVO51QNwEG9gN+1H26ADbh06wLMiC6z4a5WC8yU0bWQ/rAQ8pddaqZ9Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454340; c=relaxed/simple;
	bh=Fo0sVyYOb01BTRmBbM2BwsQRYlq13bQCTMA4C9i3IH8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QdKAZm/RCwjcLqgArbQXYp4Qjs3vrX07JurPjJGmQvbyrNLYWajtJW6AX1TZbg12HDtbrT3H/FxPoQmJ3JDE7I1SvhImtxsK3oHs0qQL4T47Pa9agrGXFOzYSwAGvK9Wb921PB4sjUKv7O+WeE/G50NCGBKnm19WRqv+q0Em/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uCJksLj4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uCJksLj4"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229A3gB3723204;
	Mon, 2 Mar 2026 07:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ff4TXrDH4/QUoHUXT9Md/3EQv62
	EoWQkHLrH3vdLygI=; b=uCJksLj4J5BYpZg+yBZFAJokEsGgduYABVW0OQv/fJE
	otpcZ0E4ILCV7FMXEfG4OBkYr7sHQTawhYzb+6g8HrOv/FxiUAD8/W7a0CbSj/KJ
	v1ZUjZ+/p36UUdtVlZfKHmnVYiii5ykqoLS5ZQBiGX8511reX8a9XLkpKndVP0mP
	8lEIsLyOz2tCIktcSkTJh5txxuGtPQS0FXif8ePsrlhVQdTVa1ZV5NIeXy6SDJTg
	HfmvjKpkzWtyrGoTKFW7TQLg6u3/UqY5uzqUzexlXKgJ2UVIW2hOaaXalpuH0cRN
	mQ0TzsslScW3MSIXPKJFXLxXihBowqbmkseL1IvhIzw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ckx546hsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 07:25:23 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 622CPMXn002596
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 07:25:22 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Mar
 2026 07:25:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Mar 2026 07:25:21 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 622CPAFo010646;
	Mon, 2 Mar 2026 07:25:12 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <cosmin.tanislav@analog.com>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH 0/3] iio: adc: ad4130: Add support for AD4129-4/8, AD4130-4, and AD4131-4/8
Date: Sat, 28 Feb 2026 09:38:32 -0300
Message-ID: <cover.1772078999.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: hWE6DtrFrN2S7FVrIVYWQXjJ9MBJrgDH
X-Proofpoint-ORIG-GUID: hWE6DtrFrN2S7FVrIVYWQXjJ9MBJrgDH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwNCBTYWx0ZWRfX66HQUtd5dIei
 ggJRVxOVFOfKa5UZrLjrvqgkRLMRyRj5HdCCMsbCYApTzPvblp5AtnqWz97qr7xm8YXTjgXy1pg
 O/X1BZdDhkBtBh6pZa2qISQQ5H9S5efBEnZOdeSSnMl4RgCWEqYnP4UpREsqBaSzZ972+CyeQjx
 PzZcGXEwlXXeN3lpZjmi12r1jzqNcss/NoiHQMhUWyW9JGG0nXPtmOg2PSXTyp/k27yIDjZ7Ikj
 YaCoATFf6GwaSwXwTRA/KAe2el4ALRGv3YuCATTKKQsBcwrF7M4D1/WiJw1YxQxRVso7UrpNIM6
 4AMDcVwATd9ue8LdhwS5eUNJRK+6YpFuLyQwxP83MyAyIrtIa6p+G2G4T91m5MpoLl52hU33dJB
 oMdQJ70tOiRIUBk74WvVdBLdYi6llbqdlt8uTZTrn5UW/kAah+PZ/qz8MsxYLJXcv91tF/qjKuR
 jdpByJ1H4xqcTzPGmJw==
X-Authority-Analysis: v=2.4 cv=HtJ72kTS c=1 sm=1 tr=0 ts=69a581b3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=u7VKI50liCD3fjHIDCQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020104

This patch series extends the AD4130 driver to support additional variants
in the AD4130 family: AD4129-4/8, AD4130-4, and AD4131-4/8.

The series introduces a chip info architecture to handle device-specific
differences. The AD4129 series provides 16-bit resolution with FIFO
support, while the AD4131 series offers 24-bit resolution but without
FIFO capability, requiring triggered buffer implementation. The 4-channel
variants feature reduced analog inputs, fewer GPIOs, and sparse pin
mappings.

Jonathan Santos (3):
  dt-bindings: iio: adc: ad4130: Add new supported parts
  iio: adc: ad4130: introduce chip info for future multidevice support
  iio: adc: ad4130: add new supported parts

 .../bindings/iio/adc/adi,ad4130.yaml          |  15 +-
 drivers/iio/adc/ad4130.c                      | 485 +++++++++++++++---
 2 files changed, 415 insertions(+), 85 deletions(-)

-- 
2.34.1

