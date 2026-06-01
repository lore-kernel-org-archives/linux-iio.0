Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011024.outbound.protection.outlook.com [52.103.14.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B411A23A6;
	Mon,  1 Jun 2026 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278248; cv=fail; b=ZArGbnUiShXtLM5JAvieZ0foiDyOXtM+XtZXiTbXZH/ZUw0tTudIgr0+i5XJs8NVOJ22wIcXZwrIa1d7KQd90sxP/pS3lYl/eB/6owth3E0H9T+HIjHsugU7HR8fT+49XjpwKfI3pQ1GraY1b2xycxyO6IuxMXt06jZcvfZVWGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278248; c=relaxed/simple;
	bh=2cVDZEfkp3zyxRnfhu4LKJJVRgDGwmqOiUx4kQ3sg/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U7LueaD1fgIfRvy4DZYTBMmHfOTjHpbcJq/A24y3gnb1hW9QPnvfgUWrVeBtk3RzGl9K4o8iWUCNS1bij7l4q8WbKubGOwuV/mJ+njNj/VHGrUqF8SAC7fhGczSY+kc7cPEWpOgkW4boWBn+qYR2FrB2o2KogGeK9ttT/zFcX+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=kBkdhK4D; arc=fail smtp.client-ip=52.103.14.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="kBkdhK4D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaELRxc4T12XmQNy2IdKmlayxyQELp+H1fraXGLsBqS/zUv90eYhJyhSINH3X8nIoRQzU9L0hJMMzVhWgiCLohscOgbo9U/5Qt83/88pxI529xN9MMZZ2qRME2nm/itRF83zJycaqepITkGaF2R/9Sbo0SF7lRTF13peAeooC6NXSjADbN2dcW3I/Clcah2jjHG0jIr6tizZFNB9JqjQZavUYobu1iEILZRireAPmZaldzcF27Bx/oKCMkpWAjkvfpEdPvJ/q20xDpj+38SrviWiyi5jVC7c9oj/zUmKfZm5sXYu6381kSrVvvjVqpNbrcvBlz9PtVQf6kWk8rNlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYLq4queA5MFmA2ugNsp9/8cJASKyZ3ZabFaTDA+mdE=;
 b=kldVAkyDVF7HFTuvh3svbVMfmKaslo6TX3eq35cd4E7B9DhTTm7RcoWRwdPUJtftdSPnFS/JEMux5JFldj8CCSNUTRLpJO+YAyeR72kk7jUBzMVtCizblIb9DiE5jugA34TAkNOKLKautj+FNkZ1gGe+h4HlCacgGYRyDtqZdGf3J4Wo2/3JKu9wOmp+UecynBnuyAghYoezytMHOkOw6/F88D7wazgERB/XI/mdOQ/kGYBkLO5Yrbs07cFPqNqxnIppJWBOuHDn81kzUao2WdXMQKVEv0pBZEXfsFSIgxZrty4U9AmscM/w4ZhbC8+X1IXiExJbUKc3X7SNkg13uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYLq4queA5MFmA2ugNsp9/8cJASKyZ3ZabFaTDA+mdE=;
 b=kBkdhK4DZpVQtc6P++3lh1wvk6Tvxj5cUn37X+omxqt0HskXorwmAr5Zpiiu83ns4TBJDdGDdmAwdJDROHNFnIb0wbMuPdEBCttygOIJFZoNxo/0M8NRpOY1Hclley+1vN0vjBM/s8zxuSW5PN7RRYYubeKzYWRYF67G9iCWc92hgS/kC0Q3mdezFgu+5fPnm6PrhHSuMv8oIBH3Sf5jNDBTemiQwdU5/PB4hyszMPO9VDgrmLQ7f2qelEn07qzGVVcN4sAsft9CZkNgfrttMSUmC0zIssiykW3OnuXIqWDR8lo/ce0Ctjtjp0i2/9ukQFeUDb6pXNz0XYd+6aXyIw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CO1PR19MB5189.namprd19.prod.outlook.com
 (2603:10b6:303:f2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 01:44:04 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 01:44:04 +0000
Date: Sun, 31 May 2026 20:44:03 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V9 02/11] dt-bindings: iio: imu: icm42600: Add icm42607
 binding
Message-ID:
 <PH0PR19MB9973385EBACD2645B8845DE4F2A5152@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
 <20260530031739.109063-3-macroalpha82@gmail.com>
 <20260530-certain-goose-from-neptune-96e8ae@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530-certain-goose-from-neptune-96e8ae@quoll>
X-ClientProxiedBy: SA9PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:21::30) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ahzj4zLt5P9PnbUQ@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CO1PR19MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0953d6ac-7720-49cb-7131-08debf7f42f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|6090799003|5072599009|25031999004|51005399006|37011999003|23021999003|19110799012|8060799015|15080799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ScrzT4p3oB3IIvPwfh1DbqpfknskgAuj1mjjA68GCXXlZy4v1qk5XWGlR4nJ?=
 =?us-ascii?Q?pY1VUJpJAe33Pq3zxneWnRN53R3wq8fLhGGwTNW1I4EoUCzXlPAISBHZYnja?=
 =?us-ascii?Q?06dPaAdFB4zHr05EPb9DLSNrAOoExuFMXjiI6VDZFVaQUHEskMCWPsLLn+Cf?=
 =?us-ascii?Q?4SuY++ikYgcbdx0ndXDp8IvYs+D9Bp8UOQR43oipS2LCB/7AesASle3uo1ks?=
 =?us-ascii?Q?80Nes2ionq3Pnuf1z8cFkq/v2EKJh2SPEFcA6CbbME2Pxtkd+HV67B4Oc69P?=
 =?us-ascii?Q?HOYZxwpWR57olmIdIYdGLU71YdDn8iwkON63L/gtHQrrjtyENnY121NlOQ5/?=
 =?us-ascii?Q?M8h5SLjdl4+BrvWpkFfqpDGZVNL2Iscij5KuD8UuGJv2QfcL9rK3IqJ07qQM?=
 =?us-ascii?Q?dVadvye5LjqM6hih6dyJxD7wIzhLV2IglmMlcyW+S/OKUrF0QD4mDis1BuHz?=
 =?us-ascii?Q?cODETAXE2gw6CK16QxL+BUQeeCmp1OEANni9j9Mbk92Whj7106yxE0mQx1RU?=
 =?us-ascii?Q?r2gtrFLZflvos8OFVz1WZEDGhx/HYPk8iksgiX4a/yJAZkscMsgVn7GxdKrw?=
 =?us-ascii?Q?n05FzoHqxTX7i49gq8LFIo/JWEaXClT5WfePpAAc9nB6ME1/aZzgL2aXurxB?=
 =?us-ascii?Q?eXBC93EhxLcT1Bxu3bpIXF0fW7KcNolguFVztCLJjjQFnUEk4H/Dg93YnnXC?=
 =?us-ascii?Q?X7jQqUsAPvOFG9JYpW1ijxXJ4chlp8cdAUtMy1S15ZtBvhEBVJGEiqC44S1M?=
 =?us-ascii?Q?McO99eDNxKcXjWW5jKw55ye9CcEgoMFAClGuTdD3H603sP8aVi9aK4ZjTSRy?=
 =?us-ascii?Q?hw2jFaikiT3Z06b1aD1iTvFXJ33B6FTbCFtKwiAHdWtljAp/kXaOBvjv3bIw?=
 =?us-ascii?Q?wx6R/3fmAKoRGwDpp2xa7lGzgshd2ZcUHEFMfJAp08BtKHYXmL5ER5iDItYc?=
 =?us-ascii?Q?MCwR48wrNbY8xxjDvbzMp1cd4Dqo4C8znvzIjD77qQBCTp6ywv0tZg6e/eFs?=
 =?us-ascii?Q?DRE+28KWNq46rReM9+hyhMJT/Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pt57mRWKXL+V+hOFsimnaSw7495+8TTxRSUSp7H9okf2TscztqnzvFcimw4w?=
 =?us-ascii?Q?R0F+N9O1QBct2A3matSJZB97w0UqL40nR7CV5ft1DimTLqsvhW4FtYJNaDmr?=
 =?us-ascii?Q?x/IO0wweTiCjYy0tqkGkLUYIb5TA7TzEEFnfVzUNTXlAVsNWMKlvmAHBzjSN?=
 =?us-ascii?Q?BxB52om4vzKv9s4UClwljtck62ORxx8hlLFEKjPM6oQcFwF7MQBWv71rmKgY?=
 =?us-ascii?Q?F9pO+nxiuZ3n8D70saGKFXh+ZWoT6vdf/mDalPArmtdD7ImhUFiwGFflBftU?=
 =?us-ascii?Q?ccd+3Q3lYdCFdH55Lq3/DIHm0Qb/9X81nRwBgTSKId6DAZ8iSL4pcP1QCTkl?=
 =?us-ascii?Q?qTiFQDOtfwoWZuHI/mG4lgq8/U5tY2qdIBa9ahDfgE431uffN7ccRTdZH36R?=
 =?us-ascii?Q?qsGo5mNBpo9P+sj3pWMAHRGP2GEH3ksNhPtFkjWdftszVH3Gt52s4haSokp8?=
 =?us-ascii?Q?BAo2xI1ARJjv5CQCo64Y6Qg728E+k2++mSR+UvhmaC8rWObzl89y9XMg90L8?=
 =?us-ascii?Q?ldQTRl0sC9LVbWhC9w9p56S0G7LMWWGGhZS5IVxbv5SWWTHa0QM2BasZpfK0?=
 =?us-ascii?Q?pktW2HaFYA37zd9S8vm1ff6mUP6Rgy8qCmVSkfjCSgLeohr6dkZmBFJQ7pyZ?=
 =?us-ascii?Q?1IXrE3m+nEndfVdfwAF1ZxQhp0jQQ+5m07dsUUOwQB/16AKPhLt+h2kvUVbE?=
 =?us-ascii?Q?qkAOzAiqZ/7Awgj8r9iw4dcGg9IT9CcX5LxOkiPZ6OOvGSLANSo2z8KDyfoJ?=
 =?us-ascii?Q?j2vHVDrYAacQQIHm75SIqk7fuZuGHV5MeXwDFinyFPAP/46DYuFjFsykMSyW?=
 =?us-ascii?Q?cXknTgPbLu89oU7ce+1pBHtV6uAyK7wh27K51OfO+jmopi17DlFLf/H1t62J?=
 =?us-ascii?Q?3g/m5XqkAYTBt3RNSHDTY0EB+XP8rV1m+JPcq9yE1kvbtm6K7NcHFG9lUrP1?=
 =?us-ascii?Q?cTzl8B/DHinFT86yJ+gaaI66LvwFqeBtEyuAU3BPzAv1ayPrpekS+P9NQla4?=
 =?us-ascii?Q?oRZ11CSTaG9yKJyu93/oluiRxUbti3XkAvo5vjtDm1boGNZqQsn5Sr5YvI4n?=
 =?us-ascii?Q?HUoYw1aCoDqllwsiNCCrS/l4/GI0GfwtBcZEGnu4ZGkMtky72hUBK47DmGdW?=
 =?us-ascii?Q?D8zw6QVQ866B51jSNhP8b0WBZhl7Ug14QKghIJldQOiV1IJ+aYCqw8gCMhid?=
 =?us-ascii?Q?lWbDtqFfF9E+FNb2AhPqlYnd8sjB8GHfBsXUEHB+YZcacsWbldMSJwLNuiSO?=
 =?us-ascii?Q?on/7IjQLj2/Cjg4UXqIGuUnRQk/P/dyifEyd8a98MiX5RdFwMqIw+oyu2gw2?=
 =?us-ascii?Q?j5HeNshLrBELBjCZpSXLQX11hfiOzMM3GI2wFoict3HUpZ65xM6eipLscLCV?=
 =?us-ascii?Q?RwXXzHbKTe6aH6Pi9HsJ/mcPiNbkNromp6vy2V7m1U29FDo2Ew=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0953d6ac-7720-49cb-7131-08debf7f42f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 01:44:04.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5189

On Sat, May 30, 2026 at 09:26:31AM +0200, Krzysztof Kozlowski wrote:
> On Fri, May 29, 2026 at 10:17:29PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add devicetree binding for the Invensense ICM42607 and Invensense
> > ICM42607P inertial measurement unit. This unit is a combined
> > accelerometer, gyroscope, and thermometer available via I2C or SPI.
> 
> Implement feedback from v3. Subject is still incorrect.
> 

I'm sorry, that was dropped due to an oversight. I'll correct it.

> > 
> > This device is functionally very similar to the icm42600 series with a
> > very different register layout, however unlike the icm42600 driver we
> > require a interrupt-names property be present.
> 
> Why do we require it? Who needs it?
> 

The driver this was based off of, the icm42600 driver, has a fallback
to select the 1st available interrupt in the event of the named
interrupt not existing. I was told not to do that here so the named
interrupt is a requirement for the icm42607.

> Best regards,
> Krzysztof
> 

Thank you,
Chris
