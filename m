Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E922386C1E;
	Tue, 15 Sep 2026 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459995; cv=fail; b=N8tzm1wxETuOVWHkAAZgSp5GIWayAv/WNSgHZzQ8FiA0kYKJv/HyNtuSDl9HGH1EivnGfBfXV/Qq05kERb8FtpTj82+qk7NgCtLe3QoquBQDv7WhHmIhZKDUWuZEuVrDmGMjPvxa7JeGPYV11lCN4PAcHc0hFvZCObPpTLlFSAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459995; c=relaxed/simple;
	bh=T9kZ149p1O33uqVXQFteD0MYs6B9L+Y67yq61Nk+thM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MMUNMV7glqyS2A5L4yxdXHgeXtZqTtycBllaBhBJPd+/kRPSV4+13JODVblUijeFqcbXViIrRlz4nHglYhOaueBDBfVoSS79eWyp/R+stJ28xILKmfXGsuyYglHeiixTbkFfvWmdkCJUSM91ewJVCFm5H2ttZ3SlBpz0LgBUrJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WetIRvG3; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WetIRvG3"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6YSjw937208;
	Tue, 15 Sep 2026 04:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wD+qJ
	GZIcjnlBKe4opjlqWFtQr02JyvG3gj7/jQeeBg=; b=WetIRvG3z/zAOatDRZwwK
	BVjTgpoGBKN1sQ56Cc76Hl42dogAhG3iXyvdScrxRsRGRFleQZay2/mTDOZeMiAK
	rPN9WbhSFsRT7Js2tRpxZbE1Cyvw8MyKT0OH+VAsVOFFEano/tsBwF3fzQBbRavJ
	fIGwZo2ga/7GSbZpcjqHL5rUxwMKgZyHl4G1c0Uk96ZBU/IFJwMB725yRx2b2SA+
	gXlMGJyAAPaJGebzY8arsaaguPAvIEESU6CM77miLAo0yAQSJ77/pBgv+fd4Fe8K
	v40lLc27z0WsUogT9DPdZFcd3YxD9GJBdi2ateZXpPjTE8GLjLYPgodTgxATLN1t
	A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gnrsfq7d6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 04:12:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHL8fLJRVVHg6xOOz7EkC9bMjxJLxa50yQwjitr1+CP63CYiDKsoI4+94ZdVHK4noFSwONoyzlK91kYlDG89jji5j159jwmIrDgRXfgj4eZNSVsWSmwzybuzsbBdraaSvMcibTK5vEIFOPWFKv3hUtFjpJDJ+FDLpq+BI37hjP/zYNd8lgR/6PSfDuf4nXlCqbkIqMf4fJUiRlkn0FOpnXiXvOiqrFrU6AgUpnlCx2kjbgQ2dmR9clYJUdpyzhWWlWDBV1XGUSi/3C3eS32YsA+lEKXH4lzi6pV22jR4Crlund6rjQKYG0pdx8ScM4GeTd4C6h3Qo2fp+2x0S4ymCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD+qJGZIcjnlBKe4opjlqWFtQr02JyvG3gj7/jQeeBg=;
 b=Vad5Zm/g8A5RvUg4SpaGVj7RCowSgU00Sz9cC8y70rNAkAS15Kw3X5AAvRcrbX9/y+MCFpCACaVwiFL4wlBPE3jC+ojAfIZiVhvpP7HqQZB3tSv4c0NOF/fKBsgvQIPIZvMRV7k530KfV/PPvdLXmNV+zjTjnIvF7OsvJ5u3YaDdUafyAvLWe0uKTQzRuNP2Q77M0EGWUM1dQVgEjE8//o5wFpwcFWvFmpGnoGIBA68b7aaFi/sF8r8FBArtIScNWAebDc8lIkGE3LbmkjaACBcEOsrbl0uAhyKRxeEH8I2ScvnlYJ6QJksdpaRzOa/iXNvGUwIsWNlcaObmChNBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSSPR03MB989190.namprd03.prod.outlook.com (2603:10b6:8:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:12:28 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 08:12:28 +0000
Date: Tue, 15 Sep 2026 09:13:37 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
        Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 08/10] ALSA: pcm_dmaengine: Use dma_slave_caps bus
 width helpers
Message-ID: <aqj9ZvQDATytHHqg@nsa>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-8-72b8fd4cc78e@analog.com>
 <aqesWfdIsiR31sql@ashevche-desk.local>
 <aqgUo4-r0-TIKZLl@nsa>
 <aqj0a2ttFTXdgGx5@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqj0a2ttFTXdgGx5@ashevche-desk.local>
X-ClientProxiedBy: MA2P292CA0008.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSSPR03MB989190:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fd8a44-2083-425b-9033-08df13011552
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 hKG3PAs3h0tlS8r9R6iSEQZTSHFrIcFimznJTMdDets1ysIlBv3rjfbJKBGPTvaaAK+UonCf9nXjyvmWOkRm7nlq8Wg+rccSg3XsY2ynIrUap3zGq9VxMUCMHgzbNijAa0kL/nu/niqwYRSqproTbDeiM2cu3RnxeGyh9fYbjbolY9EDWAHsLQZsq9mSeW/v1Up+Ug+9vuc78ze+XJOeTKCnJSEGQBi3k2HuazeiWfYo4IYzPQz38EH77+mfh1uTsVT3zgYr2X090QvTwJaGmiiRTPZo8t3eTTjHz1n2E9aiLorCcTHP+X/96J5xAYXS1W8OYa/uf5gZGheovo5joOoQTOiDMPHyPK/eKqYWnVnabO5eLzqVilheEW+diW3z6sUWgvnrJhNQ4NR303FgM65FhhKhEstDX9HuOUde/FEamtb/hZJ8/1mx7SWCHhcBq6ENX1EA1fBc8i5H7bAqLHPUvQCuY9FLtNPV++b5CrMYV5L/UOEDs+Ixwd2Tu1Ecm/MU7DL9GIbX04NYvEpEQiz4/ENYUwWpQp3X7rQOMMjm4ARBiykjqQYcDwakTeWtb3wwd4PrN92iBH6LoSl+0EYDR/ZKbI9H0NaTgzPx3814WxKy+YtTlNeyb/9TQsgMjKrrpLmQoWZ7RupIuN19bGx+hHndFq6MbqGPdmZSUuU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cU1TUXZPSi9SMk9xckxuM1dueGx1Yk1IcGVPQTBJdzFvcXhQU0hvVzdKSDRN?=
 =?utf-8?B?NDY3L2hZbW9wODdSb0JXVi9nVDZKRzlBTWNTQzM4aitjbDdKd29BT1ZURWl2?=
 =?utf-8?B?K1dBY2NTOGRUaHZ0MTNZcW5PKzM4dmNlM3FIT21DbXh1SWJHRHZ2aGdNVUpH?=
 =?utf-8?B?R2JHc0w2WXdvSCt4eGhIMDI5aG9hK0EzMHRqbnFsV29seGJpei9sbEJaVGZP?=
 =?utf-8?B?MkE1bTUyZ0N6WjhCOWs0QjdvRDdMYTdhOXNlVzJycldlYmtCdEtHSlVycnNJ?=
 =?utf-8?B?bUpRUWtibkEvSG9BT2VkS0FQaFNoYlBTcjhQYjlHZWxPd1ZuSXhkZXhNaGxn?=
 =?utf-8?B?Y2w4KzVVVm0vaC91ZFJxVlREck9PWWpKUFZRNUdaK0x2N1ZXbzBEK1UwL1J3?=
 =?utf-8?B?UFl2RkNLdnFyQlNYNjR3Ump4YUljZ3RpZ0tLZEhicmZ6MjZmeGNrY1ZiOVcz?=
 =?utf-8?B?dGdPUTFVV29xSkxlQVdocllWeG02VVdyRkNaOUJJcmVmNHk4b29DVDhMenZV?=
 =?utf-8?B?d2wvbEx2TnRwQVpoM2ZVeFB3SWR1QzJNTnBvOWVVdGVxY2VQaCtEeFhvaEoy?=
 =?utf-8?B?My91cVVLT2ZIbXRGbWRGV1NXRUVscHZManlKSlpVY0Y4L2srbC9oU1NTOERH?=
 =?utf-8?B?bmxPZ2lhTXNJWjJ3WGNJNlFOVDRZVzdUMjEwejYzalVnNkNQOXFDZUJaRXpK?=
 =?utf-8?B?OCtYeTJPTjRZUmY3emRTZmpQWXd1clJac0dhQjdFZUFWc2VOKzBzZnhkZFdR?=
 =?utf-8?B?eEY5OEl3di9KamNmcmU2YkM0NVY5aHM4cVI3cVliYUZPazgwUzhpbEoyY3pz?=
 =?utf-8?B?OVRIVU9vNlJWMWpibUkvYlMxd2MwWUNHajlmYXdVaHQwU2Q1aVl4c0FtYkpQ?=
 =?utf-8?B?aUF5d0ovMGZ5SjZtMHBwVWxWQ0ZwVlhpTHFqL3J3OUFFZStObWY0S1F6SXdV?=
 =?utf-8?B?VGl4Ykx6enFnKzFtZVl3YkNQNCtIQy9UdnVLZjZydDRrUmo3SkpTd29sUGRy?=
 =?utf-8?B?bU92UGtJa2VmSjRleXBmU2FoeW5MMkJ2bGk0b3pkYjExcEpPUGEyYnpmMDBa?=
 =?utf-8?B?Q0NsWTJOVkpWUU01emIrTmozVDdMMHJxcjNRKzRPWGlYRDBBRXJmT1Z6c0xD?=
 =?utf-8?B?RGxRaUxGMUJWNlZjUVJPT3dhRTZCbENyKzB4cUthWjY3MENnUEpLbXRGZVNY?=
 =?utf-8?B?SGZzVzliTWxaUFcra1ZHaTRZcGppZ1p5eXVEbGdRNzBFdU1nR1FSU3ZDU0oz?=
 =?utf-8?B?QlFCa2l6VUVJVHg1ekphSXR5UGd2M2dmQ25OK3Y3T2hmMVFSZE9mVmV3cFF0?=
 =?utf-8?B?VzV2OWZNZDMxa0g5UUU2WGVFd3lXNWdjZkVlYTh1TFp2c2YxWmtqUUt0SzN5?=
 =?utf-8?B?cWc2YnBiL3VGcElxWHcrSFk3a1VZd0toMTNmalh1MlhtMzlyWW9sK0VDQ29z?=
 =?utf-8?B?OGVFMGFCVjk5bWQrNURqNkpQU084bldidHZZMGg5T0E0bnVSUFlia1VwYTc5?=
 =?utf-8?B?dmdzamtjenFweXp4ZVVVZExZMkJCTEpkSFFoakhrMlVveFlSQnc3RGZablZj?=
 =?utf-8?B?SkpLeXJNRVJFVFJDcy9BV1ZmSDlMaFFMbFJMLzNubTZKMEVBdC9rOUpsRjRR?=
 =?utf-8?B?cXpuUS9Ha2l6MGx2dU5xKzhmbk5Qai9mZkFubHhLMjBibC9WTDVWOGJEcitr?=
 =?utf-8?B?QzBrQTE1a0E5MithQXdpMTZaM0VPNkVnaXM5Rk9SK0lsR285VkU4K2ZiZktG?=
 =?utf-8?B?SmdMUHp6N0RMbFQrSjdjVm1FNkhLeGlhNWRmK1UvNFA4R2JIME50VnFpR2xB?=
 =?utf-8?B?b2dOT0NMUkUwT3NCL29VaXREb0p3dURoeGNyb0Z3V0crUUtzaUlrRnhmaFU3?=
 =?utf-8?B?UEFFNEQ5R09zcmI5Uit4aDN1cGp6aVZIbXpyRng5WC82NC84eUFORXBuMmNB?=
 =?utf-8?B?N1h2dG9RUHhHbFhJYlY3UHVwNkprOXpDdUkvbDZKVmlkNWRKNzNSMDFqQnI4?=
 =?utf-8?B?NUlnODd3S1JHcmhNRlNCMVZOVm9IV0IzVjlsMUZNYkZOcHFZQklWc0s1a3Ro?=
 =?utf-8?B?dmN6RkJuV0tFa1lzKzJnMmc1eitCQ1FDNVp5blA1TzZhSFNiZGxNMFhFSk1t?=
 =?utf-8?B?RThlekNJYTVVbk8ydUVjajB5MTdFWVl6QkxramVaYlB6cUZSZlE3QW45Nm5H?=
 =?utf-8?B?R3ZuVDdWRlhoY052RmgvWm1PRkV6TU1QMEdmZmtUV3RJYkxza2N4ai9WWEV2?=
 =?utf-8?B?UUs3eDZaRFp6aEFEbFBYdnY3QmY4ZENicXFDdExqQy9KelhwbGpzS0FEVUhO?=
 =?utf-8?B?RDc3cURzWW1PYXVIY2NBYUkzbVZTeG5HYUlGRFVYVHFITzIwMG9XZz09?=
X-Exchange-RoutingPolicyChecked:
	5wv6IgHksaHc36LrDxawuawTfJzW2L/s6hzM/HHkWPjRt4zIqaIhlwy8K9Sd4zB8VWOhATQ7wVjtbxCy4tCPvNVDRuTontYv5gkw2wPsKo46FjtNOeDiv0v1xbaXrcYmHUf5nh9f/1wQ8GrXZXQHHTUQS5k66gZmAhUd5U1OMf7mj5DigqU6pxSQaprB6JdGLzHd/ssdz8w9Yv0W8WXWpyInRyX7EIJ3w3oTvrQpo3TEcEEqWT0PyLUAknjpCbH2psKZUWI3vAttFfk5lWEzoLVIMHOolNKdoYgexKPLngSzQ1nzDVnZlhEW3i9eFQXUaDAnOgySysQG2pFZml3KDQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fd8a44-2083-425b-9033-08df13011552
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:12:28.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyXj4rgVc/RaJ7MAhgHSTxQSbT/3KSXxMEkEwEjbTvr2+P2iFK59J+MszjfVUbFLLiPh0xLMKoQkzXkkwFmZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR03MB989190
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDExNyBTYWx0ZWRfX+L0NJPIs13VZ
 uHvSZV9ODz8pnCyMDGKYTJlrgFtgDMefmGxQ2r7OWbZrOv3hBrmKLYHykWnbJ90EP5nC/szar+T
 su+kqcnOlJqVYp8XnVmZVwsPeDGdIRdFnt5l5kebL+wgIjskQ6lm
X-Proofpoint-GUID: MFVMLwjCQkJlLxoRqgzpI7HdEJQ6f3QI
X-Proofpoint-ORIG-GUID: MFVMLwjCQkJlLxoRqgzpI7HdEJQ6f3QI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDExNyBTYWx0ZWRfX9z65eSm7JLpl
 Yvzs07Poj1OOox6unT+hztayr1E+dNYpyyuCZYO5oORyPLp85uKuiMYnSDykT7Q2Wz/bliZc+4Z
 GHUqd7fzugCD8upTxzjxPP6fnPAVJFUDsG6GVuZKG4Vl46So3uAZJoIk3/JPRRSQ+ZN3OAzSYmy
 9yZ4CePtUhhB0fROgDC5Nh4/I2S5VQQS+i4PrdRLwBcyMdWcYPtW1fGjwEbUvrWnZKpI4jSee4i
 tuUzrpBxqx+HqyQhY+aO48hmbCG8An2AY7SAq5eVUuOAJY0XwroHuKHi7qS+3or5CgIhhJyx5+G
 nKPK11cjcKpgJQaMdiI/fRM5ytSVmFbe8i3L/NO1oqCVaE96KISZYRvqIvXZJUFDp9qxkEJVlDv
 faAHo5izCR6UhaSQHCoax/CEyDL3KJMNKIwuILIGH+GIqOFPyZvurDSudwJ30UoW9YHZvtLxxTm
 Qo60dWXa/t4RHhXOH0g==
X-Authority-Analysis: v=2.4 cv=IKqXmQvG c=1 sm=1 tr=0 ts=6aa8fdef cx=c_pps
 a=PxsVn2hUj41VgPYomOKOQg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=y8H2xGFtw_CBm4osIMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150117

On Tue, Sep 15, 2026 at 10:31:55AM +0300, Andy Shevchenko wrote:
> On Mon, Sep 14, 2026 at 04:39:38PM +0100, Nuno Sá wrote:
> > On Mon, Sep 14, 2026 at 11:12:09AM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 11, 2026 at 06:25:43PM +0100, Nuno Sá wrote:
> 
> ...
> 
> > > > int snd_dmaengine_pcm_refine_runtime_hwparams(
> > > >  	struct snd_pcm_hardware *hw,
> > > >  	struct dma_chan *chan)
> > > >  {
> > > > +	enum dma_slave_buswidth default_widths[] = {
> > > > +		DMA_SLAVE_BUSWIDTH_1_BYTE,
> > > > +		DMA_SLAVE_BUSWIDTH_2_BYTES,
> > > > +		DMA_SLAVE_BUSWIDTH_4_BYTES,
> > > > +	};
> > > >  	struct dma_slave_caps dma_caps;
> > > > -	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > > > -			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > > > -			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> > > 
> > > > +	dma_buswidth_mask_t bus_widths = {};
> > > 
> > > Do you really need the zeroing?
> > 
> > I think so. dma_bus_width_set_many() just does __set_bit() under the
> > hood so if we do not zero initialize I think we could be left with some
> > random bits in the mask. Unless I'm missing something.
> 
> Hmm... Since it's a recipient, I would expect it will be filled correctly
> independently on the garbage it might have had initially. So, perhaps call a
> bitmap_zero() with the maximum size in there?

Hmm don't disagree! Needs to be documented but yes, for all the users of
dma_bus_width_set_many() or dma_bus_width_set() we have so far, the expectation
is that after the call we are left exactly with what we passed.

If ever needed we can add a new (or just a flag) "change
bus_width mask" API.

- Nuno Sá
> 
> > > >  	snd_pcm_format_t i;
> > > >  	int ret = 0;
> > > 
> > > >  	if (!hw || !chan || !dma_data)
> > > >  		return -EINVAL;
> > > >  
> > > > +	ret = dma_bus_width_set_many(bus_widths, default_widths,
> > > > +				     ARRAY_SIZE(default_widths));
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > I assume that if ret == 0, bus_widths should be set accordingly.
> 
> As mentioned here, if no error, bus_widths should be fine to use.)
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
