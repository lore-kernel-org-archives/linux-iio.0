Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A848CD55;
	Mon, 12 Oct 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816031; cv=fail; b=HLiAlt2wEEc+rR0BubUEBF0eWNth8hJ5ThSCwtpyCFe5hsDxickG4PlnI7opDP9+XpiRPpCUQnwfYuZwy2+8n5c7JXTJPJB9yQQrghPQv8XDfU6g5rQEOvR+nS5JBAZx5TZ7nOll9VmOwDuiNoGYdR0az3YIPjNwaB8Wjwmdl94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816031; c=relaxed/simple;
	bh=bVZ4fJGlD1eqwTyv3Mq7Y5EQBcuPwQqVXFdjcpHnEWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bOOY0AL3utmfbTSqjrkJ+Cka+thKtXSs3irA1HwnB/0/hOPriu/U2eiLc7l84taygedvnVQA5o7cGCjRqpNcuLoaHoKQMOFE6g7Et0djebe/ZDc15sjGtn0iME+4e2lvhywNKvGiGNY0o+bew+AlrXqNdn3LJR6epRSAQ7BfLDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=cdk6a01V; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tznU/7q9; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="cdk6a01V";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tznU/7q9"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CDcDSu3476257;
	Mon, 12 Oct 2026 10:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=VYVsmt/S41HnGMNroz331ReHwcLo++6LL3D0P9dKY2w=; b=cdk6a01
	VzTVwKF3YFkytB3quU+aLOy29KwmwBseD/qMpLM7BEIfXlFbbPMoUtB95/Ty2pII
	6vc7JLe2gt2frxVuUMhcra0Wb2CXTSJ5xjV/HpE9eGSkzoUFoz03inOczqHgrf0O
	5DbQGXb8z0q1QP/nfR91/EY64fgX6Z6PzfCVq14V9e/em7bBEpsaYE8CCRmvIPEh
	6nHNoVENXmskGLCDdknaUm10e7AllOFicjVMmPEyys1h0xuAbWSxgIdv/Y0wqnD/
	qW3v9rgbb400BXeKyN2tGFfbAOoBKW04SiWdUNOAncqG03UDghPvvKKbEAWUTdDA
	iuGnXbTgLS817RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VYVsm
	t/S41HnGMNroz331ReHwcLo++6LL3D0P9dKY2w=; b=tznU/7q9STkUefOwamZJo
	0aYWdeGttKwgSkjvZ0M8qOky5+u1fLG52ufQ69EMSJ6suppeY1ihPvGZapctWL5r
	1N7DQ2MXBYUn0R+RHG4Ul/uliN1ugZWw3iKDs7GWGUgi7oA1fZH8bJ05c6J/hXa7
	NtJLtbmEMKKWHzPafAiwZmA8nhnuwPIxTo9Y9SKTqMauyOEJthcC8FTt0Imf50ov
	piq7rILALoqJYirqKzX6UGPupmO5w5W6MNvt9knb+GJo9HhzywKT30Ja/99GKraj
	vsxAt0gVtpMp8rIOdFSIPT5+F/UvOB+kDkIlYn2GDX4uTeBENe5RfRwYU9Zih7Vo
	A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h90m10b13-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:40:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUobmjBJcYwwPsFGjeni9/7CBwN8vFPgoBIM4Mg/G+FZWhRCUGCQZvoWzeqA5NVqzHeT32Zv8iHlm3/9CHfh5qdZ6u3a4DPiEHVX0RORapsou79hX7aQt6ATLekjEyFz4xmTQ5IVvixjPLCVLWwabIH5amCgWd5forO+KUSUQ1ir+Toys7MEyvBYUESbVtvmurkf7mO1wgLTp9a0I3+bRUgyo3MeYPpGgPyPSrLvNXuPzINVekSnRDmo0mMRYAVKLPb++0gDGfIuLRuwWrlFuGtZPBOKiEMcJs0PfC45pgcToZKLA5Mx+KEPDQWVNuuS1pB3B7loEo6b6EpEWPrGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYVsmt/S41HnGMNroz331ReHwcLo++6LL3D0P9dKY2w=;
 b=ueAaCT3It5dJmYPY8CwkW4Ze/xcJ1SKRypJex1otn8/IM6j3oV6K1zCzdrKWwaXWwjFr74MidYLksTS3mMWNEU9bViFAzsHLm5GKOI/jxOzMJ8zJgY9kqL8pWJByuskWpC5GlX2ROw905+TDxKGgDzo2/qTW+LK9BkUcc2qa0JHyEuEDwy5A6LURLFbCZwevlp0Ww42mEwwklfcG/D/7RLUpSMhu1Qgk8FKAElbwFQ39MkIZvCN2cFKOaIlUu/szf26nVNGeIOYBbwVAX+0O6sN3X4ooMkMoyYR8fyykdO3qLiKuNFgzuUMI19i2mDNjh3+yutDngukW038z5MKnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN2PR03MB5341.namprd03.prod.outlook.com (2603:10b6:208:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 14:40:21 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 14:40:21 +0000
Date: Mon, 12 Oct 2026 15:41:42 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux@analog.com
Subject: Re: [PATCH] staging: iio: adc: ad7816: remove obsolete driver
Message-ID: <aszw2nRYy3mqm_dE@nsa>
References: <20261006115119.1416-1-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006115119.1416-1-joshua.crofts1@gmail.com>
X-ClientProxiedBy: MA3P292CA0018.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN2PR03MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c75b56-0d49-4ffa-1963-08df286ebded
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003|6133799003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|261009221227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 Yq1mrA7XOICjyDF6v8ab3/oXnOH8oo80F/EokZFjzCeZb0HKtBk7NZMMzlUiH/8+by1+fIy04/uOaMqMeuTHZAuJcDl7+HcpsmbRsyBDcMA/sBciB9IdIf7fDhgNdosqY2cOkCCMxBd6XQ1IqdOx7lpkAc+LDkpR0UvZxvefLJSc1b59NX5EC4piPBnw/xgsx75L70mTlN4uUIXeb6zw7F8KHU4eKUE31H/GJlqoF0Wj/qs7f/a+zhdcUhXUxfuk9QhDgK1QxQZwEbCTMugUuhdMe8H22ES8a8sshRvoAlhlo0PL34w5jVvUcnVADdOy8GOVkn2Tv5njRJICfssPrd3pF3SXb+BnVCs+AKXRG0QYzrBenbBBTggjCCyXDOx0yANDhjwyLKIHfXXE8Fuu/aNzu1CREKs6Jzvw2dbBT3YbyLGcIm6DKN59H8qiVvTSYQgZZaP+YOoCGRv/CSWo0N1lf2HUjulEGGqsZn95WTb04y7rCtol1RxdCBp5RUaXgFdi1fP/rn0UdAUNimy6N9EfUK3nokgFyZ6O5yklKnPz8WOPfHdht4tx0F4avz6DHmu9Y34JbpJHnEFfXLElnmvBbgM0qz+814PjFWvHt0SodjJCpj+ax5hHtRHhOr6Q
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bHQvYnRBZ0xxSVhtU0xXekxjbFk1ZW1NMnBlSFk3eXhKcVhkQkR4SnNvTFd4?=
 =?utf-8?B?KytyZklwbVFUSWVhdCttcGRZR2xWbjRXTUVGWE8rZno0QnB6MzZvV2UyZHZD?=
 =?utf-8?B?Q29DYzNJS2ZBSmE5cWN1b0h4QThNOGhEV0RTdGFXSEhHVnJtZ0JWUUxzN3Nx?=
 =?utf-8?B?VHJudWs0OXpzUlVKTk1XZE1xdU1nbmhiZmZBWGE0ZWZPN1FmU1JlV0xqcjB3?=
 =?utf-8?B?UW43ZGhCeGI1akFDdk4xY0JQUW1OSnRPbG0yWm85bC84alU0dkhMRTIzMmdH?=
 =?utf-8?B?Q2RPenZabGNyc0s5M2ZBM0lKcEVLZDkzUUtCcGhTQkxxTlRKT1hoR0JFczNj?=
 =?utf-8?B?R1NUMmdwOFVEYS9nOG9XY1l2SmZLRFFheXpicnZSbldESDE1NC9kczRkd0RN?=
 =?utf-8?B?WUQvRnpvODIxZDQwQlRJMGNMMzQ2Wm81R2U5bU5ZNjV2YjlrY2RVUU9UOTR3?=
 =?utf-8?B?b2g1bjVUZmUwYk9BTG9YZTVuM2Y4dXVncXBGNk50bTJNb0ZmVVRJNlovai9o?=
 =?utf-8?B?anRkOFhqb0syNnhVRDVLUHVFVkVjTzlibU9GYmc1ZGxNeFFnOWprTWEvMDhY?=
 =?utf-8?B?ZmlsVFYvY290SEgva2QwbWdFdmZVZXRPd0ZvdDFIM21VbDJQNWd5YkdZMUJt?=
 =?utf-8?B?dWFBZVV0VW5mV2FqK3ZiQi9ZTGw0UmdpNnZFTFhYUnJXVXc1QUR3WU5odm03?=
 =?utf-8?B?NnB0Tk1sMmpUL0Z4NUJOeWM1M3VuUTJRaU1OanJZL3ZDaThMQjh5ZjZ6ZVdX?=
 =?utf-8?B?RFFNcHVOVzUzaWljRFQ1KzJ6SGVOa2dnMis0cnNDbncwZy9JSFJyNEJjUWE5?=
 =?utf-8?B?dmZPb1pZYmhFMkhBdTd0TnNLbEI1cjJ1ay9xY2lGSmtjNlU0RG0zbDBaYUZ5?=
 =?utf-8?B?UE1vVElsbFFoT040U3R0RHFXc3Fka2dyTFAvTnRWZlUrR0N5WVQvaWVQMFZX?=
 =?utf-8?B?ZlRZTldpRWlXT210V3p2MVlENmVDMTRqelladG9Jb3lFRWdRUTVBK3dOSlNp?=
 =?utf-8?B?cXhnT0crK1FCamc2MDJkQ2RMY0w0a3JOeUhkelYrUUNHdDVWZk1mSHJtdkxL?=
 =?utf-8?B?UFF5azFXTlBMa1IxRGlHZXpSQ0gweURKQnhzWG1lR0J2ZjcxNzFyVWlVelBl?=
 =?utf-8?B?V0lzR1ZmbVFLK2RoYmZrR284S2hSYTRWSWd3U0JmMlNGVE0zZjliMEQxRXpC?=
 =?utf-8?B?NzM1NTc2M2RQZHVOdXVXRlRvd0Y4dHMrOHo2UGtYWWIxQ1ptSmxLa3YzWm1Y?=
 =?utf-8?B?K2ROQk9GQnBSc0hDdmdQemhGTVU2cnVRWGFXbWVkdnNYMUJWME53RkkvWlNk?=
 =?utf-8?B?bWJiVnJicXJvOHptdGdGZzNwN1BCRXNNQ0dwQ3Y2MFI2QlNPcUlCUXRsRDR0?=
 =?utf-8?B?cCsrUU1ZdUdGYW8xZC95R1IvYjdzbEJrQjNieHRkQ0VZSmpieWVJOVFsSTBE?=
 =?utf-8?B?MGZtdFFwcFBleUIrNjNja04yMGNvZmRWNk12VUxsSUtWNXdWbmJpL1o4ZGVw?=
 =?utf-8?B?ODEybjJXWjk1QmNEYU1iVlRrbmxzVmVZS3NlbzVhR3NNTDJ3SS9yQ2tCZjZC?=
 =?utf-8?B?Y2hGZGMyZ1oxQ1FxdmxwdS9wMmlmNk1kWGM0UzRCcUNnV2FPNlhoQWRrbDEw?=
 =?utf-8?B?UWhUNjRJYTRSQnN4VE9WR2l2c1dBZWZXaEE5OFBFM2FWUTJNcnVaVTlZOU1y?=
 =?utf-8?B?MklWNTNHakRTZTQrOExmaGVNbnZJZ1VEa2M3QlBsblpuaEtkWmhrQmo5d1FU?=
 =?utf-8?B?eWY2RFpNYjkrT2JwRlhWK0hSOG5qc2hud21PZTJvdjZNdTZFQnFuN29GWjly?=
 =?utf-8?B?VytqeTN0R05MRFJvSjRoaE5yaVZiS2p2MlZBSVpzekRjQ0RsVllPajN6bTBp?=
 =?utf-8?B?d2lWUGswdWVkbXF6aytieFhBK3I0cENWcEsrWFpUVyt6YUY1UkoyVncrSXI3?=
 =?utf-8?B?cnpGMlpDaU1NYW1xRmpEbXYwM3VCRi9oQ0VZUVRJYis5WEVwWnRFRFpucEdq?=
 =?utf-8?B?dk9oOXRiSGxGUjVORDY2Rzc1N0FFNW01TWMvZVNxMjBTU2MyMUFoS3VYUHQ2?=
 =?utf-8?B?QkFxNjc2NTZTOThuVFVmVGJmMUhhb0h4YVNINVhMNjE2MGszTDh5MDU5cUg2?=
 =?utf-8?B?K2gxVjJmRGltZjRENUdkWnVZLzZaZFJZMmxWc0Z4VWZZSHd0Vzd1TTMvQVRI?=
 =?utf-8?B?bWJjZDlWeW1GMXFkSm5BTUorR0hqRWQrVFNJemdlTGhadmlpTEFaOFNqd1Ux?=
 =?utf-8?B?L1dJMklGS2xlVWZvOVdlVzVTMEIyeGNkSDI2UVZ5d2s3Z1FHV0V6ZDFKK2Ns?=
 =?utf-8?B?dDlzOFZyMkpQUmhvTVNqUUd4YlRPNlJtemZRdWlodCtuSWsrNnVUdz09?=
X-Exchange-RoutingPolicyChecked:
	vi4XCr6n+Rm0jXvW++WsiH+6cI30ozdl6U2oR0WsV7kQZu80q7nVQXoovwO/knMqwpj3GiTglot58JGuC0atsSynABle/KFU+WU9e+c9pZGk7FBUiwHoLW1l9Fw9jozfqaUsGKXmubN5IUgvg0u5gXCAIV0NObUXaBpGbgearB+lokBhl6i5NoFBtTI90aezBV1B3IxmMH+UYVHdVTmYmQ/X8TzaTKoWf/YlOe01nCXzJF63X78BDnXAPUgcwplpCmbdiAlHybuUGn2ooRXMRCkXMrmPOQiwms7KjaE5yB9OaQ1CmOLB5Xc6+QrjXO5Sg60Lw+peFRvWxv+5l9YKHQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c75b56-0d49-4ffa-1963-08df286ebded
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:40:21.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggIqYrJn2isOMb6L7bUd4ZWEWgNdxK9L0wIGqgkqdxUQJTyoUAjXTfUk6lUP5K2k/saUmOOh7JGzbsbmGg8RYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5341
X-Proofpoint-GUID: HUTmHxf04nxHwPFNXhMc-i3XBpiWx7pL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfXzx/MuyRzYVwr
 yoJ6NWAC4TkzpXnqOtn2uCYhpGMjA8nmF0+hupt5aFI+M2pEBFAbKjSsfDdIKRLs2g16nDI0t+F
 3UZmoSn3/e16HC/zrg7zK1/sxTB8SxeqMamEPmmWVXBAJ/cG79LcbZUUp8jiu8VwCbVl5+57t1M
 CeMzPKOJfMFkPfcSSk4GBSfafLGf1mvPzl7qEXW6qgIIp6z/TClIXNBJFOQdJye3iU0u+ISxP8T
 72cHhp2E8qofItq2WQEzowqGSoTSjOLj227L0ahoRBDkxJkmk6/5PUpK7dhZQLcrRrwDq++J2b6
 zyPpg87sqp81GsUBLxCVKbI+pDwLMkJIP2gg1P9zSz/hyf1yx3hmpMm9JbOTGKeffjs7xbgXA04
 a8iFj4N+e84eEn44VyoUc0KCUhfSi2JfUaC6b8WSxZmxgZE7cgHXwc0DKGPJABu94sv0y3LlwQp
 iUfRU81pH3ckePw0Wiw==
X-Authority-Analysis: v=2.4 cv=YLkKWhGx c=1 sm=1 tr=0 ts=6accf158 cx=c_pps
 a=N6h9FcIU3O7PIE8+NyeJww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=4tbZXvb0AAAA:20 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=0X3BobtIMgrO6y9mEQ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: HUTmHxf04nxHwPFNXhMc-i3XBpiWx7pL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX4r7p5YTHTr5K
 9vYo1TtV6imqzJ+dGdHNcWnOohj9ncxeFJlayYP7UgvjvSLEQttQMsI7uvQiIsYxUuJgRU733ra
 N7E2e0iKXMTKAR4rjYuXaLC2sUCMViHHSVNwRu9LLe3qaBGs/2TA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120058

On Tue, Oct 06, 2026 at 11:51:19AM +0000, Joshua Crofts wrote:
> The AD7816 driver has been in staging for 16 years and hasn't seen any
> significant improvements for it to mature out of staging.
> 
> Additionally, the AD7816/AD7817/AD7818 have been obsolete for ~11 years.
> 
> Remove the entire adc/ subdirectory and references to it as this is the
> only driver in it.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> If people want to use the AD7816, Analog Devices have their own fork of
> the kernel where the driver is present [1].

Just note that we do update the kernel so the removal will come to us
:). Anyways, the part is indeed marked as obsolete so I'm not expecting
any effort for updating the driver and remove it out of staging. So, fine
by me. If any customers shouts, we can add the driver back in our fork
(or add proper support for it) - but odds are low

So it is only fair to ack this:

Acked-by: Nuno Sá <nuno.sa@analog.com>

> 
> Also, I don't see a point in keeping the driver for newcomers to
> practice on, as all mechanical changes (checkpatch, cocci) have been
> applied.
> 
> [1] https://github.com/analogdevicesinc/linux/blob/main/drivers/staging/iio/adc/ad7816.c
> ---
>  drivers/staging/iio/Kconfig      |   1 -
>  drivers/staging/iio/Makefile     |   1 -
>  drivers/staging/iio/adc/Kconfig  |  18 --
>  drivers/staging/iio/adc/Makefile |   6 -
>  drivers/staging/iio/adc/ad7816.c | 464 -------------------------------
>  5 files changed, 490 deletions(-)
>  delete mode 100644 drivers/staging/iio/adc/Kconfig
>  delete mode 100644 drivers/staging/iio/adc/Makefile
>  delete mode 100644 drivers/staging/iio/adc/ad7816.c
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index bf6addf2974f..58d6859e039a 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -5,7 +5,6 @@
>  menu "IIO staging drivers"
>  	depends on IIO
>  
> -source "drivers/staging/iio/adc/Kconfig"
>  source "drivers/staging/iio/addac/Kconfig"
>  source "drivers/staging/iio/frequency/Kconfig"
>  source "drivers/staging/iio/impedance-analyzer/Kconfig"
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index 739e4cbf9a7a..7768c4a8d278 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -3,7 +3,6 @@
>  # Makefile for the industrial I/O core.
>  #
>  
> -obj-y += adc/
>  obj-y += addac/
>  obj-y += frequency/
>  obj-y += impedance-analyzer/
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> deleted file mode 100644
> index 2f0d6cf048d2..000000000000
> --- a/drivers/staging/iio/adc/Kconfig
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# ADC drivers
> -#
> -menu "Analog to digital converters"
> -
> -config AD7816
> -	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
> -	depends on SPI
> -	depends on GPIOLIB || COMPILE_TEST
> -	help
> -	  Say yes here to build support for Analog Devices AD7816/7/8
> -	  temperature sensors and ADC.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7816.
> -
> -endmenu
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> deleted file mode 100644
> index 1e2a94c4db84..000000000000
> --- a/drivers/staging/iio/adc/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile for industrial I/O ADC drivers
> -#
> -
> -obj-$(CONFIG_AD7816) += ad7816.o
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> deleted file mode 100644
> index 2a15d7598abb..000000000000
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ /dev/null
> @@ -1,464 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * AD7816 digital temperature sensor driver supporting AD7816/7/8
> - *
> - * Copyright 2010 Analog Devices Inc.
> - */
> -
> -#include <linux/cleanup.h>
> -#include <linux/device.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
> -#include <linux/mutex.h>
> -#include <linux/slab.h>
> -#include <linux/spi/spi.h>
> -#include <linux/sysfs.h>
> -
> -#include <linux/iio/events.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -
> -/*
> - * AD7816 config masks
> - */
> -#define AD7816_FULL			0x1
> -#define AD7816_PD			0x2
> -#define AD7816_CS_MASK			0x7
> -#define AD7816_CS_MAX			0x4
> -
> -/*
> - * AD7816 temperature masks
> - */
> -#define AD7816_VALUE_OFFSET		6
> -#define AD7816_BOUND_VALUE_BASE		0x8
> -#define AD7816_BOUND_VALUE_MIN		-95
> -#define AD7816_BOUND_VALUE_MAX		152
> -#define AD7816_TEMP_FLOAT_OFFSET	2
> -#define AD7816_TEMP_FLOAT_MASK		0x3
> -
> -/*
> - * struct ad7816_chip_info - chip specific information
> - */
> -
> -struct ad7816_chip_info {
> -	kernel_ulong_t id;
> -	struct spi_device *spi_dev;
> -	struct gpio_desc *rdwr_pin;
> -	struct gpio_desc *convert_pin;
> -	struct gpio_desc *busy_pin;
> -	struct mutex lock; /* protect device state during SPI transfers */
> -	u8  oti_data[AD7816_CS_MAX + 1];
> -	u8  channel_id;	/* 0 always be temperature */
> -	u8  mode;
> -};
> -
> -enum ad7816_type {
> -	ID_AD7816,
> -	ID_AD7817,
> -	ID_AD7818,
> -};
> -
> -/*
> - * ad7816 data access by SPI
> - */
> -static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
> -{
> -	struct spi_device *spi_dev = chip->spi_dev;
> -	int ret;
> -	__be16 buf;
> -
> -	guard(mutex)(&chip->lock);
> -
> -	gpiod_set_value(chip->rdwr_pin, 1);
> -	gpiod_set_value(chip->rdwr_pin, 0);
> -	ret = spi_write_then_read(spi_dev, &chip->channel_id, sizeof(chip->channel_id), NULL, 0);
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> -		return ret;
> -	}
> -	gpiod_set_value(chip->rdwr_pin, 1);
> -
> -	if (chip->mode == AD7816_PD) { /* operating mode 2 */
> -		gpiod_set_value(chip->convert_pin, 1);
> -		gpiod_set_value(chip->convert_pin, 0);
> -	} else { /* operating mode 1 */
> -		gpiod_set_value(chip->convert_pin, 0);
> -		gpiod_set_value(chip->convert_pin, 1);
> -	}
> -
> -	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> -		while (gpiod_get_value(chip->busy_pin))
> -			cpu_relax();
> -	}
> -
> -	gpiod_set_value(chip->rdwr_pin, 0);
> -	gpiod_set_value(chip->rdwr_pin, 1);
> -	ret = spi_write_then_read(spi_dev, NULL, 0, &buf, sizeof(buf));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI data read error\n");
> -		return ret;
> -	}
> -
> -	*data = be16_to_cpu(buf);
> -
> -	return ret;
> -}
> -
> -static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
> -{
> -	struct spi_device *spi_dev = chip->spi_dev;
> -	int ret;
> -
> -	guard(mutex)(&chip->lock);
> -
> -	gpiod_set_value(chip->rdwr_pin, 1);
> -	gpiod_set_value(chip->rdwr_pin, 0);
> -	ret = spi_write_then_read(spi_dev, &data, sizeof(data), NULL, 0);
> -	if (ret < 0)
> -		dev_err(&spi_dev->dev, "SPI oti data write error\n");
> -
> -	return ret;
> -}
> -
> -static ssize_t ad7816_show_mode(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -
> -	if (chip->mode)
> -		return sysfs_emit(buf, "power-save\n");
> -	return sysfs_emit(buf, "full\n");
> -}
> -
> -static ssize_t ad7816_store_mode(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf,
> -				 size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -
> -	guard(mutex)(&chip->lock);
> -
> -	if (strcmp(buf, "full") == 0) {
> -		gpiod_set_value(chip->rdwr_pin, 1);
> -		chip->mode = AD7816_FULL;
> -	} else {
> -		gpiod_set_value(chip->rdwr_pin, 0);
> -		chip->mode = AD7816_PD;
> -	}
> -
> -	return len;
> -}
> -
> -static IIO_DEVICE_ATTR(mode, 0644,
> -		ad7816_show_mode,
> -		ad7816_store_mode,
> -		0);
> -
> -static ssize_t ad7816_show_available_modes(struct device *dev,
> -					   struct device_attribute *attr,
> -					   char *buf)
> -{
> -	return sysfs_emit(buf, "full\npower-save\n");
> -}
> -
> -static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
> -			NULL, 0);
> -
> -static ssize_t ad7816_show_channel(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -
> -	return sysfs_emit(buf, "%d\n", chip->channel_id);
> -}
> -
> -static ssize_t ad7816_store_channel(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf,
> -				    size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -	unsigned long data;
> -	int ret;
> -
> -	ret = kstrtoul(buf, 10, &data);
> -	if (ret)
> -		return ret;
> -
> -	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
> -		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
> -			data, indio_dev->name);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7818.\n", data);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7816.\n", data);
> -		return -EINVAL;
> -	}
> -
> -	guard(mutex)(&chip->lock);
> -
> -	chip->channel_id = data;
> -
> -	return len;
> -}
> -
> -static IIO_DEVICE_ATTR(channel, 0644,
> -		ad7816_show_channel,
> -		ad7816_store_channel,
> -		0);
> -
> -static ssize_t ad7816_show_value(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -	u16 data;
> -	s8 value;
> -	int ret;
> -
> -	ret = ad7816_spi_read(chip, &data);
> -	if (ret)
> -		return -EIO;
> -
> -	data >>= AD7816_VALUE_OFFSET;
> -
> -	if (chip->channel_id == 0) {
> -		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
> -		data &= AD7816_TEMP_FLOAT_MASK;
> -		if (value < 0)
> -			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
> -		return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
> -	}
> -	return sysfs_emit(buf, "%u\n", data);
> -}
> -
> -static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
> -
> -static struct attribute *ad7816_attributes[] = {
> -	&iio_dev_attr_available_modes.dev_attr.attr,
> -	&iio_dev_attr_mode.dev_attr.attr,
> -	&iio_dev_attr_channel.dev_attr.attr,
> -	&iio_dev_attr_value.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ad7816_attribute_group = {
> -	.attrs = ad7816_attributes,
> -};
> -
> -/*
> - * temperature bound events
> - */
> -
> -#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,	\
> -						       0,		\
> -						       IIO_EV_TYPE_THRESH, \
> -						       IIO_EV_DIR_FALLING)
> -
> -static irqreturn_t ad7816_event_handler(int irq, void *private)
> -{
> -	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
> -		       iio_get_time_ns(private));
> -	return IRQ_HANDLED;
> -}
> -
> -static ssize_t ad7816_show_oti(struct device *dev,
> -			       struct device_attribute *attr,
> -			       char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -	int value;
> -
> -	if (chip->channel_id > AD7816_CS_MAX) {
> -		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
> -		return -EINVAL;
> -	} else if (chip->channel_id == 0) {
> -		value = AD7816_BOUND_VALUE_MIN +
> -			(chip->oti_data[chip->channel_id] -
> -			AD7816_BOUND_VALUE_BASE);
> -		return sysfs_emit(buf, "%d\n", value);
> -	}
> -	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
> -}
> -
> -static inline ssize_t ad7816_set_oti(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -	long value;
> -	u8 data;
> -	int ret;
> -
> -	ret = kstrtol(buf, 10, &value);
> -	if (ret)
> -		return ret;
> -
> -	if (chip->channel_id > AD7816_CS_MAX) {
> -		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
> -		return -EINVAL;
> -	} else if (chip->channel_id == 0) {
> -		if (value < AD7816_BOUND_VALUE_MIN ||
> -		    value > AD7816_BOUND_VALUE_MAX)
> -			return -EINVAL;
> -
> -		data = (u8)(value - AD7816_BOUND_VALUE_MIN +
> -			AD7816_BOUND_VALUE_BASE);
> -	} else {
> -		if (value < AD7816_BOUND_VALUE_BASE || value > 255)
> -			return -EINVAL;
> -
> -		data = (u8)value;
> -	}
> -
> -	ret = ad7816_spi_write(chip, data);
> -	if (ret)
> -		return -EIO;
> -
> -	chip->oti_data[chip->channel_id] = data;
> -
> -	return len;
> -}
> -
> -static IIO_DEVICE_ATTR(oti, 0644,
> -		       ad7816_show_oti, ad7816_set_oti, 0);
> -
> -static struct attribute *ad7816_event_attributes[] = {
> -	&iio_dev_attr_oti.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ad7816_event_attribute_group = {
> -	.attrs = ad7816_event_attributes,
> -	.name = "events",
> -};
> -
> -static const struct iio_info ad7816_info = {
> -	.attrs = &ad7816_attribute_group,
> -	.event_attrs = &ad7816_event_attribute_group,
> -};
> -
> -/*
> - * device probe and remove
> - */
> -
> -static int ad7816_probe(struct spi_device *spi_dev)
> -{
> -	struct ad7816_chip_info *chip;
> -	struct iio_dev *indio_dev;
> -	int i, ret;
> -
> -	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -	chip = iio_priv(indio_dev);
> -
> -	ret = devm_mutex_init(&spi_dev->dev, &chip->lock);
> -	if (ret)
> -		return ret;
> -
> -	chip->spi_dev = spi_dev;
> -	for (i = 0; i <= AD7816_CS_MAX; i++)
> -		chip->oti_data[i] = 203;
> -
> -	chip->id = spi_get_device_id(spi_dev)->driver_data;
> -	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
> -	if (IS_ERR(chip->rdwr_pin)) {
> -		ret = PTR_ERR(chip->rdwr_pin);
> -		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
> -			ret);
> -		return ret;
> -	}
> -	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
> -					   GPIOD_OUT_HIGH);
> -	if (IS_ERR(chip->convert_pin)) {
> -		ret = PTR_ERR(chip->convert_pin);
> -		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
> -			ret);
> -		return ret;
> -	}
> -	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> -		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
> -						GPIOD_IN);
> -		if (IS_ERR(chip->busy_pin)) {
> -			ret = PTR_ERR(chip->busy_pin);
> -			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	}
> -
> -	indio_dev->name = spi_get_device_id(spi_dev)->name;
> -	indio_dev->info = &ad7816_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -
> -	if (spi_dev->irq) {
> -		/* Only low trigger is supported in ad7816/7/8 */
> -		ret = devm_request_threaded_irq(&spi_dev->dev, spi_dev->irq,
> -						NULL,
> -						&ad7816_event_handler,
> -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> -						indio_dev->name,
> -						indio_dev);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
> -		 indio_dev->name);
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id ad7816_of_match[] = {
> -	{ .compatible = "adi,ad7816", },
> -	{ .compatible = "adi,ad7817", },
> -	{ .compatible = "adi,ad7818", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, ad7816_of_match);
> -
> -static const struct spi_device_id ad7816_id[] = {
> -	{ .name = "ad7816", .driver_data = ID_AD7816 },
> -	{ .name = "ad7817", .driver_data = ID_AD7817 },
> -	{ .name = "ad7818", .driver_data = ID_AD7818 },
> -	{ }
> -};
> -
> -MODULE_DEVICE_TABLE(spi, ad7816_id);
> -
> -static struct spi_driver ad7816_driver = {
> -	.driver = {
> -		.name = "ad7816",
> -		.of_match_table = ad7816_of_match,
> -	},
> -	.probe = ad7816_probe,
> -	.id_table = ad7816_id,
> -};
> -module_spi_driver(ad7816_driver);
> -
> -MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7816/7/8 digital temperature sensor driver");
> -MODULE_LICENSE("GPL v2");
> -- 
> 2.47.3
> 
