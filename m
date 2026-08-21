Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B93AFB11;
	Fri, 21 Aug 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317821; cv=fail; b=erTDAu5m7rqMAhudn2DG84v9dvpca2v+aod21nrCOSrYFuT2vv52Xf2daRQC1fctP0cjcHuYncEatEGvnt1HDmO4YPpCGDQWNvlZQ85KQOj21GYprPMuMKA4hP5hyRF/WzG/dUWwTmbC7tvB0zKQ2MaFbw2lwN1ZF/LGWPB5Kio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317821; c=relaxed/simple;
	bh=Ga15wgwiPMcEXUrvYlJtspkfsT8Yn8TCErkw6cszpxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gxr87vIoOVcSKimacoRZ9iX8BJAy6BAve97e9qvo8DvV5c/CCpon1aLzvdGLy/GpxIocyODc2NEHlgqdFlARLCsPvzMTxZeL9D1mkWeTyI5r4/eVMhhvZCp1YZ6WL6KAfZZh0F/q+lvsHa/+8223qBOWzVNbuSzXa89gzj5sw2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=T7tGrcay; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="T7tGrcay"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD9rST3668825;
	Fri, 21 Aug 2026 13:09:54 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010043.outbound.protection.outlook.com [52.101.169.43])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4g4ydytqck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 13:09:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INhC+Oy/He+i8h/1Ypmgtygv9nMUOtZjL4KX8XyC9ekm3+HD7xlRFKm3b7HUWf2epYK6VLo9MJIT/MHTfnKGgA7bPuG8OxhRjHlD9AxfuKuwkAx8oQ/eq81L/Xr2c33cJ7bfYPljJeeZSeVR4SDamVR4tBTFYfQ+Gm9lGFIh0geXICceHxakfTfobMhAY4Am4nPpj3GLKFYcfAjjxBDtkJz6GMu8HDtYtyNvT3LeAFCEsKk4e6KG5cd8NvY/OwoYg+BI7O8NhhGLf6l2fzKW+zKlytFQR+DHDg5JVtL7Mo2Cc9zB2qq/vGLpKutb/1IeKgrzAvKKESYkSgeT9BZApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga15wgwiPMcEXUrvYlJtspkfsT8Yn8TCErkw6cszpxg=;
 b=hH3aZ6Lk1+eF9eAoHeXSISm45wwq+LAferFZZllgeH9bFkmG1gYYHu+LDx71z4woytQX/gap79KQkWE8sPm1VvRBDpVQRwq8jby+4zo2Iv6lB43kusc23YQOQF8qojcMTO53spylP22hGF6NNZJr4q2PNU+N5Yktr9vVkKjmUs9+Ps7XNEvfIu3U0rbuk2G0B1ICU2RulW/ip7Fg+QG75snbqAfpoiwzvMnu7NESXmSKzxN1Q+k44cLyEEX9g89CqBUiSDuNkrMxQHhyeEDDPFxVQoQxiAcgoMcew1WooB8KcYFTrgD17nm0n60hNkkiaoPJXGFui/6Jqyo3OA9ySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga15wgwiPMcEXUrvYlJtspkfsT8Yn8TCErkw6cszpxg=;
 b=T7tGrcaydQ7qrMiA19gY1F+lvUzWQMDqcUeyCOQErBRhilo7WtxnQ26fpXJewyElLT6iJ/hGhYKfKch0u+97FHFbwIuRRF+MhoAZ20OcDxVXG+vapFrKhOR4FLlZ0LSu/9EJlw2EXULUkw7MqW28GorYeHfTtVbzd2Nt775uhw/yrbN1Mbyu5j+xceVoEoZSXUL2T7+iiUmAYfzsA1CRxlUEOVNcabjJdLUkCgwftXHkXlTD/ZJOEeSLfHZ3zFaUg8/gopO/o3zw81rOg5jiwjqnsbOJd61soddn3TUF5Rv46P2ZBsasOOF/9RYvVId0u/WPQHkASNo/35QpHBtmTg==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FRYP281MB2108.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:2f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 13:09:49 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 13:09:49 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: imu: inv_icm42600: do not read FIFO count for
 watermark it
Thread-Topic: [PATCH 4/4] iio: imu: inv_icm42600: do not read FIFO count for
 watermark it
Thread-Index: AQHdMNaCkEexMCTSAEOEgIeeK6ihOLanpjWAgADSjsw=
Date: Fri, 21 Aug 2026 13:09:49 +0000
Message-ID:
 <BE1P281MB14260708607A9D4819C4145FCEA32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
	<20260820-inv-icm42600-enhacements-v1-4-075a881db557@tdk.com>
 <20260821012809.169b0b8b@jic23-huawei>
In-Reply-To: <20260821012809.169b0b8b@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FRYP281MB2108:EE_
x-ms-office365-filtering-correlation-id: 4181d7c7-4aff-4190-1600-08deff857b19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|19092799006|23010399003|18002099003|22082099003|56012099006|4143699003|3613699012|38070700021|6133799003|10067099003|11063799006;
x-microsoft-antispam-message-info:
 wO9ufeqhdWmtv+Ks7OsD747Ycn29EdGhhEEKQt8wii25Ax/pOQY0NcwjrSDShSJzlREbXg0Lg50LvcrNnQRvSCnoXbX55yobj6nibTQv7VGwPkyfBXQYHl8evl2LA9LzCRXrFFkvo6m+Uj6i4gnSvLwwyNvOOKMVB8rPIyWRKRezZlVTNAejQa34SHyVNheu7VBwv+g61I9gVrUagFLpcG9Xsn3KR1x7Ih3OiG7Nne+z6vyoyg0EB17zgcZGfPbOLyIVLfiX5JVOXL51F4wfrY3lU7pYln6efYKcdqFy3KB7gKGuXM0Pf/gdBeDmrSPchR2bSTCxTi8nTAs/beyc5MWTjIv9+cWddDNJC13vsBUBvULERYy0UgbVEkdVT0ffjs/PCJG67cx7V4eCtEr3wF+Z0FNjpIYnQ7egGdqBO4tW9kHwVJnxNVh/t48nFGgliL6FuW6hz5MbtkIl2VO+0rC9eP73S+st0KF0YDNtAMIi0PDHMlyAsMJkuQx6RxEZAXLRpo9sULCvmZRmBLcgNawFOTJ9NZB1U53M1C9OvuczbHnWLLUgnJGGLZ9lx/GL8S8Sbc3DEdeaHS4D+Y2A0ms0Gm5OPYtsu2QKfOqVu7XG5E+27+EV7xjMUNdlFmV82PZCDf4EH315Yhe1m8NbGvTX/5Xe6a3c3UMbaoNGj6YofTS+Pi4SGyfsFkEN587KVwCDjG4P23coFr+UzVOPoeHlQrHBGGvr7WUbEFUPZ/QeXt4GKz7N70k0VnVRzovM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(3613699012)(38070700021)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3pyVmZxZUJHOWRMWW5DV2VyWE5JZ090WlU2T3NySEJPQlkreEN2R2lYNXNY?=
 =?utf-8?B?WXljN0RWVSsxc1FRdm40cTRLalRNeVZzcFJNdWhzRFc1VkFWT1JadnViL25v?=
 =?utf-8?B?TGVLN3JGSnZnNEhpYjRvWFEyRHlFY2NvT1pKVUQrMG00NzB2aGhlNXhrN2JT?=
 =?utf-8?B?SGdMYkhPRWZuZHNHcnNvVHRBS1JNM0RnT2ZtcHRETFNRbGMra0d5Y0d6ZFF4?=
 =?utf-8?B?NmRJZXZYbXplOTF5QjdsemNGekRkY1libXI5MmNzV1l0S0xYc2g1OTVSQXJG?=
 =?utf-8?B?ZklJWVpnRDdMNDBkbFRKZGNnNUNqY1VFSzlQVGUvNlJQdnJFcDQ5U0Yzc0g4?=
 =?utf-8?B?cXZaaXFVMnZETk5QOTM5WnI4TmJBMGZOYzVRQ1NvT1VPV25pNlY5YTdRRmhX?=
 =?utf-8?B?RHpXQnpZWS9lSVQ3amZIQUZzTHdZOVBtRVlOT1VzaHBFYURGd2p3NHYremE5?=
 =?utf-8?B?ajFhMWk3UXNMSWNGOVY5b3NQU0NGbStNYnRhUFEwdHFaN2x1ZzJFbFF4endz?=
 =?utf-8?B?TDQyWlZhNTZLa0JjSXVZRGhsL2RzSzBNb1pqalhDSEk4NnhJdmJKSElvUWNs?=
 =?utf-8?B?VVk5eStaZHVIL2ZiSVJEejZ3OStPVU5DTFppVTRmeHpnemJJUk1KaTFQRUdP?=
 =?utf-8?B?RWNKN0RCWktHRXFiMTdJdlE3TWtNMjJqSjJ5dTdjaWhvblpEYk5lYTllVzNB?=
 =?utf-8?B?T0ZraTIyRWV1Z0dwWjJiY3BKR2s5Nk5wQkhjLzdKSDFXWkRESGZPRWdDZk1n?=
 =?utf-8?B?OTlqNVFwb3pCeHV1VGQxV0I5ZVJtSE0zeUlQcDUxQnZ6dmxBT3B1c0MxckYw?=
 =?utf-8?B?RUtzb1EyUFY0VjRGZDlOQzltSmpFRkNZVnJqQ0VubUJFbkZuUCtKYkZVTm1U?=
 =?utf-8?B?SUoxNjRDeFMwOGhHdWZNdHBMTHhxSzBoSkJyZ3hJRlNPVVJKRGVYQUIwWVdK?=
 =?utf-8?B?SlNUa2NmUU8vT2FSYkpUb1FYNVBaZjhteWNnWjczZFZrN1g2b21FbHpQQzV1?=
 =?utf-8?B?K3FwL0tLbzdGM2hJb2ZLdTdOOGo2c1RBdmM1WHlBaWhocXN1R281RU5YM2VT?=
 =?utf-8?B?Q0U4SU9GdisrcmhxRDc0aEJZY3BMU2JBdjRJSnZUekN1bnE5cXh0QUlBNmJT?=
 =?utf-8?B?OGpMbEVYZWdtYTFqTi9LalM2S09PVE40a3VkNkdMMHVIMGpOdGpIUWZmNitE?=
 =?utf-8?B?Q3hTcTREMjNpV3VNdmJBYmlNYld0WDhSMUl3bXFnTEpvc2IrbnUxYk1xNEFt?=
 =?utf-8?B?eUNXc2RFTzdTbjVsVFZoWkt6QnhJRlZKd3BJclVnZk5xYkU1dHRkenpuWUtK?=
 =?utf-8?B?UTQvY1hsa3U1NFF3d2pqaUJKaUt3RTZNWW82TzBvNTlsTnJRWkRES2MveFp1?=
 =?utf-8?B?cE14YkI5a2RGQ3RQTGtncjE5aS9ud3A0bExGNmkwMkwxcHdnZFBIR3NFaEwv?=
 =?utf-8?B?blh6MGt2YVpwaXlHVkNvUWNLd1BTelhhTWNFTDIrRk5tV2t4VjlXM0lORnhO?=
 =?utf-8?B?Tk5yWGZ2UEozcWZVTko1eVpvT2VZcXNneW8rMDliQVl4ZThnN0U2c0xuUlJW?=
 =?utf-8?B?THhCcE1GR2ZVdjdaRlVrcGtqNTVoVUFWUmtNMVpXVkJHVGdma3V3TE9yU1pr?=
 =?utf-8?B?WXExbGd1SXg0VUpXRGhkeVAzT3hLd0pIK2dSM1ZDb0dabTlBblZNM09jZTdq?=
 =?utf-8?B?Rm9IUDR0Q1pTTlRGSHl3UG5xNkNBbStuZmtDc2UwUzE2V1E1S3JvUGNDZDgr?=
 =?utf-8?B?STkzSTB2WmV3L3dSVkxMNWwvckNhdzUxem5Jb09NYlJ1VlBtRFJzMGhRMFRt?=
 =?utf-8?B?elNGeVdETUZOM0dSL2pMT3NjQmVjaWtpQjdrenNSRmZNVnF5MnJSSFlFQ2tH?=
 =?utf-8?B?WkVMR09Gc1dsVjFBOVJKYzhvZW9YMGk0MVdvQjdHTS9sZUtaS3VBZXlOSnVQ?=
 =?utf-8?B?aXJ6VXhXMnJOaUYwWVF2eS9kSHdEUmhXTU0vcjNCUmVnVVlrdlp1T1Flc0p5?=
 =?utf-8?B?czEvRjk2QWdRbng4N2E1V2hiZVBrbU9IUytZUkp5MDFsME9CNXMzbHQ0WjNJ?=
 =?utf-8?B?aEpzSXJ4dXRlcjBhVjc5SDdIdFQzNHRmYUxnOUhha0swdnlUeXUxTGJkcnJa?=
 =?utf-8?B?Z1lyVEY2QllQcUNETHpxS1RHR0hyVURmK3pOK3B5WWNwMlhXVm5kVFJYM3JQ?=
 =?utf-8?B?WEhMMmRCL2p1REcxK2ExMkZ1S3VzamdhYlNZL0ZGUzFMNkNOaDk0a2tLU0h3?=
 =?utf-8?B?NDBBUlQ5aEdTQkdORmZ3bFVGKzRESE1JbmxLM1NaMUFjNGNKOVFPZi9lb2RD?=
 =?utf-8?B?V2ViTDB2c0s0a1VQVG9PQ281YjRTS1hvRUluL3R3aDJIWkZFVVNmRlMyOWRP?=
 =?utf-8?Q?m+2XfxBPv3HHC8jZRiffh0pCx4ZPi4RgBJQn/5plYnY43?=
x-ms-exchange-antispam-messagedata-1: 2ZAAfSldUfGBIQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	zEJ49IQSjWjF2DNB/G0ySLvs9UIM4rwI2PxqLHNUkY/JMVvAj7JAhczwkv9j66jIdVN7RM06G0x6/+j2qQ2mlHCMpdwh0l9ybDi/S4s73xQOjEb5ECmLMBZaAl9uxUuU7sywPT3cuwzFsYtkU1PyypJHGeTrT98xW6pPyEjAji/2FFey6HfXnF+7xt/KDpd9AuOJf1kVW/tu8ubSD0LXq52PXykNoY9fQH5AQj/bWw9iA7yKOMoYYP7Wgyq6wwFRR+PdTYH1b09sY1yKwAd4gIkScwyMofzg5TCjYkKCOdwjkeH3dGwIZaCtVIrqc3j1g86ytMc/htAGP5yizheExg==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4181d7c7-4aff-4190-1600-08deff857b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 13:09:49.3796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhMYUm9CIfUXN9fj2IA3w6CLM3qW+wZ7MoI+bIzMoGxGV662QKM8CCl929Jrvd55y/HndYStUCIK0ZiE1sUd6PbI6xIh2DNwFkt3kxKM5Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2108
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwMSBTYWx0ZWRfXwrM5vjvFFMRZ
 jrhOkKyO5mtphB8e90qDIepE/oOJnida9OdOhwdYuG7pbQyIR4pm8QVzzrgzg0AimKxr7/BSsiA
 5n/wk1fHMpAXmSbYprYduaZr+o7Y4czE+jpDFBsWNw6uHNCwEPqh
X-Proofpoint-GUID: FOJa4q-cKSd-qA0kEeQhFUIEgjIV9dqs
X-Proofpoint-ORIG-GUID: FOJa4q-cKSd-qA0kEeQhFUIEgjIV9dqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwMSBTYWx0ZWRfX9W00nQY1ItVE
 roKrrPRpPQRBCDoyC/MpoQnt8gNRgOsTL2gYW+OPpq2phMAmlLwKzvUZAHAPx1AVGq+YC0DT+iq
 OgeIkRo2jfdEE+q3CKYfbtr1RSnEbaGLh5Geddm2kGNsjz53/jypSOeR0PLY0yZGk9cbg9p/pZu
 26V3QmdUx/7W0/4pOakwbTVZA+dgUKmXl6ND3NgqfkONOnro12/WdezI5ZW03BHWKAdiO2ZS3WZ
 DJP9tgtA5OaK7hYWTVVN86SKIDV5p3byx6DcMoVo9fTwbkozB/t8c1JvhPvWkbFt4eK+GKsdUtm
 oLOK39aBH1o/6ia5Eivp2PnyLKFhFjQgla8Ttci8FRDoQGTY1wuiSDUVZ3rD/+oVs/NI76xj2qz
 teTgkJ43B8SaMMC5GU/IwmHBtQAgGh87buiKza3mccNxYw7Is7XVuiuOQCnxnJ/hlcR4275sauL
 0O8vIsZKxWev5cK0FEw==
X-Authority-Analysis: v=2.4 cv=PqyjqQM3 c=1 sm=1 tr=0 ts=6a884e22 cx=c_pps
 a=4u/Fg1Nm7Xjk9ljLFvEY5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=VwQbUJbxAAAA:8
 a=In8RU02eAAAA:8 a=VsiJv9fCcHlxMhSKlfAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210101

Pgo+Cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5Gcm9tOiBKb25h
dGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPgo+U2VudDogRnJpZGF5LCBBdWd1c3QgMjEs
IDIwMjYgMDI6MjgKPlRvOiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheQo+Q2M6
IEplYW4tQmFwdGlzdGUgTWFuZXlyb2w7IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNo
ZXZjaGVua287IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wKPlN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80
XSBpaW86IGltdTogaW52X2ljbTQyNjAwOiBkbyBub3QgcmVhZCBGSUZPIGNvdW50IGZvciB3YXRl
cm1hcmsgaXQKPgo+T24gVGh1LCAyMCBBdWcgMjAyNiAyMTrigIowMjrigIo0MCArMDIwMCBKZWFu
LUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSA8ZGV2bnVsbCtqZWFuLWJhcHRpc3RlLuKA
im1hbmV5cm9sLuKAinRkay7igIpjb21A4oCKa2VybmVsLuKAim9yZz4gd3JvdGU6ID4gRnJvbTog
SmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS7igIptYW5leXJvbEDigIp0ZGsu
4oCKY29tPiA+ID4gT3B0aW1pemUgZGF0YSByZWFkaW5nCj5aalFjbVFSWUZwZnB0QmFubmVyU3Rh
cnQKPlRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcgo+VGhpcyBtZXNzYWdl
IGNhbWUgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLgo+Cj5aalFjbVFSWUZwZnB0QmFu
bmVyRW5kCj4KPk9uIFRodSwgMjAgQXVnIDIwMjYgMjE6MDI6NDAgKzAyMDAKPkplYW4tQmFwdGlz
dGUgTWFuZXlyb2wgdmlhIEI0IFJlbGF5IDxkZXZudWxsK2plYW4tYmFwdGlzdGUubWFuZXlyb2wu
dGRrLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPgo+PiBGcm9tOiBKZWFuLUJhcHRpc3RlIE1hbmV5
cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+Cj4+Cj4+IE9wdGltaXplIGRhdGEg
cmVhZGluZyBmb3IgaGlnaCBmcmVxdWVuY2llcyBieSBub3QgcmVhZGluZyBGSUZPCj4+IGNvdW50
IGluIGNhc2Ugb2Ygd2F0ZXJtYXJrIGludGVycnVwdC4gV2UgYWxyZWFkeSBrbm93IHRoZXJlIGlz
Cj4+IHdhdGVybWFyayBzYW1wbGVzIGluIHRoZSBGSUZPIGFuZCB3ZSBuZWVkIHRvIG5vdCByZWFk
IG1vcmUgdGhhbgo+PiB3YXRlcm1hcmsgc2FtcGxlcyBmb3IgdGltZXN0YW1waW5nIG1lY2hhbmlz
bS4gTGV0J3MganVzdCByZWFkIEZJRk8KPj4gZGF0YSBkaXJlY3RseSB3aXRob3V0IHJlYWRpbmcg
RklGTyBjb3VudCBpbiB0aGlzIGNhc2UuCj4KPkp1c3QgdG8gY2hlY2sKPgo+TGV2ZWwgaW50ZXJy
dXB0PyAgT3Igb25lIHRoYXQgd2lsbCBkZWZpbml0ZWx5IGdldCB0cmlnZ2VyZWQgYWdhaW4/Cj4K
PlRoZSB0aGlua2luZyBvbiByZWFkaW5nIGFzIG11Y2ggYXMgcG9zc2libGUgaXMgdGhhdCBmb3Ig
c29tZSBkZXZpY2VzCj53ZSBuZWVkIHRvIGJlIHZlcnkgc3VyZSB3ZSBkcmFpbmVkIHRoZW0gcGFz
dCB0aGUgdGhyZXNob2xkIG9yIHdlCj5kb24ndCBnZXQgYSBmcmVzaCBpbnRlcnJ1cHQuICBTbyBp
ZiB0aGUgdGhyZXNob2xkIGlzIHNldCBsb3cgKHNheSAxKQo+aXQgY291bGQgZWFzaWx5IHJlYWNo
IDIgYmVmb3JlIHdlIGdldCB0byBoYW5kbGluZyB0aGUgaW50ZXJydXB0Lgo+UmFjZXMgYXJlIG5h
c3R5IGFueXdheSB3aXRoIHRob3NlIGRldmljZXMgYW55d2F5IGJ1dCByZWFkaW5nIGFzCj5tdWNo
IGFzIHBvc3NpYmxlIGhlbHBlZC4KPgo+RG8geW91IGhhdmUgZGF0YSBvbiBpdCBiZWluZyB3b3J0
aCBza2lwcGluZyB0aGUgcmVhZD8gSWYgd2UgYXJlCj5hdCBoaWdoIGZyZXF1ZW5jaWVzIEknZCBh
c3N1bWUgaXQgaXMgbW9yZSB1c2VmdWwgdG8gcmVhZCBtb3JlIHRoYW4KPnRoZSBtaW5pbXVtIGp1
c3QgdG8gcmVkdWNlIGhvdyBvZnRlbiB3ZSByZWFkIHRoZSBmaWZvIGF0IGFsbC4KPgo+Sm9uYXRo
YW4KCkhlbGxvIEpvbmF0aGFuLAoKYmVjYXVzZSBvZiBvdXIgc3BlY2lmaWMgdGltZXN0YW1wIG1l
Y2hhbmlzbSwgd2UgY2Fubm90IHJlYWQgYXMgbXVjaCBhcyB3ZSBjYW4uCkl0IHdhcyBhbHJlYWR5
IHRoZSBjYXNlIGJlZm9yZSB0aGlzIHBhdGNoOyB3ZSB3ZXJlIGxpbWl0aW5nIEZJRk8gcmVhZCB0
byB3YXRlcm1hcmsuCkl0IGlzIHJlcXVpcmVkIHRvIHByZXNlcnZlIHRoZSB0aW1pbmcgYmV0d2Vl
biB0aGUgd2F0ZXJtYXJrIGludGVycnVwdHMgdGhhdAp3ZSBhcmUgdXNpbmcgdG8gY29tcHV0ZSB0
aW1lIGVsYXBzZWQgaW4gdGhlIGNoaXAgZnJhbWUuCgpIZXJlIGl0IGlzIG9ubHkgYW4gb3B0aW1p
emF0aW9uIHRvIGF2b2lkIHJlYWRpbmcgdGhlIEZJRk8gY291bnQgcmVnaXN0ZXIuCkJlY2F1c2Ug
d2Uga25vdyB3ZSBoYXZlIGF0IGxlYXN0IHdhdGVybWFyayBkYXRhIHNpbmNlIHRoZSBpbnRlcnJ1
cHQgb2NjdXJyZWQsCmFuZCB3ZSBjYW5ub3QgcmVhZCBtb3JlIG90aGVyd2lzZSB3ZSB3b3VsZCBi
cmVhayB0aGUgdGltaW5nIGJldHdlZW4gMiBpbnRlcnJ1cHRzLgoKV2l0aCB0aGlzIG9wdGltaXph
dGlvbiwgSSdtIGFibGUgZm9yIGV4YW1wbGUgdG8gc3RyZWFtIGRhdGEgYXQgMWtIeiB1c2luZyBJ
MkMuIE90aGVyd2lzZQppdCBpcyBub3QgcG9zc2libGUgb24gbXkgdGVzdCBwbGF0Zm9ybS4KCkhv
cGUgSSdtIGNsZWFyIGVub3VnaCBoZXJlLgoKVGhhbmtzLApKQgoKPgo+Cj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRr
LmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYw
MF9idWZmZXIuYyB8IDMzICsrKysrKysrKystLS0tLS0tLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2J1ZmZlci5jIGIvZHJpdmVy
cy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYnVmZmVyLmMKPj4gaW5kZXggMTQy
OGYxODQwOGNlLi4xNDEwMDk2ZjZlNmQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9p
bnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2J1ZmZlci5jCj4+ICsrKyBiL2RyaXZlcnMvaWlvL2lt
dS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2J1ZmZlci5jCj4+IEBAIC00NzQsMjQgKzQ3NCwy
MSBAQCBpbnQgaW52X2ljbTQyNjAwX2J1ZmZlcl9maWZvX3JlYWQoc3RydWN0IGludl9pY200MjYw
MF9zdGF0ZSAqc3QsCj4+ICAgICAgIHN0LT5maWZvLm5iLmFjY2VsID0gMDsKPj4gICAgICAgc3Qt
PmZpZm8ubmIudG90YWwgPSAwOwo+Pgo+PiAtICAgICAvKiBjb21wdXRlIG1heGltdW0gRklGTyBy
ZWFkIHNpemUgKHdhdGVybWFyayBmb3IgbWF4ID0gMCBpbnRlcnJ1cHQgY2FzZSkgKi8KPj4gLSAg
ICAgaWYgKG1heCA9PSAwKQo+PiAtICAgICAgICAgICAgIG1heCA9IHN0LT5maWZvLndhdGVybWFy
ay52YWx1ZTsKPj4gLSAgICAgbWF4X2NvdW50ID0gbWF4ICogSU5WX0lDTTQyNjAwX0ZJRk9fMlNF
TlNPUlNfUEFDS0VUX1NJWkU7Cj4+IC0KPj4gLSAgICAgLyogcmVhZCBGSUZPIGNvdW50IHZhbHVl
ICovCj4+IC0gICAgIHJhd19maWZvX2NvdW50ID0gKF9fYmUxNiAqKXN0LT5idWZmZXI7Cj4+IC0g
ICAgIHJldCA9IHJlZ21hcF9idWxrX3JlYWQoc3QtPm1hcCwgSU5WX0lDTTQyNjAwX1JFR19GSUZP
X0NPVU5ULAo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhd19maWZvX2NvdW50LCBz
aXplb2YoKnJhd19maWZvX2NvdW50KSk7Cj4+IC0gICAgIGlmIChyZXQpCj4+IC0gICAgICAgICAg
ICAgcmV0dXJuIHJldDsKPj4gLSAgICAgc3QtPmZpZm8uY291bnQgPSBiZTE2X3RvX2NwdXAocmF3
X2ZpZm9fY291bnQpOwo+PiAtCj4+IC0gICAgIC8qIGNoZWNrIGFuZCBjbGFtcCBGSUZPIGNvdW50
IHZhbHVlICovCj4+IC0gICAgIGlmIChzdC0+Zmlmby5jb3VudCA9PSAwKQo+PiAtICAgICAgICAg
ICAgIHJldHVybiAwOwo+PiAtICAgICBpZiAoc3QtPmZpZm8uY291bnQgPiBtYXhfY291bnQpCj4+
IC0gICAgICAgICAgICAgc3QtPmZpZm8uY291bnQgPSBtYXhfY291bnQ7Cj4+ICsgICAgIC8qIHJl
YWQgd2F0ZXJtYXJrIHNhbXBsZXMgZm9yIGludGVycnVwdCBjYXNlIChtYXggPSAwKSBvciByZWFk
IEZJRk8gY291bnQgKi8KPj4gKyAgICAgaWYgKG1heCA9PSAwKSB7Cj4+ICsgICAgICAgICAgICAg
c3QtPmZpZm8uY291bnQgPSBzdC0+Zmlmby53YXRlcm1hcmsudmFsdWUgKgo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgSU5WX0lDTTQyNjAwX0ZJRk9fMlNFTlNPUlNfUEFDS0VUX1NJ
WkU7Cj4+ICsgICAgIH0gZWxzZSB7Cj4+ICsgICAgICAgICAgICAgcmF3X2ZpZm9fY291bnQgPSAo
X19iZTE2ICopc3QtPmJ1ZmZlcjsKPj4gKyAgICAgICAgICAgICByZXQgPSByZWdtYXBfYnVsa19y
ZWFkKHN0LT5tYXAsIElOVl9JQ000MjYwMF9SRUdfRklGT19DT1VOVCwKPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByYXdfZmlmb19jb3VudCwgc2l6ZW9mKCpyYXdfZmlm
b19jb3VudCkpOwo+PiArICAgICAgICAgICAgIGlmIChyZXQpCj4+ICsgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Owo+PiArICAgICAgICAgICAgIG1heF9jb3VudCA9IG1heCAqIElOVl9J
Q000MjYwMF9GSUZPXzJTRU5TT1JTX1BBQ0tFVF9TSVpFOwo+PiArICAgICAgICAgICAgIHN0LT5m
aWZvLmNvdW50ID0gbWluKGJlMTZfdG9fY3B1cChyYXdfZmlmb19jb3VudCksIG1heF9jb3VudCk7
Cj4+ICsgICAgICAgICAgICAgaWYgKHN0LT5maWZvLmNvdW50ID09IDApCj4+ICsgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gMDsKPj4gKyAgICAgfQo+Pgo+PiAgICAgICAvKiByZWFkIGFsbCBG
SUZPIGRhdGEgaW4gaW50ZXJuYWwgYnVmZmVyICovCj4+ICAgICAgIHJldCA9IHJlZ21hcF9ub2lu
Y19yZWFkKHN0LT5tYXAsIElOVl9JQ000MjYwMF9SRUdfRklGT19EQVRBLAo+Pgo+
