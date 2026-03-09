Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0003ACF14;
	Mon,  9 Mar 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074935; cv=fail; b=KLQMtmq1Y/5Jxj6i8INR5N6IPcpdQpLz29ClFE1VGMglt9qX2vgUnxJhQWcY/qxpyMJk259pTF3MYmJumTN2GRpZdXK2qwIU6EXItsaOdblMOskZP6MoQ89Il4R3ji1i5s2Z4JRuP9KIi7womTlQ/ipunNEqYCudrUvWK4fxXgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074935; c=relaxed/simple;
	bh=N2L+h+SwaY3YshUNvz8gVL+xKhYxV4WKhFuiwMqc5GI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRk9Ry44crFYN7btHXa0cX3GpP4eaOQ82eoaVzkmuULzAKd2sosiNEmdW7LnmerdvU6W1mPml18cRGxCR6fzYLV0iamKz6W00gXomnsOe7JrmnFc57H98ZXVtBUKN+l37sAKaPZCtCjWcIibTv3RUuRZYgyqpvuJ4DILhjGCQdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=f+nsyXUV; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="f+nsyXUV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqx6lEEnb15FjLfcklaem+5L6xFU3B3LIbLN+AxEEU6wBxmzoSUStf4XPcfrlP+lblfL2OCYXOeMucgl92q3FGFAVr1AfT0vF70gPLSDLXg6KqkxsADrx21DrT6TW0VUsYub4X4dDHjwJtWzLBx1wW2rn6y1XPK3xk+R0IKNMi7YSXpPcPHessufR/d3eT6jEHSuRTiCZpS2akDJNaRezhvEsDTfFC1Ber0wt7sSbK42FF4akKf2ODGyd9BGUlTasRma0S3Ig1rbGlka4lbXeolSv2qgubg7Nso8jsDRQ+4O81pypKXQ2TihnPXdFoT+F7keWBKv4XK+ARqEOwxB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42UWP3Fo0iqX3vRsFB1dkDXlAZM1F2B2s+oPmN9jtPo=;
 b=RujQ1pqIy/hIYCTyh/2AxocY/gpNhJgeQ6oEUgZOyrerM6cSbifx8JPI77NUbqHQNoIySxCMbmnLgWg08/mDxLB/uTwkx+pXc2Gc7LorjB2gATvBvEkhZEnIcolpkNwX4G4303R0nLX8Za7jWwt1JZnQPyL8zgu31JuiXXWqYUrg54jKkE/0hqtxKtpCtXauA29OQR+z52Qat5yMXTVXs9WteiOOyodDG/Ru5iO6r0wTv6JTUOf42EZuucDf8L1ptMV9Eli36gu9w0bH0vfMWX1wCwdsioRn0oi81r08dCpSKu3l4r+xarm+g7iTYJ5g745ALmr/fiwCHRojtHFvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42UWP3Fo0iqX3vRsFB1dkDXlAZM1F2B2s+oPmN9jtPo=;
 b=f+nsyXUV6daSxH+5YDHz0Qy1TEBu3Z9yyT9HrlVM/III3vwHn8iKC+PEOAoFkU5RU9+OIf3d1yXll4XVP154v3JvBVwzK379dDtKnag1MeUyYcS96ACNDguN8vMaLPc3OVcT/Nf738b4lDuuholWdVxNQWo17lEekQtFxr4xi78=
Received: from AS4P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::20)
 by AM7PR02MB5942.eurprd02.prod.outlook.com (2603:10a6:20b:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 16:48:50 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::60) by AS4P191CA0014.outlook.office365.com
 (2603:10a6:20b:5d5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 16:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 16:48:50 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 9 Mar
 2026 17:48:50 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<linusw@kernel.org>, <sakari.ailus@linux.intel.com>,
	<harshit.m.mogalapalli@oracle.com>, <antoniu.miclaus@analog.com>,
	<andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: accel: bmc150: convert to guard(mutex)
In-Reply-To: <aa70ngEIxDNPYqky@ashevche-desk.local> (Andy Shevchenko's message
	of "Mon, 9 Mar 2026 18:26:06 +0200")
References: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
	<20260309142352.57407-2-rajveer.chaudhari.linux@gmail.com>
	<pndeclt5aup.a.out@axis.com> <aa70ngEIxDNPYqky@ashevche-desk.local>
User-Agent: a.out
Date: Mon, 9 Mar 2026 17:48:49 +0100
Message-ID: <pnd342954pa.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|AM7PR02MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 5423e709-2a97-49f4-7f0d-08de7dfbbd9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	LzZytUOe+23zBHCB7tWFN5CH6Tx7XKknT0PskkWp52Ua4JNvNuLDYh1TxPr9Nln58RphRDgZXjrK7fjwzJhOCHgloPH7Dk2RrrCdqjsWR4gTTudXpDIPWR6Y9BHQEwRuXxqXcWkg7c7gkz6/4627GBMfjTrwGvKr0ue5ovia4krMeQ2elshIioCNVUznC9eKHwGuEMnqfXuSk2H7c1Q3z1piMWu/V4mQUuqOdhBh8XV0lkjFccHicEDkQ6JGnXhhu/K9YUPi9R6tKQ4JcT9oORtSMeOgMcBykaH1NvuoDRsenPBGw8ttiVbvv21GGkxMN2ELbXWVG1DZZMGWTi9Wo8Ey2XUOMLilISpCGveUdxsdnh6ue8jaSCWf/lcG2/lunVAHkZMlO8JEnULKY7Yn4XZnBeEI9QUTTB4zOrySu+WdoFQPHW0+UOD+tzQ2u0o8Gz1TTUtudM/JvNSiEUZ5UOB8LvozX8xWFNQOqXe3g+NqbbYcFzdgAkJuOzHAzhFByC1mm9kabVYkDOEPYhcmIhovWTX0vicYVfWpbNwuCcHzBlmGsFnApC0PQJ8BL+0lpuUzLBATmFt871AixkpZtVnScDiHaNCOiEjNy3JeDrwCFjoDyEqwOOe0WwFZh5ZpEVRHcFHUzDL5AvvNOvnqsu19wY2Mt1aKubu1/PxnAnQJIDSIR23f5LdKr9TrZj8aGlVxbsK7f0i8h5JIt16a9i/fxocyvwR3m6tznvYF6a3fOFZHq7/xtdHgBscmfoVQesF1F6mWGrqMJg+54vhigQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NLdlGWndrBbE7mAkxDJQbl3T1ycUIzZZK0+V1Cq2WkUjOZ9ax2EPzM8UJRp0t/FMhCfHHon7W3p3zI+Ut4pv4PyO1/9c91LtFZnXXRrJmFWHtyz79orUKsDwwK4etEgrNMTx99AR5IjbIxsFaN0+HaIS1NwXDWqKHOLmVPvhEh8esfAKggJZ/jNK9ul9Nb5exu8pYfhOU+WxO0z2rHvR9c45bJqMOi1n0hWtH+oKwNUB22eQ/w9IzpXA8heEkSxui0P9F70MitNnHpWe5uRXcFBfq884jNrVIs3cWHa0VLG34nDj9/zEwDtJaXotT1yM3Ozocf2fE9qu9PhiKdmi+mV6Ejn3eXuXaaya0zvNplGKlrD2+LUWBx561ujmzFs75PUyfpgEEwYtVVRLyCEPa0jHkbzqAYHirb2UkjxFSwEvT08K9JmaejLWPJ1WO57u
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:48:50.4272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5423e709-2a97-49f4-7f0d-08de7dfbbd9d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5942

On Mon, Mar 09, 2026 at 18:26 +0200 Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 09, 2026 at 03:35:58PM +0100, Waqar Hameed wrote:

[...]

>> Why? Think about traceability (bisect etc.).
>
> It's all about maintenance and development. Easy to see where need to put
> a new header if it's not present (also easier to find this at a glance).

Totally agree (see below).

>
>> This comment applies to all other patches in the series as well. I'll
>> just state it here and wait for V2 before taking a deeper look. 
>
>> To be honest, I'm not even sure if sorting the headers is a "valid"
>> patch. It's just cosmetics (and there seems to be no such code style
>> guidelines)...
>
> It's valid when in a series (not as just for the sake of sorting). Here
> it would make sense to have it as a precursor to find the best place for
> a new header inclusion to place.
>
> Guidelines here are still missing maintainer preferences for IIO subsystem.

Yeah, I guess that's kind of the issue here (or in general for kernel
developing). Every sub-system have their preference. You just have to
carefully navigate through all of this :)

Moreover, I always tend to sort the include header when creating a _new_
file (for the reason you stated above). `clang-format` does that
automatically for me, though you have to modify the
`.clang-format`-file:

diff --git a/.clang-format b/.clang-format
index 1cc151e2adcc5..f6631d03bd3f3 100644
--- a/.clang-format
+++ b/.clang-format
@@ -784,7 +784,7 @@ PenaltyReturnTypeOnItsOwnLine: 60

 PointerAlignment: Right
 ReflowComments: false
-SortIncludes: false
+SortIncludes: true
 SortUsingDeclarations: false
 SpaceAfterCStyleCast: false
 SpaceAfterTemplateKeyword: true
 
The reason for the `false` value can be read in the last section "Extra
features/option" in `Documentation/dev-tools/clang-format.rst`.
