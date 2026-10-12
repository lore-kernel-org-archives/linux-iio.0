Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3CF47DD51;
	Mon, 12 Oct 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815664; cv=fail; b=h93sH49TwHe1xmG+Fz/QHDz6krhiPH46ujIgal5Qg6BQQ1dzz4lCyG8V8y+J8zkmq4V/sy7o9Z1MVRAcD0vOiCxF+FavtIXlpjLMaO16f1PhwKzx6+8FWlDDwEOvyQc8imFBbmTg2LzKDyqq90pDvjJviwc/mINir/duJtDKQSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815664; c=relaxed/simple;
	bh=HCjvzL+RUpbGZVHIc2JB4erCkPa4wB/0sSLxzPE5cRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tIIe2sodc5/XrIzWZcFgnda7csI9wjBIYoQPtUqwQ3XSjnRi/S75bKbFaHX/aC3Jw29+MEmjWcPDtX8GR8rg3olzukWeaXHvwj84WOcYipM8a1xoQrQyk4oIU7F7TzU+5D7im3iMufttcgVP2nJ7nRODo/ec0+q8+5OMJ2bPqyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=r6eLAaOw; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZwoEIAHH; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="r6eLAaOw";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZwoEIAHH"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CDtZJa1795323;
	Mon, 12 Oct 2026 10:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=AulEWHHe8qgszgIT9jFaZDH8L1UDOKIvpscEKLXJkjs=; b=r6eLAaO
	w29DY2SFkyba3JH5p9xD4jjXqMakj2F+MzSUjy8/GzKN/H1Lj7XzHZJOF1RI0zVm
	NfZc19emK7o4/ZvdBlHyVtfgn0d5bU5AkIIG9s2Mo9fUZrn0IAZzIcD1EkaWBZVJ
	P/HHfkMM18kf4GQTJ6STgcQdXQbpaUChznMJ6ZDbqNjSQVDmDji78cIiyTQT1LZ9
	j+xH/11SEk+DjH4Ne2Bdx/IKy6pH0gb91eCaHIR3lCFT1BmwHebsNuUv0/jU8SRn
	pdEEIwg2nN4rJ4sHgx9Sy8ZfzVwl8fOOC/e82NoiRfkjPeCJW0nKLosMPAKJLnpU
	XNkjsmkD6lrSBcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AulEW
	HHe8qgszgIT9jFaZDH8L1UDOKIvpscEKLXJkjs=; b=ZwoEIAHH8tJB2/J0LkBiI
	GPCX7r5Z42ZG87xaaAWWn78CYBBQE/f8Dbl1mTtW0UZRe3nh9prRUWVc186LOmce
	MmQwsHZHeYAkuvEjBs1zZ67H4TdsppzJA5HCvGe//VO+mfpm0bySi8jLjZ+4Z6wX
	NUQg7kW4o1bwZrGzlKqXC8KlWnrJrpXpBSSlJDZtWHPsJPyTcKdKrC/gdRRlaQaL
	d8CXdQClSSKsygwt69Ch9Z10ZxbF4pKddOkib/S3oa8X3X0c9/ZqFA/s2SOtBBmV
	pINJP3HrfrV2ugLQ42z0os5l5rRmp2biHXVfEOWUwbLmEOD/e7KbEO2WqyfOR8Rt
	Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h90v5867k-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:34:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0sQlbsvdtOS2naTY3Q4xnYQT3cyiTVD8Q+itMrTtd/OS5LlgdAD12IkTRlJ64XLV24fn82+xDHXqz6lu0ZEYCODSG+igB9iC0h1l+3fZJ4wAEPRHdsnLL3oAiKarVGFtK5c2bxNIjVuqKScSvqwxJbfKrwyCiCAG1Eb49w86JE4OsA/1Pooi0QULc6IASf6rfwDXzDKQpWdXVoDg5gmzX4kjM/V9Vvr/hJtX7lcg+C6y6wNCD2BvEjfRVE5MFYT3w4pnuUXXaVhhPW34LHI8f83yMsVs2ZtjPrbf64cKOyH/2bcR1R1ttvwSRpTpng+nlgz5gvGX6I+Y31FfYfB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AulEWHHe8qgszgIT9jFaZDH8L1UDOKIvpscEKLXJkjs=;
 b=tqMqNLAzSOAQm8GaKGAPEYYtaWnLCvlJEu97668lS5fX/Cji0Tzsnnt3UMQp/JESxErGfGrllTSzz2FTw7ramxfLpDc3pZExbx9HcriZWAh10Ku6dly6y9wqlEq9YmGZXOmROVKH22l+gyIwGheIwfHTCnSHzqN0a0glgkOardfexpgfdbPdm3pukEANpr1k+BHQ6rP1V9MLWIe7ahxLKrXq+eAH/D3hbVwDkOlf1wdBoCiWhujnjH96JCaD6DJANSzKXan/QpLSHW9SiYqOn1zmY88uN4cOVLpYFkb1uQ+6LoNSQVUJEEEi2S7PJ2pyw1LkN7WqRa4aZs9HiFy30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BL1PR03MB6165.namprd03.prod.outlook.com (2603:10b6:208:30b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 12 Oct
 2026 14:34:13 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 14:34:10 +0000
Date: Mon, 12 Oct 2026 15:35:30 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: raffaele.tranfaglia@gmail.com
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: use dev_err_probe() for
 ldac GPIO
Message-ID: <aszvaazebS2NISxS@nsa>
References: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
X-ClientProxiedBy: MR1P264CA0095.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::34) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BL1PR03MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 693ecef8-6f1a-4aed-689c-08df286de0c3
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 FLRtrdl0XrMRovGTyHyBaEUXztcHDY2hS/zDrE0cklCM/vJcQO+K6roF1CGsPjmEdCZoFD0WhOkJA3oRRvoOmWkTU/or5zhFnYeacHkeMvDzFnHt7mArJKa4xG9Q9Sud+l2P0Y/1IO4eXM+93sejg+ClJKxdR5cgz7rTS6dhvd3D3DyVHQV2zu3t0l+srYYqlX4MnGB3XCSVygXp58qnQAbgg+e5anNVpmkyyt7vj3ncvGvzYimACdO4f8gm85gAkB7UECMfGrpsUwzmUbyBO6WmzcE1lnv1SbAWymAQx9QZxvhCxmA8f3vA8GatQ233m1MZg9Xj6MPOSQEWg2T+uLgsBEHAWA9jsFAVRWeF+e+ykYR7dZmJ4HDs+tEmWjRdg6FI/bYhCwOIFFr9XX5Q4OZVzsG3FucVY3KXv61HWH4109j8PC6HprWY/TsS5QeJp0dbmrkLLOAp7TFtKyq912IM8/CsR6WPWlHThzKh9wprT32rQNFVL912/NNI0Nvwkl1K8+uE/jK562VMYqoCb3uvswm5PZIt2EQqls+blk268ex8ekjAQbZYfMoCgozukFmBOvTSFnBE2YcYwXl4sBi+4H5KAEsZ1hhOgAab25fvocoX7WBGht9+DxB3c3JBO5kATBF7TCDJ1xp+heSjYkJmIuU7wE1LtjnusIq51CY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R2VlTTJvZS9zbXNQYnpEU1EwMHVRamMyYTdFT3hrT3lNdjZsYTBNK05TcGx4?=
 =?utf-8?B?TGxyZUhZWVVOcXhYbDFTa0xGeWRmamR6c21yV2RTSzY0N3p0YVdQS0k0UEw3?=
 =?utf-8?B?UWM1SkNmc0kzM1F6RVlLU1VydFhtTUpDY2Qrek5PdlRtNkFmTURjWGx5UDNB?=
 =?utf-8?B?Snl2UDRaMzVzQjYwYVNRNU1KeWVOaFU1ZDMxU3VvS3FLZHIyN2NyYzlIUTFk?=
 =?utf-8?B?cmlZc1BvRlVxT0xtdkhXKzR4MklzVERRbjBwcGE5eHE3ajk5b3JWYVFqMXky?=
 =?utf-8?B?ZzY3R3pHMk9PL28ybEs3bmNkSlZvY1pvQU9nN1U5UzJtMjk5WkREcXVNWkFE?=
 =?utf-8?B?ZklxL0w2dGNKMUlWUFg1QmxhcllaK2Exd1NZWGo2aXNCaXpTTmxwRnp2S29z?=
 =?utf-8?B?VDZxUWhSeGtBbW1PK2xhZUlWT3RLcEtwSnRxVmZKcUZUL2FrdDlZNzUrQnpP?=
 =?utf-8?B?c0Rnd2xrNG9WMzBqSU9uMEo3RTYvRGxhckdzcmNkb3d0U0JXUmxMcHgvaGR2?=
 =?utf-8?B?VWVCSUxMNW9Md25jY2FsVFV2MTh2R0I5QWZVMHNMWDlyUE8xcnNEMWllMlZ3?=
 =?utf-8?B?UllENUpvWm1kSXJtRlhXRjRjUk9wRVlCWnZmMHVETWxOeGlOck94SE9wZ29s?=
 =?utf-8?B?KzNLMDhPcEk0RHJsSkRQQmxzK1haK3d3NHdKZkF2R1JzQmdMNzhDNlBIck9T?=
 =?utf-8?B?QUtka0hnWHg4N3hMZHE3RnY0QVNkQkQ1SXNvUHJaL0VyU1NpcW1LamRmMnJX?=
 =?utf-8?B?TmtoNlVhd1hXa3pJRFNRUEs5enI3UFhRUnA5Ulp5RHVWS3c2MUtxb1h1Rkt5?=
 =?utf-8?B?OXNxM1NTRUtDMHBVcWFVSzBES3JKa3hDZDR6MWwrMU56MWUwMTJtU2NTdzJj?=
 =?utf-8?B?cVZDNExIbWIzV2RIdXcyTGdNNE5JK1NyVmVEdWRDUW1aU0JJQkZtWlB4ZXN2?=
 =?utf-8?B?dzVKS1NsbFM0Y0VURXRpQVAwOG5lTjZ3MzdMZGxWMEh3WVE1WGttMDR2eEhI?=
 =?utf-8?B?WFhadmROU3hVbzh4NFg3bzZCRkFGamcxelBDSUlQK2IwQVVaeVNNV3diWE1k?=
 =?utf-8?B?VzZ3Zm1PMmh1akEwejhmeCtsZVhKeEpuTFBGa2w1emQyNVdtL3M5d2lYSU5G?=
 =?utf-8?B?SCtiSUtiRVVrekllMFcvMFB0anVNampWM1ZXbGp1T1FudWtJMHlYbk5GOUYy?=
 =?utf-8?B?bDFEQXZTZ3ZyZVNXNTdyRHVKc05tdVFZc0VjZWVLZzMxU1Aya1JjSmNzdGxq?=
 =?utf-8?B?WGFiVUxtTC93RFp5RzRQZXpjUVZtbWhYeVhqbmY3TEhTYW1TY2tud1B2ekxi?=
 =?utf-8?B?TTZJUGpwTHFSN3V6dEJrUVQ2YnhYeVRWK1grenVpNytQbWFSanUxQlp2R25p?=
 =?utf-8?B?Z2ltRDJoeHBlK1FDRGdoSHFqYmtRT3FJRnB6ODlEUk9rcTNGQ3lQRVk0U1U4?=
 =?utf-8?B?aUs3NkR5VFJDNG5sWXozSW54dFozVktmU05iaVlsTWx1OWE4NFFGMk1yV3R2?=
 =?utf-8?B?M0VkM3g4dWZwNTZad0RmU2xoRkNDanBQS2hHNi93cnJOTWFZV20zRmJmbnZ2?=
 =?utf-8?B?YllvdXN6Zm9hRGlZL0NWUDYyS0E3K2ZHaFU5NDFSL2JwOEUxbEZyYk4xK3h1?=
 =?utf-8?B?TVIrbDBweGNIT2JXd2haNjN2SzEvNEhDRkN4SmZQVXBGL1F0NGxVaW5mcERJ?=
 =?utf-8?B?dFlTeDgrZ1JKU296akorSkN5eTZjNlJCSzZ5NU9DczRpb3kzc0ZWVG8rbGhS?=
 =?utf-8?B?Q0djZWtBdncxUXFmNjJIUi92WDdXdFozTm9zajhHTGtmdWdrc2ZDUUwyK3do?=
 =?utf-8?B?dXM1c2kxS0ZicmFOSG9NRVdpTEsvUTN6S2tRam5uRDVOa2dxMmFRRFIwVlFn?=
 =?utf-8?B?Ly8yQW1Md1pWMEFGUGJnVnFxMm5jakpBdU9pUy9IRFdVc1g1aTh3ZG1RZWYw?=
 =?utf-8?B?SEVjVDNOR2ZHbTMyVytnVEFjWTlBalphV1JnWlUwaW9DR2pMdTkxSnNjc1hV?=
 =?utf-8?B?Slg0eXhoSmMwc0NvcmNTZ0ozQ3Z2Nkc0UERocklvUzc4NmZScE9mTkpvTGtH?=
 =?utf-8?B?cXdIalZWR3c5MFoxVXdmQUZIaFB2SUd3b0pIdmtuanExV1NSQURCVmZTZm1L?=
 =?utf-8?B?SFdBOHNwV05hRGRVdnEvdEx4eTNWYU81NUlQU1dwQ3FMaXFiTlpzNUVxdG5C?=
 =?utf-8?B?TE14eHNwUjhYNTFMSUlEZTBEZWVKVHc2Q1NCR1FFYlpaM2l5WEFxWTdWOGN3?=
 =?utf-8?B?V0lKSFhrQWZXL3hZRmhhNVE0M0JxbVZnQTN3b3NXTTE2bWpQZWhKOWtOOUNK?=
 =?utf-8?B?OUg5WjhFdEk3QmZleWowS2V2ZENHQ1U5dFVDUlh5UkdUZ0Nnc1Nqdz09?=
X-Exchange-RoutingPolicyChecked:
	GjJGF5O9Wd9CzbJ+dfloEEVjJyzEB+fZRURNqm5n76HYy9MXU7D1nF+upwdqC7IUkmTeaPlT7QVwxpvPr31falzgftu8LYAGotvYVLxopgU88/0E2p1jNVrlbBGy9SWEJCODZP5nMNn05f480g2y+4UzUio+45Iuzj0D3Fic4xDYwjUsBUGDd2NFHRuMiWzvZ6+RoW1TbpE1icCQiL/mjOW7WRsH9DCzSnGW7+C2hqS1+jgT12ciIco7Nlj4MZdLXgHoJ1NIhM/yvlG1U5Hh96x8JGZxK+v2soi3bNx/aiaX6d2IKlIv2MAW3W5nLd9bOQgvZmMNm5t0qHPnSkzahg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693ecef8-6f1a-4aed-689c-08df286de0c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:34:10.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xVKIizNjeK/FbBExDAbafyVRDGxDKYJOE0KiLU5tM+VI/SmQ4KEwVAqN3GEZzjuHk7zhXo1nbqqVjtovSqaqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6165
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NyBTYWx0ZWRfX5LzvYdKj0l+i
 H+4PfQlu7jfT+Oe1OIcM09FoIjPIFrFUqPSYgo/xuPgEjJWm7/kRDEpoWBN9OzZ5VAqj2u2E2l8
 Z8RIRCWA6lHXDl+GZuNVobO/FUhV4jc+k17T9KI42Q5uXpM8VVu/
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NyBTYWx0ZWRfX/jld56aw06ZS
 a41EU8agnZUhyxpAbk+6h0pF/EviI8Bn9RtAf/EBBKp0S0ce9hD6s20O8DQDkvaTttrP+GnnjCn
 4qgY0itn1qpO69p/qlLN31lPNLSIGeuOhNe0TahhXEnr/VH+cdX2a2FKioDtE0beOosQeFeeiAK
 0GEZBPqxZzpIeSijfvuLxGOs8Kedwp1Jkpc91CLcM+MyejJYRwnlIAGxe14U4NpyB+2fvDYvro1
 vX9hb/t7pQW+t5A6nYcnDDQ9BxZ+r136XN+Au7fB9bN+gY8WRo+Z3jaVCHCDlpA2E3lNcTiZwfz
 E9QX9ko3Rx0bXWlzQCBBVwkDbtXsLcSloRy/HLS7oe9SKOLUZoHpdiZMtNA6odUfDhERzvl+pVz
 mqdO6QBIrrxo0sS93W8YRFE/1S985OcuvnApcXFg4x6ZxojfsybI2Tb/B17Ptv+1oEtodcXEUHj
 3nvQSrn0tDSezcHrV4w==
X-Proofpoint-ORIG-GUID: efuUqBCmjQWEOoQxILVa8BsGkdQFdAHs
X-Authority-Analysis: v=2.4 cv=Cfedd7rl c=1 sm=1 tr=0 ts=6accefe9 cx=c_pps
 a=JXicDZ6CVi74U63V4YFJkg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=pGLkceISAAAA:8 a=832znINkK-yqb4ICu-EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: efuUqBCmjQWEOoQxILVa8BsGkdQFdAHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120057

On Sun, Oct 11, 2026 at 07:56:22PM +0100, Raffaele Tranfaglia via B4 Relay wrote:
> From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> Use dev_err_probe() when requesting the ldac GPIO fails. This
> avoids logging an error when the GPIO controller is not ready yet
> and the request returns -EPROBE_DEFER, and records the deferral
> reason. It also simplifies the error path.
> 
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> ---
> Compile-tested only.
> ---

Not sure what's Jonathan policy in here (or don't remember :)).
Personally, I don't see much benefit on this kind of patches. I'm aware
you might be eager to have something upstream but for staging I guess
the real value is in having someone willing to really cleanup the driver
so that we can take it out of staging (naturally that also means having
HW or someone willing to test it).

- Nuno Sá

>  drivers/staging/iio/addac/adt7316.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 20f6052cc7fb..8ca6def84584 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2142,11 +2142,9 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  
>  	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac",
>  						 GPIOD_OUT_LOW);
> -	if (IS_ERR(chip->ldac_pin)) {
> -		ret = PTR_ERR(chip->ldac_pin);
> -		dev_err(dev, "Failed to request ldac GPIO: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(chip->ldac_pin))
> +		return dev_err_probe(dev, PTR_ERR(chip->ldac_pin),
> +				     "Failed to request ldac GPIO\n");
>  
>  	if (!chip->ldac_pin) {
>  		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDAC;
> 
> ---
> base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
> change-id: 20261011-adt7316-dev-err-probe-8ffb5e224100
> 
> Best regards,
> --  
> Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> 
