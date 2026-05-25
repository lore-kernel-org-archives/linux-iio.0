Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB3356765;
	Mon, 25 May 2026 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711441; cv=fail; b=Oc1JJbcCSZpBLLOnY6r4cAlzhYTfXb+l9qE2GMEAlPBzlRo+EWRKTzy5PyLbHo4IxBhj2ZVEoG18a7OoTNx8bw0ZYrJ6zbKZei7NASDoXmyBhaHb2xdidEV03DGHAA5aeb69mSikbf7Xbut28htfK7Q8eHdyqzIGRe6IEleWKqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711441; c=relaxed/simple;
	bh=eJR9wguozZRdaXx6VxXUHObT4x4aWUIB4MWwP1RWHBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dt9fHUhMh+KjByKUcDmph0W2pIHwxTqoKAPMAaAeUEEljHSVVC3XNnq/D7EXTdhXQ3WwAhtu5IrZpXGjxQzceflLLDcF4QXtwEEHznAD8CJgjPs/WYX6HrgGfnvz42cKPUNaRIKC2B2VuvrTArMSe0bzSdsgYij/IC1n1WczNAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mdOTDIAU; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mdOTDIAU"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PBPKIn2477657;
	Mon, 25 May 2026 08:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eJR9w
	guozZRdaXx6VxXUHObT4x4aWUIB4MWwP1RWHBU=; b=mdOTDIAUXY66ujt12ZMJC
	lEual1LdcKn9H9zA/6rf+1cXPEpfQVGn6KXctDLhuZgf9hNdsejej2UDlbww56nY
	Ty0Ap+wuDBUpide8ri4vjyyJv56wayJB6SGQrEowwDEDX3aR8IuExV2xCkbrQPPa
	IE/pTmPzmpZNcDdHJn7caWhj6KtRwqCjpgsurGlPzzzdZ5KJ4IwWIM4/7x34c3y3
	AoY5cEPezA8WvmaHlZ2/UQoCJpfU+BmWbx5vq2S1f7rGMgBWEdUXZdopeAG5V3NE
	wmParF2Fa/QHxQ8Vh4AoIEIBJzObeoVvHc999HVRI4qrLsqxIHCy7fSjZ+acGzzX
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ecbgqa5jq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 08:16:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nU91PEUoMbZmzKMCYsu56LM7MGGgqsT5oAhrpcZyzapz9mgZshmJsh3zdOl/0UaWA66ig10wtbUl+GFQX6Tjq7KVzhXMlzwsLTmCMTpB+PlkENySrEJ3rkg+VGY4dv/msl2KX0zM8sgO5Gg1vZxF9gkAIXME3/cQEa9+az0MrSrnO5RUf3AjIyyjYHHM9cY8YGTNZaN0it2PQC1E7VpkhNMuvq8kEvlxe7umKpUJNTrLHVhNe94ODuABVgMFY2UBSGZ4KypMSgHZwb+j2aWbml53NGLYORG2YI+rZWNnboO3UTmUqYrY32F8TTvkSMeJoedfAayjOvdwlqBRLkwdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJR9wguozZRdaXx6VxXUHObT4x4aWUIB4MWwP1RWHBU=;
 b=YibEETuYavy0y/+leC9SNrkw+GLJvP5NkMXt9C5A+JDQPZJmAClIJrhbuKKcTz4gsdYpJ5VilPriXIaWRQWqclXa7u/RId1RS00BsiocLm+y/YX31QmTxp+Ottsama0p6WwxssmMOj6WY0n6fI36etDXMD+xjzWSs40zC8SVHx9pc92GW7OJbf6LAS9JAPlQZlRigvmDJpRkXgl+FEY6hRIMkvPD8ulZpyVr/bZFnnzYbVu3PqZJlKVZbMVtQ3aoR6l+qqyo4cbp41ISgPmhANqwPVb0FeZPaQssHIB1YLF4SmbHle+3lqGqrk9FQwRvmyA9n+W+d153FHtjErpURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8425.namprd03.prod.outlook.com (2603:10b6:806:47b::8)
 by SA0PR03MB5580.namprd03.prod.outlook.com (2603:10b6:806:b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 12:16:14 +0000
Received: from SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f]) by SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 12:16:14 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas
 Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v4 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
Thread-Topic: [PATCH v4 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
Thread-Index: AQHc6QzoMEt6YMR/EkCc1O+Bvcr1QbYaEiSAgAAY14CABH/8YA==
Date: Mon, 25 May 2026 12:16:14 +0000
Message-ID:
 <SA5PR03MB84250008796EE6F3B5A124DAF70A2@SA5PR03MB8425.namprd03.prod.outlook.com>
References: <20260521-ad_sigma_delta-fix-v4-0-bfb3df3e36da@analog.com>
 <20260521-ad_sigma_delta-fix-v4-2-bfb3df3e36da@analog.com>
 <20260522145143.1e651c12@jic23-huawei> <ahBwbklQh9VKkfKZ@monoceros>
In-Reply-To: <ahBwbklQh9VKkfKZ@monoceros>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8425:EE_|SA0PR03MB5580:EE_
x-ms-office365-filtering-correlation-id: 6dc25ea6-0671-409e-c53c-08deba576a89
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003|3023799007|4143699003|11063799006;
x-microsoft-antispam-message-info:
 ko+Ylf4eqEzLXaZo0mWkcx18c9+h+GEN3nm1eR9XgH7K3X22K0LSBi+HbmKjagmpN3p0eJH68s5sKWnx88Fp5Qk6okQ10+5xDOC9xXZ376KlDl+ayorRrQuBFwrReTbrH7lfUb68moNR0FfQqSN0x3bHJQh3NQrvMgmQ8V7vY71rzsdRZVRDJaRbuqKSdxe8ZykzPnIpYpckJFjeJjN41jhZsOuQDEpqEqImWzhEMmEt/TG9iVXXZ0Kka/DavpIVqgEWyPP5zM3LXQCydHsTWnWC3w/RLW5JfvHgHuq8QJnvwGY/IChZ/+ZOfk1DMox7DpEGaaREOJ4yOF62vV1f1DZNu42xiX1u0jQYIagyurTyywAH7nRykHN/S07y7K3ZtjIAwFX5BhnI+oFD3LhQksU22Xd0ExppiHTS2Wk9W1ZGp2KfBxk2xKJI48vUcJNBofw5tCZjwSG1NO+W/VzCQkaZQniJlcwtFLfCWzstrKAcRVA1qZjv5JPdyeIE/XGI4NA7I8ENRaCS8ukiYwVlEDTOHsIL9ClDr47mEBNs+10YtbzrOi62jL7TvLaW3PEJQkZNE6LsdHxxCP7ZJTCQ7M2X3mxsgS7DRb5laUIJUDKDVsoAbEMpnc/uj1ksk2F7X8lPgck+yqagB6rBimK5Q8d0UHA6qtvjC79zGSELspCAkyQ1kjXAEBdffjiZ96byyCV6RQc9IqmPirb9bPPN2LVNJvp197Q0sq5MAmrj4alG3syvALF6Rmg+nEha4ANP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8425.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003)(3023799007)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0g4dXNMU0p2ZmhUVHJmbUdUNHZKVXgvZ3UrSzB5dTBaTHBlOE5Ha2lBOVJp?=
 =?utf-8?B?NW9vWTZlQXZVWVVlc3QrZVpLSjhXUXd2RTJDUDJBTTJwSk5pd2FCeVFjWnp2?=
 =?utf-8?B?eEEwTUhVVXRaU1N3dGFYclRWNGRHekVycVBqaFptRnBYcDZkUndGSENPMmlQ?=
 =?utf-8?B?dzdvaVpxdXU5UjhrVXE3V1B2bUh5Tnk4Z1padC9NNEFYNUJ1QTQ3V2U5L1pP?=
 =?utf-8?B?cCtDRmwzTW9ZUVQwOG1WYUNjVW5ORnFnQkFMTzYrVkxUYlZoZ1QxNTRYVkNO?=
 =?utf-8?B?ckJEeVZiUVRIa2NGazlDK3Mxd001cjMrbWh1Wko5dzhVWWxzRUlGTGFPdXFP?=
 =?utf-8?B?Q3U2b0o0b2RQRjJ4MkNtSTlHTDY5RGw1Vy9TMm5Sb1ExcXd0QmNFaWVDMEJn?=
 =?utf-8?B?bk9hamVQN0JhcE80ZzRPRWdaYU0zcEpxT09WS1YrOWg4dHgxTUUxS29PMUpX?=
 =?utf-8?B?bzk0end3QytDWkI2bTVVNzZYcjRBcUZOLzJGNE9aVlJwbUR5R3VMSy95cVdu?=
 =?utf-8?B?YVAyNlp6Q0FudURNcmMyekhpUmhTRkRWK3I4djBPejlQMU1aZFhQTC9DQ3BC?=
 =?utf-8?B?aGRVZWZQUUdlRHlmMGhaQUtEdS9OV0o2bXI1M1N4RVZNZDlKUG5Jd2tyVjR3?=
 =?utf-8?B?TWZiVTZsZHhSbHduemVmZjF1T3hmbkk3T0YzTGRYM2JjRnZXd0ZRUUtFRlRJ?=
 =?utf-8?B?NGdpNlpISmV2ZmM4eXN4dUJ3cVYyU3lyMXAwQWRPbnZ6VEI2WEljdVpxaS8x?=
 =?utf-8?B?NGJRUGprM3FzWWZuTndJeG1oR25jbTh3NlBjdlI2ME9xdTBqR2YzMEE2OXZn?=
 =?utf-8?B?NDFydWJ5aE5LMkx3bi9HQytRTEdhY2w3ejBIMVZudjRmdGc0aGswQ0w5Mk85?=
 =?utf-8?B?a01mYTREQnFDRnE5WTd5ZXd2aFdxTUc3cHNHcUZyMldLeVFyckFyU0wyaExa?=
 =?utf-8?B?b1BBWXFHUXo3YjdwQk40U0NMQ2UxRFN6ZU5ieXVmeWd1SUFSdzNqamZTWjJV?=
 =?utf-8?B?eVNkdllMQWU4TStwbWVKcWNJUVI5azYyMTZVeFkzMVovOGcwM0JSZGx1aFBm?=
 =?utf-8?B?bmVBeisvZ2piSGszTTJJaTd2d3NTQkxTbEU5ZFd5UjlLQXZuSzZGR1JxaVZs?=
 =?utf-8?B?ZDNLd1BOMCs4aTJCczRzZDVmYS95Y0xxaFRJcmJraXEvOEUyRkhEWTVHYU9x?=
 =?utf-8?B?QXFDQURuL29DQ0MyOFRFdkpoeG13Y0VRbTR2emVRQW1Fd05IZlMrSHl2M0Jh?=
 =?utf-8?B?K1ZWSllKZExtbEpWR1l4bGVGbmdaY1NGSnZLaS9mVEtLU0puVnVYS2lIZG9H?=
 =?utf-8?B?TXpicUdtYXdjbEkzYktsbnA2MmJudmluK2N4eEhxOEtjMlJlcW9JYWV1TTZs?=
 =?utf-8?B?M0xWQjVVSkErV2Z4amJDYzhFWnl3dE1oamlwTVdzem9GQnBOb2l4UUZFai9n?=
 =?utf-8?B?b3VmV0JoNEdhYlZXNXF0aFNRNjR1ekoxNHdJNS9xNkFaNGttcDhYYTFhWWpW?=
 =?utf-8?B?Y0tSV2hIcG1iWk51RUhLUjRwRlRvVGNqdTRjTjAyVXFtZ0plbC9hdmhCVkI0?=
 =?utf-8?B?SzNDYXQwa1N2NVZZTzBVdmhrQXdTZmRrUVRwMmJTMWt3QW14YVBydUxFeEJV?=
 =?utf-8?B?YTZGSWxkU3lzVlNhWklsOE1WMVB1c2wvcld3T1NGLzhoRXIvbWZERmtNeldw?=
 =?utf-8?B?QmFLY0JxKzZhd05DOEUwdEhIYU5xRVgzdSsrMzB3TDlmcnpodFNqTFhOY0FB?=
 =?utf-8?B?YzdrWTV2ckdVMTd6YnpWRlF4YnFjQWZ5SUprMzRYRG90WnF6SWQ0N0EzRG1J?=
 =?utf-8?B?ZndCd010ZWhHM1F3NWNOd1VuRDZLSWIzajcyVWxWblFhMlFDcVhtVEdNWHR2?=
 =?utf-8?B?N1ZjMW5GSGM5KzlJNU8waXVSSk1Pd3JtVCtwMEJGVFB2Zm1XUXB4S1NDNU1o?=
 =?utf-8?B?c2NRNVhBOHdDcUxocWFmb3FDKzlQbHdoeWFncTF5anZZdkR6dVNlZzE1T0ls?=
 =?utf-8?B?eFJCMUkwbHFuQmZIak9Lc0ZPQ0JvTEYyUzVHT1lzaStvWVMweXVHWG5QTFZB?=
 =?utf-8?B?THVkZWQvTWRUUVVScE5BbHBqK1dyUWNMVEVpb1h2cllqNGhObzNiM0o1T0ZP?=
 =?utf-8?B?SnVvejc1dVpoczZ3RndQQldTQituRS9lOXpJd0JYaTRNemJzL0ZmVGlRZHUw?=
 =?utf-8?B?NkxMZEE0eW5KdVJxNGxCaVZRZEVuU0FBM20rTXZnU3JlenJDMHY5VytHaC84?=
 =?utf-8?B?eFJrZWk2NjQ3QjRaQUY3aEROZlNtVlFiTWxid3ZKUElESkV2K3YyU2pPMjlo?=
 =?utf-8?B?RkhvZm5XMEFnSEI0RzlWY2ZwUEJuQ1dJOE10NHJMVVpDckVpVmxlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	l6qNy+uTewkxZCq1EyGTxtl47nUzAio0juID92/uyvq9pOH/sphM4hhz9dF6bCxhI76Zbokl7gNz0nEPYskHyR6rMNNboCguGcIRVVYSG3Q9zpK5V88suwK+3ozJag8qFqYvftEBDm+ojYtnIknlsJJlcHE7dWSVpthtAVtgsVEZumlQKrdqEKH+jGaWhpmbmZw+RZBQfY0FXaxUDmQ/lnfsC/gRQBIHxk1hvUSHn9NP/0UzZ70q9VqITZshNKurHvfjKXq9Wd+5WRI/QPFHnck5UWEYR8wzYzCbWFGmsBWldE3qiX5hNcBWmHPwQEBXUuXt9UTAl2rRYZtvGm2+Fw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8425.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc25ea6-0671-409e-c53c-08deba576a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 12:16:14.4377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfC31ZhjQK5g4CXP/U4oZXunm09ISxx5HGU0TnITwbT22u72PmpGv+szunPR9/nkREkSPVFRCF+7p7OWJVB2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5580
X-Proofpoint-GUID: tkBQ6He9IMCQZwrEU66SCzKZ1gKf5200
X-Authority-Analysis: v=2.4 cv=N5cZ0W9B c=1 sm=1 tr=0 ts=6a143db2 cx=c_pps
 a=oA0oAqHEqr9/hfEU5FnDzA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=HHmBNduvZyxiQTNvkq4A:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: tkBQ6He9IMCQZwrEU66SCzKZ1gKf5200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEyNiBTYWx0ZWRfXzEq3bli59wrg
 7V3235L2TadBS5ADvRaQ8ylehrdZYimF91A6Zlt/AwrRh2uwruys3fkmOc1sDSJbd8Ij0bk9fuw
 E80sWgT9XfCjVWnny2UUI2fUL2Dd7Mo1AI8R4FqZy9KBZO9T+WP/3y36eCa3iKm3usqrFBiBIsp
 DcxNpBow6KfT84hmn2cjlU9jJMbmi1sCqyHFz+0BY11h5POS3ulhO2Vadp/n9gfXT4TrwaYzCQN
 Sr3mrwdlTLDbP9xRmUz2ssT9L6+duPh0j8YKfg4iAdMqpLM24/15AKMWFWWDraDGWORnkFqp095
 kzRUt+uITA3yMXOAJ7r+H52IXVQyTTAfAKK8a8Ovi3hY/mi8D/sy665EIQNaP6gQ9B50pZCmT8W
 3ExJksbe9RyN5K6TmsBxPbKZlZuF4YtoM+w7+NaeQa6avEDjNkdfDlGVRvBb/j5IzYr5ipYCjky
 MIyCsxNf9nrE19hhcmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250126

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQGJheWxpYnJlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMjIsIDIw
MjYgNjoyMSBQTQ0KDQouLi4NCg0KPiA+IERhdmlkIHJhaXNlZCB0aGlzIG9uIHYyLg0KPiA+DQo+
ID4gVGhpcyBzb3VuZHMgc3VzcGljaW91c2x5IGxpa2Ugd2UgYXJlIGluIGltcGxlbWVudGF0aW9u
IGRlZmluZWQgdGVycml0b3J5Lg0KPiA+IElJUkMgaWYgYW4gaXJxIGlzIGRpc2FibGVkLCB3aGV0
aGVyIHRoZSBpbnRlcnJ1cHQgaXMgbGF0Y2hlZCBpcyBkb3duDQo+ID4gdG8gd2hldGhlciB0aGUg
aXJxIGNvbnRyb2xsZXIgaGFwcGVucyB0byBkbyBzby4gVGhlcmUgaXMgbm8gaGFyZCBydWxlIG9u
IHRoaXMNCj4gPiBvciB3YXkgdG8gZGV0ZWN0IHdoZXRoZXIgaXQgd2lsbCBvciBub3QuDQo+ID4N
Cj4gPg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvaW81M2x6bnozcXAzamQ1cm9ocXNq
aG9zbm1kemQ2ZDQ0c2Rid3U1amNmcg0KPiBzM3J6MmEyQG9ycXV3Z2ZscnR5Yy8NCj4gPiBXYXMg
SSB0aGluayB0aGUgbW9zdCByZWNlbnQgZGV0YWlsZWQgdGhyZWFkIG9uIHRoaXMuDQo+ID4NCj4g
PiBVd2UgLSB5b3Ugd2VyZSBkcml2aW5nIHRoYXQgZGlzY3Vzc2lvbiBjYW4geW91IHNhbml0eSBj
aGVjayB3aGF0IHdlIGhhdmUNCj4gPiBoZXJlIGlmIHlvdSBoYXZlIGEgbW9tZW50PyAgVGhhbmtz
IQ0KPiANCj4gV2l0aG91dCBoYXZpbmcgbG9va2VkIGF0IHRoZSBjb2RlIGJ1dCBza2ltbWVkIHRo
cm91Z2ggdGhlIG9sZCBkaXNjdXNzaW9uDQo+IGFnYWluLCB0aGUgcmVzdWx0IGJhY2sgdGhlbiB3
YXMgdGhhdCB5b3Ugd29uJ3QgZ2V0IHJlbGlhYmxlIGJlaGF2aW91cg0KPiB3aXRob3V0IHJkeS1n
cGlvLg0KPiANCj4gSSBkaWRuJ3QgdHJ5IHRvIHVuZGVyc3RhbmQgd2hhdCdzIGRpZmZlcmVudCBm
cm8gInJlZ2lzdGVybGVzcyBkZXZpY2VzIiwNCj4gYnV0IEkgZG91YnQgdGhpcyBpbXBsZW1lbnRz
IGEgcm9idXN0IHNvbHV0aW9uLg0KPiANCg0KSGkgZXZlcnlvbmUsDQoNClRoYW5rIHlvdSBzbyBt
dWNoIGZvciBsb29raW5nIGludG8gdGhpcy4gVGhlIGNvbmNlcm4gYWJvdXQgSVJRIGxhdGNoaW5n
IGlzIHZhbGlkLA0KYW5kIGFmdGVyIGxvb2tpbmcgbW9yZSBjYXJlZnVsbHkgYXQgdGhpcyBJIGNh
biBzZWUgdGhlIGNvbW1pdCBtZXNzYWdlIGV4cGxhbmF0aW9uDQppcyBzaW1wbHkgd3JvbmcuDQoN
CklSUV9ESVNBQkxFX1VOTEFaWSBJIHRoaW5rIGFjdHVhbGx5IGRvZXMgdGhlIG9wcG9zaXRlLi4u
IGl0IGNhdXNlcyBpbW1lZGlhdGUgaHcNCm1hc2tpbmcgd2hlbiBkaXNhYmxlX2lycV9ub3N5bmMo
KSBpcyBjYWxsZWQsIHByZWNpc2VseSB0byBwcmV2ZW50IHNwdXJpb3VzIGludGVycnVwdHMNCmZy
b20gTUlTTy4gU28gdGhlIGNsYWltIHRoYXQgaXQgImtlZXBzIHRoZSBoYXJkd2FyZSBJUlEgbGlu
ZSB1bm1hc2tlZCB3aGlsZQ0Kc29mdHdhcmUtZGlzYWJsZWQiIHdhcyBiYWNrd2FyZHMuIEhvd2V2
ZXIsIGFzIEpvbmF0aGFuIHNheXMgdGhpcyBpcyBpbXBsZW1lbnRhdGlvbg0KZGVmaW5lZCB0ZXJy
aXRvcnksIGJ1dCBwZXJoYXBzIHRoZSBjb21tZW50IGFuZCBjb21taXQgbWVzc2FnZSBjb3VsZCBz
dGlsbCBiZSBjb3JyZWN0ZWQuDQoNCkJ1dCwgSSB0aGluayByZXR1cm4gMCBjb3VsZCBzdGlsbCBi
ZSBzYWZlLCBkZXZpY2VzIHdpdGggcmR5LWdwaW9zIHVzZSB0aGF0LCB0aGUgb25lcyB3aXRob3V0
DQpidXQgd2l0aCByZWdpc3RlcnMgdXNlIHRoZSBzdGF0dXMgcmVnaXN0ZXIgYW5kIHRoZSBvdGhl
cnMgd2hpY2ggaGF2ZSBuZWl0aGVyIChpbiBvdXIgY2FzZQ0KYWQ3MTkxLCBhZDc3ODAgYW5kIG1h
eDExMjA1IGFzIGZhciBhcyBJIGNhbiB0ZWxsKSBjb3VsZCBzYWZlbHkgdXNlIHJldHVybiAwIGJy
YW5jaCBmcm9tDQpoZXJlIGFuZCB0aGlzIGlzIHdoeSBJIHRoaW5rIGl0cyBzYWZlOg0KDQotIGFk
NzE5MTogQ1MgaXMgdGhlIFBET1dOIHBpbiAtIGRlYXNzZXJ0aW5nIGl0IHBvd2VycyBkb3duIGFu
ZCByZXNldHMgdGhlIGRldmljZS4gQnkgdGhlDQp0aW1lIGNsZWFyX3BlbmRpbmdfZXZlbnQoKSBp
cyBjYWxsZWQgYXQgdGhlIHN0YXJ0IG9mIGEgbmV3IGNvbnZlcnNpb24sIHRoZSBkZXZpY2UgaGFz
IGJlZW4NCnJlc2V0IGFuZCB0aGVyZSBzaG91bGQgbm90IGJlIGFueSBzdGFsZSByZXN1bHQgdG8g
Y2xlYXIuDQotIGFkNzc4MCAod2l0aCBwb3dyZG93biBHUElPKTogc2FtZSAtIGRldmljZSBpcyBw
b3dlcmVkIGRvd24gYmV0d2VlbiBjb252ZXJzaW9ucy4NCi0gYWQ3NzgwICh3aXRob3V0IHBvd2Vy
ZG93biBHUElPKSBhbmQgbWF4MTEyMDU6IGJvdGggYXJlIGNvbnRpbnVvdXNseS1jb252ZXJ0aW5n
IEFEQ3MNCnRoYXQgY3ljbGUgfkRSRFkgYXQgdGhlaXIgb3V0cHV0IGRhdGEgcmF0ZSByZWdhcmRs
ZXNzIG9mIHdoZXRoZXIgdGhlIHByZXZpb3VzIHJlc3VsdCB3YXMgcmVhZC4NClRoZSBuZXh0IGNv
bnZlcnNpb24ncyBmYWxsaW5nIGVkZ2UgZmlyZXMgbmF0dXJhbGx5Lg0KDQpPbmUgbGltaXRhdGlv
biBzdGlsbCByZW1haW5zIChiZXNpZGUgdGhlIHJpc2sgb2YgbWlzc2luZyBhIHNhbXBsZSBmb3Ig
dGhlIGxhc3QgY2FzZSk6IGEgZnV0dXJlDQpyZWdpc3Rlcmxlc3MgZGV2aWNlIChoYXNfcmVnaXN0
ZXJzID0gZmFsc2UpIHRoYXQgaG9sZHMgflJEWSBhc3NlcnRlZCB1bnRpbCBkYXRhIGlzIHJlYWQg
d291bGQNCm5lZWQgZWl0aGVyIG51bV9yZXNldGNsa3Mgc2V0IG9yIGEgcmR5LWdwaW8uIFBlcmhh
cHMgYSBjb21tZW50IHdvdWxkIGJlIHVzZWZ1bCBoZXJlLg0KDQpXaXRoIEJlc3QgUmVnYXJkcywN
ClJhZHUNCg==
