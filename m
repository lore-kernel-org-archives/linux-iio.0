Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E79541E70;
	Tue, 22 Sep 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086465; cv=fail; b=lPqzc22pW9IVd2hl8apLxueCKcrmjrS5AYMd1U7Zs58pAE2LOojSxtGR+aXJrIx5F0EPe7zgkp0P78zu9ohnF2YJdr5nawgdxRsdrDJiyD+XNLvqLbD8op4tO4X/6xxO5z0L3f7uYajJ3Ix8fN/c0nGDvwjwK4Axv6fNs3j9x3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086465; c=relaxed/simple;
	bh=YJoxDB2anSclFG1WhxyEl4mtWrQDm1g4ZQATCJdUPzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TJY/dFWFaiCuxrTlz+CLzeIvzJH3iUOw8qsiezxh0bcKY1N8g2awRFA6ipujDYMqfEcI05VA7vbF/wZBS10/FRZRVe7AW491+3OhP9fYiD1x97uU+arGz6koiLcX3+sL6fItlVBVioz5nNgoE1OYExIfGrAz3qEsmkJmz/S6I1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lXnvrk/i; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lXnvrk/i"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBMxZ3275347;
	Tue, 22 Sep 2026 10:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1edPH
	4fF0Hc1CFarfX2ukBnweLZYas6MrW2pE/bJxFY=; b=lXnvrk/iIenllR/aARotO
	e/SIEi1sVVBtr0AHyJmNjwNKCN3oMgiA5TP8w4rzmBJhqQ8DNv5kllrpuIaP+lHk
	ilVdgLvjspAsGYEPT0WsZGloyAllLfoXPy53J77g383x1ovZAOdhwNtkipNDgtC9
	HHjH7jU7xFSU/X2Dm3v0HjipFiQD5BqM14ZTCb+T87GB/Umk9T8Z/HsNsFP37Mck
	NR6AXdII0U3npsSaEWPwBnWkVFDZMWj0sVCqc22CZdWycxERsXK33uqk1zL3Sf/i
	oO6nNT9HxWJZ7VXcOsKth3FVqqzaymaLMb8duukmMFgZeSZfnvT6RZBqxzCwK+DZ
	A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gu3dmpr4u-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:14:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THHGd0081hBIczVulgLdz+ZQDmLkz1RUuxsE0nUiqbk3w7ZRU3gqYcQDGaMj3DZw1wO+Xn2x3dUbgcoexRuT8QiPhVyA0NOwZ1xIWkBzetR+yY06KWxRkVYNq5W9w5mwxH/oXpDEaiT6WYpaRjprIsFko/sfXxU+n4wsh2TYyRE1haYDW2WEvb9jrn9ISZJGqDe0ZhVyCufja4xw5FfYF11kHDCgIHktpsqRSoQ7KpLdlR8yf3KoQRUJuAdXhnOo9o09gCCtfopQCs5SHrm9Kbg3z5prJqBTCYoQOyWgUdWz+GAU4d82DylbxyEoaLQPifB5bT3Tim0iWpifgRrVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1edPH4fF0Hc1CFarfX2ukBnweLZYas6MrW2pE/bJxFY=;
 b=ZAltTYrBFYa1nj6ZtofNiOCCiQTpRB9EVPUum2xDtVuRsKzC8rvbrpUV7VCQRyHiSniM0vDlOzDeulZEUTOHpXXMF2bSxMgjGd2CNb8+iZbXJFuFNlzvWqbRk9/dlfmOVPK981WoLfN7OxYCuDd8iRjStuhSbzkdOin4GQBCqI14HxhBaTC7Y5agY1voL/bwfkHq4c+lrn7scMt7ARRXtg8psQkRYI9HMNejmmkYCW8FRZw4vlHfPAHgyAJGj4EvSJ7nKImE33ThbdUA7KSyAdhG+bS5QBmX1AVlRWvo86qnPeQLiDLQJ6sgiWGQUeTr0JP4JQ7+s1MxO3FouEFOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN2PR03MB5117.namprd03.prod.outlook.com (2603:10b6:208:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 14:14:03 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 14:14:03 +0000
Date: Tue, 22 Sep 2026 15:15:19 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4080: enable address ascension for chip
 identification
Message-ID: <arKNNx-6RAXbus6R@nsa>
References: <20260922110958.1329-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922110958.1329-1-antoniu.miclaus@analog.com>
X-ClientProxiedBy: MR1P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN2PR03MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 149d59f6-5550-4c49-ee76-08df18b3c116
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 QkzpeXEJDrmJ6eYxBvapHq+5QKGpjup9jhuZ+tXqFYyfiFGaBYBH99ZPbtgBrG/Gt/JR4MNeT57znySWZQ/xiVG5hh/+2pG6FK9RxWVSKqJwMYUITTyZzVBDi0YJwbaBEg0fChRrOjmslixzi93Rdumt2JUflOG2JplAFBHwoO/agjNS/skdAHEnq+9sgCVQqNdzsplbza+5KnD5QnTRrcHjQbEu/v2FPDQ43cADwO1eJpWlI/vViwIxJMO3SoIy9Un4fyr2zLR7Km0Bq/muL/8bfoPaabIS8hTj9iIjulRu5a/s2zZMj7IOTjdqcErMzxJtWMXhiLQfG75TRiUXkMghHAgk9jYSA5ezteFIKhdOCuwi1vlBBfRuBdJuCdPEp0EN2H7n/BpROUyCulsDB3uM5O6KL9nz0gO0cp6PFwdFiHxG8mmdn9Xk+1/1uYY2q83Ww1qY63H8JC5p/B6Qw2amNugRMKR3XvDKjANBY2oit1IE7GZOJzMkLa1VigrNW1L5KbU/66vwBO9Y69AesUQL8d7ePviqYHB3puhzWbt45E9V199W02bGLl77P5gbBNrCQLuI8q4F7jN05L9NFPJCp4uUvBi/CGV5O+2uFZsHd7/P+fOTtao8DEkafY/54odfwOodRvtjAPZBE7JJY8xYawti2mvFbHCy+wT8hIA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TmNBL1MrQnBhaVkvYWRIQXdqQktWdjRCbXVmT3p3N0cwcnZFUWhUSSs1TEhC?=
 =?utf-8?B?ZWhHem5TQjBjSGU0dEk5MWxmdldMRmpGeCthV0tDRFo0YnBLeFZzRkRPeFk3?=
 =?utf-8?B?UUdLV2x6Y2FLaGZjcGNudThUV2cvWGlWWHVTY251WUliNVdxWlhkTmNYcFI1?=
 =?utf-8?B?WFAxV21tR2dUTXI4S3hhM1YvMDVRM0xjdnZsNXVhcWNWbnhyaG16b0FLRXZV?=
 =?utf-8?B?SldNdG1uZUx2WDNXaE1yUndzUVVFOFFPM0lVbEhJR29RU0laWjdkeHNXek9s?=
 =?utf-8?B?UGlhQWZkUW1FdzVKK29WQ1NGL0d2UTFCTGFaUTE0SDk4R1BjTkJLNDdjbE0x?=
 =?utf-8?B?c1h1aW1NV3BVZXVEU2J1ZW0yeWIwVWZXNWNELzZOZVd6Y1dPMUppcFhhajZi?=
 =?utf-8?B?YXF4NlpYb2RhVkhpYXpoMjNOWkRrMXZQeU5CejBPNUJjU0MrZUE0Vmt2eEtk?=
 =?utf-8?B?dTZpZmhQMkNTSitGNCtZT0VreENjYjBFclRWOWY1M0QzcEtyeFlsWUErRE5Q?=
 =?utf-8?B?YkNVRXIwYzZVeU5HUjM3MDBNd0c5dHVPYmNycXRKVHdnQXp1dnlBMDFoMGQ5?=
 =?utf-8?B?NGlyRWdLcXBaNzA2Nytrbit2b3ZRRnpRN25jOFo0dHM3VEFrV1djSkJzTmRj?=
 =?utf-8?B?aUVNdVVkcEU5NlhSdGcxUDFPQlBJVFE2MitGVFM4Rk1BRmpuTEl2VTlaaENm?=
 =?utf-8?B?bDZPZDNHSkh3VnhHMVZrZnNML2w2NVc0SE12THZob1d5bUQ4UjVzenphRFVr?=
 =?utf-8?B?WVREVDhOUFE4S3VndStHU0RKc3Z6dWhzdWkyZzFuQ0pYU0IzOEdOaTRCQW1Y?=
 =?utf-8?B?TU51S2dEai9LYXdsT0lDRDdHOEZlajFreFl3d0hoK0c1K3graDlmWVF3UXMw?=
 =?utf-8?B?QWF0Qk9iSlo4MTNGa2FoWjJmV2ROWllhNzV3eFFyNXl2MldLSDFFbEFpclpv?=
 =?utf-8?B?T3NEK1IyYzhSMFJaU3JOZWRVcEpCcE4wU1l2dmJvc0RHcVNhR0Y2bUNLM0pL?=
 =?utf-8?B?TU9aaE1mWWMrYWsxTEppUDlnYTduSk4vbmlYZ1h4SFE2QmNCTWlmSXFsZnZn?=
 =?utf-8?B?dkdFSWJZK011Y2J4RHU4U0R5MmZNUHNnV2NBbFh0bnp4RjhiaS8zK1I3TnZh?=
 =?utf-8?B?WE5ubkNxTklDb1hxQW1TbmhIQUx6VU1vTU1EQ3dWVm44UHlNKzFrOXplZEEr?=
 =?utf-8?B?TTVkSWI3WmtSU0xrTG9nRm53TlB0NDNObFd0Sy9GVHVtc3BzalJ4MUQxRTlY?=
 =?utf-8?B?U2xLMHQ2M1pRMTV2RXNISTQvQmV2SmNRL0FEL05yTWVsSU9tUjROekVvN2lr?=
 =?utf-8?B?OStORGxaNkRRN2VuNmZ2TEZ4UFFGOU9BYUxCN1pnMlZaa2haSjBrb29tMFRL?=
 =?utf-8?B?Ui9iTmxVc0FjZzdMd2EybUJrVFFYU3lDaUtPYXVaMnhBaTlXNHNkMTVIRVlY?=
 =?utf-8?B?Z2ZhSmZBcXQwZVNNT21TOGxzbisxNWE4bmx3MmdDZXZ3WUtPUWZLMk9IVjZU?=
 =?utf-8?B?VCtlODJqMTNERS9wYjNjS0hPVThwNCtFb3lDUTdxaGxIbGhobnpnVEVBM01y?=
 =?utf-8?B?S0lTa0VjeW0zcjQ4NVdyNTJnZ1JvalpacTR2dlZvbDd5VElLRDVPMG40WDhs?=
 =?utf-8?B?VUJucmxRUmNpdEc5STU0VXVOSTBsNUFvR1Y3aEZzWjMrMHh0N3VwSDB6enFa?=
 =?utf-8?B?UmZrWEpSS2psMFBYa0hMaGp0VVg1ODVKUTEzNTB5RCtZVVp2RkcyUWhoQ2NP?=
 =?utf-8?B?d01aVUE2T0FZTmxqbGV6QmpFNUhBYzlqSTRDWDlrUDZ5WGxib096NFMwSEQv?=
 =?utf-8?B?eXpmUTlxcDhZeW40NmZPeTIvWGRlVWRZR29EUzY3L01RL0dyeHJic1VxMUZZ?=
 =?utf-8?B?UlIzOFE1Q0RHM2tCV2EwVU9SVFNDMHZTdFhOaUg3Nm9PbFVhMGZWbjB2NDdI?=
 =?utf-8?B?d1lJaHRjUWFPWkhCaDJHaWJrT1VOOUZzVHovc3E3Q0RCbDdCeWpYbXBFZkY5?=
 =?utf-8?B?NHJkdVY5czV5RkhOWER4S1hEK3YvOUp4L1dGNkRpNS9BcFpFU3RpRXNiTDFL?=
 =?utf-8?B?YjEwVFVGc0ZzZU5mWFpaeWlQa2ZmV0E5Y2MzUm4rTDV1eEE2SHhUMVFDNkZ0?=
 =?utf-8?B?ZlFOMEc3Q0dkNTFnUnBUWXYwbU14YjlDcEhzTExENWdXSE9GRW9uU3NwV09u?=
 =?utf-8?B?STBYTEhQcnM0Y0lNL3dvTUpHcDZmZG40Yy9RLzVaUWNsVlZraitldndtNThR?=
 =?utf-8?B?Wmg1UDhZdkNIM1hTbmY2c25rV3VMUjAzN3dSTEFLRG1yQnBkL0JKczlteDVl?=
 =?utf-8?B?U3dYRHcwRjduL1ZqWkFWVC90Sk5aa2d4Y3FzYmNHcjVXOGtHLzRmQT09?=
X-Exchange-RoutingPolicyChecked:
	VBN7AQzAOfHFAn2t9HRjJSaufbmWxxLAJuOS83IY5LFzKCrlEAmXnBSKERVbGAO3E934iKROqfZ/H+pw3/Wij2Gilnka8pW67g1roq2QFf2GIn7inAhN2c6V1y9CNEq/sxoaJHJV4ZeJoh2obhmQTEuQmL3GF5JJ+9Rw1XEW6b+RSrKg2aLAGBjCs2YKqbY9zvuLj4rXIUKqcfhfAs2+htpUIKfQ29EZKutwGVrpG8XpFpKmEZezG/7LlfIbNSCkqfi+R6J6QDg344k/HKWqGKQVhX/p4+VdVw2ZLAHQ9nDpgXrUXqHMsgsnMEDeKoMnxsMeY5pEICTmMpZ0XIBsoA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149d59f6-5550-4c49-ee76-08df18b3c116
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:14:02.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+b9nW+epgLMoibfspLD9ng53UXVezXPzYNxfEKS2AyOdE6GD/zz/PMyMRfYG9ckk6wjP8W0VyQ6wX96B6Sm7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIwNyBTYWx0ZWRfX6cxn2QVoiJZd
 YMQEI2k/Dr5nwCzt1HmxGNq4pt051N14u3rNh9HzpUJ9eM9PmQLIZV7hVEMS+NfKJ5mWxNFxd0D
 j/Hx7RJDFKvmlkM8A4vjCz6VnZCIONfDrG8QBOlFbd5cp7dz/eMZJvJ0+70kpJHj/llSP4DqrkS
 w666z5bs8pWXtFyii8zdcMXG/SMWAOvl+5uIsbAhMZ0KPTVmoc6tAgZbD7VNgIqGN3aR3hFtkzQ
 mcqKOQjWBG7OHcqcjhI4rpQz5/77IobeVWp6PQHYMgPg9X846CZNqm7JtMfRCodaT1aEMYmgCIB
 +uXd8GrAJ9HEcen2AixCBq6gvNJCZsrchL9MKgi8lmRfvP5hZSiOIAIZSMUvIf9/hLb9oZC1xBL
 +4vhUO4I6yhG9mnjph4WvAKCZoQ+xFGorRemhb6WvseHA/98HORh525sS69K/IspSnLGyCg+ikP
 xlpJxl5hHHlfBK//KZw==
X-Proofpoint-GUID: Wm1HerDnKrbG9WZkG-mXB3vJKjxqPZzq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIwNyBTYWx0ZWRfX+B30CX4DTTmd
 q5jQxsTqmMWnMl/CRXZvmpe0oods6xHILzmy5YLUnPMe20hgWS+DL4wuTOceFIy7nsSq7pD8OMH
 xNLaxf1eQZ/YhOq0eODR5lMsPvJiDIcdGt0RV08CObDwzf+Sly0z
X-Proofpoint-ORIG-GUID: Wm1HerDnKrbG9WZkG-mXB3vJKjxqPZzq
X-Authority-Analysis: v=2.4 cv=Ae4kjHXG c=1 sm=1 tr=0 ts=6ab28d32 cx=c_pps
 a=aTIAhetxxWeNPRurEgqQXA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=vsR2pqaSqOtw3rzEZBkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220207

On Tue, Sep 22, 2026 at 02:09:58PM +0300, Antoniu Miclaus wrote:
> The two byte bulk read at AD4080_REG_PRODUCT_ID_L expects PRODUCT_ID_L
> followed by PRODUCT_ID_H. After a software reset the AD408x defaults to
> descending address mode, so the second byte comes from CHIP_TYPE (0x03)
> instead. CHIP_TYPE reads 0x07 on all AD408x parts, so an AD4080 reports
> 0x0750 rather than 0x0050 and every part logs "Unrecognized CHIP_ID".
> 
> Set ADDR_ASC along with SDO_ENABLE before the read. This is the only
> multi byte transfer in the driver, so no other access is affected.
> 
> Fixes: b66cddc8be72 ("iio: adc: ad4080: fix chip identification")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

You could also just use change AD4080_REG_PRODUCT_ID_L to
AD4080_REG_PRODUCT_ID_H (maybe a slight smaller diff). Nut no strong
feelings:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad4080.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 4843ecdd91a8..4ed82aa42400 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -710,7 +710,8 @@ static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
>  		return ret;
>  
>  	ret = regmap_write(st->regmap[ch], AD4080_REG_INTERFACE_CONFIG_A,
> -			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
> +			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE |
> +			   AD4080_INTERFACE_CONFIG_A_ADDR_ASC);
>  	if (ret)
>  		return ret;
>  
> 
> base-commit: dceba8e581e3e8f475da0efbd7a73f3d9524ddd2
> -- 
> 2.43.0
> 
