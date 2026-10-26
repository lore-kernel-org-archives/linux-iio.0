Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012618;
	b=3JsmlIEPpSXf/ffNzgRl1QfsE34GN9gSj0r3+lQs27Q9kaunfQsPsUEH1YJPOAtLGkvK
	 9eZJaGJEONk+U2PcZeIIvNtZrnKBs2xE3HoMUbLbctIbbPR9P+mD3Lt1Hi1Kjf2GqaGXv
	 mTQHQBQKthfSj9z8LWXjNMH2dKRdLZWzybCBbZroUn42H3osYMkaDPXB6YaU16QuM5yTH
	 SfBCtBXXt49/Kz2mxUfjp6T8DCeyTUCmP6ofhXZoPqIeI+dwRrkrAc/5D+80UwIKt5AAY
	 r6irkkdI4bqhIibV3omUwFYoZrsnQemh0SntV4s9Uo/n8BaOjqRVQv3j2bXix5YOHVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012618;
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
	bh=DQIApVRCaG4i2EJh/WYpp4PZG+yFtgQhvqwo5vmX4A4=;
	b=oG5YAkt1dBrxp+IkkPsTMeawQ1Oc3SveEORhwD1XUjJlNe24x0y3+2P5G1ZzRcoYfN1y
	 5CX66fItK5mdclmfrxeOzBPXHtlpO6LaxB7NURGM9gvYpbn/dZAb0csRJzSFn3RP3GwAb
	 r/HuwpPcJwppTlvAvv8Q5AN7Z2CWRjj0mB+JG1xDEs3+BDMRF/hAx/lLBmpHdbkqwzAgu
	 7DIdjxWH0Q1kJG4Zxz4kmwdz5BbWanbXWcmxs5z+QPblDf4BLa0H4MgXrC16tTvZ66Ckc
	 vItuSKnWruTcJz3IJtQrRejqTqwADi9lUCiIBtW+mk549oJvxfL/IHOl6hP72QR0lDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=jY9fvhBD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.42
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357B606A32D;
	Mon, 26 Oct 2026 11:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8357B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=jY9fvhBD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxcEHrsTqSWW2ivRmBsLJUYRlORD2u3gAajZLcWZ9q+xxREgvFqTAlEtVf1Af+hWZYpXwzvThrhXtzDOmNkqm6E4k3nS6rT3NBko06AiReKda131CA6EB4Z6thlYH020wr+Op8iisyqfXMJ03wmzbVgSvukTLj4i4dRBXdpR/YedrxMgyGfFfLFfNtDgVF52HV5zz0IzNE1dQdEKnNFpSo9fI97e89ubklH4lIRb4CubE8Us+DJ6LwpcxBkM9hgNhvdwDSFRJ9aHsyh4BwG4Nz7CL+X7DSte1WAqTUJo4tW3wQE9Ff0/Abbd/Usx2f/LP+HUP62uLbqVZITxu31T1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQIApVRCaG4i2EJh/WYpp4PZG+yFtgQhvqwo5vmX4A4=;
 b=eOBjchfeMcgYzbP0Ktdx8zbQoLBX3HOZ83DHVdXcXTWiFF41UBh5QPoo191KoOif4lFhDyXTxhJ9nUmoPRgzp4raU8iYNv+6EuBfoq48V8Q3HdgVGrWdUqsA0ky4tCXPxhLBEsJMxXlbw5KY0xgm6JCsShutWW+0y9Ug5tRv8YpHiHwYFtopGrrLpwgbPt6wDd9/Hv1DeZ+HXXLviKMu+10ppEtW2gNJfCGbcq2t/Gp0fwKvPtpl8dn+BeSHzU9NX3GiMsycAEm6cwtCIL4oFWIikwUOGtqZiot4ewDroCm1+ONpriISrQLQNq4tTNO9U1cVTDfrpmattG/fyraQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQIApVRCaG4i2EJh/WYpp4PZG+yFtgQhvqwo5vmX4A4=;
 b=jY9fvhBDulOZX74THmRTpSsCxNpQZBk7wLVWQMlHT9dqBOjx/xHmSRWgRfPixnH2OEPLxtYyXWBzZ/eHKA/DHhEh1sUaImuwcm1iQEs+sW9vq3A4UMcTRoG5u7erYuf6JpafESFn8nlhOjKJqmIDBWFokEliZPe2/0pufgvDFAU=
Received: from GV3PEPF0001DDA1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6c8) by PA4PR02MB7055.eurprd02.prod.outlook.com
 (2603:10a6:102:107::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:03:29 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com (2603:10a6:388::1e7)
 by GV3PEPF0001DDA1.outlook.office365.com (2603:10a6:158:401::6c8) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.546.22 via Frontend Transport; Mon, 26 Oct 2026 11:03:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:03:29 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 26 Oct 2026 12:03:17 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 26B4F40EA;
	Mon, 26 Oct 2026 12:03:17 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 3ED9B3063079; Mon, 26 Oct 2026 12:03:17 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Subject: [PATCH v7 0/7] Add support for InvenSense ICM-42370-P
 accelerometer
Date: Mon, 26 Oct 2026 12:02:48 +0100
Message-ID: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
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
X-B4-Tracking: v=1; b=H4sIAFgz32oC/23R3WrDMAwF4Fcpvp6HJdmys6u9xxgj8c/qiyYlH
 qaj5N3ndrCFNJdH8B2BdBUlzjkW8XK4ijnWXPI0tmCfDsIf+/EzyhxaFqiQFWMnBy3zWD+yP2k
 kq87S+8AWFPPgk2jsPMeUL/fKt/eWj7l8TfP3fUOF2/S3zCl+LKsglWSrHNlknMb02l9yefbTS
 dy6Kq480I7H5gH6GFJIlgNtPP37TsGOp+at9Z6ANQKYjdcrD3bH6+ZT6MhSAiTfbbz586AU7nj
 TvGeDDgarzYPntd95RuXmoyHndAJn0vp+y7L8ACfTg/vvAQAA
X-Change-ID: 20260629-b4-inv_icm42370p-ccd671066bcf
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10436;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=hvWJmukiF1xC+Rrzsjyp3WjCBGnS8U9M8wQXQoSr9Ck=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsi6b5yj+3/TPqUgVx6BZ3c310mrrW1/u3qjA+exB8XMx
 Z4LX7X97ShlYRDjYpAVU2Q5Z7Q9en/yP9050k6XYOawMoEMYeDiFICJ3NdnZGi0FlI/wFozYf2i
 Oz8en7JT7jpq7XRUSsHDxUrV8fZ1BglGho13LnzJ4vy6vGrduz3cCcVGm7z+RdxtfFg29S+3xkv
 RySwA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000524:EE_|PA4PR02MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8c868c-8ba7-4dc7-f3a0-08df3350c442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|32650700020|36860700016|82310400026|921020|11063799006|56012099006|261009223027099003|261021135927099003|261021130227099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261021123027099003|261021121427099003|10067099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	bz6IAZ0+3Mt3wuOuG91PDoVy+ql29GItu7YvWPpdk3r99yW2hCz+C3r6hdKF+buiL6wNUzDmYJhofm69pdKABrfXuHOrmCkHlZETDlDEioetbUJzfIRrb6tSjlIhaObJ9qRaUV8Sh3Rh22uxr517gNqk2pshpGwA3Eaiwaj7971ADMrkOvLoL62vu07O/nFVeEa5J4EtEjjnEclmzyJh0w+IzUPkY9vzjlXbw0OM7fMg0zks2CoBaTO98fA5sAv+sVrsvCyIofFwfSarSQkaWy0pRlrwrfeMXBw1Kbv5tW3nT/GPrpn9nAkUrXxJUnq1Fi/MIZE1QM3sAY9JF466MAMogTmtfyZ6PXEaU9XJQ85yxPNvutowEwt8NeZsZoeMKAqH88OJGHRC3yfGM6V8s/2ij3p4J7R7mIUiX/smBw/6pqyWXUtKb/1aX7+XNO18tX99UEn1ELhUrWUFLgb+gvQjW+9rWFwwhwwmfIvuTimtPITb3Kr4I8WxhTZ8MM+SAbLKKLUofqXEQE/gpyuCIbaWtqBqdSV8OFt8iQU57+9XCNPjt2B2IhRx5ZLrdj3V9LBcqb5VV+V20v9oJvBe8T2G/8uKZ8SisTLBTZcn9AGVMCtCujY21KSVKe1G9WqWVQTitNJe/CK2aaFnnJgGLvxfNqVwQFyaI1e3r6wCecUKFLA9eX8tx+jFmZxFtUz6
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(32650700020)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(261009223027099003)(261021135927099003)(261021130227099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a1FazQHNczhs9O37HmyeR7W9XxqwoqMs4KIKvbub++gGrMAZCtzjScdpxxkL3iDB/k58E8cR4+GGiySepQI59G93pQ40rpqN/w97Lfr1IDZo1t9LZi1vesI1mRZIO9a7Dhx4e4AfWKoXFll3cy3GzlYNMQR7qaIQ0X2ZfLIwbZ2RooSNrDyVoy1GB5BosldgbQHdWJ5Zidvi4UuUUxOnuRKwRKJIVfVJaNIy+yxIVojNTXY/cSq2Ym8lZ/qp9V34iqfl9cAYMcPtdsWeibRp4DzOiQ21AZ4CuFkbZzvp9P74WPvGl8u16hUxx4OkU5MozfHtt2YqqL5cpzB/mRhtxBrAILAlZEYu9d3M9+lM1pvDXxFBk4Zw09rpcHaoYbIrmbTgfeeI3zFF4DlsmKxmy3xXCXIV5lAULVXMbimdn0vfDjxEZ0zxCluDyEoKzo7x
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:03:29.2826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8c868c-8ba7-4dc7-f3a0-08df3350c442
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7055

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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h        | 177 +++++++----
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c  | 202 +++++++++++-
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c   | 341 ++++++++++++++++++---
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c   |  13 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c    |   6 +
 6 files changed, 620 insertions(+), 140 deletions(-)
---
base-commit: c9dbe2a47f635465c9985b7af74d2ae310e98125
change-id: 20260629-b4-inv_icm42370p-ccd671066bcf

Best regards,
--  
Kanak Shilledar <kanak.shilledar@axis.com>

