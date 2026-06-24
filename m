Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71123ABB9;
	Wed, 24 Jun 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290003; cv=fail; b=lmgHLmnqeMS6mBFp+B2OXDV/xVrRKXCS0X/oWBFtv2AB2HDDceIVy/RTN9WCo02gw5Ed5IsbK58gT6BFEe3AoltpocTHRiRJ05U8V6zOryZH4Ff/X5Juru20/TijpIECuVVVhmU1gzvvLUYaua7+KLxC1RITakwLrnawDR9F0ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290003; c=relaxed/simple;
	bh=P6REZ4rfzhKPF75VIznKCbeM6/cOh0raQK6zNkrNwXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gLdX5F2u7HBHcnYXjyXRaIgsuSlCw+awlnyrdAX9uZKxCmUWm2AiPcp4wTNi+tWNMVEb6mfZbAU5+yHTc2ASmyt8MmT3VGE7Oo/PTnd+AIq98AxE08gTKJKWpjv4rVq4hchqHvOQXwtD91zb2dgd3JWlux4RiVSrleYa6JxUOAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=bzO5C4LW; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="bzO5C4LW"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5seZB1210366;
	Wed, 24 Jun 2026 08:33:13 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012059.outbound.protection.outlook.com [40.107.149.59])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4ewh7wubd0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:33:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1nqy5G/BAFRWqkI+rMZRhnAAIp3/nCp3FqWPfjb71Y52Dz90k17QdK5ig+G54G3UosTuAoNyRnlDo2CIfTtFHboI6qpbZNlykRpc2Oo7IvjmftWmoVZu8ScbKO+YACQzNRZ+CZaEMy8sju8oNGpx1Sb382xA9qcC/sDEqq2SV+it7SIdFK3ojIdV7pEiptywpCrz4HFpTx/CRP3l/O3Xy+ur4JJzSONDSkXL625necPpzVrz1/YYkz7jR8tardfFOIJUxhfou1PfFUQDaMySmaJaBGh/vmqBiuSa5SvEFRClx5EI4MeIw0E5xhSvspVkOLhMZKzwO0p8OlPBmq90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6REZ4rfzhKPF75VIznKCbeM6/cOh0raQK6zNkrNwXs=;
 b=S56Cfds8VAYJw8J6klzk4SJKiJXd3cwkIAHPuhUqhCIH5qAvmtYMh+CQq0fJpGVDUhyrByl9M+yDJv7Jpey4WwEWbccliCRNgKUNkFzf5tivirL5N8/kVblYV1c1PD5o6YTepVdlMMrQnVAhVtez0AJ90qYPY1uxYRf80VgmpHGPR6bFwz1ncI/UgD9BpXIVcwYopyyL3NhVh4ju2kv6PqqFrM4g2ccyIu3tkQqfVKAZwVbr8qUThpPgnVStiTDbdrGxvDFiFW3EAfjFrfC98TRa594xoNy1d8B3jGHmPZ7iSSlH290CYdSo99MW6BKeHViFamyVuWaK9r8Wz8YN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6REZ4rfzhKPF75VIznKCbeM6/cOh0raQK6zNkrNwXs=;
 b=bzO5C4LWyuZI6XEKpdTDwV7fe8wDcXj6KzshbaslyuTpndn1j+4aW8ApeHYk90mVewVWLPlB7s+XoNyVMk6/uoxZq9+4NT4XgWem/7s00ccoTcp5570I18UGfDWNzqqmx5Sj+kccEwm7MynEOI5uXCoPpxadZigR4vRWGPE2iTVCgnhKMrOGl+bTw9cviJvNwGfA6dn6FsNJOGLroBr+yD7TO1Ux/jZU1WmiFTRt9ShrmqLBRITdU5zTzdgTDqp9QTZ3FO6obkBjWpRFuXCiy7QGANP+BEhm+bPh+CpuxX0rlOgCChgtj4/aPv/OVjITYfRJyHC7FM38xMlk3D5ImQ==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR4P281MB3747.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 08:33:01 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 08:33:01 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Remi Buisson <Remi.Buisson@tdk.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm45600: Use I2C match data
Thread-Topic: [PATCH] iio: imu: inv_icm45600: Use I2C match data
Thread-Index: AQHdA5u+2qVxKsMYHE6ngd6hugs7lrZNXzFP
Date: Wed, 24 Jun 2026 08:33:01 +0000
Message-ID:
 <BE1P281MB142636B55D9FC138441825A2CEED2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR4P281MB3747:EE_
x-ms-office365-filtering-correlation-id: 0ba40b4c-6fa7-496d-8655-08ded1cb33f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10070799003|19092799006|18002099003|22082099003|38070700021|3613699012|11063799006|56012099006;
x-microsoft-antispam-message-info:
 n4jlMy2FXeMXYvRCJOCwlFF/O+s0eGFlFbaXvg1ZqI6aTO5J2X84vBGyUHa0ZVb4N5WIrbxDa9N7Ub3OufN2az3+wAHQFAug9LKU3LpDxJ6kimvWxbm8RuSYHa6wUpjuF0dYI1IxcbVXdklmxQxRtkdd/fZGIR7we96mn2N6ymJafxTrsZ/VkBXDMjzX9+DavHYBqV6DU0Yy9UugM5zo0InOLdEUFFFvSG8kzoEmUlZZw2vDIgbcGIDXqAnSsif35ho+bS6fRhNogRVUBUMfFQ6MKjDxXuvR6Nv1IXmw8G9gp3uDxdTt/K9v8T1i+iIqVC0JmNthMMyUDcszFPPzU+Iw1emoN0SHjQ+SI8Qgq1kpnlzuYA374BAZV05fUj2RL5hiB2yagJKYtOBQToriRATievb+fgrXhq1oQWF9TCBMcJFqE1WMYzES9FQkOpLStoJwUGWllzMQ3EHYeR1x4/8eTOV+v6ZkfiwcTwkcm/HjbjCktQuaE7OWENH01Fyuxp/vzYnEuIv1pwknzTfcegJfmTYhCSKZW5Wxsun9114y/kLAQsxrZospoQAreqK1mbnrY/gOFhf11bTlnwcC7AnEqOihsvW3ZL/F0Px9gCeND6ZbDCngbeiuI1PE+k9V/AjarNolbomjbJ3itfiYJu9iR/UIELRogENP5NmwgATQ4Iji5HcyVyHuH1ixdiADPDnsKiUKIDbgxC+CFKoH1sKfxf+XKB+up20Ko6kVdhsh5uwiAkjg88vRryc5+M8k
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(19092799006)(18002099003)(22082099003)(38070700021)(3613699012)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ck9XaVZWUVgwam1IVG1xbFEzeU55MzBOTlE5YjZPLzg2RTNLdmV1OXUxckJu?=
 =?utf-8?B?SkpwMFlDQ1RISWgwZ08yeGZWTEVDVGVabktDRFU0NnZvYjRtUG15anlZL0lW?=
 =?utf-8?B?ME1wbk04ZjlPWUs0b1F3ejBIa2xkcmZoOXBYb1Z0OUcwVXBsMHBGWlFkQkt1?=
 =?utf-8?B?RFR6MzNZenZqWkoxMDZBQm9Xb3hqT1orM0ZIYTdSR1hhOGJzSWVBNnN0TDFP?=
 =?utf-8?B?T1BFNUhQcU04SksxRlFyNVh5VGpaVzcxSTRUa0U0Y1ZZQ2xvZEwycklQejB2?=
 =?utf-8?B?dXZ5d2h0N00zVzlXTm5nM0VBRk5HL2ZBby9lNzhERFJvMEE4WHVLeGtjVENl?=
 =?utf-8?B?MGI1eWwwMVpQakhEUkhIZ0U3Zy9yaTdnMjlyM3JmZ1ljdlhveWJwNjNIME9a?=
 =?utf-8?B?THBXNXFGM2JyNERPWkNPbWV5bElJZkZCdlFEM2FqTDg1UHo0UkJSbUhWNjRW?=
 =?utf-8?B?Q1pXVm9LYnFteHl4TGNDWXZ6QnRqNmNnTWxXbG5BSm5TN0hMbm5ZSWtPTVky?=
 =?utf-8?B?eURyRWFUZzJSWXFhYU82MXZ5N1FrRUFiNGVyMUJWa0YybzgrQnk2R0xXK2dF?=
 =?utf-8?B?ZC9xdm1mUW1JWm5TOGVLNmgyQUNuQXlCNnpDVHBnVHhnZ0pFOWtIVjgzU3RR?=
 =?utf-8?B?US95SmRqS0VwL1E4SHhBZStHTVE5RjBsbk9sYkRMcjNWaFJ1cUVnZGtOcG5m?=
 =?utf-8?B?dzAvTEhjb2JzeVBtWjFEUU1NdkV5OUhvQ1k5dmxDS0pJbUkvVXdOVXdSaTJN?=
 =?utf-8?B?UE9QTEN6K0VqdFFMQXNmOEovdHY3dzdieWZlcG1tZndOdjhTRmFINmZmb3dm?=
 =?utf-8?B?dlBMK1hqb1FwRzVheVVmSVNQUWY5MmFncDFIcDZYakVGRnY4b3krdmpUamw3?=
 =?utf-8?B?VER3bnYySjlVWHIvSDVyQUhDU0M5MDc1ZWNuQWl3ZVkvTzV5ZkdlWlBZajFk?=
 =?utf-8?B?UEQvZm45ZlJkanJyNURmSWlaUHBFT1ZFek5hY3RzaWM0WTduWk1YWFZVeWxr?=
 =?utf-8?B?UFpLWEVoTU40d2oxaU92bzZmdEMzRmRDQWJ0RkR1YjQrRFlQQWZyS3c4bFNM?=
 =?utf-8?B?RC9EK1ZtTVpWSExnQm9EWUdhdWF5OU9JM1FiK2VNUHprVXdJMHhjeGorejd0?=
 =?utf-8?B?L1dGZVY3bFkwWmV2bzhSRDdIUGQ0RllKWW9rMm1CMTU0eHpkZWpzNkFPaXN2?=
 =?utf-8?B?aHJ6VkJ6WlJ0Z2hmTmZacENxaGZ6Mml3RlgrY0ExbnRoK2U1QStLaUo4ZG1s?=
 =?utf-8?B?UVorUkRQT0NHcXB1djd0OTg2dEFKelhweXVaYTFRY3FwOEtZekJmeGp2b25t?=
 =?utf-8?B?RUxnT2VERmtHWDRMcndiUGZDUWw4ZkxsRVRnbHdIK0Q0R3ZSRWNpMGVROWZO?=
 =?utf-8?B?ZzdsUTljNUNzenBabFR1WGNGL3lpdW1Fb24wRmlRaXhBTUlOUkVteEJPVmZR?=
 =?utf-8?B?ZmRzeE9LV2ltekVIdEMzTTk4V1pLb0dFclJYY2t0cHNJcVJONDAydjdxYW9j?=
 =?utf-8?B?dTNINGdBOXFRY0VISFltOWlmLzI4akV2bFJoRXZPSmNjYjZXaGNmNWlUR2d1?=
 =?utf-8?B?alZ3b2JOZVAydmZYakFhOFRnQWphMy92Y3UreXROcUlCMnhKaklWbTl6Q1ZY?=
 =?utf-8?B?NHV3WHJZTm5oS0NlMzlVdUN0bFB0ZmZZR0pGYlo3bGp3TlBxVFBvV24yNWJn?=
 =?utf-8?B?NHA1ZU4yREl4ZHdMcmo0R2VVbWRMWlU4RVdVYkhwTkFKeUhRTlBXS0s3VFZC?=
 =?utf-8?B?REVYQWJvRVV1ZzAwRXMwOXJsREttMUw2QUhCemdmeFpFVFoxU3hCMVNPWlIr?=
 =?utf-8?B?Tzc2N3poWnpET21NbDNwSTFoTDNZbmxoclM3RDNMMHVHTTFyaFpxbHl1cEli?=
 =?utf-8?B?dnBvUHREbHczNDFiclFQK2NpWnJQeDI1cFV5ZVg5MFI1V1NJcS9sMzc1U1BR?=
 =?utf-8?B?UUZnbm16MDZBeHlkOUs2ZlIxcmYzUE5lalhGdGlJcEtLWEpZZ1poNkZRNkp0?=
 =?utf-8?B?Q21TWC9sL1JDVk1nM3RIZkxQSjRaWVN2YzJQeTBoVEkzOThyUG03QWhXZDBR?=
 =?utf-8?B?M2tKNW41b1ZNMWJ6MS9kZmtHdXdONlZGZDM4bW90bGlzb1JPdys0OWNza05p?=
 =?utf-8?B?cjJNa3lZT1BPdFZnSEJQd0pwMncvQUFHcnR1WjZmVnlLUm04QjB4dWovY2R6?=
 =?utf-8?B?cXk0RmQ1VXRUTjdWbjNwdis4WjZsK3VSUFU1cHpZYkRHOEhoTXNJOFozL3Y4?=
 =?utf-8?B?bnVVeDd0amgwOGd0UjErNXdwRVgvMnBzSWJyYVNldExlM2lEZ2R2d3RqdENR?=
 =?utf-8?B?cVZ2QVFrRW1RNU1jejhBOXZjRUs1Mmx0cUp6MkcwNTk3MVNzTHZaY2pQODVE?=
 =?utf-8?Q?lAfFh92s9IZ+70NFAe5tUc4Gx8qkxiu4Mk9cIlf29NjH8?=
x-ms-exchange-antispam-messagedata-1: CCOh1SVaoZFGEA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iwmwHYZXknftT9tpC9eWyUexQL6P586vmDn+H0uaZ/IvugEtnjl5GqsS2B66YfbNT54KutBFje+VKeRE/IKOQ7rCvFPlB+Sbji/6JJdMmhM0bab67nnDlEsaQe9GQxxsZlZ6Pr9jRJAmgcBa9Io+kwRemmK5i78ZqMzGB35sTOafnbSJ+ZQF+E3kC9sp+IV5vpv3tSI5MSbwc3pQnMYThP/uaGzy/ZQ1PIc9/nq0V8zKAg5Gwk4DuSjkywzEA153lv8oT+vMjwCHxNn/f/ZtnfnHk5Sgz9cSH2X5uglvjGulmC5NHGPQTk4XFum6tJ5wUwEaxBjKf+5f32SB61iWsA==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba40b4c-6fa7-496d-8655-08ded1cb33f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 08:33:01.3198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 301BKXVw8VSdm78kKhzsmLpqcOsRheEONry/pQiozBXGOVpw1FMVZWL/rkk9PkCbYRFM5Gef8spjciT1I3t5IZxve3/Ua/H3lLR7TgVZct0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3747
X-Authority-Analysis: v=2.4 cv=U4uiy+ru c=1 sm=1 tr=0 ts=6a3b9649 cx=c_pps
 a=fBBSAWMpRdHsrBRfZckhvg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=VwQbUJbxAAAA:8
 a=In8RU02eAAAA:8 a=UR6fuQMdMiMC02myTMEA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: O5aALD2CaxwvQcCtkqqGESbKiCnTZ0Yp
X-Proofpoint-ORIG-GUID: O5aALD2CaxwvQcCtkqqGESbKiCnTZ0Yp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2OSBTYWx0ZWRfX2l1SDtxjmfpg
 jlQATq7QDnLk7OYUwG53q/YJjG/4MfPuphl9tkoOfFcY3srif93yGEoSS36/C2PWUy9MbthjTKE
 Mjfdjy3VHJQ7Co7WUAM5/RvUdQ3e1t2rkp/g6dXePhS3/EwqlSKU7zPmFyXy8XXwMQTdZ62W61b
 Rr6iPGC3EXEST3jty5P2SqtEmmLmz1YAMRniuNNrFE/CbrVOoDpL5M5mfRuACUlxX7GjA+RsqB8
 SM/4UJmjBe5PArpV2LxxMyW9oJBhEHI+gow+F6KYVJKuimCqxdQ9WI4GKROPL8EOppkmIF24HH7
 UVqWwR+oneOtFMsnSG3mFfi/DF/bTRywzd+Qoz5Ad2X80q+e6QuHjD6KRhuTQ6T5WXfNzH70uRW
 ZTvDbZcWFNiCLCcnlcfZeMi5MbRc6R9V4ho46QfIOrD7bEYtiEOzvcm17AIm7DoLfT7eBmJOnww
 QjHcn9V8BfHtHwPVJiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2OSBTYWx0ZWRfXxKaKuf/mbTBV
 0MSBTi3y9NDaBkQmVg4RV0alMU1JFmsbvo7BdX2VuCVe3xzqbA90tmjYvvRv2BReIUi+i/s0g2F
 nUkgmrHW9cfFEeqLNiAol4KH9Q6VzuhrUAw1ynL+PLbXZH/WcQmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240069

PkZyb206IFBlbmdwZW5nIEhvdSA8cGVuZ3BlbmdAaXNjYXMuYWMuY24+Cj5TZW50OiBXZWRuZXNk
YXksIEp1bmUgMjQsIDIwMjYgMDc6MzgKPlRvOiBSZW1pIEJ1aXNzb247IEpvbmF0aGFuIENhbWVy
b247IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNoZXZjaGVua28KPkNjOiBsaW51eC1p
aW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQZW5ncGVu
ZyBIb3UKPlN1YmplY3Q6IFtQQVRDSF0gaWlvOiBpbXU6IGludl9pY200NTYwMDogVXNlIEkyQyBt
YXRjaCBkYXRhCj4KPlRoZSBJMkMgZHJpdmVyIHByb3ZpZGVzIGNoaXBfaW5mbyB0aHJvdWdoIGJv
dGggdGhlIE9GIG1hdGNoIHRhYmxlIGFuZCB0aGUgSTJDIGlkIHRhYmxlLCBidXQgcHJvYmUgcmVh
ZHMgaXQgd2l0aCBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoKS4gVGhhdCBtaXNzZXMgaWQtdGFibGUg
ZHJpdmVyX2RhdGEgZm9yIG5vbi1maXJtd2FyZSBJMkMgbWF0Y2hlcyBhbmQgY2FuIHJlamVjdCBh
IHN1cHBvcnRlZCBkZXZpY2Ugd2l0aCAtRU5PREVWLuKAigo+WmpRY21RUllGcGZwdEJhbm5lclN0
YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBVbnRydXN0ZWQgU2VuZGVyCj5Zb3UgaGF2ZSBu
b3QgcHJldmlvdXNseSBjb3JyZXNwb25kZWQgd2l0aCB0aGlzIHNlbmRlci4KPgo+WmpRY21RUllG
cGZwdEJhbm5lckVuZAo+Cj5UaGUgSTJDIGRyaXZlciBwcm92aWRlcyBjaGlwX2luZm8gdGhyb3Vn
aCBib3RoIHRoZSBPRiBtYXRjaCB0YWJsZSBhbmQKPnRoZSBJMkMgaWQgdGFibGUsIGJ1dCBwcm9i
ZSByZWFkcyBpdCB3aXRoIGRldmljZV9nZXRfbWF0Y2hfZGF0YSgpLiAgVGhhdAo+bWlzc2VzIGlk
LXRhYmxlIGRyaXZlcl9kYXRhIGZvciBub24tZmlybXdhcmUgSTJDIG1hdGNoZXMgYW5kIGNhbiBy
ZWplY3QKPmEgc3VwcG9ydGVkIGRldmljZSB3aXRoIC1FTk9ERVYuCj4KPlVzZSBpMmNfZ2V0X21h
dGNoX2RhdGEoKSBzbyB0aGUgaWQtdGFibGUgY2hpcF9pbmZvIGlzIHVzZWQgd2hlbiBmaXJtd2Fy
ZQo+bWF0Y2ggZGF0YSBpcyBub3QgcHJlc2VudC4KPgo+U2lnbmVkLW9mZi1ieTogUGVuZ3Blbmcg
SG91IDxwZW5ncGVuZ0Bpc2Nhcy5hYy5jbj4KPi0tLQo+IGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNt
NDU2MDAvaW52X2ljbTQ1NjAwX2kyYy5jIHwgMiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2lu
dl9pY200NTYwMC9pbnZfaWNtNDU2MDBfaTJjLmMgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1
NjAwL2ludl9pY200NTYwMF9pMmMuYwo+aW5kZXggNWViYzE4MTIxYTExLi5jNjVlNTUwMWVlZTcg
MTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9p
MmMuYwo+KysrIGIvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfaTJj
LmMKPkBAIC0yMyw3ICsyMyw3IEBAIHN0YXRpYyBpbnQgaW52X2ljbTQ1NjAwX3Byb2JlKHN0cnVj
dCBpMmNfY2xpZW50ICpjbGllbnQpCj4gICAgICAgIGlmICghaTJjX2NoZWNrX2Z1bmN0aW9uYWxp
dHkoY2xpZW50LT5hZGFwdGVyLCBJMkNfRlVOQ19TTUJVU19JMkNfQkxPQ0spKQo+ICAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PREVWOwo+Cj4tICAgICAgIGNoaXBfaW5mbyA9IGRldmljZV9nZXRf
bWF0Y2hfZGF0YSgmY2xpZW50LT5kZXYpOwo+KyAgICAgICBjaGlwX2luZm8gPSBpMmNfZ2V0X21h
dGNoX2RhdGEoY2xpZW50KTsKPiAgICAgICAgaWYgKCFjaGlwX2luZm8pCj4gICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9ERVY7Cj4KPi0tCj4yLjUwLjEgKEFwcGxlIEdpdC0xNTUpCj4KCkhlbGxv
IFBlbmdwZW5nLAoKZ29vZCBzdHVmZiwgdGhhbmtzIGZvciB5b3VyIHBhdGNoLgoKUmV2aWV3ZWQt
Ynk6IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRrLmNv
bT4KClRoYW5rcywKSkI=
