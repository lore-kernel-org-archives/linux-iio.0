Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF013793B0;
	Fri,  3 Jul 2026 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073457; cv=none; b=GDz5+/YK2HZDd0OXIZSmAhKyW3Ph6RDoka0NtLLf5ituikOLicoz/44kzo0zvFgdm5ylcN4IqTjfeH0/Wpm0xm1sOlrxoo2I6Xim1PoTeXPKhO8yN36bwI5tUz7C7c1I9m1Jf4RO3dllfDotDlqQbJwhUFI+yzg0l5STaF0HRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073457; c=relaxed/simple;
	bh=x9UR8siIKA6bnwnWLZFTIbHCKZskbD2YgEM5xG+8hII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cFUEHoFqo0ujo9ARXCvROuQrHBUpRS4XYXF3OUHbGKxw+i0poxi+Q+57r29gxC2JPmW5fbZDeYfieDZ9MfnsymuzxWON2N9jmcrbxpu8mqDhyyszrbcvf2XDIpfnB56bmsAcMCdUHpTXE4ERiKbZtAueICMBszHYhhV7a7jZpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=x85s9ego; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="x85s9ego"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663A36Yw781752;
	Fri, 3 Jul 2026 06:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8bIBR
	yREFxPiZ0+qJhBjtcsvIDzTnaTbyQKPPzVPOYc=; b=x85s9egoKlT2yuN4349xY
	qLsOn8g8u9Z0K4L+5rRwr7VdAmbzQ1/AC2uToMAYmTJlCeswU9py/9MBV+nP0wvj
	oXvfYXPrfzJKnsO0NDguoqBDScK7f9ZBkCfeC6cCsBWMnso0HYzWePUO/Mgw+i++
	piKvdAbbdEiNM+KEzlb+9k+9MRCKOysmNUVeBM+rkqhz0Z19s5pMkI1aAKNP6O97
	6gBCt3L7UXtvwCuzlP/+ZqmpjOdWLKMP4enFOFkeII0aS3ha0w6YqkFzvQmaFGrv
	Ry2QDOO3utC5z1ssWPgbAQDFj5+mLbMeVH5ciXp/ld5xC0Yk0BVrAOU55YOv1VwR
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f656u9bc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:10:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AAeHg011009
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:10:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 3 Jul
 2026 06:10:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:10:40 -0400
Received: from analog.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AAOlF024695;
	Fri, 3 Jul 2026 06:10:35 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 3 Jul 2026 18:10:06 +0800
Subject: [PATCH v4 1/6] iio: ABI: add DAC 10kohm_to_gnd powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260703-iio-ad3532r-support-v4-1-69d9a336f4e8@analog.com>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
In-Reply-To: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783073424; l=932;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=x9UR8siIKA6bnwnWLZFTIbHCKZskbD2YgEM5xG+8hII=;
 b=LbX6+tbBtsznzzKFE+Y7A4HVcbXSJn4Y87hP8tlol7ehnhFbsFRFjtwEP6aLDdoRo+Fl4OJpS
 t82jGB+Zd4tCaSoagZefGLmm9Sv+ceRGNdGEELDT9xJnEnkyM++0C2q
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfXySARBxBZVbWU
 GGdkTUYXV74pqdBRVng6cASpaOVaECahP4QVXniWU+/TOnOOpPXa+fx4nvHV6K2b9IW+R63X/k0
 OPUjHEnMpEURiilu0iXr0BFToij/1pcflaZy5Nj9dQ5KolA0ruBVSHTiLiidjs1Hlbwp7ppAOoU
 1Jl9Zw2j+/3cQv1YlI5i0/kY0OSQOCLdc3qkqsBtcaWnu5031KCDN8Lg4+u+WPtLphJBiErUmdG
 Y/VseIpFpB98GGu2z3U23vdOhJWEHrpRUYUvdYV2fTmAXsFIY4CanaDpVcEeJEF7in5aPJkFESj
 1nLNo/+DU59TW4bp68HXYDXZVbPpttT0EcnQixAUvBPCMNN7xPRaSDWPmNEFJyq9yFDzTFkJDzK
 iZiXewVyibWpa0cEvGM8uLNax/2PHcXX0JkdteO5p07VfLSNz3isQZ8wxrMO7V5ympwdLR1dv3K
 pO+Pjxp19AzeCslllYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX6WN7J/ylUUa1
 PNtHVTmnIPFLj3ePQiZaYAh7qE9hT94OiZ3kOuISuR3yM1ITjv/w46gGJVdV6Trk+OXYumOUxkj
 YI9qBAby2uTrMoQw3EnE2tZEWmWpKr7XIaM2HvF6BBcYBN+lmO1/
X-Proofpoint-ORIG-GUID: 4tB_0kNYwoObgoK-Zz0K3iYySksOe3_w
X-Proofpoint-GUID: 4tB_0kNYwoObgoK-Zz0K3iYySksOe3_w
X-Authority-Analysis: v=2.4 cv=O4IJeh9W c=1 sm=1 tr=0 ts=6a478aa2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=c9qRhK4E6t9TYzrPtjYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030098

Add a new powerdown mode for DACs with 10kohm resistor to GND.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 4ea5598e7cd2..5cc2e82c4997 100644
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

