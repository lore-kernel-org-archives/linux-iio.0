Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986C47A895;
	Mon, 14 Sep 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400416; cv=fail; b=tf2E4DXbWJpTJqE/tJnm/LFFpyk2yjqR7oguICZ7umB+WYUckaUKLbL9O+pfwg+lNMW8KBqhvGURMYH/t1LgGJOq23KGWzMcHnUi+lHcncUelwDGE7V4TbSaLzfCj/zLU/F3OYXOG8UxFrbux/8V6nGoelZLV1ulkpfOB1bOgYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400416; c=relaxed/simple;
	bh=X9qY07LR4emHxITyWwizO+P+T2Bnxy+cRYIN5JtTsnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WwNUOukoIoN5S0qkdT9WUt5HxEZ8T+qpSCzbNVaPOP0VxG5az4ncWf/FEDzv2/3T1YbvX8eMLV6ComWgyTGye0SU8wOn9LK6zE/ibA/vpQ9DizE7Rs/oMo+ZI6TV1T7u9eBltrystr7xHA87nshqBf23MLQV2QYFnBszMyOp3iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cGSMjKuy; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cGSMjKuy"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED6LKC2410783;
	Mon, 14 Sep 2026 11:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HWTRV
	1BhUywYa64+Lg+ZmUvvuEqn1bH5NEmc/1LuSgs=; b=cGSMjKuyN9rawqkMdxkG4
	iJVXY2AGKTdkVL6N6u9EhXR2Mx4sCDqvGmSaB8JiOWNo/cZm3WLNzxw1ZfRZLEjr
	bqUJ2saBNowavsPC0E8LDNO/0/T5iM3eU6IrU578LnTY2P50UunKi18NbaaHQFQL
	hcHMcpNsy5a28+Br4NqmyOkqt3N3W9M1rQMzTpdaODjqJEMQMwT6kBmfrix7cb72
	UUCQpwP+t8I/uE94Ix9rOad75v8MJHNG/ZFJoR2/ox1QXzAlD7M3zrCQ1JRtMK8t
	QdPKijNdFEjGaekiIna2RTHdqAnfFDj7lyHPfZ5+XB0aLqJVqViocEh3mv24B+pC
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gnr2gdvb0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 11:39:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTtJY+ht1OFYw5U2z3SDZNVKlBDshd0+uX8wDiLe2pCVyRifOitJb2RUwjpyHyn/DNebL5y+xzmXJMM9wHdqGd1beeYpeDA9hck1CarzYT3mzpjIfUbKhLbuOMi+PNNeoICY4YGHWjY75iPM3Cofg4shQUByOf48PNhc+5A4H0qCRPF1yqtnMss6mKvtMviNtcMJEWE3aq428pbCG6iKwt72saPQZDbQxvZDYK9w0MS7LVHQcXexb8xoaXdAYF4XEVAxNDq1V80s/3yjxbTSiWwUE3ha4FVWDlDCS6cEGKaEatIPatDS7kx3Z3T241r5rBfo6vUgHUAefyqz2SFrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWTRV1BhUywYa64+Lg+ZmUvvuEqn1bH5NEmc/1LuSgs=;
 b=S/d0e2n+pj4JK1dfEmz0/qrEyv3rNOU+teNpksJbUF1LrNeuYRazB7pqaWS+J33SV2byhegGq+OiiUe9roKHRArgixA7kZ1lJZgRJIkAmgFMXxATYIN1io59UbduBWLoEZikpdcwaF7gYqRpTpZTL7aA8kdbsXQBvJcMM96Ke00R1IqChyujvDoJIhmQF0eagl4mQFL0zxQ278YdONBGVsEx2vfgkDWuc8o+eHYgLLkfe/Wx7bDGhWlvWF9NU0szmhV/qWLMPpJqLktk+yG6LLZJLdkQwhELJ6RIQGh7RPB3SOI2qtm9ZnRahyEWAjaCGp+/o2a6ocuCSNceqPe6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5171.namprd03.prod.outlook.com (2603:10b6:a03:220::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:39:29 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:39:29 +0000
Date: Mon, 14 Sep 2026 16:40:45 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqgVSNnyXZQpsqYn@nsa>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqgCQvRw9fns__0d@SMW015318>
X-ClientProxiedBy: MA3P292CA0057.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: a435a2da-2f15-43c6-c69c-08df12765db2
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|5023799004|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 phqhB0n4Bgdi+7p4yeImTWjVrqji1YGLFk4BhegQtLhDL1pI4LG8TUUL1FoIKuU/BDtkl1wvCUQlq0KiIHfZ2XWaGvMSe8r3e8psZvXTBhrEBBA5Rznhr6CjkQEz4ZoQO4aCbtJWdegfLcg4u6ETY14EdIe/w2VsbN+mPfa6lwEBaur2ZlBFNoSM9VZnuHq3ejGRDBc2H1WhOwhEuM2L0Bt99y21k6B/11plbkuJOQhtcIbjdKlFg8YoFs/4YX8/y7pb9KTksEQIc5K/SzohgAzLl1ZDn5Yya5nw46ciIp5tER+hDxHimAXJk8aJZzjmlN2POZa5/O+OVV5zL63U4mHwwogwX3/fjv1mdgBXIYuwd7NBsRPLJcaqIhKPoyaZAz9FRQu7/kmpRTPWNcOi1CR9urLUFfD+h3nICwr8KYN4WUHnvHnV8bjMv6/+US98NIAIMdwgxQhHII9M94NUw8NIsoiJWc7geta0BTeTOXxw6+67cn+xriFHed7woVadIoPIPAbHfhdH0NrxbpQtlVsmTFNmjqUVOkYQOOmxuszE+9bEWnWyKgIgpx5hwp/GCzH8SQcaQW0viEjGnCk/AmSXO7rdt9THXgxjfTQ5JOdaeS6asYlqafoOJwgjxb8QLCzDBUAwCaBUEX5NQAudcxYtTNqFkEeRGs/R1CyEE0c=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RG9kR0s5MDZ6bkluVGY1bjB5SE9IeHBRRXVqeS91WkxyVFJJSDJHYzVYZU1l?=
 =?utf-8?B?bkZSWUREQ0MzbWhmVjgwdUJwOVdQL3duM1hOR0JBbE84T24wVTlOT3o3SXlY?=
 =?utf-8?B?Syt2Z2JEOExhM29UdkNhTHV6TGhWNTVvSk9JOXdISG1TTzhQdTVBcTVjbEhX?=
 =?utf-8?B?NlFpdVMva1VtVjNic1JxTWRmL0pkNTdDZlU1c2kzVW04a3JhUndSWGpHNjN6?=
 =?utf-8?B?OWx3TTY2MUMvY1hUb3RvOFhoc0grODlPRzBhVXJQODY2WHBLYnhzdVpGYnlh?=
 =?utf-8?B?d0l1andlQndHWnJqNTNzVFAzek90Zk40a1Z2dlNyR3hqKzZNR01lQTNrdUFG?=
 =?utf-8?B?d09Nc0haNGJwSnVBNVZ6MGZQbnNWckVLdDdNcVFYQTFKWkVQNmdxVTFrN3RC?=
 =?utf-8?B?N0lBcEo2VEpFN1JGZFF3bmw2Z3I4a29OR21MYzh6NTBXek9DVjM2Rk93aHBo?=
 =?utf-8?B?a1MwMThqUEVrUVpnNjVUYmovUzZsckV4dk1qMG9Ddi9hWEpRV2NjRXZQbkcw?=
 =?utf-8?B?UW5EU2gxL2VGY0gxZm1vQXVYYlZxWEtXU2lmV2xqSlY0ZHZHYUM3WWVZbTdU?=
 =?utf-8?B?Sy8valhrZWIrcVFjWTkxbG5kZ1hMUldXQ3Jlb3BvTGdCM1ZBTUlsZ0hTRTRE?=
 =?utf-8?B?d09Wa3FiWUx1TGw5ZzczdFVPQ1pBMTVlUHptTWYxQkJyTnZDSDM3aC9FT1FF?=
 =?utf-8?B?MnBQTXJvVzNkeEx5bE9TcE1jWi9ITHU4L0JINGxIZXJ1Y2k5ZWRNdHB3Smg5?=
 =?utf-8?B?VWlITTBhelF6VENUVk8xa2F6c0pwM3A1Q1BBa0hYbDJRMzlycGZrUjJvdVJh?=
 =?utf-8?B?ZjNzRjZuK1Vwdnd0VWFXb1pFTnVqWjUvSXVIamRRTVdlblIzZGYyYUVZY081?=
 =?utf-8?B?TEVjT2w2RVkyVVlJQmVpTTFDNGh3eTU2SEFzZE9aY1RCY3JVZmd1ZDMxVTh5?=
 =?utf-8?B?bzRlTlRRQWxVYWQyZy9BRFg1S2JIUWFhOGtNWXlacXNjR3hpQVdhbDRSdWpk?=
 =?utf-8?B?TDJhSW93VDdmMVdvRWtod0ZtNWNnTURhRzFHY0d3SEc2MXRMN0R3SEgwUS9U?=
 =?utf-8?B?SEY2VE9ZaXVQOHBYU2EraDNmQmN3TG9LYllYeDc4TmE0TDBxb2xxY0krTGhu?=
 =?utf-8?B?bThHa3JoQklCMjFvWmFualVtMThSMmJZckRwcHA5ZWZXeC9MMldrNURaV0pP?=
 =?utf-8?B?M1lWd0hXKzB2NFkyNmNlUFdQMmV3SlBNVmxhcGJpMXdGMGtGajgvRUtMc3FI?=
 =?utf-8?B?UjVkYWlMUVdkdWs1d2pJdHo0Ukc3YWp5NE1VTjAzaFZMVVFRQUZRZ0J1ck1T?=
 =?utf-8?B?SEtmN3JpaDhUL1dpTTEzaURkMGFNWTNnYSs4NGhmZnZWWXpYQXNzUkdsYTlk?=
 =?utf-8?B?dHYxR3dXMDJZQ04zL2pxbFFKWEpHMG14YU5vU3B5UnZNNlo5aHQ5N2hJWE9P?=
 =?utf-8?B?aDhaYlR2VVYza0JFQmFqazZOWGJsbEkxSmVyblB6OFFVUUExNUI2VHNmenlE?=
 =?utf-8?B?K0txVjh3VTdBR1BrUkhFb1IwMFcwRjFSNzgvSm5qYXplVkYrdjlVdmtsT011?=
 =?utf-8?B?RXorRnlzN3ByTWg4QzdiRlJ0WWd3dlJub0M4YWtOL1ZGSUU5OTU5ZmlBRmhv?=
 =?utf-8?B?N2xlSStIOXllaEEyUDRqMzk2RXkzVWJ5Q3NxYkR1MXNTRmk5S2JLQjNjcFhl?=
 =?utf-8?B?NHc3bmVsKzFmeUVmZDh5Wlg3c2tXU0Z4YkpOemVjVmRjY2gvdHF4SEllM0FY?=
 =?utf-8?B?aXd2VFA0UUt5MWxTZGhqTTgwcElTeWFZTDVWVmtMd0FSSVZGdXQxdnBQVkZw?=
 =?utf-8?B?QXFrUXFQaHJFK0ViSlBzbGlwK28xZ1NuWWdCUmtPdk5CRkFGdlp4T3E3M3Z5?=
 =?utf-8?B?VUFvN0d6UmdVSTg2VnNZN1h3Yi9hOTlBSURqaDRhNExjRTlIL1ZDVTMySGg4?=
 =?utf-8?B?a29ORjB2QjhFYmFXL054V3FzUG1Ud0RlcE1FNFZUbDJ3KzhFQkNpU3NuLzI5?=
 =?utf-8?B?eUxuNGU1NldFTVhBTE82OUVIWk5EVjVJZCtSRXc2eCs5RDlBMHlXT1d5SFIy?=
 =?utf-8?B?UU1GcGNYSWVVVmJvMGQwelVWR05lTERYeERYVm1lcXhzSkhrb1dOVC9naFB5?=
 =?utf-8?B?MzdQUTZNanA4RGMzeFJNNC84YlpsK1pEMUxRY2ZSd243aFYrK1k4MEZVM1pN?=
 =?utf-8?B?ZnVlYitlNDh3cXgvSVBhOUxPVzJ3VkpkUHVBWDZKbVdaeXFvbUtDSVBHUSta?=
 =?utf-8?B?MVBUWU5odUw2eXVsa3VwdEZjdStNSi9OL3l0WDdOVEsyRm9IeitWOThWYzhK?=
 =?utf-8?B?T0VTYjJvR3RJUWxDbmV5dW1kTWxhT2ZsY2RtcGRzbm0rRlpXZTQ3QT09?=
X-Exchange-RoutingPolicyChecked:
	jCJxlH7kCGXKQ/cGqj+Yi5SJx4E8gL7Yiv/6qMn9Xbw0hV167oI8+o7+HEwKxI/8W3d8UQGEpNKSpnQW37sFbfl0xrFE1hG7/UUHrMs/2a+yHrEqdch6Lnvo+HojhEwv4AlHFtH3y9ibrxxsNTLOSOco074mga0533My14hqYUjc6lfTKggovY9NKr5o8hJ56eDzznWPCHcnM79Zp6TgX4jed6+SOneAxml4e3EkmamrflDZ1Gu2WFD+yPUiztjOyym60fIH942sJdH8eizuYDMJhWcvoB75qRGNy/bHEjWlN2bMapJghsyIfgt29vEERzEDSo041oEf1IdaIFGbRg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a435a2da-2f15-43c6-c69c-08df12765db2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:39:29.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ab8RekCYCTt5KrHqxTMVJD/RhmQZrSDZBX8YdNIf1KeJGGmCtmiL2PeOa2rh35qE2bQMoyYXaAiHfu+1o9/RFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5171
X-Proofpoint-GUID: ULjYfk7C2OmSnK23xWke2V2jlBL9t1fH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNSBTYWx0ZWRfXwqbyGJUgI/W3
 dvDPZATXXdT69YeATPaCg1aDLT1iUQyRaohQkibP4CNihy0Qwe6hQAct196pQKfSvBN1dS4R1aS
 VrRrzCiv++gZIK/LGob9+10R+W+4eVtCGnBxWNq+5boDrRkVxLk352JADPfC7rK+Npk01jsvvGm
 Ul/fJbhKqLo6aTr+jkWPqejvWBlQGSHa6N4sALRv1cFC9iPs1SBe9riAdgi7KMKu2MSMx4wrEtd
 zZhTSwY1NSY/gDRU+jgEt3SDX85iy9PlL+bkXOSFnhq9rNoCJeQ/fK83MrVwDlHfw1O6jmDK42P
 HdpXGvlpAb6VGIlqcGcq4vrk5J1gPnUpZjjmHZFcR5Vj3lESnSmxbEvJIhEfOl5XcNwXIxpWcND
 E7u3G5T1W/kjDUXpAXoBImJZtwIPVxPfbcI0661Tv3AgInks+8iUQRWcHGZI5f8Gq1VHaiBd51S
 5pULLv++b47NH6gjt/A==
X-Proofpoint-ORIG-GUID: ULjYfk7C2OmSnK23xWke2V2jlBL9t1fH
X-Authority-Analysis: v=2.4 cv=dtdOmFg4 c=1 sm=1 tr=0 ts=6aa81538 cx=c_pps
 a=W7vQ9/Pp6pMPjVhEX4N8+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=c9-Zu535XA33cOSN5rIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNSBTYWx0ZWRfX02/1jW9zLBgt
 PpxzThIW/NUaqrDyiFZa7yygz8FKNvww9obgcRbhN8v31MKfPHFOvaPt4tIxhiEcZB+HXJJqNIg
 AnfKiIVFeDo8ZMpNv1v+UizHfaSgaDnUxP+8+udIFaNo5m/xlAod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140225

On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > In preparation for the bitmap based bus width capabilities, move
> > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > include/linux/dma/engine/types.h.
> >
> > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > new interface would make every one of its users pay for it. Keeping the
> > basic types in a separate header lets the new interface live next to it
> > without that cost. linux/dmaengine.h includes the new header, so its
> > users are unaffected.
> >
> > While at it, add the missing kernel-doc for the enum members. The block
> > already opened with /**, so kernel-doc expected every member to be
> > described and warned about each one of them. Describe the UNDEFINED case
> > in particular, as its meaning depends on where the value is used.
> >
> > No functional change intended.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  include/linux/dma/engine/types.h | 41 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/dmaengine.h        | 20 +++-----------------
> 
> I think it is good to split dmengine consumer and provider header files to
> hidden dmaengine's detail.
> 

Makes sense but that is a much bigger effort. Hopefully that does not
block the current split (series)?

- Nuno Sá

> suggest name
> 	dma/engine.h
> 
> so we can start move more API to this files.
> 
> after all user include this consumer header file,  old
> include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> which only include by dmaengine drivers.
> 
> Frank
> 
> >  2 files changed, 44 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/dma/engine/types.h b/include/linux/dma/engine/types.h
> > new file mode 100644
> > index 000000000000..2e8a266e42ef
> > --- /dev/null
> > +++ b/include/linux/dma/engine/types.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Basic types shared by the DMA engine interfaces.
> > + */
> > +#ifndef LINUX_DMA_ENGINE_TYPES_H
> > +#define LINUX_DMA_ENGINE_TYPES_H
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * enum dma_slave_buswidth - defines bus width of the DMA slave
> > + * device, source or target buses
> > + * @DMA_SLAVE_BUSWIDTH_UNDEFINED: no bus width specified. In a
> > + *	&struct dma_slave_config it lets the controller pick a width, typically
> > + *	derived from the transfer itself. In a bus width mask it is a width a
> > + *	controller genuinely accepts, meaning it imposes no constraint of its
> > + *	own.
> > + * @DMA_SLAVE_BUSWIDTH_1_BYTE: 1 byte wide bus
> > + * @DMA_SLAVE_BUSWIDTH_2_BYTES: 2 bytes wide bus
> > + * @DMA_SLAVE_BUSWIDTH_3_BYTES: 3 bytes wide bus
> > + * @DMA_SLAVE_BUSWIDTH_4_BYTES: 4 bytes wide bus
> > + * @DMA_SLAVE_BUSWIDTH_8_BYTES: 8 bytes wide bus
> > + * @DMA_SLAVE_BUSWIDTH_16_BYTES: 16 bytes wide bus
> > + * @DMA_SLAVE_BUSWIDTH_32_BYTES: 32 bytes wide bus
> > + * @DMA_SLAVE_BUSWIDTH_64_BYTES: 64 bytes wide bus
> > + * @DMA_SLAVE_BUSWIDTH_128_BYTES: 128 bytes wide bus
> > + */
> > +enum dma_slave_buswidth {
> > +	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
> > +	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
> > +	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
> > +	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
> > +	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
> > +	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
> > +	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
> > +	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
> > +	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> > +	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> > +};
> > +
> > +#endif /* LINUX_DMA_ENGINE_TYPES_H */
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index fe33a20abc61..573e5ea34707 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -12,6 +12,9 @@
> >  #include <linux/scatterlist.h>
> >  #include <linux/bitmap.h>
> >  #include <linux/types.h>
> > +
> > +#include <linux/dma/engine/types.h>
> > +
> >  #include <asm/page.h>
> >
> >  /**
> > @@ -384,23 +387,6 @@ struct dma_chan_dev {
> >  	bool chan_dma_dev;
> >  };
> >
> > -/**
> > - * enum dma_slave_buswidth - defines bus width of the DMA slave
> > - * device, source or target buses
> > - */
> > -enum dma_slave_buswidth {
> > -	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
> > -	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
> > -	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
> > -	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
> > -	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
> > -	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
> > -	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
> > -	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
> > -	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> > -	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> > -};
> > -
> >  /**
> >   * struct dma_slave_config - dma slave channel runtime config
> >   * @direction: whether the data shall go in or out on this slave
> >
> > --
> > 2.55.0
> >
