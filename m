Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04846982A;
	Tue,  1 Sep 2026 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251755; cv=fail; b=j68MkWHlUHiZIBtp4Q1eCZiPSQ0a7JNn+w80bDg2ry9+QPQzDxFaOz+pJg6h4ur1Ttyg6T0vMuafniWhy16fFz/CGCbAUO8eWjWTvKqOhT2pAOfr6eq0v3FjQeOhFjCm28WnOSChJo1i+wz5wxNRmfCw1AX4sRZ4fxf30zlKbf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251755; c=relaxed/simple;
	bh=7+aQJFcrC8Z6wqR+1u4o+ca5fvLH44rf7N2a1npGlWM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Ty1LVExnybxYgjBCAGUmsDK1H1OJ5FgmYYxKgZqzDN3hp0VO31UBCsMdQn8kVconj/gZ0kZS8Bm69yEqRS/R/eWO5EMDh51mNtNdhIwAzBvBTkUE9ZKPSu1b8jkmNGto/6/w29cIDouZAc/jOEBo6cDBx4wR+ZLmbSA/KkbLadI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QZtXdKFs; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QZtXdKFs"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817AOue3022766;
	Tue, 1 Sep 2026 04:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o9YLz
	hJ999//TsjFhsbwRJof7r0XsuH92LkPkvkR39g=; b=QZtXdKFsQSJIgmJCmx/YU
	v4jfSIeio8J4ED+mpFLZJy1k/Fq/q+RNj24jZLj9zxEayXsej8MJBIzotyr2/kUk
	vXsruB/M6LBy8ffvY90uWrx3cZ7Z0cV7vvjBzYPT5WkRD9lgXlLMvtoRAW5YcZOT
	1SDgaLYKMehQHaLO9t3fACU535C59a/En/elx0/7HbxAwavUvJI+O+F6fX5AQQqP
	fY2qchW9l5OVTC+iqPVLvGpAh6e0Jw2MfMOYv0FFvY82O8AgMgEbgIlFWKmqb3Ad
	S1iXvdB8nlzKCQ8TUQKdwcq/QpElgpOnYYihboWuqMqO5Q/uAuEJevEWdoQ8tCm8
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcg1hy3yh-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 04:35:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJYDgiLUg1QYh13vGyJdzh8a3mqyPAcQ+piYuc4WgPK6kaWZytrWJ3pyvXapcjAw5bzjgzg1UhfXMQA1Lub1oFml1F7BYt9/negixiVWk1W0L42k3xCMkLYV0sTy3L9k0EEiQEQtZUKWmolgqj+ftdVkx1xCCjT3AHXlRDegQtRqsB9gYn34mX4IJgT2/UkVhQwHIRvFJmsZw+9LCuCLUSecBy/Kl0n5fMF+9nzDo2uw27v3apn2DPZazA3UcBwX8mADSDJn/pZDRwqEQfuYkQPfr9xPIKcllfbb8qmWayg6ytgR4pwI+Blcenvbjfs27ljjCGBPS2LyboUsnPFbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9YLzhJ999//TsjFhsbwRJof7r0XsuH92LkPkvkR39g=;
 b=fdBpfoBsXxhScAXoOmI1/Mu5eb+oQicuG41i398zmre6c5IgxcTo+xr+a02rzw2rzrhKBhVfpggJFkRAbsFAykrSY/6qr7lEjpQYy27CXl8/HhX53XbKLEB49lEBzzErwCYaidrIUXHMUVWEycA+X/uKiHEzNGFwYwnPGMFQarUzAXhpYGvDnV/jPSJeVZAEsfD4zJQ7TbkVHWbnuIR/n471sNoxoyOk8MVTx8odN+H3HJCWE6hjSj4LdzTCaIpA8M3k9GS7yzhvnYdW3d0k0MGXIGsYrK8JRalD4lD0vRsxvEGM2nlGgzDys/YDKXXbVSqF66vB3kmey3drdxN1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:35:47 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:35:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 4/4] iio: accel: adxl367: add support for INT2
 interrupt pin
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux@analog.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260821180753.4633-5-antoniu.miclaus@analog.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
 <20260821180753.4633-5-antoniu.miclaus@analog.com>
Date: Tue, 01 Sep 2026 09:36:48 +0100
Message-Id: <178825180866.3241.2859620351810883998.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788251816; l=738;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7+aQJFcrC8Z6wqR+1u4o+ca5fvLH44rf7N2a1npGlWM=;
 b=gxhlKBXjesTWgL0D1BfucZ5cI6BnnRHO3rGPsASXf1hgaMRkZVKJpRV5fxW+8QoMj/ZgGAo5b
 /4LAZLeo0YYDl7vvB1eJccj8MxXh1kMqfrEzLYN38r0n+0a9j/4Qyo9
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0124.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::35) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 82895b5b-911c-440b-2138-08df0804059f
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 AgrG2USL6pATx3GYrpxOYBCtq1TMcgmwWmhUTwf0XFnzEvguTfuJ1Wtl7qS9Vq28Co/WKHr/8Ky9r0t0rxezxKpl53Ga85sE0KdGJnQz3LYRCb4Q7J0C+9ZCIAhsiLxbk//rPFWRo9YbJc8xudhz8PXR72Ws8UIge6iPmd+UcCF5MPrR+C1k1YhC5kNccv0f1WEcXPsAwQpKMllDgTiv/Bq6/lonTEFmbOJGayy2qh2EQZMR+oAhiytU3hhbAB+4jDiLIMg0EY4xBwGFR5/dYvnIxJjy8du5rbwiz2yWxlKcr4uWYM5hcAuDYOZLEfJbXgXPjQcLeI3AZP7E0nEJFtN/QR8gMbed6p3q1tobI0AC0LwBRG7cePQEBurVd4H8UyPLSqmJu1yylhhPmXUqxwgLQPsaB/gO7jKETjQC59FrElSGRQrq7T+Soo0IFc9VIHZhibt6aPUmdKh5XQznF9uqphKxPkzNCrtr17GWOXZi5Ak67T85GUXaKzgJRldpauIznYKxwuEWJSnKgAQUi4TtWUfM3FavUMDcEX7v02mOizkdDfgsOdZUmfVod/ss8Y1GvCQncPTkW7IYWvomnNWOMO/K3D1q35n7jkG1K4a1b6hVN7EhBSH2HaGbkPXMIpX8oVNUByjJHkC8Nz9CRb2AKZOyL+7yqxneWGMtByc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TmhlZVY3S2lkVUV6Mm5OWE9MdVhQakxSU2t1ZmZkS2RQOUJFUTV2bGZ0c1JW?=
 =?utf-8?B?NVVqdTdvZFgxMmFYdXcwK1RyVUQrQjJHakc3M3BWbTY1d2E3TERYeUxsU3dV?=
 =?utf-8?B?amZGSzArdEZGV1NKUzhrMStJMjV6clZGV0tWc1ZYVEh1Qi8xcU1IeHhTNVVr?=
 =?utf-8?B?UXJ6MUJwRkFDQ0hBRGNZcFNWMEhsUURmcVk3SkJVWG5tWndISzE5ajlnU0V3?=
 =?utf-8?B?NlAzWTUxV3NWVnNmWmhYTnVHeUNXdmkwakpYOWUxQzhBRytIWGsxdkNwNFph?=
 =?utf-8?B?REZVWkpvRlBCQ2ZrdkpSMVozQ0hwZ2RIRVI3OHNxUXd0N3ZoQUw2WVRtNDNK?=
 =?utf-8?B?T01Eejk2Wlp6K2YvbGpEK1NtS2x6MmsrRjZQVCtYRFZVbFloNTRYU1UvcEJM?=
 =?utf-8?B?UUZKU1dBdFpMWElLY3ZYSys4M21lcUtWRG0rWUh1eEYxWXhJWEU2bHF3SHZP?=
 =?utf-8?B?amo4M2lEVUkyTnh3M1R4ZUMxaWUxVG1JTkxYdUszdC9MbW11cGExNjNZSmw5?=
 =?utf-8?B?SmtGd0RQQXg4QkVZTkJKRHpXNC95QlFMR0Zma3V4c2tCSlZDelVxakxPUXJk?=
 =?utf-8?B?WS92VjlNS09paVhIWGVLWTFWUTl1OGs5WUxCR0I0RjRLaFlhZlh1RStrbnRu?=
 =?utf-8?B?Rk9WdnlWdWJSbmVmbm00TWJxT0o2TkFhTGxiV2dXYnhDV08rQldIdEtkaTlD?=
 =?utf-8?B?THVNVGhzSmhpNDd5akVUYndzU0RmZyt0aGpoaDZjOVpHc0hFbktpNWVSTmlV?=
 =?utf-8?B?ak1qc0Z5N0lTQ2hXQmNsODN5N3haTU5hc01meXFkN1BwdmtUcmltK1hzSjQ2?=
 =?utf-8?B?VjlzazlDZjFHZE92WWsxTzlVUVJPQUJEa3kwMXpPL09lVXRHeklLRDVNVmRL?=
 =?utf-8?B?ZVNrTEF0ck5yMndYZVM1a1ZSRjZWbVRxNjRrcnNjVWdtV0VJZkJSRWtVZlYv?=
 =?utf-8?B?Vkg3SHFhajUxMFRLUW5IVTVHUjcxdGFHSmkySlRQb1hnRGNpQ0VqZEQwczVy?=
 =?utf-8?B?bm1CN1V6NkhPVUM5U3RCMHFVRjltaCsyVHdXSnVPQnRkMWZvVmZJMFBaU3o4?=
 =?utf-8?B?cFhBVVRzYTZRT0NuazAzcTFXWVR2VnFtSjVpZmFRWG0vRDFqNDBBTjNHVTh6?=
 =?utf-8?B?eUxqVmFudUp4citRV3VXT29zc2tYaU9JZVRTb2ZkcmFxb3dyM21Qd2JvRnJX?=
 =?utf-8?B?OGVPV2V6bFdxbGNyM1NkUU1LZDFpcC8vTDNCdURsaE1Rd0YwYk04cmpoS20w?=
 =?utf-8?B?RG1sQmdmNmY4elpwa1BPM0hyRHczMGFZYWd1WkhmMmVodVFPQmdUMDc0ekli?=
 =?utf-8?B?WVhPSTA4VE1PcXBJSkpkNjdHRWx1ejZIc0J4YWZIeXZ2b0JlRkxzRGFJSGkr?=
 =?utf-8?B?OWI3YVFyYUw4d2ZhQ002bDE4U21oeXNqYmwzcG5LVWhScVByUXpPZ3pndVhG?=
 =?utf-8?B?K0V0d1UxVXFXcHE2REk0WCs3VUpnUnI0MlNoSG1BTTVJd2hhVkdzSmduckVo?=
 =?utf-8?B?NFpHTWxUc0V0a29YRkE2ZmhIbFNmTGhOQWg0ek56Um5iT1RIcEs3L3c2cUdW?=
 =?utf-8?B?aXp3eW5IWVNKTWNRMzdWRUZEL2NJZ05FR3RIMnpOZURaNUVYRnZjRDNvR0Rx?=
 =?utf-8?B?OGJPM1ViQ2FaclRRRG0yblpUNmphSUU3VjAzcDErcCt3L1RzQU1HelVvWWpB?=
 =?utf-8?B?eXAxNzkxL2pMc3NoWG0rV3h0cDdnSUFvWTMxYTdzYmpoUkZUQy9STHJsZDdZ?=
 =?utf-8?B?NGpTWHFUM2tyZkZVZk5lK3Z0c2JTZFBOSFVXNnFheDkzUEhTVGRadVJRR1Js?=
 =?utf-8?B?NHh5ajlmYzFmRnBqUWJNeHBlcDFDaGdUc1pldXFGZDhxOTYzWHp6Y1VZYzJI?=
 =?utf-8?B?dzZadDZ4MFdUdUtrWXBKQnIyMXlKb2cvc2hlV1gyUGY5V1E0RUJLYnk5aG9o?=
 =?utf-8?B?ZUtaMGZ6ZmhKc3Bud1FkdjJyQ2VZanJNVmk5OEVwTWRtM1ZUZGZVczFYbjV6?=
 =?utf-8?B?ajRIVXRJcldqVHB1NWFabzlvVGlhaHV2djA1RC9KQjZrQlM2MVdrRzRhNk1P?=
 =?utf-8?B?eTQ4eFJwd3NXWUZZZXNuOTkrS3VEbW1Mc1p6ajBqOGUyNlRhMGUrdzN3cWZJ?=
 =?utf-8?B?Y0UyaWlTSTZPV3BEcnQ0WWtodzFkVWpGL1l4eXFlNUI0OG1OT09kRS9zZkF6?=
 =?utf-8?B?SXN2U25IZngzY3FGaHFuNEc2dklmNzFzOEI0UHlDNXlwVnNORmZkYWlCWXVx?=
 =?utf-8?B?OWtmdjc0WVlqa2NqNTVRb0poRHduY3ZhaTEwS05XbWpGemlIdjZTYjJleEdm?=
 =?utf-8?B?eHA0TEczYmFqR21zQm8xTVpPWVJkeDlnNlkvYVJJaTFTSjFsRGRNQT09?=
X-Exchange-RoutingPolicyChecked:
	h1Q97HSmgwODPvHkIjo0SwwLiY7VC9PLMuwraBZhehyKsAbM7s731NYeaPOKbmIwChPhfwDtt7OTNHjvzHwBEi0vvc1p+d4p51VOp1MsIyjcLmgLJqxpZ8XVFnxpZCXr1EkO1YEP14UrhjUJbuxVMMINgbHalriPtzf7MFUvD+ezWydk5eyECcCXGMnXhFZpsm17D8RmVUfzYgP4m+OuFd6UxfSQQbVC+hhU47k0pRZP1cPFoxEc1Tz1uIjlAWHOyC5xFaV08pWr2pDRtTg+PEOuBlQqXq4rNdzYGxe3HdSP408im2L0f8lEIdEhKnLVygmhiySh6KomLqOT+9mR5w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82895b5b-911c-440b-2138-08df0804059f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:35:47.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3mJsXAxlNleaoVkaOBz09ZBihIcNbGJk3r/aIDlek8RsCr32t7YOB8FGAW+IXADFTKwjRO7ApiZkVUW24BUzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX7uopaRixV4b1
 1EpMOP/mrr6VhM1IC5uhaZIApHh8s642EjeHNmWE/+YCfislXuBVivMpW3MF+nrLotF36EYDRG8
 U5XmUuwdhwxkoo9Opq1utIFNlhYILzrrVqqhVgds/kq3liJU/MtypmyrWPdqx6zT6oq7e2JFfA0
 0BNipUSYp96ZZmd/r3RJXBi81MH5xjAeRfeWLqfSoFkSEHbOWsrhBtqsJICR3jia3EyVpKE9SG9
 3NdBuaLBv6GFdSqCCA1+2h3FcAk31qctrUeLqXg6P4dzXRJuqMbxsr/R4rwF3maz9z9+KqUn5Kk
 RdHU/JK7WSCIe1DZQq/t6J6Bi/6R/iFk8wXQBpdxv3ofsiR+CYYbExDKVWQF9oFeI9psPmFgX1y
 dlihbFK1vMHnlGH8M93cgeGr+oUgNctA2zSTXY9trQE5vtyi9nmlK1YdDhmht5YZXGHzUZosJIG
 MLjIf4U73NIJg6lOfHA==
X-Proofpoint-ORIG-GUID: aJNDTrvDyD4fz5e0H7c2Bqcz8gTSZ3Qt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX9RXfm4PnhxwB
 49Pve/batMZqLuO8LXBYJFKCwWnnBJF8Xeh+UizNaT+wbbmdPwhhtwxqtL3CkBTY/lb4KLqiEH2
 jbYbDdgvkYFXEHmpQcWvQl2uOiNsq6iAStkLQlnnx+jg7/hfi76V
X-Proofpoint-GUID: aJNDTrvDyD4fz5e0H7c2Bqcz8gTSZ3Qt
X-Authority-Analysis: v=2.4 cv=fLkJG5ae c=1 sm=1 tr=0 ts=6a968e66 cx=c_pps
 a=Qq37X6yQjtlUzqIQK1H1Rg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gAnH3GRIAAAA:8 a=mCObrMS-_nEyfryY38oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010075

On Fri, 21 Aug 2026 21:07:53 +0300, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> [...]
> the lookup for devm_request_threaded_irq() so the requested line always
> matches the routed INTMAP register, regardless of the order in which the
> interrupts are listed. When no interrupt-names are present, default to
> INT1 and the bus-provided interrupt to preserve the existing behaviour.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

No strong feelings but I tend to prefer the style on the patch. For the
help Jonathan suggested and IIRC, some ADI IMUs would benefit from it.
Anyways, if there's time here is my tag!

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
