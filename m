Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023140.outbound.protection.outlook.com [40.107.44.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725D2C2349;
	Sat, 28 Feb 2026 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261938; cv=fail; b=m82qmis8wuYE3+PQKmRe/XfoIeHXiUesE/jeKrGndKAp/jLwO7CLE+v+lJOvjEWd+4d0oWosZtMbstFuKeWfHYuPEsk02aEQzIRQ1rzGsl4wpJ5d4qmwmZLssGM9gWoVc8Ixb7iSmmtx0gEyrWKe76vrUTHVA6zVRpoW9rKknE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261938; c=relaxed/simple;
	bh=uqpuESYghekzcFV3eLIWD49w/+LZVyQ5xj2ZUvMl2fY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rTleeVxrILXP+Yetmj0eJamrzZdrgZQpvrt/YpVznUYQkioI45DmmJ12d4mRaKnVOp4fiDCCYsLygQoL1/0igW3kd8tUvj2KDQQR9Ps6HaDMYnsczfpqQJVLzSLp0KNRY9MhRfQ1cIRe4GeoDQGjaFk0ZXQKegEcnA6A9XUcXIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=40.107.44.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqL6aEyUUrtQSU1c3iOQ/rcI4X6IH0lHBf2vzxBg2aV3PNCrXulTtQse/Qm5dCj7V8xYeOVWmwyRTrPfMO+LCAhm1eu+VpB/0scExbfV8v4rdyFnZSTcW1VqwgQAipUcaswE/MyKHeiXibq/0n2qUE5SjJAbYWgy3rHBQUvcqOLmDBkhdXwqUDM1ACkElUScgZEEFSEUh+1g6oTK0dPJhRtG/NgETX8t0ewl0MMr0zk/BCDUh1NQdH28OYiZT9VE3Psca09KTl5z1WZCMjn1IKJgufUtDLBnqy2LI10uEqoYEHYouiWxRZfvIQduLH1quEaqxHw1Mu+/3lsiLC1hKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA3P8UxXCMQvOD+LzqgpDVN6V5tmycwSpavE/3RkesY=;
 b=b7N8Hw+nOFtbuG3xkhxezBVFXwP5mtuyC2HptNXglNSD/rxKLPANA1HUHES+9qKcxJsdkZ1t4rDwVau2wIgOZ60hjJSJF2NfAaqiDVmxI5fsmplfnqccvh+tD1nqxO28W1uetnKRq19PdH8NNSEsMMezccv7fOakgDNOHZaSscAPOp3v0IyQpdLKA3EK7yFsEEirT1OBnxx94KER6WQoyQM0LvWXBI1v7MCraPTCGvoR2QM6Aqk7V6AYIkUr5VeEq4pSh6lK4ioZ5weoeH9Mo/dLOAXx3sruoKfR1kWQwaaaiaLx7N+EYigp6aHp19QnWLF/yGMsVzHzejvsjbkrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by SEYPR03MB6722.apcprd03.prod.outlook.com (2603:1096:101:6a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Sat, 28 Feb
 2026 06:58:53 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 06:58:53 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xieqinick@gmail.com,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v1 0/4] iio: adc: meson-saradc: add support for Meson S4
Date: Sat, 28 Feb 2026 14:58:36 +0800
Message-Id: <20260228065840.702651-1-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:372::11) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|SEYPR03MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 463e4fe8-6dfd-4166-b09b-08de7696d55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	NEPMqQC29I+ZCqvb5KYL6O8/J9vdKCRzDbBpcV4uzdUHIhiVF8RZMcA9mZVSZyq1icJlin1vXGJhWyXbcLbGJfG1JEUBw8rMbjDfo5FWtcX8oIPzwRSdnXa1EyTpT/rzCFt1wQVPZQpKUotr/CgLCt44U6xJpg/TisYWgONcywKQ7RAHGEmLOHwuKk9tUHmia0LXXaeuUkHXk7le2F+7v2BlXP2YoIm2prEMcch2N1JRxF2rM2KOVoMvnkRs9yqXQ+SaxtjraAF6Z+aOTGTHyaE/xs5pH07Tpb7xsEiFZCoXSubpMfREkE255hNirBL4B/NAdPt8LbDnozYIpSF2PpVWUh0+5IBY59Prm2r5XgpYpF7/FKsJGB4mtvLz2h9MwQt7jX9MUCK8iUyVyFYV1ngi+hLGeVf4D6BV01HZwzC+IlslZvHlWeQekgU7g2ePQR3nfbR1NccMsHjrJH3EDvcaObsmKzVBgj10cc398BV4c5krMciaAeHU5zQwnzrm8cArEkKsPfl6VrHe2AJtW+23CsNznrgwdstYWlgx5d1YkWWSLmcObq3u2h53fQMSlrScbwY0xA/oAOK6fiDxE5yUsCINxTHZVWpiYNn3JfJHcrt0VxvKJP7BsnOkY6mo5r/PWMEVAhnVVZk4inu+wdJ/sF53F1xAlC7EbBtaAJSWgm1XHhAjeNk2nyyamzp1qhONFsVNQaUI8ijPPgCWALvB49kmyVgIgRHTGqtIjjoQ+rcXOKd8tnRszyY4anmt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CkGF5YMPpZCoGEtPQPeSBabI3Yb51a8bKjMh0gyRbxo6bkZ6CoKtZ/RyCztD?=
 =?us-ascii?Q?thbqdB6bSrc/Mprg64JWN7QvIuU0OChzqnpTxaPQDENK5Es54fqQ6PRIeRmt?=
 =?us-ascii?Q?t76/QTGyEy+KkII9wq0AhbaYwLggYhvMIW/LX1z0JWZDq2JbFp+bN/+Vh4gi?=
 =?us-ascii?Q?z4XLRhcw6DeXe4S7yh3av1MCnz5I+bv2CdCl9Hex+KSnfrJRm5IgFmMiHLUM?=
 =?us-ascii?Q?VLRZ7JTNaCul6fuZvAizF+GYax9ZpKrtm3i+i2E74vpZ+K3GoykWAIqN+xYI?=
 =?us-ascii?Q?Dgcc6Wupw//0c6qIB8HHtYj6Zmac6Of2T77rMdIN7pwMrMY7WPeg2yeexpTO?=
 =?us-ascii?Q?9lvsUwcudzAUIhMWufmNOxdlw+5/pQyDKQiv+qcZchFbOL+2OE9+HBK57LpV?=
 =?us-ascii?Q?cwwsq9IK0QZuLLxearMVmIwTI4zqyglAD41cZiHiSdTokR5PAHBHInerdJtB?=
 =?us-ascii?Q?adzX3E328s+jUjfpWYMw5BUyK5FZuTQBJNV0rtaGqTIg+MoEEZCFT92eCUVF?=
 =?us-ascii?Q?eu0Dn9mq7PNb2xffhpxEJ9RQ4CugjYgFha2axfSSBE7CDfJQEvbHDxatDldG?=
 =?us-ascii?Q?VN3c6LenPj2NpvzUWo1YxoU5kDClb/ozizVJDRcx6sNIJ1gBKIOvW8lKw+tR?=
 =?us-ascii?Q?nHtQt25U4aX6C3bHgoA9tpmWrxyHV4qvrlEYDx29P2RTb44RGMTt6v/ZbGzK?=
 =?us-ascii?Q?QB9wFzBCFAHztxahSEuzdtsx++vO3BK5hsrfVGEzWCdiYRuPdzxtXSoQX6jO?=
 =?us-ascii?Q?wTtd2wZLwakW+WeX8ja431obsyP7PlnuWe5HxMFWghjP/Xh8A7Newg5xEDwc?=
 =?us-ascii?Q?4DcEyIkbDwCdN+D9Z4ma++3uhQ+/+TP4XbQrvFQtwJhPro/NGMJnu1Zn3KgG?=
 =?us-ascii?Q?n1vCZvpgP61TR7vU2vfuOFNmwyhthisXfaTMLYira0My2KqqLYIBJoBt7NPN?=
 =?us-ascii?Q?vzHtUvsOWCo+H6HWZwCsAkycqTZ5RbJgOKPMwX/LGlL3z9pu/XWCybBzDF0u?=
 =?us-ascii?Q?hFSSDNJvTXApMx+TGoWTmZnx/i4XKxqShK82i9u1v5xt0PifgalgE+enBj3J?=
 =?us-ascii?Q?rY1VTeVockNjCk9v3bkdkRu3dPoPDUX3lk2ZUWwb6svmP8KyfGYe2cj8KvRO?=
 =?us-ascii?Q?TPsMHcVmz/e40fgUpu5fRIAd4Sex3BxgirS+WflqYSQa+SrTBFp/thTG7b+5?=
 =?us-ascii?Q?HCz9nfh8tQcf3xo+qSckCIClSgXKT/0A42cWdBueD6JPao+nSykWUmfBDQOK?=
 =?us-ascii?Q?rKY5GgQmwiHJ063zFmTXs+4oqPcfZviM+TTy/wVyWx+inl27hUGrFYSAN+B8?=
 =?us-ascii?Q?X+4mEj9Wq/udJRMdZBj9huox2PKA08puFOeYb9HRPvNBZJiGe8/HgkXD4+9V?=
 =?us-ascii?Q?8ucc8t1B9M+WxJClNTDxQ2rmwMq3YR/60OhQlAxMz3bXNiG+WahUpzFLPNm6?=
 =?us-ascii?Q?c/VrqUNEzKokJCIWkI8E7Q84kfK3waLeahVnkgCtRmDLo61FcFFSXfhbAMJl?=
 =?us-ascii?Q?GTTyYPx4ndCO/YASw82rTKeIfVYnWZjXp1k0YM24dSOX4CFrvJvyDl4rGRZe?=
 =?us-ascii?Q?FV9W1GHEAoWm2HHem+FenrqRGTeX+hpepZOfqj8Ta1o/3ER+/agEMNvky38R?=
 =?us-ascii?Q?aUgdJ01gpbYpEoAbDSXn3uuQZux6V6mEWz4lbS5a/q7OYa3HcaEHiGO/72Y6?=
 =?us-ascii?Q?cR91Xhrt8+ZhisDpCFRQMDhlvSQDmLs8yKxNvGwAe9dvQpLe?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463e4fe8-6dfd-4166-b09b-08de7696d55f
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 06:58:53.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+jWC7eMZFVXvZVf8sxCTJOldrCNDoR4atwD5DA1HGLBs/d87JMO1v++SzKTeZjJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6722

This series adds support for the SARADC IP block found in the Amlogic
Meson S4 (S905Y4) SoC and enables it for the Khadas VIM1S board to
support the onboard ADC 'Function' key.

Following discussions in a previous board-enablement thread [1], a
dedicated compatible string ("amlogic,meson-s4-saradc") is introduced.
While the hardware currently operates perfectly using the G12A parameter
set, defining an S4-specific string ensures forward compatibility should
any S4-specific quirks or BL30 integration differences be discovered in
the future.

[1] https://lore.kernel.org/linux-amlogic/20260123022258.136448-1-nick@khadas.com/

Nick Xie (4):
  dt-bindings: iio: adc: amlogic,meson-saradc: add S4 compatible
  iio: adc: meson-saradc: add support for Meson S4
  arm64: dts: amlogic: meson-s4: add internal SARADC controller
  arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s: add Function key
    support

 .../iio/adc/amlogic,meson-saradc.yaml         |  1 +
 .../amlogic/meson-s4-s905y4-khadas-vim1s.dts  | 19 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 14 ++++++++++++++
 drivers/iio/adc/meson_saradc.c                |  8 ++++++++
 4 files changed, 42 insertions(+)

-- 
2.34.1

