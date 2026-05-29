Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29B30C35C;
	Fri, 29 May 2026 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043927; cv=fail; b=WGcDZBKttWD7ITw64wA4z1FUHIL8LWFQSWMPmAOhn+AAg6LH4FWjb62dpfmFDoDQRMKHNMjk88xCA49NJ3ZeE2HzLghdQ2ZnIiehNi5JTI7Pcm5GMrRdvq6DRzqNGfSQgPmWgbnSn+Vd9SCr/9kJv+5C8cyEjHLT91Vn0cEXXcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043927; c=relaxed/simple;
	bh=X6HN2Ha0OFbMvOFekgR7X4ZtIZf1aHyuR8kwnV5nr+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxrf4nKcS0LCHgmAFXM78lf6w2QPLEEB2dyciQg7Pqsttrfwj0+YtgHLEwz7GmvXoTUfbdFr9HTQvSUQz4tHWysSYNCqNrBuQAPhEenUclnQ+tQ0pkr9mURYjFhNMOY9TlhOvpdk0isZOhAePly/Y6SRUhePf8t3X9dudgqfFlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oH4IL1Hx; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oH4IL1Hx"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T52eK2651297;
	Fri, 29 May 2026 04:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=X6HN2
	Ha0OFbMvOFekgR7X4ZtIZf1aHyuR8kwnV5nr+4=; b=oH4IL1Hxu50zt5YBGrTsJ
	PndU4KQeGEM6ptZrA9j8ZU50K9pxl3IHbNxtTqQv+zhjCpBbos8ePCKo+CQ1ENw0
	nIRgMa+8vhpWIcXmamrj/S3duKeBPnCnqtl5ikgMv+FHC43VbRKA7SRyTbcgu+43
	VVXRzAhG81HqKHmh8tEnVcpz2ZGcj5G88jCK0ZN0CqMtXypQUQeVfzTRaDljVPFQ
	NplhhzeDRNs9FtFwb1DNsa4ETryoYtFlioclyrCZmhPUG1Kh6zj0qFKbfOLaIegQ
	5hWQgjWiYBn9Nvk5Jtg2QegS1BzSee0uy2gLD+zJNDkc6Vsd+7+pXIh7l1BYhguf
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x46jar-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 04:38:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJn+Pq0+0viAWNRagixbSXVguAvXXbvuaz03bNeDdtm7AJzL7GYaqOsDSrHnCCGzO5NTl4ICPjjEva/EwgpzaXSHVT+nPcr+He+BhHg3rGy/gqH2dHRFLRVfe3UyAHc/qMQ60pIo9ureJKrD1l54muqM4z+HxRVq2TspWWUTh+1pDeN3totWOtcTo6dduhMMjX/q34MkNAv/rPr/xXs/+MTWjqyR4/+mI+lr2rqeRRJMTYOUFP7xYH+wJlE8yAo1pziOQueKIaShrT42LETXwpLO9a6KPNDE91jyaYvHVf5FXzZo2xq9wnB9bA1Lz3T2813SqokuHwEOiVJ6AHAFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6HN2Ha0OFbMvOFekgR7X4ZtIZf1aHyuR8kwnV5nr+4=;
 b=XS9gBIdzmSzYzea4pREzvSVFKvCv9M9u9GHu2rY5IFXZfqtmOYDoM+HQR/vJfxar2TKUGipiEi5Jr/vAqi9uNPTlgpAT7jkUbhQs0rwuicEQpn1mrhkg2GS/tm1Xp9UiMe8NrOMToYV9pnn/upSjKBnDvitCzlPbwIkpj2X8N5KNo1OTloZUcOsWbEgEjZryuC9NRiVKmxKVcK16K4DzAUJEU6TPNVtUU0jFwYwBhWN9gObtTCNN4tzojuxON4U4GewpWREpqdirAEfpRmAYuttBS5j2cnvN8Qlr5WvFFlZKqc6aL345IKdcZjXPkOtaHOlVy/TR7n9JjUvB0UaTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ0PR03MB6875.namprd03.prod.outlook.com (2603:10b6:a03:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 08:38:28 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 08:38:27 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] iio: adc: ad_sigma_delta: fix CS held asserted and
 state leaks
Thread-Topic: [PATCH v5 1/2] iio: adc: ad_sigma_delta: fix CS held asserted
 and state leaks
Thread-Index: AQHc7byeUSfmqcN+/k2gXXTpiKsQgrYksK0g
Date: Fri, 29 May 2026 08:38:27 +0000
Message-ID:
 <LV9PR03MB8414E5779152FAA0FE2E911AF7162@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260527-ad_sigma_delta-fix-v5-0-446fd2bc7330@analog.com>
 <20260527-ad_sigma_delta-fix-v5-1-446fd2bc7330@analog.com>
In-Reply-To: <20260527-ad_sigma_delta-fix-v5-1-446fd2bc7330@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ0PR03MB6875:EE_
x-ms-office365-filtering-correlation-id: 0c97d743-5d68-40ba-04a0-08debd5da7b4
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|921020|38070700021|22082099003|6133799003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 7jW/2ABAWZpbQaG+oGl2xcoHeJ0k120ZAl/MuyeMMr4EvemRQZ3RJXIkmgDE+TyiE1GWY3evv1oCj2AvPGBDrpn/BP3TTs+SR0378JOM76k0iy2efbKIPijBNSGfOI+iNj1O7An8milSOyNGFHb7hcs9Q1PvZJ5UaaXv3ghFK9li383KoyCmd/jELerLQUR9SdNd6fThIQAXaYsGssFS+302CaRG2iYMtvJEnjlR94VM9C+6qK0MhCv44ESitQ3oo+XYKvBCzN/oLQIjc43llIKoYO351h1DAllN1hOGLWe3VkbZaXtTI5oJ1qo8AS/lgkmalwV9cohTFsvrhz7AdmNz4b93iAGRj6PBiHw6HZxYfOlMjToepXmfqnQgHKCpjQLa5LETXFSgXGG3e2jWMEIsBN8Yn20EosqdQXjhq4aQjPZLpkrPhbAwg+kYUxeS+qZj+8phquywi/scMXRP5Ou9TIUpibdxzYlMnBrcBWHtUqQYiTa+hFQllXegj8SbnUtRFsqPnHxxqj/R4DC0ICY7wEhuqeWPmG6FfXhr80XZqmE23tJpS4GQM6+P2GyfhGOA4V7vPM5thoPa0/3vU2LVI1JaMlwwrDxSsJnYQIH/Kjw+P2nnjDE2goyD0Fvu+kkO3t4Ni/cojacJ8DwF6gvKL+zuQMjpr+OAYViMBUhgxBvap6JHG0EfRYa4pPOeQCGIFPjspFG77OwIanisu0fxnS6RGHkrNYvlFNt5ipM27vjns7G/D5F+Tbs6rpsq5CJidjg3h5NPL4gucr19KA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(921020)(38070700021)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVNNL0hGZEwwWnRNSElCWFQwVHZEanM4OE9yNVpubzE5elRYWFNxU2tZYWhQ?=
 =?utf-8?B?NDZFYk13TmhEUXVjeXg5Rlg4Y2FBbWUxZzVYYjZ0b2kzMGlQbitWMHFYSW9Z?=
 =?utf-8?B?T3VQODk1dExuZnpodG84cmdpN3NHdis0OHBaUzgwU2tHOFRWMUhiWnVZS3J1?=
 =?utf-8?B?b21sd3dPUTRUNlFsd3RBN2wxMHc1UlBwb1J6ZEFmZEF2SHJWczZLdXR5S0dY?=
 =?utf-8?B?cUpvQUxmdithWldaTk9vWXhYME4rVG5Va2NndHY5blM5WmpVQ2FKZkJ3U0pP?=
 =?utf-8?B?TXA4S2lsT09lN0x4UktjVG1TcUxmcytYaytiNlhmT0M2MEloTEMwVVdlNjNB?=
 =?utf-8?B?SDRVS2YvNDBRbkcxZ2J4V05EaTlZUitldXoxOWwyeVExTEdieFhoTTlpWmVE?=
 =?utf-8?B?djNvQUVLL2tucnhJdmNXR1ZOeVZmOWd1RG9NL2hiUG5RREdNeURCamR5a1I2?=
 =?utf-8?B?QUhjMk9ZaFQ1OHd0YVpSOGJ5MGhpMTZnRkttUE9jVDAzRWJ4MVBhQmZOb1Ir?=
 =?utf-8?B?RzlzUGU3bDhuQWxCelVDbjZNZDg5RVZRNHZGY0tHR2pzdmRVUDJwSlFjVG1S?=
 =?utf-8?B?SVFlS0JGQVEyRy9ubHh6d25LLzZlOUJBV0h6alNoS1VWdytyMjhrRlJvRUxW?=
 =?utf-8?B?clRmdVlZaWpCSWFraW16eTVmVzRUVVRqNGN2Y2FaOU42ZkJWT090MGJzSzNL?=
 =?utf-8?B?UDFETmV0ZnJPMzVjSWE4aXROZnlMcHhQSTczUEU0SUlIU2Jsa3JZTU9Gd2p0?=
 =?utf-8?B?YVhVV09xaWdxQkIzY3RaUTlVbjk3WkdIT0RvZzhDREM0MVEwYVp5enhYUFRP?=
 =?utf-8?B?Tk5aWHlBenBZRm9ZSG82TDJTZ2hPaGkvdytBR2tvNytuQ2w5SFRoREdHTGlk?=
 =?utf-8?B?S0JYK1dEdmVzeXJONG5CZkwrRUVGV3hpTTVhZUU4U1dDK3BmYjg4V0I4cEZw?=
 =?utf-8?B?NTVveHNXSlJvR1ZsQzJWYm50akViNGdPdk05SE9UTkg2WnE4UkRFTTlyQkJP?=
 =?utf-8?B?bFF1aUMzZEgweDBUd1A4VXJPNVM5b1lKSlIzK0VWNTUxV0lDbFVUQXU3WmtU?=
 =?utf-8?B?MHN6WWVDWlZHUE9vS0dXdVo3dEFCdVh1emZ3bW5mQUo4dS9qcUxNdTZPam1t?=
 =?utf-8?B?Q3FWOFJwTEorTFZBbWpIeTNOOVE4eE5PSjFQQ2JlSWlIcHlkeU1MbklUaHp0?=
 =?utf-8?B?UHFVZHhFU3VrODRYbFQrZnR4NGVFaXh2cmZ6ZEdWaVBGWWl3azcyVjJJTjZ1?=
 =?utf-8?B?TnNmdjVQdkN6ZnVxb3FEeGFvbTVUeXZLVVNMSFVUcW42L3IzNjlLa2UwY3hn?=
 =?utf-8?B?RXVxVkhEZDVmYVIwbXpGU040RWxiRmRuNDhaNlhIUm9YcjZwVFZWWG4wSXZK?=
 =?utf-8?B?VUZuNDliZlVsQ0hUZXlhSys2dU5qcjF1djVLcWYzN0xrNnVGaVVLTzd0dEIz?=
 =?utf-8?B?NW1xQU5PYzlXd1Q2ZmFXcG45aEMwYmV1Y2V4TWxyRDVqOURjMkdrVlc0VTJ5?=
 =?utf-8?B?MUt5TnQ5aGJSYjVOK0MzZmFjMFY0MWFmcVJlUkxNcVZXU0xjbVVYc1pOVXhU?=
 =?utf-8?B?ZGs0N2l5RHdKK2lKczBIVTNtSmlBc2V6RGZRNlU3Q3o3YnhLeVY0TlhuZXlP?=
 =?utf-8?B?WjdIM2JuSEJzU0tueitvTkFDQVFEanZZQjB3cStoUVg2dHJVWUpFYkNtSnRJ?=
 =?utf-8?B?VVRHdUJna0pMSHFWdkRuSlRhcnhRenZ4MjdlajlITEl2ejg2OUpQTkpka2Ex?=
 =?utf-8?B?OVlBSnZqZ0NmT2ExVHNhUHJNMUEvREh6cGhGSFp6OXRuK1h3RW8rb0taSDBG?=
 =?utf-8?B?YzFvTFdCOGthZStuR0J2Umk2cG5KQ2VtVGlydm1TQm5INzhZdjB5L3k0NlFW?=
 =?utf-8?B?TmhRQ0NONS9zU09IZ2QvVTdiNnArWmp5aERiRzBKTkljS1BBbWs1dHNEN2hu?=
 =?utf-8?B?Vmt3TVdicjk5dUlqTnpicHRWSjdTSHRUTUF1YnJHRURpd1dqa3RVOFF3ZjFF?=
 =?utf-8?B?c0o3WVRnQlV2VEF4QlFqa3FjS3ppTlkzbGRsRGJxZjhwMWZpV1BQcmZONVZY?=
 =?utf-8?B?eHRVZmVKWE1ycEsvRzBUZnozRUJ2dE5IT052elBSWndtZWlEVmZEQUdLTkNU?=
 =?utf-8?B?TFVUbWovRldTaFk0QWIwdG9CWFkrWWo3RDdBTldXNkRpL3dTOExNeEVEUWhQ?=
 =?utf-8?B?UUhYNTRiek5ta3VRN0pPMjluVEtzbGpSYmpQT1NWUHFEV2w3Wno2a00reU1a?=
 =?utf-8?B?NGFuNnV1WW5USWxtYzh4UnJRU1JvTDJ5dHQxQTczbjJlQUt6c3ZoL2VQSGNp?=
 =?utf-8?Q?f6zJQhm7VO2R5lgctX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pFBaQrk7b7U/tivHf078O3rZDY3JH2I+b2Y3XC1fiaYeYi1YuyZ9bE++oFacANU2093lLMLYQkXzzKygV8FPRYGrRvOJWqzyyat/W7QDAuT/PPGQ8QYqAgLq+s0DRBgp2r50n6blTJgwA5uOfyGNnH0Aottw06+orvbjRG9IdBujn7EbZ8iGc9dLQ13rgPyHJ4BG5rOKjMGdkUxHDKu9UqQO3PWVJf3q0yVYElWGQNdjnStq7YYFgXfnV1WdQYKrr1L1UXvZ3KhDNhizC0dBCd9upKqlqWO+j/HXafiS/5uD3UstMv6zFjP3ZeHdn4vVqngcJrQYf1bHe2EUQOI1Cw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c97d743-5d68-40ba-04a0-08debd5da7b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 08:38:27.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eJEwmi0abDtsZL5z4l+8U5cxQphE0UNC9gaxIYJkAMgrfv5dqiXJvp29UKsPfnDwenLI4XOR4xurn3aj+plEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6875
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a195088 cx=c_pps
 a=6F35cL4xT6GZaKJ9H0o0MQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=av_-ow1lR_VGE7P5mJIA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA4MiBTYWx0ZWRfX3rM+ppmA7qid
 +B077q5h5MFVcBHtGeH9+gBPNgKgov4XnDBviMnRwOGjbZ7F7xitcMd1OciQNPfxBZKs0eH4DVa
 fpQQKNov8MKJVIlQHhCWMji2Cuw0COXtuUONnYLxzjnpHVpfLCDnwwDXoUBESHOrBrC8OxkYC38
 0eHislCDX+JvmR9bZltdSsuyirTLG3MEguRm0V4F34Ti8WOXmSWHY4r8a+p8ZzAAXIa2IGoiJCr
 4ks9E3W494KmE9k+KmOPAscdFao1LdgUHzYSwE9DCnbZz9cHm13RyZFJSAPZqzH1F54fxWIQGJX
 OKQOOmrtIseLoRXqpawN5MzRH/ILU1ljL6i/YmMieYsv6PrfSf8K53JMbpqtD1yQkJw1UdHQkaL
 Dq7L3t8jMxNRDIhDtcgd6vBe5dNo/0OTAB53Kt3B8Dw1Qb10I2MeM6+3o7D5Vs/6CwKEMHSPcSh
 1/yZJ3shLDaX05XaQrw==
X-Proofpoint-ORIG-GUID: ovGLEP3wqgy84Kpmp7SOzYMtSj6RuQN6
X-Proofpoint-GUID: ovGLEP3wqgy84Kpmp7SOzYMtSj6RuQN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290082

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
V2VkbmVzZGF5LCBNYXkgMjcsIDIwMjYgMTI6MzkgUE0NCj4gVG86IExhcnMtUGV0ZXIgQ2xhdXNl
biA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5l
cmljaEBhbmFsb2cuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47DQo+
IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IFNhLCBOdW5vIDxOdW5vLlNh
QGFuYWxvZy5jb20+Ow0KPiBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IFV3ZSBL
bGVpbmUgS8O2bmlnIDx1LmtsZWluZS0NCj4ga29lbmlnQGJheWxpYnJlLmNvbT4NCj4gQ2M6IGxp
bnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNh
YmF1LCBSYWR1DQo+IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogW1BBVENIIHY1IDEvMl0gaWlvOiBh
ZGM6IGFkX3NpZ21hX2RlbHRhOiBmaXggQ1MgaGVsZCBhc3NlcnRlZCBhbmQNCj4gc3RhdGUgbGVh
a3MNCj4gDQo+IEZyb206IFJhZHUgU2FiYXUgPHJhZHUuc2FiYXVAYW5hbG9nLmNvbT4NCj4gDQo+
IEluIGFkX3NpZ21hX2RlbHRhX3NpbmdsZV9jb252ZXJzaW9uKCksIHNldF9tb2RlKEFEX1NEX01P
REVfSURMRSkgYW5kDQo+IGRpc2FibGVfb25lKCkgd2VyZSBjYWxsZWQgZnJvbSB0aGUgb3V0OiBi
bG9jayB3aGlsZSBrZWVwX2NzX2Fzc2VydGVkDQo+IHdhcyBzdGlsbCB0cnVlLiBUaGlzIGNhdXNl
ZCBhbnkgU1BJIHRyYW5zZmVyIGlzc3VlZCBieSB0aG9zZSBjYWxsYmFja3MNCj4gdG8gY2Fycnkg
Y3NfY2hhbmdlPTEsIGxlYXZpbmcgQ1MgcGVybWFuZW50bHkgYXNzZXJ0ZWQgYWZ0ZXIgdGhlDQo+
IGNvbnZlcnNpb24uIEZpeCBieSBtb3ZpbmcgYm90aCBjYWxscyBpbnRvIHRoZSBvdXRfdW5sb2Nr
OiBibG9jaywgYWZ0ZXINCj4ga2VlcF9jc19hc3NlcnRlZCBpcyBjbGVhcmVkLCBtYXRjaGluZyB0
aGUgcGF0dGVybiBhbHJlYWR5IHVzZWQgaW4NCj4gYWRfc2RfY2FsaWJyYXRlKCkuDQo+IA0KPiBJ
biB0aGUgZXJyb3IgcGF0aCBvZiBhZF9zZF9idWZmZXJfcG9zdGVuYWJsZSgpLCBpZiBhbiBvcGVy
YXRpb24gZmFpbHMNCj4gYWZ0ZXIgc2V0X21vZGUoQURfU0RfTU9ERV9DT05USU5VT1VTKSBoYXMg
YWxyZWFkeSBzdWNjZWVkZWQgKGUuZy4NCj4gc3BpX29mZmxvYWRfdHJpZ2dlcl9lbmFibGUoKSks
IHRoZSBkZXZpY2UgaXMgbGVmdCBpbiBjb250aW51b3VzDQo+IGNvbnZlcnNpb24gbW9kZSB3aXRo
IENTIHBoeXNpY2FsbHkgYXNzZXJ0ZWQuIEFkZGl0aW9uYWxseSwNCj4gYnVzX2xvY2tlZCByZW1h
aW5pbmcgdHJ1ZSBhZnRlciBzcGlfYnVzX3VubG9jaygpIGNhdXNlcyBzdWJzZXF1ZW50DQo+IFNQ
SSBvcGVyYXRpb25zIHRvIGNhbGwgc3BpX3N5bmNfbG9ja2VkKCkgd2l0aG91dCB0aGUgYnVzIGxv
Y2sgYWN0dWFsbHkNCj4gaGVsZCwgYWxsb3dpbmcgY29uY3VycmVudCBTUEkgYWNjZXNzLg0KPiAN
Cj4gRml4IHRoZSBlcnJvciBwYXRoIGJ5IGNsZWFyaW5nIGtlZXBfY3NfYXNzZXJ0ZWQgZmlyc3Qs
IHRoZW4gY2FsbGluZw0KPiBzZXRfbW9kZShBRF9TRF9NT0RFX0lETEUpIHRvIHJldmVydCB0aGUg
ZGV2aWNlIG1vZGUgYW5kIGRlYXNzZXJ0IENTLA0KPiB0aGVuIGNsZWFyaW5nIGJ1c19sb2NrZWQg
YmVmb3JlIHJlbGVhc2luZyB0aGUgYnVzLg0KPiANCj4gRm9yIGRldmljZXMgdGhhdCBpbXBsZW1l
bnQgbmVpdGhlciBzZXRfbW9kZSBub3IgZGlzYWJsZV9vbmUgKHN1Y2ggYXMNCj4gTUFYMTEyMDUs
IHdoaWNoIGhhcyBubyBwaHlzaWNhbCBDUyBwaW4pLCBubyBTUEkgdHJhbnNmZXIgaXMgaXNzdWVk
DQo+IGR1cmluZyBjbGVhbnVwIGFuZCB0aGUgY3NfY2hhbmdlIGZsYWcgaGFzIG5vIGVmZmVjdCBv
biBhbnkgcGh5c2ljYWwNCj4gbGluZS4NCj4gDQoNCkZpeGVzIHRhZyBuZWVkZWQNCg0KRml4ZXM6
IDEzMmQ0NGRjNjk2NiAoImlpbzogYWRjOiBhZF9zaWdtYV9kZWx0YTogQ2hlY2sgZm9yIHByZXZp
b3VzIHJlYWR5IHNpZ25hbHMiKQ0KDQpUaGF0IGNvbW1pdCBtb3ZlZCBrZWVwX2NzX2Fzc2VydGVk
ID0gZmFsc2UgdG8gdGhlIG5ldyBvdXRfdW5sb2NrOiBsYWJlbCB0aGF0IHJ1bnMNCmFmdGVyIHNl
dF9tb2RlKElETEUpIGFuZCBkaXNhYmxlX29uZSgpLiBJdCBhbHNvIGludHJvZHVjZWQgdGhlIGVy
cl91bmxvY2s6IHBhdGggaW4NCmFkX3NkX2J1ZmZlcl9wb3N0ZW5hYmxlKCkgd2l0aG91dCBjbGVh
bnVwIG9mIHRob3NlIGZsYWdzLg0KDQo+IFNpZ25lZC1vZmYtYnk6IFJhZHUgU2FiYXUgPHJhZHUu
c2FiYXVAYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVs
dGEuYyB8IDggKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkX3NpZ21h
X2RlbHRhLmMNCj4gYi9kcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYyANCg0K
