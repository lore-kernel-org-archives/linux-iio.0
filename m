Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794577434;
	b=ObwbVPprkr0PlsxbGFfFNtfcwJALmQl2A7vorbAFXU7t9dawy8xJbtHILmnc5F7ppufe
	 Be2zJEgftM9Ak50BD8Db4JvQ4SyAL2TeRapvm7RzLbIS//4azE2cMwHM7ZKItF7Mhmi3i
	 MoDaq4sOhlxNsu7XLlcXYR4ggGJkVcltkBqyOndgi6sKHzgr47tmYuQcgJpXPangs35I0
	 /rBcNasUc1ejtcDQ6AVbdtfmdVdskFTLTHo/ZLSTCYIsBAote6zrXadX87y79tEWuoc4X
	 +sEjVR20+APylxMNsYwEMmRQLrODuF5qet6e6NfNnJ9jxdjk4lB47MK0Hk9m0bRydSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577434;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
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
	bh=jzF6nkO3wAAi295W3hP9o9Ax4abn0eu7uzs33OgK7n8=;
	b=O1Yixmeu0ca9Hh9Y4WhQ3mPBl5ieiTdHZfZHqw5t1PnCqOzqb25JLHf7EK6RtFgAfn00
	 O+YBnEmKKPuv4f8ZVmWg0lyIFC+C4Tq6FeV5Jif5KuhDjLFVd5PbZ66CzOjeXrBheAx0B
	 etFuO7QXrKqHJeZ0UAuKd3gnvMKWHsAT7+PfIbXGiDcSBMH3e7m5Y8qkDiUnqBT1ohf5B
	 Rb7cOjVxh2I5IZgvaVMIGsBkLi4gJEFwnhk9f5m1KQ5LnAXktEVH3jdNNl6MhYnlGSQII
	 24vpZZ2yMDnbBBihdMzbrLN4zBQvCjiNpEIvei+mB9mYQPs4BtbQZMcH5udZmO4uTzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=pSPvUa9j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.11
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0BB606A331;
	Fri, 13 Nov 2026 13:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0BB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=pSPvUa9j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFYSU0q2BzhIPLiuRYwwgROdEI/5jdSXEP02xqt4zQfKzvnbIZXXAOwVJ/WpyQ8W6KkOqHvv0dal7C3WCys51Xfar/5ue1XrHU8X8VkSCtkZX4TShGgrzJnNeaONGH6D3L4TG0lvZrkZM7oSp9r7Z9KeKVOoZaSmp4/4ghcwPKDmsJcc+vO3xBHfrDs76HDweOySQXhwVAcmJ35L1FUT0b9i61xOUj/Gk38nv3PYCRv9GVhgvINGhLeczW+KXVwoiiZJHb40U/YvwOhp7muIbt/mYlR+Z2BfXcTf6+ouKhVTWKxP+2bjwraGAT76mCjnYB1hC/NP04Tcu/hyrXpYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzF6nkO3wAAi295W3hP9o9Ax4abn0eu7uzs33OgK7n8=;
 b=mG8UI5Bq5NfvOGiNo/Zox8Ie9Rh8YcICIKjgiDs9Ge0SETWJxHtHsZQ0yGd106DyNbrILnlUnjsQV2OBU/6++YaMzgwq0Fg1ojr3FkgTOFVTpPurQc1EMMAKskxaBBwZ9BEdLPlfdE3182KAZH+pa5qalOgWPJe/DIwgldsumfXV4suT6PVNzOiNbK1LzisouYketNQXm/amR4yG0M4g9lBVoTAZPbiUBajHCHKItdbgAspwW8uNlGg/Vay2T8hXC6w2QoGGuyIN9AfvFpgLkbUWYvMMS4dHYKR1wviRSHkz4V9hUhn/91AoPZliJg75PIlynMrWbO12QUHtaYg7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzF6nkO3wAAi295W3hP9o9Ax4abn0eu7uzs33OgK7n8=;
 b=pSPvUa9jtQmr4e/qc0CmTYFr1nNnSI0JnkCE27Uq2ElPqDqjuHIRXxPURedbhGa8wsEUIZSKOQIZoaaCMxg1kePo1dPUqDettjMe/mylbREYAFkHx7fN/ABpEh+bbmO7B0DFvsnUVCZ9lGmFRQAdC0Y18oSPPjMZX9u9K/j4mIk=
Received: from AS4P251CA0024.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::16)
 by DB4PR02MB8584.eurprd02.prod.outlook.com (2603:10a6:10:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 13:43:49 +0000
Received: from AM1PEPF000C1ADB.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::5b) by AS4P251CA0024.outlook.office365.com
 (2603:10a6:20b:5d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 13:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000C1ADB.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 13:43:46 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 13 Nov
 2026 14:38:26 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Song Qiang <songqiang1304521@gmail.com>, Radu Sabau <radu.sabau@analog.com>,
	Maxwell Doose <maxwell@maxwelld.cc>, Tomasz Duszynski <tduszyns@gmail.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>, David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH 00/14] IIO: Ensure iio_trigger_poll() is of the
 device owned trigger.
In-Reply-To: <20261109042851.1326940-1-jic23@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
Date: Fri, 13 Nov 2026 14:38:26 +0100
Message-ID: <pndpkw8df71.a.out@axis.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1ADB:EE_|DB4PR02MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4d277c-fb49-4b18-3f68-08df418c242b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|261026140227099003|56012099006|261022075727099003|261022105027099003|11063799006|261021121427099003|261102123227099003|261028144727099003|5023799004|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kZHIKXU/+aivxdj1feLciucfpxpDDSyBgHvp0jqKVKgRYPah2Z3q/JSI3OPIesaheynUnhq+1Idfes+spMmXT0pl+U6l6WQek9GXeBRq25dPEz1fEt37qE6P1bodTKiid4mnepdgnYyuVwb1a4dplgOfGXXrZrNPq30AtV8qmJ44MGmqYA99vASlQZHwxGTLRrpT9GnkdAyEK4Z8rdcdvNyyhSqchO2aaQ/x4O/ICM9hJUrWRlnWvPvGvV+wCa1HZ8vmrOGQA2ZgxTvUg7tzL2amfe5RjCAFiVpzt92fBa19MBEwMfvj0GScUeXpmSTohjdDWAIlUjgb/zSD1KKanC9mZA62o2MzFLkkJAA2Cuv9dnkI0p40h/SDa1wc1ETqzPDnU4Mjxvqgl1LCl1mefiohxuhphuaH/nlMte9iQEjfPxh9THiI66oqHeVoV5QpTcSFDDhaFJMGhU7mY2PtlZ4saGzS0oSvJ4D2M78Ld2+5POo3N37rNIEmEvaEa/kSYWgUqAey7sr8t3yqpxc5qFRHzmYRlD34GiYFsgs+pAQ8KuRpwvV/uxM5+9E/tIrRFggB+erof4+988JUblzv6XrzcoKiA3265oFpRTtyGUs2RLm1zHda5WyHGcnOspjqQ5U3Tx+Icv254kvEfilQJtfn7NmhcggDZcV1eHYJHGzhLepnOS8cTppp1YAS1wFsLFxdQzw5bsc/SJ2NX8Xx2g==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(261026140227099003)(56012099006)(261022075727099003)(261022105027099003)(11063799006)(261021121427099003)(261102123227099003)(261028144727099003)(5023799004)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nfLMG27S4khxIfDD4XZJ6RF2DAPuVbG+GOl44ao21KTYLPnOUPPGAWbuBoQ91ormHJ8Rh9YV+E9nOqlYsv7wL5UJynJPBzo0wMeQGdjSDH9LZPrIISTSFTqJgMsqoswZIc/uajg0FfNmzuMlsF9xdEag0FgUP1ijdanPKsYa02c60LZsgHlgORmf0C56wbKl5DSVm+1YJ97pSjWxX7zTmV4B0SL67oSEEmUwXe8uFZkD19HX5WU+N/u1TzRVIvvO4R9l6h0cmGy5YFON8l7zergWPZAtFBGR4mEGH2LN3U+aAI6sQseOLhhvWzewVelXCed6pYC2wKHbQFvLP9TP5QLM4tMU16gsowq80ZGJcj/sSPTOG1nKG2nQ9s9B59W6sHt/8oTR2rVrv2mJTHkDUJfgvK4MlsKPW6RQ1wm6GYh98r63nfWfyRPB2Y4vmmWe
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:43:46.4415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4d277c-fb49-4b18-3f68-08df418c242b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1ADB.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8584

On Mon, Nov 09, 2026 at 04:28 +0000 Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Resend due to wrong linux-iio email address. Sorry for the noise!
>
> LLM used to help pull this fairly straight forward series together.
>
> The primary aim here is to ensure a clean layering between the two sides
> of the trigger / pollfunc (push to buffers) divide.  The caller of
> iio_trigger_poll() and iio_trigger_poll_nested() should be using data
> relevant to the trigger, not iio_dev->trig which is the
> current_trigger for the device. Most drivers got this layering right,
> but not this set!
>
> This is also step 1 in a plan to make iio_dev->trig opaque allowing
> more control of how it is assigned and avoiding traps around lifetimes.
>
> Includes one precursor fix that has been broken long enough I think
> we can just merge it via the slow path along with the rest of these.

I had the same comments as Joshua about packing the `struct`s (`pahole`
reports a lot of holes in `at91_adc_state` in patch 14, but that's
nothing new that was introduced in this patch series, and should
probably be addressed separately...). Other than that:

Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>
