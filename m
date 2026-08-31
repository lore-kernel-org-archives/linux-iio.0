Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57113E49C7;
	Mon, 31 Aug 2026 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176794; cv=fail; b=H4UKws0OVBdr4QkLYMjsswV0N2C1IBqwAQTRcjQSxgmPcL6hcGAfx8DzWp56pj8EkIntef9GA20/qGgCK7jBWzKpWf0jn45NZXQe5hDoztdiB2I1oA15SX8eAAlsUyk+fxJ1XGqUrf3PWcNHNiM2prPQnxomw/8ZZo06Bdj2x6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176794; c=relaxed/simple;
	bh=Qv1h81LwxUb4E89EpKl8EZQiIokN67bc+tKaQJ+fVM4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PHwRNdYSpPyfcR1VfnCInwbJ6D1fPVk+ZY0UWJk1XnI4yxWAxz6shOv3Tq8yCowaYoDnYpuO2Qlqmr9J7iTZ753ce1w32dpCipWCrqkEiwx9++fdL5dwUGufXnYm5lvFrgADVsJjqsb6fYC0uH7omSRR+jIqWAnUQZ36TwjlzFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z/GgyMzn; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z/GgyMzn"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VB9sQm3721621;
	Mon, 31 Aug 2026 07:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gQXH4
	55Fu1IDDh0kbcu9hnXNVWYyIkVfq5UHEcbvfGQ=; b=z/GgyMzn9+eOxZW2mXc8s
	VFqyNT9WALtHGCdXMnPuKMK2HsfJcqRKsKFsTT2qP6eUrYRNHRHZyJEXsGWYN0FI
	4wXXO0ft5EkmR0ZegQ2TR1CFJI0TBTwwyH5xljXOlhnwUs5kSXMJKPamWZpzpacJ
	hbjlMfOiD43Ycac8hBGm1QGLjxSWJzuF6JwuBeohoRa2Y2eXUnpknWIY9f+/UZzc
	tTix1bwOvSbsebNfOOoIIv+LRqZKiGZWTGtMNgcAlM1im3Bhw6xMmZdSOp6wJsOJ
	2kpbL6bj8fbHPbMnffCTs3g3wfbQgKQy4RyIxyxJSZtq4GUz2LkVbFe+It8zy+q1
	g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gchfdb3jy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:46:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB0IOdP97b3itQxxjqJtOj9WFEoEjPPDYt+uLsrRo4ji50nC2bquNaxgrDf8olHp8ivVGfdr5jRpBOoOxV5sc3HHvGxVWHHH0U1AWHJ9vfjy8/GEbwKjDmi/mtw8TEb9FBKGMJrYasig5yOvog9cFemw2zMn651YZs9yVvrrNPZSrm7f+DSy88lGGRbFMdfuN2k7vhg8O8Y06NUSSzRLRnmrWE8682SCF3jJemLTULpWSvaFVYlB2nBmMgbODb5aIY7iUzvIQzR1tpuaIAiteCMQRCsT9YyhGr7TFmjbZricxGpogKyXZDShGP+2fia+MYLXaj/v5eGRkywG0F6Vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQXH455Fu1IDDh0kbcu9hnXNVWYyIkVfq5UHEcbvfGQ=;
 b=pevdxJZdmJUr6qk2WT4ToYbaR4ARbrBOvO0LkDJ9MNshOj1LKW/yw5AfA3DA5of7ETs6lweJABv8YL0x89I1fHRDhXIiBJeqXiB+9q8ysjdctXPHnkAs6769IjsiLzf6cWJP6/q31+74Bn6QHEaqAm8CJOztFboIaJmg3q2GMv9g8JMmi0AkfplbRr3+IMoTPxtNPyPv+fpIJ4LHfTPH+XxWL1zlyWZjrXdOvk5UgEy/8IXFrZ++fLFv7F1qd6lMcvaSLK5HtqdKH4zZrzE4BlafVdjPNXKLSsii6EzKXvREzoKHnrQt11QYr7DVSgSUGR7F2e8xMRCyjkM3u3ynjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:58 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:58 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:45 +0100
Subject: [PATCH v3 8/9] spi: dw: Use dma_slave_caps bus width helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-8-507d97496f2d@analog.com>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
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
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=2420;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Qv1h81LwxUb4E89EpKl8EZQiIokN67bc+tKaQJ+fVM4=;
 b=fGDTgLq7VSS3J0fKugx41TYPYIdmwYAnm482JdnZ0FgjKG8KCTJjG4xW2Vxuc2tM5dyFu++FW
 bkViAWdbdc6ALpxKmlVkfSC3mhz57K78Hksb7S/wXqLQQc3hBhaWmEt
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0207.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eac14d2-2b1c-4f12-bd83-08df07556c32
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 13Yip199fk18tOMr7CW3XqWzFdULff04tsK+e95GSxEdgMjyIBufd4sNBqmYzjgLjXurvbQc92s9tdRW9vBj0Lxp/1enWTBaHI95HDzVXNl6ZJNhnHYvx+JlvrLi6H00OeQwlEgN4tqvBjQ7ZbrjE/QAw6C9UN8Jh8qhlpQJEuH4GkGyt4hrCfpJk+uyK5fkLkXkOj+6Vhc5mc4dlVQJkdeZzhgol+5OAXxpHYYt+qlARsJg8GI8GVxgTXYHXxCCRnA9Mmh8QfPJHouTULjcC/7DlS52Z+tTomSFRCu/PzEUmRpBaeQRZRRB9xXrFjpyB9bWZAnNkbNzopiVmy0D2WMunpffUMIFFPS6IS7v0k4zjw7b7RJ49Y/d7bKo4Q1XTY1NbN7r3NqehYz2FuffHah1tahEMif673uW+5909Vi0RLlHJwJdRuLfh7YvPLkiWoKs9lMOa0Xw9+WJe42iWWkkuHgfXf1ALtCG7vyNRJYNsSXbhDmzNM054Ln27+7m/dmEDmzbzi6yrg0TW8g3nxktBtd/fimH0VNheEOrfE+WeWtO4FrRPmJPsKT/OL6NUH8cRHFouBXW+6vDxm4xwMfJQzszWjjfy8N6vBBSNLP59oo1sksb4hqA8ED2DkLvHPWelBhXr0e5AeJ3nKTGj3DTqED++U9jtgGxnW0fJ8g=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OU5CNkpMM3phSk0xa2NOUG44S3A1SjI3aDlWcitWN0pvczFWbG42T1JJTWNx?=
 =?utf-8?B?aFR0TUpSYkxXdDlnb3pUTFlKV1FwaUZNOUZTa29RS2ZoS2Zzb0ZFZmJZaW1N?=
 =?utf-8?B?K0xva3JMa1QvVVFMM1d4YkNuY3J4VHJ3MDZJU1ovL01KZzhSRWFsRjQzcVJn?=
 =?utf-8?B?dTRDY1o5d3ljTlR6aGYzTDJsbFQ3bVpFNmlEUDR6NE93emNhdUQxQkljekJI?=
 =?utf-8?B?UlJKK3JBUDd1WFgwdWRMN1ZjRUUwNzJNTW1QSHZlTDBySzlYdkRqaU54Smox?=
 =?utf-8?B?dXd6T0sycmlZZmNVVzZhTTZDdkY1YnlHSUJCVXVVanZRR1VrUnhZQmhDTVFU?=
 =?utf-8?B?VjVDQUVLcVQxdWdzTVQ0b2tqL3p5ckRpYlRCZWNncHRTOVlaVzZVSlc5S21N?=
 =?utf-8?B?T3dWZjRXekNUMTRPaG83WlEyM3FycGlkS0dtQ2JPeVlVYUV0Y0JyMERTVWRa?=
 =?utf-8?B?YmdPbTlnT0FjUi9neUx2U0I5YzZBRjdkVThvMWJHMWFSKzRTejUzOXdkYktR?=
 =?utf-8?B?VElySFhrYVBhNUl5VlU1cTlWWlg2S2MyM2xUTGkvUDF2THU0S3ZYem80eEU1?=
 =?utf-8?B?T1BXQzB0ZTNDVHo2RmNlcE40Q2F6MXI5NmlUT1dtWHNTN0xXOVlRT2wycVB4?=
 =?utf-8?B?KzlTOUVEUVU4QndOeGpKbmtlcy9lU3JMU0VqUlBqTXFXK0g5ZU12LzBQSmhB?=
 =?utf-8?B?alpabGZveFJDNWpmdXBWNjdsb0E2KzFjcFhRQmZEbzhaR3NRYTlGVEZaTHJa?=
 =?utf-8?B?K2UxdUlldzY0UVo2T1pVeWIwdDNVSExQMU1lTVFOUmV2bFNqYXAzNXFZN1M1?=
 =?utf-8?B?eHBmR2h5ZDZPUXdzd1Y3bERvR1hxeXFmb1lUOGwzemNjZ3k4V3VkajhkY3VY?=
 =?utf-8?B?b2RoZjYvdm50eE9FcERxSFFkbkJXRENQZW1TYlpoWnl4N0l6V3MwV3NxVytx?=
 =?utf-8?B?U3pPTEtiOEpsT3lwMkhHUm1IaWgvV29sU2xrdzZiTkNMRnNYS2hYTFJWKytU?=
 =?utf-8?B?THhGWEVNeGowQU5kaHR3TnhsaHk1bUJjcEVxNStNeXRUS0RZQVk1VU5IdGlD?=
 =?utf-8?B?RU5VZUtuRjRyaHNKQVZBUE4xbkxQQVN5akpudHpSNTgxTkNxODZhb1NENU9p?=
 =?utf-8?B?cDJYcUpheTlEOWFzclg5d0tmZUcrWlA5Y1ZmM0UwblRrYWlENG1ZdGRvUlVP?=
 =?utf-8?B?Vk1KMzN3WmtsYlJVdXppOUZVK0RoSE40Yi85QzFTVlhhcnRaOGErSzgreDhy?=
 =?utf-8?B?TkJodHNFSXpOd1ZMeFpyZkJlcysvZi8rN29CV1RlajYveWYwWHc4b3Bjc0o5?=
 =?utf-8?B?OHMwNjlTek9HQXJxVndIVXF6VjZvbjE3VnI2eG4zMVRGVC9CNjRqRkZWbFRQ?=
 =?utf-8?B?U3A4RFgrZXRNcHVkMVU1akRmbUdJekJLRG04aW9aWXJUSTZTdmoreS9pQTdC?=
 =?utf-8?B?b1hXSUFwRXVYSDR3cGpHK28rVnV6VzhCRGdkZzh6bFpLSlZzUU5YRGpMU3Fn?=
 =?utf-8?B?V1VkRWFuUzR0Wk0vczNBMUdkNUg4elFQdjlDUVFNOGY5bk9RVVUrZFRLQm4r?=
 =?utf-8?B?V0JZMmgvVVNMalNFUUQyS3dtUHFyUXZacXJUTmdYZzk2cDhSVFNwWVdrWXhJ?=
 =?utf-8?B?MGNSU0JyNW1oaVRraGlvekpLazZROWNJTE1aeXR4RVlGVlRGL0RXYmlESys4?=
 =?utf-8?B?SjJ4R0xzS2dYSUNDZXVQTTJOdUhOVXJDaGtVSEFCdVdNdFplZjFUQi9IaE5I?=
 =?utf-8?B?d0ZuWnVCRUg4eWVmaEVKdncrczY0TnUzODg5di9ZQWN5N3gvOEVEaGJLWHda?=
 =?utf-8?B?azdLUVNrM3hJaHZWMzlSSm1leHM3clVaeXBTVWVEZnJGSE45Vk96UHFmYXZs?=
 =?utf-8?B?dWtLT0VRcXMwYU5BVVg5VS9HbEdhcDAvdXZ5VTFxczQ5VWlUUlZMU1BDS1k5?=
 =?utf-8?B?Sk1iZ3ljZG5JOVZTL1hvem40T2RHVURSY0s4cTlLaTdYOE9OVXFJUkNKN2lX?=
 =?utf-8?B?WHk1S1VORlFnNkp1eGUrdmdjUnlPZTNXbjZoampoSEc3ZG1mT01SVWFVNjJ4?=
 =?utf-8?B?SVk2aURqc2RVUlFpcVFyRWJDTDltZmdFWUpuQnlodCtVdmpRTE4xRkhWZFow?=
 =?utf-8?B?VTVxWEpRbHZUZXl0MXorQmdOTGg1TzJVSEFGaWZ5NHBLQ1IzOC9TekRLK2c5?=
 =?utf-8?B?c00wS3I3M0dNaXBhVGpqbVVna1kzUnc3K3psQ1I2MDBvY2ZZZHowcnVidkY2?=
 =?utf-8?B?T1ArK1Z4bkJqbXNEYzFtR1JRN1pXUW5JM1JPYXptT21FekFEUVNUMmhWNEpw?=
 =?utf-8?B?Y0hpOGFwSHRJZXBiak5XcTNCMjZvWk1ZVERYalQ4M0hsZDRlZUJPdz09?=
X-Exchange-RoutingPolicyChecked:
	qkTFdfSzOf+R+Tfec0UMEWeunsLK0VF7VwEHXrImnzo1JtcOHAOEwX0ibd1PdydyMaEn5Ff+KkY3wkF5P6AirEPkEd6xBeV85qiSl0oq6vV09+1gIB2csRD+sotPu3RVvcKVXl2fel6lJvMXEBo5BNSiSVJrfFufj2It1rWrXUgsbLtC8dQTgTTA4Oq7WcHcn91WCeGr9/IM6PfyWGfBmn5Idf22MoIBnr/qJIWa5dwM3F9Oy2djktTo8/darJlKNOkdIQ2fez33lth5XjrBLHFQyRNp6jU8sYFCEoYB9/SAZV7m8aUjDwOP2h54yNtQIL/H2lH1V9CzKLxWS0h7nw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eac14d2-2b1c-4f12-bd83-08df07556c32
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:57.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Dem6AHoNuijFR5qG25lalUj9kgmQHmWPLjL2EI9Cmu0nMbsWJDgQyc3hNkudDaSEF6/hN8ZgOXu08YeXxZ1ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-ORIG-GUID: eOjUDKBhGWK4WV7feROGGOCmNdKCWyaM
X-Proofpoint-GUID: eOjUDKBhGWK4WV7feROGGOCmNdKCWyaM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX/j148bPT9OhH
 qemy9F4D9zVXUk/aGqtii1+u6rOBomp505qMmuH50sDujjhnHAkOzCJFXgYhKTmQ47rDqEgHqFu
 9vaxmMbl6hrn7bx0X8dmctI7ij92S+TSdhg+IpB97F/sHYDWAW6s
X-Authority-Analysis: v=2.4 cv=D4x37PRj c=1 sm=1 tr=0 ts=6a956979 cx=c_pps
 a=3V5Erj4uy8rJXAE3nhxHpg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=vrfzlmHFqV6-XNZspV0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX0tZ4XWmqoaI7
 Y5zihFsnNlVQUqNpCOubRluU2st8ZQeoWmzx2s2MZELI845h/TP4PCO9UohNNEAfT8g+/LhL38f
 Zz4QrxU5VNtOGirbv7SGFuyQe96mgUVRtrG0vh0Fq7nTs3xABiNaQfUBQzPglWZ5/k0eakqCFRa
 VYU2ywgfTjayLsfBztPoW9dLeuyfm+FeCQRPJyTegPitKfOuDQ9AfReeoyTel9oH28SLvOxX+v3
 9TzR7/V9X8qHamFxpkZ7KqEoY8WME+Kf5XIjwMw7ae+Dh1j/6x/5crHLH4IMiyFBAnnoeJDyvfQ
 +C/NScgqpvTZ70WiTj/Knp/82rhQqANBMfo3CZQyXMRvdBdABhTXitA5Hq9eNPqgzaRmL3wIVUV
 l3D5f9Pl5fpl2zvWGpTjOYAMkiTHjagF8lmSW6USPZuQkZZMlqKU2BCDr4eqBo0PG3RO1gsSaRz
 Pk6cZ0cpZyPrlS/i3Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

Store the common TX destination and RX source bus widths in a
driver-owned DMA bus width bitmap and populate it through the
dma_slave_caps helper.

This avoids depending on the legacy src_addr_widths and dst_addr_widths
masks returned by dma_get_slave_caps().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-dw-dma.c | 8 +++++---
 drivers/spi/spi-dw.h     | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index fe726b9b1780..bbd7ee884d0e 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -7,6 +7,7 @@
 
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/irqreturn.h>
 #include <linux/jiffies.h>
@@ -100,10 +101,11 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 
 	/*
 	 * Assuming both channels belong to the same DMA controller hence the
-	 * peripheral side address width capabilities most likely would be
+	 * peripheral side bus width capabilities most likely would be
 	 * the same.
 	 */
-	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+	dma_bus_width_and(dws->dma_bus_widths, tx.dst_bus_widths,
+			  rx.src_bus_widths);
 
 	return 0;
 }
@@ -253,7 +255,7 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 
 	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
 
-	return dws->dma_addr_widths & BIT(dma_bus_width);
+	return dma_bus_width_test(dws->dma_bus_widths, dma_bus_width);
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2f2debc64e73..e33577c96afe 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -10,6 +10,7 @@
 #include <linux/scatterlist.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
+#include <linux/dma/engine/types.h>
 
 /* Synopsys DW SSI IP-core virtual IDs */
 #define DW_PSSI_ID			0
@@ -190,7 +191,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	u32			dma_sg_burst;
-	u32			dma_addr_widths;
+	dma_buswidth_mask_t	dma_bus_widths;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;

-- 
2.55.0

