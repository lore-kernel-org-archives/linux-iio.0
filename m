Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB867258EE1;
	Wed,  8 Apr 2026 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608477; cv=fail; b=iZIGqG4OcwXKYLDyvBSo6qUbUUD1Y9C3R9ok1iX5k0aqcw9ygkv41G3fqRBo4MtEkiGjO9vlgJDsXvapyo6t50HXT99uOlOAPh/hYRQ/ixpTcM9Yi8tqKnIDYWVhluFENoo/PTAX1uAGtIQFodUedcWr0kzDysBT+TR2D1kptcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608477; c=relaxed/simple;
	bh=ygFgxCE6VPQsx+34Smoh6l75eAePmSXDEfDyYn+Id8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=en87nlPcNqDDdaI/yPmpb+v1fcTEvbxHuiprRITqPjRF69kkcztgk3Mpgp4c4Km++H/ohKuzMc5hJXhImuBD1MFcBqAj2utwJ09akzSynfgMGZcniVFM6DU6Vmhy2c7A4NfpBriXMmPXVwwGO3iHZI5KcLcvmaFbhPm0wlRAmGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BEkj/i5N; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BEkj/i5N"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637KMHZ31886790;
	Tue, 7 Apr 2026 20:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=I30qX
	t8Yd06HUYQac/PdJcU1yCRbux3gnOl/G3aQEMc=; b=BEkj/i5NM424uL3UaaeBX
	pqEIp2OtedoYNPwHKd93WmiBk0E8U9m8OmJXUmijnu/pWNiJhrr+KVEr1DzH8/EH
	QWh6EpKpUfAzsT5pVp1k8EC7s026bpaJ162wJqN0onOsP7Xw0BQfecOA+itH4V0x
	Wv2iM3Y7nLaSTkqbiUElsSAbWXi5K1mfJHvYYJCqHIZt+4JkdPjq/fym1vJIeV8T
	l8Z2cpPZ1MSwVy8U8ka4oExKmB5XVEPl+/kwieFaY0mz2oIwFVP5abBDsqGUrkDm
	SVf9O0j8/MiZwb1kt0fYtNvDcXNtHw/dKZ6+VGOyJ+eMbLpVjSHY8s1dv2dnyD+l
	g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dcmt7cquh-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:34:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMk7vH68pzsjSYPMkuCy7481Lsf0iZSC+Bd5Q5h9EgkyMNtC6qJdeVyrjlPo4+Dv+jWJIBX3tM47CaNdpGS/Ujzm8ljkVvtN14wyML7IIKGGL3KQ85//Mt8bhQa5dIomOdD4dmU0n2VjxnSVRVdyf8sMMvDsHFrELxOExUgPCHuDJ6HBAntSBCTwxJxntPs4RAieLQJKVoN3owbboS7DZAnWTD9twbqqLq43X8yID6e4tmJZ/eDKp9+QDT6b1EHx4gBD3Qed/3V/4DrGFt/epXqAsdIhNsfmLPYQL4BgApILFt7U2cSg+PV1OaOOY2nPLpKbcZeo+AqGzhP11KLkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I30qXt8Yd06HUYQac/PdJcU1yCRbux3gnOl/G3aQEMc=;
 b=jpEiDonZFZfEJj1FUldeyXQ7LDnoLi1Pecxrk2sg+wkZrLWHfquOpvreM/Uv33NzM0Ov5lr+1Z9H09xo3Y9Li0g3F6PsZ8igO9keCMCEi42emrFGeUM7aoqSuqvZaxbxoNIUUZYVmmLCrkUMhlP5Mejr9yx2LpOyoPzl4VKpxqEvuMbBlJawQtbkeJdC9PDLcItUOBlOlkwG71MSFNIahh2ayPhvkYShUhwDCGQL0OQKDx3sP3IYSfU18+EiDRuRdyK1GII8h6xUM0XbuRvjepwKJ0BTgFGJBD/AqTDlLpbBZV/96td1yZnx1bOX/z+1pNa1uGofIgkM08A+G8tGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by PH0PR03MB6384.namprd03.prod.outlook.com (2603:10b6:510:aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 00:34:03 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 00:34:03 +0000
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
Subject: RE: [PATCH v5 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v5 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHcxkBJn5FF2Yv7AkuHo6DdbFyfsLXTrgWAgACd+KA=
Date: Wed, 8 Apr 2026 00:34:03 +0000
Message-ID:
 <PH0PR03MB6351F2639675EF9D2EE3C3D0F15BA@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260407-dev_ad5706r-v5-0-a4c7737b6ae9@analog.com>
 <20260407-dev_ad5706r-v5-2-a4c7737b6ae9@analog.com>
 <adUYrSWiX-oexxGN@ashevche-desk.local>
In-Reply-To: <adUYrSWiX-oexxGN@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|PH0PR03MB6384:EE_
x-ms-office365-filtering-correlation-id: 884c4b53-424e-44f7-c7ef-08de95068926
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 8tjUqqoHsAS12tNeQ8koSA6kGp4gp6ZH3AxlqD5+wwdtSfs5TzEbL4MYI2/tbPhwITVX/wO4kKktluiJ+almamnxVsbhqr9DYaqQvyutCAeK+A5c8nYqRFMy+qWeYb4ty5tyYnE7/3QgIkYGYWDyIqSyOgEoiy+bloUWJqyxygh7+UeQr/wgIMcJL0LwIaaUAytrn+29+QS4GmrP/IxCdZQOesjuWf3en0QF6pcxDSAbSmPHozwTJ+xHRmkLOUMwxzQNudRzw0DMJ6ww8cen9bnLS89ZgeqD1w5LNxusBs50PLdQDxP4wYz/DKce0DUyUN49BGnehkw98VjuULPJyiT3BKA21GN9OQXWxk5ylFLkjroGmVzwpMJdfmgxH66umFuLR8HPI6z8viDYY6yw5vfVeNFDi0Hq0Z45ElGy8Ty80uk2XhcXy7/0/h36VHDrEvpsrZMHIzdbGFNRrnqvWvHB887UlRfn6tl1wjNx4zQ1lXFBXjyrXE0VCgCLYSavt9JrPlS4QowF/jCxL3E23lcJpOUW558j/Z9kNfRNTkA11DIsAVrPqeVFDq+mPlOtC0pBDtUfwegiO7mcEGGOGEawg6wzR1kNFuV2QbuBmBWZWQgc8iJPqOvYRk99mXgmeRT/oDvGXmy6lzIasniQjx61xY8wYcJJ7SjnkvButGOKPMIkbAEjJSjp0Kywepl4qMtIRDE65ea9Nv7aEFDCi99QQggwl/xtV/0qUDsJvamxr1Kivx/FOP0EYO8LQQ7txXdZiSrj46Pq8RGzD4BxpxkomvCiQes+7AmXJ3DmVwU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yV42cho1C1VUXLC3CcaI5Wqpbhkj/7ouf99NJ+TurNv5MA2ZFGlH3Nsy5P09?=
 =?us-ascii?Q?F+NB1S1QReftqgLvMzpY1A2dbrAljvlzFp6d17uvhXQklb/meA+EkWTLirx1?=
 =?us-ascii?Q?a5LuO0Mq8DRdmAHgXLDPxc0NKFXb5xLDdvfOt7ttV7FYl2/4oZTlVdNDnpLX?=
 =?us-ascii?Q?CdLH4Vq6Z4uhtj6zACdUmdQXTA0stgYFAomVyc0Apb02ZcU4YuMe3aiEb41Z?=
 =?us-ascii?Q?elj8wHXtTl/7ffOzUV1eQA/mLXxX9B2zXCzrJIdUWrCHTa8mu9OvLn7+nrZp?=
 =?us-ascii?Q?ON3c6StSWKBnwX+v3z4DxaXS8DwvpGUUiuOYgropvBe519nOCeGITogYR3L9?=
 =?us-ascii?Q?zxFlMazMfaGBxyV/9b3V64fNXEmnN8ks4DHc2XjPpiSqzLsvSD1IS9Z+IO5R?=
 =?us-ascii?Q?0lNYOflzrS53C9Cz9T9SUWLX1//0WFX3Kk87H0iR2b3Syh5NWhInzCSyDPb6?=
 =?us-ascii?Q?avgrE3+5X6Zk6/t0hTKqfVwoys4axo2JVa7sVE+NDeNsiMeyFUNlRvavvIK3?=
 =?us-ascii?Q?YKeBFDRqMu1mEW6UwQXKHnrT+oMHqNc2bfjAoJ4OyR4ycCsljhBin2S2mer1?=
 =?us-ascii?Q?ss4FPZvf3rYYzcyviekkNXvbqVd92n7O3GS0kK01gLYnrewVDX1vL4MVY+7J?=
 =?us-ascii?Q?VxCI8HgcrDka1MKmTvIoc/s1bQmnoxfj1IIIitcw+iIy1wmdA0ZLRHq3s3e2?=
 =?us-ascii?Q?y2aGRKrdeNJTOLBKTTUUQH2X+5iN8ESKx1WMoa9gZl4tttNd7cHB+tTQeHCZ?=
 =?us-ascii?Q?IxEvbXx9MAjEst/fV0QMlv8TYOHs6hl9O3Wr1hzPG7csecBzBgpwbrk32HQN?=
 =?us-ascii?Q?A1vJqy3dDyAQ6fY9havYtAhLSjaqPfeqMDJlVV2+cc9V/gEhjJVYCfvKVr2f?=
 =?us-ascii?Q?c2Uz37nT53HXOEsd42UTClHk/X/4TKuSKrms5ZnAXdhUxW78QfdcLYclFTF3?=
 =?us-ascii?Q?F5/f+dr660wNWdvme2vmcRHnux/AtO4smlyFRtQ+eVNsMJrFKbvW2lXjvEkG?=
 =?us-ascii?Q?yo4rRuLJsSca3Y2/Vek72ZyfIcg6U29NEgvPPKMrs1E3sMg9rSot/G3W8ohN?=
 =?us-ascii?Q?1plP2lnIGjbcaoQ700UU4AiGcw9S8ASMitbLprGrnbX7ewUPcDOXpiaYSwD4?=
 =?us-ascii?Q?AzvvcGD51SU6eCevriehbFflDrDe5dM4YibZo1QJiHcYclrBO8OftDjCdwOe?=
 =?us-ascii?Q?T0GAYDAasy2gZMI6jdkMjnzHCdX9//AGZZmEmLLuBfvrK6xobsooDMFMikfF?=
 =?us-ascii?Q?OEslBb77i1oVh2PjPeMft2Yql5j2+6Bj/7J+MYtJNjKNWXynL8hcOSU4iUnG?=
 =?us-ascii?Q?9DA/QCL0vAyrfk1Ryuji5tLubGQrcVXVmL5x/8AO0P2hpxYZr6M0ICln95N+?=
 =?us-ascii?Q?OMWCen5djkSSw4Mgm62Y88GnBchz7spd76d605MxlWWyaleoZta0URNSO3Xv?=
 =?us-ascii?Q?jL591FCrlOiCwZX6NH8nv/JOu2Mtvoz7dbtJG+RzXt7D00rfpIhloNj5V23m?=
 =?us-ascii?Q?YOd4KeZAhH1yyiPWxGw+7FVIxrUQUa5+Y35Klq0fN4GtqO/aj4lMJPj7u+Bz?=
 =?us-ascii?Q?srj3SVcn28mWMjI6ZgTatIfCiy5Bkt+jvC+bn/Lq4tb+FPozrt1gU1Vd/23j?=
 =?us-ascii?Q?1OAhXlBNk9+DAEzy0yOKadMC7A072nW1RaTLnZE9bmttmUtC1/4TS3+ImJCj?=
 =?us-ascii?Q?R0HeN/tOctVDXjRAk45AK/6fhUnyN433iY3/sYFvmjIcrV5WP0kWB6M8ijet?=
 =?us-ascii?Q?MAb5I5kzHXjT0u02VGPsb4DzRRF0Z70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NsYYl9eMyyZdgS87xvYca8ht+UMfcXAPaNshK+abU9UcdkMZbH4as9ZfEUxzHeIIYlOVnMwALe/NymNiUamdj/x0vaDmS2I4vmYalJtZGljK91cB3eE2Cf9KcrbnLUAeWYWZyIJhSKqd/cHE/ao03Ek+6xVk3cxedy0DXsOOUCbnQVHTGwrbHqgEFnVBxNe5onUj4YOmJrSNz+gfAYSTNth3N4YghzLAwHu77KZLCgCo0Ti42NJiSwn7BsVyVojO0ePGyYoPtca5PUVORRV14SDmb4PFOB6uvzQRe/TqxpwVY27UQIGrJir7cCmtKAaTVEZXrrlk17XpMijjxZVnjA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884c4b53-424e-44f7-c7ef-08de95068926
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 00:34:03.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTmiOFHRQt4G/izwM5zyW4BdMqXlCi8h9WkeHYo4rQYv7Cs1FIQREQmtIyKzWyX3NLggvO+1AD1atsdGPeN9hwtJkurHIRpO5nxOQ2oczxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6384
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMyBTYWx0ZWRfXxIktA1neXXMB
 cg/gJg84jG3AAPflX6XbHEMqRtpqw3aBJPDZ9jDQr+WUT7muHk+sgut74MuTVZG2p6DtxpcQkvx
 247nGP+ix0BXskWDWqWA4Ui1QvoJNxD0XR1HhF3cyUymLuB+hpaCNHjRvd6DlEpJyd+fh6kFB3m
 l0coz8TujNAv2bIcZdH7A0WJ1AUDPdrdQ9bxva0DJK9fBKFJLSxeiiy9CZm87C614iJdcbKbI/A
 Q877JJX9rtIAsIagEPPX8deJv/S95eNgjVjMQVuhPGrJmdBiglZDTO6hlC8a5BCicqF7EHUc2TO
 tU+ObzT2VOBdZYmV1s91j2DOWhrMmM8psc8TB9KwIWo3BTgGkkHLi/65PjPfaPCr3K8a05ZimIy
 OljzZ+fmTAwoCu0rrTKrXSKTKvgDLj3XtjPj4tC/knK5sG4AeLoWfbvTA15d+CRbxT4vtLGUuPt
 /S2qGqvx0BFs/IijXlw==
X-Proofpoint-ORIG-GUID: L-LHatXUAzWQ9R5c-UgoX4MDAGu9-_Ke
X-Proofpoint-GUID: L-LHatXUAzWQ9R5c-UgoX4MDAGu9-_Ke
X-Authority-Analysis: v=2.4 cv=ZITnX37b c=1 sm=1 tr=0 ts=69d5a27e cx=c_pps
 a=1puOLNWm8QjqX9uS9MZT0g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=V4uVx0ldF2vEyXadMt0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080003

> > +static int ad5706r_regmap_write(void *context, const void *data,
> > +size_t count) {
> > +	struct ad5706r_state *st =3D context;
> > +	unsigned int num_bytes, val;
> > +	u16 reg;
> > +
> > +	reg =3D get_unaligned_be16(data);
> > +	num_bytes =3D ad5706r_reg_len(reg);
> > +
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D st->tx_buf,
> > +		.len =3D num_bytes + 2,
> > +	};
>=20
> > +	val =3D get_unaligned_be32(data);
>=20
> Is it safe? The data is void *, no size of it is counted here...
>=20

The regmap regbit and valbits are both 16, so data here should always be
4 bytes. Though I do agree putting this

if (count !=3D 4) return -EINVAL;

is still safer.

> > +	put_unaligned_be32(val, st->tx_buf);

...

> > +	/* Full duplex, device responds immediately after command */
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D st->tx_buf,
> > +		.rx_buf =3D st->rx_buf,
> > +		.len =3D 2 + num_bytes,
> > +	};
> > +
> > +	cmd =3D AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> > +	put_unaligned_be16(cmd, st->tx_buf);
>=20
> For the consistency's sake use &st->tx_buf[0].

Ok, I'll also apply this to the write func above with:
put_unaligned_be32(val, &st->tx_buf[0]);

>=20
> > +	put_unaligned_be16(0, &st->tx_buf[2]);
=20
...

> > +#define AD5706R_CHAN(_channel) {				\
> > +	.type =3D IIO_CURRENT,					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> > +			      BIT(IIO_CHAN_INFO_SCALE),	\
>=20
> Missing indentation at the end with tabs.
>=20

Got it,=20

Regards,
Alexis
