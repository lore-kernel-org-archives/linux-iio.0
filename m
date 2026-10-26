Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012092;
	b=hs806BYPetbX0/kXAN14DJfD5Emf7a2G6g987wd52MWc+/eKV4ozofheYJYuUsBiP+YS
	 GxRuVPSVrt/uHiHtu0S3HbqyoADqJPTF6TKjJpBEJw/8G8Aj/j/zoe/IanEfZBQiwYuxb
	 hRni2kGVgsGtxYqnvSaa+nHFe/BqX16rQ8lEbl+FlWOcYRWhqBBwq3zlFTMlfHI44O7pA
	 RYFtB96rNalN1zaLE9/s9oJuLejg1jgT/f/zhEMBcza2/eqt2W36O67iZZuUWEL2zNH6M
	 frrR++bGlGRBBquNTXcsKROsPe++1EIWvbBs07eL2NOAaOJ1niQX05Gn5tC5Iw8z1pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012092;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=b056ezsocbdxljoLLm3NmA/Kr7mJQ8nR3v5LL7hNBEM=;
	b=BOR2Wov/Sxl7vlDjne2SuuFmhud22kTWs9rBGikEzugALJnrmlLMrsh8M52UmIYulYYZ
	 XtuapNoTndw0n4zDiE5Qrs1w3Cn6xv9s77EOMkVqAp64pfz2RzGOwSoRNxj/TghaKgRLM
	 GJG0lqnTtxkRr6rRQovVv4jfwZgRpK2R04eFjMYwUT5/hTNxDCm0hTvgY7wU2YfIksC2J
	 KQqs6TJg++8goZw5r4GyvKJ34WxTiZW9mqGdBd8/sCmgzlXHXxXgOAIbyaUnbnuzZn1FM
	 A02jmIBVjSQq5BTZrSSLcrqPDoF7GQR9ItNb9mlqlelkBy/+6g+Dtxfwn+Ma3Sp9xjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=sOmtdTv+;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=DHVl0ejQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC94606A31A;
	Mon, 26 Oct 2026 10:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDC94606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=sOmtdTv+;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=DHVl0ejQ
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QA0I64632137;
	Mon, 26 Oct 2026 06:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=b056ezsocbdxljoLLm3NmA/Kr7mJQ8nR3v5LL7hNBEM=; b=sOmtdTv
	+ThphM1GTt57e48bIlGyf669JdTeXOujquXJXXBM3gtYGxuK0+Kj8DWzC2iES/46
	KHf0tjJv6K0EzG/TgANpzm75Vww6fvB9eOdQXY7QsduFtOLBNHB5Qr2/9YBVslk0
	f67r3XBtpMa8IsvO2Ra+UzA0wzu71tjmvnilytfKHgoREghSie25dCfWmL2rqzxo
	QO1iVcPtNQmiyuhM2lOnipuzyrjDD+aqi8CJexeOzhzwKJtB5+gBLmh2fXCr6CmX
	xWmt/4pgt3jpLenrYfvuUMRoXfQVV+3UL467JRdbMsr8QHhaXoAokiAOoxG9TzrU
	mt/6Vt0ah5fz+iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b056e
	zsocbdxljoLLm3NmA/Kr7mJQ8nR3v5LL7hNBEM=; b=DHVl0ejQLxsv+k7Dr3HCb
	19Kv8BUBhaIg/V6dsRSgVVEyl02B7ks/Z8wPkOU+WJndhnvf+j767bZ1Hu9C0oQ6
	rH4VmQmyRXuWmERvFQHAtMMbWU3Cp4bSxb1l5PFcelJ47jXrZA4yAD02+mw1L2Bv
	Ig3IAlefBox3gE1oJ0yD9IUxvZbSoQck1f05oqxFrrQCLeA3OsRcmBYJa3zUBr08
	sltzrfKj+SkWBPKzDkuUgvfpJAxoZ/xQJe83Jy8KXQ1LWJ3MZHpNedSsPgqGd4oj
	16E6Q49M69Ngo6vC9cgnkV1BvTGUEU/MLfGGZocuffYEjMTqc9GNWlzR2JnPV2lW
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hj4qv8aqg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 06:54:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVdQTiwpA6WLCBvkZay/ZkqrEox9flW/J/A3AsnqzZE+92O15pVG9kM9vubu/C544wji4N+c4bsoE3kNRqkLVqf4dUzZUfl9RujgUxzBy7GmDKGY7c8iLmeHUzmMaQ2BpTphF6gCGI6DY5A27DY9Io49T89kg0uDcxf3qPtn8I16OrAyJmgtDQio2JUuSA3FjEbugpaFGPrrU45wsy4n64E/38flAaCISSD3kmdy6XO4irlLvXTm+1H8XzxOzHcFeoQHJK0ZrP9sf4GIKS0RHvQxwazVVKzD++Sz7gbpptgIR70BvebTNJHn/qeFUNbZ7v4A99MsWW0JsbgOYIOXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b056ezsocbdxljoLLm3NmA/Kr7mJQ8nR3v5LL7hNBEM=;
 b=xVwAp5Ggs4eZSIKNTmQyzvzIVZ/MfHPsND9duAWW1E/o78w1Hs7FxBaWbnLCQsZoVeosjSOGfM/KYbDJ/uDeUb7BOb9LTfVc45mILu94PWbhJ4rs4cA7dT1Y4EW19OCZDbNEaD68BUL5AgBzwBF4Cy7lnxn7ves3bg3mwGmkXcLvFJObvysuLEMjpCdvznFyNVroFD4rCm8Goq+xHk6Eb4zUesGcqf2iFAiDqBN6Wxg3e1/mkTZ4ycrKF0X2q9lVy4gHswyil5/UfcJM3OOGl0sFtQp6sVRialNAnvhNYc1AdJznBwo/794Mb3m/dKgpWNhIfvmVZ4dqchXQ6LOA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA6PR03MB7807.namprd03.prod.outlook.com (2603:10b6:806:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:54:30 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:54:30 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru
 Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux
	<linux@analog.com>
Subject: RE: [PATCH v4 7/8] iio: imu: adis16607: Add external clock sync
 support
Thread-Topic: [PATCH v4 7/8] iio: imu: adis16607: Add external clock sync
 support
Thread-Index: AQHdYtEmeJWDofcEWUGyLxXV0N38b7cO93kAgACzhRA=
Date: Mon, 26 Oct 2026 10:54:30 +0000
Message-ID:
 <LV9PR03MB8414AAFA18307F673D64FBACF7612@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-7-a4d541ebfd13@analog.com>
 <20261026001132.3c76529a@jic23-hlaptop>
In-Reply-To: <20261026001132.3c76529a@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA6PR03MB7807:EE_
x-ms-office365-filtering-correlation-id: d702320e-c2d6-4323-76a2-08df334f8316
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|10070799003|366016|38070700021|4143699003|56012099006|11063799006|261009223027099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 2O11n/B6oKP/u7I2KdYf18fAZtZDudreM87c8T52H84241+AhFF7Yl47kOEjShbE5n251/mY5BQ92Pyo3lBc4g/48AB+CPztiBZtoCvMrruTLUiDoVO8QzHfZGu3GZKROULam1WKndmUTWdThHSMHn/TD7Ez+PueDFK5gTSL7Am1MmjzqtRn2vgKeUbf6TqK4LfqeC3nHgbMNTAp8s3MIv8Mx+53AUwRE2ntH3cCllq1cHHkb9G1MrrMUncgFaKNlSCcT4n8+zLNR1eMmDhZ2SQzEkCPC0Ho7q8SGxrqdobZfUXljzdl0IkmlOWOmqj0cg+9inoVXHtNF/oPLLgcieAZDpHv9VjB7ban6fONxKuruPhpp8Ppe3EeKJh0VI1V5XunDpMQodWiWshKRYsqmvgWsIakPT39dxObe7HrOlkiTQZXCaPZxTBtvBRyJltIWDeVnHvejClkYlYY+P2tIE9a9T62zeZi8IcILfcko6ue1+rLOp0oE/A3ZR765XT396rIpY7gzw5RBxUUs7X7MSlyR3nV6dP2wjqHah7dk/+fPAQzIbrGPyEafHsnhjKFfaCcPtqFm6RPujfXkHCR7Au1ekrRU/vC18hCb973e77z5rwiHWexucy/hIn7qPYO6FYm2bKMHvZWfl8ihX3/4zbpDMgf56hxvvEVrPH5w/zqCiTdDhwz7vYcMx7dcD5KfaoOnrXCtQOND61PEOvghXyoy/435AYO2zCAxmYChxA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qs4K+fTsnRhDPtozDwFyJTO8YgXmWEeBOxNxJGHylS+LciwK+FLiJMRhSzzo?=
 =?us-ascii?Q?T/Jggg8RheBC4MJQf2tNVKcIHqq/aAKRM0S/Sv28MI+Sh+HznmllqvlGyCWh?=
 =?us-ascii?Q?usXl6OYHJusmc0d1Vpp6744ELW/BZtUxvI+ZKA7vI3t7aV5Hh/xJDYoZIJ+a?=
 =?us-ascii?Q?KxLX+F/gdHpPun7ekacfX7dY8P2vHW2mDNyYiaxqkH9NCpMy6LJQqPCj7LTN?=
 =?us-ascii?Q?3Va4Rq5DZUM2ALv/vmfZOCnds7w/2mnGjTeThTtY3YtxIiqoVesLvRcIcpiJ?=
 =?us-ascii?Q?jtKzenhqhIntfUIiNpuWFsgu7+iDHLZ5qUKq6qZMeZd+kTPoNNo0gE/CVVyP?=
 =?us-ascii?Q?PM8fWkdLrvDbYkxz/j+3KLNY6MvgkPowI0LZiucm+jf8JgUZPuSTM8pi6LN3?=
 =?us-ascii?Q?ntHNFiAYmVC1bCgDOmNJiID6WhLJcQnwv3GazB8WnCz0Ph/u3E8JyWPT4s6d?=
 =?us-ascii?Q?2WVpAMhfy/yJIVVDvRv+s/ToEYqO8OezupBriR9cHghtM0KWVgJkCe2sfWGv?=
 =?us-ascii?Q?Kl2+cO8tVvw5Bz15boWTyY0QGSy1EjOvxBH/6IE6KUzwKsPYxns6yZK75kVM?=
 =?us-ascii?Q?7LjjCmVZgydwYCJMbhT/KlWYFuz2LCR5uWiFYmUGOIr6atXGnVsRumskBuHa?=
 =?us-ascii?Q?tfhXQjVh6KK5ZBb9jai4/57dVYlVdw1U/N5L15nmDUb/iQDckqlaUjQNyWAR?=
 =?us-ascii?Q?M4rYkiq4ENJIoHxtJtK5XvSnrSR5PG7NlcolVaGt00SWosA3qBeY7RtpqgjG?=
 =?us-ascii?Q?ccGIp/NoYX/Cs4g5nW2pKgdoQ5VXP9jE3rnN0A/ADPa/Q3KmFzr2Zgkpcqsw?=
 =?us-ascii?Q?BafQWjUPipPL9zRg75OLXJ26OHEls9xsZmO5uDS38Nt0Mcm0zRUXvwbKZGuI?=
 =?us-ascii?Q?VSPOA9dagUMVpVFDNgy2noJN5jHvNjhgH5SPqbZg9ffUarILkuqNNMb9ulOd?=
 =?us-ascii?Q?YPXFA/zOVYqonEtu6bNyhBEkSHUI+9pNipKsCRcLFg7U8vQmZHOMKsiRS/2s?=
 =?us-ascii?Q?Khdszzr5DdUgdlAmNTRNm/03XToj50kGfPoN9zdMfB5iSef4jZxJVhKIFQNo?=
 =?us-ascii?Q?McjzAt55uKEGzNUfypMMo4pD3XNcBmN65HST93KNd7qCYTgTyoK7JFtRxjwF?=
 =?us-ascii?Q?UbVwMIvO81rtH0nz8cE+MzYvZgyJkd6zjQlE1ESYge7RLrescZHdycGxX1yh?=
 =?us-ascii?Q?h1QVWAX3Ncn5Cz5gEpBMO4mrNFdMTYw6d4AMvXiUOoPLXupKJhiGwkLtkBHS?=
 =?us-ascii?Q?HxlWT6dbXiKiS2w1JSkpPzRGAgEFoUYrM0cTlvVPkjhmvyQq+qPsTa59QERG?=
 =?us-ascii?Q?+QN5RQ/eMspeeMvQQ94VMQJiZVZiGc+Fogx3t7OO0dLxPBLTtm19mnLUPlhd?=
 =?us-ascii?Q?U8FnNd8MKK8dHzFqlsrHaVYcvL99309b5aS/kAwU249+3uDRKsrq0FPrUKHs?=
 =?us-ascii?Q?3suTiuvAIm9xTtjOrXNk2jPCOXzZr90KSf5gyOt1tGHGMS+26CyLp09XUc3L?=
 =?us-ascii?Q?9tTJcnYSxSF9BysQadJ89etb5i9/RcB/FAeG8i37QcxeCLUEMsuGLVIYxBgt?=
 =?us-ascii?Q?aNLJn7DHFufvpvnBo0hLX/sZ1cxkOLtMdsZfyh1WSU2lJ6W0cNDNZqx15Enl?=
 =?us-ascii?Q?Lxj2aJwYw3KJLEw5/oa6LBwes10g3dQLn9k2/2H/jtHUxT6ChrrAAaX/I3ff?=
 =?us-ascii?Q?3z6uryl+zXlWIcjN5ClqPIVQC09SEAWJuHJeEjChy0AiCPEuQ66yfVbmgsmS?=
 =?us-ascii?Q?KcV3Z1V9kcapcAjcMJz0RQj76UWkbnlz/LsT2cHaAVzKTX+EXJi48Q9rRZCy?=
x-ms-exchange-antispam-messagedata-1: 5G+CeKqwmSZjnw==
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
	03N0T2CO16YoZB44OiUV6PEL/DWV4Pi/iVXsZYy8FUCceOEuWKtL4Swhh8CKa3nfVD3wXV9E1tFujxCLe4NIdkwSh4M4o/c6R44DG8SPSz7ohRpGUjO2snOokk21U4INy7t3LSxqlzeFi6Yy2Gzx2mjTQtSKVmXKbwa8/1jux/YfsXU92x7iVy6clyn6ZKuOFO1eRNpPJLNEPhf3eH0lIE8IfqOK9KNI3QYBPZenInXVrhSaXUAnr7y+gJyRORDFwVicMlXSvMF6vLOG71FYJHzkuxsVZ1J+eSDP6V8Djq86/Tge4D8iq+5DMWQFIanq35BBVObgIkmBoi260yssVQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d702320e-c2d6-4323-76a2-08df334f8316
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 10:54:30.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pa6zOuj8E3oS0yAzS7w3XC0t+KYRnVPvrw8HGJF7SVLnm+Twr6szmcT7Y8Lz/bV+I+jW7ZKeIEFTTThCnaY/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7807
X-Authority-Analysis: v=2.4 cv=W6qtxhWk c=1 sm=1 tr=0 ts=6adf3169 cx=c_pps
 a=0RQO2klDQ5fyV1VIsLBujQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=Kh4wWMj23ALisYEeBXsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MyBTYWx0ZWRfXwoJALKChjrxc
 vff+s+eT4AUMR74lTodCyg0C9Sss1rGQSFS21O1Y918GuT1/BnWSzWDM0qDQHLBwmCFfqPjZ9Xe
 6hCczC7iJgx5wWno2On03uo9ScCnPIHrIYSTBSlOVOGJZ1pdoIAiBza/3LLsKVxJQ+XAjNU9IIO
 ywkrU6rDi3paB8P451td02Kr4s+58pFw0RKwFUv1R/RNRqXsAeCYC+306QICwWQUOolVSlK0V7e
 /ILy5nvd1NF5ujNj08vd4yE8CvkedaNZOc9n561SRxJHH1gEkd01RDtz5QL/Xwsdc3IoKQ5Xdwf
 8OcvjLyT3lQnRbqA9tphJ+gRhnDtAIaTFmry8qd4h8V9k2V9xIJo32exaLzZtB2M/sk5/+TZubP
 AS4vMLqW6mht3RRosJ4FvDsZzWMQ7BPE0Tnm3vLIehj6d+vny8WouBRKwXINWSkw1BSVN+39VJm
 8Q/P3RJDzcaLi0IRQWA==
X-Proofpoint-ORIG-GUID: q78ZPX6GNH_aJ685P9r-pming88BlBLH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MyBTYWx0ZWRfX1UdWLwiXWYgY
 OeHNJNviW3iQy1K8H5xopTELerEPkNZNM/Xp0578P4Fmc9HkaLf0o26TB7zzqkchd6c7zyjMG+L
 y5w697ARNyW6D9NWzz4CZwoE/cJ70vQZhzbU1CC+tOC6LDOB8wmG
X-Proofpoint-GUID: q78ZPX6GNH_aJ685P9r-pming88BlBLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260043



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, October 26, 2026 2:12 AM

...

> > +
> > +	clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return PTR_ERR(clk);
> > +
> > +	if (clk) {
> > +		ext_clk_hz =3D clk_get_rate(clk);
>=20
> Hmm. What if it is a controllable clock?

Good point. What I'm thinking: add a clk_notifier (same pattern as
adf4377_freq_change() in drivers/iio/frequency/adf4377.c) that
re-runs the sync/scale setup on POST_RATE_CHANGE, under the same
state_lock the trigger handler already uses, so it can't race with
an in-flight FIFO drain. Splitting adis16607_config_clk() into a
probe-time wrapper (gets the clk, registers the notifier if one's
present) and the actual setup logic, so the notifier can re-run just
the latter. A fixed-rate clock would simply never trigger it in
practice, so this covers both cases with the same code.

Does that work for you?

