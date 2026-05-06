Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7C3EBF18;
	Wed,  6 May 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072817; cv=fail; b=bIlWE0Km1c7nEWkcLkPuqFStVZhUd7MU7uQYI/0xeRyV5oyInPil/Epx0e6nWhThv2syziQDqy4U4c7GOrmyEgRIOTpquatrZ4MagJ8E4fZ1HnEmWjVF7JYUhtM2zsWU5dhfe62cs2vHcTLK47Zi4qWzSO37qDPKinWSxYvItrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072817; c=relaxed/simple;
	bh=J/qv/JX2DesE1svICoQnHeekdF2ifPmCPbVXjVn+mY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmC9FV5BnwdBN6VaRnxncGD396ai5kkga4Ogv84N62gCNow4ALgouF50gSrXJLsJaTUQCKLHNT75bsLCCJxVPLTr+Scv9ocl7akIllZqm/nD+efC991xAtL8G4rxkQRw9Qu7WGyxt45vJJFepQzIpv4ILHRG97jH01p6NdqVi2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yXvwZqO+; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yXvwZqO+"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BaWJ62379043;
	Wed, 6 May 2026 09:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=J/qv/
	JX2DesE1svICoQnHeekdF2ifPmCPbVXjVn+mY0=; b=yXvwZqO+bFlJ9Z6V+IeH7
	hLGVEptVTVWkmIikmbzkb17dSZ51/aBqfBM3NWQzdG1RKLoAadKmRR99Mou7zDYU
	fgcalE0jtltGTQeSSo3XLMqE7+XdQHhgS6htI6NHCdPm2to4I62E5FPJcsWMthfQ
	Atcae/VDImRGin3uRISW4OJ6KgmX0w9vqDKy0JdKGekqf80Kldcp5/m+xUIASegl
	nENkj4gMAH8n22zrYOc7BvtBYJ0fogAxqm0RewzL70PNxmXkcJoe47zKhGwAK0jh
	lKAiW953lq1EfN5BltrDy9peKnbNHkwZUHKimGt81LBIRSDdZkT78B4XcrhPcjZU
	Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dyx23seu2-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOAz+063xuX/VxghFq9kBgMBj5w/1yY0J+f62Pt6bYQMRFNHMI7fUSspSieqPvwNoc03uaM9gzvXlVTczZOmqF8QXsaqEpH+nyyWClQ/621Php5imnrsindbh8pj1FRktQUKiD9DmT34XgP3UCQCSzKo1Dsb/t5Nnjh2NGSGP7On0eASlAsSMUJbI8eK9cTADhuuwaH0T0pjyX0x+w2/3QpE3Es124ifQ+tLnipBwys8GadksAxLemIIuJVyaT51WFCH9VJIn9I5GVkt0IAPDVTQ/BT0HvpKyI9QBvHRduWNFXBsVc/Fjrrx+TFgs6NLCINgnriuK11iITQm9wouUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/qv/JX2DesE1svICoQnHeekdF2ifPmCPbVXjVn+mY0=;
 b=X3S6hhws71/updunmAES9LnEMOzFYog6Ontd2psuJ16dQg1RBLfKlcz/hG/xE6h+UbZZkfeVCEt43QNf9+b9v3XLfTpJ0c5qwTYUlR4RUtK2tg6R9E7TFJTJIn1k6DqCYwIUax6w5b0/ifOvPuLx5/64IH1g4sr+Xon/y/FUGp4Ml7oBc/pDN4kAtVqiLtDWvwA+CIy/AuxINwTLIFF0hQh18ZhmsB+M/MrdE1EU8cKnbwdBjo0mo+eTHSwpDtztkCx6HXDgTPI75YIjTCZnmcXNqcWZUdfbPhJ0qzndDeSIvPtlaziWypSbxtP4ALzk2QYp1JuQFxf+oi3WbdC9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by BY1PR03MB7946.namprd03.prod.outlook.com (2603:10b6:a03:5b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:06:36 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:06:35 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support to
 adi,ltc2983
Thread-Topic: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support
 to adi,ltc2983
Thread-Index: AQHc1knlqBPOAtVfc0qFKzHj3Vhl67XzTSaAgA2hoGA=
Date: Wed, 6 May 2026 13:06:35 +0000
Message-ID:
 <SA5PR03MB83779FB7E2577AE0247D8669F63F2@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-2-liviu.stan@analog.com>
 <20260427-epileptic-pendant-1df77a472793@spud>
In-Reply-To: <20260427-epileptic-pendant-1df77a472793@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|BY1PR03MB7946:EE_
x-ms-office365-filtering-correlation-id: 7a050ceb-8104-43f6-4d7f-08deab704d39
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 josDLZXlzVx5uu1PJiPWF/qdS7O7qXW2um8419wftf++21XsWt3dK9HI5u2eknAJY1uqg+DsW3/uQoPgfVKDCtjXpT4+67zVQ3oHHbEWuKCCEebtrGAjiN7zqZ0920cZ3Jx/WtdqoYDL+9exXhd2VO8ITeZ9eXDI/YjIjIp4sA+laMA+NW/IWfR7cgYLq96/ozPeFPOdDDOi4YQBTjjGiQ6DJPslAvFOjX7IY/zPo0+1sCw80sZHU5lFUPl2hkwSFegoHALvzlXKHIDugCsrPDVDTeADED9tyAxAHPRYb5oi7rowwiL0oXRMMdDzfVOGHwPXQO10eWwZ3+INEOS/RkFHktlnlPrVNQqCvEO8fxRs5HwIxsjdBo+JbwzD7vFan8PaT15P4OOoci02D2STIIJUnj6duU8udAKodnYsgUJL/zoWFjTdcMMbhF9jXIOVxpA/By/8ZlcKlraBozfPByWMDrBf0WkHW9+fTf0Q/4VxE1CFkUs2AqTXeef2VI5zIqf+vzBvMjN5yMeAnYQbBz+4GD+heGHruBA48V8l6dTMXSc7bTE1QF4trPN26/pM4E/rsABte/0hV54qqwwHc2VDMlkPCiCMIBbrfBPUYV78MLV+qw17Dj7rS4BXthGQF5coAXCxW2czjfRb82PlPAEJJ0fRPOGGDOsiLd/N4nVaIJ8r7L1YEcbKXZUOpKJubiRJ44tO57bxr2FVqvng+nHVFHdPUSmpKuHwXFWRUtEFzRJ9C5iHgS3THdTym52Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-7?Q?7FzdVu2RPgbEuAdVvpl4o29XMYpEd6xikSzSl21+PTIBYEHqw9c3nFBb2K?=
 =?iso-8859-7?Q?Oem75gy5VX5yi37PSUy0SDdKTV1SQhXeqrJXoJS6uB/cWzqQxTSukMc1Er?=
 =?iso-8859-7?Q?I2NaSIZ57MBYSEv8Jb4M//L+lAtIHpsKk6QheWqf3ddm4qxjQIm+5SINSt?=
 =?iso-8859-7?Q?ntv75/T4R0tTBcp8MsEgo9Ae80fW3AB8LN5DbYoALna943B0wkau7i5xoS?=
 =?iso-8859-7?Q?90+IuQEeCM2ejGPK7DhzqdMrSfTx9M6XahvBb3eDyL9Qz1elZqdMHOHg0D?=
 =?iso-8859-7?Q?waKrMmOLcoE7EMw/w1hMiVzxJUUouZfBVaNOlrg3HBhLQRsigFYv+gNbb0?=
 =?iso-8859-7?Q?YXYYNUEs+GU/o/DxVsWEo94HX1ZKVWT1CUHPCMEBqfaVj+k62eLMtZBRZK?=
 =?iso-8859-7?Q?gLt6Cxkf3UiKZDPC70RG9KBYIo7uNCqjggIJBvGK16J8qP5+qzyBEz5CxQ?=
 =?iso-8859-7?Q?DWfQnl4/gUefihLnN82Gj1NlHHgkUauhtFA9s9ZmhwtyotJZAKgnEUwGiA?=
 =?iso-8859-7?Q?E6J9VtO6JidGx+o5sLX004edsJ4Xtz2sCrFynC3cIqucJz1oU2Ml9w43FE?=
 =?iso-8859-7?Q?WzycgUi3M4TjXv5IVsUFzKiCbW8MNkRIKjTTIIFhPvbhaU3Wt0LaVdQvRe?=
 =?iso-8859-7?Q?sUlXbB320gCvGwxtV3Wl0VjeQ360zSpaMxjvZ468gYexhvNPvK2LnQn89L?=
 =?iso-8859-7?Q?upY/jT02WGluTdU0HccLA36vk+tGfKbk+j1uWLsHF+U6RVxAKi0795dlrr?=
 =?iso-8859-7?Q?trNoyNvXOGtHq/YTnbYQaLdY0LCrdYV8kGt9doL6LpV/nYAH8kNLp0PNsZ?=
 =?iso-8859-7?Q?Ijldsj8g6tWmXUefaUdk952jVwnCxd3Wmttyj6m63xbO/lmHCaRl/riR5G?=
 =?iso-8859-7?Q?BKhNtBa4U99M/jnjeQMaE7MisyOLC1dv7H8bWaNCPaMWVxk5LCzcaVCEOp?=
 =?iso-8859-7?Q?qKKjjNzOSJ+ishK3q8+kyjXAFDutlgY2AF8VO9cD3f3o0a9DRH4w7YwKpY?=
 =?iso-8859-7?Q?Nh0CmzgeJ9MZrGNlpp4vjPqDSDIVXbZukvkJZRh05QOCUQv2lABgyh6w4k?=
 =?iso-8859-7?Q?ySS9V+xZK8yUUbeETxGHZME+LeIBXD3VCR0yxAc/ZHl8+rlZppEn5fe/8i?=
 =?iso-8859-7?Q?RP1QFmOGRzCjqCTo82yVfenS/X9aQDMphdM+eQVDj4zZBZqBTmk/NNmYwg?=
 =?iso-8859-7?Q?4qK3/SFo+ecPlApwiVUTREux/hqajdI6ymyUJp4aR9qGJhLtL2Vyp4g1sr?=
 =?iso-8859-7?Q?C935vGTbjaNyrL8kdHaNr4icYKdigz3PbxESrJFPmfQbb4yysxmJ4swg1x?=
 =?iso-8859-7?Q?nqF2qW5i6yJE+d/dDa+sooYeGsZ+5LNGS0tMw3mzLRBOoAtSwUPLU4vbHT?=
 =?iso-8859-7?Q?qntfQml1TfFCSGANV2zWiAtN71SdGsgc1lH+kT0uRcaLotq5tvYpTIvEpw?=
 =?iso-8859-7?Q?8CMGMo6fA6RbD0DlsQDH8la6Cs6P0WV2n7gI/84yOQcfrqvC2PyEQjhuK8?=
 =?iso-8859-7?Q?3AfgU8aQ0CUdPXcsUcu3oNDgl7tcrxbdCHf1wwy1ughaSQ+cBCSDd4DQw0?=
 =?iso-8859-7?Q?EFmgmCvqkzzi90U76CDsKRCTpTEwCyBBRcwAurtmoKvJw8Yz2yu59JMHaR?=
 =?iso-8859-7?Q?5kuydVZyocrGXzcbHc9DzNPbP5s2zVSC/In+jx14T4qsq1RUnnSSGxQPSy?=
 =?iso-8859-7?Q?YHZH27zwEV/2tupIuKV9YCBYzrc2eMytNCggmX8eaCZOPDb/McO+19gpQ4?=
 =?iso-8859-7?Q?gedKYs5xAIdyMQniYThskrNzqCMFI5YGWTEexrJolXwJPOeW5UPruShwAQ?=
 =?iso-8859-7?Q?SyV0LwKPgw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	c/5sI1pXs/RVPt6oOQTKQZWCjs8X8YUpkPh41FKzHOG8Cua7V6pmYYBzgzArikTe1o/JXW4VBc4V533hLhGUEUD7d9atLgMKxj+aGCM1hgaPB1W+8n+p28JouBTK6pi8wqF76by7zhpAzRR8LTkN2+AEey6tjefnAL/0I613wb9xKDQUSADrvtvp25FiadJKzHp+5JHRkTpVQe5wr6OYviOHBRKMcPX7BAcmtUTXGBukS50m8PHflUqmw/ymaydn1PRTOWg2eTSJbTD3dYFQxEDup9vPPc7P90WF9G5nKuPXJB7asEhNYF0MNRtYDwijIO+A8iyf9GK30OXmkJCDTw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a050ceb-8104-43f6-4d7f-08deab704d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 13:06:35.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBM+kwpxjzloB8bTKUNfJM5niKqaCGOnLWnDFjPPDiE3D3RukRawICQfvYyrE30KtZc020eFqQh+qwH9n7GjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7946
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEyOCBTYWx0ZWRfX3Kgu0W8ez2eD
 ZOQwGFJsl7e/8j1GzXv0AJeIQu3/Rs+pfBnu5moXOTuwdQA3llROldPa37D1ny/PfHmDNNR+kCg
 PQkXOvUWJMa7KZ1tlCFkUp77az4FebgfVlUq9rB8YYK/F1Kf7Mmhe2FN7HXpJiOfKIRW4skn2Zd
 E8sms3whgdl2Lvx1rZbQFkmHjnmCsN2L2EpSdYIvpgK5Xaq/ZKfagvZqYhb5zDluRvLo+miU/R1
 FOJDJrw6BqgO+YAekZSVrExkQ/Pz6Ea4wfOKdG3k4gwZEyrs9sDmtYBwDGIEYDhoD9X4rWK1Ui0
 1WcQ4BKwt3rSbU2FSsnyfZQ9Ck+eAH8x2FZgsmSd54JV68kJR8KM4FnJsxbxBuBdK9zyThbTxGg
 kz3zLSVFVu2gYniDwU4JiVdYaJq/87MeTiwyeXcgm2qE4b2rXlkpGBY5QkM0kMWYNrGDCaNIQ7d
 tvo6DphzpqbEcB22NUw==
X-Proofpoint-GUID: XHUtaPpfszsW3OrAwJPMR6xbGQdbMjPz
X-Authority-Analysis: v=2.4 cv=DvxmPm/+ c=1 sm=1 tr=0 ts=69fb3cdf cx=c_pps
 a=M+4CHf8fKMkYOwSYEMZyZQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=E_FQspuQcigA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=AqadZwGtysJAUTqUGVAA:9 a=o3X3QV6JOaEA:10
X-Proofpoint-ORIG-GUID: XHUtaPpfszsW3OrAwJPMR6xbGQdbMjPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060128

Thank you for the comments, and I apologize for the delayed answer.=20

On Mon, Apr 27, 2026, Conor Dooley wrote:
> I have to wonder if this is the right approach, if it's the same device
> just with a different label and advertised purpose.

Could you expand on this? Are you suggesting the copper-trace@ and
leak-detector@ node types aren't needed, or something about the overall
approach of adding ADT7604 to the existing ltc2983 binding? I want to
make sure I understand the concern.

> Pedantry perhaps, but isn't this an "ohmmeter"?

For the naming I followed the convention used in this binding: rtd@,=20
thermocouple@, diode@ are named after what they are, not what
they measure. copper-trace@ names the component being sensed. Jonathan
has a related question below about whether this should just reuse rtd@
with type 18, so the name might change depending on where that lands.

> I want to look into this property, where is the datasheet?

The ADT7604 datasheet is not yet publicly available. Will add the URL
once it is.
=20
> Are these ever linked in a different way?
> Ditto here and in the rtd node. Are these fixed linkages or actually
> dynamic?
=20
The linkage is board-dependent. Any rsense on channels 2-20 can be
paired with any sensor channel in that range. The example uses two
separate sense resistors because the copper trace and leak detector
channels need different values (100=D9 vs 10k=D9, these are the recommended
values in the datasheet). A board where all sensors share the same=20
resistance range could use a single rsense.

Thanks,
Liviu
