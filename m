Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793010172;
	b=W5NCAbbRITHWzZQI7fb2wC1yRheb5u0KmdGUK1ekBATpcsdoRL6tAqJGR+aSb9gknmwK
	 g0xncSUSN2LTBm3YUdGlqjdDDzI2jAdYPv1+ftSYb0JgjA8oa/+eMQxGeRPVGM1muwQqU
	 3x8hZRB0OKufHZxXYSOC7ob+BWQPx948Olui3S7BqpyFNE7nMSGeLV4keDrctMyYzs+mS
	 DaicOifhq52vAztzpkYjkZQi5bG+Y+X4Y+3B7Onqx7t8F5RAlHLRE6LhxkloYqHqRk8Z8
	 nrgdMxDd0ksdFnEP7BS68VvwuSj/NXx98JNfwPqOeyVKTLrwRnqpJxIXz9VgD/FmDIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010172;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=X9WK3ivUWAeUUycqaZOvduXVaXiqJo8o84zeBcHI8e8=;
	b=5Ni0tHADDsnvH8Fa/YM5b58ZMlulYzI1cXEcvBsivDrWCqUGIz0cQRY+I2cu5CBqQ7Db
	 xpFGRBR6yC2s1oLIP4krf0UuP+om8AinM2yFSEzb2CEIXhD7+oNVEtBXQ9Dcf4Wvwlg+L
	 3rxFbzSZp341VzFJBTgdJOLp9lDNbzrLhlyTqCii8Yg7Y9mRE2hhWkxkdenyvo3BIojC8
	 qwrKhba4mGjwsNPwNH0TK7LYNF+zdOKfbLvmr4xHxg3krEsrfG/PRPZD853swWAF4DSZ/
	 8EYVRVeD1Pj3LkZOMmqo7969JTQf6geJ+mviHGhMbXKzVNz43QzFAnr7kumWJiubzNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ae7kB+GZ;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=VX15IguM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668DC606A31A;
	Mon, 26 Oct 2026 10:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 668DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ae7kB+GZ;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=VX15IguM
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QA31G74185089;
	Mon, 26 Oct 2026 06:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=X9WK3ivUWAeUUycqaZOvduXVaXiqJo8o84zeBcHI8e8=; b=ae7kB+G
	ZT96TiOXLGV8AxvX5pEkqFWnuZ9D0vU50Vx43vehzOTEM3KirJWLXBVif9peyqK0
	YOrQ1b2AHKtbcYAnrdqUr7+f1EOjQ64MC9DRrnTffJY/efA2WydL6iJ8ekntQCH4
	onCh2GhChAHmwR65BRLy+AQELeJe7rlIvO5w2XHMaL4yX1MD8CLktzbSlwQsWhBu
	+8IRtcL2ncaEZaSiCpuycHV2WQMwWfVvniv7ajdAsbXpBWBCqnOdp9iVgGSR+Dgx
	7YRf0IMsf2RaDq6F+KNuOwjB4g15sHB9kr+s+XBVG4pDkvdReU4e/QsL5oHGcXnI
	3P6AEifh01m9hPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=X9WK3
	ivUWAeUUycqaZOvduXVaXiqJo8o84zeBcHI8e8=; b=VX15IguMKUbEa3IgOSVxv
	TGVCAohFYDQKf0agV2cxoivPjCA4Oh+A9AXUO8MdUsmRLgE3zlkjOt1rywKmm0G4
	jEpHy+E6FMnUUpYlB9nfTlDeJJKngGwOAoRZUxpI5PZro/Dij2EX9l946XVagCY6
	ZAWcq2oJzf7waqjyDJ9JZtDFRejPYCHFN9Yx5WHShpvTgMh+Ux9Y/NfeKLgPFi8I
	bavLOFWujMMvW5iy7ZNKOMcGT2kcZbbEb8St0gIWTJwZmYVfHCaZl5DwTE6Ogreh
	pxqHks+uE7kJaZBTjfJkIyg80SjsHRtQlYgPmsl4M6MlKq2K6tSMpXhMWKXJY9je
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hj339gqq4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 06:22:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JA5YyMOXcExggLsbDhmxuaDFS0Y2YhqkxJ6+PAj0Gn19LcHvymC/BfTNVxvK06ZKL/fk5mNuBYHjAB9Pz4a0FkZz5n1ctICxZkrzh8yHDuZmLQCTouT1E4vGcKSOn/5JtBKAHIzOWiAjGtJr24mCZHCGw8RITKPPUPrmZEenfC/GrEy9tIgbH6X0WfC/GCRNbFCPxbfhbpO/a3JzYcgniMpjflBjYToNzfgBQ2nsRjwt6CDjJW24ONhJy8p3InS4nzfG0uJTAbsPui5Zz2ik0HsSuMGyU9W3tV5ulaARjGgprevjaUWkzIuwbm9S99WFw6LfuZa/liBBwzOIP4e3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9WK3ivUWAeUUycqaZOvduXVaXiqJo8o84zeBcHI8e8=;
 b=hTnIGcjZNWbpuVuQ7atBoZS9ZQRsgpppDsI5HvL4bOW8prXzQjKodtco8/M+sipl5HUTlqzSLppF+blmzJxbR16x/9RrGo/htn+1YL8F2NZtF9UMA0BNl9gZg61oQWYA2TydINRzK+6Yu24O9PTrbvtlnO+4b5NjsbdFRlKtwCNIXtv9XAObeAdb7DcbF1tTvJ+rAOsivQwdWmowfNeJtWOYH6oZKt0GeCVPhxS1UnwzTThXe9SAo5fEGiAnkR81e/DUaIUyQaEUzP+/BKiP0OY3VepbnEa6OvE04bQSY7AqOOgPl9yVKGZKdkGXxNwv3pCJw7y+yBYuWLXK+xhkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SN4PR03MB998669.namprd03.prod.outlook.com (2603:10b6:806:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 10:22:23 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:22:22 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux
	<linux@analog.com>
Subject: RE: [PATCH v4 5/8] iio: imu: Add driver for the ADI ADIS16607
Thread-Topic: [PATCH v4 5/8] iio: imu: Add driver for the ADI ADIS16607
Thread-Index: AQHdYtEn04020ce4Nk2KyUqjY7F1HrcK7FQAgAS1CxA=
Date: Mon, 26 Oct 2026 10:22:22 +0000
Message-ID:
 <LV9PR03MB841429F153BCF3BA9F18CC02F7612@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-5-a4d541ebfd13@analog.com>
 <ats2XBBnfGmusCI2@ashevche-desk.local>
In-Reply-To: <ats2XBBnfGmusCI2@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SN4PR03MB998669:EE_
x-ms-office365-filtering-correlation-id: 04be4b2e-62b6-4fba-0e7a-08df334b062b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|10070799003|7416014|366016|38070700021|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003|261009223027099003;
x-microsoft-antispam-message-info:
 /C/2n9Maonny7y9SiptpcBLLFLP9iHsVC8iFo1FWsZz2zMyc/TdIUuHubwXQ8kJuh26AMJoGAYqbRuxTE962X5m2KOjYxxSPN8v4BTxH3ADSJe1ppcV/7CObZBSNSaUiPr1B8ER1x2r4aGAMp8S6jYYKqwdS2t+V1KF4rniyvjVCEOuUDQHPdbp7DjcMXlN3ReVKn3kOwjr66AyBQZF0l1LO9lm6+3G5wy8J5m+pUsigVf5BBySgmprrXyArp8jhIY//b+umSDk9op6F9KGlqR+m8nahvbFQ5yUvmVYeap6PlvS4nDiP6Lb1WpCkwBo/830A8GZZM3ehHxzsXYCRPmhIw28R5JbLPjcaXa5FyuwflZviZaWvgnvkCvXOdOpNl2W3JNBaSDCDIjXEy8WWCc55tu4LYo4n595Zc/YE2fOwpV610Dk7y78ANblkcXycZEb3UBrgIsu3qjH9foAONEnyMp+DjGn2PwAi1ZhwHNDDnh1yY9l6PuVXmn+nAGQ6/UYGb4nNsifZRR72deAyFDhBe81wU49Jf1JgdgXIWLy/xXINzzgeFjuDWHpiQJyVU0ImtsQanxnaM6RpXUh8zWLRlfbOQ8wcslrfCz0p2VetcAlJ4k2AVFT15fOL1SpvRu0F1pggNZ0X0bNv+QO6DEMuN40RlPenvPgJWkpZZucBqaZYsPX15DCotW/h5648
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(7416014)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h2n2bqUYN4ZWlQ1iSbU6H8h1pUH88bi2Ri4zK+pNZwWLDxBY4AQBmIR4fHv1?=
 =?us-ascii?Q?vezxOv/Al4tCTFaEphXlITliLKq+ouEOINFqUcaoRNbYV9XT7oIvC5Y4w0Km?=
 =?us-ascii?Q?cddt0r+JoJEDpj5BrKIu3ovGqyxTKN1KcmrjxyQTfIIVeW8eCBN/MAeqCsJM?=
 =?us-ascii?Q?z3Kn1gWLpnXq/fNLzXR1mERIik9Nt0p/4B+G2AE26xn7Kk5IO+oRgWBxfC8c?=
 =?us-ascii?Q?0HY1+YYqaYiIY8RG2NOyiDjFijPAAKqbRuYJ+9NDaxYPFqHR4Yt+FVvyD0gJ?=
 =?us-ascii?Q?DoNrMmxbIpyI/ZHjty62SGBrMEKdD9Unv5eGRorQotADDVRe5zEp3Y2/Y0eN?=
 =?us-ascii?Q?TXj6qJ03VsWGkQy5IK3ePasn7aPSwhZ40dS1AVy6veIEwRiVOSvEq4aCzbqH?=
 =?us-ascii?Q?uTFLCa/ozYNid7hcMk2aITc4kocUfG2Bp/dSrK9yO5A0WNO6Ir3+5WQcYlT5?=
 =?us-ascii?Q?xQ1O72j2PVO52LaLqwZ5WY+AqLMh9eK5jx/oIurMIwsHOTKUYIUZWzUHNML3?=
 =?us-ascii?Q?sJLGVN7smGLMGRdxtz72+EW6j0g3lZVhBTpAqk6SxXLwzabjkQlvGHUkiS4M?=
 =?us-ascii?Q?oKMr/n7MgO/idYBXuDY/DvLJtfppXWq9sl5i9uZZP6izoRVjvTK5po66ipgU?=
 =?us-ascii?Q?6M1rgIA0TYKe3Vawy1VhhNiAwXCUo0herTkCrnYq3eXGD/RFhCCf3ZWFKi4Y?=
 =?us-ascii?Q?tsHLnuufblxLfrQeL7QgF4T77JqmMf+Hj86mPvPUqO22Jr9PyXrMWn76jTLY?=
 =?us-ascii?Q?g8h3B/HKk2iSCRjXHsUSuGhHLj8R6OOLHPvCXJeFPjCeGKdmU8m0mgim1sXP?=
 =?us-ascii?Q?RKb781BgvfDNyAahsz1FuwUZfSqhL9T9vLfB+31k6aFqjmUNXl5vHzPSjGuW?=
 =?us-ascii?Q?iYY4LG1i3WQz4a8nCYFIW9bgV6sBjZka7IuaVkBusP6YciPc5/HUVWaOP1IA?=
 =?us-ascii?Q?8lYx7zjjAImDdhkG7jebPflj8vWfnWz6la94mpP46mwj8T+UUprDFDzAbwDW?=
 =?us-ascii?Q?I2Rsmedobp7tdnbUIdQupzWHqZ0JBL+U7t775TrvtKC5S9DFYi+OUg9AGmIG?=
 =?us-ascii?Q?t53ZlVJRJBTSnyTYlqzntk5ArGp0rtqgQPZ+IGKP1ozhxmeu5tX5oPF9PtPy?=
 =?us-ascii?Q?B9sFISqZwyf5GvDUQCfT2A0gdxlTx2V6L+oi5jc3p7MiH65RRj/EbB/FUOc2?=
 =?us-ascii?Q?jfkoua1Sm1BpMH2LsM1cnFG6qe5wj2e3UFGzYy3tcZGm5mvM7/GfOQpQo0bS?=
 =?us-ascii?Q?YJQ3YwalBLTCds+N9G53IPCRcl4JSVaL3ITeG+jpV0oOQ6DwZ2J/pVwSkWCf?=
 =?us-ascii?Q?L1qHZPdSRzbBjDYs95coWEAe1/hVBUfkK9T53Go7NPnP1Csv7JVgDRRocx/T?=
 =?us-ascii?Q?CUG3ahS0729Ta58zqla7fuzTghblqc8MyEgt+Ld1baC7fPyapXXdUxRTEL3x?=
 =?us-ascii?Q?LiU7GD8Zz2fiTUuuF2y+vo0nEaK3JW31OzQUnd8VN1+AimoN99+w13gDyRnI?=
 =?us-ascii?Q?cWHzqMV29HQpPeK4Y9VHuoPJZFBXR0EXNoYVcp1HwvY+eaUKKOTBNBOJvP/G?=
 =?us-ascii?Q?sGADJbSEL7bqiibuqn0652H/J4m592whaBx0JSnQUIGttBPEjD26SH5hjDEi?=
 =?us-ascii?Q?gnXtQdlktvTJujTrZ9/UqwcQttFD9h8YRjSl1rWjHl+Hx4AsGi1xc2EjAKfV?=
 =?us-ascii?Q?/MJoVHnKfN8sx/OHgMnxG9mBXPG2GV7BZ+NGeD5oTdAWgJo/6RmwsP/ipjcp?=
 =?us-ascii?Q?UnL1A4+vacwe+iZ5Bm4hNfFnHsjTcQA6OfzOjE/aPskv9gq62814G4olulIp?=
x-ms-exchange-antispam-messagedata-1: qovgCtYBXkQYEw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fhkq0zSkPUpG+GCFinJQYMPcyZG0dSN1i93PwUi5JdJ9j4TH0RR9oEZerDnPSnz9lZlXp8K+imNcL+MVoeHs/lMmVwLzNKJJKmTxxoDV/Uwsd1edrdUcqGG4u3yTGmTtoE0Vi2XgvlHBljDSF4siy6CP2RTh9XZPdJvi/p5tOSQjhd2gf9bg+EQvQpZDja+FCNZ1SN0hJlr+QMlr/K+kKL+TE7kYWmETsydgILZS0sHVMrXSoD0GVGKcgr/vN/bzWzf2LRzp6eNtulrLfIeCZ4PbGmVhVtkTkDie+umWAwgPHZp3OV3biYeQW8wiVZgSsaQc9b9+aYIGexcFOB2fSQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04be4b2e-62b6-4fba-0e7a-08df334b062b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 10:22:22.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEt51+2hP36J3X5GFoRssEF0qxc+iHsBNtfIs7RiXJ/6KIWP13fTWnYnV5m9De8BXd8JZyS5R/KkdYYERNW8cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB998669
X-Proofpoint-ORIG-GUID: xRoEkBTw56Go0xokR5xz2gNeLU4WcnRV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MSBTYWx0ZWRfX+LAgnEDRBIGQ
 FA19cjutkwr+UypcigjInul8vdVb0zgELy8RwED4/dbvt0Cwz7OR46onU9U2EY1dNrmn6FOHk4C
 ZzNrU1SZWTNLlNWtX/6YEN+8Th4krsxbqGjbhNqrhBcBuHfvWosfAdCZh5Hm3LVgAGtvN53WPc6
 2ewXq7uCKEMC1Vd9ecXggvdUdDTQPi//iUYPoABfOiEQ8X2ZEKs+/EmpZ9Y4qPoL9P+4S0XcxBQ
 9VYsMq2XY4tyyieROIJ2Uq/6VkNPQ4VYnnoiX+mcmGpkyvq4nWZEhVvZQ2+PrOW56Q7B+OHTRcX
 yhqcbKyhQ9OkvioK/El79sj93XUSZJ9Dco1f2ye+/kjCzGcZpu/JhTr4rhonnwEQdBteYdG28gl
 2HDccxJcR8KJyTwqlskYgCwjxpm/8X/LWmmTkQiYwXq4E1QKOaNFvT/HemjaswbL2afBkWvJYrs
 R56vXA4xACrT9mLTYcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MSBTYWx0ZWRfX6yh6RU38wU5Z
 A17ZN+RQJj8wJi6Ee1leqv9qrHT1dJABnQTgZCWqGrmOwccxkteGZhrJN+Xn+zRo9OOV0RZFJH9
 D3rMjTz3YoAI9fc/h4yAdTBAs9w3Wd/4scg1LJ9i+flVqeW4HaeV
X-Proofpoint-GUID: xRoEkBTw56Go0xokR5xz2gNeLU4WcnRV
X-Authority-Analysis: v=2.4 cv=ZbqIpcVA c=1 sm=1 tr=0 ts=6adf29e1 cx=c_pps
 a=C4vld1iEI+sMWzcozXu8ug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=QyXUC8HyAAAA:8 a=RT0LbGDypAldOLYz7mUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260041



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Friday, October 23, 2026 1:27 PM

...
=20
> > +static int adis16607_firmware_revision_show(struct seq_file *s, void *=
arg)
> > +{
> > +	struct adis16607 *st =3D s->private;
> > +	u16 rev;
>=20
> Can this be
>=20
> 	struct revision {
> 		u8 minor;
> 		u8 major;
> 	} rev;
>=20
> ?
>=20

Hi Andy! Thank you also for looking at this series.

Although I like the idea, I have a question here.
If u16 rev would be replaced by the struct and the read was done
directly on the struct pointer, could it mess things up on big-endian
targets? A native 16-bit store would place the value's low byte at
the lower address on little-endian, but the high byte at the lower
address on big-endian - so minor (at the lower offset) would only
get the right byte on little-endian, and would actually get major's
byte on big-endian, right?

What about we declare this struct and also have a u16 tmp declared,
do the read on tmp, and then rev.minor/rev.major get assigned via
FIELD_GET() - keeping the readability improvement without that risk?

struct {
        u8 minor;
        u8 major;
} rev;
u16 tmp;
int ret;

ret =3D adis_read_reg_16(&st->adis, ADIS16607_REG_REV_ID, &tmp);
if (ret)
        return ret;

rev.major =3D FIELD_GET(GENMASK(15, 8), tmp);
rev.minor =3D FIELD_GET(GENMASK(7, 0), tmp);

seq_printf(s, "%u.%u\n", rev.major, rev.minor);

