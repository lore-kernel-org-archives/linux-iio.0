Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88C46F4B0;
	Wed, 22 Jul 2026 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706910; cv=none; b=U0qr4dEfbN2RyJIgWzbS4JXlMrrv0cEpU+HOfHNclMf2goX8gXfTt3y+x/JhStJty4L1Eyt3U8Kzcwmgv0cAjSFmGs6/bvQLMPR12dFjDUX6WOvz0pIssJ+Ke8mXrvzf/ZtxKsOGibCU21MLcZHNYBuhjxmCBPiFA88FliiVAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706910; c=relaxed/simple;
	bh=3J7N9soTMmWfoCNil7Y9MGV2F45jVcOsfTiAbTEL+0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PbFEwlqg0SZY+eKO3Aw77dvqE8dQFlcmrV2DM0QshSkZUB6g0YUW+/4ocwxLLuV+7N+RsNYqL96qFhdG3JpdeMUZ4Tkoul7lDbM4L6cQyAfpkZjTKfRWvLLwQqHBavWcMXBw7djVWMzLhJFOQ/nA2HBRFIX4R6Ug4XEsnVi0Dvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Sx9/Dox1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Sx9/Dox1"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53bIA2674609;
	Wed, 22 Jul 2026 03:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IQx0+
	iK1ChybNdB0rqEEQQkDA6tDV8laf/gvjJ+X66w=; b=Sx9/Dox1UFissntuf5W8f
	tIjiH2lX0Qjv/NzWX0pIvM2nIdRNTMYk1Of24Sz8cZxNrBLPRczTRkBKhIqKxKBS
	6AOHJlgkcA9WI+314MWsWUrPVRlbzkLS1r8l6o7K2F4UlggGCf6kiPdJqR+Dcu6b
	SRwK80/TOzDE5IU01QkMv5FgpjX/V+/BOY8gvWAIENhKSk8kEkDsRPTZ2gBSfmkU
	gjy9eu4QpopgcJE9KZk18mBIzY0CaCeViIofCsHw5TQ13X9BDFmneOLH8WtkbUbC
	bW0VYB5Bg7K5afO68szAh2ivQZJJA6kkLROGS2CFltBTNWMTcXG+o/Sc0BrcbvhT
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fj6v4mqk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 03:54:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66M7sjK6060594
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 03:54:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 22 Jul
 2026 03:54:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 22 Jul 2026 03:54:45 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66M7sK4m006639;
	Wed, 22 Jul 2026 03:54:37 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 22 Jul 2026 09:54:13 +0200
Subject: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
In-Reply-To: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        Marcus
 Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706860; l=1276;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=3J7N9soTMmWfoCNil7Y9MGV2F45jVcOsfTiAbTEL+0c=;
 b=F+VNk3ucpHYs14hrJUuuNMn0dCNLDT/kBwW5VG8of9d9iYc7nyxKI1vARwP2CMKdpO4DyY1NM
 XXxCqArZUsMDvXmLwnTxMT1yniEFMunv/uVRB8sG7jZ8gqllVFqlrM2
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=DYknbPtW c=1 sm=1 tr=0 ts=6a607747 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=p7DZuduEnTu05McJuzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: I5UPjU81q7w-kWLYIo8LS2wn4MQxWDWb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfX29obemY9t/Qy
 Ugf+J1k8szveMkffojvK+QoF6cOKqbvipXwSggZWMjHJw1MFYpdUmHstV/RoIC97iRUB29QPySz
 /05njSeHvMIN/4lDizp/tcqTA/JLx2rlHdGhVVsscVB8zPIHSc5w
X-Proofpoint-GUID: I5UPjU81q7w-kWLYIo8LS2wn4MQxWDWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfXyIivoWEo8o06
 OopcbJwVoqeIKs+jUTpvuN0wGSRWBlwrPbDqtUeo0K8aSCzECcsTnxNWk89lD4L0jeXQOigvLq3
 3A25ItFEjgITwnqSlJdbEliGCvWrVyDtrYDGZyvdtHIBRtL4PDZxyKhtbP/E0NEYKTga+Wq6pxN
 zuo8UZGFZSNKhziFNcjy2MrjPEE3mHOgJsrm7iIfdw6KJMuEcJDMuWLGGn/rO1zb5VwCeDR/BBF
 or3D5z0QYbIbxkFMxKAYIop0CMGEyu5cDrEjqDr1V4AZPO9Vo4JfMaVFVpihAZuX1Y/9EA6Jt9Q
 Q8f+ppZX8tAE4bJxUtYBlZb6dWg82Wn3bdsgyNHfvaHvVhEHoKJsnMiE76gGElV08OY4h3WnrQT
 pV44f6yJG7kRHfjAcUtM0WmcM1oFrZkttGnp4AQsjq6DpVImmNgW5LZewBQmIVfNZP+mpyXMRwp
 iAV7hxYcPaWnNjs17mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220072

Some SPI devices support sharing a single chip select across multiple
physical chips by encoding a device address in the SPI frame itself.
Add the generic spi-device-addr property for describing these hardware
addresses. The property is placed on the SPI peripheral node and may
contain multiple addresses.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..b59d047cf117 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -142,6 +142,13 @@ properties:
     minItems: 2
     maxItems: 4
 
+  spi-device-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Device addresses used when multiple peripherals share a single chip
+      select. The array allows one logical peripheral to comprise multiple
+      physical devices, with one address per device.
+
   st,spi-midi-ns:
     deprecated: true
     description: |

-- 
2.43.0

