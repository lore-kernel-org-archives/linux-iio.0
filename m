Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524D453A54;
	Wed,  5 Aug 2026 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931223; cv=none; b=Twz3WLxElfZedunctiNerL0KndXnxXFUvi8yElHXow3duKg8aQSLCpXqkqIUIjnixtDvRDlifjb3fuAVCEufMjAsf/R7N2fQ6OVpUtFmOAsHKsJrgC9tmsFGjrrphMDI/EOd64h3wgwiDygTCCwTh5fd7/gaUq91oBz88jfgRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931223; c=relaxed/simple;
	bh=b7otmni9aoOFzUMCWl9ouWtfFGrnKm33Gjf703uM48U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SoVcsYi4c7tCq+eP03c7841hGzxoHUEW27SerZy/0vGWO8IKluAAizJjFWgXGrkOy9QGD5lWJVPseuabdj2FheA9UeS1zR2FaRlOxsVgoIhdF0a81mfbnCKPP89q4A2FYqEsISgzfAvOGuWdaGmQqx1DVopA9F1KbTkxphLAXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=chbGYII/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="chbGYII/"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758fLdI413462;
	Wed, 5 Aug 2026 08:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=0OcGq2SbnoRRrbUhk5Gr//V7jXE
	f3HGk8CL6Z/VO33Y=; b=chbGYII/Opolx6coL6UZS5hLvHgldCWGNp9ZtYUT6R2
	GhCz2VNCmTEMy/d2VVFS68GyCYbur9lOTbnMiB/TznaD1RT+s4Cxztl7Is/GyHY/
	AawIX185h4utOwuY7Ki569cR6jpnP+09zlTGuVjD8PSAmfEVkEQnefTH5rjDV6cB
	J7k0vOxKG+EQnwsV6oV4VhRxKT28aJfYd9IXxSDp7DRCEph/bdpVfJYzfrEEZliD
	Xvm3sjMhr38h9hUF15lqUR/jo68AoqZueQf0AxTBTvdm3zXF/uaJJTDB2VUu7+QV
	m6qMc33/qBpaATe2BtyVrooHTix93CNgAdP21AskFiw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fue6wnu4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:00:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 675C0Gp4016157
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Aug 2026 08:00:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 5 Aug
 2026 08:00:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Aug 2026 08:00:16 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 675C049l000726;
	Wed, 5 Aug 2026 08:00:06 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/2] iio: accel: adxl367: add INT2 interrupt pin support
Date: Wed, 5 Aug 2026 14:59:50 +0300
Message-ID: <20260805115952.33894-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=SdzHsPRu c=1 sm=1 tr=0 ts=6a7325d1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=LHrYOUlWEv7JUqxRrFYA:9
X-Proofpoint-ORIG-GUID: 9uIPWUTvQ1FC1TAl1sr2SZPe1CC3YLTF
X-Proofpoint-GUID: 9uIPWUTvQ1FC1TAl1sr2SZPe1CC3YLTF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NSBTYWx0ZWRfXw/IcPeyIWYCH
 i6cQlmVy4GikNFemirlNXMTGGBIBUq71UR3xSK6VfoF3RKPF4xB3yhYnU4fSr6B8DQDELCCFtA9
 HF7cEowbjwaZecHD7q0GPF10x//GjQzX87AJ1nhHzW6R3UtIUKvOTvTxJ7XJNjzfc2R3sDV1Wb/
 yk1zpioCeg1uIpaTzRBBxNMqXnK/clnTk2WaQWHQiLvQE/xH3N5YHcFdJ82Sw6bl7TUcn/bEEcT
 cLls3Bp6R07GY+Pvxs0ZYncYW7YDhjYFXomqaRhUeyUOJ7PdIswUPLZgTcllYEdtkw1ULPuFI4U
 p4KM+cQgOA6rVEIcQgiqXjnfJ9XdQBFVF1RMTvjde/r7llPDjixYIs2pvec+wH5m7bTND2JwkrN
 gOPTQPdiJbGIuubJ3GH8/SJN5U8X+/wvkdw8hbzA0kPJ6I40s6Jx8f1cZa+9AzHeGeX4hlIFT4x
 MEGMkTWg2XVXUrM22Rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NSBTYWx0ZWRfX9sBK2IiutgF1
 09arQ8/6f+njYNHwDi8rXjf2zAGcx61aLFnG/91Mmlquj++KfTub97mid0yf8gDQlKzdUZvNHow
 I1AZQJrzOhlwAEfFPhxvmDmm7eOLIC4qOS7nHZkdZdQczZ+R/niv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050095

The ADXL367 has two independent interrupt output pins, INT1 and INT2,
either of which may be wired to the host. So far the driver hardcoded
INT1 for all interrupt mappings, so a board that routes only INT2 could
never receive activity, inactivity or FIFO watermark interrupts.

This series adds an optional interrupt-names device tree property to
describe which pin ("INT1" and/or "INT2") is connected, and teaches the
driver to route its interrupt mappings to the matching register
(INTMAP1_LOWER or INTMAP2_LOWER). When no interrupt-names are present,
the driver defaults to INT1 to preserve the existing behaviour.

Antoniu Miclaus (2):
  dt-bindings: iio: accel: adi,adxl367: add interrupt-names
  iio: accel: adxl367: add support for INT2 interrupt pin

 .../bindings/iio/accel/adi,adxl367.yaml       | 11 ++++++-
 drivers/iio/accel/adxl367.c                   | 33 +++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.43.0

