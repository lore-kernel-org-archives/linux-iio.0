Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DE4ABBC6;
	Fri, 18 Sep 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720768; cv=fail; b=cFAs+uXQi8K0y/4rZ3Km3+35y6ESXbEqss1kNRQVQphqjCbC5b8LCkmw+uqs4B5XEiy12mR+1Xg/c7fWEbFXrlG+AfCARtlVKb5rM+nVFj2DeAMi2PT7wsRWVSbQqTdJ5UvrUvc8xz0XJuRrEyIZGr3k8cGuz9Ji3qGfKoV9o+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720768; c=relaxed/simple;
	bh=5fc7WUlDaYOlDHy0nxMkAoV5P144dKPfTq5dYM8bYWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eIhJcaDf/Z1zvPOnRj8fv7LvzgCxlejoGeQu/DFF0UYFFIUBNRZCwOIkKZQMy17CQ0I1d982EZknp164gHk3zoqgPJuur7PwRvSKziF2BqLr5RH6jYoeOj4F/Uhy0JAnjLq80CV+nJr+dgOx97sa1xp8XEWp2VEFMsgfAy3I5aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Bm9ulXs3; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Bm9ulXs3"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5vxf12176671;
	Fri, 18 Sep 2026 04:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jAsiw
	qEfRVp5EbIEQvQChtWcQ5aUzQA8EFiUTtGfO6E=; b=Bm9ulXs36qLJmh8yyW8t3
	ma6IBfnRhJEgt7KDKnPKwIS98dQac/xUMl8/bT1mi+4fQvB1dMYCsweMl0I0Zd8Z
	5WSuWAxpeW7EoW4Gl5THcrVlV/ZdEDN3KzPgG6ZMJh+DTQCrOdHrOrs1waEiU/MM
	SYVb77yKvEpNJtHphMc2FA3MCk6LWOrLhsGhCUgIoIvyltMGeYDBpD8E8lutI88e
	Js2HldKcAzevdiSI1oiyy/rncFCier82WPz94YkdadidvYcHWuoWwZDcNypPZy/U
	NXVshBlQK3x9Mn2MzrG46beIaMJa0jXWx5btXD2IFBn9+S5HtByEjeopD0UwFfD1
	Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gr7pae20b-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 04:38:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xR7RAVDue5FOfK2vc3jN9i1oKkPo/HldOw8ggDs+vBs7DEWcXAS6IPiQvFQeZWe207fMp1xfhIwzsJJs3kvJvF3RVLzDigeslWorifTC34CrYSQXmyfU92SiyiGRXRzrfsxZSKLfu7SOKmAqYbohBz+AIcjbui3E/RBrvlZ8UnYbGXbAZDYMSH0WwxZk2QOYAqrsKtijibx1NQDUdFzEOOIQ2OR73djRkfpKPSp8t2op+umlDaJbvfzVhtpWbr0A9jSU7Q9oPVaLJR5dI1x98HHDt+i+O/kS6CIuyMYP++cYKJWSRm5ohfJzvvxLMuwbc7DHLKm2IsrSyXyNnBGRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAsiwqEfRVp5EbIEQvQChtWcQ5aUzQA8EFiUTtGfO6E=;
 b=FHGrYKuybV8WWHnys/D1dKGiNBZSEaza0wu2zA1PSpENfDK1I2GWSeChY176zCCVMqAvq5Jfie8CoAMospMG6yqmUwnfj0v64P/dEw5pgbvlikdlPdsO6teA43SNIx2S9hgSvPEvD94sDau38MTStZ7l1M78Y+Qjsxg+g6yMVrl79L949LAYx12S4q5t2XbHT4F+8c8gKpMG92KtJTo7Kll+z+Lca+3nU4eWOMf1NkTFZo6LW7WGSHffY6mvcbV0RHOYB7s1OQp1h0QhTE7gZZOOjuaNzoTdZxmEvlZmSVTn/t1Y/XEr8RzFbMENMw9DvnrcyrvG5fl+CjqKe3F7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB6939.namprd03.prod.outlook.com (2603:10b6:510:16d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:38:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:38:39 +0000
Date: Fri, 18 Sep 2026 09:39:55 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqz1-OzFobOROuBw@nsa>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqws8pN2rfS9-dCC@parshuram>
X-ClientProxiedBy: MR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 719c018c-7e75-4073-bc18-08df15603ce8
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
 rhPO1UYcY9Wvf4fBPBXmcT0q1LWraEtBJZuI0EzRcuUrU55V0HPZHxvQFWyMJmJZUI07dXJs+ExMRE7w7MOyr6e0Fv0tr3C3ZbnDwM3xNmp98Cv2Ziyim0v3Q56ZXhdoJdWS38uDAyRio6EONxA6YTUU80qE9pHHga8vZnri/af1s6eolvxGJUCZZxYPO/KUsVElIKPBecE9n2V2SNtgwAzcnZACvGYNGZneVA/oaQvjmpW5UAKR7Z30o9PV4zy+X0ooTTW+rHwAH4EFfzr2AfNIeKJJRKdsW9NRmJffU99d5tfJkKUv5GZEPv5zFXyOLCOpauExhFzbyB6fLL/2grjWzd0G3Wme+UA6zUz3eajhLHavyKYQoRnK14CG83fNjsave97+FXEwiFQ0DV5GQUfkpHJ2xix9hwn498xLMsHHz15zXiFklwV5qwfADZJIkNRj7/46LGagJm0yeGeOBTFUXHDPF17LF4H18GpYPSd9ieZGRdRB564m7OF1iMt2J+Fk++Gl/lpXa1Ryy/R8oUSv6qNS0ujg1dSGs0PgwjkhS6qhYRsquA4g8HkF9Qt2Ph61z5dRL+UDuLngjOM77aAgqBxNSmo3UGPHy1KIcykPbESn+Vgl6OfOZEcGzV+GrGTjtdL1pG2kctdmpue98sT+c4a/uQ1TxfJCvyzEkbg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d0ZNS25MSkFnMlpJNXY4b3dSMFZ0VnR6dVZ3aU1GRGNYcU5zd0t2RU1EbnFR?=
 =?utf-8?B?ZTlvaGowRmduY0tXSlNBMkxpWGxFT2V6OG9nT1c4L05OaWdwUjFzRWh4WjlI?=
 =?utf-8?B?Z0U0UFRHamd6cXlnVEtKMDU5NEQ0Rld5ejYrUXBTNElCWXFWVGdhRlZvdTd1?=
 =?utf-8?B?Z3hlOUs1dFhxVVJjS0N2R2tRYnVPTWdhQkRtTkFmTkxuREt2VTNjNWZKTUlk?=
 =?utf-8?B?NERMd3BsWWJCY1lYMDJob0RNejd0cDZKWHNjbWJ6R1hMT0N4anJ6L3NkWW1Q?=
 =?utf-8?B?d3k3ZHVRbm84VUpmYmVraHNzNHdOeG1sM3NkWXZTb3FCVjhxSTMzK1Jxem45?=
 =?utf-8?B?MGliSjBFMWw4dUdTbWtKd0UrcTN4WTR6aElFVXQ3dkxpU012RUg5S0Q4eDUr?=
 =?utf-8?B?eWxpd003azhrRW81L0FwbmVtRXhiMUdEOExLeXZNb3VKRW5QY1NVaTN0QU82?=
 =?utf-8?B?UE5XVmsxVVlxdElXTDZwRDRqT2FmbXNqNHYvU1dzMm4yMzFqelJlY0pDaDVv?=
 =?utf-8?B?a3I4ZkZ2UUd6Q0NaOEdObE5EOTlUVmN0UmxFU284M0dVTzJzMURwZ2piRWQx?=
 =?utf-8?B?cWt4QTdWQ2JPZnFzZTF6ZmNVNlIvUTVvangwbHVyTTdSV1c0QVUrRktqVy9V?=
 =?utf-8?B?c2FXcVIxQ2UwWDQ0bVcya2VGOTBVSEpCRkR2UkprQ0gzWjVRbXFNcjBBSEdz?=
 =?utf-8?B?QTdGZGo5UVlhN2RvOUQxNGRydktheHA3U21ySTVmb1QrT01WRnd3RU5wRUt1?=
 =?utf-8?B?RUhBTHZLcVRDdVRaVTRPSC91aVU0WFRhZzdKaWZkQ05peEJoMUdoL2I0QndI?=
 =?utf-8?B?Zmxlc3FrRkF4dmVYZFZ6MzBNdmVwOEdtSjh3Z1dtM2c1K292Q2NPYStrcHlX?=
 =?utf-8?B?TmVqVnluQVFXRUVvbXpQdDVQOTZRMFpZVnFFTkM4Y1QvNkwxejkyYk95b3Jo?=
 =?utf-8?B?WXk4YkkyVTJuYjRaa1hCTDNiRTljSm9pdHdXU1htMEE1OWJyRi8waWo1ZnRP?=
 =?utf-8?B?eVBVTWI0bXg4N0dEbFNkVVNSZW9KQ1pzVGxMMXk1MzhNNndhV2JnbjFnNkF5?=
 =?utf-8?B?NEtmTkxZcmltWk1JVHd0WVB5QzlHSXZKQTFIb0JxSS8zclFEN29RZDNZUkpj?=
 =?utf-8?B?cFg5dzh5dEJrczgzMzdYaGt5SFEweFZLa1BjWUxCdkhTUEhWRWtBZ1lya1h2?=
 =?utf-8?B?dnRKL2pHTTYrOThWcmdmTHJWZnNkOCtjekEydVg5NHZUanRJc3ZrMml6c29P?=
 =?utf-8?B?U2w0eFlmeG1LdE50RzZKWmNQZUsvZlBMcXc5ZDdReXFXOXVXTVIxa3pYWmtQ?=
 =?utf-8?B?MHNNdFYrYUwvak5ma2ZiVFNEZlpVYjJuRFFXTFA0MERQdFNvLzVxQmRnVzh2?=
 =?utf-8?B?U2VIeUo2OW5nL09MQ0Z2ZEs3ZW84RUdxZ0RZYU8zMkszQmI3VUNWaGZvTncy?=
 =?utf-8?B?N2tBMks1MUs1dlpFd1lzK3EwbmFTQXo1VnRyZ3YwYlhaWnVmL1ROSmxMaTJh?=
 =?utf-8?B?aFI3L09IS2tXMEtiUjhGbnk2NFdLTG5uelIxWEhWbm9lMDJQNUFjc05qdnhY?=
 =?utf-8?B?TEFGWnlGMzk5SWM0S2pkVG1zYXduV0dHcWNrRzJ0UFgxeWZONTZjVXhnWjEz?=
 =?utf-8?B?WElldUVoSkJVMlN2bnhZTE1PTnBjenZsSDJoSnFGenlnMC9QNXlRbXp4UUVY?=
 =?utf-8?B?SWJxeUJPV0dEODdFeE5Ya0MrTFoxUE52b3ViTzJwNC9lRVl2cDFYS0UrdjFF?=
 =?utf-8?B?aFZXZGJ1alpJak5JN0lWQzk1KzR6SDFBellpSTN5SVVRUXVKSFVnd3pRWDJy?=
 =?utf-8?B?UzJmTG93LzEyMVA3MDQrb3UvWGtEcnoxeTZqWGRTTFhyTG9ZTGRkWmhIWCt2?=
 =?utf-8?B?VHNqZmE2L2Rhb3piYk4vUFU5YjhENjNybU1rVVZkL2pIaWt0UE9LaHk5QlY2?=
 =?utf-8?B?ekk5d09zQktlRWZXbnZlZFFmRk1TbjZJRVFsYmhnajBBcURSWGRXcFg0QWdy?=
 =?utf-8?B?WU0rYXlqUUcrNkV0bUtnRkMyKzVQV29QYkRpSFdiTjRGQ2lLc0doUUpRcnoy?=
 =?utf-8?B?anVDTCtpMEVFSXpUNTF6VFg3UnBod0t2MWp2Nmg3NE0wQm9ld2E3cG1BUFgr?=
 =?utf-8?B?NHlYSWlCS21HbGZRdFJjdXRVOFlBTTIwY09NU0RxVzdjVXYzMCtVOFRyc2Vz?=
 =?utf-8?B?MndGMHlWTDZQWFZpNlA4SEFwbGhxZm1wa3VrRXZMYU1MUEU2VENySWlBakJX?=
 =?utf-8?B?YW91YkY0RVFSQ2pjSUh6TnFEdmp5QlVPZFVwVy93VFBTVW1FMmtCRFhjdGlK?=
 =?utf-8?B?N0liN2N5TXhGdjVld0VPbC96TjJhT3hMOThpRWI1NTE4cXJuTFdvQT09?=
X-Exchange-RoutingPolicyChecked:
	K+3/xRjPNbPA6SnulfokRw4sD/PRgSkW92dsN1sMLi49E4g2pY/FX7VGyG6RzaGvhOTZOl0wdy3KgbIyCmapUaZ1ImAhyF6AAGznbIUIPbC5kIftbc7kEA8tyIJu5LUbWHsibksX5+0zskz7KC03msQero6n6oKPRsX94pOhb4jz0uuJY1kGCSdX6CIwemSXNiO9aEFN1jTHNvgKcQyaMjkVZaSLPM1KP39Q8jXWFq9FqK+JsBDc4gPR5rrM+a3fch7M9bnsI6ypi1aZ7JNRHimgH6wJy0MzKFRd95pMmmJfZfpZi54g4BnXSgmsuYrxVEjBWzTAHzvN1knveEaYUA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719c018c-7e75-4073-bc18-08df15603ce8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:38:39.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT4Sjn/EvbW9NSxSAtORIONv3MJgLFF4C3zteMLnf63D9NqTOjqLsFcjBt9AaXiqCx9HnNQgQnL1FWRBJ7vJFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExOCBTYWx0ZWRfX3Usez8mRaUDL
 9F/fK+ybbl2xpS3/dieUC53qrv1xoQM1gA6Wn98tAE5U9RxjssSNeIdbVqwN8o1I/UHR8g0XqH4
 kvG2cvuXmwUXwMnRqsslxfyF069j6nYiWUz29hdlYpa0/ePIxAsSwRCgza5utsWbKXV7OpSzI5F
 XYaJpYQaN0h+JFg8fr61cAExtk6fTqcn0pmtIMkyKRvqShE3iJYS4NGprpcjhN5vDgBYSkI+ebB
 zC4SD8ouJiYDn83Vm/kjeQ/htvmcxa95PlXpxEOZuJIzPW30jXCDmIulvr8wC56CLOVuxRnDZ/h
 54esZ5mZgEEE69tpjs3+P2xiIPIundP5kLE1Cxu3/VcfxSJrxgIaSKdsjDgAMIhS5VsJXacxlmw
 MYdqOdtzg6tQgLEk3srA8/6rKsri5hMatdpHhPof4wLzO4XD6utAJdRcJXEgAYOw3jX2G1/FUel
 RBGk5edVuPSaN8AObIA==
X-Authority-Analysis: v=2.4 cv=HOJWhYtv c=1 sm=1 tr=0 ts=6aacf892 cx=c_pps
 a=yHj7y5KTVbbUXXBv8k4PkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=ewAVAP25kmbclTDUQ7IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExOCBTYWx0ZWRfX+VCDYn7xscof
 tQp3uEA7K44Qekl8X+XDXGhS3oR8bMlxMcObG31dWF+WZ3jDi08aBSGL9uXxA3TgyXTAOZpGlZP
 xH7IPy3cH5My4Ap8j+f5ua47GzZ4Y53l0+5w1sTJ+ioUNCNjIYX7
X-Proofpoint-GUID: gbAkDcWnMZKR1ogMgOqPI9EhCKXKl1to
X-Proofpoint-ORIG-GUID: gbAkDcWnMZKR1ogMgOqPI9EhCKXKl1to
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180118

On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> On 15-09-26, 12:04, Frank Li wrote:
> > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > On 15-09-26, 21:22, Vinod Koul wrote:
> 
> > > > > Traditional naming would be
> > > > > dma/engine/provider.h
> > > > > dma/engine/consumer.h
> > > >
> > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > everywhere please. dma causes confusion already!
> > >
> > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > 
> > There some dmaengine code outside drivers/dma directory, like
> > drivers/crypto/ccp/ccp-dmaengine.c
> 
> They chose to be outside, their choice... They need to be updated as
> well to point to ../../dma/dmaengine.h :-)

I tend to agree with Andy but anyways. I feel this is going a bit out of
scope now. So what we have now in the series is:


- include/linux/dmaengine.h (without enum dma_slave_buswidth)
- include/linux/dma/types.h (with enum dma_slave_buswidth and new
  dma_buswidth_t type) - A future one would be dma_cap_mask_t and we could
  drop bitmap.h from dmaengine.h
- include/linux/dma/widthmask.h - The new bitmap based API for bus_width

I kind like the separation (and the whole point was to avoid bitmap.h in
the main dmaengine.h API) but tbh I'm not sure if a consumer driver
will ever use dma/widthmask.h without needing the consumer API. But
to sum things up, what do you suggest for vÛE?

* include/linux/dmaengine.h as the consumer API and includes the new
the widthmask API
* provider/private goes to drivers/dma/dmaengine.h and just includes
include/linux/dmaengine.h as the starting point?

Let me know how do you want things for v5

Thx!
- Nuno Sá

> 
> -- 
> ~Vinod
