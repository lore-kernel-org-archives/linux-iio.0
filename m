Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180225;
	b=cYdg48uLTfSat7vRbDGoKAvAb9srb5M5ZBe76SevBRq9zrndWnV0pTciUM7EiDeKvVDU
	 CKrr+oPWEO3NHX0wwCww9S54eqUH6pwYpADfSIwU+lsxw8iMM2uquQmgPmQIXdyoDkM+n
	 hcZLBo9f0nm5niED9p4cPg/Ca2p7NnNxAf0vkM+BjWA1yGRwbN/tzuKMfmUiuzmS3JbwM
	 NRClgHeswmAM+0pW1+veGThUa9i/ZxYw/BykaZOrfSttawNf1FbE3zcXtnBJGSMKDzn4U
	 1MeDEo9kwbvzjyzSVQtblQ9taeJxnvXWwRR7j8IFX82G9KZHB/PGJNVxcWeA8VT8EOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180225;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cKtHkLcAOHLYsvRE/Rkr0+F6eVQwDyl9jWdJeyl/qwE=;
	b=uLwkPneWhifErq1mEQOyTMSOSV//JTx5A59zx6Wc7cO4nE/s3F3b4JdrulWocS1JNVwJ
	 RqX44XNUvSiZY9bArK7u2jOC0jb7jLZxsp9LPZz2isDPuTxuenwb/JM2zjXOe8f5uB8Bx
	 T9yC6xSbafi5okvif4cdOg/cVLQ9FWDXhqK6W+WF2hx4QaQq3zeW+/nnGqrFlZ1xGgZie
	 Bs6pXoQuLT0ajgPlfD2Glsj+Mj/+4D0uYNb8u+s4HNIpDLBHzIID2+D0F0lRbcXS+1132
	 PRrm7E9ax51YnlVqCHxH9m3QaSVKH0TBVlYaeQLhmX/7eUCpQRmG8+ogrQPn+mTPqiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=PNYf2plI;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="brcb/rSr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAD606A324;
	Wed, 28 Oct 2026 09:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DEAD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=PNYf2plI;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=brcb/rSr
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8GiFi3552480;
	Wed, 28 Oct 2026 05:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=cKtHkLcAOHLYsvRE/Rkr0+F6eVQwDyl9jWdJeyl/qwE=; b=PNYf2pl
	IIX32ADJfkZtxFpvEs+vZwwEY+SG7G/7RCZo3FNqTBUGJlwBx+BFlZnJtb89k8Bq
	mBPMFwbKSAoMI+JswlO4+h1bBXwr/SPsS8EnapclqryICyt7aE1QpP6O+vvvfI2W
	YWLszD+hms+UzLXcPeNRRenLYDmkqcgSgaZzw/Oj0enfZczhSPJZEV8lUS0C5GUA
	dxaCq9L0O5JBRca/H50MDG/9xXGtYlQob8/yR41IPN+ejBDWfpf6NOhnAIn3RRjX
	PAHExj7jb+5FTtHeBDpwb4R4Q1/Cn6ezv/U+Q+MEIiGQ65iYqt93v2B3sZzCrVLm
	SOXeP3JVGWPce+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cKtHk
	LcAOHLYsvRE/Rkr0+F6eVQwDyl9jWdJeyl/qwE=; b=brcb/rSr+MPqtwYNZgyFs
	OG0tP9Gk0uGffjXFCnTwn07J9V3I3e6QC5vHvSVlhEoAlHTNIXOWdseSL2Te2f5C
	E6SzVQCGaaFwW7da19I6lq8oVIkCeVNAWGdNmDCb93olJgMNzePNDvkfFTbbKI8a
	ehL7dh/l5WSI0sxlH8i8gNc5rnW5xcCQtBENFYtHW8p6NwrJ+JkpwxNGps/h/9/d
	M9vjodnU0J0G4cgdSEfa4mPRK/KqGsGXlKaz9NZzCIsvNUwDjG+Ya6p4vUFDtHFV
	ymGPiD8NmMUWgnyr3u6w/M0CRfSmwS9Vgk71rID2DwMXYLlOGZ+3uDJNKIXjq0t+
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hk2w4bkw0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 05:37:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdkiSIWNnBlcugrxXtwUzRIGmp0I9zZPPn4TLLJBITWGjb5RQIFhG/kixWhGls+FulmGQrQgMPUXSo46hOVruU4KEP7+ETLn4jS0VQjrmIxH65MxIadC68HGPmU9+EgNipz2mDfe4gNYKH1aiIT6edKBQvpSGQb1MoL6oIjjLMMUAyn7BjkGxRLzdCZhaSs9TYVacWzfrJ5YKwr5J5kpDZdZBZN4sED8TV9tkiCAJHvv4t/Hc15r58qdLbVvKSj0Tppt6qIQs2ywnwhq8brC9SlHwjhivR92uY1m6pg8NSpL5IfpMiqzYU+6gh1vk+a+y+NZD3mHrUtVnlAXFxXAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKtHkLcAOHLYsvRE/Rkr0+F6eVQwDyl9jWdJeyl/qwE=;
 b=ldY1ZeBVAgaUp01l10D5kb4O15mPzBltj/dC1muAyJNzBfIfg9vKnHOaNnzIjca/oECbbcn+cVdM0pGNt7PFPUfjkMDvGeT/RM8zHJCwn39JpPj6ZI04dB/Yz4/ztqRU218aiRg9cWyufB/K29XWqF2UeDwjCR8d1/y5k/27SHjf6RY5Xt56/rkBQ6Q1pTz+lq7q+XuBaUlT5Zy3i6R4MiAZ/dUwMBaDI6IoX5BNR9lNFGXWCOheBJAsfI9KJRjlM0WTUw3D2fV4NztkuToEz02dDexyW++90d6gedU6DiCg8vNZjQzxs7c25O0GKHmYMnuhI8W+KADdrXEsVMVtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN2PR03MB5296.namprd03.prod.outlook.com (2603:10b6:208:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:36:57 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:36:56 +0000
Date: Wed, 28 Oct 2026 09:38:19 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH 07/15] iio: addac: ad74413r: fix the values of
 set_multiple
Message-ID: <auHCeHSLVRuChXYp@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-7-0d818334f6c7@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027-llm-char-misc-iio-v1-7-0d818334f6c7@linuxfoundation.org>
X-ClientProxiedBy: MR1P264CA0189.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN2PR03MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: aecf0e80-e3c7-476c-a1ab-08df34d701dc
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 +3oQbBkSQw7WAX1uZk8KK8+8CNglh4qyj+6Gn/tkc9jhOpjaZFF+InriwnimNxlHkIl09mhYCsbLq+ycQMe3PF21y0qFrUi+RBQR6yDaImZ/QbzTPRH/zQygfNMviHhkvTX/lFAfXnV1ymB/NcKAKPGPyV7xgg3gHq9C3H6/yllwpY4hBugZU4ilIQuNAbnYO/Wez30nX36Vl/Hssx2wh9Wij7TfIbDXXCpBaydfE1IBTy/Y7sRSs3P8HbiwNclxBzm/aBO52ClNvKKsLSGVtmW9kobiTMfcbT4QDkc5+py1QZhwFCesitAEyulvXlkwFiUTayd1lHEiyE9Dj/yd62ay+ZVkOMMAAdBOyQRsOuvxRepkel2sJjnaV4GZ0oAZkjp6w4NvVaV07N51YrG0OxcaOVS7WyQxFTzV6rDTVqU5mP3xQZSHaEEer/2ab1rTsEIbFS3AWmz4NGC39voTza9/DZgHzjeFTSO9YROReNnXbwc6yDu7EYXOdhoB+YeUFxQdm8c7XFv77aqsk8h3cXqHyURUhnxZqmUfih8BKPkLvdBdVda0qGsZC/VATHgHwu64LTbb6df104xXNSIkQWIwHapP/HWyVe3Nizns7ETiNsoElUekLPA1O2sjpqN8zhnHWNTmjxouWH4lYQQUXSAEHC3pqZi09zVgoEOzB2s=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dURKcEprQncvUUt4d3VnRGtEOHd2NVc1UmkyKzYrcVBzNHIrdUxFQ296Yi9W?=
 =?utf-8?B?M3FEc0hvNytOemFWeXNXY2t1T2czTlVmZVJXZ0UzZG9kTnY3MzRKV1B2UHd3?=
 =?utf-8?B?bkFFTjFpVzV3VUJpWGtDTDRhbzNuWE4zVnNnQ1lvdHVqWXlJaytEcWNsLytZ?=
 =?utf-8?B?TzE1bXIyK3RjVC9qRk1sOFVrR1QydUVKTG9Ub3pTZWVQZURJTENIU2JvdzY3?=
 =?utf-8?B?NHlKMmVJYmZhd1h0TGoyS2wreUlKOVFGSVhhVWtJVE1DRU1OcHlKOXNqdE5m?=
 =?utf-8?B?bjRzR1pYN2N1ZDhDQWlkSHN6Y29xTG16dTVqU0dUazRBWmJSZ01LZnlGb20w?=
 =?utf-8?B?TlhjelZTSFQzOC9Tdnd5emFqTTlLUmN0bDJseVBhWFQyNjIwdFl5NE0vT0lV?=
 =?utf-8?B?MmVIcWRmQ3Z0QUF0Mk4zRGdmSm1QNDMvc0hMY21RbW8rNG5kNm95Q3hpdDdu?=
 =?utf-8?B?aVc1Y2lnNkV5KzJmUEM5L0dEREc0d1ZYcUFnNG84RDQyVno3THJCWHRrQXlE?=
 =?utf-8?B?NmVac1pBSXhnaFcxcWU3RysrR203bmEzMUw0bTNlN0dGa28zNDZ3NEdUL2Rj?=
 =?utf-8?B?YVo0S2tndGVXN0tpOW95OVRvbjhZZEt3bUxVbVZZSzBXUkhNd3hmMWYxaVhj?=
 =?utf-8?B?QnBqS21RWjlNblhXVTY3SFFmQkFZbkxSU0lxUW1nSGo2dmxJYjVwek1QTnVQ?=
 =?utf-8?B?SDNvWktpQ2RyZDJCeVRsYmhzbk9kUEhoVlp3clNGaFhXVThDdnduZnNtQVZJ?=
 =?utf-8?B?eTBsamVYVVZEeStSU3ZtZDJ6Z3dKdmdvWXFSY1JlZVkxdVp1VzA0dkw1dG03?=
 =?utf-8?B?d1pYd3lLMVRyYUM2SmUzTlhwRUc3S3NyNGsrbUJydk5VV1lVMmZnc1VTOTB5?=
 =?utf-8?B?N1RrSmxvT0crU2gwd05QT3lJdUNNZDE1N3ViRnRCN3lXZS9oMlNqVzUyUkg5?=
 =?utf-8?B?dWhVbGZmb0h1bXVPcGRBMCtMSTk4VVFuWHJjYTJObXUwbS9CdHVkQUJBRGRu?=
 =?utf-8?B?Yk16Mkk0WWVaRnlsSkh0Q0NySFVBRUlZNDQvK1ozVHI1cnIwU0RaTk4zbmc3?=
 =?utf-8?B?a2NSc3paVWRTSlRXRWdEVThlc00rRzBmaU1jRWFkWHA3TnEyaVlXM1FlcEhl?=
 =?utf-8?B?dDFvUEIwd3RhMEEwR1o4cEdDVmVaK3BtZW0veHJ6eTZYZlpXdHBHLzMyeXFo?=
 =?utf-8?B?QUxXWklVSWhPWW9tZTdwK0FTYyt3K0E0UmpzWVlEam1KRy9FS2dBekFQbUFU?=
 =?utf-8?B?NUdUTlNYalVYaEhscytxbjdyQWV4Y0dMdENVWlFIbTFna2JxZGV0bXBsTkNt?=
 =?utf-8?B?K2FHc2hBRXlaeE9jdjU2TXZBajIySUFHNis2VGw0U0p6Q2QyVDJNQ1VQTWJR?=
 =?utf-8?B?dTdhMXBvcXI5ZGQrZWtjcWRXRVlPdnhqdHo3L2ZiTWJBb01SL2k4dnZBL3Bs?=
 =?utf-8?B?UnhGOW92UzJqZ0lETm44ME9GUmNMQzNRR2YzQnNPNDgrZ2xNRXFnbkEzMGlG?=
 =?utf-8?B?SlNlTEd4YnhMTXd5UEZhMnhocUF5SWlGUnZEMjV6bXVVamlieHpzNGxDSExR?=
 =?utf-8?B?bGhXM1M3MTRudlM1NnVVR015YW9rOUtubTV5V01YWjFQK1NFeGd0ZEtEL04z?=
 =?utf-8?B?SXdzSkZXK0U0KzNHOCtWWVQrSnE3UVhYZy8xTlhsaWxJUFpnTU55NVdKRkxq?=
 =?utf-8?B?S1hCVVYwUnNrWXNLZklaOHdZUThZOG9wOW9NakFIeVdKdUg0UDJ2Ykc4czdQ?=
 =?utf-8?B?dlZ6R1YxUExnak43S1dERzA0NXV0NitmYUt2K1cvZ1pXY2hYc1owWmsreGdQ?=
 =?utf-8?B?WWtIakFvWUNWM2lvTnpjblhBYnRINkhCNWcyYzI4MEhxQjlGVDdCT2lLRGtz?=
 =?utf-8?B?alkrSUxlUE1ucjV4dFBuc09IeTIybTF3Ty92NHJlTjlXTGVWK0xuOHU1akxH?=
 =?utf-8?B?Vml1dGQ1bys1YnhkdWYzMCt4eS92bjAxWGpVNElEdVQrYTd4cnFuNHF6cncy?=
 =?utf-8?B?NFpMck5iMnBzazZiK24rOUlOTXJPeUZmUUd0dW1jYXJjZTBJOUYrNTZuUCts?=
 =?utf-8?B?b3N1WEozODk0bHJRSjBYNFBRK2UyNUFVNHVPVDV1V2RoM3E5bDZjK205TzBR?=
 =?utf-8?B?Yi8veldYYVVtTStIa3lwRE1pbk1aTUhUK0J1cVZXZTRQWloyWFR3bUlMczFC?=
 =?utf-8?B?T3p5aDF5Y24zblc2M3NNR2tZRjJlR05ralB0S0F0S3JzK1gxYkxOS1RiSjZL?=
 =?utf-8?B?L25MalJkQXl1ajdlZVg2eEd0RXNjT0lTOUI1NFVXNTE0Q1NxZm9LaktLSENk?=
 =?utf-8?B?cFlHMmU3TUJ5eXhuKy9NTEU0ZjJrVmJ5a013eHRDSHcrQkpLM3RXQT09?=
X-Exchange-RoutingPolicyChecked:
	ux43nld8mik7IHnhJpou3zLo35WzZLIK9iszLVJIvxxfEOHDPfEs2UJXCFmUrDEMHzabUdBVv6McDFe8iRfKMJVEQMsN4RmPABPNCp1LybKjVW/1lvJc1AaiceaC5tJk81t76HaJTP90ikqrk0hdpvsdbmaI9/CFBN+/J4lKmEmJPaKDnXWV8ZXmfl17iZRuo/V/CjMD5RNJqSfTL7SlSHvJRbZ2sBLGHLg/BR7D9t8XZNAPnus9JbDPBMy+y9NsnrCKGXyHqFVk4skZmPrvguNsdhGLkqfhnuIsdHed946cYbNI+Es6zx7qVgxcjoFxqcgMkP4Ij92RrBDfxoLi3g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf0e80-e3c7-476c-a1ab-08df34d701dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:36:56.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgdopJnL32L7hRSoUola8bgsqo/BSes0XO7YkLGHJPz5UOKRNl6ptCdABKJozy01hXCru6x8+IgTznLrW+jbDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5296
X-Proofpoint-ORIG-GUID: muFyD5cgRzd85x6uL-_h7mZTV8UqmGfq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX/4H+w3BtodC/
 TqPSxIOZXfxd0PN8pBoREOMUQwKfZFguAF4lLCFnEl4esNkBmCgosb7iGHzDbYj53a2CTzIAus7
 F4YF4Rv4lJS+EJ8S+XGxM0ABFA024A4U8h4FAETC5KVu5se2cl/+
X-Authority-Analysis: v=2.4 cv=RMUmjIi+ c=1 sm=1 tr=0 ts=6ae1c23c cx=c_pps
 a=XX75RHJXRTy/mnnqXKIK7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=6kQ0Cfi3JWL8jnwAPuoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=qR24C9TJY6iBuJVj_x8Y:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX8WO5mbTsKanc
 MHv2i2YwGgugs0cUHAPaKsUXKA/y/Gu3zNbhICF7z2o/jRfd0WpEdObfzLnVRPBtovJQidZa5ip
 j4p1oQCroGxjsJRb6hxCRfI/rlY1SzlEP6j2onn/TB2oV/jwYnXBvtGtGORXb9LtHcetCZZA6OZ
 oSfOinnThHRuO1/OI8ZKF5v+B4+mQUV1OIX8JEAT2XOy7kn9z3cXl7n/3I4RfD0vhQ5Jnk+3dVz
 JRIKR6JM+GpLouIUT2vpr3Ltmt6Z1bCyVlQJXilzcRMDwD15VcZlGk79ro5Rnm7pP04B4G1Sz8c
 6VE7jGAbDF/8LLvmn1B721eAO832ogL0LRBU6N67ysQ7EhYYpiLV0WX7xUvPwKqAA5QPIe0pYbl
 9y2/0xg8gBCFjb4ngA2VtFf56j6UzWW/waljFHrOGviWgeXRr2HUapodTcU9D0qTgfAIEV7+ohI
 PjXL4c+FP6zAdiLU4ww==
X-Proofpoint-GUID: muFyD5cgRzd85x6uL-_h7mZTV8UqmGfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280038

On Tue, Oct 27, 2026 at 05:19:11PM +0100, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> ad74413r_gpio_set_multiple() walks over the lines in the mask and looks up
> the new value of each with
> 
> 	if (*bits & offset)
> 
> offset is the number of the line, not a bit mask.  Line 0 is always driven
> low, line 1 gets the value meant for line 0, line 2 the one meant for line
> 1, and line 3 is driven high if either of these two is.
> 
> Test the bit which belongs to the line.
> 
> Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> Cc: stable <stable@kernel.org>
> Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/addac/ad74413r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 2e5a58e48a89..20db890d958b 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -312,7 +312,7 @@ static int ad74413r_gpio_set_multiple(struct gpio_chip *chip,
>  			return ret;
>  
>  		real_mask |= BIT(real_offset);
> -		if (*bits & offset)
> +		if (test_bit(offset, bits))
>  			real_bits |= BIT(real_offset);
>  	}
>  
> 
> -- 
> 2.56.0
> 
