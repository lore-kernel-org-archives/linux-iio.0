Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2113.outbound.protection.partner.outlook.cn [139.219.17.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16E341057;
	Mon, 18 May 2026 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092357; cv=fail; b=Y4cg4UrAc/qkHKUl8VpUPoY7CwR+vweDln1DDFPtSD+yyr/TGfQ2FPrw7lBh3fRInhipkyFwyVsBwZOLA7ivGidC5npS5qfPWNzBf+CipeyZbl7P7cvTmDZRsLBi6JmniM4y+Rr/Q8nd/2NEMpsjdOW3ni0TFB7COzNsB9SRHP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092357; c=relaxed/simple;
	bh=Gu5aHvQzblXmHqDX7o+TAByIaXu7TtBtqlCxjRTKwI4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sIMdLC/QJaLsyJEoxdzy+Bb8W+trlPv5JW9w4B/LIPyqQ68A5dEaJJXhO0JtH0rAphvRubxYeEMm+tREO48BTNZBYP6aYuEyaZKhQz141SlhUQspocWBk9ZZWH7dKRnDBSrJ0SJXi5EUaM5oIUgDiWNlhUABszgSkKEIGSV6HBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HupkmPEkZUP/5MjGGjuECg+vNU9PiEb/raLmxISf6kn2yeUJnldrNZCJhh8232w/U5SIRTgKhtXxNtPq1L663DbOe+mJUer2GwAo8X+nIriFNqdnTNRGv7nITvCJjx9+ZmrqJdKpnniG879wkFY1zlklckbCz1+h723WV5tHX6zbqOBCWdqgZXg9teU8GpLG7zdG4D4suMH9LZusFIXb40SppTvAQL2nnUwL7tHhF4gOv8+6OghzgD/vRMUuNjXJKYAgtuT22PVRcARJtkgDVR0je3pMkUpXANIOxPYyHjSSyYkG8Bpybm1avbqBBz/bCIlQekrkov56w5Z1psnVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvcytlWwStyawa7aMTAyQe4haTVMKOPuEl13a3uKUag=;
 b=CmYiMVPUgXpGoEAj1hB1yihVPXYwifUaQlALmtWx1+b1BOBB8Z+iRlL38d6Il0Uy8o1MEzdi5u1na78YfcxDIgKVosq79I7PVFPc02x4SHbFagscTcRcb4DkkTakeGJ2/c9iXMCcaAoo8WPLUpkyJztz3bNPAbErIsI7vwDtw8PXM/knN5/LjmWR3wC054GMkPegRs/7DpOjTOS7omD6dqDtKmb5g8MiIZz3NgYpghL5FvYFEbZFSc1reMcaicL1leq0cexhPlGmobs9wBDxWKG1j3/47wuBjblx+VZRyLwnPmDDBfx8jhzlK2qiYpJUYMqEtlVNbo2uaLB4PMFcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Mon, 18 May
 2026 08:19:01 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.20.9913.012; Mon, 18 May 2026 08:19:00 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v1 0/2] Add StarFive SAR-ADC driver
Date: Mon, 18 May 2026 16:18:50 +0800
Message-Id: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::31) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1035:EE_
X-MS-Office365-Filtering-Correlation-Id: ddff6fc0-1920-4833-52c6-08deb4b61d1e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	+wrKek0ZrxeofzylSCtEyN7OD+NHfB3h+bBNoMVpEg/6WuogZePR2huS9ajKNix8XBSj+1eaIIXj8T441N+QPkOyg84s00gw9FUiPexGDm/N74wIYcovhOIOZyemSscrPVbJ4qGlvSzmBRL1Kvez9R/43YIb5Gmjy11WyQ1O7s894DAeWpMAQdobQnBVmL+ESo/40nxrpZkIquknvkvVD03iYGnidkoDIr/cyPPweuMeIwFvm5nk05WWDPe/oQUXjUHKqYoP1LmtNHGYBbONTEug6/wVdTkbSHM/qTq1QPph8FavviZmiYoSTAjp5RzVqCLUy8xrjA2XquwUygbkiFnC7Lga/65AIAfjWXNXpNlwSwt9MBMKEPIOPNJxVy4ax0mTm6BhaAdSI/0SoIFRxeO3gIrlpH4o80J8JCuObpidnqT6Ck2g7fwjN6fLlIloU/mQTXfVcN8rzMBpPeUdyoYle9UFJH40me1AFVo/YDK6ViQK0mtnielTO8aZ/bdbSf08ewy+oQoo1ai7G7ZOKVA2M2Ra3nU5fnM+19ye6/laroKWzePYoe0mJZy0xXR1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZbJ39YEb1ttyDjRejAahh6OKHR9HeRQbzA7bU8NjTmCH65ulS/8tzGXdJ2U?=
 =?us-ascii?Q?MYrXQ1mlbdQWDPbvWrr1DrRSJO3RIVJMikT9Ru1065HP+SfM2z8riERI3rO9?=
 =?us-ascii?Q?96NINkrGn2XGmr05EfzziyfC/6V81R+KpBehKKjjiSpatiKmpsIfu8zHlpbc?=
 =?us-ascii?Q?y2LxiKXhpKuB06yijHzuKbGnX9b/m+iSVqmYPrQX6st3dxjMAg75qOx18YjX?=
 =?us-ascii?Q?/e35o3PI372MzbPRBwGOaMQACKbg9EtOhHgos8xfqGATC0iUJHV6xnRlsNH2?=
 =?us-ascii?Q?gnucQJrn1CvuJw+X8CNLa/wmNG4xVeQ3wLjZqJh5aIc5JbEe2PPAC3htMTWN?=
 =?us-ascii?Q?ZcNrKb5XP+V6wF/x7N80Gd/R4SmnYF6y2Phkd3fxTDHE4RuaOZDOEZ2NqBEP?=
 =?us-ascii?Q?qTAfp8Myeyxw7Cw9IAiUEitHHpwNuiScFDuLSdvzjmo8XwzH4ajeenYON9vM?=
 =?us-ascii?Q?+ldLrXfs8nrhBakWj7KNvQWKWBuTjmVetUZPUb46cZP34rP9Pjlrp6BF5pEy?=
 =?us-ascii?Q?E+8j7dqAgckWiA43tWy6soWOoG6AePA0ndYH5IQONq7UnlHVtBn4y7wAI1mM?=
 =?us-ascii?Q?b6jJcsN1qtOOonE5FVS0TTHlg532IyqF0YMIbVDVJqOjUur0uyPdm20nt+cb?=
 =?us-ascii?Q?QrgNCvADyxKzGHhM+PQUJSG4XdtBt1m/TGWoaS2t5xYk22CxhZ0U1d3NCecl?=
 =?us-ascii?Q?rUDuiMCeRRlJTMuvuUCMDJTnAJTEz5hHIuan5QT8GitkQ7w9mDyanNFJMnlf?=
 =?us-ascii?Q?swSsGAKmD9yAWiR+p6lC/sDdaa+M3LlespemvD6t8jyEpy+Y2Y9rcrNsz/tf?=
 =?us-ascii?Q?Db5nfeiiE/Gqc/bzQM/onbMN5fGSJuFwu2l3wGDqeX177MEmkFqfyJxlrHco?=
 =?us-ascii?Q?6jdbiEVA1SDVmqILl0Zj1FfYd0V6whX1UepiNnNYHSZ5ss4ccAh2nPztiqFq?=
 =?us-ascii?Q?nD/Jtwn4ETNR7ufeIfT++LSrsFQmXIaTCNCAV0w5LyF1ucJxwBUjH5SXMIvX?=
 =?us-ascii?Q?LAzYhUZfnGDY3OmI1qrEScDAnZxG1TQpojlb8RDoBX/KC+TYQdFMWtgYuKvR?=
 =?us-ascii?Q?MuNgxWyNUDuYVG/oHFvL5WceIphGa4ta/rMrdHyUNr61xuRW9dUXhepFKpnp?=
 =?us-ascii?Q?xsrXt801dDYrU0psgQ073ufIaXxSfYDcOVJAhW6IP6d6Zq0dKn4N0gkurLuF?=
 =?us-ascii?Q?ssHWDDTmnPxSQbqGKQdj42EBy7Cx3cT9Qzt9I4wXcMkrDwnj6PxSCTgJRBmF?=
 =?us-ascii?Q?LyCNb6x3J6dNjoJRglOYkDDd0a+1ymmv1F27v1Pdg8qOV2QoW0VDSJjPVEhF?=
 =?us-ascii?Q?l50Ep+lKCfc+k+ik6HHVBEAkIafKihUMrzMQtomRg/G54GhpwdbnUcDdBDqj?=
 =?us-ascii?Q?A4lJ2CRV/MJA+lrvVYnsDPcTVEyvYrKGWCdP+grhTjTlokcRAn5I0rHOB6m6?=
 =?us-ascii?Q?g88NUNl9oPSBwJrbEDH2cbxIEgJZTlWjGtE36orp/oO5rNlPBWAC1BoheYKW?=
 =?us-ascii?Q?IjcSK9fstjs8SEINCurmO/p5VyDrnXtIywOzh7j5Vc2lIRGG8m8zmOjWHzak?=
 =?us-ascii?Q?giGvShEcKej+hikNU4ezioGY/x4TF+8v4W/gsWzvVMPbWiY5AkdUhKazVwoy?=
 =?us-ascii?Q?vNVxrXmx5z6EpfCYZMx20lJlLnE8AgOFjxwgXQ8ihwd4SfDUMiWy3HaThuLU?=
 =?us-ascii?Q?eS9/yLxD4wxDyOI9VEi0iYVnb2Xo5oMeDT9bV2oTj6GycCu1/11DRHUBbBu9?=
 =?us-ascii?Q?RmHiYcyYk5VglryEodTz8Kh7bYY0Trs=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddff6fc0-1920-4833-52c6-08deb4b61d1e
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:19:00.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A16Uisv4bnDHwzGjx9+iSQgxODAGBtNRoZLv5i7oZ4dFRiBrqwdDc0iTqar6C23NmXvKUDEtdB//FbiF1EXD9Yngergl8/WbSP6pFgBaGFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1035

Hi all,

This series adds an IIO ADC driver for the controller of StarFive
Successive Approximation Register A/D converter (SAR-ADC).

The StarFive SAR-ADC is a 12-bit converter with up to 8 input channels
and a fixed 1.8V reference domain. The driver provides raw and processed
voltage readouts via IIO, runtime PM support, and threshold-based
voltage monitoring.

Tested on StarFive JHB100 EVB with all ADC channels and monitor
interrupt path.

Xingyu Wu (2):
  bindings: iio: adc: Add StarFive JHB100 SARADC
  iio: adc: Add StarFive SAR-ADC driver

 .../iio/adc/starfive,jhb100-saradc.yaml       |  62 ++
 MAINTAINERS                                   |   6 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/starfive-saradc.c             | 978 ++++++++++++++++++
 5 files changed, 1058 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml
 create mode 100644 drivers/iio/adc/starfive-saradc.c

-- 
2.34.1

