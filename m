Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E803A5451;
	Tue,  5 May 2026 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955733; cv=none; b=T2WK694/7IR6IQeqzzNcCi/u2zI/06n/fQ5i/VTMkGwZGEaOAnDjZCXcucTmHSIQ+nYH/eXcKkfBxqn3/Ma1EOaKHkE7461/3vUrZoSw36Ql4BWQFQO+skMxoVpTkY+JkfXp6etjkaTHR+8/r36QFwVobLep+lmDgPpquyhMtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955733; c=relaxed/simple;
	bh=DYSJoyyIuE5os8YZ9pp+ajhcKaZ+2S1QC5sD1dxTbpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EnU5uSD4iv5aeCipoMsqNnkCzAMCIMd7PB/ZLPYLbgnI9lpeQbF8ExFkad6Gxs/QYuhE8SagctRG6pSIn3B8syvJG+vUDTCZZU/Rzq2YcF7TMzT3yeV6qmW25ukvxRof9bPDDSjtXlJwpQK85QReMi5PPCe/sLBNzyhQfbmw6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RmDRc38Q; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RmDRc38Q"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645108N7025457;
	Tue, 5 May 2026 00:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NJIqh
	y728s7lvf4u9owLu5rGyWFEdbZeKEjH+l4h82w=; b=RmDRc38QDgwvorhfL41Hf
	KfdTcmhWLCP3CQP9yF+X/Wg6WQ2W0JokPmxKMKdLybeyuUXdG7Q2TiDwZh7WOxW0
	UYFry1fFZYSUS8Bn9QT8s92/cnkt8hrEYOXWZ6xrVNsWMa6BamvBh+GvObKTVrkC
	WR6BKRMWQzUcplHiNfj5Z/2ltKHomDYN8g7aQohSWvwZJJDLaY5li0alcPOu8AYh
	l4zGRnOAbkyGVVJKaZ4RCE5sedcqafkCUz7RUxL3zcV+dfqMR55QlR6VQdex4YNN
	JSp+yQvSfUcHqQNwPnf4NSxe1yln1AqZjecuXfXVNlZbf2kU3DhJ919UHWrjm22B
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dwe619hah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 00:35:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6454Z7qB053899
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 May 2026 00:35:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 5 May
 2026 00:35:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 5 May 2026 00:35:07 -0400
Received: from 10.32.17.67 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6454Yn1P006142;
	Tue, 5 May 2026 00:34:59 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 5 May 2026 12:34:31 +0800
Subject: [PATCH 1/2] iio: ABI: Add DAC 500ohm, 3.85kohm, and 16kohm
 powerdown modes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260505-dev-ad3531r-v1-1-2b4cc55f69e7@analog.com>
References: <20260505-dev-ad3531r-v1-0-2b4cc55f69e7@analog.com>
In-Reply-To: <20260505-dev-ad3531r-v1-0-2b4cc55f69e7@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kim Seer
 Paller <kimseer.paller@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777955689; l=1370;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=DYSJoyyIuE5os8YZ9pp+ajhcKaZ+2S1QC5sD1dxTbpA=;
 b=qF03wU7H2QXrXHr43S9SM/OFwEMAOuRhmo/fVQYVzHgSLJURVN6q9dkkkAajttiRzicnl9SlJ
 kf4GLY3zYcuD7LLMC3+td8jgqx6tLQvH89k67dXOJLWkJXFGlnTULnp
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAzOSBTYWx0ZWRfX7zeGvqQxSXfj
 ddCAv6iAqslXJCY2PQTzJX/6I3sY4NM+AUkVypRgdFHERL9epdoFhjn3PO75+iFDmZ7rjgRi+pw
 PfZTIVcCcJHDtLsFnELhZANzhoxa2YLycKiZYwUayOQq0OwfSc9xPeyPGX+joSevKCRIYZj7XLe
 6z9aard16FvVbEZlVgHVZLMutFUT4FZ0JPIoQbHk8XGmhORN750WkC2UU28+qLM6eOOKibtFohq
 eppGkJo1aBmU7Ov4EJpGBq79MMVyfc4aIp5KR0Yx7/LABm4kgHYOxekIWnEhWgY8PZqx3U+7q6K
 zIfnNFkF39uY/bpZxgIyyqi4nDqMAhFAQGVP+Y1pURGThOenW1lbzswL/Z1vfzDdBcNGNagkuho
 rpEjrj/c8k21kZXBqaSskQfv4pru4nfVEhAbTPCnhIq322cAX74ZZ4iNXkWX5rmVKxT/tlzgXEG
 XKbJMKF/InaPlSBRlzw==
X-Authority-Analysis: v=2.4 cv=YcONIQRf c=1 sm=1 tr=0 ts=69f9737c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=yPQXUrJW-2Zv9Djg8wQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Rapm8XpTyQTreFl-NWFUPU7LrTNiElU0
X-Proofpoint-ORIG-GUID: Rapm8XpTyQTreFl-NWFUPU7LrTNiElU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050039

Add powerdown mode entries for DACs with 500 Ohm, 3.85 kOhm, and
16 kOhm resistor to ground output impedance states. These are used
by the AD3531/AD3531R 4-channel DAC.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 60dfeff8f2c9..925a33fd309a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -764,10 +764,13 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies the output powerdown mode.
 		DAC output stage is disconnected from the amplifier and
+		500ohm_to_gnd: connected to ground via a 500Ohm resistor,
 		1kohm_to_gnd: connected to ground via an 1kOhm resistor,
 		2.5kohm_to_gnd: connected to ground via a 2.5kOhm resistor,
+		3.85kohm_to_gnd: connected to ground via a 3.85kOhm resistor,
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
+		16kohm_to_gnd: connected to ground via a 16kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		32kohm_to_gnd: connected to ground via a 32kOhm resistor,
 		42kohm_to_gnd: connected to ground via a 42kOhm resistor,

-- 
2.34.1

