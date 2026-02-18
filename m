Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A762306483;
	Wed, 18 Feb 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421749; cv=fail; b=gT0N+gVY0BQ7oz+7c+IGMlSyRUmbsx0qgFMiyr3ZZ+DC6nK47vxodeAM9zJvPy8dHqVoBhE2CXUBoyZnYPHzX//6P45KT9ao3epi32Dx33YKzx46Lyd9vCzIfl+JlTAWRgNa5P0qK14cUtFai56Ayi0iGBD/K+Hen1N0G+C2HFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421749; c=relaxed/simple;
	bh=YDZ5xCU5wf2iCtyXkYc0BT55EDqWwLHqWWDQ1k4ezBs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YzI5y+KvFWlwYySC6gHN1NMlpuRj6/GsMkw1uZLJBn640uNetpHcFHwFk2cAqRPlsV/JTRxliHuLbcWb71ePdmr5GG43QbLRLfKOxT/paRp+O8cpfpLHUoSY/lmO1sdVYV0LQNrM8OgK3ZOJMp6nnS+Ams9LD0ZOuVSQGWCfsn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dDk1TEvL; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dDk1TEvL"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ID4t193424266;
	Wed, 18 Feb 2026 08:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=fVRy+gFvZMWVe5TgNdNKKNdUrWU
	61hJ0fK/FIGhZOLY=; b=dDk1TEvLsZDhdBOPl/sUbwE8zh6ta82eqBsHLFgjJHo
	w+sA4vrsMTqrefqAtd1clldiRewTE1f/OnvXKSMpgtoVAhniodp1gCJKAsSTF9/1
	ZXqZh+POh1oUG5GJIGh4Idi5ZQi3UDYWaKafdZEimg8ad4YIR40FFWB/VptWoWkw
	fgivZLqk7qsOYY6C77/wBNITLdQ8hwR6FsgFYfuqselK6lY1YCfHvFktVQH69Qgi
	HIi6HqqCeeOx4/mTNYS/yZ1imGJRmc5iMrOEHp8F87Mxv95HwpZZWd6y/3QSPTSB
	aHDO3joZ/6AneufgjyYMzkgJqVKEhSv56grIjl35WVw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cd7qahedw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 08:35:38 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG7W+73e8ZxR2D7ldJI3NO10McQyudktZeaa8SD0l85xzoB9SB9zYG0ogaQMR3ivJ535cbnBdpH+XqYJTwjdN3Y1ps1beOHRHr1bx1zJKGwlNqBb3N0wN97ory2pnFWvm/bNh0AdaqswF9GxUPZekk53UwYw4ItybCrn4yGUYwMbrCljvEvyxwZDoRwiq1cvGPndy8yQuBKvY/aBnbXyGQ8WV2GWYT8uCgsdzbwQnkyWjyKUeR/R7nDtByhH6OAEHYvEzroUbAbqZyOuUUInWKoiT7bnfTQ27uws76ZeL1OpWv9mgnCKgsE1bfxK3iidomZwGJk8JQNrr73xyLKH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVRy+gFvZMWVe5TgNdNKKNdUrWU61hJ0fK/FIGhZOLY=;
 b=zOMq4OHYHhtJRHqjojCvm9p67fKfLz0Ijao+u+Z5TeLfjBQbBBHYMMBJ6e7YDY/RhqYhfc4zIfRzk/CZOskAWsoRW1UmZ90RoZugv35T4U0Ew/udqBDvhdJTjLI1L0TdOEXel5w8O5Y1CbE4cYmTIm3MJ+3NLE474OKEajLxzEXdSJJKr9m5pXR1AEIXnBYZJ8BfG/8/MQ3hzSyDkDlq0DAIj+bRM7+B6sSCHZcdC81EHvJPvEY3asJjrCkgWbBQuVpateAgeCVvVJ0oOFOyXLybcEo3FBbM2+BglWDyILZHJj0kM7Z9s7lX2wCQNjYcTT5tTtYMeU3Mo2zn26TNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH8PR03MB8347.namprd03.prod.outlook.com (2603:10b6:610:2c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 13:35:36 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Wed, 18 Feb 2026
 13:35:36 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: RFC: New switch subsystem for analog/RF switch devices
Thread-Topic: RFC: New switch subsystem for analog/RF switch devices
Thread-Index: Adyg18x37nyapj0jSvWWIF3Mvl46BA==
Date: Wed, 18 Feb 2026 13:35:36 +0000
Message-ID:
 <CY4PR03MB339994407FA1DF5E2A1F32B29B6AA@CY4PR03MB3399.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH8PR03MB8347:EE_
x-ms-office365-filtering-correlation-id: 4377baef-7e09-4fc8-b403-08de6ef2992d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?TPgEY2RU6h/GvxSBJTeopk9JC5YsaQ1rBc6MGtti0ZRQ4wChcTvA1FwhfO?=
 =?iso-8859-2?Q?h1aeJrVqxIjyTSMQoXFY8EoBluH7Hh3C51jwTCKMcROSOGZpny2AkwQ5cf?=
 =?iso-8859-2?Q?cW35xkW+zTSI/2N9lp0KqEdU+k3cW2/cwppClT9sy91JcmuiT0BLlQieVs?=
 =?iso-8859-2?Q?/1PdLmB8jtGDff34F+MXrPtP/Cz/5svURn8ZAAsS2p9TkEl34/GOIairmh?=
 =?iso-8859-2?Q?P+rYWG6seCfB8LMMxjd6GJOiJcdjo58e7V378rxbc1k7caPoYSq7hdUnT8?=
 =?iso-8859-2?Q?hJnOatD6ffWYBg3Hgjroa62yC13iGXn3TC4QymCV/mNnKnyNqHUPi2UBC2?=
 =?iso-8859-2?Q?2H1XzawMSyeY3snITmebyigRB11sAsagzrqQSM8PFGBDVWdvB0mKBXFpn8?=
 =?iso-8859-2?Q?3YgKkOj051NtsQosWXkYLnr32qw6Vh/wx6G5xfVg0Q20g4OKUc6CotY7KG?=
 =?iso-8859-2?Q?Y/NCpvJBc1gs51NkqQrS+WwWvBMCpmytNP8JtzB0ufW5rtPYUKbJDoHLs0?=
 =?iso-8859-2?Q?QW3WX1tI+YgCFOtCpSFP12FdSXdgCD8p4v2hJ3OzA7immkQJw8FUNbWN+2?=
 =?iso-8859-2?Q?zoDzMhGBbUabTEYLUeqhVxJW/7ftOUiIU401G5axJdc3KakFrATmsK2AZf?=
 =?iso-8859-2?Q?1sn2VDa+eDWAP3ep+n0lBXXwjwv0tPFVABY/C94H91NFn5CH+iGB1CD+ds?=
 =?iso-8859-2?Q?2692T0+6x8Anq+YAbJ1onFtf2Ip7RXfkWBVNJ2+d2WxKzfJWoOLfz6AWbu?=
 =?iso-8859-2?Q?kPdvVwZggFAPEJqskJbQ9QNsiNKZTLxzmDPbUoYYSzL1UJqBdyx9wG1TWT?=
 =?iso-8859-2?Q?XW5ScYwlFdX6k42dxc3ygNfI8LEhtxIU6skc/SrlGSWp1TfMXa4yuhSoTT?=
 =?iso-8859-2?Q?PCEM+8DAMZ+9jLODziPoMy2WBBWJz1rtQWbSeq58BkRwg3q90nA+svq3dN?=
 =?iso-8859-2?Q?0pYL7B4iN4O/Yps8rbu1zEAloQvW8uMP9KiaKP+gjypEzkGFW+D+bIuxxG?=
 =?iso-8859-2?Q?XKrTjVw3zwciOOx5SJB1Y/vasW8T1Q6wzAnywOsoAAPJHhXdJO/CW0C7ww?=
 =?iso-8859-2?Q?1OMyiu2LVj+ZSwcvKswcBVPCC0auIAo9e0s7gejHpTvlJmGEMLAo3J0UOt?=
 =?iso-8859-2?Q?uemXVxyMIK32QZqX5ILTFjSPr32YYPtgb4fyP2FPqEqq8pChN4KYFKxhpM?=
 =?iso-8859-2?Q?lhZvu3SqfLW64lhbJQFHFCRdQAWI0LTLAXwp2ZglJJQUsd6fkAwBF513B4?=
 =?iso-8859-2?Q?ntTJ60cbTC2G70FKVhNVRoQBz/KQxuyq5BlENr1gXQLQmgLpdJfmf+FqB2?=
 =?iso-8859-2?Q?Iu0FH7o7CAbkvmIFgTnqMcmnKz113vPYbOcf1iK80jxrgbfBVGoI5tNNmF?=
 =?iso-8859-2?Q?ZCQqMko5BaanEYfN0CT0MAAw7j2LEQubvOCFfGhbbamxi7f7EnWDydhIYM?=
 =?iso-8859-2?Q?5ouwGVginHMOJ9wFJI1vH++dz0hzDrEyJKtqfBBjW1lH0w6ELXCLoaXdzq?=
 =?iso-8859-2?Q?NEHXcNLICrmQZ0mVCP9V8vEHJ7i7BVmeFMIgFqPMnwDblIZ7nvOiTERZnS?=
 =?iso-8859-2?Q?kj4hADzPNtv/ZcdAJCYMsSIAn90fApb1jZvgdMZ1ggTiKS+Xtwoqe7AxGy?=
 =?iso-8859-2?Q?0vcZ+vy639a2Ux1cVr7bzVbsxB/g53V0hs8kvAigYc43ocAiXuH7R15nkb?=
 =?iso-8859-2?Q?R2QiAaHgm+u8243NLEXVhe7+RVSmadlJOrON/e+t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?AiZtMB6i1Rjj5xbueIo9w7oOSjUlKDhL/2dyOBmD6HOKkcQhCJxnOhU51q?=
 =?iso-8859-2?Q?S14CkViMBdYfWW4HJoMn7vyUb09IriBXG6csjAjyN0jW97FMGjCYHvqeKm?=
 =?iso-8859-2?Q?pZrFxN60l55cEuAZFqbmn/BWRKAdnWV2PTdSsUcEzYT2cBdNBlzPSR25Oc?=
 =?iso-8859-2?Q?WJT64RxvKpnkk4DHrTWNXmqwIRyw6xK+x1w57AqhOCbh4ZZSWms508skaW?=
 =?iso-8859-2?Q?AfjjE/vV52UjGTB8DrXnYOgt/5aYbK3AwR4GpcSRlmQmXsoij5KTQncWmk?=
 =?iso-8859-2?Q?sR258Ift3xHqpV0ST7oavt5EqOQX0xDpcmp5mbUS+XFAcAceWflAM+3Vzn?=
 =?iso-8859-2?Q?AwaoWUkHMCgGErHRSmV3xW8roh+hDQ3l3r7r3e9tabM/71etbWHpLdiYXV?=
 =?iso-8859-2?Q?NOoL/IEoh83LptaWcin0wTqFcsN1fo5OYBapMowDk5Lqm/1+B5nL5yWRpn?=
 =?iso-8859-2?Q?eht5i9XcCRIOccXH9z7KuQKauF+O14nILpYe2+VuGnM3S7xMMXJWCuSFIv?=
 =?iso-8859-2?Q?j0jPVnzx1UQvdMZaBQDKk3qlPuc+a7nNg9HRLjtqRpZfatGZJGhl3TM3dv?=
 =?iso-8859-2?Q?rtfmVD3IlhROrbiqr03AZpz3tuzQebM3mfJ+ryRCKbs+ebBEoQY+DIBRln?=
 =?iso-8859-2?Q?2LFeRItRY0uul6l+RRjujC3SZ7mvUbGfWdqSN6z7wxUgdZFaL6JO29pPwo?=
 =?iso-8859-2?Q?37KfuUb88qRVCzBvkR2x3+ywX753968tLSgzYBjMNCM5ScwZ8URNO7Wh9o?=
 =?iso-8859-2?Q?uC7Mtj4qKOrYPN8uWHsrcjGd520f9SRkvfmvVMa5dhajY1eFqJHo0K/jEY?=
 =?iso-8859-2?Q?VXYD723Vo62j/ffCpDcHle8myPaRri4bSsgrat4QrcPU4Rebz50r8/rnVp?=
 =?iso-8859-2?Q?PUrNg2cY0zBaxPOdaJ6bb2EhiLy1PWg/hCoUOgAy/r0h2vAswlFNMosMxM?=
 =?iso-8859-2?Q?H3hiULNBNZgpdGzZF4m0LneqhcoOxBC14uNR3A8+lrzTB7JeYvWD5kqBnI?=
 =?iso-8859-2?Q?+0ecx+9J3ILhIi4Ni6M3/RgS4mOx6i7+xaRdZrNiNiNBvrM8tKMc9Y4SV5?=
 =?iso-8859-2?Q?FhILCKoJgw+apvja9gOZsvGb/QED3PTfqeysngbh76ZyqbxdJLWKacIGaW?=
 =?iso-8859-2?Q?j/ikfuAnNbYYDdnxXMniHBRZETYhpVsLGZzdKv2mBV+CUs0Cu8cK1L4c+N?=
 =?iso-8859-2?Q?9xBKHNVOYj0vkrOkBU/A5oIuGgNJ8TiMJzI5DxZ+zS2IIyupoR/dMKbJJr?=
 =?iso-8859-2?Q?/wdWBvc3xSEAcT7YgPUy+ZkIrSQOMPqAsalvOVBcxNCOUo3MKFMZYp5GD3?=
 =?iso-8859-2?Q?0gnw5rFgG0d11M9yIb/3f6Bv8IlJ0DwMTzUTRA551d5eIrSx8Miz9p9xhR?=
 =?iso-8859-2?Q?jy/WY5vD024n27v7mYfXXcmShgdeNEP62Wj//AySo0imE8eQHfhlykDzBY?=
 =?iso-8859-2?Q?S6I6MF2DX0EFcVpg0LmSE04pvDgyNQqZ7s5OCmHoNN/5xWBR+jbRw2K0yK?=
 =?iso-8859-2?Q?dDW6S9RltpRRKRjOiAqsrkYydW0HAAgjJLCUer0AfqQ2H94EuOEnaUg0Ox?=
 =?iso-8859-2?Q?AeCUC8kO2GTc/P8y+bivGkp5UsKEnQn2Zg2R7nczfvEmpHR47XbYlbZCcA?=
 =?iso-8859-2?Q?XZWWlG2UbS09AQO91cff4Zh+jMUmUy5S6nGY6iZb7LeafsygE7/rSGVJ8E?=
 =?iso-8859-2?Q?I6it6ciFFSjuThPpBF0bszOnbOc+1vTSYvWKr1GqkRWNT/GGwqnJmdLPrS?=
 =?iso-8859-2?Q?vmYefTn5P4hpILJQnHmORCEvNTPh1SBhQY6gxHWFTMYKwa/YCrwKGj0y7O?=
 =?iso-8859-2?Q?qb0cT7xKLg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4377baef-7e09-4fc8-b403-08de6ef2992d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 13:35:36.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87kOaYvvE2mCEJ04xwokeyaU488Yh+963X1Y5o2pSQZFOTOucnEcVKx8xHPV870KKnLUBwERAw8aoTFfR569StkBrLGpsTu4+R/Kk2skKbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8347
X-Authority-Analysis: v=2.4 cv=EtDfbCcA c=1 sm=1 tr=0 ts=6995c02a cx=c_pps
 a=42Ag0VRmng1YD8CjqzuPTQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=kFWYjOyuM7ebdt7c0swA:9 a=jiObf9B0YAUA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDExNSBTYWx0ZWRfX/WVczimNbA2O
 ohYrhNkXO8I4sstTX7k09ZE5gkwsX4AcqMaUL0/z0kRtp89qFwI0Vmsz+gd7eJccL8xcqjd0KJw
 l1zXbk9Z8+XCXQiFYFIdloBhFA7qVhodTecMdQyPaz2yClgpFMxw89Hv95Thm06qM76hljztETi
 fpCK7CDC8ImH81zORNKNvhuxf2+9keKePYF93DJd12i81TK0SK52xYaqqImVQuafCiExRHOUNA/
 gg0D+XKC4Krd6D3sd0b5qhQ+u9ysb581nal2IqIBXMry32JHdByziDR3jz8JncmjAf3t6gZZzdS
 pKyZNGYvz/GVsaBQi5iSZOXzZjXlf9+QQESBwhjtrIPdcObccYvu6K/tr8YEr30NqgOq6+BM8pQ
 wu1iYj2Ge0ZJsovD+YUh9Ig2NNCG2a+ed8JJPlGYVO/k4sUR03x/86CpNGcLVzsqTBuIWjMyR01
 1YgAlHKR8cYE5o8FhrA==
X-Proofpoint-ORIG-GUID: 4IV5dvQvcaV9MJrK5-rIfXCXCVLtg_yd
X-Proofpoint-GUID: 4IV5dvQvcaV9MJrK5-rIfXCXCVLtg_yd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180115

Hi Greg, Linus, =20

Thanks a lot for the feedback!

Added the public mailing list + kept most of the info from the private thre=
ad.

I looked at the existing IIO drivers. Modeling each switch channel as
an IIO output channel with IIO_CHAN_INFO_ENABLE for on/off control
might fit.

I'm thinking about a prototype for adg1712 driver under drivers/iio/signal-=
switch/.
Userspace sees:
  out_<channel_type>0_en
  out_<channel_type>1_en
  out_<channel_type>2_en
  out_<channel_type>3_en

SPI devices like the ADGS6414D would be a separate
driver in the same directory, same channel model, different control interfa=
ce.

Jonathan - does this fit within IIO?
Looking forward to your feedback.

Best regards,
Antoniu

  On Wed, Feb 18, 2026 at 02:18 PM +0200, Greg KH wrote:
  > On Wed, Feb 18, 2026 at 09:38:12AM +0100, Linus Walleij wrote:
  > > Hi Antoniu,
  > >
  > > [CC Jon Cameron]
  > >
  > > in general it is probably better to send this question to a wider aud=
ience.
  >
  > Ick, I didn't realize this wasn't on a public mailing list, which is
  > where it should be, and cc: everyone involved.  Let's start it over in
  > public please.
  >
  > > Given that this is an analog device, dealing with analog signals, it =
has
  > > IIO written all over it. IIO already deals with ADC/DAC, multiplexer
  > > (check it out drivers/iio/multiplexer) and signal (frequency) generat=
ors
  > > (drivers/iio/frequency).
  > >
  > > I think it belongs in drivers/iio/signal-switch or something.
  > >
  > > IIO already has an orderly userspace ABI that might not be lightweigh=
t
  > > but it looks like it does for a good reason: people use it for comple=
x
  > > signal routing in things I don't even understand such as GNU Radio
  > > SDRs.
  > >
  > > Give it a thought.
  >
  > That sounds reasonable to me.
  >
  > thanks,
  >
  > greg k-h
  >
  > > Yours,
  > > Linus Walleij
  > >
  > > On Fri, Feb 13, 2026 at 4:51 PM Miclaus, Antoniu
  > > <Antoniu.Miclaus@analog.com> wrote:
  > > >
  > > > Hi Greg,
  > > >
  > > > I would like to propose a new switch subsystem under drivers/switch=
/
  > > > for analog/RF switch devices and would appreciate your feedback.
  > > >
  > > > I previously attempted to upstream the ADG1712 (a quad SPST analog
  > > > switch) through both the GPIO and MUX subsystems, and the feedback
  > > > highlighted a fundamental mismatch:
  > > >
  > > > - Bartosz Golaszewski noted it's a GPIO consumer, not provider, and
  > > >   questioned whether it belongs under drivers/gpio/ at all.
  > > >   https://lore.kernel.org/all/20251117091427.3624-1-antoniu.miclaus=
@analog.com/
  > > >
  > > > - The MUX subsystem assumes mutually exclusive "select one of N"
  > > >   semantics, which doesn't match independent on/off switch channels=
.
  > > >   https://lore.kernel.org/20251121115750.20119-1-antoniu.miclaus@an=
alog.com
  > > >
  > > > We have a growing family of devices that share this problem: simple
  > > > GPIO-controlled SPST switches (ADG1712), SPI-controlled MEMS switch=
es
  > > > operating DC-24GHz (ADGM3121/ADGM3144), SPI-controlled high-voltage
  > > > octal switches with CRC and daisy-chaining (ADGS6414D) and others t=
o
  > > > be released soon. Control interfaces vary (GPIO, SPI, I2C) but the
  > > > abstraction is the same: independently controllable on/off channels=
 on
  > > > analog signal paths.
  > > >
  > > > The proposed subsystem would provide:
  > > > - A lightweight core with switch_chip/switch_channel abstractions
  > > > - Support for GPIO, SPI, and I2C control backends
  > > > - Sysfs interface for runtime switch control
  > > >
  > > > Does a standalone subsystem make sense here?
  > > >
  > > > Happy to send an RFC patch series if the direction seems reasonable=
.
  > > >
  > > > Best regards,
  > > > --
  > > > Antoniu Micl=E3u=BA

--=A0
Antoniu Micl=E3u=BA
Senior Engineer, Embedded Software
Software & Security Group

E-mail: antoniu.miclaus@analog.com
Mobile: +40 747 036533



=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0


