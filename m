Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793095629;
	b=JNWQsRnNV2W/q3Bs7S3WQjy1oNrb+sqInm5xY3KXV2t6kbzDMGSuzKvslcucqsCnwLRg
	 R7X7EZCeVYtjVes9YsLfJm+1QG69Cg/yk2t6YuX94gG3m/QF9foubhtqk3pLXv5rB3lKs
	 8ZIA93dc0rNMEOv0ir0Ib0saAidxsgtK/Wz1w6K8THJzQiK2JM1XMGqPZS1twsrGcHhDO
	 rmyZRXHvELRz6SnGAtKzydcZgLtAiPgYLhY5yglmxGyPHOpS/MclIvdzsIXiTUdspE0zy
	 ry0NWTPPJmv2zWN8SYTfHayiKqbIDBmiCh8ZMZRW925pvcb8YLNiNyopCLwWIcGsTPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095629;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=thqg/b2xH95UhwHfPFOYRhBO5CXdRSHqJQ/0UvljMGY=;
	b=Z0vDyOmGwPj28ua9xmoFif7krbn1+TMa4rfi6tGk5IEupUYsiZZMJt7/qc1fuhe6eb76
	 KFxnOqSycOjf02/TcsByC5BmpbE2AcKVypC46d7SrwZznDAEp4i/muvK7ZRt9qAOCQg3g
	 FBYp1MxvpO8ZlzVOsiRY7RHHR+17LJEH58r0gNgxWYOmSAFM2BCQU4IqvLgKbra/22TfG
	 k/y/JeXNwl/Y9NZ/80jLCoyhvhDwOurz2fXccZhKAPpaTuPX0IR0dIFHdWXZDT5yPbgjq
	 KD821ydV+OsY2XRmENsG46+YvyApKKhbvR5X+OaN7Cye6ameCGYf6iDgVa/WfAtbV2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=l+bnaz7P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.44
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010044.outbound.protection.outlook.com [52.103.7.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19A606A31A;
	Tue, 27 Oct 2026 10:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F19A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=l+bnaz7P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVX6L+VORBboHOyXVGzIFnJkZK48rkiaaiF/p3uoUv11tkoaW0XpJmmBnYQXNnkPuuTu6EdnIeI/KqnvbacumhjRspSxgDQiZFhv6qhcMrsPWLzj7fU9BU2O53urt/3WPxMM4+GJpwJ3EqAzPbSe6HI9KTwgMzGqS4D8vE1D2rsd3QdJH8lHpeeLIKZPybYjfYjfR/P4brabPlC4nXvlqbOx7xbix37mnA9W4/HKdys8uyRJpau0zE2G2drEfu1E4wHmRsSynPQl7gmXaXnDKGsKBLYTR2ryLSyf0+iocoLmgGXh/0CgsrATYA9pE2WtzW+3OrsXq2esx66o7fHjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thqg/b2xH95UhwHfPFOYRhBO5CXdRSHqJQ/0UvljMGY=;
 b=JeF/DbPEjUy5L8fzHamq+vs2IIA1MNdQTjiL1ocPYDaKvPEZU3yPfkZgyJ8aOMpcX7yyDxI9oz+p5x/dl1ZaFbXkbciQndsCQ8/vvWFUPTJy5GsTBxcY9HK65pyYPobJecsF5bN3VkywfHaanotVXQjRJgV0AZJSltJH/ehQYah8kYzg3mfIlAvmSmONxTKf9Px0vXV799fhbBMNOWrkm3QoAxt4svIwSk/SlWKFV2W1Jd0+EzKLqesHtERHwvkfOVd+37ZHe9tfIR7xad/2mn5XMIounO8TLO+eiKSGNDmEt58czq9fhAHGOTeOS/q78EOzTdoEM7gikL8pPHfB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thqg/b2xH95UhwHfPFOYRhBO5CXdRSHqJQ/0UvljMGY=;
 b=l+bnaz7PsdVaFBeoUfjit20do2OxGVou666X9tOyzuJiUHFWAmGKYaoQ/rMIsIQ4/U9BXyPXA1x9US7an+oIFbtAx3TggEVkFe9831IMiQhoZ1gVDK2dVvk6NW5q34zRBXeX1Bowk2uYzbUqO9DqpPZ9876xOLSFtfdISX+y6xrgX7+2cdt7uFWfNCe8xRhB26qo6z5wIqX/WUZ4Kz6TU9H+pkDlA8XOePuZdxLWp/o9M9DLts4AXQaZDihA9+mqRIgyouPaK0xaBAqMvZDzbLJsLpVXOhDfZKvAOKgRmkL1aYOJQ1sy/KoaB2XlO90SowhdvfN2bjsExLG2wj35Yw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:07:06 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:07:06 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: joshua.crofts1@gmail.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Tue, 27 Oct 2026 05:06:57 -0500
Message-ID:
 <SN1PR12MB252875CD203232685A86C3B0A5602@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027091747.000040c9@gmail.com>
References: <20261027091747.000040c9@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:610:50::12) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261027100657.177270-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5dbe42-9cbf-48da-39d8-08df34120dde
X-MS-Exchange-SLBlob-MailProps:
	ZotS1sRCahcBEZ0FCgjzK+/qGozmRSbATLvINCHKjgE3C+E9VcgCsbrfqmL0BFLOiWcY3fW4q5npAfZEDWbTNRQwoZBfmBz/5gGbC6aSSAzJr5IG3mIvApUwVdW40zApaYMnHCTnZ9ZkN7cg7XJ3AqTO2hsNIO1lgxZ4m446X6jk+U54dLzlhXOnoqw4KaBj+Y5fS05OEau9lsiT1pM81//JHZWAcPODYDhr+wWD/hTYoQtMjs24aWIt0yy+hlHwLXcDQCAxp8Bc5QN1DYMnspK9CEAP70tzI733EfHIz3nRPeltnZoVo8+sBjbo61WxqUi4h4AMCQ0fPQraT+Uc6rk+iEyixFxlQ9nvK4vcRJ7LlEYdSrlxJi3e0iBvUOHHHSStp3zL1G5jfjaUe9s1OZLW2tO7HsKOq2jWvFVv3XsGY7v4FpmXasIcp+5oZcmgrhUFn+4GUg2jblOaW1Pu9NRhv4Yt9IdaZN9nFQ7wgiDkiE04Xe2fPz0gzPY/omxVxrfAAX/5iiwlIP5WdOFoy0P4ZvreUN/txcYf4grK+w2PX5+V6NH1Nny4LNYlzx0LT9TaXCHS+/XeEd5UFfjOAO5z9iMG06k4cacVLY9RZy5Benwc4OLT4ayD4t1vIKt2di0cUXZo1nTl14nwxvv4VAcDdtSJmYbl
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|22091999003|5072599009|15080799012|23021999003|39105399006|24071999003|260925184616899003|24021099003|19110799012|8060799015|4140399003|20031999006|25010399006|440099028|3412199025|40105399003|261007181701699018|26121999007|11120399003|261005200801699003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uowED99qjHn/yLkWVkN8e8J3tMwIgaOS22wq+jcn3mx9jtcz9RvH/f1gwwQ0?=
 =?us-ascii?Q?8IgZTnAL3wPxKwe/+ZYxH/JRjUlpVEs403RhseVaMCT5JI0ThTreOpjGL6TO?=
 =?us-ascii?Q?deYvs4JnDtTmj3Eudnpp1Bq4DOS4sDneDZ2C0QdOiD+dNdp3feNC/3z+X5Yc?=
 =?us-ascii?Q?0giCd6Or6SgOG9s5NLonC+Js60fFbE8UwZOA47AiyKjixUT+xIUAoeGSUBNI?=
 =?us-ascii?Q?SP3lk0i8qL5pdIE/sOFOZ4AmmDuEdul5UzdCbS3FiVts1LHj4bTYhiSjoPSd?=
 =?us-ascii?Q?TCLBmFw7DG9i27y8Nx/wI1RppEIfUla02QVwS4+vtsZ0GACoPkGbDu48Wa9n?=
 =?us-ascii?Q?+9AeLCl2hUAky8eUcXH768YmTdF9R/vR4Kh6FmR3Rk2+PiIyI5R/qeZpOzsX?=
 =?us-ascii?Q?m8M0Gaq1MqJQ1qVEyBasb0Ou0bB5kP5rCl5JMXiTBMPI1KKqlg+vYhHpR9Ya?=
 =?us-ascii?Q?fU+KNu9ZLWCSg0/QkHHMFNzSKC2mxtrzTTicDmar9saZjsfQggKZ4Bv4kH2Z?=
 =?us-ascii?Q?aZr7+Ie/XhV1yXKAu4GdcnDEDt8sQrvOucr4NgIMdcjdWjKtIzUKOlTubI9J?=
 =?us-ascii?Q?XWfT/j0ZlGySexYlvcLNethnncdOlOUQLgMhzCXP9aG9LA9gkmB50ypyeBlD?=
 =?us-ascii?Q?evloZiuut7FVxU6K02ys0Tf2S1QKmLCgqJbFeRHrAqsrJrl/MjGRCKWIK9Ls?=
 =?us-ascii?Q?DfryBlaPvIqalkbLBNVXzCMCQqZSEJnVjB7GEqhel8vUlFY9t2foCuJrIyUk?=
 =?us-ascii?Q?5HR2wdX0FJbXuOxhIslNNtSUVgwWwDbiGF0y9n+y4EtdyMfVysKY3Q/pjImn?=
 =?us-ascii?Q?GHx0YTOaNVgRmV4Jr7J7eVAkhym3FvpMStO29iFTRh+KKKWLTpO+k4/HpdRw?=
 =?us-ascii?Q?Xah7cs4cMqFo5Vlal5H/isOu8ePQ5iSA6Xbqoo++kIqixFuiR1eWkOBX2OIT?=
 =?us-ascii?Q?ZKmNqdAoTnOcpHsYNhb+ep9WvPNi50rdEVdVEgkKa/5Y3KD6R6DKo9/4O3zF?=
 =?us-ascii?Q?m8ccqRaqPBFn95EubhrD7g2Yvs+n5Z2VJQAZ/119kad8eniQfitNj6oO/Vip?=
 =?us-ascii?Q?Es0X2tzRYXQu8VYq+KOYuinNoZy3Z0uaya5pGBP506g2NrnLp5VUDi6rD9pw?=
 =?us-ascii?Q?yQDoDtIinyLjW9IseTSr+BI72E3c832vhakSP5XA2EkEOfPbbV7XXRA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cTdhcj6LzCzY7zjfewBCRDsp+/zvaAoo8ChS3o1omm79OxNo5+Q3oNKdmHU1?=
 =?us-ascii?Q?jgmpPPzGD7i1dHJ6Jbal6FkGitZCWJDyZkFPBRrqUYuU45GpGn7L6Tv8Nj9V?=
 =?us-ascii?Q?LvF48CsewQ3F1rOxVqvKrYaDkzNR/KAJyszGowgM37PVCcMEAyIQr50tfgYt?=
 =?us-ascii?Q?AItgKuTkQ+fODPnvHRjytBuonIXLtAsqmONCOp7CIA6oKPgsVqrpNgXjwHqE?=
 =?us-ascii?Q?gt4dN8Ybpsg7xtc9hFkxi4Du281A9kVh0vpIkwL22FTkJtn+BAuCZA4bKM73?=
 =?us-ascii?Q?lYBHmMeZXG9DdXEOB6/0wIoMWPt4jMsmtA1NtJSKAfd29TmvFSYrnzsqNwjv?=
 =?us-ascii?Q?m35fRlrpYg1+FZGMfsxLgo71kM37YRac9vPx/n3V7oGo6tOCOZqwjfQPqf0U?=
 =?us-ascii?Q?0PvquN4Jze/jV0PAMchXprqomnoi9Jcia07wpmpaBJbq1kYRKbMItpW4eY7l?=
 =?us-ascii?Q?OWkys1v7VO6b7P0BMk2MD/gKoaTdbx53hoNMhIJwqFguYR+S1IdvhJFTPyGp?=
 =?us-ascii?Q?rJhkGaTfpfCrH69i7IXpi2NfPAa/oaPW3HmvrBT+J8hJaQqGyKIMeVgyXE90?=
 =?us-ascii?Q?ft2w01AvH/XhBrP7CDbw8BvttHin/ZvxqckiJEF7EgZeuI7GP9pD5O8ePTfg?=
 =?us-ascii?Q?kslaw8ihvlCoPWmbhAZ9R7CtYsrih2anD10ay/IOBBKCWGsHi9nducLjWsN/?=
 =?us-ascii?Q?/JWgCQgQXltKmniTUMEUpN0lpBP6o6Z1hyAhDB/OPXsPhP4OoxbnoyICiKi+?=
 =?us-ascii?Q?iaXDY0h/bQU5avJOoXcRvwQdGis3YLweavQPjm4ZDRsAuGu80zeQeh1z32P4?=
 =?us-ascii?Q?sJbofvBUbZk2jbvV9Xaev/2CN7p3JXADTnUO4GqJ4Nbk+p9h7tqcda42cSzS?=
 =?us-ascii?Q?koYnDEYrs0GrTCpaYfLVFLs9GthdTude0WXvQON2C8Ho+tqlnnYThh0jssB9?=
 =?us-ascii?Q?0M6rhC3T8j3g4y1TvXWkJNpD4hlKg5rEGQtTT9+UoqQeQpPk6FBN3MIYq/rV?=
 =?us-ascii?Q?D+QHHAwbfhgIIIi6rEflHn9ew/nhTSBkO4YeTg1y62Gjr1Mi9PE+GunJfA0T?=
 =?us-ascii?Q?FE4r9phMfJq4b/CC15X4HKQttOltAoEGIymZkZsitwqH6i2uKV6d7Gwr9jfN?=
 =?us-ascii?Q?bJKz23lQHMZuYTAOfgHi2K2d7YR2kopy2KbD8y99MjASPY2uWyAXXC2bgAPX?=
 =?us-ascii?Q?03RZ3knYYbJUCxCi7yGtn0EvQBVNkMIvH2/FaOiGpzB+TfWJG9s+ml5b8bmi?=
 =?us-ascii?Q?4AII6BAB1lI7DcvW4Aw3EnMmKnzzaVD6NMLjuX7hvN6kM25hNUnOoiMoGaP1?=
 =?us-ascii?Q?4UOaO73JWuoLGZM55Ljk3HJoepYI8G6+QUUwNraxCO0qES+FDMHJHNWx9imc?=
 =?us-ascii?Q?3nIdY5XchzsA2H86quSqmhq3cN37KMn1CqdiOQKnBCXZU3esEA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5dbe42-9cbf-48da-39d8-08df34120dde
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:07:06.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

> > +config FDC1004
> > +	tristate "Texas Instruments FDC1004 capacitive sensor driver"
> > +	depends on I2C
> 
> Please add "select REGMAP_I2C" here, otherwise building this module
> may cause errors with certain configs (e.g. allnoconfig).

Added for v4.

