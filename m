Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569C39BFEF;
	Thu, 19 Mar 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897806; cv=fail; b=bMFLAQp3MCPIr4DozMSKW9jMzQpjO7hY+wUDjUxpV+X/lLdrBOJjlhGfqMNN32NnY/ojmGMr1Mo7gdOV8xDhVzIytbJ/u+jbnFvI3cYpwJgjP7UFdsyXKarVYEO/u+dLmEbXOX5ga0jkZ0uc20Cl0U68POs/poL2ABuJ8UbHA54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897806; c=relaxed/simple;
	bh=Zx6Kq8OTJlubRQPmQ8p0pQoPVf2qhsslsBkQVUE28JY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bpzu0JsrcaYz9oyXOm/UORsqo2sEWfdXo4pTa9cjaenZVF5soh2TuyinxdEgdH/1vOiP2ho/KtwPOE0cMhdkQSRpq6b7cdFNd+u3Bf1lF5T+n5eFBt/n6a9lavbWHFHn8kwlGDt2l4cJRLr31j+xjK7wzVVG1WxaIIhiAR6Y5lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tlvtqCpF; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tlvtqCpF"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J3ZLuO1334958;
	Thu, 19 Mar 2026 01:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TgSDp
	aqjQjYiJXpnx8q+t3EC4XTDISfFpQ8xWrwT83w=; b=tlvtqCpF7IeKfb8Gl89f8
	RY4ctanVjhMMCSeyUjOVMMLQiTZWsnQ+1D/RrAXgDGXH3z6T6UNZHKev+mkm7yot
	FO9TUtLziqKr2TFHXKwDohSYipiquVuaEJeQt1ybtO/z2YGPFFkGvz1Rbi02UXyq
	YBWyCjCxWdq5ccUzi7ly9a9rtAcPAbqjKjHIWT9ZILtWrU24wekuc+tTMTwNI/m7
	EnepSbyTfM0Fkf/6biE+HKHTNCqBAcjeilgZiEVHQ83zQU/dBj04TcWyYx/qWWPN
	9LsO/ZtRFUt/tYym48Tvcs+YRxmdaMI3rr78+xmB1lopdN8gPUrYltkS1ZRpTjzm
	Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cyxn1tv0k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 01:23:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlI1JPY153baQwaOJrRMM61tr8i8/6Qe/qUBHBeEkH1pc8NMZymrhXyMVCqyf7lotgEwZZmiV5mSdkhSCoeoISQh0V51IcPMZidwEcGa49l3iDeHluC+B/t0jN9fqS9BhtsDlaeQd9VnJ6beLyee6d42uay4UEGjKs9GCqk/JYeXlViCByYNer54y3Kso/DbFmWBVrPPgpoF4XmFLgtcFrFBPZLcBwvWlPHk0kDYZvUry7XqWf1fhwqLnbWWSIjd5NI7CGeDD5Fqu50+sQfeweA6f0pEgP1en3gGq+WMtJSM8j4Fj9/aefgTHnPYPZgIsKI4HsixbEdRZ1L1N7uIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgSDpaqjQjYiJXpnx8q+t3EC4XTDISfFpQ8xWrwT83w=;
 b=jZRTjgGD23PL57aH1cfI05Q+b6ePpjQwYH77Ap9lyp57/Pi7BlCX2NJyZ3JPdnQAQXbzYOOJYW1vUhJZzHdmX3/BmgHpD7PUvaa173KiqQulVIV0vlYAwGYsPah/jHtj3cPhzvA9t4Twa/2sTKEhPWWywGa/r54SYGasnUse6Drvzudc6tareuO7EGpsScOs6fuwGzPeUItYpoZBsTMZ+cpjfCi6F6zXHDKC9EyuCqW4m+GYdZnaH5RT8al6R3p0VOTnGTD6PSzKYfWvaPuaIKPLpHWUYIk+JYc/OCQhSIRmNAtQOEU29EVXUlRRffj5erwQzCInwJn0FtePqAm3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by DS0PR03MB8246.namprd03.prod.outlook.com (2603:10b6:8:297::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 05:23:01 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 05:23:01 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Thread-Index: AQHctpdQUwFwJvhg90iS2IfIL5Fi1bWz3E4AgAFHjaA=
Date: Thu, 19 Mar 2026 05:23:01 +0000
Message-ID:
 <PH0PR03MB63511480C4AB42BEB32490CAF14FA@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
 <20260318-dev_ad5706r-v3-1-5d078f41e988@analog.com>
 <90033bd6-aade-4e76-8cbe-4002b983bf67@kernel.org>
In-Reply-To: <90033bd6-aade-4e76-8cbe-4002b983bf67@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|DS0PR03MB8246:EE_
x-ms-office365-filtering-correlation-id: e2823562-544c-439b-ff1f-08de8577970c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info:
 XCBShhaGd7jY8S+cIFwtSgBHBU4KD7xo80m66pRhF60Yf0jf1tHhoqxsoXoO/IIoh5nkbLR1YLN04p+AbIML7mws8zTBo2qUuY0k6ox7jpAwu9AVwYJlv+MLROvgRNJRtNRoPOTtXI4aK4fkJOGJd+f3MQAyjX4jNlapBT/dHFFOhM5e/UMY2k/1yja2jHidkT7JQh/pjk087A5rAhAmfdiUoTlCVdPCsuenTrOvjtamK643JQDC/bL35lrJYF3j3CsHrDiM8L5Gyf2J/Lt8uug9Z3PCL6eHhcqWr64PvA1uYit1bME0kYRqb6ijemzdeOj1PrWYSV35PA7i1IsRJS/CkWA/pkIH0c0jrwHj7ODTEf4kd/XhbGH0stb2c0iODyGRA64RHw9om7jruN1wuO6a6XdZL6+Dc88kvEzig4RaKfl45lj5Ag7/MyIKdblvHBsedzFSPigVTKW3JkFmlKR4kg8/N8sw4nx81weT4eVoUO1AZAAGDlski2vKP7kYG8/herwAvLowgcKzkx4kCLp8jtqQyb6VmCnivyeRMZLsQ14/XczoatvvOWZu02trsSI168EKjbPXfZ2I/Ef5ret9LebtegUWseZVNYgLsei3OQHQB8sBbBY+SKRlyDEpmg7vg1k5VJfb9ctjoSVjZSYfKK+3J5hkrG0Lo8ceZj77l5KbxZXa6rncD8fLB5Lg+pdvfCYGUV+rnb/blwcCzxG4H30BlSwH4NTI+0xiiHJSH7fVNzKskvynJt2j4Wmryxz0qvK4iQYGaR3PYESGc/93e9U4HmIbA13eTP3TVoXcLlh2TU/8QLRmdlUY4LHF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1dv3j2rC78q50DJYoMnmyqpRZWHsEoEDrEkRjN5+Gsgr3WMPHMyTnkSCIxs7?=
 =?us-ascii?Q?rOE019g8kiyLmb1+OQG58mGmmwMkeNU1yTltkhUXle/ameeoXQLfBmXeENsK?=
 =?us-ascii?Q?yLpIsKnzIu4uXfOVgket/jLP3kLzezOsWVDHfvQvmBLfz2qZtT/W9RRbyYbM?=
 =?us-ascii?Q?khJttbr7EETd+eWaDVGhpWKT3cq1an1z5nrplrOgX5kxt90O9N/dp4W1wBVI?=
 =?us-ascii?Q?m7I+TDlC2z2EnX6spwArnGxoIZq4o3vXP+PaYleLEV+/jIrYvPZTH8xE0Til?=
 =?us-ascii?Q?n4WyjwnvfqZ0rDmuNMyhBAsf5w1Tmr/spAQgUTNQ2WTIyvK4sPnzm4R8qOwH?=
 =?us-ascii?Q?AhGR/qSwyjXgtNxiEidIS3OO1ZMz01HR2Kx3fftu1BcbrzmDHiLfy7ge7P0+?=
 =?us-ascii?Q?s+t3q6wX8f5L+kJswdybUAYvPNSygAasXkmPfqx70N94tMuuys3nhEtkA8km?=
 =?us-ascii?Q?kCERYNqbm4UGM5BYyPA/B+xByQxFTpNB/JC2++md5lGeBb2phr+9ZDZgs5c9?=
 =?us-ascii?Q?1Pm2V4OIsuN0Lp816Il8vR0NK27MGi8LyE91Ch9yFnYcgNuy2KaGobTRtFwn?=
 =?us-ascii?Q?cc4XyRypi7MErO6PMa5SiZyHDUx27SRKClII3++Zp9rPvJtldbavsW8n6nJZ?=
 =?us-ascii?Q?M5Hn7LrmHCsXc5gfvwSjU8BvplsCPltKkVIJTUz+T19k3uhVVi+HUIXuj3UK?=
 =?us-ascii?Q?n+zWIux+525hWnFqcSFEUqNEEG6XQctirUrH8nkILb+8Z51oEXyhu0v+WaUB?=
 =?us-ascii?Q?tlDGeprCutven2DhTQ9zU7u6tPEfoa3ID/Mf3XGXvCAXOAQRgAsBKNM027S1?=
 =?us-ascii?Q?dHOxLKNCwmxDKGifFdJcTGwVfds1Jsz1fNrArgYtZatyrflwXH489tIR9UXj?=
 =?us-ascii?Q?ajR05vIya54n+u6u5lIAlV4cPfGmM6QN36OsWxxpotVmZ+2DLKBH4mUAlger?=
 =?us-ascii?Q?Ims47Dyo2cHCwj5cSEVqdPJ/loRHN5lDUY8a7hOZEnhwasWciVtvx5Go8cmv?=
 =?us-ascii?Q?rIgfNLRwWn9bMCklnA+A8ZTrr2tqSl5OVHKb8usygoKEV/nTFVBVKVLYldDa?=
 =?us-ascii?Q?/1r+QUA/kWRbG+zQkA9iUvN4lmaIVQn6t/S4bNqbbY6cOT3YbUEz0wBCTi0u?=
 =?us-ascii?Q?2rV/m3lIfeKHUM67yt7wyB7Ety5Fu0JGB7j7Z+55w6D7g4aXCVKJqcQwFUmv?=
 =?us-ascii?Q?pP9W5nbHHpw6mSNfEN8JHGQXQzXs0Lnh+Ei3d0JnTUCPocP7O6mtpxFKGscI?=
 =?us-ascii?Q?fUrhfIElPy8oxjradBCFdKoAAF/fT6Iqg7/RNufduQ9+zG95MN9D8JVXU/pT?=
 =?us-ascii?Q?aUuM3k7TnJuuVHOGjhZY88cKo7JXQ3yksnngvNgubNi0SyIJAzI7enRiLRBl?=
 =?us-ascii?Q?k1k6iB8nSgeR2kF5dAhV+QUijrQoIPnpa6KHyFh0BSKy0hVEYfCRH8ClkjqQ?=
 =?us-ascii?Q?KCC6vmgH3/OyKtMKLhuK2l74k7A2HmYOdle0KerP8hb2FrlYagEnNZ+s0KxA?=
 =?us-ascii?Q?/bVHpq/NHuJMzy0C5e1D02ZvuwzN1TBCWpXIWJkFQJ48/1NgSse3J4kYNM6O?=
 =?us-ascii?Q?A0i9hGkdB3w3pQI3i4cqnjyMGyt3kMH/Zak6rn5eHjYFsZ71Z3pdtsrHjkJT?=
 =?us-ascii?Q?W0imu4kZGeQpCvdyrdm/RM5DrYKnggrcLqAQ3gNcty4FhPw7iCWLqGdJJI21?=
 =?us-ascii?Q?XkCSpms69GUpgi5RNrCzenAFUJpdiFqnvcyCB3+vxcMCK3NGfmX+6XxZWIq5?=
 =?us-ascii?Q?L/4MWV4VMzDLjO+7K5H8OCDWoLvUjAs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	awgZ6CPdFvVISTu+pO/dmovu7hD9VQO7AuPQXdnJeX2EdW170c+M9gEC2iguBoVCr/ysuS8o0RYlU/eAlMp3hwYxDnNa1exfKo5uKGNOsYa6bN8wTrzcTSVbhwHdskVxzVeqS68PrNJBUzVEeVrERMAgZm+VC1i00fA9E63JUzoZHWEQdIdPufTxf18bkbxo5BCQC+dWUFqpl2YZibMT4lNdRLZFCDKBRUzBYygg5gJuQSt++6KpolhZr0ECsCXiK835CfvxyPNvtNUHZAjMNmCOuVW8uIOrHcyoK6X0Tc6EezTbh1UgmfksUuEI4LlZDoA9sNWo/UEW+lK34iAxgg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2823562-544c-439b-ff1f-08de8577970c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 05:23:01.4446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DPzVbn8F6eSwy6bw7cmf77Kp+gfPHpTQ0XFhzzwxrSnAzqHkjkBHhZMZJJXiqyVnUKjXrxA7RnOvmWPW7wzMacMyxXAkiU7SaYxp3nCjRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8246
X-Authority-Analysis: v=2.4 cv=PejyRyhd c=1 sm=1 tr=0 ts=69bb8837 cx=c_pps
 a=26rO91Bbw6QoawbNyte6AQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=nL8omBM7rmvP4CbAS_cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: f_CKOLkCnLalYiNJg6mV92Pl9G1VABdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAzOSBTYWx0ZWRfX2mS9aGCjdbWs
 is7SyH78iii7xOsR+gOFQgw5ZK8Evu4lM7QKQcHleBFnYs0sgke/AwRzEE8pghxS09tou7QTnm0
 hfubhQgEWapZFasZvKEn/ldkoDItOLPV1HCJzRocs5QnLa6MVoBupARz8DvDSH7d0IbW1BCrf2U
 c14U/M33g9eIL0wgqRF8bpLGsIVrrlZ8PE4eimIHUrzlBqINy7v7jog2DFs+xbeFhOvm3ROCZiW
 RdET7HFbB+jWiT4OVp+ERmIM90CWwgoTLaFwhT1DD/OoxCznPPZkx19blI1EIb0p4UQn7uDjS5O
 sNWMoC6w1g63fg1VRlRLTI+IBhMh/WVTOpO6oBuiw10CyzQiAdFG6utJ37wK6L96BfchaZ1B+w2
 9vE0iH/oQ1X9QVpwN6ZUm+yh8QJPEpw6TDaOgYOQglkywaOPZZepNCSaJufaUagp/CH6F4GGhfb
 CLyUwhZ+o71mj/IsHWw==
X-Proofpoint-ORIG-GUID: f_CKOLkCnLalYiNJg6mV92Pl9G1VABdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190039

> > Add device tree binding documentation for the Analog Devices AD5706R
> > 4-channel 16-bit current output digital-to-analog converter.
> >
> > Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> >
> > ---
> > Changes since v1:
> >   - Removed clocks, clock-names, pwms, pwm-names, gpio properties
>=20
> Why? This is odd, there was no review to drop clocks, pwms, gpios.
>=20
> Please read writing bindings - you are supposed to post complete binding.

Saw the document and I seem to already broke rules 1 and 2.
(Incomplete, and removed stuff to match what driver supports)=20

Will add them back and corrected.

Thanks,
Alexis

