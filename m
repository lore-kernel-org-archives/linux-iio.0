Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793065963;
	b=nFeOqDRNHNpr59IDbgawOwMACWFRUsZaK98Dr5Rqf35+3dLbGIfMgHN70h0+okNqa60n
	 yQp14MpACCONFv6AW7sZtiM+c47mXwe6WwRUHyCQ0JpVaIEEiuyTdG7DWRdbPqgVpbx9g
	 RFL3mAA2KzkXbBEjLSJ6pYzq2JkKUoY4orgtGtMyRUnI85hZtCVn1x5DUZN+7kgkA1M66
	 QfwW2VHVBgaZzkIAgRvfD9ieDSyBosr37IEVmBTz5KcBoKxkD3TXQpqFXTBKWODY9197F
	 NZzwIWam28J1vz9f0refL5OlrF7q/0gGhg03AtqMuZK+/rQX1YqUDeiKYTVdHfbMMvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065963;
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
	bh=ilJNKbiTcb2OYgyt5wVKZNiP1FqcE0kqrmoTRq8JE+g=;
	b=GDtYrsOpOf0syftOD5otysqP3Fy+H/TkqEfhj6Sng8nrrtt0K+eWabZywbIuPWHxxLdm
	 pYe1ScI906E9gpA8TpeoUY1JEPX4ezlX3BA8KedKNll3xwGjP8CpjLq6J1qAdNwx8eEzS
	 qjylr0aCsw6m2Op9hA5eR649T8QXnui3GS1GSziXDfS4N4JQR85ijWix74m2lMyzrKKI1
	 cKoWjYoyBTSF/zpCEkIlbTZWSTgXHc8C2CXhYGIhSmy/lQGuyQyZ3vYpiLfx+Hk+dkcWL
	 1OZen9w0GHAhudEcrbk5+vvSJ9D+sLtOPEX1+g6FJ+JOipj0w7Om4kU4d0rO/rbZ1wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="O/kmVxnX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.24
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011024.outbound.protection.outlook.com [52.103.13.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D8606A31A;
	Tue, 27 Oct 2026 01:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=O/kmVxnX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AADNZshyESf4xibctJ3Cied0M+5/lJCQRUmzRJx2eTb2a6dw2qyFMMQeeCnzORRw4O+0FXcAk0YHmH+Yn85WUqkEcxQPeV3yp7XRnAfG73yTVJLy8fWTD8EisMN0Ed68lcErPHXDBaSKfd+LCnpkU/MUBJebobaKctmqwJYDiPf+ne/yGTHNtR/dcDnBPfxmXf0M0hgY6v/10MSgeThmPGroqtaQjhW2fyh4uma5we15WY69KRsWJSOdyM1wfSDsjyiHiO0MPdtkfTmp3arUZA9JbJy8Y/cuR3dJooFk8El5DkVSLiAXispddEC56opJtjfwTmRZfqJURclNijdJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilJNKbiTcb2OYgyt5wVKZNiP1FqcE0kqrmoTRq8JE+g=;
 b=d0hzBL12PLamL29TUgXxk31P2qYRuUvFQjhXuBzZQnwKoNtq2Jlf6QBLPrGee06P0IJOmpLF7l99hmYn5VPol5KWfndqLAlq/2B5FIBo/Bs4ZghZUC9LBpaERqov6hN7TxA0KqJ0kS+eHiQBRD64klkUsp8BElOzM1m8FqcHKpoip6SiTiR7l0ceEQCJAUJF/UTkynJSqQtZU9SLZKR5yKJRgozEb6bvhaMUGYNW8TX4gsxF0fW15n9aRjgdkbk3oBQZ0QxM1RGxlFZEQcZ74rnil9aRRIno0XOkSKmI1P/7NoWH/nDDfLbqGCmgv5CRcJwNBqiVM7CUONH6I1bKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilJNKbiTcb2OYgyt5wVKZNiP1FqcE0kqrmoTRq8JE+g=;
 b=O/kmVxnXRE7EAqjN+UvCD/2JOT9vlDYgFWehGPwzkXZTe1QcIIptkXGwVM5mOgwE/Kayy5mEK7Jwuj36d8lTzkLvBH99iG3Bq3c8ni8LLZm4/8MPT1i26W9VYrRzA9zxiTRTmT9dLAz2UsnaLINCnN5nvTfCvImpu103mIHWo1C0LiURAw94GmWuoStmdS3bIYta6Sl8f7BBoTm7lqsSqttFnT99WimT5DXHJU8ukaQnhNqT5rRka85q6F8BSm9ovh0OMkOLm8nXJw/0PiU4/hklTl2lgnyqY5nWVQonXTxfxjOfn2t4TBxWUNUzCxH9rqMYTBUqqV6Ji3jSpMDIoQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 01:52:04 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 01:52:04 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Mon, 26 Oct 2026 20:51:53 -0500
Message-ID:
 <SN1PR12MB25288ACCA8FC85EFBE08CD3CA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at-1SGe6xnObPqPG@ashevche-desk.local>
References: <at-1SGe6xnObPqPG@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:610:50::22) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261027015153.141096-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: c12c3942-5ae3-4854-4703-08df33cce4da
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|20031999006|8060799015|4140399003|260925184616899003|25010399006|19110799012|22091999003|24121999003|23021999003|15080799012|5072599009|24071999003|24021099003|39105399006|40105399003|26121999007|261007181701699018|261005200801699003|11120399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8AO8xhCs6gR5RPT23bgiDHBgQFsDrh4w0BGyMCID0BkApykZ+suVUfynRHoa?=
 =?us-ascii?Q?x/NHsArliAwr+kmg7uoZof7bQLR6bQR6NPWKkSckYMiSVI3s9qpZ3fvOmqY3?=
 =?us-ascii?Q?ab7BLtgSaeYjmcrafISPOZli4u9Q4pDMPgw0RXpaVGmrwfK9qtce8hGdb7mT?=
 =?us-ascii?Q?9i1oBW0xVKreIdj/HYt535fqw8fx2vGQcSFgAvElMZP0Br12jfvFCvT88bme?=
 =?us-ascii?Q?cr8ZQUS590S1BrqzG2voY3C5PtEzQG37wHTwjb0hRWstbMEul3+KvwwMJ34M?=
 =?us-ascii?Q?z7gW433hIw2iIrPDw4EpnfU1uAMBfubFX1WlSKAefFB2mx+uTDsshHCHqJoS?=
 =?us-ascii?Q?6w2W7kWCej14W8plGcf2Z5hNXHu+dHJc2r04WrkwVsdWUK47sQcjl5BlB5V8?=
 =?us-ascii?Q?Iso6n9dfvwwuepCYdvNERRClk7x2E6ls83VDhfb8PkKPPmauJGOQfFoDuwAd?=
 =?us-ascii?Q?Wf9jCs4Bf59W6HulJlrV/GietWRB7hYA85FKFV4SUqAZ9xcQSdWX99cMFNzX?=
 =?us-ascii?Q?BYUJsY2TsD1f+aHyl2NYtzwSLNHDO4nnkKiQ+SyV6LmfynGp1qSuTix+h3C6?=
 =?us-ascii?Q?eYGAxoPptK4oTLqxbyX/V4bakKKVDdQbD2wGH/8AxV+Uy2Y/SsJNpHLJd1ja?=
 =?us-ascii?Q?hPWFLz1YGL15ahGoT3rvzo42IbhzGMtYJIR40Lqj/vBR8/m7NVDiFBbpGCxK?=
 =?us-ascii?Q?jvxtbsh3uEu9aC6I8pqCcYzYpzo8mGosOXD65zVCN9S8GnZL6eKwrGBj+kni?=
 =?us-ascii?Q?3Za5MsFuMYTKuBhA1GIRqaRQ+lKLocv6rbv3w5++kDjtA5tV/NF7o9yiR5OZ?=
 =?us-ascii?Q?sr+f9USUePtyQ+MeaqFNYKsI/rFpIVwFOPkLSP7UWtHMlgM6NtINfByCFVUG?=
 =?us-ascii?Q?XnH5kuTLs/MNkn/7yAZitWecmnmC82WodDRqVHeWyI9bVbLo922qy0R8zNYZ?=
 =?us-ascii?Q?F4DjSVN9iz1rlj9KenkEBM7usA2RmrFD0PCCrShfsF8EimNclTJV+s/hkeca?=
 =?us-ascii?Q?YkSqFTe2OKIwrtREJVrrrngWEEGBnSPTMw78BRBsMuhXRZZ7Qv9Kr1n7as2Y?=
 =?us-ascii?Q?ObZ+HZQlZuza8ZTtA14PX5d+sTIthhzBB/I1NdZLMwR1NJd3MbU37bg0CAuO?=
 =?us-ascii?Q?LAcQJv/AXhTEiW/o9ysDrq7REsTmGcybOQQwVCV36JxAWh7u8wUhKaM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7LFBlr+A5iqnjd5bK1S6xaVhyg71MS3ImMx2VC+JnfO0yjdc/lFhc2KDSzF?=
 =?us-ascii?Q?lpxZphiBreQqmn0hix3dpdeszeOmD91YX644O/cCHB3ETSakqUWXfApxn6RN?=
 =?us-ascii?Q?nnU0pwCT9O5/eiIy+ZPlOHevz/5i+vsjfBfY7l0JvSH3Wq0SvJ174fPQYE/D?=
 =?us-ascii?Q?kvalmPeuZBYYKAkbkO+NILALCducoIv00GI//eiRk7OrfnVxfbYioW2+PfFt?=
 =?us-ascii?Q?sQAKGiEJ524xN48xQ/xNHifsw8tLQg1xqsgj0gGKcDijM5X78j97/mx8YbNz?=
 =?us-ascii?Q?DGCtT45jih+NB/VCJB68lt5wC/+UmKi6OslRCOZerF/ZcY2zTKMUvQX6pLoB?=
 =?us-ascii?Q?qRLdj1I0kh1Dr0ydAq+dCE5PRcsqvAXC8zAdwbgoMcprkAaaN3Mse6wT+QEQ?=
 =?us-ascii?Q?rnz9qSPSTFBKNEktPWmVnUMpfCWg3of6vdhzBikC2EC4TMI9QIuBG07YUGm4?=
 =?us-ascii?Q?4NEb9RXWXqOJYDW9tfh/vtBUJjhbElAzyw5daM0mVbo5tYipoGmaNQM/f0Uf?=
 =?us-ascii?Q?3EGDk87l5SBfCLcQWi1L08bfm7aLEAjLdc44FGM1b+Msb1+fUBpXMcD6STpq?=
 =?us-ascii?Q?vSPOZQiEpoAn1EuSoGguX3necABJadYcI18kqfKuN8G+YF8mhp6czsIxKZ5o?=
 =?us-ascii?Q?V2+AD+7mwy2WAzqFxlIyOZXBtUzdC2IBjDgNS2MlM/XrRCJryqHyQ+4R2FaV?=
 =?us-ascii?Q?MQDaOWzt+30/n2TfRn9woxiZBeQvm+9UmT087/BcJb7Afs/V8G/aX/Swj4Cx?=
 =?us-ascii?Q?lgNEfpirsDyjkO1gg3Mqx0gON/VM0O/QVQteRse6chwDoKpZHOSmsG+r9DkC?=
 =?us-ascii?Q?haUY976lfk/DXvofSc7G5z5jnbc7W0iBfQubrVlIFN7vuDBzzXXBEsE97o9a?=
 =?us-ascii?Q?t2Y3sOKMNghKoB0bgbiB9a5pYvQaEhE1RUh6yoWSAvuDZvZ+rHZIIcr9nCMi?=
 =?us-ascii?Q?w5punYBx1Ye0SfGLdQi6lYRlQmTnGnt3Gv2UuiWqDY5nA7HnNE1jsfurO1gA?=
 =?us-ascii?Q?Wx9bnnHJfKE8q4x6BQPt9hYHNM4GSt2KLaVyiSlyZcJ9dmaUpLU7kL8Tqx0y?=
 =?us-ascii?Q?oNUa/ooEbl5Go+z+KSrbH5T14xN/ud8X1H8ZlQ2Z9PqsHZuf9NrUpinNlD1k?=
 =?us-ascii?Q?ml9E2Njo044BPDx2eXtev3QmXTEBB2zTEasP8nmfn8U8C8G/gLEXF35XZtiv?=
 =?us-ascii?Q?YV0x/EGAcgoeJLguCnPpjoPv38begtvahx29ukoDm2MksSTjxxcO114NgmTu?=
 =?us-ascii?Q?bXX565rSgOcxnnJM+N/A/AP7LgnyMRngCB8nHONroZlOWrnpChdTiWcaQH+H?=
 =?us-ascii?Q?1qm1WaKxzDReM99W1NhOpyxUvvM+ABpuGWGLFqA+aZjR3xff69biSTQhQWB/?=
 =?us-ascii?Q?v1tsl3GFNs/ZqCBai3Vjrw4vRkpWNxWqQzEdpKpQ2UJD11tE9g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12c3942-5ae3-4854-4703-08df33cce4da
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 01:52:04.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256

> > +#define GREATEST_POWER_OF_10_THAT_FITS_IN_S64 18
> 
> It's an interesting name for log10(2^63).
> 
> This, along with log10(2^64 - 1) should be added as definitions at least
> IIO-wide. There is a series that wanted similar for u64.

In that case, might as well go all the way and add them to linux/limits.h?
