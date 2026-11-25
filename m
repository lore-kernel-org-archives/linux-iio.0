Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795602004;
	b=zfJtYBu7qK1jUaju4sJmNI9g5G200VG7/CRc1/JnBw5HsWJFaQgJUyjPYZL9nre4Xxkc
	 fODxqTOfoOOXOFSi9QnGcR1Th0yj8Og9WMlcdvS00rEw1LXN5h26jcOn4GI5OFGRN1xUu
	 Eagopf21vFWMHm3Aw+8bCsn2aCGrNdf7l2kmiY0nUtSmWHKJt93YRas0rbIH97YGKIBPO
	 rb/XTX1d4TOxMpeJSzxU03KuEFtSN87HKdMUMtCwUOA92YCgiGTmhiDSSOPdAI03GKO2T
	 sTmHRYeiDYGpfIqL8vHcsSZCN/pLyYtYF/JMzZk6nqhRJtDpI3TsS2w69Gisq8iPzFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602004;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1QhH6h8HG4sZbhTo2C+y5j/zG8VhrKXGXLEmybzCo4E=;
	b=Zt7ctVyZWf8eRNtIg4qFHC/0K803iKSiRsT12cLtAYd3pB2QS/UjVr9qGw0Qfe6chJjP
	 MVWlTgUF62MwEQC3KC2oFjvXh2wqpvUcQOZP77ZCJNgKl7G6GGjRhbo1oHL5tHo7B4I7A
	 /eSBq/GRWmRRrekSzkyRz9/go4OSinXjyGQY51XQAzyiRSCClO1ORDNmBADaNZDmutLDy
	 LmzZmRfMfnJpPPvTa46rxaUz/tkX01C5hXcuKQhcPSt2UtymIlBChj9/AwF51z+4PZ6yM
	 dTCUY9aWU1ggj+4rFihf+zqlfm36Y49Lc9DP9Q0DE9rbwr0efs+GP+iqVt64TGhQVaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="YeI+Mx/0";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=bZftgbNP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A985606A321;
	Wed, 25 Nov 2026 10:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A985606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YeI+Mx/0;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=bZftgbNP
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nn8E1789396;
	Wed, 25 Nov 2026 05:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=1QhH6h8HG4sZbhTo2C+y5j/zG8VhrKXGXLEmybzCo4E=; b=YeI+Mx/
	08e8LQ/5MoTBplrpXJGpuOkPp1XhLhJ5/kOw+uicGexIt6jUaJBzDw9mJYIJsy4d
	01SrlgZVDwNYwAhUX8CKVgYqfAQrUBeUcS17+0ESnEHoAhZKLJZ4UnLx9eciussV
	WyMPO0vB3xSqPFS+5ED/JBFjdSvQW2FAYhfa35qbVpcRGkNwaZwiKVb3lOE4txzi
	l/H3B6KZIVcZRwtEUvaOMuduTHiZSCwDadpu3TKS4SOqF094XV9n53TRuGR0ghH+
	HpDXZsCe4uKDWD1E5W30PWYm0x5yVozftoAuW1I6+EgJ+pfAZun0PigYqAG+vUGt
	u5vqAF7EQGMa7wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1QhH6
	h8HG4sZbhTo2C+y5j/zG8VhrKXGXLEmybzCo4E=; b=bZftgbNPetNzFtfnoQT1F
	cBQFc66GgEv59ic7blHqkx6yw1zgCOxiMxNB/g+UPxVn2IkX0XrHk59V2+bt71fM
	pxRSXb0qm69eLS/OXUKSKLGygHQfH48Us1gjdBYZgksBrK4p5rhzvfe4R5Zdc3wn
	vulibL6FR08NYC2gCDuDr47P8rhd6NNYmJ1aaq/5rkwIAnWCfLsdSx4Kln0zB7FT
	UiwAJOXljcpcJOi0JtUjZtt/eNTAVz+pcYHaM0SnSuc16zkr9Mi3yXjp2mwvmIYC
	KPRjo9A1EvlZ4X+GoXLhXdzvOOE+zukjrwFacfI47YDNsMg7TUkxZU8ujzibcamv
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j5db6dfgf-7
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 05:19:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJGRLxK+nnr28c7xhUW47ou4un6RVjOjslK3ZV96516N0P2vV4NKRlmssmO1o5/UeLK8PNGO0o6rGrvHronbvWz85Dal+ZrmP+iR38pBwSP3E5xcGCSZCFZt4kWFh1omZ/w9twjdqbAiJHF5lCJty4cc3T/VkoVyjuogYktLMB5U6+cCWqJPTceItdp86Z+KYrPlJfzEqLPo6Rj2skSgQw9gV+78ShszdpYaSdBGb70JM+JNCMFIwJGSm1Lm35uPuUUKtMJNKn1O+TMqU6TOtO623uD17rQfztO2rAAcGVyqfva/D0EUjgRSd3LwzmAt6WAQLf+vz1cxs+K6pLoynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QhH6h8HG4sZbhTo2C+y5j/zG8VhrKXGXLEmybzCo4E=;
 b=mP268myvFL+W7iaIrtQoCZZsJofqaiPLaXBE9uJ0esqXQ2gL8ptzfHCr5SInED8WvFFhmZbXuuLOU9KdVSiJ48DNr6Eb1Qqtru4gRTqbMOurbg7VOxTX6nGLE2XFAdy6M0isoLqor5pUAWezZ05VGDwkwMrLhSoNuH1PDNqx5b4dL094Km1450rvyd2wDAL4B5TJ6E7YzDK7N1gKqGIj4whJNZR+4+NQlJfPOCObu8WJoTS7G2KlZLhvK4OHKaYFKDUAk+dEyIkuUjMAdOI276hoAqV0BZvQSJhRS9F4LXpRLwxNRaXZqUEkHcjEbkd7bUgW2rzAN9Df2HUzUupwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN6PR03MB7573.namprd03.prod.outlook.com (2603:10b6:208:4fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:19:41 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 10:19:41 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 25 Nov 2026 10:19:20 +0000
Subject: [PATCH 4/6] iio: adc: ad7791: drop platform data support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-iio-adi-legacy-platdata-v1-4-54e4c8830b57@analog.com>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux@analog.com, Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795601958; l=3318;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=lh8C9bytpfeoRUg4PmVFcnm7TDhPFzhx6ITMLd1UPDM=;
 b=nq/Y9jW23lb9kYthgcGcDZV0+cN8YRDu8UdodePI3zdZyprhjohvcy4Away7JVZkdRZ95UDMo
 Wf0Edw4viLvCWDvVTE5uUlHUSfJzlaT1sU4PRZizFU+kUOKyELDFpMb
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN6PR03MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b9817a-6295-4b14-af5e-08df4add9e1b
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261022105027099003|10067099003|261026140227099003|261022075727099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 CNcJywu7O5Ct5lQkz7a+iHQOferQD8emQKbnH0TUz7O1G7azzSClCnMP02RE45OkXY+HtNlXN4mbL0bTgXOhVQqo7AoYoLbL9iQMxhkdRWYm69NqdRbB9mi9FgdPJTABfG/aIMEWYX6krERzwgRJrmAtk3m0XCU6vhhYEFlSXNe90FJOaxsC1nCv3+jj9RUoU+xH15xefwBpaA3in9fdlPe+rSlF5FYNyIbX6FogfSIPmGXzXIU57NmiL90wb8eo3n6TetfdcI32arI3GQoGzJGwOaoLca+6b2dNIVfO1rwMCq7ZpmFnw1T+Oxh5HurIsG+mrz5KbxjBTaFexl0f/VIcg3ECJI9onpE/JP2nAH/NeYQ5fqbcXRpJdGqmg9hlSdo1gKl58Ia2rZE7oG8CheMmASVzAelA7W54bqJbB/RCl4GRNSKv3L3I5XcGtfcFyLyMZBYWTyupIKfS0Yj3ChBfzDu5VkxsoIWyHRBbeocF6f/GXWof11/yAmlAKLqgyPuqTAPGP7CUnPo1bn2a/3N/1jF0XGiTn0cOESbkLFK1Xw92d2Qfl9GfqZAXTZ6Tcy8iI61IEfC36SLpjg1McfVQNI/ybaS6wH1AUElPt7Pj3ZcFKR8j4wBnVcCYuXNWv9pt6LekxwUq0rXdpwX/MIjZlkOU3pNfyBRgRLAFYpA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261022105027099003)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NzNDaXU2OTcwVHVHR3R1RUQwUkVpS1g2TTR3VGkyMzdWTWNHVlVRbDRIblBq?=
 =?utf-8?B?NWUrMlVEUUw3Q2p6N2lZdGpaTVJhcFkzSllUclQyOWlzSGcvT1hJZ240clV1?=
 =?utf-8?B?NWkzdHJYY0xGNWdRNWc1cmZ1U1Ztcmk4cHhhN3lDSjYzOEJObWtkNlBoaUxs?=
 =?utf-8?B?aTFxVTdPWStGc1FHQ2RMaG1IdTllVXYvZE55QmFPbm1XdVBZd1R1YXpkQzhH?=
 =?utf-8?B?M3l2R2pqUWVlWitwaGgrdzRjOEtaWVZhZEs1bFlDNDVnenBkU055OWRYT1Bh?=
 =?utf-8?B?Yzc5bmJDenJOeTVKbGFibTRzQTNwUWFjZ2FUOW9oWmFvS1hXanNzZ3VaMWVj?=
 =?utf-8?B?MVBsK3ZyQ0FKSUt3bjNkZTNOcmxLdm56c0NSZGVCdlNWUVR5Sm0vSENIazhU?=
 =?utf-8?B?enNIdWpMU1RLRDBJNjdxNnRIYnBMaFBRaDdjaWlwalFRVEFmRjFiUS9ZM0Rl?=
 =?utf-8?B?TVgvdzFrZlVjV1cwWXVJQ3Q0ZHUxbHVPYk1ZODRmczRLY2FwVERnTGNiZTFz?=
 =?utf-8?B?c0MxWnNjK1UvbUJQd0JIc1c1c1hlWlZqV2N4S3hjQ2VhN2FhdlBwSGNhT0c2?=
 =?utf-8?B?cGFyQW9nRW9wT1lqVkRNRDYvQ2tPd0pjRXdEQjZxeXlKWEE5dE9iNXlnZGdX?=
 =?utf-8?B?WTVhUFpjczRqc0ZkUEI3SlBPYVMwTGhUb2xJWVF0b1dacHhGeE1DZWlmNElV?=
 =?utf-8?B?UjdMYUJiTEJzb0JWRDhSejN6OUxwL3JubDVEV244SC9wRDMwUGlJZEVtck9y?=
 =?utf-8?B?ZktkU1Njajdab3RvQkFLeGZFcmlySWN5aDR1ZjFia0c3bHdoR3pRNGI5dXIy?=
 =?utf-8?B?MjBzV1pRTnVFUDFyd1dHOXVGcW95anBWWHNyY2ZvYjZJYTdZZFFhZEJnbjc1?=
 =?utf-8?B?bnRMMnc4SnloVUxwL0NyZDRFc2RRYjNNdE1sVTQwSjVud0RIR2pnVHJMc2JQ?=
 =?utf-8?B?aUo2d0t4eHRZbnZGbkRGa3VTZE5IYlV4TFY1cElORW83OVVlMmpTWVhlRXZB?=
 =?utf-8?B?YkJEd0NLeXZNcWdEemtoMUVaZVZaSktpa0ZBWlcvS1hWZFljblhRL1JDS0tB?=
 =?utf-8?B?UWJ1VGlBUVhhMGhPUDJKMXYwVUozNll1SnRsVHd4ZWJMOHZ0ajNHMjA3T1lC?=
 =?utf-8?B?NlJqRTR2M3dFWis5QnplMWEwK3lvUHJLZmZpS2hMcSsyN29PbE4zMHRYMWNr?=
 =?utf-8?B?Z1lqWGJzRU5USkN1MDB1ei9ES2h6Zjc2K2djU25GM01xMGVKclRITXRhQ2xo?=
 =?utf-8?B?eXlsNTRLYU5oeTBoWnpXZlJYY1FvZitkYTJVbGR3NnJ3OXZNenlSaVBuQ3Rt?=
 =?utf-8?B?VTJLb0tOS3RRUFdmSUhJZjVHTys4ZDBHdXErQnNuQS84MUszWnd4NldLK3NC?=
 =?utf-8?B?SkNNUmpONC8yNS96ZDlGamtiL1AxSngxeEd2SmNJc09ycmtDSllWUzh5YTND?=
 =?utf-8?B?Nm13OFNDdC9vdnA2dUdwZXdvUi9qRVdsQkpxUER6V0lNNDNNVGhFcXoxZjBN?=
 =?utf-8?B?d2ZBaXdha2JRb0crTmxYWXhkazc0dzJaR1IraWZ4NGc5RmR4VVMwZmg5dGdX?=
 =?utf-8?B?MWlsNHhFbW9uemlqU1JvcHFVTzY5emc5Rm01SXVtNkc4TksxUVBjSElnRUtO?=
 =?utf-8?B?VS9GQTQ1ZVVZYStTaFI5NG5kMkxLZjhtZmZxOTY4eVZ4Z20wbzNYZzVNcVNz?=
 =?utf-8?B?QllDSnVzN3pjdjFKcGkrWEhzSytPLzQzSmk4Ti9uckRxQm9PZHhFNDB0enhU?=
 =?utf-8?B?dnN3OUVvWUJBUTA4YkljR2VQMENnUlJPdzdwc0VFU2NYcW9jMEVuSDg1dG5j?=
 =?utf-8?B?YUl2Z3J5bG5WUE5wOThlcVJJcVQ1RG5zd1NCRk5YYUtOMWNwVnc2WCs1ZFpQ?=
 =?utf-8?B?Z2pXUWhEOE9NeEV3ZDFlSUpGRUtCdzd0WE4vNklJM3c5ODBmN3BtYktaZlJQ?=
 =?utf-8?B?VjJ4by93WjFLcWNhazlOSmVFZjNCL3lORXFaL0NCRkp4U1IzR3IrWmtEU05x?=
 =?utf-8?B?aGhMQTVlSzlRT0Q1NnAxTzZRRFFEdXhKdEwvcENYamd4eVN5MVFKcTArNHNl?=
 =?utf-8?B?aW0vWmVjb0dxR3FaU1NTS3BqWnFKOFN3Zmh2aVVuNTVLZGNkcld6QmNSczBx?=
 =?utf-8?B?eGZmV3lsUm9lK1VIVGZOYVpHVitXOGorQWQ1VGZtTXNmY0E3bWVhZFJVUnJT?=
 =?utf-8?B?b3V4OUNWNVRaMWV1YjFwZXB2b2UwQkFwcUtuMEU0dlo4UmIzV1FlNXVBK0tj?=
 =?utf-8?B?OGFKT2dOa0hIdDBCbklmQmxsd3NVeHJaTWV5b0gzVkZGV1JhYjc0L04ySk9V?=
 =?utf-8?B?UVNGUG1mMm1HL2J4ZXhnQ1FGSTFhUkpJWDMrNXZLYUhzQm56N1phQT09?=
X-Exchange-RoutingPolicyChecked:
	boaMPmzy9CJm9adVXBfF647LF7BlncaOsWhG7mkEfI+rslrGmcl6Y2wySrwqlPLuEOP5F93rzRMqLotG/qhcgQPBf4sxp3+cy0Jqvbh71QrmrGYS7QMmUtkz4oNMfjLNPiwW1Yu9anJVmES1X+uJd5FcsscXLnhl/9YpLqdn+Cqw/qWnAcXsLJKtBwSacUNeWx9hxy4HNZ+Tp1bjV0KSkpd2EHHcCT/pb4QbHfND1PpwJVJ+WU+WR1y6YitphWwNFkXsKlodnvBDn1WxD+s46cHXC/khrita822XW6DRkwDXOSoPBiiw7JL3VJF3DOMCH/tqGf5+Q2tVui+ioUdQEw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b9817a-6295-4b14-af5e-08df4add9e1b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:19:41.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVsYoKHrf5ryYQVeqF0DW/a1gNYV66rIVUpXKftDdwlx+R3CG0AHmSc/+XvmdSRFT4kuHJCqEYv9R5Iq1liuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7573
X-Proofpoint-GUID: Z_Q5RvFVCIsWpFigWEsLJ0zxM-kErMpX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXzMPFxP4Ql4lO
 ts7poRwc+doR/xi5dv5ob9ibHAmANYyfY/StzzlTrpWXk8vP+cHEXJ7HZLXUAwf9fWCsSXkJaq8
 +PWAO0MyckHVFQDYMyTyEkChVhV76w1XL9DWtw6Yz7nqFn0leCbdsDyGswHT++zwokBOfRFAY9p
 /LDK0BWzVmVf0rLOYogpVQrMl14u//GvS1wjmdhz34XxnFBy+VP1BPj8vJ5AVWYCIWUO5N9G196
 ikRd6Tq09MR1q/VxICUWg+Wz7hlWDJyklTW9q1M8OKUBttDPigLYYPQonRWqr/7Smd2nAqQUtcA
 i2fBrGE8ufgS3/ySh7vAiuUj0XzDY29jwdsWwCuL0pH1AgHvJpfzwkYyXp1X5LJMMemEpnVt1CW
 A6t/ry0uakzshcOBXX13wMEjFrI4aLLY1Cr2cdPlbz5sgeOdmRkt8flvlVWs3aQ+ZGcnMlwzJLi
 TsJtQk/fJcTY76/iM2Q==
X-Proofpoint-ORIG-GUID: Z_Q5RvFVCIsWpFigWEsLJ0zxM-kErMpX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX3shA8JZd7oJ6
 KwTIQrTbhBr6hqGoosSCkMhXe/MhMbxor0/tHMFHej4IjfyjXxuzPVUIyJv+7EZbB25torkyUWG
 UIaNAZOQeNRWt97P5A594AmkXzKkh6f1T0BiGKWPYToQ/ecaP/1n
X-Authority-Analysis: v=2.4 cv=H99OUOYi c=1 sm=1 tr=0 ts=6b06b641 cx=c_pps
 a=6KPqUB2zuHFFswelnWAHBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=e644-nuCMJy5pIWW9kEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

There are no in-tree users of struct ad7791_platform_data. Without it,
the driver already keeps the power-on reset configuration: buffered
mode (on parts that have a buffer), bipolar mode and no burnout
current.

Drop the platform data header together with the code applying it. As a
result, ad7791_setup() can no longer fail, so make it return void.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7791.c             | 26 ++------------------------
 include/linux/platform_data/ad7791.h | 18 ------------------
 2 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index c2688307bbba..1edc2284626f 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -26,8 +26,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
 
-#include <linux/platform_data/ad7791.h>
-
 #define AD7791_REG_COMM			0x0 /* For writes */
 #define AD7791_REG_STATUS		0x0 /* For reads */
 #define AD7791_REG_MODE			0x1
@@ -376,28 +374,11 @@ static const struct iio_info ad7791_no_filter_info = {
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
-static int ad7791_setup(struct ad7791_state *st,
-			const struct ad7791_platform_data *pdata)
+static void ad7791_setup(struct ad7791_state *st)
 {
 	/* Set to poweron-reset default values */
 	st->mode = AD7791_MODE_BUFFER;
 	st->filter = AD7791_FILTER_RATE_16_6;
-
-	if (!pdata)
-		return 0;
-
-	if ((st->info->flags & AD7791_FLAG_HAS_BUFFER) && !pdata->buffered)
-		st->mode &= ~AD7791_MODE_BUFFER;
-
-	if ((st->info->flags & AD7791_FLAG_HAS_BURNOUT) &&
-		pdata->burnout_current)
-		st->mode |= AD7791_MODE_BURNOUT;
-
-	if ((st->info->flags & AD7791_FLAG_HAS_UNIPOLAR) && pdata->unipolar)
-		st->mode |= AD7791_MODE_UNIPOLAR;
-
-	return ad_sd_write_reg(&st->sd, AD7791_REG_MODE, sizeof(st->mode),
-		st->mode);
 }
 
 static void ad7791_reg_disable(void *reg)
@@ -408,7 +389,6 @@ static void ad7791_reg_disable(void *reg)
 static int ad7791_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
-	const struct ad7791_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad7791_state *st;
 	int ret;
@@ -450,9 +430,7 @@ static int ad7791_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7791_setup(st, pdata);
-	if (ret)
-		return ret;
+	ad7791_setup(st);
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/include/linux/platform_data/ad7791.h b/include/linux/platform_data/ad7791.h
deleted file mode 100644
index cc7533049b5b..000000000000
--- a/include/linux/platform_data/ad7791.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_PLATFORM_DATA_AD7791__
-#define __LINUX_PLATFORM_DATA_AD7791__
-
-/**
- * struct ad7791_platform_data - AD7791 device platform data
- * @buffered: If set to true configure the device for buffered input mode.
- * @burnout_current: If set to true the 100mA burnout current is enabled.
- * @unipolar: If set to true sample in unipolar mode, if set to false sample in
- *		bipolar mode.
- */
-struct ad7791_platform_data {
-	bool buffered;
-	bool burnout_current;
-	bool unipolar;
-};
-
-#endif

-- 
2.56.0

