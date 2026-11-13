Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590452;
	b=VOLb6A52D7esT6WD8kO1dfCcmRe6MiIdBtIbxtGUku3dJQb0CCoZDOjrQ9hG3RmJuG8Z
	 lUMwYkMHFe3sy0CZy8Nq1l0RV6Og16pVKMhmT9Qgh6Oc7WI8j3Kz5CvmfE+JRU9RNxP4l
	 3IVbJoSj5In6kZ3vNBe7SQUuI5Ua3ISuGdxm1rseBYDQ22VCKjB4rmDyYMRfq9LXj2DMd
	 mst8Wbzowe1fb/6+H1gLoPIIBoTPvBOQjdpuDhL4ht9vrcdAzBaw2T26u6O8o/zdghV8a
	 +GWha65f1o8YHTq9wcKrvkrLxxm9wh7SVUe4rS17Ui5s8wI4LIoE69BQKqf3g9h5ZAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590452;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
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
	bh=l2OOE/qERmA70BqT5CG8tFK/v3PC4U/6dBTI5EH9hSg=;
	b=ytYFJe1ezEpvqwBeoSwD6I9q71TkLEuS6Aar+lJ1abf8Yv8hDsdED+ktpwuY1fI198iG
	 a7rbPVtD5c4drrBQ1ph0ATTLwkxJKxO4TKJ89vHk8T+Fd8NnLlIXEFsgjpaKd82FqQaNs
	 4WuIiFyjBgAZAszSrOyMvRe90ljwrIpu0Z+8gfJuMQFHHBwyTtjf9yVo+dGx3BwT20TdH
	 rxuP95hlmlhV3RqpaTYTHJumtArsoiYo66UDWFpkh7hCK5zpNnP5uAHVyeg/PeO/iFjTL
	 HjA63IahMfhn9KgfNnf16saS0fAqpdpu2XcE/po6RO6BYb2x6FofaIJoyhlrQTA63aQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=A1HyUxCh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.17
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850D6070F27;
	Fri, 13 Nov 2026 17:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2850D6070F27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=A1HyUxCh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC583S7sZI0/UqnmjoMhTmFDfOKoePr1VmZJNF6fV8v/FH9vXqcBo8Ucg6m4N++3/yWalpFODNslv6AHxneGGJI2orE7UZeynqnUROof0O2jvtJhdgeWzhagLrMRdOmVmWBUHvk15rAzXakQMmMe91m97KrnJoWkPBVo2FktFkQkc/9ePAIT4YcRn3Vsfhx6obj8ZlwSoJxR84Yu3DuJ8BtVLN5plq91Q0vY/CBU8DkthOJLckbw0Sixkkmub4rdkfF1NJqn1IlWeNipqtDD4C9oQDJC2Cc1T37VVB/tm89rq4dN+TQ909k8+XR3jK4Fqeh1kw4orIFALRPpjpohgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2OOE/qERmA70BqT5CG8tFK/v3PC4U/6dBTI5EH9hSg=;
 b=s+KTtKMO16vlBsAgbl+h9q7e05qGSIiz1K94PtoPenCnw871bcdVti0xyh/M0z1/6zXCYgy8Ucauf7oHCvKdECzXoZT2IsougDrdRcpOvO5mEt0MtruL/P3zX9cp1W6BD86uTlsgnsmV5wbwY5pFwVrQo41+wCp+04r4JutweKXcgvdiLtCQ0mZoqYhhzPcWB4uMB2vUba45NzJdxdJV42yPeOypmvdu77Ngnd1I+fCQ5BslT/zbuWipnL6C9RqKW0GgnIDofAaeYd/eeF9Ij2zF5qbptRIe0+dKUnLpXOuxyrL/ZpUMgVLJGVLSb9Bfq/OKoagEX34M4VXXXrh6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2OOE/qERmA70BqT5CG8tFK/v3PC4U/6dBTI5EH9hSg=;
 b=A1HyUxChcBXuM8/sKM2dUz415x/pRZpiuskjkhQjYkvsVQ7EQPh4xPeGRffuvx7ZEyIq6XwobtSnFhQWsrvPeuRwMKydDDdo5AuVilS5TLULN8tEtxkagjB0BJXwbPfSrWompHueTnOQMgQEzVtiF6a4wpRgO8q25V2q4hGo5uo=
Received: from DU2PR04CA0216.eurprd04.prod.outlook.com (2603:10a6:10:2b1::11)
 by VI0PR02MB10704.eurprd02.prod.outlook.com (2603:10a6:800:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 17:20:46 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::24) by DU2PR04CA0216.outlook.office365.com
 (2603:10a6:10:2b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:20:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 17:20:46 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 13 Nov
 2026 18:20:43 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?Q?S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: Add Nicera D3-323-AA PIR sensor driver
In-Reply-To: <cover.1794589264.git.waqar.hameed@axis.com>
References: <cover.1794589264.git.waqar.hameed@axis.com>
Message-ID: <9df23ec9de5c89398b298983ab0d61b9b9c9f2c8.1794589264.git.waqar.hameed@axis.com>
Date: Fri, 13 Nov 2026 18:20:43 +0100
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
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|VI0PR02MB10704:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fc7763-ddff-49b4-ad21-08df41aa744e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|56012099006|261102123227099003|261021135927099003|261026121527099003|261026140227099003|261009223027099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K5E17kdQe48GDc7h7gt35n9MeyJUjgffHbS1KOhc/et1U+BbgKxCcd98W5U5/xr+JRePRZ4wqmPORkr3L+EvzZbl1ymBrSwuoB/FSUE9XoFfBIBZc3YghnK/6ioyw0eY76a+3VUw/ovdJzekMl7OEjr6vnbKPdvFq4Udhkadp3vwFjGeQjtv7s3B75pAS6tt7sZ0Tso4JYGR9SO8m8P88EMoHd6L4QPFyvask1H8TX/Dn/FfXW8snEJ/fq0aX72dzd+Pvo9r2sU1hZ5QF146RAAyx0Cb3PnW/vZFv27KYR3slDaAa7+BRYhPsldcjrSu1DkGHb2uyb0YvGtNO0m/g7ZUc6PyJXKOWzsJtw7N/hbbnqyovCScuEVraYz7PBdpjmZ7lrB/IyP43d61UNDY7Scmui1Y2ItMUkxap8Jo/Bn/yHRXcLJ68g4A1FhwTU3cC0w6gjrPRJwHzPycuMSA3hpcq9mJWs3DE7dSZMjw73+tHH3zbuEdpaHTE8RfQd1292fpDZKmvvFKKxQuxmL+svzdi6VskU3tJL8pPeYmXgU4NJNGhNvglTexx816VkhylaR/8NvlEVr8Nm049td3Xw2JPz/O45pI/WMZzbvq6iZhoFpRlJsATnBwHd4Vp6+jC/XoT2nSaavAEjLvNSzq/sIQtSyUtCYIJtfDWlFumrVqSB0pzjowT7d190kmwPqW3xBq351nLdgagol0AcP9eA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261102123227099003)(261021135927099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GnpVKIVx7+B1CZbNxi6aruzDG0gB2/1Y0AKFMsa586N96cbJFwD+OfglwiNWZxfti491BIPaQ6Xi+0sMxaOqUuArc9IalFRuN1tSmjIjq8D5dEGzgFJ6NNOqt27PCRMmY1Dq1HCY2oJmkLKnZLwmCOvqN+lx+sMYOKhXYgE+ZTS3raciAKndeWIvaKGYAFrCIday1/2wiRfc0Lj/jwADSHoqQGMKGIyjSf0t4oEfWj6fp0jFvR8qH6f7hKKxQx8xmndUQNSOplFldCmOOYewQo9IuuHgIUsybxZlmoZt/Gg9fKl2A5tm+JoEEwknb+I7F/xuGa0wLMz+cB0DD4OcSjiDbmNPYZdK1wUPri3CkmAEEaIBMqV2QqZKgKuickes+p56/I1Cc4ilqWUu8oN5pAAWiNAy6xzZUxm3MOPuD0/eG/iNgJVGItWGf8MIRL03
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:20:46.0950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fc7763-ddff-49b4-ad21-08df41aa744e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10704

Axis Communications has resources dedicated to maintain, test and review
this driver. Thus, add myself and the company kernel mailing list to
help out with this.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cf20f1a461b6..84f4fa2e91042 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19986,6 +19986,14 @@ F:	include/uapi/linux/nfs*
 F:	include/uapi/linux/sunrpc/
 F:	net/sunrpc/
 
+NICERA D3-323-AA PIR SENSOR DRIVER
+M:	Waqar Hameed <waqar.hameed@axis.com>
+L:	linux-iio@vger.kernel.org
+L:	kernel@axis.com
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
+F:	drivers/iio/proximity/d3323aa.c
+
 NILFS2 FILESYSTEM
 M:	Ryusuke Konishi <konishi.ryusuke@gmail.com>
 M:	Viacheslav Dubeyko <slava@dubeyko.com>
-- 
2.43.0

