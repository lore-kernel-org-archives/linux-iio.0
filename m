Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426668;
	b=zKhSmxFrW3koT3eanWX8ImjPfoQUhR+mC9pMF2qT3RohG0au0M2UJxQY8vbykXn4uejn
	 apmC0mljwHEONqQM/8ZFn3Ug4wIwNHOVIcAaiyVA28wB7+cdTrHBw3bfgwAAVrQKPS4dS
	 AstNC5cqp8f0Gf0GAhUDjahi+4Iadj75bZraAEb2Efz481iYI3TjaVetOBf99i91Bw4+I
	 5zq+iGpJdpPobdGocaaEF1BBHhTt3DJgG7jq/0p93A3HSgb3if4DRZXYh7uAr4iR+AjiP
	 kozI66NDtjJNna6prbauQm+eYUFWddeSRpN1CUkFR3ESR906itCGXQsWtN4RPMwqalQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426668;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RRsE+0tuQcP7A9pHA6BTl0r8XK//rMAU9HWWY2207vU=;
	b=CcCU8Grz75VWlj+yVZTMLGS4ZwWltFuBv9f821alBx0SuBszFHtOtdhZnrKLcj3PcqPQ
	 XekLoiX0xOuIHtfU45ey7MtlQLerSnb9n/4wpoHUBJKRQDFFcVHNIQ4VBfXSsSjFF1A6+
	 tGw1s6OUEFUC4FaHLrbKg6L9DIU2LyqF+MTGNkmh4FSkV+1vX4yBNln3KzwLBSY/EbpD5
	 Z9O+oePLPOiVXZJCgHKrK9c9C+QOT3M42nWFPbRfV0otY8cU9fj15+y2Wzkn/yfPGYcdY
	 xGv+HHUoEDxg6jJm+XzkIjNjo6jofbsXv0ZC2Q/jhXXRgV7uoopJpc0F3dcQXLPwnHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Z5E2TQp6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.16
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46890606A31A;
	Mon, 19 Oct 2026 16:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46890606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Z5E2TQp6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkUuniWn+I2/pzko25YlOXFwhLzn6uUF1DqfcQKloHAXC2v+90wh5LuwLEhqxhJAd+09F2ywiBJ0quYzzasZQRqjO2JkHE0zhaSu4xtxV7lGz284t0OyM3HJ679GY9ftuqtFl0j/JhzPWZv2Bjuj3OmEaGkpqr3Dix69mS52X3NoqNcpk8g4xa7XmK7wETxtD5ZTlRkrThaNDXWc2z/dXRcbnLqZ4DS1OhbCEI9+Tw7gkBoJmPBB1E+SlLKt31A/robeZNzvUno4nFI5ipRYjNAJYLZzI82XNQIolT08qGQ00GDdAqf4C19BtwsMX6Zxein2kBxewBFurjw33Cr9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRsE+0tuQcP7A9pHA6BTl0r8XK//rMAU9HWWY2207vU=;
 b=Dv654PKZm3We3sgHn9kqpHo41871P2XI3Xfw1o2c9MrXuen9QeiAsUX71/jaSsR+rvmaYU69lvkOWfY9fLGAziHWuAL07Vt21tx6CwnsPUVSB9FyczDq55tF0JsR08RXax5umz1sGGP5/s81+pAm5RWlwiTA90C/MJdeLFuGF6jIdOTsX9x5vKMzOpyxV5wvlHxcFXqGre14QL7h9qYqDJWfV7pgQfiz8TL2vGJC1zGiG9e9S0bZP+QZgtSSIAYdRFQpbOjc8M772iJo3lDKHKUsiVr1Vv+BllXIRwYxjyW7cHTBEI5/77jJW8pOUTVTklDKszUWA20+zyP2uvwmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRsE+0tuQcP7A9pHA6BTl0r8XK//rMAU9HWWY2207vU=;
 b=Z5E2TQp6iX6i5fNMnwSUQl27vClnha9fhsI+yA6uCSgG7oUsqzEQHrCxCbMMDiXq1p/rFl4YO5gUCgu/awmIRTUZkBtWoX9YjaBQhN7D6176hj6cwV3kUM84dZsyaqEOOS3vP1RcLNHq7jb/bs/Qc4aGXhDTlPzd8sNwTEljFAtkdh1TOETZ2aD7W6Ugo59oFm8gx3ZOX/nwTyglzcMXFL+6rNINP4BEPJtqBiu0v0KDhxKR0F1cY5JmGDqtbFLUsFMvyaYMRJ3jNFrlEJx/EVzEln1sLq8MF+j0sfZP+HquhvAjwINJ/KP1evKDBNO446qqHUzX5a3aXFKMzgesRg==
Received: from ZR2P278CA0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:47::12)
 by DU2PR10MB7726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:17:39 +0000
Received: from MI3PEPF00008484.eurprd02.prod.outlook.com
 (2603:10a6:910:47:cafe::a) by ZR2P278CA0031.outlook.office365.com
 (2603:10a6:910:47::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:17:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008484.mail.protection.outlook.com (10.167.240.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:17:39 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 19 Oct
 2026 18:18:08 +0200
Received: from [10.48.87.64] (10.48.87.64) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 19 Oct
 2026 18:17:37 +0200
Message-ID: <ec411432-4b77-4410-b0aa-b29f73b82c84@foss.st.com>
Date: Mon, 19 Oct 2026 18:17:36 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Alexandre Torgue" <alexandre.torgue@foss.st.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261001-tribesman-gauze-862e1ef0cdd8@spud>
 <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
 <20261008-9e2a48675c1a4c28f2dfa73b@squawk>
 <950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
 <20261009-8db882a9fa159f8759aa7327@squawk>
 <2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>
 <20261014-untrimmed-partly-81a4a21db49c@spud>
 <48e528a5-0c54-4778-bd29-b6f44ae95be7@foss.st.com>
 <20261014-unmade-sphinx-71cb25110d58@spud>
 <436ef0bf-4146-435d-8252-acec68e64b9e@foss.st.com>
 <20261015-attentive-conflict-1a1f538de77d@spud>
 <20261019022510.0d554b39@jic23-hlaptop>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261019022510.0d554b39@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008484:EE_|DU2PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e165a2-e276-4ed3-d3dd-08df2dfc7ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|82310400026|36860700016|56012099006|4143699003|11063799006|261009221727099003|261009221227099003|261009223327099003|261009220027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	eDCBkBzEPeyAmaEHFe4fTcM6SzY95vn488lrnQOmzGvuRc6iEoSXgw6UjfhjsKsOjScgAiHZDWgKRZJIyQzR6u6kSe30DYDps3pYbbjGUs+DY6SLraR0GwqMy53lUNoVy4OTNbQ+lMSyPJN91cAtoj7KxKghzv6AJ/c+rgBgQSnOgyQNd7LVqW1vBc0lPB63EVY61v5C6TyS6vJCpC3py7KdtrFJpRHIAJJ6qijOxMpUOZZsV0Jf83ivoGTCslxUTKpw9zFu0ovmg3jsfQu7KIRkez6UtqJRNv3oAwsdaAs2//WzlM17O4mHU7ZvnJVx5w5Q+a53RN18cinve8PRswsWdZhvKDNZdJ+fyjBIoG/Gj7Re7YqJHDEgwgjl4Tc5/rMSRLDG39a4OH16UEfe9rAmI8fAr1Uhf+WBBx49AujMzg9rD43oiQxTpwnxLZYsHjOhgrBAjcAUL8tRoCjuGm7648uoyAGltkXmynZz7t2VqTQLb8A29kY22V8N/K1yxoppIu0D3ghH+k7yy3zN/WSIcQs4i04fTjnsABYsKAKLzHR2yJReFGim6EniBLjE3k8tsmXFwRNVN7gmz1zV9ngyxTp6MQtbauPl18AXZcfUrEI2uoYUYteZZlEQFN9fVKNQ29j1yt3Nkem8gB49vA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(261009221727099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qgvxTrU2Nf1Vdu8PxY74bej/5ms4rns6Jwgtxs8ZiTJBNKtqxTDuqibIN8VMFxj+HzChu1xleRVukJzGLKc8JSOp1NYrJXtO0RVMZmwtj7FzW+wdkEnF5TwtzVFgxQEQHvQELWT1cDR/lr2qfcedpK4bOkErYNhvDIT2erBeV+wvuGYvgx8p8V0iUJPgHA4WAcEns8uFc7kZ7ryCvb+xv4HlFrTAoPDOqpcWrmobBIkhIdV0KcRJk8vXkL1od+zNMbyzNaDf8khewxrCQFxqdjNNviC8/fmFgbFsZYE9ppJ3mjxhVHGwRXAeYKthAA6MEzYNG8lMo6wvZ0Xt6ZX6ct/muqDuuJNL2JpYDaF125cS9ZDMLfkRGutNoB8aPt7zPsmqwZTFraIHwM09UOcpXFAfRFh5LLyO+sZSXRBJtiVZ2ox44uC7sagnYtOlLba9
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:17:39.3330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e165a2-e276-4ed3-d3dd-08df2dfc7ee6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7726

Hi Jonathan,

On 10/19/26 03:25, Jonathan Cameron wrote:
> On Thu, 15 Oct 2026 13:34:04 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
>> On Thu, Oct 15, 2026 at 11:19:19AM +0200, Olivier MOYSAN wrote:
>>> Hi Conor,
>>>
>>> On 10/15/26 00:49, Conor Dooley wrote:
>>>> On Wed, Oct 14, 2026 at 06:51:45PM +0200, Olivier MOYSAN wrote:
>>>>> On 10/14/26 17:15, Conor Dooley wrote:
>>>>>> On Mon, Oct 12, 2026 at 02:56:04PM +0200, Olivier MOYSAN wrote:
>>>>>>> On 10/9/26 21:12, Conor Dooley wrote:
>>>>>>>> On Thu, Oct 08, 2026 at 06:37:26PM +0200, Olivier MOYSAN wrote:
>>>>>>>>> On 10/8/26 12:11, Conor Dooley wrote:
>>>>>>>>>> On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wrote:
>>>>>>>>>>> On 10/1/26 20:32, Conor Dooley wrote:
>>>>>>>>>>>>    
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +required:
>>>>>>>>>>>>> +  - compatible
>>>>>>>>>>>>> +  - reg
>>>>>>>>>>>>> +  - ranges
>>>>>>>>>>>>> +  - clocks
>>>>>>>>>>>>> +  - clock-names
>>>>>>>>>>>>> +  - clock-ranges
>>>>>>>>>>>>> +  - "#address-cells"
>>>>>>>>>>>>> +  - "#size-cells"
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +additionalProperties: false
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +patternProperties:
>>>>>>>>>>>>> +  "^sitf@[0-9]+$":
>>>>>>>>>>>>> +    type: object
>>>>>>>>>>>>> +    description: Serial interface child node
>>>>>>>>>>>>
>>>>>>>>>>>> Why is this a child node at all?
>>>>>>>>>>>> Probably not worth reviewing more without a link to the docs for this
>>>>>>>>>>>> device so I can figure out what on earth is going on!
>>>>>>>>>>>>    
>>>>>>>>>>>
>>>>>>>>>>> The MDF is a digital filter for sigma-delta bitstreams, rather than the
>>>>>>>>>>> analog-to-digital converter itself.
>>>>>>>>>>>
>>>>>>>>>>> Here is the link to STM32MP25 reference manuel
>>>>>>>>>>> https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
>>>>>>>>>>> Chapter 45: Multi-function digital filter (MDF)
>>>>>>>>>>>
>>>>>>>>>>> On STMP32MP25 SoC, the MDF provides 8 serial interfaces (SITF) and 8 digital
>>>>>>>>>>> filters (DFLT) which can be connected through a multiplexer.
>>>>>>>>>>>
>>>>>>>>>>> Below is a schematic view of typical applications targeted by this
>>>>>>>>>>> peripheral
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Audio use case:
>>>>>>>>>>>
>>>>>>>>>>> 		mdf
>>>>>>>>>>>                  +-------------------------------------+
>>>>>>>>>>> +------+    | +------+    +------+    +------+    |
>>>>>>>>>>> | dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> audio device
>>>>>>>>>>> +------+    | +------+    +------+    +------+    |
>>>>>>>>>>>                  +-------------------------------------+
>>>>>>>>>>>
>>>>>>>>>>> For instance, in an audio use case the serial interface can be configured to
>>>>>>>>>>> provide the clock to the digital microphone (cck0, cck1 or both) at a common
>>>>>>>>>>> predefined rate, and to retrieve the PDM samples.
>>>>>>>>>>> The serial interface provides this samples to a digital filter, which
>>>>>>>>>>> delivers PCM samples on its output.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Analog use case:
>>>>>>>>>>>
>>>>>>>>>>> 		mdf
>>>>>>>>>>>                    +-------------------------------------+
>>>>>>>>>>> +--------+    | +------+    +------+    +------+    |
>>>>>>>>>>> | sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> iio device
>>>>>>>>>>> +--------+    | +------+    +------+    +------+    |
>>>>>>>>>>>                    +-------------------------------------+
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> So, looking at the docs and a brief chat with Jonathan about this
>>>>>>>>>> device, I believe you've got things backwards and this is actually the backend,
>>>>>>>>>> and the adc should be the one populating the io-backends property
>>>>>>>>>> pointing to this device. You should have io-backend-cells, and I assume
>>>>>>>>>> that there should be a cell for the adc to select which dlft it is connected
>>>>>>>>>> to.
>>>>>>>>>>    
>>>>>>>>>
>>>>>>>>> There have already been lengthy discussions in the past about a DFSDM
>>>>>>>>> peripheral on STM32MP1, which has features similar to those of the MDF and
>>>>>>>>> similar implementation constraints. For the DFSDM, a solution based on an
>>>>>>>>> IIO backend had been upstreamed. The MDF follows the same architecture. I
>>>>>>>>> need to take a little time to dive back into this issue.
>>>>>>>>
>>>>>>>> One thing to note there is that you retrofitted the backends onto that
>>>>>>>> device, and the original design here is much older (it's a text
>>>>>>>> binding).
>>>>>>>>
>>>>>>>>    
>>>>>>>>>
>>>>>>>>> DFSDM sources:
>>>>>>>>> drivers/iio/adc/stm32-dfsdm-adc.c
>>>>>>>>> drivers/iio/adc/stm32-dfsdm-core.c
>>>>>>>>>
>>>>>>>>> Here is a sample of DFSDM DT
>>>>>>>>>
>>>>>>>>> sd_adc0: simple-sd-adc0 {
>>>>>>>>> 	compatible = "sd-modulator";
>>>>>>>>> 	#io-backend-cells = <0>;
>>>>>>>>> 	vref-supply = <&v3v3>;
>>>>>>>>
>>>>>>>> Yeah, pretty sure this is wrong (backwards). The backend is the thing
>>>>>>>> that gets data from an ADC not the ADC.
>>>>>>>>    
>>>>>>>
>>>>>>> The backend framework was introduced to implement complex IIO aggregate
>>>>>>> devices. The hardwares that were driving this need were analog device ad9467
>>>>>>> and ST DFSDM.
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
>>>>>>>
>>>>>>>    From drivers/iio/industrialio-backend.c:
>>>>>>>
>>>>>>> "The typical architecture is to have one device as the frontend device which
>>>>>>> can be "linked" against one or multiple backend devices. All the IIO and
>>>>>>> userspace interface is expected to be registers/managed by the frontend
>>>>>>> device which will callback into the backends when needed (to get/set some
>>>>>>> configuration that it does not directly control)."
>>>>>>>
>>>>>>>     *                                    ---------------------
>>>>>>>     * ------------------                 | ------------
>>>>>>>     * |     ADC        |-----------------| | ADC CORE |
>>>>>>>     * | (Frontend/IIO) | Serial Data (eg | |(backend) |-------
>>>>>>>     * |                |-----------------| ------------
>>>>>>>     * ------------------                 ---------------------
>>>>>>>
>>>>>>> The MDF (or DFSDM) use case, follows this topology:
>>>>>>> - The SD modulator (ADC core) registers in backend framework
>>>>>>> - The MDF registers in IIO framework and exposes the IIO devices
>>>>>>>      It also get configuration (ref voltage) from SD modulator, to compute
>>>>>>> scaling.
>>>>>>>
>>>>>>> I agree that if we consider the terms frontend and backend, the elements in
>>>>>>> the data flow do not have the roles that we would naturally expect. However,
>>>>>>> if we consider the expected role of the elements using the iio-backend
>>>>>>> framework, the usage seems coherent to me.
>>>>>>
>>>>>> I didn't even get as far as sd modulators or whatever, if I understand
>>>>>> correctly the ADC inputs on this device are fed by the onboard ADC?
>>>>>> (https://lore.kernel.org/linux-iio/20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com/)
>>>>>> In that case, I can't really see how it makes sense for the primary iio
>>>>>> device to change when data is fed back through the mdf or taken
>>>>>> directly from the ADC itself, particularly given how that would affect
>>>>>> the userspace interface.
>>>>>>
>>>>>> The "serial" side of this seems in a similar vein to the adi,axi-adc
>>>>>> stuff, which when considered with the ADC inputs, really does give me
>>>>>> the impression this is backwards.
>>>>>
>>>>> Some clarifications about the STM32MP25. This SoC does indeed provide ADCs,
>>>>> and these can be connected to the MDF via a dedicated interface. (but not
>>>>> the serial interface).
>>>>>
>>>>> However, this use case is not supported by the driver. Only sigma-delta
>>>>> modulators, external to the SoC and connected via the serial interface, are
>>>>> supported. On ST boards, the only available SD modulators are digital
>>>>> microphones.
>>>>
>>>> Quite frankly, I don't care what you are choosing to implement in the
>>>> driver or what your first-party boards support. The binding must
>>>> represent the capabilities of the device, not what subset you deem
>>>> relevant at this point in time. I'm not going to ack anything that does
>>>> not consider all use cases for the device, especially since I the more I
>>>> look the more I am convinced that this is the wrong way to model the
>>>> relationship between devices and therefore intentionally ignoring a use case
>>>> is likely to be problematic when someone does decide that they want to use
>>>> that feature.
>>>>    
>>>>> Anyway, if the internal ADC to MDF use case was supported, the issue would
>>>>> be the same. The whole ADC + MDF set would be presented at the interface as
>>>>> an aggregated device, and the ADC data would not be directly accessible to
>>>>> the user.
>>>>
>>>> Of course, that's what I was talking about when I said:
>>>> | In that case, I can't really see how it makes sense for the primary iio
>>>> | device to change when data is fed back through the mdf or taken
>>>> | directly from the ADC itself, particularly given how that would affect
>>>> | the userspace interface.
>>>>
>>>> To me, in that ADC to MDF use case, the frontend portion of the aggregate
>>>> device presented to userspace needs to be the ADC and the MDF needs to be
>>>> the backend, since otherwise the ADC will simultaneously be frontend and
>>>> backend, depending on which channel is considered. That makes no sense to me
>>>> when the MDF can always be the backend, for all use cases and avoid that
>>>> sort of problem entirely.
>>>> I've heard no argument as to why the MDF cannot be a backend, just that you
>>>> don't want to because the previous device didn't, but copying what was
>>>> done before isn't a justification that bears weight if how it was done
>>>> before isn't the way it should be done.
>>>>    
>>>
>>> These topology problems were discussed at length in the case of DFSDM.
>>> The main blocking point being support for interleaved channels (scan mode),
>>> a problematic issue that is still found with MDF.
>>
>> If I am not mistaken, you're talking about what's described in the
>> section labelled "Interleaved-transfer mode" of the document you
>> provided previously?
>>
>>> The constraints that led to this approach are in the following thread:
>>> https://lore.kernel.org/all/20210919191414.09270f4e@jic23-huawei/
>>
>> That to me seemed like a discussion about why the MDF/interleaver needs
>> to be represented as a separate device, I don't see anything that
>> explains why the MDF cannot be a backend.
>>
>> Reading the document, "Interleaved-transfer mode" doesn't trash the
>> association between data and which fifo, and thereby which sensor or
>> ADC, it came from. Using #io-backend-cells = <1> in the MDF, the
>> sensor/ADC can provide the channel to which it is linked, and the data
>> association restored. You already know what the set of interleaved channels
>> is from the st,interleave property so there's no extra properties required
>> for this I think.
>>
>> The problem here must be that you want to access the interleaved data? That
>> could be handled by having a cell value that represents the interleaved
>> data (e.g. -1), rather than a channel (1-N)? That'd support systems that
>> want interleaved data (like an array of identical sensors?) and systems
>> using the mode for the stated aim of it in documentation of optimising
>> DMA request resources who have disparate devices where interleaved data
>> itself is not useful?
> 
> Sorry it took me so long to get to this. I promise I wasn't hiding - it
> just happened to fall down the gaps in my various flurries of reading
> IIO from latest emails back in time over the last few weeks.
> 
> I'd managed to blank the whole complexity of multi channel SD demodulators
> from my mind since the earlier discussion that was linked (thanks for that
> - I now remember how these work - though maybe not how we ended up with
> the binding).  We are still evolving so it is also possible the solution
> from that isn't how we'd do it today.
> 
> As to the question of front end vs backend question, Nuno is probably best person
> to give input on that but let me have a go.
> 
> Backends tend to the datashifter / manging engines that deal with taking
> data from the 'front end' which is typically the ADC device with the actual
> pins to which we connect analog signals.  Examples being parallel interfaces
> and the many weird and wonderful specialist SPI engines.
> 
> Front ends as mentioned are the devices to which the inputs are connected.
> I think that aligns with what Conor was suggesting (and the quick discussion
> we had in Prague 10 days or so back).
> 
> The problem you have with the multiple modulators is actually pretty similar
> to the one we have with chained SPI devices or those weird addressable ones.
>   - share a bus
>   - extra address bits that allow any given device to 'sometimes' ignore messages.
>   - magic registers that are written whatever the address bits.
>   - Special read out sequences that let you 'stream' from multiple devices.
>   - For these we currently constrain things to 'like' devices rather than a mix.
> 
> A single data pipe (the interleaver here?) is taking data from multiple front end devices.
> 
> A question here.  Do you care about mixed modulator types? The example
> suggests you do.  Which puts us in the situation of something like
>   ____________              _______           ___________
> |Modulator 1 |            |       |         |           |
> |(ADC)       |-pulsetrain-|Demod 1|-Digital-|Interleaver|
> |____________|            |_______|         | (Skipping |
>   ____________              _______          |  dflt as  |-> Software dmux
> | Modulator 2|            |       |         |  diag too |
> |(Audio/ADC) |-Pulsetrain-|Demod 2|-Digital-|  fat)     |
> |____________|            |_______|         |___________|
> 
> In this if we just took the top half, then simples, the
> Demodulator 1 and Interleaver (not interleaving) would
> be a normal IIO Backend for the Modulator 1 (kind of
> the ADC).
> 
> If we take the whole thing (but with bottom as an Audio
> channel, not an ADC) then effectively we have a backend
> backing both signal types and it's up to software to unwind
> what turns up in memory.
> 
> Note that a lot of what follows isn't stuff that ends
> up in DT, but I'm trying to represent the dataflows through
> IIO. Some of this is very idealistic :(  Also my terminology
> is probably garbage. For me demods go from an encoded signal
> on one line to ADC samples. I suspect that maps to the acquisition
> bit of the digital filters in this device.
> 
> If they are both IIO style ADCs then this runs into the
> same challenges as SPI chaining.  We really would want to
> end up with a composite device that presents
> 
>   __   ____________              _______           ___________
> |  |  |Modulator 1 |            |       |         |           |
> |  |--|(ADC)       |-pulsetrain-|Demod 1|-Digital-|Interleaver|
> |  |  |____________|            |_______|         | (Skipping |
> |A |   ____________              _______          |  dflt as  |-> Software dmux
> |  |  | Modulator 2|            |       |         |  diag too |
> |  |--|(ADC)       |-Pulsetrain-|Demod 2|-Digital-|  fat)     |
> |__|  |____________|            |_______|         |___________|
> 
> Imagine A for example was an a multichannel analog device such
> as a 2 axis analog Accelemeter.  The ultimate IIO device we want
> would represent that A.  We have these in tree and they work
> by being consumers of ADC channels but assume those channels
> come from a single IIO ADC.  Here the snag is that
> Modulators 1 and and 2 would naturally be separate IIO 'devices'.
> (Note there is an example like A in the datasheet - middle of figure
> 378 - key is the shared clock I think)
> 
> So conceptually we have
> 
>   __   ____________        _______     ___________           __________
> |  |  |Modulator 1 |     |       |   |           |         | Data for |
> |  |--|(ADC)       |-pdm-|Demod 1|-D-|Interleaver|        /| A chan 0 |
> |  |  |____________|     |_______|   | (Skipping |       / | (mod 1)  |
> |A |   ____________       _______    |  dflt as  |-SWDemux |__________|
> |  |  | Modulator 2|     |       |   |  diag too |       \  __________
> |  |--|(ADC)       |-pdm-|Demod 2|-D-|  fat)     |        \| Data for |
> |__|  |____________|     |_______|   |___________|         | A chan 1 |
>                                                             | (mod 2)  |
>                                                             |__________|
> 
> But then we actually want to have A as one device which
> conceptually requires a mux
> 
>   __   ____________        _______     ___________          __________
> |  |  |Modulator 1 |     |       |   |           |        | Data for |
> |  |--|(ADC)       |-pdm-|Demod 1|-D-|Interleaver|        | A chan 0 |
> |  |  |____________|     |_______|   | (Skipping |       /| (mod 1)  |\
> |A |   ____________       _______    |  dflt as  |-SWDemux|__________| SWMux - Data A
> |  |  | Modulator 2|     |       |   |  diag too |       \ __________ /
> |  |--|(ADC)       |-pdm-|Demod 2|-D-|  fat)     |        | Data for |
> |__|  |____________|     |_______|   |___________|        | A chan 1 |
>                                                            | (mod 2)  |
>                                                            |__________|
> 
> Obviously in practice we want some way of flattening the and mux
> so that we don't actually do anything. (FWIW we haven't yet built
> a SW mux concept into IIO, though it has come up a few times for
> this soft of case).
> 
> So what is what in this model.
> 
> A - Simple IIO consumer of Modulator 1 and Modulator 2.
> Modulator 1/2 - IIO front end devices - each a device on its own.
> Demod 1/2 + interleaver - IIO backend (data mangler)
> 
> SWdemux - new concept we need to unwind from a backend that provides
>            service to a pair of front end (actually similar to the IIO
> 	  demux. Might be able to reuse that)
> Data for A chan 0.  Kind of a virtual backend for the top half of diag.
> 
> SWMux - new concept that we haven't built - but here it is only theoretical
>          anyway because we don't want to demux then remux. Trick is
>          never use the apparent interfaces for the IIO devices
>          representing the modulator
> 
> Anyhow, how on earth to we map this to DT. Hmm..
> 
> We don't need to represent the device A, though we may need to figure
> that out by looking for devices pointing to the backend and build it
> in software.
> 
> The backend should be both the demodulators and the interleaver
> (which I think maps to interleaver + digital fiters + the serial
>   interfaces in this case).
> Stuff to the right is all software concepts.
> 
> How to indicate what is interleaved?  Maybe we do have to
> represent that front end device as a consumer of channels provided
> by the various ADCs (modulators here).
> 
> Other bits in the device here.
> Digital filters.  Why do we need those in DT?  Aren't they software
> controlled things and associate with a channel? Or are they representing
> what I have as demodulators above.?
> 
> Given I think they end up in the backend we may need to extend some interfaces.
> 
> Anyhow, that probably confused anyone who previously had
> any idea on how this all fits together.
> 
> Also, I should have gotten out my UK keyboard or changed keyboard layout.
> US keyboard, with UK layout makes for tricky to find symbols for asci art :(
> 
> Jonathan
> 

Thanks for your feedback.

First, a quick overview of MDF to clarify filter usage.

                                          +- - - - - - +
                                          ' STM32MP2   '
+--------+     +--------+  1bit stream   ' +--------+ '
| source | --> | SD mod | -------------> ' |  MDF   | '
+--------+     +--------+                ' +--------+ '
                                          +- - - - - - +

The analog input is sampled and converted into a 1-bit digital data 
stream by the external Sigma-Delta modulator.
The MDF filter processing consists mainly in averaging the input serial 
stream and producing a parallel,lower rate, data output with higher 
resolution. (there is no other demodulation stage than this decimation)

The MDF filters feature a set of configurable parameters that allow to 
tune the output resolution and data rate.

What need to be configured at filter level
- filter/serial interface muxing
- filter order (exposed in binding. maybe considered as sw tuning ?)
- filter dma association and configuration
The interleave mode (2 to n filters) is only a special use case, the 
most common case being a single filter per channel


Below is a kind of state of the art regarding the solutions considered 
for the DFSDM. (MDF inherits these choices)

1 - Initial DFSDM implementation proposed (not upstreamed)

                               +-------------+
                               | Sysfs       |
          +-------------+      | - Scale     |
          | Sysfs       |      | - Raw data  | +-------------+
          +-------------+      +-------------+ | IIO char dev|
          +-------------+                      +-------------+
          | IIO char dev|            ^              /\
          +-------------+            |              ||
                                     |              ||  Userland
   -------------------------------------------------------------
                                     |              ||  IIO fw
                                     |              ||
                                     |              ||
   -------------------------------------------------------------
          +-------------+       +----|--------------||+
          |             |       |    |              ||| Drivers
          |       +-----+-------+----+              |||
          |       |     |       |                   |||
          +-------|-----+       +-------------------||+
                  |                                 ||
   -------------------------------------------------------------
                  |                                 ||
          +-------|-----+       +-------------------||+
          |             |       |                   ||| Hardware
          | sd modulator|       |     DFSDM         |||
    ==================================================
          |             |       |                     |
          +-------+-----+       +---------------------+
                  |
                 Vref

==> data path
--> info path

Both SD modulator and DFSDM register a IIO device.
The DFSDM is a consumer of the SD modulator.
vref is retrieved from SD modulator to compute the scaling info.
Compatible with interleaved mode

The main drawback is that we expose useless SD modulator IIO devices


2 - DFSDM managed as a "hardware accelerator"


   +-------------+
   | Sysfs       |
   | - Scale     | +---------------+
   | - Raw data  | | IIO char dev  |
   +-------------+ +---------------+
            ^             /\
            |             ||
            |             ||                         Userland
  -----------------------------------------------------------
            |             ||                         IIO fw
            |             ||
            |             ||
  -----------------------------------------------------------
            |             ||
         +--|-------------||--+     +----------------+
         |  |             ||  |     |                | Drivers
         |  |             =======================    |
         |  |                 |     |           ||   |
         |  +-----------------+-----+--+        ||   |
         |          +---------+-----+--+        ||   |
         +----------|---------+     +-----------||---+
                    |                           ||
  -----------------------------------------------------------
                    |                           ||
         +----------|---------+     +-----------||---+
         |                    |     |           ||   | Hardware
         |    sd modulator    |     |  DFSDM    ||   |
     =============================================   |
         |                    |     |                |
         +----------+---------+     +----------------+
                    |
                    |
                   Vref

The DFSDM is a consumer of the SD modulator.

In addition to its complexity, the main drawback of this approach is 
that it is unsuitable for interleaved mode.


3 - Aggregated IIO device

                               +-------------+
                               | Sysfs       |
                               | - Scale     | +-------------+
                               | - Raw data  | | IIO char dev|
                               +-------------+ +-------------+
                                        ^            /\
                                        |            ||
                                        |            || Userland
   -------------------------------------------------------------
                                        |            || IIO fw
           Composite IIO component      |            ||
                      |                 |            ||
                      |                 |            ||
   -------------------------------------------------------------
       +--------------+-----------------+---------------+
       | +------------+--+       +--------------+    || | Drivers
       | |               |       |              |    || |
       | |               |       |              |    || |
       | +---------------+       +--------------+    || |
       +---------------------------------------------||-+
   -------------------------------------------------------------
         +---------------+       +--------------+    ||
         |               |       |              |    || Hardware
         | sd modulator  |       |    DFSDM     |    ||
    ===================================================
         |               |       |              |
         +-------+-------+       +--------------+
                 |
                Vref

The converter framework introduced by Nuno Sa was an attempt to address 
a similar issue
https://lore.kernel.org/linux-iio/dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com/
https://marc.info/?l=linux-iio&m=169347939425097&w=2

A trial use of this framework was carried out for DFSDM and seemed 
suitable. However, this solution was abandoned in favor of the backend 
framework.


4 - Current DFSDM implementation (upstreamed)

                                +-------------+
                                | Sysfs       |
                                | - Scale     | +-------------+
                                | - Raw data  | | IIO char dev|
                                +-------------+ +-------------+
                                      ^              /\
                                      |              ||
                                      |              ||  Userland
   -------------------------------------------------------------
                                      |              ||  IIO fw
           +-------------+            |              ||
           | Backend fw  |            |              ||
           |             |            |              ||
           +-------------+            |              ||
                                      |              ||
   -------------------------------------------------------------
           +-------------+        +---|--------------||+
           |             |        |   |              ||| Drivers
           |       +-----+--------+---+              |||
           |       |     |        |                  |||
           +-------|-----+        +------------------||+
                   |                                 ||
   -------------------------------------------------------------
                   |                                 ||
           +-------|-----+        +------------------||+
           |             |        |                  ||| Hardware
           | sd modulator|        |    DFSDM         |||
     ==================================================
           |             |        |                    |
           +-------+-----+        +--------------------+
                   |
                  Vref

The SD modulator is registered as a backend device.
SD modulator is a consumer of the DFSDM.
Only DFSDM IIO device is exposed.
vref is retrieved from SD modulator to compute the scaling info.
Compatible with interleaved mode

I agree with your definition of a frontend and a backend. From that 
point of view, this implementation does not fit the definition.
However, it looks to me that the root of the problem is the name of the 
“backend” framework, which does not correspond to the role it actually 
plays. In this use case, it should probably be called frontend. But that 
would indeed need to be confirmed with Nuno. I will also take a closer 
look at how the framework is used by components such as the AD9467.

Best regards
Olivier

> 
>>
>> Thanks,
>> Conor.
> 

