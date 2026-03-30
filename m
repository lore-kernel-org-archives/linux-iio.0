Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D0393DC0;
	Mon, 30 Mar 2026 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774844315; cv=fail; b=WF3284euaHfX8lFfsjzXgmPJAnno/9ozq+x/NthhcMY7o3gxXDeKyUITKdWMTtdXkUntKLipWP7l7r9A4DCHeM7XFkX+ApGoOXSkO4bXaY7pEGH95vLMtSKT3eUp+yBB2FtOrYZ8dUh3Sr0APBt5F+vXIsT+ggA09w3gv7uEu0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774844315; c=relaxed/simple;
	bh=6Jj/Puaws2oBzaNO4psN1DBN6rV1g7emly9aj1GxFnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bu2COm9GeHkqWVziiWnah0SUlFDDE5ZyAVl43+8p9yqUI/1+w6nY1tARneQ7eXmxmJlWk721VBkaOVQt6ffURX4KKsjocJTkzSI2qeMdzQPnBH/LpJyFsR0T14s5CqfaI6aTYht3wPn+9Llai2Qsuh5aKMHKURPIWo5Yu3x+clg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QToyoNgC; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QToyoNgC"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U2eBMp2262957;
	Mon, 30 Mar 2026 00:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6Jj/P
	uaws2oBzaNO4psN1DBN6rV1g7emly9aj1GxFnY=; b=QToyoNgC9A79LDfEPhwNm
	x2s+Oeg1jY4ZO89NCYRECJXGP1mT/BPy7Iz0y8D3500rGwNuy++qjr6QAwfQkRmL
	NbRjZfUr0PP+JOffM4eVUebvNztiYo71w/WXMZfh1Bax9TfyHfhreppkPUH/9x2g
	ER+ykrRdjcM8m82r9lVfDGqAREXrcNJureE+uc/dJT016nIQHtuClByIkVShO4cP
	hnEIyZdlZ3MfbFP+N3swZ59WI3mdUgjOdpXwD5GtEE4HxRt3vax9F0dz1lEEFUie
	YltsOxuYujS1skg5w0WsEEgNZtDWCwmPhZCi5Lu9wu2mSuEfQTBimGt4s+jiF0DW
	Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d6bm4mgbv-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 00:18:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP9emlp6MNoqNVQ089tPIWWU/7zu14wTq6xVvnyMPcDgrapTn4J62UjOJJPr8Oi/Y6UHV//vVwGVKMEW+DcB1eG9A+anHis9+Zuv2wtagS+WjL+FHoxNygPEUh+esbLClnmdWYAn+stn8fJYcGpV0CnGez+2vZAvukbAhEBRUR05FFyaUXwuqyUkcIK0O/kfJfFWecbHFToa6Ex1rlBP2wkQhQWSicvyhX3IwvTXo8PQIhTW6Oay/Mpl54Kr5U3B5z5JpGl3J9K/YE3gYmXcH91iyjcbCIkVOIoNqti0IP3IUukR4LoSEBgGFUPKC4RDsJxnzOD8vRSdfhdncDnTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jj/Puaws2oBzaNO4psN1DBN6rV1g7emly9aj1GxFnY=;
 b=Ht7rsQNjoEnejcE8/jHs95tDg7AMMjbdlg2T8VQ0EmlhrrDk+lkvPNOGzZFOO1ajNHZxC6k4TEzGG/DfAS62sl0huw+hWoYxi+W16DGpfJ23IWO82f0JDj7z31WQ/mNoFRoo1HS3rYkB3hpF5HzjJa9aJGBjcE/iOzM5dUn1PXlBABSwXFNgcGLa6DCPPIE+3jOtPsDiAZ0QvedgzlLHw/gxS46NOGusLp66xqneMvzQJDjwvJegsedfjczeJClE5wl9swzLc4n8KVRlLhMGKWe8pK+szKBb5ZKE97EOkjf8dTEnR/8h+vK41vuJydSb1ovx3a48B9cBzRmNVVUUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by SA6PR03MB7925.namprd03.prod.outlook.com (2603:10b6:806:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 04:18:14 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 04:18:13 +0000
From: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Liam Beguin <liambeguin@gmail.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "Marques, Jorge" <Jorge.Marques@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: ltc2309: Add read delay support for LTC2305
Thread-Topic: [PATCH] iio: adc: ltc2309: Add read delay support for LTC2305
Thread-Index: AQHcvcz1v4MPWhIabkOdSRegn0OGw7XGeUYQ
Date: Mon, 30 Mar 2026 04:18:13 +0000
Message-ID:
 <SJ0PR03MB58549445B7E093E787641A24F452A@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260327034159.15545-1-carlosjr.jones@analog.com>
 <acZPLXhC9PWNIpeN@ashevche-desk.local>
In-Reply-To: <acZPLXhC9PWNIpeN@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|SA6PR03MB7925:EE_
x-ms-office365-filtering-correlation-id: 7e37ef76-1b6c-402f-a157-08de8e135c4b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 ts9nM2OETUqKGN7UIcbR1IE/4DuCKZwb0md3LIXlmoJLk8A52qy7auBVgJV0CKVC8rDA1EGhb8Asbi8Kfr+1+8V3Pnh0M9c/F1GVlgwfXjNuvhZbxJ80QIRmog5eHcQaI8ntmpje9j8t1hzf4Qvls6bbbUPJN5r/0LWX/ii/HzEX+FGzObM+s+0B+XhEUl5VTLsOruYnsZvoVoG4TIPHzgf4KH8fYcOZ17YNxRBEKNOi0GN7w5Tmmld9WVd1q9INvEaf3HyGbNqCNHYzopqMnRyJ97bSfrGyc34tZSatnHPzhnDQdE1dv66N8gaMFk3sXSYgI770cdti8w/FI6W9V2bcTjjVnbwC2nzrlnP+Gnyiazl5g/mb2A3Kv3BO1AyclyT0Dt8hbnDDDsyQfYCcsF+keRp0SWvFvn5de2j1xMfKUKQ1IzC7hWmCW2llgS3PncuPAAzECP3FRenmIXB/lq+gylA4tMYsZ861aYBrSjfDASW3+uGl+5ietude/3rFrIKlOjIxxHlO227Z68wCwfhqPyS0Wh/rHXruSnpJtSga67rL4RLktSalhYriOf2QcuFJunWKKXSaBK5T+hN07iTlMmrfqeWorJeF3b9MbxFzdkEF+V05TLfpYcE6KQ2rQfQzmcnxakNIaq6AJZFn6+BMI09/22bhmLvD+AB90Y8tcP1XohWQ9E7YiUDqkboINU6EW5gLF6RC2Us6kopszPFPJgD+KipYTo0XlSUoSodKT+XXBQ6G0y2qSaDELjVtwbTZnJC6HnJM7xicfgf0OV6e35zAgkaieX/wgqfjsrk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGZMRUM1ZmRWaHZiYUIvblA5bVY2eFN5VkxXMG1IWTcrWUkrTDRvcVdENHNO?=
 =?utf-8?B?ZFlEWkU5MElQc3BPTVB3MmhQbTF0Slh1NVRBZnBLaWxGL0grYzMvRCtkOXpS?=
 =?utf-8?B?dHI1MVQrQkdhaWdsbjZYb2NUVGZoRlNIM2VKajlqOVhLcWFRQVUxaS9VdVA5?=
 =?utf-8?B?czloMFJXWWFpemk0UW5YMGk3ZkN6N0o4MmdScHF4U0FQQU9MaTFYMXVQTHN6?=
 =?utf-8?B?TFZYclJJaGJFYjVHZWNyRTdvdWtlc3JKSlRDTEVoNVpyY0VlNFlUd1JmVG15?=
 =?utf-8?B?RGNkT3N6VEFoNC94VEtLaFMrc3ZDcEZsMTdGczc0bFBHWm51dEFPMUhYc0RC?=
 =?utf-8?B?dWY1SUlTWDBiQitSV3BMOWdTZmtQeUNXNGRJQkN4RG5nV2dMOC9lY3ZvRTZR?=
 =?utf-8?B?UlgvVW9HOFlLTm0xOXd2clp2aDFucm9yR0p5enVjTlJ2RktqYWtVL3J1S2tM?=
 =?utf-8?B?eEFmQktGYWgxTmRnZExqZWVoRGlPWlFwTk5vOUFvQkx6WmdhQUh0bTF1SVpH?=
 =?utf-8?B?OXI3M2VQaGFzT0QxNTRwOWp4RzV1TU9UMU9HaE9tR0xFSDFWczQvaDBmSC9r?=
 =?utf-8?B?NjdObXZ3TEZLVE8wWjFOalV6NFZMKzRoMG5Pejd2VWtUMTBnRDVIU2pnbm1a?=
 =?utf-8?B?U3BKRHJWWHg5bTBpajFxV2tHZ2FKQUcvT0Z5eEJSNWR2Y0JZTnpsanBuSEtR?=
 =?utf-8?B?Rmc1RUlySmRaZHRZU3NVQUNPblpvU0RHSFFIUFlueHVCYVV0N2tmVGRncms5?=
 =?utf-8?B?Y1hYQ3g3STNPYUJKSWZNUDlOM21XL3FmR0VZL2E3bnVEYTY1UlJSRFVsSTh4?=
 =?utf-8?B?WE8ya2R0bmxxMzJIalFzdG5uNDFqZmRCOCtVYzh6RGIySVA2SnVTQ3M1ZHV4?=
 =?utf-8?B?RElJN085b1BFN013WHZKeERxbnk3UU5TVHM2TVdoQi9lZWxHTStHZHpFQzNP?=
 =?utf-8?B?aXlnZjFUN1R2OWNCai82TktmbHVTNkhlUy9PcTRlSkpxMGQxWXU5RlM2eGNF?=
 =?utf-8?B?eFhGU1EwSnl6Y2FLZWJqdmNDdnZxSHZEZWpLTW1xOU93SWtYbjhUM0RwbTVG?=
 =?utf-8?B?SFBPNXQ3MWg0b3ZjOXpXS05Edmk4ZVBKeTRmL21TcGtaUVJvZUxvNEVWRE5p?=
 =?utf-8?B?bXREME9VZFhNNHB0Q0NVa2FxK29TczFvWU5IbVZVOTEvMEdoZjNZSi9KaFpT?=
 =?utf-8?B?YVRncTQ1TDBRbWU2R0krOFdTLzNrcDdZRGhlR1ZETy8wOXlYYWI0dy8zSUtx?=
 =?utf-8?B?dGlsbnRXSzAxQmlTa0tYWURkYXdMT2doZUlVaGR0LzJzSzUrTEtranpFMU1K?=
 =?utf-8?B?T09Pd3hnT3ByeHlSUFBwVVNORmoyMWwyNVZZUWhhaVo5d2loZlViT1d2UXFK?=
 =?utf-8?B?aTdUYkpvMHl4Y0E4VDhTUVNGRnFxUE92TnhocXFqeXpFMlBTVVdkVzBQK2ds?=
 =?utf-8?B?MTk1ZnZNOWQxOFNhTlY4WGIvNERQQXNTRXdjN3VUV2ZOUzhQTjNIbFVNWTh1?=
 =?utf-8?B?RTI5dUxWbms5Y01jSXlHNHpiODhxeVhGTXp5dVdXRWRraTlWME5KMi9DSFlX?=
 =?utf-8?B?TlhkTnd4MUo3OVUzUWhDaGFTNUJ4MTBDc0t0QkVFNzYwZ0FrUW5kcFgrU3kx?=
 =?utf-8?B?QnBlRXN4RkxoV2ltUmFlTDB4U0NXYWxNU0NWY0RsaDJuSGZOVFdEVERoczds?=
 =?utf-8?B?TGU2QlhHTFE3NE15d0V0bUlmeFNQc0F1dVlSYitrcFlUM0xXT2xqNnhaa0ZK?=
 =?utf-8?B?VTJjcTNNRzJZdWpGVUVZZFRQUmpVZlNaRkw5eWY0TkxnV2ZmSHBxWGhROVcr?=
 =?utf-8?B?cXpmWWFWTVZHOFFKNUxqdy9LcW51Q2NtbnowSEtxUnRpSTAwaFk1clBmeFl2?=
 =?utf-8?B?eUJ2Zkp3bnVkdldGaHRCc2gzNzRUb3IyY0kzN1VCWkZBcURjYVpFSWtWTno1?=
 =?utf-8?B?QUgyZDJwME1NOWI0RE9iM0Y3TlF0K1IwTVNYM3ZUa1FjelFIeTl2SXN6Qita?=
 =?utf-8?B?aXcwUkJUdEZzU2RXejFpTDY0T1RnOTVWOFhUVTBzWVp2QTRCK0hVSkd3OG1O?=
 =?utf-8?B?RmY3b1l6dVV2VENPbEhmZG5sZGZVcnJyRWxoZjdZQThucDg0dGIzejZOYmYx?=
 =?utf-8?B?R21sOGpBM2xrVHVsWWtGL1lGeUxmYkdoL0JtYXNUUFRSdnhFQXlKQ2pOdGMz?=
 =?utf-8?B?Skh2anRrNXdTUGx0UDlMczdVVU1YVkhndGJyMVE1Qjd2cGZRZzg1RDY4RHNB?=
 =?utf-8?B?VUhMdWdhWS94eklkQ3FRbS9hWCthRnFTaVhyOHYyTkpLWEx1VzA2S3BNTFQv?=
 =?utf-8?B?VVFsRHh4SEVuQ09OVnBsRGVNU2xZM21uUHpiQXpmVjF5Yjg3T2dRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jrgtSXB1I7hWKsRENTZHbuy5pcGXufNSUsPibO7Ea8ualSBm6/WZxzEd9gAsz4Z5WIIzi9yx+kNLLfwNiQLewZqrIUcF0qWfkOxJ64atQaMXMHGCrl+us+kkNGF3z1rxUI7dhFJRgvIWlxsYrNaSY2Kc0yTUqhwMFcgOPKaSClTcBkwXV8bWcI+jsDCWhKxrVUNLJ8n0v/2dudKek2lYW5ZYfNIMcApQd8GKy/Q3Q7yQR4EKw5o0PowvHKuHAWvHJgIPoHyLo7FS/q0e4sfnVlRI/H7rVtEHs4ETgM4WvFK5WJeoB9VIChmheaTF+FhYiWMuXrsPpE2kbL39M4uiOg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e37ef76-1b6c-402f-a157-08de8e135c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 04:18:13.6580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwHgK0fp0d9IaqzL/misKp04w1v3NVaCxXDxuuz0PEV6xuKZIPI97o3M17jQzIAq9e8U4Pz0TsGrPvIEJR2Kk7bUZPXf9nujNIGbkNKgZPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7925
X-Authority-Analysis: v=2.4 cv=NvvcssdJ c=1 sm=1 tr=0 ts=69c9f989 cx=c_pps
 a=xQfGHK7Kh/zEjKjNz0BexA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=kqe3gQoSG6rKCZieiv0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAzMCBTYWx0ZWRfXxQIW5qASoBwd
 06CQI6csbEjKjdjqSzU6dkE+Q33ddJc4tVsNmc389C/gurnQp07oQDNHFtK8jHgScbP2UHmWryT
 vwgsiAeliOVtKWzdaHejTL3fcl7zfpuT3SKDjT22Him2uwNpWOhgzItPDO7nL9DgMXdKnWpN6J7
 eUe+7XHOegcE+rD+gH09JrjsT14yIFvlLlTt0QfSQT20JM6pL2PExIJBjirbjcMytazMGjMuo2x
 LnHIZUnGvPHRLQt+AhXB51eYsd+JwpqI3N1uLWG7Aa9a5tPzLxPFjeEzy8OWTDKdyPNbaad3gbV
 aSqzExGWLB28/7EpI9sYf462yWpHUA+s84OzIDNYDDd1OaMKHdQtqgWqhm9tratmU/io9w7X8Hp
 v+PF/hfrNG3IcUmYVhWHUb0P7rtwNTsqGvKsgFOv8x1zU7PJRX3cEsNYqTTdLEdX3imIIAkRSm3
 HNlTlfFwQnevvqy98aw==
X-Proofpoint-ORIG-GUID: ykmFIA1q8rERjnOK4O88CJxnp7OtCEl8
X-Proofpoint-GUID: ykmFIA1q8rERjnOK4O88CJxnp7OtCEl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300030

PiBPbiBGcmksIE1hciAyNywgMjAyNiBhdCAxMTo0MTo1OUFNICswODAwLCBDYXJsb3MgSm9uZXMg
SnIgd3JvdGU6DQo+ID4gVGhlIExUQzIzMDUgcmVxdWlyZXMgYSBtaW5pbXVtIDEuNs68cyBkZWxh
eSBiZXR3ZWVuIHRoZSBJMkMgd3JpdGUNCj4gPiBvcGVyYXRpb24gKGNoYW5uZWwgc2VsZWN0aW9u
KSBhbmQgdGhlIHN1YnNlcXVlbnQgcmVhZCBvcGVyYXRpb24gdG8NCj4gPiBhbGxvdyB0aGUgY2hp
cCB0byBwcm9jZXNzIHRoZSBjb21tYW5kIGFuZCBwcmVwYXJlIHRoZSByZXN1bHQuIFdoaWxlDQo+
ID4gbm90IGV4cGxpY2l0bHkgZG9jdW1lbnRlZCBpbiB0aGUgZGF0YXNoZWV0LCB0aGlzIHRpbWlu
ZyByZXF1aXJlbWVudA0KPiA+IHdhcyBpZGVudGlmaWVkIGJ5IHRoZSBoYXJkd2FyZSBkZXNpZ25l
ciBhcyBuZWNlc3NhcnkgZm9yIHJlbGlhYmxlDQo+ID4gb3BlcmF0aW9uLg0KPiA+DQo+ID4gVGhp
cyBleHRlbmRzIHRoZSBleGlzdGluZyBMVEMyMzA1IHN1cHBvcnQgKGNvbW1pdCA4NjI1ZDQxOGQy
NGINCj4gPiAoImlpbzogYWRjOiBsdGMyMzA5OiBhZGQgc3VwcG9ydCBmb3IgbHRjMjMwNSIpKSB3
aXRoIHRoZSBtaXNzaW5nDQo+ID4gaW50ZXItdHJhbnNhY3Rpb24gZGVsYXkuDQo+ID4NCj4gPiBB
ZGQgYSByZWFkX2RlbGF5X3VzIGZpZWxkIHRvIGNoaXBfaW5mbyB0byBzdXBwb3J0IGNoaXAtc3Bl
Y2lmaWMgdGltaW5nDQo+ID4gcmVxdWlyZW1lbnRzLiBVc2UgZnNsZWVwKCkgdG8gaW1wbGVtZW50
IHRoZSBkZWxheSwgd2l0aCBMVEMyMzA1IHNldCB0bw0KPiA+IDLOvHMgKDEuNs68cyByZXF1aXJl
bWVudCByb3VuZGVkIHVwKS4gTFRDMjMwOSBkb2VzIG5vdCByZXF1aXJlDQo+ID4gYWRkaXRpb25h
bCBkZWxheSBiZXlvbmQgaW5oZXJlbnQgSTJDIGJ1cyB0aW1pbmcuDQo+IA0KPiA+IEFsc28gb3B0
aW1pemUgY2hpcF9pbmZvIHN0cnVjdHVyZSB3aXRoIF9fY291bnRlZF9ieV9wdHIoKSBhbm5vdGF0
aW9uDQo+ID4gYW5kIGZpZWxkIHJlb3JkZXJpbmcgdG8gbWluaW1pemUgcGFkZGluZy4NCj4gDQo+
IFRoaXMgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2guDQo+IFBsZWFzZSwgYWx3YXlzIHNwbGl0
IHRoZSBjaGFuZ2UgdG8gbG9naWNhbCBwaWVjZXMuDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVn
YXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo+IA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcsIEFu
ZHkuIEknbGwga2VlcCB0aGlzIGluIG1pbmQuDQo=
