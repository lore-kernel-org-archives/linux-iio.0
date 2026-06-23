Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023142.outbound.protection.outlook.com [40.107.162.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4B1F4180;
	Tue, 23 Jun 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219168; cv=fail; b=R04gML6z9GNhxFZJB1yIJ2wSlnjevIeokBffuRFbmtouBQiHOD5bxat+8t97u+8gdQ8hdO2i+X5kGsBUQEyLRU307s4X/Sr1ugkERMF+5E/msLxMbkDWrFFdY4nl0ALQx1x5FNmzRrgB2UFjpLzNjsyv171STmr+aQo8r1n2suM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219168; c=relaxed/simple;
	bh=TpaAzcvJWi4ZnNsQAEKSFUywo4Y5cJC6R6jzCTBwqwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRSHlhCttLA2FGTZylEc3qshNbBAwB3KTdN1N3RBfsO7BaV9zpmvjzgR2QYAjEHG0eB101s/FHj+FnyJFRV0CV7LbJU/CwMLSUA9oHKat47neC63f5kyUYQGSK0e0wcDR+rK27ugQ8BFxrFcjtK1oC/RhZzSp5PsXmC3dC5SM9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=ncL6Jt3D; arc=fail smtp.client-ip=40.107.162.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="ncL6Jt3D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiHBAvEZDSRn/zYhsB5OL4ymMGzbDMMwVNhHL5MtGh4jOX+KLS6cADqvqmi8zJaV9ZKk1pBqYcwLuQkEFJC5R5wHr+XEkNFzr4qhE9fc4mxLuR5Jp+gIGFt8LmQZXvkJJ7zWrhv+iPEEd/p3eMZTbwSDbqMVL+50QO46hfSHer6zNxGnMGK2I44eJDXbEYnqdqgXzWQ8azxJMuIpFoOnayg4SOVU1+RLcekRs2y50Jkr5rUFP2T9uws//kR4emFbbCwzaIH0dFp8LfE0+u03qZ8oM7dPjTVVwzYOMQzJtZzcDBHZX9KBlX/QFl/VaEpN2zYFTaJzXmE9Zsqitc0BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpaAzcvJWi4ZnNsQAEKSFUywo4Y5cJC6R6jzCTBwqwE=;
 b=gMg90eA9ULd32IoTcgsa3ugDrGiiOal7oF0fyRTeZv1ctWC11NlY3IQ2VEi8PKp+GaYUzd97dY5Qw8XT2CHcAvwKZRMdmI4E4R90OwePQTzh9ZFydPNMB6KwQkscATlB2zPKJQqY43eBb8HFEuP6JZk097v+jkcMk73VZo+1ym4xJJiUCCDeVcvPE9CkPA9TSvrLyOSgIv/OnWMcojpcQalKeay2Ni0wnMkyKUerjdJIhWB1IrVrVixSQ14ygjPbKNUwd6/WFBVsNf7Ln2YyQ/jk4/LYb1BRUp66+4h5qFQ93Tvbs93DEAZH/V6cBL42Q3f/yS/XvcNIghmn4lTj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.61.153.66) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpaAzcvJWi4ZnNsQAEKSFUywo4Y5cJC6R6jzCTBwqwE=;
 b=ncL6Jt3D8div3PGa0ArQ7UTsx0lKK69kRo9euhvOh5POfWvZFs9jF/KLC523797kXKEOjlSbf8JWUnGTtGYBQ5BR+ntyD/cuMRxHtullF5fPcfyczU6jC+y6eThafs+WXaYUhhwukTleK/ztXq2TZabCfLRKYFktwXB6vGZY9/k=
Received: from DU7P251CA0014.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::17)
 by AS8PR02MB7771.eurprd02.prod.outlook.com (2603:10a6:20b:442::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Tue, 23 Jun
 2026 12:52:38 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::43) by DU7P251CA0014.outlook.office365.com
 (2603:10a6:10:551::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.61.153.66)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 212.61.153.66 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.61.153.66;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (212.61.153.66) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:52:36 +0000
Received: from EXCOP02.bk.prodrive.nl (10.1.0.91) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 23 Jun
 2026 14:52:35 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP02.bk.prodrive.nl (10.1.0.91) with Microsoft SMTP Server id 15.2.2562.43
 via Frontend Transport; Tue, 23 Jun 2026 14:52:35 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1wc0cF-0092RE-0s;
	Tue, 23 Jun 2026 14:52:35 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <dlechner@baylibre.com>, <andriy.shevchenko@intel.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tobias.sperling@softing.com>
Subject: Re: [PATCH v2] iio: ti-ads7138: Disable STATS_EN bit while reading conversion results
Date: Tue, 23 Jun 2026 14:52:35 +0200
Message-ID: <20260623125235.2154290-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ajY0pjnnzQX0IQm1@ashevche-desk.local>
References: <ajY0pjnnzQX0IQm1@ashevche-desk.local>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|AS8PR02MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de2ac34-73f1-4d49-174f-08ded1264d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e7vd7CBnAVLlhL0fhCatBSk+gmnWS4OnfUjasC+jV2SivDNwWhODmn5D7Stw/iFOUWM6e4TTcByQUnWS4ecDGFBN+TpY28/trSE4I8UbzENbubEdgnsLtB0oV7MuPp0F4rvxZqha/IdHO88oj4l9+eT+CuRXDpqn6qVay/yEPddw9NFlIq7kO7gXnHI0/legyIwDka1VxkXEMPkceP62Ba6UkDVwmRL0/OvdQ6GmWI/BFyiFUx+JUAidQgVHz9kB8CEQ0OuEMBMgTHfMpwaAEWKX8p6/gZqJ2qMVUwz27wOth3p1FRhiVKgktAiQT6X8NQi2AFGQerq5z6WfQWhYZYhtPhJMq9arZvFi94Vn9hO2V46eCThZhshMyzYbuLsEwq1pSAhh0Yc1c+rgSRQWZobS00jtjivqYYmar3s/1Br2yHP4v6r5OuNs3txaGaLJa7aooLM8CWuSwA2C8GknhupvtIxu1VNCmINz6lb/6i3QUNksXuPAz9xu0wq4RKuVfp9Qyd2e+4949B68gAAPl7whMPlQ97MqovX8a7NVL2NsNNYuNli52cjWKLHGL1UEI54SquKHtAnEavCdF0ZBk5oxJbeVzGPKGcmlGsZiKADFsk+YndNo5wihtJ3w0Qjw1Iv0meAp2MG/s4/XIYdwwe8UTbKTA7iNfn4DwYDtzLvxDxTKGxcwZHey0bFR5A0/1FM+W+K5gOtoTa4HiSlZ9Q==
X-Forefront-Antispam-Report:
	CIP:212.61.153.66;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.prodrive.nl;PTR:prodrive.fiberspeed.claranet.nl;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vX/xTv07NbQdtnjqjNLC6w5YpQrCG0MIoLDWH8bPp2/2SjrNlbmD78IAMmOIVrEkYdbp6Ok4OKHLhHhOwnUIGeKE7QEZLMQCn7JAnj8yynZfxbwd1t0lw9kI0BK6tzv2il+X76/7CBusq41ZLxqMQ6XsOSRQ0SzbEv4OJxji+HtfJFL6xp4+k35s/JOSd1F5pe/JbMJNOB8koL2pkY6aK9et8mYsJJAXfN+fryYrMSEbM9+JmXBATafr4k2PbitJzoxWHAx5o0gOyNJxtFuLAEFGD8MGu1Gg/otX4mIWtPXS6XNg/PvkE8STXE+vsojA5v0eZx76ZUMEu91vvNLsHe/Tpg2wDljL8gF3yWapICfkIXqSsmB731HMKs0ig0wHrOLsBIZmSBw7lPGTvrmmWCG6W9AzW1rWdUurzvatspUO6HVMrJbo3s1/r+8JL39d
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:52:36.3429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de2ac34-73f1-4d49-174f-08ded1264d01
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[212.61.153.66];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7771

> On Fri, Jun 19, 2026 at 09:42:08AM -0500, David Lechner wrote:
> > On 6/19/26 4:00 AM, Paul Geurts wrote:
> > > The device might update channel data while it's read by the host,
> > > providing a data race. Disable the update of the channel stats before
> > > reading the values.
> >
> > This description seems a bit short on details. It looks like this
> > driver doesn't support buffered reads. So if we disable statistics
> > during a direct read, why would we want to enable statistics in
> > the first place?
>
> I believe this patch is initiated by
> "Until a new conversion result is available, previous values can be read from
> the statistics registers. Before reading the statistics registers, set STATS_EN
> to 0 to prevent any updates to this register block."
> from the datasheet.
>
> I would rather like to know if this is IRL problem, or just a datasheet reading
> based code.

This is indeed the part of the datahseet I got the solution from. Our real life
scenario was that the register read from the RECENT register was constantly
flipping between values 0x24F0 and 0x2500. Due to the STATS_EN not being
cleared, we occasionally read 0x2400 and 0x25F0. So this is based on a real
life problem.

>
> > (This driver suffers from the comments say "what" rather than "why"
> > /* Enable statistics and digital window comparator */ so it is hard
> > to say what the original intention was.)
> >
> > Can you explain more what this race condition is about and what
> > happens before the fix vs. after the fix? People generally do this
> > with two columns showing concurrent function calls.
> >
> > It seems to me like disabling statistics would break IIO_CHAN_INFO_PEAK.

I think it indeed could break the PEAK value. But I think the data race is a
bigger issue. I'm not sure using the statistics at all is a good idea for
this device, but I'm also not sure there is another option. TBH, I don't
really have the time now to properly fix all of this. I just saw and
quickly fixed this, and thought it would be good to let you know this is
an issue.

>
> --
> With Best Regards,
> Andy Shevchenko

br,
Paul
