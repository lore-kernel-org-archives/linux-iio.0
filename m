Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C640DFBB;
	Mon, 29 Jun 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739007; cv=fail; b=XnhgOGwk/OjH4y/EK2qtamzOM6R0SDmlqv1zcyMNr/TgWTZTp4THpPtnbZayAC+oJaTBK6nGRfSTleQLMtyQTZKuoPb/F+sXl4n4nryVe9ZPKmx6pSPGoAlAKk7pRNoFs8T5Sc1TTHQ5kt/uc4pH780GZhDEdjYcGzEN79M6low=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739007; c=relaxed/simple;
	bh=f5u1wwQrd9xLFl4okAxlbzKifGZu5vq6E5saEqEgXGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UvylXJam7SZkXFvN+Zlp2nnOOvGAJ7+HdG3q9fxGqzvZLHgJaQJqfHwENKMyK/ldsh/MNqq2VHCAfLbXK7CUtSbKgvd4EBgwj4zs4XvwZcO4TXjEG4flHyd8yFNRRJakKZOWbeL8ihp2DGDkeWKsvxCRJW84Dyr2vlHwoQw0xrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=04KscSrB; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="04KscSrB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oShqZlm3GKKMDZAgyXJQvtFQMcDbKVrIA5fQQXG1Y5bDenyRdey8S1VMB+Bzmr4cRWewgcqsuM28TZ/zn/RyQPd6fJoMJGlzEG4vEewOJ/gmjQ1qwdpBfxa5kosBb1i3NlGJBrSGP+zJAQPeH8egPRgrYHmcdgfpToPUdLDjp0yrqc3+cjX69sonrtW2t2TWSYtz++T4C8tb/sygDHn5vmuASgTho0dmKouCu+lNF/MKRhnpgXqbBgF8RBIgQp5qTG6ixJumBqxIuOzVpcTk/MPcZYa7lYdg7Qx8i5KajdIHg4NiVDIYngDUzlWfJBCvz26NocUUGQxLvvrxJ6s2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRHE+pq5OAsDMTJicgTGoI804z8BdXoqvoSxTs+r780=;
 b=L2yLozZT29hhNVL728kqDbJilWhsVJBd3W8NUR2q3pa2ETmD+9KddfcT1sdyqRRo1cWkHP7IGbaXUSCSfquhPJnBmjh5jMMsuXqgULoye7ErydfQCKjdfngUP5Ds95qvIUWhGw0QFdlbeBf2huyXWfyxk8wouUPbW5cDMN4jp9BkrA1EsJoHjC7c4wgs904FpZRgb7C1xpJOC2uq8cXZ17kUaH/Q1RMZKXIxKvKwsaRmxilv9seX3PjlCS2goYYsHs+0Yy6TiF02inuNAzR4TWu5SfTDqQUsJ3opk1rSG4ejs2dMtEnjsUfSBoABaCYJey10tGTz3pBm/6LW/GF6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRHE+pq5OAsDMTJicgTGoI804z8BdXoqvoSxTs+r780=;
 b=04KscSrBHhB4P2Sv2byMvLhG2PMH75524m0cbhfSrWgMo+lvD9rEw7n6le//uSRfHX4o760FL1RLus3UylrUgIec4gcAhZlly4/ua9NwOKvr5EaV2Fy32hsmrJtZjYoFmZSHeF2MYo3hAkCpmqfLFc/pHnHLtqO3uoEA56VOXhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:16:41 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:16:41 +0000
Message-ID: <e574f8ec-d869-4823-b9be-83c7c6d3b2c3@amd.com>
Date: Mon, 29 Jun 2026 15:16:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Sai Krishna Potthuri to Xilinx AMS
 driver
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260629114754.203415-1-sai.krishna.potthuri@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260629114754.203415-1-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 2617b08d-3a7f-4d5f-6aab-08ded5e0a8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	IjJgOYWiXcVk7S3s+katBqo8adJ21vvJvfor52xgVk2EMUot+sAKmV59pQnAXfS9rHh+CkgCyr5C5nFPkQIVzrSIUBcjJu+xsiU8DVFT4wZR2db0ORELsTXL22kiZ8+hzG4IDjgSuy7nzOnZ2VQNJ0l75XNddC1wLJY7tmG4/Lc0pG5cugVMoxZxkFruXNqLNOWlMzcNFWk+pzlO1s9hVr7wh2qJ3MC1esH87YgJoXJ164uPsQgeIOLq5qdsmNwNqxCLAFKzlanHhocBbuUEVMrrbL0+uE9MtTSBVQ0i2xujDzbiE3FYSSe2k+oL05f0DjFURbwzCaEXDFHDt8etgmuPoN/19ArZ6StHK3Wo7etlM6e6fRdljR7OiZeIyvDaVpYoRD629NbfTF9H5SHsMvRCph8YY1Il6QlkTmdGK4nCBoMPBz7L8ApcAgRWkJa7O+lQiTkBUDtZu3PImosYz49gWhOuO3OTI2+VVbv8Kj0dVFgdg8FU7DEZP19mnYjZCYJQiLTkotnGQHB0D3Mgh0ZVu4L4WhOzxZM0zwU578JhSwbvhYgNXCP5RUPpdPFKfXtYK8X7c8+eWJhAEFxkLb/zT0buIjLFuWYTyrPUi6gS+FTv3lpdJB4Kve+wC+7JKUpy7U3p/3Ra+dRkOO/Y/PLnKhNpMDtL4u5w0VmQE4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzQ1Tk0zUnZJSnptV1BMeWdSNHFpSmdSQkltdVZMeTNPc3UveGh1eDJSS1lM?=
 =?utf-8?B?c0VXYXZPSzZOYWF4ejgvT3h3U1lNOTBGMlVjbjBLQzlhb0hDY1R1ejZsalZK?=
 =?utf-8?B?Z09uWFBuNXJXV2tSdlQraU5tYll2N3oyRjNvV25LaUNRZkZaRi9IVVhFNWtH?=
 =?utf-8?B?THd6MTdOaE8zc3dKQkRYb3hkNWVTeDgvc1lJU1FBK0l1NUQ0Qzk3NVZnZTZF?=
 =?utf-8?B?V0xDZ044bzgyTkN0bERtbVdrWHl5UVY0eTVlTWl1bTVYYy9kbnVoNWU0eW9F?=
 =?utf-8?B?dE9FWlk1YmsxMlludTgrT0gxYnVLWGdOV2ZOZWMyRW96THgrRVcxSnE0RmZM?=
 =?utf-8?B?Zk9CVEYvN2ZpZkxuMENEeDRRMFQzeFpBRGtENG5RWUJ3QUlrSzNXYnFtTm9V?=
 =?utf-8?B?bFJ2eWdqMmFiL2x5dldSYldJRC9rZWpXblZaQ3RFNzZJenpOcmVsS2NjbHcv?=
 =?utf-8?B?QUc4ZEd0VmZ2UW9qblVRVGQ1SmtKcUNXMlRGQUFhMDRzeHVQQzE1UkRKYkZ2?=
 =?utf-8?B?YVRCaU1IZ1FVNGdJRGVFZDYvM291Z3EzVmt6aHhOZjJubGRaWEgxS0dtMFFI?=
 =?utf-8?B?ejZJM2RJRllDbU0yblVraHB6MUowRkpWUW1uUVVxS0RJTmUrd3EwZ1ZKQnhY?=
 =?utf-8?B?alcrdUxHNGRneFNqdnZDUzFhd0JtdGhBVForbGJENWI0Q0Yxcit4YnV1b0dL?=
 =?utf-8?B?QkFLZ3hnVXU1NE1uV2FSZmFuV2xDSGc3a3l6RitYZmltWEwycWh4Zmdobmo2?=
 =?utf-8?B?OWk1aUwxQW4zbTlRREJkanhvMXREQWJpYXEyRjZtU1NFWThRSzVYL1VLaUM4?=
 =?utf-8?B?bjFmeWE2UjRFMm1rbFo4THRBR0UwNklpVFpTbU5kWS8xRWg4ZTRsRE5ZcG1S?=
 =?utf-8?B?dXc2clpnUWh1Z2p4WDlpc3VNMDJVNC8xeWhpcndlMlFRc1ljR05LTEZ1Q3N6?=
 =?utf-8?B?angwMGxLK21IVDZTV09GMDducXpLYU9kQjJFR2piZVI3cEZmSEhaSXVxd1Ni?=
 =?utf-8?B?YmorY3ZFM05oenVvK1lzL3gyRTFLZm41MHc1eTNtSEx1YWltb2I0Z1Z5WElE?=
 =?utf-8?B?eGZCY29aNGVLajZqem9pV3pUSzJDNUVRUnk1WXdseDh4Ulg2dzNaampRV29E?=
 =?utf-8?B?cTFVM2hTaGNJVy9vU1dQbFI1QkxDVkZQdVhZNS9RbjVBWUdCcEZ5QU1zcUpz?=
 =?utf-8?B?Y2N5c2lIaG9Ob2E4TnZQMW1NQVhvL1dMTmlabXQrVFExMStDWVhZeG5pTWFs?=
 =?utf-8?B?TnJiWVZYRjBTeDBvcXk4UTFlY080ZHQ4QjZmYTVOMkZwVlI0R3drbEFsWkVi?=
 =?utf-8?B?eTZVQTFlYnZpMnhYY0dYZ2h1WVhhVFVCK1lZZEJJSGQ4eGVSZktjL2ZsMjNl?=
 =?utf-8?B?aEdpMFBMeDBZeko5YmZCd2RGb2lxS2IvdkNWelUzUDV4QUpPYXA4dnJHUDJm?=
 =?utf-8?B?QW5CK0xiTEcvRm1ZOHVDNStpVmVCYnN5cVNOMlpENVR6b2NQV1g1K2M2aXZB?=
 =?utf-8?B?bTRRMERSUTVQL01RRDZNRWw4UmZBQVQ0VHZiODBYZURla0tBU21FVmN5cFZ1?=
 =?utf-8?B?Y3JGcE14b2ZPcGEveld3ZkMrT040QjdUbHlHZmQ5NjN2eWtMZHhNa284RklP?=
 =?utf-8?B?SUtzY3FBMU92eUFxVzZxNENpYU5JZ1VjU1pWTEhwZ2NLQm8wckQydFNCR3BB?=
 =?utf-8?B?bFkwSDFRYVY5RDhTWGs3T1gzR3hISlJoNTBCZ2dIY2ZpcTdVOHY1TW04QmFt?=
 =?utf-8?B?TXdUOHFmRWVURFNiNXZSRjdBQ1B5U04xNW9iWUVkYWJYOUFoQ2xEZDQwclZN?=
 =?utf-8?B?eTJyTFl6LzZ4TlBTZ1dNcTRzZklxbloyRHJlVHB5ZnNydEZaTWt3eUtmeVV0?=
 =?utf-8?B?VHIxQ0twWWE1MjVsSzk4b0Y2OGtCdWcybFhxZ3RnMVFTdlRvSG00R3djMEpP?=
 =?utf-8?B?TGR0T0R4RDdSSWdqL0FrR1M1a1lBZThkb1lKL3FZSWdnYmxaY1lCeE1VZGxu?=
 =?utf-8?B?M1l2TjNBWFF2dnNsdzhOZUFVb2hCT1pZSUpnYndmRm5SUnpXK1luQXV1Qnc3?=
 =?utf-8?B?SjhXcCtSb0FGM1pncVJQbzdUOUQ3dnpqMXI1d2JTTFRaSGp0M2xEdGtDbnZk?=
 =?utf-8?B?SmdLeFZOb2pjc3o4cXFla3ZENzVjT0JlRzB6Z2xRUnF0c1JMRVU0ekFyY2FB?=
 =?utf-8?B?RFFaUWd2SXRXenpaYy9iREt1Wk5NVHRqQU9PZFRRc0trVWdXRnJENFVVSkxt?=
 =?utf-8?B?QVQ1M2VhTmNQcGthR3lLK1hseks5WlRGWmttQkttMjZzNklrSDUzQUlWbnZF?=
 =?utf-8?B?VEJURUVOTDRPbDNiNUtVNy83YUc3UTdIZzIwMVY5ZVpjZVZScFQ3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2617b08d-3a7f-4d5f-6aab-08ded5e0a8d3
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:16:41.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8kL6wlzsfzIdgrDozGAqyoshUsJvmZ4oy09UG6NHD9nR0qji1cQvg3b5uMN87/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466



On 6/29/26 13:47, Sai Krishna Potthuri wrote:
> Add Sai Krishna Potthuri as a maintainer for the Xilinx AMS
> driver for continued development and maintenance.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b4560681b51..924e004a8a5e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29460,6 +29460,7 @@ F:	include/uapi/linux/fsmap.h
>   XILINX AMS DRIVER
>   M:	Salih Erim <salih.erim@amd.com>
>   M:	Conall O'Griofa <conall.ogriofa@amd.com>
> +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

you should replace Salih because there is no intention to maintain this driver 
from his side.

Thanks,
Michal
