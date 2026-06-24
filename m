Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE77391846;
	Wed, 24 Jun 2026 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288997; cv=fail; b=hBWsTNjyMvUML5+JsAtlKulVjiHdz1UqJ6r733MDDXJXnh37HxHMZxj77BPk9yu2J7gD6HGEqtCmHuBNTphnqTVJRbRaNmt2j6E98Lx9dCZPrCk2yEyztvsHOWLfDPeaAbjy6FCbGu5onggVOt0OyzxMtVQK1lOKCPc9oW7fDIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288997; c=relaxed/simple;
	bh=o5f+EeXhQtGuLfO0j+4vwI/QYzrUsR0Yr4pCsxheZ8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EgXL8uAjOKZ7iJld1MY2qGdoD/jj+ymzjBb9dWe+Eu9b1zLLC+A8Io131tPJ4ei9tQA7a6sODcG+R5lp0Bs5nN2zagCBRavVqUYKeZ+im2E9BYTL9W601lPEL1IwckkZlHc8BbO8qTJUuhxWvhWz7W7YZQh5yTCU02s2GdoNr4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=lDxakuMg; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="lDxakuMg"
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5sqP12138294;
	Wed, 24 Jun 2026 08:16:16 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012021.outbound.protection.outlook.com [40.107.149.21])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4ewm7hu9yq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:16:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSVs3uFz7sDbSkCnFEiZJS7Wqtwp2axZ56KrnKgT/tCFdSdWXFxUa4Np4P6tDW8QOeT3sFfaehSxKeOzgjF3vc7h7INvY3MoG9IHClh1M2Hf/eb9QuOXR3iX/28KYx2rv+rx0A5ICM++r+xo/YZT37oK+3f0TYtlWVvNLxRRY9XRYdOK1NmJFDwus86AIkEBitNMFWni7lS5uuCT86oXYxxOC+iep56qxdbPlYJYG7Q746v1ZIcMKKGRHRyqRj6pvp4/r9SAIbLWK8Afvj3jvYCKi90i1DyfRr6scIU+obez03JENUsL1D4DksIujyFREtqt0RbdfKq2oS0rTVKrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5f+EeXhQtGuLfO0j+4vwI/QYzrUsR0Yr4pCsxheZ8k=;
 b=la3K+IUGPbq6FwWi1P0N3RlHi7RavXSbPcgLjchMVvvpCYQ4QTx5j4LHfTId7bE6QI7JFnqJvYmS7Dsf4L8rQCKRfekfb36xlVHSCUoHYTVsTTS/pjEG/zZ88abJiQr0mT3msICZLn+YRWUGM2mTAfR5da4z+Y/fXMrchzYlMDWZqznA64AZ0E3kjIJtDl0SDIGsRl9DwGvekAY4GPtgSfJP8kmiE1AuRfKTp5h0cCs7b8rFEQB4x05AInaOXBj/Ks0pURJRI59BLEYSR0ffQr1w1Q0MOvnHeVQihjGEBYd92L8tIHi0sLTF6vzkCexK23MlBklomov22xZL8ogfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5f+EeXhQtGuLfO0j+4vwI/QYzrUsR0Yr4pCsxheZ8k=;
 b=lDxakuMgfnKQYdO3q3/XQdXWn8oaghHMe7R5+QkIB7crGH/Wtv3nm9FZWJHo6grk5SXk0i6eTD2Be/aZfdCrtP/3GEuRWEAE3gg6m/mq26/04KHr5urkBjFGbG5vnUTF+W0z5ROJqoJoq+MJpeyUfzrOcyWjphbIpszEo1fy3+H1UXl2PSJxtdCuPBBV4FbfDM9x/d/7BRcap2hpAepFc+I9DA576VLSswhcLZs3qvBs0Ohjgoh1iKZd2yrSi79HYPzRcbfYd3Ia0FRWrZUQ9l3ko0CUjW46PVymsqGKwqrvelS6ZLktBZYw47W32vVdCNJDe8MayyBND0DVzsCFYA==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR3PPF24338B46A.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::11e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 08:16:10 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 08:16:10 +0000
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
Subject: Re: [PATCH] iio: imu: inv_icm42600: add buffer hwfifo watermark
 attributes
Thread-Topic: [PATCH] iio: imu: inv_icm42600: add buffer hwfifo watermark
 attributes
Thread-Index: AQHdAvic4wS7f0qpj0KL2Tg9sGiAtbZMlP8AgADH7KI=
Date: Wed, 24 Jun 2026 08:16:09 +0000
Message-ID:
 <BE1P281MB1426567ACA34E8965D243CAECEED2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260623-inv-icm42600-add-buffer-hwfifo_attributes-v1-1-d190800e60de@tdk.com>
 <ajrqHJk7bbKLQJBS@ashevche-desk.local>
In-Reply-To: <ajrqHJk7bbKLQJBS@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR3PPF24338B46A:EE_
x-ms-office365-filtering-correlation-id: ce55252d-4960-48c0-b9da-08ded1c8d8f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|23010399003|1800799024|366016|376014|3613699012|22082099003|18002099003|11063799006|4143699003|56012099006|38070700021|6133799003;
x-microsoft-antispam-message-info:
 oh6lwpIZ9L2OkaLuePyLyrM1G1Jim/rMZG54KhQQZxrkxRW55+r4F7rJOwI9IXq0cKeIUg+uSjQ6s/O/ZlzrT47Z9NDGE3LBQ9uW6x7U3sbnNEyXncE0BttlzuZ8KP2cFiu9cgGZY170E64rKJ++pi061XfAmO0VkUo0IbSEXVDxXc2RE2gkBUBbEykMC6Mjwp8e5yAxu4YQZP7p15Edo+ftr8ydL7SpW8vrNgX8xpNWhXX+XbUI0JLcO25O368yCt9rpFGB5DYWeINTuWK61uqyvHxP5nC8T6VDyFxgj6HT6H3KetpX4N90GRuNNsrdxSUl/v3wt263RDnhOhAQ7xVToiTCKku+VqvPIBvVrULFHpsPneC4/bhiEVMnOtoHVqq5W5cQ2pzZ2FPupE9f36vaQB8zjR1ukrIdGTox9U8OQdCFkjJNJcJ8pYZSHRuGzE2Noh4WBhtzPDzcFvWxuQKPA947VNBECWmTnYwTdGilFBBLKGctnjDVA0XZcmRsWvrAMvjeE8FdRnLwv4xLpbbsT7VyRu1Z9xtgxq3DkAtosTXV68gifcpPAQUVDWOjGSaolGayNKoCayWCrRtt8E6fBxIQUmghvcZaT73uFFBEWb+imzwIyn8BRM6ak1uN1PRgqsgGWw2XrwSQwC9yN0yz68L1eWGQwmsHWEZbpZuPW11sDohLfMZQXl3nNQ6UP14/eJVsoEY7vXkIzTZAtL19aXf0cgHpaIKKkO2MnmEs3b90HSQIxvBDzlXdVnIR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(23010399003)(1800799024)(366016)(376014)(3613699012)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2FRc2RCZStmTXRleW53S1RaT2dhek0vNW45RWNQVW5aSzh4R3l1Mlp1d1la?=
 =?utf-8?B?T09qMHQwK3RJNVZhc3pJZ2FraExrci9MTVRhSEFMVUtpd00wRW91SlJqNWNQ?=
 =?utf-8?B?ZnA3b1pRc1FubzZBRXBCWTVnL1A3c3IyL0NVQTZxRnV1d2xUYnhEcit2b2lW?=
 =?utf-8?B?RHZkNUpOQ1NCZFhaQmJxSWxpYndZL0JlRm80K001RGNhajZYd2sxa3JiVWJn?=
 =?utf-8?B?Q3Yxc3MvSHJJQnVRM1VHWDdNRVlrWVJjOUFxbWRsYzkvaG5vb0Z6SENIY3Rs?=
 =?utf-8?B?d2t2bU5jV0s5WWhISUxCR2ZkenZFd29NekJJcEJtRVhxM0JQRXhQd2E3bXIv?=
 =?utf-8?B?V0lkSmtLZzJMaFlVSHdUeUl6enFXSW05LzhBRG5xdWlNbXdlWGtISGo1aEZh?=
 =?utf-8?B?V3Y4MDNYaWErdDNJR2hGZEIwdnp4RDlpeHF3N1dTa1ZRc1hXN3VhZytZNlVN?=
 =?utf-8?B?WVZDbUxWMjcyaWFhQmQxMk54NXFLYnpBa3lRTURIcGN0RHF4cER4ZHU2Z1gy?=
 =?utf-8?B?am5JYWpVUG9uTEJlV2xTUDk5c1VaWFAyZ1g0QVRlVVlnUEVmRkU0aFN4RTBL?=
 =?utf-8?B?VGhieEhzckFYWC8zSllhd0Q0ZXRLOXk5WUwya1dFYW14ekZBQjA3M3VsanY1?=
 =?utf-8?B?Z2hBMk5MWjBzeGo4QWRqU3dVbS9ad3Y1UU9SNlJlRS9GMkErb21uWG53RHFO?=
 =?utf-8?B?V3RmOGJmZTNMN0VyeCtaNE1UMElOdDNoRlJXeWNjY1JPN0ZHS0xnNzlsWUpm?=
 =?utf-8?B?K2VENGJiQ0svK21GWWtvT3B5ekN4a1ZKYjQwQU9JOWQwWHY5bHJhYUJKM0c2?=
 =?utf-8?B?VDIzdENCQlpOdmk2YmxoVmVxN3B0U2pML2txdURSTWNhVkpNZmpENHFxd25R?=
 =?utf-8?B?TWlPUndSeGE5cVI2N3h0dm9zdmozM1BvWEo1TDZ5dFpPTU5JUDFFdnNWcjlK?=
 =?utf-8?B?MHhXQjRmZDBLVXVWQjFuOHQ3NHpmYnRBczRob0lEUTBaVm9iZlppUFBpTkFN?=
 =?utf-8?B?WjRZczZPS0JuU1pwbGhJMXRFSGZSVzNpSDJZeXlxckpQRkZ1NjA5NGJWQXEy?=
 =?utf-8?B?M0xGYmJWU2g5eExZa29QbWIzbS8vTkU2aXlUUm9TTWd3cVN4b08zWkh2YkZW?=
 =?utf-8?B?aGp0V3lvLzlTUkJzR2YwMWhuWE56b2RISW1BZ3JhZzg0THM0WWdZYlA1a3Vy?=
 =?utf-8?B?NWhGTGFPT2ZKdVEzMi9SOXNiY3laUHRRSXVjUllJK2U4NHRtWUQ3MXVVbEx0?=
 =?utf-8?B?NVI0UGVsQnd5ZzlvejF0VFJ3Q3k3a2xlS3FkdnlFRXdsdHg0ZC9tTWl3ekZt?=
 =?utf-8?B?ZUxldmNhak9sdVIyblRJWGNleWFvYTc5RG1RYmZ1MWh0cEdETmZzd0F1WVMr?=
 =?utf-8?B?SmRRTmNHdmhPUkI5M2hDWHNKVTVTMHVwZVRDRFJDajRHUnIyNHBkVUZpVWxM?=
 =?utf-8?B?L21DWDR2RHllc3lkb0JZVmlNSWhvaFBNYTg1V3pseGxnZkRyTlA3ZGtXMmJD?=
 =?utf-8?B?S2Uvc1FZYXlSQ1dyWVg2ZHoyOEFXZU5GWUlwZnVSNUplQm1LRDltTzlWcTQ1?=
 =?utf-8?B?UGdkM3N1eGNkby9OL0NqVElNSnByM3JPOHpHZFFIcDBCUVlKS0xmYWIxNmFC?=
 =?utf-8?B?WXBHbkpxZFFPRXZBdGphV01PUmRnaURWbWtiZWtnWHBhRnpKL0E1RjlhY3hH?=
 =?utf-8?B?MXpjYWlmdmZRbWhlU2pWUU1VMW5nWmxKWU9SZjdrdlAzRjFNSDEzNmNKZmZJ?=
 =?utf-8?B?Ynk2Vy9RSnI0NGhEZkJRVDgzMnF2V0F6NkZQTlpScW80Tm1aUjI3SkRvMDYv?=
 =?utf-8?B?V3RIV0lTcTUxK0pURmZxWDJJL3VTK0N0NUcwcEZjQUZ1M3JvWUl4NlcvM1VK?=
 =?utf-8?B?R1QrdmhwSWxNVUdHaHFhOGV1NHlsbS83UHh2eEIxaDlZZityUUhDekxPNXcw?=
 =?utf-8?B?MEJlVDQ2MFdJRk05MDZ6MzBvTEJOZThJM2hVQTg1SW81YWsrMjZrVTVoSmVa?=
 =?utf-8?B?V25IdnhGYnl3TWltZUFqWTZ1N0dhRnpyNmFNYjVFK3pybEZCYnVGRTJ2akhJ?=
 =?utf-8?B?T292MFpScm9Ia25xU1E5S1dEaEFkS3FxRVNVUnA2QjZQLzJQRllUQWNoOGNE?=
 =?utf-8?B?TFhyVVlOdTdIQkdNeGNpRE5EM1MxbHR3dCticytRRThSU2ZodjZXM2dGZ2Zp?=
 =?utf-8?B?Q0prMnMxUFRLL3hTSWVrdzFPbVMvejFPcGJ6bnhpamd5SGlFN2djb3lpTXRP?=
 =?utf-8?B?OE9LYzAzd2ZlSFNhMHp5TVRteWhiQWNKaUNmWGVhUjE5QzlGNjB4UFRyMmt6?=
 =?utf-8?B?N3BRb0tnRVJnbnUxWW94UWpCaFdBa0Jud0R5UEw4aStpZUk3Z0xuU0IrdG9D?=
 =?utf-8?Q?z04rd/m6L6x352Lwpvg9pzcLHRqbk1EpluTpmf+FRG5CS?=
x-ms-exchange-antispam-messagedata-1: VHnMvxvcZc9xiA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fM/pRycAAAjz1tuE3n6QRxxC0j4igbCqxsMNylhGyQjIH1+/SfxYBnLkgam2WnY7XGj8ClTauiWg6G1qx7SXRKtVshMGzlfg8WsT60FXtWRRLCJZ0YIsK1yfRnx5pMzoAv7bqhPWwMIFp9SpX9rnXavl4ojNwfdcLLz8dNWs0poMTEdDmnuADx3apuDgPXrbYyk2TH/5euOfSWX2Zt2wq4B8fphYror0fcVlPoeBCNiVHzhtFoaWeI+uiVr1LwYDNb0E6pFt5MEMS0ijFnAePgzlnLPxlMDPg9i6NWZBJJSs3csQdBiH9jurIcIDMWvKKNSgpAuKFNBfgCE/XSAxTA==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ce55252d-4960-48c0-b9da-08ded1c8d8f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 08:16:09.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8Pe6JzYDw7ehiP0umSPZ36twB26CdPpYOsp08GTxazzijuc7WUHrdNDPNaH8DPmUsDegIknkkQ27akXlsHXS1ZGOcl1scYYHeSghu89KVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF24338B46A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2NyBTYWx0ZWRfXzucQBScYUe9K
 EtECxonXst+nZVfeqF/YsEWY2LIOPDRTzO8AWnbtrUZuT0Vo+g3SiNRUV04cUmHC1C4N/7Z2vlf
 jWEBgwmc/a3sO+WVHfPhmrHMcABNkvsrP432mFfhK+B0P3wCUCKqw0BCspPggyomJEJI52hHM1I
 BJHO9AjGbUZ3RvW+gIt8aFbZrZ+BhSko2sT9tNZhj3TLgLZysXBqWd5qpD/4JxsoGtJDl2RTi04
 +PiZXDfiYB2WuY5Fqop8/AbOqECyFiEnwnfHZU+VW29BtRmF9JGuIbM+wFNb1UvD2qo8Zeokspn
 CduBlsE6WFSROJI3tqrRPSSbVWY24DzwhWzraEGb6nIjJihmVPAZyBle29Mh+ca1FpJFXizj1Ol
 727wTO8PaOspBiM5b0yr86014bsVuxBS3svsuDl45N9HoFqJg/nfZsKdIj5svjTai1o8XmXA8tg
 WVpChq5zWOOSz1Woebw==
X-Proofpoint-ORIG-GUID: UKm_1vgD1pLkUYz2PcHsjaE4CJ2-6WZR
X-Proofpoint-GUID: UKm_1vgD1pLkUYz2PcHsjaE4CJ2-6WZR
X-Authority-Analysis: v=2.4 cv=Ivgutr/g c=1 sm=1 tr=0 ts=6a3b9250 cx=c_pps
 a=IR8Brr64TpGTdnjv7obVRg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=Fb1OVVX5NHNCQtuFP9oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2NyBTYWx0ZWRfX/wf6BsaYbggJ
 /uyXF/LCzBhFV3I5sTpn38/g+ncf5YYcd4l5ICBdSLTNsVGZvceGuaPWeGZ625hoSWkBE9VjNFD
 6t19Cx2dNka3RgX1oPzOghQkRnCWCEzmDf4+OzY4zZ9f/aHlEkqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240067

PkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPgo+U2Vu
dDogVHVlc2RheSwgSnVuZSAyMywgMjAyNiAyMjoxOAo+VG86IEplYW4tQmFwdGlzdGUgTWFuZXly
b2wKPkNjOiBKb25hdGhhbiBDYW1lcm9uOyBEYXZpZCBMZWNobmVyOyBOdW5vIFPDoTsgQW5keSBT
aGV2Y2hlbmtvOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnCj5TdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGltdTogaW52X2ljbTQyNjAwOiBh
ZGQgYnVmZmVyIGh3ZmlmbyB3YXRlcm1hcmsgYXR0cmlidXRlcwo+Cj5PbiBUdWUsIEp1biAyMywg
MjAyNiBhdCAxMjrigIoxMDrigIozOFBNICswMjAwLCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZp
YSBCNCBSZWxheSB3cm90ZTogPiBBZGQgaHdmaWZvX3dhdGVybWFyay9taW4vbWF4L2VuYWJsZWQg
YnVmZmVyIGF0dHJpYnV0ZXMuID4gSGFyZHdhcmUgRklGTyBpcyBhbHdheXMgZW5hYmxlZCBhbmQg
dXNlZC4gLi7igIouID4gK2NvbnN0IHN0cnVjdCBpaW9fZGV2X2F0dHIgKmludl9pY200MjYwMF9i
dWZmZXJfYXR0cnNbXQo+WmpRY21RUllGcGZwdEJhbm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMg
RnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIKPlRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5
b3VyIG9yZ2FuaXphdGlvbi4KPgo+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+Cj5PbiBUdWUsIEp1
biAyMywgMjAyNiBhdCAxMjoxMDozOFBNICswMjAwLCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZp
YSBCNCBSZWxheSB3cm90ZToKPgo+PiBBZGQgaHdmaWZvX3dhdGVybWFyay9taW4vbWF4L2VuYWJs
ZWQgYnVmZmVyIGF0dHJpYnV0ZXMuCj4+IEhhcmR3YXJlIEZJRk8gaXMgYWx3YXlzIGVuYWJsZWQg
YW5kIHVzZWQuCj4KPi4uLgo+Cj4+ICtjb25zdCBzdHJ1Y3QgaWlvX2Rldl9hdHRyICppbnZfaWNt
NDI2MDBfYnVmZmVyX2F0dHJzW10gPSB7Cj4+ICsgICAgICZpaW9fZGV2X2F0dHJfaHdmaWZvX3dh
dGVybWFya19taW4sCj4+ICsgICAgICZpaW9fZGV2X2F0dHJfaHdmaWZvX3dhdGVybWFya19tYXgs
Cj4+ICsgICAgICZpaW9fZGV2X2F0dHJfaHdmaWZvX3dhdGVybWFyaywKPj4gKyAgICAgJmlpb19k
ZXZfYXR0cl9od2ZpZm9fZW5hYmxlZCwKPj4gKyAgICAgTlVMTCwKPgo+Tm8gdHJhaWxpbmcgY29t
bWEgaW4gdGVybWluYXRvciBlbnRyaWVzLgo+CgpIZWxsbyBBbmR5LAoKbm8gcHJvYmxlbSwgd2ls
bCBkbyBhIFYyIHdpdGggdGhlIGZpeC4KClRoYW5rcywKSkIKCj4+ICt9Owo+Cj4tLQo+V2l0aCBC
ZXN0IFJlZ2FyZHMsCj5BbmR5IFNoZXZjaGVua28KPgo=
