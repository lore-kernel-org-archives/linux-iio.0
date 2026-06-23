Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4233C6611;
	Tue, 23 Jun 2026 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207838; cv=fail; b=toWB0bhUyk3jLjZXVKyA/bsivn/0tB1N+aPyGq954wT/vjIcaBBlxQ0G9SgbAVAfMkhrU7G2vsnXcSvKxZQ8DbuFNy1f+M/F+27e6gYaMIjPw82p6I+qlHXjF4QmU69oiYtaNlfJ5PQXoSIQ1y/ArS55MpiZAQh4VHGzMYzCr3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207838; c=relaxed/simple;
	bh=c5/lTT57QjmeqQJWhZROosPUJaILhzLc2jEaZRvPmBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t9gYk9I44cHXZdX288bqwg8B5/WfX5PuKF6crc6VKvMjwhWYO9ZlUWhUl29zrwV2zzHXIBFKPGV3NXuALFWaLj8zpeZHWTJ+g0B57gDiibiOT/LGrp0CZX2wyecSqaRXevLiqX6zMa2N8bcfi3hjMKN/LT6mimHZPr6DZXc30kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GQyioHy+; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GQyioHy+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlInPGPB+ZfxRDfBWkJ34xZ5aMK66Za2SdFfBM20lfQh7kL0IkLf/vJQPdjmtgG7xfUt9tvZBSu9epmCUjgRm16ufr7+482I1owC3HNujNGQqDH8y7cfFskxWUqpRx6XKDGFmRccLk1B8z4YbKVfe0gbfQqsdfWYT8E7HylWbEXMt2AW5PGx5QYC4VbbDe46qOWOh+AJowo7v9MtmR8JDk0Rs5Voul1OhCLWCYkfXRT7sjvO67pxBz6ufWFGsEnSFyJscqOMRdGfWJjpXKZJvfP7JLqP0VPd5+0R2xNr3JdzEsKlNY9pRD+RtOOaDbJ+LqddqEybWvwCzZGMASr0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzwEa75SVblGykfagU1zVBLhxmcBKPZum3qY/q9Q3pE=;
 b=e5KcQHP7NY3d/Y8i+3RFLhs7MlmcrspFP8dYm2ClsGF51ngEe2JS0hYnMHk8JvwSWICt1WUZR5A0V4rpW8xfBhzjQ+VwJ4DKNBIq31lXyNmFwvu7JNXsmbKYq865ZZwWWnkbMhs7TbNyMEod7vvMrme9gAaiWXto+XBLehz9AtQ7+W9UUaOsyAlB86aOlda6pbhOv8QFq7Cwq95mL5J9DxeOwHXPDxIzBRwnlTcfomnMUQz+PpS8x1kmwH3YcEEYwO61bgSE0YWlyXYtTQMjn7bkf0ueusgaSXlJyDcXS2TGIITz4FWCHdQIcM+R8v0vEJKOX/38WL8oT5yaZHXvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzwEa75SVblGykfagU1zVBLhxmcBKPZum3qY/q9Q3pE=;
 b=GQyioHy+c1A4xRDtR4HXv7otANck9wU7ttfGPQo9ALvWGuVSlq1WhkWQ5hivAawnUn0qQDK50Mbosqe8pulQZsQiQ0F2WOeGgA+rI0hHFNysiLs+sFMqoXV8WLoibmEpyW/1k/7ebjaZyn66kZZuFHMRn0drIBz5RYO54LSlWWbOse0gSwJkNUR3SnwC1kHbSyI9E60VSDKGv14xODHP6xPrFxYVaAiUEIIqhbTshdzJIxpjWUt300597K48Y/aicKK5cJAxJEUzO19c3cAD5pKXgT+dq8kVIwja8TN5oXo4HGEaKOEuL1QmzgkI0reLtMfAQwoyvGBsMUQD8e7Eaw==
Received: from CW1P302CA0027.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:297::15)
 by AM0PR10MB3587.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:43:52 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:400:297:cafe::4b) by CW1P302CA0027.outlook.office365.com
 (2603:10a6:400:297::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 23
 Jun 2026 09:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:43:52 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 23 Jun
 2026 11:48:31 +0200
Received: from [10.48.87.64] (10.48.87.64) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 23 Jun
 2026 11:43:51 +0200
Message-ID: <46fce99d-9dd5-435b-95cd-86ed4771aa83@foss.st.com>
Date: Tue, 23 Jun 2026 11:43:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: stm32-dfsdm: Treat flags as booleans
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: "Rob Herring (Arm)" <robh@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260612215151.1886851-1-robh@kernel.org>
 <ai1dhJWb9vKqxEEe@ashevche-desk.local> <20260621151026.69714694@jic23-huawei>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20260621151026.69714694@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|AM0PR10MB3587:EE_
X-MS-Office365-Filtering-Correlation-Id: cb799532-a9d2-4ac0-1d61-08ded10bef4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|82310400026|1800799024|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uTgiYrW5OMUhs76rdxWHgh8vqjeDQbgJ85zYMhglDPz6nC+zFow7ah7JFHMjk3Cvw9CADuKshjfqEE0p9AWiYj8rpyNI2ihkimT0M4X04WX2DnKIzM9X711qQNw+NCGTmGNA17V2BmyD4DBHuRTsf67IyQ5L3YiiOIHqD3yf7IXJwofESlk9kLtjomki4c5to4lVMIiwZbtkpviUfiim4FUDjQ0JGGG4fs6AYGlfT+WVuaH3rHExrNJKxFtQTrPng0uoDNkJy4kb4VIpy9HIR0hSFyJCrcVmfWz0BUcxfjbxIUvaQkOZI3DpK67jKh40qUCcA6ssm8G5gJQPYy9xPZZyW+/w75Mc7siSbm+BNuhVukQ+7Cz153yi0c5fWeCS/2MpZJrRD4+KYLXQPfUh4Tvc5CbTHgbccR4Li0bmZ0dpkVGq9EDWzlaXem95U3IGbWRSU+ut39hgd2XLy4byQTq3yF6mz7920W1uI2ZVz0ytUq3ekehA8Hpj7zUAVWshO3CLmbbYxOPxvzt+kWDvswBQSjSZeKEDXuztAE2DfIboD2kVplS8XTeFINnm3AOOuFDcC5BylmXqS/uxuxebDsLZ31zrVhk9IQJXItcYfpZhf2suXh85ZoBpmIZMnlYrud4B+ae/Jwneiix428ofeBm2at0NdgiVdeDcUq7KFmJpCYFOe2eB57NR8hFycBVEvrsat0Mk1iR04f0Ec20FNg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eYFI6jQmZ7osDd8wtC/j+X1GK/PhcCscAawF6J0uyab6o8gxPTYBmfv2FBw6AZ9cYqqPTwUBj/KIoUTM+IXS8oqjQYHUUcOOG9gyisg14Qh+v+sqgch7/5yO3Cm1NOgHbwjHez99ZTkW74x2OYLRG9yerAvxiiAX6CCJrqVZLxSPv6zCNgJA+wO2Dg/LfFQ5R2tS+jRFBmdmNyqFJ4uYewLxH47qxzGJbxaYgLjxPne4iTdZ0UE6ua/Z8lm/Q9luRpfrQr8GCxGny8CorU64l86Sx3MBT31+b0wo2khEPJ24j19YrHqDMJYHO+BFFZLwHZWQ8SllXJBTvqRVDErj/B8LUQms2WtZKnwzZHiVYdI3SBTMK8yuEzJhL0WZZp70HrO64oIp3IafJikDa8ED6FV5ar4rvvIX/AJB439X27gg+x9DaXUimpTI8LwlMHxj
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:43:52.2098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb799532-a9d2-4ac0-1d61-08ded10bef4f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3587

Hi Andy, Jonathan,

Sorry for the late answer.

On 6/21/26 16:10, Jonathan Cameron wrote:
> On Sat, 13 Jun 2026 16:39:16 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Fri, Jun 12, 2026 at 04:51:50PM -0500, Rob Herring (Arm) wrote:
>>> The "st,adc-alt-channel" and "st,filter0-sync" properties are
>>> documented as boolean flags. The legacy parser read them as integer
>>> cells, unlike the child-node parser which already checks only for
>>> presence.
>>>
>>> Use presence and boolean helpers so both parsers follow the binding and
>>> the property type checker no longer reports the flags.
>>
>> For the patch
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>
>> However one interesting remark below.
>>
>> ...
>>
>>> -	ret = of_property_read_u32_index(indio_dev->dev.of_node,
>>> -					 "st,adc-alt-channel", chan_idx,
>>> -					 &df_ch->alt_si);
>>
>>> +	df_ch->alt_si = of_property_present(indio_dev->dev.of_node,
>>
>> I believe it still has another (serious?) issue. We usually don't use indio_dev
>> for device properties. It's not a device that is described in DT.
>> It seems the only driver in IIO that does that. Note, I haven't conducted any
>> deeper research, it might be (however I'm quite in doubt) that this is correct
>> use and one device registers a few indio_dev:s.
> 
> It is curious.  The registration sequence in this driver is complex, but I'm not
> seeing anything that sets the fwnode for the struct iio_dev->dev before calling
> the init() callbacks that end up in this code.  It is set later by iio_device_register()
> (iirc that has something to do with consumers turning up later).
> 
> St folk could you take a look at this and see what we are missing
> if it does currently work?
> 
> For now I'll apply this patch but might need to drop it if a fix clashes
> with it.
> 
> Thanks,
> 
> Jonathan
> 
> 

I confirm that the current legacy path is functional
(With the st,adc-alt-channel property fix applied)

It currently works because the driver initializes np from dev->of_node 
in probe, and that value is then used in init callbacks.

I agree that this approach is not robust, as it depends on 
initialization sequencing and on using an IIO object that is not the DT 
owner object. I will prepare a patch to use the DT device directly as 
the single source for DT properties.

I also suggest keeping a fallback path for st,adc-alt-channel so we do 
not break legacy DTs that have not yet migrated to the new binding.
I prepare this also.

BRs
Olivier

> 
>>
>>> +					    "st,adc-alt-channel");
>>
> 
> 

