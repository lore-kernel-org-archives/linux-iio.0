Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52994AA1FE;
	Fri, 11 Sep 2026 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147802; cv=fail; b=Oy7DqOI9bo/5oKAO1LeTCa8+oboSBOzZ8o/fCNFR89divNg+rANfbu5ynV0yUxeWcjH5Q9BmXjb8EovlawrmYXQDc9yXAjoAN0uX2pSh/gVuTuMqj/S9SGxmYKMlA/2qnMFCQfne63XEYrmh3rM6MNpmcjONbysG9W/2RWh5Qwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147802; c=relaxed/simple;
	bh=76XKiT8yKdphpWIwXX2fdd01S2c6+USpWDJpxaeXXYU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X96KsuaeIgsIBy9jAjRHpjnYcSfoB4fd5qYdAT+1Y9W4eiKH/3yHMastl65QQ5B/fz1Ao1nSxsHzHYfomYT4bDvQdfrlRhf6P6fSIO8eGWmK+dm9DGamy3eni0yK3+MV+wfkfg4u4TOs4Dfl9pcGt6PtgX6X2g4hH8a6eKLzkuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hUM3xVlq; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hUM3xVlq"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEijor1169500;
	Fri, 11 Sep 2026 13:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5awVn
	jxSXD3BUiBTVVzIW4UDySM4YgsSFwbJW2rV0lA=; b=hUM3xVlq963m/x8x5tQFK
	gdKjY7+iRPMatA5wPi7rl0Q4jNZ9C3uti5Iy+frpRZ6n4RGi6Awof23/xslJaL9G
	uV4fF0uQIvKfeQDo4siPhGWwFD+1XhYCYP+ZntW+DUjRSxBLND057ktmjsW+gtOl
	biktmZvZ/M07ID+yl5EnHMjZdZWveQOuTtZen2M0FYP9BuxRkEzYZqUjW/80TJUf
	yexK4shDaP7/FJr+cEktsxvNU3g57VcZV+v40l3yZhFQKdpLL7smb/1iU8wvURdt
	4Y1nCdIO3VaapeRzoCOBDfSw6zDsgALLf1LDM3e8wdrLiJUHOnksziVWOGlNKycn
	Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxb08k7-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:29:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjqx99SHZ3616M6wtNlSioSMpSpeuyAy4rqlMm3Z74TU+5tPoVp3QkOy4oTqEBU5gkUOt7YwNkcpbUQ2sfMJOfH/cNP0POriuquyFNY8IJltiCAB12AiljiRN3oZLKSVVo8meJL3gxgrjW51ylAN+ROvAk7UjJ2Dop5x/imAFdp79VCDBWSgMorImY4wM4rj6kW4tFd2SmSgbdi29+QSJsHBy6u/ld2oa60lx+c94OR/mCidPDz3CWLSDaeiMI0YDWYZdCF5ZrVVZQHJO/8XwFTqQtwTp/CtWPjGmrqOMUUfA3O7Bavb0wSol6xfxCEdHlyEtNYw9Lc89wbqag/17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5awVnjxSXD3BUiBTVVzIW4UDySM4YgsSFwbJW2rV0lA=;
 b=jcRWFVT1+pKDvScfR80hE2cs0N1rXN/FtynKxVJJrf1G7BMAW2AWcR6c0/176hlKbhf/tsQO10x+8EHk8QNyY+nKfn2oR8YTtkSfXtpIB5D59RQAgoply4xlqvIookuYmWzTxh5vht+Y9EqpUUDaiI2izQriQrSh4XNmaHgl7/tI8lXNkCadfZK0wbBPn6GHnLtMoT2TONK6pVkuWFtlLdu4hnlBkphLcIg+FMAWIF37K3Zyqn5ZAIacosYt87F9SUw0p0rbI1iVVV7o0Xp2VJsOPl2dHLp5LXuGMDB9h0VwFoy6k7dFWIW1wfDg3iMpUg+mkCwJlzrTsUyYBhWuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB7027.namprd03.prod.outlook.com (2603:10b6:a03:4e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:29:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:29:23 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:45 +0100
Subject: [PATCH v4 10/10] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-10-72b8fd4cc78e@analog.com>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=4640;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=76XKiT8yKdphpWIwXX2fdd01S2c6+USpWDJpxaeXXYU=;
 b=vLNsIFNOYmpXFzVcYRzX6GC6v1qLxZfmmaKtDzgxPtLSn7ndfKpNmDN/AqmDwTv37YAc55ZTI
 N/HpveyOBFDCjib3k3g++NSDGinIRgsnf7cey6sGeVsVd8CUJtn+3N8
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0128.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 204ef4e4-4bcc-4f1d-9d39-08df102a3831
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|18002099003|22082099003|5023799004|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 DvsIwHh1G+yOJPv0QeVXJM+OJWZs6wzjwt4tanRYv41SnuKAoV44QVUZjonCOZLnELAISBFr6wsNWLEVJa2rhsB/nIUThn94zauvQGrJgQlZcwdLUhWln+jToXKMk3mQ+JxbL+Lq4wdekBeHNWMILvi8C8og/e/Ad9N6Gk/z3Eh3bqDxM4x+h6HSdw58XzJEEzm5MMfdUz3Gun2a7Wtkl6cBELCcbIuQCQ70R74ttR+0usRYBRUoHXNDom1T3FxZzQiotAWO4vVlMRbNxsilPNRNs3FtjtiS8KUnrrkZKCL6mJBeuqjE9k+krMxE2PpbhMbT0cL+av2sgFkCo5am/JkyeqXHYkweN8KBh47CYZcs2yXisxCMIAIpy4loaV/DfKwnKaX15pKS034B1AZEsAUoLfsYJ3c7Txdt1+mEJj9KUOoaxv/ufYjQzlCQoU21UtAEZqLmiF2Iija8XFpgxKmuOhF09Fb75Msmzxtf/EG7E5z+18H4d8LQcSbMpqsWZhJW6GCReUK8xD/+uWzJbZO+RLImkLBYqX3gFZd/FX6dPMjGA7ex6pplmiZaUSfAvlZPWvqy/Lt3ZFFVjB/fJYL8+CFsMOnQfxE/6ap6BrDtlXLRCu7yK7Lvbga2nmZG88ozL0V7ZLZzSQW0NpwkvNoRq7KjHGWrFGo5bh9r47w=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K0hFTHNOcEhXVXlrNW5Ka3c0U0d4SEdObkhlZWhtMGZXcjhxb2JlcG1tSW0x?=
 =?utf-8?B?WmUyaHFCcjlpVWtrQmZmMkZWRm5SbjVjY0N5U1FjRVJwM0NSK1RXazFDYXR4?=
 =?utf-8?B?WjJvUmRNMjFVN04vU3NZRWZQVHhWL1VyVjBnMEFQYUZsZCtmYktsMG9Ec3FQ?=
 =?utf-8?B?b3V4VDdqOGZXZE9UQlNVY3p3ZFNrOVh1aUxGQklDSCtnRnlMMFVOWjRBRzl3?=
 =?utf-8?B?U2JsSWlkN2k1blZOeHVVM3pyR0JCOVhONnFrMzFoMTZaOFoxK1VHVGt5UUts?=
 =?utf-8?B?TXY5dFZka1pZUm5xTVZyYjVsY0hRUmFZYkNnS0JDNkVtbjZWTHpXM2NkeHN6?=
 =?utf-8?B?cXNkaGZ6cFhidWFycTVqbmJaQ2ZKYUV1NTQxZWZBUlpUcm1ONWxubS80bXhq?=
 =?utf-8?B?OExiNWJyajJybzlHV0VGZ05zK0EwU3NOZ1dUZ1NZRjgzVVVvdDZOeHRDY2g4?=
 =?utf-8?B?NFMxWlNUV21kMHhqbmxvVVVlOWgyYjBoMVdRbGlMVVVUTVQzbXFGc0U4L3dR?=
 =?utf-8?B?eVR6OEpPS0R6QWVUSVFNMnJDcndWaFh1OGNZcUI3Q1FwNmtCNTQ3WTJYamN3?=
 =?utf-8?B?RkdJWm82eGVNdlNoQ1Avek1BMUtLMUlZc2l3aEhoMkZVUUd3aERBOTF6cVcx?=
 =?utf-8?B?MDF6VFYvc2c1UWhIbjZRbGhvQlZJazByL2ZCZk0yZ1RKZnB2UmdZOWlDSHkr?=
 =?utf-8?B?UWZGMmI4YXZ0SFNvRldiVktpRE10WkhESzdwNG5mbkx2clUxV2Q5VEtBYzBw?=
 =?utf-8?B?VVB3N3JqeUQwMWdkWHJ6dElBcFdRdkNWOFYrUlI4U1ZlL1kzeERtUi9UZ241?=
 =?utf-8?B?Zm8vNGhWcU5mSGJNbFhhTDdoUi9ERDBoWXIyeXFvNWR4Y2xDQkNLdCtIUHVj?=
 =?utf-8?B?STJPM2pZanFwemQxNGU4OEtqZ1JLTG1CMDY1Y3loeG1BR21NbStCOG90dmlW?=
 =?utf-8?B?NVZJSVJwd0xvUjlWcW9iTEdtVkdYa0JQY1pvVnh5c1JuN3RXVVJkdWZVK3hX?=
 =?utf-8?B?TVdHblFOOSt0NEpncUcvTTFaVlErTUlPYzVoOUtTL2R0czBGbWFzMVFaTkUr?=
 =?utf-8?B?bXp3a3BhcmZmTERHbHpVZ0t4czFGRVZnZWplUkhnbmhEQmY0cEI2emxJcUhh?=
 =?utf-8?B?R0M5eGppUm91OTlJdjE5WnNsNzV0dmxjVFRrMytweFVLMmFneHZKKzJkczdF?=
 =?utf-8?B?SmlscmJLczlBN2xCa0MvOFJMMTFGSzdQdzlLMm1XSjFNeWlpd1hBN05oN2o0?=
 =?utf-8?B?TUJQSFZmSHlyeDdBbU41M3dhZ0NLYk90eXpqbHpJNVNaMVRISUtLUlZDVzAz?=
 =?utf-8?B?cURhVHl0OGs2anlqaUNoSU1iN0dDKzFqV3NXd29mM3pnMEhEaEFDNmoyQWRQ?=
 =?utf-8?B?R214SnpQZS9aVmpLM2RwdHZTWG4zRkN4eFdWZkpwUzNEUU91ZjN6VHpWa3pG?=
 =?utf-8?B?VUhtZDlhTzE0OGZ5MG9YODAzL29qa1R6WEJpMUhoajByU1ZqMUgrcTJYTURo?=
 =?utf-8?B?TzdwdjAydHVNTDFIZUpUZi9UUk5UaG0zVXkwb3B4alJkZllMZUJjQllMc3Bn?=
 =?utf-8?B?TU56VFZoQWJzZ2huOTJvb1lWbHZjbENuMFlFcndFcTRGSXZJNlJDTkE4d3pS?=
 =?utf-8?B?WGJwcWVtUnZmWDdXeGJVc282dzRGNk5yaGFqWGFFVXExZ3NZMU5BUkYxQzJ2?=
 =?utf-8?B?OGp0OUNqaXd0Yi9wVVZuVWFoODVSZDB4Z3k3aTcvb3VWNUxKalh1cXFZamZS?=
 =?utf-8?B?cHJmYUtiMVdpTTYyUUthQXdBdm4zUnRHNUVGaHZ6K1VVQ0tlNWtwS1I0VnM2?=
 =?utf-8?B?eHBrL3NZeElxU29oQWhheFlqbk1zbEE1L1hOOURmbXc0Q1BoaW94eWlXUUox?=
 =?utf-8?B?aVdlTXNhcHBlYUFGQXlkTHg1eFNGTzMvY3BGTU1DakNFL2x6aXhVZGJlTU92?=
 =?utf-8?B?N0hMZHhOQ1hMN1lsZFVtU3ozbyt0cmJBUVQvcHB6alhBN21XdW5UNzVZK1Rv?=
 =?utf-8?B?TnFpK3h5dVBYZVdVclVWdFVnN0lPV0xyYmpNbmdoclpRb0Ntdldvd1lhVUhQ?=
 =?utf-8?B?dHFUUms0d0dXQk1TNDNBMTJOOHo2ekZ2Q1cxL2E3Z0JMVXdCUlRXSDdwS1lV?=
 =?utf-8?B?cE00aFl0MkI3Q0pVN3QzVS9pL0R1U2dUZnIycE1lMk1YZytGOC9IWTRXUHZv?=
 =?utf-8?B?c29oZm1KMnFMaENiRVBmVWVkcjRQdU92SzNYUVYvN09tdkNJbXR0dDBpNVFh?=
 =?utf-8?B?Umg4bmI3MDVUaGsrU0ZRQ2hUTTJrbzVxdm9DSk5ocEhQeXVxU1QzVHBIRmJk?=
 =?utf-8?B?bkdNOUpoem1SK3FwRmRJNFlFZi9sSjlZcGZPOTBsNXNmbjl3bGhXQT09?=
X-Exchange-RoutingPolicyChecked:
	napJfDbIo505NqkPNW3l1YNJl24qnQris+TDane8FP71ryLOOi7hACcq6MRI488zsGmd9mXmzOzWliL05JUm35EEqoLVOQhKyEENe2kBB3J3zoAmdq91M/1kaEi9CpyWxlwzeVTz/KcJGCxcClknu4tmNgamqqhn9P1MIFazszE8iwB7FxZOdl1pd0zWsCRp6/Kkbc+8nmvspv6cUjOEueUIAqZg/G6rozgeNVfSWVJE5VImFYRKGXlnCiMqJaG2pv+bXFRTNuJ+H/VWUgQJlLn6CAcjhLPRrLKtao9o9u3wk9HcbRFVZOAO1u4LsksHb8dGoVBBcGdXoip/aRBAlg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204ef4e4-4bcc-4f1d-9d39-08df102a3831
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:29:23.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //qj0B8bU8hTjC5VdlY/x0g6QlCHtXbVgyVFlTteEGLROgDFgG50TnjAuNIaE0E/i2RRftchbLXl05npgB/UzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7027
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX3nxbcxiKmero
 6zygizsnQj26D0m8CwlKOGygHu5535H4Io1kfe35/6QegTqlxbRrbrQbZSko4GayNwT7/I6+r1v
 q68FXrm71NvoPaQ+dSF2Ml2nRejfxI4FhP6LiTivDPHsFn1fn2R16qJVkvaeTGElnP//yqeECAT
 gclKQapKOjP6leuOcWOzHTNi71tv00pe53blXqt8Ng5Jxxk+BBie95MoeNL56zEnogr3A4+y1dc
 PhJseBGFEk/dissGjXNTSh9vNr55qRnuN0GKdMeWYXadvmOb7SZMJoh90Pkqg4yGl5v+gr63niO
 DDmipAcgsJ8udLk5gpALrepf/pUufmwF8R/cbSgneJJYQ8nTgy3BwBSLboH8FIsixjdL5vxHQmw
 hFjDeDGUZ0DSzn0zui4Pz6m8aR1JHgwlNavQAHIj1jub36/sNQbLt3TiFoxHKVKU+XYfDGUIs3B
 IT3zANj5G9otmHSooaQ==
X-Authority-Analysis: v=2.4 cv=R6yWitRX c=1 sm=1 tr=0 ts=6aa43a76 cx=c_pps
 a=lEAAG6kgDLZw1ps4cEx4qA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=CIoI50WrR_K_g9tIiWcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX85EhqJyux4P4
 t+AeEF+Xw7KTaSL8FCCg+ClosKbENKgvDuE0GRniySxss/ykhoWYmbnope5OaIy1llPYsh1QjAJ
 66kp9BfQIvo7Wzus/yhDWGSQ9Rbc0o9cxSeX+5I+ZlTvNCQMbKQs
X-Proofpoint-ORIG-GUID: ZbtVjDmGUxFB5inbgERcHa8m9md9PEbz
X-Proofpoint-GUID: ZbtVjDmGUxFB5inbgERcHa8m9md9PEbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

All users of dma_get_slave_caps() that inspect bus width capabilities now
use the bitmap helpers.

Hence, remove the legacy u32 src_addr_widths and dst_addr_widths fields
from struct dma_slave_caps and stop copying the dma_device masks into
them.

Note the legacy u32 src_addr_widths and dst_addr_widths fields in struct
dma_device are kept for now as every DMA controller driver setting them
still has to be converted to the new helpers. dma_get_slave_caps() keeps
folding those masks into the bitmaps it returns so unconverted producers
continue to work during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c   | 31 +------------------------------
 include/linux/dmaengine.h | 13 ++-----------
 2 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 8e68921cf01d..945079c677b1 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -596,8 +596,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 
 	dma_bus_width_copy(caps->src_bus_widths, device->src_bus_widths);
 	dma_bus_width_copy(caps->dst_bus_widths, device->dst_bus_widths);
-	caps->src_addr_widths = device->src_addr_widths;
-	caps->dst_addr_widths = device->dst_addr_widths;
 
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
@@ -616,31 +614,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	 * callback to override the generic capabilities with
 	 * channel-specific ones.
 	 */
-	if (device->device_caps) {
+	if (device->device_caps)
 		device->device_caps(chan, caps);
 
-		/*
-		 * A driver already converted to the bus width interface
-		 * adjusts the masks, so derive the legacy capabilities from
-		 * them for the consumers not converted yet. Drivers not
-		 * converted adjust the legacy capabilities directly, in which
-		 * case there is nothing to do.
-		 *
-		 * Goes away with the legacy dma_slave_caps fields.
-		 */
-		if (!bitmap_equal(caps->src_bus_widths.bits,
-				  device->src_bus_widths.bits,
-				  DMA_SLAVE_BUSWIDTH_MAX))
-			caps->src_addr_widths = bitmap_read(caps->src_bus_widths.bits,
-							    0, 32);
-
-		if (!bitmap_equal(caps->dst_bus_widths.bits,
-				  device->dst_bus_widths.bits,
-				  DMA_SLAVE_BUSWIDTH_MAX))
-			caps->dst_addr_widths = bitmap_read(caps->dst_bus_widths.bits,
-							    0, 32);
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
@@ -1208,14 +1184,9 @@ static void dma_device_fold_legacy_bus_widths(struct dma_device *device)
 {
 	if (bitmap_empty(device->src_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
 		bitmap_from_arr32(device->src_bus_widths.bits, &device->src_addr_widths, 32);
-	/* consumers not converted yet still read the legacy caps */
-	else if (!device->src_addr_widths)
-		device->src_addr_widths = bitmap_read(device->src_bus_widths.bits, 0, 32);
 
 	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
 		bitmap_from_arr32(device->dst_bus_widths.bits, &device->dst_addr_widths, 32);
-	else if (!device->dst_addr_widths)
-		device->dst_addr_widths = bitmap_read(device->dst_bus_widths.bits, 0, 32);
 }
 
 /**
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8236a1b274fb..657d3a1ee976 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -483,10 +483,7 @@ enum dma_residue_granularity {
 /**
  * struct dma_slave_caps - expose capabilities of a slave channel only
  * @src_bus_widths: mask of source bus widths the channel supports.
- * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
  * @dst_bus_widths: mask of destination bus widths the channel supports.
- * @dst_addr_widths: legacy bit mask of destination bus widths the channel
- *	supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -505,14 +502,8 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	struct {
-		dma_buswidth_mask_t src_bus_widths;
-		u32 src_addr_widths;
-	};
-	struct {
-		dma_buswidth_mask_t dst_bus_widths;
-		u32 dst_addr_widths;
-	};
+	dma_buswidth_mask_t src_bus_widths;
+	dma_buswidth_mask_t dst_bus_widths;
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;

-- 
2.55.0

