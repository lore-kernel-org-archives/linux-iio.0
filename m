Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500964;
	b=mP8lUYvY1QGI/7TjWw+43W5S3nuE0QMIVMZS1XcAtZssab9DoEjLdvCI71bsRFRYovuf
	 d2/suC72tUiaOy1zKJ+ZfBP9x4XtzjkIEinZq/j4tXt68LsnFbEsEGkIc0JPw/hy7JlmT
	 elWejiqCz4com2tBR/OulfQI3Hpz3jQnygEHY4tT92XA6Mz6ZP4AyIETk22u3ubSjJMXT
	 a6PwsxgUHAu9N60L0EXfCoWGDDIDtfqOHYf9YBRVN37ReWm/OhqNHevX31xX63jI3wDQS
	 eHBR8X45/TYH3rTr1VF7KFT8AhV+IvXGapHloqq93yVJDo/Wu4EeLdrf8Qu1uA9xX3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500964;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=a/DRuLhyQa2SB6HcgSl+ByrH3mVav+9XMdsW7LCtkHY=;
	b=4ik4kI9X5TbOlsyq5zmls3UX6iv4VC755Xxire+VNI94afPDjP9PIzEuDDTj5V1hvSOw
	 FP/HeoelUJN6wcG/O4Sb4HDhazdbnwX1Vf/vKQ5MSs+qCCXHsTEFFm8b/OhLnmRm1yBN6
	 MyQNnBZhH2yfBtlrRThG5LFEZ9vUzkL4j0QvOvwbFc3KDEK+M0PeuJOU3cmitZTadOlwe
	 22P5EWRyqppft7s8aB8q4rh4qehGHlr3LrwxB8bHhWFIygmEAGKXRnmVka+vup7lJZHJx
	 NHGN2FzBK5EJH6yPBnnNtv8fZM9/+7ZDRrpnKD9u977W/TgjkoGkuWwSP4koVNlSG9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tdk.com;
	spf=pass smtp.mailfrom=tdk.com;
	dkim=pass header.d=tdk.com header.i=@tdk.com header.a=rsa-sha256 header.s=selector1 header.b=GR3Ddr0U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.134
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77058606A319;
	Tue, 20 Oct 2026 12:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77058606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tdk.com header.i=@tdk.com header.a=rsa-sha256 header.s=selector1 header.b=GR3Ddr0U
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KChUwt3068572;
	Tue, 20 Oct 2026 12:55:56 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012043.outbound.protection.outlook.com [40.107.149.43])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4hdw50gs45-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 12:55:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbmGhRcVVz3f1lc/9m1C4BEj2Kk3y/9p63S1BVsOADyIv0o2gipEnFdFVrTWvZg7Q+9OIJvYjo8EWhUWtF64sp+W2yAUOgM/+budoRuD5M7jow1eaFNEXeCj9C9nKrA3nrwylDEfhOxAuX60C2mIQNVBfcZEFMJdZdmwNIdFoslyRub690A9pGSHwsitI8Nn9WuMnlJUR2kUbxFWr+OFty673L3LNyco9jAUlQ+iRzRX9vKFRGULFuQWCIn27gYl9mIl0n6TgelAdzL/4XslNTLej5pFacT0zfryjGvQjVO+44B+xF+2rhTK4M6Uxd6Dl+mvtcKEk2LcrftiJeU0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/DRuLhyQa2SB6HcgSl+ByrH3mVav+9XMdsW7LCtkHY=;
 b=a286gXRdOEVBRSh43dmx+D/pVdUHQcckJdf3ORXNLk1OQ2YNp1DA1DGpiX0y7ff8O3vKL0B9IourqZj3YwAzEIr30vWekwTugaMWqGNAvhfCn+aTCrtIGanzPp3kf50rrFbkTTKbpsCRImP/PSQ5paDR4kdPTsYT12qyljW+p8M3cCkI0rusKh5oSf6CX+GVD6omRWynbSP9eCsBP5U9z7TEqh3cBawRknMx0Am3MbCxByzGEyyQkA8ChPOhJ4Wud5xPTp5+AGDQpcUb+LXqyfApemHVwdAoW1R0X7a/lLuHYFIxcHLi0zvNvxJ5N8Ig2OnARoPF6jUkmVRFgNtECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/DRuLhyQa2SB6HcgSl+ByrH3mVav+9XMdsW7LCtkHY=;
 b=GR3Ddr0URDr6NZAciqJB0wtPJEZPYfwHi6KAXg+XYAa9WzCNTDOK4NMKfDW+v6xWzy0BX3NrhCMOmU4SH0EHDXD/Z/DTinlFmKl07Gf2XvvlmPDBMUM7aiHkjKk6MNQCb82//E8D1oBXQfiGXAnBtzji2qinAwndI9LSKE9evb7TnCqNARR0GFQPs4WUCLdg57L3617o2esbZtP1c3WQRlx1TFVxrglnQ0Ph/v0Gr3pv/2W4PHCzQje5Yp6261gAptsxwXqESPODY3wF1yZWfEOQZkSGTT9BXdLK3w8ITDc6JvivfWTsSDw2qITiJ95pJw2kZ6oNVzg9ucTL33vrkQ==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BE3P281MB5569.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 12:55:53 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 12:55:53 +0000
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
Subject: Re: [PATCH] iio: imu: inv_icm42600: update gyro start and stop delay
Thread-Topic: [PATCH] iio: imu: inv_icm42600: update gyro start and stop delay
Thread-Index: AQHdYG7/Bt+d/fxZakagq8umvgRGPbcGIB4AgAA3f3eAAAt25g==
Date: Tue, 20 Oct 2026 12:55:53 +0000
Message-ID:
 <BE1P281MB1426FBE0884F6FC89255B5A2CE672@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20261020-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v1-1-ed52290a4ca4@tdk.com>
 <atcsENHqXSRvn7SU@ashevche-desk.local>
 <BE1P281MB142605780E1D5B1B051ED4A3CE672@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <BE1P281MB142605780E1D5B1B051ED4A3CE672@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tdk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BE3P281MB5569:EE_
x-ms-office365-filtering-correlation-id: 8fa1547e-845f-4198-918f-08df2ea97972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|10070799003|19092799006|366016|3613699012|38070700021|56012099006|4143699003|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 Urkx0mT9tuJBkK9BiQB8W5G/Yo/R9XxkFUes4T78MDU+vTlvg3JHyse1HPzbJP1S/twZ+pF5RhRPcZD1cQFulZT3dW9aB7fnPVk9dSWZsPlp307Uolh2OrL+YQy6aFyJLD4het2I+esD/crSh94wX27uQcqgDAmYe9DRfErDYsfoieGDeB033DQfyJHnq/iB2cGaIrCGVasDQyzEBtm2pnPEB++t4esaPMrXQnddDCYp7sMBOsCpL2i3MdgY3+vlyDqqBkWbReVShaWOLiyxL8zOWdHK+q0tcYRFT0Thdx4wSsXWSHfDmoqrl97LaR0tXYPNCjTp+N/GXotBVeN6mY7xr/eMAE8N10wjjr/uG6KKB6xL3K96ujA7HqLon9/xvmSc3pv3MKODTNx2smblbiubLhjrjlnZzulkXaDgkIGXilbPD8/VF/AzftxSztzoDMeeGt9s0ZZFFpOVP06x/2EWVLzmwRQvBvRYDrCDY2jF5CKqSlz3rj5DzWMXHmwSk4AtOsuTYJJ1Qq4hlegIS5nP1r7DicUog4RKMpBFQffAtf9ewlYLY8xDbFN9xVdUs/yX+2ZhPseiabWtWfzkao3QUxfG+HxjGur7LSr3AncRUxHQC7w7QBmJnfYhmuCfGROfCV7Lo0MhKKMlKY2nF4+wAUMFU0Nhp17prHxEQaqUppd3iSfx8nRU2nOaOfR6jAeLvSkx+Q3jR7bBDsIPH9V93Ivn6xMJngPGevnoXaIhVppOTWxSThE+eSe7RsVI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(19092799006)(366016)(3613699012)(38070700021)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXlZY1locWVGZDBmQmViaUVUalNTUkpteS9ES05kQk1sV1R4K2JwN2lpZ1RG?=
 =?utf-8?B?RUFMVzJ5VThPSk1lSEpWU1FjK1d6UkZ5SHFvcnEyUVZmTkw1bm1kTmFkZldN?=
 =?utf-8?B?MkI4Y0VrOElYRXNIdnkycVM3MVhKOVoyQ1FudXR5MVRGblFEbXNYV3JEOFZo?=
 =?utf-8?B?RkNvcGhUTVpNdkVtYXowc05VcTBXQ0t5SUhIUnVYTE1vOTMwckpreGNoYUFN?=
 =?utf-8?B?aGRBZlcrMEVTWFgyNEUrR2h4RVBCOTV4N1ZScW5FN2N2R21XOUNHZmwyL2Ur?=
 =?utf-8?B?RHN5cENXa09jR0U1WTZUeXRKQysrUHNCeCtlZXpjTWZ5cTRpc3RlTnVmV01W?=
 =?utf-8?B?YktUQzRKYktmcGwrVzduR2hqRU1DYk5qTzdCZU1QcXl1dENpNmp5dUxLcmdL?=
 =?utf-8?B?NG0wVnRqVkFKamFNMTl0bkcxSkwyeXBtZ2htSzhsbzNsbjJubVlaV3JMV0Z0?=
 =?utf-8?B?aW9HS21JUENqbVMreXNHK2R4cTN0QzlTM0lZME1yMG94d3REUFdoOGRudlA5?=
 =?utf-8?B?TVJyRExDRko3K0dteS82a2FFeG1uVmxVOU03ZjI5ZUJJUEFZS1ZRM2lMalYx?=
 =?utf-8?B?eVd6STBhdUQwbzRIWlZlQ1o3ZTVGbjByN2Z6eklzR01Fb0NpM21YTFovLzZS?=
 =?utf-8?B?RStrd3pxVTFUZXMvQ0tRTTlzcWNtWDNYbjhSU1BKbGRNTzFnRStBUWdUTHNO?=
 =?utf-8?B?VGszbkFIa09NVi9Ra2R2L3V2RitZNy85SExEeTJqbXNtWmowZmVxb2ZFNDMv?=
 =?utf-8?B?WDdMNlpYQ1RrZ0J2RDl6ckY3YllkMkROd2EzVmFyOFpiYlUwNjJqZ2g2QVla?=
 =?utf-8?B?enovRllIakFRZnU1bVU1S29mRnE4QU1RU0JrZE1YYys2N21iakwydk03UWl2?=
 =?utf-8?B?aW5sU2EyQ1Y4Q0IwV0VTYUp1S1JVaHNyUDIwWlZ4OC8rMFdrUWxVREhqVm9B?=
 =?utf-8?B?QWpTN2lOeDNaWFY1RTRrN24xSVl1R0xuek9XTGFhNEJOYmVxbnNvdGc4WnZl?=
 =?utf-8?B?cEhKSEZsSDE4eXFEVGNhUWJZWG1DaktXdXZWaDZSWjlrTlpjNlVxZ2RKd1dS?=
 =?utf-8?B?TmdKMVFpcnd4OFZyVm5iRUFrYWE0RjlubTRjRzdTKy9wdkRheXk3U0xBcFVP?=
 =?utf-8?B?UzBQcC91Z0syb2UxNUtUSDROakg0OExjeEZ4MGNCOGRPbk1qM2F2NEd1SmR3?=
 =?utf-8?B?V3ZvUGdIRkRESW50QmRQQXBybkUrUnJQY3VQejNLcFdjN3FhZ244K05WTU90?=
 =?utf-8?B?RnFhMVhhMXpUTnhNRFJBYjRFZDJuM2wxc3hsaGpUMlpHWXo5cHplUWdhQTcz?=
 =?utf-8?B?V3UzUTBqYzJjU3JqSWVSZ3FCYUdtd2NrSUVYOHVnNEZQeXNEV2tkTFgwR0RD?=
 =?utf-8?B?bVFFL3JTTU95eE5WS2hiZkNkQTc5c09aSU0vYzZsRCs1aEdNWnQzN296UHlC?=
 =?utf-8?B?dnJXQTQzdGU5d3M0c2xldmRKU0lGTnZ4RTdtdG5EZ3VUbE5XV2txNFNTeG1p?=
 =?utf-8?B?UExMWHhvU0h1Y0ZGVDNDeCtKNndXODUycjlETGxBeGpxNExqcm5LdGdWNitM?=
 =?utf-8?B?NkVjREJXZk82WEQ3RC9selc3bExXbDVNNmQ4WXk1L0loVkRGR3d5cmNnQWFx?=
 =?utf-8?B?NERwZkdPSEVOcWRSOU5lWUxUc2IzUXBKNFhqeU8vS2dySlUyNGxtaG0ydHRJ?=
 =?utf-8?B?c2dXMVVrVFliSk1RY3AyV2ZLeFM4NGJsaXd2ZmIyK1M1ajNobHVMcmdtZGNC?=
 =?utf-8?B?SWlSZGJubGVKeHhZbktWbWV4UmRwUUt4UEphbGFyOXhRazZHRGhCVWkrZW1a?=
 =?utf-8?B?SG5RSWR0OXAra1F6ZTNZRUx0Y2ZseWN1NWdvd1pXUUpLQ3pLd0pUYWQxZGtC?=
 =?utf-8?B?ZGxzM0FveHVQWUw4RHhTcyswR2hBMndVSnpaVXJ2VjZsRTlvbkh4LzIvdXZL?=
 =?utf-8?B?WUJIT3VnNHd5c1ViYW1FSWIzL3VwWi9lZkFjL2Y0TXo2VmVPMVBOeWEzMEdi?=
 =?utf-8?B?VjRFTXoyeHdrdExkU0xqS2xMTDJ3bDJiWitGSVAzUGxKMSt6bmtyQWQvY2Nk?=
 =?utf-8?B?VmgyR1hMOWhoWDMrU0hTdFlCTWowSFp6SjJZZjJUTXBNUldsMHhhQ0s0emFa?=
 =?utf-8?B?UklNMWFIMU1uYzdFL1NRcUVOTWJ1TkxVR1FJdEROWE5lSGN3eitWZUZCZGlm?=
 =?utf-8?B?THJkdnB6KzFxMEVVTmF3am9OVzRUbWxYSmFQck5iVm5PV3RUK0Vza2xtdGhm?=
 =?utf-8?B?YittTEdQbkZlSGZ5VXlvTmNVVEwzMFFvb09KS0ZCcTY0bEhhQldjV2FQUk5w?=
 =?utf-8?B?TkhGMHdqVmxIMDA5V3pYMkRnVkVGcUMrMWJNQldTbGRDTnRYNTdqUGczcXVL?=
 =?utf-8?Q?WwSpHOeuStAkfn1+F5UGRidSMaoyyvusVa8ST+oN+iEHH?=
x-ms-exchange-antispam-messagedata-1: YrOPa1jD9QrR3A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ffVvzR9dIZVXt/Pba+XYUfZ9Pf6O8lYDpTCkVn5azeXb0K5CIgTlgN5rE9nXyKV1pVSLotgxzkMU8fk3UgVGRMNj6i/xpFPqQIadmwOYLssKfN9miDYnompLsRIzhqkBcL5dXakWSlro9iUlhSPQYjtmUeR7l5MiEoJtoxmWwuPQQBD8YnCH70HhzRk1D/jjsiQbCIt6pRH95oOQe1CVyBHwQ+EgYWWf9YT5aIPa5fUnqFncFF5mpj3vmyXYiPsz8pUz9Fn8pI1ki/FB/gZyHfgDH6E3QuFf+8YUJaiGg2dmKeqw4Wg9j5yovg96HJ9AKn1JIu9ygjxgKx6pmv373g==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa1547e-845f-4198-918f-08df2ea97972
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 12:55:53.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNMvP5ivos1QVRTNGRz4HVU/9LvcSTmzcJ8HFIbYfpf8pFAiOJU00GiACdKZjdgMDuJ6WBGVDBE+KNCiIgvVXHl/2zWeKw8Pbpyg4su6DTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB5569
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MSBTYWx0ZWRfX0IATl4/JXpLu
 Pafjct2tYvwrcvA5GOtRJY+CSPhX1Nl5POc9UkYLUUbLMOhbYvbeSKr7PgSJ44NH5DX6YMHXEnU
 uwR0yTyz2BHdZfTT280xBJx+FTfpART3L4apfduY0pq7/VPs+4mH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MSBTYWx0ZWRfX0v9D7mLV7w8I
 juILteUMxwrH/htb7vljzK16PuZz+dWsEXr4nOJLTNSQbK9gn5QaKeIB5W0GycGt4u+Ca9XefxF
 XM9ApNcqYCnZa9FhsXr0xPm8FUOc5LNKvTM+y+1ORAIwDy7pFs4DzFxQ0+rDkTIbDJDllUiUOdd
 BYSLSCKGBuVcQf4tYMGWaz5DA6s1LvcbWMEPEh48uR8Xh4Fq6xh77DFPnhVsLYGVSJqpifHvMAr
 EQSlHh0rqDZIKz1lKe782fclGC0eWsedb/bt3ugpn7Zk6sT5h2vfRASzYCICInSnv7PIRr7pg00
 bOywBa1lvL9U1BItoxZLllEDmN/VyH9F9rHGs7Lhwvul6I9DlvIT+VVMyBXTZEbwKxISr/2fUo0
 niO43UM7L80kT2ZRfAl1NO7NUfhuiKNc/0OQnaFxCpWZiDzhcVMYfEgIOUbNKEw7BT2S3YrIGti
 q7Nq06qXRYLpCZUSBig==
X-Proofpoint-GUID: IoqqkfURg0Hk75OX8mrbH6bC4HWGeq3y
X-Proofpoint-ORIG-GUID: IoqqkfURg0Hk75OX8mrbH6bC4HWGeq3y
X-Authority-Analysis: v=2.4 cv=Zb6IpcVA c=1 sm=1 tr=0 ts=6ad764dc cx=c_pps
 a=bAoKWJo6pcMwaXoz2TTY+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=In8RU02eAAAA:8
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=vQqfPHwuL9mr-qzPhpEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200051

Pgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+RnJvbTogSmVhbi1C
YXB0aXN0ZSBNYW5leXJvbCA8SmVhbi1CYXB0aXN0ZS5NYW5leXJvbEB0ZGsuY29tPgo+U2VudDog
VHVlc2RheSwgT2N0b2JlciAyMCwgMjAyNiAxNDo0MAo+VG86IEFuZHkgU2hldmNoZW5rbwo+Q2M6
IEpvbmF0aGFuIENhbWVyb247IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNoZXZjaGVu
a287IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcKPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzogaW11OiBpbnZfaWNtNDI2MDA6IHVwZGF0ZSBn
eXJvIHN0YXJ0IGFuZCBzdG9wIGRlbGF5Cj4KPj5fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fID5Gcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS7igIpzaGV2Y2hlbmtv
QOKAimludGVsLuKAimNvbT4gPlNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjAsIDIwMjYgMTA64oCK
NTMgPlRvOiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sID5DYzogSm9uYXRoYW4gQ2FtZXJvbjsgRGF2
aWQgTGVjaG5lcjsgTnVubyBTw6E7IEFuZHkgU2hldmNoZW5rbzsKPlpqUWNtUVJZRnBmcHRCYW5u
ZXJTdGFydAo+VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyCj5UaGlzIG1l
c3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uCj4KPlpqUWNtUVJZRnBm
cHRCYW5uZXJFbmQKPgo+Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Pj5Gcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4KPj5T
ZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIwLCAyMDI2IDEwOjUzCj4+VG86IEplYW4tQmFwdGlzdGUg
TWFuZXlyb2wKPj5DYzogSm9uYXRoYW4gQ2FtZXJvbjsgRGF2aWQgTGVjaG5lcjsgTnVubyBTw6E7
IEFuZHkgU2hldmNoZW5rbzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZwo+PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzogaW11OiBpbnZfaWNt
NDI2MDA6IHVwZGF0ZSBneXJvIHN0YXJ0IGFuZCBzdG9wIGRlbGF5Cj4+Cj4+T24gVHVlLCBPY3Qg
MjAsIDIwMjYgYXQgMTA64oCKNDI64oCKMzBBTSArMDIwMCwgSmVhbi1CYXB0aXN0ZSBNYW5leXJv
bCB2aWEgQjQgUmVsYXkgd3JvdGU6ID4gRm9sbG93aW5nIGRhdGFzaGVldCBneXJvc2NvcGUgc3Bl
Y2lmaWNhdGlvbnMsIHRoZSBtYXhpbXVtIHN0YXJ0IHRpbWUgV2hhdCBkYXRhc2hlZXQ/IFdoYXQg
c3BlY2lmaWNhdGlvbnM/IFBsZWFzZSwgYmUgbW9yZSBwcmVjaXNlIHRvIHJlZmVyIHRoZSBEYXRh
c2hlZXQKPj5aalFjbVFSWUZwZnB0QmFubmVyU3RhcnQKPj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBh
biBFeHRlcm5hbCBTZW5kZXIKPj5UaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBv
cmdhbml6YXRpb24uCj4+Cj4+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+Pgo+Pk9uIFR1ZSwgT2N0
IDIwLCAyMDI2IGF0IDEwOjQyOjMwQU0gKzAyMDAsIEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgdmlh
IEI0IFJlbGF5IHdyb3RlOgo+Pgo+Pj4gRm9sbG93aW5nIGRhdGFzaGVldCBneXJvc2NvcGUgc3Bl
Y2lmaWNhdGlvbnMsIHRoZSBtYXhpbXVtIHN0YXJ0IHRpbWUKPj4KPj5XaGF0IGRhdGFzaGVldD8g
V2hhdCBzcGVjaWZpY2F0aW9ucz8gUGxlYXNlLCBiZSBtb3JlIHByZWNpc2UgdG8gcmVmZXIgdGhl
Cj4+RGF0YXNoZWV0IG5hbWUsIHZlcnNpb24sIGNoYXB0ZXIsIHNlY3Rpb24sIGV0IGNldGVyYS4K
Pgo+SGVsbG8gQW5keSwKPgo+SSB3aWxsIGFkZCB0aGUgcmVmZXJlbmNlLgoKSGVsbG8gYWdhaW4s
CgppbiBmYWN0LCB0aGlzIG51bWJlciBpcyBub3QgYXZhaWxhYmxlIGluIHRoZSBwdWJsaWMgZGF0
YXNoZWV0LiBPbmx5IHRoZSBtZWFuCnZhbHVlIGlzIGFjY2Vzc2libGUuCgpTaG91bGQgSSBqdXN0
IG1vZGlmeSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gZGVsZXRlIGFueSByZWZlcmVuY2UgdG8gdGhl
IGRhdGFzaGVldD8KCj4KPj4KPj4+IGZvciBneXJvc2NvcGUgaXMgNDVtcy4gU3RvcCB0aW1lIGlz
IHJlcXVpcmVkIGZvciBsZXR0aW5nIGd5cm9zY29wZQo+Pj4gbWVjaGFuaWNhbCBzdHJ1Y3R1cmUg
c2V0dGxlIGRvd24gYmVmb3JlIGVuYWJsaW5nIGl0IGJhY2suIDUwbXMgaXMgYQo+Pj4gc3VmZmlj
aWVudCB2YWx1ZSBmb3IgdGhhdC4KPj4+Cj4+PiBVcGRhdGUgdmFsdWVzIHRvIHRoZXNlIG51bWJl
cnMuCj4+Cj4+RG8gd2UgbmVlZCBhIEZpeGVzIHRhZz8KPgo+SSBkb24ndCB0aGluayBzbywgc2lu
Y2UgaXQgaXMgbm90IGEgYnVnIGZpeCBidXQgYW4gZW5oYW5jZW1lbnQuIEl0IHdhcwo+d29ya2lu
ZyBjb3JyZWN0bHkgYmVmb3JlLCBldmVuIGlmIGl0IHdhcyB3YWl0aW5nIHRvbyBtdWNoIGZvciBu
b3RoaW5nLgo+Cj4+Cj4+LS0KPj5XaXRoIEJlc3QgUmVnYXJkcywKPj5BbmR5IFNoZXZjaGVua28K
Pj4KPgo+VGhhbmtzLAo+SkIKPgoKVGhhbmtzLApKQg==
