Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53A5012AE;
	Tue, 13 Oct 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897291; cv=fail; b=iC/It7rqF1z23SoRntGfTNlNZ+JxpmzuvE3HrkZdlWqwkjk0+tOMwXKs3X4HNvOL5rf0KQMfiFUbIgFcl8dNaQULM2fUDAymOsUMSDrLOieW0Sk9o26K3Vg3HqYiHcbtnNlNclAwSE5QfsOfqRGQdWLBK0oz/9irNkYALGrxRxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897291; c=relaxed/simple;
	bh=k8uk6Lm2/0138Xqhq/wpoNbgC6Vly+HUTH1dIt5sXlI=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=rWXknQNrGVzVP9ErzEBEXMfaTWS93cVzU95DmkvlQ0lrbENpOm2NR+UcbuN7O5g0AgiOc5rlhvjVnPMaWLrVY2Kmcrg/xCa23+Vak28+Fbwytp2V21k2qWiMoyMNiDHgz8xOLZrr5eFJCXXxgYVrxeIn1SmsQ2mOdBLuB5+9X+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=P+9VMM6s; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dvAHlxwk; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="P+9VMM6s";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dvAHlxwk"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DBHD1w3856932;
	Tue, 13 Oct 2026 09:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=qXPw/4KV9bosJ8lrc/JO5wMgRPJvw2kNeIczChM6Mpo=; b=P+9VMM6
	s6hFwjjn55vQkl7Wr17FUWgNrO5bBYTCa3fcJoiWofXy8HqkthEYnk99sBPQJ9FE
	9ClY2E+TfLiKLvJmEru8GJlkQsunYSOgpbBjaMSpuvmvaomWh21UJr4aobCrNTsO
	vnjZYOFzPNZd/I1mI3lqfeGmeLxKtTd1uF/24QeAzzahdhB76jnqbfxPl5IZF5PQ
	2UMjAG2qRqZQNNmZltebME9P4E2YeHDtW096O8D7M/PiNnFB40DseJ0TT5io+7Sk
	mWHT0HjLKgfprLgm/FHxKW4HOokd0+chox636DL3hIvX29Q4P5UJb4GC4sGfqIur
	fHk4mWVRbrEZ0Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qXPw/
	4KV9bosJ8lrc/JO5wMgRPJvw2kNeIczChM6Mpo=; b=dvAHlxwkZB8totCINYtqF
	I/DYLitXBKfFz9tDf8co4GLR5u1oagCM4m3yfGhsm/3BCKjt9G+99vWdIe4i+sUm
	3gvVw3On9WjyGFgP6bGzAuyblSg6CK4w1HklJbzsF6HCxKgvkAvU6eR4NWB1AGYt
	DMP9Z27lNgi4GdXj2yRsV4NXe+300/IKYKcZP5BKQ5Kjy2j6ibXz0W4CvD6T4ZTb
	N1X3EYvWqO5lXfILkxt3zVRmOTmzvwC2D1tIlv5bRT+w+QXIUmNlfePyGbv6HJkX
	QO0vu/UPAFKgNYaWAzZDsMZv5Qqwkl3J1N6fIyx0oUXxomcIWWBfwF/pM4xsDWUX
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h8r8msbmf-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:14:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on+Aep9z7S+4cjhq6yLRZLFvX7NIurKjPTpZS/fth8zGdgfCu6qa3m7efBDWqR1yz82NHKU+DPmcDqA2Q/w4m1WrIpEYmHztoKbUk2hLP5NzYb+aIz+2tqutXkGVDO4c9WWjZHlvcgZonWY/LECQX0yGzQ210uG+YiX3/G5QcU3FmVRbvkamHoH1mDEoTEXeQeb/3tZqSklz5C/bNjWafx9bOuK/eVNEQOikJdxdafzrtX/pgukdvdcZyx7lZGIRtGxNjq/j8BERePJ3HcwYC1xg01qUrbc5FVMfkBA/lnFQyiGv7e8jW2rWL5nLa0ExiVq84Qn7Ap5NicG4CqWTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXPw/4KV9bosJ8lrc/JO5wMgRPJvw2kNeIczChM6Mpo=;
 b=ATDbSvFhqRCu1CUyWostYfeKtMFnB+UIDkG4Y/DJrPx1szUzIYRcgI5SKDyXKd8PSQkYBADiCg6XVxTo3Xn9fHTjg/9etzZOTPmZFc86peY5ieaOAqlHT2TAX5cEGokqOAdEqVEbJkExrYwgdoqD84319HflwddDTROvqxsYGCo1T+Uqu7mh04hfowMiZrl7+Fdm7v6r0qKn40IDl4UIobhryLfELiQ5JzDXG7u9L7c+8zudfBj39/9i8m7Tr1VY+CE2HRrKNEB7eSJEW+27IDVsS/cw+sY/RMOz+thc/D3X2oAdHBm6cNc4oafGCRJ9DI0Yu4bqCZcOX/2ir13iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by DS0PR03MB989571.namprd03.prod.outlook.com (2603:10b6:8:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:14:42 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 13:14:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: lltc,ltc2497: add LTC2493
 support
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-1-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
 <20261009-submission-ltc2493-support-v1-v1-1-3dad1d4b152a@analog.com>
Date: Tue, 13 Oct 2026 14:15:55 +0100
Message-Id: <179189735510.1005940.8416380835311568189.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791897361; l=425;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=k8uk6Lm2/0138Xqhq/wpoNbgC6Vly+HUTH1dIt5sXlI=;
 b=xqyGdMAzpvyy9NcRdoQtX64t8Wj67u1ibbTEo0NhFMyLTJ4fScBKNKVgJXjBgs8CS962RlpfH
 BE/d8hi52f8ALToev1A6i+O2u+/CBIg3G6Vi+xsxF9a9YvRL5BZoUqG
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::34) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|DS0PR03MB989571:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7e8b55-6236-42a7-ee44-08df292bf1b2
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 oh/MYAD1qdglndKTVvJNOJi1cbgOFP/i9R3nSKV8mKRjjldupL/fUPNQzVnCF8INoD0xZ0CJzl17g/Fz3ls+YO1rRyfSwXt1l33OntA87R7ftnH8uYk9cg6kBcPpRKu7JXCfzpARwgQp8UTKRMZa56tt55VuqxJuP9KR2tVp9ICJr5Ge4FCDqr6Z7teR0pq3AxQxLk7uvlX4fCIHWVcCOEreDy49oE6Em0TLRB54f3gX6nrtBdEcNiPK80towJz2Q7qioaFCu3lLKw7G1zwjuuzVWJm/bJHhk3gMuAeOgXgo//0QU/D4ACERuiiRWgHWhEmXkVluTUfaGNCh+UEjmpl9kVxEhwO+KN1tUwNemkjZV4ar3JiXJB9oVMRQRTDYf8MhqMW0zrGJyf8byaH0Cm6ojMpJAWeyxxKSEJEK7DxTuVxmKUZYl0+zKLkuKHLdc6XVeZVJNSpTkI48QplZngkpjfErcSjPFjoSsbTYr47M7EoqrwWAzfBFQarzBIfmUbbnPjYrsPm5jU3vb/GK138vcW6qlxa6QKMOblRqlsaCGOQ97lwjA9Rmmr9FB4rXkhpMB/OdI0gKovroX1DC+Oapyiyf2Ba2ORp8DzQJKWM5QpOZ4ew1T5y2QXDAuc7t1rl2ePkib05GpsxAa3YkSeRomzDLB8ZRL+VNksdWntc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RGV3OHpXWExoYTRveVJHSlgza1A5SmxrMlNRcVUwUmVjVjN4UEhFZVZGSGVt?=
 =?utf-8?B?WTJrTm01cWFIWUhsUWJHWGs2eDRBSGd0WHRsRks0ZEV3Z2k0WXBwZnVRRGEr?=
 =?utf-8?B?aURyRHVNQjlZZ1pwWXJ3eUNWamRKcGNaY3k4aEpMNkFaaEp0QzBkQUVOZFlp?=
 =?utf-8?B?Tm1CZmZIWEVsWFE4M1hpajVNZjJNa3pORnN6VFNScmRpMmFKdzRzSC9xLzBn?=
 =?utf-8?B?NVlObVQrck9qWTdGcVFKc0JMVDJkNjhFaHR2RlhyN2FpQndlYUtMeTAycU5P?=
 =?utf-8?B?L0hlenpBOW1makdkUm1ubXJSQ2pCdEJhM0tzUXU4aEpXRnBaVVNVc1pjWTNX?=
 =?utf-8?B?MzlmUSsrUjBKVUFFb1NZMndQazFrekNhTm1kOE1sRUxnQStmdHZzYzhHaGFl?=
 =?utf-8?B?dVdQR3hpMm03S1ZIVG4yRFZIMGtqUHZHMHdCeXNDNlpueUxqb1VkcUNtbFNY?=
 =?utf-8?B?Ly9yZlBLaVdMNm9mNFc4YzRicWdxZFcxaU1ZNTdDRko2MDJIeUZnVUxHZ3p1?=
 =?utf-8?B?cHJMY1VPcnovaE9nOGxsSlVjNWw0UHl0VWpTc1BCaUpSNTU2cmEwZ2x3Q1lE?=
 =?utf-8?B?M0NzSVFlaDNLS2UvM2djMkZMaEZjVlZqVVphWCtnMThCY3Q5MEdjRWlCMWpR?=
 =?utf-8?B?aUUzWVFoT2Y0cUFaRUs1ZjlzUm1HM25UT1lTWUhnNjg2dldzdzZXY0xZKzlY?=
 =?utf-8?B?YlZ2b0NhU3kwYlFwWjZ3TnAya0lKMGlaSjByTlVVRGlsODBGbVp4cWpMQmtt?=
 =?utf-8?B?YytUWTZRMmpjTVh2Y2pUSjA0OW0xcnU2OEN1K0tpRnZ5R1JFV0t6M0xpNnZZ?=
 =?utf-8?B?YXFjZEZMRklxZDR1cy9SOTVLcE9odlFibTU3R0hEejlzUjJhaS93aVlhM0pN?=
 =?utf-8?B?dVNJWE1YUzJjSGZHSXYzZjR1bnBlM3dQS1Y1d1ZpOXZyK3dTdVZINnVsbXpL?=
 =?utf-8?B?dk5wa0dyYVA3VmtXb3NpaFdnMjFrVkdDMTRRMzJHd3gyN3Q4aHlBck5sUURQ?=
 =?utf-8?B?UlE1ZDNjMjRRQlkza1h1bTd0M2Q3emdhaEZCRVNYRk1BQmlSQ21uWDFhVUwv?=
 =?utf-8?B?Qkx4R2tmVStFeXdEeEd6VWd5R1R5QnVSaVdGOHVuMEpSV3Jtd1ZkVVhDOUhu?=
 =?utf-8?B?cTZLazB5YjJIRDM4L2t4T1RoSmpzV1lNR3ZqK1MzSWFMNTNkbkpLNG81eEZa?=
 =?utf-8?B?Q0tVcVJzN3FaeUFwQmVIb3pNQjh2dW1SbTdjYnN6K1k4aE82NS9QL0xoUDZx?=
 =?utf-8?B?UnhXTnlnN2tXRjV2ZEF3dFdDRDVDY1VGd1JxSDNFbUlsb3BMUUVIL3M5UDQ5?=
 =?utf-8?B?REFaNEwrSkhEQjJtY1Y4UXQvL1pJK0htcVUyUWplVEhKSy85Vkd0aTNyWlpS?=
 =?utf-8?B?RnhWK25nVDRQWHFkUElGY2YxS1Q4aTMzRzBnTFI4eG03V0Zma1ZGNWpjVFRa?=
 =?utf-8?B?bG1PNW5sZTJjdThzcWwyYmJ0WU8rZkdRL0Y0ckZ5SkRwc2toS28vME9VdFRN?=
 =?utf-8?B?TnA4SkZPNng2UjMvdzloQmFmc2dLdm5nUFZiaXBsdWZldFBtcjd5dnd2aUJj?=
 =?utf-8?B?MHRWbWhmcTlCYWM1ZGM2aG1rV3pweGYxb2JkbFdubmJocE9veDdYRExvOEVE?=
 =?utf-8?B?U2M4RGtBSjBkSTNuVUxjdk1KajFwMlZpUWR2RVpUVks3a3JQRUVzajRSdEls?=
 =?utf-8?B?TDcvemFhSWp4MVNCd2FrYWhLSlpVSU1WaE93RTJmSG1hZ2p6YmovL3RXamda?=
 =?utf-8?B?SDg0N3g0ekJMWGx0MFlUbHhQQzUxVWNqT1JuczdkMm5UNmNGcmpTbzgwck1S?=
 =?utf-8?B?bzZaemtSVVJ3MStVUU5adzVCMGlDRTVxcjJoTXVDd0swRE41SmtySFVvK0JN?=
 =?utf-8?B?ZTBCd1pkR1JTVmlOZDJnOVNXb2hYNEo1SjZZVzlsMjQxeFhqNENMTFVuL1dQ?=
 =?utf-8?B?NDlLRVBqSThrQVpxME5PQkVpbFlnZkgzU3hTUFViMTE5QS8ySGptVlUxQ0dr?=
 =?utf-8?B?Sk9hYmdEMDBqS013U2dCdlY1WlBzUlQzajBIVVV2cDRsOFliTEdlWDloNlZO?=
 =?utf-8?B?UzF5aFNkdWJnZ1lJOVBDQWZZdzZNZkVNdGN0cWFQL25PMzhGUWwrd2tOdWNl?=
 =?utf-8?B?RDhlWWJHaHY5b3dJYjgxdXh5RGZMZ0QrMVVSdktXTk9jSW45bGViVXVpSVFX?=
 =?utf-8?B?bWwyTWxrbTFCbkxjZkZocFBaa0RkZ0tpRGNEOFNUcnEySUYvVG1aQ0JibjRw?=
 =?utf-8?B?WnFiMmxGZ0Z6RUs4M0drYWpQUXJVMHJONmJPYXpjVE02NWs0Tld5Q25yb1Ns?=
 =?utf-8?B?ZGV0M3RoMEZEMFh1b3JQNEdrdXZUZ1czNnJVbU5idUIwaDlYQ3dRUT09?=
X-Exchange-RoutingPolicyChecked:
	hv/Njk4mgk6g73hULmHF7M24ALFdQIow7Il7llyhtgtob65yjqV07dPCOzkFSblLtl4Jhk8kuHU/GAVEjCMijPI5Tqnc26EOYAycYsUIXcKBcXPfFhxzkUTpbHnaIr7yKg3SDzaIj6OCy2fasWQwbHqJL5IuqNNK4DV9lb4UlSMmMkvK61Y2dbrCHK1BhtB7C2jmT/uUp+daEka2vqthZalyAltZquN5nl6jPxM4qo/06mdcebx0ns8kTgN7c+t4cV7XkPDo4a4rgfEPcTAlQ+4CN3CTiBmaHfdY+ij9VpHzlpqNRydamz6v4M8NKcLiCxD3SOcJKJ7/R1ciSITzSQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7e8b55-6236-42a7-ee44-08df292bf1b2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:14:42.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfP3ZfzA5zMErqOXF2NcBPFTT1o4WprZ6AIXSU1t4NUCcPm0SSxzzy2pMUO0mRe0Kd75VnZXAkJcx4glNYLyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB989571
X-Authority-Analysis: v=2.4 cv=XudvqlF9 c=1 sm=1 tr=0 ts=6ace2ec5 cx=c_pps
 a=jJxBgQE0Gv9vBhouG1T1Tg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=g8XXJ0pksu_Y19MBRcAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8SkSV3f_5-NMc4BAYbtLJhccSMo_cp-s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX4YZ32EwACRnc
 Nb9xmn2j9iqkYstyiP86LzwlS95jz6YxSKOKiy+1GA9Oy23NOda3gTG02WfiQEoL/YM7xJSk57J
 5zZNjVumMsUOoYPUjKFHnELXhmOCad5aWBt9oON8vtygSmWZikPF
X-Proofpoint-GUID: 8SkSV3f_5-NMc4BAYbtLJhccSMo_cp-s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX7vX4RvSPPcrk
 SPfqZhBtcD5tlhRc+ZAmmqKs6P/0S75H9oU6tYruU+KZANsH0QiU9CYwJIyGcoOIJ7Q02hqP3eT
 UqIP6dm6Q23GwLIYDWOg7PFL0BoCaBbdlB1N/eGBpLD6bK7+vi09pM9nzOxdJ9s2CU5g5fKKqv4
 lnxtRLNKTnxwDXrRrYDAVC8epMmgu0UDuO7hueBOiQknYGEDrhnWAvzijJAecCjewxlmS5YJy5a
 Tv6u3NMgyzw4corPFZcthDc/O6ZhCV7miSl8qUGZvHJK664+fSxLM1BJzC87KxPnRl5d5ZynR+p
 G1qMMM89AzErx4/T7KpjV7jKko+H8yicKsTB0ic/jdvCaDGDNCnDmn5XeboZ+wcWUrHcoWOUT+Q
 hUY/x7d3tAtBxEisHxMW5VzoRjPyhAoxtWKwLEB0KQAdiTxvkaVOk+HR0s9gfTlgBvD3JwaPrNt
 4r+73pD/GYH7XiuJgkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130052

On Fri, 09 Oct 2026 11:43:34 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:
> The LTC2493 is a 24-bit delta-sigma ADC with 4 single-ended or 2
> differential inputs and an I2C interface. Its channel map matches no
> part already listed, so it gets its own compatible rather than a
> fallback; no new property is needed.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
