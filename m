Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1443477E39;
	Mon,  5 Oct 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204816; cv=fail; b=Qb1YO1PMpKfptcPS+l0J2kM+2HL8N9YCRlclVBe1HMk6iq7118f0lobtP4grRiHNKStgJA/IOoCTYx2LsDmWm73OJLsRO+fTilDn/3f5nRhPgT0BJWU+SrPzNcB5DUJFjko/99e2k1xQsifWs2n4ar94DXtu28MkOJRp/TAZCjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204816; c=relaxed/simple;
	bh=nOPhLIMJppkciaWWHv+inXmvlk9OJGZNl8TVhHVv/zc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qmrf+VK8lgPCo4q7G2mgPISWV6JR0dqZJKUri2LZxpfEpMOIZ0nMzyfRLS11EHzhrhA1YxgnYDhdAx3MSBOituUZwvBF59Q9l516ijw0MTmi8CGdcMnxuFqRc689a6qCriJQ78EJc9ZbfiLBYSrZ/wqUMqlmdEAu/fJypui1KVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JhspJ9BD; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JhspJ9BD"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695Cpgw93341219;
	Mon, 5 Oct 2026 08:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Tskbi
	IBG3OS2MmMrXdrLEeMKhdh1G52cA1CHP0fNRls=; b=JhspJ9BDd3EH7QfuRKnIH
	vMgzRgTf5maA76/5kI/xx28D7tn1VitWpG0wiFCDWMu9h9b4Ei7rkZRDXc2ccmPa
	JYjsRzXK679QFemlBxHfGU0h8A/j31d2mJ8Qdj06dEuu7Bd10BOLKDaBubaDA3Ov
	E01slmpgD1+7DP0IrKvvFcW3GwM/dvNMKMNg7NBeCHytryIN/aCEoUS6LsY4Befd
	qXniUAiAjuQU96JrBnBj65ZK2i3Tvc84/aZ3IMJF6uPtW8KhCrNC3hKLWwFNUkmo
	uayCo7Xi6teRPR54C183tQ0cFCNFu/s7gLt0d2ArRwBKGmlan9mCgHV9Wl9gaFN6
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h4c95r06r-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:53:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCsklnCebH2hcrncPn2oV8B6aaY1Levuy0VSHNoLK3gCkBZ1mb5a1XvIehkvLaDL5WS7Bud2VjQLqi74/DCaBjgO5BMOTp74hxZ8UtM2q3liVhRCCRB/i4vKd/IoKMTnah/mmqRD2uKNObF2TsgQnvuhCyQbJ+fWaDN3BX/U7qWccOXa3WKO4QM04VwdCK28EwBZKLZ+1IFAn1mg4Hfsjgno7x1a5U8Tf0Kk/H1tWf2jmFCccTxHu/WrnkHmrCnFCfTnag2Cxzx8JXVZW18EWme/aLW9UpfpiuHw1pEAI06RRIfqtwQRFQyxqy78ygIBAp7hHDvnbQk/usjvnzAE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TskbiIBG3OS2MmMrXdrLEeMKhdh1G52cA1CHP0fNRls=;
 b=BZJWUe+LBJv6N3XFg3fcwzk4bWSZJ6uAfEeXiALkNnxlKrQGjjwWoPoO3eD7GVqRj+PX2sUXvxz1uok3PHKiXKLeA0FA7f8yy9UQ1nzpRabREWfj4lfsYv0/QDU0gole+fQvw5kjqK/H37YHukDD31tfMTkEeMtIh1eswLR5SFrhIDCYYC+4FjisG/3JHIOcP5DdBqyXO+5Qwzh4PF39wD5n3/+m5ozu6r5JZunFjB2nCI3qK4TXwGX0YXep61qEysAynut/rcN9GX22d0yRaGZcBNeNLAQvHpe4FKewod3VK1JxmLvZa6DfKRlpMlSrcDUm7u1mdVc3/kTJ4ItLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by MN2PR03MB5213.namprd03.prod.outlook.com (2603:10b6:208:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 12:53:01 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 12:53:01 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Conor Dooley <conor@kernel.org>
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
Subject: RE: [PATCH 1/2] dt-bindings: iio: imu: Add bindings for ADI ADIS16607
Thread-Topic: [PATCH 1/2] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Thread-Index: AQHdUYTnPfCnQVN/rUumtWUErn3NVbbpDGCAgAXfnnA=
Date: Mon, 5 Oct 2026 12:53:01 +0000
Message-ID:
 <LV9PR03MB841414871915A3A276849DA1F7962@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
 <20261001-adis16607-v1-1-9c89cee35d56@analog.com>
 <20261001-custodian-marvelous-4e0dc985fa3e@spud>
In-Reply-To: <20261001-custodian-marvelous-4e0dc985fa3e@spud>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|MN2PR03MB5213:EE_
x-ms-office365-filtering-correlation-id: 0daeebf1-bec4-4b53-c37c-08df22df96b8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|23010399003|376014|38070700021|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 cULk72oFqnuyOyTsQ6lo1cgWWujVf1sLtzNN1YeNnngvWyVw+3f1Bzr8+hMeGbdnJUsYCfUm1hKEHVmJbmHhFKYbLZdEIj/yD/J5PBbOP8XrMLZ/MoYYIpgk2qVcuRHB34Rod2vjqYRlq3/k0GuW1QRm8/bUOZw3HJ88PoBlYzQlvqkhQaJS90VzIod2q2+5Zzxll5R+tHYnCNWdI4QWXXu25pjVrivY3FFv7b8QkOAQm25nbkpLddjCyoowfzLdJGbbcfkRo8Nx0aUDDzGl1V0eEpmyxh83kHTQwXFwLOR0r7HAEQ9MTpc0gp89EYioNFviI7et5MbpG+Y3zV0C+qMg+zZlh4WWMgkTHo/CUXMWQMOzwYlVyVyTEThQoR2KQtvlM5jRm7KI6/SZktHQQ9knlBGIneoVE/3x0WH0LYwgcHvX2uLQiwUDvA0ncUq6HSyGEI4xq3+hBGd34pQh1tdFp3+bZMDFjzH9a96SL1BDvogWxYZzKltIjOKQmP1RV25K+2rtzHjnBdYRmNGjYHSU1j9ThJNCl4dZTUAwY/O7/q87xpPFgkr/XKI9ajxwgK8JoxRgj3YypITpKzUcdUj3I8TnoudXUartlWg4GkttvOgjIH3Xn1ww0GdvsdFq1xhTqUXJtL/l//XqqzCFPkqfVKyFe2RaI8XLpCb1nPNO61Qr/MQagESuFEjmIzyuQ+rZS6187VqJmOFwZTdz2340VwYKFVX5qtGav3XkHmg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(23010399003)(376014)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6Bg82CsykHhVuBxhJo+0HpygmN4K6W5iuVH5AESO4e1rXF2InhCPTnE3Y0Oq?=
 =?us-ascii?Q?S55Uge9szfjuPjhBCrPkXCLfuUiQyN9L+xqfQhrBPpVn5RBHgP6B/SQVLQ6+?=
 =?us-ascii?Q?YSXFbY5KAonZpImdwgGN5UzxtCGLXFCpljUErg26XA4C/UcSL24gGaRS42ET?=
 =?us-ascii?Q?jH2gHs+mSFG7I+Xz2ALptYE04AgyBbHTBaedwgvSxI5WPAGvmbjgofZZ7N2A?=
 =?us-ascii?Q?CnZDuSEAucYC6kdBM5WkIRml1hcAWSw3m0RtyiYX91uNcR33vGR1DRkmO8m4?=
 =?us-ascii?Q?nWuk+1TM7cl3vIgBiDL6GoR42K9NCL2HC5WeknKLqv4hTrB1gz3BGFlKwhmV?=
 =?us-ascii?Q?h8kn7dF1ls6TFAMtg3pKUiiRLU0gatv65rPpcD6CbwM4JfJkWvZFRbarLaBf?=
 =?us-ascii?Q?VdmbxT5RUZ//VCR/BahHY4s8loztsVLUOGJS98BOQUQSeirmdxTTvK4FpUQH?=
 =?us-ascii?Q?HwVOTSH5YFcQQhuyQj46m+cL/eovNfE11+WJ6mgLF6m0/xhFyHIKVWj1NUdf?=
 =?us-ascii?Q?jcuC/quWVHjWYd4yuK7zqOYpF1/kuy/3+QffHMaQE6kVgewcYgdXYp+fx3Ek?=
 =?us-ascii?Q?03FBYmAxwdK5MP2zSoAqg6nPMWG4XZnBMERRZeYsXQChX7RMORRoBuKZu8jy?=
 =?us-ascii?Q?alpnsCsQRWUElElk6gbRVo3PTsKIrn3nbu2MvHa+HVIEvLQc4un5jTiO154j?=
 =?us-ascii?Q?YBtQvQSwhsZ5vy2p0/ykTYsBzeLjVmJdudauYR3EGiPMUcO7HAs0krrO9PT7?=
 =?us-ascii?Q?fbgP1aUjHiZy0RCCYzZg/pyr2AFeYS3uBd1YeLsML1Npf3EuIYAt985M/QnI?=
 =?us-ascii?Q?tXQA/6Me/wS9WXU5GLFzSa146t9lTTnzwK+HIZ2kYqTxta42Cf1Lr3vP/s54?=
 =?us-ascii?Q?3pA2tW9o6Hv7+wPeQs1elchpvKtJXFiqGJM5e8jnZKfeIU6qB/OCI8lYNnQ1?=
 =?us-ascii?Q?q61m7NUxhWRCldd/9FaZYzLW3LyjVFg3ucFxgeCZerI6H2dSN//nfvx7OHc6?=
 =?us-ascii?Q?K9zwYQxazgsz3qJegMSbhd718M350WEBDG4flsw3SJHc4CYL2FREHqGG5gxm?=
 =?us-ascii?Q?KUSerYnZdiXSybSstmBPadRQGx5k+SMh0FRvvxX2suwkPMRg1AXr6rSeS5cy?=
 =?us-ascii?Q?gevtIgOk4QckqTuWOVqFWkNIUdtTXVOzF+CN7yV2azIXyrtz6GVm2SCUaPp1?=
 =?us-ascii?Q?b/+pgEsXDpjMm1mIlHOh0a9qVlE20wipCyjD7HucQcsXtl7WJqfC2Pa/DWRL?=
 =?us-ascii?Q?gt3C6ugHqGdxkVkswufA0cOYgoMdFog/mt/2gaD5f6+TGGHGg9g8U30uqW4h?=
 =?us-ascii?Q?VyV8nP5815DuTSAAAsNNx/biwbH1F7tDaK93IiEXRT7Wnh4aOhz+Nw0awGYg?=
 =?us-ascii?Q?N1m3ddjdLAqGTc8HBuVnzAbngDK2aajnfRc6PaHaxVhlmWrwUl8cDyj/MCKt?=
 =?us-ascii?Q?SID6KRp2wgbAnbHdp5e1EYWF/JyU2Shyx0cXMYgD6+FLvJYN7/evrLAz5RFo?=
 =?us-ascii?Q?liHvyNhvzpmRO+7NUb7g71oD5jWjFI2EgEWict+Qu2TkhavT+9rQTRhm+TLT?=
 =?us-ascii?Q?lN6+qxLAiWRaKzWEcByjIW/IQ21IAlLJ/vS5QwOb/jN6utKQ5wI6dK3HOvYg?=
 =?us-ascii?Q?bnnDBB7LbaRqKTJoFJ9iRNS/jwuGGCRx2VHri81lYxAqSddrTe2FmAjXLpWG?=
 =?us-ascii?Q?dmfPogbC/5A4Tfm7S5FuE/Xl2lSQtGFFir7ojvf85Ti7oI6O5bprdyDes2xz?=
 =?us-ascii?Q?KMWsG+dAfn+FphTpmKVgPh3P6ZM8yeOzf3q+fDOR2sPWRtiRiWCGBf/35t0T?=
x-ms-exchange-antispam-messagedata-1: aSCWKttDZA+j8Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LyC7Zp0Ms4etBXlpZsCRBKotjgoc4JkLZaFfb5EVYmtuKDQn3nwnfaaUKjY/e4uuDMcBe9zt7jOev+rglakzEDY2fzv5WvehEzfMJ2RFRCWaUyZsIeak6+E2NFGZ2fgD6i/SRVTgsq3gisx9mYhTmEYkhmVhxh5vrupGuRe3na8dBI0JHPRTv/JxgwNc2Ztm6ao0ILv2Gz3M1YqynbOS7YpGEKn40jEzyI03g9yJwfImDGrT6PyzudiTsO+96l/GVsDD6uzjlbdJyy/5DUDjO2xXxwm4azQ96QalKr+gQDWuEbA0lpZVzVn8+bplO6yq0INavTfEcDSXL9Ez6fcE/g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0daeebf1-bec4-4b53-c37c-08df22df96b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 12:53:01.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYKKlgOaUqwxHb//s+uQ6TII/JFPjofRZVl7KYBSPVLxiwTb8O1zCXQYuaVOe8Zy5WyNoN+wyn7xy3UDDN2FvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5213
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MCBTYWx0ZWRfX6WT2fvmV7XNa
 vOvWI/Fm9N1yp0gdcQ/fFQYY0ckI2wOLXF9oja//qK+5Biy5D6WlWN0Ud8HzDK05WQ8H6ecZCy8
 /BR4dCy6u3gWeGEDRlLQhhaa3k3SYKf2a3U+F3j9NZyNYpW4QOkF94alOu5nalcgfo2F2HGEyES
 6Mtnv12djRhkab/NJOLQ8+IAEUbUjfC6UsakF6CmMyUaT+DflbDS4RSjbdT7Kra/PeCCQp9Cd4a
 RU2PRaEWUGne9C/Dxo0DVM1ipidG7D3fEMXuaGxNembNO54PJ5q+h7TOr9QzgyCfMELq5iYYSdf
 GtErLhG003K4TbffNACcvIWtR8Bo7gdhxuL0QTfQ+emircMwOBhXPhLvlrlRqdWeQ0TZbHdvooS
 U2Rm1F/4IUxtUPOh2IonErHHda+KnT/dEo2w+fVBd2LGsNzax8qg9nwZ3d9oCV2ZLfvduvYLuQ/
 KYHf9h4NErjkMPUmLRA==
X-Authority-Analysis: v=2.4 cv=HvLjiETS c=1 sm=1 tr=0 ts=6ac39db1 cx=c_pps
 a=sTXJTCApLso7sb9o5cHK3g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=VwQbUJbxAAAA:8 a=UHWTFwORYkZbGGuO0C4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 9RKXL7zxG5UvzvX8OJ8KqoUwUDXYNYcH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MCBTYWx0ZWRfX3SzcORYCzkft
 I4ZuXhBX/MJ14b6EjmklgP6GZcOSb5NCSo3Rc2LwlmejKbNoyyj4gXGORqcesEE+qgiGmQhf6VY
 0bJM45rqvc85KBCPrtT1Fh++2zVLW86AkCRsMD1V8CZqI4EfQeBJ
X-Proofpoint-ORIG-GUID: 9RKXL7zxG5UvzvX8OJ8KqoUwUDXYNYcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1011 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050050

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Thursday, October 1, 2026 10:05 PM

...

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adis16607-2
> > +      - adi,adis16607-3
>=20
> Yet they are not compatible. Why?
> pw-bot: changes-requested

Yep, Sashiko also pointed this, it was an earlier version which won't be re=
leased
anymore and I left it mentioned in the commit message by accident, I will
remove that, sorry for the confusion, again.

>=20
> > +
> > +  reg:

...

> > +  adi,fifo-enable:
> > +    type: boolean
> > +    description:
> > +      Enable hardware FIFO mode for buffered data acquisition. When
> enabled,
> > +      the driver uses the device FIFO with configurable watermark thre=
shold
> > +      instead of single-sample burst reads.
>=20
> What aspect of the usecase does setting this depend on?
> Why not just always enable this?

This one has given me some thinking, and I think you have a really great po=
int
here, FIFO should always be enabled. At first I thought that the advantage =
of
direct single burst readings is that you get the diagnose at each point, bu=
t
after some consideration I think the FIFO way is also correct enough since =
it
gets that diagnose too if things go wrong so no point in keeping that direc=
t
burst mode. Thanks for this!

