Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794165710;
	b=nINW9mg+PrDp/CIRJgjeI4eebGFdUNdkoB8cFI7cqUJKbXOOW5aDqVxS8LC3KTMv5/eq
	 RpKKH5ZF5NJAseiuZWOZ4Uu6bdeNkwTjXMUd2oij7FsyeJ4hAknV9Hy0usDvRMtvOwrld
	 94MLIEQiAXAFZmHrRD4I/gO5PPcjycFV3XBky/QXCrM4v6sJjI33iEekDOVPIVH3XUHde
	 j3LOkpI4b8gzGmGgmON7EBdVMct88z/S2r5PTjdqzM7IMAOpVeT/OeuqMRThV3qD4YAZA
	 QrNPiXeiYdkUY+e4PLd9q8i8aPxOuAXWHRGS9f02SGxde2MQgFhdfaVuecht8bpQVHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165710;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=06IoR0jKPa3hV73cSU0EsvjR2ErafbtTDxvewx1wtq0=;
	b=aZzrYcgJP0C0ECYi1pI2ycEn1Vo8j2eJl0zsWKeJeuMBcdOI6WqO0s3s+Wx5NgVjHbJU
	 KQECR1i2BysNt9CfNLOfGDyZFXHSl2vdDYy1dm+hD1y6Inux++C9o2rboLK5W5Yf+7acS
	 dW7T5OMLhd941Nk0tFXmvLtMpBxpSsrcHrQ59QkpiUAzqnjfbIXNbVEg3L8RDShBHnc2P
	 AnlNJZCm5/ThjGqAVAV64yo7i9K4XuqXELxLLeOq33EQ8ZSKC8Y6ugCn3BIPxRCuLJ1iN
	 Rcti2lRelbI6GeuGxH1OcjrbQNx26aAxUh5pj84ZLysWDvYVbsX97L9wCA99VY7KQug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=LZkyAJ10;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.2
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011002.outbound.protection.outlook.com [52.103.1.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA4606A320;
	Sun,  8 Nov 2026 19:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2BA4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=LZkyAJ10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEirCUAXDDqNipfv8jLIN1CZwUxbHUFRJHdD4+IF0rgw/5icQzAEBBLBSPy0Z7WXy9vrKE+sDeYe/nOfbx2lj/Gm5N+cz+P75uDhH4bw22/iwZQ5pul1+YOwGerNoX7gYOvCFDIxeHU3XaiWSSc7oX56T0XTwuZ+Yyx3TCy9LF7kJhi91TVpHq1GsF+Bivr1778q5iFBYa9REOX1/Pm5qkgLy6K2GR/fnuHz9ABznI7WxwobjRPiQHMF2k6pllqdb3GbVRlS0aksPoKCC7Ls2v6VkSiKygSG3npRP1k1S9kQn8kZtrJ8KODCWf5KmaIOqc6OOpTnD5qtJsXuQMS7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06IoR0jKPa3hV73cSU0EsvjR2ErafbtTDxvewx1wtq0=;
 b=p9eWyWMudRsSW+/wVX5vSla4IJ3Ujr5eoCM112oSRQgtXT3IJeC+M639Q2zlQy67n0IwkNa1QeID9r39zTE1nLFPLRi3a7lfFwJIPMQJF+ELocWg0mds7tSN+IBg2X4ZzOCflhlI7mDkB7XhDS8LLeO5ozvJ9dJouQ+gyLYAPyV7iSAb5439bRZ8sV5S5xgfVCOdQDvDNujZhSKfls5HXOAGzjxGt+97vnz5eWJL4a4amwByVjuddL4N7GLWYH9lgnQfo57UYZGod7hZGHLQlPcNoXzB6qkcDCxpxuyTY86wWgcQzKuWBoYi/gblKx0Wyj/nZWLkNPp6ygiJsC4pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06IoR0jKPa3hV73cSU0EsvjR2ErafbtTDxvewx1wtq0=;
 b=LZkyAJ10KtZ9sFH0P5PImhKO3TT6Vj1LZ/e74hFK460arJeS2HKc3bQDFwuA6ylpkod6uUq+Aknjm1lD1IXaGYGed0RROlpzKolHzresD0aRVwms24RHztDTKS+VkZGR+tKmQgHtqFSBiSNojtF+rde4+s46Fz2iba2x0k7/7lQjAQSUZWg0fGyICE8nVPTrKmGoNTjyxEmfq5qH4jrPqQInwK9Pahiy7UftB66SbI7X5c4ReBI/QdDquET/1uJptw0JIxKjK1gV460y9rUaVCtpc7y+gV6M8ZGS+udqAoP953QV9nMPtluSqaXxvCWJvMMVYYJ8XmjDCg/g8No3HQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sun, 8 Nov
 2026 19:21:43 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 19:21:42 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	nuno.sa@analog.com,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun,  8 Nov 2026 13:21:34 -0600
Message-ID:
 <SN1PR12MB252888B43D53AB1723952D21A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107193145.4d21b8c3@jic23-hlaptop>
References: <20261107193145.4d21b8c3@jic23-hlaptop>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:610:58::32) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108192134.973827-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 384317d2-4047-4451-76c7-08df3dcd852b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|260925184616899003|24021099003|22091999003|23021999003|24121999003|8060799015|19110799012|12121999013|41001999006|25010399006|4140399003|5072599009|10035399007|1602099012|52005399003|40105399003|4302099013|440099028|3412199025|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUh8Tv69zwnIxdP07/E+AzmYLRtt0WQuaP8/PXcyrmC3kpjo6pMoEZBEUxCm?=
 =?us-ascii?Q?WWzpIN1KYpDCmZQj5hh60wskMIjIBJbmsVds23qCeRWKkEkIZOD9b1CRRr5c?=
 =?us-ascii?Q?EnVxDBhXQ2vtTlavF1XFxNRB53JW9cEKlmYsm37F/ci3stS9cJ4xMPBHJqKm?=
 =?us-ascii?Q?j4ZQzW8Hoq07C/AE3lzwcGplZVq8YiYVXJJCQQxJkB4A8H3Fe1vtDgwd9sl3?=
 =?us-ascii?Q?LwlVdrS1TM56eTGVhErPsoxqonHyCHWdV6m/CbGFKcDVQu3PfYjeV+c0zQNf?=
 =?us-ascii?Q?2QYqKCJR7KzZFIi0W3HC5SBXho8TmZ0CyNzAnvSp5V+87pPyfkXvyyr1ldzC?=
 =?us-ascii?Q?6PMtvStnl4u00rlLXhME+sJTE9dkAd9GdNWCl0PadCBtSuSDUsqd3RP6oeHQ?=
 =?us-ascii?Q?6ukjUfEL9OB4EoK1tuYN+dYu4EnGzmvSu+m0IFm8F5xBpr0nu0ieXmO/Jk2n?=
 =?us-ascii?Q?ziMwvEAOO+zHqyu+oTrzE8gemUaZI6FokF+qqGp2rm/JWDm1a7bASWSWoWCb?=
 =?us-ascii?Q?LUMxF2UNNWIOUGaYral/VZF3cCeRWMv1/dL2jlJZN2yk1JP3InFmFZAWtI+T?=
 =?us-ascii?Q?Fy5AG3FWcniKQ3U5Upm0rB+pxxo9kdISw8Et2WxYtnG/gV0r5cx3vkPPAKQ0?=
 =?us-ascii?Q?U5XFkgItHsRaD4qWRlCUZA+uVYOtDIQUH4CRGV7l0dXrypOErQyK246qMrka?=
 =?us-ascii?Q?vzFXgTGxLCeDli6zkC9tacLnC3GqOHVRZI9Vs0UJYeXV4eOzFqf0T+0bxtgZ?=
 =?us-ascii?Q?NAA1KCVo+WercXFWAvpHDsS67bpGgsQ+lV/ICWlqrWimgwNROUy7s3aJOu3M?=
 =?us-ascii?Q?ElBNwjE+BoFpKQ7fByDcPq1RXH90wWsj/0wJfYaLHcmLm98fYkYGdp5TKvTD?=
 =?us-ascii?Q?/gokmVBYUFUICkWIg4bXlt0bUHQpW4THR1Y73aw0nQX6pAobQeRUZg1jnYD2?=
 =?us-ascii?Q?ioZZv1VYBGCQkvb7TS58kEIKEgi0Tt2F3CvbpoBtKZImb45FNHhBU4WgUlj6?=
 =?us-ascii?Q?MpLBX2UIoSMwAIQbSSuf9t92XiVZ9uC4JsNJ7LqAffX6J6nByRt6WFtMz1if?=
 =?us-ascii?Q?cSSK2B/Y51e4LaHjsnwCCJ2Egn4EwHfH2HrVbVd/Z7bkOtCDUgIjy9Z6EjWh?=
 =?us-ascii?Q?X6UHItNvb5oYn4p0ZQmUkFCAoYvIILIerdcvcss4wVkORbVWRGu73Lk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LpUgMHOdLQsX+kAb9qdra8Jfrcc7pF7aQ+LyCbuo23xigu6cGCxfC1tD/6sB?=
 =?us-ascii?Q?UzSDVK/gQCWQzYMRQrbHkeYKH5vT6iehvjy5CSnDzele7q4OE8AxE162PV/O?=
 =?us-ascii?Q?M+qIfxlGtDTsiQGmlqzwsWANjMi8RhiVH3PpDgcl6PcEBiAKxM1pTzEko4jo?=
 =?us-ascii?Q?fcYkPe5RbjFPs+3npZmq+UQSi8y6739WTrPGFc1Q5Zj8aLI3AqmAkUssbKyy?=
 =?us-ascii?Q?1LUS8VKNWAQcsfFBLw52HO32PbOpO+ig1m7CxFRKSQcG2X6XtBePNkqc1Wod?=
 =?us-ascii?Q?00MR66lS/GxG6FN5lPEtVrd9ZLJUw0wb70E9RbylDhQfYzgdoa1HKbrA9j7f?=
 =?us-ascii?Q?Da8hSkXV1xqGtghFaTEIDypXPkwZ4M0tplreosR0npl3ipcbrJ/4FkrF4YXL?=
 =?us-ascii?Q?HdMHpjtxuE4lAJMcl1oCxd6/ytQaTiKgRuOX2jUki2l7EPnoz2RgLeHub/Qc?=
 =?us-ascii?Q?dqk3e53dhBEZK3eG/mCHt4RhWxeFCuw3z8D9H5qCM+NHln4ygzGWIzBFQyp1?=
 =?us-ascii?Q?KGR48ErqYQwLuUf2EpNUhlhG4gmWvJTjmoeXLLOvkeTym2W/wP7zT/LlzKCW?=
 =?us-ascii?Q?9pgA41YlF3piq2kmcDMgCwUaqXHLB81zDQ/cD3h+6tdi5jse+vf3CInfd0Ar?=
 =?us-ascii?Q?sQnCGvqOwd+evKDK+1zRUmuzFJwa50oPDy8w1cw+lNTrXFB9mLjV4iR1pucW?=
 =?us-ascii?Q?exP/nCvfBfKXQdiCpM5SDATN7K7b1s4k3HeVw135f7tGRQlr86G4BaJEsowx?=
 =?us-ascii?Q?DwEjTo4sv9zsn8qmL7eDd4hUqRx5QJxM3XLqP4gYNejN+Zneyyg2a97lQ/yC?=
 =?us-ascii?Q?WCiJozeYY4MTmwja/uzwimsVoiYzjtL1rdB3cuA5KxlM8bqRRFiW4CsXKB70?=
 =?us-ascii?Q?FgO8ehSP4t6j/Vg7xtkpWXzAf/6yu/EVKeyEk4TGxXRQLlZc8Q/OLjzXplQM?=
 =?us-ascii?Q?B5oOc6yrb4SzIDwsnPfZqUynPbzYOImH/yFvTlviz/vG+pqhoekLkBf8suEs?=
 =?us-ascii?Q?hC2ZitzZ4ioEp4yIjFw2e3MkiWx1GayWLmaKiaRrAYqu1ng5GhYslGVDCdzJ?=
 =?us-ascii?Q?Zxbt1RiZWHIRX4Rv1Qqqq7a3xPEK7I9qBDpDTYMfI1jzVtqnt0fsM6mZXaQ5?=
 =?us-ascii?Q?JT8keUKTmMIXvx2aUlxnNp75hhP9a4GvhSl4g/kIpoqXqxladpT2wqxZrZqD?=
 =?us-ascii?Q?qrGJageb1pSqIGMNgF/auf7TB6k8FwZh+LutR3IC+pB77lOkGiO8ekbFAPrH?=
 =?us-ascii?Q?3qrIL5wUa7COfXRbbvYblKV1mzvBKrDsHFr6XZ716AqcjsiWiFeI2xkaQpcf?=
 =?us-ascii?Q?d3PDEMZK2alYUr9krA7m5FUl1/iKql4B0DizsmAtwLsvyJ/3j4zJiyocOUq1?=
 =?us-ascii?Q?I/spIsEe/W958JgFxuU9UbM1P+OHtMD/T3CHW5mZzG1DIMYR3Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384317d2-4047-4451-76c7-08df3dcd852b
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:21:42.6617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

> https://sashiko.dev/#/patchset/SN1PR12MB2528805DB17DD015E191111FA5762%40SN1PR12MB2528.namprd12.prod.outlook.com

> > +static const struct regmap_config fdc1004_regmap_config = {
> > +	.name = "fdc1004",
> > +	.reg_bits = 8,
> > +	.val_bits = 16,
> > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > +	.max_register = FDC1004_REG_GAIN_CAL_CINn(3),
> > +	.rd_table = &fdc1004_readable_reg_table,
> > +	.wr_table = &fdc1004_writeable_reg_table,
> > +	.volatile_table = &fdc1004_volatile_reg_table,
> > +	.cache_type = REGCACHE_MAPLE,
> > +};
> Should fdc1004_regmap_config set .use_single_read = true?
> On adapters that support I2C_FUNC_I2C, regmap_bulk_read() in
> fdc1004_read_raw() coalesces the read of FDC1004_REG_MEASn_MSB(0) and
> FDC1004_REG_MEASn_LSB(0) into a single 4-byte I2C read at register 0x00,
> whereas the FDC1004 does not auto-increment its register pointer across
> multi-register reads and requires two separate 16-bit reads at 0x00 and
> 0x01.

Hmm, I think that's right. The relevant quote is (section 6.5.2, p. 12):

"When reading from the FDC1004, the last value stored in the pointer by
a write operation is used to determine which register is read by a read
operation. To change the pointer register for a read operation, a new value
must be written to the pointer."

> > +static int fdc1004_soft_reset(struct fdc1004_data *data)
> > +{
> > +	struct regmap *map = data->regmap;
> > +	unsigned int reg_val;
> > +	int ret;
> > +
> > +	ret = regmap_write(map, FDC1004_REG_FDC_CONF, FDC1004_FDC_CONF_RST_MASK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
> > +					!(ret & FDC1004_FDC_CONF_RST_MASK),
> > +					1 * USEC_PER_MSEC, 200 * USEC_PER_MSEC);
> > +}
> Should the poll condition in fdc1004_soft_reset() check reg_val instead of
> ret?  At this point ret is 0, so regmap_read_poll_timeout() succeeds on the
> first read without waiting for FDC1004_FDC_CONF_RST_MASK to clear.

Yikes, that's a good catch. I broke this between v1 and v2.

> > +
> > +static int fdc1004_read_raw(struct iio_dev *indio_dev,
> > +			    const struct iio_chan_spec *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct fdc1004_data *data = iio_priv(indio_dev);
> > +	struct regmap *map = data->regmap;
> > +	unsigned int reg_val;
> > +	u16 reg_vals[2];
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		iio_val_s64_decompose(fdc1004_scale, val, val2);
> > +		return IIO_VAL_DECIMAL64_YOCTO;
> > +	case IIO_CHAN_INFO_RAW: {
> > +		guard(mutex)(&data->lock);
> > +
> > +		/* Configure the measurement we want. */
> > +		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel) |
> > +			  FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2) |
> > +			  FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
> > +				     data->offsets[chan->channel]);
> Should FDC1004_CONF_MEAS_CAPDAC_MASK be left at 0 when reading a
> differential channel?
> Differential channels do not use CAPDAC (chan->channel2 is a physical
> channel rather than FDC1004_CONF_MEAS_CHB_CAPDAC) and do not expose
> IIO_CHAN_INFO_OFFSET, but this unconditionally writes the single-ended
> offset from data->offsets[chan->channel] into the CAPDAC field, which the
> datasheet specifies must be 0b00000 for differential measurements.

The datasheet does not specify that. Section 6.5.3.1 (p. 14) says:
"Note that the CAPDAC setting has no effect for a differential measurement."

> [ ... ]
> > +static const int fdc1004_calibbias_decomposed[] = {
> > +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> > +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> > +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> > +};
> > +
> > +static const int fdc1004_calibscale_decomposed[] = {
> > +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> > +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> > +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> > +};
> Does initializing fdc1004_calibbias_decomposed[] and
> fdc1004_calibscale_decomposed[] from elements of const arrays break Clang
> builds?
> In C11/GNU11 mode, subscripting a const array such as fdc1004_calibbias[]
> is not an integer constant expression, so compiling with Clang (make
> LLVM=1) fails with "initializer element is not a compile-time constant".

Clang compiles this just fine as long as both arrays are const:
https://godbolt.org/z/3Kn3T8fq5

> > +static int fdc1004_write_raw(struct iio_dev *indio_dev,
> > +			     const struct iio_chan_spec *chan,
> > +			     int val, int val2, long mask)
> > +{
> [ ... ]
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		val64 = iio_val_s64_compose(val, val2);
> > +		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
> > +			return -EINVAL;
> > +
> > +		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
> > +				    DIV_S64_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
> Does passing a negative DIV_S64_ROUND_CLOSEST() result directly to
> regmap_write() fail when writing a negative calibration bias?
> When val64 is negative, the s64 quotient is implicitly converted to an
> unsigned int in 0xffff8000..0xffffffff rather than a 16-bit value in
> 0x8000..0xffff.  _regmap_write() caches that 32-bit value in
> REGCACHE_MAPLE, and on SMBus word adapters regmap_smbus_word_write_swapped()
> rejects values greater than 0xffff with -EINVAL:
> drivers/base/regmap/regmap-i2c.c:regmap_smbus_word_write_swapped() {
> 	if (val > 0xffff || reg > 0xff)
> 		return -EINVAL;
>     ...
> }
> Casting the quotient to u16 before passing it to regmap_write() avoids
> both issues.

Negative values work with my setup, but that may be because my adapter
doesn't use that code path. I've added the cast just in case.

