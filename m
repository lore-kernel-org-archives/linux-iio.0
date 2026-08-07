Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7A3D8103;
	Fri,  7 Aug 2026 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093126; cv=none; b=Dyw5GyVyguBz5bDbBN6l5qmzbK0lFs6k44i7wkApBq5dBaCwV/mVVmMntp1w7mul9u/HsbFM7eCxbZZgIuWUEa9azJyng60kUYvU9Wo7VpOGNBjsyWXXv5BIVmqpj2TQm0MLYEnY1phs0y7z7OnXeoTmMmpvIsWhPMPZSUe5SYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093126; c=relaxed/simple;
	bh=mf5ScwRldBoTu6PizKpsedJ+VNQr2D8dAz939oRS66U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mY1aMUBpa7kxc5/U6XF21fAEq8yddA8AO6+D6pb99kiDTmxYl0IvjFSsI5UIh/PB7FhVNUAPIuxQ4J1Kca2Sw06m88BOHAaI4zWZsoulQI8s1rpj/LNunKkoA4n+ZvrpL1tyCRJFNK1JsrUH3DQI13M3QdTO7x3/bVNCSdOm9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sEzE3xgT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sEzE3xgT"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6776ZfoC752554;
	Fri, 7 Aug 2026 04:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=6TOpr5XZozoxPYLhnTbduB/0AT6
	Lu2XfbaBTqdkySpE=; b=sEzE3xgT/B70xOkS/PQygNZaEjy43cMN5FPE3RgM/mO
	MmfPIvJ9j2VakhHi3D/tdJolFSKEFDMDlzcLss9Oc/xWGfMllKQj81GOSmxBIKU7
	RToPw/8lQYphLkbOn+GyJhLRt63p3kB9FbSbxA6UTiPI++D9vG1FoLgOtqxcsyrd
	TU0A7qdsOidRpPV99FlfhM/KTE5ib7iutI3OEIANxGYkXLUYr4RVlfMqkysxf+SM
	Qc3WNeQflUk+i+QMvD/3nymurJ/+TT0crxLJtJ1jNqUObtdMGe31bixHjveLD+Pc
	UQTQF/g/7hd6HQm4RupUP0VzhQorOjen0xZayWhnDWA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvrcpwq86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 04:58:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6778wehC059711
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Aug 2026 04:58:40 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 7 Aug 2026 04:58:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 7 Aug 2026 04:58:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 7 Aug 2026 04:58:39 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6778wTrA022705;
	Fri, 7 Aug 2026 04:58:31 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] iio: adc: ade9000: series of probe and channel fixes
Date: Fri, 7 Aug 2026 11:56:40 +0300
Message-ID: <20260807085643.5502-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: Zt75LzenDy5grlJqkWYUIFIR6XnlE5mm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NiBTYWx0ZWRfXxWXF4vLzE3Pa
 wDbwtY5DxuyDIAjrBB4KcIs8KvXDIyDKAqdnSdoOdgCnj3dHaOk9MAhKdAvDU7TGOQNIpt21eAF
 PwvQkj2Z6F0xEEf6Lb1rPwIaA5THg065RqNZOjIfFOBwBWmTaxN8
X-Proofpoint-ORIG-GUID: Zt75LzenDy5grlJqkWYUIFIR6XnlE5mm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NiBTYWx0ZWRfX5+2TXu0x5w/S
 Ahd3QZ9bi8GrsGdHULuhktxBgXtpw7lIdiUTRjNE5u4aq9CwoKSoOlCtJl2d+LIH45sZwg+XRxJ
 XHihRHCBPkNKa9U3oiZhjsKFZDREXFhs/R47P4ZH+W7tJE6lSvT2e8aaK5ui8R5Wuur9cCqjb7t
 PJwojTV0txFJGp7hG+X2dn+WComVnTpveXZxIivwLJQxlWI5VrboVXObjYf1nnQN9JV5knPjRXA
 U2wNyJ5S5K4F+/p8hlorCw3noMksj0d+DpHAMFEJHVzF9ahSCIEc5GRd6ksLi4RkNwoZkVWf7ei
 aF8+AG/t9wzUwo1Fd4KpipUzmzmObbyV2x6aJwwhajBd2hAA4FhytmPaNhYmKF+d29E7JuMb6ut
 TSlb4ea10Rc0EUDqsKpMyyPP58CvhHdMLU9bqY4obD03ohQEdgbAN6FLjK7TmsfZCk+T/CJRFtd
 AJxYPiCRFor9WVcmZOg==
X-Authority-Analysis: v=2.4 cv=IPwyzAvG c=1 sm=1 tr=0 ts=6a759e41 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=xpfcq4rGskaNeJp9eGYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070066

This series fixes three issues in the ade9000 driver, all present since
the driver was added.

Patch 1 moves the interrupt requests after the vdd regulator is enabled,
so an early interrupt no longer runs a handler doing SPI accesses against
an unpowered chip.

Patch 2 corrects the overlapping scan_index values for the current and
voltage channels, which caused the Phase B and C waveform buffers to be
configured incorrectly.

Patch 3 fixes the STATUS1 event scan bound so that Phase C dip events
(bit 25) are actually reported.

Antoniu Miclaus (3):
  iio: adc: ade9000: request interrupts after powering the device
  iio: adc: ade9000: fix overlapping scan_index for current and voltage
    channels
  iio: adc: ade9000: handle Phase C dip events in IRQ1 handler

 drivers/iio/adc/ade9000.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

-- 
2.43.0

