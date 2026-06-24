Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021136.outbound.protection.outlook.com [52.101.70.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D6391E43;
	Wed, 24 Jun 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285848; cv=fail; b=AVkIuLUUgXhnfnfe65ofmWmstPhOCLmrIGmlRUqSlwtLhMKkZmwe/3xBmwuJLz62GlmapgbezYwl/GcO+Kj+wZeAFRC0L8FAJNZhMbuLLJU3BPr/dpG7rmUSHcdRUNvdJAZVbK0jtJ4k8u1uVeIG+iG9gAeKsrLIu3TWvnQiZko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285848; c=relaxed/simple;
	bh=N39Vt7besWW7cSMSxkzg1Zu8Q4LH8RXNoWDFN+szV5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiimMp0Jw/0MOaLku1tLSsw8lAcIP/hFvfh7ULmCd7mZL7pR5Vj5Ms3hPqIeUO+v4XdRlFly66ZytdNLfVu5xwlUvzddhLMGxLSZcdWZu1V25KJGK8yAe2+uURjeqpqxzuBm6GZZIXQUgKo1sz7Ri9lGyym/Du1NRs9rgfjJ6tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=OF/4gPro; arc=fail smtp.client-ip=52.101.70.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="OF/4gPro"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIHvptR5xMZSfKjr00U18xZRxdBimvhaVAZsSs/h/sfqhTAlmNaQqaw0uxvqUNBqp6wQcJBavk+0yym2Lfm2gAndRwyWj2BlH9o1pZ2TKj/P4h8Z/kTIVVoc0OWRJmN/k4SGxMaFP4GM+UMt3gPlfNjunSRsr2tjywlEjX8eHq/1kkPlb4532DYFLqKqBJnBRgHXhRNGw/zuNAwrrWS/QLsxYWp835+6rPNMK6BI23WfLItPLxBEkHqcoqD8iJk1Wn0KRukF2Z9Pqbtn1Hhggq1CKKFr14SIaJ2KziUUrM7y4LgEvH1U/i99exxdqFnZ18lDXyYTG2q8AKDIq+K/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iSbozAZqdec6c+ONzeXfefBw8Gm8p3YmH6adcU73t0=;
 b=lpjfR21nMl+6eWSVzisaoiw6ltpiJKgC39n56I0IjokzQNnxksr8PG40AWn/bGqABKDOX5leQRCHx7HTtVo5NOEwC5xp6z+Urto5ELHpHMktg2jD8/rFnzTk02YuaeR4WBTrieLieK7gB5ulCTfx8ueGirkz5gEStPLstxsWSZOq9gnTkCY1Em10dhAXbitWGp+RE4/3isohOZBoM/40Jc+pIVhOrxoS9TSYQDW4KkyYz/gxf0oJFzlOgGsCbFNCRe7qKcnB0mfp7UlWN9ilSKl9B9Ld8OHd/wtRkI90wkz9OLCHBQQNFbiCyXYmt50qZJUyAYRV0hi95+Ya6iMViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 109.94.150.189) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iSbozAZqdec6c+ONzeXfefBw8Gm8p3YmH6adcU73t0=;
 b=OF/4gProBdaglVnhRrSQBQxbNe/7uvuUStxOQ6y2fKvQM8WbCCiSXUDNzYXbgb6IDZVbbPFIsKAeytbc6OwDTx9IcbCjf8YaPPrCB6llNxeY9AhW3nQTk5HBg0Qni5dwWJVvVoIOdS+poTYXfV1aYEz6/EDaysPbnGenAXH1E1c=
Received: from AM8P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::30)
 by DU0PR02MB9097.eurprd02.prod.outlook.com (2603:10a6:10:47d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Wed, 24 Jun
 2026 07:24:01 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::41) by AM8P251CA0025.outlook.office365.com
 (2603:10a6:20b:21b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 07:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 109.94.150.189)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 109.94.150.189 as permitted sender)
 receiver=protection.outlook.com; client-ip=109.94.150.189;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (109.94.150.189) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 07:24:01 +0000
Received: from EXCOP02.bk.prodrive.nl (10.1.0.91) by EXCOP02.bk.prodrive.nl
 (10.1.0.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 24 Jun
 2026 09:24:00 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP02.bk.prodrive.nl (10.1.0.91) with Microsoft SMTP Server id 15.2.2562.43
 via Frontend Transport; Wed, 24 Jun 2026 09:24:00 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1wcHxo-00DSbj-27;
	Wed, 24 Jun 2026 09:24:00 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <dlechner@baylibre.com>, <andriy.shevchenko@intel.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tobias.sperling@softing.com>
Subject: Re: [PATCH v2] iio: ti-ads7138: Disable STATS_EN bit while reading conversion results
Date: Wed, 24 Jun 2026 09:24:00 +0200
Message-ID: <20260624072400.3208213-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <da800798-e902-44ac-b245-b31aed199e92@baylibre.com>
References: <da800798-e902-44ac-b245-b31aed199e92@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|DU0PR02MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e996012-95b0-4a05-47f9-08ded1c19044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aXd9csRgszu6bqEl/Ej3LP1b3pI+v7NLpiRO3kS7ay7R7713nmrzsOAQ0wJjvqjVx1RxJWhOGiDR7PqfAl9IgtS2ND5CeAtt4+VcF8BCqVNIqyQO/RJonpJ0vIq1c6XQ4X8b0R6QiiOH6gpVBCjpq0CKpuFsY00pi1dZ8OLz+3kcGIWL0k40/Do3EPzJnjBhtgDUvuSldop1eoejxnHFjKc5OhBjznwznwhKVSPUDfO2vZkM6K9b2SQEcWg1aaG/ZGpLZ6y+GcRfjhw4QNGFwGNZbtZE4SuvJstPC0gsNHSMUySm0CBMCoIo2rltcjnUNQ4cQJKx6BCaz/G0ec8E2zY671W8MkYWTBwtB78j4PNNxP/wFO3kzyX9FX1TJUpBlUhdyMYqH6me8Vo5tOJqHCOzbyuJNZFgyT4dbGXQPYUCfKvrTAMr2fW8CtBlO3HNTppP/wIXbjBm0JdZfBoVkAhAs0mNHxmRUAosvJgyXPoEr1+19PemCs4eu+ER2qUaPMwOCuvgkXWjPhKK4bpea+BgjT3yHK7CSepyxPYZexY1lkAhbwKnHgKpdTmO/4lPkmBIH7yvizuK0Ifau8PWO8J4Av5qPhxrx8wFBFgW+2NyIYl+IFW4zcMmFR5dkEeB6GRkOfTCFc/h9WPftG5SqSWnV6Sy2BRSU0+DhHminAb9AC/J6R6yZNzidDjYs0j4RNSqNL7hJbsy4Y+VUVf50w==
X-Forefront-Antispam-Report:
	CIP:109.94.150.189;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.prodrive.nl;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8DASaU8Frd+2Tug37lvIHvbVVbhayxVxcZgQDBp8QmQtRFnW4mmkPcK+ELTF5+ZqvHgkpt3rh7Ulbmf+NVOobSE+mzSr+JUG6gWgwOc7sSSZPyVoI5GohkxypUJfL0mUYBz6m/I/Yk0WCdfy+0LYjn2E3i13Y5JsNtDC8jk5uER66rL6WttzpSy5HjEyNUnsSYu6XwfK23vWTHpgbXebVsq5jZUAH5xaM4xsH8NM95Yf4Rf7p8v68q1dlItK2xamwT+G/3gYfcb7YhnJqoEa5pEoj4F2Q9kf53OUh+fgzGVZDpyZXCEHxKtkxRkh/Ym3S8f+G4iqgX/myz/nIJAD//PWP4rje1BoqsBxk4Undf7jkH9lqPwBIGZK5J681iCaiqWmPrWE9NdsvW+va5ZoLj7nlvyo/4er67mJ1O3Dahz9Omr21YUnp1KvWKLmJeWg
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:24:01.2274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e996012-95b0-4a05-47f9-08ded1c19044
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[109.94.150.189];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9097

> On 6/23/26 7:52 AM, Paul Geurts wrote:
>>> On Fri, Jun 19, 2026 at 09:42:08AM -0500, David Lechner wrote:
>>>> On 6/19/26 4:00 AM, Paul Geurts wrote:
>>>>> The device might update channel data while it's read by the host,
>>>>> providing a data race. Disable the update of the channel stats before
>>>>> reading the values.
>>>>
>>>> This description seems a bit short on details. It looks like this
>>>> driver doesn't support buffered reads. So if we disable statistics
>>>> during a direct read, why would we want to enable statistics in
>>>> the first place?
>>>
>>> I believe this patch is initiated by
>>> "Until a new conversion result is available, previous values can be read from
>>> the statistics registers. Before reading the statistics registers, set STATS_EN
>>> to 0 to prevent any updates to this register block."
>>> from the datasheet.
>>>
>>> I would rather like to know if this is IRL problem, or just a datasheet reading
>>> based code.
>> 
>> This is indeed the part of the datahseet I got the solution from. Our real life
>> scenario was that the register read from the RECENT register was constantly
>> flipping between values 0x24F0 and 0x2500. Due to the STATS_EN not being
>> cleared, we occasionally read 0x2400 and 0x25F0. So this is based on a real
>> life problem.
>
> Thanks, this is the kind of description we want in the commit message.

Ok I'll update that.

>
>> 
>>>
>>>> (This driver suffers from the comments say "what" rather than "why"
>>>> /* Enable statistics and digital window comparator */ so it is hard
>>>> to say what the original intention was.)
>>>>
>>>> Can you explain more what this race condition is about and what
>>>> happens before the fix vs. after the fix? People generally do this
>>>> with two columns showing concurrent function calls.
>>>>
>>>> It seems to me like disabling statistics would break IIO_CHAN_INFO_PEAK.
>> 
>> I think it indeed could break the PEAK value. But I think the data race is a
>> bigger issue. I'm not sure using the statistics at all is a good idea for
>> this device, but I'm also not sure there is another option. TBH, I don't
>> really have the time now to properly fix all of this. I just saw and
>> quickly fixed this, and thought it would be good to let you know this is
>> an issue.
>
> Now that it has been explained in more detail, I can see that your fix
> is correct. And we should also do the same when reading IIO_CHAN_INFO_PEAK
> and IIO_CHAN_INFO_TROUGH.
>
> This would make it so that we could never get the peak and trough from
> the same time period though since each read would reset all 3 values. Not
> sure if that is important or not.

Yes I can add that. It would probably not be ideal, but at least the data
being read is correct.

>
>> 
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>> 
>> br,
>> Paul

Thanks!
Paul
