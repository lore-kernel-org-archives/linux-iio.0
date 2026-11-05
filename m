Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893759;
	b=K4sl5a2S/OnwcZgV8hAK5ktNQhkKyUoUK9oOTjZttW8u1YV6PazZPzd0for4aqIdXfgW
	 IXenYyBRat5bh98ldGl5CGNy8kqzl3ykV7tmOxCXkLiHVFJpnui+HfeYHu4XFNltaE0iw
	 S2pO1BWlJIYg1UNLuSWM0XMIJc2TE1MOX8XsyOszPjoWSff0Lc2waoGYEjEo8XuJRnKA5
	 qZH1zLso4FJHfDzPavF0L8+eRpylH7C/+2M7Byr+/4S716FftaNcrp24AmJKB9ikdhe1+
	 4m3eAAdltTCdN/d5118b7OzHtVDrqVTna5wgIx4KB5EOKzUnx/5nZGtVh/R0dczssOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893759;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=ysnkV25T936JkgD2a4uaivsOxkfJyFf5IHGhVuVh8H4=;
	b=I+3sORxRDZIBuS4Eqevx4ZqKjCWf1rFDTVlxw7UF6Fwqv3e8Q6f/2ok1fY6km9KaJrK/
	 qplEcQZLeqbOhYKkXJDvnwY6EPP9RMkUhbr/dNqtBH4wUEAYubfijxsbUFB5+pDmKWymf
	 waKdzMQA/zCNwY2yTtNbWopwyJhkQUDnGPaqtreSU/Jh26Qbxrt7j6QdmUwqYpDxy4lcG
	 7/ZkdjTgyHdu3eLXpe9rpV/8iZXpgYLZnKusaTprGJsan8angHsl8I5ZJqxmK1C8stIlq
	 k/IeaRgNsdBX8Y3pzeYeOFt+2guxwF3tqxUAtPnTF9r0p7sR2Ofi3lFuQWp43kqMWJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=SYNeanN8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.16
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6475606EEB1;
	Thu,  5 Nov 2026 15:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6475606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=SYNeanN8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeCL6LBfiJj2ZeyBG4FZ2kABtPnBrl80BTPN2g8TI43vwQQak5R0yHM2+THbaXn1v0KDmLDI9DYq4SUyk/0h6RRRN6CqN56V22bedGVnv+lvj8JwVTqkBPVrxpTJ5Nmnykiee5LiOQ4jKnhOtJsWoqo61OTD8KfGbn9h3kGvz4QhJHESC1pOnzrjZY7Tvr3DgcLkkn993TwcTKErNN3BjZvIHFTbqPf12Kq2hr4d1MuUDpqCqBFpvhMje9LyJVnH+P2zEs3USo05lWnsCjiP8JAQfiPcP0KYgeK3bESuflugerfwxfNW4V82CeHO63zJNxU4vx5oRo+U79NYwFSNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysnkV25T936JkgD2a4uaivsOxkfJyFf5IHGhVuVh8H4=;
 b=jNzChGK3HwlYJtPnegPoe8gBFtxirTca8MuNPHHLVnDMFdvjeHmyI5x1nApMMRp9vrWdbVWOaARJEiuF67Ova1BywLiWUsPK6u5hymxc1W3ySb+7FBx83D59htN3ek0Y1utxAqDWtcjKWPlj9AUoeVZuT7HzSdoXwEnin9TrGLtmTWMdO330AAo0g09H9KEB3psW4afB4yf8GEATZlYa/3h4KmJ9OwGGL2UbCX7KUgLQZk9QUE9Wdh7/NAx++Q00bCm30uqvcHVP4XjL10Ur+GFnccWjyuoJmq9wDpDuU5eYySq5lH9L52AzMzALKx15FTOaTWa5n9IpEnYrCNjyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysnkV25T936JkgD2a4uaivsOxkfJyFf5IHGhVuVh8H4=;
 b=SYNeanN8d96gRmaUuHPJ1Xp69Ji4q4W9hG8213g9rLCibqVIBfARS7ZeFrzMmPwRbSb1zYt5OLN2sJeatXStFNvNfLCCYmzBfLDlI+Iwe6SMr8JEw+Wrx4DuO9+dPnacM069nyVqAqMaT8H528/yHLCl6DcE0sGTA6Mz0Iw2oQs=
Received: from DUZPR01CA0199.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::28) by PA4PR02MB7117.eurprd02.prod.outlook.com
 (2603:10a6:102:10e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:49:10 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::9b) by DUZPR01CA0199.outlook.office365.com
 (2603:10a6:10:4b6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:49:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:49:10 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 5 Nov 2026 16:49:03 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 826234A9B;
	Thu,  5 Nov 2026 16:49:03 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 74524305D5A8; Thu,  5 Nov 2026 16:49:03 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Subject: [PATCH v8 0/7] Add support for InvenSense ICM-42370-P
 accelerometer
Date: Thu, 5 Nov 2026 16:48:48 +0100
Message-ID: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
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
X-B4-Tracking: v=1; b=H4sIAGCl7GoC/23R3WrDMAwF4Fcpvp6HJduSs6u9xxgj8c/qiyYlG
 aaj5N3ndrCF1JdH8B2BdBVLnHNcxMvhKuZY8pKnsQb3dBD+2I+fUeZQs0CFpAg7ORiZx/KR/cm
 gZnWW3gdiUESDT6Ky8xxTvtwr395rPubla5q/7xsK3Ka/ZU7RY1kBqSSxcpqTdQbTa3/Jy7OfT
 uLWVXDjQTc8Vg/Qx5BCYgp65/W/7xQ0vK6e2XsNZBDA7rzZeOCGN9Wn0GnWCVD7buftnwelsOF
 t9Z4sOhjY2AdPW994RqHqo9XOmQTOpv39eOOxdX+uHhEjdtR7iGrj13X9AT2LVusvAgAA
X-Change-ID: 20260629-b4-inv_icm42370p-ccd671066bcf
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, "Joshua
 Crofts" <crofts@kernel.org>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10916;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=WohI+ObplGwzJcL3OHsXeWGqB027SGMU81OgdmTjka0=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsh6szR3DYf1hS9xL/6JXePpypiXmSBce/RF1zGhdy53v
 vT/XLI7s6OUhUGMi0FWTJHlnNH26P3J/3TnSDtdgpnDygQyhIGLUwAmwvSA4b9D7/H/dpqWRQVT
 Jx6NuP++Q21Sm1r4WRUOkT9/xM0+GZ1g+J9a9d2u6Kj5GQ3pzKlJEz/l+vybEnD1/qrjR6d8+XP
 vUhwbAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|PA4PR02MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f381d0-7c90-4486-27f4-08df3b54556e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|32650700020|1800799024|36860700016|82310400026|10067099003|921020|56012099006|11063799006|261021135927099003|261022075727099003|261021123027099003|261021130227099003|261009223027099003|261022105027099003|261021121427099003|261022113327099003|261022115727099003|261026121527099003|261026130827099003|261028144727099003|261026140227099003|261102123227099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	R2aQhlitSduC46o5c/8utzUzdHttHM7Be+9Z5bMDs7y05HvmQWt0N+Gcpy4hBJtC2hrwf6b0i+501qDnu4a0B4itbMHkh1+Dr0cGIv/8EWt5RN39gTDGIkx6kaMkQSowLNgD/aGRXbULwO4HRf2k4BLQUkDwZV6DA8vK3nWW0Q56q26YZaSkDVhbzN4yX0XhBa3Xb03do4hqVjTuJc3OL4Ko9ebWST0PiAGR0MLSiBkHbtNmokIzjI7/L6ehMnA1OFVxZpNwpZ864Ky6pCLMHThl0fDvG4zSEyzWW5chlvpEpJL945MZ5YOQlLi3GG6F7TIonAwtmPpOf710Xqnoa7k0VHqCmAzJse81BGPLzREpxBHh5SeAX+qCztsqJSjPFfvHSuWESTEb8EkeZ5vrcY97Tc/EPCRmMVdVL+R5w7PCa1XgPFKewiK8L7vRX8KzfXeZh+9OkLdScNEnwc5Y88JvWRWhuy6f1ZukKGtKSNbgMdVmTL5G5rstxqJqPaxQnOkXc8b/jXU0qnIzCM9HdNtelckKDCTdd11JKf6cXRAtsGi9t7M3bCPANXiBPNzmAiN24UWMldd4NpeW6Y7MUVGU1Dnb6k/M5Cn801JmpdRmgFTg1WbwF0R+5rwMRuRL/6Ai12k2w7ousdDPQej6K9cUatooAA5Ug5p/6vHHUoEkWC6zn521jHbcblv1lgsN
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(32650700020)(1800799024)(36860700016)(82310400026)(10067099003)(921020)(56012099006)(11063799006)(261021135927099003)(261022075727099003)(261021123027099003)(261021130227099003)(261009223027099003)(261022105027099003)(261021121427099003)(261022113327099003)(261022115727099003)(261026121527099003)(261026130827099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+QzabLpJael2fgeycvZRTCNmKbgX2czOx25N/NHN9uL5E4BuS5pvW9JeIXIXbfSssZk4b+zpUkvhl4nX7n83rafTnSwi2L429/ZfAS/yOynG4rNWoCo6LMsX85FylvUKPkpahuq3Ki5nWpBOQIeaTw1EZ2fiNESCRpFrx0EowCREcqXzbPFrVtPxLM72U3dpOPDL8qOanTTUGW0vRZhtcL1qXme8C3Mgi89l1qGt27xop6QB9i/fITOjGcO8hjEIb3FYYCZPax3LHC/8RgbqGsqGac2XCRMlyGGAMvo/CmM+wrZrt2+Z/K/iu4mKHvntLi78TiQbj2R3JOaWjOPcCZE0Fl2h9dYw4+53pmHoUHmRhClje3EyfvcQ+iUZP9q98cjG3T6thOgtZZJ9dt9rZ/ffsoLxuzdhLZQ8FYdNaYZdIm5rUkzCkXlqaClRuq4C
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:49:10.5960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f381d0-7c90-4486-27f4-08df3b54556e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7117

InvenSense ICM42370P is a high performance MEMS MotionTracking 3-axis
accelerometer. It supports I2C, I3C and SPI protocols. It has a 2.25kB
FIFO and two programmable interrupts with support for ultra-low-power
wake-on-motion support. It has a built-in temperature sensor. This
patch series adds basic support for the sensor with functionality of
performing raw reads and writes via the I2C interface.

This device contains 4 register banks for configuring the device called
MREG0, MREG1, MREG2 and MREG3. Unlike other devices from the same
vendor, this contains a very different way of accessing the register
banks apart from the default user bank 0 (MREG0). The register bank access
procedure is mentioned in the datasheet Section 13. This is very
similar to the existing InvenSense, ICM-42607-P driver. Thus, it
improves the existing driver support and adds the ICM-42370-P device to
it.

While adding the support for new device, I tried to perform some fixes
to the existing driver which were pointed out in the v2 of this patch
series.

The buffer support will be added in another patch series.

Note: The datasheet for InvenSense, ICM-42607-P could not be found on the 
official https://www.invensense.tdk.com/en-us website. Thus, I am 
using the datasheet available at https://www.lcsc.com.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
Changes in v8:
* [patch 1]
 - Drop orphaned link in the commit message.
* [patch 4,7]
 - Fix indentation and alignment of code.
* [patch 6]
 - Drop Assisted-by tag.
 - Add extra helper functions to implement bank switching to make the
   code more readable.
 - Update the commit message to highlight, BLK_SEL_* should be restored
   whenever, MREGx transaction is initiated. 
- Link to v7: https://patch.msgid.link/20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com

Changes in v7:
- Add reviewed-by tags.
- Added a precursor patch to fix interrupts property in dt-binding.
* [patch 4] Initialize gyro based on chip_info
  - Use explicit comparison instead of implicit.
  - Add a new wrapper for setting sensor modes depending on availability
    of gyroscope.
* [patch 5] Add support for ICM-42370-P
  - Drop the dev_err_probe for WHO_AM_I failure, as it was unnecessary
    and doesn't provide any extra useful information.
* [patch 6] Implement MREGx register access
  - Fix formatting issues
  - Performed checks with lockdep and no issues were found.
  - Added `use_single_write` to the virtual regmap (pointed out by
    @sashiko).
  - Moved the transport regmap to _core.c file such that, it can be
    accessed in both _i2c.c and _spi.c.
  - Handle error when clearing bits for IDLE bit.
  - Rearrange fsleep in _mreg_read/write to sleep before entering the if
    block in case of error.
- Link to v6: https://patch.msgid.link/20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com

Changes in v6:
- Add reviewed-by tags.
- Arrange ID tables based on compatible.
- Reword some commit messages.
* [patch 1] dt-bindings: Add ICM-42670-P
  - Explain the new device properly in commit message and dt-binding
    description.
  - Remove invensense,icm42670p as required from interrupts.
* [patch 3] Initialize gyro based on chip_info
  - Fix conditional flow with if-else statements.
  - Do multiple similar assignments in one.
  - Fix inv_icm42607_set/get_pwr_mgmt0 functions with has_gyro condition.
* [patch 5] Implement MREGx register access
  - Elaborate more on the bank switching mechanism in commit message.
  - Fix return on error handling in inv_icm42607_mreg_read/write functions.
  - Fix code formatting and reduce priority of "failed to clear IDLE after
    MCLK timeout..." to debug.
  - Return early in inv_icm42607_mclk_put().
  - Deduplicate regmap_config for i2c and spi regmaps.
  - Remove MREGx registers from the list of volatile registers. There are
    few volatile registers but they are not used currently and are not
    being on planned on using in the near future.
* [patch 6] Add accelerometer calibbias support
  - Move the Note to end of the commit message after ---.
  - Replace div_s64 with DIV_S64_ROUND_CLOSEST().
  - Replace masking and shifting for accessing the USER_OFFSETx registers
    with combination of FIELD_PREP/GET and GENMASK.
  - Fix switch statement by combining similar return types.
- Link to v5: https://patch.msgid.link/20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com

Changes in v5:
- Merge the dt-binding properties into icm42600 binding.
- Revert the unnecessary moving of iio_chan_spec_ext_info struct
- Move the addition of has_gyro property to a separate commit.
- Reword the commit messages for few patches.
* MREG bank access
- Update the bank id defines.
- Use graceful error handling when clearing mclk bits.
- Use FIELD_GET macro whereever possible.
- Change to get_unaligned_be16 wherever possible.
- Revert removal of _is_readable and _is_writeable functions.
* Calibbias support
- Make _accel_calibbias array a static const int.
- Fix casting of values throughout.
- Link to v4: https://patch.msgid.link/20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com

Changes in v4:
- Drop the little endian ABI change patch.
- Drop the odr formatting patch.
- Drop the gyroscope calibbias implementation patch.
- Reword commit subject for changes to the IIO channels macro.
- Fix formatting across patch stack.
* DT bindings
- Reword the commit message of dt-bindings patch.
- Drop the MAINTAINERS entry.
* ICM42370-P support
- Update the probe to select gyroscope functionality based on the
  chipinfo struct based on the `has_gyro` member.
- Drop setting gyro member in the `inv_icm42370_default_conf` struct to
  NULL.
* MREG bank access
- Update the bank access as per @Jean's comment to make it similar to
  icm45600 driver.
- Use the regmap approach to handle bank access.
- Dropped setting the default configuration for the ICM42370 to be
  always start in the LOW_POWER mode.
* Calibbias support
- Add calibbias to `inv_icm42607_accel_read_avail()` function.
- Instead of clamping out of range values reject them with -EINVAL.
- Fix return handling of calibbias functions.

- Link to v3: https://patch.msgid.link/20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com

Changes in v3:
- Updated the cover letter to match the implementation.
- Add SPI properties to dt-bindings and fix typo (leave out I3C for now).
- Move the implementation to inv_icm42607 driver as both are similar
  devices.
- Fix formatting of the drivers based on the comments received in v2.
- Switch endianness of the driver.
- Update mreg checking to perform bank access even if the device is in
  OFF or LOW POWER state.
- Implement mreg read writes and calibbias support for inv_icm42607
  driver.
- Drop buffer and interrupt handling implementation for next patch series.

- Link to v2: https://patch.msgid.link/20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com

Changes in v2:
* Changes across all files
- Update MAINTAINERS with company mailing list
- Sort/Cleanup of includes
- Use `guard(mutex)` and newer `pm_runtime` APIs
- Fix code formatting and add empty lines
- Be consistent in inv_icm42370_data variable name
- Fix MODULE_DESCRIPTION
- Drop secondary state struct and merge it's properties in
  `inv_icm42370_data` struct
- Update mreg_read/write function calls
- Change the compatible and filename to `icm42370p`

* Changes to dt-binding
- Add dependencies property
- Made vdd and vddio supply as required
- Add description to drive-open-drain property
- Add mount-matrix property
- Add interrupt-names property

* Changes to `inv_icm42370.h` and `inv_icm42370_buffer.h`:
- Resturcture the file according to @Marcelo's advice
- Move struct __aligned properties to the end

* Changes to `inv_icm42370_core.c`:
- Fix _accel_scale[] values
- Add IIO_TIMESTAMP to channel spec
- Update mreg_read/write to fix bank access
- Replace usleep_range() with fsleep()
- Use constants from linux/units.h
- Call `_update_fifo_period()` after updating the ODR values
- Fix mathematical error in offset calculation
- Implement handling of mount matrix
- Implement handling of named interrupts
- Use devm_regulator_get_enable for the vdd/vddio regulators
- Use better error handling
- Move iio device registration after performing IRQ init

* Changes to `inv_icm42370_i2c.c`
- Change compatible string as per the binding
- Use named identifiers
- Add `id_table` to the i2c_driver struct

* Changes to `inv_icm42370_buffer.c`
- Update FIFO enable/disable logic
- Update FIFO buffer to match the specification and handle increased
  size dynamically.

- Link to v1: https://patch.msgid.link/20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com

To: Kanak Shilledar <kanak.shilledar@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: kernel@axis.com
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---
Kanak Shilledar (7):
      dt-bindings: iio: imu: icm42600: Drop interrupt requirement
      dt-bindings: iio: imu: icm42600: Add ICM-42670-P
      iio: imu: inv_icm42607: Simplify IIO channel macros
      iio: imu: inv_icm42607: Initialize gyro based on chip_info
      iio: imu: inv_icm42607: Add support for ICM-42370-P
      iio: imu: inv_icm42607: Implement MREGx register access
      iio: imu: inv_icm42607: Add accelerometer calibbias support

 .../bindings/iio/imu/invensense,icm42600.yaml      |  21 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607.h        | 177 ++++++----
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c  | 202 ++++++++++-
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c   | 389 ++++++++++++++++++---
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c   |  13 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c    |   6 +
 6 files changed, 667 insertions(+), 141 deletions(-)
---
base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
change-id: 20260629-b4-inv_icm42370p-ccd671066bcf

Best regards,
--  
Kanak Shilledar <kanak.shilledar@axis.com>

