Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793686903;
	b=eUhKJdcm4uEqT5OyoUfXa+fAQlKMEScIVoVGIlAPX42Gs4FrpT+qRHEksab6Ti3sIK4z
	 fekvTrKmr0H9sRg2SHUr4HHkGJYC3b8UJK7E2qGM6PEghLbn4fJkVDFEYeSDKg+pLOkyX
	 imZrtsFO3YIcWU61Ni/Nfi2PpMDVgtMakgihDTCumG6WOOI+rMqE0Vb09bSbhCOFGfHLC
	 qkZkBLMyOZla2CvjR3/gZMTFhb0l4fvMUp+RF9T2v3z0MYcN5XK8jVCyPAZ6OmQdaSTu1
	 tAbfvTjBL1NCl2xNltXZp8Dde2pF7iTB5Ulq/AruSHXPaqPpKN/rapKBpXnrVRj12bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686903;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mgaHoaDSnb1mohn5EaSrqbs7+U3txp2mNBSExj0uQW0=;
	b=K5WKFJhNmq6ToxPbaBpg4oqwMEZ0lDvVlsTOsHyKO8yYPLr0B36FveOqQzGtDgDEjMl7
	 eBtNQ2aTztSlEddt/Zs6rslTNGixUQgsl0ELwRKHy01x/uJZ4kwT+UITUK8ypHH5B5Wv1
	 JDkWtYAZ3ncE9H8rTCFX/XMVTH3y+9S1+gFyAOzhG/WHMKnsNR8rsUgrW/A5TRhXBt/w9
	 SKeupXwAa4OdL3WHdGYOmu7CF3oYEg2mY1l0IaL8EVm2xGJx7mF1JoABf6SPw1nSGiLkm
	 VVm4y6ozOqdx8C988IR9VnVf7LG7sjva1UCyB+G0KCmyUy042jdpNhochpcSK5L6ztA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YHsXXiiF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.12
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BB606A32C;
	Tue,  3 Nov 2026 06:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 625BB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YHsXXiiF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEAmLTlksRrMFyEcMRzpR8x1g3ijnt6/scgRwSbP3rm5HuKB9Gq6qrzKsSkgsTUjDMQ0l2XIomWlpIbtnUGmg/3Q36iz1pvhzcdbx8pOVbfE8Kx7vpdccj97+FdE8Rbm+GhCRaeCjEvoEP5AoVfKTpi4igFXtaVEwjnHccBJHKNKD/RgK6ADJ0Llyj+T9+R8XwDw26nSntrGZWNY27ZDievrPJcG2k1G2rr/CRlrHTzZSO35rOhj0YWZoZstj5qQClFSyrmrBw1697a6SHFty0QEArkqhpFH3JC7KM+WReGF8ydId7R1FdFg4Pur3N4IA9bmZKebfDs4AoX6jL91NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgaHoaDSnb1mohn5EaSrqbs7+U3txp2mNBSExj0uQW0=;
 b=KECFOceopEc+6pT1skFgtBgVELAfz14hCMy6fJgu8QZZZRg9C+1zEafjugpuXMecTXvmZf4UreyfazhsglXjv9u30rnBhE5r9PxYoBYxQeZvFPQHz51838fqFplr3pQH2BuFM0aiHDtavk3BizQI7etou22YOpry1aQDO2Asdtvo0/X7uMB1G/91PMzGbr2q4R3yShbfCIUVtz5r8wja+gQ61rlK1s0AcD36XE79ZPi9DG5F9lSywgR11SKQRY7ZXNKRQVpLQW2JcJqqcgdtjFrYDCvVZw+C/7xRiaeuVIFVlB2pvWNxexLp6Ajh273MoEm9quo9l7h4wkWd5YC0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgaHoaDSnb1mohn5EaSrqbs7+U3txp2mNBSExj0uQW0=;
 b=YHsXXiiFpJxCVZJUsDC1us6TriZk7/RrObzYaZnch8Sm6VVrOxjbXcUlVDKnqGjyBQwdJfIpMDOMeAWYYW3nBb//rcDoXZkQxprLi3orDx/HgfOvFSMsD4n33CPVceAJFu9ma3n98rfv7qaVzsIwhrT2LCI57DJXcqfPNYghinc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:37 +0000
Received: from CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8]) by CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:36 +0000
Message-ID: <3ad2be9f-906a-4f7b-b9c3-627aad8f0a06@amd.com>
Date: Tue, 3 Nov 2026 11:51:29 +0530
User-Agent: Mozilla Thunderbird
From: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: Convert xilinx-xadc
 bindings to YAML schema
To: Michal Simek <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>,
 Pramod Maurya <pramod.nexgen@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Salih Erim <salih.erim@amd.com>, conall.ogriofa@amd.com
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260515075736.172172-1-pramod.nexgen@gmail.com>
 <20260515075736.172172-2-pramod.nexgen@gmail.com>
 <20260516121856.12b8880f@jic23-huawei>
 <ba1a416b-1e4a-4c75-9856-6d7a8794dab2@amd.com>
Content-Language: en-US
In-Reply-To: <ba1a416b-1e4a-4c75-9856-6d7a8794dab2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0192.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::10) To CY1PR12MB9559.namprd12.prod.outlook.com
 (2603:10b6:930:fd::14)
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
X-MS-TrafficTypeDiagnostic: CY1PR12MB9559:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 591342b1-3a23-4e5c-2571-08df3972b6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|3023799007|56012099006|11063799006|4143699003|261022105027099003|261021121427099003|261009221227099003|261026121527099003|261022075727099003|261022113327099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	On73emmriXbso+yxSZNdl9HeBv+KrpeGmD7Xg7lCCP8WP8Zh+bFkVyb5sOSdBc0pEE7uLHCITlLPyOAdGGU5rr/bGwCG7rdEOmIuc0nYhKCibVs8vsYoxpbVsetvETxyynU/SW1Mp2g0jhFYl/ocFBYI8ChMyU8di0ODIB6ARc9whN508sGLk7j+PPRM2AZZX5S+1tziGpKobhq65NTLVPzE8PmCvEVhPGNJgQV9fwoqJZwdOuzUwjcNPbHhBOjbRXrrl8rVIVA2arWUAn8d/LbmOaJwvn6i48Jqpu6OLBqjY3k9EEipxmfq2CVRdWNcxAPdj8/3i4VnzzI2yQOBS5PXEwA+OPJoyi2MeXuOExTpZHF84xQFVup5kPfhwXb5I9KQNUa+vdl8QFW6PgmPEXLbAapPXRrVtRNSIdHLl0YfOGPCY6PEg05qBe5V5b0fVq1x7Z8zuPQovOwLVG4XF7XHsCMMYdcURdpvk3a17Tb4+NTR/+D22V1OMT/EVlPFx8c5YbhM2UtrCFp08cKCzQ35yMqq1cQgD1pETLHEBDweREfEPZWzrgnTIKR4OZFgWycrM6ajzvNma9EcStDNJoRZyhelAZhEnE7c6+9YwASAyVSi3UTi0w6J2pHbxsl7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261022105027099003)(261021121427099003)(261009221227099003)(261026121527099003)(261022075727099003)(261022113327099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGpXOW1xZUp1aDlrZ1YwMzQ2RzVjdnM5ZlFDaE1TTkpscGJMUzlIR2RFUk9T?=
 =?utf-8?B?dk1maFlzWVBLbFZ6bGlwdi9aQXN5YmpNTy9IaDZPWDEySUt5aHZGOGRLNGl1?=
 =?utf-8?B?VkcvcXk1SU5sQXZ4OGpsU1ZpcUdsangvSktJSnRDYVlmWTZIUzQ0UUJ1WHBp?=
 =?utf-8?B?bEFma0ZvNmIyVWRjc041UzZ2dDNPOXdVOElMWlNwOG5hK1ROZHNWbmtpamVO?=
 =?utf-8?B?Vi9XODVTTkFBVDZWSzlqSUhNcVQwRTFUSXZYcTlaa0d6Y1BwY1lrSUN6WVNj?=
 =?utf-8?B?UW9YZHY3VE9TdHd2eFVZbkExOXB0cHk5K2JpQUplNVZtcFR5QWdYSDllMUg5?=
 =?utf-8?B?RFU1ZDVaUDlqdUhKajMrSkxJZ2Y5RVBJbEowMWpyNnlhcVBUSzVpS0pVK2hW?=
 =?utf-8?B?ZjdJTXdzNUxhaFc4Vi80SENuVmpVaStUUTBsenZQMU16YnhOUDVJeE15ak1X?=
 =?utf-8?B?NjMxQ2VHKzVvSVB3ZkdOdFkxTnZIWXhITitzdHQ3RGVlTm5FK2VsM1p3bmxV?=
 =?utf-8?B?Mm03NlFCYnRoWjYremU4NHo4VGJKRGdqQ1QrV3BJeTdIQ21NcncrY0lqdDI0?=
 =?utf-8?B?aXNxZXBvMmZna1JaaUVlQjFNT2FpYmhpSStJY3VuQS9jU3l3bTVoNlFmaEU5?=
 =?utf-8?B?QnVGdUNva0N1aTJSQ2srNXhaRkg1Q1NaYmp6NmxFUXNSS0ZTYXM1QUJ3Vm9F?=
 =?utf-8?B?Z0hQRHFiVGdmYWRZSHFMUEtLS0VZQStIdm5iTFVPSlFFaUZMU0pmeHp4VDg1?=
 =?utf-8?B?SThxeEZDSUlkTkYxOWlaNmdoREl3aXZ2dGxXR1JUQlRCb1B2TWsyaFBOdUc1?=
 =?utf-8?B?c1NOMjZySmkwRFN1ZXd3bnZ4K0lQVCt2US9iSk04MEQvWnZ0U3RYM2FSYlJS?=
 =?utf-8?B?MVFXSWptcXRhTWhPS0ZFemF4R1FVTFRLMlJFQmlSb0FUczFSdXRiSnRlY21v?=
 =?utf-8?B?STNlTkUweDduNmZYSlhtQ085dVgxalRVOVcyZ2Zxb0hoTG1udjhybU1scjRo?=
 =?utf-8?B?dmVGM2VuOGZJSnB4a2lWdXFvNlFtd1dFWmwrUTBSREdpMHRER3dxSWRvREJv?=
 =?utf-8?B?UDdsNHNyTjVQQjN4U2lVRHI0QmtjRTliTnREVzdpTWUzYk1CaVNNWFk1UDBX?=
 =?utf-8?B?alJxaVVteW1kZUZKY1dzZHVEMU1CUUFSQVVsZGtlZ3Urc21WcDNWRHhzVjI5?=
 =?utf-8?B?Q2RSQ3RIWHJVTmJqOUk3cU9jdkIvSE5jdmhPQmozYXBWMTllUTZUMytHUmJM?=
 =?utf-8?B?d0ErVDN0RlJ2NWVXb09VUTl5K0tZOGNieHZHWndGUmt3dkVsdHZ3b21qektj?=
 =?utf-8?B?aGdlVVdiSnVvQVlUOFZZZExYOU9Fdm5mbXBoMTdPWjVMWXhZbXlrMi9Sb3l1?=
 =?utf-8?B?SUQvSmVjVnlyQjlQa2YrODB5VXpMYlRORnhTTE92ejB0VkdVT2lnYklKelN0?=
 =?utf-8?B?VkRzWGozU3VKQTdWT1k0U2pIRDZXajNvck9KM1JyZEtZY1E3TTh3OTlKTkdW?=
 =?utf-8?B?dlFnc1JhK3FCa2toa0h3NmJ1WWQrUEtjeVN2SEhBdVV5SW03bXJYU2VqYWFS?=
 =?utf-8?B?bk5ja0RDNWNMc05wZFFwS1I0NWZ2a1I3b2ZOVWtvSVE1S2V6N0ZKQ2ZDUVpX?=
 =?utf-8?B?d0ZBc2EvTFJCSW5PNi9lREZXNTNnSFRyMzVVTy9naHh6QjNiK0lWNmp2R3Rh?=
 =?utf-8?B?RUFDQkZDL3hCOXh6TnZPOFh1TWVSK1p3cCtlTnpOQkpiOVY5WDNOSUZXMFAz?=
 =?utf-8?B?Z1l5b0puT05UWlZvK2tDUnFhajA4WmlWaDBISGFxRnB2MlpnK08xN1AwY0lj?=
 =?utf-8?B?elQzVE5xd1BnT0dVTytENitlQzBuYUVwamtWODlFd1RROGdQT3ZhRUJTTEZn?=
 =?utf-8?B?aFFROEIxeDMxNnlmdHJwRXFxelVHQmM1UTN3OTl4d1J0dVFzQTZFRTFrQlQ3?=
 =?utf-8?B?VmpPUCtKTS9oS0lEZWduTWxuWC9rV3JSc0pockpOb2RoZUpTN1BWcWQrNFZp?=
 =?utf-8?B?UzBVTFNOcGlTdkRpaHBibmE4WENXM2hLUTNmbURHYmovZWJZMEJIZkFaeHpW?=
 =?utf-8?B?UTY1dU9ibU1PZXVEbE9kZG5QaHZMdjhwdENyQ1diQ2FXcmQ1UmtuYjYxNVhO?=
 =?utf-8?B?K1I2MlpuK3p3U0xJQ1BzZ2xTYkMycVlsVGYyMjZOS0tYNFJHTUdXQXRkZlNN?=
 =?utf-8?B?T3YydW1pNnlGeXF4WFAxMEV4THBIbU51clllbWFCVGI5cFRodVRMaWY4Q3JJ?=
 =?utf-8?B?bXJxdHdrSU1zTjFnblFaRDhVbktoRzJVam43c3VSRnBGZjhsaWdCTlhBM1lq?=
 =?utf-8?B?VkFNS1FnL1hKQjlpOHdXQktsM053N2kxMGJ1WkNEeVZwMkQ2ZWczdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591342b1-3a23-4e5c-2571-08df3972b6bb
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:36.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3uMGADRv/N24j0QfJOzPMQMPFCV0lBN45WcC5TNnniH2GLuYL82bBd1gufkxjkL5Bgd+EDhDQ3uXVRQzNKf8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

Hi Pramod,

On 5/18/2026 3:07 PM, Michal Simek wrote:
> 
> 
> On 5/16/26 13:18, Jonathan Cameron wrote:
>> On Fri, 15 May 2026 03:57:34 -0400
>> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
>>
>>> Convert the Xilinx XADC and UltraScale System Monitor device tree 
>>> binding
>>> from the legacy plain-text format to a YAML schema, enabling automated
>>> validation with dt-schema.
>>>
>>> The new binding covers the same hardware and compatible strings:
>>>    - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>>    - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>>    - xlnx,system-management-wiz-1.3 (UltraScale System Management 
>>> Wizard)
>>>
>>> The xlnx,channels subnode retains its legacy name (including the comma)
>>> for backwards compatibility with existing device trees.
>>>
>>> Place xlnx,channels under properties: now that dt-schema PR#195 allows
>>> comma-containing nodenames for long-established bindings. Fix reg
>>> constraints inside channel subnodes to use maxItems and an items block
>>> rather than bare minimum/maximum keywords which are silently ignored on
>>> array types. Remove the redundant type: boolean from xlnx,bipolar since
>>> the $ref to /schemas/types.yaml#/definitions/flag already implies it.
>>>
>>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
>>
>> Various folk +CC, questions for them inline!
>>
>> A few comments from me.  Whilst the original was 'example rich' I don't
>> see a need for more than one in the yaml.
>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml 
>>> b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>>> new file mode 100644
>>> index 000000000000..06a0ce498352
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>>> @@ -0,0 +1,210 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Xilinx XADC and UltraScale System Monitor
>>> +
>>> +maintainers:
>>> +  - Lars-Peter Clausen <lars@metafoo.de>
>>
>> I'd like a confirmation tag from Lars that he is still happy 
>> maintaining this.
>> If not Pramod, would you be willing to step up?
>>
>> Maybe one of the AMD/Xilinx folk?
>>
>> Please +CC Salih, Michal and Conall on future versions..
>> (done on this reply).
>>
>> AMD folk, given you currently have a series (including bindings) for 
>> the newer
>> similar IP, would someone mind reviewing this?
> 
> Keep me in CC and I will make sure that series is reviewed.
> 

As there is no further activity on this thread, we would like to take 
this forward by addressing the review comments and posting the next 
version of XADC YAML binding as a standalone patch, while retaining the 
original authorship.
Please let us know if you have any reservations. Otherwise, we plan to 
send the updated patch by the end of this week.

Thanks,
Dileep

> Thanks,
> Michal
