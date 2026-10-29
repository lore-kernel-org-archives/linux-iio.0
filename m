Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793284786;
	b=iAYDV7YZWuOxTQHXKPjzghl0A0hA/ahSl6DFOn6ZiUgJaD68vdvLwK3TEVAh9AyfjVo5
	 e83GF31tlfa0mNcFOgTLkmuijQyAto+gRGdUmpiA4BXOUOYxKi4aHPFc7tLGMerhtoKU1
	 lmxyW3m/pN/XqYMSgYEiNglb5bGj7AxzPTPgg1RZ/iVbcOO6qjoaSim7HqqcyTEJp8zFB
	 xY5hhYQ+M5Rykj57tPV7zWxg39heTUpbiYn7GQehr2J+ABjPD10x4mWE6vpYN8GtyOw9e
	 b0Sq/O+hwhHhy+YNpAZF/Ps9ZzG0akC4RdHBIkZ29G+6n+21LQhFX7ClD3k1/4Dx+Wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284786;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7fFEJsI42BULWbpmlMCPrNp6LGj0+FOh4JdpCRq4VWw=;
	b=pMFedooDYXMd3arVNTvTFtlyBLSVY82M66LGoYHBKEbldUkaTTwBWyeH7YiiXHzKYkg0
	 0SJk8B+LEeKPjanbI61H3gFPZ+kow4YScEL9i9UkPzDCXZgewGnwZeaC/KpI6MsjZ4S5e
	 NCNrWDnaqwPR0sZ11zQcvJaiGRk0rz97ogkkfZSe42jMAsJATgNHAwSQsNZu4elLYSi7K
	 sMqZQ8B0GzYOZ81+3YivUpDdTnTY4lgwK9924BNEONU/X777StXkwDWaZY5QLkJY2horg
	 WxBLAc39S8ljKWAjmNldLouXWqEutUB75jNNz+Y0+f+/meagwM1fZUOauvGVH/vw0Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=uedGL+0A;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="h/FYdpbH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90091606A31A;
	Thu, 29 Oct 2026 14:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90091606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=uedGL+0A;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=h/FYdpbH
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TDqJCX985680;
	Thu, 29 Oct 2026 10:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=7fFEJsI42BULWbpmlMCPrNp6LGj0+FOh4JdpCRq4VWw=; b=uedGL+0
	Ad9CTVUBFdPMRe4yivt5S79MkgrJUFY8p82ef3qqj1r3nhbwuMbiV+DpCm15kBRS
	LkEc/EnX8JLlM6bkOidtwHwn6beWpj0qXmP7S4G44LlMm7Hf/NKY67a57MgQVdKK
	gPMAvP4cvO341O6B2TJW3UJkBeApleyErXpxAWv/Z0Wa8gEQFfAOxH4TyvTR9qLY
	HfztubjTCJO+Ro3iHCYXMO8QhkGXGFmsVOQqfG2svorRp5j3ME78TWRenvDoUsFV
	sHLTNn06JYvUsJ5QxM1skdvQFoQb5+O5k0PvZerU+lS/pgA6bxdcMe4wW0YieZ86
	iKm3HP7JJZ6+/pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7fFEJ
	sI42BULWbpmlMCPrNp6LGj0+FOh4JdpCRq4VWw=; b=h/FYdpbHrRS4SiNTU0XC2
	JYGwdMTKLUVHrGsQ71f+cyl8PClXcg+23lnSK8bG8fvyTS7h+0x2s4Kmei7wkJKV
	4sI/EyWnpNGSo2VUAO7egvWVxLSA2m7Fjwow1BmMJBms3e5layrH+wLoZFqPOA2h
	2GF3Vw86chpH3dcKhUXRzVZq1rLY56pIHRBGJKteZ6uAV5lql7+QuoFjrcqqt8g1
	kBcJlQmUNjfQJ5NCbfERQiZJeJpkLEOzni7XsHVwqZB4C5x5ApEPGfFCpFxcvwvT
	ujEwLTr9OcJIPuzzLsZc9W5gSioI6FFsrfe/bMMR8tS88T8qY87B8BMbSVUJxqsT
	Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hm7dm89jv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 10:39:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/8obWi5nH8kN6wP6JZr8X+o74atuC6Swsw5SrgSH90C917pCSeyZZ8T5B5cNX37FohiMaAswQE0jddOhNztUd9nHTQzUHRkqUE8TxND5Co7+1bKsbdLFwR1DevQU7YuKuUfMJ7HW5UModL1+9y59VEExSx/21on2Q2/CAHYf7rRYygmc4W9oetdOJVq/K5i1CfyzkQ9go4js7f6exZPqolMstNCkk1mxyjgxhXTdUmruGgXDtBEXeXtQQ5ozZW7hRfF/86B2j1DoiIBdASIwfh1c2MHCWpIeycxBwrjk0iiaL3cMqa9nJ8Vb7RQsoE8KA3tNbL6x53MKG4qIcHZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fFEJsI42BULWbpmlMCPrNp6LGj0+FOh4JdpCRq4VWw=;
 b=BR0hgfMXNDxqyrBKIsvGIJsrW8H0q0vOs+IiWYzPCZ6rfbg3FTLtmqytR/eggEEUvzBBo9hTniX9H/P1ggJkwAC7qTuCiOrhSRY0dR7zA0+5jOm0n1k2S0BvbNblwThMqEM6cdbmKBTRjhxN6b02FG0+3qedVyhO23/8IOCeGREr7tr/mtZUoHUeJabH+uUZuWo3nAxtwI7pLasCWtq21nf3tDlO+LYVKKbWMtzL0WOw1NWRE0cbBJkcAWjjKxbcyFrhgsUINuq+Hr+mV+zXive1OWAAUZTuHqersmUb62oP/Yx6zPTsYauePBpArJvNlaiuV/wxmZBlwPRXYK0asw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB5448.namprd03.prod.outlook.com (2603:10b6:5:2c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:39:24 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 14:39:23 +0000
Date: Thu, 29 Oct 2026 14:40:33 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/15] iio: buffer: let the block keep its DMA fence
Message-ID: <auNat2qdekGqqsfj@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-1-0d818334f6c7@linuxfoundation.org>
 <auHAbRpnapYDWF4N@nsa>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auHAbRpnapYDWF4N@nsa>
X-ClientProxiedBy: ZR2P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 762c4535-d4eb-49e7-a08a-08df35ca6cb6
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|260925021911599003|260925022911599003|260925021311599003|11063799006|4143699003|56012099006|261009221227099003|261009223027099003|261022075727099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|10067099003|261021123027099003|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 7+gmUeCB6t5jgW1dBG55U2hoFDsMQmov5srnjc4MiK07mr0cyQrmOyooRhX6j7QQyfFljVjkw0eZm3RpJG9/V/EKhtlAJ8ZHMbTUC+lQs/DYVYPiZ8lMW2zmWl51eDMbEQf1bQ2KQcjsF5EOlhFRcDjd+WwcfXCSBPx3DkOObrGLMHh/o9G9z8gQt/yWsY/mDEHjggBwCB7PqSZ8UbYkKgb2JLtRnjpbiiry4wk9IVownx/s15pp0otZ9aRtOBt2v35L4zs9l+IfgnSiq0emuWqfjrteBBx61cLv52D/Vaa2m59TWOEB353XW20sqF85mQq0er6OUBy/G6BnfZBAyA/cJbKQVxQ7Twt1jv1hVQcZ3gsqPOsqHIN830Y6H1ciyPKM3zFbzWeXsLcIl23ByGsS/5kEGqUBI9fza4CcYolyY8vUm6H2HRwCCplSnKElMixXFF9NU2KijXDyaJ+ciiVj2lHaL93QwWHPYHAUbm2Z6mrW17n1g5pQbbw/BGvCEvkS+ByiYUQmkULWPD2Tvr7ZYYHrUr+Cua7Dw/v1ohB0mNphqV8xDYjsE5hTFLeNOoPX4G3SluueA7OvQGAuRqh4oijHpcsHWjyq4srifH4t8yOvL6Up5RConl6Uy4nx
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(4143699003)(56012099006)(261009221227099003)(261009223027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003)(261021123027099003)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bmZrSlNuY3VUQWFaSytxN0UzN1M5WEhHQlBYK2NUZnZET0prMDNQUzd3eGc5?=
 =?utf-8?B?YWlNOXBHeE12ZmE0MXY0V0tQRzJkekJlSURNcnpBT2Q3eXVJeEYvSTZmNmFV?=
 =?utf-8?B?Q3FMT2cxRkE1dmY3SUFpRDNGUVdVcGF5WU43b0FnWVUxMFFWQ1dkeEZnUkxL?=
 =?utf-8?B?clBDUEkrd3BMS3c5eS9Ra2pxRkxoNjBNWndSb21EZU1pTTkxSnFRWXF2b2ZC?=
 =?utf-8?B?bUloRHlnL21idHp0UlZ3Ri92UXVXZ2hOd2E4TWhFUVE1VUdVY29GZXQzZXgw?=
 =?utf-8?B?bWFETEVVNXQ0Ky9tZ1NjZTF4ODZIVW9OeXNyM210alNzdW8vblhjWS96Y3lT?=
 =?utf-8?B?YVcxM3ZabFJ5UUYydCtkbFgzdnFVT3FwN0p4Mjd5OFlnb3FOOVVERGordGRv?=
 =?utf-8?B?aWFtYzc0clNGRXA3VytCTG9xakNpVjBrOVA4MWJJelJseEcya2tsUUJwNXd0?=
 =?utf-8?B?K0ppWnBYbWp2NUg0NGltMk5WaGN3UkpxYjZQNzVhUEFxZzdWNThIMEdZWXg5?=
 =?utf-8?B?a0NhckZBTVQ4VmpaY0ZpaFFsM2hxZ3loL0pDbFp6UFdMblJiK0UvU1pEZVNQ?=
 =?utf-8?B?dDc3bml6K0tUSnhiSnBqemZSYUpyd0RQUTJkTEhTUG01Y3crY3hUUUx4TGRo?=
 =?utf-8?B?c3I0V01oT3B5dVFlM2dzL2pFOVd2UE5nTUtpRUx5dDNUYmJaaDdRRXZIaEUr?=
 =?utf-8?B?ak9wV0VkdVYySm0rNDlPMkU0TGtSTmlOOHRlL1JGL1cwQ3NxWHZwY3p5bzdt?=
 =?utf-8?B?Y094dEV3aHlWK0htcElqbkdPNTZEbGtBVEV2NTE1eTdMTDcwTmVxY0hOR2ZC?=
 =?utf-8?B?c3NiTGlVMGQyYk81VWpLdTZLUldmVkVUcU0rZVJaRGI2UzBLTTVwcUFOSEJs?=
 =?utf-8?B?SG84QVpQWHZuOWFkWnNSVFpGS2tmdkY2cnFkS0lrNkZIK2k0OWNodUFKaEVj?=
 =?utf-8?B?R1FUY0t3VERXUEI0b05zSHNxUTh6OWdTbWNsMHlkai9SQ2FmWUxBRE96NEs3?=
 =?utf-8?B?cTdQVHRkNDh6OXRqR1ZXV2diR2tJWVdBb1RSTVB0YlYyU3RZTXdJTC9vVFRo?=
 =?utf-8?B?YUR1Q0srVmVadEdDNlpJQnpLWWx0V3V6QjUxMmwzVDBpRHBXS0xHSzM4clRD?=
 =?utf-8?B?WXphRTA0Qk1NMnQyS0NueDJxRm43UjVhWEtmckhaa1RsZklaV0pXbEd6QTVN?=
 =?utf-8?B?bFNYZlY0enFVMHlnS010dnQyS2V4Q1hyeUJWNG5VMGxsaHJUUlVQWW9MVUxH?=
 =?utf-8?B?eWRGaWhGK3NkTXRSZGN3bUdRcEJoVTMyT1A5d3hUSzJ2cE5ZUjcvazNlbDMr?=
 =?utf-8?B?NkpIYUExVWpBQlVRVGo3MW52M2RyRHV3QWF1QWFUeUFuQmtoMjR5SXN3M014?=
 =?utf-8?B?dWZQaktlYXc0aG9iL0dDMTljaTNNY05tRzUxQy9qRmNkNElIdU80LzYzalI3?=
 =?utf-8?B?OHg3NGV3TzdDYjRZMjBwZmNlcTBMNDM4d3p2bUMwaE5ieFpVdTMxRnFiREhH?=
 =?utf-8?B?SDRRRWpta2FzU1o0MDlSbXgvVStET2tqQnBueEg1ZTlmdno0YW5BQlVkODlk?=
 =?utf-8?B?K2lVdldmSnF1Z3dZY29Lb3ZqZ0JHMEdmRDExYTJWcGV6RHdxWjhrcms4NVdm?=
 =?utf-8?B?eDg1S2lEK1VGeG5TSjJyNUFpSzlvZHBvREFnbk1WdjErMDQxdnY2R010M1h1?=
 =?utf-8?B?djZhV0JKbjVLcDZaMm1hWlRydkNKUkJvcTY1Q1daUFRvVW45bkpGYWhkVEk5?=
 =?utf-8?B?bXRCWS84ZjhvRXVDT2IzQVZ2ekxsaE1oeGlMaTdUUU5vdUs3NGEwaHlqdG54?=
 =?utf-8?B?bVlFNTArUUZ2UkVQTE1LTGRDRTBtNTRHU0dkYUFjaGR5aCtLY0I0VWZENndJ?=
 =?utf-8?B?TzkvRHJYMkJXd0Y0VytMS09EV3htZy83bzYvV1EwdmRNWFlzekFabUdkOFVH?=
 =?utf-8?B?c1poT1VVMnZCd01qdksrUk40OG55a0Z2Zm5uamlBbmZNZlVDb1JldzdXbjJU?=
 =?utf-8?B?SkZhaWNNdS9scjVGMkh2WGFOZWdSOGpXVHM3NUh5YzA3cG94eStLSnVoRGps?=
 =?utf-8?B?dTd2a1hpa09WSU9nR0FCa1IzcU5rZTRpNFJWWlFaZ3RUOXVzVGMwWUY0aTFn?=
 =?utf-8?B?enpsQTh0bEhya3d3RTl0b2tqVUdhYXVvRE44alp2ZUt0bzhTN2dmQTh1U2ZI?=
 =?utf-8?B?Q3cxaFlpYUJqYjVBMDJXMlZMZjltV1VIbEFNL3FqbEVUNHZ1cjRkQUhwa3lE?=
 =?utf-8?B?K0pydFd1Z2tnZENrNXdFVlVITUNabllFUWs3ZmR2Sml5UUJZbmNJaXc0S3U4?=
 =?utf-8?B?andPTEZ4QStVdW1UQlF4elJvMzh3aGVnYy9OODNCSk94OElsbkI4dz09?=
X-Exchange-RoutingPolicyChecked:
	olya9+WnOgaaC6M4eA67WhmscVnDFKWM0d4fw/2wvpmk0yDZ36pWNLdgju5J8+NmKFvn7Vvh5RHa9QCOG6p8+JSXivAjSjc/oMP9b9k5wU5cKCAJ9qia5abwG3RrXbjo4ZMGI7oq56A+RhkZvlQCo3Vo64+V+4C/A+0tUQSj/ikwQQb7qtrKhTMO+txRXgOwwyCKEflv2fb6gsku/IX4iwxCglbVOfEK/UGToRuh/s5N4PxzNwZ3Et1hCUALL2m134tCG6IOOzqL2jZ9mpPiY73ZifuuI0a0Zd8Piu1MWOP/bQgQJTN4ZS9La2T/M0eJifGAWMR4P0npQfyNqh5PAA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762c4535-d4eb-49e7-a08a-08df35ca6cb6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:39:23.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+7x0FfuBg0W5ju8lg8kpufjROt5l/5QwdUx0Gbi0tGdPRT00xCbJ67xCf0WhBpbt4HdXvjIgBlLOwoFK4b9ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5448
X-Proofpoint-ORIG-GUID: d5ajibtjsp63YMmyqZZlt7S8dAowb0Kh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1NyBTYWx0ZWRfX/Xd+Z8TKQEq7
 KsO4nieYK0Qn9Y61dlVOt/ly9CIi2nRUhMGNuOl9/cCHGTkJYVC45zZNvLCFTUn/0S6fnluFL8K
 R++aJ20RlTTgou7BXZ1MYdYpBHwJNnrK7mQK+ZtP/zKVU2neDRNM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1NyBTYWx0ZWRfXy5uv5S2pnoHk
 TEuS77muu/vMEEMGLu7V1kXBeprmP/bEq4OFZFxkJct+hBexMaySblz0Epsyo1Fcip4eK0tMMcS
 QyDKuVGH2RsrnrcJyQJTCpKrwCGqh46M+vNVC3VeJQmzY6RrPrguK9weODaHdDytCnWTfQGS65K
 rR6MAN6Pyni1jxig/Mi6nHY2ngj3wJRGMQc09NCJP/lJt1IkYGxKzMuLRyj+DkfUjSWN3jVq64F
 Jvy9W8lhKa8H7n7XpBFlT3YujQhDkBGB9ddO7EEGVqhuw2FyawvdP/QTlyxmRlDoeRM0DJV2tr/
 Ucb7kW09hdoynlXyaa/KzhtMxXmYKERM1K4lAa7tRzZuF/j0g6MpvV78UrbZ3Mr10EvVCnCG9KB
 fcrJuB6F/9eJsTg2NFnzjVQTL8To+PLMtmjHRRR5iskx8qjn0g4d1f2LZKW2rxT+v7G1N7lUqE+
 tKEGvjg686WxTFy+65Q==
X-Proofpoint-GUID: d5ajibtjsp63YMmyqZZlt7S8dAowb0Kh
X-Authority-Analysis: v=2.4 cv=O92sLx9W c=1 sm=1 tr=0 ts=6ae35a9f cx=c_pps
 a=NYwhZoOBzU3e7w62/nBhxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=P-IC7800AAAA:8 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=ER_8r6IbAAAA:8 a=ag1SF4gXAAAA:8 a=FEMb5lTiUdIB1wFmTPIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=qR24C9TJY6iBuJVj_x8Y:22 a=IawgGOuG5U0WyFbmm1f5:22 a=9LHmKk7ezEChjTCyhBa9:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290057

On Wed, Oct 28, 2026 at 09:30:19AM +0000, Nuno Sá wrote:
> On Tue, Oct 27, 2026 at 05:19:05PM +0100, Greg Kroah-Hartman wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > iio_buffer_enqueue_dmabuf() hands a plain pointer to the fence to the
> > buffer implementation, which keeps it in block->fence, and since the fix
> > for the fence leak it drops the initial reference right after
> > dma_resv_add_fence(). The only reference left is the one of the
> > reservation object.
> > 
> > That one does not last until the fence is signalled. dma_resv_add_fence()
> > replaces and puts a fence as soon as a later fence of the same context and
> > the same usage is added. All the fences of an attachment share a context,
> > and an enqueue on an output buffer only waits for the writers, not for the
> > read fence of the enqueue before it. A second IIO_BUFFER_DMABUF_ENQUEUE of
> > a buffer which is still queued is refused by iio_dma_can_enqueue_block(),
> > but by then its fence has taken the place of the first one. When the DMA
> > is done, iio_buffer_signal_dmabuf_done() signals a fence which has been
> > freed and schedules the work item in it.
> > 
> > The leak came from the reference which iio_buffer_signal_dmabuf_done()
> > takes and iio_buffer_cleanup() drops: with it nobody dropped the initial
> > one. Do not take it, and leave the initial reference to the block until
> > the cleanup.
> > 
> > Fixes: a09399935508 ("iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()")
> > Cc: stable <stable@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno Sá" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: "Benoît Monin" <benoit.monin@bootlin.com>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> Patch looks good to me! Maybe Paul remembers why all of that refcouting
> dance was needed. Like this, it feels more natural:
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

Also suspect we have the save problem in the USB side of things:

https://elixir.bootlin.com/linux/v7.3/source/drivers/usb/gadget/function/f_fs.c#L1741

- Nuno Sá

> 
> >  drivers/iio/industrialio-buffer.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 4294101810fd..a2386dba497c 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1931,9 +1931,14 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
> >  	if (ret)
> >  		goto err_queue_unlock;
> >  
> > +	/*
> > +	 * The reservation object takes a reference of its own, and drops it as
> > +	 * soon as a later fence of this attachment takes the place of this
> > +	 * one. The initial reference stays with the block, which points to the
> > +	 * fence until iio_buffer_cleanup() has run.
> > +	 */
> >  	dma_resv_add_fence(dmabuf->resv, &fence->base,
> >  			   dma_to_ram ? DMA_RESV_USAGE_WRITE : DMA_RESV_USAGE_READ);
> > -	dma_fence_put(&fence->base);
> >  	dma_resv_unlock(dmabuf->resv);
> >  
> >  	cookie = dma_fence_begin_signalling();
> > @@ -1989,18 +1994,12 @@ void iio_buffer_signal_dmabuf_done(struct dma_fence *fence, int ret)
> >  		container_of(fence, struct iio_dma_fence, base);
> >  	bool cookie = dma_fence_begin_signalling();
> >  
> > -	/*
> > -	 * Get a reference to the fence, so that it's not freed as soon as
> > -	 * it's signaled.
> > -	 */
> > -	dma_fence_get(fence);
> > -
> >  	fence->error = ret;
> >  	dma_fence_signal(fence);
> >  	dma_fence_end_signalling(cookie);
> >  
> >  	/*
> > -	 * The fence will be unref'd in iio_buffer_cleanup.
> > +	 * The reference of the block will be dropped in iio_buffer_cleanup.
> >  	 * It can't be done here, as the unref functions might try to lock the
> >  	 * resv object, which can deadlock.
> >  	 */
> > 
> > -- 
> > 2.56.0
> > 
