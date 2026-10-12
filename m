Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD123A0E99;
	Mon, 12 Oct 2026 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802073; cv=fail; b=kQIJC3zE1zkifdzFyumO3gD+B+5N4Bl1KClr5GwpimoSFUXJj0m7872Tr9cStI/CcP1+0a6qGeagRoUHXut3TZyJ0nzCnxDrN5S1Iv/2+cwBpADmmF17OaIxxjcsmDlzHNIAtkZXG/yCnB8zYaF05qHnE4JDESJdZN1qXVA99U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802073; c=relaxed/simple;
	bh=h8SKwh0tIUF35aNgQLzl1AMTYXGLSLiQAy1xAFauN9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lFxKNI0ZGifVfzQjAXQgUGfMgHNtPIKqfz9gsnYCJb3crxuSFzIRq3QSwQl7mgpkXukDjkZ4G/kPXg1mmF2uOWnBs86HO6GC82DVHkqnw9EecQOILoL7zAWPFC17lFYfsDhGqPfed0eh9yNAIe+PKI+tRPhJi6/KNIIJ5QFMH6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=IseRIu2r; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DcBYPM3a; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="IseRIu2r";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DcBYPM3a"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8NkHq1714098;
	Mon, 12 Oct 2026 06:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=rJ+MkZRS25JnXtHNHoNd0Jf2os7jLhfILOxuZM4M8is=; b=IseRIu2
	rCpjrM5CbLOzXj3Y32hMhOTBMbPvq92T5Cwr8DeF+VtR6CUfuRggklhz9NIC7I3H
	NbxHDB1MZ43mZ+AG1zW066PLeoNAbHa/xwmfv3yKlrLebRUvq9XZg7sKypZABc1s
	HcWOJYlm+xDLByezdlzHNUeZX4lODMzp/EzT2eGCq0csdn8YoHAooAKwKJAjuN2f
	AGvEXY0XlKkqsmDBzDZ56e/b1j47b8QffkqPczHr/31wH+rwo+xPuGqPIuystGKZ
	uw4SjgNIIks86zygBS/I8KHhwVirZaGARNb6p1XgIuxxRnh5eIL+BySsPMpafuZO
	+IVzHMRTDJRAz4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rJ+Mk
	ZRS25JnXtHNHoNd0Jf2os7jLhfILOxuZM4M8is=; b=DcBYPM3amOTWira/vdOJb
	Qkn37N3Ot6DpkTyAW+nKM+idzj2FdS8RkBXeKsZq1Mku/CSjCHiTfeteMBtTNYCo
	+TqeQctNsSJFCzMUv0RBzFe1BBGpolquy/ECSHUR1sGl7TanCxma+RujdduDS2C4
	u1DHKAjAePFuTtawABWSeB5urquYRMgeC4gJ6NucQv6JbPMDUEC9cw1YI8+aHjJ/
	4okNyqwqk01rC7CLSve5xgmAQPo+wv6a1sOdk0rsKd86s4Vcne4Ezy5elIpWHKQ7
	frN5FK+yTCgmjBR5q143yp7O2NbikUS4XjH2uZ/kQEZPRitD8Fc7EBIQApSo0N02
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h8r8mhm9e-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:46:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIOeXhAehWKnrI/sTOPh3GEZxTr5uf5qpbRs3vDahPXDePKtcNa6dDBPvnV1pSF4bwnlC9xAjgh6GB5hIP8jfJhyNiMi8UL73tSMyFSc/K+aKU7cqeM9M4Wsv4zedTciz2QnT2xgAW9FcMk6OyvzpzOEJ49oe8UBpOyFxU1HMU6KPnYZjd5XLfdqGHrPAy11HtGstN2tpqqKCHJvUVM1N4odGKUar0lM7P68sR5i5LPgDufCfJDISngEUhcK2ESw8JxvcCInXhKJDsHq0H2pJcprEOq1hR/xwycUCKU9L/qjpx74KedvqD8scEn3bgnUatH/ANPAZeWMmVbS3+Zeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ+MkZRS25JnXtHNHoNd0Jf2os7jLhfILOxuZM4M8is=;
 b=VbUkRxesl/NYGkgEEkZC1yVLxTl6i78iYe9CxLhlvn3dBJ7UyS+zmcU27Ge0gGaVLzeZ05HRY1H1x+X11rCreUUQL0Rigwjrx+1UubXWeV/jUdKx1TO8qymcNLuUGIOTC6o/FmGk40bf/daXw9uNxqyf4Hp/asweTuEpeIP/gGOpSXgq1suWt7r1V9dElZDDJmGHpCnpOWUq1r/9MRTAHGGz+Uop12HGi8jml7WJ9pHWGVL+CfNwlRLcMw3EwE80oA31YEMKjg7do7kiOz27iEz7iTi0Jy8cxfPyMaS8RTLpjliwX4GS+wa8p7KQCPh3o39RPArSmb1M/2uytyJarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV4PPF7DEB3316E.namprd03.prod.outlook.com (2603:10b6:40f:fc02::210) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:45:58 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 10:45:58 +0000
Date: Mon, 12 Oct 2026 11:47:20 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <asy3ky8r1Cyo8vS9@nsa>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
 <20261009-dmaengine-support-wider-dma-masks-v5-1-4c4e63a7a1af@analog.com>
 <asmmsoNxW-gfugXx@SMW015318>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asmmsoNxW-gfugXx@SMW015318>
X-ClientProxiedBy: MR1P264CA0153.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV4PPF7DEB3316E:EE_
X-MS-Office365-Filtering-Correlation-Id: c60040fa-4ae6-4cda-1217-08df284e0008
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 8JLELdGqexCGMI6WYu+Da3+5/qRj/o7RwoWyc8Re8PUzFzdwnojZgTlPvJxfudBInfUulFpGFg5I13RrxZMf36WI08JTiRZIbGd/Ini9kQeYi9l3ehIQS6ILiEUPqblXKtiLVUt+h0dIt9GmX63mk/Ct0x9GlTa1BwgeosR1Ck5601Mhe80keJPYP7bGMf4JT5cttqwqhDIQSJ79caIFwnr34ZGK90dmgHLbphSFifHvLa8AJQhIoP2iWHxmQV2dIfYgvl4BR7mYSi1+3W50S3wOT/HjLUz2oVkgWAC1SBNGxTEdGxQfmlB2cb2E1THT6Fzuqacee1HM4xVg2jHX/7p5/IgejCHuDbnCL6sjR4Pg6Ul3k1gj9PObRGFWHVPMGpF59JlMYu7wT3wgmvy0qLDWmQy0w4oy7QGBl1542tnA1BKOaYgAEXqchE0AF1r0HfUvwZC2y/Y+Oh3S51MPyDnlwBu5xR1rHueuGiVL7LGJZ9nhj9c9f5LhY/0thJZAEXa95hXPBR9WTsnAbbgJ/IB550bd01HQN/CNUzbLB6LUUEQn1PAo3xOeWBcOO5dwraUFko4wOwif/dngzqQJXszdlR/09mdHGv+5dRctB0XQuSiX+WO/cMvhwdVkdDdMTWI3Zcke2wndFDBZG8xdrFg04J7sYDs3ARhaGN1diM8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?amtRWkdoMmJQd0FESVZFaEVPa1ZZR2JObmxGWnJtUVFiYnRBRmRkcmRidzRP?=
 =?utf-8?B?ZnhXeHM2MzZDdTFmcWFpSmRyUk1BN3JGZ2dyc1UrVGRFQjYrT2twUkRLb1h4?=
 =?utf-8?B?RGlxdldyYmZWVlk3dTJsL0xTTXF0UjY1emxKVlVyTzBJWm0yN0hUU3JGZGxJ?=
 =?utf-8?B?VnN0SS9lb0lJdkVSajROeU0xbHZKTXVsUVQrVTJBNUkxQ05QaVFTSlUwa0Ix?=
 =?utf-8?B?b0ZoeVFsZkZBdFo1RkpIZnA2U3kyZzNjc2sxOHpsVUFZamJ1Y1Zjd0tBL2Fz?=
 =?utf-8?B?cE9TdDJ5VWF2QUh6UTVyb2tKVnovLys3SHNkeHNCK0w4eUVIMTYrdnFBalNk?=
 =?utf-8?B?bGVIRW9jb1AxTDhYenZzMVl2aFMxTjkyZXJMa2NhK29mVXlJVklHODFlSDRK?=
 =?utf-8?B?T1VtSjlLWVkzMmtvQVE0bmlXY0FtT3kxdGc1R3BsTTJ0dlJxL2FNYjY3Y29z?=
 =?utf-8?B?MzR1VFYyQ1NRQkZDT1lBaEhlWFV4ZTQ5Mjk3MWsxdUhhWCtPUWFXT2xQL0VP?=
 =?utf-8?B?c1VUT2hKY25mSGQrS3JRZUVFNmRzUzROQUJtNXJPMjM1QTczKzlRTXFJZDZV?=
 =?utf-8?B?U0JoZDEzWG9ZZzVTSml4UVRkeVYwdWxKMHdBd3VsYjFxeWJ1ZUpiZ0xKeERK?=
 =?utf-8?B?RUJxQysrZWFsQ0twRzl1dUJQclhqK3pkVjJUMklsWjVveFM2eUJHSk1jUTEz?=
 =?utf-8?B?RS95c2drMm5WaldTWWU0NU42ZVErWDV3S0NoaExTalh3T05abmRJSzFyR0Jz?=
 =?utf-8?B?VTlobWdvbkVzb09pdVRLTHJHdDdCNEVLbkpYTEdsRnVWMmxwMzVJRVdiQ0pE?=
 =?utf-8?B?SDYyMWVNK0dsRGZrbzBnTVVqQVdtRjRLZ2xjbUIxcTNjNVJnWnh2VWJ1UEpz?=
 =?utf-8?B?eW05dTd6WHdYK1UyaTNiQU5oTUdZNDgyVUdvSDYyQVhRWHVjVGZGVURSM0h1?=
 =?utf-8?B?eTdCRnJ0VjJNV3JNU2JDZ01nWEZYR25DYytoNmZkNGVEZy9SYmswbFUyblNk?=
 =?utf-8?B?eFQvbmVSLytCZVFYbWh3RGk5SzlxRENJZzBuME12YktPeGh0aXJxV0M4UUJt?=
 =?utf-8?B?YitFd3NabmpBSy9jamhBdUVYbnJQMzhZU1NRRkloaVdYU1NYSUQ2dzZneFdY?=
 =?utf-8?B?TmdkbkF6ZHBuN05Hb0FMb3FBS1lPTkVqbTBpN1dHNVFVYy9hNWRIT1gvd3JR?=
 =?utf-8?B?Vkt0V3h5TDdpNjdLZkFiTms1L1ZpVmw4ZWpzLzZSZTNRbE9lV2hzc1psTDBt?=
 =?utf-8?B?UHFYYndIeTVtcHdva2ZQdU51enhZVFNRMDhkUUhiTFVndXdOaVB6VjJrZkls?=
 =?utf-8?B?QzEwbnNkeVJKQ0o4UlVNWUhPTWhHL0syUFAxd1p0eldaaEVOZGNEbVZDZmVo?=
 =?utf-8?B?U1lPOXV6a1M1U2hPV0FBN0xSMkV6dVpyNzlDcGJFZjhwa2wxUGlYODhoZTZS?=
 =?utf-8?B?OUNJZ2xXUGNOTG9wRFZsQU9RVXMrQ01SR0M3Vkk5VG1tTy9KUDdLNHhvQVM5?=
 =?utf-8?B?UUVRYnpUUXREZVMraS93UmRPV3EvTXJwUnYwUG9EUjZ1SlpaZDNxZWh1Uk9k?=
 =?utf-8?B?cFlpVUJOMzRyQ2p4VVZKa21xbG1JN0xvdkwxdFArVFZscWw3NjZwNEd5NHEx?=
 =?utf-8?B?R3o0amZCWmlXTFFWMHczM3J3cmtWQURPOTUwM3pjOUgrcklyQW1Tb0wxajhP?=
 =?utf-8?B?MFFsaEF4TWU2L2hUSTdFakZyUE5ZU0JpZW1SMTdYMzM4NEtpNmt2VmVYbEVl?=
 =?utf-8?B?Z1N1S0QwYVhJU2xHeFl4eDVwK0VhZmRickJ3NkhhSEhSSE5VOVNHZkNTeXJD?=
 =?utf-8?B?MXNWTlFkMWhMN05Bd3JVTlpxU3RreXdRQlU1Skt6a1o0cmZJY1pXaVpRdGUx?=
 =?utf-8?B?MllTbm1UWkhTWHBOQXFpWEw5R2FUVm90em96eFJ4RXplN2NPRmcvT3llTVh5?=
 =?utf-8?B?Z3Z3eitGNWRqMUsrVFBhWFh2TllmSktUMmQrNnptUVpDU0hOMTFhWEsxZEJM?=
 =?utf-8?B?S0xTa3hkWWR6aW5ONGhFenVWVTdwMVJTdTl0SjFlbWxmeXZQbmFQYUdsTENP?=
 =?utf-8?B?cHptQjltbUYzTGoyb0F6SFpPUU5hbkdKWmFhYXNsWVpZM2Z2Snk2T3hXWFRv?=
 =?utf-8?B?TmRtbmFPaUFNaWg2OVFPNjdycVdleW9ubTRHL2xBcElST3lVaEh6NFJjNHJk?=
 =?utf-8?B?RTl3Y25JeTVvKzkwTW4zSTdWMHdIN3pUalZTdXZ3WGFCYWNSNUI4bjJVd3kr?=
 =?utf-8?B?K1BGV3JQV0E1d3JXRTJvQ1JmS2lSeDFKSGZCaWgxdDBHRW5jS0pNaE03YU4w?=
 =?utf-8?B?QVNGQlozK2pGRXJta1N2UFVLUy9VMCtjTkNET0ZmQUhlcDE5MHhyZz09?=
X-Exchange-RoutingPolicyChecked:
	Mj2WHhyiPsLMAR3/VcTMOadhckF7uvU4s24smfvSagqUvrh1h64MeUKndtEuprkhzyQ9V+YtxMBQ+KITqGMZDR0abT0CuqIlbO8bubzuC+JM5PJCvRzggJ0GwbyBVJN0vgx110TIA9j2YqvhfA2RIfQom85XFjOIO0FTIpVuRb2Z0EXb2ZRmqpCHJxv3pmodhMco7JQec/7Pjfip5QypdAMHIkD6cRdvSnzBiJYAK4HgyRu3xFytgUg2n+N2beO/tZzpoeE6eOZIqfjzjEoixtj8npnevi0e/Qt+5W3W/RnIzokf46nVqwm6526ZB/Bbmy+SlvQV7APW+kwsfwbeKQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60040fa-4ae6-4cda-1217-08df284e0008
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:45:58.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DENgN8GcjjMGuB4gN7QJI4m1KphW25qU5MQtimvtqDKxJY3tLt496/UDvJBgG2EndlFELULlS6mab0jaRYuyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPF7DEB3316E
X-Authority-Analysis: v=2.4 cv=XudvqlF9 c=1 sm=1 tr=0 ts=6accba69 cx=c_pps
 a=uYXQfM3GD41LpGGBCGkGnQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=QYabyLya7rksitipNSUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4cLfFeQabC8x8qzCe7EBqsPf5OVoSM0a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX1HADpQBu66IX
 aZw38zKyFailxFqfPypXXqMXS97c/qwrKjDErQZOMWs2RLNCBfoylpoSdfPHb2Y1Cz/0Ulqkapj
 2Blx6SfNOJqKelrBEVyqncuqbZMdlUUiMMk4cNXVomYkuSRp7JFH
X-Proofpoint-GUID: 4cLfFeQabC8x8qzCe7EBqsPf5OVoSM0a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX9aYEU6kcUipb
 A6lv8/g7VGmgov0yKFAh75n6c6OChY4alLtrzHF7xuVKDVHx3CZQ66JEXh3Jqv1qPKZ6lxjkCFd
 Fenozy0huoqSDQaSlWvqdiElTZnh85DhaGgi5AoRkBWj4hxH6jNZ0hdmZ2vD91tl0yus+GImcEL
 H7xSK7f4XajdFNjByL+FT7+LctJ6wn1K7YLXx30wUWIGdDXmpcO1k64XFfJkWe5PkPQlQy0Ky1Q
 uSd/h+fcfGG2wBwaQDHksKgD+GtHVVk2F0/T0uibrX/51G9I31WjUr+zWOtrklGZ3kezJn9i1Ih
 tfz2ZfWly6k1m6or95owj0B+ij9Psj6rZD4VUUYJhQEFdQ2X/xaneZAJ1ubj7F0KrAEhUpzZWeX
 LegJvKpiZxt8U+KmhSVpnozP/cACCZS1ER6iCVOFvnP6LtWuawVRTSi2/D16bQ4EydB9fCWqfyx
 LExElHJoYn4m7PMCxEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120042

On Fri, Oct 09, 2026 at 09:45:06PM -0500, Frank Li wrote:
> On Fri, Oct 09, 2026 at 04:52:53PM +0100, Nuno Sá wrote:
> > The src_addr_widths and dst_addr_widths capability masks encode each
> > supported width as a bit whose position equals the corresponding
> > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > 4). As these masks are plain u32, widths of 32 bytes and above
> > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > be represented at all.
> >
> > Introduce bitmap-based bus width capabilities that span the full enum
> > range, through a new dma_buswidth_mask_t type modeled after
> > dma_cap_mask_t. To allow DMA controller drivers to be converted
> > incrementally, the legacy dma_device u32 fields are kept alongside the
> > new masks and the core folds a legacy-only driver's u32 into the mask
> > when the device is registered, so consumers only ever have to look at
> > the mask.
> >
> > The fold is bidirectional while both representations coexist. A driver
> > that only fills in the legacy u32 gets its mask derived from it, so the
> > consumers already converted see it. A driver that only fills in the mask
> > gets its legacy u32 derived from the mask, so the consumers not
> > converted yet, which read the legacy dma_slave_caps fields, keep working.
> >
> > On top of that, dma_get_slave_caps() derives the legacy dma_slave_caps
> > masks from the new ones when a device_caps() callback adjusted them, so
> > that a converted controller narrowing its per-channel capabilities is
> > still seen by the consumers not converted yet, while a driver adjusting
> > the legacy masks directly keeps working.
> >
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> >
> > ---
> >
> > Andy, did not take your tag given that you're the one asking for the
> > split and since we ended up not doing it, not sure if the tag is
> > to be kept :)
> > ---
> >  drivers/dma/dmaengine.c   |  51 +++++++++++-
> >  include/linux/dmaengine.h | 208 +++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 246 insertions(+), 13 deletions(-)
> >
> ...
> >
> >  	/* note: this only matters in the
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 71cde09ff240..eb68eea840b5 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -427,8 +427,179 @@ enum dma_slave_buswidth {
> >  	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
> >  	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> >  	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> > +	DMA_SLAVE_BUSWIDTH_MAX
> >  };
> >
> ...
> > +/**
> > + * dma_bus_width_min - get the smallest bus width of a bus width mask
> > + * @mask: bus width mask
> > + *
> > + * Return: the smallest bus width set in @mask, or
> > + * %DMA_SLAVE_BUSWIDTH_UNDEFINED if @mask is empty.
> > + */
> > +#define dma_bus_width_min(mask) __dma_bus_width_min(&(mask))
> > +
> 
> We are working on make dma_device private. New API avoid direct use
> dma_device field.
> 
> pass down dma_chan point, dma engine handle everything in core part.

Not sure I follow the above. All the API's work directly on
dma_buswidth_mask_t and never touch dma_device. Now, consumers should
use this API through struct dma_slave_caps while provider's
(drivers/dma) should be able to use the private struct?

Other thing that came to mind that I can do in v6 is that APIs that
change the mask like:

dma_bus_width_clear()
dma_bus_width_set_many()
dma_bus_width_set()

Should be safely made private? I mean my expectation is that only
controllers know (can) act of the bitmap so don't think there's any
usecase where it makes sense to have API's like the above on the
consumer side of things?

> 
> > +static inline void __dma_bus_width_copy(dma_buswidth_mask_t *dst,
> > +					const dma_buswidth_mask_t *src)
> > +{
> > +	bitmap_copy(dst->bits, src->bits, DMA_SLAVE_BUSWIDTH_MAX);
> > +}
> > +
> > +/**
> > + * dma_bus_width_copy - copy a bus width mask
> > + * @dst: bus width mask to copy to
> > + * @src: bus width mask to copy from
> > + */
> > +#define dma_bus_width_copy(dst, src) __dma_bus_width_copy(&(dst), &(src))
> > +
> > +static inline bool __dma_bus_width_and(dma_buswidth_mask_t *dst,
> > +				       const dma_buswidth_mask_t *src1,
> > +				       const dma_buswidth_mask_t *src2)
> > +{
> > +	return bitmap_and(dst->bits, src1->bits, src2->bits,
> > +			  DMA_SLAVE_BUSWIDTH_MAX);
> > +}
> > +
> > +/**
> > + * dma_bus_width_and - intersect two bus width masks
> > + * @dst: bus width mask to store the result in
> > + * @src1: first bus width mask
> > + * @src2: second bus width mask
> > + *
> > + * Return: true if @dst has at least one bus width set, false otherwise.
> > + */
> > +#define dma_bus_width_and(dst, src1, src2) \
> > +	__dma_bus_width_and(&(dst), &(src1), &(src2))
> > +
> 
> One thing I forget, new API should start from dmaengine_.
> 

Noted!

- Nuno Sá

> Frank
