Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924FB3A7D78;
	Tue, 12 May 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595708; cv=fail; b=NWMT/luDd4R3Cb73ydEIbha+mZBYb18vq5E/hlaC/qJ8Bkk+tOs/+QrfczAzdtZpcAeaQc+qrM966yjsAcyFF+y7m44yOJddAS9coMgMnUSgGS1BDGZ0Do9WvDkrEgcH5LpLuwnZDAY9kJQgDwTWCNo6gO8goRCZMbVzMLRYhS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595708; c=relaxed/simple;
	bh=RHn7IY6EgtxCvTHrWGd7XthfSnE03RljdRhGTRZkB7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q8hwemA5q9Ft1sFNjMjG9InBkuAFDwLsCFwZfebEMC3vSy6h9Koyp9VAj3u4KEBWxJwoYUziGg0X3MAJ6n8pDskA9xY1R8XkMzn1UusAOPOCN876/GetHjrcOmdarC2kIN0S1kIgldEQf8wpwJEHpukf9im1OEy+fiY2NEJXZS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WQ8E0n4J; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WQ8E0n4J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySnactiFI8+J3efKfQh2+Z0hV9y9ce901OXpWAf67oJSwuzuegsjgHQtxjt1DLLGoC45Ir4egbHpEIdC1u2ryFjos6MpcK6oerI9LlHkim7mI5u00FH3F+8GmogerOE4gEcLgwBPFskindPJKKiz1HoLYB+EQ77pwVZD83kQPRfcCscszWZPdLlTzm3elusF9SRiSitlG0jiB15wNtFCCSk7irjmPs/MvgWWk/aRhmQOQ6flp7lpYPKAuAhckQYyxaSFQ4yZDDuT0A/W9FsUyID3/qbuVIj9BWdcEyuzjN1ng4xIIxUHlupkaNmcajfYeCxhe1slaOI94qz2ttTUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T27Wj8wdvylScwa+cxisCMGrHhX6nj+/CFSx9W5dFJE=;
 b=aFbQGKz2JVRLV7bxozHRj+eCedpFYpXlq3apbno81DuSx8nIhuBqFk4DAj2uNZ4rtT+GXWeun+toIa+9IhFakNJroBpc4+Uh0HJ6D1tnu12niVH3Hr5zUSiP/1Y7MNkO6ctHnehHqMoai5OgFkdAhxsDiUpSP3K9OA3NbUMw2SowkJQ4UUipsR5/CovcxuyYdVZdqHkbP+1lITQfFURwdYVUcIAPVFzQ6ihJw2KvILi39F+kGB9Hr7YiAnhgnKNU2pPSimLigCeZ9elFLijVWqq6dq/Z1vak8Ht2XfmR/6QX3A7+s90ZCkp/FlLFr+EatQ80RGUz8967+moljNQVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T27Wj8wdvylScwa+cxisCMGrHhX6nj+/CFSx9W5dFJE=;
 b=WQ8E0n4JLkH6dYQ/+5Y/WT02wQgJsQ/jxcw+6VCvXZU9GMAzltS6TFuuKpweBZD4PiNwwK0uvqa7Q8ZeE2ukAXD5QVDdfYc8CNo0zIoUfe9HbGShKTbJsPKFHALEpqK/rINww+6Xq8vWhx6p0J2ElVGkZ22TTZ3Vs6ZkRgTCqZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 14:21:40 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 14:21:40 +0000
Message-ID: <55a25652-bd45-4487-af76-1d65fd207fdf@amd.com>
Date: Tue, 12 May 2026 16:21:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
To: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Pramod Maurya <pramod.nexgen@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260510120141.118057-1-pramod.nexgen@gmail.com>
 <20260511171554.6541042b@jic23-huawei>
 <7baf9ca5-50ff-4131-995b-70ee094ed247@baylibre.com>
 <CAL_JsqLxtWLR+jxRXt7Uz6dcF-90NYmfyGWYQk9um9TYHSWbTw@mail.gmail.com>
 <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
 <cc26edcf-3218-4294-a522-ffafdaf41070@amd.com>
 <db7fc677-56bb-4421-969d-6116a0a57d77@baylibre.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <db7fc677-56bb-4421-969d-6116a0a57d77@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::27) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8d413e-e908-42e7-b588-08deb031c903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|3023799003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Ygh4MCFBEiUKMWG/t0poVddrqP2DwtppArGJzsK9WIecAocvohrzag07tXF+yu+1eZ0v93AJhPeH1WtUjnGnu99EOFyUn46VuTG+BCzsEg8LIC8Rxxx1yLVqGMK2ZG5ui9dbwNFKsFJLp862mQA641+0ozzO+eh3yVx1maryzCKrN4YDQNCcI3qMuazjtdZsclSVHjVQf8+GOZ8JzR8WzH+/kf9ARAKrevd2fKTzvwSihjqzul8anouVUNd48WrRx/RKoI11Ghe1DlwXupvWI2oKO9OjYRdWA98WOqzsbZQOB/IIAH5X5cE1uC9EfOiRHERBWm1zsA9N/Fs7ygpQR/nVYTE63/k+sRE/zptBUyeSYEQUUw0NOL8L0JYyYOsQEnejDwK0uW5vBBGAnDn+5eCqmcYszwDk2glLXGjln5WS38p3vnfbVuWuXb5NZyvpzpnUxYyZG4wZu55AwcXgVYZq46qCygaJxVeYVtPa58lyrLDXxY9sGF8jqpbnU7sAEaaIMFLTM77CIcUkRjZ/B62LoyULoto1M1X8f6kj591Vu+mJFdLJ5QbujPKK6sjIRUuRKr5QbHys1/zuHHrSx+j0OdNoOGnzPbHpmN4dpGtpB2GxwwHEnioZFSodcXcZSzPUSfdo5R8WrOXGkADujPQPl0AlyuBDRVumvV1yqYL/musLKBObRqTVmnymEKRQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9788.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(3023799003)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z01TR0MrKzU4M0Q4bHppZ01Ub1MxWC9yQ3VVVGtyYXRKQTJEc2VrdnFzVnF2?=
 =?utf-8?B?UHc3dFdNWDg5Zy9tNTc2cmJuZGhyd2J5Y2ZhclU5VHNXSzJtdHk2MEJTSDM3?=
 =?utf-8?B?VTZaQVdpRlZldU5MVjVMaXJMS2xuU1JNNmZaZ2w3eDN4UVpxMzlxWVIzNEM4?=
 =?utf-8?B?Tk95ekhwbmlIdlY1NEZEOWlKaWRNT2dJcE1XSGY4c1Ewc2owRTNNcHZwZ3dy?=
 =?utf-8?B?UXJmRHJ1UEppbUxpZ1lJdS9wZnltUFBLUWJlYmlVaGR2Z1V1NElwWmZhWUhX?=
 =?utf-8?B?QS9TQUtudGwwTTVLdHBHMHRDSUtpYkVJZi93bGdXVm9GSFRkbGw0OVQzeTU4?=
 =?utf-8?B?VTNmTWVBTndaMFN2T0xRWFdVVlRZWEpObC9MdEtBWGdFMUk1UkNMR0JVd3FQ?=
 =?utf-8?B?b1VIUGlDVlA3ek5QSWt0NnR1aGYwR0ZUQWxyc0sycmQ2aXlVZG1TQUVjTWFT?=
 =?utf-8?B?SGhkMU1oc0JnaDd1RUllZGNYdG1HREZBVnpFWjY0dGFFenh1ZExPdWFHZTVD?=
 =?utf-8?B?UEVWT1RWdmpqSmhnNWtqOG95YjlYUGRNellYdit1T29RUFMzVTVTOTBrUW5a?=
 =?utf-8?B?b0hmMDBmSHpqMkc4aXNjL2l1MThQQXJlbHppUjNhUEFqUUpzb2c2Tnk0eDY0?=
 =?utf-8?B?WjZFaHl3VFk0dk9RVkVvYm9nVXJTcW5OTHdvdDVuMC8ycFNPVUJwMkxhMzNX?=
 =?utf-8?B?RTNONndKU0JveGhpYjhId2VMTitiZnhyMnFjSzlCUzkwQ1Q1MlJjbnJvZnNu?=
 =?utf-8?B?VTVJT0pQRGMvY0d1T0NidjhULzdJUTVkOVd6cnI4Z3crTHF4WWN2TUZVSWYz?=
 =?utf-8?B?cVJNaDlleWloWm1vbzNyeHdFeWFZdU1yaEhoMzNCbWxZcUI4bllBZkY1UnU0?=
 =?utf-8?B?a25aREd2Z3E3MURQcDhjbHZFOUtXUlpZVlJEWHlPWUxOcEdhSVlpeGFkUjg3?=
 =?utf-8?B?bi9nWHNNMU12bitXek9GbVFpL0U3QUk3RTdOOFJIalhLb3RHZEl2dXV0RWtZ?=
 =?utf-8?B?VUNDamIxT0h5eWdzWXF1T0U4NmpwSVFvb3I3QmJVZTFETnhHWk5leWZ6OW1w?=
 =?utf-8?B?OTk4RHk0QUF0ekFtZGNoaUxEWEZkWVhkeFM3aDJHNE5oVlh4bnZYVW5nRm9h?=
 =?utf-8?B?UTdGZ1hyV1dlQzQ5UjlBcStqUUZkWTBvVEk3ZHZwc3lyMnQ5WmF3RE1MbFF5?=
 =?utf-8?B?ZHhsOXFLcHFnT1NaUXpXcms3R0p1OWE4NDB5T2Z6RW1tcmNDb3JyTzVGb0lq?=
 =?utf-8?B?VkMyZGp5REtuaS85dDlIeWN4bGw2dUNWNzltVkNJMndYQ3hHWXIyNEovdXVu?=
 =?utf-8?B?bjhhV1VBenllZjkycUFDYzBSNDhpVU91UkVoYlBpUkJ2UWUxNW9vQlJ3U0ZT?=
 =?utf-8?B?dHlreEcyaGhWMUVVVlZEZ1U2WDVqT0hXQVZ5Q0ZoU2p6YjR2Y3FZaXhmL2xo?=
 =?utf-8?B?K3pSN3FoWmUwS0V6TEtXaitoeWpxSDNpRFBrSFQ5M1djbUpETjBXYUxHZDRo?=
 =?utf-8?B?cEE1RVlTYlBkOUtmbWVNdWdMc2YzV2Voakg5WkpxVG1UQUdHQlRxZmRoRERX?=
 =?utf-8?B?ZFdsbTVGdjNHRTczbUZhTjUzVlFMUmJoaXcxV0FDc0Voby9KNDRUL2tyakRZ?=
 =?utf-8?B?cng2S2VmOUFOVHJhYTYrVUN5ZE01U0xaY3hvMmRhTUZSTEFOQW5CSWdSYUtQ?=
 =?utf-8?B?eEtQQzF5VXBSU1FaYnAvNFZDcDNRMVkwUEk2VHkrMDQrU1RDWWxzL3AwRnhC?=
 =?utf-8?B?ejhMRitLZFEwdzBITmJtSDBxeEwvTmlGWG5NTDBVUlJVTHdJc200eHIveGt6?=
 =?utf-8?B?dU1uMEV5OVMwSk9RVVVaR3NMRXhNWDNVbHJHYys4M3hPNFc4SkpRaERsTFgw?=
 =?utf-8?B?VlZWd0FvTHFkbFA2cy9La3NpbU1XeW5mYWtvMEZPSDBBOUpOSTY5cDVFb3VC?=
 =?utf-8?B?MnZFYkorOXdFdDRvek9TcTB4QWNqQlNNNXZET21EdUVYU0k5ZlM2WG4rV1Ns?=
 =?utf-8?B?SEU2aDhkckRLS0xMZHpPMEtKZHY0ZzJsZkVJTlZyaTI0ampVc2o2UGl6UThE?=
 =?utf-8?B?VGhDcm9kcHUxOG56WHJiN2YvU1JBc1NJSGd4SDdUNmwwaXVSVVFmcXRlanY4?=
 =?utf-8?B?dndiYWJseXgxZlZwbHVFa1pKZ3BrTUJlREsrbVZadjRxR1BKdXpYZ1dJY3Zs?=
 =?utf-8?B?cElrMzVHdmhPMEVzSUFPYzFtVDAxQWdVOWtEbWRraFRQWFFMSEp1dkhQeDBx?=
 =?utf-8?B?QjByNFRoNDQrWWJBNSszRVA3Vk9YNTNSTUZxK2JRWGw0NW9memZuSlFkaU04?=
 =?utf-8?B?K1JYUnViMmhqUnFTazM1Ull6THBkV0lXYkFKQmRsS1c2VUtaZHhOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8d413e-e908-42e7-b588-08deb031c903
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:21:40.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASOaBxgRe7ktrDQOLT0TSUpQEekp5ZsPrb9Q/mr6Qhb33+pjNvKGDlSYbTkS1/Ib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820



On 5/12/26 16:16, David Lechner wrote:
> On 5/12/26 9:10 AM, Michal Simek wrote:
>>
>>
>> On 5/12/26 15:58, David Lechner wrote:
>>> On 5/12/26 7:14 AM, Rob Herring wrote:
>>>> On Mon, May 11, 2026 at 11:24 AM David Lechner <dlechner@baylibre.com> wrote:
>>>>>
>>>>> On 5/11/26 11:15 AM, Jonathan Cameron wrote:
>>>>>> On Sun, 10 May 2026 08:01:36 -0400
>>>>>> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
>>>>>>
>>>>>>> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
>>>>>>> from the legacy plain-text format to a YAML schema, enabling automated
>>>>>>> validation with dt-schema.
>>>>>>>
>>>>>>> The new binding covers the same hardware and compatible strings:
>>>>>>>     - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>>>>>>     - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>>>>>>     - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
>>>>>>>
>>>>>>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
>>>>>> Hi Pramod,
>>>>>>
>>>>>> Something went wrong with your sending of v3. I have two versions sent
>>>>>> half a day apart and no idea how they are related.
>>>>>>
>>>>>> Anyhow one of them got feedback from Rob's bot so I'll assume we are
>>>>>> getting a v4 and wait for that.
>>>>>>
>>>>>> Jonathan
>>>>>
>>>>> I think Rob will have to fix the bot to make an exception for the
>>>>> legacy bindings. This should have been called out in the commit message
>>>>> as requested in a previous revision.
>>>>
>>>> The bot is not the problem. It just runs validation. The schemas will
>>>> have to either drop this check (comma's in nodenames) or exclude just
>>>> this property.
>>>>
>>>>
>>>> Rob
>>>
>>> Even though this is an existing text-based schema that has been around
>>> for 12 years with this name already? Changing it could be a breaking
>>> change to existing users. Although there aren't any in any .dts in the
>>> kernel source.
>>
>> Zynq has it described.
>> arch/arm/boot/dts/xilinx/zynq-7000.dtsi:111:                       compatible = "xlnx,zynq-xadc-1.00.a";
>>
>> And make no sense to describe programmable logic which are that other two.
>>
>> Thanks,
>> Michal
> 
> The issue is with the xlnx,channels property name. Searching only shows
> this in the driver and in the examples in the bindings .txt file.

Because it depends on HW design configuration. Different configuration have 
different channels exposed. We are using device tree generator which take 
current design configuration and describe them. zynq-7000.dtsi is generic for 
all boards. I can't remember all details but I wouldn't be surprise if no 
channel is exported on minimal/default designs which are described.

Thanks,
Michal

