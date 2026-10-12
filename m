Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0E2E7366;
	Mon, 12 Oct 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816278; cv=fail; b=J37gbbnl0Ct7ZOrbpt83BWUbXRkgGHGFMP6oHq/FogiTHX22VBp3gzS6Tqnl2Yd3Q6Cxit3mz8i12XSwhRapSjuZRwh5KpRJFTR+cj3lRA0fHI0fuydlUxIOEDBuQ/iLgjHChCd8piUiy0CiENpwq4+2kAqCR3lotW+TBiyS5/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816278; c=relaxed/simple;
	bh=ePAyYEc7IlfZ+bGElU+McIsAYjI2fW9MsAgyksoeBb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s7GjIynFoD5yaoy0O1f7qLXJk+5D3dLE+nipkYL0qJCsBcAUwrJKI38unaPWLdQ9BTa2GIMVQgL3bYh6oBo0hlpaDCMUnsQ3Bev531AlEq+C4AIHrIrhmmy+J8GQKgZaWObJXAQ2Bx69R+1vefFH5rMmVs0UZbIlF5gvUeW04jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=LuqnHKv5; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LzQvZUJp; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="LuqnHKv5";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LzQvZUJp"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CBvQBO2849042;
	Mon, 12 Oct 2026 10:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=mlUX6+a6NdgwqzA4IfYqJv0jaV7GgZjQJSnL98cF+LI=; b=LuqnHKv
	5893TcjpUbj53lrzG/3v04kY82b+gCIIs4T2PIglnziqb7ml4VeczN/pMfqM3003
	Q1tONkoaQRggOcxPtWLwhewO2L6IWJb7MVii6SSGF0La92e8kVG5JuO6qyZdf+Tx
	gXTczYP6sXHuJQ9HA3Q26SGuFzN/773bGaPAtgW4cMlGTWmr9SehRBJwggpMMzQC
	23XcOODFfaWZmk1TVN43mDWXejcJq8ZMob+5X8XghOXpxO38QW9vCZu24FYBmb1I
	nh1/OCceGOVe3ueb9ArTjyT8TMyCyUEEBYPOv1Ufob6cRfbPFVpj+5fMVxaqsglU
	QBJGD2xdLg+pKpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mlUX6
	+a6NdgwqzA4IfYqJv0jaV7GgZjQJSnL98cF+LI=; b=LzQvZUJp9O11Kym84eikv
	Yz+TYWBIveIHk82ko9/UV/SeBufozab8g+zTDnNJ0fl4Czb5YzWKyKawBNC4zmxG
	1TOsD2fmsZ+gyZCOcRpX1spfzNNVkbiujJ+ZWccBJMWY0OqZvHVjhbTY3HFB2xJA
	Ijs30tq0JhSVU639csNhJv5hyoHvoNaFP2Gn+Uwpy4XFi3f9/9Y88MqSwCwN2Jai
	4+wAYPmU7OSgw/ouAj+gVuXSXh8hMOskyPBy72HRhlGcNWsIMVdVHoyHghwt/VDx
	LFxhMAlOsd0Q3DChZCmo43TgeUs8WVquzVtQxXp/Ykfi/c6o8sbXgiTEPM6Tgwyu
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h86pefkea-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:44:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9yJcVQKLOw5ga9hi5RRcx39NicumhB5iR2pOluPe2hpaNKAugwbr5ulIdJ4M/onAHGr3jS1CAjzBj8rsFy5xbGxu7blgpFkBmTFjwuPqv+PafimyNCoENQjsnOMUjtxUsCnmNB1wmjdhEdpKbzBXe+msEpwCOcF3aD2GVzwmOQqP/GwyMRNdQNbLje5L1RiXx+P0oWDcj5bpR4rlpAqDOLTgghgfvO7r9Uw3TdZxnNHsaChecekqDVJN/1z9h0mCGkGtuM7Ft0B5EPAPJ321haHnv1LMfb6I40yNSOH40ySv26iW/Y9zFcgEvlUFghavD1m3AT5ayIhQnY2gioPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlUX6+a6NdgwqzA4IfYqJv0jaV7GgZjQJSnL98cF+LI=;
 b=QZkgAyxHOjKMLzHJ5eU9Nefj/DqiObaBexiztT6iFfjKgo8g7OnnzQndunVgIUaJsadouhUXgZQ6dqNor244ejrvLp2SP7RiGAgyHG77Gk7m0thRM2UOKNkpaasPEHNkeV63Q9ud1KmBFiqlTM1W6jM+PJrPmZ8PjZjisTiXiiDshgpvXVJoXKej+8tcphOUjesrypqVNQfWCQSi5/3eWeF32rO/M1LR6pOyGHdsfrTEYJZ0KygYJCErMXj6VfTrM7ZUBP28Y8GXE1Ey04Jw2fWOR6ojS2r+Mc8oidcMe6SZvOo8QZhl1p35GI3GZP9GAA65v5t1uDNO/V2oyCuJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BLAPR03MB5491.namprd03.prod.outlook.com (2603:10b6:208:285::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 14:44:30 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 14:44:30 +0000
Date: Mon, 12 Oct 2026 15:45:47 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux@analog.com, linux-kernel@vger.kernel.org, jan.sun97@gmail.com,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] iio: dac: ad5529r: Clean up definitions and regmap
 configuration
Message-ID: <aszyX_e44Dp2MSln@nsa>
References: <20261008-ad5529r-review-followup-v1-1-84a98e0e27eb@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261008-ad5529r-review-followup-v1-1-84a98e0e27eb@analog.com>
X-ClientProxiedBy: MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BLAPR03MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4b6d03-43cf-476f-3cb6-08df286f5035
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 wbHlV/jv0HNRSi3oCWzsu5bTIT6EexOGBkmL68M2krLqnQZLoDtBx/NuIbsD6pE9MkYL+Bzs1gUphS4LOMlzY5OGIn7/ZYwERJjPw//P3lSdHMWwnkRcvEgKZniMbyEc2Lm6j6LdZz+uJKZi5uqSq3d/0JSxOC3SQiNgBuJD7wCJbJlohu4JRHDB/xl9kGT9TC0+MYgWZkFQd3Sz1pRyBUYB8wJUu181e/lt5OfNiMPCFeSM5Wcw9lhdMV73mM8TtMNuM+eF3tsDqA9cRu8TmWammzH5WSM2IXr8OB5+t5iwwCd7fpsn8z4axUvV9EDuL0gENlWQ0smC+RJpxBk/6YQOeNAHCTZ4ceDLbqJv6UGOEZCldXiOilTtGvT+O/GbfTvnPCc6FiCQ9DjwHsqganC8Rnp3CVVL87FqYXkAoyp43fbjqp3OkY0IORMyfy/1+J8XP3ac04o4rJR+cm1e9delpuxGrGQAuSh6UDeiv2PkCfvOJ4rQa2RP0MLS1/XtGLowAN0Oz+tz6xBx6KRzFKzT3XISP/UzriPOosv3PvL1/I7GmyGW1QyI53fJIPPUKdcrkurtwY1qpy2MBpJATYclJ4KEt8mhp1dq0MU0fwI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QWJteCtuSTFCRjI5ckcrSmR3T1FCTHhucXhLYmRvT0VZUExjREIyRUY5TnAx?=
 =?utf-8?B?bGdkWVVWTWxvUmRCay82RXR2MDcydjRJQUVIZWR2MVE3VmphL25UQTR3ZUVx?=
 =?utf-8?B?OFlTRXVzdnpDMUdFRmtVamVkNVQ3TCswMkZ3RTBpUHBDTTFpZitHaEZwSnFu?=
 =?utf-8?B?TUVWWndjNlJPbk0wTHRLNFhrY0FEcjd0OFVDN3h2em9QVnBlOEhmZ3BhSkh6?=
 =?utf-8?B?Undzc2tWR2p1MDl5OWQ5b0lXR3ZiRjNUZUptSmM2YlBTemJVTkhtSWdVNjdI?=
 =?utf-8?B?alFleU5uSmVxcGpNMFpnL081SlpxY2VEcDhTZ1BMcEJoNzZuRnA4QmNwRVk5?=
 =?utf-8?B?M2x6L0xLS2tHUmdOaHIxbGlNa1Z1R2t1RDVEdjFXakNuOUpTRlZiTHg5bDFw?=
 =?utf-8?B?eEZwRzM2d2V4YzFBVHJtUVh4Z2p6aFJ5c2ZkWHVLTU5oNG5ML0NaWmRYU1Q3?=
 =?utf-8?B?MU84V04xR0VJalJiLzhXZG9JWDd5VGdaa2V4aXJlRllubFkvaXZtQ3M2bVVC?=
 =?utf-8?B?eXEzYUtUUmRYUWtYcXN3QWR5N2MvRXpzMHI3SDk0ZkQ3TzZQTnNMQWtTTDNZ?=
 =?utf-8?B?djltaE5vU0grQ0pEZGRBUzZpcWZxT3cxWGFNV3NnSGdTSlJaOE1IY013cFNH?=
 =?utf-8?B?RHFPL0g0YjNMa2VVQk9MeHQrcTZKWGVBWHBuL2hoM3FrRmxOYzFHbUMrTEVP?=
 =?utf-8?B?NXFEVVVLTlQveW9iVUozRWMrcENxdEE5WGwwRjNuOHdadjZsQ05BK29rMCtM?=
 =?utf-8?B?WDkwbFlXTEhBQTFXK1QrL3BHWFFBWWpVYWlyYUM4SFRPWFhOM1BRWW1aSlpq?=
 =?utf-8?B?QURTbHhYeVljLzRtMWcwNWVRMFhwRlNvazhUTlNWY3hrVlF1dDZTY29zbno2?=
 =?utf-8?B?ZjhjU2pSNmdGUmdqdmZ4S2dHU2wySDBBbUs0a1JvOXZGWGJMYmcrUCtMQjF0?=
 =?utf-8?B?VWlhbGFITUg1LzBJYjRDWGRTMjdKU1lueUJNK29zWDFMSHdPK21ac0dKRGhM?=
 =?utf-8?B?UU5CUS9McDBVaXB0V20rWTAyYWhTdzlkTFNmbGU3SDViWXd0VDdTKzJTM3F2?=
 =?utf-8?B?dlRmVUpCVzJjelN3VW5IYUtDdXBhZVJtcy9yK1liSDZ5WFpvZDBnN0VrRlBn?=
 =?utf-8?B?V2gzK2FFV1Vjb0JNYm9VZFVtNUhuWHVKM0xreXQweGMyS3dzdFV5WXE1UDBa?=
 =?utf-8?B?OTZwVGQ1ZVcxOTQ0NGdmQUZzYytGWW9ub1E2WGZDNHluKzAwY2Npb3o1VVlj?=
 =?utf-8?B?YjVlSEY5dEtjeDZqdE5aSG1yVlMxN2NVWGdTbSt2Rzg4VFd4RjZlV2g5d1Ru?=
 =?utf-8?B?bmRsS1BYSkVubmJmZUJaVWZXTE9POXJaNUFjZ21Sc2tHR3p1VDJqZkF0a09q?=
 =?utf-8?B?Y0xTd1JLRjZrb3FINlNQTFNnTkw1QXFNN2VNelJkb2ZyUVV2NUZCQVpLZmlO?=
 =?utf-8?B?V1ZOUWJ1bmpMZXdxeHkzSnRrRGtKUHlRY1Vtd3VXWG1ZL1RuTXYrTXdMZ0dS?=
 =?utf-8?B?L21nQkJKTkZvZzk3N1cxNVhpREZxeG5KU1hweGdrSjVGWlZSa2lDRisxZkY5?=
 =?utf-8?B?YTZFR3lGY09yeWw5SmZqMCtvb3FJYXMxekZxeUc0czYyeFFFWjRFaG5kQVVF?=
 =?utf-8?B?QkhNVExPNEVjamVuVHNYbUlHYnVlVVpUQ0VFdnVyMmlDYnMwdXMvNW95ZmpV?=
 =?utf-8?B?dVlBUU5MWXlheTJtc2xUMEZwQjU1c0gzNzFQanNWb2xuTVlXazA3T05GbEo2?=
 =?utf-8?B?QUdKOTVuK2Z3bkUzVlpJTWxONHpwNzVTN3kybXhsMkNzYzN1VUsxTkZzL0tk?=
 =?utf-8?B?USs5aWs4WVlpWXh0RGI0UkJUaW83UTNwM2tFNkl1TVIvdHE2SERlUGpUb3dD?=
 =?utf-8?B?dk9vZHVrSTYydUs1VmQrRHdqUFNYUm9yVXdUNGdZSlhwb1huMEp4UmFkSERq?=
 =?utf-8?B?OWJsZXQ5Ym9qM3BpUHFMUjdTOGVVN2I3cGJhN0xMVHBSVGh5N0N2VnpBcG9W?=
 =?utf-8?B?V2pMZS9vT2h2bVVncC96ZUZSMS92dnhxTjVqbEVoT0crUHVucWRsaloveVBi?=
 =?utf-8?B?Qlp3TEFJV2hyb3NJTU90Y1dpVHlldDdva2FNcXdycmRMbm5oYU1iQzRleDd6?=
 =?utf-8?B?QitPYzQxYVpOWVFRVmNwMnJLZVhscFpTejFjMDc4WUd5VHJvT29nRCthOUpH?=
 =?utf-8?B?L3J3VGNTeTQrS3JwYnk0NWRGNlVKeUJSeDRndUgzUG1ybjk3R1VuWFZTR0M0?=
 =?utf-8?B?NW4zNXg0VWZ3dS8ybW9DNjNrSUs3U0lNQ1NzUElnRUZKVjMxa0dhZ0FQOHJR?=
 =?utf-8?B?QjRqZ0c5RHlpcU91SVgrNFQ1QnBUcUp5Z2NBbjArNDBvbFRodEhOdz09?=
X-Exchange-RoutingPolicyChecked:
	X/GJQoWfYUCrOsZNkcRnetYoTWxf/FYgBf9BQsMWizwo2TawGhiMYVMWHpDC2rqhHFPqEsr7/vV0Oiw8H/KTKgrP2s7t0FKM4BDTz/lTjMZULMd6Rdx2gouq5wPEAb5MFrphmZ9bcBsLrwA2M3ImSCZYYsI9hUwD0kRJqtRXVnnrF69zO9a0mFmv4lVSQSDNNYcyBmBLBUh50njcSVPg9CO3t81M4eONCTy66FgKY/6HzI1aN2+ftW7D1Wp0IB11CbyBzhkHyqkHj6DOt+ZT1UXC5ZwBvDVfwoNwb4+bJLlTtHbXHtkfG31PGYJe7CExl4DgzGk1TOTNqBZuS1JPww==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4b6d03-43cf-476f-3cb6-08df286f5035
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:44:30.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYo77oqPLRKVSR9I9Cy2OJIA0JkBBhQS+YffEkH4UF7FkjLXl3NM3Idnpcx/y5S/bb/AHvohlOmgMViQZPlOJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5491
X-Proofpoint-GUID: WZpnjiBum_sHQqsZqrW8LWR4BupVZh21
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX5/0DXzDf0v4x
 7Wvpy8dsUPqOap+4qTVDUc2JgbLvGijoIW3Qv1fJvgbHsQnKLTeEtbpzy4ECUOnniVO0VJ1Sn6m
 G1gkRnMdONXuzolBsOdkCVgQqihxQYL7z7nuYCX6O3LQX2km3uqi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX889ONuB8/DoU
 eJQFlmTS5jLjj9PXcuLRDQpKTb9qMfeBvmZN+vNUs20gISMIn3cTZfF5+EjA/+PSysaLz8npk5x
 /NnOt4rKzjt7W8hAYukTLPJlzQhhL52YksrwAI+HK4vVIRcJ2EimO1ZDhlVRXWkUaFkQL1Paqcr
 2YmZWczg0wsodCFMcK09OhN8+L/1HzKvUe9C6KHq4ZW+aJHT7Pib6phJfnA+qaYDIAhg0MuPLw8
 tE8j5G/7yWa49HEZCmr13L+vqvjoqm2QoG/0RuKJ9PwGfpZqgF0LqRUP1i/+wrfqdevtYxvF17D
 kSl7sTynS/jaoehSEB/UyLGnqEcq37hM6dFPzyXlWkKUb4Z0DkZih7jPl5/p079wFUBRB6o4BNY
 fQ9q1DfGlpuVEpmSAuDGE/F4vKjyypDJGg+P7lKlxXtfqWZmu9XWzWt+0iB6EuPlwQwV/JzWDRY
 6i/6HvFCgx+OS0ZOyVQ==
X-Authority-Analysis: v=2.4 cv=QfPzLcbv c=1 sm=1 tr=0 ts=6accf251 cx=c_pps
 a=DLgJpnoc0/49jVUGH+L3OQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=bpGtb6sdRXbNveXrrh8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WZpnjiBum_sHQqsZqrW8LWR4BupVZh21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120058

On Thu, Oct 08, 2026 at 11:19:15AM +0200, Janani Sunil wrote:
> Use fixed width register literals matching the device's register address
> width. Rely on SPI regmap's default read flag instead of specifying the
> same value explicitly, and remove parentheses around the channel
> initializer.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
> The AD5529R driver is already queued in the IIO tree. This patch follows
> up on the remaining review comments from Andy Shevchenko:
> 
> https://lore.kernel.org/r/arzTnOTaL97GudZM@ashevche-desk.local/
> ---

Seems like there are some other things recommended by Andy. But those
can be different patches. Hence for this one:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/dac/ad5529r.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> index 8154b87ff831..04bb02af9612 100644
> --- a/drivers/iio/dac/ad5529r.c
> +++ b/drivers/iio/dac/ad5529r.c
> @@ -24,19 +24,19 @@
>  
>  #include <linux/iio/iio.h>
>  
> -#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
> +#define AD5529R_REG_INTERFACE_CONFIG_A		0x000
>  #define   AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0))
>  #define   AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
>  #define   AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
> -#define AD5529R_REG_DEVICE_CONFIG		0x02
> -#define AD5529R_REG_CHIP_GRADE			0x06
> -#define AD5529R_REG_SCRATCH_PAD			0x0A
> -#define AD5529R_REG_SPI_REVISION		0x0B
> -#define AD5529R_REG_VENDOR_H			0x0D
> -#define AD5529R_REG_STREAM_MODE			0x0E
> -#define AD5529R_REG_INTERFACE_STATUS_A		0x11
> -#define AD5529R_REG_MULTI_DAC_CH_SEL		0x14
> -#define AD5529R_REG_OUT_RANGE_BASE		0x3C
> +#define AD5529R_REG_DEVICE_CONFIG		0x002
> +#define AD5529R_REG_CHIP_GRADE			0x006
> +#define AD5529R_REG_SCRATCH_PAD			0x00A
> +#define AD5529R_REG_SPI_REVISION		0x00B
> +#define AD5529R_REG_VENDOR_H			0x00D
> +#define AD5529R_REG_STREAM_MODE			0x00E
> +#define AD5529R_REG_INTERFACE_STATUS_A		0x011
> +#define AD5529R_REG_MULTI_DAC_CH_SEL		0x014
> +#define AD5529R_REG_OUT_RANGE_BASE		0x03C
>  #define AD5529R_REG_OUT_RANGE(ch)		(AD5529R_REG_OUT_RANGE_BASE + (ch) * 2)
>  #define AD5529R_REG_DAC_INPUT_A_BASE		0x148
>  #define AD5529R_REG_DAC_INPUT_A(ch)		(AD5529R_REG_DAC_INPUT_A_BASE + (ch) * 2)
> @@ -50,9 +50,8 @@
>  #define AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC	0x1A8
>  
>  #define AD5529R_MAX_REGISTER			0x232
> -#define AD5529R_8BIT_REG_MAX			0x13
> +#define AD5529R_8BIT_REG_MAX			0x013
>  #define AD5529R_MAX_CHANNELS			16
> -#define AD5529R_SPI_READ_FLAG			0x80
>  #define AD5529R_ADDR_SHIFT			12
>  
>  struct ad5529r_model_data {
> @@ -60,7 +59,7 @@ struct ad5529r_model_data {
>  	unsigned int resolution;
>  };
>  
> -#define AD5529R_DAC_CHANNEL(chan) ((struct iio_chan_spec) {		\
> +#define AD5529R_DAC_CHANNEL(chan) (struct iio_chan_spec) {		\
>  	.type = IIO_VOLTAGE,						\
>  	.indexed = 1,							\
>  	.output = 1,							\
> @@ -68,7 +67,7 @@ struct ad5529r_model_data {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>  			      BIT(IIO_CHAN_INFO_SCALE) |		\
>  			      BIT(IIO_CHAN_INFO_OFFSET),		\
> -})
> +	}
>  
>  static const char * const ad5529r_supply_names[] = {
>  	"vdd-io",
> @@ -433,7 +432,6 @@ static int ad5529r_probe(struct spi_device *spi)
>  		.reg_bits = 16,
>  		.val_bits = 8,
>  		.max_register = AD5529R_8BIT_REG_MAX,
> -		.read_flag_mask = AD5529R_SPI_READ_FLAG,
>  		.rd_table = &ad5529r_8bit_readable_table,
>  		.wr_table = &ad5529r_8bit_writeable_table,
>  		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
> @@ -443,7 +441,6 @@ static int ad5529r_probe(struct spi_device *spi)
>  		.reg_bits = 16,
>  		.val_bits = 16,
>  		.max_register = AD5529R_MAX_REGISTER,
> -		.read_flag_mask = AD5529R_SPI_READ_FLAG,
>  		.val_format_endian = REGMAP_ENDIAN_LITTLE,
>  		.rd_table = &ad5529r_16bit_readable_table,
>  		.wr_table = &ad5529r_16bit_writeable_table,
> 
> ---
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> change-id: 20261006-ad5529r-review-followup-22c8547c5b65
> 
> Best regards,
> -- 
> Janani Sunil <janani.sunil@analog.com>
> 
