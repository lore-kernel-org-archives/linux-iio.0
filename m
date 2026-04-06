Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E22D7BF;
	Mon,  6 Apr 2026 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459115; cv=fail; b=rKkByVWvZEky0XtFAQn3wExMaYoqYKGChsqWFCh06fJs4DO3AAUnQHcvaIq+hXfn6qMjsRr9V18E7r2Bi1NeB2NcUKSWXqW60xAW7baKkUrn85rrGQSL+uvfY5MlbvqGFW73z4+4GP/tTHBiTus+dI8rhS6oOoM3GTMX4lS6lb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459115; c=relaxed/simple;
	bh=kTiNh7BBwPb3FtaCrw6ITJwoLyfEEFCbMkp4bUYlBT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FjujLLo17AjFzKJGaQdcVWz0N9tuIK4BFRI/QMzB/UkUu4/lW3GD84qwlw1DR/VCc3rfIZXhEGJzSztKyeCDMdtG05ZGCaPlf4e5fKI3Ux6EIKberdjrZNigXfXmzG4pxqKQtz2jMs07ifkcbVqO1fWGtiifSpMzJqz5YgaKz4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pNhiaE3Z; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pNhiaE3Z"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6366xgEp1037386;
	Mon, 6 Apr 2026 03:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=c6Rcw
	wEjoGXzEb/VxgMNpUEb++6aveT7SjjtmsjfGf0=; b=pNhiaE3Z01JDzIPbjsHAn
	0RtuQn3HVc5XFJu7rK3g36o0X7jLnYu2oLRKvbPo5r97oMpiaAw60MirnugJexr9
	vwezxjpBYQdOe0o3Sp+TbucuuwhQMcI7rHR7T7iWnLI1pFCli5+CKpi8sIXun7XF
	2D+l7h6K3glLHLhr0cCflkwWEjLrqv6foCbJYOC2MRKicdOTrKV82eMRNa1KU7sd
	fjQmo6OxWJyt0xv4yGfoQraDnBX3QXvcudHFTftUJZW1hDLUvJTvnlsLpb9oaHi/
	DKFUvQn4ytypiKol+U63bFUlHzmeVjzFbMxYQwKutvrWgfoNyOlWMANm9AEO4Yx6
	Q==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dc13gsjyg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 03:04:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PElEoQZCTovr6PswNXeTMtEH71XLGQyufhzQGXif1tGX2vcLVwatBFojEnij3JpCJ+AuplcGIvRukErzWJ9r2PsbvewBheqR61bCIexPjidvPbgmDUWvQ5nL6NnqD62cTWzPm0vPrXE4D6FOC5yyLpoxuZAu29112nfzigOFC5Kz/gTnWNKzPTEZcfjjF930oHNCuSteIOihJCR3L2sMg81DuGoOwaLS+TpRx3eirBNSs0MmqbQia90J71P41MKCY5MgtbKhfCFSVlstnXiUnnh5IeYD+r0iLhkQhmVpQE50axUHTw6DjsEqQhIPkm+uZuTfLdPEiRHzegzROgG6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6RcwwEjoGXzEb/VxgMNpUEb++6aveT7SjjtmsjfGf0=;
 b=iQEljDBgrCg5PsHCiJ6qZXLZ1me4YhlEsLdOXEER8UssIL1ECjzJYAtJ2KgFae2He7VmLp0Sd3+jNksT7Y8e3Vn/Hox3MmlLLzpyu9p12vVSeUk3Q+6glA8EZx/YPgfokVSCMAJ+S17XDqUHfzktq+TkkWjEKY9WLtMw65k83Yk12wj9/RxFNecIK+42EDMK4Oc+XAzCZnlWOajpiInBWVaU8g0wZHcrI/UOUpXje7LKhP/MT8e529abgFTnLQyGmxBRcoL5ypCA6ReTMXk/Lc0JnNFOaZqrWLMFVi0ZewGNDuUykzLCR4OmJSgqUfYonQ/VjGcpSnhennxW44Jv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by DM4PR03MB6079.namprd03.prod.outlook.com (2603:10b6:5:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 07:04:44 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 07:04:44 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: RE: [PATCH v4 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v4 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHcwcEymlEo4GZnj06tv2Ym75awubXKS+CAgAc2fEA=
Date: Mon, 6 Apr 2026 07:04:44 +0000
Message-ID:
 <PH0PR03MB63516A449873005315ACFF02F15DA@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com>
 <20260401-dev_ad5706r-v4-2-a785184a8d53@analog.com>
 <ac0yEfGzqsbkZh86@ashevche-desk.local>
In-Reply-To: <ac0yEfGzqsbkZh86@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|DM4PR03MB6079:EE_
x-ms-office365-filtering-correlation-id: 793df6a6-48f2-42ed-5986-08de93aac80b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 X3GKXs+TDn1LYGgJHbZEV0D7eEHqueVFMmf8h43f9F9dncnABJVl4+FtE/SsvAegZiI4IjJwPT0f5PRVzv1kG4Nz1EJAB6XUeEbY/+QZELdVtt2Q1QOse7hPb1QoSRo54vKND6PQnV26FvKFwlhyxIemRolHeQzam+1tP06gVXzB5VeSRMvJxUQkstQVsnMEXE9KgZoJTEcydtgmmokjQH7/mnE1hzGtVtDd6HmNwbxNFKKlBTAygVI4c1wJ+7rvRtJR7mTlSlM39TnDpoOhbUPhmisry2Gvu1QyRExTKb+Zu/dBiVFTOK4LGgbrQg7pFMheTRx6sZCRt1yEs5qbwSTlrk3RiQM1/PAKWpJbP0bvkebIf35xE5XWZvI+ZBZNqdltLL28fKQCaZFoQNLwCHIfUu4KEAz0SGzfMz9Mee1PVIDjrdmzxRyQ/O0kjzQtS24Q5Viug+RxCVQoKif2PH5FrzJ32B80GYexnTY/JBHYwmHo+P208W7eecTblyRlD4EnP+nAHJEoHtBZ1mG+I+HqCknZpQulAYKOkzUJoB/5pnjwaej1Ld2hiMRvzYdll8PkOcM+Jnk468RYEtSOti76MqFkw12vV3y10Q+h6wFOS9PJbmg4/boq4F5KEz9c/5pl368A0AR7nH7fRTRoj8kIhJZiFMBaZZ5hWYZSJ1oebWfJKFmJkotxKgaNm/gs8Tmsbf+GzTszKha4Thiwp0SM0y8l1WZ6mUNtf2u46gVFsAJEG/DP+u2OuIgVkQqA0Qdh3J+yNzYARTTgKkq8T2DH3EaJ2OPaQkYll3cMxNA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dC3e+hSAb4F5DxxjXJJn9IFRFh5pSdHconvhBx9fp7RS6++gcCS9eeXIQ6ci?=
 =?us-ascii?Q?2ez58DdhdpzKk4+t+/kCjGl+VDT0T7ze4NjhPoTaGAviWPmmTjGjSUqap0Cr?=
 =?us-ascii?Q?9g2mS0TKMoOBDZpncIXkRxSFMV7tEY6m6RuvZWUhUmH9mMgeLuKgTT7qrdng?=
 =?us-ascii?Q?cAMVvau1L5IyrKtRwFf4eZ11hMNJuFFMgn5/4qo4d9ieFCIAYuAwu/a4P3a6?=
 =?us-ascii?Q?8hxfw9cb/P8qrMAfgkKOMngeidHLAyqmJW9GvOghvVUXInqgjlqB3VYUyfVq?=
 =?us-ascii?Q?7DlILKfbqIiCRxTVyvd8hJ1EEQmJ8b46MHb+4qtHmzCi6TFJphT4ZhhsoVk8?=
 =?us-ascii?Q?Teov689L5LTIcfggCQxNnkrUAnS63bmIGSInG41GATfdk5Vief65IVbFJsRQ?=
 =?us-ascii?Q?7spahxQri64e+KOPe7faJVBWW7/P5h8xhFde8+H7m/o/f9fBK98vJxCPoqvp?=
 =?us-ascii?Q?+TeLkGPLHSFy9imEdqR4zm6jmUzGi9/tBEx+iMD/57YGi//79b6eUezAc0Nh?=
 =?us-ascii?Q?1iJftePkEkM9C+Z1bpd0IxYOb9nuva/me59nsqNyYf3oGiLjUo3pmYmJ2WL9?=
 =?us-ascii?Q?EdVL+10L60xSiEmN4va2psC9fvapQw5bD6EdFl5uUz+OA6BqUh3UvyM0Oq4o?=
 =?us-ascii?Q?sSH9Rbr+SjLUZ7B5wLN9s1xM7FAAvnQDrFlDlkVSqPi04LqGDq9qRyqc7WEV?=
 =?us-ascii?Q?bkuIShdLe600mUKSvqv9vwYpbQ4dDdcY2tggkRNjB/95PmLeyV3XNuFxU6gH?=
 =?us-ascii?Q?pKRBf48PZDsv03NkWeNwG/NugCuzZbURvIxw24myYveOv0IaqCFZ6rA71DMN?=
 =?us-ascii?Q?Xqq1YmGiNjdTBhqpWgxnNyfMZw/634djF0vOg89aifL+sWmXoS19tUHGYnD+?=
 =?us-ascii?Q?HTdrIbxyEYvaDqTcFAXDUW/zl828cQviEjBsuY/TDD3DXPkDmvIpBc0+1yKx?=
 =?us-ascii?Q?QL0cxfNdJhqTfwsgK2KvvyWNuZ6y/+duZ+fnHunM1NmnZCbMNM61A5aLIkcT?=
 =?us-ascii?Q?cTOr7nYVMdLVZrqsfgXwVQ6+Q8JUU2NKUwAgIZLiE/v6VbFNipvzMs6hJFOn?=
 =?us-ascii?Q?YQVShx62KWv4VVIV4RJlDpeyUP80+FQ1DnNGv8pC77UZFyJzpzNsT2wC2VCb?=
 =?us-ascii?Q?dF6jhB6IrmlNADJeaZRZ7UwzjwcZTFAfdFQG7/AuiGP6eeQ0+jM8XiWO+/Uu?=
 =?us-ascii?Q?3ntcETNp9E9xdn0o4Bw1t4Erg9WLTJ+jJSmFxfixZMJHLZyJ0XfABokjyErT?=
 =?us-ascii?Q?Pc0miM45EczQHXiuIo3IEtSkQznPFw1S9qow0dCUxm3jwavOIzZ18A5KARQr?=
 =?us-ascii?Q?c88IJi6f4pyFWo7nCz1bp13QkldyxE+6bsaJAAwr/vyAhy4ZTS1oMhCay5K3?=
 =?us-ascii?Q?i4yi+bagO7Kd8YKK6A3XlqYGtgMlhZ0pe1yq7XOxulsWBi8hwiR2g3qxSTqF?=
 =?us-ascii?Q?GKbx0wpA+MBR4KACL1InBt/ZYGXEU6xVtRGdRbRdBiz0ud+yTdbCXBhe2+9E?=
 =?us-ascii?Q?PaBMjwzQSLAViYKVrSe/IfmH1dEKZStStKVMr/5fexN1ShN04WqXauONnixX?=
 =?us-ascii?Q?E8NnPDJ7yravwmx64Thb3gxNvzK4QbruuXEPK6wX4iPIWD5yb8Q7ZPuZwMqc?=
 =?us-ascii?Q?Ql55vlMtZ7ywtP1wtM/DZLBlGc+Vsq9rVxWgRBR7qfZHKnhlRu1TzdtbyZ2W?=
 =?us-ascii?Q?rD5FVza0NfbhtK39LW0crN1knnQN2HXj/PcSye38Bf51+KoNpRLTUlzEvEYe?=
 =?us-ascii?Q?qE2GHAx0q14nMGH6BCEE707AY23nqB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZfdsHFOIhFJZ37wNULUN+O2iOgif+9BsnJujn58vBq924QsPy43sYkTJRd7R1RgVN2NajC5T8KWqpKGlYWM0GjfbkuloOGVgUPftt5XMBMub9H3U9quq9I0iPp1ToV0d5a2RDLA+VfIPTod0AO5p4DcHIc8awsBtlvo0ZZsmD1VQVAKjowclj/Pu27MHQ28gw/Ebs6RYEgI2/HAbAGUmZmsHC8dWlvQ1b6gdwQLGm4ipH6Or+bl03az1MahlT7pTUVpTuN+GELFMbstaaO1Uo1b8wtI8H6q5H32+NWZPO3x14ebVjYvZ86Ltgmg2LhaMN3BTC/cvR9nNtId0nLHBNw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793df6a6-48f2-42ed-5986-08de93aac80b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 07:04:44.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bxMoki/NeSqmKwIKzuu0VRhnElOqiTNLAdZJtmivcRZwSAgT2chVNgqNgZqexjkyMzgGgQVLEqwakLgK1qMQV3w4l/NgnpSyqiTGKD+IJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6079
X-Authority-Analysis: v=2.4 cv=Af+83nXG c=1 sm=1 tr=0 ts=69d35b0e cx=c_pps
 a=Ovo9riOs5JmVBBfNyWc1Cw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=4ZaGt1M9S-buqCWkuzgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA2NiBTYWx0ZWRfX15qnHEeUdnzN
 m1fIUoNJRSnV20GKPypcZ0Ov/QqnpEO8RKaVLeHCiF+Y8OEubM60cMApHdHT/3Hn7W5hKmb5RpP
 XdEHzOqepecvZVTvzx8ZIorSDT41CvPUPWy1thbQVA4eINcrv/4QsmFhYBq1wdnLjClQcMS/uv2
 YYxMq7mXwY4A/OvXZZXxfq1XVXnU6n1KPmYRp/aQZkNNRpzzLIkZJ+LZaJ67L+4fL7XekYfM/N1
 r1iU5WmoohS45JSWB849MnePHpWUOTXkiSq0cAYfEN1yyZ1fQaXWXD1sasNKUf8PtAixwBPgmrZ
 ZiqAdfWSkIJCU1tUy+yyePrzL2r96R+EeFbeIUSv4n2w1Ewy7P1t9A4ljJG7HdBal0Xo5QsXa2T
 WKqkXcOlTgflO1G08NOqHDF6asVF3w7XJS4GTqMs225xCiuO3cxrw2m3HTqFfKAL5R0lRSp6V4b
 /2RfnugrM1jKMa1c7QA==
X-Proofpoint-GUID: NKHFAZdPlo7geniJr0-ittv5EGER32Np
X-Proofpoint-ORIG-GUID: NKHFAZdPlo7geniJr0-ittv5EGER32Np
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060066

> On Wed, Apr 01, 2026 at 06:20:04PM +0800, Alexis Czezar Torreno wrote:
> > Add support for the Analog Devices AD5706R, a 4-channel 16-bit current
> > output digital-to-analog converter with SPI interface.
> >
> > Features:
> >   - 4 independent DAC channels
> >   - Hardware and software LDAC trigger
> >   - Configurable output range
> >   - PWM-based LDAC control
> >   - Dither and toggle modes
> >   - Dynamically configurable SPI speed
>=20
> ...
>=20
> > ---
> > Changes since v1:
> >   - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
> >   - Removed all custom ext_info sysfs attributes
> >   - Simplified to basic raw read/write and read-only scale
> >   - SPI read/write can handle multibyte registers
> > ---
>=20
> A bit confusing to have this changelog w/o having v3..v4 ones.

Will add the others

>=20
> ...
>=20
> > +config AD5706R
> > +	tristate "Analog Devices AD5706R DAC driver"
> > +	depends on SPI
>=20
> Shouldn't you select REGMAP?

Oh yeah, I should've. Will add

>=20
> > +	help
> > +	  Say yes here to build support for Analog Devices AD5706R 4-channel,
> > +	  16-bit current output DAC.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ad5706r.
>=20
> ...
>=20
> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>
>=20
> > +#include <linux/device.h>
>=20
> Not used, but dev_printk.h is missing.
>=20
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
>=20
> > +#include <linux/errno.h>
>=20
> No need (in most cases) when err.h is included.
>=20
> > +#include <linux/iio/iio.h>
> > +#include <linux/minmax.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
>=20
> Based on the above comments, please revisit the header block.

Will do, thanks for the suggestions above.

>=20
> ...
>=20
> > +struct ad5706r_state {
> > +	struct spi_device *spi;
> > +	struct regmap *regmap;
> > +
> > +	u8 tx_buf[4] __aligned(ARCH_DMA_MINALIGN);
>=20
> Don't we have specific IIO macro for that?

Ah yeah I think it was IIO_DMA_MINALIGN, will change, will also remove the
header where ARCH_DMA_MINALIGN comes from

>=20
> > +static int ad5706r_regmap_write(void *context, const void *data,
> > +size_t count) {
> > +	struct ad5706r_state *st =3D context;
> > +	unsigned int num_bytes;
>=20
> Currently only 1 and 2 bytes are supported, right? Any updates are planne=
d on
> this in the future?

Yes only 1 and 2 bytes, no future extension. Should I make num_bytes a 'u8'=
?

>=20
> > +	u16 reg;
> > +

...

> > +
> > +	cmd =3D AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> > +	put_unaligned_be16(cmd, st->tx_buf);
>=20
> > +	memset(st->tx_buf + 2, 0, num_bytes);
>=20
> I would use &st->tx_buf[2] here and below for the sake of consistency wit=
h
> put_unaligned_*().

Will edit for consistnency.

>=20
> > +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Ignore the first two bytes (echo during command) */
> > +	if (num_bytes =3D=3D AD5706R_SINGLE_BYTE_LEN)
> > +		put_unaligned_be16(st->rx_buf[2], val_buf);
>=20
> The comment wants to explain why it's required to put 2 bytes anyway.

Will add clearer comments for this

>=20
> > +	else
> > +		memcpy(val_buf, st->rx_buf + 2, num_bytes);
>=20
> However with the above question in mind, if it's all about 1 or 2 bytes, =
can't we
> simply use the same approach everywhere, like put_unaligned_*()?

For consistency, put_unaligned_*() can work.=20

Although since rx_buf is u8, this line:

     memcpy(val_buf, &st->rx_buf[2], num_bytes);

Will look like this for 2 bytes:

    x =3D get_unaligned_be16( &st->rx_buf[2] )
    put_unaligned_be16( x, val_buf )

I suppose the mem* commands looks cleaner

>=20
> ...
>=20
> > +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
>=20
> Better to use logical split (here and elsewhere where appropriate)
>=20
> static int ad5706r_read_raw(struct iio_dev *indio_dev,
> 			    struct iio_chan_spec const *chan,
> 			    int *val, int *val2, long mask)
>=20
> ...
>=20
> > +	st->regmap =3D devm_regmap_init(&spi->dev, &ad5706r_regmap_bus,
> > +				      st, &ad5706r_regmap_config);
>=20
> Use
>=20
> 	struct device *dev =3D &spi->dev;
>=20
> at the top of the function to make this look better.
>=20
> > +	if (IS_ERR(st->regmap))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> > +				     "Failed to init regmap");
>=20
> Missing \n.
>=20

Will apply the three minor edits above
