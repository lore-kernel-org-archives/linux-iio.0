Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD02ECD3A;
	Mon,  6 Apr 2026 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459116; cv=fail; b=UXJt8avqe9MWjzsjtUWM0c2WSdEYWGI3ecfuQr+g1SFNEhqs5lDoMPNvqZ1uZu6JDlk11e0IQL55G0puR8nU1qNajuyB4cvTh2TV8bei9Xa3fgZe73vrtbfr6CkYSsjgIbR9/IJGVUHvBBiS/v+6vq2uU/TBYMZlNDGOiFd7h9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459116; c=relaxed/simple;
	bh=LFFXGFpYkBZDWMcexE/s23hjSPkUAhqg2hXgB5ZY6m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CXbN96UJxFfUACOGBsiLvDhlb7ll+oWItPS9pf0Nz3YSIhPMPs0tbwdB58TwSfVJnPpWFPLZsD94hyD+QxcLuACrfVRF2Mzt/XmwrQWgP2ebgL8vP0SVvGPqp0aFw/r3/2vXYzD6T3PI3vDEwvP7xXJx7n0o0aLw3yoRwVWRR/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ptp8T+BA; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ptp8T+BA"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6365st37413412;
	Mon, 6 Apr 2026 03:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LFFXG
	FpYkBZDWMcexE/s23hjSPkUAhqg2hXgB5ZY6m0=; b=Ptp8T+BAMtmeLhCzWU/R2
	hbY7d8jcGulLKkI3ZNoWMsEPBzItYy5LnC0KhULwQEFbBVs/sc8/8SC3h2K+/Gd9
	R0kMG0LVXKI2z0Zlc4IQPqK4iIg129L6yA+0usBGKB/7Shgex/yxphutzTRRIwyL
	ayJGuilSY7VKuLwbpPIqMXBiHvktVkEx0riEu4MPw+g+PSEnvnNF1whB6mZxTm8c
	/PPO7mTXA6NC3WoaDIl7ayfnszHgY3HR5IjoZlEpGRxeIv6VoqSobv775SKuUfuS
	i93Oiip1VsPI/XN1t7JMid7+O+ND1n5MhsNxVtlOcQp2c254R9lDPv++RRuJ4UIN
	w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dbmpfjqhe-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 03:04:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSt5OXnSKaIyV2GTu0f7Ck0tcpqwAnA3r7OLwNAV+8UHlwPS4syWgMLwTN/aq8S8TLYK4ULB0hsQ55OqL4/FpBKuYFsV63foKtk4ms5+U/LAkXTSZ12HeOMC/3XoJhjdx3XO53j5EmIS7cueVfLsa0iGhKSQGHMObgVwrvlAg4w/krFbxmgkSZY6Gu476lUgHVuq24T0tT7MnZ8E89sdK81MkG81mtloVqD/x+yk/I9EbEcHwVEKXePYXw3LkOS5igp/N1CN+gDHLLQL2xNghmNeBXUqxKT9Moky9Z7uviA8baVfWIJ9zskRw0BwLnEK53eCIoMphQ2pXUkfubYQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFFXGFpYkBZDWMcexE/s23hjSPkUAhqg2hXgB5ZY6m0=;
 b=yiKZHJWRPNihXQq5roFPAHLBHfjas3rPv8NUvRyIgpcV0N5fkIjByDx/gBzb3CwF9gL9r94QXU6w+rNs4yVjinFSeuKHJpy8+pz4zC/JiNMzERedSQz+XkBQ55Q4gyBsGWiflCWjFWifKKeYcXJwg9pg3xqxhDWXupTQtI+Bs0dSNIzOCKRbWwAaEblGYrfQzukDCdH5b07qGvObTLJdP/ywODFBdzialEznHGq1QKtuktxQeR7ONWXLtAy949rAFSq4G6HdZJlrTK9zHg7WEXJZ1dJk6TYR+etQOBj2F5dQ5jYokY9+o4mnmxB6OcvfuyEBZ5FYDzJG5dA+O0PeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by DM4PR03MB6079.namprd03.prod.outlook.com (2603:10b6:5:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 07:04:48 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 07:04:48 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Thread-Topic: [PATCH v4 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Thread-Index: AQHcwcEwFSP3qi3Xf0iM5zA1if3l4rXLWTKAgAYjnaA=
Date: Mon, 6 Apr 2026 07:04:47 +0000
Message-ID:
 <PH0PR03MB6351DF2BA8F16F72620C34ABF15DA@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com>
 <20260401-dev_ad5706r-v4-1-a785184a8d53@analog.com>
 <20260402-new-venomous-groundhog-e646ee@quoll>
In-Reply-To: <20260402-new-venomous-groundhog-e646ee@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|DM4PR03MB6079:EE_
x-ms-office365-filtering-correlation-id: 8ce64a0e-c8b6-4809-1084-08de93aaca45
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Wef9Y2iXei6aZ90PVQSlcEgRTDxx5IWRmjD5Xc7ZuZSD3UOzeqUuBnewejyQhxfoIt29Xy3a77txk1wPRZp6x6OWraY8bRLVF3eUMe+45BTMbmT5lroSbGL9MW3oeRAj9vFVGIwPhysxzH5RyCcKaCKuLrzoRwY4l9t4Q6xVqno+9FwyE96aYAi2ERkgxnv7/ERjv/iEKleVf8wnSzMFnWYB+0FuxKm+cQgZEMj0sscvRt+XJBb+B4BeKu7pbMgPdGBv+fxEoe++aoNtGe6X3NWSDoOm3WWv7qUd5+BH7zekNWsDVRnKt3g/CRwnL49m3BjlEMamSOgyNZ1jgCJFUfIDwcuw6sd5ZiA6iXqg/UpSDdNgKQPbryDyNDGo9yyyt/tC3IKAofnnzH1DV+e3TfnFNW2AKxxHi1S9ofWXeBu0Zwaa2QP8W9mYlsroIbOQzCCoQhFlAQ+rwvv9htoTlCabcFJ6IjJ7ncUyhVTZvuOFateJV6j6BwqN2dbiipHe+2anC+fsbIKon4PRJN1MzovT17R8df80+u4JMYBpaxnU8fOvYbwFyfO+xPomvyMxWfI5kA7i3VooTJJmWmmC3CKdbN8mFRtUT0RMeRPTBtvZDOv2wnSFMhSbZ5i26ejkcgXfqVjs0QCRp/DVH3PRXuMZ9YZ0H30IQfA5LJNM5uO4lQ4+demL4aDIkk0R2lEQqz4epwZRSFjTTaEphOXJL5JUqCZhWi52VL6PNxxH58bRn8TaoAecoJ4DQs4VhC6awtijHEMEIs0YUoJUj9ca5mPWxIm13vHPM82DD6MrtxU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlNFU0NyUkY3VXlYVXo5QmZYSmtzanppdDk3Y2lIYjZjRXNGZE9wVzlCTmhs?=
 =?utf-8?B?WG01Z2VrVlZLbEQybVdRaEFydjc4ZWt5NU8wTDNKcEFNWTlHbk9VWWtKbEdn?=
 =?utf-8?B?bnVpaDQra1NNOEVsQU1BUVZDWUZTcjVONWR4aTRYdzVuTlFvWEJ3ZXR4VHhN?=
 =?utf-8?B?U0h5VEg0WUd5NWFIOUNqSzVBWWtKSm5tZlRHMWlOR2ZzNlRVTFNMTlFYb0Fj?=
 =?utf-8?B?MkVVUXpjTUVqLzFYRnJrdkZHYXl2Q1JKY2MwRG5EeUh6eC9xdzZCS2VWWjZx?=
 =?utf-8?B?S2kyU1pWbFdvdkVXK0JVbVNnTnhBaXM0dDhGVG5MaCs3UEJIbVVzMEZpdDVS?=
 =?utf-8?B?dVdtQTYxZjJjY215eXVRN0pFL25STUM5QlJPR1FkN1B6ZlVqZ3oyelJOSnBL?=
 =?utf-8?B?YTEycWxuY0lxSzkrVWlGbHdIQnkrWjRWbGpHc0JPeFdEa2hteHFhbkJKUFFK?=
 =?utf-8?B?VnNBUVdFM3AxZ0tIdmQwcXJsQ2RpRDZaaGNHQ1dyWStSQUtJTnRhcUIwT0Jp?=
 =?utf-8?B?NmMrSi84b01aeWNTRkhBRFZnaGJxV09nU0JmQkc5YlFhak9Dd3ROQkhlYmM4?=
 =?utf-8?B?V1Z3RHJNa3N2cmszdnc1dk1tc25tVVZpcmRqSG9PSWJCWWpRcHlpUEZjOHhV?=
 =?utf-8?B?cEVYbEZ1emozWVJpR0RESUNTN3NGbEpNSVBaSi9IR0hkSXlxeEgwUjhXNVQx?=
 =?utf-8?B?eUN2Vk9WNjl5TmZFbnZ4cGtnckt5VTlCSytjd0dKenZLQkFEOURVMnBxU1dy?=
 =?utf-8?B?OWZJdURCTGk5NnUrTTh1eHFMREp4aXk1MjVtdTlleFFvdEY4cnNXRVRkTnp0?=
 =?utf-8?B?NDE4WTFlWWFwR3EvVDZtY0RjTGZGTlQ3R2lUWk1qaVlkc1hrWnNLcnZmbGIz?=
 =?utf-8?B?dmgzWmNuZTNsYUZicFozV2JmbVU0Q3pXT0x5emgzaXlWUXkrY3dBdUNHcFl1?=
 =?utf-8?B?TmYrWlRqZytyelcySk9UcXpGVXJibzdUdHV5RVdUTWExTFl5RmY3aDhXc3Qz?=
 =?utf-8?B?aDU5dytkanBHcTgzYU5aSlpyUEZhSzh6Y3RjTUk3SXlxblBmaldFaFdZbFlp?=
 =?utf-8?B?QktUdEZ3L0lhV1lyajd5elJoVGZXUWdzK0V4c2YwcGJOY1ltTTZiR01IT2RQ?=
 =?utf-8?B?aUVTT0t5Ykk3azVNeDFDWUNIM0lORXh3VzRUbTZubTNTb0tYRUdEQ2ZraW05?=
 =?utf-8?B?ODd3dXFnMG90SWhEVGNIcktrcVFnVGtDUm1iaW9DU0JsMWdOQ1RZcTVzTXNN?=
 =?utf-8?B?UEo2eUxpUThFSnk5Vzk2dnJSS09aVnBrWjRmQjlGOGd1YnI0N3NHc1R6b051?=
 =?utf-8?B?N25QWWtvekV3NEZOUUxRZ3NnYkFxaGtnMlN5aVFTRVlNRC9SM0VGSWdWRkE0?=
 =?utf-8?B?amhhK0ZrWVlSVWlEcEdiTWdKdFI3WXdUNHhWdW92SlZOS254UmhlNTJadXUr?=
 =?utf-8?B?MGdUSWZ5YmhTeXJaSUFwOWhEb2ZhM1pLRkd2cWI5RnIwRERtS1NCUG9sWCsx?=
 =?utf-8?B?UCtUcnRwSnhkM3djc2I5enpEaG1qakdNRTltRUlQOGF4Y0c4N1dVTHVRM0Vi?=
 =?utf-8?B?dHc2RkU1d3R6cVBSZVJUUTEySEdvRlJ5ZCsvdFk0UXZOVmtGSE1zMUxkaXZa?=
 =?utf-8?B?RVJEOHZuVW92OWdlNUpTMWZtVTRaYzJoZnR3QkkrRmFkRk0welZvUlRneDlz?=
 =?utf-8?B?d1JrKzF1L2RUdXBNVEx5RHhZWkp5bC8xdmYvYmNIaGs1N1YxMGY4MEt1UXhE?=
 =?utf-8?B?SytmTE5RMmIwYUZMdzRaRnRZVHF5NW1ZM2RxLzAyK3RCT3dReS9oUW1RSk9W?=
 =?utf-8?B?SmJuSGMzYnRvY0Q4ZytYRUtwSnRnVWZwWmpoWVk0UUVweFNPcGwyMUdMcGo0?=
 =?utf-8?B?QXEzNThnNS9lN3loMlphWnltbG9LRmo2UEZld0tFMzNLQWJ3Qm1FaHdFc21j?=
 =?utf-8?B?U2o2MDJJQ0p5cGFWczlwTlJ2NjlKaG80UWFGL1gxRlZXeUc4bEdvb25xMzBh?=
 =?utf-8?B?Z1hjVWMwQkZwM1VOTzlROTBzbUZTeGZpT3pmV2VTaklDUWg4T1ArMEo5ZWZz?=
 =?utf-8?B?YW1DRFFldG5RWUFkeCtqNkF2UGZ3czd0RGVaaVhBNnhXcmJIZ01UT3dBaEZw?=
 =?utf-8?B?NHRWMVcvMXgxVVo1c1N0YUQ1akhsTnJ6YTRDVXRuMWdxYUxlMzZPWXhZZ2cx?=
 =?utf-8?B?OFVyN1JkMDYxdnh2R25OTWJsdkZ5bWE3dVNQWkFoRW1XZ3FJMnJkTGpKcjdQ?=
 =?utf-8?B?NHNCMitVRGpCMEJuRnJYcDZLdy9yYVlvUDRZa1FEQzM4WUNJeUxucXhpbitU?=
 =?utf-8?B?QnQybVpYZ0lhc0VJMlpSdDNUdUpFejJRRW9RSXo5K3FmU1BncFp4Z1BtclNO?=
 =?utf-8?Q?plkmiIJlOJ05ExhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hDmPU5jJ5B2zSuT0g31mvJclOkRHBcQnWegdMARXa+ME18qr2Bd9/e4AGMkgml17K8cDRQUHSXRNAhcyggYKN1IaTlMhf419ZNpm6m/mxs09wzP8e9boP2mGbU+CLTUnc9xGowXrsmKTQ7q8Le5EbtpLUu5uY45t2qWkL/oiKHDbS5uH2s0Jy/X6kOHJlj8TKl3DT87e/Ax+pynd2tc6Ir0q/gK5GBU04MzCVZpYRK2XDWRgHE+WE2Mjiw9lSfGJAYHsNNAC9zVe31MmmqQ+7t7hGblKxzaqKWLZGSD2dfp5fHDh/+Ozscvq5AvP3+DX5zLqpF/By/ZidwUXUPTVbQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce64a0e-c8b6-4809-1084-08de93aaca45
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 07:04:47.9974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIurKBeK+tTWfFVpg56aIPhVkH6697jasNMHDZS36ph+NWfzsXjIEAnIifvqZm/KwaeBvfg37MSVfQgMINLdRfgdMOQf5osRL1N0M0FNcew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6079
X-Authority-Analysis: v=2.4 cv=UOvQ3Sfy c=1 sm=1 tr=0 ts=69d35b12 cx=c_pps
 a=zYHeo5UF1QI7fA+G+QDVSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=9Hd2qmRyQCjVzIiG3EkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mCtGmMEndVGRLFBCYMa4vrYma8kgEV1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA2NiBTYWx0ZWRfX9k+1mbWK5Czo
 7W8IS+H0iDsQFp0ACBtSEgNp/thNhgy0lY7KN4X9QuaopHpSrS4tmvYCnaCOhOvPQz59UuXYrJ0
 fhUvTXk9tervTyyOsqIuknO7x7Tbc1TtXbVeLquZ+2mn9zbc0kibbsrccSImA2hcNO9rLawqnrB
 3FSwXnAsbSidqDXrI6d1Bh0W2zFAcito/C9aH9tF6nr+7Yf5zfUqvTwiOgNaAZ8ugMuXzKKuhx/
 EOkNhrCTf+06CMK9FoefL5/GI6zVQkdfgaM7NmpXDX7Atpb0QpW9mX//Cb6P2T8eGY9WnokuEKw
 lLQeOTOyCOAxzuwoyjo72Pk95iK0QLBk88GjlTyTWJu8DTnWZ6zhE5aVYXxD0mrbujg9r8wlBf0
 S8Awt4KK/tRbsQkzca0JMxC6s2X5EvLIwgwJannA9XRRmfEqTUbN+XIWhmIgRJbvA6eyhOwa2sy
 nfpI0L8O004co7xy6FA==
X-Proofpoint-ORIG-GUID: mCtGmMEndVGRLFBCYMa4vrYma8kgEV1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060066

DQo+ID4gKyAgcHdtczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICBkZXNjcmlwdGlv
bjoNCj4gPiArICAgICAgT3B0aW9uYWwgUFdNIGNvbm5lY3RlZCB0byB0aGUgTERBQy9UR1AvRENL
IHBpbiBmb3IgaGFyZHdhcmUNCj4gPiArICAgICAgdHJpZ2dlcmVkIERBQyB1cGRhdGVzLCB0b2dn
bGUsIG9yIGRpdGhlciBjbG9jayBnZW5lcmF0aW9uLg0KPiA+ICsNCj4gPiArICByZXNldC1ncGlv
czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAg
ICAgR1BJTyBjb25uZWN0ZWQgdG8gdGhlIGFjdGl2ZSBsb3cgUkVTRVQgcGluLiBJZiBub3QgcHJv
dmlkZWQsDQo+ID4gKyAgICAgIHNvZnR3YXJlIHJlc2V0IGlzIHVzZWQuDQo+ID4gKw0KPiA+ICsg
IG91dC1lbi1ncGlvczoNCj4gDQo+IElzbid0IHRoaXMganVzdCBlbmFibGUtZ3Bpb3MgZnJvbSBn
cGlvLWNvbnN1bWVyLWNvbW1vbj8gRG9lcyB0aGUgZGV2aWNlDQo+IGhhdmUgbW9yZSBlbmFibGUt
bGlrZSBHUElPcz8NCj4gDQoNCkFoLCB0aGVyZSdzIG9ubHkgMSBlbmFibGUtbGlrZSBHUElPLiBZ
ZWFoLCBuZWVkIHRvIHJlbmFtZSB0aGlzIHRvICdlbmFibGUtZ3Bpb3MnDQoNClJlZ2FyZHMsDQpB
bGV4aXMNCg==
