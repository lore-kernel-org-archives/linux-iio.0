Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008A40756E;
	Wed, 14 Oct 2026 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996879; cv=fail; b=XkSP2zeMWnfLgEP6EEJT+4O3mI54OA+2tKADDx65EVmiEI17ogkOTnDRXDE9ZrnNfJG5QLqPpKjk0YvgPKOeIjfH/ImR3UX42ATjrn2y5gmsT+Rie5j9WY2CjQs+0Zmr3wSxa9rQhP/XJg2Qguw05ObKVh6frNC7mGwOKdJXYHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996879; c=relaxed/simple;
	bh=DlvqGUkf5NIYmPpIUSsoeh3w1IlsTOJYFVgeyf/CbwY=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=lAE6DBeHppYXbMVU1GpiT5PAZv6Wm84CidoC7OVPUuLaGdprVZjrsPtxlIqKQhdCwoUm4N3ouzptFxtfO8OILc+HrYxWmVBPg9fOVAfyDuN+DFuTWUh3HveWg1ryjo9LcT1KBmVDz54LJ+SHVf4jI+rhTE3iWtb3FldUztVjhrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=t5QxLRt6; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Fc5QSN+M; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="t5QxLRt6";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Fc5QSN+M"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEb1ju4024445;
	Wed, 14 Oct 2026 12:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=5bOcOjnhnghjgb4rSS0JnETWx4FJFvl3B4+obvhWiDg=; b=t5QxLRt
	69wpXYKjEqhfvB6nsxTD9tMof//hIo4yBqFa86vVbl0JkeJL95oZ0TonEgwuY92D
	dREnOn6uQUVdwDA4KGg+WzF64exIBI5TW6+5Xchhrs3NxkddmI0kaT4BMyMXMRgI
	84gosavbBc+64igBqg3FAAEDeH3FDAzeCHm0Xd4FVmMSl3gH6QvI1CiRk4siOEv5
	FX3fr+Omsx+5iiKQniUSo+EpF5nLk0Uitve4j0bnfFYrM1AoKsmkfzkHP8vIenaF
	LUaN1qWd6kRHKc+mqLC5UqZZFY85l24Oe0roFGyxpc6VMZiUyorDA3fV2mkzEAL0
	X4iEtsiEy2qwh/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5bOcO
	jnhnghjgb4rSS0JnETWx4FJFvl3B4+obvhWiDg=; b=Fc5QSN+M6b7Crct8Drg8b
	jhsajExFQFR9C1I/zM3/yumxgUXQ2M4bUqOTFV/wYrxtWwG68LdkCeituMo4ej8I
	jlLfHzj+Wqb+71s7a+iWxNN77G9lT/HQM5eMM3tZbBiOfJ66hFWnJoDcYUnIYCM1
	pOIxAQoKUgy2lpwxJlMMKZaf+CFI2qZUg1+D+bgMwGO9HhLjjYk5GWCk0BQMezgN
	rU4IQEFAziMdDjmChWnxEgzwSUbZ7WIvw9a7I6L94oPPsH9/OA7oiJg2vZTs8avH
	p9S+CStc0oT3nDg9csKkVq7QcgX3rsXzG8O/TR2cDAyP41M1LIVTGuShFnic2wnp
	A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haab61aw1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:54:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S50iuJgZHqXh51ZAm1fn1p1Gu6qk36wMel38s+rhIZCRbx8nGNXSMjPPBELpdoTmDuaiEPVcgtFn6/GXcCnZmkF54r7Bdo11/nZ70CgpAAfoKNifVtU+jqndjt1Djirkztj749BInodFh3YZOMZIKsEFDOU6k71wkHHlrsiE0Dsc/1A1FTMBbbDw6FANLr6r6eq1Q0858zHcmlikeXIGvuo0vrvGfUFMMmt2bz5hY4fSASAke4lxnkAW4XrF3rl3+xx410F4xgBcxsRVrgU73i9gYFZymQEKtPUmyZvLmqj6ks0zmO7Vx1M+lcPN3s6mvzsdqaOH8gH7BCbuSyb5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bOcOjnhnghjgb4rSS0JnETWx4FJFvl3B4+obvhWiDg=;
 b=fKDAi+Z59JbV3aV9fnJq14+n57A6eO/ald4ON9Nk23jnGMyPvOYe2Awkwx5cXnylW4xfPssQoKRiaU/KUqgMwB2g2JhD3hFAkcm0IEh8XhsLQjsetWLB16WJ6XxadS5eHzLjtPcboxn1a2LBLE1Hx5vT9d+rkxsHAATECGMoyWqSuq7fJYUy6wbm8/34PD+3RdUFZoUJTZqtkjdPMDpRRQEuS/TlFL5vnOprizDFUY33kXM+YkaAV09mTOEZ/zX4XtAYOhcsYuWjZ/KGPlBgykEBtZGntnoNBxHeLsehdyu/g5DUMxb86KcnwkW1so9wFV4PiyRqepv0xEuI9+G/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:54:31 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:54:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 07/13] iio: adc: ad4134: Support buffered data read
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        marcelo.schmitt1@gmail.com
In-Reply-To: <5d31212a27c2099c226cce189aa96677e75ca529.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <5d31212a27c2099c226cce189aa96677e75ca529.1791309733.git.marcelo.schmitt@analog.com>
Date: Wed, 14 Oct 2026 17:55:28 +0100
Message-Id: <179199692826.658576.4841754843069240356.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996931; l=1714;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=DlvqGUkf5NIYmPpIUSsoeh3w1IlsTOJYFVgeyf/CbwY=;
 b=xSJi5GEJunCThE/jTcuDKN4V0j9aFQ+zDbFR4fx/9exmygXcxMqiG7EOHrOQsEULOC5qRKum8
 QgkBxTdVpIOAeK6cgsjLxnFaowD3MiaxtMJV/5BOyUcXxK2GxXbKENx
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0018.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd56b56-5754-4be7-8cfd-08df2a13d11d
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 3CgBsn8Cp0xh7oLnjaeDJJ3u2Oas9UwWHHyCo3TZJukyVn6vPX8jWnPaIjas1Nb+vWlNeNSuqc7e4r3M8r9EQszBb89shnMLwJmrp2hIExQ50lHjr21VbsRtMDbSg4FiWXBUThCRQorSpsaSLiRtSxs7a0GKH8q5p/RP3RCd/BxxvJwLF6+cK5OT/nbhpLPnJZyP0HMsWjko7c4v4PhUXWwfCpR+4+TjJieloKsyLOUNtJRsVblJFDxQAsL0a21U3n3XR7bumrmGm4HSlwNDn3pOndK6fS69EGLJcAmFc0ztTKmINZE1lwcoat9+BbPqDho40NHKKp9gAk7Eboulc28rKpFCF2R+5LzExPJuS/1LUpCn+e2z9Gfd812CDmNYqqCUb0mpcwi18MKvqklInhwkKw2YzcxIqdRdxf0fskKlC5HGG2frCDLcC0Ae2aTAQxqsF4YMMFOw7lIvsMQeyuv78dtBAMy5Aq+pfObcHfUhEqhWZ0QJuxIHKWy5JhGCP2A/QpgIpG14fBrI3RfS0QcsHmaV79y2bOg7U03UnA/TUWDGJaVfxU9ZbqZ7mfO/yv7OQ65n/39SCYiDZZJW/esJUrM7L81oB/TEAf8sap3u0FktxTtG/05EKjcApThV5jeJGSL5iq1JXK0tP6TeAKDkkO2n+71GA3ibVrENE+M=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?THBKMXFpbXJ0WlFVMWI4U2tvWTl2THZPMmwrM25RYVFDbFRZN3A4NDBXa0tJ?=
 =?utf-8?B?MUp2TWk4RGNyemdFczQza2FqNDZnbkdqTjVKc05NOTVpeC9sUmdKQ0c5Rldu?=
 =?utf-8?B?ajhJcW5HR3d3ODRNM004aXRqdTB3V3JvdTVzVnFhbXBTZXRrKzRkUjJTSjBm?=
 =?utf-8?B?WW5YTm56QnFwOGMxTDVZWlk2RlQ2QjNsa3hpQjJCb3BwVGRvUnRtYTQ4L1Y5?=
 =?utf-8?B?bGkzT05ueE5TWXM3bnlhWk9BQTFFdEFLTkk4TE1CdmNhYlhnZDkvVlFhUWZZ?=
 =?utf-8?B?Qk5ndmNvT1lRZ1lmclBkaWtrbk9VUWV0Rk5qT0EveE5NRXhUOFh3ZURXT0xG?=
 =?utf-8?B?ZjBZTm9LUkVOUG95V0dabWp1OHlqRExKNEtkcWoya1BEOE5FdW50L2xiSVBI?=
 =?utf-8?B?cEwyUDR5MDhhd0s2RjhGZzk1dzUyMHozUXYzaTkxZ2Z3ZVNnVnFzNm9SY0o4?=
 =?utf-8?B?YzM4YjRsdG9EdEVFSFF3WFYzMS9VbU1WNUlLYTR3T2xOUEdkR254YWpNSDVP?=
 =?utf-8?B?cGxqKzBQWHZRcVRUUncxOUxsc1hSNWdtYUN0d09pcDUrUklPNThHcmR2cWxS?=
 =?utf-8?B?OElJaXVpUXpRNit5aG43TThRaHBmZUw1VTQwNnBwWVlnUEszSEFVdTJqZDRD?=
 =?utf-8?B?UzZqYW4wbE9nVG50cUdERW5tYjJMQi9kamR2aUN3MXMrLzljVDVMNjVkRFRV?=
 =?utf-8?B?MmZsb3lBQ3ptWHZOeEpMOWFBRlpRckF2b0pOcVZ0WkFVTnNFZ3REaHQ0dUF3?=
 =?utf-8?B?Z3hidHFmY2NQclUwZjN5YVFDdVRlVlB1RFlTaElmclhjUzhsZ2FrWEg3V1NW?=
 =?utf-8?B?RmFIUkVKcVJPZk1CWFZ3TktDUVNJN0I0dERGMGVCMk9WTnJnT2ZlQTZTK3gv?=
 =?utf-8?B?MUpUWTF1NHBsQWhTWGllUUJUYlBLR3ladXZ5L3F6Y3ZsK3FjV3o2c1lpVGFQ?=
 =?utf-8?B?L3NPaWtYdml0dklDaGttTVdnbGdtcTg1Q1h0clJOdW15RTFOdERLcTZwOU5O?=
 =?utf-8?B?aE5jQ0paY1NJMzVGUTdibTBVZ29xRDliV1RGbEVqMUpZOXp1TnJLY2g1YmYy?=
 =?utf-8?B?WnFjd21LdUFrT2R3Zzd5VE9RQnNwMEhmMEVidXhFWTYrT1UrQ2JLUDFPazdU?=
 =?utf-8?B?aWlNcFpTcVN1QnZ4Qk9FcDFtL1cyU0M4MzNLbnZKU0MwRXVjUzFFeHZtaE5t?=
 =?utf-8?B?MEVHM0Zjb3JaTGpvTDNhUWRhYjZtbjl5blNWa3hpUXNTS0NLSUlwUUVGeVdX?=
 =?utf-8?B?N1hZMjJkbkFQZ0FJRHNUUXFXelpuU1plelZENW5OZXBzK29OR0hPYnR1Tldo?=
 =?utf-8?B?U1lBMHNwclRzSnc1SGYwT1ZuS3hQbW55allmS1k5cXJQc1g4Q2Z4cytKWlBM?=
 =?utf-8?B?RGQrYkI2MG9qTFVVdmxWRXRUanBMbks2dlNrUGdVZEs3UHUzeFNtK0p4NkZj?=
 =?utf-8?B?M3FvTEJtaUc3emx6NmJuNFU0TktRNi9JVnljcTBVNUZrNmlwY29EK1pTUzll?=
 =?utf-8?B?YVNmL1Q5RnVUNUJtcWpGV0hTaEF2NUVyR3NsdGVKc3psckc3dGVDUEU3c1Yv?=
 =?utf-8?B?RW41aCtRb0I1S1RCS1pDTjlPSW05ZFdzVlZvVVNUWlZITGpsMDMzTU1pMkFv?=
 =?utf-8?B?VmphV015OUkwZXRteDQ4b3IrMTZaNEtkR2FxRFpRM2FSUUhuOEt2QTVBRE9D?=
 =?utf-8?B?dlVvcnMxcjh0L1JnL1ZVZWNjdUhHdGxvQ3JQcTVQQXQreU0vUEl6NzQrbEh2?=
 =?utf-8?B?eVFXZitqNzN6bm4vVHg2NVdPUFhVK1hWL0xuOXZ0czgzQzYzRENKS2ordDRG?=
 =?utf-8?B?dXF3VzBhMGNUNi94ZWdJYkhDVmtNZjg4SElycThXZ3duMzhjRXhHdXEvOEhP?=
 =?utf-8?B?bTdBQWVsNCs2cnVBYUE3ek9BVVFNTFllQ0l6RUk2Wmd3djBDN2g3a2IycDFP?=
 =?utf-8?B?SHRhYTg3UlRGZGU1OGtUeTcxTjh4amFxQU03clg3WElzNGE1aXcvT3RKVVZm?=
 =?utf-8?B?T29Vbm1kRkJHb3dKb3VSQWRnMXVFYkZkU1R3eFNRMnd2bFN0QTVDS0pzQzRr?=
 =?utf-8?B?RDZjQWJnb2hlS2hoV2o3T0w2L0lQUXB3RHg2Yzh2UWt2MlhORXZwSGduU01C?=
 =?utf-8?B?ZkJLb3MyTDZyUHdsQjFabXB3L21iZ2s4VnpvWW5jQ3JZUEZNdElISGtSZ2t5?=
 =?utf-8?B?NHZObUxsaTh6aGV0aHdzUkVNT1ZUbU1RODhjQitrcEs2Z1A1c1p2ejlJRUlP?=
 =?utf-8?B?dXRXdGFPNG5BZ2JZL3RzUVVtUnF3bDVBUGlmLzRPSnB4b1lqa21tVEExWXE5?=
 =?utf-8?B?dysvSDdUSWNWZDQ4VDJIMDNUOXJSa3JIQnpDNGUxSllOOEZaNUs4Zz09?=
X-Exchange-RoutingPolicyChecked:
	CpTZv4ZbnNzsSmTsZUu4fr6GM3HMZHYjTxrgpOlZEm8CD/FozU/MJSLo+Po2ar6IIhZFdcEPH2ISc1XA8q0kgLjES0OUrLirFqQoyC4j5P/O3/x1NdSOP7Vp81qXeW8qUF+KbE19S3xK3d3qQrIykWPmsvk4BBIkHxgB8AUGR2LsPx1lsOUus8LNg8zGoG0DzzMDAL0XJyNbKipTGUl+NtU4YVbFuLs2u5Zbg/FZoQeoUnVW/WHWhreBqeDCxRvVXqHrnPwscPcrDOqM998O11wmHQ1Zbo03lv/pPQ4DGRHMZECi3WyI3ONmwjzhKqP4UqSJB9zIhIrGZAz1qcU2TA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd56b56-5754-4be7-8cfd-08df2a13d11d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:54:31.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RixghfUXAC2u8JD6sQ7vKDNbkkMmTWuaBQ35WUEaJGwrDpbC7hweZIE+0i9cB7W+NtNx5UIlyr/e/KPHl3dyeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6acfb3c9 cx=c_pps
 a=3r3V3iWCG03xnAr+XYP7tA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=ftEwOgmq7MRNccfMLLQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WVpgUrzKGoovSBi25FeWIdKFoGsRW2YX
X-Proofpoint-ORIG-GUID: WVpgUrzKGoovSBi25FeWIdKFoGsRW2YX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXwHUiKGeQFYrY
 VaIKFzEEyyfb4lhvivtS50a2D5bAi3B2nikpIK7HhjNVRfCBbDYthoGOBw+9xsjldvSeK/Xfu1a
 fJg0ZVAwsL0mUtYIvCHrDIUHmDpfyr2V0hEMm1/N3tlpWdtLCW6Eu4k4x2bbH6GSI5/NiPP2zeP
 zDY5cYqb9oswV2QMIB7nKiaztxB7vsNjTpVn5s7zORkbOj5siEKwUO/mj2g6Bbp2qS/sEBC3wQ1
 CHa+NQ9QN58A5971yOX/502hFGiCtoKmxu118vGrlgwvAKj3oq6gtbDXxQ00Jjl/O6uFy2r7hWI
 R5+nCtWg1QtW1oOAQJ0gfqyfIpDkUl0uaj708s0B8GuqlmY5xM5uBHLgU1Ysf/y0mqt+MDNl1+j
 wvvQwP0VJhCBbC70P8grs+r/WxKxmCSNVy7DUX8UL7CVFodacobsGDNDoSoF5TX461W2TPIouFJ
 +KkjoKEgGWY+gZXiWcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXweG9H9Z5BTaG
 3H7cPbvAbT8hX44Yb3u4bWwfX8FEbjXyuHPLjLpHPu8REQ/lxqGCuRHjwcz4QZRGzeKW4maqOll
 JR9gn6dXZyomVbI3I6ohDbtseg5+vMmPIg4cJ/lB+6V/oN1RWaNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067

On Tue, 06 Oct 2026 15:17:56 -0300, Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 3048e61a3cb1..b5207f16054e 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -149,7 +160,7 @@ struct ad4134_state {
>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
>  	 * to live in their own cache lines.
>  	 */
> -	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN * AD4134_NUM_CHANNELS] __aligned(IIO_DMA_MINALIGN);
>  	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
>  };

The above is indeed a possible issue! Not just about dma but also about
concurrency on the buffers.

> @@ -333,6 +344,44 @@ static const struct regmap_config ad4134_regmap_config = {
> [ ... skip 17 lines ... ]
> +	gpiod_set_value_cansleep(st->odr_gpio, 1);
> +	fsleep(1);
> +	gpiod_set_value_cansleep(st->odr_gpio, 0);
> +
> +	/* Run enough DCLK cycles to match the data frame length. */
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);

Yeah the above needs to be sync with debugfs. Either by not allowing
debugfs when buffering (which can be odd tbh) or just by using the sync
lock around both places or even by just using a dedicated buffer (that
can even allocated with devm during probe - or on the setup buffer op
depending on the scan_mask) so that no locking is needed.

> +	if (ret)
> +		goto out;
> +
> +	for (int ch = 0, i = 0; ch < AD4134_NUM_CHANNELS; ch++) {
> +		if (!test_bit(ch, indio_dev->active_scan_mask))
> +			continue;

As you already noted, please use the proper IIO helper.

-- 
Nuno Sá <nuno.sa@analog.com>
