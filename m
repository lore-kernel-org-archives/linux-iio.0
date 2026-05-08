Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122327FB37;
	Fri,  8 May 2026 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251739; cv=fail; b=ftEuFv+quReoYrO9W8BGjYosniZs/9qDSFcSQzPIYJSYIws4TzVqfJhxlNnMXBsRXnH3yOVNV9r5n+BkaAGwJgpDnsGl99pKLtMHbrbW8UcvP0gN+vLLykTtYUXPACD3p1I8+g7F6bOxm0eeinX7+59aEyr+ueT3rzuCPSGSpn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251739; c=relaxed/simple;
	bh=GggGINeqrQmm8SGTaaYpLIXWZVttCuQ53zOHp94IjDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krK247OvUbImy7o8ngxjbUJhl6zS0v9H6nPyEdzEGGLHCyS/vgL4HUitFIyD7UFXKMVt2v+JKrfX2k/mGkE0QcFil+eF+uXfW273yjHbxnYrt1o1lQRlBn2UY7V9qILEg9SvRXjCVr6hP87pOzIk3nIxso2w/14h/GEwZ9tH2PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NGuoJiaZ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NGuoJiaZ"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6489UUKb1044498;
	Fri, 8 May 2026 10:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GggGI
	NeqrQmm8SGTaaYpLIXWZVttCuQ53zOHp94IjDg=; b=NGuoJiaZSOeEi7XXaIGWU
	8kbN/jwdMuYkGvm39mhJq1/prW2MnNPZT1EybFl4Dg1VdRjPJoWnD6Xp4H+aZfBd
	RviKcKQ5Lp2Wy1YYKtoN7Q+27xyAnvf6vWJpWKN/qIvVsLkGs5rgtZdA9tjwJ0My
	N7qhFx4PR6+h0owRPl5TEE5tGA7mK5BxSTDzee89PQplNVU7EJn9MrpbhfuS12mS
	YelsWRaacNh0rqM102Xr7yqMNMJ24qrKXtpl/S3vdwNnJzQ0BgmhafGL3CeAXHHG
	/VIeT2n9gSZXFDYocOsJR0L8+PhJiShDAcRt7TJAk+roqT2plvHjcGT0VC6YljS2
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e122akaad-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:48:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=To5MSy5P5VOyYRT4zPda67XJB75v1HovPGkrYQk0Fxn9deCK8NH+BwCV5ytgOrhxwqDe/Lj66yayFMGxpQ8MxGfhkLx/KYicoEcuIpWyjV4UjPFIYBej2r0F9YplzRc6wOAhC21AIgjS8iT17MglchrLG/ZEiLes1mM4qOND5WjPWSk/8edGCnKl6sElkP0HlKi0OSog4zs67IYZ3iD8FUpfEoQTdjgBnsIjBuqX0GBorqFDAdwg29j7awz17WSn/ymzrJyXX5cKSsuiOkvdzzdFO/s+gQ0NpmHjgo+utV25w6vpA0fRbyOmNoRuUx5PFeJfNNtfiikM4tl0tz26DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GggGINeqrQmm8SGTaaYpLIXWZVttCuQ53zOHp94IjDg=;
 b=m3uKw6QtXqRnaVxM5Ie3blTlEIJHnXBnCIj7g3v0aZRHb7/mPvk1PC8TtPRTaGjI2+0U+lTeWW8GgBiF5XWY4mQqSb37pSLrjJI7UC4dz6RYaYrmZyYuK/0qFoIspPhB+4NRzqLFnmBnihCsHaX2yv6oz9X5UAJZLJ0sVy4xJyjHrF4Jm1ZSCKzUpw9en2A69H5OeLM0YuyJhkT6Mwjz4IJObrutAvhVB+eZcBSLyM1N866OIFcV7qZ8NJG4i7H7Q6eYlSNiYs8//WeMDal2mLTC3NND09R5wV2kh3yZZ1oJ0MMv4IUh4fEyyKalyA0X+ZaKngoOyhkpPKJTqSR8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by IA1PR03MB8214.namprd03.prod.outlook.com (2603:10b6:208:5d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 14:48:40 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 14:48:39 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index:
 AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbX0U6uAgA5CZsCAAVTVgIAAIEGAgAAYMKCAABGiAIAADdZQ
Date: Fri, 8 May 2026 14:48:39 +0000
Message-ID:
 <SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com> <afCVtXBHIIoLlsRo@nsa>
 <SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af2no3bJA9MSjXvV@nsa> <20260508121441.39ad9f65@jic23-huawei>
 <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af3oezNmmBhI4Yu4@nsa>
In-Reply-To: <af3oezNmmBhI4Yu4@nsa>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|IA1PR03MB8214:EE_
x-ms-office365-filtering-correlation-id: b0a9e4f0-ee97-4eb8-efe9-08dead10e474
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 BkVjPtM5d2d3Dda8aH5xImwcgVLIj5UZZQ58A+Zfloa5pndrYt2JYjCKj11Aayy30RLSvz7zvfVd6hjYfXejsGftHFhTmcAnqytoW0Ze2r/eWvM46A1kWdG2NzPQXJ5BGj6FoxwvimDrx2x/QLjf8CFkAebBm6aSR/ScUjGtirCA+QecMsgbIk3NA8tWFldirW/aQJIRboCX5lp4O6joMNjSfFZcbM9vPD/+YMerz3jxUmF7CMu1nm4ynu/J13jJb2OHamdWCWVMH1usFIRlnaYQDt0jZlHX2Md6K7jWVTBCHDTouIAcR7MqsUaCpfmaFXr9fOuCu9gf2oMBwXokhNgsb3TckbSrSd+AV38Cm0ZKkXfiWryqvLGKZGdDz/e79r/A6g3/WLY6aHAjuV8K2agb9r+S4BKM+9Wj4wj7XfptzKDwkXANUL3Wtsb1lEan5G1N/Wv0k5VQ3V47tuqTE77LKMyu2em4KKuz7nwnLkIaC5iKL1pIkVziIKjcJ/TZYGFzAIDjL4VrJ+ZIu08T5/Bo//izz9rwWf1N3bQlCfFOuPVt05KNdO+vH+Zrx3h/7mEQYW6hGIvykOmt5Cnq7/7M8Xy7UL4+A2M4nc+48QxPrZYydJYh+LuTwPgOv7SinmVoUX70EzX6C8qcwkLxT89odFbJLNIl3urW6+nKPrVO7kEEK9y5km+x9wgIH0UCJLNgXhXGxpTKoEK4nJXTpM/pU3ywgX1/nCaLr8fD4bkeU4WVLoJUYS95a29uAhfR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0pPemwvSW5URVYzaWxxQ3QvaHdhUVRWVndsSkRPZSsweWtjYXd0RnFTQXdu?=
 =?utf-8?B?Q3IxeExTQ0d6N3JqeDFjSUh6Vjh1b3R0S2t2VEZVL3RnVW1URG12MW0rWHBx?=
 =?utf-8?B?ZTM5OVJlWUEwb3JkRmVTRk1naDNMK2o4bE5tL1lRR0dQNXNKVmdKS0czYnhW?=
 =?utf-8?B?UGJuZGRrVWNQRmxpOUsxaFJyUUpnRTg1ZHRpZ0g4d09xeG5VbW1SSDRneW0z?=
 =?utf-8?B?NnV2dGltRTV5U0NZejZUUDAyVVo0UlBBTlUrTmM0aDkxeno4VGdxaXQ2RGpW?=
 =?utf-8?B?MVlJZ3VyZk03ZWwyaUo1TEU5eTU0djRLc3BYeE1tQ213enRibWpBZmZONkRX?=
 =?utf-8?B?WjZLK28vWXd5NEJVRkVOYW9qR0oxNXNwU2lqRUNUTWw4K1lEcGw3cE1ENVhs?=
 =?utf-8?B?bkcvWlY4YStrUGFsREw0dHF6RVk4VHhyOGxPWFowSXFQTUhVVDFuRzhiSUly?=
 =?utf-8?B?VTVaN0dVUUNWbkEyL1lnUy9wbElvM2Z6T2dEQmVCekpVczVVb1NZZEpLUDBh?=
 =?utf-8?B?ZmV4MDYveWgweFNJMm95NFhEUEt1cU5CWHVNL3lPTnBMdm5CZkUwNDlVbUl5?=
 =?utf-8?B?a2lFTUNKUzZjUDJXQU13eVB4ZmxLZHgzakZ5RGE4U0s4VWhsaDZZSkV1MnMr?=
 =?utf-8?B?NHA4bFBrSFBRZWM5ZFVCSXlzOUczbklLSHVHY0Z1d1RLZDRwK1J2WDNNdGx5?=
 =?utf-8?B?N0pXUnpiUTBZMldPZjNSYmZUU0ZkQ0oycHZ2VWw4UzBiY0kxeHVzVEdTZjlw?=
 =?utf-8?B?cDAvUE85RHZGU0tjUXlKMWV2cGhLZU1JU3dwZVhXQWFSdWFEUWxtVXY3VjVG?=
 =?utf-8?B?RCszV3huR0JxbTlqa0NGYmZiL3BWQlJMUUFnTldrWmhMREJ4Q0xLanE5bzJk?=
 =?utf-8?B?QnJMUUp6N21SaCtGQlpWMU5xQlM3aDdPQnI1Skh0MlhnMm1Sa2d5Sk1qRytD?=
 =?utf-8?B?MGhIVkRydHA0Vy9CSUFJYkF4N29nem5saVRIMVI2OTdXVFZpWk5YZzQ2Q2FG?=
 =?utf-8?B?NzhUSWZvRXZnV3FsS1FkbE82RmJGYjY5ZGVtYnlHNitnbzRweUcvaytLSHll?=
 =?utf-8?B?NHIrdkRpQ1JnSTIvN3BnVlNtUTgrbGZ6M1JHT0g1Lzlid3pNR2dob2JpWjdH?=
 =?utf-8?B?dnA3RWJKMjNZZTIyYkJvVUZHZlIzQjNYSEFxUjJSNldqNDZPdXZwUzVaSU1L?=
 =?utf-8?B?R2JIRE1FSlhxOENrZzYrbkRvWGJXNWFCUnZoMUNpU3ltNjNVNWJDYzdsdHlq?=
 =?utf-8?B?VzNPa1VpWlVCZWl5cWwxb3BrSDRhelY4Q0ltaEZOUC9ncXhRd2RjOSt6WkYz?=
 =?utf-8?B?RFVDS1hobENvSU4xdTdNZmgwSlp5dWlVRVoyemo0aE1tZSs4SUV0NEUvUHcv?=
 =?utf-8?B?MUdaTXA3S3dueWJGRlJCaEtiK3JXTFZvRnhWbjFWY09WL3R0Q1RVMzhkZ3c4?=
 =?utf-8?B?TmlEZTBCQkhRa2xOREJ4VXY4ajVna3JVa3dvdU1xbUp6NWp2dG42eUZJamJS?=
 =?utf-8?B?M2RmempYaVRxbUhFNnliU3JaMWpGN01LMDFYVk10VnJLZnFCSjFoUDBQbG5w?=
 =?utf-8?B?OXdMUjVNQkFNVCtkcE1yWVFxeFpkMFBjclpHUm11UHI0UVUwL3NEMGx6M08x?=
 =?utf-8?B?VndWMFQ2VWp2Y3Y4YXpPdmIxOVZOcnpPbGxtOCtzNE5TbmxGcm1FNVhrWjBL?=
 =?utf-8?B?R29uZFRaSndya2xSR2IrWTY5NU5GamNkVFlZcm9lcmF5bjhaY00yQ3dpNFFM?=
 =?utf-8?B?b08xeUorRUo3TjhkSHdIcTNpNklrbUxqQkFZRFJxaGNtWDFGL0tzMTB6MHpD?=
 =?utf-8?B?ZUN3R2FVUmFzL055MnBqSUV6Zm9QSjZCZWVZZTBHdjk2QW1wWE9USlFHNmR6?=
 =?utf-8?B?TkxxekM5SHdya3gwVVFDblQ2SzJkRWM3dG03amNzWnNQQ011aWRYOVZmU0pE?=
 =?utf-8?B?MEw0OGdORFg1SG1sSWU1ZWtHdE5jcm9ON014TmNpcWpYRWdNTEhocHcweWsy?=
 =?utf-8?B?a1Q0T0xjTEdiTWp2UDdxQnI2VXByTzZtU2E5UWhBdFRTTGZ1aDdhT0ZTcnFl?=
 =?utf-8?B?eWV0eGluS2JEQXdaUEN3VTFaNVhFSnU2VWk1NUhPT2Zia0IzMVpxaVVmUTF1?=
 =?utf-8?B?U29pME54a3RTOVJvcWxvek11WlByclhmdHBCOFI3VHQ2SENvVkVyU3k5MnA4?=
 =?utf-8?B?UDBmazJLL2Z1L1FCSGQzcnlKc3AvUmNlWWRYY3NBR2FZb3l2TXdRRXVkelFm?=
 =?utf-8?B?SVVUWXI5ZHlneUdoKys5aUJjS292Vk1zTmVZM1ZpcUp6N01oK2NGRTM5NWJT?=
 =?utf-8?B?amh0QTJ0Yi9RSVUvdEVHTFN0VWNaWXRhd0drY20yRlE5Z3dYWnFHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BVNdE1JkGdF8UtttXJG0Ck37MfdwA4+MKi2LLieXYmzQCUJby+OKsg6m2aKJI5pNha50tJnVcUSYR+mhssx6STHRUZSS0szhyhumnbWZIbOdfJ4IMgEamoMiiWNRE3HXmuwTJXA9h2U5nyIlU0WQ6zxtuD0sgJF63TVVqdRj/nZLwUqeqMU1mMeGA+BJieNHf0gOQfL5G5dxj9fTLJjurhNOiTc68zD5bjiWidIC7KBmpPW0cJp4yCRlW8PwDhxxFvjoTWt08uIQmLLg1qC5SWZfI/ktMUwCznFC4iGiuxC+OzHFIihcKONVezIJB8wUw00xEgJc84XJHoYDBVsfCA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a9e4f0-ee97-4eb8-efe9-08dead10e474
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 14:48:39.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTtxGLDRL0fGgjdwB7pTY3QPWfYCmgeLf9xW8ewFiszbfGFDnyyMPGnJRXeWfF3KluwWBgtRg9JfQYdlC4maFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8214
X-Authority-Analysis: v=2.4 cv=demwG3Xe c=1 sm=1 tr=0 ts=69fdf7cb cx=c_pps
 a=LPqnct3xGwQwGN9n+XDEZg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=BqaDk1D0K--OP5Gf91cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1MSBTYWx0ZWRfX924wnlifcP13
 k3mY+hLmDq2XssmzlSREsfTokmjBhJN5vdkb97RF/E891eehe8Kv5JI/vhG0Lh+igJsFyBkVzhs
 K6l5pC9C6VuTM5nmmGPapVqdakDkTJ/Cr9EEPttI7t8/N9lnVB2+aDPztOSVA20ulP9YHCQNpGk
 Vyss2H7tiLBGSN/WUn+wB6BkONw5xbcgAZsHwE7joKZ98Zl27Kl+EzHMbbbskePV+/XZfX+pSSe
 2kRcMCgW6XeTdhMaculDsU4UDgqcbnjiUJLGDDwCkcujWmhTFhzKwcXa7NYDXDC8IJ4Qu6WaXPG
 f0Sc0e7nqIsV6vQyQ3/oZWndSeC8a+h/pFWMwmXGEireGXE5Yl955nRMjpjFutF6dd4QUYLeEW9
 tJJnEl8okm9uE+Db3YFhuXK1dZfm26UkXCjST++rPE1SYKeoO6sFR08/KTuS4DggUOnW08NBXZ3
 vrBy8+iI7sVnHqwN83Q==
X-Proofpoint-GUID: OZ1705rqubPpB226pJ6zvLNTLWQ8pNQ_
X-Proofpoint-ORIG-GUID: OZ1705rqubPpB226pJ6zvLNTLWQ8pNQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080151

T24gRnJpLCBNYXkgMDgsIDIwMjYgTnVubyBTw6Egd3JvdGU6DQo+ID4gT24gRnJpLCA4IE1heSAy
MDI2IEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPiA+IFdpbGwgZGVmZXIgdGhpcyB0byBK
b25hdGhhbiBidXQgaWYgd2UgY2FuIGhhdmUgYSByZWFsIG9mIHRoZSBjb3ZlcmFnZQ0KPiA+ID4g
PiBnaXZlbiB0aGUgdGVtcGVyYXR1cmUsIEkgZ3Vlc3MgdGhpcyBpcyBvay4gR2l2ZW4gdGhhdCBJ
IHRoaW5rIHdlIGRvbid0IGhhdmUNCj4gPiA+ID4gYSBiZXR0ZXIgY2hhbm5lbCAodW5sZXNzIHdl
IGFkZCBvbmU/KSBmb3IgdGhpcy4gT3IganVzdCBleHRlbmRlZF9pbmZvLi4uDQo+ID4gPiA+DQo+
ID4gPg0KPiA+ID4gSSBoYXZlIG5vIGlkZWEgd2hhdCBjb3ZlcmFnZSBwZXJjZW50YWdlIG1lYW5z
IGluIHRoaXMgY2FzZS4NCj4gPiA+IENhbiB5b3UgcHJvdmlkZSBzb21lIG1vcmUgZGV0YWlscyBv
ciBhIHJlZmVyZW5jZT8gIEdvb2dsZSBpc24ndCBnaXZpbmcgbWUNCj4gPiA+IGFueXRoaW5nIHVz
ZWZ1bC4NCj4gPg0KPiA+IEEgbGVhayBkZXRlY3RvciBpcyBhIHNlbnNvciBsaWtlIHRoZSByYWlu
ZHJvcCBkZXRlY3Rpb24gbW9kdWxlcywgd2hvc2UNCj4gPiByZXNpc3RhbmNlIGRlY3JlYXNlcyBh
cyBtb3JlIG9mIGl0cyBzdXJmYWNlIGlzIGNvbnRhY3RlZCBieSBsaXF1aWQuIEluIHRoaXMgY2Fz
ZSwNCj4gPiBmb3IgZXhhbXBsZSwgaWYgaGFsZiBvZiB0aGUgc2Vuc29yJ3Mgc3VyZmFjZSBpcyBp
biBjb250YWN0IHdpdGggYSBsaXF1aWQsIHRoZQ0KPiA+IEFEVDc2MDQgc2hvdWxkLCB3aXRoIGFu
IGFwcHJvcGlhdGUgdXNlci1wcm92aWRlZCByZXNpc3RhbmNlLXZzLWNvdmVyYWdlDQo+ID4gdGFi
bGUsIHJlcG9ydCA1MCUgY292ZXJhZ2UgaW4gdGhlIElJTyBjaGFubmVsLg0KPiANCj4gQW5kLCBB
RkFJVSwgZGVwZW5kaW5nIG9uIHRoZSBjb3ZlcmFnZSB0aGUgcmVzaXN0YW5jZSBjaGFuZ2VzIGFu
ZCB0aGF0J3MNCj4gaG93IHdlIGdldCBpbnRvIHRoZSBpbmRpcmVjdCB0ZW1wZXJhdHVyZSB2YXJp
YXRpb25zPw0KDQpJZiBJIHVuZGVyc3RhbmQgeW91ciBjb21tZW50IGNvcnJlY3RseSwgeW91J3Jl
IGltcGx5aW5nIHRoYXQgdGhlcmUgYXJlIGluZGlyZWN0DQp0ZW1wZXJhdHVyZSB2YXJpYXRpb25z
IGNhdXNlZCBieSByZXNpc3RhbmNlIGNoYW5nZXMsIGFuZCB0aGF0J3Mgd2hhdCB0aGUgY2hpcCBp
cw0KbWVhc3VyaW5nPyBUaGUgY2hpcCBkb2VzIG5vdCBtZWFzdXJlIGFueSBhY3R1YWwgdGVtcGVy
YXR1cmUgZm9yIHRoaXMgc2Vuc29yDQp0eXBlLCB0aGUgdmFsdWUgaW4gdGhlIHRlbXBlcmF0dXJl
IHJlc3VsdCByZWdpc3RlciBiYW5rIGlzIHNvbGVseSBhIHJlc3VsdCBvZiB0aGUgDQpjaGlwJ3Mg
aW50ZXJwb2xhdGlvbiBvZiB0aGUgdXNlci1kZWZpbmVkIGN1c3RvbSB0YWJsZS4NCg0KTGl2aXUN
Cg==
