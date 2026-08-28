Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173C2BE03C
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914012; cv=fail; b=ZpGbUuHTjAZmwayNMmpSbe1T1cGXsoATWvxVfMHxAmdJQjTN6QKTgI8P1NK2+RrWd+s14Sds5eu+XDawdpUVq1oMdstSAp36jDsmQiK+tyDdiF7gtw/ci8AWXJf7xyobG+ODgl+CvG6Kr0VXrI6gfDH4ns3o5noxmeFZedtRmWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914012; c=relaxed/simple;
	bh=r056y7N7wwIakK0lvPOsJLS5H+guN1pC03GhCSPdY9A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TrQ534Rhs+U/rwksVxG10zGjQdweeuRV+Rcf/y3wQ9W7XrSOjhyaUzeEWLmMquFNr6j7gcdGHCILFHFzeIOE68Ckw21M5kC7jIwdt18seVN4gow4/nFcqr1IGTfKj451m7bZThqNol4lV7ggFnD5zk3lYIbOInPr8euTSUhyQvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PRbnJ2WK; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PRbnJ2WK"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA74gG1834143;
	Fri, 28 Aug 2026 06:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y7ElR
	5cxFzcCqLqGOx0Pod8+hSrsTIzLygq6flV0p8s=; b=PRbnJ2WKvnpcYMoEQyYTE
	Gxd1a2wPQyQ6cJUNZB+c4d2gTUt3S7FY/eiC8ttyCtoDZIyE0P4udd3g6GzQ/SZd
	sx7p5n4p9j1VmF/roTUz5IaN+dEwAZQxGjI+r8UZOa6knPbitMrq+kPgABGLKLJZ
	8JcbdZHivUkFZpCPF628xwaPAV6CbU8qVSP1XGKg57zp34V2TBs++RQzNxFklAqI
	0qlXwMhuL3j3Rt4ZgMMyCotlRjqjoWMsq9VCIK8dBrTY1VSKprZAPGKyJ4XVQNp1
	TUJQeOfgTaLxgM7xr0pYGVsv6j10ouw2EJrswlzgi34GIFxrmNNPqhKoXFRuI6xu
	g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gajxhwvtt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 06:46:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YocgCdcQh2/aZ6H5IV/xfQLOBCh3lfk8VyDw7dftDnKe3L9Xyg+kFgyRiMJNa/Nda7gJ57VWDePBsPu28bsnzf6OIw7IFgo15QbTz/7oe3ZDyc6gY8A9bA4CXllHPTN3dACkztTRvICbcp3zdh+HPph2pp1gOsmtY6KnQXmFna87/wuxUnAXBZlZh3j2mS38/9DaUJ4BkWCca0TEaPBzKidwj1r41Jx8EbQ8vxV2UyUeBQeW/4+EMDLq+pXCDEpE72lYDVTBU5kkRHhjvuvfvUjv7q6FDGOmjnn6SBvtrF+bbBOMFylc1fnQxJZQ04ltTssTfoECA8eyGNzWvEUjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7ElR5cxFzcCqLqGOx0Pod8+hSrsTIzLygq6flV0p8s=;
 b=bPlwHnQx1VJks2alPdLYKNxmEZTLrxvpDhMpADBSLER418o9csHnubE5hopA0XcYaRsvepLtZU3gwKaLiyvtOfu5DWJ1AOJIJwyaNjcB0jcauuqZoW/jKsvH6nvlhJ9hn4MBnK6goWiUUMKpouzofAuv0dL9sh5n2iSOOj7ksOWdAa5M7Dz/iO7Jfxzyf06lW8+aPp4zmQfzQE0LP6skZaid3F7//6u7hqQEPH+ilSsLot4/sdMVlmUBsjlPtziLCm0uX9NhIox2PL6YdiFysmQdBpSAmUE5+piXsTSnxnRgjualrPliXK8COhg+5Q3x0Lkiw6Erq20R6aWfikGZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by PH0PR03MB989121.namprd03.prod.outlook.com (2603:10b6:510:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:46:44 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%4]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 10:46:43 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 28 Aug 2026 11:46:56 +0100
Subject: [PATCH v2 2/2] iio: buffer-dmaengine: drop dead max_size
 computation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-iio-buffer-dmabuf-iommu-fic-v2-2-b4dd71827621@analog.com>
References: <20260828-iio-buffer-dmabuf-iommu-fic-v2-0-b4dd71827621@analog.com>
In-Reply-To: <20260828-iio-buffer-dmabuf-iommu-fic-v2-0-b4dd71827621@analog.com>
To: linux-iio@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787914052; l=1068;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=r056y7N7wwIakK0lvPOsJLS5H+guN1pC03GhCSPdY9A=;
 b=NbY+fviBT9AydMkh/o1BxVEm4n86lY9e18Y7pzlgf4ssD/0w2pOcYjPnY7GVQ79yX+ODlpUfB
 apJ3xX+Ps2+AdNiUblwspXZy9pbzIz45VBGBDmoiS3iZJjCj0vhunj3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0206.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::19) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|PH0PR03MB989121:EE_
X-MS-Office365-Filtering-Correlation-Id: 655f3c9c-8ecc-496d-4286-08df04f1a5d1
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 NhsfbUaSV1xtS7mPryB/LQsVv9n10SZ8+MlzoWJet827YhApuyGOQNoZe6f9bc67Sy5cHXsJszql580MqOKOz1+rG31c+82v0hpPQMdUAMLbDvG8KnjXkRqWb5yPsOB9fTB9v7MJc28oIFyGW85qA62tRNvNLHmm5CRiZd3TvDPAzvsQUAyZeLzzu5o8ky+PuOJD1BOS/nCinepg5PaMJpgGkYM783VHDXi/hztAhT+Vxgh/rE9ZRn+sQGnhjnApSEIuw4rUNYWOnoOrpfnDTK/zM4mfekvbTq26XOX2lwjWFpiJ+Z3EU/NQtrx+IAMCfu6qsHzyRJOFo6uVm8PQVZe9l8iGcRM+4tEK/FZCC0kWii0GkedXh8wcG9mQOCvLJjP886VDVfTRsBUveZz3l6vGoraWYpKTu1Et4KBsxY+x2yGMCwsMpfNTi+KgCyIfEwGhOFYKXXM9y9ePFX8rUqQAicaW1pHFr9rq9hue4DL+4WhcMumpdVg6lpiMh37/JbLCqszsn52jzOR1jPVV2VjKHT5II+wlCHecnvp9vDohlXA5MEDVRT4+S0Sb/rbI8oQPmnk3SqNjJZC98k0XfwpNcszBADTBqnOVUmBcoOPYRL2SUUG0QHQz0FXAqJd1EsOmfkWo2ThpZ7y8AyGFEYUA15UGG/ub9Ogj9hveNNA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UnViZS94Z1N3a3N0NHJOS2xDTWhKZHBnVjNLODUxejlxQjcwR2pwYlZNZm0y?=
 =?utf-8?B?WVNsZ1R1cjlzV1pMMGRBcGhTNHJvdnNKNHNSUFNHalNOYzc2bmFITDJuMHdH?=
 =?utf-8?B?M0duM0pWellXcGJFSytLYnNzaTVDZnJySFM2VDdwZ0ZNeStPcUxkSnlTUDJB?=
 =?utf-8?B?UldWa01MNHpicTdpMUgxYVZBSWc0UWp4TzRrOU8yNVFSTm84S3BPS2NBcHZ5?=
 =?utf-8?B?b2ZpVWJ6MDBpTkxrVHZjeDFBbmZ1UzErMmJWTy9PVTFGZGhJYm0wT0ZEL1FN?=
 =?utf-8?B?MWRwYjlub0RtRXpZc0VrY244OC90cUhvWEY0a1lqYXBxKzh5OEpmSnZpM2pk?=
 =?utf-8?B?dzB1QnlUbjZ3bjY4R3k3MHhuTTZpMzJDNFl2QjdGT1RUNG9aSFhsaXloVDlp?=
 =?utf-8?B?RXVsZlJwMUJPb05xeUszNUlud1hOdTRsR1VxNjI2cEtRV0RCSWl4b2Uyalpz?=
 =?utf-8?B?eEhHaFhpa0ovYUp0QTlNZDRYZnNnWThNbDI5MWRkVlB2R3JYZW4rOVJUbmgy?=
 =?utf-8?B?Tk9JUWNDSVE5aURvZG5adm15amJ0RGU3cWZ3a3QzRk0xdE9ZcTI0aExQSFh1?=
 =?utf-8?B?ZjZnTmNIUjRvbEh5bEVHa2NnUEdDdzVKanZVK2RDTHUzc2xSTU52Unc5ZTJl?=
 =?utf-8?B?L1BXcVRaYW1IdDk4aS8wakw2RVI5UFY0Yy8wQzV1T094RUFpdEwweWJPaC9I?=
 =?utf-8?B?M3pDbTdNY0J2eVVqbGpDandnWWZXRHk0UVY0aU8yMS9HdU0rb1hjQjA0ek9l?=
 =?utf-8?B?U3lhZytvL2k0ampSbTVUeUowS0k4U3NRME1WTDMyS1pVSFRBQUIxTFp5WkYy?=
 =?utf-8?B?cmpHYnhIdkttMlQ2dFcyMjBUdnVvN21HTUVjWXV4ODlWMUlwSDVrMGZ2ckN6?=
 =?utf-8?B?anA5eXdiY1U2RTlDcHBvYkpuRzBCd3FjcFdqQXFtSWszcCtxNlRjSWR0SGJO?=
 =?utf-8?B?QUdvbmd3ZWo4dWRnTEExbTdJc3NQNHl2STFYTDJZOUh4dDFKWlVjdXhTRmNX?=
 =?utf-8?B?NFVGR2o0NEVic0RaUjdqMzl5cmVRd0UzSWN3UzZybmFPK3dSc2c1U2YxU3VK?=
 =?utf-8?B?bWFhY3dwV0ZRWGx0K1EyL2w3clJsdWRTdHVPNWphZStNc1BXakE1cENpckJP?=
 =?utf-8?B?RHlCUXpjNytCUnlrN3UrSzFTOHM3SzVWb3NTazVTRkhSa3IyS3hZOHdrNmZT?=
 =?utf-8?B?aUc1NWQ1UTUvemhlVHNlNU00UzdwQ0FORkhVamhKaFN5bWJmSEY2MUt4SmxO?=
 =?utf-8?B?cXAxVkRSdG53dHAxck8waWd6SGErL28zamErVkNRWTNIS2QrbEVUMWhRWm1k?=
 =?utf-8?B?VGZGYjdaWUxCVkhZbHlSQVE4eXkwdFFmMzFYUFphV0xEVmFtZEVVNjEvVFY1?=
 =?utf-8?B?dkxFS1N0V0RCd0k0UWxxMUY1S3ZSQ3ZQVEVONUNMcmdUaXlIMzZlamJpSDVs?=
 =?utf-8?B?L29UZlBSdytPdGI3bnhPVnUvWUdBRXVraytzT0lZMy85S2NZWG0ramtSaG0w?=
 =?utf-8?B?N0NSUVZPUmRzMzFEYzlhMzYxRlJLV3kyUm9rdGZNeng3RmE1M3hxd0lTbEdW?=
 =?utf-8?B?VUc2S1V2NUdVWWx2eVN5eHpQTk1NWFlHYVN1Y2JKQ1JlMktvWmZGZTlLVTJG?=
 =?utf-8?B?Zy9TajVKbnZibVpER2x1cWV3QS9Ca2JENFlYdnkvRzhuSjJhMUVld0txaFYv?=
 =?utf-8?B?c0hUVmIrUS91alJiZUk1TXV2d2FSZUkwL2JOMTd5aVFaS0JsOGlJWTV2eWNF?=
 =?utf-8?B?VDhJZHc2alh4UUo4Y2QxU2RDbXFGekpmdTBqeXV1Y1NHcHo2ck14OU1PRUtR?=
 =?utf-8?B?SEU5bGoxUkw4aVdEWkhzdS8xL2dnV3p5NmdlOVROMldWYm5yUFJMVysvenpy?=
 =?utf-8?B?NU9IY1p1a1lFUUVJNjNrUEkzZzROOW9HS0Fia1pLODgyYUVCaHZIMHRCVzEv?=
 =?utf-8?B?dU5WWUxQckVwNE1OanF3NEljS0NGeWM3UHVRRHBXYWFBQW93L3NsdmxLR29z?=
 =?utf-8?B?MEd5V1Q5ZzBTT1hiTmFFWnFZQWtxMXVOYmhhbDk5UE5sQU5SdmdaY3NzMDRt?=
 =?utf-8?B?VUpQTy9EbUUxMXhLSWRnZTNUdXkrbk5pTjZOZGZVeUsxdkdqK2JTSXBSK1k2?=
 =?utf-8?B?d1VGbXpxNXdmNXltai9YMVZwRXNTcjY1Q0J1WTVYY0FDV3lmM3J4ajUwQ1JQ?=
 =?utf-8?B?dDFEa1VhRzYzRHNMQVJ6c2NwWTAvMW80cXJWNmFGc3VPMkkvSXY0dmlrN0Qr?=
 =?utf-8?B?bVA4T1A3bWZ4NzJZM3BjL3lZcW5kRTVPV2Z6bWVzQVRlaGhyRnkxS0NzOUha?=
 =?utf-8?B?TTRjTGNHRDByUTRuZGxBVVJnZE1KV1V5eEZWSHluZkNrTGJ2Yjc5dz09?=
X-Exchange-RoutingPolicyChecked:
	d0Hd7FskhaEpayG3oud3SEU237+MBAgdryZvTzOuDoUHnj70roEPt9XX2JQdT9lhshrPLo8mOeLv1ywEd4UD4KiCL6rJSTCmIaqFz+q/E02YS1OMbmkpcPaZ8MHufaKXbT1Rl9VIgVWOHWoNHnBcP8jx0Q0l+zhlV828JeN5H8ha+4k11Ihxir2E5JF81PpqXlbE22BWksSQIptwA2sqC0xp6zkrZ669lTGEU0QNob/e5uhk9K8uUn5K+2XZBPfLIaC8anTxyYn7vp6BA9Vjrnj0ZzzQyrzm1h035M5Jddm7oSmD8eIoUBOy/qBT9q44a5FRnwteY4GODgCrYJYkjA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655f3c9c-8ecc-496d-4286-08df04f1a5d1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:46:43.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYMq22MsF6RqxIRRtLCtCGNSqL9ug/29Rto8VcDFGR6uU46WljYfDE8Hv+1GpT1tDyDDuZ16mXPDWMjPqoN1WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989121
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5MiBTYWx0ZWRfXwk1ye0eHnJCH
 PTa+q/SlTXrJBZ6m8DFRItWokksdmNAnCQGpNCrHjfsj5AWWyEYXirRAgbHdgAfQH+/RZMzc8zA
 eYKbkV+u/8BHGQwPvCoiqfi0//lb1Mrs7c4WISdboiabK+Dss6Cv
X-Proofpoint-ORIG-GUID: sMaUiAa33nhcOQNdo13fSl4tdTBQ4jPJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5MiBTYWx0ZWRfX2pux5gw/olfO
 TUXxemYQ3DuGJOcVFTodz3tCOEnnhsY+9FPUBANbLAUFbyJZgJSEOQB5TIvk0hgVcl90t0PY7iI
 ChXxsF8RPIay/SUPSFieBgYRhjNjZn47paklr1VMWWc9pTr2RcBnNwoIWVXqjJhLxi84KA8bjDS
 EtuGM/QiULQDcvK/6c5wcrI8smXCCP8BOKi5EhOhAC+5lceok3dEhQ59I1Ga2fgtYQcaSDRoEwM
 HpMBMiPJqBCyTXHfMSxnTNf5RNSglzO11PNPAco2iv+yYpYStFdaDeIMsurm7GaW7l5BoBRb0/r
 Eml4wg7Voc30lF/nJDvExF3WmQ8yetN7bwp7GRVqx3XYCX9MpUk/kkDkyM6vSfF03f0e8lnsgOG
 qOByVUPnAYRbndZ4Vvy3/8hKSueKBTMt5zYUZonarCBAeSuisLZERGzOnseDyWypTVSbLAwo7hp
 5ozbh/2UrOe6tUIxMwg==
X-Proofpoint-GUID: sMaUiAa33nhcOQNdo13fSl4tdTBQ4jPJ
X-Authority-Analysis: v=2.4 cv=Oqt/DS/t c=1 sm=1 tr=0 ts=6a916716 cx=c_pps
 a=DYOzx0NG23oKzpQZkEOi/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=Y6pci1o2owasQnMRWecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280092

iio_dmaengine_buffer_submit_block() computes max_size unconditionally at
the top of the function, but only the fileio branch consumes it - and
that branch already computes it again right where it is used. Drop the
unconditional copy.

No functional change intended.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 376486be3f55..284d4ef92104 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -88,9 +88,6 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	unsigned int i;
 	int nents;
 
-	max_size = min(block->size, dmaengine_buffer->max_size);
-	max_size = round_down(max_size, dmaengine_buffer->align);
-
 	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
 		dma_dir = DMA_DEV_TO_MEM;
 	else

-- 
2.55.0

