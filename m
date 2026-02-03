Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056E3ACF19;
	Tue,  3 Feb 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133400; cv=fail; b=uk8se6aSQgvjoB/W1DicDAYkmooRKigL37tSULQUo+wU65OtIRqAUK6Ej87Tn/4hIl1ChO9ExL37MQv2pg+yCKaGmt6lfrzysihRt09Xtk+s8ZAx/a/5rmX/h/ze3RATnmPFS8mCH4tOsFzaTtRs2Rq6yXxeD5QlJX6lvV85Ct8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133400; c=relaxed/simple;
	bh=7xNQBHFvmJmSh+SbRzBJiMSDKQysZoV2uAg0m6z1pyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Na7luUhcIMGmltCY7n0h6ilOwg7XnqpozJKP5yyFQDfkWqZ6cEXIWG4QD2G8hDok9TTV/GWpyRTvBbm7O7zcSXvTSfGaUumMGotKRk2rBNgM5ECi0OaFwXtIntuGWy3B16V0S5Fm6QOjSANtIdbi6ab08rKPyO08/+Ju7WE+Ju8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v+ccL0dy; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v+ccL0dy"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613E4Ows3228941;
	Tue, 3 Feb 2026 10:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7xNQB
	HFvmJmSh+SbRzBJiMSDKQysZoV2uAg0m6z1pyY=; b=v+ccL0dyPKmz37F4ZkVJW
	DTl7j5+DQzqK95cNY5h7vDJol0NGRRN8WtODb0NHdfpEUhnqpGmjO36PeGH38kJP
	NmzxDXHrzsCJnE+sDd3jOx82TeulkESGi/gf49Q+2Zw2iu+vDP07f1DxN7csm+8b
	8hdcyYf2TUPwwq5rAGuZPX1B82tKe+Kv2g5XcNVcTptQLjRmRFAWzET5k34aoIZV
	Ejl5GDcejiwT07UcdSx40hl/2UW9lswxCK2ZSJLflUxvZA4yXtuUSOLlacsUOAl5
	FCPgOTcr3jBDjkE34HLlnnadJfpN/quHaub53OwnD0MG0dssVh+3+pqRJiyBAY2o
	A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c3cv51ff1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 10:42:59 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSMWIn2dUJo0ZGoycB0pId52kwsTAD02E+JracSW7KR8Tqj2z8sfqP1oCHqpcMmN/b9AMgpqNrPnPCOvHZhxFi6VMd0BvXsar8oUpUfRGoXDOvoQWsIZE3HHO2apgUaS3nC0Q6fswyBNS2u9X+TbcLsZ6MKlpkz4IqdSg2ShnzCJMWcaIppRg8EhfVbibuZ56qzKcoPbCsjliFgAS4a+Qbx2k3tEJ0pPleRUw8tB1zrAvmsfp4dJqAwbMOKREgu3n8VON/7hPXkakm6MBCzroFU9Trrs3Gw1cun3+TUOHn8/uE5ku6KZNP+F0Foo3Dq6GvvRD0T7dDf9Z78nEXhNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xNQBHFvmJmSh+SbRzBJiMSDKQysZoV2uAg0m6z1pyY=;
 b=RFGEVkBvSYu3z/t/RsX61i42a7uESbnywClSYmekglgzAIuvDxxInF7EUv6+UiEEqnR9YooZYnP7xbSHyjGO06AGVOvr2/RQim67wpeHDKMk5BFCLQLsv1KXIGRNvmFZSHwVLSY8p2bl5q8NUqug07n5JB0XfdTke6GlZb81E3GL3SJhJYqjcbmcfgZAEy+ti/hHlxviH5F7tStowb4INA9ldf5tS+bCRXSrhUlkMc5UCx5M5pIx+EqGwXq4lIYkEB/Iew8uAGvEj4YKP/SW+iS7u4sHHFgCaWp5K6TCJlPX/C8dDg1xLV6yeuSLHxrHPQo9B+/yiKFfTFjtu//9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:42:55 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Tue, 3 Feb 2026
 15:42:55 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4880 support
Thread-Topic: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4880 support
Thread-Index: AQHckTPXVtsi9x5yvE2bCRqO7TO7aLVpU/OAgAfQNMA=
Date: Tue, 3 Feb 2026 15:42:55 +0000
Message-ID:
 <CY4PR03MB3399D81C92B07FEC8EFA09B19B9BA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260129152731.154368-1-antoniu.miclaus@analog.com>
 <20260129152731.154368-2-antoniu.miclaus@analog.com>
 <5d2e85cd-caa2-43a6-a451-3b822bd0ef01@baylibre.com>
In-Reply-To: <5d2e85cd-caa2-43a6-a451-3b822bd0ef01@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|IA3PR03MB8021:EE_
x-ms-office365-filtering-correlation-id: 583ac18b-8559-475e-8acf-08de633ae664
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFRoMHh5WFk0bGR4NEFiVWRGTThQUEtmMHRMT1NjYStISUw5Y2FGclVJeVlq?=
 =?utf-8?B?VGJLbmo3R3NhU3p0RHFOUitPNHRTRU5PSmVqMitTenFIRFdoVVdvTk4vbnRh?=
 =?utf-8?B?RFYrSGJmVWtMZ1g4eUM0Y0cwaXBoQTE1OWJ2MVBYZ1BadDI2UUFPZWxRKzdR?=
 =?utf-8?B?eVRBUGlXZXQydHFEU2NXaUhuZFNOSmMrbmhZT2tPYmlwOWU1U003SGlPOUlY?=
 =?utf-8?B?SStsYSt5SkFJQkJrV2xNcEN6Zy9XVFRkcXZIcE1Wb25pRld4UTBVdVMxM0pn?=
 =?utf-8?B?TXI2ZGRDMVBNUmtsVWgrRm96eDE3a0hHTUhReWN4R1BUOFlrNFd4anhIZ0xm?=
 =?utf-8?B?RE9LQ3A5QjNKWVBySkM1b3Nlay9tRWVQZWdENkxEZWpPN0s5T0VGdFF3WXV4?=
 =?utf-8?B?UldtcFhuWlRqSU5uclNvZk5vazExVmdEaHB4cmtUbElHRFhHNmlZTDhoaWJs?=
 =?utf-8?B?dDgwdUdwaFlhdUxYZStMY0lJYm4vR0EwUndFSUVZbHRsRWNuVXVlVythNnhu?=
 =?utf-8?B?T0thOTFEUDlvU3NOV3JaUXgrb2t4dVQ3RWpzbmdqa1hzMi94b3Vud1dHVFRE?=
 =?utf-8?B?ZzE2M1FkdmpoS2I2dER6Z2NweVNHWjRpS0xUVEJ5c1BWSllRN0tNTmdhU1N4?=
 =?utf-8?B?ZzRlQkQyaGpLNE1vcDgwZEd3alU5ZVNydFpZdFBiTE5IOS9UbDVzc3VEeTNU?=
 =?utf-8?B?Qmd1Sy9mR0R2MjNac3d0TXdHZHJFc3RNVldqTUk4MC8vU1M3eUN5THdORlpp?=
 =?utf-8?B?Vms1blFTVmp5enRqLzBnNEJSUzBlOUZObWlmU21Id0pMZFRhS1Y3MzAvSll4?=
 =?utf-8?B?QmxNbXRsYjRCSjdsVDdBUUpqc1lFUFRacHZzZjBmQTJaN3BiSmp0TTR3dFI2?=
 =?utf-8?B?SG9OeXhOTTBNRDRiQVFxUkJFaVJEdmw1SkhPQVdmcHFyS2lzNkVJWlRFWThS?=
 =?utf-8?B?VVVCV0gwUjh6SkNZMk5EZ3dIMDE2amQ3b1VHUHgycnIyeXhSbTBSTGpLT2Iy?=
 =?utf-8?B?aEY1WjdrOWoyanZINUlucWZTRjNURHhRczBnU1pwU1VUZDRKamVtbEZLUGxH?=
 =?utf-8?B?QytQcGc0VFIvUm5rUE5aOWlNVFRuaHZVZmZKNWRndzdlK1RYVmdkbjlINjgv?=
 =?utf-8?B?eDIrcHJZcXFtTXdNcWlFQlBYNHc0RDlsSzA5WUhIQ2J5WjVsT01CeEtCcGxp?=
 =?utf-8?B?QWNRYkkxc2hlSDVET3JFQStQa2NWVStENFdnL3VDcWZJYlZGYThrdjluZDVW?=
 =?utf-8?B?YWl4dDMxdlFtWndOdHRwRXRiRkJ5V2l3OFUwU3YxWENvL3RvZFc0eTZtdm03?=
 =?utf-8?B?SEZHSWlNa01UMnBNTGNjcGZ2T3RNSWdBUG9DQURudGxHWURGSFpyOTR1M2k4?=
 =?utf-8?B?WTEwK0FJdGpjMXJoUnVSd09uR2t6WDBnWVJiWkIreFl4Z201MVhoM0tiM1Fj?=
 =?utf-8?B?SHlCQktJS1lsYUFJMjh0UjNSRTlJdlA3MTFxQnRSUnEzcjRKVXkrRWRML29t?=
 =?utf-8?B?eHEzTkhrRXRJYVZDczBEcGNMOHJlU0tjaEZWYVliUXZ3ajR5OFk1RHZqWS9W?=
 =?utf-8?B?aElnRTk2aDFQQ2xhQ1RER1dxdEFyRWtnMG1QcEdYd3J1Y0UrUmU5MXZlRXkx?=
 =?utf-8?B?TnM3SjZKallWYW9mb3dscEhvaWxKVVJTMmtrUDhTTjh3enlDQkVSd1l3dTFW?=
 =?utf-8?B?RzQ5MkVWMHpnWk1sZjBWM1hhc1NLcE84ZUV2MGdCeFc2NCtBa01PbkRxZW4v?=
 =?utf-8?B?dUM3SnVRdlRJK2NCRlo1WDVHSWszZUo2SWpQTDRwbG5NYVk5WW9BRDBhdGRp?=
 =?utf-8?B?Nkt0S0xuVTR6YmFiQjNHdDNJTVJVNFltN3NIVEtSMXlvUUs3cHN6OGNxcnFr?=
 =?utf-8?B?UFE2ZmEzQTRxUFFENTJsdE5EcTBTeEV0U25rdzZTM2ZyWGVQMFBNcDlRVDJG?=
 =?utf-8?B?L2ZIZHRTTy9yNTNaTkx1NkRIMFVYT042MVVVc0p0cUN2cU1FQ3U4Vk5SMlNC?=
 =?utf-8?B?UEhnekIyWTVLeFhXejkxTWUxRGNSU2RIUi8yeEFiZG5qc2l0dmFjLzZBNlI2?=
 =?utf-8?B?a1QzZGs3QTZoTmpuRWY2TXpDbGV2eVBab1R3SWlYQk1EUkk1blJzQk5Pb25l?=
 =?utf-8?B?cnUzNUNnUUx0WXZ2YnJuSGRyRFZudk9lcEtka2hYaXAxdnYybGwwWjJidWs2?=
 =?utf-8?Q?ILDaCvPHXc6vnoixVvO3TUo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aCszdkdUZTc5Wk9oQmR6WmtHcEdIbHBRdCs0dVpDb3hpMk9hY04vRW9DYndq?=
 =?utf-8?B?L1pGVzdURit5RFFkK3htVjZEZ1lmVDZWVkp5RkhzZUhkQmRmZzNtQjBVYkFl?=
 =?utf-8?B?a1ZLcllYSEVBcURGK0R6QnZFdndicnQwMW5lcngzRHBsdnpJd1dwdXF3dkw1?=
 =?utf-8?B?aWU0a0JIK3VidHM5bXNWR0ZnOWlTeEtVVkxlRlp6bmxzSUlZNjRzNWt0c3lR?=
 =?utf-8?B?SytGU0YwVUpVRDc5SVp6b0dCOHYwNlJjaUhrWVdsTXM5UDgvd2xld283WGhw?=
 =?utf-8?B?N1FqYVdFKzdvellqNE5ReE0ySUZmUS8xVTVYakdMd281WGZ1TndWNXVmb2Y1?=
 =?utf-8?B?RHh5ZFJwRnozeTY3SXRhbkRxL2s5emhuT2tVZVJDVTNWb0ZCQ0N5QkN2TDAz?=
 =?utf-8?B?TjhGQ1pZSldxUEpJT2lKcjdnWWVqMDZXN1lIdHJVWlVyUGszdUlvNDZrdFBS?=
 =?utf-8?B?QytNdVRENENkWHBUbHQremRTV1k5eHdqZEQwTVY5blJmb0IxeHVrZ2hFcWdO?=
 =?utf-8?B?NzN0cUlwUEttZXZZNXZLWGV1UzVZc2FKZXRSODJ0aDZmSXp5OEpNTGt3ZkRa?=
 =?utf-8?B?MnlFeHFFOStIZmNXZ09hNS9zUENrOHIzOUNaOXdkallZdVk3UXJhV01QUXlO?=
 =?utf-8?B?ZTlCWW4yY290Sk5pTVRZdVp4bkNEdXhReTBCNFVhWENCR2x2N3RYMVFjeE9o?=
 =?utf-8?B?RzVLdXpjNmpkTDF0bUhHck85OVdocEFteFgrRStRcWRnZmU1bkNhbkdVcXJt?=
 =?utf-8?B?aDFsTzlFbmZwVGEyVEF5bm1IYXVhZXpuVlh4aE9uTWdrdWE1YzVHVFBkRTdS?=
 =?utf-8?B?WUNHUjByZFZZa2xXL2FSam45ai9OL3BEN1Z1MnZza0hsTWRjQnVWc3RPcUpq?=
 =?utf-8?B?UHVXRnFFSTZMOVZXZ0NkMXAvQm1jOGhqa2RiQUJQeWdSSm9wN3Z3bTNieHla?=
 =?utf-8?B?YkttbWExWWF0Rlo4TjZudnlQNHQyV2U2eWhDRVRzSkhUVzZZRi90YmZzcHhF?=
 =?utf-8?B?ZHppazZNUTF2bnpzVjVveUZzZTNrY09jaXJWK3dUeE9XNXJGQzMwR2dDdjFw?=
 =?utf-8?B?WVVCeW1HT2xmMXAxUE52VTE5ejJQRlhhZ2pHWlE5Z0N6R3Y3b2JsdEZNS2Rm?=
 =?utf-8?B?K0UxeTA5YU9nUUs2em4zUkVJeFdqL09Ib2NTRnZPZFI3MU1Id3dhVWpnNnlu?=
 =?utf-8?B?a0tXa0IrMDFLSDhtVkRWWnJqaDR4WUxnWllKbHh3WDVBSDJLdC9FZUM3QlBl?=
 =?utf-8?B?eHJDbm42VkgvMFU0eGp2WmRyczN5QjRkNW03U2N5NkZIVTBSRHdOY2NRa013?=
 =?utf-8?B?TWFzUTIveUlpU24wTDlnVWtVUFp5b0lqTWFNZ2VXVnRPODd4QzQ4SVphdnNU?=
 =?utf-8?B?TFJVaXg1WkxPdUIyRDAyQWxrY09GYkhkSEpWWnIzakdob1ZnZ3pxSlJpTFpn?=
 =?utf-8?B?bFR0NnJnOEQzZkxNdlRqWFhpdEVZOVVKbkswSlJreXdDWUNTRTBqeUp6eDNl?=
 =?utf-8?B?OWFLOTJLWTE1T1JkNzVlTS9uNTRqMXVIMklLWEx6ZFRmelRWWlh5Y05QSVJm?=
 =?utf-8?B?NitINWp1Y0x2UnNwRmJuOVZqTDRFdHBETTd6N0VnUkJCMjUrblAraVJhNVhC?=
 =?utf-8?B?RC84cGxqcFhzMllmM3BLSmgzS2JRMmZ6a0F0TTc4cEFYZmNzMk9UTFdsTXlx?=
 =?utf-8?B?QTRmMzAxdmNRL09LalBBVHVGQm9Ub01MZnlQcWYybFpiR3ZxR2FibnNYOUND?=
 =?utf-8?B?SXRCTm1EOXBVbVQ0U3NYbk1Scm12YVo0Z1JLUGE1cnZPTTBDVG8vak9RNnl6?=
 =?utf-8?B?UjFxTWN3d0ZBcUNWRVphTG5yLyt5RFVCSEpxVHd5TThKV2JkK2NlN21oRzNU?=
 =?utf-8?B?ZjJPeXA2NXZDRVVaMUx5Z3VVQmJKRTZsdHVqU3NJcGs3R3d1a0dPM05lR3Ez?=
 =?utf-8?B?ODRLK2xONXZFbGlwSHFGUTcvQmpBMUpZRVVwaFJDSy9GbjVjbHQ0R2JZMXpC?=
 =?utf-8?B?N0VhaTdOSnVSRGx5OUlMQkgyOWZFSEpscWx3MHNURUhsMXhvbktWQ0o1cUdm?=
 =?utf-8?B?a0ZrWTFGU0lNM1ZVbHVFTUsreHZsejZLU2dsNjI1L2tmR3AxdGFLUWRrRkJS?=
 =?utf-8?B?QTNoZjVnWHdNS05UYUg4L3ZtS0NvYWtuNC9oaFBXbkozcFV6eWE0V0tFakFx?=
 =?utf-8?B?SHRsQTlITjNpSmk4ODhxemJiL0VaYU5wVWtvbHhXNVRyOG0yY0RHU01UZDRs?=
 =?utf-8?B?QWpmZGJNKzlxcFlQOWZHbE8rWGVDQ0haWCtFaWhyeS9LN2ZPaWh1QlRSQWNC?=
 =?utf-8?B?RFFQTEhHR2VEdHV5c0gzY2M3QVFrL0cyaGV1M0lNQnJ0amNsSkJpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583ac18b-8559-475e-8acf-08de633ae664
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 15:42:55.7566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i85MZQ0rD7ASfMLKoLlWttijRlWtqoXJhnLYUxo2VEqVMlOprlOAeCWXk3DJxSc6SuVUrpLyJOg4xaf9Pnr1Qtoaf3DCxcpOqnhizvexIy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8021
X-Proofpoint-ORIG-GUID: VCHhcnAXsQ-yugUmM2a9k1JOmwn40UMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyMyBTYWx0ZWRfXzWgie9uZuL8i
 cqg63BZ8XufE6LdwBgkxe543yovW6sHUhuvARiD+Miw+tVnO8+lRsNj9a9QXhaRUnNwMzcl9NhS
 ZruHScZ/2infGuSBKjQrvyhskDj4h+maesKiTRupTpV++c1q6K6GZpJAHjUtvcRfs1XwSvx0US3
 ruoy6vnrOoxoktTdZWnOxeVtjG9YQCeIVtY8WXqpCeVJZqj19/jykVN0kvOyvtcfd0Cz0k/oS/z
 GmxolRpefHclNxbhPpNckNTFQ8giVBga337qosYPnklEfGjJDaXKzk605gDFrCEJ6WgjIYrKD7G
 2LgSK/DfAYS8sXuH/IYkF3XJztHS6lX9F8VKal1mqxenHVVhI8MwJKZPwGMsy9wOPRScMlgXDDa
 4gxbt7cWvd/uLzJeYfMU6YAeznW161akgndKrL7P32eFy8vD6a8UduT22dV+UzbAAF/tcKCskfI
 +BkfZ5la4DkfwPaaBhw==
X-Authority-Analysis: v=2.4 cv=abBsXBot c=1 sm=1 tr=0 ts=69821783 cx=c_pps
 a=5zjvB78PlnLPEzvzEo0MXg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ovzKdMC59ZcKuGCBBNMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VCHhcnAXsQ-yugUmM2a9k1JOmwn40UMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030123

Li4uDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAg
IGlvLWJhY2tlbmRzOg0KPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDINCj4gPiArICAgICAgcmVx
dWlyZWQ6DQo+ID4gKyAgICAgICAgLSBhZGksYXV4LXNwaS1jcw0KPiA+ICsgICAgZWxzZToNCj4g
PiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBpby1iYWNrZW5kczoNCj4gPiArICAg
ICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCj4gPg0KPiA+ICBleGFtcGxlczoNCj4gPiBAQCAtOTgsNCArMTI3LDIyIEBAIGV4YW1wbGVz
Og0KPiA+ICAgICAgICAgICAgaW8tYmFja2VuZHMgPSA8Jmlpb19iYWNrZW5kPjsNCj4gPiAgICAg
ICAgICB9Ow0KPiA+ICAgICAgfTsNCj4gPiArICAtIHwNCj4gPiArICAgIHNwaSB7DQo+ID4gKyAg
ICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8
MD47DQo+ID4gKw0KPiA+ICsgICAgICAgIGFkY0AwIHsNCj4gPiArICAgICAgICAgIGNvbXBhdGli
bGUgPSAiYWRpLGFkNDg4MCI7DQo+ID4gKyAgICAgICAgICByZWcgPSA8MD47DQo+ID4gKyAgICAg
ICAgICBhZGksYXV4LXNwaS1jcyA9IDwxPjsNCj4gDQo+IFdlIGNhbiBhbHJlYWR5IGhhdmUgbXVs
dGlwbGUgcmVnIGZvciBhIG11bHRpcGxlIENTIGRldmljZS4NCj4gDQo+ICAgICAgICAgICAgICBy
ZWcgPSA8MD4sIDwxPjsNCj4gDQo+IFNvIHdlIHNob3VsZG4ndCBuZWVkIGEgbmV3IGFkaSxhdXgt
c3BpLWNzIHByb3BlcnR5IGZvciB0aGF0Lg0KDQpTdXJlLCB0aGF0IHdhcyB0aGUgaW5pdGlhbCBw
bGFuIGJ1dCBmb3Igc29tZSByZWFzb24gZ29pbmcgZm9yIG11bHRpcGxlIHJlZ3MgZ2V0cyBtZSB0
byB0aGlzOg0KDQpbICAgMTEuMzk2ODMzXSAgc3BpX25ld19hbmNpbGxhcnlfZGV2aWNlIGZyb20g
YWQ0MDgwX3Byb2JlKzB4NGI4LzB4NWE0DQpbICAgMTEuMzk2ODYxXSAgYWQ0MDgwX3Byb2JlIGZy
b20gcmVhbGx5X3Byb2JlKzB4YzgvMHgyYzgNClsgICAxMS4zOTcyODFdIGFkNDA4MCBzcGkxLjA6
IGNoaXBzZWxlY3QgMSBhbHJlYWR5IGluIHVzZQ0KWyAgIDExLjM5NzI5N10gYWQ0MDgwIHNwaTEu
MDogZmFpbGVkIHRvIHJlZ2lzdGVyIGFuY2lsbGFyeSBkZXZpY2UNClsgICAxMS4zOTczMTddIGFk
NDA4MCBzcGkxLjA6IHByb2JlIHdpdGggZHJpdmVyIGFkNDA4MCBmYWlsZWQgd2l0aCBlcnJvciAt
MTYNCg0KV2hpbGUgdGhlIGF1eC1zcGktY3Mgd29ya3MgZmluZS4gQW55IHRpcHM/DQoNCj4gDQo+
ID4gKyAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMDAwMDAwMD47DQo+ID4gKyAgICAg
ICAgICB2ZGQzMy1zdXBwbHkgPSA8JnZkZDMzPjsNCj4gPiArICAgICAgICAgIHZkZGxkby1zdXBw
bHkgPSA8JnZkZGxkbz47DQo+ID4gKyAgICAgICAgICB2cmVmaW4tc3VwcGx5ID0gPCZ2cmVmaW4+
Ow0KPiA+ICsgICAgICAgICAgY2xvY2tzID0gPCZjbnY+Ow0KPiA+ICsgICAgICAgICAgY2xvY2st
bmFtZXMgPSAiY252IjsNCj4gPiArICAgICAgICAgIGlvLWJhY2tlbmRzID0gPCZpaW9fYmFja2Vu
ZF9jaGE+LCA8Jmlpb19iYWNrZW5kX2NoYj47DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07
DQo+ID4gIC4uLg0KDQo=
