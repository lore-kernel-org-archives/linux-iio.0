Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D116359703;
	Thu,  7 May 2026 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161961; cv=fail; b=S/3Gg8eInzoSiLn1p6aSsJ0n7vEp7oRrewlI/zwpcK1gcYBCkOakCy+dJYxKX7n9Dbm6KAxAPQvpB1qa+UJ+T07CDk1Jbca4PXGoZURcJEgisvSXFfH+Jfzg0tdqwWjrLiNiP2oppSOer8ySJf8JgyF7HTJeKFMiYMIm4NW5vNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161961; c=relaxed/simple;
	bh=h/EpUhFTVnhjRMc5D5aJOMgt1mpWHYmmxs9dqVy8lo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BnAvIMpfuNfgB+muDp4/MjDUTVI94yW7KbYGZ0+v6Y+qUiQDFq1BMa0qh2QpB53EAbWSdVd8BEx2mVoNQmnmLXCtL25URw0wQSWstJ5UtAgvhxF9nKSlsp9DKvc09Rpw5f2VuCFz5OnDkKzJyFV+21sBZhFhoyYJpPHfam+nYHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GbOSHACn; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GbOSHACn"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647A1oAM493567;
	Thu, 7 May 2026 09:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=h/EpU
	hFTVnhjRMc5D5aJOMgt1mpWHYmmxs9dqVy8lo8=; b=GbOSHACnlMVyPd6LRPYg6
	Jb5srLsaGCS6wGoN95GQPlKGDFc0KG1IyzV0WiywUcAauieYLd9EgkAmzK9Gxf+4
	hFriX88RWwCU0PkrM389LpXfp0gOoKp4w+YegPP79fSbxKhgXBSGUWxEqDXdJtcn
	F8zhnm92O0xhTvgqFFCN2qyMwQBufJ349h7eKZ6C1ad4kVungqJzkGyLt+MctoGL
	ywMzWjhxcG+IOeUZF6jahdoImsRk55ICywzZMmTEppp4moTspq4itC9SfVXi74kj
	+f0tbjlv1Z9+vxEBflb4asfvElLxmMBq83GSPxp0nDsM+r0XcN6LYr2sATcJtGsK
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dycmx2mue-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 09:52:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAExPrdqExC7tLgajBLe/mJWCQ/aD6hil0pTMHH3mqhR/tGHeqz5p9wri+nhVQ4+PS3EaaUKcPwdOFrRJkIyaXiwt2s5A9Kp8UrQ+yNQylFWhGLzYr/dANZ0bJg3WPzjxBUdcFfwRlXTpaChezOHWqZbHILJeNk7CQ6xYlOOFbblUmbpLqTF8MzL8x7Zcnlh5HtAKiNk95RmkZcn98uinMcPL2r2oadztE94b+r+2ekSUTm9mmPL/YslOUP16rVcGcgVABrtsFFtwDBW8ksStmwYjt2lmuDr5cbd5GG9luOPecTBuJOc6dwl0YJ/R/fqNkEQILe+Oz1ENRU1pyTDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/EpUhFTVnhjRMc5D5aJOMgt1mpWHYmmxs9dqVy8lo8=;
 b=oJEeEA5KmRWj4Y4ydhA/PyOPbT5qRCfgZrYN1dC7RHXvpWkgWwvhDj3+lXOMSVAiSDn8zRlFn58/8aVSBScJFQFzEVx+ibe55KAvZAx5sQTSkmcX5NO3+yC2klqr1JEXERZdK3kB0yl9OoLzTDbivB5bKwNqnGYgl/YhbX5v7NduTUoVFK7BPioRicX1sdIt95LmR3S56xOC67bTTCKO9QXdaaTB1P5Qmc9imbHUjiRbtjP7YHXw+GOpPnyE+c5Zp5qrwqHeJR3s89A4s2cZ4WX2zQt0INc8Na9NWoZYUyfmQ+uYN8Y07UjBB1I510REmduY7h2XFTneinIVsB7DjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH0PR03MB6081.namprd03.prod.outlook.com (2603:10b6:610:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 13:52:21 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:52:21 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Topic: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Index: AQHc1xVfa1WYdTQUw0CFFOByxUryxLYCiHmAgAAZ06A=
Date: Thu, 7 May 2026 13:52:20 +0000
Message-ID:
 <LV9PR03MB84140625A4D0D32174303304F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com>
 <LV9PR03MB84144C0FF2FC2197AAFED941F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To:
 <LV9PR03MB84144C0FF2FC2197AAFED941F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH0PR03MB6081:EE_
x-ms-office365-filtering-correlation-id: d6c432a0-e68d-42db-d6f0-08deac3fdc35
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 T03V2/VNhBlAb/jbO+EF0bYB9M9Npze9DxtDLyk1WFMZvBKXFCy5fSvv8GWEMjqz5S68+3tnvLqhA35xqdM0LBU7NX+o9lP8GvVjK6j4/VALrsitzM9ndFr9FDPln7XA5av84iFTPTcav7RsI8617xVHgycoNGWvc++s4gQ9BXz9XbF1i+eqipGgDpzkQ9WMuF6uDHOLUJNfzWCusAmEXQcd+YKzS8/PKCPDjTmkfBNQnOQEYmHHYIR7if+E8X9WWI15s8cIi0s/S9ac1XtX+AAI/RRCCN5GgwjAmP1JI6o2HJzn+rBb2A8UPa2PinoQDam8xOFZxpwyTei+IbfSiGLFSzcpfPJ9A95X4SewQb6z7QlN+dS98odGyNSQ4ScX1DQqAc2BvR7R+k3q/HuHx+rWaVFF/e1dEAGHl0Oyn+MDZasbDcb1ZSkIwTnhkwAn+/K8hwY95jqGFEqzheTGD1jTIw8tR8mYYG0f2gwrbHSkCvo4YzlcX34hvrposbVpfjXBeGHql1fUZ9jXPYjw1hSCLmuVShqFyN2nVLtfziV5Y9HmsjfY1S6GC8k58ymk9t0OYcaC7VgT3YtGxNW3rDWv+yeYXDYkLbgfgoaTYc+tP1m0+4YtQj0wPWdQWYvbwFy9xgn2IZu8ofr9mQp/PA03Yaf4eHuLkyBsaHJblhsc1mZfP8UogyjmVGv2Lp1Fe2AMIvpejXWHEfIhk8+kqg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkl0ek1NRFIzTzFqY2x0b2JvWTlLV0t4czZaZHo2VzIzNDJORmpNVEQyWjUx?=
 =?utf-8?B?WWVpNGpmWXB0M1hBc3RnRkd6Q081NytTQ2p6WTBFRkg1NU80R2V6RUQ4ZmpJ?=
 =?utf-8?B?c1FCbElLbHpPUERZTXZxVlZHa0pwSGhMc0Zvdzl3T3pNQ29Nc3NiWkRXOUlJ?=
 =?utf-8?B?L1pLSHBiTjBYaDFEamVGeHBKeVJwMVB1cm5kREJEWHFFY001eHBqNWttalBw?=
 =?utf-8?B?aTR0KzI4aWlGWmZ4RFArNmZRU0l3c1hzdzQvWFI4a2RiZEp1NU52T0dRU0dD?=
 =?utf-8?B?c0xsWHp1cmJxbkxFQ3RKK1hTNjA5RnI0ZGVkMzdNOUFGY2J2MzJmaFZxbkxS?=
 =?utf-8?B?NmgwbU50VTJlbkFCeGNuWlJrSWFIa01KcUxXRFlTcHhXak95RVVFTi8vaTVp?=
 =?utf-8?B?QWZWWVN3TlFGb0I5U1V2TU8zTVlPUG5YZnQ2d0tzemxlaCsxRWhsZFkzVExV?=
 =?utf-8?B?WnUxNzM0K1ZtaDNQOWdSdmJqOW4wN2tPcU93ZWhKN09DWUY3bHoxS0pKcjlK?=
 =?utf-8?B?cmF4d3JhSTkxZU1IZ29RaERoQUthek1tNDhmVFNlZno1elF4Y3NLR2MwR3hp?=
 =?utf-8?B?dVhPdGJtM3RldzBJRHMvelhQeDBXOVNmUkNNb3ZiVThTSlBKSHZzQkRTcWk4?=
 =?utf-8?B?ZzZRR3VJRHpiaVpwQ3dYbXU4QXVpU0dvQ1VBTGtOMmRMTWp0cUVxZWRIN3Jh?=
 =?utf-8?B?M24yVjBvenYvTWkzMmNmYTJmUUdaeDBVVDdNVC83bzlUNHBieitPR2FMeUpw?=
 =?utf-8?B?L3VKVHlHUGxNbGVyeEN0U3pDeGRJcEZ6UWRva0ZjVmIrMkRpSGIvVVMxdmor?=
 =?utf-8?B?M2hFNEV2dk9OM2srZGtqeVJpTjA1clBmTDZUOWhlRjdnRi9CN0dvV1pjS3J4?=
 =?utf-8?B?TWI0NVhmdUdPMlhORHRBcnFMcU5qNW5GMEN1UFBTazhKMjZCNFlxMk0zSVRP?=
 =?utf-8?B?ZnkvMnd0OHk3TGFab1YwM0NGME1IUThWbnJ2Q09QckVIamJPbHRBSDJvY08y?=
 =?utf-8?B?S2pNMStBczExR25VUk81YUt6d2JRZ0kvaW9EU3lCcS9FOE1TdzN2bDgrNE1v?=
 =?utf-8?B?dnczcHFiaXFlYTRobVV6RGhuUlVJOVl3bXZTZ1hOSnpqOEdneklqdk91VC9I?=
 =?utf-8?B?Nncwc3RZczZxSzNDL2F2cks4ZE12YmsvTE52anBsOXhjYm1IODRnczk0Zmow?=
 =?utf-8?B?a3lVV2hQeHdEaUF4aURBK3VTbWFkRlZKMnZLS3l6dWU0QUxiV2dNc2ZySHk4?=
 =?utf-8?B?OHRzN25oT2VmWWxHNTZqT1RReGc3VnYveGIzbTUxTWV2cllid1NwTFJpYTJy?=
 =?utf-8?B?dU9yQnpFaC9POENkdFdDU2hVb0lKcm5zeHovT0x4eGdCRDIyMmZmb2kwc294?=
 =?utf-8?B?THcvSFFYVzE2c1NxeWtTL3ZBUEdUZ1VPZXZWZmFDWk9tRVhPRUl3aGRHdXQ1?=
 =?utf-8?B?cmxPdW1zMG14UlpJb3FZZUd0VUsxd0ZuQWx5bmk2MUJpK3ZJeXJKMWdvaE0z?=
 =?utf-8?B?b2tVQWJRZjBZYUVMaVZOYzZyTmRBVlQrM01lS3Y5TGo0c0I0bXIxY0lSN1lE?=
 =?utf-8?B?b3B3aFhuaTZGWXlHczBiTW1iM2RwMXlkTldyQmV3RnY1V2xkNnNwQVgySzRp?=
 =?utf-8?B?OHF3TWk2ZFBzaXFRN2FvQlBzMVJvRk5UU3kvVDljdGR2OG52TFFkRzhJdGI1?=
 =?utf-8?B?VHVMS3ZNWVNhNXNnK1Npek0ya0NvS2pPQno5Y0J6VXJOQThMY1phWloyaVZG?=
 =?utf-8?B?SmdSRVFiL1E5U2ZvK1JQa1BybEc3MVlJNDVmVzZmTDEyYWkzVmJuZ0xaOHp3?=
 =?utf-8?B?MTduYkY3L0YycWxoSnBrUkJ2dnZlSktVSzdCZGRqQ0hQSTJTbEhxU2dPejBn?=
 =?utf-8?B?L0JOZGg0dmdKaGRweDhTQWVhUktYVTZuRU1ZWHNjby9hM0Vwa3VxZko2WEVn?=
 =?utf-8?B?SGlSdWI3TUo3UmhjSytjNWhDSzJWTkpwVWpnbE8vZmVJQUdrWVcyanUwemQz?=
 =?utf-8?B?Z3pmQkhtc253QkNZU0Y1NGpSdFZZcm5mbUJWRmxMNmt4Zno2YWFKbUprKy9p?=
 =?utf-8?B?Q25DSXFWYklRYk5FdlBMaWZKbWNzVldGQTBBK2l5ekZueHBiMzg0cnB0MGRu?=
 =?utf-8?B?UFB4aEs2anJXekFYbHdwbVlGTldSUklaYUxCaTljWkJJM0NVeHJ6QWJkZTRr?=
 =?utf-8?B?dGFJbWpKYlptYjVyOWpqWkNpUGdzWVVyc3Uvbks2Y25xS3dsUEtBeTB2YkpO?=
 =?utf-8?B?WFFJS2tiZnFHeksxY1dTK2NsU1Bod212Q0RUYjY0WEhkcFdSaWttdklmRnRD?=
 =?utf-8?B?dGtpbytDSE5zUWRldkIxTlV2VHUvVUtzWXJiRkc2Z0lmWVcrbWJDQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jAokX9l+Un1SInbAwRF08qSXsdky4CTVL/jOjhfUqese29HBZ5mpi5wfqsbZ0tBVxxKGq5IOQljiBy1kWGsDPP/md2mXtN5AyzOfbcVXrJ0M+1vYI0Cu9c/6uXdaulZ5ZVvOJOhT6cN50j0L0DWcxC3FpMx4Aa9wVDHNvNZrYKWY+vySLBOzdA+PIiQ81nmBnTYIpBVRbXznLJjBCXWt01XiZxeYhE89376gB63Vo4NNVPPunZmV5sjo6hhoqxXnHy3OUkQAwkFFiO1rHqE4mXWbMjfGWrsktgQkqS++Z2n7Xjz0dEFQ771P5hEovleWKK5rIRyhv+Oay0/IvsPVbQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c432a0-e68d-42db-d6f0-08deac3fdc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 13:52:21.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/OFAwSII+EEzPQGKMo0pQ/nOM4G7XZwtHW9r1TXnsD1Oc2rM0iEBflFdcs0nD5zXmm+/UpdGxBW4imSSaaOIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6081
X-Proofpoint-GUID: qthChxg9nhQIEb2MNm1upm62QlDyIRlE
X-Authority-Analysis: v=2.4 cv=C6/ZDwP+ c=1 sm=1 tr=0 ts=69fc9918 cx=c_pps
 a=2P5E0MqkZ2zb1j7CzKDU6Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=c92rfblmAAAA:8 a=gAnH3GRIAAAA:8
 a=PxHQvI_G-ny2bp4JgAkA:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzOCBTYWx0ZWRfXxzXtXhNsdty8
 3xC9s92ZKrv1mbkxo3bJH8Dx9AVRQpduLCgbACeOyyP5mMUk/gFdI4MFKnqsl+tdqFmPxOshPtJ
 VF2LMBbvvjKEloPROfuq6exT2m4+OSsrt8emPkoyDpGHAar/sZk4X8A6VnPfeKWES7Qco5eBIc5
 T10Ki6t0DCCgQq4mSHd5vLXDcSpdIXLM6FRlxaF3ti9bFMyxUlHqfLw0FUty/Mf6hdb7aiEfgoY
 jX+2aSJtJezx28Eekw1X+djmBqpMNaOMWDE/k6MJFYzEY5dDfWyy6DED+OYbTHx5ebnxTaKvmDq
 SBAiXFqPF/OvwUBCANZXBIK7RiEWkoli7Lo0Bd6k5fg+jR40OQIiFSQZkyo90Y4nnLxpqLuhezT
 ptP82KKuIudaE1Lly89zZWyf9bzvx9U38o5w6yU7MNi415fq0BuVbiv6wreykqVUx0yJwY2KNrP
 5fpe8o7UDByvMSZTnFQ==
X-Proofpoint-ORIG-GUID: qthChxg9nhQIEb2MNm1upm62QlDyIRlE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070138

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWJhdSwgUmFkdSBib2dkYW4g
PFJhZHUuU2FiYXVAYW5hbG9nLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSA3LCAyMDI2IDM6
MTcgUE0NCg0KLi4uDQoNCj4gPg0KPiANCj4gSGkgZXZlcnlvbmUsDQo+IA0KPiBVaG1tLi4uLCB3
aHkgd2FzIHRoaXMgZml4IG1hcmtlZCBhcyBDaGFuZ2VzIFJlcXVlc3RlZD8gSXMgaXQgc29tZXRo
aW5nIEkgYW0NCj4gbWlzc2luZz8NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gUmFkdQ0KDQpJIGhh
dmUgYWxzbyBoYWQgYSBsb29rIGhlcmUgOg0KaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0
LzIwMjYwNDI4LWFkX3NpZ21hX2RlbHRhLWZpeC12MS0xLThlM2Y5MjVlZThkMiU0MGFuYWxvZy5j
b20NCg0KVGhlcmVmb3JlIGhlcmUgaXMgdGhlIHJlcGx5IHRvIFNhc2hpa28ncyByZXZpZXc6DQoN
Cj4gRm9yIGRldmljZXMgdGhhdCBsYWNrIHRoZSBvcHRpb25hbCBkaXNhYmxlX29uZSBjYWxsYmFj
aywNCj4gYWRfc2lnbWFfZGVsdGFfZGlzYWJsZV9vbmUoKSBpcyBhIG5vLW9wLiBJbiB0aGF0IHNj
ZW5hcmlvLA0KPiBhZF9zaWdtYV9kZWx0YV9zZXRfbW9kZSgpIGV4ZWN1dGVzIHRoZSBmaW5hbCBT
UEkgdHJhbnNmZXIgZm9yIHRoZQ0KPiBjb252ZXJzaW9uLg0KPg0KPiBCZWNhdXNlIHNpZ21hX2Rl
bHRhLT5rZWVwX2NzX2Fzc2VydGVkIGlzIHN0aWxsIHRydWUgd2hlbiBzZXRfbW9kZSBpcw0KPiBj
YWxsZWQsIGl0cyB0cmFuc2ZlciB3aWxsIGNhcnJ5IGNzX2NoYW5nZSA9IDEuIFNpbmNlIGRpc2Fi
bGVfb25lDQo+IGRvZXMgbm90IGlzc3VlIGEgc3Vic2VxdWVudCB0cmFuc2ZlciB3aXRoIGNzX2No
YW5nZSA9IDAsIHdpbGwgdGhlIFNQSQ0KPiBmcmFtZXdvcmsgc2tpcCB0ZWFyZG93biBhbmQgbGVh
dmUgQ1MgcGVybWFuZW50bHkgc3R1Y2sgbG93Pw0KPg0KPiBDb3VsZCBzaWdtYV9kZWx0YS0+a2Vl
cF9jc19hc3NlcnRlZCBiZSBjbGVhcmVkIGJlZm9yZSBjYWxsaW5nDQo+IGFkX3NpZ21hX2RlbHRh
X3NldF9tb2RlKCkgdG8gZW5zdXJlIHByb3BlciB0ZWFyZG93biwgb3Igc2hvdWxkIGFuDQo+IGV4
cGxpY2l0IGR1bW15IHRyYW5zZmVyIGJlIGFkZGVkPw0KDQpHb29kIGNhdGNoLCB0aGFuayB5b3Uu
IFRoZSBwcmV2aW91cyB2ZXJzaW9uIG9ubHkgbW92ZWQgZGlzYWJsZV9vbmUoKQ0KYWZ0ZXIgY2xl
YXJpbmcga2VlcF9jc19hc3NlcnRlZCwgYnV0IGxlZnQgc2V0X21vZGUoQURfU0RfTU9ERV9JRExF
KSBpbg0KdGhlIG91dDogYmxvY2sgd2hlcmUga2VlcF9jc19hc3NlcnRlZCBpcyBzdGlsbCB0cnVl
LiBGb3IgZGV2aWNlcyB0aGF0DQpkbyBub3QgaW1wbGVtZW50IGRpc2FibGVfb25lLCBzZXRfbW9k
ZSgpIGlzc3VlcyB0aGUgbGFzdCBTUEkgdHJhbnNmZXIsDQpzbyBpdCBjYXJyaWVzIGNzX2NoYW5n
ZT0xIGFuZCBDUyBzdGF5cyBzdHVjayDigJQgdGhlIHNhbWUgYnVnIHJlcHJvZHVjZWQNCm9uIGEg
ZGlmZmVyZW50IGNvZGUgcGF0aC4NCg0KRml4ZWQgYnkgbW92aW5nIHNldF9tb2RlKElETEUpIGlu
dG8gdGhlIG91dF91bmxvY2s6IGJsb2NrIGFzIHdlbGwsIHNvDQpib3RoIGNhbGxzIGV4ZWN1dGUg
YWZ0ZXIga2VlcF9jc19hc3NlcnRlZCBpcyBjbGVhcmVkLiBUaGlzIG1hdGNoZXMgdGhlDQpwYXR0
ZXJuIGFscmVhZHkgdXNlZCBjb3JyZWN0bHkgaW4gYWRfc2RfY2FsaWJyYXRlKCksIHdoaWNoIGNs
ZWFycw0Ka2VlcF9jc19hc3NlcnRlZCBiZWZvcmUgY2FsbGluZyBzZXRfbW9kZShJRExFKSBhbmQg
ZGlzYWJsZV9vbmUoKSBpbiBpdHMNCnNpbmdsZSBjbGVhbnVwIGJsb2NrLg0KDQouLi4NCg0KPiBJ
IG5vdGljZWQgYW4gYWRkaXRpb25hbCBzdGF0ZSB0cmFja2luZyBpc3N1ZSBpbiB0aGUgZXJyb3Ig
cGF0aCBvZg0KPiBhZF9zZF9idWZmZXJfcG9zdGVuYWJsZSgpIHRoYXQgd2Fzbid0IGludHJvZHVj
ZWQgYnkgdGhpcyBwYXRjaC4NCj4gV2hlbiBvcGVyYXRpb25zIGxpa2UgYWRfc2lnbWFfZGVsdGFf
Y2xlYXJfcGVuZGluZ19ldmVudCgpIGZhaWwsIHRoZSBlcnJvcg0KPiBwYXRoIGNhbGxzIHNwaV9i
dXNfdW5sb2NrKCkgYnV0IGxlYXZlcyBzaWdtYV9kZWx0YS0+YnVzX2xvY2tlZCA9IHRydWUgYW5k
DQo+IHNpZ21hX2RlbHRhLT5rZWVwX2NzX2Fzc2VydGVkID0gdHJ1ZS4gU2luY2UgdGhlIElJTyBj
b3JlIGRvZXMgbm90IGludm9rZQ0KPiBwcmVkaXNhYmxlIG9uIGEgcG9zdGVuYWJsZSBmYWlsdXJl
LCB0aGlzIHN0YXRlIHBlcnNpc3RzLg0KPg0KPiBTdWJzZXF1ZW50IFNQSSBvcGVyYXRpb25zIGxp
a2UgZGlyZWN0IG1vZGUgcmVhZHMgd2lsbCBvYnNlcnZlDQo+IGJ1c19sb2NrZWQgPT0gdHJ1ZSBh
bmQgaW5jb3JyZWN0bHkgaW52b2tlIHNwaV9zeW5jX2xvY2tlZCgpLiBBcyB0aGUgYnVzDQo+IGlz
IG5vdCBhY3R1YWxseSBsb2NrZWQgYXQgdGhlIGNvbnRyb2xsZXIgbGV2ZWwsIHRoaXMgYnlwYXNz
ZXMgdGhlDQo+IFNQSSBmcmFtZXdvcmsncyBidXNfbG9ja19tdXRleC4NCj4NCj4gRG9lcyB0aGlz
IGFsbG93IGNvbmN1cnJlbnQgYWNjZXNzIHRvIHRoZSBTUEkgY29udHJvbGxlciBmcm9tIG11bHRp
cGxlDQo+IHRocmVhZHMsIHBvdGVudGlhbGx5IGNvcnJ1cHRpbmcgU1BJIGJ1cyBkYXRhPw0KDQpZ
ZXMsIHRoZSBjb25jZXJuIGlzIHZhbGlkLiBXaXRoIGJ1c19sb2NrZWQgPT0gdHJ1ZSBidXQgdGhl
IGNvbnRyb2xsZXIncw0KYnVzX2xvY2tfbXV0ZXggbm90IGhlbGQsIGFueSBjb25jdXJyZW50IHNw
aV9zeW5jKCkgZnJvbSBhbm90aGVyIGRyaXZlcg0KY2FuIHByb2NlZWQgdW5vYnN0cnVjdGVkIHdo
aWxlIG91ciBkcml2ZXIgaXNzdWVzIHNwaV9zeW5jX2xvY2tlZCgpIOKAlA0KZXhhY3RseSB0aGUg
cmFjZSBidXNfbG9ja19tdXRleCBpcyBtZWFudCB0byBwcmV2ZW50Lg0KDQpGaXhlZCBpbiB0aGUg
c2FtZSBwYXRjaCBieSByZXNldHRpbmcgYm90aCBrZWVwX2NzX2Fzc2VydGVkIGFuZA0KYnVzX2xv
Y2tlZCB0byBmYWxzZSBpbiBlcnJfdW5sb2NrOiBiZWZvcmUgY2FsbGluZyBzcGlfYnVzX3VubG9j
aygpLA0KY29uc2lzdGVudCB3aXRoIHRoZSB0ZWFyZG93biBzZXF1ZW5jZSBpbiBwcmVkaXNhYmxl
KCkuDQo=
