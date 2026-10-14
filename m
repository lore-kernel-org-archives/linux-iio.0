Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7D544893;
	Wed, 14 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987608; cv=fail; b=pxzBJuxLmK1fGtb05DHFo6+fn8KdtjlFe8cvch0o6ixjJU9trdnmffnkzXwQSsX0uyG+fTdkK86sXamztuCLhKrF+ldJ0LzJ8GOQs18VZsum2SgRAqBZGgfJp484KS3wXPCaHnV14hWrFYonfZkrBtf4G6wvTYiID5RPu9TjKTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987608; c=relaxed/simple;
	bh=cXLNGLa5bVOSVmm39qO5c9q/pEQSHF8eORjZRjpxL30=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SCKRyLlYcDDxzrCHxVsqaQIAQFNnS57rDhLwZz6OJdHcoJ3c1AGoEHBiXhkh/Hg9+Tj4nKG+wfJ+h5KcsvfHCNwlwkxVcVJvE8HRPQ3Re0VEWEp5GHdKV55WwZI1TfpXD2m90CSzfmWJvNoHDzf3IIUvxkNna9Fl4nWZCCLYTaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=fNiwDvsv; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=loluM2Wx; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="fNiwDvsv";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="loluM2Wx"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EE0YwB2737284;
	Wed, 14 Oct 2026 10:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=hMDGpSuSBJlFdAmxgn7ZdUe8OKTfl1Xjkt1GvtJxmLg=; b=fNiwDvs
	vRPZwUlSF1RXNTPlkTOXgkspduiVX2T6jja79PaV1nltKv2cw3LhlL84tN68LREr
	CBINYswMo2+kqCrw0Zdcg2FEae/1+PVZlY+6oKxWtldw2jWHpVzIxE9XI4mogsft
	8Za+qfR1WM34WgCE5pCl6ajh/QhZiT3USBHikQN7TQ6mM767b7dSCC7qUD0oBSdS
	aZpiBMhURxXY1vuQr0MFjAZY1Q4BXplTWXSCEqJBmDgXfdCGsbu159ub+RU8QN7l
	26vdPT/Iz3AQt2ftRIFsYbOD/6iROSFqerW8V2m4TuUOAE3N523aqcvQqlPw08Ty
	abdOuzXfitCQrYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hMDGp
	SuSBJlFdAmxgn7ZdUe8OKTfl1Xjkt1GvtJxmLg=; b=loluM2Wx2daTjxqRPrkcT
	+/O+opfAkJFS6D+vcQ2KN0DQG6Ou9XvkSVTeQD01ADglMAjElz/698ooVMC2u7TS
	FNaNctCwcJ+F+wxUva43zi5qoXMDiD8JDRI78+TPL6QbDZrv810KMplGkDnuyjdY
	z8aGo5rmJwOTAYGEhV8KA/GkfxdgM23ePTYDG1HJ/NjNhGqRZzP6jul7I2E+FXj7
	duIQdwmDEDQ+QDBuv5/TZ8BzyuylNZuoNlGHPSr95kabh1sjlriBYH+TQebj7mxj
	934noiuBD+vHdUMuLk5ZEtOtUQ1so3eQZNgB1HpQQeuUCCUV11q748q0BdQdTfKF
	g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h9xnscd27-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:18:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALMQHIT9vx8Iuyl55GGsO5SbMbYSk3/wfz9q0QvlM64VIAKEvPapIHd2+q5jIA+Lce3Gm5rVNMRWsg6V+Vjqz0lGADIc5Feuupq5Cjtz0ODrLx3lPKyD7Blxa1EHMCeUVdwLgEmCd5S+4QCHKCTglOJUKIOjJQxicToSrreZL04Q3WxmGqmeCO2meeeRLB3bSCZxL5z6SaaT7btgL352u+Cq9QuhQJKnEipH63a+FV01VB52KtvqhzH1g850+zJXA622u7agKvwItuVZFaG92kTw6UBLhQXu9tpuiy+spFgkrzwfYinnLix0aNLgvpwSbJuq6lNrfGiFtWE4ueAJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMDGpSuSBJlFdAmxgn7ZdUe8OKTfl1Xjkt1GvtJxmLg=;
 b=xYJiLSbeyLlpvAG3MIUOmpzp1fPYkF2LCWb9/vWCYZa86Bx2kZB9OMp94K6Pp8aym0/q8w2ytyKJijn8pq5pRB05FK/+TQrbGwmkx9gYpJQJ5m23wEeqq8kz023V9HcO+n8oQRx69knDz0ix9VfXDlqxBq/H/lL534yod8npCsxlVG/jPuFop6NrCXZa0rFIxoTDeWcuargay7/uWLVxPCtk82xcv2DNxnxcgT4KOxKNVC21hml8XuE0gsZRUnJMppYSMVWciDpTGG+HgaTnt8aGftDRjqw2bKFQ8LBnwYUq6AZmchZdiL3sPzM2TZXCbVQlXdB18S0re+dzFlZtNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:18:26 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:18:26 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 14 Oct 2026 15:19:18 +0100
Subject: [PATCH v6 8/9] spi: dw: Use dma_slave_caps bus width helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-8-5b3ffdef8191@analog.com>
References: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
In-Reply-To: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=2312;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=cXLNGLa5bVOSVmm39qO5c9q/pEQSHF8eORjZRjpxL30=;
 b=ZyzuSBePTdl7nBbozVW54jZNI11dQPECEGh+qNQFgsBdF+bND/yP5Wy7bVUm71lQRLDq6yJZ4
 Jv8Icm0hCCbD0Rq3Hou1lffF3ccIZpnf+cVi/Mo522ww1rcU5WTZ0S6
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::22) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 882b7918-388a-41e1-00b5-08df29fe032b
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 tWh6eyvpxTW/HyIpi/nLdS0yvm5NzX8GvpIgjLj8yQi0n81smsm5ht49HL0Q3ubDrX5qCeQg1LHp2qCO6GD9PVxRCmym4HUBP+O98eVkuKBnKh9w48fhyRJfTXbrPqfkoFzVgxIs70MDq3LFSoWGj60ftKjSZ6gTlroDYBWFsjUURUoveHHvrgtwSqQ9u+DzU/H9nG33kyFFJGCOrzCCNaxXnhi3QCvmnLaht5LGtOQYpe4wQuRnUdLnXmxY5fUL8h6fp+Y9k/Fgs5z74KyTsiv8IPs0gSDYKuQVdNwjPiEkqh8N34F6WhDkVYGC7vSzvnNNrxMWVwQXM784DsjjDcdSssAR+F9TdVkAC9EHdady+gjDqB4F9rOnosMEpWwAlXsv/sjDHGDPhY3ge8reZem3nneGNQmw3NKlnQ1rk6EEkKFEj/JlGoCRH6cAycDzlUjbzpoOigUfDEzND3AYSj8NS2xG1qkvjwq+jhEm7S5I7BP/yOv+z23EdjvofOKBKC7CHkA1luiHmXGy5Mja7VwiNbC7JtI0ZpSWUZ7MJ7NGDP/K0q75XWRuQDo2e+qdiTXO0QxlLOyay4Wr1IY6Fn3Kyl03e2VXFMTqUUtVpDtCFKKc9in69zK6QUUBo+xCp5fwbgg22mgOnF2jcvAvh3jqFeJsOffu1r//uENAfBI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aHRtVWsydG80WHlYK3RvaWczR0FIYk5BWTJBcURuZG9kczhOcFRNUmhFRGlz?=
 =?utf-8?B?TzBwT29zRUt0Z3JNRGFQTDZPY1ZNaG03YTFacTdaWFFKYWZsUGNyZlVDaDhk?=
 =?utf-8?B?TWpRcE9leEF5bVg3Wi9DMDZXQUtlNUxkU2huQmluYnRjK2NNSXlwM0d3S2E1?=
 =?utf-8?B?VEhtaE9ReU5tSXkvWnRnSytXaFdpdjFESGgyRjFKbDNMcDIvam1YczREUjFV?=
 =?utf-8?B?V0Y2bHNmVXVhbWYzR2RLaVZ6VG5QelRUVXZSRHdhTndGQ0xjQmpPTW1PT1pk?=
 =?utf-8?B?WGd2Qy9HbVRjUzYrb25QT0c3Unc0MWFxMnRtR0dxMVVlbFNUZ1E5eDUrdXp3?=
 =?utf-8?B?bGFoVTU2R0NpM3lZaUk4THFKT0lERDcvU1QrT3RTWTBYMFdGTE1CbmZpWS9U?=
 =?utf-8?B?bXVrUmJTbXlkVVk1bjhuUWo0N2kzNVJ6Q0NhVHEvdVprY0UzaGhBWHJ5bHJR?=
 =?utf-8?B?SHgwU2xYRE9OZCs2cnp5Nm0rQnZYQ3NHTHpMQ290c0xFWTFNYWhlTmxZd1FP?=
 =?utf-8?B?bExhVDcyMWNRenFuU0VacFBXdmYzVDFTSUpLMGdxVEJEbGZIZ1BqWUYxS0R5?=
 =?utf-8?B?S21Zbi9ZZjdyc2xCWm1IelR1VWpkSkY1Tm9KTTNFVktpZmVVaDQ3eWZvVVNF?=
 =?utf-8?B?RVJQQWpDdUNrajVuSzgxT1o2QzJGUmZhbWw5Y2p3b0hVa09XdGVVcFdmMlM2?=
 =?utf-8?B?N3VjQndxYkg0RVJkMWV0aHgzZGQxaDhjNjVBaXJ6aGppOFVOdmgveG5oOXc1?=
 =?utf-8?B?LzdyWEN6RWxGNHlXMzdKWXB5eE1UUDRzTWFWQkpiQ1Q2L2pxZWMrL1YyNFBi?=
 =?utf-8?B?NDEyL3NiWUoyYVB5TmJMTnMrTzdvWmIweVZUZjNhL0V5d3pwbE9tOXRqWXI3?=
 =?utf-8?B?RThmYnpubEFQNHNlUWpFa3pSV1pxTTFmM3NlMW81bTlISjR0bU92YWlRdlQw?=
 =?utf-8?B?U1c1RDh2SWlvdDNVemROMUkrVHp0dWJpandaRFNMR0ZubWxzaklkdkZZV29s?=
 =?utf-8?B?bTNQNmFUZ0lheHJNUzk5VlJwMkFic1hHM0poeDBnK3oxUkZjZkJka3UvTWU2?=
 =?utf-8?B?ZEoyL0ZoRFVEdStnOThXTFpDdDAzMStpZ3o3Ky9RL3V3SlBpVGk3UE9pdncw?=
 =?utf-8?B?eEp1L2tGL09ON3pDLzRIS0FKREYzZklQd0J3VDZKYTBpcGZFTnBvR3Rkbzdk?=
 =?utf-8?B?SUlTWUV4N1dhMS9PNUF5QWl0VkxoZUZnTnFWeHc2ZXo2V2ZkejdrMytwSysy?=
 =?utf-8?B?am5lZklZN29RdUI1bVBucGh0U0ozZTVNNFp6WWtTY09rWmFqcWVLOWEvamRk?=
 =?utf-8?B?azJsT1JiWExTYldvSFpXdnNWRWc2Q1A0ak5tMzdkSm5sb2ZCaGE1aS8vVUxw?=
 =?utf-8?B?emM2LzE1dlFIUTltY2RMMGN2WXNoSjRSa2tCS3VYeVpCYnQycjMzTG0zOUJo?=
 =?utf-8?B?eDBteGJnMXo3dmo5aDlMM3JWRVM5SThpcmpQeE01ZHcyNHJEQjlZSGpGQ1RK?=
 =?utf-8?B?WWU4MDVOcWNtVklpdStOTGwzc3FadXBuRXAzN0hxeEdsbWI0RWpFRUI4NEph?=
 =?utf-8?B?MlZoVkh4cG5aTXJTenFDRkJEV3R2UkVYRktUVWQ5R3FaQittNmdoV1FGZ2M0?=
 =?utf-8?B?RFk1Q0dkczJxcGY2aEVIbmY3ZDA0UjlRWC9DblZXUmhJMzRTTmpFT3k3UDZw?=
 =?utf-8?B?RHdwbW9oTGhXMXo1TGQzWmZKWEM5S0JkdnlYd0MyN21rTmZ6SDkrWm9WMGxr?=
 =?utf-8?B?NkVJTFJBTVIzaHhIT2xZNk1mME83NDNyNFNLY09WbTZoaERKMUxkNlpPamJh?=
 =?utf-8?B?ekg2MDBIUER2OVozODZRTHUxT3ZiZksxbE9UZmdubTM2WjdpaHNkYWY5MTNJ?=
 =?utf-8?B?M2ZYRW5OaHdJclEySFlQRWpxOFh4UlhjQzRoZlE3KzRPdGJPYXFXZUhBU2pa?=
 =?utf-8?B?azhJZ0pxOHZQOGgzZ3RnVmlXb2hwalhYZjJPVjBCdGsrTExGZy9BQjZjdGkr?=
 =?utf-8?B?N3ZlNVRtbmJPT0lSc1I4SFBwRlVZaXFvNHFSY295VVRQaWNJL29nMG5SRHhZ?=
 =?utf-8?B?M044Q0hIWVovNVUwNmFkbk1VeGNkWWZKSkNPMXNJMDRNWmJiN3hMWFpkcFpu?=
 =?utf-8?B?enN1K1dkVUpTVlA0VmVSOWlpZWN5MkFjVXBlWDllQTVtL2UvUk5ITjNnRVFN?=
 =?utf-8?B?WGdHTnZUUVI5L2RlTzJMYTRYd3ZjNk1tRkdVTWtBd1dXRWhlZlFJUWwyRXNv?=
 =?utf-8?B?WmZtYUhFNDRIakRSRkg5QmJzeFFRSXpYOExTSWRiZzhaaFpRcjMzcW1YNDhQ?=
 =?utf-8?B?V0krd3VJUHUvWGs2d0o1Nm9hRjhvQ2J4eVgwZUgrK2tBaUdTUzkzUT09?=
X-Exchange-RoutingPolicyChecked:
	gy6etVSswd2yj5o/zU+soiK2hwFAhaAo9t7qgx8CqF79P5Y1J6j4L6HY4B2tbdcyqFFk86SqbF0SF9QUTANjTLLB12Xw62kHNiSzSzKoQVFgUPv3gXuH+bkTe5APSwSpRVACzkzj55Mjjfla9ev2sKj3xRNBa6lPY0CcrIu75QHUCYSB5k3eh2D/Q3eemq9S3qBZj/mWuFR6tfdk6WEYmfBVxNC6FE+34HC9ijozXJhV9DPJy9FzqZsKkFmBSn1qoSENemjLfpMk8RlaD+DJw6+O3SqaIDerhrKKG4BDYNMP/JNnO3C2pNL/U7IqI71wi2jkSP7BIGP+DPco6TfzJQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882b7918-388a-41e1-00b5-08df29fe032b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:18:26.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zx8ucnUA9kErAnZzpj4eIupl8lxZYolU/5EbMoEMRwuNKgDKvBZSQa/Y+fQQH4La5Ib1RhRf0IVcWMJ4Y8EQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Proofpoint-GUID: JEzPROU3unmlDjEi7hMquIhO1kAFq76z
X-Authority-Analysis: v=2.4 cv=MIr1C8Zl c=1 sm=1 tr=0 ts=6acf8f36 cx=c_pps
 a=lnATZ3Q5w/Ci7ZOK4Uls6Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=X5a4OoKTc_LXYW4y-_AA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfXxW7GVB+UCEpk
 FvZp6TAxGAIDQfaDnB/ozp+nClP6YGPs56FGN+PNtBratRSw0Fjq+BS+e/t1zqpIzXqh3gi0akO
 zcapdT7cARy6v3tFa5A+V5CuK+50qtFWscLnr+ISD93rmXykMxVU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX6ClpdM9lCUCv
 sGsyRrMiUaqA1V3ZbYGN8w2GHkstH47NG7t02Ajt9MTOrEBNN/Cwsj1gjUFsiVf1VV1XSOAPYEi
 MDThLbBEVt77s25E4Twy2DQX+xGLgBn1cnHJgv3fGWpEHd5QD0bUmMvLLACQTkNM2aqBbrR1stv
 0ngUxNzYjrcRAfmRIZlz9r43oRAWNFu1mGlbplLA0BIAC/oc9J2/mFH5H/V090inWbo061+5/gy
 aTbXLxalAjPe7xkgu30o9e/YYvoCZ6Zwol58zDWWpPoHa/kdcvD/YiQSMDqfKvU9rWVJUBXJcQh
 AxhxQ0KB5XLihmk45uUc4yes+JUpAlVITa13Nkx0rZkrre/sUes4uuJhbyP3J/HL3Kg5t0vBNb6
 bYRy+wN7f78pDXKe1K2itRQGwojpV+fAlrg94QDtWk+74I8l1fuNgcF3AGwd/7zwGDGMY8pg9cD
 qYGJtqqBw9wl7etT3eQ==
X-Proofpoint-ORIG-GUID: JEzPROU3unmlDjEi7hMquIhO1kAFq76z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

Store the common TX destination and RX source bus widths in a
driver-owned DMA bus width bitmap and populate it through the
dma_slave_caps helper.

This avoids depending on the legacy src_addr_widths and dst_addr_widths
masks returned by dma_get_slave_caps().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-dw-dma.c | 7 ++++---
 drivers/spi/spi-dw.h     | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f7d848fec9ab..054227349104 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -100,10 +100,11 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 
 	/*
 	 * Assuming both channels belong to the same DMA controller hence the
-	 * peripheral side address width capabilities most likely would be
+	 * peripheral side bus width capabilities most likely would be
 	 * the same.
 	 */
-	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+	dmaengine_bus_width_and(&dws->dma_bus_widths, &tx.dst_bus_widths,
+				&rx.src_bus_widths);
 
 	return 0;
 }
@@ -254,7 +255,7 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 
 	dma_bus_width = dw_spi_dma_convert_width(n_bytes);
 
-	return dws->dma_addr_widths & BIT(dma_bus_width);
+	return dmaengine_bus_width_test(&dws->dma_bus_widths, dma_bus_width);
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index e62f919f1188..351034bcbb97 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
+#include <linux/dmaengine.h>
 #include <linux/irqreturn.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
@@ -228,7 +229,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	u32			dma_sg_burst;
-	u32			dma_addr_widths;
+	dma_buswidth_mask_t	dma_bus_widths;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;

-- 
2.56.0

