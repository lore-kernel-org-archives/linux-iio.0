Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87632D42B;
	Fri, 10 Apr 2026 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797165; cv=fail; b=dBptBp4VYAQXEgBF80Yt6ERGGtxmFiHhCyFMLwdBJvh6LHTMppzzNUOiVcyWK1vCJAtH5BAjTtzNxn7mPyV0y/xi6rZqnLw39a+TWbGVMG8jO7jOmlA3WJ6OnPlmbU8/N5umEu1Rpi8EcusRY2t8UDT+q34iA1u1Mc5jiSK1ioA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797165; c=relaxed/simple;
	bh=UFY9g2A/GsrZosqXbxO65qWvtK0IGfZ1/SQBspaqA9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cvqvgOPS5TgbUMnyTHk1D4Pd0uVQTKSIXdJfRF81C4GekOXd8gDb50jCEn/hkQBRs2qubBhXFsu055Ayomn4SCuAlr0j0r9rIVsbDomCUDpaZOs4VMQgpa43y8Vj4hnyz3fdUZKWGqBO0qKZiAva7qc6hL+zZLG+R0tVNS9s124=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X5pSwbHd; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X5pSwbHd"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A3NeXa3091940;
	Fri, 10 Apr 2026 00:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yZRqp
	vTR134FCbbANSRXZu/jEAruTmSLZenv4dfG8ws=; b=X5pSwbHdvh0p/3CxxX5NG
	xpGsbjHLDfVrBmuOv8mwhgnN1S3C3eNfpyA3S7CR/d92KHRyqnFi+HrqqYNWxDiv
	C5+yx09/z063KDDkgPO7TN2sPaOYiJnqccA4f6E2ZK77c7DmvyQU7fUu1BJTO+/Z
	xuz610l3rgISwvaGdUzmkoXlyVOrx3sES5eAyywl/P47VPJ8uARzweZBTEYSEJkv
	lkou7H6pH9wHoxsoyUEs7uFycDKa0rxd68YXn/xIs2RjCRvarOf+ynJoMAJlW4it
	dZhsc5jRUyRp2OnA5+vCDDY5VXYu6Pc9wNQb/ZZHf4sEFSrLOhrM1e0OeZe1Dt39
	g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4de7r4uxcy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 00:59:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz+KYWj8KX9KFSx7rzw6X3ivStYgXAytd2tNA4cOES4tft1x292jpQGtxJjEeT6pL2MDJp5NGmXd7phrPCZDjfunfqYpPGUL91ADOHufcezSAFmLKxene9uSsSZkBidVouBzLvLyQb6+vKsLcj9W5tGONfoa25UIBIucpKs9NZLvHUiIMaY9iQxIKdXElYrwDFWtd3aJxntekgI+VPJ7rkOMDd3GoJTD+9bZFTvOCD4e2x035XnGA918Pg4+e5fVM39elAEP5mU41YPmFVC/MQmt0pCcBvLfaXBrVH26OrQrPlvTBu3SL5QrYfQ+7UqobWPqCgwIYWINOXtycRcyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZRqpvTR134FCbbANSRXZu/jEAruTmSLZenv4dfG8ws=;
 b=tG9NtLJEuE2KtgRw3x9O4eLKCfD5AKBG1FFFFYY3w1ZjWeWsx0ARqEnLBKncT+GWwXxxrN9eNRYV5kqqeBzNPrFl7LSeBiF46iQ7MudIYfO8qa8bmlBoHvMH6PUFdCdShNLWmEYWfTwvkxjSggUxFPFkzt6wJ8VjrJg1owH05WqLCFcaIqQyZjeeQ09bUlNb8r6aLgDqwfwoW1Wzdfr9SxD300NRaXNUNvu/9MbndqBgcJ93N9RyPOyIDaRTihiK7V54V1Af1tvx6Y7w/SWsAOWpC/aPOr4IktNkwW0b2elV1vgrc4rZqbHvRROLqmbKZVzqyw+iGCPWFph+xq3PaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by SA2PR03MB5675.namprd03.prod.outlook.com (2603:10b6:806:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 04:59:04 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 04:59:04 +0000
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
Subject: RE: [PATCH v6 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v6 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHcyIovL3A0nLoLm0GVFRXYgaoSLLXXt3yAgAACxCA=
Date: Fri, 10 Apr 2026 04:59:04 +0000
Message-ID:
 <PH0PR03MB6351D7161C4BEE27D91B54C0F1592@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260410-dev_ad5706r-v6-0-f3fda5921fe4@analog.com>
 <20260410-dev_ad5706r-v6-2-f3fda5921fe4@analog.com>
 <adh_c1GG17zCbBdu@ashevche-desk.local>
In-Reply-To: <adh_c1GG17zCbBdu@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|SA2PR03MB5675:EE_
x-ms-office365-filtering-correlation-id: c352846c-9a18-4ebe-90ff-08de96bde385
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 cRPps656Zw4zHDzHXo3DYJQUzZTmGXU+qCyv5xNc7/cncKvdMqUHdpmx5hOXV+U4qg0ZK7z5f34im8Bcu4Dgwuwjmd8hVs7L/NIaYt8Wwc8pbTAVRNfwe7gAuCspro5jtwvQYcJKia8ZdOlgvos8eDL71uZwWIXgrDzN0qrkQ0LQ1yWHqPb5SfdkBparSF9GZb0b9IhPSG3Rfdl3nY3NrNZMKvbZkRyifZl1UGePVBiOe3J2X9R0szFbf4/w4XN+N4cueNiEBLz7+Kbr3hn7R+LsOQBsB/K3cTgW1eJjNx6Vi/i1zB8NY16LyV5wWLovgqfWgu0P/QWPPoSwViH2frdFo6JqdMXW7sqPpBK9mNcFWB38DN84VUYeIZ3bFQo8GikRFZyA47HL+LNuZhB9Yu0qOEfy89hgoVB6+w8zRT+MWLhGLazu8ynQqIM4LUC0FWyXBg+Bz+EeZaVeE254U1P+RGGEgPBVhXM1NYXhhl5Re1m53IJCKJKT7FcV9cf6APNEnqJd95sX4JppOVuT/cc2lwHZ9JrYsKm3rompV4XKzSh2ITQGsuyydclYczEqRv7f5DStwOY3vzrSKNl6PvGl88T3dYlhTfZowO3lHTxSAZ/m0uClZY+gJFgglfu2NC5MuWg1v1yC8sq8adkQb0DkVBxnO7HKxLjvVcwrj0Pw2UzN3Ee2HFl/ZGV5ov6pichKJXeuZ2CXQJRT+FQzBNfD54wj6DmRW8txaPfF2kf0N4S5tv2+13JHNBMMbwPqSYJ707WJxgT3Z3ZssHjq0B7Ty8LftVS5QA6i2Gg+KsI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?71q4h5lrY6/ZbrR5nOKcCyB1sHGKJscKxub34O9tW460OR5d2Xmk+g6UzpRF?=
 =?us-ascii?Q?kM3ijaRwnSbPXD+O7n05WRvYQ9YQYVY2pUOJdAqwhAWm+l2IUdq258WWdays?=
 =?us-ascii?Q?JnXlIJbNFhM8bnhKs08sZ81DeMP+3SU0NN0MUaSH34NDHG9XNORWYVSJpbto?=
 =?us-ascii?Q?OipwvJPF9lgxyofYqhVf9OzGHcX+zn/Ltm2cIuWhdbntpx3I2nN6bw4Yawfp?=
 =?us-ascii?Q?UavWkwo/8Iv9GuKe9xnV76yWaEaOlTJA0AGFKb+7Jx56HjSchaWhn64bA4Lv?=
 =?us-ascii?Q?fI+XAs1cqtg3fugocyFxsdX8JbZzMQuOjzS6l1yp8ae5lJHtv4iF0a8qip1I?=
 =?us-ascii?Q?hNzR3cGA9WnMK3tVIClwb43QC2rVl3WMcVfUTtiL3I72EpMbplQUd2qtHs6j?=
 =?us-ascii?Q?UsSSMKTpFHY7pNE1BAssv/S0R9B7p5v+nYSrgXsxjNSNCbk8+lX+4CLLQaUG?=
 =?us-ascii?Q?b94YMB2lT4iDzsU46a5tEHagh5tcUil4WQPXB61uEa5NgFcFhd2Ulo6yUHJc?=
 =?us-ascii?Q?gzrgxAkxGBUXFCsQSn6BWsu9gH/P2fKHxmm7JoFWQU7K6GzAEz/ERysp6NxY?=
 =?us-ascii?Q?3wjt+JY5wyF6mH2tfxyg7MnWOKEvFoMLXYRH2jpm1kLOrJeU+4lXY8rq5q5M?=
 =?us-ascii?Q?nhlaB0tijRYKCTB49fOaQuikPBoGjA6I9VxUglU62WLSUuLmutkRYhgt8BSF?=
 =?us-ascii?Q?3V8RYED+QHop2BKKteocgO2DorALTb0N8uqwi4V66sYvo5dRo7yoZb9hpg2n?=
 =?us-ascii?Q?A72+2yfMvsko4PxjFLDrGKTDkEKg3XdxkXnY93cmlu2yZwIq8VHNpEfS0Lk2?=
 =?us-ascii?Q?pid5QTcLqrDgzIPqaMMo9BCbGDrxGLMeCLsQPY7+2vsObROi96CrObXeH0F4?=
 =?us-ascii?Q?7kEaUMK2qiD62NMj8XfUFq8UTGhEQqWTlRI4/nEeckalY/MKT7qzuEN7xhA6?=
 =?us-ascii?Q?3P1Ol/g2sE9JP5zyW2AeOplDQesVOK6yE4bezctvzbUzq+r3eGKMFimgIjBG?=
 =?us-ascii?Q?KyZKjO4DfDp0vl2ebbDQOS2kB+yo+D3W8zmclSL+o+dFxuz+T6mqpjdiOUpq?=
 =?us-ascii?Q?FEkZFWA0dMYu7Lds1OZ3/sWtSMST6GeP381G2V9ElL6KU9dQBQoZnKQqb+YD?=
 =?us-ascii?Q?z8xgwA06+C3IPSH3hZP0QWUY6IYN8Zs+jIe4QP0FsMfJclakvWJRbMAAZpOw?=
 =?us-ascii?Q?rT8PWuGan/BnYgCMb08vVswb7OWVspT6PJRQQnjJk7iSW2b1wg0PNvBNoyqZ?=
 =?us-ascii?Q?kGJAOmpSFrNAYazQwvNcZ8xmyqqqDIBtfz0J9e/ne0lB2aaCRRl3F5GgwvXq?=
 =?us-ascii?Q?/j+3O/lHnSQtDcQbW7ZT3FVgMG8H6Yq1dnOaRXd3VK68nfRm2VJs/JnFnGrj?=
 =?us-ascii?Q?ktya88uM9db53jZP22vNY6QBJSMkdCQ8uXQR/nc+v2XTysQJic8EKAc/xwHS?=
 =?us-ascii?Q?+8JbedDDWZZIRBRYrRiuH3/twCHeujEdtCShjrfE+S60d7mCaHkGu3qYjh37?=
 =?us-ascii?Q?u05KMXRzT+Ha4vakQSOWnPHaQKduUib/BemMjyWh275AaZkGJT9MqCRXNNc5?=
 =?us-ascii?Q?TvgY04OIsPq6u8RRoPfNQ20V14FYhm7iMR1/x6s/ijSj+Wpa6eJICixhx8fh?=
 =?us-ascii?Q?fiIwx569rt7IxgWdktHTi/hce4FEbVZBOlW1TcOvgczJuBB5hxGWzh4NJKhD?=
 =?us-ascii?Q?XEBCownymGocrm4UMymVinP72uEaX6UIBNNgAIE9sQmPHhXxL8LnzuY4MTbD?=
 =?us-ascii?Q?ZEU6pS+50DiDcbaNAH88AEt4fvvdw1k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EcDIerlSySGl7OQ81IdkFA450uG2UiJ1jiDezfatikAaw52kBbRpbqj+Hydz7cvkMd1Yre+SLJYyZJUxxIv4xIBivE1dW3B1NtWz+QDVkgEwlmu0Tibcsw1GsMG8Q4EYP6NPtwWaxRAVxCQwKrb5XJARCfSfn+cZpWwYqetj2o/n7dPaDKZvOg7qI7Krb42q9h1S37poUuEdet4robli8BdAEzL1N1VIfAUHZZz85tCqWpk+N/QUUOZQDDwvPH/F3n29ORmKYNvnf7k8vbrMeTJUTO0VzOb3PCBWpUiVG8yF7hddXPceahQradDmSL30gDLeer1+Oz++inG3zOr7RA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c352846c-9a18-4ebe-90ff-08de96bde385
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 04:59:04.3063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qNRd6cQKUeZ7Q9RgxCjRsPcfjk6gv5/ALGh9heI0QmsBm0X71rhQFij9OkFl38lAnGc1CM8SBfEsKZwUHgSFwpfreQ7/ZTJ3mAgMKHk2xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5675
X-Proofpoint-GUID: in6YMtVQPlOEMoCwdz_LBlCyHabgutHN
X-Proofpoint-ORIG-GUID: in6YMtVQPlOEMoCwdz_LBlCyHabgutHN
X-Authority-Analysis: v=2.4 cv=Kv99H2WN c=1 sm=1 tr=0 ts=69d8839d cx=c_pps
 a=cRSuPULe8LMj8fTR+fkUeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=QyXUC8HyAAAA:8 a=sFlYKg60l1m4Tf3A5woA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA0MyBTYWx0ZWRfX56RnbD9ZCF7R
 JZRQLCXNWwyvR0HB0ZeJwOirDPEPorx0L08uMZEfSDai+Ks1UXLbJw2aTIk/BUaIRpUTrJbb1bJ
 93pYzjupLHmyQ5GMxHj09Pq6e1Iz8Wd57yM80QuE2qnhuSMSPIrMcW4g0bziEMLNqmx1URD0qyY
 QBT5emR6DlkEsv259nYfnEb6PDxExPpoihvx6JW6eBcc5Besm4GyMnOLTLD/DrAhfU7Nbzs9Sb9
 nEIMIHSYHQvoxD4F+aN5jspMSbqxJKn/uoKOpBXmyztU9yTxbf/jNyUQAneOElJu+kHDWFOavYo
 h1KQ6z4NWxSyb3uwCheynMwSGLwM632JECs6d9Mi2oBjVEHxByuX8LNlep4puveOOP0CdYKO3t4
 wcNcKys/Q4GGt8FNUoH5TMfEWKBRukxUit7E+GbjG2VlkG2PVfwdA8TvssX/t/OYAtHXLLoC8Xf
 eTJROKQOQ91p2aQwtVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100043

>=20
> On Fri, Apr 10, 2026 at 09:33:56AM +0800, Alexis Czezar Torreno wrote:
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
> Still the same issue...
> After addressing it in full feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>=20
> ...
>=20
> > +static int ad5706r_regmap_write(void *context, const void *data,
> > +size_t count) {
> > +	struct ad5706r_state *st =3D context;
> > +	unsigned int num_bytes, val;
> > +	u16 reg;
>=20
> > +	reg =3D get_unaligned_be16(data);
>=20
> But this has the similar issue... Validation has to be done before the ac=
cess.
> (also theoretically possible to have count 0, so even for byte access we =
have  to
> validate the input, strictly speaking)
>=20

Will move the validation before the "reg =3D get_unaligned_be16(data);"
I'll also add the validation to regmap_read for the same reason it accesses
void* reg_buf

will send a v7 with your review tag, thanks!


