Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108688;
	b=PNqLUmC7iCYuFdDUrTxKJIP4IejPVXBRs3Oz48wGvukUFTfpxsUU3s3XyDiIM0TJh/v5
	 b5+Map2Ih9FLgCNf3+xyHT4QEUwOzuxLdu1ZXCEHaDPubznYTSqWhAJ5qD3XDxbT1xbIj
	 U91d16P6vZUTYbeyN9/uhdZIo5eGUmdFmXLQyFpb13UMZhiLSOPK+ZyY8zjb4uouLLutP
	 nh+nM3P+xs+FNs+jk731HRbezOOuefQzuYv1GnDSLSNCyV5QinycGXTBdWDsGZ9vw2GHO
	 qk0K1utTcEHRD3pmrZ716Zcw9tlwGDomtYuKx4lABwEG7vWFswHVmMCe/YBIx7MfujA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108688;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FSelX1DXeZ34wltl4hnyDZJzfe3lOpYTnObA/WQbkb8=;
	b=i/Z2E2kcEmYfO4810kGqHORB/PgjbJjGpdLSI6//xSJGeeKHsNnpBk+uI86fCttYOfyW
	 VcGbvQknHBNsATyVF6KLsV9wynOtQ8LOWFK6eFVF5OQ9VJ8OsQwdvxSanZJMLQRQy3MBk
	 Vm0NdbPs2ZUmy4fhlusASXYFOX0E4fCQkpf3KbOHgh492Rbd4oJtEBQHyeJYyUvw3lPGu
	 7GQ4xQ6MCJTSaXFoVbj/rkbDhHi/Ox8x+fCH7QMU302T5nGdtJWQPaY7Z9HI3RFnSYBQ4
	 vSIAwNhKuYfXHauQJ4nt9PnvLiaImsqc9F274m/W1JAcJiKwS10Cuhh7xLPCOZkG++w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=aiS21hNN;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1EIUXxKs;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442A606A31B;
	Tue, 27 Oct 2026 13:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1442A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=aiS21hNN;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1EIUXxKs
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDRKRW490055;
	Tue, 27 Oct 2026 09:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=FSelX1DXeZ34wltl
	4hnyDZJzfe3lOpYTnObA/WQbkb8=; b=aiS21hNN1WAW85VGOMlc4aYX/8TZ0NIB
	hqSPv/glSTffbXxVUgoT0zqpjmQbu5ncdiXe0HxFpOIA3emnoMCQXw2H/5lv/Ksx
	wbWUm9rxyHv3FPMNuaI9Unr0OJQ0nmwHCBYDgE1h6Fz65FsWlAPwN151NGuN4dro
	yLqgZR2ap8wn6BRNhi3TmXqCjPzQSaalEUT4WT0eppVvet+93DjP+rYo9MSvXvTD
	34xxDJgBMnkkisdWLSQa9Qp6TIEUeqEnl3sh+Cn3ktTdeWMbUQ83kK375xlIEg/9
	oy4xPMIsz7bUwJBemgomtFQU3lw17GCKbqxNwSfV1lB74sH4/3Gxww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=FSelX1DXeZ34wltl4hnyDZJzfe3
	lOpYTnObA/WQbkb8=; b=1EIUXxKs4VJFU3RJZvbsDk+MbbIljCGoiDdyCzMKK6t
	gF+lxAzhpC1Up3DJ1DowBUiclfnmMhkPodPLXXiApxr2q56UzPWzXTerUMgb+03K
	nnjWkmEuMlTBr3Y/MU965c/PUD+FOZfPVe9ni7PUudhkbZ52s2Cl9V2pBMvj61fZ
	qOQ+vzrNtHZvo5MI+OsR34LEbIfw4KiaytF0umNnNsTMwybmHlx+cnOjBOSWJmKs
	Jl2dFYpF/C0VuRCQlNd+eu3aiGbWs0WNGfXnk9oVtK+EzMc8IsV4BNELL6vLvtni
	gVUtXkN8eI/Ahq3kBlVYIyDZHUeZx7etRRAdc/jSi1g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hjqj81vh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 09:44:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69RDibgt039577
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Oct 2026 09:44:37 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 27 Oct 2026 09:44:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 27 Oct 2026 09:44:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 27 Oct 2026 09:44:37 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69RDiPUO014649;
	Tue, 27 Oct 2026 09:44:28 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: add LTC2387 and ADAQ2387x support
Date: Tue, 27 Oct 2026 15:44:07 +0200
Message-ID: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bLCDs/+Z c=1 sm=1 tr=0 ts=6ae0aac6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8
 a=QsWrtFZefnq_ch6bf4EA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: xIxxDTYMy4jjHiD5PTQa5MaACnhU4w2H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX8GlgHAZeVjh/
 iF89JYT6dlltb4OJRUuP6OQAZGF7vyrpTa/h2cO6JxtWMbpkrT1fPfdWVrERPdMcKdM/1GvHust
 uMHBweAlnvZNjNzjvvFYRC/BTI2jjnttljqxZ8U0WyeDYZLVviEBaeM4s84CAiv/j3sGAxQtXzV
 fp0H98qk47u5BjLVs8Ohs4gdn3NkMEvQAGEkCQRIezSr5dAEIL86ehuoAJqQj9cvSlGWlMV9Z37
 YyrE1I5CnSSaKlV10h3UgplqIiwUmP3j9TDgRqvzDMwTQ+01GkUq1fm2DHoNO9i/QGGY1bpQowK
 otP5Zi+OSQamYkS7upW1JvRsvAMD7FIVEgBE1SjkqQbnrtofvDqTpR72JWICecPoECsQ2WV5+N7
 yR2Rkmvc+HpYxhoCiPuIFgK8yXufu8jXER1gON8DQnsemrkZqCTyhQPOfgp82DaZOm2qxHoAgGR
 hYlUtEbPdwP+5fb/Sig==
X-Proofpoint-GUID: xIxxDTYMy4jjHiD5PTQa5MaACnhU4w2H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX7opiVJN5yj4I
 YPS2jqdKdKReKKjrBXj7DF1Ixjm9dkS3KVI6tZ0g9Dlv7Uhp9s/4HIJ08zpQupf02kvGqnl6bou
 VOPWKnZ4Z24IYoip9Rwn6XrnB8Sj3jmPoc6TuXC7v50eKUjW57YN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054

This series adds a driver for the LTC2387-16/18, 15 Msps SAR ADCs with
an LVDS data interface, and for the ADAQ23875, ADAQ23876 and ADAQ23878
uModule ADCs, which pair an LTC2387 die with a fully differential
amplifier front end.

Conversion start (CNV) and the gated LVDS data clock are generated by
two channels of an AXI PWM generator. Sample data is captured by the
AXI ADC IP core and reached through the IIO backend framework. The
front-end gain of the ADAQ parts is described with adi,gain-milli
(fixed at 2 on the ADAQ23875, pin-strapped on the ADAQ23876/78) and
applied to in_voltage_scale.

Tested on an EV-ADAQ23875FMCZ on a ZedBoard running the adaq2387x HDL
project in two-lane, 16-bit mode: probe, in_voltage_scale,
sampling_frequency (writes, rounding and range checks), buffered
capture up to 1M samples, and unbind/rebind. The bare LTC2387
variants, one-lane mode and the -x4 variants were not tested on
hardware.

Datasheets:
  https://www.analog.com/LTC2387-16
  https://www.analog.com/LTC2387-18
  https://www.analog.com/ADAQ23875
  https://www.analog.com/ADAQ23876
  https://www.analog.com/ADAQ23878

Evaluation board:
  https://www.analog.com/EVAL-ADAQ23875

HDL reference design and IP cores:
  https://analogdevicesinc.github.io/hdl/projects/adaq23875/index.html
  https://analogdevicesinc.github.io/hdl/library/axi_ltc2387/index.html
  https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html

Sergiu Cuciurean (2):
  dt-bindings: iio: adc: add lltc,ltc2387
  iio: adc: add ltc2387 driver

 .../bindings/iio/adc/lltc,ltc2387.yaml        | 138 +++++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ltc2387.c                     | 482 ++++++++++++++++++
 5 files changed, 641 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
 create mode 100644 drivers/iio/adc/ltc2387.c


base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.34.1

