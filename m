Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CB3F0AB8;
	Mon, 10 Aug 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374395; cv=fail; b=OeXIxpPcvA2Y6tgDSZQJZT8b4iXER29Yo9rhSoGt4hVW05L7SNBCuOmwP2XOJ9cTmIB4W1C7uGe3G5AfiKCa5raDfKbfct8HoW3miPm4XGj3Z0Lqs3OegXmWdJ5s0Tt6QOMWd8Y1yE4dw8VifWzjTEMBiGuu5/htMe08Nvxrn+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374395; c=relaxed/simple;
	bh=JM+OkSL+ZTo5rUXURMGSVMGenKGHIfkUhlF7gxhO1pE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KZzAiWhj78aPw6mbD9v+cSHZb4TEp4XjH9v2mwKVfEPmgD42VT3VC3F6ZW2R7VsJYIxVDq5Vely5GSflJvworuNWhTpRQ5WWcNK9ESUUZL5NJ12uH/624NjUJGFW47CrkMsk1xUo9KdevkE0x2VQxxvjShCp9Cgoj29nbBw63yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J0jxn42j; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J0jxn42j"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsHLC3474289;
	Mon, 10 Aug 2026 11:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Pb0oH
	ILlaIOnWmvIVqqBzrTX8m+6a+YIolmuVPliaj4=; b=J0jxn42jdVmPodTpil1Lg
	rtCGIDvzpI3GHKUJymsVEWBEapO5q2eLgA5pH6CyWRNOy2jtS1tsHS+dtacUIif6
	EuIE6bSQ6t9OHA01cM0zw/BOZkTIw8dMkh/+KfvZmQX3YAZBbC/sV019PkNi4KAg
	Y+vfiQlneEZjKCmsu7qW3eiOdUYVuAi8q3maqKfNU8k72nz7Xb9j7s3MsNpmDTym
	/MWfUOcuSBfzml9QteGFZ9313us6aR4NTqH/bc213cT++i7mNKy7BOg/pm9CywOy
	hptqNa/ul20VQJc5rw9ZoL1kv8gvX7Dv2ohYEgYR2V+TcnLysssNQ2pgfAYE3vhq
	w==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxn2jbwfm-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:06:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtYf6//X6R8GBKz4Txe/c5/l6kPy5g94iHYWyAKaeyYXWkqpLQDAfB/CE2HYFWEgtOd/+S9FRfBFxJ65goOCue5OSfAQEbR2VC4KNf5yrH/e/s0RmL7YoxM0iTlxQ9Qo02/c9VtdpO2iho8c6EO3SxaKqqSYjqMP69X9lVG0oUozMIU/PTOYM4Lj6+6ql5YlUAXIyO7hWRAijzjcjtW2SC8kJWB4i7U8B0Yget8jFLOgQ9oqkK8DS6R0oPHghbMxM6wxGA5xjHvX8S5iUopIitgIW6OY23R3f7QJTNuzAMgmxDnZDIoAXl7GwiT+1iFdSk+jOHAYn0GzXao5rRmTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pb0oHILlaIOnWmvIVqqBzrTX8m+6a+YIolmuVPliaj4=;
 b=Wu7vnhxHusqiuBZlQzvsiOUqs4z2YBGQd5cDK8rh6YRSZAmSEVFqmQ7Livlx5ZJLS8YRPVSOqvX+hGv5JveH3eeXrCj+umidxNUFgBXFnm4tvXKAbM1r3bKX+uViFz29Gx4x+kGtB4eURNtNLX1I/d1ZK86zSr5mgC8LboyhwXjWwyYFmEWE4uXU1bKyGzdCCpbggGjTceRT1ekpXzX7MbfL5U3yr6ku1UB4AizSUAsfUwLCPa+u4gpGRRyeCifjUUwl/RVXcP8kVTv7zaRyVwYdGSpKuDugCLp1t/wKshYlGwQJ74uNMX9u4uRq4u7XSoZ8jHIE4g64n2Z8/ZjzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:05:50 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:05:50 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:45 +0100
Subject: [PATCH v2 4/9] dmaengine: qcom: gpi: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-4-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=1430;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JM+OkSL+ZTo5rUXURMGSVMGenKGHIfkUhlF7gxhO1pE=;
 b=sS1DboyOcAOxuYfACVA1dRxOwqW6/YR48AITz4VAiunJI3qGCkN3zJmz8F6BNotzD8Z82/4rp
 Bm4yfdi69OEA7C09GBVoVqD0GtjkVXkeMtKgVPetz7Xo6wWiSH2zuEW
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0006.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb986be-2130-4222-d0db-08def6f0dd55
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 NRE4D6p054x+j3jMugYE4UZvBPUK6mc/XhXCX9ChemOqg/ky+k4alJTmesjIzUH5eIxBjrDWfkQABpfeljx304uHyNHlQ7FSEoJcBcrKprRLuG5TfZPAiRG6MkSvn3UvSAHK1s0bLt9K5P/ak/cLEkUEKzmqvAvBJPTt5T75sLkgTKNr8m1QUtwRyj5n3BUeJC/mPZ5qSKBRzjhhbAk2N6JHeTcsDyUr8BM/JnBoTAL6G80RrrsHJlGHf+0rd/KfVDH3tpEnIeu8I93rMcdIUf4xFAHhpbac++v7jdUtT56Bb+MXuBR8Vq7ZWxqgniNb0Jf2rT4WkyVfP3v+z4hNoi1BSRtWhQnk8RZLydOwjWgMmHBCTnMECHJgTK0aW7hu6YX2R1iXmlbi3SN1D3kjghMd2sW2QAYbFE0I9oEpRyc29KZB5bBSzmkSX8tn+jkuPsTOYBu3iXBxnW4Wq8xOuGtTH1l/WslHoLlFgtD7Os9YnBgV7L0O4sCJZ7kv5Vdg1sCEXfM8d9aDI+xDU5/24TPfBa4C4rqhHVFJiVxqBIf3aK8/I8MnRpi0VCgU4won6Zhrl9Q/qOqFgglDM5LYLzo4M6asMrDcNqVg5cmbGwWu6XSYZCVNzWRcmYRvmWYCoq7N3CMmC2owFXXXJpiLNPna6VRzJIokmJdhTO8qWA8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QUFBM1dCc2piRzU2Mk9QTVlhVGpjakdVeTR6RUhkZW9aaldDQXYxbXJ5TjlB?=
 =?utf-8?B?dUY1dnVUWWhNaHpUajdZZkMvRWtoMkRDUEs0dndXSWRQVXUvOXBtM2tYL0RJ?=
 =?utf-8?B?Wkx4SHFMSDN1OWZYRWtPK21UK1BYTHNtTDhuUDg4VFBuMm40SUJxY0N5QTBN?=
 =?utf-8?B?RTk0OGUzK0xLVUhSalVwcFdOcmY2SHpQd09YV3B0Mkp1M3phblgzRXJKMWFl?=
 =?utf-8?B?SEtqZFZHamFiaExZWE5oRnh6U3JtSkRsMk9uaTJoUUlXdUI0N3VOcjBlRnds?=
 =?utf-8?B?SVVFaTRUc2dMZVMvVy9ySjVKdTlSRFdxOXhNOUJoY1ZWcUFuZmQ4UlRteFQ2?=
 =?utf-8?B?WXRaeTZERHFwdjZaR1Z1dDBsOHBsRWZtWEZnSk5BdkxSRDFDRFdlQU93WjYr?=
 =?utf-8?B?aFU1WUhsQksrd3MyVjhMVDY5YVlKVWRMWEM0eVdHK1JZODJiQThMRFpnVEJu?=
 =?utf-8?B?TlE3VkdNdlBQM3VzbU01RU5Xd2htQ0ZERERLd0t1eDNsbHR5eG9EVVVrQklQ?=
 =?utf-8?B?Vm1wa3pacUxwYzdSd0JINXQxZW5XR0VwZ1JnU1lIRE9Ta01icGdadmVoTHlz?=
 =?utf-8?B?ZENvWThNQXRiTmwybnlGazhreSs1SG5mbktQVC9zQXpBcEg4WHpQa3RNYjVW?=
 =?utf-8?B?Ly9mWERrWCtFbHNCeG9FTkVlK0ZrSVlveUNpOGtUUmNCSHFCdGFmZDdtN0dI?=
 =?utf-8?B?UElMajBTd2ZwaVo3M2Rrd1JuMFpjRGdTbHNoL3hqb0ptUm9WSloyajNRemta?=
 =?utf-8?B?WVZyRXI3SnlEenAxeWFQcjlSMllZUDAzaWZGbi9EM0VPYmpjSS9FQlNPaS9l?=
 =?utf-8?B?QnIxQ2NBTUd6S2pFNG4zK1Y3eW5rcHpNRnVFM2VLbTRhRUNEdjkrUTI0TGEv?=
 =?utf-8?B?d0Z5U0cyZndqVEZnWFlhN2tITUJjYThZbkRIZHpTZkJmenc1T2VwNlIvWEd6?=
 =?utf-8?B?bVBsbnNlVzJEbnlHZysxVEV4VE0wZ0RleTEzRDl4U1hRbGlWWTIvRHJpNDZz?=
 =?utf-8?B?Rk8waC9aM3ZjMjhmK1ZMdStYRGw4Z2lWZFZUYzdvVTA3OGlqZGlhU0ZjTVlB?=
 =?utf-8?B?cm9teGtkZi9PeUdxRkFhUGlmN2d4KzluQmEvWHl4NStoMXFDK0lTNnduVzkz?=
 =?utf-8?B?T2w0YVAwZ2I1S3BpekpjbStGTjRNNlJIT0t6TTNqZHhuNmQxRkxVaGVtV3BE?=
 =?utf-8?B?SHAvN1BUTkJXa2dyY2dzSmd1eURqZ1ppKzZoSmhweEFhNXI5MkM0VFExOFFY?=
 =?utf-8?B?VXNYWjZQRjNieXVIZG5VR3pPbEZqbVU1ZkRaTm90WUJiWThlYUovcHo3Z0xk?=
 =?utf-8?B?TGhrTWw3ckR6YUZaYk1DbEdxakgydUVhVU5TcTFRZHd5V2JsMnVuRGFpQVRs?=
 =?utf-8?B?aHBJdkJ5NzFSajluNUw1bkd2YzBpRGgvc29FZ0ZsRVlGK2x1N0E5dEdOSjk1?=
 =?utf-8?B?OXhaeEtZMEF1NFZqUUZlMGYvY1orZjFFR29Wc1JDTVVwM1hydkR4RmNIbFhG?=
 =?utf-8?B?Rm9kOXh1blZsNnJXaHlQQXp1TEpYSW9ZZllqOWdBWXo0TXR3bmI1Q0g3Z0Zl?=
 =?utf-8?B?ajlmMkdwWXdnZ0oyb09EYitlb2hlWmYwaGR1UmlhdGJPajlySUR5S2E3T2VC?=
 =?utf-8?B?MDJ0VVdJaXZrb3pOaEVoY0dnVTV4MWNaOUkwVnpqbU9VWVpjUWdYWEc1WERY?=
 =?utf-8?B?aUJ0MnVpaEtaendXbWtPRTRHRnlQSnl3aHhHRmJrSHlIRDk2c0R1SDNCYW8r?=
 =?utf-8?B?NzgzejVvRGNEakh2Zko3MEFKVXZPQWlMWEdDUEh6NE9pTUN4Q2dGekJWdXpH?=
 =?utf-8?B?UERkSVFRbTRPVzRoWGtvN29OUXlGK2hKTmJMQWFHaktXWkxYT2RNYTdacW1G?=
 =?utf-8?B?RS9mUFpvWTZkQlkzR0RNZnBXQWc5NFpiMTVuMXdiakNuQ0ozNUl2N3lWWkRX?=
 =?utf-8?B?Q21lZzNlZzNuVkhUNm5FQmNhTVk1bmZKRlpyeWd0Qk5qWm5PR0o1dHk5QU5m?=
 =?utf-8?B?SVpILzBKMU9DQ0swWWcxYkVyN0hZNzE4R1Y4ZldCV3o5L1pWbmpkdS9jYzRE?=
 =?utf-8?B?NFVneTJ0dnBYemVMcWZhUlVTQmU5NWMyYVpKZEFHS2dDbThhenlxTnlCUy9W?=
 =?utf-8?B?ZnRjZUs5N3VEbFk1dlBURzhCbG93dnVaOGtGTGhDQWI5Uk5sOVNNYmZNci9M?=
 =?utf-8?B?NitiR0w3Y1FZR2xxMmVVVGw2Uk1PeW1UYXlFdU9wcTdKWURwdklYQ1J3RE1B?=
 =?utf-8?B?V29Vak45L3lWcS9BRjNTOURIWGpTOVJIV0tEZHZ4bGdhVmUvOGRCZzZnYXg0?=
 =?utf-8?B?cTE5ekZHTWtpWDUyMmVULytkdmNJcGNaNVdYRG9Zd3E3eno3TU9Zdz09?=
X-Exchange-RoutingPolicyChecked:
	HYn24LvxRYg+m5cxhapom0Qy/JhJ10O6eZMBKAAnltuEYDyMesDiWcJcNV/+RLJm/a2IilK/AMvZ0CL3T1Ve6XluYZFwmPY439DpeZIG2jyEAccEE6DjNEsXfONPmDs+5hD+s5PRoWChX38AYEjMDavgjU3UXtR0uK9arw77ldjnbC4WUSl6I0L8CqRS2e6C0dFufcrqUlo85LiDiuefmSUIEK4DLPRYHQC3TQuI9uUzqA7oHgmwE9HtuzJgQd0gzS2KOLly9Z8k6rCoGCd56KR08jsvjeZSkAubSw3pgL+GLAajdunEwjVhrZZzr2bTtyW/F3z8vUIP4SDIFNaN/w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb986be-2130-4222-d0db-08def6f0dd55
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:05:50.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKbZCGXuqP1WXvBbvByEcsfdxMQ7XNdQUG0g9vv8SgIvPIVBzyjvTGcKEAk6jf7BkH5c97gpL/hqNo9mjE5o3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: BC0YTnpB2fJCcLulW4nOGcQj9BtjsQGd
X-Authority-Analysis: v=2.4 cv=SJ1ykuvH c=1 sm=1 tr=0 ts=6a79e8da cx=c_pps
 a=94FLU6K3oGZrB1XHaeOsDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=11eJKpf74FRv4loUduQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX7F2TLLTfZlW1
 wZyzWYddvdj5l9RnYfyawVAlJOJJ+IS3qQXO1NndKybI9AtGu6JsD/DwVmw/azgoJQoWWRHzY23
 2ze/0TeUFWhyLkLF7ZGppHPJUc6HhntPsIMJZzoIw2Ay7tcEoYQ9GI8a1RpWTJ4wSpVf11b6dl4
 rmODTiuA6qkLPtBDsa1db7mZ26TFb8pv4RdN0uoSEF3nRJBT6+VWFdFYENLtRNZsozaCXYVQRvG
 yyVET4g/dwq/SE+oKQR4rhvBy88d86KD332PJreWfI5Isj4WQ6tQ0q7jirx2fdTV3HNSXnGWj77
 OyaeIglJApabxF2tK70CYrR7D1qRlxaOzeQLqm+0EGAncgNIsGMZXYvVfnLUrjZOiKczHK0u9MD
 aXOvBdvwautgkNfT3qg0PBk32m6UuoYB3RP1QpN2nMJrHJ52ifsopa0cVdW0dtznKU56xEM39OY
 XLNOv+t9GLhIR3SMvOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX+s+3VvYAjDsI
 FgT/XD+vtrhEH+FnZvw7AYjX+QFIMP8e7wVfK/b9E+YFzfmDWjfFgvyJqGp7+Jt49qIPwdVczHu
 FLc/oLBPqmT8Ab1QDPfkgg58gvHeacD3dD/kAXr0uTI7vdJ1y1Ot
X-Proofpoint-GUID: BC0YTnpB2fJCcLulW4nOGcQj9BtjsQGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

Advertise the single supported source and destination bus width through
the new dma_set_src_bus_width() and dma_set_dst_bus_width() helpers
instead of assigning the legacy u32 fields directly.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/qcom/gpi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..fd45cadce91f 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2265,8 +2265,15 @@ static int gpi_probe(struct platform_device *pdev)
 	/* configure dmaengine apis */
 	gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
-	gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	ret = dma_set_src_bus_width(&gpi_dev->dma_device,
+				    DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
+
+	ret = dma_set_dst_bus_width(&gpi_dev->dma_device,
+				    DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
 	gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
 	gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
 	gpi_dev->dma_device.device_tx_status = dma_cookie_status;

-- 
2.55.0

