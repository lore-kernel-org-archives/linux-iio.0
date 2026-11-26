Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795689060;
	b=ycO+KA97y8iug1BXYvl/vge/XFoWMauQ9u9kgeDy/4e5qHWDxaWmy56Fkwcf3LjsGjN+
	 5cYSgv8RGOxMXiWEZ+HDjQwpJfji3PmYXRxqNktIeCCl+j4/HR70kKyZVfjPmQeB3HJLO
	 o9/mCHnVMSVZvleiGOZof5JayVm0cHzGMteZjPaF+MjAoVrLYw0DyLre3O+cu2a2vCZlX
	 ZX9vVc0dQsDQtcF8AYsSAlfja9JcoqmbAfK/s0tHRSp0P6bQW6Clce7vl62tGnAoY7VkE
	 A4xnh8k3NyP4Pz04IM+/FHrKpQus0job0z3HlorC2Nj+/7sgQSYOYfWxHpzeFstl+AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689060;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jBlfyOSTpWcUfqg8bwBngnDOVBy6fSAq2P/x8yWoUJk=;
	b=b85KYYGl8fDv8oLrYbthmvPI76FDtsIUpijpdD4GVKR3Or2XiVcPBrKNrDMDxeZDWy3q
	 Hudk8PZredQNfwlHRGpw2uultbK9nYPN9D79GOKFGzBZcxKpBz/9WF7ou5U5z01VHnSFg
	 QWC7uz8UZ6GcxuMF+JRLBxUWxylnOuRk1LTSnr2kKsAOOwY3OYKBn6yxeviOopa7JVzIY
	 NxiL5pWAegO/Hu2aIseMXW+0yMGbfrgIA4jm1XVcDndy68B+A3Gqhm2JqPzUGd83NrpD1
	 wynP6tr2AkRJOTCCPtU3IPtgQ1a9ZKQsb+ylOVrTZefFXHc1735KeJR/XL/hTqT27xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QolyvS5i;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="NMay4/Nj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321DB606A335;
	Thu, 26 Nov 2026 10:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 321DB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QolyvS5i;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=NMay4/Nj
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7EA69334621;
	Thu, 26 Nov 2026 05:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=jBlfyOSTpWcUfqg8bwBngnDOVBy6fSAq2P/x8yWoUJk=; b=QolyvS5
	iffzBAImA2E0zQ500GiKmzyiee1tEY8e9g74nXRN1Xj2pOs9aoVLAyIoibhrhxyq
	UuQ8l6BsbPvc4J9u/YoHxY1ECOMLIdgwarc3hs23KaSMhtn2+d2CMERZSr59Raeb
	yxFfj3tToaFfYcKI8eWQ1Fpb5S6fCykPbX/wxo/a+OTqq4gVofpm6dtISE8OD1sT
	O0/OtR/awxqdaPcaUli4fhYeB/C/vVd/0sENEC10OYADSpxlclmQuZurpZuujQSn
	L5wpH3QbO+pC1RPIE0X0nfVqdYHXxrZMq8SSvfMnRdQTGjrFXIfC9cxjTJHTHrVd
	c1w1cNBR5ci9tfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jBlfy
	OSTpWcUfqg8bwBngnDOVBy6fSAq2P/x8yWoUJk=; b=NMay4/NjWHHdcmNfWRnkb
	CB06OrL6p+sfPsS3TotPx5Wg0CRsdsrU2CSjeZzIxOpdTIDHjN/U6oFF5KCp2fx5
	QOACpgWO0nGze+Bqo0KcaHc+zoELzccC9F4CVIEcRmFA64FFss9uMRxwbsTcyeDo
	6J+Y2hMP8+r89u872bApOF1EvVq0wmFCRFKNwM0VYvDubu9lUG7JLnfQqIjfkDGO
	hm1TQqL6blVNP3vOnTw3889DVXvYHZay+cMCsNpXRYwiqxNl34PPStcUfeKx92Si
	Ddw9a+UsTrgmqUQfohq3HU42cux7JvlvWsdqjw45HixRzOdQdmkDnLtobPq9Xb55
	w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j5epyhypd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 05:30:53 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTdGEjxNLHLMGmvFgJ1moAjMwFmBtkw58pqlydJ/yYjgXEsOnYFpfLfHo2JEDMEtIBTjfLjenu5zwy1Hx8XuD7MeJSdJpjBmXbiiIVjNFSppSCzauRuOzeBHxoNgUugmQTLkAP/4J4daqs7wxgFNLC3FIFmSPv4JrQqekyj+9e4/BxLdGCO5qk9jVPCMV9PR8u0GMvSbpvREe4CdyMs74/mSV1IX3djxBwbwONrw8LRQlv3jQlzd6yZtWeLkRIr7H2lmoM3FHFJEaPRsPafZsEOKPYCfXe6DuJGzYQf70pjhdSpfNJkOXTmNoqTs9Ds4xaIwesw/enlZ1hv0E1Y6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBlfyOSTpWcUfqg8bwBngnDOVBy6fSAq2P/x8yWoUJk=;
 b=TfcvuhrUjBZFZHoYSx8Avb/4pvPa9zutvS4LB2piEpMdCwyZ4IkbFuqOuifHwSCvLC4faE2ayFum6E1TBZ0jh5m0KZr36uelPlJ3yJacB5Wi9HXcq5N9Vf/ELHcO2eS4DCe/lTuJ7EmDlOb4MFckWOQfEkWXCnL5V1l6bb2ENdwYVowmPDmpmojL+tP8NQF4B1StjBIqw4pzPBMIkc0QzAXRL3KgBcI5baZmlbhtKYTMMw5hcnQLOafWBWCucoPyNFvmujYyxXtmO1sEVpZ4ZfsCr6NQ8OlP381OdNyTfqbpbN1FbE8Z0jtdKkMsNz/fsAbcwRTaYrjw92qN2IRaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH7PR03MB6864.namprd03.prod.outlook.com (2603:10b6:510:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 10:30:48 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 10:30:48 +0000
Date: Thu, 26 Nov 2026 10:30:44 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/6] iio: adc: ad7887: drop platform data support
Message-ID: <awgKRA_OVR9JaoVh@nsa>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-2-54e4c8830b57@analog.com>
 <awa55IsQZJnkJ5lX@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awa55IsQZJnkJ5lX@ashevche-desk.local>
X-ClientProxiedBy: PAZP264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::22) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH7PR03MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: b59eec27-a36b-4c73-8ad3-08df4ba8563c
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|11063799006|10067099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
 LPT+ttsc/TucfAvAdpJpag374ZFch+F5ocrxe02z+qE+52hlwxSHVznKlrsLK6ab6vH+4QKgwyfz+1usf3Ht7haQ2Mxz5yewTWizJPJWakiskeBJs/aTeIi1H40MRPobeSOlN0gSrgW54aUK2Ksy1R63EsGKi2VCs0q/tsCoQKj05YHv4s9sv8Erp7Q8q3VhmANu1fhUF04ubhGo4KwkCtr8+/HvW4XEnfLvEoKUdU2SZdyKZHwNp4h0wIomJntH6UFiOjGki1pzcstZv7eqbGqH7RWSUrBu/LjipNT9Bdj1ER9FvNMEEmvb/DACaFA/G0VbT/tZtuIWkG1t1TmR746WdtH9KAJIfz8SEjjMz+W6UdeSYqAFDj5HjJ8rdJrQ0do6p6VL2XSoG4Cwddlf5OZ5mpTtb1WhqpvWqe7tNNpugjEGzobLoLjhr0tgQ4IFI7N7wowVqFKBk/80OZWUgCwz2fn8pNTrYGzJ1ZQm6LMlqR+FN+ASiB9p+D7KpGP2MpMi/A3aLChvzR3Y9kQtSzTCeEX+pTQPJT/HIoWLeD/h4VZlzWljdCBx9ZCJpVfeT88wz8+WISen3qWGb4nVTJ8Sdind9jlC4VhDLawne59K+3bBeCHkFVgmiONaTvCLSQVX/oaMi0eIvF4FZou/YwwE4Gb4CRS1KhvVwHA7Pvs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(11063799006)(10067099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U2pJMTR5RDE0SkdVNDRxVUdOVnJ5MkVCcjlwalZ2eFJINlFWRXNlWGg2SGZq?=
 =?utf-8?B?QTI4OW5GcDdBeXNZV29pczRFK1pybklpRlVrQXpjdjd3RTZNbmx6TnZyUEJK?=
 =?utf-8?B?bE1SSlk4NDFENGZBSlpGWkdDcE5ZU09WUDUzcWFzM05sa0xlMDBBei83cFRk?=
 =?utf-8?B?WUFjbUE3R2IwMHhZMVBNTExkSmRKZnluVis4Tm1ha0ptWVhRZkYrWHdpU0pz?=
 =?utf-8?B?eWg0QURTU3I2aElGMC9TL05IaE4rbDQvWXpqWlkzaUpmTEN0b2l1UXpjR2Ri?=
 =?utf-8?B?R1Z5Q1I2OUx2NkxJeThwektDdFJaWTBxQ1Q0RUQ5UWViN3pEM3h1YnlkMnky?=
 =?utf-8?B?RFBKVmRlWk9ETjdyejJGMjVESDluSHVhcm1Bb29kYk5BM3FMRkJpUVJzNXZh?=
 =?utf-8?B?NkNsQXZRS3ZRa3FEU3Z0QjJ4RFU4eVFkRWJHTnBWbEhuKy9uT1pnTmlIZmtw?=
 =?utf-8?B?eXd3aEhpSWFKZVB5NGczSEhHTWlVcTg1N2pqenYvZStQMHVMbDRZN1ZDOUFs?=
 =?utf-8?B?YmNFaVVRdWNsQWxuUEJXZm9qVlBTMVU4cG5KV3kwT2JDc0pVU01vdVIxbk82?=
 =?utf-8?B?VG9QT1p6ZG5DRllBWXU4ZUpIN0FqVnJkK0ZqUUNwemNBS0FEcCs1akdnVXRw?=
 =?utf-8?B?SlJTbXdQbVI5c0FySm1OQ1pYNEl5OERxS2YzK04vT2dQL1BldDNtN1Znb0hn?=
 =?utf-8?B?UFlCMTdMbS9DVzJ4QkRrVUtwNklJT1p4dzY4TWdaUUJWbm5pVlBwMUtlRER0?=
 =?utf-8?B?S1ZnUlNTQyt2NTNMalh2VVFXSzFsQXRQbityVlJSa3ZXN1Z3UmY1SUZwMDRk?=
 =?utf-8?B?MEVndytXSjQzS1hWT0FUNWh5bm9CWVZxQmRCNGVHTVdxT3pZMHl0b2QyNXA5?=
 =?utf-8?B?WFhuNEc0Wkl6Rm15M0VBMUFza01iRmpxd3oxeTVGMHZPZHNyMUkzejUvQ2xO?=
 =?utf-8?B?bG5RWTc2NkxvNkxnVEdOc0VzR1QxOHh3Tzk2UndJekNYOGNuS2t3RjhWNE5l?=
 =?utf-8?B?VkVQM1hzaml2Z1g2OXg1d2xJNStEenZXK1ZSVExqRW1OREFyWVpDS0ZKQTl2?=
 =?utf-8?B?M09xZ3hhVE05NjgrZlFIRllPR1JiUHU5bzJ3QXBnV1poU2NMRHBuZVdvYTNG?=
 =?utf-8?B?YjRKcjVmcy81T3Z3dEgrc3ZNSTJDSm0yQ2ozWXJuenYxSzJhTkJtTlpETzVl?=
 =?utf-8?B?Z1ZRUmxFc0xVaEc0a2NGRnJvYVRJRXZnR1ZoaUt5ZzRhemYwUmdmYmFtSmhE?=
 =?utf-8?B?eWN4dVdnL3ZuZ0hGeHptMU1wcGl3TU5LUmdvU0pwUk1sSU5NUUVQeFNNazdF?=
 =?utf-8?B?U3Y3UGhYZnRUOUs1T25vdThudGZyVEZEd1JmNlZpRUg2QmlsR01JenR5QVh6?=
 =?utf-8?B?UjZ5UnVkeS92MENMbjlWcWY3bHFWVytkZDZMZVQ1NUZ0VHZGMlNDaDJwOEp0?=
 =?utf-8?B?NFhDNWpkSW9NYWg2bmloakxyN2dBVzJRMUhCZGdObElBbnZXWldReVRiUkxk?=
 =?utf-8?B?VVFkM2psdmlvMkEyelVCZ2xqTDlwMlNVK2JZcHFyRE1tUEpFZjVVMmo0bTVB?=
 =?utf-8?B?RCszNDZhOGdYUkhHSWRmK2wzSmd4T0w5NWU2UlhkcndlTGJ5YUdaNXhwTXQx?=
 =?utf-8?B?QjFlV2w4dVlTV0h3NnhzRXByTXJoM2RoeVZEUVRJSEtqaG1xSTlualBVVjdp?=
 =?utf-8?B?VVN6QUhZWDZ0MDJvRTRodGdhYVFyaitKcXAxV25tdlNKTXJtQ2xBUTJ4T1dh?=
 =?utf-8?B?VTdWMEdZdmdIbWNMT1VnVWo3bkl0NGwvTDdFU1VuV2tOM0NMK2VOTG9Sc2J5?=
 =?utf-8?B?b3hwVXdiU1EyemJiRU0xTU9iRmNVYmJUb1pyTmtJSnV2cS9IaGxDelVUT2VB?=
 =?utf-8?B?cGJsNkFKZWs2NGNQU0dxNUp0ZUNWZUcvL0tKOERPZi9SR3I0bHVmOXgvUjNF?=
 =?utf-8?B?UnliK2VIZ2UycDNvQ0VaQjYxUXNvN1VMc0Q5MFgycTgxVzA3bjNPMUxuUm5n?=
 =?utf-8?B?aEd0am5UREh2UXdGbUVMczJNN0VCdlpCTnl6WlJacGo5THlIdVhadmdqbytw?=
 =?utf-8?B?NWxENCtrNFJMVCtUQU5rVjRPNW5ibE0yZlljSGhoV3gwVUpmOU9Ic3FiTU9W?=
 =?utf-8?B?RmxtYklTZjMycGZJNUhrNTc2d3JCWi9VM3BRaVNPVlVjNTZhTWQ2VW5iOEFv?=
 =?utf-8?B?dXpINUt1aFgyRDk3QWJUN0RXSGkyS050WCs3T0NjemcwdWs1cVo1ZXlodTJz?=
 =?utf-8?B?Wi9KQU90Wis1MjlqSGxsVHE1eVg3K1Vqb2F3aFBEUUhGMUoxUC9vMUs2cGpB?=
 =?utf-8?B?RTVsS2dsNFlFbnYwM0lDZ2k5d3N4VWpZb2NFTEI1S1JGM09JZ2I3QT09?=
X-Exchange-RoutingPolicyChecked:
	BsTjuZi7L3bQSdQQoRVkz37yPqXJI7MIm5rFGR2F4JWD5la8uWPvgjHgc7KD2woO7VjQOnqVnFywzEg7xx7+zj3/coA4w8+0B1HrroGII4Fuj8WaNXpZI7yKnj1nza5J5dSBcvjlpZUbBFneZMhcpKmOw/cv3b0P6HZNCevkqPZ+8HMwCsh1+uVq8pHUaCCU4OrMFh6d9zRUoFBTkCLq49M8UEpX+O3dv0MmoyyIJMd3RgAVsoRraLyGWU5uHbHiibFJqzsfWIN0aLYVqpTYHkrP5Gd9YYmwxcJDBN+qkItvgCBByKkEbz0BwOXnGlIidDY7sqymE3HRUVx5dHBFPA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59eec27-a36b-4c73-8ad3-08df4ba8563c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:48.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ/77AQq7dluEQURW6DADMjSYK/MUBjlQ32nkbripDyH3ghfeXHtlOhE1fH3lile7hEu8VlpaJ+l3KT99oxmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6864
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX9fzPuyNw4lSU
 QEeHR0PLo+5U6mfRFUvgzSAPjJCw5gTGbxvS5pif1UoKkYS0IrAw2VNclMqDY9iQsH9FpqRqdQ9
 O1dDaI0//fWfzpW6mY3VY0UYk0vZ0PexAVJuOYFLlHlOsxRB/NaVvW1aM/cNjC+mGRhWDd1pJHG
 m1y4X7OwDqKX9fAYMG2Hkc3eeEPaflFri6vl3op1OmlyW1j1icjbjHbayucwjbKnWuXFqGZYwQu
 qSJy50jg83z7Phlckn7lN6/mvGjBLVfX98IQgcWH3689QBypqDzYyRCMgnUYvNkmUpjVGEYf7c9
 pb3pJZTbE7ixwAjBbqiubRG3kgq6+qdSXCXp9v5JzcqyZIFjHgTw+gbG8vK8hBDuUZmcRxnBHrx
 eSF61bS8DEF7Uu/hcM3RI22ZkLrrY4GkY43oJZN59hb6xMYsqrT23gCXPTutCThT9sVKqbZQ07e
 OdCmrCuHgL85bwq0Jww==
X-Proofpoint-GUID: vAqWePmGBXCBBVyeGSGtqVQeJK3swO99
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX3hsnBfi91Rwa
 y9HgEnccjmT0FSAgwePkZ49OZdh8ieEWoPgLG0D2YAaJo6FYvHsSpk/wpSK71rokkfIdwPenvVx
 psNf8R6WE7oOAut0N7sbudSDPBa5soW/XdKuQEA6FnDL9rVRG8ib
X-Proofpoint-ORIG-GUID: vAqWePmGBXCBBVyeGSGtqVQeJK3swO99
X-Authority-Analysis: v=2.4 cv=G+WJgNk5 c=1 sm=1 tr=0 ts=6b080a5d cx=c_pps
 a=L/RFU+sPSyhylg1snxNseA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=vao05GVmRdqDvxM2drYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260040

On Wed, Nov 25, 2026 at 12:35:16PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 25, 2026 at 10:19:18AM +0000, Nuno Sá wrote:
> > There are no in-tree users of struct ad7887_platform_data, and the
> > driver works fine without it. Its only knob, en_dual, selects dual
> > channel mode, where the AIN1/VREF pin is used as a second input.
> > 
> > Drop the platform data header and default to single channel mode, which
> > is what the driver does when no platform data is given. The dual
> > channel code is kept so it can be enabled again should someone need it
> > and add a firmware property for it.
> 
> ...
> 
> > +	/*
> > +	 * Dual channel mode could only be enabled through platform data, which
> > +	 * had no users. Keep the support around in case someone needs it and
> > +	 * adds a firmware property for it.
> > +	 */
> 
> This patch removed the platform_data, hence the first sentence in this comment
> at least confusing. Just drop it?

Can do that, yes.

- Nuno Sá

> 
> > +	bool en_dual = false;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
