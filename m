Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6A39F190;
	Tue, 22 Sep 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087738; cv=fail; b=qe8iz2tsKd6agId9VoMYP2irngD9H8mJdgaoGe6Vbqn2n/RPPinD8tHJg4IT2ZaByj72hZ4JeJIzYojbW6rTncaf0VfltLka1/xoCo8ANuPKV3AUHrwArbsqLqPzSPBuaZvUTqY0PQszkgRcfCHas7reT+CCDcZDLbmRhqCgaJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087738; c=relaxed/simple;
	bh=c94ERG8LuprI5pjaPEHf0sztvoUtQv5xeTrv1MiKFpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dPlEMlYJkmOMjEA9sqgFm0kKGTAknjMws1IQmGZFJThcgnjiXvmyG0pHVAHEsiKsH8M7U3VDcBzZz0VRHVsYysToGHbDNDWFDqysToYTkP6yp1nQxtbgDXTpDMsHuDvlVt2fR6YDGxYsKP5tDp5nu/Ips7uSGtSy+SDh3xfFzmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dGw5mLWP; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dGw5mLWP"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBQ7pR3783298;
	Tue, 22 Sep 2026 10:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wZDTD
	VF3eqi7WEEn4NS9bVosLqbd5vgU4XZjUIwfRnc=; b=dGw5mLWPF8wtb9Hm527E3
	7DxiP2lou8thym/6200Z35yAdFCjJhUhNF6yIYNw8BGQBbQn0WEKjHOjStBH+qJe
	2A/TAFyNMpxT9cjTTiwINXrzNJfPrGTb72Hbi6vI89VAgasmW5+1IcoWmZ9/D0Z2
	wlhbKUI761ChtVaYQ0SzUkh61rX7ucWqGBM5+6zIz46138e9GImvzUTP790YOtn/
	n5/K8Xh4CZrgPJorbZufoWmDfhITxrJmTwWNEESS0hjq/zLx9gL50bbUdV9QBoDV
	aMIqrPxIt5k+H2+PIxyCCis7Ak6y0clikPhmK0VnNZn99yCuDDbWwgFNF4P2Dkdi
	Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gsm83feta-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:35:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voPuoKgTGX+JY4JBqdz0LzsZmlxsZBh/cWi+iTVsCVgfV75gkESs//0Gso288CxzQFyIZCuijOPhs4ohaaVwcTsDypu2Ni0pDWiepBjKVG4eZkLZFdrtSnmr4GH70F38WDP5N5XhDktQswStwDgk9UgvEI8JlUxvGadbjGK6vEp6OT23hBmf2B9mKg0Yw3DNJN3qtIL910sQCSHnHEq7ZTfrNFelDyysfZpPsZYILLxgEKAkHKaKFWxBVBY9mMvfKfHrXez7qZ9QQPEv90VVd9cKtdoZoxJ3PqjZfS1e0wFkJsp8HZzctG2q01jJpKDbFc+8uqvujU5AfsT+BQBdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZDTDVF3eqi7WEEn4NS9bVosLqbd5vgU4XZjUIwfRnc=;
 b=hXrw5hn6Wp3M5fXupKp/1jpgayq9/AWY0Xeply9UW1sL2TMvPS2tRsK2y3lxVyC2Ue5gSa7GD8s4rCpyYzpr53r+h3qhlzOlwvaPXr6dLegCCMzNm9wBknAtk4X3eYlfS3erVHgfW7oG6a4aPGDgPzBOdRJzyfuceMv3ApeBikXFfZxv5RNLnqBA2OG8m+K/yOLRFBsPZ7tz9aqSje8m3viytmpfVq3/N9SfXQ6PPDPJL3PNfEulzQuhd0BGBQwHAv6G3gHz3u3m689BY+YJDzjMt7uwZoA6zn+jfTY7drOPsqqvZEE1tfcD5GGWBZ/fbkvHUGoHfH1J2Zy16gyz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5456.namprd03.prod.outlook.com (2603:10b6:a03:28c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 14:35:20 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 14:35:20 +0000
Date: Tue, 22 Sep 2026 15:36:36 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Bill Wendling <morbo@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        codemender-patching+linux@google.com
Subject: Re: [PATCH] iio: st_sensors: add __counted_by_ptr to struct
 st_sensor_settings
Message-ID: <arKSPA7hGmWbXVIu@nsa>
References: <20260922112111.1970872-1-morbo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922112111.1970872-1-morbo@google.com>
X-ClientProxiedBy: MR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f457f11-b8b3-4d79-800c-08df18b6bab7
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 AmFRBb3nYzAyqaMetqZQn3izVkSWZt+zg0Ua3z4pGvkHakn5iCflhL/LGKV4y4/v2g33KFGWLXCPJdGVcyUWvjn1lUfkstR6rWxNYjrA/fuqiGqwDN9qfgeDSSKNsglhiNEkIiNVF9BN6wFcQMB4qPXMA9H0YiEXnEzwkhuS3nkU+w45fCHUaN0QHCmH/QauWcwqft8awEPeka484AhU+oNKhaSJ84QUjfYkMiK6WhrRCE4NKLxV5LwdQblTYK7HR9fLpawsCEcyKtnEkByjxOA1dE1BzSSDOG5nwCF9exotduWIQM+bTmV5CikKTqaf7XBUWhov2oTZZbBQDEYxxw2/BoRO8cxrJkukneOtprzoIdQcoEUNNBNvebZIprQN575RMhMPOj2+gikNfSW0vhBPm8stkFdGiYmC7S0Tqu9fI4dyOwNyEHh/Jxh01wj/y8eoR/SR5ajm43335+AO+/uChckSZZGG63nKXbrH3QkPMnRPXbdex5iVbDB+JUssL86MhiKirS53m/NeKrI2888utZJdrsOv071aDqNBHzsUo4MPAlnLIZc6Dl1eKTgBRPDdN9SzczqO+aOJ043yjsZcZNeipyXrRBNqggMAEMhWgAJIKxmeFRJI29h0PX8UBRzu7f5PIYaVHqUdY0PZ476JbN7wtKVbcYzpKSl/a3I=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MWdOWVhqMGRVeHhkNFFQMDJHKzlNZ0dFTXp5cU45amR2OWNpa25YSm9zejd3?=
 =?utf-8?B?UkhUSGt0K1I4UzdzeDlXRGozSHpjSkNyb2FIckFSZFJkcXU0OW1DVnhsb1N1?=
 =?utf-8?B?TlltdDl2dEQ1aU03MGFJaUhnTFdTZFVyOElwaEVIdGNYRUpFVVJwTXZ0Wmda?=
 =?utf-8?B?bGY4QnNUM29lcEwrNVV4aElpMm1xN2RaYTVnWGkrRVluUlVtRG1lbTI0a3da?=
 =?utf-8?B?NHEwWUdPMVN6ZUN1S2NmRndSd2VPTVlobTNPUHowa0RLMmtSVDU5eUlHZEg5?=
 =?utf-8?B?TFlqUExQQmFVa3FGeTF2a0ZJRS9RSyt1aWlJTHJUdjhnNU4wcWpaODFaQXls?=
 =?utf-8?B?dVdlcXJETlBkOFVaZ0ZzVmM0c25wSnZaRGpuMEg3VUVLaG53aGU4K0trbGFy?=
 =?utf-8?B?SUx5b3pZZndHd0d1WlVrYkRZOHJYRzc3bk1ZNTZ4SGpjRml6c2RtSGo0RXRB?=
 =?utf-8?B?YWpRZ2ZnVUl0UVRMRGFkVmhySjFoZmFRdXh2VDBaYm5paDVNV1RySzdieldt?=
 =?utf-8?B?a1dTWVZZbEFXVkpYanMydDlRU1ZrbGZOTjRPbVlWL1h4TnZhWUhJdy9ET2FV?=
 =?utf-8?B?ZGljbnBFTFJNL2FNWlgvVy9VeVZsV00zSk1wMWZBTjdXWW84SHRMbVJmVlVx?=
 =?utf-8?B?SXRNaDBjUWNGM1hRMGhSaFBjRXlaWmpSSjhNQXBtbnJRTWtXVU1XS01JTS9x?=
 =?utf-8?B?N2FwN0dnbVJiQ1hMOVNaUmFCcWs0K3hibitQME55ejEycVc3RDlqTUFwUTFU?=
 =?utf-8?B?UStnRlVDMlQ2K2hCL0ZINWUrSlFXOXVxczNqSmhXSi9PQmFxR0VEdTJ5Q05L?=
 =?utf-8?B?QUgxMEx3RUZnbzJMeHhqa3hTc0ZQSWpMWWtqbkpvNUE3a2c1NmhHdzdML1Nm?=
 =?utf-8?B?cEZseHBvYmtWZ2wxUTdUd2ZHNDBGU01VeGw4Tk5rMlV6a1VIcHBkMWl0aHVP?=
 =?utf-8?B?UkVoc0QxTXQyKy9BYWZGZ2xUbDBZU0JKY1ZoV1VIRmdCSFdMQ3dleE1rOUw0?=
 =?utf-8?B?Y0ZuOHdUaXlHdVc3TUUyZk4zdGpBd3BySGVSc1k3dHNDaFZCZVFNWU5UNVA1?=
 =?utf-8?B?dHBNSENQclRjeEVjMUlFM2ZYVTNCaGVBUFpMczBuK2twRzRNU1ZCQTExalgv?=
 =?utf-8?B?QnFQZ3QzT0tIbG45VU5DaExPTVI0WmJaTVFFeC9pOTFMRzJNeGVxQWlRcEx3?=
 =?utf-8?B?WlFZTnY1NWdWWUU1blJyajlBY0RXaHBjWGJYVVdzR3hvbHhWZE41T2FBVTly?=
 =?utf-8?B?bG5rbUdLNVQxdTVTQnVjbXBXTTIvemkwTkZuMFpjNmFLZTI3WHY0RXU1NDdX?=
 =?utf-8?B?bnoyaXhKNUtVVXFpOUNZZkFIN3VydmNnMWt1UmYzeU5pcWZIeHh0eHBVcnB5?=
 =?utf-8?B?bThVTTBSNTlZcFFuSDBWMS9pT09WcVZVNEU4WEQ2dzk3QnFJbXhiUXdUTDB2?=
 =?utf-8?B?QW5xaFVhR2ZLc2V3UFR5bS9hVFh4UnYzSks1UWR5NWtnVTlWZVRXUmxyeE52?=
 =?utf-8?B?eklweUs0dFRFWU9NNkhUZlU4ZFAwUU03R3MzTDlaS1p0QTNoekxwQzZKSlZ2?=
 =?utf-8?B?Q05FaVlCdzZjWHZuK250UHJtd1lKWU9xUDhkUm1DV2NBNjhyM1EzcUIrRnI5?=
 =?utf-8?B?bng0ZndXaU4xZGVKbW1DeEppdFJOajF5NkVhTzJsWU5FUGxmajZkc2pVekJq?=
 =?utf-8?B?YlFMZEk1dXZtSVRsNGNSNGZGZjdxZTVzVUFTTCtWQ2dja1BFaElTQ01zVjkz?=
 =?utf-8?B?TFpiQVBBbnJaMkczN2pGc0JoMkVPNnFhSVo5TUlSM1FHajJxckZDSUdvbzRO?=
 =?utf-8?B?KzR1ZE9ITGg0V2VqK2ppYlhTbnR6UE1xaVV0ekpGelpXYWFxMHV3bnJWamRQ?=
 =?utf-8?B?bjdDaGNyay9VaU8rZFlsU2tOYllvcFF6cEVGWERYbEo4WHF5MkJmTjgrUWk5?=
 =?utf-8?B?ZHg4MUdsVEYweklXa2ttbjVWVkRCV2U3V2hCQ3Bha0JjUXp6NUN5OFcwakF3?=
 =?utf-8?B?U1NObS9aWW90dERhMHE2NjQvTTdvUHJ0cjRkd1hTcFlYbm1tcTZTY2lCTnQr?=
 =?utf-8?B?MDkvb0JNSE5xNGdlSTdmNDhyZzhiV3RRV3NManpzakVVakRpYkx5VjZNR296?=
 =?utf-8?B?S1NMUFpMMlZ1TE9LREpyTk03bkJHa0ZhdkRmcHZHYXB1M1o5NGxGclMzSzdl?=
 =?utf-8?B?M3JmQW5uQktGV1NlNWM2K1ZLN1NqT3d0MnowL2ZxNm5MRC9aODYvdU10K1c2?=
 =?utf-8?B?MGdhTEFNV0gwZ3VPeURFcnhlRDNRR1B5Ukc4M3UxN2JhZlJFcE4xREZmVGln?=
 =?utf-8?B?M2tqU01PblBEVk50TFhvWTViMWVtNC9OeCtieU1uWnBIWGdKdFlxUT09?=
X-Exchange-RoutingPolicyChecked:
	EQZCWre6SMRMGcXqYu+R1pckbF8uNa8tXtbi16RBe/Wfuc3mFLO96N7sGceQod/YGrGJDqBjLqA0xwTPqNKEo6UjJWhfuQ88IXw6ZJ3fvzsYqHtYu1MY3e+xHY+bYJZZT3wx7YnZSoMRR74WyzfXJEdJL5BJ8J6Rh3tfeeB8Ok11hHsDvoiGU3WHaU8u6zCs+z8RgRm8pRrnzWYxPwzyQyHw91nCfecC8SM+WyCSAkWLNfXMPx1Tzp0KomB9/G5B8Q1V+5IZW0sGn3waF4eWaWT/M0Iv5kUu3HFGXZpQx1TnZr01HTWcQ6Lpnsr8lv2wSj0fPLKIlN9A19PFbl9/BA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f457f11-b8b3-4d79-800c-08df18b6bab7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:35:20.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcMFB43aorx5FlHirx4ZNTf4UfakKa7l0eKdmKtvnjWKev116dHVQ9vsAjE7jR7ASxJ2JEAOiWpBCGwM97D66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5456
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIxMiBTYWx0ZWRfX4p6Nljxf2jcB
 I7fkwctgy67hvRhIXGL1IrkCCPBtvwrxL87VUcKiqdvm2LPKnH1CYcsbW+uHlLEwwkqxRYNpfT/
 Ewyq3w29Y42gDrlvwLbl2FSPWKQqAd0apbzYJ3mkL41hI8dWqXPK
X-Proofpoint-GUID: t-bGcMkg6BtMY71oVB8ReqI41DbLcxWy
X-Authority-Analysis: v=2.4 cv=e66T2qp/ c=1 sm=1 tr=0 ts=6ab2922b cx=c_pps
 a=zLftBE+EtYxwi/BgDV84wA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=1XWaLZrsAAAA:8 a=gAnH3GRIAAAA:8 a=8A-kgZgV7H4LFlDSZ1UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIxMiBTYWx0ZWRfX800tNImx2K2z
 voLPpPLXYJgdugQQFeHkvt3g5Am0zmcmOqLLgOsRyBU67c1MYruAG6TvJtuJ7gGoFyiAfHp7Zye
 QwYVKsY1TJ4lAyuETsaCmeSsNeh/jegl+7JGpFA+luJjtL/D6VRR2sO8+JpbiMEEvbmkXICx/83
 CYUbS9ZleXPFfrcA2lH8KnWICZpZCw0nY0+2nRMcZ6rWALufdp2Cnzt+gsl2RuiJEx3XgWoPCw6
 7wwX92SNgT/34UKbGhNKFGEvM2CORQqtjE0STjjf1+oJ3H0dI3UcSU5k9/57J1dXs/PiVDNG6d1
 /ssa7rMCjKSPmUt9Il25U5gd8+GogJ7Qds6r0BY/BoHZqBsGyvoTvm4QOZk4I/n3knNVRAqq0ae
 05cAUuMzBhMHt7dsab9NDoQTbNaPJxzGTqXK8oES3STAGtXkVMVZCre2fic2WMjYH68aiihO33D
 UeDbAqukTpWsax99yQQ==
X-Proofpoint-ORIG-GUID: t-bGcMkg6BtMY71oVB8ReqI41DbLcxWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220212

On Tue, Sep 22, 2026 at 11:21:11AM +0000, Bill Wendling wrote:
> Annotate the "ch" pointer member of "struct st_sensor_settings" with the
> "__counted_by_ptr" attribute. The elements of "ch" are counted by the
> "num_ch" member in the same struct.
> 
> All instances of "struct st_sensor_settings" are defined as "static
> const" arrays across the ST sensor core drivers. For pressure sensors,
> "num_ch" is explicitly initialized with the size of the respective
> channel array using "ARRAY_SIZE(...)" during static definition.
> 
> For accelerometer, gyroscope, and magnetometer sensors, "num_ch" is not
> explicitly initialized (and thus defaults to 0). This is because those
> drivers hardcode the channel count to "ST_SENSORS_NUMBER_ALL_CHANNELS"
> rather than using "num_ch" from the settings struct.
> 
> Since these structures are static const, both "ch" and "num_ch" are
> fully initialized at compile time and available immediately at boot
> time.  The only accesses to the "ch" field of "st_sensor_settings" occur
> when assigning it to "indio_dev->channels" during device probing.
> 
> Because "sensor_settings->ch" is never dereferenced or accessed as an
> array, adding the "__counted_by_ptr" annotation does not cause any
> runtime panics or false-positive bounds checks under KASAN or UBSAN.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  include/linux/iio/common/st_sensors.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 1ba496f0fea5..6e914ed49529 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -206,7 +206,7 @@ struct st_sensor_settings {
>  	u8 wai;
>  	u8 wai_addr;
>  	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
> -	struct iio_chan_spec *ch;
> +	struct iio_chan_spec *ch __counted_by_ptr(num_ch);
>  	int num_ch;
>  	struct st_sensor_odr odr;
>  	struct st_sensor_power pw;
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
