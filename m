Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D659B68E;
	Thu, 17 Sep 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655913; cv=fail; b=r3jt5+XPKbKaPVJNu8Qc/hvgWRbcnm7h1/8ldzfaSZqN8Je84ZpEaxDtjNsn2f9y72hcc40NJgDIxvq2guuolloAfLqXHPQHfhmuaJhAcRPL9hn9lSkv59Y0waTfnRoW7qYsZfymy96E+B33h4Z2lnUopiG4Dh1Z2ktQSzvop7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655913; c=relaxed/simple;
	bh=6J+SlQ/kPHzFZHXCR3Xn155bPTySTcNpL2/4FblsABU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTj1oSUHhUWirhEDw5ESaGpB4zStEjgoiEz+afUfOdmwZxGdWG0LhQkcwI7Huk97aGpciUZh4XtdF9RBh6vp5rHkBQ5doozULuFL+bSYOnLMNBI8W1ALwKyUe6nzMz9Ng8tH2PnFf0aedzY1Cy1Jn6hC4dVskTyP+CW2vYB729k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=p87bhFwn reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p87bhFwn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDxocd1Gil6GTQsi3jfAif3NpVCqGlZVvPpR4LciYBLL2LGYiIeF+qGzltp3HlfrqnKXYiJVOYBmlozRtNVne8aKHDJx32ql5nBmd4HC2znCZwxLSr0Z2enKiPttRU4NRLx/9B5XDElfrKEGRhcEXaZrYB6zVFpS6/shyufuynbY5UwY7MVbZ7p9J2E+aGSZjCIdeV/qjy/4ozLJsvEqgTAqnHO8fOmiGA6GvR7hM11GqaCc8K5xEcInfeXcmReSYT5uJriG9R7VIF4DYQVdEkuqi4BWnHxjU9/MKLecfjM4z2xzUvw0lCP6fbN5XcU3qLPFJzBzPaqlylDMaXM/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsy/gm8Pyeq95oeZmgUTPC0eC1lcM6Hj/7wbHYEelvw=;
 b=czhpA4MExWMzcFcn/l6Esi8+2sBaRi/+xEbZzwa0NkiOlj6sshs2QchRBJx/Yo0oEcsYEKTU7HvvLglCo3fMV2Hy3AbcXnSFWLV+tkJc9cYFERAblfC7Tl1x1uOMYMIOH8EXsZOwd0R3IRAGP7RsCeZntAuiNK48+6SogHyqWgE1gBT12E0HZsoRGdWVpsACmqyP5HRIif/KjDV65c/XWvzslGRiSrVGI1rPBrhqqWnqWznI098XTmIu2Gnr/oi1aaZSSzr0h9MtiEdM6np723umtV8MdEC6x79/Gfp+3v0aIzrIu0ng5/Rb2XJXG7z2T3Dbx9r6ktD7oW01fDO8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsy/gm8Pyeq95oeZmgUTPC0eC1lcM6Hj/7wbHYEelvw=;
 b=p87bhFwnak7Taj6esGM+RlYnZ3jGSVnuPfgJBg6LGcGmykZUjM/VfRPoPOiuYjgqkqRjCQ3M9sklF8mUrHhZ9lfOLI9h/maco71fJoXyxr2IrC+FZShuBLhLSrbq5whuU0++JYBQPRnvfoNt9nw5wjXOTqs3KXrS9MAXLREaE111FqbbM6AvlipUFWXTx2RtSogrXf7aIIH/hty9/eN/pOXyhmTXFvFpLKu8ScizJHC9KxYlm3VQ8h7Y+XhGzSTqeeT/WfJnJy/LwqvSttxMgs41dAR3JwXvgvkenGN2uHwpY/ASC0k/HKWwZz2i1YNDCkKYGZXVCRThNnIvWng8Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 14:38:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 14:38:26 +0000
Date: Thu, 17 Sep 2026 09:38:15 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqv7V0E5GObzw9l0@SMW015318>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlYOHIFU_dB72I3@SMW015318>
 <aqvFFg5Uh1cXln0y@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqvFFg5Uh1cXln0y@nsa>
X-ClientProxiedBy: CYZPR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:930:8c::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: c68591ff-0806-4829-f87e-08df14c95520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|19092799006|366016|376014|18002099003|22082099003|5023799004|11063799006|56012099006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	D0qZEjIxGVrI42sj6hC7muSgGqF7F7o7YzKGfXvX5rRcVLohq3vulj9QDYn2+ZhLLoL6TGWhVgFhyZWPjruqqQHrSZGK1qbRd1XxYZNPrTpf6WICU9tL5Pwep9lnStcKQxiV7QDtCNFJMgg0PCizSqOqKW2Xc7w/ZHpOJi4eDO71BPn2fNycrcc/XJv1BkaUxHQj3CvQt5mq4RI7xTm0wLIcyOY1vge3P+axbN4Zhbbv4WwFfkMLeAwx5g981Ik2BmKk0bIciqBJl0QXFns1cf6A7rNqgUQrZYKdhiUFwhxGqbhdInFeb4tC1Bvd9J8nXvUgLExtsujwO3LoQPxzuzFNQ5VfJydOUCiE9Px8z4u4uFMuatPFOFBK4WH7si9mok/cFig0Ap7WkMewrafkMvyRvTiQd9E6bfACfnrQT34kCXxL7it6VtfxB+fApY4y5otfY8a3h/J2bOvavJKagP3tkyPv29Iux4fuLrKGy2VE62pY324eptETe0OF4u2b0okOl3lTJnMIxI3gXMHT+IwI5/EcqmLoBeNfTtWOs9aJxem8uN57J0zFbyojQlNXp+lpEL2snY5+kUxFNk952e5t2ICYB8XwFKb32UMDYCRv8VK65zNcwfva9EPcuMcSq2tdBWQ32LQTi0PUSwRCUzxaGXewztCFj3wLoRsW+pk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(19092799006)(366016)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?lLg3kbAwP27c4DNU2M6V2potYRQajpV0Us3mDHnFxHu24nTR++IdYfEXbq?=
 =?iso-8859-1?Q?exUtWVC9d0LKR2p2dRtLRWCm+BFOC/e0noFWGmDFptE72kS3pseJc/jkMj?=
 =?iso-8859-1?Q?T3gJL796ins7vc7oGWS12v7w5+tMNaqohlVtdKqDef1al4kQgJL1HUO2j5?=
 =?iso-8859-1?Q?22QqzHRKhYRj/Fw3v3uYgXApnwpDHCaeMN1UrhVNyv/E75sfKTT1/XTb2o?=
 =?iso-8859-1?Q?Iae7T99dMGT88fiomdwlWzskB4DXe2ldLTXQYGYLeorIMj/vPDOe7h0LJY?=
 =?iso-8859-1?Q?hDhqPyV0+hPJKvz01j5CT5fc/OvLB24ETogpa/STZHxdKn3bsU8Wld9ubq?=
 =?iso-8859-1?Q?OoJ9AOhdI+N9UfCOWMktnw/NqujUifX8ax65zg4+sDI2XY928ovQXw2piP?=
 =?iso-8859-1?Q?NJPMBdKfTQlnRA8VZ0SlSlLiCzCerBLGrcX/kDgzK2WhmVc4JfSzjxRI21?=
 =?iso-8859-1?Q?6zVEjFtI86ZJxe3TJu1P8wkURVb+mi6KHlKMeHy0PzNOT3JdEy8tWPr+vE?=
 =?iso-8859-1?Q?SdD5KTto7tzIELBtZ+xIWylMqhsKXCAiZNogCniO5BDwvqRPEV1Z8UKRU8?=
 =?iso-8859-1?Q?S6PmhbpOhJUMj/99+FTCBR5NejndArd3O1N8HauQsvKpbCfwNSPF9tJpDw?=
 =?iso-8859-1?Q?f+k7zVsfbDFIfYuK7S09a1sHy1/FfyvAs9PjRqKThSs5Z2Kb2O6JkdHH0A?=
 =?iso-8859-1?Q?Qt7gu5DuS7ZtzM3cCVZzUbZcVjj/sbuEEUcv5KxZRpvxAqBlEDf7ANJuPx?=
 =?iso-8859-1?Q?oxcKN8qCKN93QEqrO+HJGYA6/Y7vGE/RmAOze25dg0BO6HE61CmYT7TiLL?=
 =?iso-8859-1?Q?4ibympKSK8tlwu4Nj4pkV0dCeXYdHN0/Amf486FY1bEBRaN0UDN729Uics?=
 =?iso-8859-1?Q?ogVBvK21KAapikKt0aEk80DYSRZ6hZcw4rF61h/K5vOiDHh1e2mXY8S4/J?=
 =?iso-8859-1?Q?FOEI7Bi5/HsXwOGENIHFzTdA5OWyBNKnDCQn9EK8u31/MPwAekKQ4G/iza?=
 =?iso-8859-1?Q?/v2gSna+9kdaVjiwBzrv+cmx8G1SEbvU2E1JoteFRvpvvD/YoJ2xMNJcVT?=
 =?iso-8859-1?Q?R6ocKm43ARSPRhMjrhGmv9dU4JQrQZX8AWdiGAmJjQ+sX0cjQmlMggMDrb?=
 =?iso-8859-1?Q?zKWZMjJ2aIWI5xHZbed7OyJxH9mtxwq/gVDLTGDec5LCNSdXLRTAvfPR1g?=
 =?iso-8859-1?Q?MZ0BgRwbdrDBTW2X2yK7qhs68ll1X8F5JH1W3V7FgFfVnL/t+mIn8d/REa?=
 =?iso-8859-1?Q?nw6B7Kt+z86mQZs3PAwUjPE2dNFjpXa9MZpbSo47sXnG7S+Zlfk4EQejjI?=
 =?iso-8859-1?Q?PcnwrdXUsuaBPlB0rCBhlouGtAu/WacmVmmDqAKEWp+DO7J0/s2fuiYoMf?=
 =?iso-8859-1?Q?6kXx6ZEuevOMriMnZCSBTGdtYOuzehj1rKU7yX07Nlj9CDavd0jDsIS5f/?=
 =?iso-8859-1?Q?4keCmoI2c4TMoRBLkC1LtbnmHiCHSqKMKJJa3w4uZQlM29prnq1gSUEREG?=
 =?iso-8859-1?Q?Pfg8AZlUiI5tYKZ7SIETEqkPTiUfy5BhKdtlbQqBHzoMRHVrKpo7z0c6X2?=
 =?iso-8859-1?Q?loHhkVFEJypQ8uKOGckLbUPTYgWh1G6rcm6Ay5NBDBFD1eIAMWiZdFKR0/?=
 =?iso-8859-1?Q?8oPUXFAHSQhLpMUIRAva9BYUdzVrxd2koOQ0Fb9stdcnXGFyZNRdV60yJI?=
 =?iso-8859-1?Q?s0GRxPYF6PYDCziRJc+HwYr14V6DhV7P76S/8MNKkFT13Zbzijt58NDD7r?=
 =?iso-8859-1?Q?vrIiZGrqDwXfY2NnK2fT4GfZGFudJwm8cGJIsBajxCeM11VuM2jEGFGaJo?=
 =?iso-8859-1?Q?vCKzW2B0JXT1ABgijqpGLW1Mas+uR824iiZ7I7dhA5W7bUKpptFj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68591ff-0806-4829-f87e-08df14c95520
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:38:26.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNMkonIogOoZ4phRPw3zavo6YCCmj01g2OTPxUgES8wbR7vs4OmYHwjbAduSuuJk46/I7ATDravDahlhEkk2xq9fbPle8ChjXMkiyt9QwVn7gxsZl5L3M1Qi1DvzNfsZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968

On Thu, Sep 17, 2026 at 11:49:46AM +0100, Nuno Sá wrote:
> On Tue, Sep 15, 2026 at 09:37:44AM -0500, Frank Li wrote:
> > On Tue, Sep 15, 2026 at 10:29:03AM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > > > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > > > > In preparation for the bitmap based bus width capabilities, move
> > > > > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > > > > include/linux/dma/engine/types.h.
> > > > >
> > > > > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > > > > new interface would make every one of its users pay for it. Keeping the
> > > > > basic types in a separate header lets the new interface live next to it
> > > > > without that cost. linux/dmaengine.h includes the new header, so its
> > > > > users are unaffected.
> > > > >
> > > > > While at it, add the missing kernel-doc for the enum members. The block
> > > > > already opened with /**, so kernel-doc expected every member to be
> > > > > described and warned about each one of them. Describe the UNDEFINED case
> > > > > in particular, as its meaning depends on where the value is used.
> > >
> > > ...
> > >
> > > > >  include/linux/dmaengine.h        | 20 +++-----------------
> > > >
> > > > I think it is good to split dmengine consumer and provider header files to
> > > > hidden dmaengine's detail.
> > >
> > > It's indeed desirable change. but isn't it a bit out of scope of the series?
> > > I suggest to do one step at a time. Would it work for you?
> >
> > Yes, but I hope the file name is finial expected file name. it is okay
> > just move enum dma_slave_buswidth to there now.
>
> Hi Frank, if I understood you, you mean to have an engine.h as kind of a
> consumer and have enum dma_slave_buswidth on it?

yes,

>
> If so, note that enum is used both by consumers and providers so having
> them in types kind of header makes sense to me. Kind of the same as with
> the new widthmask header. It's used by both.

Yes, generally, provider include consumer's header files.

suppose detail dmaengine implement should be hidden in provider header
files.

consumer is just subset by use provide APIs. It takes time to implement it
but can start work from enum dma_slave_buswidth.

Just choose good filenames now, avoid rename letter.

ideally, As vnod said include/linux/dmaengine.h is consumer header file.
drivers/dma/dmaegine.h as providers.

but some dmaengine driver outside drivers/dma/ directory.

Maybe we use

include/linux/dmaengine_consumer.h as start.  wait for vnod to comments.

Frank

>
> - Nuno Sá
>
> >
> > Frank
> >
> > >
> > > > suggest name
> > > > 	dma/engine.h
> > > >
> > > > so we can start move more API to this files.
> > > >
> > > > after all user include this consumer header file,  old
> > > > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > > > which only include by dmaengine drivers.
> > >
> > > Traditional naming would be
> > > dma/engine/provider.h
> > > dma/engine/consumer.h
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
