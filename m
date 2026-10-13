Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BE519919;
	Tue, 13 Oct 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897305; cv=fail; b=X5pWUyAUQuZq/T37MkMSNQrhFji3P4ku0v3MW6sGoOAdfNd/641fnrsXOxYwj71LqDJTzpW/drPIGb0ZfTd9JSH/icu5Ygn1Le69DnWFqumFWBwc+ZzBEJUtT7nfRW7tCHdArXNUxebH/AMx5WfABPRqbGn4LG2tlT6ExegU/3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897305; c=relaxed/simple;
	bh=LT5rtp71iFnPqH7J33/3LtdIOMVrb1Cbwik+abwUqk4=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=HvGOpQWqdCQfwDevxU36Tv1CZGnKP4wktDcfEtYAKVO/PrK/QcjRQK/W3C2UtkgSrep6ZPZUBqeQrgEg/3SZKUTZq6BCafNqG/LTEHAXM4SUkV/NrbMsvAiaZvYKLO8/zb/3Z/TTp8IGM+PwASo2nBbeH7oi0qMzHHKrqyGElrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=ZV+ThFu4; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m+ijGiuy; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="ZV+ThFu4";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m+ijGiuy"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DAogRC185507;
	Tue, 13 Oct 2026 09:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=y38G7Stne7weho2cesfj/ityzIHDJHqZyiWcFLQF/vI=; b=ZV+ThFu
	48UXUMERmHE4egwoj3HdmkGI7aPW+f8xIvOY4MFKr7eyFWAK6pOJkhVtZ/SV3AyO
	Lp3kwF6xTJaVgPhHYmBUu42JbjnxYSxXOPWg4UhmOrbxTYch3+SelL5WtlJzFSFb
	CQpPARvmlR6HQyp17B+AFq27DQkl8+auas1ykwv9hfD0VM5oUw247Fb2Ku0SXPfO
	xb9F75Vwc1SigO+NAfIqXZfM802Vg+c+ltIlzEjbBh5jCV3lp2MbSquz/RwZdTrJ
	gfxWV7UKmSY9dtxfaDxTa8HQq0RQ/K5G/OuGZpIko7thSdYPtu4YRaHkC00Ftf/e
	Y8x42KNKPjGxMMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y38G7
	Stne7weho2cesfj/ityzIHDJHqZyiWcFLQF/vI=; b=m+ijGiuy0IY1R1UZXw8jR
	z+RwzV/vGxJwqwQ6qrY9/WrNOaB043RmMfc3oTsKQk0ZdoeUKAaRbGeFExlfUK7m
	tqU1yq2x/RqQyD8/PyI4vlkYGN5jo4Tb5d0D35PrMezOu1wIxZmgDe7h+PhZ1KKB
	kKRnxAksO0sYPOAuROH/Tm/brkS2nT8LtzrXMpZpyXudMkhc7KfIXHJT7q17dSCE
	Wu9L+8j/3NkZ65e71DbJxnS1ZKjS8yqUXkqqZjXQGR3PxwuTFu/KB0UHyK6FCEnf
	7/ohSK4H1O+/nUTmMw4X+NHX4HENsXrsdQXQ9U6DP+tqL945VdwFd7Aq/gEBBQp/
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h9ftnsmwa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:14:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTi9mg9pcxlBwa9lj5wqkQEBxV91pdUxupSL1bmH8c5SSyB/GLV2JZ7WVm91d/lGVVy8du9gXL6GUyYhqgkjxlrse2LhoXvI4F+Udkrf68ea7sFKttGGYLJNv//zi2Q9DCJI0aEpDH+CcPS18puFv7+gJfamydD+MMAvzEBYf7ppJJBLLF4HhYH1XBsOgm4QZ/dO386hMM4wFzUPZdOejV32oBZfelLXivd4EqjwgZMKUs47bkc6o9HK7cDEAkqorCLgX2mHsW9rVXqISVj+47MzGuE60bz+HyvkemOV7xmoafzTN6kh0eh9VVMnXJeGxgOi5FpjQZ1kJ8LfcsKWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y38G7Stne7weho2cesfj/ityzIHDJHqZyiWcFLQF/vI=;
 b=o3SPxn0bWz+k0d65EOaexZGDd8oZaFWqMSFajyoOw7I0LeHYgeOtg89uEZD3dORz0H5lzDYn1s4cZngrOtFmKJe/Du+MqCl/w4lVh7h+pppVILfExIUGRoThVe0H/0x4XZCwUy+lRPw+IR7E14GsjNghdZrUpXiPTLfP0jnKJeRHWtC+wE4O6DSqbxpApdU4lQkMkxH2/eOxPHKsyzCt7HceTlxmmTqLKN8njidm+VhaoAUHBn51nDSx3uX8Evg+Iy/kq6ynQXFv4xK2Nzy8lI1Yvhn/Y+1eOZ9HZTI22OPOEe/4R8Od5ztFWwJcMDFzuNiLvzTw/6BIhg2H1PDRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by DS0PR03MB989571.namprd03.prod.outlook.com (2603:10b6:8:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:14:45 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 13:14:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/6] iio: adc: ltc2497: add LTC2493 internal
 temperature channel
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-3-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
 <20261009-submission-ltc2493-support-v1-v1-3-3dad1d4b152a@analog.com>
Date: Tue, 13 Oct 2026 14:15:55 +0100
Message-Id: <179189735513.1005940.11850215863623320051.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791897361; l=1028;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=LT5rtp71iFnPqH7J33/3LtdIOMVrb1Cbwik+abwUqk4=;
 b=1WWkdfHDmLYxNSZ8Hpn4lLDRLnDUv3AfeJs/pMJhqt9dyAavx6p4m6e2dpjUuSgD0xnXOWrxS
 0VTcjSM0bw/D/soB/+FRKqkCqoi1ynI2j5Ah4J3ncHl33EYkJxtft8u
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::33) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|DS0PR03MB989571:EE_
X-MS-Office365-Filtering-Correlation-Id: 898383aa-8e29-4307-2239-08df292bf391
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|261009223027099003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 D3DlrYszmQpkUMjC1LVwl/eZBqo5siuCKbT5egfz+uZfNHVEqcO1ychN2dYHh728WfJ/fR1p1/4yXsdLt4mfOn4kzOr/lXDNoe9eg9EY+KIAbAp+wbz5Yhk3xrb2nV3c9GGZ0CW5qdOMTIKDN0qrzO5sq+819wsm3YilUdrR6lx2Gcw5ORJY9D00sRqGXYGFBvO7gPPSgG8bmijv6tRpCk6x5JCgqBWkNIkBCszVfxl1KfmV3HtvBlUuEES5/fpd5FtJN0JQORC28yyeQv47v1fbmAvSN5fYvya7mgfNGLKe1kZnPlCCQ4gDoOEwypfpPjoLOe6THBTcm4MasUbMM+6/uwwtB0vB5ubjcYsm2zOGTcuexof9bxLEGeSfEYvDhBVYctVX4252bHTBJQ3AuqWp4Gut+9FNj7tuCgESMu/iSGa6aRoEEsfvbj0Gc9nxtLgX6ceH+IR+bDaESOKTKgSXlyNlWmpM7Mqu200GuCM+TTz6oxObhJ1c/HHFhtUTwUBfiCzPwoE2zr0UqOPP4a8gBJOgc8VC12xoirFt57VInXo87sgfHVMyqZf98Saa7DjIACItcG8lKsSBvpAKwuKWtVqtDZyQmwhk7hB1TJykSk7jAhS6rZNJr21YhN407A4OUuopBtMsYBZp7Oo+m5/kw4kkSiGbObzadRqukk8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(261009223027099003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OHl3UUdQaUJJZDNiUHJxZ0pib1pqRncwbGZ0SktWQTNjNEovcFU4eE5tSnpW?=
 =?utf-8?B?N0treGp1MHVUMTV1Nm1UTEt3VUlZYm9CN1hxdW9mZ3FHVEs5dUVPSUdYMS83?=
 =?utf-8?B?WjdydmgwZDE2aDZiY3Q5UUM1WlBwRFUwSnk3cnovcFdLZk5nQ0pVYmw3WWJV?=
 =?utf-8?B?cU5jSDBrdlFSd2c1aUNubEZxYUxTdHVHd2pBbWNHdzJ0TGVNUlpsQVFXNkFS?=
 =?utf-8?B?RlB1MEYyVE14YWsvSUJBQUZlc0lhRnJ4SHVYSlN2Z0FEaGxaU1pWWlZtWGdH?=
 =?utf-8?B?YldIckhJRDQreUN5R2FkRWZBNnRrVld6NW43QlJSVjdBbW9LMU45dUNSLy8r?=
 =?utf-8?B?ZjVzdnVnSTh0RjhtNEtGZnlNcEZYWGNhbldpMGtpODJGaURtVjAwRENuZmVn?=
 =?utf-8?B?YUpmVUMrOTVGTCtpSGxPM2VEbXBDVjdxV1pWVnd3YlN2VVo2enFkODJ5NUp5?=
 =?utf-8?B?dHRzQnFjMityMHdqYkk5azJKcnFKVHl2RTUwZXJLM1J5TkVHbUZXVnByOEVy?=
 =?utf-8?B?R1ZIVlpDUXpMQVVHVlNYRnZuM3NTL2lRRlAvcEtINWQyVStoM25mVXNPNHQy?=
 =?utf-8?B?Y3RxMlI2NkFRV3NxYndLa1lEYWRwenpjVndWYkUyYTM2dFNGa29DdlBIdlVt?=
 =?utf-8?B?dUtwZGk2bVpSNm5mNXIwY0J5TW1ScG9xRldmNFZtdEdmS2JSbk0rd3lySU5P?=
 =?utf-8?B?UU9MbzU3WWJBUWN5N0paVDNpdXFNK2V1SDBCOENWUWs3T3RVLzJlT2VXQnhW?=
 =?utf-8?B?S0N2b3NRTHBZSXJLWlBHL2ZuWUVnWlozRitwWFQ5Y0VTTitIRm5UKzlFUmI0?=
 =?utf-8?B?Qlh0aENUYUZIM3FTV0RFdkFSM1NCVVIzZEhtdmg3Z0tEMDFqdHhHQ2xoTm5x?=
 =?utf-8?B?VmZXaU9FVGlQYXkxYXd2MElxa0xWaXlPc0MyOExqZnRacE9Qd3hRbUdnN0cx?=
 =?utf-8?B?TVJvN0ZFU254d2tQRlAxQmxUNnBxRG1HNGJONGZMN3prWjRidWhwbVdKcFhw?=
 =?utf-8?B?Tk0vQk9ML0JNbWNhdHVKc3dTQWxGSWtoSWNXOTNPaGZlUnRuMlRIRy8xL1dX?=
 =?utf-8?B?bERTYmZTMTJCa1dSRnhGRTkwcU1uK3VsK2pXZVhKSUhHUXNNd3VlQ0pFckZS?=
 =?utf-8?B?dWxhSksyMWIveEVoM1BiRkNESWNQZ2Fsc2pqeFhMOWs3ZTVZeU9tbDkwemFB?=
 =?utf-8?B?Y2lvazBvYzJtSE5VSDNHOFp4YWZtOXkvRUY5WkFzeFdNTlBpQUxnSi9FSUFq?=
 =?utf-8?B?SDc5dzRmSVhqN0x4U2NtNlRRWGVseFlJc0tYenRUZyt4SG5QS3krWXZOWmYv?=
 =?utf-8?B?cXR4dUtGalVISzFaanpHVW9NcGFrajhiQ3huWEpKTEJzSGVCUjJDY2RPUWZt?=
 =?utf-8?B?ZzNhNWRYSSs3Vnp3Q3QrL1pPZXBzS0I5MW05cTlqdkFLV09qVGJsZDZWaTUz?=
 =?utf-8?B?MG1jN3NuUDY2KzhhS2thNmFYTEY4SS9sSHJKVFd3N1JzWHM5czlNbHVHVk1E?=
 =?utf-8?B?WTZJV0tEZ2tzME1MSTllUDhzTTBLR2l0MlZkRFo2TitzbXY2bnJGYzJRWnFw?=
 =?utf-8?B?clFud2tKc3dmSnMwelZPN2J2TjN6bGUxbUlEZEtXSklRTlhvd1hORUlZSjlj?=
 =?utf-8?B?OFAwd2lsa0RrSUhHMjlnSHdqSFZoY3lCcjJwM2xtWHdlLzFvSUwrbnUzL3Y5?=
 =?utf-8?B?ODJyWTJDREMvZjhKS1hmUWRQMmxUUDFGWVVlR0sweGFvVk9NTGxwRmxMNEpI?=
 =?utf-8?B?UDFFbEpiR2lna2JOUTA4dlk1Ui8yWEFtN1pOQW1ZQ0s0dHZWZWJyVXkzRXB2?=
 =?utf-8?B?OEhMMVhoTXVxbzJlQUQ1WDVULytGbXdmckdvQklhVHZvcmc2ZFJUaElOdXR2?=
 =?utf-8?B?c1l5Y0NQRFlhTVlDYWpXMktyenRvMnlSKzFGTFQ2Ylc0bmk3MjZvYjZYU2ZY?=
 =?utf-8?B?NVNFTXIxSHR5UEhENXpDV05KdTVORUxzUnJSQWNybU11bTIrME1xR3VBd3BV?=
 =?utf-8?B?T094WXJldU5xWXJBUUwvR2xXSXl0YUREUFFGNjBpSExrUFR2RmxrcG5Ma20x?=
 =?utf-8?B?M1Ntd2NsMVh6bFFIdzNLYldIdGU4VzZoNU5xandlN1Z3T1ZuK00xOTBqaTVn?=
 =?utf-8?B?QUUyRkIrKzJWQ1lTRHYxRnNwR0lqbzl2YnhqUjQrSHIzUXcvUGE4MWRaQWp6?=
 =?utf-8?B?N3QraGRHMFJ3U2ZZa3plVGRaWjF6M0E4NVFOR0YvbS8vdWk5WW5NUGhlaW9Q?=
 =?utf-8?B?eDc4VWFPODNTdzMzcjN3cnB6ZnBRNUlNMFQ5SHhlb3V4bzJYb0J2dWhRUHZY?=
 =?utf-8?B?K3FjbXVMS1pZeExsSVN3Tk03VFVxYlFvZU9aYm5qSW5qVjNjNDJYZz09?=
X-Exchange-RoutingPolicyChecked:
	xb+C/5ddutpzKoKnHBxyQ+gD4mhe3Dy+mS7eM7QyvaNv6V0GEwY25bTC6dRXM4vycIz+rnmgbq7t2TrRCpuzS1BTiCk8ZJeeYEJoQESROweBvm7PQvf7uMytxTne9ic76Qel1ndr3SJr83alvzTQ1/AhZ2fGGyxtDn4MI4jnC6hlpOcWAsz4OMRqnocZh6BRNYt9rEDP36qD2WrW+Ei72asxW4E3ZIWx9oc9F6DZg3yBjlRobZbYac+WzABVIMzELxYTnU/Bgaup9dd/adzEtFsY07Sb0Zt6dfi9bWBh1yFrav22myE9XQSu3w6/k4n3eZns39md+TqtAMI8Bw8DOQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898383aa-8e29-4307-2239-08df292bf391
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:14:45.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0DK2Pe8o3yzre6ub4tWVYxpd4au3YkgbZMB2jDU01BwQLiK+De6DH1IxxpjBm1IUgS5AYRK70dsuJxXNzVRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB989571
X-Proofpoint-GUID: kE60PWxUG-MIUI-OQjpB28-DHwZNIFUQ
X-Proofpoint-ORIG-GUID: kE60PWxUG-MIUI-OQjpB28-DHwZNIFUQ
X-Authority-Analysis: v=2.4 cv=avwnmiZV c=1 sm=1 tr=0 ts=6ace2ec8 cx=c_pps
 a=JJStoDgKLvGmSPu1zToK9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=bwh2cWtizcrNWL52cfEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfXzkUQcPj5461Y
 HelI9xQRyfV4V0l4l4IF3kadXCA7aszZ6rTVhWj159tf4cQfJIq+OU4W7t0kKOs6TK+w8GSBGXF
 MlyUzvEdKnoygmSaFTCYe3fqQua7Z02B65D1PSdAjvJrXBABoar5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX8wtsHZN2Y3w1
 Rc5RG3IkDRVS97UyuHDgh5JDjnOj/qxJ9RqVIRDBsDzTeLtVt3TPspZ7lsiLP1ATUX5upmPP8R/
 gevA9zbtdDZgOr2fECMMsFwr+S/ZOIeX08VC2GVK+oEV0FdV+M+4NsT289TrBv3WAFqbk2XTryP
 QiCv3U+ofpUWPXasoCBVi+VjXFWvBICuiWIfnFm6ceM/FiLWDikDEvH/fsMNc6leY758mw8nnad
 +RXTEw3LEflzfhGrKR6Zi4l8hXy3wKDYIV8OsGqxH2olwsfDIwkn0Wh0dTi2QtrHPs9LR3CXbte
 NGbYjtikNziMKnIIE7g0khGcOaFrMT7j4OuSlSjMuzmpfX9pfECaHV6+UF5E2WjoLIaznJN26s2
 njcIhRIaxEqcs41qc5P48bj6CzuldXNAH7alE7TyB2CrtygcVu8HXbdDUg2kop2kJ8ozcj95jRK
 Kp8i3T60SPLqxm74PSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130052

On Fri, 09 Oct 2026 11:43:36 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index 96b365efd1e9..87eade46beb5 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -396,7 +396,7 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>  			indio_dev->channels = ltc2497core_channel;
>  		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
>  	}
> -	/* Only the ltc2499 has a temperature channel; it is the last entry. */
> +	/* Temperature is the last channel entry; trim it for parts without the sensor. */

Hmm. In the last patch you added the above just to change it in the next
patch? Not seeing a reason why the generic comment cannot be added in
the previous. But I'll go even one step further. I would remove it, the
code is very self explanatory to me :)

(maybe Jonathan can actually drop it when applying)

-- 
Nuno Sá <nuno.sa@analog.com>
