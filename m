Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BF3C10AE;
	Thu, 25 Jun 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382080; cv=fail; b=ZOuJiMNTjw1dvn9GqJ2w0v2jcMgkFDV3fBIMZDgOQ/IIjdslf+4jXaoVUqCYyAPqse56CRKr1p5SFZGct4bx747C38lEDE6N3xuc9PW5cNkeA7HXdL2q51tXYjUQAd/jIWX1oee0bNLJIg7imtoGOFITngzfU3fbyIvCNstPO+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382080; c=relaxed/simple;
	bh=rgn9AOf3mCh8/ni8gn+diHhcfvcaSuOSw1GOdM6bAh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JoDPR/DQsOzxlTdiqiSImLrrOWK2zyGMeJeT/O5FxLSKWCYCzXK32BEbKTRBTJPwIFqhnr1GYCUMVgaFr+ObSCPGFqsOosrf5r045Gj3k9LsLF6QVD70DSPe3xPC6Ym5ABlkSKCuLCFBjoozI4HXhQ1TCun0Sc7/mcgMFtsV56w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gmOarqi+; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gmOarqi+"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P8OTgY2583271;
	Thu, 25 Jun 2026 06:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ugdls
	VV7H5A5pWSqpMlrZbFejAjWFq2wYfYPybhnLvQ=; b=gmOarqi+YaEgKLmp5qGDq
	XLsGNcDYGWL9Xwpr4hoxicBV9MSwArELNQfK5to4d+cri/vIGRLLgxuDiy5NA2r3
	urlQ29ac2dc9JkAVBoS2MopqrY50T37XK8Z4tRPuFtdZojdMadluwF+IFWGHRybd
	bN3M7oEDNTMONstQSe1E9rsRenKwYojll6ad21W5K3cd7gn8I1QrbCxmtpMp7Gsa
	0Sd16m2iyfY+3GNMcF1y8c23lTElBGTYwI0ceJ6qDti3Edg8WHHCQmlmRXpfZf07
	WsvWfDBqkcXsNofnAyV/NK+i9QZx2hmPMrYJHuUxT3kUjUaXU4wCMNiapveq2VgG
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f0qgvjgs6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 06:07:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpQemsc4cR6zq80IXcJnNcn7zdzNskUc0M711Zhy42tjy51tosTObda67+Dxd8HcrSxq/WglLL2/MzP1159UkwkqisnLhY3WN2oTJ3D25NSrt7dKTfDJkMLqqyXMFtXWd1Cz3IUVIkhqG8b1bp9HR7n5COHJYikybB4T6vQobFS7s2Wv8RtzFhd7FPielg5DPXBWrUYtPz7HYUyFzPgkVOywzyL0jcGYXFnB6L6SV5doPlAVFkVxWbTe1i2d89Codgx4691Xpa1RQeyObKuP8sHCUYKAgTI0ZuX1aqh7FvZuSNbeSQ8Ter/lOWNy+tI5s97DMGcz37Mi4miJJuqf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugdlsVV7H5A5pWSqpMlrZbFejAjWFq2wYfYPybhnLvQ=;
 b=TsBM/YwTlB6bDV25+A88k3V3rYSpJD7cIrB6drsrLAbQmsJ8MfPx9Za/Wir0CQZhrF+AVP6bentNebVquhGHLJBakx+yjL3tUthxzOJvdPWLfc8snZQRXfuXpNrjQDUJEvNOUFT5seZXfpwYqDpLHAm/VhcqZlqMk8e5wRBAF2N5W0Trk02qqR2GJVLUQgkE6zPMy2WQ93baE8IyOc17mUjIm72f2L/p7oH3NslZMU7r0CQS/JwKm8ILKR7/9zkQ3FMicFh6Zne6VHaAcNtPSmW47O1zKPp1XxNSr4q6G3sVa/jrDm4APlhISUs4r2SdUvUB9mfoKSnvjRYNiBd5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by MN2PR03MB5325.namprd03.prod.outlook.com (2603:10b6:208:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 10:07:47 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::72cd:8b8b:cf3c:8376]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::72cd:8b8b:cf3c:8376%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 10:07:47 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] iio: dac: ad3530r: Add support for AD3532R/AD3532
Thread-Topic: [PATCH v2 4/4] iio: dac: ad3530r: Add support for AD3532R/AD3532
Thread-Index: AQHc/I8+DQOesUXe2k2hx3mE8//lLbY/Y/AAgAndxACABdgt4A==
Date: Thu, 25 Jun 2026 10:07:47 +0000
Message-ID:
 <PH0PR03MB7141524D6546CD0FF1EF43FAF9EC2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
	<20260615-iio-ad3532r-support-v2-4-84a0af8b83fa@analog.com>
	<ai_OeEegWavHcNF1@ashevche-desk.local> <20260621174548.5eca5db6@jic23-huawei>
In-Reply-To: <20260621174548.5eca5db6@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|MN2PR03MB5325:EE_
x-ms-office365-filtering-correlation-id: 9424a304-19fa-416d-4275-08ded2a19bb7
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|38070700021|6133799003|3023799007|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 /TX3J3IiGjpXyxzVyzcYlB8lRbrbxzvfSPYtv+Xch5+JEdqS1yX2XNtUWrCwn/EXBvNyhaI1gbYa2xLYmJaOekNHd79L39M/4OjeY53h8o7uO8rRAXf0sZHZXwFB1+VwkK0mrLN4me25h90J7Ac5ImaUkHm5XGY5236Eqiil4jZDUhoYKQderfcwVzbYpVCsKDsD86KuBceTf1h0qoo/WHNbu/qi6uTOtz1n8+eAjNxaTzUaN3MCmRRVwExl+huCnvaRKItuiDSOqrT9Vi0URV+hBL6zrikcOrYl7f3E3rAmEALadNdCsMQ0lAmrOzv8moIvCPIlMbR4EbjCj7axCMd0AWt7qVpO05E1JNxT992dPQJ4wBNxoPV3LXRIBqNejwWo98mXNdrZomtoraxPJmmgU3aA3d9qEWoZWptgYvdcrAEyJz33bKVNPoCY/R5nhaQDMb6iEJqnpGvSPldy78LIq/HBorsRohfo8FeW3AmWVk0jRcoHGRXkTtLyIP7xBEYsLJ4vlUkXPrPIPal0EKqQPtVcmZmMu641siGPS0PHStqbCJdhuenSev3jE+M0oRX3omG7FH121tVnYNp/nFnGqQsz2iewew15OpuX1g5PPwpXOTq2qcbX0tKyRdteGO25OoV+tuSBz66L99ecoAPSTIyPn9uO1shHi0pZVGA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(38070700021)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zrc3/pyJ/l7UVdpvq0F4p73FStZ5k3lSJL5IxVBh6xczsFPImnsjbBJwYjHH?=
 =?us-ascii?Q?vS6d8WviHkvnfiHweM5jCEN4uvsFo2wEkkDcoY+9CWcftSnB0qtTTll3tCJn?=
 =?us-ascii?Q?8Xwzj5/H6pIrdR2ILhAnz6Qi9jDTbl125G7OPVsc+NfCk52ljSHn6u9wmF5+?=
 =?us-ascii?Q?NxGGfaf/vdN5fkSuXETVEXGyU0KCIQtvzmjhRG/o5YbCdI0M3rukSLcsm7cR?=
 =?us-ascii?Q?bcr0tG6qwOHc542A2OvnZysAGgvMVba6LLIduvK/Q7lMU6UFnbgvWz5ziauk?=
 =?us-ascii?Q?qTes+eSbWJd/cnYSOqr9i6W4pawW2kpMIzIuKj+fO25/rtYwI+YY0XHbneEc?=
 =?us-ascii?Q?buyM9sSJRqxbwDAmq8qaZnjABtqVm91ZGnm5RRP3MG4elb9+cctyVBE3fxwz?=
 =?us-ascii?Q?oXTfzKR2/fqbcZ6z3c5PnBYqSLzhRZtXxnFytzjnhVJsYg3+X/w2hBy4f8sE?=
 =?us-ascii?Q?w0+JeyCPbCH5SdWQEDUb+Yy2Kd6JVcaVOXh0TU9s2shjOP2fLDkO40CC2LZj?=
 =?us-ascii?Q?FhKse3pB4NHKyDfHs6X7ZlTH0r2v2SK4awrzOotCseihA7M570XV+TBVZd2y?=
 =?us-ascii?Q?GEBoaxNxkdvDSG8Y71MDq2sVlv4wv5TKxheO8hAmI9pl+kGBT7bGPJ9s6tL9?=
 =?us-ascii?Q?rtETaMQlZyO8cSqAVOTzBoUaW2dyN8PXTyXzBmI1+1fQb+1nreYP8QmfPuMu?=
 =?us-ascii?Q?uIlYhtxpg6icrezkaOFx37V0eGUcvhCck0DP//M9/dlzE2n5UelK6v3BWie0?=
 =?us-ascii?Q?2zRqW7B9CjhOTwsvTY4ODE8V1F2RsHS8rFGKUvrrt9faJgT8i20/hz+Hmh/k?=
 =?us-ascii?Q?TJ/tZTHDsHu70ehPHDBGPFjOs+XuGzXjDlt/SrjzTCiCH64Beg1gm7q7ydJ6?=
 =?us-ascii?Q?+LxRewYRpez+D7NHcKG5wmG/n2TxSWXhrBuad5PiyCoo+uZMwE5De/BewCRK?=
 =?us-ascii?Q?WPzoEfrCX8ZHzYOUqiad8Ynryo5cVzgIjNpL4LAmjdww9CC6u9iFhNnKtfNl?=
 =?us-ascii?Q?8yynm+ReWxtE9VCl6DQ/tQLAWIYtvcOJmpf/JIoKXRv126MsJDt4PVeOqLob?=
 =?us-ascii?Q?zVNu9IYFX3WvnYDqbXf1xNuuuU7BaCljc5TSHzTeYx2/Eo6sT39oQ1YEXK5E?=
 =?us-ascii?Q?VDY4tyextSV2BUBcccO9lOtiQKlYztjVnBgekX2xjCbksoHgbnu6CJhuxNku?=
 =?us-ascii?Q?qfT1HEmHWEc1rsAkXDVfC0anHraAmSuHsoNMqLbgpAucFhlY5sItjR6fFpxL?=
 =?us-ascii?Q?uPlYx1PSBtwxMcVMTSQ1ONim5JB9qYu8IRh2/0Kq/lLfAOVMus/DDc9/w+me?=
 =?us-ascii?Q?aPF/H3BWL3eVu51hWA4+xjzhdsScgLsQOYImjETyeEtRgFTIwVul3D5bs9+z?=
 =?us-ascii?Q?X/2LyrNPh4TVKO6KUYUOtjkbOt9zJaOjLx969ZpUdI2PeLo8lZYSyuENecYG?=
 =?us-ascii?Q?QV2xxF5ocKEKP/IwIJIRZSXiKYZoIEQIfaaoKg5ixcVKV+uxbRjWjWKPo0rd?=
 =?us-ascii?Q?wDnwyIibKvtsidJ+mWM3fes2Oo6VxYtqwHMaYD1MpKqYl0WKXFtI5Uyz5B2k?=
 =?us-ascii?Q?mzyqSzAIxzQ+vaPMGQ+knYh9BJxm4M39ATj7sLPi5Prn5wU26IiY0E4t5OpN?=
 =?us-ascii?Q?ShIN7jzvqKZWGLJJPlnJbsUkA0iLolKScDw+oioL10xvH8qLL1RIYNw6nCPo?=
 =?us-ascii?Q?1EBkOm7HRst7LWYYxY8sZJfWav3mMJx9e6MGdSHv9Hwfgw8To1sg3B2YM0dd?=
 =?us-ascii?Q?Zg2qIho1uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ScvP3YT2ANGfGCsDFQhwldnEoQNJu5PlmkJXWvX6zyv5vsT4wkFqIfKMZiEgooUyO5KULpuiQICkt1QU27sSUg4ks5qmr1Jo+iE7Ip7b86nWduX9d5WA+xJV7y7oH+UGJacnhcTsSB/XK3nuxqba8UDhfRUnZZipDjhy9dy7ZoHKeGYhj5O93YXCoQGmDzYqzlkFqzm9eyUKkAIUw9708jQPsr5iPdVMEfJXEaL2sOAWq8nXY8RTeOIrK7rWHkPNqNpnfPl1sdaou90BqTqSFsFxPBT3tyl9kqZBDq34yh1Lolnz25rd+1kIJRktUTmyiwtuxfmCt5rbsSTqtpqTKA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9424a304-19fa-416d-4275-08ded2a19bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 10:07:47.7105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6Nsj3Pih2TGFez8OtUHmpubUTgZOa64zjUJ7oW8b/0jhqgw/OQeATEBN0LmscwanE7LOjNNGAhGmV3aLvdcL3Ett3tQPA6p023jQxO/0o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5325
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3cfdf6 cx=c_pps
 a=FYyDd4Hx0FY4jkPLXAZhlw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=4mIRgYpPz_A38yngCJMA:9
 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4NyBTYWx0ZWRfX0XS0eRM0D2ai
 7Qqw0sz0YI4vcGBPganKpYvCK5iJ68wxBF5KbVNLVT3B+l8BxCkJMaK4ktoPW2gwDr13P0/fQ13
 3XuufYb5PSsWxmge+uD2Xhe0vUqlQb4O3ieEKjyXtaTJbyJyOFlNgiG4dUMIZ57dQ7uaNeJPE8F
 R2zQWGYTUV8n0ev/HENPCxKrLvrvaYcp4b1StxIpxjWXZdnjY7rdPOof8qSnEqmKc7Ytm4Bv9Fl
 f4ijF0m+jBLJ7mjKQ4AzxM+v48cSjMt0tTOXpYzWHkqT3UySItA6z+LLAivE6qxd+40HALYnqU1
 kfSDf4GlfW67Tli2mGI6WcXYio2pw221K5dNmUd/sOR9wNllubmispJRrFntstpvM78NhiJOX5+
 5MyKoEgyRFVJoFAcDaz4dGzUxTeOrWAKwcO30zIVreFNs5qUa0fpCoZyjP21osmiPtMn7BdbqH/
 rGffQRq4WfVUks6Pn4Q==
X-Proofpoint-ORIG-GUID: onu13DrzU5EkydknhFlG6KRdooMp3mL2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4NyBTYWx0ZWRfX/TnXweck2yxX
 JwyxIJ6Itmmp/wsNc/SLs0IdJ8M/qun+gVGu4L70RA+qSiIIkO74i54opxrR8QRkOhy1kecXWfP
 esItMUrgZTnDWRln1D63kGl6pk321grVRfspPa8DyIXOrOA0jsZh
X-Proofpoint-GUID: onu13DrzU5EkydknhFlG6KRdooMp3mL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250087

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, June 22, 2026 12:46 AM
> To: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; David Lechner
> <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>; Andy
> Shevchenko <andy@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux
> <linux@analog.com>; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: Add support for
> AD3532R/AD3532
>=20
> [External]
>=20
> On Mon, 15 Jun 2026 13:05:44 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>=20
> > On Mon, Jun 15, 2026 at 02:20:18PM +0800, Kim Seer Paller wrote:
> > > The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC with a
> > > dual-bank register architecture (bank 0 at 0x1000 for channels 0-7,
> > > bank 1 at 0x3000 for channels 8-15). It shares similar functionality
> > > with AD3530R (channel configuration, LDAC triggering, powerdown
> > > control), the main difference being the register address map due to
> > > the dual-bank architecture, handled by table-driven helpers.
> > >
> > > Add AD3532R-specific register definitions, channel specs, per-bank
> > > register arrays, a dedicated ad3532r_set_dac_powerdown(), and
> > > per-chip regmap_config to limit debugfs-exposed register space to
> > > each variant's actual address range.
> >
> > ...
> >
> >
> > >  	help
> > > -	  Say yes here to build support for Analog Devices AD3530R, AD3531R
> > > -	  Digital to Analog Converter.
> > > +	  Say yes here to build support for Analog Devices AD3530/AD3530R,
> > > +	  AD3531/AD3531R, and AD3532/AD3532R Digital to Analog
> Converters.
> >
> > This just shows how unscalable the above text is. That's why we
> > usually recommend to make the list explicit and separated.
> >
> > 	  Say yes here to build support for the following Analog Devices
> > 	  Digital to Analog Converters:
> > 	  - AD3530/AD3530R (8-channel)
> > 	  - AD3531/AD3531R (4-channel)
> > 	  - AD3532/AD3532R (16-channel)
> >
> > (and looking into the C-file change, perhaps add here as well
> > distinctive  information, such as number of channels, in the parenthese=
s).
> >
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called ad3530r.
> >
> > ...
> >
> > > +#define AD3532R_INTERFACE_CONFIG_A_0		0x1000
> > > +#define AD3532R_INTERFACE_CONFIG_A_1		0x3000
> > > +#define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
> > > +#define AD3532R_OUTPUT_OPERATING_MODE_1		0x1021
> > > +#define AD3532R_OUTPUT_OPERATING_MODE_2		0x3020
> > > +#define AD3532R_OUTPUT_OPERATING_MODE_3		0x3021
> > > +#define AD3532R_OUTPUT_CONTROL_0		0x102A
> > > +#define AD3532R_OUTPUT_CONTROL_1		0x302A
> > > +#define AD3532R_REFERENCE_CONTROL_0		0x103C
> > > +#define AD3532R_REFERENCE_CONTROL_1		0x303C
> > > +#define AD3532R_SW_LDAC_TRIG_0			0x10E5
> > > +#define AD3532R_SW_LDAC_TRIG_1			0x30E5
> > > +#define AD3532R_INPUT_CH_0			0x10EB
> > > +#define AD3532R_INPUT_CH_1			0x30EB
> > > +#define AD3532R_MAX_REG_ADDR			0x30F9
> Whilst we are here, Sashiko thinks there is an off by one on that value a=
s it's
> the lower of the two registers that make up channel 15.
> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260615-iio-
> ad3532r-support-v2-0-
> 84a0af8b83fa*40analog.com__;IyU!!A3Ni8CS0y2Y!88afCOStwucx32wuoeR
> SyZ9GpkZge9YDw5_PIMAf7SLs3OLykUC_qNRDUCnRw7wTwsxiIT1V-
> R8sH17sTg$
> It also suggests an existing bug that it would be good to look into.

I don't think it's off-by-one. INPUT_CHn registers are listed by LSB, so ch=
annel 15 is 0x30F8 (LSB) / 0x30F9 (MSB).
The driver addresses the MSB and the part defaults to descending mode, so t=
he access goes 0x30F9 -> 0x30F8.
0x30F9 is also the highest valid address per the datasheet, so max_register=
 looks correct same for AD3530R's 0xF9.
Does that match our understanding, or am I missing a case?

>=20
> >
> > Hmm... I dunno if it's better to sort by values (so the "bank" 0 goes
> > together followed by "bank" 1). Jonathan, what's your preference here?
> Nuno, David?
> That is how people will typically check them vs the datasheet so I agree =
with
> numeric order.  Maybe with a comment at the top about there effectively
> being two banks. Many of the registers are effectively copies for the new
> channels but not all of them, so a macro approach would probably be even
> more confusing.
>=20
> Jonathan
