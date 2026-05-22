Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F92D595B;
	Fri, 22 May 2026 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458184; cv=fail; b=nlL39S+oTroPmYUQIn575SMSpHlQSHJPU4HzMuZn5nbU89C9r60xFA+1SbHJdt04Kmn1U9i5p9LmS9bEmJLXImAu8bTxZaxqr2Bv8aKSoZXBSDF4OE8lpMNkeGf68H9v0whH7fHcGJYz9cSXGby4FzBpmX5WpTBGgs50DQkDczg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458184; c=relaxed/simple;
	bh=86kmp8GJffIxMjYXgK6rfymdsiKTp9JWFie23x5LpH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BL6JmKpuYtDHx9rYTt1U0puaHTVcQPUTByKpgkJz8n4x8ui6aSCYhauvWiz98ShE9J2fV0ktu4Rm8x3Noa/Pl3mYSKy9pFWPisXBN+Zgf+Bo4M0h7thOIJGAp9jdK/UtzdQs4djPBzyIfOzaqdnDY8hW86z0LCuXCZEf0oNORsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1mzCWRuj; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1mzCWRuj"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MAFaU92083360;
	Fri, 22 May 2026 09:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=erXfB
	2t3rH8h6TA882yaiIYgUCkw6CwXsOu4IOFOry0=; b=1mzCWRujQqesl9D+bPm/Z
	VlHvqXH42yXtaipcMIxDnurvXoUe1wPQkoVFQnQ1fp7fcsMPotwOZLhUH5vgqu2P
	VeylQxsrs2kyb47+8QbXpBXKBPwMjPyJr1cRh9EEqFlfkSN0ocs3+GvLmpIbBV5r
	3cqZdvdSB4JAMjfnN0f5WAb9bqxj4sK0c/IqWmXdtSXPbosijwphnLbb3lVsKtrj
	/mKrK6AqmptLvfltERpkspr6C/IdyVABjWhrmaOZsoYUqydlOeg1nHwopaYYJelu
	5DrHvQm6BvSpFJjycH6ZyBErLfobcck9GoMpecD3RIKDK6yx61c2SgBv3jM5XOb0
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ea6d2m0bp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:56:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZK/X5I1TTGRKA34/pq3ryvnXZJ1RU80AGZuuKryx+C8Vib60Cyq0t2ij6MoZ8s2kNpYXQu5+QmTv2r7p8VGLHOWt3ioknB+qPzhYRzCXKUIRIJKk2jOpS0YzwxN/hW2f1Mnys3afWtJqncW6mCX/LXn1O+zffCZ4ycfDdux4DLPoRyWAy4bgstd99nYWBSilNxkcv17DPL0IwT+4lDprr+QHxbF4EQDSE3FnpBC4lLm3+yswZiaHqslGkl26m4VXJroyNMzoXayP0wZNHJeMa2YzCTSQkBdG8joJw3IdxmJ6CMgIDa51iBUO5/wONt7hp46N4I3HsB9I9JtVb0nZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erXfB2t3rH8h6TA882yaiIYgUCkw6CwXsOu4IOFOry0=;
 b=AMNl2Gdh/CTDXBKvK2/ZC/MjMMoMs8gahorHSU6MvW90rbvZt+Rp3zP77/wB11k803KjD0lOYBTx3MBFIxkAUc4KS2lPSgZxkQ0+nvhtcBDHm/JZf9SZo2YjXwOdp/tRQIo5l4MPZbKVX3IctXRX2i2jM+AV/ennEbFRejLCjSXpiqrJFkYILi2onblR2kHykuMi0A8uAkSqnfvyIgX1npfGB5ToTJwisEGtXgtpTmDbEmb11L/ydLADf7qSFVhfs7mkl2ZVZbSbJbvWz6qMrw5thXTGFlV+KfZi/5BYs8as6CoJwFdOO2x0WKpCJuUwrQatdv35vxLJdyHK0E17Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8366.namprd03.prod.outlook.com (2603:10b6:408:368::16)
 by DM6PR03MB5129.namprd03.prod.outlook.com (2603:10b6:5:1eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 13:56:17 +0000
Received: from LV9PR03MB8366.namprd03.prod.outlook.com
 ([fe80::b6c5:a618:15f2:c6eb]) by LV9PR03MB8366.namprd03.prod.outlook.com
 ([fe80::b6c5:a618:15f2:c6eb%6]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 13:56:16 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miclaus,
 Antoniu" <Antoniu.Miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/8] iio: temperature: ltc2983: Use local device
 pointer consistently
Thread-Topic: [PATCH v3 2/8] iio: temperature: ltc2983: Use local device
 pointer consistently
Thread-Index: AQHc6UFSbIaV7oiInUim2lvNx7vBlbYaBBmAgAANlXA=
Date: Fri, 22 May 2026 13:56:16 +0000
Message-ID:
 <LV9PR03MB8366F20731EC761694748739F60F2@LV9PR03MB8366.namprd03.prod.outlook.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
	<20260521164323.770626-3-liviu.stan@analog.com>
 <20260522140255.27445c41@jic23-huawei>
In-Reply-To: <20260522140255.27445c41@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8366:EE_|DM6PR03MB5129:EE_
x-ms-office365-filtering-correlation-id: 1b10d082-1a02-428e-bc0a-08deb809e4f7
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info:
 KQoSK4yviJ7JbSCADxZgfaq2JIeX0bwsRjRm0YWUcetLxH958xSFcSnf+x8XUxJAYf0fb/aRG/NdmUPL2kYLVigzgHhVlGgQwgL7a1II7CtLXsvF9eVLbBv/oULi9k19JQVYWBBuEMTRvRIOUwxwuR9QaJIPYUwI/0J1t8i4mMhNwtnrKCmPV7FgQwiB6qU3SdEeYHtMEVftJe53ApsoCAZ9rGO7D+owxXAtOiuhS471U5stY6v8wO/MSUgvWgTEncSKXaMv8aKJnSaZ2yKy7DoTr45dqcbcdcnv4VD/CK15J5jCNyQIBTRWCFnF2/37lPLU47DjqV26E7jNkED7zpGq6QiPpcWuHcR8lwrHIMmIldB3KNvXqOaGBmXQ3VYRjZ+LeubYVBMBrrpxgPYuiVq95r/bnVOoT7OdxMAOdVeG7Moa89BWhMDUOWxbPnsXmi2zTaiI1gY1KTE/oeIRz9NgiR3C588TPs1fwqzf+gPXaqVCP/d92oC8u452vo9pEDQGO0bbcS+U1YfHwcO01eiTD98hJIPxmuWGtwlS6Dk0mYxh57uHVP2hKklfUHhhXlLLoxlyRZ+OvqJ5a4bzgFhL5UuPrGAn2x50iWZCH4hBwu2Vb5nBsgpQlahYdjavBrzyL19pjtOJqh2iyZJVqjk0Bqug4lBr5cn8AkS/X0hzVVM4ZcUvxgBGEMc9J7t8C5Cr9v9MexbkApy8wsrJgEbEWIFJamacbffL0Sh0Pu+kOy/V3onxD8T7s71qCoGD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q7ocfjjPZ6ryBesNyDjCOG1GdgFTqOKhL/1zHfVSpUUN/DU7hXBOXguRO2eg?=
 =?us-ascii?Q?mrA6+D4R7kYyxiqRZOYzTbIjlzKvNT59OdCJVH6kwkQfRgcGADbnU3XdJNiy?=
 =?us-ascii?Q?vJ7jhfS7YwYQgKJ5l+BrC5DHvZDAwJn81kx+DIqKnnqknZJoGYmF28E9+OUo?=
 =?us-ascii?Q?LPiflMxQ227Nn8I9vYoAvE2QpHVXsmNcL0BpQXKg5v7MuZ3OfT+vL7S+7cmk?=
 =?us-ascii?Q?VxAPSPgfRWk9PRN88/075TOmgXzIwVbDTVYywlaN740wPwHdnQDXp3nasNed?=
 =?us-ascii?Q?FIk/d7bTazdm0LhZcYYj8UB9FZGAWcVTkF5/NdVSXX1rGChRVEWAUy8OuCyy?=
 =?us-ascii?Q?lSRexPk9iJWb38fCnnM99xlU7fBll8C8SiEQeOEB3UAx4fspy2tfm8IBvad8?=
 =?us-ascii?Q?Ij9Sqf2HRsAgnLNHTXYN2cq2rEd/6BUY+knzcJ6KJVxSgOoK6pufhKic3Doa?=
 =?us-ascii?Q?PjTfjjvgK8wJReyxe7JMBVHiRkyyhfBWL+l5HfDOk5mDZjsUkJsDcwzYMSXK?=
 =?us-ascii?Q?3nk2RA6/esWwcGN0PYj1zspQ6yzyBTHQKk7d23WakyWjeyBL8eFDWpWW/ibq?=
 =?us-ascii?Q?VIvWEmnwj/Wi8VjQlywUDgGop6aBqnO1APVL6s/ur7pSMH9SByMkrNaMymyf?=
 =?us-ascii?Q?0b7Qiuh/CpwRYogZZGDobFZwKwUhYvOonbFd00JzPQIJhVJRwN/BQNDK2mId?=
 =?us-ascii?Q?zatyPwgakTpaljPpzydu+XKkmB8faG0H0qpRRHW0n3qGX7rgKkEGqPZ3AqF9?=
 =?us-ascii?Q?gmdP8W+YYUW30rU6wwy7cQyZWRGyQA9qwB7UHM9aFtA1zBS/Xdmw4N6t/x7G?=
 =?us-ascii?Q?eNut3lZizlC54OlVuV2cr7FfyS4TaC8ABWr+Kw4Zca+ZVH0u9NmLpkOZlshu?=
 =?us-ascii?Q?U36watSEpRg37rYS/I/xm9lXr1iLImJP5l++nQWoXvsxIq4KJQsL6atPC2/m?=
 =?us-ascii?Q?48p60zdP+3aZJp8oK4YlaxWKStXcHNpLrRf9FQKqQ86vgBkP2Kit6cYyAsBY?=
 =?us-ascii?Q?2ukRsAUcsDvdKZd7+ciiDDmlkO1sNKsVQ7Dyy74Jl8CKP6sJkstlpjT9qrPF?=
 =?us-ascii?Q?7IOY1N6bkuEtHh0W4L/x5QZHlwr3jWI822afvdeBhwvQbixn1x2oncIS7I0p?=
 =?us-ascii?Q?RiysBaxUcUTU4JDoernjC31wGlnwoQjUVxY6iECOUC9j+2+FaQ3BgiMI4ssh?=
 =?us-ascii?Q?brxRoFnhiUZ047iJe76JtWp184uatajuoThw1KltkbcUKqiGtJC/Ji/oolTL?=
 =?us-ascii?Q?mAG5LmpspCigwcGXpT9i2iuHC1R17atJTOyNgzS7isV5/4gXP4rRZhKBlTic?=
 =?us-ascii?Q?c7YSDo7lZC6HAyIqNs7tSBW5IgqPQVZOWlWn/nD8iOk5/FbvWExxZcQy/t6a?=
 =?us-ascii?Q?W6SQnWUnAV8qj9EWYRYvD4TVWp+hbcPbJoHgbwoHctu2cW8YimeutmNq6goZ?=
 =?us-ascii?Q?BMO42JRuTRCDG13I51msfhUd32c2kDNJBmH/rNvdMmSbP872g0uwRWNT2heg?=
 =?us-ascii?Q?W0Wv7gxq3zzMbCUGgK2lgs/7W9NrbON6t9GPBEQ3JHMPNsOfbK5OF8qvswp5?=
 =?us-ascii?Q?VaH2iDTfB5dvMmy52w4GIdy4krE2BcToHrqaqWPAG049EPAd6nHFo995pUc6?=
 =?us-ascii?Q?Z/1ho3rk3Gnhs/56Fn70dITh3yV7bIJgt77P3GZ7xF0X4UL4wokI5skmt44E?=
 =?us-ascii?Q?0wjPCooJpFNxZWU4ji+FNqsUrmFiIdp+vwVXnhMf09i+9mkie+E5AWp2GPGN?=
 =?us-ascii?Q?oz16mekHEg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rXxTAbIo0asOs5oO96g7DX2v2C97WLwIvGM2q9Ids9jiEiudpV8qs5wi70MLpmjRm/7CEOyVU7mjgrkwxMdIjWoFRj49h/SBdwAfmERTRr4wM8crbW6i4k77WVjXwL5Ned2rnBqSG8LWadtxca1DCDxStEwYFggzbIBgPYhVGAP1k9bLuDEG1Xs4jrxWEPt0R/ZQhaPL6P3hXo4PQW5SlGf+DdjaKlIYI/vxbFoov2QwtL3LNgS4Bz5HAx8vcdmVUxapjUngGUiMlv31UJz3ekFUXX78rAgRNHGYhjsd3z2Ci6U4lORjG7XABz/LZVIrBda7Isn8V2R5qQCfLtmmcQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b10d082-1a02-428e-bc0a-08deb809e4f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 13:56:16.8296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RP3xYLg9lyUudhH3IrfdUPw6aa5Thxjf0IdQt341EzMsBkwHd66mTaQCghZvmDs7RwiJPgVgf9S/+marND3luA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5129
X-Authority-Analysis: v=2.4 cv=dpbrzVg4 c=1 sm=1 tr=0 ts=6a106083 cx=c_pps
 a=xBU3AFOX62plvdJ7VrUh9g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=hrI3nvs9gsBQ71enaesA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzOSBTYWx0ZWRfX0Qi/2e839DJ0
 4eZhbGUk9IndIQdWUbZnVebMvMowmFL+WPVZ6tNVqUVP3R/7LnKuAiQsYcJD+OOV1la9KvuYiwh
 Pchy/h48+IUN32oZxMDqjDKtqzka63Xiwb4Zg14gJxa43eFZSj3n7tJxI3zQeP7pZsMBLhIWfs6
 Cj5LNuRgcIVFeGdE8Sjk3AUOm5EmMGawNEHB0vO557Rj0Yf+A74BN7ZEUqKkSRt1wUw7hM+O4bj
 vAP/3hRtLDSjo150QgELnEUeTyZNeVzPoo1e8odl7bTl4p1di+l/uMdgPjWiuuf2My616aH8fOA
 1VOo/cUcbhIWQUufCnP5jRuEeGDtNae5+QUXZnBba4tR2etxagXjmIMPrWdV4pi1VDrEjbSF0oj
 RWeTwU27py5FWY8OtVYmnXYkWj88hLOcCXB4csMbaexC4gC+n2VbgfP9ewucwN4jdVpvLgoKiEB
 MX332Jq9oGBllk+1XTw==
X-Proofpoint-GUID: 9EQ6GQ5_5DM8Q6jkz2MMeOy8nqe7EZoW
X-Proofpoint-ORIG-GUID: 9EQ6GQ5_5DM8Q6jkz2MMeOy8nqe7EZoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220139

On Fri, 22 May 2026 14:02:55 +0100 Jonathan Cameron <jic23@kernel.org> wrot=
e:

> On Thu, 21 May 2026 19:42:55 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
>=20
> > Some functions define a local 'dev' pointer but still use bare
> > '&st->spi->dev' in some code paths, and some don't have it at all.
> > Replace bare references with the local pointer for consistency.
> >=20
> > Signed-off-by: Liviu Stan <liviu.stan@analog.com>
>=20
> Hi Liviu,
>=20
> When doing this sort of change, one of the advantages is often that code =
lines
> get shorter. So look at the lines touched and see if the wrapping remains
> appropriate.
>=20
> At least some of the cases I point out below already fitted on one line
> under 80 chars but none the less they are now even shorter so that needs
> tidying up.  Note that a few other cases are just over 80 chars.
> Take a look at those and decide if readability is improved much by just
> going a few characters over.  That line length isn't the hard rule it
> used to be!
>=20
Hi,

Understood, I'll tidy them up! Thanks!

Liviu
