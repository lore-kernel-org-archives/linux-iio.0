Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7F3EFD2A;
	Thu,  7 May 2026 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156281; cv=fail; b=q/6U9pu1GyRmQOgW4wUj9+C7OZIVhOhJOsrKEpYy9jfRNkxujTS9URTt50ecZn6VV5d+BmC6uazLKJLIeiFXHjAOk1OI3VDJWzNq5e9VUlfuVbgxniG6ZhlaEmRcC1qCjHeQdud8ssWccsxADCjWl4XWOn1VVs0LAT4PVX3jB7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156281; c=relaxed/simple;
	bh=SwuJwlytDY4/3PZARTHMI8m7zHyptlI+8Dbx8EPTNFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdhdX3r9fLL3Dc1ZoVWSL1aVqXYxYxQJKrErTYX7SlqHJvsq+nvNoQHpd4vmO/PmQrLBiYUqGPAskIQdlBvL+tO4DVcWiGXxbIv+WKGfM52OsKnCUcoFnVkeMtXb/R0a/OjErTfWgjwL+KMuMPXzKvTLFyaTj81YVRqWboI120U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NY7xugiF; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NY7xugiF"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647AfmS5400862;
	Thu, 7 May 2026 08:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SwuJw
	lytDY4/3PZARTHMI8m7zHyptlI+8Dbx8EPTNFU=; b=NY7xugiFS5SFVIQFZVo9Q
	bKEeq2Gk6cj4YAl3wYcyslhYiVO1xAFq2iqC6NYW/9xujtUAVNxWobTrZmPCo7A1
	QN1Yz+Zl32QJoitEjSKhx18gk9BSyvM1Vy0FYhuBiyMHdkmSHszDCS4AGoFjlWCT
	Yk12CWpam9W6FfgdOUVpX1IOijfq2aLZWiTwLPuCZashV3cY12gEonQje0vDwDIw
	z/As03UU7O0J5tUE8JGw3HMAr4ALtJ/TNvSuGgX+E8x+O2BXt8HD0MLgr9JplrgA
	7E32B1AZ2Fw52sHCbnGEl3DDlfi2TwbyK1gm/jw6K19TnT24LxZ8AViLfrb25iBW
	w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dyu7a7686-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 08:17:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nicEID8uIzTGdM5+QHDGCtZD9fmasKGSZ5dn3jlxsj62WaM6k26xNDVF0wM/EhtYJel09SrN7BQ2H0ZPkwfuZNyrlQ4aoMuB/4SJyisvpQBwlxjTjBKxza7PvEZ2Tjvoyqj+gTeqcdIhA2k3SNyT4hOI+WvTVJAGffO9FvKFD2BMZodzIYfLlcfeIbJGuxDIVKNGEDMqiM950jJDnPhEVK7fMJOEkjyJF9KEuZan9jQ1uga1G/nVUaK4qbyOxozPaS1cv//D+xFDcs/h3ZVmlcY9xmyd4DS6sjMbftzte0RmZy201oQDYND43Xgql24Gk/Az8fhFAjA5uBoUGWMIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwuJwlytDY4/3PZARTHMI8m7zHyptlI+8Dbx8EPTNFU=;
 b=TMUsYZ9WNf+yBWSZrdnV+2g0L9S12sPxKAnAA5wFdBr7uf2YN2BZ+VlLhNU5QoTC/g6hTc+DA48aQMpvH9r037tSKu1Gx7ZjI/cj3sc7vb+yQEE2mgjmqh2eDuGSK4Va1ltH8gELflTT1M8f0SZOMh9aGOGY/sUvGZVhFT1nsY0H0TiRwC3+spvJu8gUmly3XoJfW1o16vcJ0JLX3u7UiHu/xZQbtjZl8aA52SXDS+gYfiCeENOtU/BFUkKtTb5QUCR8QtBuSXLMJ1ISeNLkOZDAsX6Lr6Sr4pImE8aH5yCTH1e3TtKLNUeLJjbyvhgsaKAzq5NRFsImBux7hrLTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH2PR03MB8085.namprd03.prod.outlook.com (2603:10b6:610:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:17:26 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 12:17:26 +0000
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
Subject: RE: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Topic: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Index: AQHc1xVfa1WYdTQUw0CFFOByxUryxLYCiHmA
Date: Thu, 7 May 2026 12:17:25 +0000
Message-ID:
 <LV9PR03MB84144C0FF2FC2197AAFED941F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com>
In-Reply-To: <20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH2PR03MB8085:EE_
x-ms-office365-filtering-correlation-id: b7b2db96-c401-4244-4e67-08deac32999b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 rp4b5PLQqvfSo3oRX+fP3mZLbMNmYGsDhpFytb8C7klyeQFw22Wj6y66DLz8ArAKVVDgBPEOAmPHfnq4gtNcEFH54PSNNLBMCkmIcHCttMLa6Ubv9M0rnLa0mHdDSKx8rSTSZhchPTN1l5i+kMHVYlt2egMLS3NP/3VNDQ2vwYCLAcBpTAtpVclV42GDAOUFpCttTfz8jJzqCgoVYFdWWVNnlV33H6USJekeU9q/+YG6qrcmSyv1sX6JMGpw9nnAu0alIpHTAC+NM/1LA2e4kX92BvYOu3/br9NpGxXXj5iQHxwO6pRt5fYtwipIMRiesBsibXMaespK6xv6LaqgrNFI2YqUJJLjGpBP+pdB8U81WB6Hf4v/VwKS09uc3rNNQY+hOhV2kiJ9YE62g6YOIyZl/lqTKF01OJH0AiZCwvv4ybCnzIbgz0a9+HRe8cAuROhP8OrM1yY7q0wj8CC8wTeCS1oJANHnVpAZ8dr05a5dbEzd9nZcUZ1dbdXSMv0y/8w+08ysYuXjKyO98MQQ2XqAov7OVpmUzmqGB9Uvdn8dnP5X2TPgxGdh20j0MGlXTusJEqR6T1Ue5VM0t+i+WnzJVESJ8WWtHV03Yy9cUY1D4ykKNZgZMfo5xwZOD6jU1wOMWqZPNsoJ9iaitG3Iy+dInQniOHtX4PgWtgnnPVSrdCuj40xV4atF8CyyyD4PZc1UDqRcvQAdOHI7CkM8YVKXkxLn3Z1NKTLYjAlR+d+4DLV39QQJZ5zjvbJrghQDpYXbBGy+8+BDToF+QZepmA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVlZd3UzY1kxc2hScGExcXB6NnIwMGhsQnNtZXA0L1hlOTZQMWVvenB6Vlh5?=
 =?utf-8?B?b3d4NzhCd2Q5WElsWDNTanFjTUl4ajE2M3UxSEgzaUFUcEp2eGVXT1l5bmdL?=
 =?utf-8?B?bnpDT0FTVEQvcDl6VlJLZ0svYTdZSEprWWRCaVRMN01NcC9yOG5nT0htT2F4?=
 =?utf-8?B?NkRKM3FOSkFPV1ZsclFURTNIM21ZSnVKcVdXVHMxU2M3eUNCVFZIR3BCeHBT?=
 =?utf-8?B?d3MvRUFHSkFqSzUrTmdRek1YOS9ZV0VIdUJQQlNFZGVKSGZKUmNxbTRxWnE5?=
 =?utf-8?B?Zmw3UitqYk5ENlZGU3ZtS1A2VmZpQ20vNTRVbWJHRVAwbStxOW9WZ1NKeTcz?=
 =?utf-8?B?Q2FaKysxdGNpOEwyNWFNTlIzNjJpVm1mazd3ckVJUmM0bmFzbDJyNHFrT2ZN?=
 =?utf-8?B?MERoeU15dUlHSnBXQXNtSVF5ZUljdjRLaVFqMThVWXoyRmNoeERyMldFcHlM?=
 =?utf-8?B?NnJKMDVZUXBrSTY5aVlYR1FEdTFCWENFU0Ewai9iMGdqa2FBci9CWis1RDhs?=
 =?utf-8?B?R3QyVzl6OU5lblU0UldISktLUGQ5K3V6akpQOEFYRmg4YWoyMFRvY1J2TUtY?=
 =?utf-8?B?YVdMZGE1ZkhSQlRCNGtWM1IxajdCSS9wbHQ2dnd1eVFOdDE0bFMzK1lGQ3pq?=
 =?utf-8?B?clRuYUJ0OGFEamhkaGlyWEZXNDhFK2xMU0ZtVkdnOE0zN3pXbkpsUWJlcng1?=
 =?utf-8?B?ZDl0TGovYWhHZ0s3dm5iTG5GdlMxelQrRGNIcUNuSndNMHM1TGpvbmxNZmJU?=
 =?utf-8?B?MXZYeUhoT3RpWlFBajc3K2Mva3RtVmVQUFAwM1NKZ2ROSUwzd29QTXduNjFW?=
 =?utf-8?B?eUFMdE1EVEs4Q05VWjZ4cWg2Tm9aQU1NdzIrV2MxOEpqcDArclFSV2lZYmJF?=
 =?utf-8?B?NnhMSVBjVUlnK0dyTmNBZWp1aXU4cHhPT3ZzTGtPdGRyZmpGeWtQbWJQM1Nz?=
 =?utf-8?B?czNINm8xZURmVmNnNEVXcUtZMHluYkZtY2F3UkZmZEN2T2FrbXhYZ0FTZjdU?=
 =?utf-8?B?WWU5VDRPeURyWUpwQmoyZlg5b0Y2eUpKeTJrd3BralE0S0xybWMreDBqay9J?=
 =?utf-8?B?S3ZzVmZhWFJFTWxnMWVxaHBsT1NCUUlaN3phS3JaQkEyTzl5aXM3NWlYYWpW?=
 =?utf-8?B?ZzNxb2VnTno4L1M5V3ZORGtqZFBNa1oyYTNzMjV3UDBqajNETWNlc2w5aCt6?=
 =?utf-8?B?SW85ZXFtTEZxS3Q0N0ZRdTcwdkR5SEIwVldGL1NLaDhOOHhaUXhCenN6WlhL?=
 =?utf-8?B?Y3FsRjZXdmVIcEFtSVNkbzJPcHcyVDR5VjVqUWVuWnJpZ3NwdmFhem5UczVj?=
 =?utf-8?B?c3RlN0dCVEdvOTFaL0t4WGJvV05ZZGx3dWRVaXBmanZTZC80Y1N1ZGhxTlQz?=
 =?utf-8?B?bVErdXdiTUNMME9jQ2lPWWhxeWZaZzcvblI4anFlU1ZqaHY0ZmdzVGJSVHRx?=
 =?utf-8?B?U3JZRGFLOUw4QWk3R0c2VEJ0TXpUT2ZyRStFSEsxUndNdU83akdoSm5TV2Z1?=
 =?utf-8?B?NzZvWVdCbE1pOS9TS3ZvQTlpV01aL2d3NDdidlRHN256cnBIa2RNb3BmU1o5?=
 =?utf-8?B?KzBCZ2szN0Y0V29DM0h5M291NkJscEkwd3FudE9YSngzV2dyRk91SDA4UUFl?=
 =?utf-8?B?eThubWY3OTNCZ0x6NW50SGVnM3RtVHkzMlZOKzBWaG40cGVnekJRZE5QUlVm?=
 =?utf-8?B?RFNLcWhMdElOeEhYN0VrTitsY25XaHVpMjBXY1NuUlkrd3pZaEpOV3kzdDAw?=
 =?utf-8?B?elYyTkd2T3Z3REVCZHkyZk9vOG1iaXdJbU9CdkQyRVk3aGxyTG9tTUsrSzAr?=
 =?utf-8?B?cU9CMnR4S2ppbXpsQlFISXFNWDl3WTNxSkk4Um0rL1duZzJKcG54TWp4WnE5?=
 =?utf-8?B?NzdzKys4V09icTlUOVRkOW4wOGRtcXVnZDA4QUhZUXR1Sk1qb1VMTnlFNGlJ?=
 =?utf-8?B?OGZsamZ4b0ZNMVZxd0gwZ25YN3l3YjZaZjZFNzJIdVFmWWQveHUrWVFMWDE2?=
 =?utf-8?B?WFI4VnBDTDhCcVhzMUNLdmxEdHBZYXJvV3dTRFJPYnhRREp1TUt2WXpaRGF4?=
 =?utf-8?B?ZjJZbVU3eGdZc3VCbjk0bmd3MW9YL3ltbWQ4UzRRU3EwUUhJRFl4MXFmTHVw?=
 =?utf-8?B?eXR3TUtSK0JudDlHekpHb3ZtYWFUUUltbjliYjF6VCs2YnJpV1BiQmF5OTVJ?=
 =?utf-8?B?cUcwcFNKdnZpa2F6eWhsRDI0a3NScmJFM3R0dUhnNmxnMm9ZQlBaMnZnN1Qv?=
 =?utf-8?B?a2txRE9lQlRLMEhNVkhrYjdtT3UrMWJNVjN6NXhHVi94TlI1OEM0d1p4bG0y?=
 =?utf-8?B?L2FQdTZTcjlkNXJ3WGhqQWlrZ2tSZ2tBRTYzNlhOaThRVnVtNUdSZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	L4ITqo/9nisOczN5JmIdH75mpyXYXRI57VOkPAuvG4Jx9b6+OmZ/NzyBAn30wzeg24LpgvkvEWRMQs7cJCOcSpLE4swU994PJ8soZgcK+dTzEBmAdOq8/uYfFLEl3/8CATa3xxR8tfEE3967LottoWiTfLsRFiLea4QvXLiOjwvQr+GOHnfBS7TBPk49PqsBL5Hh2NlJvavb9Jxyaamm+k4aCw74qdrr8doUiRmxc0uMsroxeyY5u02+4dA6BQcfwWFdy0URnO2TtGsOv+Ueurr/FG/BVVtYFe2rwhwnQWvbvs0S4d6Wp78m+mrfVxyZfhVWk6xwR5PhOhyKozh1jw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b2db96-c401-4244-4e67-08deac32999b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 12:17:25.8250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgUYaIbdFW/+a8N2Rqv0UCAuSUMy7YhV6mia1GQtqXditdM8Z9hVrPFO36O4q4kV7+w39NuWQdZ5c6Ea/9V81Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8085
X-Proofpoint-ORIG-GUID: 3VYLVN8l0ovECMQ82Ts_3rsVJ1fSui1f
X-Proofpoint-GUID: 3VYLVN8l0ovECMQ82Ts_3rsVJ1fSui1f
X-Authority-Analysis: v=2.4 cv=caXiaHDM c=1 sm=1 tr=0 ts=69fc82db cx=c_pps
 a=QnZ2uEdZlRAtgHxfLCbJPw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=qeN3tFiKhdA1IFpPZsEA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEyMSBTYWx0ZWRfX1EO+bnoq7cLl
 jlNNg6P2/Hsc8koZxCN47Rorg0KP9le0/0HDNOks8REpsZFAgs6yADzxAjCHleYzpyJTrzXt9KX
 YxKLfGxoG/9N6WJ06+9LfB+mrtlOwCu4G6l1mYhsDD4q23gXHzHTcvr8yE8XIRLykNkcVwn9F+v
 8OzoxrVO2hB1n8kyLUqiaUVw+hBfU1fevDmdyR6pM+pTSiZ8foJW8S5sk0YCTswAAPfy1A6ZsXK
 20bPw2BjdmARHFKhUsLkvMv5SSUPbzAbC6cpT/newoJj/VboeoCYcpTKuBi9vOAkKbtokV/D1bY
 OOrMztGHD5i4B+ee+I0JhfSZ6Hrh7yLpbWa0eKiVSKW3VO7nth50D9jS2lyBb5gZ9kBlnnHwzPZ
 HV7s0EvT1yux4r/R2CYqwmsawXv93goyMq677BWgGNo4gxzMDmmmr0BK+5llraFi9MQNtG4WmC7
 JUW9q6Ix9vYHPk9Fh9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070121

PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYw0KPiArKysgYi9kcml2ZXJz
L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYw0KPiBAQCAtNDQyLDEwICs0NDIsMTAgQEAgaW50IGFk
X3NpZ21hX2RlbHRhX3NpbmdsZV9jb252ZXJzaW9uKHN0cnVjdA0KPiBpaW9fZGV2ICppbmRpb19k
ZXYsDQo+ICAJYWRfc2RfZGlzYWJsZV9pcnEoc2lnbWFfZGVsdGEpOw0KPiANCj4gIAlhZF9zaWdt
YV9kZWx0YV9zZXRfbW9kZShzaWdtYV9kZWx0YSwgQURfU0RfTU9ERV9JRExFKTsNCj4gLQlhZF9z
aWdtYV9kZWx0YV9kaXNhYmxlX29uZShzaWdtYV9kZWx0YSwgY2hhbi0+YWRkcmVzcyk7DQo+IA0K
PiAgb3V0X3VubG9jazoNCj4gIAlzaWdtYV9kZWx0YS0+a2VlcF9jc19hc3NlcnRlZCA9IGZhbHNl
Ow0KPiArCWFkX3NpZ21hX2RlbHRhX2Rpc2FibGVfb25lKHNpZ21hX2RlbHRhLCBjaGFuLT5hZGRy
ZXNzKTsNCj4gIAlzaWdtYV9kZWx0YS0+YnVzX2xvY2tlZCA9IGZhbHNlOw0KPiAgCXNwaV9idXNf
dW5sb2NrKHNpZ21hX2RlbHRhLT5zcGktPmNvbnRyb2xsZXIpOw0KPiAgb3V0X3JlbGVhc2U6DQo+
IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDNiM2JlYTZkNGI5YzE2MmY5ZTU1NTkwNWQ5NmI4YzFk
YTY3ZWNkNWINCj4gY2hhbmdlLWlkOiAyMDI2MDQyOC1hZF9zaWdtYV9kZWx0YS1maXgtYmI2NWQ1
NmNjYmIwDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFJhZHUgU2FiYXUgPHJhZHUuc2Fi
YXVAYW5hbG9nLmNvbT4NCj4gDQoNCkhpIGV2ZXJ5b25lLA0KDQpVaG1tLi4uLCB3aHkgd2FzIHRo
aXMgZml4IG1hcmtlZCBhcyBDaGFuZ2VzIFJlcXVlc3RlZD8gSXMgaXQgc29tZXRoaW5nIEkgYW0N
Cm1pc3Npbmc/DQoNCkJlc3QgUmVnYXJkcywNClJhZHUNCg==
