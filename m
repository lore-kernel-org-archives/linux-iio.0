Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048143DB645;
	Mon, 31 Aug 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176781; cv=fail; b=XMkI0a9y0j0ZmWftr/FQLTEqrq+dN2OM1SY2Ww9D7Nm9eUB4ZGy9Q4YTCPU1ocOQkMz43j32EakJywVkSApeqTlunOekMFV5f3vsxtB6eHJrgxKiqzeNEL2km4nBmp5WOweSGjYvPYQuu/Sg9mTFsQr6ce3NSKk5+SUqEccsZHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176781; c=relaxed/simple;
	bh=eVij2aryRxM7Iz/SXGQ1Bo/WIVJo9FcnI+r9ssDc4Qs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SZ5+IPe0wlfBHIk5/Ft1jqiWuy/0rpxfnk7cTwz4o9gJyff2/y61/O5lVaUj2S2IbkO7/JS1Y05u5ZFSzkZu1OAfN2ZG5zmCxIaes2Lamo8qtZVfGs5zJ5nqrXbNObjNsdJpXROkRuM/13OPd27vPEVCV0BRi0nvsAqJMnGr17c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kFrePB4O; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kFrePB4O"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VB9oVv305798;
	Mon, 31 Aug 2026 07:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6PZQL
	Asc0Bov5dshJTOYP+YiAtZRg8wxfWcQ7P3m9Mg=; b=kFrePB4OvE2KZHYpiLPza
	Jk9HXUK7I2Dz/o1GbOdXM03cK7AldHICs2WhBgiLVr7UeG7yRuucEZyoyGzjbpL4
	Ly13lXH2WW9V/FKznt5DHcfgCxDx53hRRjfRGjrThjhayc1QFies07bDThstv+nF
	zyE/+6GcipRIa0aGeruYM6b3MB7qT++gkngdK+HaOf4w7mliUAYgXc1MvXs8DTw6
	/YEAuXth/4PjTUCufVosHLpFfSz1xUf9cxRPluCdze/ksjvFFn3AI0pVtNyb1pKH
	akvegi8CIQvbLN4HqSy6rE/VxNeTHxViXYe2EnhsxnKaPlPQL49J/FNB2FPQ0DHf
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gbv24wmav-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:45:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vL7mE8H1SdrPfi5/D+ux9RTHJDUvNDg/5uvEjiMGl94mR1de62q8zLqeSetmAU54TU1CsF2XhmoWJxNhx2W0gjJJtHF4K94tcT19VtYSqZG39C3D1Y0/muce4uQ0j5ZrFwsYsVqgeSeNXNVHgVsNzF/g6vJ2wyrGO+/969DqEap4lZd5bx4jMPUeF62xqeTsASQnuHJ9J3ois2BvmlH0E0fmou4yOgZvyOeRBaQtV/sFnluDgheL7DZcv31f3M5rJirCFOsgcmeqOzOwprx41yHT8PuNnYZcfBW1/K5OqDkQLRIEn+enaKqvfIvWbJ+mOXUs+1xgqhy3Hl5pFMkW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PZQLAsc0Bov5dshJTOYP+YiAtZRg8wxfWcQ7P3m9Mg=;
 b=EJ9jlGlzJohcbIPtiZMlaknsvRtwYrbXWwrGXOdVIwDfDAfk60vxnJR4TFP0eGvRmwPA7bdxhifEhdT/iQKMvJ8E0i9SyGxdA19fC6z7MWeEkiDU9gXWJ6w0FpZZLpvNmM9OVstvoECQWGUYhQdipUY9mk4itL446XNoagbtrDhQkh0y6UJmeWDyxOcHcBijrfVMHB4yqiBbLRF0eubyfVyrS7i77d6SnTNBuJUW32TFXfIIQj3Tk8wHBU1LEYv664WYJ1l0BA5W8115KkQ6PCQnmQ0P3fYoEsLQAMysv74Bt6+ylFf2rTxaWHQ3yf5X/EIz6VsIek7dy+u9BNGCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:37 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:37 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:40 +0100
Subject: [PATCH v3 3/9] dmaengine: dw-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-3-507d97496f2d@analog.com>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
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
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=3057;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=eVij2aryRxM7Iz/SXGQ1Bo/WIVJo9FcnI+r9ssDc4Qs=;
 b=JqY6SHm3eOHGJulbftV+Dw/m1ZGn6BnoqpIRCcDaHTLB2FfY0tA3uJ/D6jQl/La5mIJ8JKo8b
 rbA3pY1iSiUCYaEH9ufkdkQLQbO3KoyiAyaQLt/QD0rMFV9Ng9l4xoB
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0051.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6364ec-7f3f-45b5-6768-08df07555fab
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 yiUe/ZTg6eTBqy3/G/I6aOZds75uGe5nOcUlsbFYkT0E8xUHfH7eM13Jfh57DGSi28FLSIYWlNJfhsJmbRxcqE8gsR4F//GvDMBR4VSYAdj083+C78EtNQ1MNrQ17DNdSHkIBZnyrEYs/X5Egq8WhecN/w/8Ct+UqmH2UEJKECblyGcZD1zOkztqlDxQRFpsdBf8YY8UeUXaaI7nWLpgp4IEa8FXgTEtZSqvZTHOKt/aXSV8taMSOIK+t4Cit+wH+e8/WNsgRP7HT7/RcpFLCC6HF6E+Trdemqig5I/OZRvRDRjzn9hM5opq1seDKIQ0aruYJa0yxZ5jEkt6p58O8AojVQdafoPReu9Mf2hPCDTg1MeSdirwW6Ymo//O3710Nv/U2DcF6P6ELKIGzl+6dY2OFcbMF4noHy5mzWF1yz0qFNc0a8+5EGbJhw3rqg2h13VSiOwGcHeAkoAf+GGITHK1ygeNgmRhxQ2pIcBOUQ5D1SM8ZwalIyd+hRjDYOy4MUySzm0TaRu9n6DlzdbU8f/jIpDBF0p27X+/+AhWcSwWpMyytQjoGZQUYev0l/d9A4lGeINoTCxuB8VS5xgjPc6nr1+3KQ57avFKFqd9WJcJtap6X6J1RVWi+OFaOaEjJXq1a1rkQkarTydZAtw9KqFtcntO208rroYiOt+wC6Y=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WEVPQk41M2x2b00yVWcva3FlWVJLQ2tGTnA5REswclBTU2pNTDMrQWRTR0k1?=
 =?utf-8?B?U1dGZGRDQzlNdzI5NzhVTm04a0pRQ1Y2SEVITnU0N1JWL0JhWHNCOU1qR21P?=
 =?utf-8?B?Mkx1WFNWQlRnY0V6ODdveVFIY1h3Y2Z0dWs4MlpNcEV3NzNnM255bU9rb1Nr?=
 =?utf-8?B?RmkrWFYvNW83OTlyZEkvL2pSbURQVnQxYXRTcEEvRHRhbFBhWDNabno5NmxN?=
 =?utf-8?B?aXFUMDdsV3hNMlozRlVRUHc3b3JvOVVjTytQdVkxS1FjWnJUUkNhLzFFVlBN?=
 =?utf-8?B?NTNSZ0pBQVU0eVRCWGxxcEx0QU04b3hjYlNaMGZiSzAxVHdCNlQ2Nm1uWG9w?=
 =?utf-8?B?SWxsS2RPbktta01uTTg3OHltekZpSVJhTFJoVWU0V29oMU01REtZcVJRTmcv?=
 =?utf-8?B?R0xTNGhBRmxBRDVFenlDdjNrY2JnTGhGN0VFZWRSbGxSL05ucktzdkMrbC9t?=
 =?utf-8?B?THFYYU1iRnpZcjBUT0dQN015elNLR2NKVW10eUVpZlBJZFI2b0xRQWpSTHlr?=
 =?utf-8?B?N21lSXFMT1F3M3ZiV1NTQ3VRbjU5NWVHV3N1RzR5a0M0RFNpQnlydE1JWVhX?=
 =?utf-8?B?WnlscENCeWtRT3dNTnc2TTY1Yk8yZXJZREtEWndlOXdaTmFJUWx1NnB1aHZC?=
 =?utf-8?B?R0J4MUhNKzVXeW50K3ZEdklUZEU0OXcvSlNHalMwdlN3S3RBMTNOcWZBanFP?=
 =?utf-8?B?dUc5RFBRTTJIa2xVckRTdHlFeHBRME9jOGo3Z0gxNjBDYnAyNUZYTjR2UTYx?=
 =?utf-8?B?L2I0UE44YzAxQ2pEZTBCaE8xK09WNTREME1GdlB5V0dkMWJyYS94VFhlUDNY?=
 =?utf-8?B?YnUrZ0d5ZUFETk5zNWhxZzZyWjY0MTFMY05tZmpjWUVCVEZzUy9TaElTTEo3?=
 =?utf-8?B?aWJtZWsrS09nTFVIL2oyRGU3Y25nUDRRaU0vWnFqWk92YUUvTHlMLzZDVkMy?=
 =?utf-8?B?cjB1bUVTZzRLOVRORkg1c0Vtd3hSRGRoczMxZXh4MEZrT0hDVnRDK2RYbGF5?=
 =?utf-8?B?eHYwTndJc29ySkhHZWR5QjBUdkdaTU5pNDBJMUdyeUZRYTJWUWRuR1piZTBt?=
 =?utf-8?B?VGlDYyt1czd4VVFMekM4U2NMK3JzRUl4amZvTWN2SDdSQnMvNkJ5dXZnYXRk?=
 =?utf-8?B?YVV2Y04vOEYwNUJ6c21nVnIvTWpaSk9NUld1NW5PZFBockhsbDI2blh2dWxj?=
 =?utf-8?B?Rm83SXROb25OZms0K2lobHdNU1pkY2NKblZkU28yckg5WHo3bHhNeHdZcElZ?=
 =?utf-8?B?OXlCaDJmQ0VWU0N0d2Z3UUdRS0hnb2JQUHZmNitiRFZpNW1KYjgrc3dJUXQv?=
 =?utf-8?B?em9sSmNvcXFjcVUzdTJtbEc0OTAwcTFMNVFXM2tJSVduR2VmNC9FbXZkcGw4?=
 =?utf-8?B?RHVXMEppbGZKYlBDT1kyRHhkYllGbXRxcmFTa2FrcVVCOFNWVFhaTWx6TXZH?=
 =?utf-8?B?MHNHbFQ5YUc1VkQ1TTJ0eUFJdlBPRmp3bDkvSjg1aDBYYUw2UUFNVEMyWXc0?=
 =?utf-8?B?V2ZUZmt4eVVMc05lNGJ4YW1jL21FYXlLV25HR2ptR2lSZkdsVERVSnFvbDJM?=
 =?utf-8?B?MGZWK05xM1BqaTcvWVZIRXRXZ0czTzhENjdkTWpscGtZSHQ1SkxTUFFjNWgr?=
 =?utf-8?B?UG8zaWpFbkxUVnhLbWo1Yk5hbzB3VEQwUkdoUy9UWlhzVDNGSjRFQURZdW9u?=
 =?utf-8?B?WVpwSTh0T2gwL2Jld0gzNEJRZEsvaUthVnR4dTdMekpob0xzZzlvU084bnBS?=
 =?utf-8?B?RU5CdlBWN1NyeU9qZDNVc1VDSEQ5bnRXTEp5cit3VlRaZGxQZDE4VzcwMG0x?=
 =?utf-8?B?RVZjdEtqd05WUU1JODJBY3RqcWxJVEdLaktsT0F1Nm9mcE5kREx3ZktUQi9M?=
 =?utf-8?B?aGk4RzdzNUozeTVTMlBuKzRUT0x4ZHVKZTNSRmtjcnpWUlA3TWRheUpvZWln?=
 =?utf-8?B?UVBPbTBudXAyWlk5QjBpcmluWlJaZkFoa3ZROTdSTFpuQnViempURHJNOWpo?=
 =?utf-8?B?OVlzeWMzNGEyYTdXcVlXcnpWeUQvWEIrTjl5ajM0TG5mdzJjQ0x3K0JqaGQ5?=
 =?utf-8?B?VjlOV0NXZW1McjQrYXFKc3dXNktZV0JKVS9mVm5JRHJnVDJ6OHVQOE9YK1NN?=
 =?utf-8?B?Nk1SeURrMks3aFFxTFV5QXR3SjVSSWFBTk54OVNyclE1QnozdHQzWmVJMUEv?=
 =?utf-8?B?b25HTTZJZ3RHclROZ2J1VHgvNnY3RU5PMW00TXc4M0pkdWxwY2l1VnhOTE9h?=
 =?utf-8?B?MjVVL0pNdVRUQlFDVEduK2F2RE42Um94aGNlWWQ4dTY1LzQwbTZlemYwUEhl?=
 =?utf-8?B?UGpnN2g0M1R4YUNzdHp5TUQ3dzduVmdoV0RIZGpPbTZSQXJJWFk4QT09?=
X-Exchange-RoutingPolicyChecked:
	ivS4cMXLvY8JdiNmDS86RSB0NbIzXPJ8SRilWK9CdylDthHRj8gy8C5q8Yd4pYFtqe9tNn1V4AkjZESTPK/cq/MnwlNg3lOlqeD9wUwkBF7FrCPKiJu9+t1EuI+VfFrN51lsy5YcXmCBgv+/096+WwEiO3PqewF2OXxDMrP52A+XeaxqGc7FyC98nK12nnG6/UQTLrzpp9LcyLyta7anx3Yn2d7FDXMToNEXMDHswMMCjJmUSY2fLAkmYj9ilqEIxv400Xuna3X8oxEruqdlV1pR0wrz7Am3kzOQJvUcVr8VXQrm5yrK0EAi31Ee9Pu8BKSdvHTkGaaOH9xgqK5axw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6364ec-7f3f-45b5-6768-08df07555fab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:36.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r558MUTcCzjYajk6CWQd5NbbyG2s/gPZkpzRrdBqJZCEj/4xDR71WS8utMBwIXn37Vd63fyB/3YIBZ/ru41o8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfXyVosF4EnD1JP
 uBInUqHTT3Fw51J4C1O+Zj52jh9cdd+JcsuerGQYI7+qQDBmnUNV60IpjbQ+75KxpjN+U/tncKL
 9FvlmN3xsCS5MwZIMKcoTmTSN9olW1VSG0/xdLgVzRclcmvqC/MTAO8Prl/vjhiJlKLe/cdWbDY
 s9kmISrRy31T0O50RJYm7Z9DOOHtghXp1PYhaaUQB4jL1csM/sBb4ZAEFI+wr3HNxblgVbSHwfh
 PEJ4F2qwCbvQSxRtNZ2fikFyBSotADS9f7JNKu8kzfIS8cEhCLZ+LqwY+k5hvHWcpX74hiIr+ab
 mX6zr+lG9a4pJCIAaGFvmIsfksGMyXge0Wb2RtAqkmRsWlYqGC8BPdVtdIz+CY+3BwfeHo47fmp
 mFCiajfxNa/6G0IqfBDED0lDr29HMpozAZwXxfq6sL7bc5PdPwtLNYW9458JZ9vd7Gm7euvnYwd
 vTpxMmGUJqvdb3pBMKQ==
X-Proofpoint-GUID: YL6pFWWl3EiRep9hLVmrkV9b1Ee7awGC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX0sUbJ8Rn6sud
 7yq2WWVkRhU9B38Hp7uor3RfBUB/PJIP1IzuhmEHtqmGYeC2dgL6o+HZTsXtquQa/IJOmLvb3IV
 PLFl+z9EJogTMyqqdrLE889lke5XO3R+3SwCotU6ZENmQS7NBdYn
X-Authority-Analysis: v=2.4 cv=etTvCIpX c=1 sm=1 tr=0 ts=6a956963 cx=c_pps
 a=xBU3AFOX62plvdJ7VrUh9g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=y_OmukUNvUlgtTeSwsgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: YL6pFWWl3EiRep9hLVmrkV9b1Ee7awGC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310101

Advertise the supported bus widths through dma_set_src_bus_widths()
and dma_set_dst_bus_widths() instead of assigning the legacy u32 masks
directly. This keeps the driver using the new bitmap representation
while preserving legacy fields during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 38 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index eebed2474210..ca0ab8dc5f59 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
@@ -33,20 +34,6 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
-/*
- * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
- * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configuration.
- */
-#define AXI_DMA_BUSWIDTHS		  \
-	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
-	DMA_SLAVE_BUSWIDTH_2_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_4_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_8_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_16_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_64_BYTES)
-
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
@@ -1482,6 +1469,20 @@ static int dw_probe(struct platform_device *pdev)
 	unsigned int flags;
 	u32 i;
 	int ret;
+	/*
+	 * The set of bus widths supported by the DMA controller. DW AXI DMAC
+	 * supports master data bus width up to 512 bits (for both AXI master
+	 * interfaces), but it depends on IP block configuration.
+	 */
+	enum dma_slave_buswidth buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+		DMA_SLAVE_BUSWIDTH_16_BYTES,
+		DMA_SLAVE_BUSWIDTH_32_BYTES,
+		DMA_SLAVE_BUSWIDTH_64_BYTES,
+	};
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -1565,8 +1566,13 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* DMA capabilities */
 	dw->dma.max_burst = hdata->axi_rw_burst_len;
-	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
-	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
+	ret = dma_bus_width_set_many(dw->dma.src_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set_many(dw->dma.dst_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		return ret;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
 	dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;

-- 
2.55.0

