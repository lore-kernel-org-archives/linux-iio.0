Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCE30F548;
	Wed, 12 Aug 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539562; cv=fail; b=AOePkfC7DelP4l4cHvYP5maDHUJ0VvvrrNV8PG5QjrcH4JX/aU714Bty9F4wVS90wlw/KBfHwywbHSSbLr4ddStEM7ikL3+UmEtYxsNBDu6VtVAc8Mz7xE9XJLUTfb9JnbwtOrZ+QzZkBzd4atpIJQrxXcKGxzl2FCs+EDiIpVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539562; c=relaxed/simple;
	bh=OiEgcCnBG0XK60UdrpnwI/KP2LmTuvkE4jkKPukCABw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cXIRAxGx2iC+3uNROwPVp/3k0EkgcpF7uNOgvnP4J9pnmzPBoLBwatQK9ErbC0dzr8vEwgx2vO/GJk6cG6lQNGNXP4mEbg2yi2Xi7aHBXP2Ez67iraAZabSdrtGoiEN6xdsfFUgOG+1PZ8lzyQ4l8eVexipwC9Oea82JCWayjXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jAbucpPL; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jAbucpPL"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB7HLE3556456;
	Wed, 12 Aug 2026 08:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0fOyg
	9dfoiz+zO4uI6+XJxySkq7y995BPbF/r27s+lI=; b=jAbucpPLLZMR2k6L7C6TY
	fAPkzoP00/qPglwPKuixcYmp52QiDQlo+bjMaOdyuzABmyg1+olTiasn6dMgHUxn
	YoXTss0KzpAdNrzBNwrgnokglzhCDUFdirvL/WxZ7Trid+e1ljV0ySUCqhR8VgSO
	ZnmdTUHA+GVpexIdhxseKm6fPUGEC8H7FoHzIQs2BXOUhtuShjqTj+LPfvvhYBWr
	A31tWMV6o7BX4PYSv9thhY5644a0wj3A2B96epRgbBIJr4euLdre9x2OlMwOL1kf
	PxfOeq9TfsA0NVrVSeCHHRWbn1utwR1pkVRyAzPjBD9ZoYQ+Nw+TSlVA7SfnHZrX
	Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g0qp88bu6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:58:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rch0J9e86II4etGrrkoAIt97KwcY9/A9/LxloBdlPuYZyPl/Hx/o5CuHpWEAuq6XEljnL58Il9PGZLi7gdQlPd6srt8NqsrPI4i5Eqr6JwqvYvi/i4lsNitwvNprJjmyGmy/s66IdDlVekXRbRqi63Uk4NHHisIRtaaMZTKcAAV1RgIHQJ3lBimogQQzljhWgddViJLqWUDY/NIxj/MGFsg1AoYL4gVEnhAi2ElQc3fnOI+yqaPnEIIBUu7DAIYtYRVyLSr50W7SkBnABfamh6b42NO2KUYnjFagnSY0VkR1NpOQnb65FmKTLRcErCibN8sWdiRhCfBpp7K070nHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fOyg9dfoiz+zO4uI6+XJxySkq7y995BPbF/r27s+lI=;
 b=Wq/mRawphkncnhLxOrYOECxlh1sSB6Y3ERA5zyOGB7dHfkI57iE+12EQMFQuNRZX4HOyTyqWYw7K1bAW3JppC7+Tat/CMPu63YiYIIgOHGmzauPBEb1flU11WrTHJs+MLHRMLW0A/77qf/2mqlPxTdjl/OLsLg0izkvzQTohgJoT4AjTF1H88I3ioZ4mfmamI6KK6dCnH3iq7Ax/QP6FqwvNX+VS6LmKVLy2rEfxoR4xbJ58bMQSPMtNJRmTs/Eiz8qBDcG9caFpGWq1IfcKxo9rQDcFJDt9022EAdHaxiN5eNF5QgBnZTZd++LEpuV9XMjpH7Oy4kXd5jd1hDzs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV4PR03MB8258.namprd03.prod.outlook.com (2603:10b6:408:2db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 12:58:50 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:58:50 +0000
Date: Wed, 12 Aug 2026 13:59:59 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <anxt4HO1V7HPg4Z1@nsa>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
 <antirKIhG8iaMqNv@vaman>
 <anwwrvNLP2OujnWd@nsa>
 <anxBgJZH57acnOZr@ashevche-desk.local>
 <anxasgXZsSKzvxG9@nsa>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anxasgXZsSKzvxG9@nsa>
X-ClientProxiedBy: MR1P264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV4PR03MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4463d8a9-21a0-4dbd-5625-08def8717443
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 8AxI+IbYU/9i87GQpxfPzZo+fMVqudcdA0M63Z8Xo1PVzzI+l8GgbGFFsy/3FpMutHHAq7rt8hWiu3ouGsGyQkv7zydshONxqVcjQSywTW5va6rjupqmQsiW/7EyUaEqR/My9QuXoXQFAUf5RwdJec5eYdJgcUHD4LV9GasQ+6ZncMadTebFtuGP9t5qGYjEJLekgWbsfnoEypWOVGMLM2XmkNghMWsKqwpj2rTcjb+hCloFxA9qTiPxaFmW7VUymL613LMGKMD1PJ5dHOL4sYNp1Np474m8hnK7/jYZRbn3R8qFm4xebBrB8/V0HxdzDzQKrWiYmCx5Cg7cv7OBD6meTzzdW+5UXLlpOuuDkSla2R6QKvHxrWxvjj0i6Pm+ZwtesOqwhHhjf/MbwArjna8MG8mZmUbOp26+OyYga6rWj3Hv9BtQP6JmPmhtemM/6OST2ho+cdr9hUzBUmJJL42f7aYOpTM1RUmbHWQC7I6kf5r50meFh06z8d9EiLzazO5gAEJV4A3N6tCluyhnmAoOSpa8bQkfYHLBgjY33Z1K+en9SMTiljWxsG/PL2IO7bOfrS3R1LKLoDj3hBZF49lmb1DPBsXyPrZlELSLiVxZe63E+RJI4iygXkv8i4GEIqoND/rPncT/bQKpLXZujQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WjhqRmt1b2hMamVBSUxSODROOEMrTzdORmc3UU1DYTR1ZjRBRmF2VUpWa3cr?=
 =?utf-8?B?SFNZcGNBaGgza080UnRqTVkraTFhK21iU3grT09ETjZramhhejYzQUhxdkR2?=
 =?utf-8?B?N3k4cUIwSjd3VzhlRGhoQXFWdmN6ZzA5VDEzUmw2Z1VOQmlJaG1iOWRqUk9X?=
 =?utf-8?B?QXVQbnZIYlRTUzFjbUMyYUJITGpwclFPbUIvRG9vSTI3dmwrdVFsZTcyNEV4?=
 =?utf-8?B?Wi9DWm1RcjNsMXk0NitEdElRek9qM3RQQldHZGFKb241ZXN5alFUSUlEVUo5?=
 =?utf-8?B?eTlES2VxNkt2dG1hbW9yZTl0Q2xPMHBnejlSaEZTRml3bDVNaEhhNmZSelB1?=
 =?utf-8?B?ODVRMGJXdTJqZTYrUGYzSEkzRkZ4R2NOODZFbHdDVlpZU1V4NnNuMkFQYStw?=
 =?utf-8?B?djB5ZFgwKytncEZEeDZjb0pUKzZXQzJGNCtPTGhkNmVkbGVmbmI4ZngyYzJP?=
 =?utf-8?B?eE53OUExa2NwWVZBM1JlTkFOTEgwbEF3MS94ZTRkMFF2bGFmUVRqbkxvS3Iw?=
 =?utf-8?B?UGdCNEFkQ0pFTFFjbDltSXFrOHlBS3lQV1dwSnN3QVNrMW5GdjByNDFuR0hD?=
 =?utf-8?B?ZlhlRFZzZzdaamZTT0czbjI3cVB0WTVoMElkckpUdVZtaCtkU1cybzNZcTF1?=
 =?utf-8?B?ZFRiRWFSRmRpVDVFYTJTb2REWmw4TU1ZWDlQazNRSWFiUE8zRUQ0blA1ODA0?=
 =?utf-8?B?L0JieTVUNEp4VEdPNFZZMi9qSWNsQWVyQmxqc2J1L0o3aUJIZnZuTURJd2xX?=
 =?utf-8?B?bFNPN1NVanFpQm1Vd2VFdFVTY3dYbjJnTVpUWkoxcVFIUEdHZk9HdEdvMXIx?=
 =?utf-8?B?a0JESFJ1ZEY3WEtDeHFBd0tEVnFYMGZxVDVUbm41NDUyVnJBNGV1WkxScnBP?=
 =?utf-8?B?TytEVmdUUURwbEJRc0NaNTVPTC8rUWF6VUIzV1lRbHh6SjhPeUtLMytBMTZm?=
 =?utf-8?B?N1BRN0NyWjNKYStmb0NrVEg2N1h5VVZqUUs3Lzd5czNpcnpRQWRyWmY1a2k4?=
 =?utf-8?B?Sk1SQzRlOEtqUGh1bXFJSDVmQ1YxeFEzMzYxUUd4ZmtHYjFHWFFEbkh3ckxD?=
 =?utf-8?B?NlE3TW1jZTRJWlNXV3lzTHoxa0h1SDdBOXIwZ0tueTlpeHZsVUg0YkhCZVFH?=
 =?utf-8?B?ZVJ5SXpoc2UxVk5OVzR6Y05JSElmT2dzdlRHWGlLVmdqUE1nS3FYdXRJSTBR?=
 =?utf-8?B?T0FjaFgxZFVzT2NwL0llVVRhTU1HVC9idEg2bXZ0NCsrdzdPU0FNNTE5TDhx?=
 =?utf-8?B?eUc3dEVaK3doVjQyOEYwd3VQS1hLL3VBREkrSlYxWlUrSnFBSlE3RWNUd2xQ?=
 =?utf-8?B?aEhFY2dESlpMSEI1dkJCclpVZExPZnlSUjUwUG9OaUxXamNOZSszZmVrVFBy?=
 =?utf-8?B?NlJmMmJlNXc5YldQMzM2aVhES0VHNis4NlpWS3huN0ltM2Ridm02LzNHRTd5?=
 =?utf-8?B?eWlOcWU2Z0RvRlNQczk4azNGMWJTVkI5VnZuRjFZZWRGZjdBQ0pEOEtldlI5?=
 =?utf-8?B?Skw4UkVadmhmR2w3WUpHOE5iWktIdkNkYmp3Zjc0TEQyMDRvOWtRRVYyejRW?=
 =?utf-8?B?Zm5hTVZNQVRMM3lBcmlFbk40WC9hUU8ybEhXS2hOS0pFNWNVK0FMcjZZVzc0?=
 =?utf-8?B?bFRuN0xSdSt5aEtvUmkweFNMcldhNzRPS2R5NWp6YXlqek1TMFNpR0lwRzVE?=
 =?utf-8?B?MUtEbTR3Q2tkN25LNnB4OE9DZU1TS2pVSks1Tjc5WkFURFkweHUwaUZ2Z1V5?=
 =?utf-8?B?RXJCZWJmOUp0emdaYnRVb3FIOVA3aUgyODlMNDVvaXd1YUM1RlZnRXFlUGpK?=
 =?utf-8?B?eCtrT3pjRG52QVpKZ1FWUU5nSmFhUHVSSlRpTWxmVExOSC82STc5ekVYODNy?=
 =?utf-8?B?bzRieWs1Nm92SGVsTEFobDdYUGNreHRlaGxtZCthRmJ3WHNIR3d5SHMrWjlt?=
 =?utf-8?B?cDFhQU9oSVJXZ3BKVWFIQWxVYVJablQ4OWZBT2ZGbnI5OVJTTjliK1pIZzVS?=
 =?utf-8?B?ZUkzaTFQc1paYXAyWVY2NGhQNHViMkJBR2JtdFdZc1A4RnA5MmJacW91OTFN?=
 =?utf-8?B?dHZsWlBsb0svejUvWUIzbHp5TEtJN1dzUWhqc1VXUG9MaVRRMTdKZGxoTmRO?=
 =?utf-8?B?UzNteTdZdUFCTFFGdWZXbWJnMC9VS0QzWHNFMlNHSnE4QVZZblozZjVpNCtL?=
 =?utf-8?B?RENZeTVwNCtCa3AzbWlkWmlhQm96alFFNk14N0pRblF3SXJpRzB1YS9ySXpO?=
 =?utf-8?B?eTJFTE5jVUZJYjl2ejdZc2hVYmVneFp4RGQzK1JZZWMyZCsxY3FyL3pYZWhI?=
 =?utf-8?B?UVBjaFJObmN3d25LaHU1eUkrTHpDTHY4Q05qSk50WGFXRkVieFZDdz09?=
X-Exchange-RoutingPolicyChecked:
	UZIuqqQC2oVEV9IL0ldwGNNh92udSItSe4idBM8isB+HYUVP9BN+0iWXcfKF5evWrK01QRUvGMiWLqEBDxcWos07SUZKWPwNDz3/toqrn0EFfjXhSVCGcD6+Va4L8ULdmjRZ0NovRWH1zeYKyPsUpbTeVAnZqOpipxC/UVkdOs4jhtDq9MlXDTjzd+NZuhpyDYScztKFoO/rbqMzpsBqGifsYUdnsbN3cvAJS/t4EJCGJQf4dlIpcyp3gLcGqmE32/J1n0+1RLejDWBwcdViAj1zWnsLafCuc2T9xuRtIz3S1frBT9LHXm+vg4iHV6SSDNbCpItRnS+uWqUHptMW9Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4463d8a9-21a0-4dbd-5625-08def8717443
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:58:50.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLtX3qqAqdU1dMEgzNibgHFSAkpzA9FXuFVG2MDzTEMvPGowEgmKPjrYuzAC1l4UbvorEFXE4usmzUSuT6tc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8258
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX0Z07O/6dIdO3
 RkKu5EmhJKzg9DBBTg3pL6c1EcxJgT24DAxyH/f8RNb4esWseRoLQRxqW4o0U4Ujz2VFxXumKTp
 rzY4jmlJh3vmglg7nNEzP9SPwS/B8+esMKS9ZC7PxioTJbuI49yD
X-Proofpoint-ORIG-GUID: mQmwlBFPoDBsYkBkWD4W7C4-CWJkyNVM
X-Authority-Analysis: v=2.4 cv=PuSjqQM3 c=1 sm=1 tr=0 ts=6a7c6e0d cx=c_pps
 a=miuBlqXM8bFb40OTON37XA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=B-oMf-06ae7yJy23Gl4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mQmwlBFPoDBsYkBkWD4W7C4-CWJkyNVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfXxdIWy4gqJfhR
 x+XqeRZo6i9Fld4eYCAmECtAHOPpqh+VkFT+Al/dZSvWj1TaN0xo+ag2XGKtO9Fu5vBgQBpmffH
 UMidLNk2OeGpi90GH6Er1rlCtSIK0652GQ2nsgufeKkrtcqc0ZlwUcI3iCNXUwM5r+S6pEoeqXs
 /wFLCHgIAVSYTCumkGYgQj/9mNIE4wPfgCHs3bKIXG7iWPQPi6jK2AENS3ww1r9HIDpdkjM6/pS
 Ebhf5AH8pYr/cm3a5hjmtP7VVIGq24HktMf8ahSYKT21mXEcwtQeWD2R1CRm6dwvSSAqXhmeI3s
 0pudp/qiCDBsj+lgo+kliF9P+8aSdsmqUwOydPFpo88Nx1xEy00lJ3VMJfTQQdAGkfdEsOiXOYe
 CUCfHNkAzESm5onzUHuXnhvS8fLrGkB4urYplkfhrPZPGedLnjre/cfsIkaDVydYMljaCFbYBUt
 U+ctxZSdgwcpuG3wlQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120106

On Wed, Aug 12, 2026 at 01:18:41PM +0100, Nuno Sá wrote:
> On Wed, Aug 12, 2026 at 12:48:48PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 12, 2026 at 10:08:34AM +0100, Nuno Sá wrote:
> > > On Tue, Aug 11, 2026 at 11:28:04PM +0530, Vinod Koul wrote:
> > 
> > ...
> > 
> > > Just remembered that bitmap.h is already included in dmaengine.h anyways. bitops.h
> > > is because of __set/clear_bit().
> > 
> > Oh my gosh, true! bitmap.h implies all bit ops, so no need then a new header.
> > Indeed the whole hell is due to dma_cap_zero(). So, while your patch won't
> > change the current state, in lieu of the said previously I would like to have
> > a split, but since dma_cap_zero() is used almost everywhere, perhaps make
> > __dma_cap_zero() an exported function then? This, of course, can be done later
> > but if we start from the more mess, it will be harder to untangle, so I still
> > think the separate header is a way to go. And perhaps these capabilities also
> > can be split to dmaengine-capmask.h (with a fallback inclusion in dmaengine.h)
> > so in the future we can only include it when it's needed.
> 
> Yeps dmaengine-capmask.h would make sense to me but as I said, I really
> don't have the bandwidth for that!
> 
> > 
> > Looking into the structure of the include/linux/dma* I even would think of
> > something like include/linux/dma/engine/*.h with include/linux/dmaengine.h
> > to collect (for backward compatibility), where the first citizen may be
> > your API, followed by split capmask.h.
> > 
> 
> Ok. So what you have in mind is something like?
> 
> <include/linux/dma/engine/buswidth.h>
> 	#include <linux/bitmap.h>
> 	#include <linux/dmaengine.h>

I mean, one way I can see to avoid the above include is to come up with
a new type like dma_cap_mask_t. Something dma_buswidth_mask_t...

- Nuno Sá

> 
> And have all the inline helpers in there.
> 
> I can go with the above for v3, yes! But note one thing:
> 
> enum dma_slave_buswidth
> DECLARE_DMA_BUS_WIDTHS()
> 
> will still be part of dmaengine.h and what I could do as follow up is to
> move the above to something like
> 
> <include/linux/dma/engine/buswidth-types.h> or maybe just have a generic
> <include/linux/dma/engine/types.h>
> 
> Generic might make more sense given that we move around 7 typedefs in
> dmaengine.h but I'm not so sure about the enums.
> 
> Then, we can also do the split for capmask.h as you said. I can do the
> dma part of things I can't just commit to change all users in the kernel
> for the new headers :)
> 
> (Ok, moving the buswidth types into a new header might make sense in
> this series - if we agree with that direction).
> 
> - Nuno Sá
> 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
