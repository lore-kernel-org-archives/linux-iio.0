Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795453873;
	b=RtvVHfKZVcGHIqpagQDDm9FHtQ+nPz2ZG+/4lDbFHuXNMknwPWNzTlEsBD7B0wKOPwPm
	 32nbAcEqlhXR3CcFLFJ8H0K08nijfTE6KNG5RDVsg38qHXKP4gfoVLdy1TtoaFniDa8Zc
	 uZv2vAaxNtdnZIlNN6TUue2xbYpvBAHmZzuoWxZYMSk+xOrtPPx631cR00NdsKoYJXjwB
	 jhXnB8RhetkANM+gnwv8FbMbuvwGgAFIZrhYzCbUMp/mTVfO8ewTkMuj5PgT13QCbAGFI
	 rYYdQKQXd0JeMY4IO9TTs602VfWW4AIVeHBHQk48lEP2PFfS1HuQRU1W3k0ZQPi0xOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453873;
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
	bh=NsEPAT8HlD9tcLNZtfAR8scYox7Q2qDPawCwuSzZjmU=;
	b=qtfUbZsSOyzFMGyDiZ5Ta8GO/QsT+65GCit9TTZtJFb8WUEvs/Hgx8Q1D8We/Ab5XsaW
	 F3r4dXzCLXFIgXgF3y5RnSa9KDEalMts+lGvb5UH1/kJddEf6P1uDZ10imFAqhEM8tu6h
	 PIi5B19HIY+MHWZIChkv+7uy2z1sq1pSe9hnDR9PQLmt4JadTC+yFO1+gq0wGO7IpDNbf
	 2QZhxLQN4XufR1PmnJ0SpREpEgz5Lm+ElxJXWAbXVeaRunRxC8YPDfoSFiB1RPXTFSmK8
	 g4BRmpRC3XT9k4/FBuXTWa1GW99t9QRkwxYEIZ9IN2Akb50Vrjjtb/h59fyv66Hotlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ooQL5nTf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.17
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF172606A321;
	Mon, 23 Nov 2026 17:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF172606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ooQL5nTf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCGtl17NmhieDlzdiXk94Lhy9TK/95aNbUAqm4YaOZ+CU4U5nzwjkDBYVwy66SNVrHHU/6jc37+AJM5y6p7uMPkRsFo2iQY+WuH27lN5SZHgPM8RoMCGL/0cpCNAefjTgFS68IIhXKGA1VjJTDfklG3dqPIAAayXHtp/TtHaPN4pesVkIcCEzcz79iY1Yb2TrLZhg8JQd5/GvdYfb0bJeWoTLjngSRMbUfO3raSvTp3FxLOpOH5NjhWYS1yfwYK087DSUwveMo9ZHnP+ENPx0yE8FzsQhHp97CGaWV/ArJHTogeybPIGBJMq5yCdFx6/rrvZKpVpXfc9YGNLt3J55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsEPAT8HlD9tcLNZtfAR8scYox7Q2qDPawCwuSzZjmU=;
 b=TPlft9nhHkkxEk760X3blxCXJOw/ONbIxLSkvcrkwelEpolv3fBe9EDT/0lBb2J3MM2SabqcBQrXBdQlI81eXatS4FEAVCqOy0Y3SOvavzz9Svy4TF/GR5rZzAy4xtNR3ZBvrpBMyWpE6WmjO7PsRA987dpLbyyKohOpReS2fg1TZQrI99wcERoGDZd0YVsEIo+WQ4dGPiG6Q38vcK9vnZ/An2LoxBw6/GRX6/SgVLvvxm6BEEeARUyq2qgevj/5Aotr5AdlJQEAJ6Mwqn8Q8pwcz5PFkeuF04CEDLb7xnn0s+6X5tXppe05yRtSpstf7Tuuv63Qx76kka6pj/5fFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsEPAT8HlD9tcLNZtfAR8scYox7Q2qDPawCwuSzZjmU=;
 b=ooQL5nTfVKP2FTu7O3ZNfqEdelLLpO3Wv4VnPX6UEdXCHTyDze/L6jnBs7reK6Iu+67ZWPSzfBej5sqx87Liw1IvLgcQx1SMIseZFGlaoOTll/Ovu3mk++XwrCu+DeM2nE6w7Yny3dnisnmrPcFjoqCk/+CZH4J+m/k0uIh5RtEfVRvgg5rSZkE1ZLXui9ouLQd6bhXc7dC5q/k7TClvE70oM/bd5eSfsCTdu86/IP3DWtpAbw6hYAhHlwjHWxpAk0b0gHASpd2rctdMZ1eNkbQjgrdMqmNBfUZ1DC076mFvcuLrVmMYNP8tuT8WsjmBomJn3/YksUPVISetmOjbjQ==
Received: from AS9PR06CA0499.eurprd06.prod.outlook.com (2603:10a6:20b:49b::23)
 by PAXPR10MB5256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Mon, 23 Nov
 2026 17:11:03 +0000
Received: from AM1PEPF000C1ADC.eurprd02.prod.outlook.com
 (2603:10a6:20b:49b:cafe::1a) by AS9PR06CA0499.outlook.office365.com
 (2603:10a6:20b:49b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 17:11:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000C1ADC.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 17:11:03 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 23 Nov
 2026 18:11:51 +0100
Received: from [10.48.87.64] (10.48.87.64) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 23 Nov
 2026 18:11:01 +0100
Message-ID: <512e3dd2-183b-4459-9b3e-f29f0b97250f@foss.st.com>
Date: Mon, 23 Nov 2026 18:11:00 +0100
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
Subject: Re: [PATCH v2 00/11] iio: adc: stm32: add mdf support for stm32mp2
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Sumit Semwal" <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-sound@vger.kernel.org>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261119-stick-armored-64cd8e1cea62@spud>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261119-stick-armored-64cd8e1cea62@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1ADC:EE_|PAXPR10MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: faf60db6-a185-4763-a61b-08df4984c14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|23010399003|18002099003|22082099003|6133799003|3023799007|13003099007|56012099006|4143699003|11063799006|5023799004|261102130727099003|261102123227099003|261021121427099003|261028144727099003|261022105027099003|261021123027099003|261021130227099003|261022113327099003|261022075727099003|261021135927099003|261009223027099003|261022115727099003|261026140227099003|261026130827099003|261009221227099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	rCjFmWbL/xWBOarKxN6E8WPt4Ecg0xMqciOj9pmPxJD/p9W8HvFxpOpPEts3JIFHw4d/T/iipGcnHqHyeWexfhag/n7Km9/TDURwgM1H4yHxIxCwJGnPxoTPfSKESMPsfphu6nh8tCCNTWcL5S9sq3vMjLQN770eVIdjg2/7czA2S0HTiDvhhfbABpJNlyzGiSDBqhHgkToNqmOvRnC7yWWJIkC2nCHWFU8gIItvCmX/hkOXohCk5a96ZWX8aiydrvcJH7798tFJEtfbSQT2Jj5oxNymKbf5wvqThW0+Z9UJLLxPoJTe9f4jtbbGIQk69u58zjCJT6Q36v2ps2Oz2bvdT75delFPJw0fjpy+3fBXHQ7PUuc6ZMeCRwm23uTr2qEINISTPB9+XmpgG18xwLyiwwDF+a1mcPJHbyd7sh+2CZlgv8r2qLQS5bKam+9aFF5GR0Q/Pdqa8OfcjjKSIXta2RsNi26TbvxPTRj4zzm3uLa5N3024RL+qirt6LAPq69izTdnPZ7+Vt5m/WGE/3+4V9/kGlgC59C8hjh452Do0UlPMWddmmf7dyYx3f/rY5xuNvVSPHqxPbhL0nlCOE2b37NYE9r7ydqiJa5pseMXrNhi7Gi6DIV0xDpXag5JSxyp0vH+zDupWkXf/e6PKw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(13003099007)(56012099006)(4143699003)(11063799006)(5023799004)(261102130727099003)(261102123227099003)(261021121427099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261021135927099003)(261009223027099003)(261022115727099003)(261026140227099003)(261026130827099003)(261009221227099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l5UGaaDh+uRwydPs1vP2qjNGZCEkxHR4H+ho2eStKLm7x6qhAKWScwPPaY5LRqOVGpYBLR8b2E+dUO9EmG/p/Ch+Jxm986tcSaUMbIxSntmlh2tUEU+krBL5KP4+GmsKWIft2sHZWyvCg4zqsdmT+HAWdbtbW8XE8UFadQeaFmf23OLT+N8tb5VJtxyWaDD6bz3CR/j5/0Ll25G2q7bKQlmTcJWQt/Z9LO+j8xYWRXL0hrLG/9nr1lVTEIIcmkF4pnu3Lj5jOXJ908vRJxAiNiop+yZm6b9PJ/vjAk5Qj/rEMi2ChjIg263IJWjnhOyQMJnCvI5ej2RRlr5+wqmeJ088liNlOGBwAckyVRlaGEPkSrENJ3pxCvJt65DiHlrEXD+IzXMrZUj6KJXVMjSW3r20hHUKY3FEP+8WV2CVyAgiRQukqw287mpruZPj2vC9
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:11:03.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf60db6-a185-4763-a61b-08df4984c14b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1ADC.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5256

Hi Conor,

On 11/19/26 19:37, Conor Dooley wrote:
> On Wed, Nov 18, 2026 at 04:17:45PM +0100, Olivier Moysan wrote:
>> This series adds support for the STM32 Multi-function Digital Filter
>> (MDF) found on STM32MP2 SoCs. MDF converts bitstreams from external
>> sigma-delta modulators and PDM microphones into samples for IIO and
>> ASoC consumers.
>>
>> The drivers support direct IIO conversions, cyclic DMA acquisition,
>> CIC configuration and scaling, synchronized and interleaved filters,
>> and external timer triggers. An ASoC DAI provides PDM microphone capture.
>>
>> This revision addresses the v1 review comments listed below and splits
>> the driver patch into smaller functional patches for readability.
>> It retains the existing IIO backend interface for external sigma-delta
>> modulators, pending agreement on the preferred abstraction.
>>
>> These changes do not resolve all v1 review comments. In particular, the
>> frontend/backend architecture, DT child-node model and complete clock
>> topology remain open discussion points.
>>
>> * Open questions: MDF topology (backend/frontend)
>>
>> In Analog Devices use of the IIO backend framework, the AXI ADC is a
>> hardware backend, while the AD9467 is a hardware frontend. The external
>> sigma-delta modulator is actually a hardware frontend in the MDF signal
>> chain. The difference from the AD9467 use case is which driver owns the
>> aggregate IIO device.
> 
> My red line here, that I probably made pretty clear on v1, is that what
> is done needs to make sense when the ADC is feeding the MDF, it cannot
> only work for the data coming in from sd modulators or w/e you connect
> to the SITFx inputs.
> 

I understand your concern. Let me first give some context on the use 
cases. This series only supports external devices connected to the
serial interfaces (SITF): PDM microphones, which are the main use case,
and sigma-delta modulators. Still, I think the MDF centered model 
(option 1 & 2) makes sense for the internal ADC to MDF path as well.
Here is how it could look:

- The ADC becomes a provider for the MDF filter, like an external
   modulator: it provides its resolution and vref and runs its
   conversions in MDF mode, while the filter handles decimation,
   trigger and DMA.

- The routing is static. On the STM32 ADC, data routing to the MDF is a
   global setting for the ADC instance, not a per-channel configuration.
   An ADC instance feeding the MDF is dedicated to this path. It would
   not be a frontend for some channels and a backend for others at the
   same time.

- The binding describes the data source of each filter: could be either
   a stream on a serial interface (the current st,sitf reference) or the
   ADC interface (reference to the ADC node). The binding can be
   completed this way without changing the rest of the model.

- The same model also covers interleaved groups that mix filters fed by
   the ADC and filters fed by serial interfaces, as well as the audio
   use case described below.

The STM32 ADC driver does not support a backend mode today, but it could
be added as an exclusive per-instance mode, selected in DT, in which the
ADC registers an IIO backend instead of an IIO device.

I agree that the IIO device exposing a given analog signal is not the 
same when the signal is read directly from the ADC and when it goes 
through the MDF.
I think this is consistent with the hardware: these are two distinct 
acquisition chains, with different configurations. As the routing is 
fixed in DT, userspace sees only one device for a given channel.

>> Option 1:
>> One option would be to generalize the existing backend abstraction to
>> represent components contributing to an aggregate IIO device,
>> independently of their position in the signal chain.
>>
>> The existing framework appears to provide the required mechanisms. None
>> of these mechanisms inherently requires the provider to be a hardware backend.
>> A generic component/provider model would support both topologies without
>> duplicating interfaces or requiring reciprocal dependencies. The key
>> point here is to preserve the compatibility of APIs and DT bindings.
>>
>> Option 2:
>> Alternatively, if the backend abstraction should retain its hardware
>> meaning, we could introduce an explicit frontend-provider abstraction
>> sharing the existing infrastructure. Frontend operations would cover
>> analog-side control and conversion parameters.
>>
>> Would generalizing the existing abstraction be acceptable, or would a
>> separate frontend interface built on shared infrastructure be preferred?
> 
> For either of these options, do you envisage the data being retrieved
> from the mdf sysfs files rather than from the modulator?
> 

Yes, in options 1 & 2, the MDF filter registers the IIO device that
exposes the data. The modulator, or the ADC in the case above, only 
provides the analog-side information, such as the reference voltage used 
to compute the scale.
This would generalize the IIO backend framework, regardless of where the 
companion component is placed in the chain.

+---------------------+       +----------------+
| frontend w/o iio dev| ----> | MDF            |---> IIO dev
|                     |       |                |
+---------------------+       +----------------+

This also resembles the way the acquisition chain is described in the 
ASoC framework, where the device is not attached to the codec. (see below)

>>
>> Option 3:
>> An aggregate IIO device based on the component framework, as discussed
>> in previous threads, could also be considered. I currently regard this
>> as a fallback solution:
>> https://lore.kernel.org/all/ec411432-4b77-4410-b0aa-b29f73b82c84@foss.st.com/
> 
> You option 2 in the earlier thread had:
> | 2 - DFSDM managed as a "hardware accelerator"
> |
> |
> |    +-------------+
> |    | Sysfs       |
> |    | - Scale     | +---------------+
> |    | - Raw data  | | IIO char dev  |
> |    +-------------+ +---------------+
> |             ^             /\
> |             |             ||
> |             |             ||                         Userland
> |   -----------------------------------------------------------
> |             |             ||                         IIO fw
> |             |             ||
> |             |             ||
> |   -----------------------------------------------------------
> |             |             ||
> |          +--|-------------||--+     +----------------+
> |          |  |             ||  |     |                | Drivers
> |          |  |             =======================    |
> |          |  |                 |     |           ||   |
> |          |  +-----------------+-----+--+        ||   |
> |          |          +---------+-----+--+        ||   |
> |          +----------|---------+     +-----------||---+
> |                     |                           ||
> |   -----------------------------------------------------------
> |                     |                           ||
> |          +----------|---------+     +-----------||---+
> |          |                    |     |           ||   | Hardware
> |          |    sd modulator    |     |  DFSDM    ||   |
> |      =============================================   |
> |          |                    |     |                |
> |          +----------+---------+     +----------------+
> |                     |
> |                     |
> |                    Vref
> |
> | The DFSDM is a consumer of the SD modulator.
> |
> | In addition to its complexity, the main drawback of this approach is
> | that it is unsuitable for interleaved mode.
> 
> Two mails prior I had theorised a way to deal with the interleaved mode
> https://lore.kernel.org/all/20261015-attentive-conflict-1a1f538de77d@spud/
> but I never saw a response from you as to why something like that cannot
> work. That's twice in that thread you said it was unsuitable without
> providing the actual explanation for why?
> 

Sorry, I did not respond to your proposal directly. Here is the explanation.

In interleaved mode, filters 0 to N-1 are grouped, and synchronized by 
filter 0. The samples of all the filters are transferred through the 
filter 0 DMA request as a single interleaved stream. Filters 1 to N-1 
have no DMA transfer and no configuration of their own in this mode.
Interleaved is used in audio (ex stereo) and analog (scan mode) use cases.
Interleaved mode is needed in following use cases: multichannel audio
capture (e.g. stereo microphones), and synchronous multichannel
acquisition of analog sources (scan mode).

With the MDF as a backend, each modulator would be a frontend 
registering its own IIO device. I see the following limitations:

- One hardware buffer, several IIO devices.
   The interleaved stream is a single DMA buffer carrying samples from
   N modulators. A backend buffer is attached to a single IIO device.
   There is currently no way to share one hardware buffer between several
   frontends, or to demux it into several IIO devices.
   Jonathan described this as the swdemux/swmux concepts, which do not
   exist yet:
   https://lore.kernel.org/all/20261019022510.0d554b39@jic23-hlaptop/

- Ownership of the interleaved data.
   With a dedicated cell value (e.g. -1) for the interleaved data, some
   node has to reference it. If it is one of the modulators, this
   modulator becomes in practice the aggregate device (or interleaver)
   It exposes the N channels and needs the scale and supplies of the
   other modulators.
   The choice of this modulator is arbitrary and nothing in the hardware
   reflects it. If it is a dedicated node, it describes a software
   construct rather than hardware.

- Shared configuration.
   Because the configuration is common to the group, writing config
   (sampling_frequency or oversampling) on one frontend would silently
   change the other frontends.

- Frontends unusable on their own.
   Filters 1 to N-1 have no DMA and no config of their own in this mode,
   so the frontend IIO devices linked to them could not acquire alone.
   Acquisition can be started through the filter 0 only.
   The current driver avoids this by only exposing the group, through
   filter 0.

None of these points is impossible to solve in principle, but they
require new IIO infrastructure (cross-device buffer demux, coordinated
buffer enable, arbitration of shared attributes).


* Audio use case

Audio is currently the main use case for the MDF.
The audio chain is modeled as follows in ASoC framework:

Digital Audio Interface link
+------------------------------------------------------+
| +--------------------+       +----------------+      |
| | DMIC               | ----> | MDF            | -----|--> audio device
| | (Audio codec)      |       | (CPU DAI)      |      |
| +--------------------+       +----------------+      |
+------------------------------------------------------+

- The sources are PDM microphones. They are handled on the ASoC side
   (e.g. the generic dmic codec). They have no IIO representation.

- ALSA expects interleaved PCM frames for multichannel capture. An
   N-channel capture is exposed as a single audio device fed by the
   interleaved filter group, whereas N independent mono captures are
   exposed as N separate audio devices.

- The data goes to the ASoC DAI through an ASoC callback, not to IIO
   userspace.

So for audio, the interleaved stream is the data itself, not an
optimisation of DMA resources. It is consumed as one multichannel
stream whose sources have no IIO frontend. In a model where the MDF is
only a backend of IIO frontends, there is no frontend to own this
stream. The MDF would remain the data producer for audio while being a
backend for the analog sources, i.e. two models in the same driver.

This let me say that MDF as backend is "unsuitable" (complexity & 
missing IIO infrastructure)

This is why I think the model should be centered on the MDF filter
as the device producing the data, with the data sources
(external modulators, or the internal ADC) providing their analog-side
information. This model covers the serial interface and ADC sources,
interleaved groups, and audio, with a single approach. Option 1 or 2 
from the cover letter, or the aggregate device of option 3, would fit it.

Jonathan and Nuno, please let me know if you have an opinion on this.
In particular on whether a frontend-provider abstraction (option 2) 
would be acceptable.

If not, it seems to me the that option 3 (aggregate IIO device based on 
component framework) has less drawbacks than the swmux/demux approach.

Best regards,
Olivier


> Cheers,
> Conor.
> 
>>
>> * Driver implementation
>>
>> Serial interfaces (SITF) are shared resources managed directly by the
>> MDF core and no longer have separate platform devices. This revision
>> retains their DT nodes to describe configuration and clock connections,
>> and to allow filters to reference their input bitstreams without
>> duplicating shared settings.
>>
>> This revision also retains a platform device for each MDF filter, as
>> each filter manages its own registers, interrupt, DMA channel and IIO
>> acquisition state, with a separate suspend/resume lifecycle.
>>
>> * Clock management
>>
>> Several clock-management review comments are addressed in this revision:
>> - The provider-side clock-frequency property has been removed. Consumers
>>    request CCK rates through assigned-clocks and assigned-clock-rates.
>> - The clock-names property has been removed. The core acquires its single
>>    input clock by index, and CCK gating uses regmap-based clock operations.
>> - Remove the unused clock-ranges property, as the core now explicitly
>>    shares the kernel clock with the serial interfaces and filters instead
>>    of relying on parent clock lookup.
>>
>> Clock topology point remains open, awaiting clarification of the MDF topology.
>>
>> Changes since v1:
>> - Split the large IIO driver patch into smaller functional patches.
>> - Replace provider-side clock-frequency with consumer-assigned CCK rates
>>    through the common clock framework.
>> - Remove the platform devices for serial interfaces.
>> - Replace the interleave phandle list with a filter count, covering
>>    consecutive filters starting at filter 0.
>> - Simplify clock-output-names, remove clock-names, reset-names and
>>    filter-level clock properties, and move mdf-dai into an explicit
>>    property outside the conditional schema.
>> - Rename the binding to match the STM32MP25 compatible, sort compatible
>>    entries, and simplify the binding patch subject.
>> - Use unsigned long for match data, improve probe error reporting and
>>    wrapping, remove a probe-success debug message, and add kernel-doc for
>>    exported core functions.
>> - Use scoped spinlock guards.
>> - Remove empty serial-interface runtime-PM callbacks.
>> - Remove the redundant ASoC platform module alias.
>>
>> Additional fixes since v1 (following Sashiko review):
>> - Compute the settling-time discard count with 64-bit arithmetic.
>> - Size cyclic DMA periods in complete scans and validate buffer and
>>    period alignment before starting DMA.
>> - Fix backend-enable rollback so backend zero is disabled as well.
>> - Use managed allocation for the conversion buffer and managed IIO
>>    triggered-buffer setup.
>> - Release temporary synchronization and serial-interface firmware-node
>>    references. Replacing interleave phandles also removes the associated
>>    stored node references.
>> - Avoid unregistering secondary interleaved filters that were never
>>    registered as IIO devices.
>> - Use managed acquisition of the optional serial clock.
>> - Replace the GCD-based CCK divider selection with a search for the
>>    largest valid divisor, allowing non-power-of-two divider values.
>> - Remove the selection of the undefined COMMON_CLK_REGMAP symbol.
>>
>> Previous discussion:
>> https://lore.kernel.org/all/20261001145702.2628429-1-olivier.moysan@foss.st.com/
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>> Olivier Moysan (11):
>>        dt-bindings: iio: adc: add stm32mp2 mdf filter
>>        iio: adc: stm32-mdf: add core registration
>>        iio: adc: stm32-mdf: add cck clocks provider
>>        iio: adc: stm32-mdf: add serial interfaces support
>>        iio: adc: stm32-mdf: add digital filter device support
>>        iio: adc: stm32-mdf: configure cic filters and sample rates
>>        iio: adc: stm32-mdf: add direct iio conversion support
>>        iio: adc: stm32-mdf: add dma buffered acquisition support
>>        iio: adc: stm32-mdf: add external timer trigger support
>>        iio: adc: stm32-mdf: add dmic audio filter support
>>        ASoC: stm32: add mdf dai support
>>
>>   .../bindings/iio/adc/st,stm32mp25-mdf.yaml         |  341 ++++
>>   drivers/iio/adc/Kconfig                            |   29 +
>>   drivers/iio/adc/Makefile                           |    3 +
>>   drivers/iio/adc/stm32-mdf-adc.c                    | 2080 ++++++++++++++++++++
>>   drivers/iio/adc/stm32-mdf-core.c                   |  899 +++++++++
>>   drivers/iio/adc/stm32-mdf-serial.c                 |  223 +++
>>   drivers/iio/adc/stm32-mdf.h                        |  275 +++
>>   include/linux/iio/adc/stm32-mdf-adc.h              |   19 +
>>   sound/soc/stm/Kconfig                              |   15 +
>>   sound/soc/stm/Makefile                             |    3 +
>>   sound/soc/stm/stm32_amdf.c                         |  375 ++++
>>   11 files changed, 4262 insertions(+)
>> ---
>> base-commit: d922ed738439e1d5b4701df7f4cdd49a09925624
>> change-id: 20261112-upstream_mdf_v2-76040d99138e
>>
>> Best regards,
>> --
>> Olivier Moysan <olivier.moysan@foss.st.com>
>>

