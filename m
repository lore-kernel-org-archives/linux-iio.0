Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA63BB671;
	Fri,  3 Jul 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074621; cv=none; b=Xbd2Vcnh/A/91pjHSPr8YEL8p4wywIH6ioQkmMFYgIwDIwf8ZP/eQMgG1gkMZYTie7Zhzgjw3fRXtTzZrmJRPOFnMfjVvryXcSXgdZZ/0XlQNph1ozTDPsKL2kBvnCpyjriQDgdPKL+bHnDCHQViOPAOzCE8R8Ul/QAsB1NMIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074621; c=relaxed/simple;
	bh=3GQqdOPoPivj+Ck8+ngkS0l798UXERywJkMkJAz3q6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ppLQNkkp3+z6/OB+GtLhYH/7NwXHYVXRTRTHWwWC0Rb/NLrWvIp2XGXzuyqk4B+HA9jtiJos5rAOcRCpGrzTZ2jlmFJ/1pKAe188zBwfhHQ6RV4LuRUJUUgKWPQBP4Gyq7+7tVsbJI32PtpRYxvDFEP9UJtc2CbPkCfjR2JE5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FgXeDFdL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FgXeDFdL"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635vrqD370739;
	Fri, 3 Jul 2026 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=njsch5x3TVYB3665IfEalYahiFQ
	wA6VpTPXJJnklDWM=; b=FgXeDFdLKMi7C4ykEtVNY/2VYJek1Ap1vdq4lOjkhwl
	NzuYNYgmHiq20V61CxlRCLpPDmmATOuy9ze8SydCxSOjiLNV8ZNF9Su/sQchz/o9
	UrkgOf7Kdve5NmegixCnKRlC1EeWCrWOj0HxjWjswIJ7WbSMy3FbVLnfBtdVZ8Ds
	f1yb0yLkjcezn3Nl78ud0oJYzG3wXMsS5H5+uMcibromnczZNH71wjLETKmKYSmT
	ZMjtXocxYNcGUMWX1vmgGasroAq+rDCrmRZKZMyJjvkX9a5IlXKuP5RpNbu4lKWw
	O/Y7e+yhzWyZE+s0TQvyMEf+apQ1Tql3N+ACTti2dEg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f648x9rts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:30:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AUEIB012191
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:30:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 3 Jul
 2026 06:30:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:30:13 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AU1SK025379;
	Fri, 3 Jul 2026 06:30:03 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v1 0/2] iio: adc: add MAX40080 current-sense amplifier driver
Date: Fri, 3 Jul 2026 13:29:30 +0300
Message-ID: <20260703102941.1141341-1-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: o2rJLDvYEEHB05sT1M4hvWKjlbd4eTbQ
X-Proofpoint-GUID: o2rJLDvYEEHB05sT1M4hvWKjlbd4eTbQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwMSBTYWx0ZWRfXzHPDMDCHtjq1
 zV10bi6liqx3M7fAhQk2e0tSLRlqSRfbDGZmHeV1PBt+02Jynl14s2t7m4RNjYWEWdtEY9XnjrU
 /aZysZoD2jh6f/IANoLcyanBbilM0u+nRFDrY+FMWiX1nT3rjiBEm4ufjsaMfdUxGqF74AKyFQA
 /fmyUGFFGcvdWzrKkV5cDYeKhfywcjyuc/Un18PEFoVV2eutGiTJvT3jlBkhtqjG2FTRG/5FU7N
 wxGOiXFkQHvpxtc56KuY9o9b6H5JTP4AiHG55qtTTD/DrGXwodYvIFit564PKg9K8lskn/WsbNP
 AK4l+fP5fKtPd9XGjl5FIdEvle/hNtrBvNiJ5jZIKQeQWRbMQZxg16DF9WMbkp1koKaECGruGIx
 sFZAGTa34VxE3tSCIqUDRc9AEflgp/gSHL9KpOHCTu7MpBip84fMsL9kxboORmylAnEBWYsCzcN
 WaOUM2dV/e75eE5/ocw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwMSBTYWx0ZWRfXwlVjPRbUPUeb
 FMsNuQ26Nc2dCnawHIQXDOmggRvqpaFLHx0ZB+NOBG69QWH5xPPY4HlBFRf5VYRLu4igEzS/wOH
 9NTK5jkCWNDg+HHVuJYQg4lp5zkppU86oBj958VyubtFDW9Vi+LW
X-Authority-Analysis: v=2.4 cv=Au3eGu9P c=1 sm=1 tr=0 ts=6a478f37 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=OGqDcEpPKfH9cPnAXqQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030101

This series adds support for the Maxim MAX40080, a bidirectional
current-sense amplifier with an integrated 12-bit ADC and an I2C/SMBus
interface. It measures the voltage across an external shunt resistor and
the input bus voltage.

The driver operates in direct (INDIO_DIRECT_MODE) mode. Each raw read
triggers a single on-demand conversion (SMBus Quick Command) and reads
back the matched current/voltage pair, so results are always fresh. It
exposes the current and voltage channels with raw and scale attributes,
a configurable oversampling (digital averaging) ratio, and PEC-protected
register access. The two selectable current-sense ranges are exposed
through scale/scale_available (the range is chosen by writing the
desired scale); the current scale is derived from the
shunt-resistor-micro-ohms device-tree property.

Continuous FIFO buffering, threshold events and the alert interrupt are
intentionally left out of this initial submission and may be added
later.

Tested on hardware with four MAX40080 devices on an I2C bus.

Patch 1 adds the device-tree binding; patch 2 adds the driver.

Stefan Popa (2):
  dt-bindings: iio: adc: add maxim,max40080
  iio: adc: add MAX40080 current-sense amplifier driver

 .../bindings/iio/adc/maxim,max40080.yaml      |  55 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max40080.c                    | 587 ++++++++++++++++++
 5 files changed, 663 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
 create mode 100644 drivers/iio/adc/max40080.c

-- 
2.51.0

