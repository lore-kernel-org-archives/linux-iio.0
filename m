Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C72F83A2;
	Mon, 15 Jun 2026 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504476; cv=none; b=uyGmJvpvoZhaflw5z7J4KBc2+WW6oge1ZLOyMpzxX4HGcj76mtupe/eiH+p85zDOPl2IhgnZJe0IZq1GQA01zLo5mdM6UzSMhQDXbSsiNX/nPSgWuG5XPkg2+mAAgmvBWve4zBTpyuQL1r8vS++G80vdQ0Mx/IABcLPOYYFAz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504476; c=relaxed/simple;
	bh=jFuM5C+IjBabb0VfDLYDd6JB/mZ5b5npmqYEpPug8wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rizOh2iAMHv+RekRwaM0eHuLNeHleXeHmDMpeQmhuHpF/Q6/vxZK4+EgPv1UuVdU8MnI+tNpmDTGduZGDGv/Id2Re2jTDsjbQWkemhdlfBPwYTlAXzKpifyxGvvFcwuQ0y3FczdivmP/A/o3iQ398Mouhf98oOIeZc1PU5P2muE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RpMVQF8U; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RpMVQF8U"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6K1aC380089;
	Mon, 15 Jun 2026 02:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mnqma
	exz0zcR9J6xnZf1AOICfDENQ5T/2HlyVWPfFg0=; b=RpMVQF8UVfP+dXS+HFFIF
	dp/CZlLKfQTUqnhn5H94/ogRf/d4bGzyXclL3gKH1SO2PvkokX3IHvRTfV/zygkJ
	bWpGsAaiV1sFqEogyXZZ+KC5utOI/wNu5e6TXl41CDYEdyQstyy7VrPmO22n/WFm
	GQWqMunVLrn591zlx9TYhGymWKWQNJ0X5vjo0wWTMn5yHV+2ENnwdSkWT6HIWOII
	LYHVrGtdnut1NhbW1j4iqZt1tCCW63ZAnSxxf/zgj2EtAJhQQl94u7Zp0Tb5WANZ
	jvtMKRo1nALDwCbk9XhJFjl7EPEqemrtP/d0ITwZx4dx8EwknP+l54x8r6NOth3f
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4esvwwa4je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 02:21:12 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65F6LBn9020925
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 02:21:11 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 15 Jun 2026 02:21:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 15 Jun 2026 02:21:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 15 Jun 2026 02:21:11 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65F6Kk5S014857;
	Mon, 15 Jun 2026 02:21:03 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 15 Jun 2026 14:20:16 +0800
Subject: [PATCH v2 2/4] iio: ABI: add DAC 10kohm_to_gnd powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-iio-ad3532r-support-v2-2-84a0af8b83fa@analog.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
In-Reply-To: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781504447; l=932;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=jFuM5C+IjBabb0VfDLYDd6JB/mZ5b5npmqYEpPug8wE=;
 b=gctGbtOvo6M+1RXOC7zKgQmDcU8wTxELyCv0Vo8SRiIfXKyJ8hICLhGpquXgirPRMKhanwVOD
 f+ixlYgSfQsCCLMt8LtQhM4iZve9sVD2yhhbOWOdoZw+Kku49cYgZAi
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: B6nfrMQDn5k_juZ4uu216upzlKVs8kQf
X-Proofpoint-ORIG-GUID: B6nfrMQDn5k_juZ4uu216upzlKVs8kQf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfX+EN0Xx415Wko
 5chfYgJ7MTazc36f6D07MvOSjDlOiFQKDzP8giPLrqtkvIkyfyp3aXvB2sr8bzGpVVXr63l/toB
 h2vpx4BEU/HkenrUTR8hi5J6gPL5NgzrvxYZKMj7rsyvstF7BCb8FhKxNRUtXGgcbb8wzrpVode
 0hMV0+wjmINNLTOFeVNaWFEb4L1uy8H4NVd19aIFouzLolRHiPKYSyTLJ7WZ9bgI52VkI8ezD0D
 Dyl6gEWpdVdEQevE1ZqBUwGkJIaIew++nA73CBsmd0NlpkXcrcZf1H4nF4db7XHp4b7UhX2vXUH
 QIPlFaNjLCmqIWyqdAVF2qX6PJ4J4snNVRi1Qt/lGqmhOlb5PQkBoHGF2z132HCX4olxh7i+hU6
 U99FsZOBT9T4HWrwuwZbrW4sxEp9IXxvoQLnuPkS3ad3a8V5Ady+0U+O+W8+kBtp1XLiHOZFRLN
 KLK/HaA/rFH2A8bgEDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfX0c0yXYrHOHW3
 Tilu++S33rQrzIkag0RBsD9qtKVYisYawh2xCm6eR63NCWJbAvs9t04rWDmcPu7x9pOVCLz4H71
 JkTHRogVJC1R9aUpN6lBNGIgJMR7X0MzJaFHSqt/lxxexIgEJoX4
X-Authority-Analysis: v=2.4 cv=OM0XGyaB c=1 sm=1 tr=0 ts=6a2f99d8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=c9qRhK4E6t9TYzrPtjYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150064

Add a new powerdown mode for DACs with 10kohm resistor to GND.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d8d6d85235b0..67446cd37183 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -770,6 +770,7 @@ Description:
 		3.85kohm_to_gnd: connected to ground via a 3.85kOhm resistor,
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
+		10kohm_to_gnd: connected to ground via a 10kOhm resistor,
 		16kohm_to_gnd: connected to ground via a 16kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		32kohm_to_gnd: connected to ground via a 32kOhm resistor,

-- 
2.34.1

