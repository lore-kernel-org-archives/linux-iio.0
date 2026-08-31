Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070374B1B56;
	Mon, 31 Aug 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191481; cv=fail; b=ZsUwJLf6f1znk4Urpda97Al0zXS2Xy5i+mpq4eZ9G/exBNQWGUJ3uLXl/vW8f8GQEzO3bLENOp1Mfcu2rJs1mVhg5nA6tuMTD6p7+N6mhiZvQB2ThwPF3c5YuHf0+tKEJ2HW+D/sfOYD/d8DWf4D5Oh4idHAcY0O/PAZLnrFsew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191481; c=relaxed/simple;
	bh=nwulQYG2xAhytWDpmu1RzJIXe9klM/oIULFx69+iGnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CClyF3YFnf+uNsuv9Pk+wd8Tmmc173oN+P+28IoSybJ25VOkXnr8+/FXlAXxMwo7EO2g1We8eet90h9fg2DfZ9JwATIVQInhaNCsNiYSBShbjzGOOWt1BO0F4lstN7WCdCRpGpCSfAvA5qYXRnl8mcp34Hlt/PciST2/R0rU6j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=etJFX7w8; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="etJFX7w8"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VFn5J12184901;
	Mon, 31 Aug 2026 11:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2azuv
	9hZ1Go18GK3/rQi7kw79kMoVeOPd1kk8MjJUPY=; b=etJFX7w8wuUR/ecI4x8u/
	yJvPwcYtg999fbGPqpU2g85VAsmG8FQco8k1VdpcirURL/VzaQxoYTIKYATv5aFG
	AIvZ6JxFpUwjNsbcIUcKoXJFzR14hN6Aopee/GjX6hjhcSExNtobgcyommOJiRLw
	ttPdOse9+8V1gHMAD5BNEA/Ms6BfJ6tOmLCK5AenpXrY5WDRS+zc5/IjTdB5MLNL
	ic4Q7f/V00nyJKmD8lMmabhs+/CJPJQjnaETB0JhEBPTe5N5pVvVupUlI+fO3S5h
	Bfj3q6gFXYNc3oF2OnXIKm7UlR7WiNj13VxowXM/9VOHnvje/O3FzuBYGPNXVK6H
	A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbs910k06-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:50:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnZS9P/p5OPbo/LqwkkhgUztesi1l/IbdncVp8vDPCAHQH2hBEknYKSLu+gxuiLkz9qAbeXOP5qyg2Venbm5R6UAhXBWTek7ty9DGEpq4cSmAUQWqS/khZUnwl7Eh1AlJ1otQJi0Eg9lcfMwawTMDjZWItLGxE8vBdYls6RD+kW4U5UWbeMN6QPGSqbZWkODFJFAKgbMtIj9YXEVscZjVEyPGVWtzXcavN46ScC0y2SPmBuQ25JtTyqhE5IAfHAtIBcBRE45MQhkghdjCzSwzosm2+l5D4y2F4vVI54+hiOiS7NpAakdz0v1UZPqnrz69XSyQTHHHxuhKC8UXn6WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2azuv9hZ1Go18GK3/rQi7kw79kMoVeOPd1kk8MjJUPY=;
 b=xP5a7P2OqEFpiMnY3pH6Rg0uL8SJkvYyQNcx6sJwjzabMzVc8RxZr0pBOsg9ks/b8r+7OviuW6EeELL9d1Cmfqfp0LT5gvHGDFjUVYHR4I/qhwtlz9xL37KvmkvtSuFne3Njm1Qi1gH5iwqMM22452utGpWtZhSWYJocUPXDeF5eUoVBJgeTdaYZoudyPBMDgvtXgktpL0MnSCK4xR70oUoUmovblI2cFkCfcr4z3F/XgaThXGCH0c8ND7zY+aNf8tCavdmB6+69Lpn7m8+FJisuo7WiDGCuWwicZmRIL8rsxDoQD9TCY4gMvbPDia79vY3vhzlAh1JBOp/YQpKS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS6PR03MB989093.namprd03.prod.outlook.com (2603:10b6:8:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:50:35 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:50:35 +0000
Date: Mon, 31 Aug 2026 16:51:48 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <apWi5DuyoORGfdml@nsa>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <apWGqZPhC6wCuakp@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apWGqZPhC6wCuakp@ashevche-desk.local>
X-ClientProxiedBy: MR1P264CA0078.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::24) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS6PR03MB989093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1b84b7-ee25-4d79-7752-08df0777988b
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 woAX/20XIKpfHWpbH4m1FBHu0fbaJIQmK2lO/JMjS3LpmFWmwG2LObVHP9hs3D4gt8tQQNjatw/az/xw/RlQfA9dVFvJOTkmJ7vfD0L1dOMY3bfCoXFJgMKX70/b/SAEDWgEZy/TxkyvSUcbrsX6AZlt6hrxYgl/nslcYKYM6V5pz8PEPU0HbidAyeryHe/Hv05LhmqzA+uEn/FH7aGBbvxDmImYllDA1KSHc4dJWH+VxeBaiu+/w5Y2QQEtDivm52KfxFMmehVI16q1jcMde3vXsusKOIF3Bu1yII4d+scqAWTqOcyd/hX6xxgw/osbPOEBhWX1z1qYWekNqV7goNAqxkxjiV/KPSRH6gbbpjF+qsPwzltnB0hNpk/mZ1FifY2c21g8l0tT6FSujCGtqKAzqAIdDjPO46UzM1bvSRTdcm46lyBYDfUVt4sZBGCDZHg7Sa5cSoMnMudbiuCmrynjJNoFrf2QxkjAQJZDd5HT8OID2uxfo+ERA++Hcmnew2PfQXKCXwhyhkXQBxWkCY9OCPcSXdVeDXSinYMfMC+qxzShYEWXxo2NY8T5jPvY0hNzJ1kzppqgYCMFBAZdWGsGX3xOVPE33soZjYssuLZkcXac/EfKWWfEjymP+f19bDcEBPmZuP9nEwy3/rZkRwACz0XFwnhXR1S9ML56DXY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UXhGaU95TVU5WXAwOGtrakdydTVNZ2xmM2ZwY25GbHB3d2NTSUpBbVdXV0t2?=
 =?utf-8?B?amZ4YW5EY3RqSTYyZmtPZENFNEFTMVdpd0grNElzOUYzeExqNlN1Vmc3UXdt?=
 =?utf-8?B?MndkcGZHT3VNOU43dENFbU52dVlGUGJzSW92dmtFV3BJZUpyMVgxNDIxaytr?=
 =?utf-8?B?STNDVE56KzhNK1JxWXZ4cEdBNGRRaHplVnZrYjYxU1NxTEFrbFRRc2ZQd0Nj?=
 =?utf-8?B?dm50R1VvNUJqYmNtL1JWZDhYN1EwZFZGR1JDMThrT1c3NVMxaXRkY0w5UUlw?=
 =?utf-8?B?QWsrZk85NEZMa1FRUWF6TmJqV0Z2TmVaaHc1K25UY2UwY1IxKzBrRitjOTZR?=
 =?utf-8?B?WkQxcnFtbTVIQ1RqMkJoSUdWTVh6dUJDUzUvYzNYOGs3eEV2MDJOeUJOWnkw?=
 =?utf-8?B?NnlMTTkxcUxLTnJnbStCR1M3K2pjS0lYdldtVHRLV2V2VE5WMVdMamhubkV5?=
 =?utf-8?B?bWRjNVdtOERsUG5CL1Irc0M1ck9YejgxckpxNTNjN2ZrMHFLQ0ZYQ1hxR1hr?=
 =?utf-8?B?VG1DbTlqU1R3RTdIZk9EU2owT2pVdkc2OFUyVloxV2RMSkdBYnFYQVBoNWN6?=
 =?utf-8?B?RHRIMlpYNXFSVWxLT3RTWU5vdS94RC94VWdKc3ZzbG1NdzYrY0ZBZ1R3dE9F?=
 =?utf-8?B?K25INzhCNUczb0llak95QUVKeEUzZm9DcktqNWFJU3l4cml0RjBxdnVDQUly?=
 =?utf-8?B?d1kweHF5cjdqekYzaURuNFc3T2pOUTRjRzZ2SG84TXU0WW9vd2I3RG9xeTlT?=
 =?utf-8?B?Q3FuQlk5SEhIU3VER1Qxak1GM0RYM1B2a0s3T2VqVkhsRC9ib3prTjF5dHRZ?=
 =?utf-8?B?RjUwbFVscTNUempSeFhxNnA2MGxKMEZxSVRyZzhwZ2RwTTJva1hxN0N4MEpH?=
 =?utf-8?B?aUVjWlVneWM1RkkrSmRjRzJwekxyalhRSkNwRWlVaXNxS1p1aWdzNHBiaVhu?=
 =?utf-8?B?NE5rNFBzenpJV3k3SCtRdHNDWVU2a1VmclgyU0llNmI1UzIwT1YyRFk3TnJR?=
 =?utf-8?B?cjMxU25CMmRyOWg2elEyMThsbytnbURlNUpocW0vc1o2MTRFMEI1NUJCbytr?=
 =?utf-8?B?TFd2RFFiODM2Wng4S1pCOVNFR0xpREVZc1FCQ1d1cVhJQ0lCQXdzWmkzczBN?=
 =?utf-8?B?TTNPeHplWmt5Q3QzQ1hJQzhLVnd6UnJtUGhNWmhhUWo0VFNQc2svVzhTN2Qw?=
 =?utf-8?B?TEVmQUZ6UjI0aFg5d0psaG5zN0JDTkl6S0JndkJEU3JmSDNreHdqVE5zbS9i?=
 =?utf-8?B?S3RnSkdscjdXTFB3bWNGYlRCa0pTL2FYVXQyS0ZhbDFYb3MyNEEwaE5aeHR1?=
 =?utf-8?B?Ym9uUXluU3pWMXBWOEx5SnBNVzRKWW9jY3JoemFHU0hrbWFOZ0pEaHp1a3JR?=
 =?utf-8?B?UjZpd0trM3F5QUtodXNyaUo2NHcyVWJ2T3RTYWdJSk00VzNTUUEzYjl4bkkx?=
 =?utf-8?B?OEJEU0tPSW5YY00xdmVSSzhrOUErMThDWkp4Ty9keHliR0Z4a0tzbCs1K1lU?=
 =?utf-8?B?aVNFaTk5aXRUM0t2UXpzRXduQVZXNXMxUXZteC9HdHVGaXhoNGZhcENEVDhD?=
 =?utf-8?B?N3BINjQyVFR2Nk9pNEhud1l3bnR2K0NpQU9vUXd4UnB3dnhhV2xXdXRFUjgw?=
 =?utf-8?B?WDhUc2UwaVNkV1FOQzZuUGJrMVNMMEpWTWwrcHFEZ1QxSjg1K0Y0U044NjRh?=
 =?utf-8?B?ekEzdnBscDBLYVhjYW42UFBLa0lrWHpLRUNyOEFNdDBYcjcwdFMvN3VaZFFy?=
 =?utf-8?B?L0Jwd3JNQmVib3lVTkJJSnlRZ0JBaTNFMUo4aWhUVTlVclZ6RThEV2xvK1hS?=
 =?utf-8?B?RTFFRC9DbWhRR3BEMHQwRWpUeUVtWEl3aVZoMXdTRE1YMjhZUyt6U1RrSWNj?=
 =?utf-8?B?b04yLzlHdXFDTll1TlBmNmIwMmxKeUlWY3Vrb3pWbFROVm1pbGxvdjlyOGVx?=
 =?utf-8?B?dStldllycVZBakJ4S09pak1XME4rSkFFMUN3OEoycys3WFp5ZkJXdm1Idkhv?=
 =?utf-8?B?QzNBT0R0M3BqRXIvanIzQ25iR1JTb1hCaVNHRTJBM2VHamw1SEg4K21RamVl?=
 =?utf-8?B?YzMyNHA0bWFibmdqVDRyZHBTcml0UDdyUHR0eWNsRHpKK3NLOWlWWmRiOXpo?=
 =?utf-8?B?RHk5Z2pqZUxYNFIxNWFuYnBhajVkVmpHS0lySXl1SFQ0SXl2d1NqSVk0ODQx?=
 =?utf-8?B?SGVsazBHWHYrU2R5ZkM1VllGNERKUGZVTWptWlFmRXpPU3lBMjViRnFoeVJa?=
 =?utf-8?B?QUF0WmNxM3FYcmltTWFtUVlodzVaWmllMEFLWjZnVzNmSXd5Z2p3MXJaZU9q?=
 =?utf-8?B?SEtrbmw2K1g4c010eWFhYnFjLzlocVVNcXZ3SGdoYUNid3lKUnJJZz09?=
X-Exchange-RoutingPolicyChecked:
	vm7pkbRjTcE4dNv6qyfqvbaks68gN6I4VeWfUD2YQpQ14tpPFW5WwAg+oapfBuUKElJnxykfKVVH8eI6Ft0hQxtZc63T7VbrCBh5AeYnI9VRj9r7bWNL01sYYMExWOX9wTOmDy85Ar6vGLdIcCA2u3HIgJ22lis1ZXvxVLANaMnFWTf0O8QmEZ2YBois1L4AKcZAHXEkY53n0oNnRerq7nHVlKbK1PIBeruQdbVaSDz7S8hDiqSEyeyrGrZ67juDTclUZjt++3hz9B+YyuyHJfCAfR5NoIcUqJDuUHl4mMcAihRNHQ5S8h9f+X1cUKr2nQHpq6UyT5Z5Ut6Le9BdYw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1b84b7-ee25-4d79-7752-08df0777988b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:50:35.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+bE86oNNS+UHblzkr46AGIZvLLCEGqiJD2ce9aJnyOHsqvwIGaqVSXDDdPHeiC9MzRd2wURIrrKmf5CVOJK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR03MB989093
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzNiBTYWx0ZWRfX9ngQOgqy+CR1
 cGkrCLe9k/afVjZTK0r6JKQEVaQoTqqWvzyvJ0LA5eU3axJi1kvc/Cdm1tGCrJS9BNnuwYD51Fk
 Vg93KZxVfDAyVdlyIobkB4lv+4pDRCPB7MXFxH7seRDLGSwDaCfX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzNiBTYWx0ZWRfX7yJT0dISOIra
 O8CmGuOf3KR4xYGgTSNmIjnlEg1UNJiftNs4AQzTDotI9HQCggCDraapOGfsuRnK4lTiJUhdEXZ
 PbqTfGcP76rm+PMHAa7ivGKfIlm6JulrfthCbi4zZrtdDxB0j4wjcQIM0XAIMuEILn6f0I1Cjw9
 J5dVOkhKo/mY6wZAS0zPNUklTZKvPDQr24Jf5k5Dh0sMUDyl/5L0X63k0mNgT9vNGT06oU1CHqw
 j4Jz+yPH8dI+pM3rN7uIcPD9C0dG7HoFVkn/EqcOs3Fw1Q1z4J9388/zEeyo0yzZoQ2MKw4lb+L
 Jsj5mIN9EdRCKxuGXSEpehgEcqieriHCiG6MzD2Ym7cfBlRcLGk+nwv9EDwDnMZ4uKJXy/7LsAd
 XFiFhSviaLigGu+vkH1xE+fRzV2O4SwAmdT/BZzoWzl3Zw1GPmEl0Ut4pK9Yvsx46ZdCICwrlWG
 GdX8zuQcyCJmmJ+cNuw==
X-Proofpoint-GUID: g164bNBsTdYrrXOeJL9sst4LvG8cs5PB
X-Proofpoint-ORIG-GUID: g164bNBsTdYrrXOeJL9sst4LvG8cs5PB
X-Authority-Analysis: v=2.4 cv=c9Cbhx9l c=1 sm=1 tr=0 ts=6a95a2ce cx=c_pps
 a=I468VFW1STRMRX/li1H5LA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=VwQbUJbxAAAA:8 a=DlM_9YKQvuf9OEaYejQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310136

On Mon, Aug 31, 2026 at 04:50:33PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 31, 2026 at 12:46:37PM +0100, Nuno Sá wrote:
> > The DMA engine slave capabilities advertise the supported source and
> > destination bus widths through src_addr_widths / dst_addr_widths. These
> > are plain u32 bitmasks where a set bit's position equals the
> > corresponding enum dma_slave_buswidth value, e.g.
> > DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.
> > 
> > The consequence is that widths of 32 bytes and above cannot be
> > represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> > 32, 64 and 128, which do not fit in a u32. Hardware with wider data
> > paths is becoming common, so add a representation that can express these
> > widths while still using enum dma_slave_buswidth.
> > 
> > This series switches consumers and a small set of producers to the new
> > bus width capabilities, represented by a dma_buswidth_mask_t modeled
> > after dma_cap_mask_t. The legacy dma_device u32 fields are kept for now
> > so the remaining DMA controller drivers can be converted incrementally:
> > dma_async_device_register() folds a legacy-only producer's u32 into the
> > mask, so consumers only ever have to look at the mask.
> > 
> > The new interface lives in include/linux/dma/engine/{types,widthmask}.h
> > rather than in linux/dmaengine.h, so that only its users pay for the
> > linux/bitmap.h include. Every accessor takes a dma_buswidth_mask_t,
> > which means the interface will not change when the legacy fields are
> > eventually dropped.
> > 
> > Once the remaining producers are converted, the legacy dma_device
> > src/dst_addr_widths fields can be removed as a final cleanup.
> > 
> > This issue was discussed before here:
> > 
> > https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/
> 
> Thanks, this version looks like the right approach. I have looked at a couple
> of patches and only the first one needs a bit of work, the rest looks nice!

It does! Once this lands, I do intend to do the same separation for the
caps_mask so that we can drop bitmap from dmaengine.h

- Nuno Sá

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
