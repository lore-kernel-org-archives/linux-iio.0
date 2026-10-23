Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792758651;
	b=r4iEZc4zBF3YOvIzbkmva+zmOHMS3xYIIHqBht+IwGFPURqPN4XgAFYMP9BWP/3SBq6J
	 vdQGYEPQTUZnIET2Oe2LRJ10EcTudkFn5WWFtHPBx7glquv9abVXWKkJR4SHlqUQb+3lr
	 F6vQTwJJQDX0kxS8X9RupWkrtsBhnxKwaUFnZjT4YggGXia2uBC9rTgx6oiqk0bN2fWzw
	 DFkgFZwxZEbPI7MjxM9j7vH/vq3zKkD7US+5pa08kGHMZrZKhsYGsh61ieogLYsysNUMS
	 ztjaxk+L8yEQY75iVCawRWR406MytKXQVsb7blb7EWIYHAL1VLgNLHYsy+RAMq1AcHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758651;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 CC:X-Mailer:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Cbxan8DvN07hP/0nCs2ytc8AP+Iumdb6AQCfUPfZO58=;
	b=JjsYlcvP9Hb4Gq64C7LCIRjt41ypJLOsiEPS2NS/NL7M6PD9y1GfbNUALeQGzrG9vEMl
	 TTSu0pj6Mzxw8Bb5aVnoduZkpjLiDMN4zhOZHkhGHP1YOm29zn7NXzdj0JZamUhUZ17ZF
	 td5K4u1852WJSf5Fzf8Yulr5CY/UCmmH0wpM1qAEgyCYz19YDfekQJV2LPxMk930M7iSr
	 Wnqw/2BktUJnFemKLNfVOCllbOf5TV30uRY1r76A5drWc3jKozNTskzy69miseblzP1Wi
	 CmxXM86uxB0MwgEuggDmAuu5VXXegifwxUAegKJ9aORlMDVEbgM7FZ9/3xexergMa+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=GQ9z55xM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.41
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236B60A2608;
	Fri, 23 Oct 2026 12:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F236B60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=GQ9z55xM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efKwuNT8gzPtOS5BbZy1IrvHoMn5gpGpDlnyadv0nk+2Z3zX7kjY1VgDymNn7cGFmT8CJDCwkPSS8GGPsuX+Kl1o3k87gqplmJ4TRheSSRifZ9X2masbnnSQbJpN5Fwnu5KSw/6mDmDYtoGzyHTVas8asmqBFsi9Ik0E+/eJ5FQd4QQvzCtQijfsKQK3YfxE5S1QO3y9hWubc/12JFnAOwUrvRp1QoO6eFHSS9GUzbk2KFhOsg5Asjg74VEB6Hu6CQ62fVRSumbvKX09xNfykHi8EoPHvyw8Y+n3tWfyZb6gKSOQVQR1Ua6vOuISWP6Tgbv+c3FAL+Xm7lt3Qk7rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cbxan8DvN07hP/0nCs2ytc8AP+Iumdb6AQCfUPfZO58=;
 b=Vr7VF1cu+gvi6DoBMOpHUT5M3oXidUddDr69uCVa8ZANnqZiGuChVS2AXFqDHEjhKGCOYY1JfDRD9GPWE2fUbkVKb0ZZImHVA+KfAdxCg2mP2MQsNZqettZJMqr3VSnb50bQOJ5jXkGTMQSta8Aity52fiYPK9v5bqoCJmiG358RwkmLBUqG5dJDmPLus9rvbyF0GQZBifgP//wlFVbEo7ViV7Ml4vgmncTzG0WxjEK1Sw9jRIjH8ReJ3sQT0qvuFt8xEcpz7ONOJcCyrm82DCq0Wnh9ryKLLGdqD7jgm9rDwDNHbC7T7UFd62x+rF/0ls8gFOYpQwau77PNYPMJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cbxan8DvN07hP/0nCs2ytc8AP+Iumdb6AQCfUPfZO58=;
 b=GQ9z55xMPUt8XlQSjdMap/9H9/+AKMv0Etj0DxM92mLQ3ya+c5TbynpeIGwq6YZD8vsp1FYaJxgZwGPU0A6DBtp6d6RCViXRf4zviaj3AiKyy6KTFo6pgCsRn4IRwDtpOUJ/mwIkNhpmK6GiWgHtNwr0FoSUGsaZITZf2H0xV64=
Received: from AS9PR06CA0343.eurprd06.prod.outlook.com (2603:10a6:20b:466::26)
 by DU0PR02MB8268.eurprd02.prod.outlook.com (2603:10a6:10:3a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 12:30:43 +0000
Received: from AMS1EPF0000008F.eurprd05.prod.outlook.com
 (2603:10a6:20b:466:cafe::48) by AS9PR06CA0343.outlook.office365.com
 (2603:10a6:20b:466::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:30:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000008F.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 12:30:43 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 23 Oct
 2026 14:30:37 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 14:30:37 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id A9DA42C6F;
	Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id A19EE584AC3D; Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Subject: [PATCH v2 0/4] This series adds support for Texas Instruments
 OPT4041 Ambient light sensor
Date: Fri, 23 Oct 2026 14:30:27 +0200
Message-ID: <20261023-opt4041-v2-0-ee320812804c@axis.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGNT22oC/z2NQQ6CMBBFr0Jmbc3MQIW48h6GBbZFxkRK2kowh
 LsLaFy+5P33Z4guiItwzmYIbpQovl+BDxmYrunvToldGRj5RIil8kMqsCBFVU7aVprQtrDaQ3C
 tTHvpWn85vm4PZ9I234xOYvLhvV+NtHm/Kuf/6kgKVaGZy7Zii9pcmkni0fgn1MuyfACr04rHr
 wAAAA==
X-Change-ID: 20261007-opt4041-18315d8510df
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Stefan
 Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesper X Nilsson <jesper.x.nilsson@axis.com>,
	<kernel@axis.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008F:EE_|DU0PR02MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: e673146a-932f-427f-22ba-08df310174df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|376014|1800799024|36860700016|10067099003|18002099003|13003099007|261021121427099003|261021123027099003|261009223027099003|11063799006|261009221227099003|261022105027099003|261022075727099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Qvq7ygrs0ARqdDlgMtaNfRtbZ7aOXdNl9RS+QtO1jUzDsiHPBXMZuz5J1L94WYx0gCnY1lE0vp1uNsYod+SkI1gjKYWzhPcy9IqT54LWeBlopJC08KN/2Kmp2GrBechi+iSBAQN6iGRkT19/u31AWuwugoQyzVuGYCpUKWQy6IlbXXsph27rDdXOLXaERWQpoSdiVBmWiDkEKAze1tncOCsUkVeUnB5y1/6NdfQ/ku4ETaT24HINyR6FNSGLJIbt0JbiaajgF0OJsILnqtsURgEVPc17QfNHC9CFqPIQCShqFOdLDiRQUc4F7P6G0edgsDaEdkRCT2N9SIJgSHm1nkQ/kQw2l7ulARTj180zML2H5RWP/tPHANZuJVjlk0akslqAi5smNUy0A/GYWFeK/VivZP1BcnZ3lVoCTg/CVMzBEWaMrJT+3UDOI10ohgssDXwgtaP8ge7oPaXwaCwdxOoj4nXF92Cyg9WWpe70cJGygQ+NFrrFx0oflZTXzBcUKiptB9nZOWW0m+WDb8h6QA5TWhhMyj9YdFD/vcw6l1OPx+/Ty0Xc9D3KGPrQ4XRMPnxG02i/xWYZ2srn3j7mMEzxx4ELeLK2TiM0Mb12UwMHSbaowHKbdmm3CwQJ7LJE8joRb6DwY9NvrElEcjC2pA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(18002099003)(13003099007)(261021121427099003)(261021123027099003)(261009223027099003)(11063799006)(261009221227099003)(261022105027099003)(261022075727099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QmFU9zjIKUv3Mn3sqDLeEmGhBeCr8eBL8FijR/cVuNMfI6HwY/h3SSfoHCPPdwWxpcXz/M6EyLGagW/mAyw908zpQri8qRlwGYJCYLrcK39p7iU1ME9LbkIYIgCrEmonQyQBSA8JCKFFi1r885qjI44UifOCeh9ltuJRHWrIrSkXLX6vyKMHpVshdBi0pQws/bN6wT2jQL2VmHRim8zFqKSTpKNQBgvKZA9y9b1h5mphsre9DMU/wBxPen4OjPrG/JKxXY4prUVOOodSO+uOIrjNCf1UFytL/jbWwE6VmtddwdqzgI25TRLr1pHbIUTJTmNiNNNy5XINTGx7UYzYSVTqRE1zPDODmAAPqqstYR7Z7GIOg5AvQDnpEdcvRGWJKCZbzkVLlV6y2hg70trIfDTRbleqPEElWAeGFjJ/L4okthoJDqOvWBt0Dte9HEMD
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:30:43.5052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e673146a-932f-427f-22ba-08df310174df
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8268

Extend the opt4001 driver to support OPT4041, since it is so similar to
OPT4001. The OPT4041 adds a second channel, a wide band channel ranging
from 380nm to 1000nm. The register map is almost the same for both
devices. OPT4001 has an internal fifo of size four, OPT4041 has two
fifos of size two, one for each channel.

Since OPT4041 has two channels it has one bit in register 0Bh to select
which channel is compared to the threshold register. The driver does not
support setting the threshold registers, so no new support has been
added for this.

The OPT4041 is pin compatible and has the same package as
opt4001-sot-5x3. Although the device id is different, I added a new
compatible string since the driver already had different compatible
strings to differentiate between the two OPT4001.

Datasheet: https://www.ti.com/lit/gpn/opt4041
Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>

---
Changes in v2:
- Drop tag Assited-by: LLM from commit messages
- Include patch from Andy: Re-use generic struct s32_fract
- Add trailing commas to structs where it was missing
- Sort variables in reverse xmas tree order in opt4001_read_raw_value()
- Return -ENODATA if i2c_get_match() returns NULL
- Update tristate summary and copy the string to MODULE_DESCRIPTION()
  and to the comment in the top of the driver
- Change the help text to included OPT4001 and OPT4041 on seperate lines
- Link to v1: https://patch.msgid.link/20261023-opt4041-v1-0-45227f82d05c@axis.com

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Andy Shevchenko (1):
      iio: light: opt4001: Re-use generic struct s32_fract

Jesper X Nilsson (3):
      dt-bindings: iio: light: opt4001: add opt4041
      iio: light: opt4001: refactor driver to prepare to support more devices
      iio: light: opt4001: add support for opt4041

 .../devicetree/bindings/iio/light/ti,opt4001.yaml  |   9 +-
 drivers/iio/light/Kconfig                          |   6 +-
 drivers/iio/light/opt4001.c                        | 164 +++++++++++++++------
 3 files changed, 133 insertions(+), 46 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261007-opt4041-18315d8510df

Best regards,
--  
Jesper X Nilsson <jesper.x.nilsson@axis.com>

