Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311712;
	b=2Ye6Svx4XsxPZSkibYnM8iS45gw50RWShHSKOtWOj8dH62EV1uV36wSaoLuqo5aCRGSR
	 ffJvmGFWLyPgurrVsE14JNm6QGErdv5zmb/a3aHPk6kUX3xTQmlJdvLrcPMc+La8Hm4my
	 EkpN0aTvacF5ZCrdgeEpyHFXAm1TtOTkz8t++jDqDcPEUlWCTJxMaqZ80ZikmyJLzSf8V
	 myyAunlwR4OIqOL7CboepIOQ4okGTQrVh2QoRP1a1o/QZdE0joZk4JEmnpLvW8Gi4ZzG8
	 f26Tl3fCi7tNK7Q1R89RJyU40sdG8cKX4xKBz5H1NuL7RRmks97w7lfd2UeQNQzpSHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311712;
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
	bh=9tehReWZepAVd84Aey9zm+1K+nAt9gNgPoPTE7PfRVM=;
	b=v2qMsIiClkVGAtkNf19yKAuCvuOJLklSwPNfZSYTauQrA3qDeYQ9sFdHOFZSAaLBOmQz
	 AIDWnD6I3u2pa+NaiBTa8n2IvV0Pe+9nenFe2hMUTkQTVRI9SiA/wnrSB9PZvOjcaH4s2
	 XzSD2wgD1p7pgIovHyMB+jQkIlF64gKZq25jFkSVeWffLDntGWrhb4wtKZqAqTfNtvuVj
	 s05NpRal5+YDfiDDk2IdEYXTuoWQo20EauNHyOpbSFzI9crj1cq4Hm9Sruw+DPGMplcz4
	 y5VIuYl5J7j3lMNA96v9Jf75jCs/hgJUIlp7LPD9GuuE1LAr1YpPnTP2HVhIjtouzMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EkzHDQ89;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.19
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010019.outbound.protection.outlook.com [52.103.23.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31984606A331;
	Tue, 10 Nov 2026 11:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31984606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EkzHDQ89
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCO2AdaQHgJBQB8LsZ/1CiF5QePY/L8VDOdm2COicg/e4lJ0PQ6uH40BOueNAyhWtCgX2gvPsk+neHpZx6K2iaMFU6rE3R6i9XsA1MgXJmzZ1N09mmuQg1IW236o3YONvs3ZmxXgDFBKw4LcLcFUJvoHI1OhEUDvAaDL0eSgRp3NBZKEzmiLtdqWSbdWfeWZwFEpjP2ik9uG8s5joek1pHFHbbMIsihjEGZwg5KsdyKKO6A99wGLmgzSlbH8h8d9TkyzxNaEHh6j0qgB3Xdj9yMoplmCEDbs7vowWG4NF3wTD/CVLu62yNQEnleb1iiMXpdmBV8H2fNn9DHrZXUU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tehReWZepAVd84Aey9zm+1K+nAt9gNgPoPTE7PfRVM=;
 b=EGgbunGbllL2qJxsN/1nt0PP5bTr5Ax4mRtVcGNlW6Zfgsqgg30aM+w0xZrqbqN3S0iGC2UjS9HVdvHE1CfqDnhFGEMSLtnlhLysyu8gyNzVJmre5+rUedI7BePB6V+mIPIGuTBRkRrhpJ93So3Jt1gHHKsaeEbz7CnkVzpJ6rXXFV5zBSVw+GlQtukuQ3TkR1sw4B6hJpPRL9XNNDo2bdlI9rEp4QiDfvpbLF2fSMJ9sDtuQewHAxUdkW+ve0q08FOAfFsME39Vsc882bcyhWCbEv3uWgA8sMm3CsrRif2lN1ZzLRgBRz/enP4VKcnDWJSmfIPrMs4JzQ+OoUBVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tehReWZepAVd84Aey9zm+1K+nAt9gNgPoPTE7PfRVM=;
 b=EkzHDQ89Q+ptWb2lIwZoHhGtaKcLXSrGmLWZ2P2WBQ1551jmMSCNJNwmqLI2J2krRREw+egAFrOeNaTwEyrCIy9qqLvLHt/ippSHQloPcmcCfpt+IWa9LmDYB5hNYepl3yl/4aG/ieCXZEH4zpo/pvlxu0GVwYCGIkYsuwOWJ8NNuoMdkKijLa34nOZ+VhTygDf+fvw0j37412bvTeBV+sYh2NWHs/qYgFfXh8drDnUbMGJ2uAOMIdjTc5xBC+NeZbHUt30w40x01h7RRUlUEdwfA3fSql5+RGWho1fagy02+WUfzgYvANVfrIejH7g5xa+dF/Vv7Zo2s1dHgVa+pA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CH4PR12MB795688.namprd12.prod.outlook.com (2603:10b6:610:518::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 11:55:09 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 11:55:08 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v7 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Tue, 10 Nov 2026 05:54:58 -0600
Message-ID:
 <SN1PR12MB2528684E196432864FD48626A5722@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avLpEA6CoZvicvDN@ashevche-desk.local>
References: <avLpEA6CoZvicvDN@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::23) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261110115458.1087401-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CH4PR12MB795688:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f67d770-a409-4916-9363-08df3f217660
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|260925184616899003|4140399003|24021099003|25010399006|23021999003|12121999013|8060799015|5072599009|19110799012|15080799012|22091999003|24121999003|41001999006|1602099012|10035399007|40105399003|52005399003|26121999007|3412199025|440099028|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4TDwScSYByPjnXa5OiqAFPBkT75r990wMO3m2BFEvNWKfBzVllrpDZWjLxWU?=
 =?us-ascii?Q?ZnhMkYCXISRHxq3MfG3XEFBVnds9m4NS05Jnw4obOj3vSd98bc2tsPulu3Yt?=
 =?us-ascii?Q?E1DlPEaGjsArFo1+XkccS3Q3ViQ6J8zpNz0EQjuLK0naDc4teKewke5y6Div?=
 =?us-ascii?Q?nuSjkC5r3LpR+D6BFn5nYlO6bgD1PK4A/hHaZQlxZcVyCfxbFlhWnUpWGf8p?=
 =?us-ascii?Q?xgdFVyklH/h3Mwpp4fNt8S1UgUn/ZXtHws72KdUGSjOM6hCiMD2UZfhGJV/t?=
 =?us-ascii?Q?R+D5strPtEaIQKG1Czhzt66ZjCKpnJ4Ik0j6YZtqFnh56pFz20Wi+BptolnG?=
 =?us-ascii?Q?2kItwqd3GrcNRy3y1XTZm/HtI9stKXX3QgtPiZqOzyty+U8WZ5xXqww3d+3I?=
 =?us-ascii?Q?AB63zfqSOt9TF10xj6TE9E5F9nAMlywIILb7z8+kUDlVuJV1ADy0qZCnXQwL?=
 =?us-ascii?Q?VX1I49UuYGy28a9/3cndfpkB8VfGnO1weYFOIL5G6xsiSIu87WRY0EItWg5O?=
 =?us-ascii?Q?8a72vG0ECrH20MW6vGtQR5RyKdK1ycRKQI3VkgIGw5QOhlw5LFTqUW1Tde6a?=
 =?us-ascii?Q?hRkivcGdN2869Fgk68mBWrvblwQkE3hDrzX93kTN+QfvUvLs9VyHP6wDcOBA?=
 =?us-ascii?Q?bkvWLIEP1TnUFiHCROq3wUzW4UiOXvCJLPbswaVQvpHglU+8p5B6l+F5T2FS?=
 =?us-ascii?Q?wXMqB5om2jOfDQS+K4fgwKzShhwkZYoA4hVKkFk+tPdGyFPWxxjsaYlDRwuc?=
 =?us-ascii?Q?tBvl3IUHuYfYrKUu2Gf//9sE2X01FGddkBbM/dAEd8ZjNDZ1zpbfxQlRG9lI?=
 =?us-ascii?Q?90ozXKGc6qQV07hzPqBOG+w7KNpGgP6wweipp0JOrSsKWTVZiUih9YB9KL4v?=
 =?us-ascii?Q?Ed/hlvYRGF6wRrE7TpdnwlmI8rZBSAtZyiEIKawjGC5fA/0yZuK1Ka1pj8KG?=
 =?us-ascii?Q?NkjKi9bJhyHPMU/I51nciUzi9UIrLIHytmxaFmsmYiA6dtphLsp1n1e0ecGD?=
 =?us-ascii?Q?V2lN1RqLbaz14x9cqmkrzDXUSfxK4521xaBednZrQ4AVDH2UvFIVvtAKxAj0?=
 =?us-ascii?Q?WbZMpGoAWs3cgIhmIAchOylB+xPGmrJz/ptrims7VdtAixkQw7/BB0FCncwc?=
 =?us-ascii?Q?r7Zxk6xspj+/NT9s/RF3zoL75s01x5271fwG4jx2BtNDR+/TmTXI4Lg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?StmmJbPMP82sd/N8f5YnLIjBfEnWr40HJen6/VUgZc0H+PbH7vwnQEvy5YPz?=
 =?us-ascii?Q?l/6Xw36NvwC5YLab8IVGM4tQe5nQMQQZMqbH3WPFhs6N1jkzVkiUMR2dnxjD?=
 =?us-ascii?Q?U7lAHyICX+7+VUxrMjDoU5SPtg9KZy7+XYHeMEMLM8YwqCXArZOhPyCwQDLm?=
 =?us-ascii?Q?14uFWLmympXkLKRLlx1otqMWVFwYpm8ahjS0Wn526GDNRb7EK88TAq+WElpu?=
 =?us-ascii?Q?u3qXSgsmAMGqNIrWIs7XOy+E0Owd7hFamNGnu6gYbwvfy9yQsyyu5XeFepbR?=
 =?us-ascii?Q?dnqnMjv3FFSzXTrTAKKrHu2nQOeSMWMyn0M6mNilrk6Xlfsvv7fFNm83FWt0?=
 =?us-ascii?Q?Ziwqfm1ilEifpXtWVf9/T/u/oJGSO184XFWwe+zZnPHOb9Ianmz9/TaRL6vF?=
 =?us-ascii?Q?HecoQ8Fb+jkfsMzhjZXTiNDlyIKh1ciHmOHv3yq43WZq50AxwyU7+F7IAw39?=
 =?us-ascii?Q?fXSxe+HR/1UMCPOjB+s0FXiNHtXZwPbO6bn9UHuzsCg9ZQ6cpheHZpsEP1q9?=
 =?us-ascii?Q?YrC9/ju+EY61dwlZaSjFQcsbla9dAp8DWWuF+FKeHrMVbGAQ4laQR5lKzO9d?=
 =?us-ascii?Q?/ddRLwPy4gKrwdYB0/pW6xvAVf/TfYppzhZIn0xWX9w+sbWAz20bqUCMxHGY?=
 =?us-ascii?Q?ZIbvssE3jpepKnsxCbsSzueXPo2xMf72mk/YVqiJtWsTC5CMcDLpq8PU+yB7?=
 =?us-ascii?Q?DH8Ys7uC7F2kuM03YUql0SAPRYzgeg/sWWexhw7ygehc2sN2Su041prF7eUk?=
 =?us-ascii?Q?0XWAc8MaFG2q+ayqZVpSZi30eef+8TRJ3igNYkSM7UyMzomy+I7Zph4d4Ab/?=
 =?us-ascii?Q?ORwvZn+zu5wbn8xoUP3UEkzDm2m6bm3kDLRebjJTGcEq3rZ4bYrU+EA1RO62?=
 =?us-ascii?Q?6O+LIn4swkDG7yKBskrOUzSUQ4CWcRgjmv9Vxx75Iyola6WsPmsHWiA0bEfg?=
 =?us-ascii?Q?zpgivG2GcG0Rn8sKSJxEW+Vyq+/FEYaUvXs3ZwKs/slYECzQ04gAtMVOuiUU?=
 =?us-ascii?Q?L0m5epe6iO4R62z36JBZ5zdX2Pmmy2248LUDZkYA8v2ov3BUJkQnPixHzLzJ?=
 =?us-ascii?Q?/+Dyrnbf9xY9MApZXafGRQ3OhGQm65RqkeGLL/t48gezvjSOFtQ+ksXHQ1mF?=
 =?us-ascii?Q?OkVK27E7QT/hNDiR30QTjUPXoeU0bJKwggt+R0a138NgqlJ8SBm6uZQNiTVg?=
 =?us-ascii?Q?ST6n81huacoT9y+a1rsYff10pH1HNjHiyP51+xx2Meqqk3OvN/HQOYOkuNxT?=
 =?us-ascii?Q?cT+Bpsh3lVqUdmYipf0lBV1UooF2eHCCuFCwxfj1Crymw1/6S2mwLgNSfJBC?=
 =?us-ascii?Q?JtFL5L0gc9rpD2MZLpzwyx6OdjN5FhJF4pAFEiDOTZ2wT+uvwZbPHHHTLNoT?=
 =?us-ascii?Q?VQ7PTTaQBSmcsYFlV1YOSh3CqFBOkAs2qR72GM5qCP5FJwOb4Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f67d770-a409-4916-9363-08df3f217660
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 11:55:08.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB795688

> > > > +		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
> > > > +				    (u16)DIV_S64_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
> > > 
> > > Why casting? Shouldn't it be handled on the regmap_write() stage based on
> > > the register / field description?
> > 
> > This was prompted by this sashiko review:
> > 
> > https://lore.kernel.org/SN1PR12MB252888B43D53AB1723952D21A5742@SN1PR12MB2528.namprd12.prod.outlook.com
> > 
> > TLDR I'm not certain the cast is necessary, but I'm also not certain
> > it's not necessary (if regmap does handle it, I couldn't figure out
> > where), so I've added it out of caution.
> 
> Yes, regmap core code is tricky in many places. So, as far as I read it,
> the I2C default bus with val_bits == 16 (if you have no custom regmap IO
> accessors) uses internal format operation regmap_format_16_be() along
> with format_write kept at NULL and hence defer_cache set to true (cache
> after formatting). The default working buffer for the data is work_buf,
> to which the above formatter puts the data, it doesn't put anything outside
> 16 LSBs.
> 
> Since the code is tricky, please double check my way of understanding the code
> and confirm or point out any mistakes I made.

So to explain it to myself, the call chain is:

regmap_write() forwards to _regmap_write() forwards to map->reg_write().
What is map->reg_write() at this point? It is _regmap_bus_raw_write,
because that's what it was set to in __regmap_init().
_regmap_bus_raw_write() formats the value using map->format.format_val(),
which at this point is regmap_format_16_be(), also set in __regmap_init().
regmap_format_16_be() discards the top 16 bits.

I still haven't quite grasped all the logic in __regmap_init,
but I'm relatively sure of that description. Okay, that makes
me confident enough to remove the cast.



