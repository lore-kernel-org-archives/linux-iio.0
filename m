Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180328;
	b=TGK9jPnW9PuXdg9HRyi+90YsFdXL6PSmNLHvoezWEPuS/LEaXN9P7A+IiN98M0SXqjuN
	 vkRNU42QMAaQOKiWs2It1Xat3ggVnaz//lHsDT+bs5XiFtrUguGSMkzsQE4jQBENW9O0o
	 I92vA3cdcc6MmsRA0bH5kizwd05Os8YDHdqrpVSvqMughF9nkcVFgVwI75BRRfxCTSzuE
	 XoTYUMzJDiGDW6vhRMrht9QCzQzkL2Cysb4IVemo90k5odi6yQG3FQn3lsoHQn/fvEPri
	 N9q/UYTwRfFwZlVnO+mr1Mx9xcDgsxg1JuQqI16NrjyjS9frJn2xj2MT0hFsAx1l3ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180328;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tM5fkt7mYn59uI0Ze5O+2LP6RI/U80ShJAs/cekOZgQ=;
	b=KBZlw1eowP62eqp8yvVcyCL7bDEFol/1y90rr+fWPUCOj+nhtkhjaY9gAQAbvF6yeit8
	 ATYMK3diILwf3IfPH4I40rTs4ruOS4vzzvfITkfw3ufh0HBDZu5fQnkOZ+8MncF+FGqMN
	 1r0IRCF+qd338RR5GI+kiA3Rq9xYGclFyHwFI8uNmLzJ933J5Xo/ZRKR0H8rjQ5+6T4gR
	 XgoSC7fKmCgHNu7AnRYNUwfuVRz1lsHJ5zVKj8hREc8l4xSMQxQ+WKBWDtxXHgA0t/rZN
	 gvHuHpHYccyDON/PLlYkMSqT54I+ojY8ZeKkfUGIfyLPEB9vmA5lrmTuKSLQTS2oAAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=byt6Wor5;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=LbJqk2FR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC2606A31C;
	Wed, 28 Oct 2026 09:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35CC2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=byt6Wor5;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=LbJqk2FR
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8GiE51929167;
	Wed, 28 Oct 2026 05:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=tM5fkt7mYn59uI0Ze5O+2LP6RI/U80ShJAs/cekOZgQ=; b=byt6Wor
	5ChQL6fxmcYmXMRgUAWxtnxyWyGwmSuyqgiUQ+0MFpXx51TY7JHq7+xRJEXihx8w
	KPgP6H2jWVD2N5vMJDckm1w1cbRAPNJ6TD/JzRDw/WS82bWEdZhRgN1WuLK9mEKx
	GqfFrdWaN44D6XnnjeuC+eLXLauougoPuLmHLiYw0oVgZJcT1GSWJ+DV75l/BuMj
	ELoGgj9hVBpPFQNkGSXNeCi0QGwd/Y4l9sW6h0D4TlzA1BsVjKIlIkW1+AI6RrRD
	0St9a15/rHFq/yMT+NNsmzDjuAN/6i7hO8ASL2rjyVusje2cIgnv4/INoICbA5wF
	b16xFb65wYrYerA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tM5fk
	t7mYn59uI0Ze5O+2LP6RI/U80ShJAs/cekOZgQ=; b=LbJqk2FRHp1HsYCsOsg5t
	m3IDMF03/itS07Ur83imVUjfoOAM3t8eHixj0jLBDfKvuWNkegks7s/pUV6upXej
	gb0SyaVnOwcbC09t7Ep6Sj2xbVEzHLN1Apn4Eu8xvwFBOXS8AOrvl2xzvLaMQcsl
	X828c1Bbg8rjr7OK5ukhcx0DAbN0IFFFLU5HepsOr3fCFxNe2+5g+IIBn+zORVdi
	gKUJ1tyJCU8iosr8UmxPUgyI6lpJgAnWbHFC2/7+jZeY1fnh1hg8Frwi+TX+p+Tr
	rO7/CV9JCr55HZlOZ/suLapeA1+jZx7pvLlN7MXpokltAp7mKyqvX7pC5v3sHHDm
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hk3y3aym7-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 05:38:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBBfXMbW/p9AWlhaVnID0RW81wF5HsoaqKl8gHCTNhd2iSMHCl/NbGH806FE/hWN8PdTu3x88VbfPJKEWCcGR+LE4nrjpwM3s/WBCoz+WnmGowEqvHSCAQZun2fu/8emzNgjhPhX9S/G1mrR4f+c2fKbmPQl+rgtF7YA7cyvuXXhlerpN1qGNKELVnDy/xnPTQAYhNiEMgYEyxRjYBdHjpEWiVC+JoxcddM/5b5aBUKwZarZO5DGh25I09dHazoZiqV1Kz8He0d6SJTOOFn3KQLPl+2TdkM/9/wgKC51WJfZviKblUYZSCeDOtiO5eAJyz4JC2AV+jqajAnUu1Iaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM5fkt7mYn59uI0Ze5O+2LP6RI/U80ShJAs/cekOZgQ=;
 b=L0pUXa8ztB9K9OktVzKkhtJHvOPT+cZv/ccFFfAun9E1l5VUp177uR9j2bzAVkJ8xd74LXRnCDbQ8AHQpyBtyZTNSiMLMwzqPAX0cs7k/vqlQ64MZEXp0NtUhB1eWozsduRmtRzFIMnG0FdfaQc5nzF9Xh3gZUjrzA3ldCq34XB1u2AleLeBI9bxOyq2JAIx22JXQUOdvt7UGGVEFaogskd7A6cpx/eUMsfv+54BqZ/4P6vMMY+EbvmQuGkCBZAnv8dRuDZ/dtyacOxLMypIHM+rFv0g7v4SHetNPjt1JpwT//CtDnqRBqLY7/9pVdHYb5kfAoFYYTfwJjXNJnco3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN2PR03MB5296.namprd03.prod.outlook.com (2603:10b6:208:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:38:41 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:38:41 +0000
Date: Wed, 28 Oct 2026 09:40:03 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 05/15] iio: adc: check the result of ad_sd_init()
Message-ID: <auHC27EyvvR9TYKu@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-5-0d818334f6c7@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027-llm-char-misc-iio-v1-5-0d818334f6c7@linuxfoundation.org>
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c3bcfc38-d9d1-4152-6cd5-08df34d74023
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|261009223027099003|261009220027099003|261009223327099003|261009221727099003|261021123027099003|261022105027099003|261009221227099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|11063799006|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 jVNPJuuXw2IWWdybFl6lpoU2xFp2Lo8yljeVYspWA8s5utDPa7hfGvR3OsGVpKqB7pwU+BsRMK9kglyZO3SwGVKA064Bnopg25n2qCqMX8Us8hz6WeNB4twLyHpEuXWkXC0yo+1c1ilghGJEds+l3MjuxH2IBBmhyioDgLYF8qnad2uU6PPm0vuAWoPcNKRlO9gYFUDGw6+3S1r5z0Cjj8rNb8N7F+g9R+kPF8bYFzKrZraLkTri7zb7xFm7X9lwUKgjHiNlDcWvzHVBdESMwmJ5dJfReNnoMi/vnVtDZd5U9fZ6DOSmeV2k8L/fw5bddbqN9lv9QyTMi4MRjWfgZsjqHzDKgOEUw30inorYo1f/5C1GK2/pkfbE9LaudEQTMi1zauKToG9xHtrDwpedQ2eMuFPqub3nIQF8wZfIU4MYeeqI8QiPlIWXfvkWOjYtuvE5cA75wrGmYZ7ELx++WKlBGablvAzQSaNimgVwlZnIumGXBw0An59nO9txvO7rwHWLBcsba19EsvBQWy2ASBHOvqHSA3jCHBKwvY5IUfvvGHti9c0yTsAx4COgJZqNTiYtq9EZi+w5BbGUMNbV08V8z86XUjpBpG21J3LANmvoNuHptSd6Om7dxxbyP0Scr6zV5/4a7LT2oKYQZrtqZzVNbSsAhQGWD+GYdHZBW+E=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(261009223027099003)(261009220027099003)(261009223327099003)(261009221727099003)(261021123027099003)(261022105027099003)(261009221227099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TWhnMHpJcU51RGlKTHlEQVpJTHN5VTRNUG1FYmN2VDhwU0RzNzlidGQ2Y29p?=
 =?utf-8?B?RGVlaU9vdWtqSWFWNm1uaHdvVUhLQXNVbEY3S1h5MGR3UUdWblpKR1lOMy82?=
 =?utf-8?B?ZmFBaVdBaXdab2ZMUGFUNm5oZXd5SkFEa2Q0cVFheGFGRzJqcjBiQmdLeXdM?=
 =?utf-8?B?Z1p2WWpKaGpIdE5SK3ZDZWEySzRGZWJlei9OM05wakoxeExVMkhDZDdyNlQ1?=
 =?utf-8?B?STh1cmQ3Q1JSWlVBeTNXSElWSGJGUXVvK1NpMFRKbUNVVnJSeWI4eTFHTTdS?=
 =?utf-8?B?bHBUcVpPNmZsa0I2M0JKVkJqcVVsUHVpOG45YXl2T1prckk5bis2TWc1a0wr?=
 =?utf-8?B?ZjhSUGd0TnlUVk1XdzQ2OHBET1dObXI3MmtmbUczandxTTVXZ1prU1FoOWgv?=
 =?utf-8?B?L0RrelZWVkRsSi9QeTZnOGIzWGROd0VXM3kzTzc2cXU2U2RuYzRxcXJJU1pF?=
 =?utf-8?B?aVJoTWc4UjhtMGlOZ2VPYk9xaVQ1Y1doOExOVmk3WEsvbDkxWHBCQXVrcGk3?=
 =?utf-8?B?WW5mdDVQOEI4dUpWeFEwOTRtRTljYVhyajhjcnlwWXlqUE5WSVdPSnYwRURQ?=
 =?utf-8?B?Ry9Fb3QxV09zNlBMRzZnSWcyaHR4cDNjcGFTa2RtNWVJS1R5VlY3TTNTeWw4?=
 =?utf-8?B?MkdZWm5FdWVjTm16WnZjcmdRVmlBelp4WUdiWUwvdis3UUUzcThGRk9hcWxy?=
 =?utf-8?B?OHBMUVVBWFpEREFsYWpZRklQTStWV3pWRW45MlNEbkVQZzhueDZtQmhlU0Js?=
 =?utf-8?B?SzRldGRaSWl0UkFFZERPc1VvTVNtNjAvTnRQWWJObmpSOWJUbExRVVpkUW9w?=
 =?utf-8?B?aGU4OTBKb1c3K1VWeFdOUjRDTkkvY1JVNE1ZUnh6V1JTbGsrNjVNUDNmc3VF?=
 =?utf-8?B?cEJvUjF1WVZ1RHZtL1RsVndNMVllSVcxcDlZSFVPK1JjamxCcVFSNDNtZTFk?=
 =?utf-8?B?OTNGc1ZQMlRJSGY4V1FEVUZDendpa3FaVWhnUVFwc0hJQlY2eWhZcG1EODdO?=
 =?utf-8?B?NzJ6cmV0bEdVbU5MQStZSXNaZzJuQzUrNlJZQll6cXJKaE81akRORTR4L2Jt?=
 =?utf-8?B?SjRtcmdNKzZJMXpIYjhDa0hnNXRERFNINVV2aXB4REtKRktyZ3VnczU0SHFB?=
 =?utf-8?B?WThLYi9uMFdtZ2VFMTNKeFBlelJzdTNBNnZTTDVZaEhYWXU4eThMNjhSdXcy?=
 =?utf-8?B?NkpkOGp2OElRcXhhV3RFbEQ1bG1Ba2xKVVpwOTlCM1Z1QWRwbjdLY2pXaDFu?=
 =?utf-8?B?em5wTldGd2s4cHVLYzRSeEo4RHB4K0NEMHVMWG4zMWt2ZDF0aWhQZ2wwUXN6?=
 =?utf-8?B?VElmNGdZd2lMR2swS0xsTEZCTE5kaDhXNGFUMEhHQ09hTFpTL3JpSnJLemZu?=
 =?utf-8?B?SjJPUVhXa05RV055dXM3NkczNytxcFkydXFWaFVIWHpyWjh3WmxlUWJrQ3dw?=
 =?utf-8?B?L2xCTFNIaU5OalZ6WVphMHQwcjRyaHpORUpqOXROTEdTbW9weG5kZndQMGx1?=
 =?utf-8?B?ZEs5RG1NQUhNZ1BQV1FPclpCcUJ1VENzY0hXc3JKTWlieWowMngvTVBzYWRQ?=
 =?utf-8?B?ai8xcjYvWG9NWE11ZWtuenN6bitkU1hCc2tRUHIrUnBYWTd3SlRmcEtkQ25V?=
 =?utf-8?B?cmk1VW5tWWZZQ3hBbmFIUlFRSFNJUDNaaXZPeVhhbG4yNG01eVAvaFpweHhB?=
 =?utf-8?B?emJvU0ROd2hWYnVRL1lzZkttbWYwcnpTeWFDSlA4K0ZRMEh5aTQwK2VOS2Nr?=
 =?utf-8?B?M1M2djJzcmhwY1Y5NkRheS8vR3duZnU1L2t4R2wvRFVqMUVybGNLQW9yZGwr?=
 =?utf-8?B?STVLN2VwdUtjTFBXZVI1eHVKdUNCdVBqK2ZWR2dFQk9YRWRoNjF2NW1HOTVY?=
 =?utf-8?B?RHlKc2NwVU0yZ3BJQW1yVHMwd0J3cVVCMHJFY3dkdUE0RXFwOVl2cFo4UkNT?=
 =?utf-8?B?Zi9SWmtpaUJLRDc2Z21EOEJJdFVYZ2I5VGRIQ3JjQU8vbVo1SG5QRmorc2J4?=
 =?utf-8?B?MXZCdXcvbmh1MWR0YXZOc3NIaW1vOUI3aUlqYUp4aW81UWo0ZDF0U1N6YnJN?=
 =?utf-8?B?VDVXUXlrYi9zdENHdmpWS3dkRFVqZkNoWVAzMDIyU2s2Sjh5VjZOS0V4YWlW?=
 =?utf-8?B?azc1WjBta1IvTmt4bWphSm55UlRKV1hjNDZ5K0hDWEs2cE1mM3Y1SitrWlpQ?=
 =?utf-8?B?TjV6ZkRhNWRLY201YjZjeGdEa3hORHNUQWFvTzJWSFhVbjFuNS9xRytDKzZI?=
 =?utf-8?B?aHNNMlg0T0pQTFdtRkZpcHN0dC9HUFdWYmdJZmJ1RGN5S25BOFNHTUR6Vm1Z?=
 =?utf-8?B?aU1TSWNlSjllSzRkS2UydWFFS3BobFJEVmNGMVdaZGQ3ZFF4VDF4UT09?=
X-Exchange-RoutingPolicyChecked:
	JSJBOmzb//0htKnuUuL7NONScbnoVNuzUmpNp8yTl9lLv8yv2waO9S4w9Fl1M9dtfOEYNuAnKbu1ZAHzcc31TNH86MzzIKFQeFVu8JRoN/bFdGOV3htZKn+nipk8ff2l8go0ng13F14Xxp2l+N1qPZVotuRDNFlUym3ZBcLlxQrtrUiIJhiltWSNdq89QxSTHSeAAbyKSYJjL4gIV+8l74OkDBb1W5Z4aw//Y5to9DZmrb+olIrQPrrOTuegRfGQDEA247kW1hMJgp8WdQIkmYuZr+A1W58HMY9R9PTBRSCSXXnBTAy//GzlTSpTlQD1JFvkywXzxr9CJ9p3baU3og==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bcfc38-d9d1-4152-6cd5-08df34d74023
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:38:40.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJX6bI5yay0LhFp9nSV2NRrAvoTzJWstzzSpa4fymqbsnvb3H4QHI8LwjlMKeXGeix2JLa6ibPAJKR7B1U4XFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5296
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX2eVR2cjLx6B4
 2F9n2unWv0kH7ijwOFuJRcXjMgiZDcru1yylgUA5+llChztgoljSz3Z+gylJX2uRc9baMFHQQUH
 1pc3NLODeaDxuumhzUWyX+xBG4PTIcCr+aMe9h38cS0rUrXlbrHORy2SqLke9Sc9ETt2eYzIzw+
 vbeqXv8rkCosr3K/sxmws9/zqQB8CX+o/IF2vQZj8jvqKQwKNsEky4M4bvzHlcp12aZNlbUNDta
 JWHLTjskg31OKIHdH8D+L9748pyp9NQ0BvH7159M4hUVREXQE9bAAR9qRoRKjaHBDOYk32PGQ37
 jvgxGa9axSt4tow/aomczBjQoZaWSMclQIF9/PDxwj/Y/VPnZO8baeh+6DX8/cdNyKXvnm3Y12s
 vwb4RJbvrRgcT4JlLOpL7z4lw34Mj3MJRxkW5/se6Y1PhoG5ryJorTH+X9A9owUj0aFP97F2D9V
 N6sr8SnBo69m6jw0hlg==
X-Proofpoint-ORIG-GUID: CarBCtmxQRaiFKQWna0rIaSDapIdRvMA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX/PRzMCtJ92aN
 gFNhys7FXI088DofaR1FQ1B/kaNjIF61Zw764kWskD3+/4TMRQq+0B8YVNcnXbdNwnw4i9BLfBf
 rSUDHWOPtD1jW2cEVYv5flW6/gptqs6UHUOrtdkRfimJJ1ICvm/g
X-Proofpoint-GUID: CarBCtmxQRaiFKQWna0rIaSDapIdRvMA
X-Authority-Analysis: v=2.4 cv=HrrjiETS c=1 sm=1 tr=0 ts=6ae1c2a3 cx=c_pps
 a=56WOIFdoL1k8+DRIoLPNvg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=IpJZQVW2AAAA:8 a=ag1SF4gXAAAA:8 a=t8vl3Q9cHziSSlIYz4EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=qR24C9TJY6iBuJVj_x8Y:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280038

On Tue, Oct 27, 2026 at 05:19:09PM +0100, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> ad_sd_init() asks for the optional "rdy" GPIO and returns the error if
> that fails, for instance -EPROBE_DEFER. The binding of the AD7780
> describes such a GPIO.
> 
> ad7780, ad7791, ad7793 and max11205 ignore the result. The function has
> then returned before it set the driver data of the IIO device, which
> devm_ad_sd_setup_buffer_and_trigger() dereferences a few lines further
> down in these probe functions, and sigma_delta->rdy_gpiod holds an
> ERR_PTR() which ad_sigma_delta_clear_pending_event() takes for a GPIO.
> 
> Return the error, as the other users of the library do.
> 
> Fixes: a87ef09b1fdf ("iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO")
> Cc: stable <stable@kernel.org>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Renato Lui Geh <renatogeh@gmail.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Ramona Bolboaca <ramona.bolboaca@analog.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7780.c   | 4 +++-
>  drivers/iio/adc/ad7791.c   | 4 +++-
>  drivers/iio/adc/ad7793.c   | 4 +++-
>  drivers/iio/adc/max11205.c | 4 +++-
>  4 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
> index 1cfad70320fe..c1428f30241c 100644
> --- a/drivers/iio/adc/ad7780.c
> +++ b/drivers/iio/adc/ad7780.c
> @@ -311,7 +311,9 @@ static int ad7780_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	st->gain = 1;
>  
> -	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
> +	if (ret)
> +		return ret;
>  
>  	st->chip_info =
>  		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index c2688307bbba..10aa40ca35e7 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -435,7 +435,9 @@ static int ad7791_probe(struct spi_device *spi)
>  		return ret;
>  
>  	st->info = &ad7791_chip_infos[spi_get_device_id(spi)->driver_data];
> -	ad_sd_init(&st->sd, indio_dev, spi, &ad7791_sigma_delta_info);
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7791_sigma_delta_info);
> +	if (ret)
> +		return ret;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index b0f44c144f20..937c8b09ad45 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -796,7 +796,9 @@ static int ad7793_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
> +	if (ret)
> +		return ret;
>  
>  	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
>  		ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> diff --git a/drivers/iio/adc/max11205.c b/drivers/iio/adc/max11205.c
> index 53ac2f4f383e..e46e90400bdc 100644
> --- a/drivers/iio/adc/max11205.c
> +++ b/drivers/iio/adc/max11205.c
> @@ -114,7 +114,9 @@ static int max11205_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);
> +	if (ret)
> +		return ret;
>  
>  	st->chip_info = spi_get_device_match_data(spi);
>  	if (!st->chip_info)
> 
> -- 
> 2.56.0
> 
