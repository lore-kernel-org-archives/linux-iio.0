Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB338AC68;
	Fri,  9 Oct 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561216; cv=fail; b=U0S0a1ZedN3/50V92SFJARdJXNRYM8uf2iDzmV3vSOS40w/gzx0MLu+5eJ/5DUshAlupU+XNar8eAadWcUsCMecBUo9v79P4B3DQ2t3dEU9N2cJhe6o96EgCSwtlgKQH+ILV9o9smYQwJxVQXCcC6tOnN/GbXJOstyAjOisQjDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561216; c=relaxed/simple;
	bh=ubAqMskhMqtqnZXFqvSgqqkyB6OR/Gc8rbO8qPfJFyQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QNt4gqdJHGIk4DHsP+RCPGo331FZiiGa1vwSCaOPwz1Mt0ttF8dUs0yPRkpEBGBjD4n9QTQ8jdRb5DnUiqraZAdEDUDxQzzGRGap1TPcfw5pTgdkk1SfKkamOlSTNuuY8rxlWcqNokvzGCTsQ3wsOKTi+nHDx1RZvRCFWtYCfqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=W8Wz9Y/A; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dPbhgEcW; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="W8Wz9Y/A";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dPbhgEcW"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DN9vU2289188;
	Fri, 9 Oct 2026 11:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=XBz4Rf9vdiYUNJ/08MbW4YlmN26AAvHZysQmb5t74gQ=; b=W8Wz9Y/
	AGX/Je/dfCOjPcv4476cYFJFoPTTkoMsbMtaYMKbOixeFBKgX9XgrzstmCgvUePc
	7FOxHjjo6/Xs1v8M20d0mAnxtaTHUMYTA0yfPKuAAhGWVOdBB6p1faYmEb830os6
	rFqx56lyWu/WVUTHFvf5BKdt8sf1TJUaoQhqVmQXuouLp9bx2EogwDaoR5w+NkNp
	B1QzYOr0oucbgY3WJLdYN4FSFcs64SPlM2dhubLLwMPVj/mR+5iu1E4a6kASkDlE
	EUua5kNlBinl0/ee8cywndrI0r41eC+p9o+TPLLPvlfrL4sUl1d4Roiiq9AHzuc8
	lLpsWHgzKkkjLHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XBz4R
	f9vdiYUNJ/08MbW4YlmN26AAvHZysQmb5t74gQ=; b=dPbhgEcWZILnHSu39OwWA
	/OtN3vXkwOdUa6dBBTaCwvf9Q630UK8nscfZCg6DFCgLmo8hpJjM+ePKc7N3apMN
	XB5tw5FKh3EqEbCCSI9BSmM0470Uwk18Hu8Oi5m9pBDacdFVG0MWNJeF+vvTXojg
	2WWCh9cJ0j/7rGDnsLwo6Ook3PNWPJo5CPwzivoRKuX7+H/bLCYqGLuaAwFDytkj
	deaxXtv1gJblu+Mmtn9e5ZBa1iZeNXKkCfh13UK3LPQ6GVN1xxBaJ9PfCvhfLzR5
	Q/yPigDeBA1q9lCNF7/00QDHDbI9TjzsCrmOhWrdGByf8idx2GSGwu8lN9KY4OtR
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h6kgmmvam-9
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:51:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+W8HUZEt9G5ZioAwjjY9PmYXwPUTBP+uTOo8kcVfo6sRQBC0xAflWRMSpjVayqBauvvZU7lKBJ7UsToUnGXLjAtyJYjTtJ0YuhbIAswWiaQRl2o0jiJnHFkWROl4zHTtKyZPpftHbrvxwAUu9krV8kE7L0bugXhVZCxNPasf2JuIVgqktGI9lGBlz6N9tSb/3uRI2cobtbmjJoOyJXJBb/gHoQwO18NASfKI7SRj8EmTnVCrx6dlnnY/ZhoMPPpFn4X1wz1pZ1TZoLVMTaEOuMacAW5aSgGOC0RiW0DJO1YSdg6vtVWl1My8ekxL3c6PrJXsN3sZJr/fYoApyvecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBz4Rf9vdiYUNJ/08MbW4YlmN26AAvHZysQmb5t74gQ=;
 b=t15M43eVGFSEROf/73wSEf4N7OlEsGeQd++/6+aNeXPrjaG3TaRw2lrNxxGI3HUluMk/zk0d64XIWRCY+bx7zTnuCD3JKq+8sJPC8XgrxZjoyauW7kvktwNXYDv4t1tdQjgsCOUQZnGshg7xl0DAIBry0ps++ZRGNKc0Vak+dXeLLX1gg2ry+SXjz7QcJPy1e72SyyWaEuIICj+552SyhrVHj5cXpOVh6bqJo8f56UGpj5ibyWaLWWchonFVAVz1tTrS6sC4EIdNt0wr9ZjbxIAft/Yp+Y4Fy/WEtZrEl10hfTq9GBjfDrSGMO+ph5f5sdeXzUYwnpyc1qrPmOCxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5051.namprd03.prod.outlook.com (2603:10b6:5:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:51:53 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:51:53 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:52:57 +0100
Subject: [PATCH v5 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-5-4c4e63a7a1af@analog.com>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=3756;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ubAqMskhMqtqnZXFqvSgqqkyB6OR/Gc8rbO8qPfJFyQ=;
 b=bqRlGxms8JD2UO8YInXBfUrmvHH7kiUNo8E3BkV6iDFxwKqGjanQAjkc2mZMmEJ4S20XCywhw
 JTIWoeyrE23ADDEudt7AfL/Ttt0QdrsguxlAbn1T6etHAk0QDlreyBX
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0002.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa11deb-7d4a-4bd8-5436-08df261d3d58
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 EyGI/QcFwLZvCZoJYgjin9jeKqWugvlaO5HeAg5xpxZdRRG+jnIoC7E4SOGto2hcMVu4SNO6a3ufrO4RxVFInbu5GXFSdUqNWFG4H9Sgx4MzVb8N3JMsvBUrhiy1WIXkLq1NSa4zOPoANUQJrNvcomgOHsjlsPVlwoCJJWrksKLKHvOEo7hdFsRHBG8HpHP6Y+z3ZHm+Ryv6zlVjHdiCWt1VvKAEhA5WnKjgc8fUH+A/fRIDb3VhX4u1S/v4u6aGMce5VL8y8ltPcSusGLTpC+4HLe3PROAeMbOMjtc6M/bfhoHSb681WYGLR15LQKmik+9TNVLFjbWZX7RfmysgqKMkiZ5SgxSvPJgkp48mjk1efIm08YKeBHcIfIS8ya10l4n1GUamDOpkz9x/Rh0dMVwt2uV8Xcm0gDc+pUT+Z+6gkLL2xGJ1oiwyAEEftK6Md1ZphEcHzPr4SlkdB6ej02NU+PPP53GFF32/ZISJ5KVVGVrFRNQ4IkIDJnVJBFxpfs955ITZGXKtB2sImQGIRZ0NRLPwMDOGSyYZ9vfLoDLcVV/iemF6ibHPsy2NRaOEjnZhp58bfnGyBTH4G/les1ylpajdll6kd2GyDstxjRN+4n4I607fjn6IPy7huNC56fyPFFtHJX8tDM2yA3yHovlbymUUP90HaIUXPvtwXRU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bEMzTWRLMC9WK2VXZm00ajJuaDByampDajNqN2N3bll6REw4WGZqS2RUcklI?=
 =?utf-8?B?VCtoaUZlNnRScG15Ri84M0kvMmQzcUtjaWFTTE5uWmdySHVtcUd4NThXYWt6?=
 =?utf-8?B?bXJUWWVmYzNPUnUyWHRPU01odGcwSTNOWlJBeG8yYVpscnlGSTZBVG4wQjk1?=
 =?utf-8?B?Vzl1R0crUEZ2KzVwaUF2d0ZFK2JGYmtnVzdVR3JRUGRFZzY5QnZicy9NSVN4?=
 =?utf-8?B?UDFJTTVpcWZacXpLTTlGaDhMYmxrNmEzKytRQXA5YS95VjNrRXJ5MWZKZGJY?=
 =?utf-8?B?eEZObThJaDZ5eE5IU1dpcTRWRmZsL0dJb3lsZml4RWJVU2l4cWFUbWlzZXND?=
 =?utf-8?B?SWJDYzBSY3RaZk9qdkpESjc3ejlBcENTaVBZQzdYcUdsV3dVM2tKQzVLVlFu?=
 =?utf-8?B?MWs3dVRGek9EeXRCUDJPeVBvQVhyK1U5bzh4SCsvdlRFOVowejZpRUtWckc3?=
 =?utf-8?B?S0hlQ2Vobm9GRVE5bWYrL3RhVHA3K1hNNU9LSC9QZUJVbGJmRXpWQWlMN1F4?=
 =?utf-8?B?U0g4S1FjZ0xFczN6ckFiVVVJNjBDQlY3UVVCeGJlSFFUTUV2QStZSGYraGdy?=
 =?utf-8?B?K3dMZFBlVEY2SVdoNUIzckJFOVNldGVtUjExWlpnMGNrd2pFR3hLVk1pTGpL?=
 =?utf-8?B?ZnhIeWU3cllCRWZDR1dKY3VlUTZ1QWdXVVNtYnVHdW11djlVQUIra0lyZEt1?=
 =?utf-8?B?UXBBVThXRXZYNndFNmtGUTdzVWRvWFJLMmF2eTJvZFVnc3ZtYTR4RXplR2N1?=
 =?utf-8?B?UWxVRVlIQlZrU2tnZy9kemg0NTlVelp2a2FSbitnVit0d1hVQXBjUUwwTFhT?=
 =?utf-8?B?VFh6K1lmWm1iMnl5L1loR0tVVGpTcEE4Z3lVL1hLOFk2bEVSTE9zMnp4MGRl?=
 =?utf-8?B?aVVQVWFIS1kvN3B3YjBsVFlVMlFqSFlpMVlMazlzR3BIUWtJUWQvZnlob3Jx?=
 =?utf-8?B?MHhPQjhvbmFucnFEM2xLcjNjUXNzSVBBanZwZkV0dEZ3Sk04SzJxR29tK1pM?=
 =?utf-8?B?YU5BbHQvRkJINVR2S1krRmJkek9uSFBZQi9HMlNxTHZWTzdtcFFQK3BJT0ll?=
 =?utf-8?B?TjhVdVArTmt4aHZNUy9ySWRVdGttUGQ1Nk41WVJmUFhIc2hDeXV4Rkg1Mmk2?=
 =?utf-8?B?Y2xHVDFRSktKVkRnUXRsdXJRRWowTE1zdlp4aUdkczJmTmhMSTdRZVJjT2xU?=
 =?utf-8?B?STdoMC8wcXgvTzdsRW40ZlUranl0T2lEOCtaN3VnM205TmRWaGgzVzBaN2Z6?=
 =?utf-8?B?OWNzWjBUY0NwUzhQVlRZRHhXTiswZnc4WXhiZWZzWnViR0oyT2lvVTlVYnc0?=
 =?utf-8?B?enJHbnE1M0R4R05Cc2YwbFJ5eEdlczM0bVh5TEdzNXZtdHVSM2FDQVUyWm8x?=
 =?utf-8?B?bE1FdHhMN0c0L2RYeDRJUnNPQUtoN2hNZTBCNFFXbnNRQmNRRkwxZ3B0a0p5?=
 =?utf-8?B?N1lhN0VENktpS0FQTUVuMU80U0ZSN3d1SHpaYkVqUTNjYlFtQVY4SHRqbTQx?=
 =?utf-8?B?ZE93NndJWXJZVXp6UDdRYXRLdHU0MzB6ancxdFZsVUdOeTBkekZTL1RaL25r?=
 =?utf-8?B?N3NwVUtYc0svY2JkMVMzU1RrTXlIR0c1YmFNaml4RWRVaWIwUFR5YTI4a0ZP?=
 =?utf-8?B?cGJyajFzUGhmM253LzJpaHlPNnRQZnhDY2FLeDVoWnBRNnVpNlhEZGJmaEt5?=
 =?utf-8?B?bFFzaVllVzJWTmJCeHZ4UFJiWStncWswY3VWVVF1RUlBd2dDbTZ2bFhweENU?=
 =?utf-8?B?RUpmWGxmeFVFc3o2QmJjNjRNNDk1QnkzYW9JTUZFdHoydUtCSlNJWk9KK3A3?=
 =?utf-8?B?d2NmYXRXenBpdWJrYlV6d0JkVHNBbWdLMjhEaWhNcTRGZVZpRElnZkU5dlFu?=
 =?utf-8?B?eDRGSnJ4b0lydEhqWmpybm5BQTJHSnJuZ1p4bmVONS9vQ3Y2VzM0WHkzd0VR?=
 =?utf-8?B?TUJ0bzNKZzFJQnF1RDU5OW9IOXNEcEdWek1XOGpaaFZlejlscVh0S0ZHQXRw?=
 =?utf-8?B?OHgvd25qejMyNDBVYjJWZ0xuYnAzdmhoTzB2SW9FYkp6Mit1UmU3VWRkc2ls?=
 =?utf-8?B?TFliU3dUMm9NM2VrL2VuQkU4VFkwU1R5SXhxSENqTHlDbWIrQzIzdThDT0Nw?=
 =?utf-8?B?SHM1N3dxL2dzQUxJQzFZdXBTRExQcUFjOGQwUUJaL1c4K0tPaFNMeld4MTho?=
 =?utf-8?B?RWdEZkpJbnJhdWI5TzBJNUk5UVVNMnNYUTRXVzhrZFVzb3U2clNZRENhS2Ny?=
 =?utf-8?B?YUg0aFRFNSs0djNFZFlYYUxtRXlpVFFDUEZSSm5IUXlEQlBKKzFaajRaVks4?=
 =?utf-8?B?RWJ0VEJJdEdpWU9UOHlWU3ZCSHE4Tmoxa0Y4WUZFRHg0OWlvQzh1QT09?=
X-Exchange-RoutingPolicyChecked:
	AP3bC+mxtRkVooCYpkx4KAOJQoe06CMXudesturhsbFQpz/GlMQloGzccZ6H2FKXN+yOJ0+ysyfznubUxmWBiKKPRVO9bO1Fwe3yg7kv6moAW9q/ky3mwLB3/hJnJyp0onrnkgV2Vjc7B8Fxniwx+kcp7MThgOtvO/vsyQEYG13cY9RhrAZ7ejqALdD5j0wX4PeWtg2U0gtPmwMJT1Hwe98dAt38MJtlZ7UERnbyDh64YvGVAa1W6KUI9kcEAMBg7wYDlZlDTO4/Uan/MQak8C5DSKfSr+lkjjzA/QeSUNUBXqdQhKUBB0cOhPb+QaSX0mZQLIrsfMD+i/luTs5SHw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa11deb-7d4a-4bd8-5436-08df261d3d58
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:51:53.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT6Ov+Qzi2XKpv97LLqLC/euH0rvNozBcT183kgQISue2bZZ3CPZuEo7pFUCKPNuODCT7QqRH2lUgSiFBgWIYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5051
X-Proofpoint-GUID: JbHC8ZQcF5cpN7wLPCq1_N5vhJHfhMVf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXxop5gVOa07+F
 U5HIALE9eHKEJCnVaDSw7AUISwfcD4mcfKFCSLpAtEOs+UY/y8G6UQjhhKaTs3PN+ZfsuAhO5G0
 VDEPEtYTEBcIfh7BDvWqQ1EcIBgvLrMNhrVW25A7XCYuGBUuO6xl
X-Authority-Analysis: v=2.4 cv=Avx7T+9P c=1 sm=1 tr=0 ts=6ac90d9f cx=c_pps
 a=WfYMUjdTTdEkkNza/pHfSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=8AirrxEcAAAA:8 a=8b9GpE9nAAAA:8 a=gAnH3GRIAAAA:8 a=hoLHniV83FUdLTyWGJsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: JbHC8ZQcF5cpN7wLPCq1_N5vhJHfhMVf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX3U8tZcK64rst
 sbPh5Ic8Pxa74VgYTCEpOr/7yfg6SMbVxZYaZeSte2UG3SszDOjxLk7xcCWDpGKjjVgUAm+SduZ
 y/YM7Bs2907oCRtlP8rHFSkAK9zRAsvig6h2GaXD2uunoZwXSRbTuabl0DwbaATwcsCMZckopb+
 Won0WhB7wkhvvCmxMhxOw6BpNhFVvJ6C8ZSIYigtE/gvw7NAhmFI4fIaFD15lwef43HverO0pRI
 Ivg7PLgOdzQz/VtEkHh1C2tZ/j9oRXQvMw1MfAJ1P+1pdvxZKXxJ+a/Bzv1lue7wrRoN1FLaB2U
 6jy0ECKVALofEzdr1t/1DJqtfbHuJglJ4XY49vUfhCBSjzk5epZTNNjWv6eV6BwrykdGfm8m/dA
 0wOLNVVamRm6wtR0+JHjzB7B/7NqrRuCsIyQ9+eq0yt9ZhzR/I/ItvDMNt9C5y0bPuJ7xvqh8q1
 CK5BXbIQVCkMvtcbSYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090063

Advertise the controller-wide bus width capabilities through the new
dma_bus_width_set_many() helper and clear the per-channel unsupported
widths through dma_bus_width_clear().

While at it, validate the requested transfer bus widths against the new
capability mask instead of the legacy u32 one, so the driver does not
depend on the legacy field anymore.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/stm32/stm32-dma3.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4fe226541efa..8a8a0b9ab507 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -583,7 +583,8 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 	dbl_max = chan->dma_config.dst_maxburst ? : 1;
 
 	/* Following conditions would raise User Setting Error interrupt */
-	if (!(dma_device.src_addr_widths & BIT(sdw)) || !(dma_device.dst_addr_widths & BIT(ddw))) {
+	if (!dma_bus_width_test(dma_device.src_bus_widths, sdw) ||
+	    !dma_bus_width_test(dma_device.dst_bus_widths, ddw)) {
 		dev_err(vchan_chan_dev(&chan->vchan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
 		return -EINVAL;
 	}
@@ -1464,14 +1465,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
 
 	if (!chan->fifo_size) {
 		caps->max_burst = 0;
-		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dma_bus_width_clear(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dma_bus_width_clear(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
 	} else {
 		/* Burst transfer should not exceed half of the fifo size */
 		caps->max_burst = chan->max_burst;
 		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
-			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dma_bus_width_clear(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dma_bus_width_clear(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
 		}
 	}
 }
@@ -1729,6 +1730,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	struct reset_control *reset;
 	struct stm32_dma3_chan *chan;
 	struct dma_device *dma_dev;
+	enum dma_slave_buswidth buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+	};
 	u32 master_ports, chan_reserved, i, verr;
 	u64 hwcfgr;
 	int ret;
@@ -1770,14 +1777,14 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	 * channel, and can only access address at even boundaries, multiple of the buswidth.
 	 */
 	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
-	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	ret = dma_bus_width_set_many(dma_dev->src_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		goto err_clk_disable;
+
+	ret = dma_bus_width_set_many(dma_dev->dst_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		goto err_clk_disable;
+
 	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
 
 	dma_dev->descriptor_reuse = true;

-- 
2.56.0

