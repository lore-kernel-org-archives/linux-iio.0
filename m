Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AF472F63;
	Tue,  1 Sep 2026 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251763; cv=fail; b=IxFvsk0AwICa8lZoQ0clO6axlhy9QpnJHOqDM/J69bSs4WrNdq+QpEF/6W0Ko6vkwvnfXWdNA7pTeqeEvDFVz9LdsSvEF+yWd3rFDYSEWLGk7k5N8GJFmnGOEA0srDUwsKH+PPeMk+dcaMjgl82GAME95BBsFxPVAgcwSAZR2B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251763; c=relaxed/simple;
	bh=rW/e7bQyvTlALSj4slK7teQbiif6DCaIScfeYUqMb7Y=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Y4CrFWmstss+eJTH3xCMv97msrP1Y3YgcnIITAt6e7UTlwa4beB2VPg3GAwNqRkL+JPTUxQGtZ/kCGm7g1QHSgMWDWu8rBQWMQ2Jr6ENisE1N5hETmWcFSxnqbiYWwptmYBG7XiaJfWwmD7MnybPOQNIiDCgoMj9WwW42Bb1z3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ItACkw+/; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ItACkw+/"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817C5H83965868;
	Tue, 1 Sep 2026 04:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ls/uF
	9dw1E2xbgiOXFnC2O4k2gbIKFz0I8aqBe04sgg=; b=ItACkw+/LiHu2YNEkASRg
	AYk6sscAs0g3fPA9cEoCsV6PsLFmDpgLIXGRiK/qhLoiO5UN1CmFZrE20dKQGTrW
	0aJDB9bGgWdqVj4+bFf863hrMWcutBaF1opKsa+LIsiG1Y6wZUpBnviNVUnQAO7y
	Q4dtPA+RDDvQCWvRNAhZlURk42O+ZDbihBakmi5ex7jaEhRJHL0kKcDHYtEL2GvW
	/P18fg1EGYd8ed9m59zTPn58jaG0aANggtRncnNQ3neA7FCefa0sCW0dyOW3VaCp
	7g/JAcaJTXY30c2c196/oXar6wkoZnNoBq0To7Q06ed2Ny1cYyFreuZYBr+LKiNr
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbs914bx6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 04:35:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKy/vGeYSY7GMhZGFz3iTYPHEWBAnK7Cq0n0jOTRgno+sZfXzy9G/3+9wfzADtSaCMeaDIlElVgcWDd+6dx+uHVz9yc9iN8dz0g29T+GmHvN+h/lUB2pbGRb9j6f97J7zSQ2Vu6kj/ip1egalVmyAilxnPHHDBGfWPhS3TtckEHDsKxQL/5dpvd1QfOu2/tU9fAqOYLxYldMcjRBbHm6RNqiY16LhVqS1Rw4fhW4KoFWovgHLQgAtMksc95uKj1lajaxzzUSfW9+pWQNBjU+lNchDsYpFj4z0ncEadAAyc98wJqAs7FI8e0NCDnimg8BxYXqtsJmuRdstRpNh5VMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls/uF9dw1E2xbgiOXFnC2O4k2gbIKFz0I8aqBe04sgg=;
 b=PYo439kU01tyOI4YmCUd1SCuZwS1OtM2uMQTngcXuu2J5URbjWtpLDVjn3fJS38O46AXPlUoosZA19r5YPvk+V1vjmNy3NKJCRBnJuxoMbPVl8PQaJOFckiZwrF60LluAMfQ3ACT1VvRRZ9CwwRRgueujdqE/8rIuhD2EpkNnUTTkmj8k2QrRi6bOqVfYwdyybEzjHDWca+U4KKfQnXQtNcWPuslhgggf3OcxBWA+vMVfcqRfUU4fHLbjt1zRIkVxVz+VsEnWZYzfWUYJGIuEQ00ztSy3rREe96448WwBuNWcq19x2r1L17Jht+MvETXS0Us4mW5WqOqFOQhd1ZmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:35:43 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:35:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 3/4] iio: accel: adxl367: use regmap_assign_bits()
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux@analog.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260821180753.4633-4-antoniu.miclaus@analog.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
 <20260821180753.4633-4-antoniu.miclaus@analog.com>
Date: Tue, 01 Sep 2026 09:36:48 +0100
Message-Id: <178825180863.3241.2697978050195970953.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788251816; l=456;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rW/e7bQyvTlALSj4slK7teQbiif6DCaIScfeYUqMb7Y=;
 b=jrDfjssDcrfGw3vkdJ18UgDF5c6xuQilts/OQDa+lhObEXUNUtDgBH9EGgLbJh+pvkMhQuPgI
 HS5jbkdbqLPDqMDL4UgHo7WDP1E1k6PW7QL+eh9doOYE4dlTLI/pGdR
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 905ea04e-7637-4b0e-0ecf-08df080402e4
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 k8j5EMFsYoAKH3b0Za2pi+U50lIFJwohSHSEe2XKuo6zSxYMk0pxXapOUtplzjC5zE8ZJ20p/pgynr9dIOApv9dVMap5WWYXiiq7SBQOrhV2/2DpaTmiew9qWQj1lkKNKccxGQBjg2KjHYvWFo6A7dT2GYYjjYNtzw+BR1+UvnwCV+vmkM5BkhPKJiDBl3Zss/ZkWpXgZHDu8GmzFL7aLKpVQWAeWZqh3mFh+4Xw3CoF1s/3bvdpLAcUHQHHOvBCVgTE0NurLSB9U8isgDTs+Qik6Q6+ZJYsZOiA32rO4gspERKFgC03r02NXR0AW+2luVNAc4HFV+3qTD1eNIBAmX8NeF9DRBbXZgBO2IVYwPqeBcmK8yQ3WqIb5cRAQmDffv5C7p2QLAhun3lxvxw6DPugheFy+GR6qchaveJLksyfD8cKWl9spNHi9L5gb9XzBGHdwokH2QTEKsQoZwX3sM7rh95+Sgad3988KZsXmbP6ZJ4Ys3l34awXqiyR2F6kxN+lepkoeIxczvDJ5PqYjNVLyp92ZRdX5FOosP5+Yu/m1UWFgIwo2mo7NRJpJk26Wp7ZzMLMmYpCdjRsLB23hbXr4teK2gZoDdNxU/klkIlnWLkJ/8k4vxsqu2VUDiwlpN3EMTJRSuWagLy34qQV0rAcMQ0nt7nHFZGsfYaRER4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?anpFQ0Y0c1NvUXBMQmVBVXI4V3FuVlBhcitEQXhzc01kYnRDME5na1k1MTJG?=
 =?utf-8?B?aGZ3WkI0d0xIUFBCbWtvY0hOdVYzNEUyeEhPSWI0elZVeWhNeTkyTExKbi9m?=
 =?utf-8?B?QXV4bnZVUHcxOUpGY0RxcHNMbjdFNkEwcW5CSE9tV0lZVHRFQVA2V0hZZEIy?=
 =?utf-8?B?cFF0ajJzcVBSbENZUXlkR2pXRitiOU96UWlrVVA0Tm1qTjA1eHBVU2F4RzIx?=
 =?utf-8?B?ajlQUjhkUVkzVHlEVGJFM3d3VmgyYTRkMUtHY01zWllXS2MwS0t3dnJQSGdG?=
 =?utf-8?B?TXNhbWRvRkp2SVdsTytLZjhJR1BkR21abVNZenV5ajg5dVd2MnpOaGl0bVNV?=
 =?utf-8?B?ZzY2N1dVbENheWZjMVlFN2U1dDR3ZUhpT0NIbjQvN29zSjJYNHk4NnRZUWlB?=
 =?utf-8?B?eHBLWGF2OEp2RTNvSisvSmQ1b0FxZk5Za0NXNWIycXAwSXBwZVI3Vm9FSmox?=
 =?utf-8?B?M3R6aFpFS3RNSHNjMDE0N2lZb0hBUE5DNmlienhTeFFFTnpoRnFLWTdGRWdr?=
 =?utf-8?B?aXkwRnJJWU9HY2pqN0N5UWpzRVI2NlpoNXMrdXlsYVFjaHkwNU9pVVBMNXJa?=
 =?utf-8?B?eHIzVEJOWWZnT0FyaHR5cGMwaUNIOUwzZFJnOVRZajlHTUIrZzBaZzJDR3V4?=
 =?utf-8?B?R04wNUtHcjZZODJvRE1oUzc1WnJ5TzNNd0g4aGdrOThuejZ4eTM3NFA5KzVp?=
 =?utf-8?B?c2ZWK2N6N3g2ZkNXVHBrSEpxZVJwTytIcUcwdlR1ZDhRc0x3NGhPVjMvMEtT?=
 =?utf-8?B?Wm5KN2FwVHJBZVVnRmpCazJxYlRURlVVRThZYS9wUlRSNTFnWkRCR21oNTVr?=
 =?utf-8?B?dFdqdXFQeWJzcW03aXZoMmZUS1Y5ZnV1dFU2bWRycEY4VURicEVlZHNiclF1?=
 =?utf-8?B?ZWpDVURDSDZZcjlzaFhicXBYVkJ6TkVPZVVLTkRFcnV6MVN6R1JpYUhLN2xn?=
 =?utf-8?B?c2w1REx5N08zNUhVd293WVNucHgxZk9NMkgrNmM3MGowbGszdEtYcmJ5WGNJ?=
 =?utf-8?B?OUtRK0c1T2hRSlBJVWsyWXo0SVk3TnU5UFNON09PcjdQdEZXMnFrS0xYS3JE?=
 =?utf-8?B?M1dyYTEzY0pURTJTYWwycHBieXNucFcxYzd5ajZrYlllMHpocm1ZM2NVUWZx?=
 =?utf-8?B?c0ZEb2dtRmg0MS91dWNIZXhxQmV6NjRlL3UrNFQzMnVKclVLM2t0MVl3djR2?=
 =?utf-8?B?S25FNXFzRlovNExGZ3c2WDVaTCs1TTBybFlhdXZFVUR1NXg2bm9ZeGh5dW9q?=
 =?utf-8?B?dmVvVVRpOGh1dVNFVE5VaFEwOEpWUGZaNURMNERkN2hpUUFxRW9EdlEvZzZW?=
 =?utf-8?B?T3BHVmY1MWtlTGhyY2hScHpxN0JUcHVxTE5ScTNZU0E3eUJUNHNEOGlnWlBI?=
 =?utf-8?B?UFRZVGp1ZmlIdmd0S0wrVFlWLzVVbHNmR2tkL3QySUxzYmhlUnNobjFBR2dG?=
 =?utf-8?B?cFJzSlJCZ2pValhDVGVNSk5xZXlwSjJxQU9wZVRTOTlnY3Ixc3hwRGdoL0V4?=
 =?utf-8?B?Tmgwa1liMlNwQStHSFJXbkptU0ZTVHZyb0dCT2RlYUFzMWRLZnBwRVEwTjdp?=
 =?utf-8?B?ajNXay9zQ2dUbGhZU1B3SVJ0NjFFenAzTk9GZDJqQmtmeEpXdFdoQ1YyQXZY?=
 =?utf-8?B?OUp1YU9CcXJYNWp2ZUFIbDA0VDk0azlaYXdZSzBMVVUzcXNEczdVTU9URmtx?=
 =?utf-8?B?WHZCclNEQ3lXbmZwS2V0emY4ZFI1Q3p6aXB4NzZ3UnRKSmlPMTNCcElZQURQ?=
 =?utf-8?B?cjIxdnkxU2FCL3haQVBXZ2taZWZGOW9QWmJZcyt6MXdXVHFyRkRvWGFTTjBB?=
 =?utf-8?B?aHhMa2w5YWZTc3BTeGRpQkFjTDVodjBwUkZac2JhaGQ4N0xDcTNMeGlDeEVq?=
 =?utf-8?B?SDdIS0orMHltN0YvQ21DQk5yMjV0cGF6cGV5VnV3VWJqQVJuVXVhcmJRbnpy?=
 =?utf-8?B?VjREVW1UVXdybGRUTHZDeUN1Q2xWMzZBeFRCYkY4RG5wOUk5MElFZ1Q1blJP?=
 =?utf-8?B?MWZxdHNBbTBIQkp0ZkRWWTlCVDVKKy9FZFpaUWxsaDVuT3Z0eXlGWXlGekJ6?=
 =?utf-8?B?Qjd6b0NKRHViaHcvaSs5bGpIS1VqTEkwcUx0WktYUUY1cWFCMG5BWTR2WUFX?=
 =?utf-8?B?MmVQdjZ3RjQzNHhYQ1R0bVJOQUo2Zi9oM0pRbnMyWjhrVmo1ZkRGZTl5QnF1?=
 =?utf-8?B?TjBYNUNKSUJHUHBEdE9KWnBQemRmeFU3VktDQkFWUFV3NjlTUkRvMmJrZ2NF?=
 =?utf-8?B?dHUxZFB0VXpILytiaFdqdTVSelc2TXNVZ2syUVl0YmJOSnRSNHB5OEVibHkw?=
 =?utf-8?B?aWd2YktjdjBxRkhIc0EzWVUwVHJMV0l2S2pwMG5qVXBDTDVwbEhLdz09?=
X-Exchange-RoutingPolicyChecked:
	oB/wzTxtz866qIeImJQRx+i/AynrdTQXHoAjNC4WO7TF9ZkXMMnswYW/Oxv5lpiE+tvtQyboyBGw/b9TKF7BlwW9LIQi4SccSACZ/XC+6cx75qRYVKiuTwyH1xU5p/zzuuP7/65oTHPtdrrNpMCJmZvcvbBfCe7McGmvxX7sbYvhLTgRxnViB8TCuIbP0/UWKKd0khACaKoJfiz8MFPIcT7IR5ByiWg0Rctc/3KDhyIKMTD05srx/iDhusUSuU1FwvSQVo4wJGY+nnwWyk1HHNn7tvTj+649aJDnwFMz9V6B/an1/zCPJloZC6P3b2KkubXpL91cnQCiWN5s/b9rwA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905ea04e-7637-4b0e-0ecf-08df080402e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:35:43.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8W51wUOlB8ARpwLxeQXTunadzjX5r+WEHurznDntC8d4GLOon+3C/HcInn9gIi6R71d9Iq5rJ4WYEr3Ii7aDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX5yaWtSw4mfZU
 gcyLOZRXrUqNSUTgH5CsO8gGhoWJ0jrW/1Pj/xCFUBExwr6aX44/xGu3enwqj+/7hBKjxTv7FxH
 gcmGxoCFjeCRh2zOn4U06Nv5XPgMHcNMdRyW8kHwTbe8zkYLzxR6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX1d1M2INcht3E
 BD8R5w6M5cb96ta8VofcPk7Y5F3VXWb8xiALUZ35CJVDZPaXSOrlCd1ZwjPQyZNzXDYm/y/phNW
 B1K7XE+WO7dByseajBQDYTJXZUCcBXxkp45DumPOdhb1Ilg+zYNlUzodeaObBe533Re1CqVPvDJ
 +k2klVrvc5kQBZvDtml4/qqodeesSyo1vY0DLQQ3JI5rA74K7sr1kJblBIP0lgOMaceOcZk5iMF
 oYnxRvitDbI1a00rEPrNnH1llvMxcbxL4IwEjxEze/3dZKsdUM+fRFYGBUFsL7T1KdYLTwGRWaU
 kf56bzSnAaHQFE4t++5/K3IZW46cLwsRCY0yQqkbyLkrCDkb2bcOl73remmToV0B0EULd3i+N50
 0Cakmla6SjS5BQR5L64u5xi0wwCZ2lScN7KoVjjAErVY6jlTF5g+Bx2NAFvmV9F0MZPIv119MHF
 Ir4vV7khFdNml87EJ2A==
X-Proofpoint-GUID: 8MzDCx0X3RlozRgsmlTx4Sycc9QguE7U
X-Proofpoint-ORIG-GUID: 8MzDCx0X3RlozRgsmlTx4Sycc9QguE7U
X-Authority-Analysis: v=2.4 cv=c9Cbhx9l c=1 sm=1 tr=0 ts=6a968e64 cx=c_pps
 a=DmgWn/vclFWqUiYYRim7xg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=ca71rdTq6tLmqxj74RIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010075

On Fri, 21 Aug 2026 21:07:52 +0300, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> Several helpers set or clear a fixed set of bits based on a boolean using
> the regmap_update_bits(reg, mask, en ? mask : 0) idiom. Replace these with
> regmap_assign_bits(), which expresses the same intent more concisely.
> 
> No functional change intended.
> 
> 
> [...]

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
