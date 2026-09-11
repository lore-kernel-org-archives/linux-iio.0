Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76413290B0;
	Fri, 11 Sep 2026 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147767; cv=fail; b=OqVtsCVy2HhrVbGuC2jtdK/CTnnxVZQz80jc6Do/9c0Sa+m16l7u3h7btuALCyuAC3+Q1GMMu1hxQvXc2TYfJED29Vn91duD2Gt6IiaUwZ1SHZ0yRC/5g6J+IenG1JfYx/X8MClM8zVlnFKtBu1o9ASkAfYV1TrElguHV632pOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147767; c=relaxed/simple;
	bh=JlvBrSrP3AS/idy56pCpU/pekk2KV+oeF9Ima3U9tGo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dthnfcS3a9HJWdxeVc9dAbGP8DZecn2zXSsgIKlZUNI+JAburrk1xk/p+HKXBjUEZ+jgQk2BimFt9MEzMOSHSfjS5odhrGoVmOFjZHVtikOF6DDnDLN9Su45P6A7NMMLOFvJX5TDYjZNp0K5mdy/SvoAwhclaS3z43K6YPeMRAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vlyTp4jY; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vlyTp4jY"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEjOTg2838823;
	Fri, 11 Sep 2026 13:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NYG1Y
	2lzyg6iKVuGzhPVhHBAUs03OoLlZRATtJJ9ei8=; b=vlyTp4jYPGs9lIvB2E97i
	2hNV8D142w7+uDe4P96n2fnVaMw0/CnBKMblUzqZB+rns/wH6++++Zh2LtWFiKuE
	tgMqQrr0ptiTvsa5dPiJ9/Z2adeL+XaA9e4bv5Ls6TrQ39twSBxH0TpXhUm203/t
	djsptxKbI1LEb4N1gkzYhcaylkH7ywcMTDHCRlYl1FAbJwA0oxc3AJdEyBv6DnmA
	vZC3vw7INbilPXFAZLrwRW+9kgTFo+Tm+UDMuRmDnJ3ADCtFtfrMafqE3/rsfZ25
	MEnu1LRm0QJD1bhxrVPf5hRk17f4aLmTHrn+U6dfWlrGFF3akm3yiyAUTwFtXXEh
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxd26t8-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:28:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC1PXtZ/fC2aht323lR4Weugb77A+jANzs4fQmL9mbRpIPnaDcRvNfs4n6+7B21sU513wOxkOmBvELJ7BLfeKon4oKRJ6dIMnAM/Yl36cvqW/X3za8hHxlvmFcDm3jucVggw7Wqkk+a0vqknYyRCjbcrPKolXNjJrzQFotfrkUKOLFcvfH+RjBxFIJkPS8ITqSjU1Vuu5uJII3Czid7E/8xzPUlFn8MV3WcprqiuRsUid2xCn9BS6P888JW0AoBHb1f1+zoJ69O+EyYZfeFooQFgj5rCeYb56aKrAOF9z+zhdvW26dxxBRcWsaTbrCfV0grcOTRpatwHkNGF+KlfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYG1Y2lzyg6iKVuGzhPVhHBAUs03OoLlZRATtJJ9ei8=;
 b=wjVmaSDvh1i7JbBqCblmRwAvGYe5HugLyE4k8WkwaQIdQPOvId/yRCr6yFSGyYofegNCYTzDvigd0EPMa+SjzqKNgUG7Rm+cwbcxK/NKE9DuIn4v4LZrngfnzrtyK5vPoMuBj1oS+4XxbneW0YjxCmZJSPPetHJlYfWTeqAC99q6wC+eGgMVx3qNzTuOd3xdtznNtUoEttqlWvTmXzumFtEtJvjBeZF0SE9OXFSVSxMr1sarFq0Eg8IlGtfoVSQjGwTP7RZN8GOhPuk8PSwlDtogsNETiEfEWi1xhtVC0+4kw32hLcc8kWhrEzfmvRdliKaIMH0/zJpW6GNQwllHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:28:47 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:28:47 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:36 +0100
Subject: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a new
 header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=3950;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JlvBrSrP3AS/idy56pCpU/pekk2KV+oeF9Ima3U9tGo=;
 b=OSFnDJKw/bp5GIa0xCz8N0CwWcM4iB9mKHwCpcVarkB41pph7OmZOOAmkEfoM0bRmjdd3qqu/
 dlp4d3uemDjA5XnETVnBy4GqEk2gGs+YEvWNcr+UnboueMQdFSVBcqp
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0073.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: cedb9fb3-f5c9-4639-0bba-08df102a22bb
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 WSOiRamZd3WTPZQ7ZSUSx3LVma7LFnIMYO8ob3AjHmCVSNFRxQ8GVfkDwPQKopzh1EOb4xvyPVpn0TaDkhleBsKyrUAWtv1rbvWw1Z+Ynxc0UBMG2kN27au2yBGogEMNrqy4xcWVaVUzjEkRiB9ocIIyPS+0E1/FNzg5ZBuUX8g3+T8YVRcBnNVLGfDzDvPdadVy59854hgoqr19ky2W6io6UP83Fex0Y+tTWZqvok9X4IAJYYqLhnu9FbCgrTL4TXaA0IxYtBG0YhPbfnTxYxVkYPDcM+zryr7F1cFhsg9OlXfbeomeZ5/0aPxVzaWZPtogky5xhJgGIclCIo4NirN3NeUCMmJ0cTjEb/G0JqnosiWVHrLweTgfGygus+VosfU3v6gO5CWfuAEGsAgWuegt0AZrOTYeQfjKWlmonCPh1X5+5AskZ9hCuVuoX5fq3livO1No71lPepMU7ajoyi6VCIekYVLOcNKUhX3Hy8yYvjZcG4ajoUEA5Cdc0i/CfGwMb5QHFYGy4LmmbZsS990S236jpsRBsuU5OcS8TJ2LTC78bdqyjWJd26V0PsvXNQ0ysr8IOkTVIEdNnGTKkA8XwLvauSDvWn/gN9TJl5rRF0/huUHThbxRRc3fUpUjyQYZuvL527/3b2PMaavTj2W8j7frpXJ4vk+jTNP/N0A=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TEZTMGwxaEluV0lpNDI4Y0ZGeUR4SE1qNGtpUW9YN3JGaDJ5RGVYaVJ3bFRN?=
 =?utf-8?B?bVptNm04cFhQTFRCUkpqcDcvbVczQ0VVZ2hnOFVWckNJR3dQVWp1cmpFVm1V?=
 =?utf-8?B?WDZlaWFIY0g2SUtBUW92cjJvN0dJTFlBWXFCZDJkeWZCYm80VmFpeHhlV0FE?=
 =?utf-8?B?eVNlRmtkQ2FlWVE1b05ud1BLT3Z2MVY3RXlGa2Q1VldBTG1ySWlrcWRkM1oy?=
 =?utf-8?B?WFdKRmppRVVkMlVTekhPVmVvZTczQkxmeVBqUUJsL2NjZlF5SjgyMmxaaldC?=
 =?utf-8?B?cW00M3VsNkxDRG9nS3ROa2xtaHNFd2RTaTJLK1VHREF1L05ZSVdZTWt0VStP?=
 =?utf-8?B?ODhDVzhXd2IvWUk4R0xQVnRaZWdTSzZiRldRQVh1YzlIblQ0b3lXTkJhQ3Bm?=
 =?utf-8?B?T3JJOU1La2xPVFhrWlQxRGlVbjZxY09MOURLaWZJbGhhekVySFhkbmdJNSs1?=
 =?utf-8?B?c1F2b3hDemRUVm9WRG5zbk1qR3RvTU5DVzY5VmVMZFZuSlk4U3JEcmNrVlRx?=
 =?utf-8?B?VlJZL3BIUzVzdFVqQTZ2NVBJNFV2anFlUSs3S3hjSG9hS2tJNVhhd0U2OFNw?=
 =?utf-8?B?WmZxUklTK3R6UExaS0huOUgwdGNOSFFUci95cTBYNmFvNVBoSUh0aWJMc3FO?=
 =?utf-8?B?OHdOLzVuaEpEait6YmJpRmwvUU1nL2VoRFhxMTQ5cG8zWUlRam10MUFGcUN2?=
 =?utf-8?B?RkpJbUtvU1k1RnY0OHdvT09ZNno3Z0Jzd2ZtWDZRUER3UkxPVHloVVZFenRE?=
 =?utf-8?B?UzU3RnlUTGZQVXBIQlFYRkpuL3dzSUVPamoyUWNtUFN4aGNGZUt0V2pRMGtP?=
 =?utf-8?B?MjVzcDNHTk5nd2JPNXhSWDZiS0ZzUVV4WU56SktBL3ZWd0lXbjJaWnhoeW40?=
 =?utf-8?B?d2tuSDdlS0orU1pXbGUrTmI2c1VXcGQvRzJsaDN0aDlCYUQ4VkZHZDV5WlBj?=
 =?utf-8?B?c084YjQ5cTIzNXNjeU9VVngrZmJrYUlGbVBhNWd1MFpBUjNWWlZnbmtnTklZ?=
 =?utf-8?B?Mjl5VytCdEpVb3ZuWnJSMGcySjNXVisrTGM1RTRZWmJBc0grWnhCQkphcnFZ?=
 =?utf-8?B?VU5Sd0g4M1B4WURrMC80WithTW1xUjhnNzNKcFdwMUlQd1VuZHgyUFV1OEpQ?=
 =?utf-8?B?SytGeTdMbjM0eEV0c3Boa1JTRi9ub2hpN1MzMlRZUHhJQmxEK1pDOGpZYU9z?=
 =?utf-8?B?WTg0UWJyNWtwRlpZNStOR3BWR0ZrcndNekFwUzg5eWkvTGhvWFY2bW9ZVmh5?=
 =?utf-8?B?N0VMejdaVWkwNEdaUEplcWM0c2hLZE0wQU1RdFZjZkl1QkxGRnFIRGZ3azFZ?=
 =?utf-8?B?Q01wS0lyV1Q1MnM1L3lTRXFJMHozKzNFTHJTU0kvaUtiRXJVWnB2Z1JtWUx3?=
 =?utf-8?B?cWFwMUpaaFlFWGtONHBxc0l0MTBRcWVDbHQwQTRjYkhoc2gybGF2RWlkN2xs?=
 =?utf-8?B?aWRHQnBRTUlTbjUreVN3ek00TWRrN3pEOC90TjhCejN5UE1rTUszRkI3WTZY?=
 =?utf-8?B?eHNxVE9iVGRoQzV6RjZBRVBpVjlSWTgrYUZha3pIVVpGNmE0MFpYejNtT1h2?=
 =?utf-8?B?bkFSVU5YeExEMmFTM3l3ditTdUJOb3VQWW1nOHVnekNRbzQ2V050WWtCM01k?=
 =?utf-8?B?Y2tHTjYwb1hVUlEyaGRubmxlTXBiMnExbmhiZ3VUeW8rNU1TOUg2S0pRaTl5?=
 =?utf-8?B?aGFwU3RVckJKemJiMWxZQWpHSzZ6Q0FYZjBJaFROOGZJSSs3Rm5JaFBwcmJi?=
 =?utf-8?B?ZXMyUUkvZmMzUmZLeUFyQkxKZVREdmMvSS9wVHlscWVpUWY3cm5JQzdpOHNP?=
 =?utf-8?B?ZTlaNjVGN2RKbUlDeHUzL2I4L3BDL0R3UFBTRkRIeUpQUTZ0dDN3MVE0aU81?=
 =?utf-8?B?cGJqSGxrNHlyT3ptZkFsN25BUjdLTXFrTkdJbHk1OFM0ZzA2TGhUeWF3MkNG?=
 =?utf-8?B?N0gxOE91akdaa1JDQVo4czdlYjJLckNDeEZxWUN1Y2dIOExVK3UvN1h3bEFQ?=
 =?utf-8?B?R2xLQkJGUmg1VnhQcE91WXNCTmV5bit0UDdwUnZYekRjREtEVjNLODdiVUF5?=
 =?utf-8?B?YWxqaU54U2NtRTloenVxZzBQZWowU0FYdlJWMlpRaFh4bkdSQVQzZFp4MkFt?=
 =?utf-8?B?ZXh5YWNnTjFONW9scFNyTHZmWVdQREdZbWRPMVZPZFBab3NTZDd5MDlSV09u?=
 =?utf-8?B?SUw0ZzhTcDBRR0FlTE9LNVhKV2lyb2FUTlJZV3FSVGxiWTA0SndzVWh2RE1M?=
 =?utf-8?B?Z1lBM3pkc3dHa0FiREZBejA3RGxkNmRKM0ZBMVhkM3YyaURwdWdPelVXOFhh?=
 =?utf-8?B?ZVN5UEsyZ2wvSlp2bW5vYVV4Y2pjRDlhRmQxOUd5cjlLRi9kS3ptUT09?=
X-Exchange-RoutingPolicyChecked:
	eGFolheNLeCjEhlCuoiqs+OYO9mfsYTjdyFpU1XnXJeTGfNb39juye1mWKolG9Pj26Ma1XwMWOYS00/DLv1eQs0XiKNJ+GJq0YWxvMQ3skx3WGQ1KswHKPOJpZQC7Ctr5q+1OanMaScAncgedaVlGGr4VE8kyQVTl1ZRyKv9ogkcUvcndZ5YH0vOhR8ncsbj7IDuKMYFnIlLIJ9kWfDQ6iKZPmXpTK7d47vOKf217VPDj5kIrGd72iVpTUm+lmYzRrzgl0Su2II5dBwphNncA1HGRkV/r3clumIKRGwFS260+CbsfA9ZDGynd8HA2chkNg4dmCqJsNjAIBj3VxtKpQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedb9fb3-f5c9-4639-0bba-08df102a22bb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:28:46.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuPlyoC2kgKhikfKyifupZFVl5tveOus2tZwrkUqhNWts3jIg8dh4TczayYEhWafjSGCeP+e5YHfoVn5bpXkww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX1HnJyX3L7gBZ
 OOIaeoIus3CP/7CT3NtXMeM7BBnFXE+yioW/yWp6DXkR+nBHqzacVJnk6/KFsX6UUwlQ2upxBb+
 qw8SbViGb15NXmw0hsf3r3yhBBg2wiVOnclA/7UmM35ci4Kv1i92aUNjnHL3oexiawuA2sMVLhm
 ReF/j0iJkfPCHwtDaQUNLWQ21kKtcnmXxuvfXJ6VDW/HwZRH7NChugu92zVHc9yjLql0QlGdp1L
 dTM0sb4UnI7pOPZ7Ay/BXza6o5OykDDvsmjUcvVRYROYvmpsl8LqXeZDrFiDaL2FEfJ2aBsNooA
 T2WzUNKYscuDGsieMs14N3I4WGyrEoYg4AKXoLncrG6Cu4UVFksSUofmpWoOVCK+VIUkG6htmWD
 Abvdj3GD0AJOUk1sdQzXmmvOpZh257jV343Pz3lKHzs4tPpbYEiJXWY8g2Qhw8vstPqIYTKeoFJ
 4hpVghnCAqQqnYg7ecQ==
X-Authority-Analysis: v=2.4 cv=GoTXaU1C c=1 sm=1 tr=0 ts=6aa43a51 cx=c_pps
 a=gJSDm7Sez3IyWyplfMHn2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=8rQE5u7KU4cnMVh7pvgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX6/rGfyDleOar
 2PCTCcOpaP+iRAnrf046/icdxbrs6NaV3r6krNhAqdQ/uA36ar56mppnzNihwqEQWb+3tJld4CZ
 bXoQWsKY5fBJvnMRvPXbSGy0pGgZieNrbFXDPXrDkgPQVUiIfBLI
X-Proofpoint-GUID: ilfFtJixFVeshb_YvaDvQBt_FeVGDQQl
X-Proofpoint-ORIG-GUID: ilfFtJixFVeshb_YvaDvQBt_FeVGDQQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

In preparation for the bitmap based bus width capabilities, move
enum dma_slave_buswidth out of linux/dmaengine.h into a new
include/linux/dma/engine/types.h.

linux/dmaengine.h is included nearly everywhere, so growing it with the
new interface would make every one of its users pay for it. Keeping the
basic types in a separate header lets the new interface live next to it
without that cost. linux/dmaengine.h includes the new header, so its
users are unaffected.

While at it, add the missing kernel-doc for the enum members. The block
already opened with /**, so kernel-doc expected every member to be
described and warned about each one of them. Describe the UNDEFINED case
in particular, as its meaning depends on where the value is used.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/dma/engine/types.h | 41 ++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h        | 20 +++-----------------
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/linux/dma/engine/types.h b/include/linux/dma/engine/types.h
new file mode 100644
index 000000000000..2e8a266e42ef
--- /dev/null
+++ b/include/linux/dma/engine/types.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Basic types shared by the DMA engine interfaces.
+ */
+#ifndef LINUX_DMA_ENGINE_TYPES_H
+#define LINUX_DMA_ENGINE_TYPES_H
+
+#include <linux/types.h>
+
+/**
+ * enum dma_slave_buswidth - defines bus width of the DMA slave
+ * device, source or target buses
+ * @DMA_SLAVE_BUSWIDTH_UNDEFINED: no bus width specified. In a
+ *	&struct dma_slave_config it lets the controller pick a width, typically
+ *	derived from the transfer itself. In a bus width mask it is a width a
+ *	controller genuinely accepts, meaning it imposes no constraint of its
+ *	own.
+ * @DMA_SLAVE_BUSWIDTH_1_BYTE: 1 byte wide bus
+ * @DMA_SLAVE_BUSWIDTH_2_BYTES: 2 bytes wide bus
+ * @DMA_SLAVE_BUSWIDTH_3_BYTES: 3 bytes wide bus
+ * @DMA_SLAVE_BUSWIDTH_4_BYTES: 4 bytes wide bus
+ * @DMA_SLAVE_BUSWIDTH_8_BYTES: 8 bytes wide bus
+ * @DMA_SLAVE_BUSWIDTH_16_BYTES: 16 bytes wide bus
+ * @DMA_SLAVE_BUSWIDTH_32_BYTES: 32 bytes wide bus
+ * @DMA_SLAVE_BUSWIDTH_64_BYTES: 64 bytes wide bus
+ * @DMA_SLAVE_BUSWIDTH_128_BYTES: 128 bytes wide bus
+ */
+enum dma_slave_buswidth {
+	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
+	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
+	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
+	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
+	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
+	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
+	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
+	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
+	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
+	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
+};
+
+#endif /* LINUX_DMA_ENGINE_TYPES_H */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index fe33a20abc61..573e5ea34707 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -12,6 +12,9 @@
 #include <linux/scatterlist.h>
 #include <linux/bitmap.h>
 #include <linux/types.h>
+
+#include <linux/dma/engine/types.h>
+
 #include <asm/page.h>
 
 /**
@@ -384,23 +387,6 @@ struct dma_chan_dev {
 	bool chan_dma_dev;
 };
 
-/**
- * enum dma_slave_buswidth - defines bus width of the DMA slave
- * device, source or target buses
- */
-enum dma_slave_buswidth {
-	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
-	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
-	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
-	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
-	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
-	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
-	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
-	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
-	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
-	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
-};
-
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave

-- 
2.55.0

