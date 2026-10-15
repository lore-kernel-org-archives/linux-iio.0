Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazhn15011020.outbound.protection.outlook.com [52.102.161.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BF4EC649;
	Thu, 15 Oct 2026 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.161.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055979; cv=fail; b=k/YmtsK8OyBP44IblDkKfevoU6G/Imf1t0NP57d9t50JjUefCDFpGkCh7rG2THcW0vDdK3qLDNDOrZklHf4yjGTicfU5PgA2MWrblTdWKBzhkKzoUwTQFheNVHiQ/EXpbss0ZNAiO0/OwReIPLzL/pRXwcjn/JlFyhvypE62ecM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055979; c=relaxed/simple;
	bh=odGIgXl9NTxr4attmLvSWADsWoie0LzBJeVus0ymQvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ckb5L8hJ+yqDEcgFkgdd8O9/PJZyFP2w2awyt7ZywcsY71SuJEFQvFwqSFu/qbzLZZ4KzcLSH69pSv7juNhA1NaryzWbBoiiKAxIQ9lY4zz16E5kBERVsO6RAl+WiY+rYD+yfmSwzY6GiVZCl/dpKiKorhGmfoLky1U7d0t+BAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BHM9Kf/G; arc=fail smtp.client-ip=52.102.161.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BHM9Kf/G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWh/ohwIUeO0zg+fJo9YzPIVe5Bzq7Sql/dqswfTGzN/B9ul5oLIutxK5fWR5Sp12F+IdxM0pSa2PFLTDPv61tK2p07qULA/xmkKgMSXtbhwFrCKlAspTrz28g1/isUpVbfDN5NviUYEO1hNc1Yj2I8EE9PW1WRJrey0DLF/THwKnDEP0fN3I5ykCIpnIzqT4ywHmJAXUUrqfgEefpKT3ryWJC78GJxFMziq+gdOHes/vWOWlFSpeOOh3zLSrITvaEiyw//AkHKiNi/rHTM69F5Cc35dV3wziyT+3OlhwYQ+Iamd5tPzDbFGmXlDdhAGHSweYtNjjds6Lv/y/6kWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4yyzQ3ChG9Lhm5tQTnYsOcaWp53qqsuz2ze0mCqK80=;
 b=GtoaGjwVXa/muo7QZArLkNglYWr06f+IFREw6D3c8TJJB2JOlhT3KVjfHgQUuReMRRpWgZTGBpJ5Y/rivimzc76NDadDfJPVMg0biu7ezvhssfxImaPkTg763Ng5BjLK1+fP1whGTEHjOg6MSWBSDNfYeu/gUixa/km2Cx8WtqLjAsyn8A+UbVazHQMeFzbKcsVUkrv7TO6+rYU/Yxu+LZVY/EZig8OJeu7Up3P7O64soNQOUEIzFIG/Ke5Ij3E7dA5uUGfrMMW3C/N+Js9edjtA12VZCchRTPUTy476w15PQRiji92x4AmQBIYQ52BwBqsicZh3bqj+WeShONQMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4yyzQ3ChG9Lhm5tQTnYsOcaWp53qqsuz2ze0mCqK80=;
 b=BHM9Kf/GeZTLI/Rs60QAU5bXc/93IpWuprf8D5+Ctdf5msnJ3C+NrV8cf/1rOHFHQDQTCntN3gEKcaj0zKDV5Z1FajEJOGl2XOI3hC7WFq7O+KP0T9oPyhDI6GiJCEhPQE8fEtPK6u/+GKY48MHX5MMXVT2fv2olM2bz0OqZ9sSrguviOB9VTNQuoBs+O+sl8SLwHo34g65UFCIag2OBNzP8gPwRy2H62xiujDJsm9coATDM+MTrjhZl43HP2UetCTHZ+FGYjjdQumobeFBr3SjOhrhD5zRpPfRjhxAHC/s1PE24SQ9njIi0hu7gCslbVWOYthG1RAsihL5dfsJTYQ==
Received: from AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23)
 by DU0PR10MB6344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:410::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 09:19:25 +0000
Received: from CPH1EPF0000052C.eurprd05.prod.outlook.com
 (2603:10a6:20b:331:cafe::5b) by AS8PR04CA0168.outlook.office365.com
 (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 09:19:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052C.mail.protection.outlook.com (10.167.241.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 09:19:24 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 15 Oct
 2026 11:19:37 +0200
Received: from [10.48.87.64] (10.48.87.64) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 15 Oct
 2026 11:19:21 +0200
Message-ID: <436ef0bf-4146-435d-8252-acec68e64b9e@foss.st.com>
Date: Thu, 15 Oct 2026 11:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
 <20261001-tribesman-gauze-862e1ef0cdd8@spud>
 <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
 <20261008-9e2a48675c1a4c28f2dfa73b@squawk>
 <950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
 <20261009-8db882a9fa159f8759aa7327@squawk>
 <2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>
 <20261014-untrimmed-partly-81a4a21db49c@spud>
 <48e528a5-0c54-4778-bd29-b6f44ae95be7@foss.st.com>
 <20261014-unmade-sphinx-71cb25110d58@spud>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261014-unmade-sphinx-71cb25110d58@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052C:EE_|DU0PR10MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f96cf35-b4ff-4f92-0a83-08df2a9d67a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|34020700016|82310400026|23010399003|36860700016|56012099006|261009221727099003|11063799006|4143699003|261009223327099003|261009220027099003|261009223027099003|261009221227099003|10067099003|18002099003|6133799003|13003099007|22082099003|3023799007|12100799066;
X-Microsoft-Antispam-Message-Info:
	3hY7nlWWB8F0Q1kXr4zF6nI/attkFCXgdUPI3BnhroFdZnFOh48UOIztOjLts032Z9RXFVMIYzBrcWqigXYHys9LmtPJdmrs1xbOZXHc5E789b3vN2WPuD9wQXr5D+w7PZhY0mZnnV/jCNLZWBgpw4yg21wgIiDB8YpplLy4yDo+l45SHn1I+xAf3kEkWRmukPs8q8aTN0OYGNnLG8AAeAjqT7lOl4Htz2/uy9eWW9afrbr5K9Sy7N41+Z5cNB6roGxEoqbv3bXS0BAxeet2/+05y9Uj0Ea3NRYtk6VgC+MUqm2DJSWSf66nUet2KCzPhPb1bDJls3yoSY3XcwTg1UziWiO3PextqMapRUv5mz8ZyamuOcU5TIXU8imn8F8dzoAyHrVi45V2jpvChegavF2AQzPN9pG7UIriDUQXhic3mnSsOKo6+Y5yNAuMeYCtq1ekxKYR7DF6FOfqcLFMsbre4239pPlhCta7mtsUaD3s0D2d+OOGeVxzI7MV7WSa7h/D9ZK4VBsQrKWBpLAqK6mbftWY5ObrG24lv4KX0j33c3uwLOO7UVMA/QkbTj5TFvxUJVScVDUEl98vMw6y5kOGPlV8O2QPJTvlVXUpf99k/Y+sGP5Osh2fKNPevH5RqDSLWMjvQoJ5f1mfVb7Z4w==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(34020700016)(82310400026)(23010399003)(36860700016)(56012099006)(261009221727099003)(11063799006)(4143699003)(261009223327099003)(261009220027099003)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(6133799003)(13003099007)(22082099003)(3023799007)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vLPT1DzigKuJKThgrf1wD0/xTDnG/2VUeb4sj9ZJ7OcZrwIT/5gx9lbf+GdUAipRig0krAjf2YYZYsQSSlTqXryOYTm7jrtdQdY/X2gmBxnlv6O4+q9O1gUVN+I8NzI28O5lVZNo4kTLEusTp819kVTQEKhhO5uWM7LMuRaVsP02S2Qed+PG954sdMSHdowQRrQLDgd4noFHI+QPj0xQNDcfT/ZvcXjnl1ll8uxsv3QKtnqOwHFXHSyzrG699SJdtvFkPRXfTTYGLo7B53rC5IEEAIK/BhNa7nGdE5PZwb7FnYZeJzPU1xQOw+SWCLDXO3rCTigTT5r5sFYo+5Eh46eojpqaF2Yd5MmnGDjjfS4KoRUGlE4muBi/DNdEeexfm8ANLMa52xi8EpC2/H2+lbo+sr3RTye/W6eAArLIjJx6yxSIyL3TCmAhPYX1+KCs
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:19:24.5983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f96cf35-b4ff-4f92-0a83-08df2a9d67a4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6344

Hi Conor,

On 10/15/26 00:49, Conor Dooley wrote:
> On Wed, Oct 14, 2026 at 06:51:45PM +0200, Olivier MOYSAN wrote:
>> On 10/14/26 17:15, Conor Dooley wrote:
>>> On Mon, Oct 12, 2026 at 02:56:04PM +0200, Olivier MOYSAN wrote:
>>>> On 10/9/26 21:12, Conor Dooley wrote:
>>>>> On Thu, Oct 08, 2026 at 06:37:26PM +0200, Olivier MOYSAN wrote:
>>>>>> On 10/8/26 12:11, Conor Dooley wrote:
>>>>>>> On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wrote:
>>>>>>>> On 10/1/26 20:32, Conor Dooley wrote:
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +required:
>>>>>>>>>> +  - compatible
>>>>>>>>>> +  - reg
>>>>>>>>>> +  - ranges
>>>>>>>>>> +  - clocks
>>>>>>>>>> +  - clock-names
>>>>>>>>>> +  - clock-ranges
>>>>>>>>>> +  - "#address-cells"
>>>>>>>>>> +  - "#size-cells"
>>>>>>>>>> +
>>>>>>>>>> +additionalProperties: false
>>>>>>>>>> +
>>>>>>>>>> +patternProperties:
>>>>>>>>>> +  "^sitf@[0-9]+$":
>>>>>>>>>> +    type: object
>>>>>>>>>> +    description: Serial interface child node
>>>>>>>>>
>>>>>>>>> Why is this a child node at all?
>>>>>>>>> Probably not worth reviewing more without a link to the docs for this
>>>>>>>>> device so I can figure out what on earth is going on!
>>>>>>>>>
>>>>>>>>
>>>>>>>> The MDF is a digital filter for sigma-delta bitstreams, rather than the
>>>>>>>> analog-to-digital converter itself.
>>>>>>>>
>>>>>>>> Here is the link to STM32MP25 reference manuel
>>>>>>>> https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
>>>>>>>> Chapter 45: Multi-function digital filter (MDF)
>>>>>>>>
>>>>>>>> On STMP32MP25 SoC, the MDF provides 8 serial interfaces (SITF) and 8 digital
>>>>>>>> filters (DFLT) which can be connected through a multiplexer.
>>>>>>>>
>>>>>>>> Below is a schematic view of typical applications targeted by this
>>>>>>>> peripheral
>>>>>>>>
>>>>>>>>
>>>>>>>> Audio use case:
>>>>>>>>
>>>>>>>> 		mdf
>>>>>>>>                 +-------------------------------------+
>>>>>>>> +------+    | +------+    +------+    +------+    |
>>>>>>>> | dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> audio device
>>>>>>>> +------+    | +------+    +------+    +------+    |
>>>>>>>>                 +-------------------------------------+
>>>>>>>>
>>>>>>>> For instance, in an audio use case the serial interface can be configured to
>>>>>>>> provide the clock to the digital microphone (cck0, cck1 or both) at a common
>>>>>>>> predefined rate, and to retrieve the PDM samples.
>>>>>>>> The serial interface provides this samples to a digital filter, which
>>>>>>>> delivers PCM samples on its output.
>>>>>>>>
>>>>>>>>
>>>>>>>> Analog use case:
>>>>>>>>
>>>>>>>> 		mdf
>>>>>>>>                   +-------------------------------------+
>>>>>>>> +--------+    | +------+    +------+    +------+    |
>>>>>>>> | sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> iio device
>>>>>>>> +--------+    | +------+    +------+    +------+    |
>>>>>>>>                   +-------------------------------------+
>>>>>>>
>>>>>>>
>>>>>>> So, looking at the docs and a brief chat with Jonathan about this
>>>>>>> device, I believe you've got things backwards and this is actually the backend,
>>>>>>> and the adc should be the one populating the io-backends property
>>>>>>> pointing to this device. You should have io-backend-cells, and I assume
>>>>>>> that there should be a cell for the adc to select which dlft it is connected
>>>>>>> to.
>>>>>>>
>>>>>>
>>>>>> There have already been lengthy discussions in the past about a DFSDM
>>>>>> peripheral on STM32MP1, which has features similar to those of the MDF and
>>>>>> similar implementation constraints. For the DFSDM, a solution based on an
>>>>>> IIO backend had been upstreamed. The MDF follows the same architecture. I
>>>>>> need to take a little time to dive back into this issue.
>>>>>
>>>>> One thing to note there is that you retrofitted the backends onto that
>>>>> device, and the original design here is much older (it's a text
>>>>> binding).
>>>>>
>>>>>
>>>>>>
>>>>>> DFSDM sources:
>>>>>> drivers/iio/adc/stm32-dfsdm-adc.c
>>>>>> drivers/iio/adc/stm32-dfsdm-core.c
>>>>>>
>>>>>> Here is a sample of DFSDM DT
>>>>>>
>>>>>> sd_adc0: simple-sd-adc0 {
>>>>>> 	compatible = "sd-modulator";
>>>>>> 	#io-backend-cells = <0>;
>>>>>> 	vref-supply = <&v3v3>;
>>>>>
>>>>> Yeah, pretty sure this is wrong (backwards). The backend is the thing
>>>>> that gets data from an ADC not the ADC.
>>>>>
>>>>
>>>> The backend framework was introduced to implement complex IIO aggregate
>>>> devices. The hardwares that were driving this need were analog device ad9467
>>>> and ST DFSDM.
>>>>
>>>> https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
>>>>
>>>>   From drivers/iio/industrialio-backend.c:
>>>>
>>>> "The typical architecture is to have one device as the frontend device which
>>>> can be "linked" against one or multiple backend devices. All the IIO and
>>>> userspace interface is expected to be registers/managed by the frontend
>>>> device which will callback into the backends when needed (to get/set some
>>>> configuration that it does not directly control)."
>>>>
>>>>    *                                    ---------------------
>>>>    * ------------------                 | ------------
>>>>    * |     ADC        |-----------------| | ADC CORE |
>>>>    * | (Frontend/IIO) | Serial Data (eg | |(backend) |-------
>>>>    * |                |-----------------| ------------
>>>>    * ------------------                 ---------------------
>>>>
>>>> The MDF (or DFSDM) use case, follows this topology:
>>>> - The SD modulator (ADC core) registers in backend framework
>>>> - The MDF registers in IIO framework and exposes the IIO devices
>>>>     It also get configuration (ref voltage) from SD modulator, to compute
>>>> scaling.
>>>>
>>>> I agree that if we consider the terms frontend and backend, the elements in
>>>> the data flow do not have the roles that we would naturally expect. However,
>>>> if we consider the expected role of the elements using the iio-backend
>>>> framework, the usage seems coherent to me.
>>>
>>> I didn't even get as far as sd modulators or whatever, if I understand
>>> correctly the ADC inputs on this device are fed by the onboard ADC?
>>> (https://lore.kernel.org/linux-iio/20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com/)
>>> In that case, I can't really see how it makes sense for the primary iio
>>> device to change when data is fed back through the mdf or taken
>>> directly from the ADC itself, particularly given how that would affect
>>> the userspace interface.
>>>
>>> The "serial" side of this seems in a similar vein to the adi,axi-adc
>>> stuff, which when considered with the ADC inputs, really does give me
>>> the impression this is backwards.
>>
>> Some clarifications about the STM32MP25. This SoC does indeed provide ADCs,
>> and these can be connected to the MDF via a dedicated interface. (but not
>> the serial interface).
>>
>> However, this use case is not supported by the driver. Only sigma-delta
>> modulators, external to the SoC and connected via the serial interface, are
>> supported. On ST boards, the only available SD modulators are digital
>> microphones.
> 
> Quite frankly, I don't care what you are choosing to implement in the
> driver or what your first-party boards support. The binding must
> represent the capabilities of the device, not what subset you deem
> relevant at this point in time. I'm not going to ack anything that does
> not consider all use cases for the device, especially since I the more I
> look the more I am convinced that this is the wrong way to model the
> relationship between devices and therefore intentionally ignoring a use case
> is likely to be problematic when someone does decide that they want to use
> that feature.
> 
>> Anyway, if the internal ADC to MDF use case was supported, the issue would
>> be the same. The whole ADC + MDF set would be presented at the interface as
>> an aggregated device, and the ADC data would not be directly accessible to
>> the user.
> 
> Of course, that's what I was talking about when I said:
> | In that case, I can't really see how it makes sense for the primary iio
> | device to change when data is fed back through the mdf or taken
> | directly from the ADC itself, particularly given how that would affect
> | the userspace interface.
> 
> To me, in that ADC to MDF use case, the frontend portion of the aggregate
> device presented to userspace needs to be the ADC and the MDF needs to be
> the backend, since otherwise the ADC will simultaneously be frontend and
> backend, depending on which channel is considered. That makes no sense to me
> when the MDF can always be the backend, for all use cases and avoid that
> sort of problem entirely.
> I've heard no argument as to why the MDF cannot be a backend, just that you
> don't want to because the previous device didn't, but copying what was
> done before isn't a justification that bears weight if how it was done
> before isn't the way it should be done.
> 

These topology problems were discussed at length in the case of DFSDM.
The main blocking point being support for interleaved channels (scan 
mode), a problematic issue that is still found with MDF.
The constraints that led to this approach are in the following thread:
https://lore.kernel.org/all/20210919191414.09270f4e@jic23-huawei/

FYI: An implementation attempt had been made also via the "concverter 
framework" proposal, but this approach has been abandoned in favor of 
the backend framework.
https://marc.info/?l=linux-iio&m=169347396021802&w=2

BRs
Olivier

> Thanks,
> Conor.

