Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794356311;
	b=Gns2Jp8m9S8cHaz1HTLxO3Zc/yej8VpR5lg6WYrfMREOk5ajciegJEIHt62ffG0vwkfv
	 PCmEPjTwP+by9Hkmlcreg28OyKrf6LHc0mQK20d3QsGXONj9SeY9mD0G3fMullPpL0ZOp
	 OFfTd6fqLkEoLqCeYriBbHotUcvQvouwYWp5oQ0BFrtDA3xxRqDa0UvVrTwCdoGo+573r
	 hkah1mB2mvjmoIGhFJxvRYMykcJX71hUtJAmMH8kaWWGuLSYFLVrDr3wPTFDUQ89v0AXi
	 RTApCC/Ng7JgRBSoAcd1E4IkmfFgiber0FTnBeA5DNOE5j63wz0pnBvovSvAoSdpkzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356311;
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
	bh=iYWjfhlEiTwSaTjFsQgWDxjy3ff0h86TXxfZgju05fE=;
	b=MtRNNjegq4amQJENKH1/FhgzPlmHSWqQH2D1vmiX1OKKMXhSs3s5Gs7I4leDh1asug6u
	 rl50/zgKUycp1RRfT2A+mlywgUZs+QKfElqkCCx7Nw6xkeNmL0MCRzzkDXk1VWlTUv5Zc
	 zqQ9jCPkKAec9znlKArJkkKZSFhFJznBBDOWWZCFhP/Umf7OGgTdKvlg+8yVviz5N+aMU
	 KUo0Gaz55Nz76tmVs3V81eboLtMkZSb15EO7jmWxP4yrMTCPkgesyrrEX/sorHiEWgLsQ
	 AAfUq/IkYBo9J9A4xcDs6Urp1dgHWhQUvhb3Ei4wgwdxweEtesZ+ZmVaBeAzzk1FdLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EXEb0Rfy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.39
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010039.outbound.protection.outlook.com [52.103.10.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD47606A31C;
	Wed, 11 Nov 2026 00:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD47606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EXEb0Rfy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTBdK5FVqCc5Zsqx6FRzDSk/BV8UZ3WmOJibtbrnFk7ygesniIX2eDkro3fKC4RibmcNcBzfxBnUbGh/h8628/5TiPqdhj6kCUnY7bL6ASkpyoRJgcobfUC5sPnwShOO2R2C2uDdw/98KI7CJH+I9j7Q2TTzRcIkTQSPeRZtRRbOIEXuAKCrdirmxF9AqgT6C58V19i4LqnvaLBg3niOxjA/X3yC2iqb+meRI8H5wLtSvxcU2LRbGQE+PYyRkOEr94NLi5UeLrEjWF6TdAjYNxKLlRwKbj73phVTO5+RGVvzjcQZhfGpuKxEJF7m/C2NLc4qeyIeZeogHGjSsDDikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYWjfhlEiTwSaTjFsQgWDxjy3ff0h86TXxfZgju05fE=;
 b=grVf0kmjyuh0Nu14y+q0kRFYRT7mlvEDuccuCzk3pMLZSwFWXoLI3tBjQ3TJCo+ZA8eFMDJRNELvNuP+fGE5OXqms1nPA1fJ10/pBwNq9XieygoIxWWjeq73wHYVLwDCsjCymKfTrJx9RDjqKbWLcDQbEKLGG1W8k6tdvirUgL6xgo/4kDw9jTgMUDKkoCWPjHP3FJF9ED/WNGAtwiBY6KOF+ncMYQe7FkVzgrxmklB57yx8F9092nJHtA81smmCFjUqmDSTNyAL30HATJ625B13clKuD3xJi+/LgnC9j7SfpuQ7PkkaCwx7Hfy9T0LXzqu3syJ7tmB64WB6Tyo+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYWjfhlEiTwSaTjFsQgWDxjy3ff0h86TXxfZgju05fE=;
 b=EXEb0RfyfeyT4Evo4hH7J1VOQoMLWxCv6kZjkcT/fkDPNpCqZaRpx5/BCIvGOB2x9pql0p4LcGbYKeQo/gqPGZeaKzs1HkmDaP6VIASIxaI3Kgkgz4P50lG+p5F/hMONo9ajCZDbFkYFS8fNZmM/IiyoAtE/CepVlRQT/7lhWI1loEyxNzsvobMOnpO9BPZ/4qcYEbf6B3SVvuHBghCv+9BkYUMyagYNOhEJk6W06cNmCVRK6DdYgDrsc1iPQW1MfwUGErYodpsNsEo5xYZfidhzTy0lh+AyMXLG8hDQStCLUEnTLFyweCHYUMYFCmrSyQPm1QfsLOqPOnij4ovbFA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 00:18:25 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 00:18:25 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v8 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Tue, 10 Nov 2026 18:18:16 -0600
Message-ID:
 <SN1PR12MB252866C4690F808A80429926A5712@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avOKDbkkDwqhHEaC@ashevche-desk.local>
References: <avOKDbkkDwqhHEaC@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:610:75::15) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261111001816.1116411-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a60061-62d5-452b-0880-08df3f894cc2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|260925184616899003|8060799015|19110799012|25010399006|4140399003|24021099003|23021999003|5072599009|15080799012|24121999003|22091999003|52005399003|40105399003|26121999007|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SK3JliM8H1SAz4WrMJDc5zE3lqtyt9jsN8wa4SW3J7j7beyPXOBjT9nzM0Ri?=
 =?us-ascii?Q?Sl9vowa2bLTwYEd9PdyAC5MjzHW03XPQHQjwXnihiF4RowycpRWXUUKLzlVo?=
 =?us-ascii?Q?nTGPSfhip0hQtTfpPixRxlYmbxSi7cRPpyE93TM/ZQPWHzLIg/cM0kB+e5c7?=
 =?us-ascii?Q?7cBiJHr4IzOceIl7K6avecYvj2y6otuRIBz6V9E0I5G5DVkKkjpd4TbT4qGv?=
 =?us-ascii?Q?5szA3PprWGgreWxiiM+84Djk5FxM2jzfytXwSuPmeAFb6IFoeQPWGcilZK8w?=
 =?us-ascii?Q?C36au2ZEvzzQNXoH/sOe762L4KcS0iZnZ4rKrgtRSGG7dfMb2590Iz9+jOvH?=
 =?us-ascii?Q?lMODAweo4KmqV7YIr146RJsxbUUqV2BpE66zMbI1XQNPVLsoB+k7yRYo0cIx?=
 =?us-ascii?Q?ptjPjSsp6P0BKe1KUcoT5Rv50qVoOoN3oM720URWqV5ubUparG1AyZIDFX1j?=
 =?us-ascii?Q?LB46GPy5+TDUsHgsx73cQ10nxsSkpKcwBf6tSH6koUgk5w1qQYLtCa3F1GBy?=
 =?us-ascii?Q?Iu7kkRIE902EBjZ4d/k9jRwXguuFulPfdEoarSXRwhTzBk0pJcjWMc1TsmyB?=
 =?us-ascii?Q?z8W8hJUmgUWgh8CIAEj4i6IkVwaQGjvkBGVqPDptPTCxmwU3DUyYZsrge0QO?=
 =?us-ascii?Q?flI7KGLJcrlBEi6wl9pJhDW+h9aY6lvMEuHvWdtQW98sDCQk+9z2Y3ZbODDE?=
 =?us-ascii?Q?6GMshmv9v784DiKB0egQ1eWXN52psmPxbGBvRcze22nHuwIrkBvLoBFf5HLl?=
 =?us-ascii?Q?PLUXDWqQB+5QZ5AN4Ca3H+bLDRp41fww0RXH92H7xBKX4ikaJlkM3/w6b8/S?=
 =?us-ascii?Q?8LmLzDqUELzQX/xKhXINCG/9ELxSwlYonBHTuvIfNKCXLrNB6BWsvB/a9gUc?=
 =?us-ascii?Q?e6Oro9q+O7fIzsAf1je5AKFbJCOqB8krd7Bx99TZsYyqe6TjbwZOOMy85X/5?=
 =?us-ascii?Q?OpGMXU22XzJP5oAi1TjlD7IS/TTHtSSLzXSRIaufOJLNZwJRechJJAX0N7bZ?=
 =?us-ascii?Q?KYEepO9wKTgjK475Ly/DDzMNZ/4LdVj14w+fKwn0lDbP8fA4UHupJMaaAkA5?=
 =?us-ascii?Q?Ataekwty?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/LqHmTSkfm2hXRZUHjPaKg4Km+cQDpmHy//6bebgbQAotJGgqYYTsjZ7MWq3?=
 =?us-ascii?Q?E2eIMjdts7vV1kgBkQhctpKheRdD8YIWlrcv647a1GtRf0jn/k/6spYYgEC6?=
 =?us-ascii?Q?pNX4CwShYZ63P9y6Oogtt8f9HeEjQlvhQw07Z1D8SyN9fSdbgZutDuYA0kNb?=
 =?us-ascii?Q?vGluDuXFnVPV5kMaH5AiKP864LLzbtyOyT57ifuesSHFFf6HnZ0W0Y79gd4e?=
 =?us-ascii?Q?FPnvL5o5YyTV26E5zf68dNlCWXBuEPhqKMN/sgrHCZ+NoTQwbXgz9BHuYMIE?=
 =?us-ascii?Q?048gW6Q4fxaPMjd1feaTI1B3IFMd4XyXPXRDF9hTn1yncyAeQ5VRsqrPoBPj?=
 =?us-ascii?Q?cjvx5dt8sNu9T2LDqKah2aHLBo/8yNPZDnABLOk8GSFjnwSlEPg1BCM7Y3SV?=
 =?us-ascii?Q?VcRC/zFpraCilU74u3IvT/Lia2J0GDwRooKqRjhJMP6apxBgMfeUr+lvGJ3V?=
 =?us-ascii?Q?wo4bhZ6UT0wLucng0YBEIXEQBZcDeFUlAHQtvF89ENae9beDtAhR8YOBvZe6?=
 =?us-ascii?Q?ISM1EZrC6n4+pp8+2hqmSwELFx3K9MBTYTgToyKXhLdaKkDFQUSfi/qHijy6?=
 =?us-ascii?Q?RtY/E0e5568wl78WXfU1OMpu5JSStAW9RRFQD8j6zOipircoir1vGKsDP/8c?=
 =?us-ascii?Q?E+JmWwtRDrEPLgP7OFIsiRIgmEqnCHP9MynZmCFXLYqVVPoYlmmomsPCwqLm?=
 =?us-ascii?Q?10YDD0a3wwNRdRPawcj1DaztHelM4iuLKBNjiZqQ8n0+mxHkwsRGe9SO/muz?=
 =?us-ascii?Q?MhBUWP1D7YqH8CKEHzTvbhP+fNQsqRM2vyZ6gtaX9Xwg+p29GDvxWskoXM26?=
 =?us-ascii?Q?LsVz07io2WxeGlrk771w5AUzsux4zTQEFmGiSMnS/gd0hjRF+erjERdapHfQ?=
 =?us-ascii?Q?vn2ioc4UvaINyNXe1v8NXpfuevpdaxL+pHz0oOn9ExH5wh8t+J2d6vhdQd6H?=
 =?us-ascii?Q?x3bZ/n5WQH/170sRTnIBCVQmST8oZxDo57FWGyWb2ILW62ZO8ijCiw3dcGqG?=
 =?us-ascii?Q?zoBCVuZNoqC1UZ0MD39gVIzR5ALeLQdPC6mfNzuL1iGb9EB+wipLi2uuJKkb?=
 =?us-ascii?Q?JMnNP5HrEMS3pkDm6frxVj9C7c+vGedcoN06cD7y0iFMdK8k7QKknaUE1N6U?=
 =?us-ascii?Q?3YS8jKqhoSkLX33cWP6RFayTRWb7UWjpZD8c4WCOMIa+5e5eb8EwR2Yw/na1?=
 =?us-ascii?Q?IDV9HsHLTZUXhFgItEH9t/L1iiWwW1xBFGy1msW95pFk82yFCFjj+nF+bBFM?=
 =?us-ascii?Q?Y+/ZAhaIsTAWEe+71Ltto7M/y29PRx2VuTVzfPNu1POkBj5uoyP16z4c/8/0?=
 =?us-ascii?Q?KJdVvzOxx1GsfHyDnAuTOtr77oZSZWuITDFxhDVbGO417dmGzTxI/E4IaU/A?=
 =?us-ascii?Q?SC+bZlimODDHJbtmVrzrRovvPV8T5InWW179WtwjDulM6qD9yw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a60061-62d5-452b-0880-08df3f894cc2
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 00:18:25.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994

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
> 
> Can we prepare them dynamically at runtime? Use global variables and a macro
> from once.h to make the populate function a singleton, so we don't have as many
> copies as devices on the system that are driven by this code. We can probably
> do this later, though.

Are you sure there's a separate copy for each device? In my understanding,
these static variables are loaded along with the module, and the module
is loaded only once and shared between all devices.
