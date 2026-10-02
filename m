Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65848032F;
	Fri,  2 Oct 2026 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937849; cv=fail; b=jxJBB1jfnv4Pu/mfFESftwN2Ncuw9TF1ih9yPleNDvAM+klzpz2ada0iNLXXCOJKYQHBhMog6rFKyI72Rw4m6FK+YShCvbPRpeaBU+xu+h4yTNuK0vq9GSlsqY0PhsgPJuY6eyvdin+l7xgWh+weF39mZUSMzq+SZk1GpLBoeOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937849; c=relaxed/simple;
	bh=bz+xb9Vz89121OI20C4CMtPwn2+c3In4wp7GE8NDoL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=scjVBOQlXPva/xv6XEVVb+eYWaiU8sYSkp7c2x02hmmZDeLClMIBMlRVHYAq+xA9c0vML3oP/zvTsG+orB2/Ae4WK5aDrA1/QLdfX8XQRVba83YLSkrFyeW/t88py1I7SCvEmQ3KQK8TqzaPuR7VkwNlhAJL3poghlFi/5gWwMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pujYxNFV; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pujYxNFV"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929lXJQ3177260;
	Fri, 2 Oct 2026 06:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GLHxC
	mNl6GwzXS6tVIRrgN3IHZfswz3sWmrtJb9FSdM=; b=pujYxNFVC6oqeBH1o3yDY
	aRPpObuWNAA/1pcwsveeakjj8UHiLGQKvfs9LNXLHFYkVSSsQxyEsgnneJJ8GBop
	5EkjYREc33R4TDK8gZVqo3IuFcn4/C/hVIwRwDsNXXuhvSrJKCb6EJ9CrUlkaWpv
	/H1FrK1MMeFqg/ibUdlg2/Q8oTqlaoGjh9Fp0mw2XziI3JlMDq7H3ZUNCSZXBgQr
	W2AtZ3qqvsk8Qhdv0TskJ9KeclKco5GxNfBEFVjcfpgYa93YeBxyF2w2ivc2Ehtz
	hfA9nmRIzRgvdh8FYAHEh29h1mimDpC6c3xOJNrpC+xTOusDeEdEk639chfGKiuD
	Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h24essu9p-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 06:42:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFdZHuAg9y+ADan6T0QdzNH1KjFYx/GPjNRA78d4b3moR6rtyp513M5mH0tBjjdDSkAhNR2caknK5Mpc7fmGSacM3TT6b45nu/8WDczAXHyUwciHM5cJL6qL9hJXmamBU9acTaaTjC5i7NPaWcOuGuILvaKNpl4U5af0RHyxXYE8/MS+l4ocOLq0IgIjYh0kKnlKwKyPdGJaoYdUFR5deaewolXqeW8hE2hzJ58i47W2moTBBf+98xC98hnfr560eVa2PVLVJCV5kMb6MxG1hrqiG2MLeJ4XUYlR+QaXv/ok5lrvTbPOgeNnOTvKRX6akPQKq34jGZOc8Tbl/ss9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLHxCmNl6GwzXS6tVIRrgN3IHZfswz3sWmrtJb9FSdM=;
 b=WJUdJfYZHkhd4WM+O/R8b0Ji0HNgpc1ox2J4XvSmfpPtN+/od34hEDb2Cn1FmQ4AV0lshqRXVyNelWW8OGnpmG1NCUt0LSyKGkSUbOSwxJbwz3q/0EaaiyNvzhGnr51nq7jO0n12pYvvi9Shw080P4dLJ8fGoJcOPNC/77EincEnKxoeInaBeGe1byZWmUZlLH59hl5wKa5gsdUS0umsb6kUHo1IxzxYzt3jV3bCn8ONqvtQUgluM41Dtt4N5CI3Nlv3j/k6OMu2TR97NhCVzdO4HGTXYXsI6cL2v4132c+/HtpPUALSuc6A4L5kgXAcM4qTAp4lXufdLWoiHirZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by PH7PR03MB7242.namprd03.prod.outlook.com (2603:10b6:510:249::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Fri, 2 Oct
 2026 10:42:10 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 10:42:09 +0000
Date: Fri, 2 Oct 2026 11:43:17 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <ar-Il2qP_Qms3Qw1@nsa>
References: <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
 <aqz1-OzFobOROuBw@nsa>
 <aq18_TMNs4EJzgZO@parshuram>
 <arDtEB0na9DxDWAS@nsa>
 <arFXc0LqEpgWSS6m@SMW015318>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arFXc0LqEpgWSS6m@SMW015318>
X-ClientProxiedBy: MA3P292CA0060.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::19) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|PH7PR03MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3681807f-e54d-4fc7-0b6c-08df2071cf07
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|5023799004|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 /PmCOFnmlxd/Bp1N5BEjGNbbq1l4FPxh+jFIxH7GjrP3Hd147uwO8EkTuwdc4HRU3gm1c3PeZsbXQ85Z9Gv0/xFdKRjvhhVt6C35g/HTeUVUK+TTKNaCPzKHMYQW9vaizR75atWvu7bbNxlk14KPXPbiVYDg5divAoIcLTK29eqj4QAADNTd+Y6kCquqhM54Z2UQrSJa0nVTjMSUVKimhxSjhIqX2Z73PcqNUICOq9GgFjoZvTAQWSIDkUqoF3WS/3/lsQUku8NenKXN8g0eaWDsIPMBwTHcRah3yBv1eiRBkq8boHWlcSjBmsrtpq8pWX4A4G5RVgN56YDDxjbXB+UeUYjBBalqbaiQXQVEednd6K4oEbEZDqWUZLW7AW5UIR5/s064KgrzrzcGdbO13KmKkOgEC3YFLlPV3NnjBKscg2/y7UxIDf3mScDbAwIoc9E+TANCPFzuLML5A8ZSXgh24YIHmXJ/W0E9SV4WQWqBX9+DBIUneOBpRGWiA0fG5PtlCZFRqpyQTSZZsa53e2d1tXc/R8Pog7PaV0irvYUfG/IWYwDBhW6H4NlSIOsdLz8S8GDcTNDR+FrdCJ4l/aiYjSlT6eHBr6R3TThhwthnuLZpIhvGkpwZrnaYr06rFAsGXE3Fut3h6QAv5SMWqr3TGjq8csM2j7XC/Uju3NM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MVlSWjdvRE40QUp0bVNjTG5Tb0FPZUswbGN0WU9SRWwxYTdKQk5KZ2dOeVhw?=
 =?utf-8?B?QmhxODVlQ2NyY3JiUzkrZEFTdWw4WUt3TmU3WG8vK3QyUmZlKzhORkRkWHc4?=
 =?utf-8?B?alQvTTFkcDAzTEwxb2VNMjc3cWkvS2JmTDBvZUYzaTIva013bjBuaDI4SlZQ?=
 =?utf-8?B?TVVqaVpyQW9WMTY4TElkN0RYa3RONENvZFpoKzQ0Ymx4Q29jNmNJQnI4ZG9y?=
 =?utf-8?B?UkJGOW43ajI4aWl3NXN2Wmx0bGszOTVwbzJRMENGWTVTbGFZd2d3WFEyMHNl?=
 =?utf-8?B?cEcrR2RKckRnaHVHM2VwcnR2YTdWbzZrWkVGZDQ3Z0YycDJsdjR3L0pSQWJY?=
 =?utf-8?B?TmRUb2NxdTNvSWFJcTRNRXpxUTBVOG9yYzd2eG0wdXZZTDNLSWV5aDNOeTlz?=
 =?utf-8?B?S3V4dmNkNEZNTFJlTW5BWnpLbTJna0NNSkhtUW15TjVnSWtPMFJDZ0pBZFpE?=
 =?utf-8?B?eUlEbFloYkdRck5HZk9hNXVLQUtHRjM0L3pPeHg3YVlOaGIzU1JmWVl1eFht?=
 =?utf-8?B?ekRwblBwS2g5RzNzd3B2dGsvMllaK3FKM1BZa2xDOE5VOFBaMGdYZ29TUnN6?=
 =?utf-8?B?MUJaU2ozb1lGaTVsWm9iTGRXOEI1THR3MFJOZFZ5QS9WZUwyWlVlS1VNa0xq?=
 =?utf-8?B?YWJBMG12UmFwWHJURlpGRkp3aEJUWWtnaFJ3UDZtYUl6WGx3U3R6R0IvNVhH?=
 =?utf-8?B?OTFZNWkwVnNuOXpGTDRXMnRzNGJ5NS9HSUhCOUVwdTdQUldRUUFXRXJENVBW?=
 =?utf-8?B?ZGd2K0NpQjYwQ3RCT1lKdSt6ZXFNZGNXSjBybmdINmN2TWJkUlZBcEZzRWZs?=
 =?utf-8?B?K00wVGdWa3RrY0FDV3JibWtrelVaZWlMYXk1bnFMbjZPQ2w5Q3ZNUktVVnd2?=
 =?utf-8?B?WWhBeStBeG4rN0RRYXZuc1l6aGE5VXdSaTlNYzFieHEwVmtERm5xczV3bllO?=
 =?utf-8?B?dk5FbDZkK2hNQ05PeVJ5a2NYMlpkMWhteVBYMkc2NExvbW5raU1lNHY2UWxM?=
 =?utf-8?B?cGt0VkpPaWliV3VhWVlKR1l6S1M1WlArb2tkZXltK3ZWeUc4TEJUKzhaZDdW?=
 =?utf-8?B?QVg3bWFJSmJGdmNja2JSUWRKaUpaMC9oZzQrS3pUTGxBWW1sOGd0bXhKYmZB?=
 =?utf-8?B?T3pXampaekNpNEQreUlkUmtWR1RoWU5GdWJsdGd0S2JaWHNuMm43NHFnSEVv?=
 =?utf-8?B?Nng5dXZFUjFPQVM3VktRRjE4RzhmblpKaFpjU21tY1p5Z1RBZ0FIMk9XaFd0?=
 =?utf-8?B?QVZrelVmSytFaWNNVkE2b1B0cVdYU2VJVmI4RHplU2JvQkVKRUxxZEdCeXhP?=
 =?utf-8?B?RTRuY3c3SHU2ZEk3dS9WL003N21taFl0RDBUeDB5NTFpOXZGYjd2ZSsxZ2JS?=
 =?utf-8?B?T3pZenZ6UitNNDB0R1pnN3YwbElhZnhCak12dnpPNUp4dlB0ejZ0MFF2R1Bv?=
 =?utf-8?B?Y2lBYXMwV2N2ZXF5bk9ESklsVVNEcnF5K05lMGZpajVITXBtQjVmeUswb09i?=
 =?utf-8?B?Nm5WMFpid09ydld5bXA3Y2E0WlQwa3ZTaXk3SnQwcGh1TmhMZ2REcEVQMlN5?=
 =?utf-8?B?ZmRjbitjSTZYOHJjeTV3YjduY3pVSFJWM09kVzluZyswVkF4RlJZS01udUU5?=
 =?utf-8?B?NkNnaWVRWXhTL1EwTnNrODlLQmRJRUZiaE9ZeE1VOEtyZ2pjWkF1blRtSTN4?=
 =?utf-8?B?OXdIUEExRmF3U3RWbU5kZHdYdWlMUVhLUDRFcjhHTVNaM0J2dXJmUDFNMEpi?=
 =?utf-8?B?YkZyQ0szQ21RQ09CZklrRjdvSHFhZnB0SGU4ZFlNbTk0eERYdnBRUTd6ZmRZ?=
 =?utf-8?B?R3BMUEs3Slh6ZG1XdjVwdzVhdVBhTFYxM203YUxnbG1PSkJzckVnVDNsVnc5?=
 =?utf-8?B?VjZHV3JQemYrU3NqeW9GcGZqNjRZbUdmYjhOTkJYMngwY2J3WU91MUUvTmsy?=
 =?utf-8?B?SFJhalk0Y0V5WUJxVmV6WFBMczl4eUZBak5VUDNJRTVRZEZuTlhaZ3lTY2Z2?=
 =?utf-8?B?NkpYeVRFcGc4L0RRV3hLdzRKMFN4UE8wR08yRnR6cWdSM1l4amVhT3hiRTJI?=
 =?utf-8?B?aEJ5RXVaRno2K2FJWEtSL0ZqTFFsOTVPZWJ1RFJZeGlJOXlkWEgzRk4xaUJl?=
 =?utf-8?B?WG1valdrM0cvc1NHUFFBeUJGQXQrVFEweFFrMjJNdUp1T2NGeEZjTzdtN3lq?=
 =?utf-8?B?SktMdUZ4YytwMFhBRm1MK2Q3SW5NcFJPR3hkdURjSWk3TTFqTDdzYmh4TjBl?=
 =?utf-8?B?ZG94Wlc1QlFPOTF2RUU3UlRZZUNHZXhzbnpUTEp3eW5JUG9ONHc3ZEtSSW1n?=
 =?utf-8?B?WWQzMFZORjY0V2VJK2RjSFQyTmUweVZWRWl4SC9PdVF1ZnErNTNnUT09?=
X-Exchange-RoutingPolicyChecked:
	YX01Bi5n1tul0skT943mpTb3vVruyZGJ8/sLyeEdWQha+FVmDF/Vpkb9NJye/NTZ3E+f4yPV9H0kVd6CKAfiikYOKyDGti0HnqPQwQNtxT7zqdnVTcIxeIN5MX2vbUnC3miBxQ3BcFRBkKAHuo8bxq/djryYHhNIhLn3LsmYB+GqDW5Jpc17pw9Ku3jwoQWhw6ljEwYMvOIgVTiJzPjLl7r08YcTIckta0hbENLOPzdIZb2wizMuEZhj42kZ7qXQ/ijBH1hvPcfi7/qziGKQ409URBeqerDUpmicCif4KJ9kZh+2hzgqjxUDxBVGRrutwwxKk/mwr2dAIVGNxC2A4A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3681807f-e54d-4fc7-0b6c-08df2071cf07
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:42:09.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwQkdmF8OFqlTR0zPxlqGhtZrCliCsx/kKAywVVj+a+iXJUTFX+fSG2QdmM9/3vgOsSw2fgoEV6TXLXujlRdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7242
X-Proofpoint-ORIG-GUID: IXGGYDKicCROKBu0PKIZH2ku0mBa0ic4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX8ck6t7DsBlP8
 ljODwUCy9nhgrnOuC6u2i+VRVOfTPuNAcTYBxBVgl+HRtzCdDXrWLIkDQlLQxE3kUK4B8f0Diix
 WXYPPNg9f1m3wTTuAMCJonv7jbFnzL6n2iA39w6qDAuHntxoG0SRH6xwpJm880DSzzOyM7bURVn
 CjKZvbgbmxlVaLIWThHtSMCDWoYmDNodEVcfqZap6uybiKc89IRLlcU+b2d9DHBqoC6lXZUiVuC
 L8TcdChx8N59dUjkS/RZ6uMNvwV56J0lyhUdHzIa3a+qrSFJHzjsKe2jXz7EUbPiWdNjXOImlEX
 yqRNlHBmuk8Zw9JSThaJt2g12if9/Kzxo91b6ho3MKUqg5t57G1tXtnT2yjpXD2gXcuWlQcpM1c
 U60+hOjuuPublHZUXWnVBSvpSftpINL9Tmky/nWhLHwIT5Rh+oZnOdnNnAyHpQGvwcqHfq4Phxq
 6cyTLyd7OYfeO7VwQNQ==
X-Proofpoint-GUID: IXGGYDKicCROKBu0PKIZH2ku0mBa0ic4
X-Authority-Analysis: v=2.4 cv=IYQSymqa c=1 sm=1 tr=0 ts=6abf8a85 cx=c_pps
 a=nvwb1BjkeYK3HDx+lqLWkw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=9fXPgR74Q9QXLEDFEHIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfXwoTmCs5keZsX
 Wmrj8uoC56pj5DEvAcQRWKcO2nwa1YQBTMuzWreX0wL+N/3ReiUb93EAW4WFl41nYrtqZChiKFt
 aGwWfv64j8mrGp0YsjdOKYg2AtnKeaUVmAdU0t8by/rWj+JveV7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020042

On Mon, Sep 21, 2026 at 11:12:35AM -0500, Frank Li wrote:
> On Mon, Sep 21, 2026 at 09:53:49AM +0100, Nuno Sá wrote:
> > On Fri, Sep 18, 2026 at 11:33:41PM +0530, Vinod Koul wrote:
> > > On 18-09-26, 09:39, Nuno Sá wrote:
> > > > On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> > > > > On 15-09-26, 12:04, Frank Li wrote:
> > > > > > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > > > > > On 15-09-26, 21:22, Vinod Koul wrote:
> > > > >
> > > > > > > > > Traditional naming would be
> > > > > > > > > dma/engine/provider.h
> > > > > > > > > dma/engine/consumer.h
> > > > > > > >
> > > > > > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > > > > > everywhere please. dma causes confusion already!
> > > > > > >
> > > > > > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > > > > >
> > > > > > There some dmaengine code outside drivers/dma directory, like
> > > > > > drivers/crypto/ccp/ccp-dmaengine.c
> > > > >
> > > > > They chose to be outside, their choice... They need to be updated as
> > > > > well to point to ../../dma/dmaengine.h :-)
> > > >
> > > > I tend to agree with Andy but anyways. I feel this is going a bit out of
> > > > scope now. So what we have now in the series is:
> > > >
> > > >
> > > > - include/linux/dmaengine.h (without enum dma_slave_buswidth)
> > > > - include/linux/dma/types.h (with enum dma_slave_buswidth and new
> > > >   dma_buswidth_t type) - A future one would be dma_cap_mask_t and we could
> > > >   drop bitmap.h from dmaengine.h
> > > > - include/linux/dma/widthmask.h - The new bitmap based API for bus_width
> > > >
> > > > I kind like the separation (and the whole point was to avoid bitmap.h in
> > > > the main dmaengine.h API) but tbh I'm not sure if a consumer driver
> > > > will ever use dma/widthmask.h without needing the consumer API. But
> > > > to sum things up, what do you suggest for vÛE?
> > > >
> > > > * include/linux/dmaengine.h as the consumer API and includes the new
> > > > the widthmask API
> > > > * provider/private goes to drivers/dma/dmaengine.h and just includes
> > > > include/linux/dmaengine.h as the starting point?
> > > >
> > > > Let me know how do you want things for v5
> > >
> > > Yes lets talk about dma_slave_buswidth, it is client type. This is
> > > configured by users to set the width of peripheral.
> > > So this needs to be in the include/linux/dmaengine.h
> > >
> >
> > Agreed! But providers also need to set the allowed bus mask. And I'm
> > just not sure they need to include/consume all of the consumer API.
> > Also, it's common to allow the provider API to be widely used throughout
> > the kernel (but I agree that could be even harder to get done - if we
> > want to make some stuff really private - but I guess that could be done
> > in a second step or more incrementally). We do also have some subfolders
> > in `drivers/dma` which means we'll need the odd "../dmaengine.h" relative
> > include which I do not love tbh (on top of the crypto stuff).
> >
> > I really think something like the below would be more appropriate (if we
> > just want the provider/consumer API without further splitting like the
> > types.h and widthmak.h in this version):
> >
> > include/linux/dmaengine.h - provider API (as of today)
> > include/linux/dmaengine-consumer.h
> >
> > But anyways, if you or Frank do not object in the next few days, I'll
> > take the above approach suggested by Vinod:
> >
> > drivers/dma/dmaengine.h - provider
> > include/linux/dmaengine.h - consumer
> 
> It think it is fine.

Hi Frank,

So I was aboutto start on this again and I just realized
drivers/dma/dmaengine.h already exists today so nothing to do on this
series. I mean I could remove the consumer include on the dmaengine
drivers that I'm touching but not really on scope and super important
IMO. So, for the consumer side, should I just go to the first approach
where all the bus_width API goes into include/linux/dmaengine.h or
should I keep:

include/linux/engine/types.h
include/linux/engine/widthmask.h

And have a better separation on the consumer side? Or maybe changing
s/engine/consumer/ on the above paths?

- Nuno Sá

> 
> Frank
> 
> >
> > - Nuno Sá
> >
> > > --
> > > ~Vinod
