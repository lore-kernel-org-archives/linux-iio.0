Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACC562612;
	Wed, 14 Oct 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996965; cv=fail; b=bW8nSLE2jKkERZqyt0oDkPwZ9t+UgCLodWmbJyol2JHET0xRDemOcV6u1LjbY7/qVoOQ3OdP/OTkCjVcbeKXpTqs4NmqZdzQE3Yfo4r0BEybvRUDpUkeGYpLP3gxwYZztzbJTQc/GBYN3J/Q12o8NkhApv+DCEaLc4gF483Q92A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996965; c=relaxed/simple;
	bh=TDsMSWpGwpDft1GfbW/SgkYh8AoXT+GVWqXVsdMDJuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HzYBL0W/51SSPWSKRDWXCmpWU1aLWCFdgMuPoRhW6X94sTpVmTq2Qq87kBGWkPbjLM0qxWriAyb8NUYrSiTPrK32uUSZpH6iWyv7WTE5puhDg5fWXIwm23tp2RtePSJOWQyuxarZjEaKxfOrJ69slO9xuvh5KXCnKzUMoQzPbcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=mKm97DRD; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QWJRBgzq; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="mKm97DRD";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QWJRBgzq"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEb3uI4024487;
	Wed, 14 Oct 2026 12:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=lBDJD1EiwcFGzAGjsCnw4SdYuzXtXsCMJyVoq0St8cg=; b=mKm97DR
	Dal7cGGTwPHa3dyQYVpxW3c0P2viGaROvqpcOCfPYeRwEXqJ4RwXhlvY2PhnTXyc
	vvG3cMO4eaMsstPSW6HZdLW6Vb6nRqTSh3qhjw98O0LQW0eVGTkS89y8BFkGznFb
	Yww19cPL15kN9ZDiyu7CWxKxrD70gNrvKuhlOS1rXh9ZVWHLipGOYUJP7RKK5NrJ
	eAavNYUYqKJyPgvkg+1wrHEt/gWXBDOiIoaLkAuj8T6qhM14x7pqisOuZG/Zhn56
	yiVEMcKJVAFcwcGodP/EJ/z01JrzzaBx0JrdJRzQ9OJBiHi5RclzmJ5xezcUyjM+
	EE9sj2uGjX005Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lBDJD
	1EiwcFGzAGjsCnw4SdYuzXtXsCMJyVoq0St8cg=; b=QWJRBgzqXtHN23VKriPTa
	d6kLCpl+dJs6XfVWfb6QwfpmkRkqc23HfjBWBAyK4fKPcGZaxq5zlU/4zypOyQY8
	NBM19mdxr2dC9r+KQ8k7pEdD1tea3LdTs7Wm9VXswJjtnOc5dZ8V4uk3o+3Ji3Gh
	I/VPgmsr0UO5tPDloYaXAc97US0UBVtkRVVFpsb6O75E8nNlsQ7GBsjC0L5y+kvV
	dbEvVCeezLI5SB5GfrhqcE3CBOzYHWl2wYhxix5CcbGtkBCC8QP5OxeZdWeqgJyV
	ND+uYzKYv2YO0CNeHRqiv1ALM2zW6NCxihUXe7YkrtNXYC4snoIF6ndxv7ezkYVr
	g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haab61b4b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:55:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgaOyd8/+knnBwiLjPPAYIMNEogBSgTQGpZlRFEBSxwMMENCVlicJtg1Ie8v61qgQlpiMSsMWtVBQIgVTlIyPOa8IYgAY4skQEJSaBIO9ekMqp4UnPwiSU4W447XefK01XuEypEd9IxtMJ3u3fBPHzyjJa4LW3pUBB36B0+qqChVcVFECOYeZay3sG+HwVNBQ4bL7oedPNnuewwCanx5k4PHKgIy4liOveLDpqsVkdJ3hEdHYfJWJGQrSjQOhKnE3O0ZKfaMcfNZ2e30lxACEGccyKNRwGVMCTljx88Qc/rk3Vkm1SRnTLLmBSZTzN9IPySz4ll9C9ChgVhYSGof5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBDJD1EiwcFGzAGjsCnw4SdYuzXtXsCMJyVoq0St8cg=;
 b=n/HmUUzI4mXTj+g8R0AG4nkczrCgpZgkoxNwFs8LzrToPBNsaUyRCS0+UzP9Aq1uMoNcfaAMILXwcJkWA5nim+HogNA8PF2roxFD3hH9sXizqNhS9Pfl/xruCPfC5Bfatcvmvt1rnY+bYQphydB1zfGvvMfPLnbBP0qor6FVThcI8nfeAO8yqUjohL3nvSell5IrM4eEMPFQskHOQFU80pLikVxanCiWGjAnrDpRpHQhs2Pr0HZrbNU0QLyYGNT3Po90c8oN1LI45mzbzAAOb2isepZ023biVo6T8GkfrR0KQXipSTW8jmrE1g4V63a5d5tJVVQ1IW3NOmJ8JbTSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB6470.namprd03.prod.outlook.com (2603:10b6:a03:396::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 14 Oct
 2026 16:55:53 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:55:53 +0000
Date: Wed, 14 Oct 2026 17:57:15 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
        conor+dt@kernel.org
Subject: Re: [PATCH v4 10/13] iio: adc: ad4134: Support SPI 4-wire mode
Message-ID: <as-0GfwuX6JyKuel@nsa>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <ec26e0e1cbb6572c8eee391951c084a7c264887c.1791309733.git.marcelo.schmitt@analog.com>
 <sashiko-outbox-162354@kernel.org>
 <as6eYQaso8KQPn5T@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as6eYQaso8KQPn5T@debian-BULLSEYE-live-builder-AMD64>
X-ClientProxiedBy: MA4P292CA0009.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 08407885-5d59-489c-9b16-08df2a14024b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|6133799003|10067099003|11063799006|22082099003|18002099003|261009223027099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	ZDLnmjlZQ6pJ8fffmGWaEzb0Nt5aSDuvmNP6jgPKM6RzKY0FFCdmva5VVt0KKwiGxpvtSjfjy8Df5qwWJw7l/E1v5UoB4+nn+eURY/qLJPxh0xRhG/K67TwgeXlUuAlKuJeoAbRTWAsFWWMcDHQJ7JGUsg4B451/40DTUFayQsUXW8UNaDH5vWItBmWaJqGXLSm6+p/FQNyzNXlw3o7mSGaY0f5zUTZaoNGvgvqjmQt811esHQ7EbIRyu6P83kVkJVdEsAK1ZQj7vvkmCwHEvoEeP2yM7UOhispoOgGQ/i+IObL11UvLGa8V77NaUb+8E+eToIt5RNtBYfnms7DrgYN5UiruEeArp4mwdNCRLRHpndqbwFSCMEH8irtJzWZuFuHFCtwGKuQBja8D0fGk6/rBevSgW4al7r6yVj4pYwrPX/gxhyexRDXLkkLhU/78PTBDrrZ+dk6v0l+LwA1foAVjWF4a9MlGq1PzOUAqUkcw6P7dwLfkuv0jZPJsej11Mwj9Qx6jYanP9d5cV6P4753lkxyRqxNE8GV039RwFwJmuq+UKRUodJP1FeHGE43eG2xUjVIgfmcTIQ0Qhb+VeT3XN6spVFvEnzUHyrf4ehybDtjoJk/H7vOGbNPPswVPp+rVmKk3i7cnONhypGmH1rhpAN6yzJFy3+UznXSio4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(261009223027099003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGpmM2Z2SUs5VTFqZjdXKy9Kckx3SHMrUXIrYUQ0NUtiWjdKSU9XOUFKSXcw?=
 =?utf-8?B?bTJOcDVjK1BvdzRVS3VRSnRNa3FsWXlxeG05SXdjdjk0MUNmU01DeGNKV3pv?=
 =?utf-8?B?ZUcreFFDWFVxdFBrZEsyMHRyQ1FmWHFJZk05YnJ5SE0zYzJ3aTJxR2NldElk?=
 =?utf-8?B?ZWx0YS9PVExEcjc4MS9LY1Roa1FvY1JyeVQxUVVBa0F6RWpHdFI1SDdLYnZo?=
 =?utf-8?B?dnRyMnAyaFlhcmN5NVNFazBSRlpMM1Znenk2anRqSFhxVUFEY2hnVHcwM2xB?=
 =?utf-8?B?VXpQWFJiclVZaUovbEpET09UNXVhQTJEYklKMExLa084Mi9BLzk1U2xMa25B?=
 =?utf-8?B?Vm9CUWhwSGxQVk9ROUNhNDdmSUtFaE52Y21LM3VUakUwc1NGb05JR2wyWFRH?=
 =?utf-8?B?RFVaYy9wNGtEK1QzSW1uWVZpMWRlT3hjZ0VRalZBaTVxRG5CQjBUSzJRcnl6?=
 =?utf-8?B?Qmh2RTgzWW9oaFFHZlFZWWFtRUxDZEQzMStuMm1WaVI2MHJFb2NPaG5RZ0s2?=
 =?utf-8?B?TDZTQmdDNW1QNnR3ZytQbGgreEZ4M0VveU03MXlDS3BkMDNpZWZNdXRjcXJz?=
 =?utf-8?B?WUpZK2ZZVmJrK3BpVFRoeGt5cngvZDluY09BN043clY2RmpjSVR4SXB2K2U4?=
 =?utf-8?B?WWpUbGNYNXl3QjFGK3NmOHZDbTVBNTlLUHlBSTFHRVV3LzFGUVI4MVJpcGZ1?=
 =?utf-8?B?MWlIRjBBQjQ1RkRmNTNzc0hMNE5tMlhaRWtrSEswZWpuWjVIY3Rtc2FacTN6?=
 =?utf-8?B?a0gxNkZDWmw0SmVoeXlMamIweG94Vkx1dVpsMWEySGppUG5rWXlSTWVidzBG?=
 =?utf-8?B?MVZmSnAzNzhuNjZhRnFxbzNpSXRHQXRJREl0WFkzQlhqdDdhN1VuMzVZbk14?=
 =?utf-8?B?ekVSWEdSanZDV0NZRE4vZWhOdzVwcmRuZ0lTQkM3d2ZONjFKNFE3Um1LdWhR?=
 =?utf-8?B?ZGY0R0Z5RzAwQXh6bzdLcDNOMWUva3cvNjBNOTVnRkxhMVRZNlN4eFgrdlpY?=
 =?utf-8?B?TmhqV0hnMkRqMVJqdGJadFRXejRjSTF3QjZjQ1dvRU9UbVpoTGVuZlNMVVFv?=
 =?utf-8?B?N3F2VHY1RXR3RGZsY0RsMHRQeHdPblQ4bUdKQTlRb25RRVl1OER5aTNhSXE1?=
 =?utf-8?B?SEFWMGpEVDkybGs2Q1ZBV0ZkYTBvK2I1dzVlV3d1bWNJN2ordkd5ejZSOEVY?=
 =?utf-8?B?OTlTb3N2VFEwanJsS295K1pzS004RzBMVk5JYjRkM2Y0OUxkUEwzUUlBd1ZV?=
 =?utf-8?B?S3JTcTVBWmxnMEk2akl6aDgrbEM2SU1DY21HNVI4WW5WbkRYTm0yRWJLTVJv?=
 =?utf-8?B?YjRZY0pBY2J1SDZOTG52RGtRMGl6OW03c2l4cjdzMFBObWFNSjdOb2tNdnE3?=
 =?utf-8?B?Q1dadGhQSlg1WThwUnppNWNWRHJ1ZlZlRHl4dVpITHQxMEMrMDBBaXJqNk1N?=
 =?utf-8?B?Wm1yWkVBVGVLYVJJb0FsanU4TENUelA3MDd5TUNZZGFqdm9wTmlDVFpOV21U?=
 =?utf-8?B?cU5maVJDSUxWQjh2UUhzNUxlcHBpUmtKTVh2a3ovaXMwaUdVS20xaFFxNW9y?=
 =?utf-8?B?ZDlFTHZ5eW1nWEJLcDFGeW92MlVSS1VPK2Vyd01JK2JvUlQzeWpjQlVMREhv?=
 =?utf-8?B?M2l1d1ZqangxUXREdzNqdmVhVHhHVjB5UVoxc2k2bnNkTDRhRG1VQnlNbVJp?=
 =?utf-8?B?eGhPMUVSTGZ5c2hDejhXZjllbnQvcUNGVnp0amxkM2FlZEZHaVcrakNzNTJz?=
 =?utf-8?B?M0lUMG5zTzBwN1U5TUI2TWhuc29OUTZYQ3VuUDdncXhxS1cyeExpNzdneWth?=
 =?utf-8?B?VUtGbzVUdmZiZndBVDk0a2ZsUHM0WU02dEtnV1BkVVN4cEV2TzVpUE53VUpM?=
 =?utf-8?B?cmxqYUY5S2JyZkFLYjc3ZG1PVkpRbGx3TzBtbTQ2M0R3Y0lTS3hzMVd4b3JW?=
 =?utf-8?B?dmpnL2hHc2cra3hBRUViaThqRWpDcTlJbHNpblBieHl4c084dVZMK0hKaVNQ?=
 =?utf-8?B?UUdlcUtobU93TU12dGtYZ1dHci83QWR5VEdQRFlCZEdkcEN1ZzFkcEFWYXFE?=
 =?utf-8?B?Vlk5SFQ3NGt0K2pBVDNud0YwVW5ydG1LSW56RFpKeWszcWZPN1AwdnhxZ01a?=
 =?utf-8?B?Ykp5Q0dvZk9yV1kzazM1VXlVMlhmVi9Gc0NZdnh5Z3dJZU53NTVjUWlkbG92?=
 =?utf-8?B?YmtQVmhVTC83OHRwUzNQRWxCd3lUNXBQTzRlbVFwbUlmc0VzV2NkZ1ZSc29p?=
 =?utf-8?B?b2dLdlJ5Y2s3aDJzL04xQ28vNGRDa3NQOEttNGFBTVFBYXR1TDhqL1BUSmZu?=
 =?utf-8?B?SmgyMWhLZllaQTJtOWN4QTBMYVFpSzlIVzdzekJiWHE3enlpV1Uydz09?=
X-Exchange-RoutingPolicyChecked:
	s9MaQ6s6DEZUBH9gg9i59JAWWGNI7XxoavDXlYHy7Pix3LvciWw/L6BhE4osMsJ6MuD/n9/aY1cLwrwk+mXySHR5LfmNgqlyj7YEQBSfTGLVwiEHiWu4yGRYGyv3+MLPWpTIyYIhT8UGuJ52HhBGNr34wCpdc4BZAQFd3+3U06q6g1PCUoyHUb5L1zoUpNmuk+bBGZaHJeC/jTQqpzvft5w1loW2yAO3QK9fx3DA6VcIJIOk3Sz1C4J681ASZ8Spc0vRr77Hgl0/rY4H1gMW3wwIRb40FK4KaZMzQxo1I8PzRsL8cisUUgwhkyBcd10xKY164CKnK+nbkFRdK7VHew==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08407885-5d59-489c-9b16-08df2a14024b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:55:53.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crQfD0e4jCk5OoRzTb3+y0jVOkOroVAdpNij/F6Ymej22HcL1puS1KuxsimyHz2UO4aOt5b0wuhzJNRsuZOkxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6470
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6acfb41f cx=c_pps
 a=NlF6qXdsITzFGNsd7EO88Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=VwQbUJbxAAAA:8 a=FOBBUzkC5Xxx3mb-xOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xZTcIXsOPBOJp_6n5FMtN7ZOYRCpO8i3
X-Proofpoint-ORIG-GUID: xZTcIXsOPBOJp_6n5FMtN7ZOYRCpO8i3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXwoaGW4tusc5S
 iW2pKWY111kmNHZ4eFh/24W7uPzL+DAL8f4q8dRaEQG+wt5UoWD1vc0boKAxLF27Xc9GtxFQjqp
 tnzpAtWgpY5/as4sFOZdc3cRry/lfs2sHNmwBlUMark08+X5kLdg3aRGC+akGT6OwKIvqAqs/Oj
 5svRKDYusFziDtMbWDsfXUyV86ZRMcFGJE907anT2ex/IldMVZICWsD/2r0mQcJmWyNfhtlgDYn
 UTf85+pkunhqciPmLWJLFwp6/WR9tIRvIYkaZV07/CztqvKKWxkzNcAOS323URwkrR7pYFHpf1k
 Fen4j01FBBfRnx+LYJAQRJtzqEugIuBdhNxOcT8feQLapPc12ql5dRgdwaRYu0Sn5H/8P6X3X6A
 pwBdlc4r/l7wNF0sEmnn2x+XpYqfwN9LSEQBkEZ8YxuDu4aZmywW3owfo77lXXNdhqd0wO/DWPu
 rSK3cWkb5DoO5eenePA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXwOiiWB/RyzVx
 kC7O0Q6aTpIblNAVsygrRLY3hu1taeJmHy3p+yGYpef+N9fZYpZryC9uZbdADgRqaM6Eo2UzPnI
 W13Y1Ee6cNm4yLEtJ+zeHi9fbRKqKASmkcjMliNFnk2S/E6sw9g9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067

On Tue, Oct 13, 2026 at 06:10:57PM -0300, Marcelo Schmitt wrote:
> On 10/06, sashiko-bot@kernel.org wrote:
> ...
> > [Severity: Medium]
> > If spi_setup() fails here, we return the error but st->spi->mode remains
> > modified. On subsequent calls, cur_mode != SPI_MODE_0 will evaluate to false
> > because the cached mode reflects the requested state.
> > 
> > Can this cause the driver to bypass spi_setup() on subsequent calls and
> > attempt to communicate with the device while the SPI hardware remains
> > incorrectly configured?
> 
> Seems to make sense. Will double check and fix if needed.
> 
> ...
> > [Severity: High]
> > Does this cause a deadlock during device probe in NO_CS mode?
> > 
> > Here the driver acquires and permanently selects the SDO multiplexer via
> > devm_mux_state_get_optional_selected(), which acquires the multiplexer's
> > non-recursive semaphore.
> > 
> > Immediately after, probe calls ad4134_min_io_mode_setup(), which writes to
> > device registers via regmap_update_bits(). This triggers the following call
> > chain:
> > 
> > ad4134_min_io_mode_setup()
> >   regmap_update_bits()
> >     ad4134_reg_write()
> >       ad4134_claim_reg_access()
> > 
> > ad4134_claim_reg_access() unconditionally calls mux_state_select(), which
> > will attempt to acquire the exact same semaphore already held by the current
> > task, causing a deadlock.
> > 
> > Furthermore, ad4134_release_reg_access() then unconditionally calls
> > mux_state_deselect(), which would prematurely release the probe-acquired
> > lock.
> 
> Seems plausible. Will double check and fix if needed.
> 
> 
> Other LLM comments don't seem to apply either because they are related to debug
> interface usage or marginal issues.

Hmm don't agree. Don't disregard debugfs claim just because it's a debug
interface. Looks like a real issue to me (very easy to trigger) that
needs fixing (same as the other patch).

- Nuno Sá

