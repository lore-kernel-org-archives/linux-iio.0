Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493892;
	b=jLOsfdwFolkTDb9aQUv6a4WBxunYtN7ksAGWzrE6nhC/8qqLacItKnb/f1BVenl1ijlA
	 TzH+sOboe/AkVBa7X6h0gD7TFce8bIovVIWYTaDi/qlI+kxLaiQq0DUxKE0BYWreDzY3J
	 YII7jwB8ZVcmM+vhq8d1t6voagMuZyuBNXodhZG0eNxqqBOMJWfulrbOzpaRllfUsH1eu
	 Lf2ZmgXdYwA3/nM9CL3RVasavaNyBqpbohOJRpaPRWd/ATLDVEGqu0pOMatb8Sxr/p2dv
	 wSeuHoOIugaU+LdsB7DBOkNW6Elt9OSExf2QJAyJWeZjGbPyF7qiRB+b+HZQvtR1UQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=GXPx2Bcbn8wBF9aR3oZ2XoZDODyxcUbD7FaPBq/1ItY=;
	b=UW4Y3FBnhk0MarLVpRan0/MK940E48DKOsVx4XLDY3VacWC8U1EZUNiePd5kqZIZ44Av
	 XrB5kIr+7hqh9CPTXKTFLmIJNud3VtdHXoNpjQLV6pg1xrVWEHuPIN/zHi1vdbT/3YrYL
	 BDLwi9IYbfx9H2koy3x0XA6KlWFcAE5m3xSJqSrOAJ6DPOId5q50ggcwtq5GZ2reHfkln
	 c34EY3PYFcJQ/QSzJ0INAVZz8hMXDcitXXxog0IEUEfAaJyog1nkt5gi03SBNZf4JE5SP
	 d1C/79kk6Cjv6FuiyhY2OnG2L89bsw021zRV7yJ8MkmFfz7wDOU4IJdHwaYqcVqc4CA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=VM7UFB3P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.60
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAA60A3835;
	Thu, 12 Nov 2026 14:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCAA60A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=VM7UFB3P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgrfQXLq0RRv4uUQFxF8m81kwlpsDm5zZGypVeanO0Vfe6H8Y96xAyRk2fVYuO7D1zxUop20BpkoFoN6BdHHpEVzBn20x8XT9tekCXxRC/QSqF1fVvZ6+Qjt9jAI+Hpks+A4KIdBp4wcoPlgU4va+vb//O/3W60Mt2QfCWgwzmjIYZllOHGEq3pcN6zJMFfGPY8qurnsuB3uP/e8IbYoKsy9gw1PJW43FR7aYUheDI6WMQfKRs4jIg0pjbprs1b9+hGVxykzmMLsFS7QPVyhB0Uo1p/MTU6DGIGh/WvyAk1cjyS4roBiMxTHkWhlhhR/HVCWdraaapL4vKhsDpjhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXPx2Bcbn8wBF9aR3oZ2XoZDODyxcUbD7FaPBq/1ItY=;
 b=ykWkFej+qugWLqlNyUHnU/sU/v8UTHTYVtTUAEYl76YKEFOr6iYqyzwGMW078S0KyhOhp0CLXQeJSEXSPTcusKugZIvpk3agj/V4wWX0tBTfmxhCypjuwD8M/u1lHr1648d9CBT+MYvLTAAWWjdtZED4EGV3HSxEng3cszJn7VdkN/75K94WCtV/oKtYZVZ+54TH/Gg+5UmXcxpXijRYbQwbDsxmzETZ8NroWridDPVJS1tjGSorKb7VjP9gZuKtEVatXFdkhIGGfqIfsvuq3AJOCXvyWK7Kvdx6iM6jKC3VZ5c0S9QUFM2sGvjh0oHr55RpLYmqNSM4HmNadBjpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXPx2Bcbn8wBF9aR3oZ2XoZDODyxcUbD7FaPBq/1ItY=;
 b=VM7UFB3PBf8AC+Z69Y0k8BCc6WrWduWTs5mgJvtqysUxcR0YvBNHlIjTFkANeOOgmKEWjSf1VVWTqpJ4LrBO7N9dwLWFN8yZYgLkLrqEsLQJLQqXlEL3tsrA1zSB1v1gEnOtAjsVC2LNMTSbgrPY8KLiktnWgW8dGnjWVqntvBE=
Received: from DU2PR04CA0262.eurprd04.prod.outlook.com (2603:10a6:10:28e::27)
 by DU0PR02MB9537.eurprd02.prod.outlook.com (2603:10a6:10:41d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:31:28 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:10:28e:cafe::58) by DU2PR04CA0262.outlook.office365.com
 (2603:10a6:10:28e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:31:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:31:28 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 15:31:07 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 15:31:08 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id E991F20AA;
	Thu, 12 Nov 2026 15:31:07 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id DC4303061551; Thu, 12 Nov 2026 15:31:07 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Subject: [PATCH v9 0/7] Add support for InvenSense ICM-42370-P
 accelerometer
Date: Thu, 12 Nov 2026 15:29:26 +0100
Message-ID: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
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
X-B4-Tracking: v=1; b=H4sIAEbN9WoC/23R3WrDMAwF4Fcpvl6GJNuy3au9xxgj/lt90aYkI
 3SUvPvcDtaQ+vIIviOQrmJKY0mT2O+uYkxzmcpwqsG97EQ49Kev1JVYsyAgBibXedWV0/xZwlG
 RNHDuQohsEJh9yKKy85hyudwr3z9qPpTpexh/7htmvE3/yizwc9mMHXRswEqTtVWU3/pLmV7Dc
 BS3rplWHmXDU/WIfYo5ZsNRbrx8eAfY8LJ6Y0KQyIoQ9carlUfT8Kr6HJ00MiPJ4DZe/3sEoIb
 X1QfWZNEbpZ88r33jGTNXn7S0VmW0Om/vZ1aeWvc31RNRIsd9wAQbbx8eQTe8rd4rlbxjIPC88
 suy/AKE0rWtbwIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11337;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=W5dMvLdBhcEqsOZJThV5AecpOEbcP9dXnyj8k47eiO8=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsj6enbpG0nJW+5n582oufH2X6XoUzbOyR2crm41VxsWN
 bmvbLq0tKOUhUGMi0FWTJHlnNH26P3J/3TnSDtdgpnDygQyhIGLUwAmEsvA8Ff6xhynpeGX9cst
 jKI7/VtqdF/kdduLnWFs49LuVKjcN5eR4bGAJustMz7nXd0bDy5P3230ZmHSPZN3ba55LZcTm6u
 rGQA=
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B0:EE_|DU0PR02MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1fde69-e1fb-40f1-6e03-08df40c9a341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|32650700020|23010399003|1800799024|82310400026|921020|10067099003|11063799006|56012099006|261022115727099003|261022105027099003|261022075727099003|261022113327099003|261021121427099003|261021123027099003|261021135927099003|261021130227099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261026130827099003|261028144727099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	71WHFibf/uelxncoGODU/H3HJ4+5G7Hk3pa5EY216anrStqr+BIMroTH5vXhFFOcD2fGaKHgibmNgYavEE3wgeFm6BZ+r51O9z5FP7dXNX/uHnuV63zG5yMChs6TwJo8alXMzLqw8jhkwoTXyYyNFJhZvKHuY3Q70O51237ua5vKuQKoftNkzAu3vfj/ZLMKtXA+myaDiIXQGNnrMP5SI6B0duUB70N6Zr5ECKM7TdGPI3RpUKLKN6WKm/BTV4+XEltS9V5ji3po74WQ0rQWrPQzSUlU4m5Sw69nXFb48q9lFl8MUzW81slolXFKcapIM4xlr4XrMUSijDN0T4sGvAdy+RlK7F+GrBzwDd4eZAhloeyYoKwKN3EEPG3A2mfzvTDstz6W5Bl0kBQHlnwZvCQGbdYEYMj2esmz62Av7wEqFyQIp6zdffOvb3gTzfJ3YAdWiJ5RZ5+dLZFbd0wcsPumiXD6GmxeLyxWo+Xcfw6L20Ap2wqU/mWt30UQvRrEKv06rZ8AWxYla3CDWjJbJfgxNQzdPjqKdj8yXg4MfiS2C772gGxam6eXVkJM/FXnUow6nxDamJKyFX1XEHYH0xzm6UCov2qV+Mbhgl2XUt6Cy7qHke8i8hCov+Sucrq4F6fwM+7Mzz6ZiWVZasz6HdbjC1PAVvw2xtzsgtGE4b6ExqSagU2k8OsSyKDtpjn3
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(32650700020)(23010399003)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261022115727099003)(261022105027099003)(261022075727099003)(261022113327099003)(261021121427099003)(261021123027099003)(261021135927099003)(261021130227099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RD1McGzUl2CE1vxS93wn6jUNzR4QJnR8Igk0heZ3VoPlr9gDAJExNZPk2Mm579zMtz3A/tT7p4phhc/aJyR0zrYtVUydbYB3btnyOcCf+DvCtGCG+ntYSfhxxXlOkX3o9eOqMkgCEieY7R4KKVAu1ylFqZyx7Dfy/jn9/UKlUTbei5b294GMySSnZKMJlWfV/g+SfS0IhIqUeLs1Soolh8hTE3M8JO+izoMC226bBQi2w0pgF2Nlmu11y7E0ZQopWnCCpkIT46X8f3/Hkh5qB74MhkHZ/dOhH5SAnMgOWORG9hmKJiZQDEnahrbgAqL6o5t3cIQ8DGGitPbGZ2R9ZUViQ26s0R9IVYgmIOK8/HgRyjobTTA70zpdXB0sQe4LZv/BVyVsNskG2tyq/oR/rno1/Yv5+LvqKddcNVyYpRjd18y9QbK9rlQ4hw1WZFAG
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:31:28.0601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1fde69-e1fb-40f1-6e03-08df40c9a341
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9537

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
Changes in v9:
* [patch 1, 2]
 - Dropped gerrit's ChangeID.
 - Fixed the commit message title to match ICM-42370-P.
* [patch 4]
 - Updated the temperature read function to use _get_pwr_mgmt0 function
   instead of accessing the PWR_MGMT0 register directly.
- Link to v8: https://patch.msgid.link/20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com

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
      dt-bindings: iio: imu: icm42600: Add ICM-42370-P
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
 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c   |  12 +-
 7 files changed, 672 insertions(+), 148 deletions(-)
---
base-commit: b70566610b48ba49dec636019da4d696db64b085
change-id: 20260629-b4-inv_icm42370p-ccd671066bcf

Best regards,
--  
Kanak Shilledar <kanak.shilledar@axis.com>

