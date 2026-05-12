Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7E39478F;
	Tue, 12 May 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578701; cv=fail; b=TZaRap1UPrgwsrQ/JSnefIYMVP1p04VnCiFDCnbF9zgrI+r6V975ezr2ZYxak2mjr3sPaah+loQVlGC3dqgdBtbLB74dER2q16xD/JfBfTEHbr1X/w9nKbBC7BYntw25Hs8j7irnMX/C9s+gxWhmAzwpJuX5IOcQrXldRr2MzPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578701; c=relaxed/simple;
	bh=9eHgFVs9nr3GYYf0ilKE05R4+elbXdltvAhGpSk6p80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OByHqCDozwvXxpq3I88NtcYiipLqC4+0EXU9JIuHPc1+I98fBvKSnA4OFozF62/JbEVFjCOBmaM9EadMN0358xlbYhAXIRdnmqZ2g5OEXOXCUCMTRh007XkGaGaUKFwhyW/F/Ey8w18AQ4PZVx+04JjMUphyMwU2FJ/9Q1OBOUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mdP3IuU2; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mdP3IuU2"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C8ggAK1981290;
	Tue, 12 May 2026 05:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OIhQL
	jSZHizrzb5go5JvzX0Y52zKHX1eFiHxxQ0as0U=; b=mdP3IuU2RPh3R5++3cI/5
	SmeDs2qaJUqiCnpKykur+QScOvsbDefpNeOq1inyCNUOl2Dtu+V/2GIGnsTCfAZa
	cohM8P9wY6QsEopipW/QO9EVwI1CySRSDenfiFdwnSx/rrmcovchgyebYwQnKF9Y
	Uf8N1NSz1eDmNZs+EsJelocK6RUJtVP98Yw4c/123wmaojBbNJnsMhPccjd0I8Xt
	lNSDy1slbfn6H2CAGZUkNGHHi7tnID4uQBUBmuNigjk1q0LOYVthHBMYCgvWmRxP
	QGd5BvU2CfN1gIytrX03lm6zMArnAF/E96M32QIkfCcZ92JYwsrJmdFuYIfc8AM+
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e3nwa2bgu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 05:38:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywrmcKdQtnUHglZcMxrs8tY3+a/DeRInw0DHk2gai2mnqvhMijBz0Wsq4nv+GqfUXeAs3h+1B1qByArO61VNIB2ZQiYV0abs+02nBRzGUlND/Cx7JL/Xa3OEulHQxuGDkEL/Mey/IS+kXrM6d5hRhngo7UMN3BIcknETkmalQQnvnFHHopBv6Vtu8nwinElkT1m38WakdTpGW48+lkgHzDqHU30bLiDpX0ZjLf7XYMGLhZPW8pnD0ipi+tBqWHAlgKMJA/noS3VESLifdyoJPpc2nVFR6FLh3m1sAboxeYC07Jcqj07acn2bIBL/Uw4+zCcSS0Lvv9yCC5fWED99AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIhQLjSZHizrzb5go5JvzX0Y52zKHX1eFiHxxQ0as0U=;
 b=y9AYleqmy3LwsroTtCxBmz27vY895dMYyfLK0lxAIyTwun5XGceJ96NDg4GmfubGpQWBCHOEDfSMH+XsOTCmxo0k0/wmO9IfP4dvtc9tFHXKGYSgHlu1oWISALjJLSXlUWHx2fQcnFUx6q1vLbjezz06xwKAxsbdWXoUchdrLgJuG82YJua2Rtt6iJKtY5dIf1ejfvpyqb4Zp36HSdful6a4Vg4TQy2bTkerli0CcmCdgbvHvuEt5PDGK+YDx440yQ6xEHjf+GQGFSdfBKHpwhyfXD3WC8xUIZMO2WxTFFRbxIOERJZRHJWQgl8e3AX4lBV6UcbJPETgL8cNYYh0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:37:57 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Tue, 12 May 2026
 09:37:57 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index:
 AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbXzOXOAgA9qvqCAASwcgIAGPn+AgAAOuACAABJ4cA==
Date: Tue, 12 May 2026 09:37:57 +0000
Message-ID:
 <SA5PR03MB83774C631680E4E48B5655CAF6392@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
 <ae-pvxKhqmkWwXdX@ashevche-desk.local>
 <SA5PR03MB837776014440C2594B811BF7F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af2UQ7ZLA2DL4FWY@ashevche-desk.local>
 <SA5PR03MB8377DB8F5136CC7BF9594B64F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
 <agLdhvre_WrLDP3Y@ashevche-desk.local>
In-Reply-To: <agLdhvre_WrLDP3Y@ashevche-desk.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|PH0PR03MB5847:EE_
x-ms-office365-filtering-correlation-id: c88a3d3c-eecf-495a-9668-08deb00a2643
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|11063799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 cNk0BSqig+1+ACvfdUAejMCTjsaDJN450IIEqqBqaVfGy1yUtoMTCNt/WxNkE+5flAJlPZKrnUhgYnEKlcZvCDvX0w0KBM7k6CgR6cMz93qJjQ4k/repOaVDTHxPTmRByXudSzvACYdHjZ4zWChILS1bdAXYUIkWL8bOAvv9yHE9+dCnLUm+UB4GPc9RrSPA4Dz5gdLE+0aFmbick9Y56PHLJcbqhfgGKHum8uY5LV5vsu0xYwZo1VPnFUGnoW1Q+IjvcdVV49E1PQs9MKkLyOU2PYHmR0LMzX8y1ubEnpdwzUeauJOzFnOI5/s3aP90hqLRvfLgK+y8ZKbnpatdihJX0hTm7TkFXY0hFQaX7m2OyJn8rMIDRO/jze3dHgvEfxpfCzsbKITX3SIZ3mjCJXzAli2wR8Y48E/Z268C80glqmNMnfCKVlKWaKOHzy3libGvd7/rmdsk7mIetF0pB9fEJeVyuBo3E2KQw/4ya5ILtOMG+7d5k5pA/dq4vaCCI9Mk7VImsMhJ2XJzQ2Iw9Amp9klpYrpsRpl1GS8VaD6BfTArz7UZxBjNpuMy4gwYWpGYP33J/Wd+g7X5Wd9YVDUvE5gYYUlfe6dkRVKkV6cVxfVVZXHJ2lMcQLhNGbqKYkMaOisH85YKtDV/OcO1jT6pS/V9LHGQEXpalaIKn9DK999Lzf3wGm2wY9Un/ntMdrl/gNQ8NBzgLl6hp9Ll1xQyhpYcM73GGhPynm8J1UtRs9ssZnpEwG5lK+mMwmFb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6uWDrVprRraZ09AiaRFPDB1XXt25TA026Qidpws7iKpJY+YL3yitJ1VMQ6gN?=
 =?us-ascii?Q?nUR5kVM/s979dfJ+Y6AKAK4tXpisGJAeyf97kQKrnxB1YHkZKIv76xBxjFlY?=
 =?us-ascii?Q?jSWLwxyUJ1HFKjzh33yTU/XRVrd3vLlkYHUxZT2Dpq3gZ4mB6LS/WtofeqdC?=
 =?us-ascii?Q?AXoY6ZqsjHP/EZbPZptflqc1gIQVNK54PkMMRVuLQAPOx/aS0Jt94qnM9YIY?=
 =?us-ascii?Q?JEhvlDM2IPvEk4x1Uct9EG7h3qqZokSDZERG92HkiQSJIrLqVsojlvD2FFJm?=
 =?us-ascii?Q?vRkr3AAR0Oqd0zuPSBjWz2Zi7suCYkhP9+zYC25n4XyzKkWde+sahgLc61yn?=
 =?us-ascii?Q?OnG680UsajFlmS40rfXdMnpYeJ5HUblBUvoPnoizfxgPl8hwoTgIJdH9yuc7?=
 =?us-ascii?Q?tn/yL1GsDogJcDxFvkmroRBwYmHq4NJ0vEl8SZuFpTwE96IZI8KDjux/w4N4?=
 =?us-ascii?Q?JiMRPpLy1J7oDGBUcSDDvwIbH6zjFdwwOevRsoxSsT9EYuYqgpDdcvoGkKpN?=
 =?us-ascii?Q?2QXf6C7Bod+nFNiQy0uyxTFiRY3ZPazyWs/gD9JAqYKwXCBPlirTI5vqNxbH?=
 =?us-ascii?Q?nT4RsWL5gNE8YTceZGVcErZ1bAUxEfp2H7MSqMfugOSXY8PwbwV9jFcEPQ4j?=
 =?us-ascii?Q?LSnrwecf+W33+aqutAVepcLYqE4t9fVaJyTcila2V/aaCKF6HbxphdR5Tu06?=
 =?us-ascii?Q?pGcWp3sWwq1Pqdos54xdZrhNk/NjsDb/rmTtpAWivCzMeUR3bVDVeF0p9j67?=
 =?us-ascii?Q?OsQczZnlktbPFLgANZy83lIRl8I0whxVdQZtwsf5RkovrVJ9jfo8uwswQtv3?=
 =?us-ascii?Q?8Alm6984N1iNh223UT9DjDOkoPjCbHkicAzYpOS4zl1jsFQbbZYRKBYkPC9O?=
 =?us-ascii?Q?D/ZbusKMUw2Qp6Z7YcLcZJKyxjn3Ji1sJt3LKoTnXKP/99w2l6dS0yZMgmje?=
 =?us-ascii?Q?rLECAdxdHX9V+SsoMJ28fmoykzbTAiISwqtP7nRx9UvlETA/zjwx5fDwdnjv?=
 =?us-ascii?Q?SP4cTDxG4xmIYSgXvMZBbCq68z2qCpsqJKbo3HJQVUWIy42s3hXZE4yPX2mf?=
 =?us-ascii?Q?lEWftDw/qIfCtMlsnMijeq9IO457hI1Ir8cD11fC/evLn1hfdmAWRtDZYALg?=
 =?us-ascii?Q?kLLUsryj50ZFy6Fvl/x/C0G0dF4AdvUqYdSDx8Tfvw3nsgUZMa2/ifPPPp5K?=
 =?us-ascii?Q?YpG4XxkMIsWk3Oxc7BIzS7Y6Yqh4dNLG3NvZuP+U2Mai32DrqvuHVYeBh8TK?=
 =?us-ascii?Q?vc6k6tMbzZHue8i+HkDAuF8wB6NBuyCDcH9GKOjpF4CkYcvDAA6S51OkOVSD?=
 =?us-ascii?Q?RdBsaZwkxI/ox6zGouLGLuAWJaM/2bWJvkxzbfrVj1LajIyZU1s5t3lGn4AU?=
 =?us-ascii?Q?dYTUThTske2u2CddEyQvw24FOiaNTvnQ7qufClvU7p48oiERMm77K9iO/wZo?=
 =?us-ascii?Q?wEjmcZqH/6qIRUyRRgf76IAK43EHKYwZS67SxHyea243aanm9ffkiBSMDGYn?=
 =?us-ascii?Q?SeLNuR6rfxmGNpOKHn3ghINy/7m99NUL0SV6cWPQijGZi1zR40O/4bPDBmyL?=
 =?us-ascii?Q?kR/Tx5n9r4//hKoPmBe3uiH/nXr2J6Kli93CkUpjY3sYqKae8WgWQDDM95Ju?=
 =?us-ascii?Q?VoYijwJHXcegppnbHJtUSMGfHQA2crjOLoeZ6hi2JaScQYY5QBSkc4uz/Bn+?=
 =?us-ascii?Q?bHkaU4BPCE9HwS7HIbStQYUP4STa5LxQR1iPnUNX2lfC7HQ9ZLHJxqc+HlW7?=
 =?us-ascii?Q?uO5OYfacZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gbvEuG1pfZnZn0MwAurDMk+28uVmOiMo8DxJBMJQHky2P7tyOTgSHN7LbgRCQCz1EPxGVeNzVZYCuiDuz5KtY2u1Ev+cdu2WYQCxwloykLFqhc7VZKwufGDYKVnEUu5UAcJXawXvPGLeT+iGRafqGKBy00Ni/QU3iI7WJ6OPkEGfJA2CjzDYx8U0crb485C10IzEiFuYUTnBHU/TeWA9sGfJ7HJhYkBd/nia9dvy3I7QVDN6l2iEfy8vxucfnToCRpSozzf6bRdaBbEiOWQ4SHtWEOO6vXiaVk8UjUmA9XTeKoxagGgAp8/sQkchpXB3gAqptiEcPjTLeXd/ib4raA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88a3d3c-eecf-495a-9668-08deb00a2643
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:37:57.0768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEJ1GNT+/gjHDonGYNTf4YVa9mIqEo9R423zdSdC0x2ldB3r2oeXfhI74ozXyHlMGZjY7PcPcTMXKkin2JO11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA5OCBTYWx0ZWRfX6Uj/b87C0POA
 bgKgutWWGHjdgI4bvh0iC2W/ywQVxDIf5xjKWMverUszODYChx7qXcRHEZMd/ZbX9BDIn/Y+da/
 1v2yKAV9BwHd9Y9Rtsw2ltaDLtU+Sq0HQsaFfUNR8oXi5gYtvBCR6dfvgnKWk7HobIblPLKUOxu
 B6b3w3HJlVhgiJk6pMVIENO/Vyuy9xTwjQ96yLa3y2krzLCq9AIgOgnjVrNeEcHrudTUztLZFUA
 l2oOls/x19ki58KS0OP6IVRYB3VsTo9joJsUrMJ546mw0NF1I+MFGtCVKNlzdsUOtt9BGi1otRY
 geNxS0LPDS2t0kwHOoTXK0hw80dOWYfzKJ22O6mQFKHEwqV8ImSYPlmhNzvWLi9HVcnbPZ0g/Wj
 +RE+6oD+ZmtycZ6TcuqlqPFl171VCGe1epghUgq9SbnlcMPAbDOXGWfeUzA4p/1ibPbu1CQWRL1
 RT6gwGYA3MbuBoNbN/A==
X-Authority-Analysis: v=2.4 cv=WLxPmHsR c=1 sm=1 tr=0 ts=6a02f4f9 cx=c_pps
 a=alg3xCnYRXnG81SgvFS1VQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=ZiTQiH2IUWBo4DdfFesA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1IuD0HFwhNu0gomlaEx5IuQa6a8aBGnV
X-Proofpoint-GUID: 1IuD0HFwhNu0gomlaEx5IuQa6a8aBGnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120098

On Tue, May 12, 2026 Andy Shevchenko wrote:
> > > >  #define LTC2983_CHAN_START_ADDR(chan) \
> > > >  			(((chan - 1) * 4) +
> > > LTC2983_CHAN_ASSIGN_START_REG)
> > > > -#define LTC2983_CHAN_RES_ADDR(chan) \
> > > > -			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> > > > +#define LTC2983_CHAN_RES_ADDR(chan, base) \
> > > > +			((((chan) - 1) * 4) + (base))
> > >
> > > For the sake of consistency I would see (base) also to be in the
> _START_ADDR()
> > > macro.
> >
> > I said I would change this in v2, but on second look, I think it would =
be better
> > to keep LTC2983_CHAN_START_ADDR without a (base) parameter. The base
> > parameter in LTC2983_CHAN_RES_ADDR exists because the ADT7604 adds a
> > second result register bank, so the base genuinely varies. For channel
> assignment
> > there is only one bank, so adding a base parameter would make the macro
> look
> > configurable when it isn't and force callers to always pass
> > LTC2983_CHAN_ASSIGN_START_REG.
>=20
> Do the names of the definitions _START_ADDR and _RES_ADDR come directly
> from
> the datasheet?  Also, given the above explanation I would see rather (ban=
k)
> than (base) there. With this it makes less attractive for a change that I
> suggested earlier.
>=20
> > Happy to change if you still prefer consistency.
>=20
> With current names they sound like they are semantically tighten, when in
> practice it's not so. There are options:
> - move to (bank) and leave as currently done
> - synchronise them and use (base) in both cases
> - rename one or the other to be different by the name, so less confusion =
is
> added
>=20
> Your choice needs to be based on the datasheet explanation for these
> registers.

The datasheet calls the memory regions "Channel Assignment Data"
(0x0200-0x024F),  "Temperature Result Memory" (0x0010-0x005F) and
"Resistance Result Memory" (0x060-0x0AF). Each region is a flat array of
4-byte slots, one per channel, so LTC2983_CHAN_ in both macro names
refers to the offset of a specific channel's slot within the enclosing regi=
on.
But I agree that it can easily create confusion.

Given that, I think it would be best to rename
LTC2983_CHAN_START_ADDR(chan) to LTC2983_CHAN_ASSIGN_ADDR(chan),
which aligns it with the existing LTC2983_CHAN_ASSIGN_START_REG
constant and LTC2983_CHAN_RES_ADDR(chan, base) to
LTC2983_RESULT_ADDR(chan, base). I would also keep (base) rather than=20
(bank) for the parameter name, since the macro expects the base address=20
of the memory region.

So, in the end we would have:
#define LTC2983_CHAN_ASSIGN_ADDR(chan) \
			((((chan) - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
#define LTC2983_RESULT_ADDR(chan, base) \
			((((chan) - 1) * 4) + (base))

Thanks,
Liviu
