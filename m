Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010093.outbound.protection.outlook.com [52.103.10.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FD41E6D9;
	Tue, 15 Sep 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491637; cv=fail; b=kFhomO9I3ILzxg+w/ndjwZyFcFc8T4JPXtURRb9FIhbHl/IesPWYel/6ilLsOMzRFTwJGdtwAyFXjz3/iMmVYhlrJbx9eIhsieiuiZMifpjnrZ7boaQjqtdhBmpDAYOczj87Dp4y5xq8vq8j//xVpHc1NBbJrYGj3YDTuqeiY6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491637; c=relaxed/simple;
	bh=mQYAaAGzDLIchH4E0COp7ipajqOZAcfNfeSNnpgxOFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qsn6MWyAweB0IvzYIW07U0FjX/S0sG966X6XPDrV1BJkqNaWgM2NXCXtfHfsbUpZSpXcpcyMHcq6GhzMB53UBsFEVaOsBLpOVjai/lmM7PcXgyNcO6ERw1vICihzSaAx+OGwVu8CUF9rjaoR6QSC7bjxMsih5naad3pyxHWFXi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=B4VM4gDT; arc=fail smtp.client-ip=52.103.10.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="B4VM4gDT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeYTPSkByf50/nJSYNL6TD2IvmL6CKlj896DLe2eQY4pYOjQae6FBmop48ESLqr6xWsHcX3VbNAQyIqT65MkieleALYooimPpxQLJaVUM0u15MrEeuBIftTDJ4pK8lI8aL7YnVFNiWCGSTPEAsLqg972bGUCtzwpDks57Ua4dW0cToU8VRuPgJSOuywbI+pi1rYeJ7qhKW/bZ1estEHt6yH0YCTTpGISn+ca4xEKSspdR/NPA49JOvh0MFHyIZPM3ZnXpn/p4ZQVs6Ors1Gyrt7Df/qUM/HqZFkbPQ6+J5JYMd8WkGnyHzL5KGfnicPF6z8FeFeji8Kou3dDZPu0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//x1EHJn9ee6VvZf9OKAA6rPf7oSmUcLjCh+rwHieWI=;
 b=MuNMjOtRNE0/+1IYy/Llb+lXzUArg458rXaU12Xzw1JFJPWJFW1/0z4/z9EQjEX46hw5faMcLpAwND/AwjUd+aGCjGjrgdelqMibBZll1owXBQa6jwBlZNLtg4EYCSKuNX65zdc1g4YiislazgZt6K6iZJnG+SjmamllpdC8W30yAn7ZnKqUs4C66CnqKKzG/xAKqi2uhQm1INJrcA5mCvyOuZGWXBe6uhXPxX3hqv1ZJgmC0z4rCKtXl/VPeR9btuBz9NQRe0WW5CLIGhaaMTz8uF+BAsLyPlsoFkA9y7kXHwDhCUle85cE10mnEkzav1NUMtcNysSTPxF8IvovVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//x1EHJn9ee6VvZf9OKAA6rPf7oSmUcLjCh+rwHieWI=;
 b=B4VM4gDTBtUWa1acZEyWVpzyf641t3nG1FWZXpXDuceEiX5hYL2xGR4O1Egoo5jQ0K0BiuBCQWRcDsfnceMeFs5cZvuRzt47SMWl2kzmEcrBo7nPbsC2BRh72tLzT3FOHu3IpBfqJxZIAKeqVevXUgFPFv9WBkS/Z9TxzJWUXBJNsLJ0jIZWI7Fv0hVFOTTB/Zw3IVu3gTY5JOUfKw4jXxlBbNz54uUWC6olD9GXvRZz49hjgc2ZrKYB541SCvvS1FS2EUmeLUncunsiH0XeQK+GHLDHEgBMAZNgRgTL5daIqX9EWVRu6lTi5MVXrwL1b6HN3U3CneQztg/mLBn0Dw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA0PR19MB4350.namprd19.prod.outlook.com
 (2603:10b6:806:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 17:00:32 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 17:00:32 +0000
Date: Tue, 15 Sep 2026 12:00:28 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linmao Li <lilinmao@kylinos.cn>,
	kernel@axis.com
Subject: Re: [PATCH togreg v4 0/2] iio: imu: inv_icm42607: fix PM error
 handling
Message-ID:
 <PH0PR19MB99733868ECBD2EBDD57833E80BA5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260824035531.141429-1-lilinmao@kylinos.cn>
 <178939644602.1670536.5651900027161221634.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178939644602.1670536.5651900027161221634.b4-review@b4>
X-ClientProxiedBy: DS1PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:8:450::16) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aql5rM0vD6jpmFbU@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SA0PR19MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 94892a18-4f86-4560-824c-08df134ad9f0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|25010399006|25031999004|37011999003|4140399003|24021099003|5072599009|19110799012|8060799015|6090799003|52005399003|2607281247196008|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nSahg2y8+Ec4uuKo4PMhC8h2UJnveZ/8nuDPKc/PM7mfD2mJeNgoxMeHzUmN?=
 =?us-ascii?Q?tfM4dYxvFElzDWuKZDpDtRvrSO8iAjiBK9WHkl5sLducJMWs0VNWPLj2Vaq3?=
 =?us-ascii?Q?mcomd4Vq1dGqB1s0R5o2LkarjFQsTCfKmJ22B9nEuUKoKIXRUOqpeQweAcdP?=
 =?us-ascii?Q?NZA9Ey3UQsO3+s5HNpt0W7hi7bhQudQZ+P45/4Y2GxUsJ/kV1SycQ7GPIITX?=
 =?us-ascii?Q?XSIwKinbIgfxi1I+r4YxYCuqFY3rHVhYarWKZn7kUkwpm2PPa3wmPx861bL1?=
 =?us-ascii?Q?I79jliZe5IB149231w1/noKnrll+YRvLEq5PuLnPA22wIqH9ri6YKNXdPJij?=
 =?us-ascii?Q?0QYmu86rcCRa4UB9nAZ760Ua2DF1hXse0OQF95M9Ap3N098VXIGE9R39CsQO?=
 =?us-ascii?Q?C/Zz2dL0eyZY0gcQsPM6v8OD3kI6KdJ5dJlwRBPllZpnCCogEEJAcgEt50kt?=
 =?us-ascii?Q?stbOq0pYswnnoGvG7X+t85xaVjcs6hQzSGnGRxplSVZ+dwNkYi9WKfUg0eoQ?=
 =?us-ascii?Q?V1XyXp/G1SRdtejhvTewByxAWhnUcubO+QKxSEAMN7eOvum6GiPsJMGufRTg?=
 =?us-ascii?Q?bk+t1rpaXpV7J2yoH4hm7o7u6r3ZG9Lcg2jcALP5gs51e2FH4yHgMsNcB1CB?=
 =?us-ascii?Q?LmKmAI4daGkdA+AybcN/X+LQL3hclUWxtgdIhjfUNzk3okx/ERRFBBDU+NOO?=
 =?us-ascii?Q?IKuR2jV+H6kbj70ZCVFppcrbSg1S4rDwIT30tF7ZSVabXSSY6y5wt7/bslZQ?=
 =?us-ascii?Q?v0FkAWZVLvbOwP/TEMVtF/D6m73ZcQj514sBJqkQL6LPNoU94cZqiJEB5ad/?=
 =?us-ascii?Q?JNErQ6giNZk6pR3j+3fimPEBA04w9V5+SEsgfJbCd7v+52WHOCbAvzHA/TjF?=
 =?us-ascii?Q?Hpr9TpCjsAMQL+D/rdlb5/5AmSD3LZjUqmozb029bHZiNS+ghC4lHUQxh7EL?=
 =?us-ascii?Q?yxo4NGJdFciU5jrfEKlOgrzvJaA3pyMtiVMRSFzG5ljDAGuA5GbZJo5wtwV2?=
 =?us-ascii?Q?6MJSxleXSFY0E93lht5KgbvTmg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?901pDgkG3eymiO3alwYIeZ8avxxJ03ISOKQZu6iaZvGDHSS4ACcwXc9/xeII?=
 =?us-ascii?Q?eOx3w423+5JNkE8N1Ek8jr9nystil2MeB6lpTBrpjjGwnBpn3cpsUqBXVGW4?=
 =?us-ascii?Q?F38xaQxfqDue1hoBEf5bgb1yXbqg0JRkjnsX0iLCvSosL9xWjZYHrQVWgYtt?=
 =?us-ascii?Q?UZ/NmHFfaQyJUGMXezcFCMc1pCQztm/lOi53EGTDgJp9nDepc/3mYWaDO4HX?=
 =?us-ascii?Q?92hrsJIIWJVZQSv/+Sj9jFAcHPNahaG1UjYkeTCjGsLBuQdyaFaHarMZ49uM?=
 =?us-ascii?Q?SoJT9Dws66o5TQaG3dooD4aP4dSFIB5W2TVRmvid3TGnrjTDeqK0YxlMIEKa?=
 =?us-ascii?Q?O59oRHgh2pyhMWMRuRFak+kV4GAQ+0zQ9s9oUI3uz2nZo03wZB94pxpXxw47?=
 =?us-ascii?Q?zjqyeke9i4XfyBshteTBY4p9VGrgUi20DuFED5aAig9QcxTfLFaWpd6UGFcI?=
 =?us-ascii?Q?WTQL5BABlh5eAFDJu0FYHEDYpDvalMPGQHX3VTlG1D3KcCQtjKQPNc+49iq/?=
 =?us-ascii?Q?je2/Vw90F3r9GcogFd1msSXiJ+bTQj6V3iUKjom9GMwAuqGyL/qAB6DcarTr?=
 =?us-ascii?Q?BxNqW5HwRV4Ev62CtB19RlYAg5XhmdG+jSf7jEUGDVTqqqyElHqdxHZfDpRM?=
 =?us-ascii?Q?QmXteQiiCZkBzFMC9OohQ4W3eih6OyO2Rwkf4hoQKEeJxqY+qHeOz6mMv/AY?=
 =?us-ascii?Q?8ccl24xI9onhgMKePOUNNgW2WmXLugSrvTCtao+7iAxYVvnzmhF7ycidEOa/?=
 =?us-ascii?Q?cmd0E17B6qi0cqON8gBfGKYC38vDojIOhvwE9MN7tJC3cm+cd5/xIg+3V/55?=
 =?us-ascii?Q?lUdH5nuslHNyBI6QGG1M9Ege4TtRc+qxRAIs5Bns4H7lvV5eLco+FzfEHXJl?=
 =?us-ascii?Q?Z6SK18+Z2WzJ9vPwzFckJFC0RVqU+GtwTmMGpsVlMCRG250BNqo6QfVAg2t+?=
 =?us-ascii?Q?2O9JpCmBD01zBkacNeaXB8MZVTfiEUwExJHX2A4xVBnaB8Dg2H5cejOOKO2r?=
 =?us-ascii?Q?PpsQkpSMMwxLIHYzufsL1EnFpq3E8oslevQ20WbdL3kosEyA4dzo7hnUhiCL?=
 =?us-ascii?Q?4jjJkTSguVv99rSCwOQEF+oMuw/uQmfWJ+4frppvXgs8vNJ2ASglbrfeZIam?=
 =?us-ascii?Q?wb4p9XpEoRxajyRwWaNAC013qYhJImZTgHjC2gWedbuMo59LZpayU9CCiyJO?=
 =?us-ascii?Q?5vDQ4kG9ArTxkhF9I9BVmsQwP4Kma1MD+rFJqHBTk6UtYNF6ibDm7o53OFIv?=
 =?us-ascii?Q?KtcyvGYwudAZYOZlQYbEgFO5ucIo4ovzPaXOFKhYhypwG7XUcKbiFTpAHt8T?=
 =?us-ascii?Q?IE6GRi7O3uyPPaHhHAnwUMK/EILO2lgx+EThozQu2rOJoKzdMcNiCzooKvB3?=
 =?us-ascii?Q?2+MA2qTL2k5uL6W7tgLMFsvTZ1lq?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 94892a18-4f86-4560-824c-08df134ad9f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:00:31.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4350

On Mon, Sep 14, 2026 at 04:34:06PM +0200, Kanak Shilledar wrote:
> > The recently queued ICM-42607 PM support has two error paths that can leave
> > the PM core's state inconsistent with the device.
> > 
> > Patch 1 propagates sensor shutdown failures from runtime suspend.  Patch 2
> > ensures that system resume restores runtime PM management on both of its
> > error paths, so that a failed resume does not leave runtime PM disabled for
> > good.
> > 
> > Changes since v3:
> > - Patch 1: commit message expanded with the practical effect of the current
> >   behaviour, the cost of propagating the error, and a description of the
> >   recovery path that does not assume a particular regmap bus
> >   implementation.  No code change.
> > - Patch 2: unchanged.
> > 
> > Neither patch was reproduced on hardware; both were found by code
> > inspection.  They were compile-tested with W=1 and checked with smatch.
> > 
> > Whether patch 1 is worth making is still a fair question - it trades a
> > possible idle power leak that may be cleared by a later successful access
> > for a runtime PM error state that needs an explicit reset.  The commit
> > message spells that out; happy to drop it if you would rather not take
> > that trade.
> > 
> > Linmao Li (2):
> >   iio: imu: inv_icm42607: propagate runtime suspend errors
> >   iio: imu: inv_icm42607: restore runtime PM on system resume errors
> > 
> >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 38 ++++++++++++++-----
> >  1 file changed, 29 insertions(+), 9 deletions(-)
> > 
> > base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
> > --
> > 2.25.1
> 
> Tested on Invensense, ICM-42370-P development board. Performed testing
> with basic r/w to the device and checking the PM runtime status. It
> worked as expeted.
> 
> Tested-by: Kanak Shilledar <kanak.shilledar@axis.com>
> 
> -- 
> Kanak Shilledar <kanak.shilledar@axis.com>

Sorry, I've been a bit busy with back-to-school stuff this month for my
kids. I've tested these patches and do not see any problems with them on
my device. Note though that I didn't observe any errors prior, but I can
at least confirm this doesn't appear to introduce new ones.

Thank you,
Chris

Tested-by: Chris Morgan <macromorgan@hotmail.com>
