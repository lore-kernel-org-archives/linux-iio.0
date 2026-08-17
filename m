Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07A3C2B92;
	Mon, 17 Aug 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956120; cv=fail; b=aYHNY9bOrAbuioM77zj+jTK10Oahq8TfVJp1DfJUP6iuR/MV+SDrGXztTOTADqb+M9Wg41pOA4Xt4fBwFK84i27V+cmqbtRJJSkuzeagIpfmX/Yc6O3771lWld0Bh692Pl3qdwMZ9uDfxvg7nDknZk5/NUMB+hEqMDdrz7d/eMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956120; c=relaxed/simple;
	bh=rVIXTdADkUrRcSfr7dlg4cPnIwzvTnooQNmR8g+0mLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eiRs9zfPNWTFUF1hHSjCLlRMv7MXuOSwOXMZwhY0lFgwglTBPflXL59LGb6e7XmjrGBpFYWk33Vxv2V4Xwpud6Bn5rFzcolaPRYEs6UOGBcuN524fMi9juO4Wm6JxGOnwIWUwb9MiskhcbDSnMkkDRZ1BiqGwO2JIPLAFvgZeAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y1v6jolk; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y1v6jolk"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H71OGa2809656;
	Mon, 17 Aug 2026 04:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BM5OQ
	GQ5UqthL4GZbidO+4xG7TyqBsXF6RZvxFDlYBE=; b=Y1v6jolk7qklbPcNBtYz5
	f39bNAoNPPPsqdJ1rdOAc1DundtGQaTyT3Vmtv2x++KMgCy1albGT+MngtD9wLfc
	ptAvlzjOHaG8oegt38F+CEzDhdSArvhH4BAhPZgijpp+5lZJm78nzwsULQd4wPd+
	FntmhPdyapThmWa02LJnM1JrMd1ursp18VZ6d1YYuYJ/fU0Eb1D4vHjwhuq3vBa4
	3/180IkXCZmzwYmMOa3RhT8cnLIP7IBViQXDq36tEYJWeH8RnglBkyuI83i20Seq
	Tt+4ogkxAOCzJNxQ7YL/PfKVZDoPUzIbS+qqOxSBZ/q5f9uvZ//9ST4AE9XPF3Ye
	g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g39efktvd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 04:41:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNg2MZcMzppfkyBBJ7wY4w8au5Xfpps/yeb0TH/5LC2CM546zflZOAiAvM8JrKeMnOuHMbbsvbR6IYj1W2X0BPlwfY9sacJXoyeJiLxqNv8SsozC4kIhtmTxGDlQ00iGfN33TQsIhf/EWdnMTKNd6KWS89wCDYnqH/bzPqtREEzLpcJLTzp2aRkDmccQXxvnLi91A7Gq0E/dRTUuL4Tae8RT7kxwlahzAYESwukw/JpEjrVMv+VUGOz37k7Vx6XptWloaVY+L0GH6avNvr/mxDD4bAlF+wBBhLW2fgW+wyyiW+eWkRHeYTxuo2wfahdC8UPGTzHMSH4rHZC2Ox8c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM5OQGQ5UqthL4GZbidO+4xG7TyqBsXF6RZvxFDlYBE=;
 b=M94RwkrMQOMkYcYCHZ1mTJIsxILcmV+cIgNImeNN2ggHI5zIUE4sJYVa39c0Q5lcct6Cw1L6KbPwHB2/CPrjJ3NDP2rgFOCaphhLqlH+PO1qnoiJJW2FR9MC16icKZNga9EDJBsRHLUvHNk5Q9ait5olOCK/HVm3z1Vrh6vtGgmzJq0PJm9jwQhiwQ4qh1jY9H3N34gxsgPMPaU9Fv6Z44WME4wy3zsnnxSvtnmhfkxxYeYkhwvgwqlSI84kFGMflM8XdIWu6POkKC0EFzwiSMbepFNmDE+drHqv9I0+hQwYgnyO3o/olaLIPzVmm1u+T1VxNHMYdMEtZPiEjgiK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:41:53 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 08:41:52 +0000
Date: Mon, 17 Aug 2026 09:42:53 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux@analog.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: accel: adxl367: add support for INT2
 interrupt pin
Message-ID: <aoLI-TVgOD4PqVHj@nsa>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
 <20260813081452.4289-4-antoniu.miclaus@analog.com>
 <178671050969.21598.13163934753300429850.b4-review@b4>
 <20260816014959.18034ff6@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816014959.18034ff6@jic23-huawei>
X-ClientProxiedBy: MA4P292CA0005.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ddf662-ca78-44c0-f3ba-08defc3b626c
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|4143699003|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 KMFHcQu00njE01zdX4el1Dj7A/t6Srrg/YkcELS/txgcHwq38Ci80Hpzvy6QrHQ/YQDNqa6982wUHlpaztoXGDXpg+MeOWTasdgiZt7Bz1ieTB34gCroGywHawzoOpbpQhxFq16cSJLjVMnfGH4DcWZYKSm6OfextPgwQZHpmmLdkOSSJuLsrTouv6hmDGP8KQpmW6KNtoQq/ZfAh7aguHn0v7QpCMH0+KbywnHOHpvkckE44BgslWr1ZImocaX+un5er0T3rVvjgqdAeq8F4U6/QLA0TQYJ7iu9ha0HuAv/yKwv+0muQNcoILLDXq/5j6otXpWgeeQX3jK8Dg5HCgC3UacCR8iGbcA2Aao5dLPoeql0hKZaNICQNZQuKIiNnP0vRb5HA6XEgF6zxD9vhuYRpnhUYQb+w1BqEp69lhE0cSCyv2rZC4PAVhbSj0O6/S02jQQI2Eh1MQN63APCzo0N2wrYwpJtXyRCRF1ljyu9E+Bwv5F+dbNYEe2bvfEz3TeHSe/y6tKzwrw+eWDjLAhNneRe9Qh+FQVb3fnTDmn9anO+TfAywaTq+DjQYoWiMJ+tmbdcR9SGcNvHOgzEJps1SVWW0q1uKehiDYCXUBA9+FTvAdb73qplODndgBN7twL/ciIY0hD0gC+7tsRAZdZMVhNYrBnOxTQnZFggCaE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dEp0REdDbnRBYWovcXNkeGo5Y3NOL1FieWw3SGRKRHlqcVcxeGRibHZITnNl?=
 =?utf-8?B?R2hPNnNtS1M0TjhmT3NpcGp1RENoVE03eUYrRVhtNWFKcDI1dmRGNDU0SWFa?=
 =?utf-8?B?V0V3Sldlcm02LzRyZ0JUeVF5RkhiaWhGWVJGNWtZNThTWGl5MjZXWldTZTN2?=
 =?utf-8?B?TjMxWUJLbjM0U3JEL0g5U3ViRlA2cUlyUjFxU2RuNGkzZDd5WkxOMWFTVFgx?=
 =?utf-8?B?T3VYdXhmaWhrQ3JPVVNXZitibWF5QjVJdzBMZjUxL3ExN0pBREQ4ZjZWS1dJ?=
 =?utf-8?B?WFVpc2VpVklUck9VUGxMRjNKTEIveFRJbVNPYlJSMmtVRGhHaDMwQXBaeUdq?=
 =?utf-8?B?TElrVkxYeEgzOElpYXhDd3gydFRJWlVlL2szQitmYjBtdU5YVXpUdVk2WVA0?=
 =?utf-8?B?QWo0THpBOWd0aE95dnlEQ3JWRENsYlhkV3Z1aGNMUmxPSEZQT1ExVTBEOHNB?=
 =?utf-8?B?THkwaDUwa2dkWld4OXZnQ3A1dlhUOXIyVFVpZnBId0RxS211WEpabHpYZS9L?=
 =?utf-8?B?d0dYcWNkNUQyYmZUR3d4T2lRTENvSklLb25RQXRKQlArc2FiSkJPenpEU0JF?=
 =?utf-8?B?K3V5L3dXR0FjVjF1bkZ6MUZuMTQzMElhS2pLV1NPby9uMUxWK2NMaCtLV3U5?=
 =?utf-8?B?Y0ZsNWVNdFQ1a25KZnYzS0JuZnEyRVE2c0U2ZlNTOWlWUGlpYjJHV29mMGFQ?=
 =?utf-8?B?OTVlMjJGbFBnM01aalpyKzVLaFdNT0pXSlZxMkE1M0d5dDNMeFdZYlRSdjdT?=
 =?utf-8?B?TXNKUi8yZWhMK2lNV1dhcUhueHpranY2RmdJeS92MVRnSzk5SXdMNkRNUzNz?=
 =?utf-8?B?YXRSUWMrdXNRWVRqQXl3cFpORXBHRlVkVHlWMk04bFc0cVBGZmVGTG8zWFhW?=
 =?utf-8?B?dkgzUkNXRzRYWEtOa1JSNEw4c09EdTJhNEdSa05ndlpWYU1vL2M5TEV4UnZ4?=
 =?utf-8?B?S2w1a1RTcU1xWW5RTEhnN0VmaEtKaitvRUZJdDVTaHdCRmlidi9iV0xMRkI0?=
 =?utf-8?B?TmpvY0JHOUpoR1MzM3VMTk5aZ1VKNjJ4QlZLRVQ5YTdkOElQUXBUZ1VEanRR?=
 =?utf-8?B?S3RJMDAxN085Sk1BNXJiUGFSU0FFZm9aOVEzNnpmU3pWREZScmJwTlRZK2ky?=
 =?utf-8?B?TVR1Z0pyRWRUQ0ozcVNHN0o0NUE3L0ZoN21PdDl0TGE5UmZBbjI1VkVkNHhs?=
 =?utf-8?B?MFBINjl1TzJ0OE02Z0FITnltbmRMTG1vSlVCM0xmT2s4S0pLS2lxMitlWHYr?=
 =?utf-8?B?WVEwTWd0L29RNEplbVlxMWlDaTFkcFFlV0dOTHNPeWtYTWRLQlB2aFp6Qms5?=
 =?utf-8?B?Tkk5dUkvNldwZDk5UkZnUnZCZWFMdXZGdFJNd1pMZzhPb1dIcUtIWTQzRmox?=
 =?utf-8?B?cHV6anhEZjZpQ2J6WFQybURweGx1UndBT3FVaU9qMFQxSUphR2Z2d0JuWnYw?=
 =?utf-8?B?eG5CY1ZTUUV3V3dZRzNCazNZVlF5bDNOY0hiUVEvOER3Y1JsRlcvUHdOTzYw?=
 =?utf-8?B?U3hNMStRZ1lPYS9DZ2V4RDFTOVl5a3hwWUFkcExleVppMXBQVHhNWTVjMTBi?=
 =?utf-8?B?TGVKNHZnT212dVV4MUVjRHZCUkErU2ZUV1JHZUt1cTN4WEkrTjlVQWZYZDRk?=
 =?utf-8?B?cjBRK2lQa2xuTkhrT1lReTMzVHVzV1V6R0NMMHBLY0xlZm50cUIzdGF5NWZl?=
 =?utf-8?B?RThIai9YYUo0NmdrOWdyNEQ0VTVhaVZweDh0V05qMVFrSUpyd3lWZGlzQjZs?=
 =?utf-8?B?NVVyQ2loUVFqallHSEFjRGRsZCtZcjhWY2puWkcyQzNXNi9tNDR5WWltZHly?=
 =?utf-8?B?MytvY0tOaHg3aks3YmZMVCtJK0hiQTNVaXBjTFp3cnZMNnhpR3NpTEtWaU9V?=
 =?utf-8?B?eTI3U1BUTHd5SC9NSU93M3VxcmdqMnduQkhPWVN0d1NFQnI0UUF2YkxRanlS?=
 =?utf-8?B?a0hxeVB6VTVzK1dtT0NRa3lIdnBId3RCbStkd25LdWdjaEpHL1ZjZXpuSmU1?=
 =?utf-8?B?L0NraE9weVBaNmVncHBJcDhJMEdXU3pyS0FNSlFLaW9QRFpuVEtseUJabENr?=
 =?utf-8?B?bmJyUFByWFMveWNBemI0a3hkNG1pMzFOOWdiR2tKa0tqWXRZc09sZHkwRy9O?=
 =?utf-8?B?em95VFNCZnEwR1haMHdMejdWODJrNnR5TlROSjYzRXpOU0xFa0xINGgxbDd6?=
 =?utf-8?B?L0FLaFo1bU1SVmwzdHF2SlNKcmsweEZ4MnlnRDlpK0w3VWpWcWN1NXo4T0dJ?=
 =?utf-8?B?SGl5VzFOMjBGUkxMajRJRzFtTE44cWpud1NCZ0llN052SzRuY1R6c2pOcHRB?=
 =?utf-8?B?WG1iQlJxajVsdmRDQ0crNVJSamVNT24wUzlDbXhFejFDdGhRTzlGUT09?=
X-Exchange-RoutingPolicyChecked:
	rILzLjmjm2C/LqSvSFfWj/zy8ib6hJ+s1NP12x2oitCryxL3xxXWRwhFN4wZN/w6bmh09tWn5zjoyAmCoKpYMnisyApVQO0PWONsSNZXH9luD/M6KhMCejK6GZ0/EsbcOaRwfSCJJew4uVxi6fF4Zb0CPBV6AMYwEYPVwsogCoWmEJQsmJp6mY+/R7n1huwY4Prj/5MPzZpmQJRsRZYwkkw6vUWn6uKvDGEQ9w7UIJVQVIjW2nljgNXZuLx3qe/eNPKCdF1myfLWSS0ABQVDNp4rWVh22XhE7W4sozOzJoEjhaf+D66DcotPXKFwheCHThOhasT73pyxwzzlL79mZQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ddf662-ca78-44c0-f3ba-08defc3b626c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:41:52.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lwZ4R2k/CdsOFpfgulEDuI5ZZIX5qUGfpvOC+32+OHsut+h4UAxF11apq5Lpg2peXqCK4GM59NgAMYWTwFPaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5893
X-Proofpoint-GUID: leYx8LqWuXSFNayItvakqfb0HpaNMPqx
X-Proofpoint-ORIG-GUID: leYx8LqWuXSFNayItvakqfb0HpaNMPqx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2NCBTYWx0ZWRfX9ET9PLdcjn3L
 jbEJG7xYEE89QkZm/+Ki5wuxOsUkQsLBuhNuY0P+V/jIOWQJNSp6RRwj6/UAo1lvJlNfybHwxip
 u8xqZG7+sGcJmtFYyWSqaGqxTrJwnRxkSno4AQ2NSDa87f8HEucT
X-Authority-Analysis: v=2.4 cv=VM/tWdPX c=1 sm=1 tr=0 ts=6a82c954 cx=c_pps
 a=8eopZEidgIdRxOfdJNpAuQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=aOlQcwIiioG5Px7z1HMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2NCBTYWx0ZWRfX6cvpTrp0Ea8T
 4RPq9DIxqos5qWwEky1ErRHM4UM/H6nPU7aYFKZRw+htzSRiiHU/0toplHp/kCGxKWPDTHLsWUq
 W8gpzbvhLWMvVXrlJdLwxjLH0/oeo7Y2LINJP8wTWYJRMwOxYZCrwOX/j6XqdiKkGCZFWrc2P53
 ljVC/mco1lLrWv7yorGH3soWGbu0ZrT4g2JyUiAahO1gOzsVAZhbyonhQnO0UEzskxhs+Q2alfV
 FZqkR2sYwfrXXpr7bxJ6dW8T1uOC4//2m32VmIo/wG9fqWQK3Wiq5PtqovSG4tb4mvNV1x63jrB
 ETu2wF2XcP/dBwluR4W/Nb+lZXeBEM298BjE4boNrdIjUdi585N9adwmKUSoQkDt5ixd/Ee8yPF
 3prQQndWYhgjvILccHAWhGfrWbqz1oYRyWamVeuwL2ut9PlZ9+abhZXRC4yfsCfCbliBPPgtprZ
 HSiP2DjHR3t1JSUJjWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170064

On Sun, Aug 16, 2026 at 01:49:59AM +0100, Jonathan Cameron wrote:
> On Fri, 14 Aug 2026 13:28:29 +0100
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > On Thu, 13 Aug 2026 11:14:52 +0300, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> > > diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> > > index 8c3de11a10a3..df385740b17b 100644
> > > --- a/drivers/iio/accel/adxl367.c
> > > +++ b/drivers/iio/accel/adxl367.c
> > > @@ -1426,6 +1430,31 @@ static int adxl367_setup(struct adxl367_state *st)
> > >  	return adxl367_set_measure_en(st, true);
> > >  }
> > >  
> > > +static int adxl367_set_int_map_reg(struct adxl367_state *st)
> > > +{
> > > +	int irq;
> > > +
> > > +	irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> > > +	if (irq == -EPROBE_DEFER)
> > > +		return irq;
> > > +	if (irq > 0) {
> > > +		st->int_map_reg = ADXL367_REG_INT1_MAP;
> > > +		return 0;  
> > 
> > sashiko point is sensible but I guess both INT ouputs are pretty much
> > the same? So even even if there's a mismatch against spi/i2c I guess
> > it is not problematic?
> 
> Sashiko has spotted a real problem here, be it one that won't
> pass the binding restrictions which require INT1 to be first
> if it is present at all.  Anyhow we should be checking for a dts
> that provides bother interrupts but ordered as INT2 INT1 then
> the i2c and spi layers will give us the irq associated with
> the first element (so INT2) but the code here will see that
> there is an INT1 and route the interrupts there.  Hence the miss.
> 

Yes, using the real irq was more or like "implicit" when I said
"even if there's a mismatch against spi/i2c" (which I think it will be
the case). I'm truncating my replies too much :)

- Nuno Sá

> If you are looking up interrupts by name you should use the
> interrupt number retrieved. 
> 
> return irq from adxl367_set_int_map_reg() on success then
> 
> 
> 	ret = adxl367_set_int_map_reg(st);
> 	if (ret < 0)
> 		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");
> 
> 	irq = ret;
> 	ret = devm_request_threaded_irq(st->dev, irq, NULL,
> 					adxl367_irq_handler, IRQF_ONESHOT,
> 					indio_dev->name, indio_dev);
> 	if (ret)
> 		return dev_err_probe(st->dev, ret, "Failed to request irq\n");
> 
> Or pass it as a pointer so that adxl367_set_int_map_reg() can modify it
> on matching by name. 
> 
> Could argue that we should never see this but I think it's easy to harden
> against, so why not.
> 
> Hmm. On a wide awake day I think I'd have spotted this, but not sure I would have
> today!
> 
> Jonathan
> 
> > 
> > - Nuno Sá
> > 
> 
