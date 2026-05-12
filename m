Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DA3B1003;
	Tue, 12 May 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595736; cv=fail; b=FOPTsAyJV9R3BsnCymDRGDbHMP0jIEaqBKJTOSsF1Jn9PRQawHLKeiOcB2s5K6bRGWPUtfdXUAtxfu3xiaIPqnxUAAsm/XBXxu7k2yLYOIq8N1L4WCMwbzNwl/Zwxe65vTPDDLlalE03cYmlFJZmTGKkAZDFWGctJAWqQT75NxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595736; c=relaxed/simple;
	bh=V5GqCFqKmmAbT0C8XlnByETSQs8VG+6+v9mLxMSfmvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h8WZ6bFlQzXq363Wy1hGTdDXg+iUyiK5GMn4GZ7K2UcdUXJ0N3KEy4291HKM6+09s/WfqXFmPRn0ED7c/30a2tUhyBfvLFzbDp/TIAgYzkxRX69MmrkINC+rpogRGy+2qWJN1iE74/XCZO16PODkPZbmNdsyEauH2n0SAwN+93Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OkEz+uN6; arc=fail smtp.client-ip=40.107.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OkEz+uN6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXZetlcqTgcrlQN45cj2rUKFjwB+ywKLJxw0oRh01lJBS65Ke6fEG3qsF60mH1gnJX+pr0yVx6qeT9gjfZZJWjMWS5zDu9fzUtKbloZM+M5ywf3XMPSn/dgCV684D7xFuKnOsmwZXCdWAkPxm+zb1CUQ+jXm72c2UCHEDZ83nq5BCNZEQieFbPV5fm99nNEtXT5E3I4flxJb0FP92DN9FK1u0DG+PtOD3tHnZrY3gpx/Bb8NyQaOPc2L1Sw3cHb8oYmy/rWlaGrNAlRr7OEniNOqZnj/hcVs9ZpQ2cZ6Moq5oh5BTRIP/n4nS2jX/wVUNrqPJskpyt2OG6dbKMmIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k2/pvS1+mx3Nzc9TzTSFcmd65Zl3U9Nw/j20IJv57c=;
 b=cUgUtoK5nFm+LHl7n62gujcnEsvW8PTEWxhvxQKa3C882MAcZnAWuGIs4F2rVPubYC3wGSJuAYBsrAVK+2JNsIyp0OORXHylLKYN6MpVbr4iW62xuu1AO2W2AnmtDJzFxNPY2Bcv2dlyO4hfGd3TdV1jZsJ7nYzfIUWgdCiDHeGrK0OqKCrXuMUaCPX9UOYoUegEaqqbUPaRLAAa1Qe6Sifjk/hp3xxZP4zXkXd6gMLFtQrYrmxfl+wc2J551550Nf2BEbfYhyrRaihCgT86Rghe65pRvtmyRUbUOY1YS7xfWTrVwZ55arJavaNmsUJv2+tj9amfEXur7W5m19I9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k2/pvS1+mx3Nzc9TzTSFcmd65Zl3U9Nw/j20IJv57c=;
 b=OkEz+uN6tD9C2DkbmwELXTR2OcZV62BHi9Ieme4Dyar4ZXA5dF5NA5hH6iZ184sPljiUq4dH7gRr30LeDRZKJCMOIsQPuS6YCn1q5tScm73RLl1ey9hDgmfw2VxOO+nkSF6RDLbYk/w7Z4xknZygAGy95FMwCqMNsi4MBqKe1To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SJ5PPFF62310189.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Tue, 12 May
 2026 14:22:04 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 14:22:04 +0000
Message-ID: <46bcd2ce-bfb4-4fc3-b840-dba657f39a7f@amd.com>
Date: Tue, 12 May 2026 15:22:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel
 lookup in event handling
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
 Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron
 <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
 <20260414224245.8493-2-guilherme.bozi@usp.br>
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <20260414224245.8493-2-guilherme.bozi@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: df6fa636-d882-4205-2151-08deb031d743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	crr0T8M8WAu7ltS+7CQmKZp12mBoWjgVQTySEV7rFT31q45lhShctBLYimQMEa0G0kbfRo+Cokcn3eoNYqqG0SX5kfcylNP2nSOWtp7D0welJOXDzGvKY+mHkB5109l4eTBDNPKiuKaWjITZx93BYw54HIeupPDGyC840qUVedB+LfZ3FAhyasgEv6oDaqlOJBKfmnfmpMDxlU3ivRBf9yU+D+EtOa0YIStyMkjOBWsPGIFc6OOv7B7jWOdx1BuDBJA8V7xAv+soxqnulGHGYooigBnnQiTWC+TjvLTgxi+Rl5s4Ad9hTesCYLsPBcdr4xtBXpyLYQEo0DRoj3+RjDMbLjUfnRk4m0v3s421w31zmzxbYabsYZPjE9ofJY+fqDMCK1V9VfM67ZWlIJMAHF5NnHmiDvh1rtqATZ4SAu4TPYM12BWs2kzggNmKjyiGTJyH6Db86QilQdGJA7loOSKpSw8UDSJw+jKH+KlW/ddjRAA5kG4USOmurppIjeetNhN4cjvwZJZLRvT0bwrFUxEQQQb1d2DfmrzzVHxjbA7PUz1x1qSIg63LVMkxRuzCL/klcI4xJIa3tnkpSK77QW1DT85DOMIX1pGlPkzRiB2s9J/O0KZfod0vLAKXFrBtIHPziaDcp/oBGVH7E/zdGSWpXZVH7QU7se7dHkpZ5QOYBbUiT2zkUgnTYfXkAa2D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGpzYTRoR0hHYmhudnc5UjFuaUVlYTlyMHM4Z09lRG1QTTZGMklGZ0F2UXEy?=
 =?utf-8?B?a3gyQ2F6ZVNURTVldUFDeDkxU042VGNENzYrUVRVNEpLTzlSSFpXNEdybGUr?=
 =?utf-8?B?eC92eTM5QlJUVmpXMURKZ1hLNmNFYjNYNFVyTFg1ZkFYVjhLMUJ0NFc0RFFN?=
 =?utf-8?B?WngxT2szalkrVXcxRHhvaVV0eGhxRnRFNXdFSU9rMkJXRWp2QlFqTlBoYVB5?=
 =?utf-8?B?M1hTejlSNHUwM3FxSDh2UXJXMnJMamJUSFRCaytVOW5WZVVkb3dJZ0o0T2Uw?=
 =?utf-8?B?VkxFZTdmT0M3Vkw2OWlXbWJ5T01TZktOdmRiUkQ1ei8vak5zc3FkNTAwd2c1?=
 =?utf-8?B?bmUzaXZaU3NvTUx4N0c5OHNXTWZ5NTd1UWh2elp3VTVOcjRJTnd1NXZnVnJn?=
 =?utf-8?B?VWFrWHV5eXcxUEczUG9mK040dXhiQnI5aVoxYmxXZWJaMzl1eTMyRk1Id0F1?=
 =?utf-8?B?MUx2TTdPVGhXcHY3V0JEZm1vVC85SmRYUEhzenk0YW5URGF2L2lmYnUzNjU3?=
 =?utf-8?B?ME5uZWYyMm42L3g0aW52OWl6cDhMSXBNaU43cE90VzFUdFVTZWZBc3BoaHNu?=
 =?utf-8?B?RlNWNEc1S1lhdEhNQlVrUFU3cUVnUzd1TlJEOFAwS25UNkpqYUNCREtqekNY?=
 =?utf-8?B?YUpXaXJhb1gwZ1N5Sk1mQWRLeG45VmoydERJbi9RVVE4MDdxVEZ2U3BBMll6?=
 =?utf-8?B?b1ZvRnQrMGlMY2VmMVA1NHBHMG1sc1ZZOFRiNk5jUmYvYTN6eEdjamZTQUpk?=
 =?utf-8?B?bkgwbnRub2JZQkxYUlE5ZXJEQjFCUERYSndMMVZzdXRaRjczWjVMcUNDUW1v?=
 =?utf-8?B?aDBzZFZzTWMzS0c0Mm5yU1JJVksvTUJhOHp0VFdvaWg1TTF6WjdIRVlWaFUz?=
 =?utf-8?B?VEdUVnFjMzB4UW1WTEpSdndWWUY3RTkyR1krcGhVM0JsaW1vZnlFZkw4OHJY?=
 =?utf-8?B?TTdoclJtaUE1dlNGNDNPbUdtUkNCenhUaDQ3Zm45NGlUL0x2V0RnV3lnNDlL?=
 =?utf-8?B?c1pTcTNuMUZjc2lHTHROekdqbDdxM0J2RFdrMjU1RHJvbkNvdHRDUWZIVE0z?=
 =?utf-8?B?ZWdibTlHTWpGcC9xRTdqbTcvMTBFQjAwbWhhTHg0ZFJYbWhVQm1Kb2U5eC9a?=
 =?utf-8?B?SVJvY0dqSXJOdnM2Vk5VaGVYcDlaQVJ4QTY5MFc5ejBPR21VdUFyeEgyc2wy?=
 =?utf-8?B?NjQ5a0NveHBDaFZzWU5veHFaWjJycWY5QlRlS3dpeVZZZE1HTHRIZXY5V1Iz?=
 =?utf-8?B?WkVlR25xTzhBa3czU2h4KzZIbVdDZTRuRTFGRVNsM1pINkdtNS9XY3Q1d0Nl?=
 =?utf-8?B?M29qZSsyaHMyeWorQTBYanZJWDRycDE1Vmo5Qi90ckRTL2E0N1pxNktzeUpH?=
 =?utf-8?B?K2FSS0d2TVFVUlpUZzhOYXV4b2R0SytyTExvQkp1SFJHYlFQcXhrWjR3Uitl?=
 =?utf-8?B?S2QzejRZb2FwVjBVQkM2TDZPRVoxRU9kQnhnVExTMktqQnlFeDJqckpUVmp5?=
 =?utf-8?B?cjZKcXJZc1hXK2ViUE84dDRRc1NRVXNaUTlSRW0rejM2Q0NsT1QvNnhQNVlv?=
 =?utf-8?B?dXRrZVBiVDV5L05YTzZaK25ydndqZStGaS9lN3RZK0V4NkR4SWhqbUVGU2xN?=
 =?utf-8?B?Z3ZHeFgzaVpwMzZ4Njg2aXFCRHI3WnV4dXozNzEvNjNaSzBhME1vVWdiQ3BJ?=
 =?utf-8?B?YjV1VWxHOWc0UGxseXVaRHp0blJLeHdwcEpmWFQzLzZvUUNVdTRBbThGSGN6?=
 =?utf-8?B?ck5OUTdobE5nL3p1UkhJZmdkcnZTQmVWZnFDY3N2ZDE3U2RocU1DTzhzbTlz?=
 =?utf-8?B?OHdsVm1wM1k4OFVxdUN5NjdQMEZGdU1SM2dvSk4vVzFzRUlGYmNtYkFBcDVR?=
 =?utf-8?B?UzRveDd2R2lhb3RiM0x1QlpCNUc2V0J6NFl1L3ZpWU9kZFduelprMjFsdkU1?=
 =?utf-8?B?VkVVT1NNVlFpaWVFNVkxUVhvLzVwdTZxdE40bEM0VFBUSmJHVG1jQ0JDT1RR?=
 =?utf-8?B?amxYd2Q0ZW16L2ZsZ1dLTWpHRnYyaUwvaHFVbExER01QZHNvTjArREVKNXZn?=
 =?utf-8?B?RVpRYXd0MWZHNXhHUy83VWtSUlA1Q3lENGREVlNKLzFqOW12ampDeHduQm1D?=
 =?utf-8?B?bzlna1VOK2luZG5scnF1RkpWMEdZdytHOUpTWGFMKzV6SFdwTi8vYlk2RWZw?=
 =?utf-8?B?K3NvcUZBVWtMVXVtWUVFdDEvVCthV21wTHV6SE1jQloxKzRkMmRkWlJkM3c2?=
 =?utf-8?B?WlAxcFNaTWFKME9TN2VSbHFIU2V4bzNZekxmRUR1Q0VNKzBZUHFramtVNGEw?=
 =?utf-8?Q?v7mHkYmIOhLqtkUJB7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6fa636-d882-4205-2151-08deb031d743
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:22:04.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVtx7R8XLVubcOCq+PQ1fvloM1tS3VP7QA0XzH2hffBf5ecJM+6Kk1Fi2zM2Qa9q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189

Hi Guilherme,

Replies are inline.

On 4/14/2026 11:40 PM, Guilherme Ivo Bozi wrote:
> ams_event_to_channel() may return a pointer past the end of
> dev->channels when no matching scan_index is found. This can lead
> to invalid memory access in ams_handle_event().
> 
> Add a bounds check in ams_event_to_channel() and return NULL when
> no channel is found. Also guard the caller to safely handle this
> case.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
> ---
>   drivers/iio/adc/xilinx-ams.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 124470c92529..6191cd1b29a5 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -871,6 +871,9 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
>                  if (dev->channels[i].scan_index == scan_index)
>                          break;
> 
> +       if (i == dev->num_channels)
> +               return NULL;
> +
The added lines use spaces for indentation instead of tabs.

Salih

