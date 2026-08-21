Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E361486B9B;
	Fri, 21 Aug 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317163; cv=fail; b=W3BA4MC5elm1v9OyIZ+WQld4XWJiVsSC7uVxF8lsG3bMaHjThsJomdl32lgKYuOFpETIi0Vrb5PEzcIjoXI6UZ5jEwQoHJws2SbRoMeQMmFEJ4Ztyu8eui6MoGroo17r6dVxWNydnzeYxQ22Qq05oUCKA+CAMqgHExmgXTWA+nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317163; c=relaxed/simple;
	bh=NPhkChsKxD48V+zV4n0w9YH/WSTOKf6mwt4/m5x+VRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KOz2VcoChidkxsVvdftOwTlzHCx2zR6ukGhrRkigevQP9b5OMdEEq6+UzLSrTIZGXx/jRIXB068f/s7CVED9tWS5NVTV7g8dz3Llq/5OGCtY9q7AGdQjGKGhEsg+JcwkFSPcg66GpJw3zk5C6iIeaShLzhGNCLepKWackOkDCPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=YukC//pj; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="YukC//pj"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCmUWP3630597;
	Fri, 21 Aug 2026 12:59:13 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012021.outbound.protection.outlook.com [40.107.149.21])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4g4ydytq73-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:59:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN1oOJmsJFKkjX7H52ZuiZUxBsDjpqFVUsKfDNcyX5ElEpmMVAuapyLVaJbLknYOz7tMrIlKwJDBljzFncPD0wiqpx0dlqCtTBQ15KNbpytikKPysvI8jdUnrL+OnVtbreG/qJJuKDPkHBPPZnn4gNO/waT/KJ4PeE5Am5ro/1NfZD3/aaF/RvmXiPW53Do8069E5ydEO2iYWwJivZ1XkC00ZUhICuBkknAbvP78a9Uy1uYMLiaNP6UqYZ4e4K+NcyVEWVy2/SWrgwqTQEL8UsXASAN1dI/5JyUSs5RpAQFM5E4A+i5auD2r5l8EXkGRyrcNqJciGKfLQb2QEfo7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPhkChsKxD48V+zV4n0w9YH/WSTOKf6mwt4/m5x+VRA=;
 b=Og3y/QWs6BrvCn+oZLgI0LgoFsqdbL8bxpP6kdZhzwuRMKXCYi42IJhEaw7TQFWxZmaD+CrUpR1rA1OvXxzP5VXadImv8XrJq7KfK8cqcQIidZgNkXiA8iCtkm9WuvQNOVBotvWO5wlx8tgxAR48CY5rJovvrNf+VkX0QhCfuSyHyEA44JEMeRiwx/0TVRMqCmOCVoBvEtKNwOa4SXcdG+XjttMe56ObB71GSzYhPa+24J8DXbYQ9TrDm22DwGTGyN8A1ab979bBWCZViXfYZWTiGrZdkMaXYMbZm+C1wJOssaDbWxIU+qxqgmZv9pt9LELRsAVoWqPIQBKqbBU/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPhkChsKxD48V+zV4n0w9YH/WSTOKf6mwt4/m5x+VRA=;
 b=YukC//pjHJfTw82kzQYcLVt/G/T1FnkAlErUj1J4XJPTgZaKyvN4yxC3CnGlKUjeFIplcFicFL8j7b2CxISDKna2mO3GPkZtarvpIaXt/kzdMSUBuWmVDmgEzZcygJL20F9K4f1fvogxT29RoCtvH9Pv4oSYNgP9SAhowWH1yh2oWmGIHayhqBNqP+hsj3aWVDI2KgkyHYcFf9V2tVIHnZzynfdTRnEPCAhN0QJ//9B6E1GpRfLFVtMGwekJ4HiCS7pXoX5YsdjXZXsfW0r9RZHNS5z5X7OhOffqrQbJYDW8GRWOr0X5IIGL69MJvdKgZj2HJoKmbznc9IRmvXa6Kw==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR6P281MB3873.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 12:59:05 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 12:59:04 +0000
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
Subject: Re: [PATCH 2/4] iio: imu: inv_icm42600: use 2 sensors fixed packet
 size of 16 bytes
Thread-Topic: [PATCH 2/4] iio: imu: inv_icm42600: use 2 sensors fixed packet
 size of 16 bytes
Thread-Index: AQHdMNaD1W8dP/C65kKdoAJn/lproLanoPcAgADUvNE=
Date: Fri, 21 Aug 2026 12:59:04 +0000
Message-ID:
 <BE1P281MB14260F4C5AFBAF610E883E37CEA32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
	<20260820-inv-icm42600-enhacements-v1-2-075a881db557@tdk.com>
 <20260821010924.3761225d@jic23-huawei>
In-Reply-To: <20260821010924.3761225d@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR6P281MB3873:EE_
x-ms-office365-filtering-correlation-id: 94c14054-b57c-42b1-7829-08deff83faf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|19092799006|10070799003|1800799024|366016|3613699012|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 zr3nUlo8UVZ8BxVfLCepfv9uhC/yXRdqUJKIp6YRuvoLDeab55Tv0w0bsXwF/ngkA8TDMKAFgvK7cX0jDrQjOohVCXTRzS3ZKCWgBPSREAjFKawV08Z5XZmxVLGQsucvsCW9Qhy7Dxy6/857/mbGGH+wbAY6RcQzkU6m3YvaFygSubkgKgQiCbJzlZ8J5GC9A/EVqxeB6ko6Y5SiSRj+iTpG3i4wif5BPuDExztQTcuDuNyhcTsC6wSv7fE9qhcXVna3xjITAdD3AZn3Cw0UVolLpPWcGdlMVoUGmQbs5H9N3Vr4vjjmawSP/M21A/rYqZmjk7VJ9FOxmNTtxz4ZWQiIDqidbXNmsK8qR3P0nxraBp3PNdO34z2G/Wn8jR9NJEI75YLCTtNke5bu0p4PFEWgi0qniWU8qOzFwBalktS4I7pSpy9gsOH4h6KdUvTvJBbYR4R1u7cjiUpSLPIhHt9rfYTHXxufbblUXEBchwkl+smSiuCNvcfces5NGdohiB9cSC+j5AFnnWJJleX7ACsgR9U7fvv+DHkr9XhtJXKiHZEZ+rspu1MW9dn2uk9Wzr7Y6llYqW0xO7MvUbyk1e5TevuGtbink16tBzFNrdCyRx2S3rcYlDoC9rUFn2lsJiizhosRF2spbTSuTq30QBVKXaQfa83AHWsAyqaZKbZvUXmh7DxBdX8kZgnR3Y7P/lrx6pK0b8zFSRaLZkbEtwF/2KMsFsiX4uuh2n3mYEM8RaMTRT9mYN4iSELglH0p
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(10070799003)(1800799024)(366016)(3613699012)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVFNanJ3TDJWRFVYanY1Y2dPRW0rSWVZd1ZuZjM0ZDFPUkZxQ0xNekJaYWxT?=
 =?utf-8?B?NW1oNnZmaHlhTGVjanpBREx2UVlLLzRabW0wUDVGWnQ1V0pMVkV5a3lwalRC?=
 =?utf-8?B?c0hDekNoeEZEUjA0UytSdVQwTjEzMVhTMC93OUlaRTQ0NURUVkZYZHV6U3Ew?=
 =?utf-8?B?WG1Ed2NKT1E4ZExDNlZmR1ByVXozd2JDNmx0cmpoNVhBNXNXbS8rUi9sS3VL?=
 =?utf-8?B?MEs4Q3AzenM5TTlhd1ZKVWErTXNZVENoTVVySU9xMWlOZGVzNXF1Ly90Uklx?=
 =?utf-8?B?Skl6cC9vdURSZHQ4R094NzJ5MlB5bUgvRHZrT1h6NHcxT1pOS2xYODZOYVFS?=
 =?utf-8?B?bWtSWjFEdnpQVmpJaTBYcndyYjBpZGlXWjdDUGQwd0tUSTZ4aVU1c2IvcERr?=
 =?utf-8?B?TnJUZU10cWRRem82c0IvY2VnSGs1TjFmVGRDZTY5eVhHd0wrYkdtOS9aeFg1?=
 =?utf-8?B?M2t6ZlhXc2Myc2hFZkRqR2lpMUJmenBweTZibXJUQkxqK3BoY3ZCNm5pb0xV?=
 =?utf-8?B?S2R2UmVXRy90a3J1SDlvZTE1cFBtMnVlT0hBTEF6YitsNUl0cFJwWGxwU2R5?=
 =?utf-8?B?NU1IczF0VTFHbnZPZ2xmM2JlZzZPaEdrMHN3UU9uZEJWTEd1Tjg0VjM1bXF1?=
 =?utf-8?B?c1JZeTN6Yk8wWmNVOUY1N2pvd1FRTzBacDRybDFUWEtoTTVJWFFIK0xpbTUv?=
 =?utf-8?B?WTlFN25TY3dzdnpxWTVkdGd0WnJyNTR1aURlVVNyeXlPbEFsMDk2QWhiSENl?=
 =?utf-8?B?OGlMVUZTWkpZNzAvcUI3V0VYNXVaZ3RuZXpZWjZPS2FFMldTbmErbEVlU2p4?=
 =?utf-8?B?S1F1YjY3N0JIMGpRZDNRUWxRcGF4MU1Qc1E1SlFCOVhjZkZaNmIrRWJaL09Y?=
 =?utf-8?B?UnhvbHViWS84OElkL2xNOFg4ZnlnZkZpbzdRUmpMS28vTmUyZHArVTZFRFFj?=
 =?utf-8?B?RmcvZGF6S2JwM2M1YkNFYWRlSG1adXdHVzJDUEl5UnR1YVJDSC9mZitVU2ph?=
 =?utf-8?B?UHlGZGdvV1lTQmt2WjFhOW5UenRCWEtKeitRT0lJbkR5ZnJ2ZW9QZUJmbEtZ?=
 =?utf-8?B?anR1MkoxZWtkVEEwSDhTclhhaUZ2TnFNd3ZZZ0lqdVdqamxwMkRZQUowZEcx?=
 =?utf-8?B?dDEzTnZEdURJekNvbmpVdFd1aDZkQXQzSDNkR2Eramt2MmtIdmwyNkxGeGhE?=
 =?utf-8?B?RUlqK0R2NE9JclVxZkwwMXRJRlZhNm1EeUlVekI4ZU4zZUFocWhxL0htZ2hF?=
 =?utf-8?B?QjBHanRJU2d5VUxzdGVMYThFVjQwNjZzRTVpVnlwUWtMczBacnYrVm9XY0Y0?=
 =?utf-8?B?cjlPRG1WREJMRVE5cER1VHJFWnFNaXVDSm11N3VlZURTYmVDdldVQlJhWFBv?=
 =?utf-8?B?SVVzQVByZC9NejJUTUFjdmRsZDQ1ZHFNZUw3cXBlbVdCdThQL3lFSnlFejlE?=
 =?utf-8?B?a3V1MGNpZERCZThicEFrSHdOVGpsT0x1L3QvbFhuWVNIYS9keWxKQU9OcjJG?=
 =?utf-8?B?YVpqVGNmeTJoOExlSVpyc212Rm13ZTZ5MDBncnQvejBURFphWllzTC9taFpM?=
 =?utf-8?B?ZzV2SklQT09TS0s1enhCRkhrVnhHUmtTOXloVElpdEFHQTNYTDY2ZE4ra1Vl?=
 =?utf-8?B?QkZOSVFFbFF4RFJtZXhPOTNzdDl6U3dGcGg4ZjRwSFJzMzdjNSs1OTRHSG1H?=
 =?utf-8?B?MVFiRDVYTGpLV0dnd01BMmhWZ0VUQnlkbDZKQlA2bUF0eExnWFVsNFVjUEhC?=
 =?utf-8?B?SGlqY2syYTZDUkY3QktJeDFVZGVoQmNNVEFKdFpPNHV6MXJXbFRFNFh2TG01?=
 =?utf-8?B?MmxHUitkUDh1UXJ4b3g1TUdYRm83QVZYcDZpd1pZR29DMEtTanZ6N0FsMVkx?=
 =?utf-8?B?b2k3NE5RajJUSVBYMHU2NVoyYVQ4dFhMelZnZjhGR3BlaUJSNFlaamZXdGVt?=
 =?utf-8?B?MW5WTExLU2FMQWQ3ME9OeVd1ZEJQN2Y2YkFWblBsQ0pZRGg3Zm8zTm9EcGxr?=
 =?utf-8?B?K1c3ZURwTEpyVzF2VGZKSnpDc05JcVU3bmVQT3U2dHBpdTlBa0dLZHo1S2hO?=
 =?utf-8?B?Y0x2VE9RZzRFUWxpRlliMzFlS21zcnRXc05LcXJrdm9TTEREMmx0QnpSc2Zz?=
 =?utf-8?B?Q0dqQ3ZaOXJMNXZRcG9PbWlhenVMb2lFSHVGRngyeVp4US9xaXVoVWJXTW5O?=
 =?utf-8?B?SzJlYVNqZExaYndqcDBKRXdoMkdTVjdMQldPQko1QkUySzl4NUoxT1hhaWJj?=
 =?utf-8?B?d3BIcjZOL1ZYdVJQY0VGTzA5WFI0bVo5UXRFOVdwZUVrVmFzbGsvTklSSFB3?=
 =?utf-8?B?ZUxObHM2c1VDTFArM3VOVEI2Nk1Ub3lVSVpEa2ZuV1hzaEVLb2lwR0tVYlVS?=
 =?utf-8?Q?QA/uHiE8tfJHJmQ5fQ36hCsXsg2WZd+iATY4kCJGMvkVq?=
x-ms-exchange-antispam-messagedata-1: FkAfNwsiu2Nluw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xWmIIiWY0KWPBWcAszCmfnysAmH3o4iLyVEdnn52cGYHpMqpg3dhaFGEPTMrs3VjlecgjkEvGI7Ef6Y314VctVrqJ9MjLRx8ME6K46oCOFGga0qpXfkiwF2bStoY+BdDXKD0HcWbPHB7zF42p+sGQKlZ882iSWNVWSj37LahhTh9d5nLEG7Lt38keKITzNyRRUYlabKvq1nTtmCrc0deCm8XoyLppsnTcNCJdTYPg7l/c5etjKyIxBTL2atgYaSthPlQyvsOs8TRycZdBCspt/yta4jW2nafWT3SDy5HNyMLyDUS0iT1HcH+tJVlUX+4/Fpre5ZRcIjmD1zE/vBqPQ==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c14054-b57c-42b1-7829-08deff83faf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 12:59:04.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2rCq3kXBnuaxBMIDXJkL9xFyxdR+L7Bg8MqjTctXAqqS42A0zMivQBzDnAA2lFYy77UuFiNiDWiYHv0F92WD7+sU6Z8Yg0H4gF0CwbfZko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3873
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5OSBTYWx0ZWRfX6a6r0BTooxw6
 XDagCCpOvegt6Rr1JP15HlWI4wu393nx8HYjY45xU3sTAOs53x8e8XxUMhToCLa0H2L4KJkM/8o
 u1S8ZbwVLCxCDSTIkuHfUvscC97WH21PYUxOK32YW6YbTzw9Q1SF
X-Proofpoint-GUID: _gpxehYyMmnhFrm1v_Uc6G06jb-Vre8v
X-Proofpoint-ORIG-GUID: _gpxehYyMmnhFrm1v_Uc6G06jb-Vre8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5OSBTYWx0ZWRfXzYT//5JBUjQG
 82lEXRvxIvIUT+DwGWiF26E6UyVksELHTSyB7JHY3lEskarJ5d3S8uOCqIwAn/zXHJfHYBtKAHN
 lfyvJZY06mmvBbFIIfNpAB0bN3ebRu0pb7m5jxQAMyR7PmFEV1DFQnmzQKF/2FfiNk0l8jlg7a+
 fFOK/1YUzwjsnMiMvi+G8ywGaTzDgdeDighH7YGXPSJsNA8oddQpn0BSl1ld25iqnA/MXZ5Tx+Y
 8FYG6EDnVpu1vQO/93akK8fH+qtqSsmkaBuKFXirHxyN75GdnAJ2uJuNFpzIT17eLbS1Lk/g8HM
 KT5S41kHG+W6aZzzoksPBc/UWVbKBT2/yv9WBBpVp2cD/w3lXljsqnv0PfckgQZkbW2DV4L3Wzt
 6nGbeQkj7s6JRegvdauevBvEDWnuQK0ELuFXfwKn3UN9r8DZVL1pWGIwX2LV0GJCJJ8Qskm619U
 VsH7FeGyICzebxfp8Rw==
X-Authority-Analysis: v=2.4 cv=PqyjqQM3 c=1 sm=1 tr=0 ts=6a884ba1 cx=c_pps
 a=IR8Brr64TpGTdnjv7obVRg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=VwQbUJbxAAAA:8
 a=In8RU02eAAAA:8 a=_SPSz89DaulL2KdFmOgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210099

Pgo+Cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5Gcm9tOiBKb25h
dGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPgo+U2VudDogRnJpZGF5LCBBdWd1c3QgMjEs
IDIwMjYgMDI6MDkKPlRvOiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheQo+Q2M6
IEplYW4tQmFwdGlzdGUgTWFuZXlyb2w7IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNo
ZXZjaGVua287IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wKPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMi80
XSBpaW86IGltdTogaW52X2ljbTQyNjAwOiB1c2UgMiBzZW5zb3JzIGZpeGVkIHBhY2tldCBzaXpl
IG9mIDE2IGJ5dGVzCj4KPk9uIFRodSwgMjAgQXVnIDIwMjYgMjE64oCKMDI64oCKMzggKzAyMDAg
SmVhbi1CYXB0aXN0ZSBNYW5leXJvbCB2aWEgQjQgUmVsYXkgPGRldm51bGwramVhbi1iYXB0aXN0
ZS7igIptYW5leXJvbC7igIp0ZGsu4oCKY29tQOKAimtlcm5lbC7igIpvcmc+IHdyb3RlOiA+IEZy
b206IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUu4oCKbWFuZXlyb2xA4oCK
dGRrLuKAimNvbT4gPiA+IFNvbWV0aW1lcyBkeW5hbWljIHN3aXRjaAo+WmpRY21RUllGcGZwdEJh
bm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIKPlRoaXMg
bWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4KPgo+WmpRY21RUllG
cGZwdEJhbm5lckVuZAo+Cj5PbiBUaHUsIDIwIEF1ZyAyMDI2IDIxOjAyOjM4ICswMjAwCj5KZWFu
LUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSA8ZGV2bnVsbCtqZWFuLWJhcHRpc3RlLm1h
bmV5cm9sLnRkay5jb21Aa2VybmVsLm9yZz4gd3JvdGU6Cj4KPj4gRnJvbTogSmVhbi1CYXB0aXN0
ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS5tYW5leXJvbEB0ZGsuY29tPgo+Pgo+PiBTb21ldGlt
ZXMgZHluYW1pYyBzd2l0Y2ggYmV0d2VlbiAxIHNlbnNvciBmcmFtZSB0byAyIHNlbnNvcnMgZnJh
bWUgaXMKPj4gbm90IHdvcmtpbmcgd2hlbiB0aGVyZSBhcmUgdG9vIG11Y2ggZnJhbWVzIGFscmVh
ZHkgaW4gdGhlIEZJRk8uIEJ5Cj4+IG1vdmluZyBhY2NlbC9neXJvIG9uIHNsZWVwIGJlZm9yZSB0
dXJuaW5nIEZJRk8gb24sIHdlIGFyZSBzdG9yaW5nIG1hbnkKPj4gRklGTyBmcmFtZXMgYmVmb3Jl
IHVwZGF0aW5nIHRoZSBmcmFtZSBmb3JtYXQgaGl0dGluZyB0aGUgYnVnIGV2ZXJ5dGltZS4KPj4K
Pj4gRml4IHRoYXQgYnkgYWx3YXlzIHVzaW5nIHRoZSAyIHNlbnNvcnMgZnJhbWUgb2YgMTYgYnl0
ZXMuIEFsc28gdXBkYXRlCj4+IHRoZSBod2ZpZm8gbWF4IHdhdGVybWFyayByZXBvcnRlZC4KPj4K
Pj4gU2lnbmVkLW9mZi1ieTogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS5t
YW5leXJvbEB0ZGsuY29tPgo+Cj5TbyBmcm9tIHRoYXQgZGVzY3JpcHRpb24gdGhpcyBzb21ldGlt
ZXMgaGFwcGVucyB3aXRob3V0IHRoZSByZW9yZGVyPwo+SWYgc28gaXMgaXQgYXBwcm9wcmlhdGUg
dG8gZ2l2ZSB0aGlzIGEgRml4ZXMgdGFnPwoKSGVsbG8gSm9uYXRoYW4sCgppdCBtYXkgYmUgcG9z
c2libGUsIGJ1dCBJIG5ldmVyIGVuY291bnRlcmVkIGl0IGJlZm9yZS4gVGhhdCdzIHdoeSBJIGRp
ZG4ndAptYWtlIGEgZml4ZXMgdGFnLgoKPgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11
L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYnVmZmVyLmMgYi9kcml2ZXJzL2lpby9pbXUvaW52
X2ljbTQyNjAwL2ludl9pY200MjYwMF9idWZmZXIuYwo+PiBpbmRleCA5OThkMzEyZjdiZGUuLjA0
M2FlOWRlZWU2NSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9p
bnZfaWNtNDI2MDBfYnVmZmVyLmMKPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYw
MC9pbnZfaWNtNDI2MDBfYnVmZmVyLmMKPj4gQEAgLTEzMSwxMyArMTMxLDEzIEBAIGludCBpbnZf
aWNtNDI2MDBfYnVmZmVyX3NldF9maWZvX2VuKHN0cnVjdCBpbnZfaWNtNDI2MDBfc3RhdGUgKnN0
LAo+PiAgICAgICAgICAgICAgIElOVl9JQ000MjYwMF9GSUZPX0NPTkZJRzFfR1lST19FTiB8Cj4+
ICAgICAgICAgICAgICAgSU5WX0lDTTQyNjAwX0ZJRk9fQ09ORklHMV9BQ0NFTF9FTjsKPj4KPj4g
LSAgICAgdmFsID0gMDsKPj4gLSAgICAgaWYgKGZpZm9fZW4gJiBJTlZfSUNNNDI2MDBfU0VOU09S
X0dZUk8pCj4+IC0gICAgICAgICAgICAgdmFsIHw9IElOVl9JQ000MjYwMF9GSUZPX0NPTkZJRzFf
R1lST19FTjsKPj4gLSAgICAgaWYgKGZpZm9fZW4gJiBJTlZfSUNNNDI2MDBfU0VOU09SX0FDQ0VM
KQo+PiAtICAgICAgICAgICAgIHZhbCB8PSBJTlZfSUNNNDI2MDBfRklGT19DT05GSUcxX0FDQ0VM
X0VOOwo+PiAtICAgICBpZiAoZmlmb19lbiAmIElOVl9JQ000MjYwMF9TRU5TT1JfVEVNUCkKPj4g
LSAgICAgICAgICAgICB2YWwgfD0gSU5WX0lDTTQyNjAwX0ZJRk9fQ09ORklHMV9URU1QX0VOOwo+
PiArICAgICAvKiBhbHdheXMgZW5hYmxlL2Rpc2FibGUgYWxsIGJpdHMgZm9yIGFsbG93aW5nIGR5
bmFtaWMgdHJhbnNpdGlvbnMgKi8KPgo+VGhpcyBuZWVkcyBhIGxpdHRsZSBtb3JlLiAgSXQgbWFr
ZXMgc2Vuc2UgaW4gdGhlIGNvbnRleHQgb2YKPnRoaXMgcGF0Y2ggYnV0IHdpbGwgc2VlbSByYXRo
ZXIgb2RkIGlmIHdlIGxvb2sgYXQgaXQgc29tZXRpbWUgaW4KPnRoZSBkaXN0YW50IGZ1dHVyZS4g
IER5bmFtaWMgdHJhbnNpdGlvbnMgb2Ygd2hhdD8KCkl0IGlzIGR5bmFtaWMgdHJhbnNpdGlvbiBv
ZiB0aGUgRklGTyBmcmFtZSBmb3JtYXQgZnJvbSA4IGJpdHMgdG8gMTYgYml0cy4gSQp3aWxsIHJl
d29yZCB0aGF0IGluIFYyLgoKPgo+PiArICAgICBpZiAoZmlmb19lbikKPj4gKyAgICAgICAgICAg
ICB2YWwgPSBJTlZfSUNNNDI2MDBfRklGT19DT05GSUcxX1RFTVBfRU4gfAo+PiArICAgICAgICAg
ICAgICAgICAgIElOVl9JQ000MjYwMF9GSUZPX0NPTkZJRzFfR1lST19FTiB8Cj4+ICsgICAgICAg
ICAgICAgICAgICAgSU5WX0lDTTQyNjAwX0ZJRk9fQ09ORklHMV9BQ0NFTF9FTjsKPj4gKyAgICAg
ZWxzZQo+PiArICAgICAgICAgICAgIHZhbCA9IDA7Cj4+Cj4+ICAgICAgIHJldCA9IHJlZ21hcF91
cGRhdGVfYml0cyhzdC0+bWFwLCBJTlZfSUNNNDI2MDBfUkVHX0ZJRk9fQ09ORklHMSwgbWFzaywg
dmFsKTsKPj4gICAgICAgaWYgKHJldCkKPj4gQEAgLTE0OSwxOSArMTQ5LDYgQEAgaW50IGludl9p
Y200MjYwMF9idWZmZXJfc2V0X2ZpZm9fZW4oc3RydWN0IGludl9pY200MjYwMF9zdGF0ZSAqc3Qs
Cj4+ICAgICAgIHJldHVybiAwOwo+PiAgfQo+Cj4KClRoYW5rcywKSkI=
