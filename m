Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E4238C16;
	Mon, 21 Sep 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007170; cv=fail; b=QFi8NGBDiDXYQi9zm6PbP03hxy4mzFJwLvV2cEb0uyJOE4vFKyWFRPQzsPrQKMbrhyOg2lxmymXtI7vb1JM8puRvodgBi5ORrb1zHwWLTV/5Y7JDzWWpVJUS3Oy14CC36v0BilrvW5YgLP9U1HQq7CJSAelUBpZfzMaRMdcUiVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007170; c=relaxed/simple;
	bh=vbWOugetJqIk0KvA7v0JKmV5fdp/VvcsfKbik1LxNik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AWTE4jkvq2WSmyVJ5vbw5nQFm4rnwyAFRphjA0g+N2C4LUQTFao9nK156bMt1iHXIVO4onn7oYQKFVmKEHHUcyA1OSyDm/OwUZW6MHCE9hGQb8uRcw+/voup9a9l9emxLt+cujHTuCEfZkp0nEkq0DzEuY1G0FVZl7br3ZRU2hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S2Y1uQAk reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S2Y1uQAk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6cjvh48FC/MnJWb3ONk4a9nLKN6sSnP3DZKXYNNDPWyeTDEDkSTsSXXx7CN9praCgX3nmgfm/eFHYi7kT7jag8ZeLC/0ohisBpi0/SpDaHyf0OHmlt3jRdeN0ni3SXQDBQizTspRq7d1FOegrWEXe1bqdn/m+JhxwLJK0qgCQkU0L00mD7OY+MGd5OxoFia/lBj4jeb/TRLokvy021ZnT7dsddMRj6mLwVnFSPHqeE4Hl6T/dPp5rJhh841HbdE5B5MVzG8QH6qMHFNvAdENy1PFoT2FjK1sAckM6qn9EUJ7VPdHst/7r+EMJr0d3r6jZacFKaqqyDmj/xklmyMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9+xnx6EtfJ8oLlhNZnAg8LxHBXlWFsK5ue5T4aGatE=;
 b=pzvjFEI3CiUkd1/2CsUW6A2M5yJIW3dLe2RLvGYt2P5vloP3wc2bkH6y/qK/Y4hV6U9ezzc4HuNvb5nGCFkIHTzpuqsA/Z3mgUytzu4kXl78cBp38PvEA48D2S2ln1oLNlb65m2LyOfB0KDliV16LItDu6n2C3vocSKfC5NSTpZZsXA8of+U6PhLXzfCXDbuYCVryS8R2McIzi526tgGAKD8IhKozTPuHfik0UmFTkUS91cqKKBubzOzaIZh1GaHqWQzkd6eIsvAxJz3hAxg2i6TxRjMTKsQLgZ/9ml1V0/OcQpdD6mH8TOIo4ZXMuM/croSKHk/t2//EeoiS4oIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9+xnx6EtfJ8oLlhNZnAg8LxHBXlWFsK5ue5T4aGatE=;
 b=S2Y1uQAkFmkf4vTtWizpQSiN4fiVkYfhZ7l/bxZEOPnli/kRFEhPHLerV8R/yWYifYxQ8ja7tfJSdqa6JDku8pKtxbhu8zhHUNnZMqZ0kp2aFJgF/GVLbWPZxd51Am9BAFxeRjJFck5mmfYReC69vCtotaqyd2WzNXW5diOOlQPdkqpQsruFeiCWPecrm2dn9HGXRMwTqiYYmuUMPWPjf1P7bzjEFzx//WIa4Vh9RPLWx09gazVUlEMRYW7xzZmWtN0DPfpu5sM7lgmtDkI4VRN2t1G90MeXXZwn1Tz9XocwNFqn17DGij5yeyBLR/sJWOvu1heCekb2531Xlj4h4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUYPR04MB12668.eurprd04.prod.outlook.com (2603:10a6:10:660::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:12:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:12:46 +0000
Date: Mon, 21 Sep 2026 11:12:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>,
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
Message-ID: <arFXc0LqEpgWSS6m@SMW015318>
References: <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
 <aqz1-OzFobOROuBw@nsa>
 <aq18_TMNs4EJzgZO@parshuram>
 <arDtEB0na9DxDWAS@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arDtEB0na9DxDWAS@nsa>
X-ClientProxiedBy: CY5P221CA0154.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:6a::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUYPR04MB12668:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7d4457-2777-45ac-9b30-08df17fb2c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ashmVz3oRXQG1gXgFr5GSqtAYYEJe1XHiR/ifyT3rcrg1Lplw5Wo8JW3nt5cBxpgsFhYYxRR0q7A0XNhYgQEZSMRzDauYJfITJllertuIjwyNn+Uwgu5+mus5GfrYfd+MF2o+3F8AGJbZDTtBCxVBZJyVeIJwOeaMFk2Ri0fmJGhz9qYWOEb29YzeEEY9AapuDIaEd95WkWwt7JZqkLuo3VlOHOkF28EJ9pHuK/ATQkh7Otf+nlF5+tWxjpjftbNDnzLrXpe1uCaKu0L6s0zWFfGDuk/dpa7YVyoW5m5pa5KPTtCeVoVOq7fLvw0v08DmB4BMZOFLu7LuqRPP4C44SXstAhyQAP+zyDW5G3R7/WR5COzc2kxOUBR1hO9l5iFZK0EmEJcbHQKth2qcUm598YJOAbCsSanV2Dyxzq05wE4YiSQ5SyGxeLZnIQL0LaciMchDqtTzD6VAT+zyIYF3jYUF0XfY2ZeH+wU9Hi8BLSN11NnSSoC99fQFNzaI3kMGwE811CAyeMF0JkQAXYhHXyW3a5H1P8PRWYbSGOdEz3GgCPqFBctHpRkv7/cRhlXsNH99b2jRcE1ZV1T/s9EQbhvGRx/5fh7aSs7Bb8Cx9BbAOte4EpUBUm1mKhxRoRxdDh8gPGCckfwsCnfBY49OnwAWkWeFIuA6ukqL9blico=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?9y482wELgf+nbdkx45cytNSv6V/WDEv6kB7HOMw8klEzCWXAOUaAxp58dt?=
 =?iso-8859-1?Q?mx6+puNVN+vsC/PqZltCpKw7Isn+NTrHozVJgm9cX+p0q0XHP9FH5hkUdj?=
 =?iso-8859-1?Q?D402QAtr7cNIDKjGNdHsyI0chuxxX8vBFea/1r0x5bg2bF5LnaQa2OeW8J?=
 =?iso-8859-1?Q?zv4vUGaHVPKmJ0CPbcYniDDDtfZeljjdI08fLE8FnqGZ0wbWgcmVXIzVZJ?=
 =?iso-8859-1?Q?qOdiI2v6uIH0pLQKkBRSFci7g2GADh5nhhK/HwtBwn/VQH/ButxbB0oAuv?=
 =?iso-8859-1?Q?e8Q5wBHe9k+BHkRWQpTodIknEhVoQy/y9W7O9/MQDjKCs+bCL24e3+fEeM?=
 =?iso-8859-1?Q?bosGqqyxT0C+shbIVAt9z2WkYlC7TZ6KPkQVAd786hwwS/l85XqXObDrk+?=
 =?iso-8859-1?Q?XHjjN47Eer//sZx1aTM9wjCYfaBwGcy7v79IJMMvwB0P5ZYikjtGoGyokX?=
 =?iso-8859-1?Q?n1vQVz1pCFFJyGiFNmbtVKyataFV8VLOjQ0aQdi8b9RzDR2ukwna+aAzr4?=
 =?iso-8859-1?Q?78mgGiN8QfTC5XcruZ4+HE8RmhmFzcXE3QC8iC1xCLUUhRBxXknZe78e16?=
 =?iso-8859-1?Q?jCHTrd72mP6MKzodbNPJZwGru9cPCSnL6Lyc5bbPi6jA92VemTq7X2uH4X?=
 =?iso-8859-1?Q?TIehTh+tWjX/vsU0IFlCBgJamUgwOo3oWCZI4X9gi/JFG4YZEui5aNkaEZ?=
 =?iso-8859-1?Q?0J9Pp1To+7m7srmuVbPNItGvcaSAlPFmAr2p+xvdYwrc4kH+dnz3vZAuIC?=
 =?iso-8859-1?Q?l57blHngFcis+KA0dLRQyb0nFE6j4kNlU1IPoWWlQ60zzdbPkHCmcN2QOG?=
 =?iso-8859-1?Q?0F5HqRqvWjQ4fjE/2xhvdwFab2Y3Q4MuKcC6G6KB4+5aGjan0dMwSydUZd?=
 =?iso-8859-1?Q?lgR98ha+hLA3JbTmeMJgRtC5vBttQnMUNJqPwVJFlTlvnmX+mN4HcjyOge?=
 =?iso-8859-1?Q?FlBFjQNcBTM/fvQeje1nCU4o0RKZsZPFIYH8gxfP6qCFzzYIKw8lSSNKa1?=
 =?iso-8859-1?Q?e+Xn3VFY+DopCwf66D92LtnvyK2S/bwkg9kBxcvfYXetkMonUCX/NuH1YA?=
 =?iso-8859-1?Q?I2HgppI7jMROuyK+w0fmfZRs5ZeHB2G/UzJX5U5aT6qm9oUYM5ZR2iW3lu?=
 =?iso-8859-1?Q?AkqCeJ5ir2S7zMPytPDvpnJI/AJviFFFsrP8x3t9l4p4PL7m2rete0qr06?=
 =?iso-8859-1?Q?Q5ZORDYespVsKPSa5Zh9NVEj9xD5NCRn3YueHbawh9WNOQSRroUMpVs9Xi?=
 =?iso-8859-1?Q?SbZzvn2BzePyvzs4IwSW55OueHiA3rU/F6nqLKvGEMCiC048R5imQKB1NP?=
 =?iso-8859-1?Q?uo6sZ9tih1TNBzqzGGrCDIYX2xJKpVbwj9kAeudsbWuZV3gOWfmBm/uYsh?=
 =?iso-8859-1?Q?gIIAoZjSHGJe7kw7yRaHviUC8m5MCM6Z2BH9BmvUyquxj+pRiaDXLpu3JZ?=
 =?iso-8859-1?Q?ftdvlgpqg6XjxZv5XIYaN/CRX4q/iZ81aIQzRZHaV2pJz2h2f7DeVvE+2c?=
 =?iso-8859-1?Q?iAs6GxG8ARomw7IbpLcxM4wL2tb8X8X7wQBxCKGnaPsklG0Fsr00/nyE+v?=
 =?iso-8859-1?Q?M1MsVhESG48D6dXBhD/OtRu6Y/PCHqgO2Bs0SWhPc/mqPzJsMZ3wWjjVdx?=
 =?iso-8859-1?Q?R9lAhOUbpq9pVt+9PJw9E0M4upUVZcPDWUb81rM2evpnAs0jy69zVfwJoZ?=
 =?iso-8859-1?Q?3PII12ROrwbz1y1j0DuMSj1rNBC/3YVFtfxJR2fxZtcFXe0et7RieoVDtz?=
 =?iso-8859-1?Q?SR5M+KRrUmDiVNLeecNGoyFRfnDIeNrk4ctkebWRImaKN+783vID5z1waQ?=
 =?iso-8859-1?Q?bXRFuDaQPOPHcJYABqLGk4LoJbU7O3lx82l2DgZ3cg6HZJJUoMqa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7d4457-2777-45ac-9b30-08df17fb2c7c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:12:46.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaCDyAo0rlBl2FAsPVSHwEtn2E3ubXAlh4TicmiRpijEIpMWwI62pI8htOHed001BjntkjZiectcX17iiFfqRqiC92w6uHwiw4YT78r1CVh0mj4SQyCfbE9hFxZjiHxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12668

On Mon, Sep 21, 2026 at 09:53:49AM +0100, Nuno Sá wrote:
> On Fri, Sep 18, 2026 at 11:33:41PM +0530, Vinod Koul wrote:
> > On 18-09-26, 09:39, Nuno Sá wrote:
> > > On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> > > > On 15-09-26, 12:04, Frank Li wrote:
> > > > > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > > > > On 15-09-26, 21:22, Vinod Koul wrote:
> > > >
> > > > > > > > Traditional naming would be
> > > > > > > > dma/engine/provider.h
> > > > > > > > dma/engine/consumer.h
> > > > > > >
> > > > > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > > > > everywhere please. dma causes confusion already!
> > > > > >
> > > > > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > > > >
> > > > > There some dmaengine code outside drivers/dma directory, like
> > > > > drivers/crypto/ccp/ccp-dmaengine.c
> > > >
> > > > They chose to be outside, their choice... They need to be updated as
> > > > well to point to ../../dma/dmaengine.h :-)
> > >
> > > I tend to agree with Andy but anyways. I feel this is going a bit out of
> > > scope now. So what we have now in the series is:
> > >
> > >
> > > - include/linux/dmaengine.h (without enum dma_slave_buswidth)
> > > - include/linux/dma/types.h (with enum dma_slave_buswidth and new
> > >   dma_buswidth_t type) - A future one would be dma_cap_mask_t and we could
> > >   drop bitmap.h from dmaengine.h
> > > - include/linux/dma/widthmask.h - The new bitmap based API for bus_width
> > >
> > > I kind like the separation (and the whole point was to avoid bitmap.h in
> > > the main dmaengine.h API) but tbh I'm not sure if a consumer driver
> > > will ever use dma/widthmask.h without needing the consumer API. But
> > > to sum things up, what do you suggest for vÛE?
> > >
> > > * include/linux/dmaengine.h as the consumer API and includes the new
> > > the widthmask API
> > > * provider/private goes to drivers/dma/dmaengine.h and just includes
> > > include/linux/dmaengine.h as the starting point?
> > >
> > > Let me know how do you want things for v5
> >
> > Yes lets talk about dma_slave_buswidth, it is client type. This is
> > configured by users to set the width of peripheral.
> > So this needs to be in the include/linux/dmaengine.h
> >
>
> Agreed! But providers also need to set the allowed bus mask. And I'm
> just not sure they need to include/consume all of the consumer API.
> Also, it's common to allow the provider API to be widely used throughout
> the kernel (but I agree that could be even harder to get done - if we
> want to make some stuff really private - but I guess that could be done
> in a second step or more incrementally). We do also have some subfolders
> in `drivers/dma` which means we'll need the odd "../dmaengine.h" relative
> include which I do not love tbh (on top of the crypto stuff).
>
> I really think something like the below would be more appropriate (if we
> just want the provider/consumer API without further splitting like the
> types.h and widthmak.h in this version):
>
> include/linux/dmaengine.h - provider API (as of today)
> include/linux/dmaengine-consumer.h
>
> But anyways, if you or Frank do not object in the next few days, I'll
> take the above approach suggested by Vinod:
>
> drivers/dma/dmaengine.h - provider
> include/linux/dmaengine.h - consumer

It think it is fine.

Frank

>
> - Nuno Sá
>
> > --
> > ~Vinod
