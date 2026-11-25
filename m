Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795611403;
	b=pzirMLv6xYIU+cy18RyhBcknbyMz3MOHlKCwnbkEeca1pN2oTFeLmFXvtAPD1AxWr3S2
	 V4DESh4l0UbE4/U/E16XK9INJR/qarb97/NEV/HDQNu8KXRw0bS+7eE+6TvCOm4bBvQak
	 yut0RF9LUMQMKEfiXMgzApa09cb+VgiZlDCmxr14MS2M8a93K14foUNQu+sc1DQwOZ88X
	 y3H7gof//gPPzTBeqOeMeuz+lyzRJe814GrHoeOTXc/+leehP+/hkNLKQrqO60UfNboxX
	 rXvok+jfNcJzfmskRg0BZLekZMefv/+rKueR47zjm85byNRzJqGr+jXSEDIPv8DGYhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611403;
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
	bh=j4MdXjnFm1Zmbu4F9y1VJvvPrSN2D+YB0/Vrb8u8iuc=;
	b=W8PdEHnsCOm226YYttEjVxl6qievBC1vDDkBfOyMKzttTV2ptNiig4QpMwxHho6YrYjO
	 7XufjAcisAUlImEIbty3oDyFfwGUDcQw2/2IFgP/vCNerliB5fhm32ajp6HSGLyipa2rO
	 ERn8bQh5GokaDDjZfsG6Gxsw1f+knAXzizyH2hZ5t4/MeOtVwFQHrBuU+tQeRBxplpUCF
	 pzj6eTcQCV1Y+/jXZlEnHRpKizail8CdUHmnF3DZKQ/nCB6nskBzXSPfJMiyK1EkW/PGK
	 I++E1AneNH+T7pFX5YcA0y4y/hXqeCDpzlHN3IRwG59whpJRrMFM70szqm7x8U5YLBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=WiuA3gb9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.60
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDD606A690;
	Wed, 25 Nov 2026 12:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51FDD606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=WiuA3gb9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgEFVBRF9JhQDX4j377sMMkVPwrRIem5LdCfDpp1QM6xZi11arvUw47Pt41E/rtrgHnve13+kQg9J7vSy1A6WQbHxRWRgS03OQJo9xTXhVS6gU5m+AbyUSkrbbgEtiwdE1w0SRet3NvuvDmy3Cwk1AyHuHEaNB8DML6c+3R75lJej0YCAsdg7P6qSp57ud9iEvHobfYG3v1GMDPdeF3ufgFRwwKsXS6Ky0QEwLV5nRr1V3Dl8h/t6fXQ9bmPVx7KAg7llW70FVD8UzXsluMsiPjwcETjrYVhgIzQ7pKlniqxaY0u/MGEgWnbv00Yj+qkS0eVLshbsMhOeOTnITrOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4MdXjnFm1Zmbu4F9y1VJvvPrSN2D+YB0/Vrb8u8iuc=;
 b=OYycFVrn1R5iiSgCXSuusjHVHs76BEi7lrt20UA1WlSCXD91dWMBhuhLCIFlmnQngFxNhdgMMyntHl8p3GodUpMrONrkrtmPUus81hUQgPcYhIT9GDBzRoJXgxIKk1JOyNvO19OtREFq059yOf42NQfKjtisoyydfJmk1+geMzXqiDFRS6VqwIddxzt8vExpSbuW4HP3eXVAA4iVdn72iZDknmlUgO+k/Fpwl+wNHJ2DwsBUeI+6icuinZf1Rz/+oa89a/j6cIxDlNECZ+0VJNPCxlNyFXqup/iMjexqzNH16tKdF9CT1n1GlHIC/53b18o/t6/MjDE2yJG54kYpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=teslabs.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4MdXjnFm1Zmbu4F9y1VJvvPrSN2D+YB0/Vrb8u8iuc=;
 b=WiuA3gb9UByT9BDhPNBmQJPPiUwFGmoiDs3nqthxuc1WeyiiKubWgMzMrH9fzmSsOwf5iScnkiJwjwDot04lvcqDIuXodZcYY3V5bsPD9+9WYsY6ePxHcEH0O8cmNHQa8UokqVxmzZlkPnJzdoTM1Vb9RbMicA3J1kXpuR3Ep9xm2B3veKPBD5g6EUXhj+1wdq+4IDnRa+AFXGvuF7BLGkuh6B9fbSdc/bePGA0WnP0UoLMnz3lzwTEnW9vCOrL72cjR4V0F8/T2zQV4Mtfr9Gg8viODZxcwf0xlPS1FTtq4fyUg+M0BG5CoFslwL7yf/QGyFZ1FevIeEQx3oE/IKg==
Received: from OS6P279CA0079.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3e::7) by
 CPJPR10MB309500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:380:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 12:56:38 +0000
Received: from CPH1EPF0000052E.eurprd05.prod.outlook.com
 (2603:10a6:e10:3e:cafe::7c) by OS6P279CA0079.outlook.office365.com
 (2603:10a6:e10:3e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 12:56:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052E.mail.protection.outlook.com (10.167.241.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 12:56:37 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 13:57:26 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 13:56:36 +0100
Message-ID: <89f43760-01c7-43e8-9682-b7363ffc931f@foss.st.com>
Date: Wed, 25 Nov 2026 13:56:35 +0100
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
Subject: Re: [PATCH 0/2] iio: adc: stm32: describe the STM32H7 temperature
 sensor calibration
To: Gerard Marull-Paretas <gerard@teslabs.com>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <jic23@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
References: <20261124202220.23721-1-gerard@teslabs.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20261124202220.23721-1-gerard@teslabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052E:EE_|CPJPR10MB309500:EE_
X-MS-Office365-Filtering-Correlation-Id: 799ac60a-f4a3-4b1e-3004-08df4af38aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qCsfkUrjwIcderXYt2nsrQVK9zddUbpkzRYQ4lOAtS0CO2zaPq7TsHPvn7i1S6VqNTWfE39WcpAFrtti+dw89wqzb4qbMsrrFBy14gvG8IxgBYs6qaspi5Buaw+80rZHoB4Hou8mnPQ5lf2SfJH7st9uO1e4NJeyPg9IfZIorSUYkog6d0r6GCYfELdCNPtAvhqqGst0XVEt2cTua5sQhR4JPURT3Jw29UGtBIknkA+QbgNtloE0ejcqoshpUsEdwoKOj6hzxFbgNhWqb7fBRglMADn+ByUE8V2aFKUHWnt/x/uYTsJqAPk/qgt5brUTRHWZk6iJF8LEIi5XCn9g7GNenDTG+kOhiaD1e2LeQMxATcJm4Q7hQeFjOAuUjUgLyJxV0jNJHxKasWgU/8Z/u3Pc4tT2pKI2LDjcigU998jCjiMX62oYOXE+K4C6MrPpfx7LEIqW2AvOefhoWZ1Dh11MRY024o91eHGbIi6z8bhaj6NHdw+PA+VNlEPOAdDlc1HTpO4EdPR9R6PULfDx3xYxnj8qgzEgD3m7IrgjAgBiZDAdESd/9E2pC2dRuzAZtj3C9Poq05zGC2rZ88W2zLy9V5mrPP1Gv0f9lpAkyQ6lP01imkjzB3AuVoBXVHzTHf1SfDg8oJo4rzjXfLWyLTpKqwzIPmjs5tSRQO17wFs=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qy4tJB5sdMDH49zwRaAGOdfubNXAQpo0Ve0bOZCYU88d+jU6S2KHjyuuxRkZWJGBeixOKR5rRN6iYZrKkTFW9g/5pJ9UGpMlzEnvUMCK2Cmx7oFZSInBOa1WGCl9fo1wKOqqDatQl4jiimr/3xhF2mSzPZxinXhsktuTT+ZZfuBnt+jLX+iCKJLOpsLc2HVkqBl1E6lijWwW4WneA1cWMUC2T3gIqPusC5oC6Z9qyyvBgSrivCXUydgC3N2GC2hbvpRaBZkKofutL13a1hZz3TNfE+Q4KoywZTulYfdDJRVz3qO127mP7d0x6QyyoAew7IFgmANn6Xi+VOuv0g7dWe/9eijt29J7ECJ3UNEQDhsM6rQplvaP/6wBsHBlfEG/7G5dTTnkvCOsqpnAq06bwvslc/cPyqg8YiL/KQYNiAXWFt0AziJx88yX3iGCESLD
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:56:37.7033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 799ac60a-f4a3-4b1e-3004-08df4af38aea
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPJPR10MB309500

On 11/24/26 21:22, Gerard Marull-Paretas wrote:
> The STM32 ADC binding lets an ADC take the factory calibration of its
> internal voltage reference (VREFINT_CAL) as an nvmem cell, but not the
> two calibration points of the internal temperature sensor (TS_CAL1 and
> TS_CAL2), although the STM32F4 and STM32MP1 device trees already
> describe those cells.
> 
> This series adds the two temperature sensor calibration cells to the
> binding, and describes the factory calibration area of the STM32H7 in
> system memory, passing its cells to ADC3, which the temperature sensor
> and VREFINT are connected to.
> 
> PebbleOS uses these bindings, including the new cells, to describe the
> STM32H747 and read its temperature sensor.
> 
> Gerard Marull-Paretas (2):
>   dt-bindings: iio: adc: st,stm32-adc: add temperature sensor
>     calibration cells
>   ARM: dts: stm32: add the factory calibration data to stm32h743
> 
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 10 +++++++++
>  arch/arm/boot/dts/st/stm32h743.dtsi           | 21 +++++++++++++++++++

Hi Gerald,

The DT is deprecated and are going to be removed [1].

[1] https://lore.kernel.org/linux-arm-kernel/2afd5f78-0174-4955-8c1b-be18aea3800b@app.fastmail.com/

So I'm not sure the dt-bindings update is useful.

Best Regards,
Fabrice

>  2 files changed, 31 insertions(+)
> 
> 
> base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc

