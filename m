Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7F35FF6E;
	Mon, 13 Jul 2026 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930079; cv=fail; b=qEcUr151MDXvw1WLfgtMcm6NHEv3C+Yph5SOd8xPOuw0CGKPRTdl5UqRS1Hg9rAURTQAEXfAitHhVTeJPhxOJXKGTL0dPHuurYQTm1EAUC2Al3WS6htVHiL+0Oa66ebZAnkAJWgd3J1X0NA4j4NwndvisMOhAkMeOcBRm3PEmI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930079; c=relaxed/simple;
	bh=PGoQZN5tpxpGELVwwwXzc7xHRSkSHGDJa2B89vOFnxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R0EIP2OScxfLFn3iNZjafofYTI8LFjGy/KZPKIUY1I2iGHN4atrEtGVypXOognaAzANyEO6Dmriur03UuQwpjkt1W7TftcgGgQhMldaZp9hTgVhiG2TrA6SIhwD9kgbxxE8I+jxa8gtWnfJG5+KlfbCgaMmqtorI1OttT0CjUtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pKjQWlRl; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pKjQWlRl"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6PKFe1682804;
	Mon, 13 Jul 2026 04:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AYL17
	Y0X3vSNbKhw3tFRtM69yu7y9/BG42ct8Mi9V+Y=; b=pKjQWlRlNzyBb47AWvE6c
	yzSxWn7XPOzmkIFUMBk2k4Cqo8MiT4lreDSWEkN/IGwJ3Ha9kUh+S5OwwYdYphU8
	+h3BYT3u3YxYPYaq5523osCChAmpCEycth57i8pgm1GD2omMuJ3yAnut0Lk85m8U
	q8ZihS+NZc7+el2SSldih5nndHIEl/pukqFGbr9Q68iUTcxvE7FBkQsbjrUgAfUX
	6mZLZKp7pPx9tpUuSaGrcvbrZon8Rx7Jjn9JHN+6m9NHmh+nDiASEWmDOPTffEFH
	zsWQySxj/ELpSh+XJrwbOApufNNJdRmLTSK3kZPSXWuVmxY4EZRQ4LMFMcdGpAdQ
	w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fc7vg2fcj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:07:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1sw/376tr3ggo032G+H7L5i0GRv91VOJI5pBkQL95dwsNqPayBr2LkQ5hUQDF9mnEwh27o6zedCt7YobVoHqLYtAXYqllzutAdhP9ln0jm9u5WKnpTOJqTnh0z1EEhrTGjMxGWHUt1izyobsya7M4aCkwpsyAAZy/6eSxSCcqPB7pk9EiHHKu+Z147spWZ0utFQ/l0OXkmhG08Dk9bdvTU4e/aQlX8fjX4Cod/wMGw+hLgF9SSeBtnJaRvDjpjiHr4iqWc2kihutDZqaOUWh0kzwPzSUolo9RxBo9jB8dwvHgU6xV19K5mMZYBVZuqzsZdxC5+I0JOeEVpqWyqYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYL17Y0X3vSNbKhw3tFRtM69yu7y9/BG42ct8Mi9V+Y=;
 b=poxwk0IemkjuoUrRjeDfR6VjvYANBN+r4JXltZ0FvDVRBvw89Znof6Gp5gOVI6FXObIkWFWVdrMUvMCxD1RGptq5Bovn7yYpzI+ArBNW1P2zuo7RtljQhxYEkIpPcKXQCBi/9dvmf8HhwfC5/D9slMu5m8YjPHGEct4QFDgNKa6Ke5nErQro7MyBymCi1ac8Ca4fBK9sokhgwptI5KnGV8LIfSY0O5s8RqWisB0QkYqWW+dgNxIDDy+uhW+Vj2hl9PZtHjS5rFxZfKUyxphGnffjtVOjw2YfPAj+G/2Efvuc52lCR4/FS5vHhiLsE8U390GK8PP+RIBZnIfeQjAI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY2PR03MB649933.namprd03.prod.outlook.com
 (2603:10b6:930:116::5) by DS2PR03MB8160.namprd03.prod.outlook.com
 (2603:10b6:8:27d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 08:07:40 +0000
Received: from CY2PR03MB649933.namprd03.prod.outlook.com
 ([fe80::fec3:43b4:61ce:f576]) by CY2PR03MB649933.namprd03.prod.outlook.com
 ([fe80::fec3:43b4:61ce:f576%2]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 08:07:39 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        linux <linux@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: adc: ad4080: configure backend data size
Thread-Topic: [PATCH 2/2] iio: adc: ad4080: configure backend data size
Thread-Index: AQHdAvGg4BuuOpfsJk6T1U+7+hpfSLZMxEmAgBxmRoCAAgsmoA==
Date: Mon, 13 Jul 2026 08:07:39 +0000
Message-ID:
 <CY2PR03MB64993378F0E160D372C9E2C7359BFA2@CY2PR03MB649933.namprd03.prod.outlook.com>
References: <20260623090717.3296-1-antoniu.miclaus@analog.com>
	<20260623090717.3296-3-antoniu.miclaus@analog.com>
	<3caf5748-0da2-4f11-a0ff-d3dd5fdf339f@baylibre.com>
 <20260712014859.1e92ee70@jic23-huawei>
In-Reply-To: <20260712014859.1e92ee70@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY2PR03MB649933:EE_|DS2PR03MB8160:EE_
x-ms-office365-filtering-correlation-id: aa0fb594-fa0b-4e52-5c9f-08dee0b5cef2
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|18002099003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 d59qoIGToLOzbGYXca/LxL1RRBAsGq2F9eAQFHcId2MzPGsgAh+/DSfUhNbF2JWGBQfmGDwIMAgpGCvGE26VUE1hlmi9ecpJoU3PUVmloNLf1urU4wOl5Z3jJqUR7v/YPimdVs+M/m49AtOSWRpIxhl3ImUGAU8au4AvnJ6858dF3zdrTs0AjoqXXQ95ub5/sh1wimiHxyblu1G0V+LG5Mkhfh3bc/ghS0Ny+CX2JNv0YTm+CuSoMV3J79eZQH9KGdA/YH89jrpGBxP/+aOpy50UB3SB1RCussEUp7xrIXcrhNTFbJqAmq84RqhiZgQgIe56JzSHaSkNOfvjuZIk2g5Cyc1OxUcsMYjBTbpD9HFgbAYbYwtQENGgN02qOhM/uR6VOKTgZBpSVoL6jdf/PkFURmRWvzSRWGtP7WMK8cHU0E7n42GbP+ssVXTi4/SeVf5nNc/atEnLL+yYMvGqU6NyEZu/OwOAdJRDc5EcuJ8LUgwIQ1AYseKBs2raiALPgSEOTJ+W2MWZaEowObLV6hdcSXfUtuaekaQPUoUmxuEQhzeL8ihoKDn23jNc0PcievMl1HkKEy3WBP0a+GK4qxFsFkQaug4pS9gEuRnGgu3pwxi0x0sOyCRSiW3PrVePOP6aPvJEC4dg/Af3p1ixke9jyrJjtm4PDuB2BIdkoU5OIt5ifQ9tgwbpTVj+O+2hnuRcIFFTqioJqXcUAWZoTJ/rNmtk0mHQwHDQlKwqB5o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY2PR03MB649933.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qh4EOAT0jm2uK7hMhlnpS/O3sHCowb+V3qcr9n7P/U0cz8YzmwXtCGuRHD3t?=
 =?us-ascii?Q?Ax9t/2EpTymqGs6Xg+ERGdRp37FqdpN9c28pLcziR3zgUP7R33c1jF2hgp6X?=
 =?us-ascii?Q?nNhmMOR2tYpqFh/AzfKUv+VAaC2lzAmfmt3C6RtSqJ8S1KA3c9ilZf5jvIwe?=
 =?us-ascii?Q?fPPgR1Cg3oHD4aTEklDFk+0NYi0DOLP2QGA2vlTuGqaG6+0tdGjQcuX0zda5?=
 =?us-ascii?Q?HXS8+DfaETtuQ0qTmHfSyQcANIKQUJFMnlJuSVtJeYpsGWDETLZK5PFm5zKA?=
 =?us-ascii?Q?C8gI/0zTAKCZ4P1QyNBU0+IajQsCeqsH2PUZZOVVpEiq8kJeDIwCPKDjaqu7?=
 =?us-ascii?Q?4zv1zZxcDD+R/hZec/EbapZzx4JrpP/UQ4SJtbpH8ftdVZ/FAK0oUzcdhgwo?=
 =?us-ascii?Q?CTrXO8vHeB6oc5RAr9GLibcYd0F+FylP2CtaP87yLKnpxeh56H8klT8ddbRL?=
 =?us-ascii?Q?qh/4yy8n7k1TIZ8H3HpNfTacKvjEvzz4uX7eaF74ksHgL7CyqZY37wQBNSRy?=
 =?us-ascii?Q?5mgOXJHUKdXF2fWRsK1V4XdgEAct2bl+6kZuRqusPwrxRwWjEp1V0cK1ni30?=
 =?us-ascii?Q?qRh8uJFWHd9lJPP3tEb2ia4j/934f4jStxGG0y8nFF/0HkQfLHg//B6lv8Vu?=
 =?us-ascii?Q?NgJTEAdG1Om/ghqZboC2UWA+Utl2AtNNmun4wGziK7xkRM5umQbtVLgTUxxD?=
 =?us-ascii?Q?gKjZpg1ftJN4ljoJ269PNci4aZLBZLLs9FH/bZatUOWtrK2gFgfhnbN5DQuX?=
 =?us-ascii?Q?9u4hMMFm0nypejvzJdOpLklJKLJOaFXj7yWsipB0geJMRVd3qWV2r4bvWJvI?=
 =?us-ascii?Q?FUSx7L1r5OtLu3FGhX+CU88oMKA8Gxyn5WyH+RCzzZWvHuCbSl+w5I2YstWT?=
 =?us-ascii?Q?2/k5i7fHNOgnmooUKVNtsfTqdAgaeL+PK2PGV/fNI9+OQZz3vEhzGOa+BVeb?=
 =?us-ascii?Q?qXMsgX6j3H3nZFsXIAF9XtJa+BWOjrSEhP7tC0bhLryI9EtcbT8Ar50h4P5P?=
 =?us-ascii?Q?6Q7XdD70fivfXVj1CQ24kmDa2Ro2Gj55skcoWRNafdmZKNlInhozYk0w2max?=
 =?us-ascii?Q?QBNaHQfGA3gIJTJXWW4GurNJvFvOsTQj5+c3Gu4reqMErFY3Jk6HhadB2026?=
 =?us-ascii?Q?tGr9oCNRMbFAWWtXZAiUrJNO/AmN98rWTGHElkmx0GwtLyt0EzkczHIoUTIf?=
 =?us-ascii?Q?lzB+koWJ/Z67nDMpcMu0ljinUtfN/NBYFAUjR/1wXP/pv5S3N5KGtOA1Qp29?=
 =?us-ascii?Q?wjJLXrj07A5ask0ZR2mPoTcZv50/notvDHXrne+XjAToEutoHxux/3SMg0hv?=
 =?us-ascii?Q?32eYPtOr0WYGyVs48v7++Wg/o5s+uKihJIDi4kc8l59T6KookdnCEc/DmhaN?=
 =?us-ascii?Q?CGljyeGBZY+bqrigTvbmFjMqaAx/TwAkMAozCPf0E6NdNnfDp1/fhHHPOKDf?=
 =?us-ascii?Q?C2A1oWGsyXgci/wfXTM4Q+IduVwdW4QkBUK1ToUrvNkOWzGuZ+8CeFgbqxdS?=
 =?us-ascii?Q?iHNtHw3k51pJImOJvhTTRvmn8aJv5EPD5NXtnVh+OSha3ysSWu5leEn0PwjJ?=
 =?us-ascii?Q?v3u2ZChR1jEYu/V0GKKytJ6J+RXwC7VE5pRllPFdBJNCFHcnsFhIqte2AU+R?=
 =?us-ascii?Q?yBpLHWqvec0TX78FTQdWqdyUJuyhzQCN6AoC9GHFLUDLXY52aEa/yn2PCQgX?=
 =?us-ascii?Q?yaa+wHzV0kCfxmuCn+3DmH1dsAekkM3gGcKXMlfS1yNScjikT+mN7irNxcI2?=
 =?us-ascii?Q?1/UOf6UCpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	FgSFMa/2nv3SuL4nDwo0bzBXK4e1nHd0EPLWCJSlesDoMMUZ1IwyK8CYxNyfL0k8i51Q1jYjuJfIckKk9ZnUa00eIoIANApTSxlotQJ6GQ9dBAQ2VSS7uVSfqju7+9BPXtcLM+1ZEZtDI9CzqTeziUg8+tAos6aYEmqzayWzt8TYKdVLtWda0wOznS6VXDOeBONZIdeLpRSr+cNMP/D4kx/dt43n5PhK6+fRS8F0yEzRZQuxXfdaVPQf6Bd+X7omr7mIH+fS88QRsWxziam3dIX0wzcABndVrWci9QYuLUL9lHxi/nVYbKTOek2UkF3eaLszzrq6zQrGzJtJm4kB2w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY2PR03MB649933.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0fb594-fa0b-4e52-5c9f-08dee0b5cef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 08:07:39.8516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSpBg6i6+Q56bVfQWnRp6ppu2OgZZNQBWA7GDNy0IW1HIMmm0vmeqoWpXLjC2+4M7RtARdvfnFPpiR2iwARoSS1g/25GHQfY1q08LXfPff4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8160
X-Proofpoint-GUID: AuhVbcVtqVkGGhuJHcSCiw4qkuJFThzU
X-Proofpoint-ORIG-GUID: AuhVbcVtqVkGGhuJHcSCiw4qkuJFThzU
X-Authority-Analysis: v=2.4 cv=Tu7WQjXh c=1 sm=1 tr=0 ts=6a549cce cx=c_pps
 a=KjzTqp3n3Gc09/MFY+gPWg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=s23-U_mXTwlAzeSwSQUA:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4MiBTYWx0ZWRfXxPAgjCHzukwa
 vwX5DbH0tu2GLyB1XO55FP5s9FzvEPmcRC35g1Z1fy4wMkhzYfmkQN32nVfczcji1+eKog8G0BA
 fpVlVjLraiDOjg05TaMzbw+aM+0/K3TsNlKz/IsDV8y9c4CZ/hlM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4MiBTYWx0ZWRfXxgnnbhu2Ta82
 NXYzTwkhgEynGwg+DoKr919sl+9ZtgFeMUFSmHLFtiq5vq4HBxVJ0BnHCXZZkgRtkN44cyjWEzJ
 9mWecvSYsIzc13O+yguHGcUvRhTNKlBtArIj1USHE9vWdjC5BZTEz1FnAbbqRmGYHnPlZ5dvySI
 F4qk1tyRZJQdHvk6f55nizTvJbZwTtdgupnEkY6BkeJ/OGOoIjpNvRaShobdh3b62MSW4xdTsaP
 mnS5ONrIoiRPCDUDDB0plFnvTXHgLcsu2/bAB0LBTMzbrOvzAjZ9J5Eo7v86pxtBS0O2y0WN6YZ
 g7TGJFmmM5p9xVrpu2TSqdZEbvqH9+WqUQUfxaUhUNmY6BbH5EKYAJH9s0jvhjf6qp7QNjO7LBQ
 81h/fSXSkmOlZPHX/OMesT6LCQrp5HrCiaTg49Wj2cDTdP3xZXxcEverFtVdIU6h6NBW5T9/ZBA
 duDVOp3yHb8VG9BmzVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130082

Hi David, Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, July 12, 2026 3:49 AM
> To: David Lechner <dlechner@baylibre.com>
> Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; linux <linux@analog.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] iio: adc: ad4080: configure backend data size
>=20
> On Tue, 23 Jun 2026 18:07:39 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 6/23/26 4:07 AM, Antoniu Miclaus wrote:
> > > The AXI backend needs to know the ADC word width in order to pack the
> > > sample data correctly on the bus. During channel setup, program the
> > > backend packet format via iio_backend_data_size_set() using the chann=
el
> > > resolution, so the data is transferred according to the device's
> > > realbits.
> > >
> >
> > Do we need a Fixes: tag?
> Antoniu?
>=20
> I'm holding this one for a tag or a reason why not.

Will add the Fixes: tag with some extra explanation in V2 series. Sorry for=
 the delayed response, was a bit out of office.

> Thanks,
>=20
> Jonathan
>=20
> >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > >  drivers/iio/adc/ad4080.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > > index 8d2953341b15..8feb0c7f7fcb 100644
> > > --- a/drivers/iio/adc/ad4080.c
> > > +++ b/drivers/iio/adc/ad4080.c
> > > @@ -698,6 +698,11 @@ static int ad4080_setup_channel(struct
> ad4080_state *st, unsigned int ch)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > +	ret =3D iio_backend_data_size_set(st->back[ch],
> > > +					st->info-
> >channels[0].scan_type.realbits);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	if (!st->lvds_cnv_en)
> > >  		return 0;
> > >
> >

