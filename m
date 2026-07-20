Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246B3D0907;
	Mon, 20 Jul 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543415; cv=fail; b=NB5mBQ7igmikd7V+GyMQp+4gHKvpewVH6L8ykfu9k+qxauojoZpkvakyXbGwMTQEmRQbeUjxT35Xo8NvLqPcJZgXa6CDs1LRaWs6yp89/6ZaUQgt15uMEeTIePTltyWmOOe9ShqLnH9HHbcXNhIMdDq+vvhL8gD+/eer4BZosGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543415; c=relaxed/simple;
	bh=gdLligMYVT1a8gU/bWbcXMh8HDQwQD7KtSFM6F14Q3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bj/QcR5nJJBrtYqo0QKvnRaAa6utz5nhclccUa8ZjqbIu+NJvYmvRcMnlqt7Hs/uBa2xhw0tz+59EPay5chD/v1NTD5zucLU8CYClzmuPpP3irk+Cu2b3zqixfR9s/C3D6Kddd1NbkQTa2lKJE6sPUBe9x2DtG4tXjTGs+/gTEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=tswZtfNb; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="tswZtfNb"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KA2GOY374656;
	Mon, 20 Jul 2026 10:15:32 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012036.outbound.protection.outlook.com [40.107.149.36])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4fg2a917ye-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:15:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3lBLSdN9aXgXuKuO9K0L4GSJ9JX/BGrHlXIoUqd/D3wuqeBDh7QTaPt1gsBoOvaTtWY0bEDsNF9l1Il4wVgyHLcjrY5q2a4USQxfilaiaJDVM9KfUeu9v/r8hdxorzvf51hpKhzUPwRJ47AlSzapSI2m6onhArzRecRYuQx3xViv697PxBl0YBePFsymKq+l2dE03WIQxcRLLwfDWYAjobtOhFndhGx4tRM9+wPPq79sBoRHQgevkIS6i+bQbjO3Lx68kDqzmYQ9+JOENxhU2jepd1TY+J6KLhnBB+TBcg6cisgRSOUpImqRMs4aKjiDOeHIDAIgQAhZTCwK610FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdLligMYVT1a8gU/bWbcXMh8HDQwQD7KtSFM6F14Q3I=;
 b=jkgXMYwqnnZX8Fpkz6LemL4oZ/9YilWibsj9QPDcwNJVSHEhtZ1vbbWJJhH2LCFcPzDdH7F+YEqECXaak2k0305H1BmtOYeseP47Buf5s5fCNvQiRfH5TIkQeY56Y3gEksU6cFZKcVH1nWn3Sh9CVNJnH22T86VRYLqRUUS4ypP1SGt8TxZp35/DRSfVsoaK/aZXcSffz9tSvAwdRSGUSrK2xubUTa0ghpJZYk+hTe7gen5hXxGoER+sXcEKx2o7LrRjpSqk549YUAU5zsSkizuQuApNTh9t6HIxegj8tWc5FFiIys08GAc3U6sjm1wUGSzaIDB4Yc62s4Ju4rLyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdLligMYVT1a8gU/bWbcXMh8HDQwQD7KtSFM6F14Q3I=;
 b=tswZtfNbBkxDpKkWQsBNWCuWarsU4dr7kStvOs7FD+0LeneoE6ZtzZAeCPny8lrnSSZmfCTOR7U2lkCgmuqKsURD28JfXlp6+R09lIBl+mCqWr4LnRezY5sziXtSc11UKfcWmgheWd9DPBK4V+LE3dov2Tgs+vJEi5xAPUsLajjWag1dJVPU6h5zqw7JzwAPTKNVI67iH5+vO6ICdoHE2Ij27lMposPndFpKu3Z81vKWetFHGXw9p+Jpd6DErbgaHJGSJeUpK/eCnj1JW4fV+kp44KtUEzbcjQ1+qw8wsWddKZ7fqao1PmLoJVYMwyuOj9J8oElv8zCK8X5z4dDyaQ==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR3PPF99537C539.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::16c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:15:24 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:15:24 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: invensense: better timestamp alignment when
 using watermark
Thread-Topic: [PATCH 1/2] iio: invensense: better timestamp alignment when
 using watermark
Thread-Index: AQHdFellUi8K4phVu0mjAKpY24DPjLZyAjwAgAQyqZA=
Date: Mon, 20 Jul 2026 10:15:24 +0000
Message-ID:
 <BE1P281MB14261E2A07A387A74707527CCEC32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
 <20260717-iio-common-inv-sensors-timestamp-rework-v1-1-d1afee2805cd@tdk.com>
 <alpvNm6GHF6y_-oR@ashevche-desk.local>
In-Reply-To: <alpvNm6GHF6y_-oR@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR3PPF99537C539:EE_
x-ms-office365-filtering-correlation-id: 8d8d225e-cfee-487f-db2f-08dee647d016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|38070700021|56012099006|4143699003|11063799006|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 b7Ky3Nw1BUXbT8m9o4zZOLlnBa39C9uJlnf19iJ66yPbYbzVCUjZp4gVKJ/nYDsmaUhWAxnaElrsil+kp95Kz//yjfkqHSk8rS0pIkiRoHjORW1YUXja364Aia6AeFKo+M54rpoPM/gXwjWaRQXVAKzzSV6G5viMZNDtkH4c4fd0WljA7Qx8hB6e1C04z3foutwBYZj2LWgrivBE0oJmGsmL4E0UWlq4K82d/LdjJrkKBGV04bhngzNddl2n9014ba7mQWMMtCihl1izcTXdtc1NKuiK6cFC5vsQ8mAzEUA3fEPUjaGcGFQxGOtHVuEbTCCpwhDKaMn6S7qLDBIl7HYHQ/+S5Bg1rNtIWa3dUS1lqwnS/rbQwRD7zQJ1PThb1kBtftfHqrvZAWD5vm4cNOWrQrVrT1Gq0xeNPmxlr59ZNYjyhtviFxr1lIz5+akOT+4xPic0fhhmjo974xE2uKonkmYcwjADvY1XkvZCI3CvzwnlSetjgQjC4iPaSNr2hUTaFw355XMwPfWX9t6f2q3FnBUyxnj8kqZbCduPPEXlLZugkcMJ6OxLEDZHuIcau1FqTM6aJn3rysRIQT+Dl7b7GDiFaMpHC+iOiTqXJJ7CUJkFxUCPnflFifNFpkYT3yetA3Ja/khcSvb/LqhAoG5/hiX/QtY9LOk5YMEx/kjEOYnvMSPjielIyEffq/AP7ByH2W+gFFf16tpsyQmNICiOiNM/WnlaREM7Of/I2o4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S01ldWh4ODI1WTQyR2VrdmMvQjBGQnpBYk9TUldQZGVQNVRVNU02Tnd2RWNM?=
 =?utf-8?B?VEZubisyQUQ0RXR6aXR5ZEJ1TmlxWVdNTGJqdVViZFRtS0pjc1JDQk9KaEVm?=
 =?utf-8?B?bHhHR0pIQkNrQ0FaNm8xUzhzNHZpSlBsUTc4REFrc0xuVElrdmVrelBQa25W?=
 =?utf-8?B?UlRhV0tiU3phdmg5UG5Qd2ZKdzhQY1MzVmhvSlZ0RklOTmtlV3Mxd2tRS0RK?=
 =?utf-8?B?Tk8vRThCS3FlakhHVmJsT1BIdnB2K3Z4YmRneUQyclR6a21pbEh2Q3RURGpr?=
 =?utf-8?B?eVBCM0UwRTNuMDhDbUNjeEx5SzJGMFZQL2R0cHNMdTU2WTlONVpvRUtkV3o3?=
 =?utf-8?B?ekFsMndLaW1vTEFkMENsQXhKNG1QRG42eDloSjBmSFRGeU1jTEZpV3Z3a0xC?=
 =?utf-8?B?dDZ4T1BKWk1nUTk2Nkd1ZWpKdG9zdW4rRDhDTGdoU00zQkZxVDRzc013M09C?=
 =?utf-8?B?LzJIeHFMR0pDU1lkTzJDTjdwNWtTS1NLY2l1T3A1ZHg0Zmd2YXlURVRmZTl1?=
 =?utf-8?B?U2dXTk1mTXRreUtNMkZJRFVITktaa2I1dWt4K1I5VDdvcjNNRGpjdWRsak1R?=
 =?utf-8?B?eEZqSmN6NktNRXkwSmNpNEF5YnMycS9MT0VKaXhRa3lldXJTOVQ0L0oySG1X?=
 =?utf-8?B?OS9rNjVrQlgxYVRSZVcyYjVqTCtyRVlKaFU0cDJ6bzM5bEZ4cEZaMjlqdWN0?=
 =?utf-8?B?UzhWaForNk4rNTdhVE9hSk45Y0lDVnR6UUMwR2RCSzdqZjVDUmNhMi9qdXBZ?=
 =?utf-8?B?amQzNWdsSEhrenNzcVdPQ1g5YWcyejZpaW9LNG5yV0NQWFBYa3JrTnhCNnFJ?=
 =?utf-8?B?cnQvSFNYOTlRVlp6dDA4NzZMcnBkdkhxeEE0U1BvT0U1RFFnbmZUem1kcUh6?=
 =?utf-8?B?Uno4VVM5UUtLYWNUL3J5bUsvMS8zN0tPbnFvb1VpemErbXN4L0F1R2NzcHIz?=
 =?utf-8?B?UnVLREVIcWFncmY4RHZ1TXFXdG5kNDhxc1VoMFVPWEVHendxSlhXVHh5UTBX?=
 =?utf-8?B?Y1JSR3ZBREZNcjJVNGdKMFhjUUlwbE9KNm93VTRFNS9BbVkycHJsdEF1MjNH?=
 =?utf-8?B?QUhxVVBFQThDbGpXSHNWekRHazlKb2xvYlB4Mmx6SUFtdE5DK2MxYjVjblVC?=
 =?utf-8?B?OWNCcER1ZTc3MU55VjB2UWVNbHFQdTdMcHU0ZHEzSEVidzZEMml3blYyMURt?=
 =?utf-8?B?RFJEYkQyUGlaVnEzWWpOQ1hyUm5wRjJkODJCYy9VN3VKd2FUY0R4VDZnYU93?=
 =?utf-8?B?TXUySVp4dWJVaGsvQnVhYVMvd1ZiN2E5dVRjWjJ3Q1IweXFMVVRsbHRBSDl5?=
 =?utf-8?B?SmlFTDlhV0x1NE5HTHRjTjhTWGZFMlY1OXBCcGo0bnQzNkRla212TURnWkIr?=
 =?utf-8?B?bGVtOFp3bHdDNGEvSlhGd20rM2JsNGpSNHYxQkZaN2cyZ0d4S09MdmJGNnRB?=
 =?utf-8?B?ZU9UYXJwc2Y3UlpTQVlUTk9ibTU5R0Q0LzNXRHBFUE54ZFZWOXBjNzM0cy92?=
 =?utf-8?B?Q0NVSkdaZlM4SHhJZVJMT3N0VnRsS21UNVhzVWpxOFkvREl3Ym9NSHF5Vlds?=
 =?utf-8?B?b20xTkVPa3Z0bDdJUXpaZE9wQWNOYmp2WjZSWHNYN0Y5MXh3bCs2ck9kaTJ1?=
 =?utf-8?B?S21GNklTdXZFNUNlMzcvK1BtaEtYajQ2WlJ2ekVmRDJlemxpdXZxWmVoUDda?=
 =?utf-8?B?TjF0amhiRGFXUmpwVXdXMkkydWZRVEZwVkNxRjl4enFYT3owT0lMSlBjam1U?=
 =?utf-8?B?TFdLekxpaE1sbGUwalNmU012eDBaL0dOWTBaQWtVYjZoblN1MEdGdlRYL3ZW?=
 =?utf-8?B?dW05R05Da0pFeDNEZXdYWDN2VXlVOFVJT3RLaXlvSFc0VDFtNUhsSWRQN1ds?=
 =?utf-8?B?MTNNdCt0RmdzOFhURzBWaUd3UHNRM0N0N25lcGNOWGdiRkFJWnU3ekFwV1lt?=
 =?utf-8?B?Y1hEejAwcy9XMXhsSHNtOGZLUDg2NkFwSC9DcWNnTVVSS0VrYmFRRm1vOHBu?=
 =?utf-8?B?VThOWkFLcUJFNkNxYXNZeDRHd0JDaHBCQU5qTHpjb0hZTlJxQWFZRm5wcUFI?=
 =?utf-8?B?bWhlRFZ5TzVIQ3AvL3piSEVtbnZHNjlxZVQvc0wvS0lHNThDTVREYjk5Yldz?=
 =?utf-8?B?L0VydkhybTVUbklWKzVOS1hTb2ZQME9XUlRXV0I2UzV4cmJzRjFValdCYnJk?=
 =?utf-8?B?bFFqd05Vc09SZDBZeER0bUxxYUFxTnEwOWZ2L2NoN0xoMTFaM1NuZE4wTng5?=
 =?utf-8?B?UUZ6Z2ZoRXNBMytKSVNUVzJMMTJNa0JkcURFQWloMkk4NWtuNjg2NGhZL3NP?=
 =?utf-8?B?OEZ6N0FacGxwODFCQ2txMUhOMkRIU2lBREFUeGkyZmkrQmtuckNtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MRmjesFZRrnIChKWNTwbY/pkQJko3nfpMtSAlMYA5IOdxyM4YICuX29wv+ohE5JoAp1n6pNEVP/WHbtaHl3oY36KA8BHyMuKJkBAIJ5Fejt8pk4d+Pb2SujIBLheo2jYF8O/VWuOnaJsDE7fkJ3+2uFTb8/kPpcv+zpvUpNFf7J9p4Bg2F0yUFxF04oAa1Xn9BZaDNwkZJxi7uvQpENYneb70dpLknljQVXemAVe0N74U2oRA/qGDAsOGlv09FLSLlhddpxthp9OA8MfF5fThyMMiDu/XfGrz+F/3xY0YrASQaiZaanqR/QdieoopyFnSOSERrvgtOisixBHt43vmA==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8d225e-cfee-487f-db2f-08dee647d016
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:15:24.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wo+/WHHLb5cvomXrQEVnn72rlpqbVP3P8CbWFnGfAEpsOqKcXx5obAygHqBuL0kjqNVmppR61Qcm5mZhaa/zqGU5mUo1ZruGS4VaVzZ9yeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF99537C539
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX7QVt5/iUAJaZ
 NziJ7V9MKmq8ESyN0adCsca4AGV/TqiTLvdQ1OPhynwzOFy/xs6d/ZzWyEKhOdXeaZ27EyvbNbJ
 GkxbIXeRE5GUrDh1c8iwZxf6j+UK17SdWXapIXAXj2KqAncC5o5V
X-Proofpoint-GUID: yf65xCG4j-o2DAkCFTCVCZTXnHL03NY4
X-Proofpoint-ORIG-GUID: yf65xCG4j-o2DAkCFTCVCZTXnHL03NY4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX7/IAN0lWxsTj
 mPPrepUyYl67OjPFyDDiDqvVVczW7+9CpXjuKEF+N2NYfq3kTmf+Yxa30C25qNk5c274LymVMBW
 zKxQ4AP6ki5aZI5DxTz87A2Tkk17WRdlILA+zDN9c70zKHIlGF7koA1r5+2jvqaocBvDypgJJcx
 cF8NuwINHA/jQI5XDPqY5Vp9qnM76P1g0W35AnP5DcOCDD8kdttfB+qfugBtngMGZkg0s13M+Bs
 IOzPF/xdnfvMznPn/5GgCGHWiCZk2Kbiqf4yAt0nMF5hbBpnwcz9PRBNusC743MbaCUWD9Rauko
 dCEzuMQ4ZGScbvLFx8JCDs2sMB+oyMvXzFRrKi/pOlvWUHgtx3mnuUMj9R8bUSQmXTLDT7TPMGA
 zQxS/I+LT13N0Unhb2WqjgWID77NREUrk4lzwTD6/FYZtsxGUeUXAe6RAC4YgjtyYnJLQx/KwgY
 vzJEb/ItA0aTlgtWmcQ==
X-Authority-Analysis: v=2.4 cv=W6oIkxWk c=1 sm=1 tr=0 ts=6a5df544 cx=c_pps
 a=mAxJTf1qDA15S3qeTESxCg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=kQtLSR-DKLgZNJ82GyoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200114

Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPkZyb206IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPgo+U2VudDogRnJpZGF5LCBKdWx5
IDE3LCAyMDI2IDIwOjA2Cj5UbzogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbAo+Q2M6IEpvbmF0aGFu
IENhbWVyb247IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNoZXZjaGVua287IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8yXSBpaW86IGludmVuc2Vuc2U6IGJldHRlciB0aW1lc3RhbXAgYWxp
Z25tZW50IHdoZW4gdXNpbmcgd2F0ZXJtYXJrCj4KPk9uIEZyaSwgSnVsIDE3LCAyMDI2IGF0IDAy
OuKAijM5OuKAijQwUE0gKzAyMDAsIEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgdmlhIEI0IFJlbGF5
IHdyb3RlOiA+IEN1cnJlbnQgaW50ZXJydXB0IHRpbWVzdGFtcCBhbGlnbm1lbnQgb25seSBjaGFu
Z2UgdGhlIG5leHQgY29taW5nID4gdGltZXN0YW1wLiBGb3Igd2F0ZXJtYXJrIHdoZXJlIHdlIGhh
dmUgYSBiYXRjaCBvZiBzYW1wbGVzIHBlciA+IGludGVycnVwdCwgaXQKPlpqUWNtUVJZRnBmcHRC
YW5uZXJTdGFydAo+VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyCj5UaGlz
IG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uCj4KPlpqUWNtUVJZ
RnBmcHRCYW5uZXJFbmQKPgo+T24gRnJpLCBKdWwgMTcsIDIwMjYgYXQgMDI6Mzk6NDBQTSArMDIw
MCwgSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCB2aWEgQjQgUmVsYXkgd3JvdGU6Cj4KPj4gQ3VycmVu
dCBpbnRlcnJ1cHQgdGltZXN0YW1wIGFsaWdubWVudCBvbmx5IGNoYW5nZSB0aGUgbmV4dCBjb21p
bmcKPj4gdGltZXN0YW1wLiBGb3Igd2F0ZXJtYXJrIHdoZXJlIHdlIGhhdmUgYSBiYXRjaCBvZiBz
YW1wbGVzIHBlcgo+PiBpbnRlcnJ1cHQsIGl0IGRvZXNuJ3QgbWFuYWdlIHRvIGFsaWduIHRpbWVz
dGFtcCBzaW5jZSBtb2RpZmljYXRpb24KPj4gaXMgbGltaXRlZCBiZWNhdXNlIG9mIGppdHRlci4K
Pj4KPj4gSW1wbGVtZW50IGEgYmV0dGVyIHZlcnNpb24gdGhhdCBpbnN0ZWFkIG1vZGlmeSB0aGUg
cGVyaW9kIHRvIGFsaWduCj4+IHRvIGludGVycnVwdCB0aW1lc3RhbXAuIFBlcmlvZCBpcyBub3cg
Y29tcHV0ZWQgYnkgYWxpZ24gdGltZXN0YW1wCj4+IGlmIGludGVycnVwdCBpbnRlcnZhbCBpcyB2
YWxpZCwgb3Igd2UgdXNlIHRoZSBjb21wdXRlZCBlc3RpbWF0aW9uLgo+Cj4uLi4KPgo+PiAtLyog
Y29tcHV0ZSBqaXR0ZXIsIG1pbiBhbmQgbWF4IGZvbGxvd2luZyBqaXR0ZXIgaW4gcGVyIG1pbGxl
ICovCj4+IC0jZGVmaW5lIElOVl9TRU5TT1JTX1RJTUVTVEFNUF9KSVRURVIoX3ZhbCwgX2ppdHRl
cikgICAgICAgICAgXAo+PiAtICAgICAoZGl2X3M2NCgoX3ZhbCkgKiAoX2ppdHRlciksIDEwMDAp
KQo+PiArLyogY29tcHV0ZSBtaW4gYW5kIG1heCBmb2xsb3dpbmcgaml0dGVyIGluIHBlciBtaWxs
ZSAqLwo+PiAgI2RlZmluZSBJTlZfU0VOU09SU19USU1FU1RBTVBfTUlOKF92YWwsIF9qaXR0ZXIp
ICAgICAgICAgICAgIFwKPj4gICAgICAgKCgoX3ZhbCkgKiAoMTAwMCAtIChfaml0dGVyKSkpIC8g
MTAwMCkKPgo+U2lkZSBub3RlOiBKdXN0IG5vdGljZWQgInBlciBtaWxsZSIgZm9yIHdoaWNoIHdl
IG5vdyBoYXZlIGEgY29uc3RhbnQgZGVmaW5lZAo+aW4gdW5pdHMuaCA6LSkKPgo+Li4uCj4KPj4g
LXN0YXRpYyB2b2lkIGludl9hbGlnbl90aW1lc3RhbXBfaXQoc3RydWN0IGludl9zZW5zb3JzX3Rp
bWVzdGFtcCAqdHMpCj4+ICtzdGF0aWMgdWludDMyX3QgaW52X2FsaWduX3RpbWVzdGFtcF9pdChz
dHJ1Y3QgaW52X3NlbnNvcnNfdGltZXN0YW1wICp0cywKPgo+UGxlYXNlLCB1c2Uga2VybmVsIHR5
cGVzLiB1MzIgaGVyZS4gSSB0aGluayB3ZSB1c2VkIHRvIGhhdmUgc3VjaCBhIGRpc2N1c3Npb24K
PmEgeWVhciBvciBjb3VwbGUgb2YgeWVhcnMgYWdvIGFuZCBiZWNvbWUgdG8gYW4gYWdyZWVtZW50
IHRoYXQgYXQgc29tZSBwb2ludAo+dGhlIHR5cGVzIHNob3VsZCBiZSBjaGFuZ2VkIGluIHRoZSBk
cml2ZXIgYmVmb3JlIGFjY2VwdGluZyBhbnkgbmV3IGNoYW5nZXMKPnRvIGl0Lgo+CgpIZWxsbyBB
bmR5LAoKeW91J3JlIHJpZ2h0LCBJIHdpbGwgYWRkIGEgcHJlbGltaW5hcnkgcGF0Y2ggdG8gcG9y
dCBhbGwgZmlsZXMgdG8ga2VybmVsIHR5cGVzLgoKPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzYW1wbGVfbmIpCj4KPi4uLgo+Cj4+ICAgICAgIC8q
IGlmIGludGVycnVwdCBpbnRlcnZhbCBpcyB2YWxpZCwgc3luYyB3aXRoIGludGVycnVwdCB0aW1l
c3RhbXAgKi8KPj4gLSAgICAgaWYgKHZhbGlkKQo+Cj5MZWF2ZSB0aGlzIGxpbmUgYXMgaXMsIGp1
c3QgYWRkIGFzc2lnbm1lbnQgYW5kICdlbHNlJyBicmFuY2guCj4KCldpbGwgZG8sIG5vIHByb2Js
ZW0uCgo+PiAtICAgICAgICAgICAgIGludl9hbGlnbl90aW1lc3RhbXBfaXQodHMpOwo+PiArICAg
ICB0cy0+cGVyaW9kID0gdmFsaWQgPyBpbnZfYWxpZ25fdGltZXN0YW1wX2l0KHRzLCBzYW1wbGVf
bmIpIDoKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgdHMtPm11bHQgKiB0cy0+Y2hpcF9w
ZXJpb2QudmFsOwo+PiAgfQo+Cj4tLQo+V2l0aCBCZXN0IFJlZ2FyZHMsCj5BbmR5IFNoZXZjaGVu
a28KPgo+CgpUaGFua3MsCkpC
