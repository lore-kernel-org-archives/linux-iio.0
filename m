Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D24348095D;
	Thu,  6 Aug 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031949; cv=fail; b=SHWN6lkauGfFZdfWDQ82eeUa6zOIu6iqM+dAsyRPTxd4s42bnVOPuWcHq/wW9CozbH6sMddjQv5soBBD6oYyrWkKmVidaLSuieT2c6OFsN2o90pSPrYflKhPruRqCl/LpvWoAzrCPZAiedaeVLimPL5A7R0J50bcGLJ2wQNV980=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031949; c=relaxed/simple;
	bh=tg6JNIrrEXsm+09Cj7FQ8ngrKneWJz0fdmIg/oj3NXw=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=tuuPqBcYJYM2ozQlnMNmtgQ5GZ77lI5BOqVKGxA53cYeiLGJpjYZhG7gkjnJh894Ak6H9WAhItUQGVTGCQduhBCqwoUrXcfAYpVqpHk7iIMeYEpcNo6SBq+NzOPv7SQQ0BVpozXEP8wQv2ABEt3Zfs1/HVf6WgBsBp8has+ogU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kPOIFjg0; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kPOIFjg0"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EqeE83342632;
	Thu, 6 Aug 2026 11:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hCS73
	bxlVv0X+fBB3ujMBihLij/HaIqhCtJEyBCZz5M=; b=kPOIFjg0Dr+H/CcDVvTFW
	bAkEqLEIYxSbdiU5sbj9/ZF4JfYf8JDCqVGfFeiplQnRJMTI6aHrkscIVe1ut98q
	0E3cZXw7YQgqbGrW8jAvphQR/rF9LfBKdvazj6iw9AoX7awLPAW7v0N4qdphuHHO
	Zf7LbQft4dO4PkNmL4/91l9fmqq3vZRepR89oeG6TCH4gICpdF2Q3jIsIIxdOMLo
	gQC0p+jDRWOtiirGiPJ8swhUZccV0HsCogon3IlDsRY+iM+uqDIC8+k/28tVJAlW
	EzY9rLMrDLBi8LM77SYv8T8V9K/tGQynoXcjLLcLrfP3p2+1z7+DriS62dYztyII
	Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fvuvyrfj3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:58:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggfujfh24Dl+TC/uRz1/Quj87JH76AF4fYwmXGMEjmgQM3kq9L6NGR9Am28trkZW32s4PV+LnnLEy8nf1sk3ohJa9Hg1VQxxGDi4OoLeOCvDYB82+5JL5hfasKx9fhBjt0dtX8TMfrVkgXwqmKGZWkNSSsGLTDvv3XnIyplnuWAYpLx5FhAHLM4TCH5xCsxj95CyiwifdGTYArXxgkQH6QSQP09ZiN3mdSocdrc7vw5X0LFeTnX3vU7I04FmJmeq1Nuff4CRqk0aCyW4J0l9gsRlroDDLLf+X7rQM5XdgKp8kwF5ObNOCV+bFEblLLUpL+2S0seF4MDkydZ+Va8TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCS73bxlVv0X+fBB3ujMBihLij/HaIqhCtJEyBCZz5M=;
 b=oD0N6/pUdOhTDKsNL01ec9uJCgXGp8vH5B27y0O9MHBRvGZRPrW5EGcia8G6aX76/uFKtA7RXaA4ydmyE5Co05ep+WOZgG6HVoKUpVboGQvyJgD9HF8ScOCCzeYSdo1SG0tlXEuv42YBHUszQvLYMeUqE+Av9jPXMHfPisVzM+LH8hertWJe0mMw4hlAGv18+4B3q6LICAwZ8t5/4uFmveQdu6A67WIIMNuNNuv6i0eETa2K/yrTKio0V7xmzD7ok5bzkz0+5hhmR4uv3uKv0srsO7y7cOIb54Ej1pi8NBVzWlpEUOFPQry1bTYA7HdN8ElUtdhhGd3ESxixIh+3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 15:58:53 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:58:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/2] iio: accel: adxl367: add support for INT2
 interrupt pin
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260805115952.33894-3-antoniu.miclaus@analog.com>
References: <20260805115952.33894-1-antoniu.miclaus@analog.com>
 <20260805115952.33894-3-antoniu.miclaus@analog.com>
Date: Thu, 06 Aug 2026 16:59:55 +0100
Message-Id: <178603199582.1212536.12747445371339172232.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786031998; l=652;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tg6JNIrrEXsm+09Cj7FQ8ngrKneWJz0fdmIg/oj3NXw=;
 b=RlaWiexEx9jmN06p8ZxMo848Xpsi+3OYWK7sJXWzEHmZp+iSNk15DvgH9ZlQQoHu5GP9i3PVr
 DlTvC98y/kQCxzMhLYr5uRLFfcS0kZTflJnSUgbv+cfx98cva+I8EUF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0217.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: f53086ae-47b5-49e1-5a67-08def3d39d23
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 48nm2e/VDLN97f5Oh8okBQ4j6499LaA/bE5NrhcTJFfNWoRup5YU7kFjE/LeAv2qE+c4i43FG7G89fr7S/OQxuOkRYpczv09cw+N7pBZdOIbQW6iWeg8tSrs4uJRt02qJB68NGbGs9q360GGO2joGyBbdmYFn+jFtq30RljI13tPMTLBsXG1AXu/bYWqkfvS2JEXT2hgWUkGwthUoULDkN4NORIRDzDkIsqbC9ezfAf+qZhn0E6djhb4jXrrX5Eh7qYgd4zQ512dJOhHH8BlbZzSQCVtPcyF7ohYDdv0EtHYh58HlWFOOQkinbUN3UJcZlZ83TZ7KgM13OgFCs0P1pWTGveNjyhm9teZvhJ49l7iQbXtf69sOe8n3R6s1cHkkWriCD6GoHf3b/dOiwIOUpRPIe5DUWyJk17zCtmQ9kBC3i+KWUaD+5HJZdMbSCb2DDQ74XRDZ8gIKtESdwEsNAHXgYpcpdRejkLNRw0ddlfrgP01or2PYT6u+IhHycG4wLRzvOs0HpByhLy9oVGJ0whenKPuAZGBvWOae51I4zvoQ0DRFJ5+jQplV71oc3eEm0Bev7s305JMAPUMNcAZBFR02lgXRAeLjquGIjTeDZ088UTsbx9RLuEaga6Fbo7TbIVDsRo7c40CpLLSKkDn8wn3cb0Raz7+Jb3+WI1IfEc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c1FRL1hkQUFLeXltWmF5akN0TkhTSEdtaUJjQWVpZXdoN0NHMmp4RGxwUVl5?=
 =?utf-8?B?R3R3ZEhrWktQZVA1T3ZSVWpyUjNnZ0E4TmFWWVV1cFJVMjB5SEpjQVhxMTM5?=
 =?utf-8?B?UGt1MWkvb3hlQmJlWDdMeFg5eWFPWmhpNklrVitnbWV3K3V4eExtMHFqbUJi?=
 =?utf-8?B?YndzOXl1OEtvYzUzVFVxUDVPelozMDc4dDBtUzAwdHBSNFM4WnBhMnExeHU1?=
 =?utf-8?B?SUYxaXpjRUJrVmpQdXhOalRQaGNjUi9iZXpUdzNTSjM5eXFIYkE3N2kzTzZm?=
 =?utf-8?B?SDVhZU5ydWYrU0hXRHowdmhyOG5Fc0NkdFlMTXRsejZQb2J2Q1FiMHJ3QmJx?=
 =?utf-8?B?NkFuWjlHNHJTdFNXN1J5S2orYkYzRGRVbExuOEs1RlA2OFFKNW1HbnR5Q1I4?=
 =?utf-8?B?MmtFajE5dFQ0QUJrV3VCU0RmWWp3OVhUb2xudVBDcEI2Sm9COEExMUJZa0xP?=
 =?utf-8?B?Q0VhL3pqTDF2djBQeHZzUTJXblRIcUZMcE5IaEVQUis5QlVxYTFiTWwvWFpB?=
 =?utf-8?B?TDVHVFQrVkk1dmtqZC8vRHhwcDFIeldBVFBQTmxFYWszU1haZyt3MHpoZkcz?=
 =?utf-8?B?Z3Vsb2hFTm5BQUIxZHF6TUFiTHE4Q0IxeW5pU3JpRGIzWlRMcm95L1pDMS8w?=
 =?utf-8?B?YitNb0pjV1lNcmxkeit0aTZWckwzMGNwY2xsVUJqbzlKTkF0RzBPS0swMlNL?=
 =?utf-8?B?NkZQVi9seE1ja1JCZ0J2dmkzaGVUbUQ5Y3M5a0NLKzZJV0Y0MldjV2lJelNK?=
 =?utf-8?B?WDlIUmdjZTFzQS9rVDlJQ20yY1VyM0t5RGZUWlJkWWNlTzI4ejBnMWg4WjZG?=
 =?utf-8?B?STR0bE5NSXZJR3hGMkVCUUV3SGN4UFlKWVRKb0ljL1o4T05hV1JFSUhrTFVy?=
 =?utf-8?B?aXIxbVBwWElXdDFrNDRpNWxONEdtUDRDZmRPS05WWTRldldaRW9acmd4NUps?=
 =?utf-8?B?NEQ5WHlUaG50NHFlNDA0dFRLN0RVd3Ayd1JCK0JUaTkzNTUwNUgzWEwxenpn?=
 =?utf-8?B?NCtQcGhhUXRORXp0dThFS1l1ZHQyK0VyYVRPaE8vTkxvQzR4Sm51WDFqRkFs?=
 =?utf-8?B?ejlPdWk2OTNodFV6QUFndGc5ZFVJQ1hDY2FBaEw5MG9xUjlnM2lkdlhYNlA2?=
 =?utf-8?B?dndRY1NyVmhSSWU5ZlQ2R0V1L1JvVmsrcTJDb2k3SmNCVWhETU1YUk9DZnZC?=
 =?utf-8?B?bklLc3RBa1FWclNNU0hWTnhLaVZJOFVrSVg2T29yMnBId1grTk55MWxEVVRF?=
 =?utf-8?B?Vlh5WnlDUXFCN2R2ODFsd1lNdmx0MnAyS2NuRFVvNEhHRTQ1TzQrRTR6UDFl?=
 =?utf-8?B?a0RpaWxxbHhUUnNvV1hJSWF5KytzTEFldE5DN3d2OWpZRzgrWW5SUHRSbzJB?=
 =?utf-8?B?RFBZZmJTMWo1U0lMb3Z4ak1keHRaMXM5cGIxY0dXbEpyN3NWekF1ZExFYVg2?=
 =?utf-8?B?MTJhU1h4VjBKVUxCYTUwZEFNaGlwTEE3UU9rcG1nSnFDUWpZcEphbzZMV1g4?=
 =?utf-8?B?TTNCeW5odERTS05BUWIvRUU0cjhwTUFsMjdRcjFPV3NFOGRkU0w0QlBjSU9F?=
 =?utf-8?B?Z2FYRmZyeW1td1MzWmxmU2JIMm1rTWNYWWJ2UkU5QWpaQ2thTGlSR0NuaFYy?=
 =?utf-8?B?Q2VBZXpMN0NQNHJMTW1YL1dXQVJ6c1NmSmNTbVdXa0FHTTd2M2phUUNhMzdB?=
 =?utf-8?B?WXNZTnhLT3RPYkFIdm9zeURYTDZXd245R1hMZXB3RXYrVGZacFNJMWZWMHN2?=
 =?utf-8?B?dUlJNnVUK3lSWE9mQWQzc3EyMG5oeWZSOUdpMzZpYm1rUng4cVZpK0pNSCth?=
 =?utf-8?B?dkdTQWVBdzNxTVNUcDlLUlBnODRSeEhxeU5QdHZvSFUwT3JmSmlSbk9kc1hM?=
 =?utf-8?B?Yk9wNlVvRnVjWmZnYTNvRE5LTENQUkYxTFZjREh6OEhZN2JEV3dNM0k0THlP?=
 =?utf-8?B?Q0hQWkNQVXFqTktIbHZsV1RYbGpxK2hUbDR3VlhFZXk3QktIbGVUa2N3YURW?=
 =?utf-8?B?MmtyQk42bU42R25Hbm1qV3ljdFY3RUtmS1k3M2NOMGwyMkhETFVhMlZPa1Bw?=
 =?utf-8?B?QjR5UGs3bWNKa3pLbXI3N2JibzFOK1krblJlMzVGbXNjRG5CMjU3ZzNrN2li?=
 =?utf-8?B?QmozM1hBemcrYjc1S3dYUFYwSlNnNkllM1J5RjE5WW8zYkZJbmd2cGFHVmcz?=
 =?utf-8?B?dXZ4V0tVaHVrVG96SFh0UFZQVGRUU0lKa1RCK2ZqdVdtdWo2V2JTTFNneU44?=
 =?utf-8?B?MXI1endMN0s5UHBjOXBlc0JKZGcxa2V4Kzd1TkRIRGZSM0xrSFVmYi9IRnE1?=
 =?utf-8?B?eGM5R3hRdTcrMEwxdkZKL09EaEZEWW9hWXp2bVFlWDVuaXR0WDBXdz09?=
X-Exchange-RoutingPolicyChecked:
	doDEluCnYQI1OiJ6WtYBYUDIzdp0K/CCaYM/tyBsMfPggs6+9E8bM2yB840TpnQUturp4+XmLXGFOQX94nk5fJSFspStKTO198n1h3bqcr0NAjrSlZoXb5w934sMS1+RpHTnxvucekQ3rnqoeCgCy4YCseK2ZOe29IekARhGx/kg/Y0PPepL9+jSGK7MsamGtBCggKfZA9hE7mPpyJfHezWMWvlqS1v6vbFo1IhPk0eJcRdvvotalQlnhbb49RHVYho14PqHQNmJrNzsaIWVOq4v6SlXQSFDREu/x4u10JcSM1vWNZ4wO9CbOwOE4uwhReDq5WeWIPW9TFQqcLOweA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53086ae-47b5-49e1-5a67-08def3d39d23
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:58:53.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+Ba14cT0p548hvnmBdCnSitDzIPUsVSBYYQXOnCFQHTZUrU9Evn9xE7LaggXa2Dweu9rrkhZza17s/EtLSs3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMyBTYWx0ZWRfX4B5QV2lvo988
 yxB3Dh51x1m9Olf6s0mXPA6/5//IiWmHkFGS2x2YVCQH8ATGWEr7RlXiJo1pAq99YeCvXQxm+94
 K6fXesiQsNQkstMa4TjuJbQSPsPVv6BP1+B5HCLirCNygjDhvMO4iJJyB8yXtitxLm/OUhI/ALr
 ykNF2NfmfbhlqpgLq4XslwDyu709JTNKs2RysAe16/ysZFi27H/NpKHtJ5ISIGahkUT4lo717dj
 ko4Rmn9iSVtg4AUmWBm/n5wgJixP1axJJKGWLeoB2Y+qxcUuAYAhuFvpNbGIMqs3dBXHE0zJzWM
 9mLwO7UXJmv9P5bqdhzDznNntJIVQmlldt8LNCFMbEeMsnqCIhgjfHeyZ9QXb4D7ZlnuqliJi1o
 8F2zMvlYFKhLC85/3dCJm/CtI31zCO330WJx9wgWIG8XvanOgIAL5TiYaMwAzhkX5pRVyo6PHi/
 cFtbcv4wJk7Hi+/HPNA==
X-Proofpoint-GUID: 8jUqhtOS5qzrFrlfAG2weSYmD77gaoHc
X-Proofpoint-ORIG-GUID: 8jUqhtOS5qzrFrlfAG2weSYmD77gaoHc
X-Authority-Analysis: v=2.4 cv=JsjBas4C c=1 sm=1 tr=0 ts=6a74af40 cx=c_pps
 a=Ul8IY3gNdN0J7lfmD5e20A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=WImR_lWV1cPRWLqsFJ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMyBTYWx0ZWRfX46NzMZzEHYUs
 cNicBjG54zH+TO8VGAVDNscmtoVMlvj+mKcvs8Q9gesDY09Yn2854TL6B+b6K0UluJjBXkWUgpf
 onU9orSnfJXaBvtWRet9sa5IiSeh2wTTT0wckl4lZWdsOXlrpmfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060123

On Wed, 05 Aug 2026 14:59:52 +0300, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 8c3de11a10a3..229974478d10 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -1482,6 +1507,8 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  	if (ret)
>  		return ret;
>  
> +	irq = adxl367_get_int_line(st, irq);

On top of Sashiko's points (which do make sense), I'm not sure why we
return irq in adxl367_get_int_line() which seems to be just the same we
passed to it?

-- 
Nuno Sá <nuno.sa@analog.com>
