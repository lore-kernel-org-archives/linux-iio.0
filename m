Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2943A6F01;
	Tue, 12 May 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595042; cv=fail; b=mBZC3nZN6LW0OKJSvoyaC0hDk87TBLZrtRnNI9jOuX/pvkmXS4dcsk2RKh2/G1d7tYFcE7eWUm5a1nfABY9bNXdnn1YQ4nAgmjnntrrU8z9ZaGFEJO3Ch35W5CXx3RVf45R/YteKHH0bXiBgZuRXghtR5j2KiWWFM3lYsXoMiZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595042; c=relaxed/simple;
	bh=+9dVUtuD7xHsH8uCpabxSLDP6VO3+rTaMzQa6eUlaQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R4lMLje77gei+jKar/E4Udon112KwJ1GfZTC9GkWl8oBILmtIg5BnwFymNvro47LySlHI7sCOEL4PPoAoaygxmhur2GgpLZnd7t6GQIU3azLebTn8kmUUufW2UdxD2qXpIkR9dAiDB0NEGEMQVQtJuIXHQcrImVzkHHJcVyi6F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g25iOIA+; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g25iOIA+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGeMLYXCcQJ8kWmtVJSNc9zOc6xNK/ttbXQ8nMY0c6k9ra9TXDqMytA1GJOrxmjT5kiPyTrXSiS1GEM1c3dQ6/pvJ2SKA2zOHAo8oih6UmVDC7eynMd4HBJfC396wincweGyBGlCbtI6yx/zJOXKItB5U0hnJbvB40+osYFfpIzHDNx70wMzzsZuUBGKw5QQHLufHXwmRMELDKvQGt8a50M667aOj7lLdjjn2zaqjByV7mfIRf9TYhXSdcobTWxmeouorpDELLR7nGGH1CqCiOVSoiuaecwcEB4HdKwIGO95koMEmtBeb65tI4zydb/cVGUF/z5f/M1wseeTb0xReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K829guo6NH2Oq+cCyvwFRGewBmaZ/jGyisRwzEC0eHY=;
 b=facDhTtZOnvPFsP+hMZgzVfhCB6d2LESU50UfoTKADOULEHHRMQVgTH9VhpPUEqI1gammvMr0Sg3Uz1SnKC3fKFNZII2YJjN1zhAB9PJzZLFnlZ66H0mkv3213FFVq06uEaoEMzCk5gkEgMSskfAvFVBDBvOy454ezSmMdMUeF9X1XxALoHC9NwNIxesTsJeIJNIsODcsuIfdrsG3+QIQSoXh8Jz5e3V8H/+GXYPOedCDTNjecHVj0G0eQdhVQvnvRGdw9Di689bKV+4ud7PR/7kDlP0g40Dss7IjMVn4ASKcmHIBviz2N7s5EL6c0ZpjRaczeeRsMF6doPVcZdRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K829guo6NH2Oq+cCyvwFRGewBmaZ/jGyisRwzEC0eHY=;
 b=g25iOIA+rG+Fe+jGRA2fai9IJHvgzjIEmsQ7+9QnsWlch+hGC3e9jk8JqWbT4e+AXhuzLkPGru9flWo141VrWyhB+0t2rNcQKevaXmh69WGr2lHVwDa9eEKpqX1H+1pzPWDXjkDtHDdTxwmm+uGTOMd8lpbL3EAopWAPOK8dEDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 12 May
 2026 14:10:33 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 14:10:33 +0000
Message-ID: <cc26edcf-3218-4294-a522-ffafdaf41070@amd.com>
Date: Tue, 12 May 2026 16:10:26 +0200
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
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 17bec5d3-dc2f-424e-c07a-08deb0303b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|11063799003|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JlyFavnnKMvGQoizWYCLJfcw1Ggvl8kB8eEDMjgGqIA203nlNtiOG6etMmwRmYdAsDvwfT5VNly2483UBcfipjInZim7wz7H2dxkCf5esCprW6oV4RIaDs596QqAVowWQF2ugK2zqrayFt5WdGRlRIwB3zP01eylxQ3EkaihYnXTfYWpvfoSNNz7qCOGwNoexMfrfcYBxGQDFm1XcXdQ5ddDa1W7nuhp3t2Ou5KF1ASPYXiPq04se5CDUGGH/I4EjUBy8nQufXpk9af06VJHg84IlqN84/Ii4sVA9gMtCIa5mbUNtoYv7033jGE5moe91ISAkEBvx/5V5dLfx3rWhPGYrVndUat91w2D5gEXajha6wzrYDWOT2swCZ9zO9hUCILG5BgSriOvH7sIM9kqayI2rmqAryoN2H2U7AOsoxBBBt2ioGlEeEZwTm4gFMBwrAYTE5aI2Y37idFrLC+zG6AvjSso7iEqWRiJpjoi+LQ7uf2XPKqPcsdBRxNuhvo+ivSNeJj189t1DToyxeZB+ZMv9EQ9pLB2wGQXXjFl1eUXdy5uCdKio7Pf0WExsPr+v+NKPhY2zdlp3CQtsHS5tLk1nvkmgE2+Z8nX+0ydr6Ks43vU6TTUCpYtL4Qt3Qom1TA52nMekC60AkonNbYH7rEfCbpLkgtA1W3hgi8us2jAeMXc80cyE/w7dwpaskNo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9788.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(11063799003)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1E3Y29MaVFaVUlaQXdyTit1SEJzOWlSbFJ0S0Z1NW5pcnVFSGRraUpTZUZT?=
 =?utf-8?B?RFd1WlMxSWVydHZKaS9FaUxOdlRLSUo0dmNPNEpmT0xnNEN5Mk4wdHVHVDFo?=
 =?utf-8?B?Q2ZkL3AybVFIM0JKSnA1UEcrcXEycERIcW5FK0tpaHV0Wlk1VWwrRGY3QXhE?=
 =?utf-8?B?c21EL1V0aTNDV3dXVjRzS3ZaN2VuQkdFUFkyaDd1TzVJT1VFT3RVZTd4M2NY?=
 =?utf-8?B?eXhvd2c5WVF0VnRaVzZEbllrSnN2RitmK2t0N3RhNXdEdWpUdm9CVUNJeHhB?=
 =?utf-8?B?QzVqbExqRmxKbVJETFVuaVB5Ly9HRVFIQXQwWDlzSVhTaE9DRGpvYUlyUWVW?=
 =?utf-8?B?aENMcWFjMkpqWS8rNzlRUHk0bEFjdlhLQ1cvQ2JPYXl6SjV3bk9UOHBzQmd3?=
 =?utf-8?B?anpmRlVRWjd0aVp4ZVU4K3Raem92RDc0QmwwdFhHMU1QUisxNFRjbS9zL1hj?=
 =?utf-8?B?VWplRVlhOXI3WWR2UDNndTcxQlJRRmdtOUVGUHlpNUt4YkQreWRRRnlqWUo5?=
 =?utf-8?B?Lys2T1cyWDRqTit2MDB1VExEdnZocE9DNTNlLzAydGdIWnJQWmNuNWtlTDBZ?=
 =?utf-8?B?QkhYdy9xT011YXRrT2MyMmxHZDlzQm02U080OVRIWENFR2lDQ291S1ZiZFdN?=
 =?utf-8?B?Rno0Mkc2NThTN2pnUUVJYytkM05xRU5wcStaSnlSQTNmQ1U2a2QzUlF0bXVQ?=
 =?utf-8?B?UDdIeTZmWmpYajk3TERRa0NXQlhmR0pHakJZdDZpekFsQ1RpRkRqcXF3UldF?=
 =?utf-8?B?RFZaOVpDZWQ4ZUNScTl6elZNL0xucHNWeXNsTm01cnh5VFA0NUNBVkR0YUx0?=
 =?utf-8?B?Mitqd2xoTW4weG1KbVI0T2NJVVZ1VWd1amtVdWR4UTRTd2hsdkpPSlNEZWIz?=
 =?utf-8?B?VDJRUjB4MUUzcEorRWFBUlBVWlkzbzVjR1FSRlVsRm5iaFg1L1RjaHVKTjgw?=
 =?utf-8?B?dU0vYXkrRlNGZkFDMUh0L081Z0pOMEppR1RqWVE3SkM0dzhzbXRJOGxwS1gx?=
 =?utf-8?B?TUlSSUR5MElsS29La1oxZFF6bzhEWjRYU290aFpTSzViMXEzazEwZEhVVUdy?=
 =?utf-8?B?b3YwWDBCYThDQVVXVEhIZ3dRMUZtVnVHaHVoQ0NJOTJVTnlCeDJVWnQzbkhI?=
 =?utf-8?B?R2gwalJia2cxekdlVkZnMFFHTG55RWZsNUtwZ1Zzb3NjS1I5dU1CRlJvOTNx?=
 =?utf-8?B?QVExTUdybmFMNmg1MmpsS1E5MU1UNThTaU1GVEdITnlMeXpRWWJRajYrUnQ0?=
 =?utf-8?B?b0t1L0NIR3QwcUdsc21JK24zU20xN1h4N0xoazJwbHNCZnpRMU1xT0FuYkVS?=
 =?utf-8?B?NDRxM0VKUFlSSU5JbWx3azN4c2FQRnRkN0RNMS9uZDAwRXc1di9wME16TjF0?=
 =?utf-8?B?RnFHci9nTEFvWENqTnIvUXdlaFlLMGRhQWZtUEt2Yk82T0RzaER3K0RJNFRK?=
 =?utf-8?B?d1prZzEyUHFHMmJhTmRrd2JzdnY1Vyt4VlQvcjlhUU5IdVVaWmlxNjlZeFZZ?=
 =?utf-8?B?TXdJNDU5RnVyQW9LbGM1ampzd05EVWVrSEpQbG9McFd5cVRmSTJZYmhMNlNY?=
 =?utf-8?B?cm5ZVVJzWGJGZjIvUit1bVZ1QkRqN0FIbHhnWjNDMWJ0N1BkUml2L29DNzFk?=
 =?utf-8?B?OE9tR0lKSWc0RlFKVThzYUk2cjdsZytPZEpYNm1UbDZZZGFQTks1bEpuMDgx?=
 =?utf-8?B?QVZNVGFwS05kaVE0d1RQV2wxM0tYaTFvR1l3NkRRL0xUOVZJKzEwQXAvQ0I3?=
 =?utf-8?B?Vkd2VmhncWtCQjJwYnhQaFhaVW1TaDRodHY1VHI0M2dDL1JBeUQrUWlQYm5L?=
 =?utf-8?B?a2tXMm5kWDdyM2g0TlU5SFVQc1dxdk5vekhmcTUvN05wVUUzVnJEK1ZXSDhP?=
 =?utf-8?B?Mlh6eWRmdytscnZRSk5kTHRlUkd3bXJjeituNWxtZTRNNnFyMWgwUXBxZS96?=
 =?utf-8?B?NmNmUXU1ZWlqREdoZ0psZ1RxemZCWWRFT1o5eUxZNS93Z05BTngvTGdRSnZI?=
 =?utf-8?B?L2pVSnZ3N2wwWVNCUGFpcy81Sm1tWmtreWUzUEVuNlluMlZDclhYUnRycTFU?=
 =?utf-8?B?Y3UzSWVnRlYvMEN6d2NKdTk4ZzhFSkVwQWp1ZEtJWG5NWlN4cTFWNUc3QjFs?=
 =?utf-8?B?RGhON2NDNEl2VEUvcFNFbzYzZEU0R1N3VDh0WjErQ2VtVWpyT3d5VmdjNjVr?=
 =?utf-8?B?NFd6U0MwTGZtNThQMWxnSFFPaUNhK2k3MEt1aHJDd1hPSUNaa21xN3ROQTNV?=
 =?utf-8?B?c2U5Yk1zS3M1K0FnOGJBZFgrL3V2bGRDYVJmYmJqQUpxcWl5a29ObmhldHoz?=
 =?utf-8?B?K0poQkkxdytDV0JKMElZdDV0WUtVbzJnamFWUndtWTlEeUkzTXcvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bec5d3-dc2f-424e-c07a-08deb0303b49
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:10:33.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dqbBrk8i4Af66lKx+ewt0aCy7k96ikTuOvGy20TQQfPsxofXYm47G+QZHZdzg2c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527



On 5/12/26 15:58, David Lechner wrote:
> On 5/12/26 7:14 AM, Rob Herring wrote:
>> On Mon, May 11, 2026 at 11:24 AM David Lechner <dlechner@baylibre.com> wrote:
>>>
>>> On 5/11/26 11:15 AM, Jonathan Cameron wrote:
>>>> On Sun, 10 May 2026 08:01:36 -0400
>>>> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
>>>>
>>>>> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
>>>>> from the legacy plain-text format to a YAML schema, enabling automated
>>>>> validation with dt-schema.
>>>>>
>>>>> The new binding covers the same hardware and compatible strings:
>>>>>    - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>>>>    - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>>>>    - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
>>>>>
>>>>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
>>>> Hi Pramod,
>>>>
>>>> Something went wrong with your sending of v3. I have two versions sent
>>>> half a day apart and no idea how they are related.
>>>>
>>>> Anyhow one of them got feedback from Rob's bot so I'll assume we are
>>>> getting a v4 and wait for that.
>>>>
>>>> Jonathan
>>>
>>> I think Rob will have to fix the bot to make an exception for the
>>> legacy bindings. This should have been called out in the commit message
>>> as requested in a previous revision.
>>
>> The bot is not the problem. It just runs validation. The schemas will
>> have to either drop this check (comma's in nodenames) or exclude just
>> this property.
>>
>>
>> Rob
> 
> Even though this is an existing text-based schema that has been around
> for 12 years with this name already? Changing it could be a breaking
> change to existing users. Although there aren't any in any .dts in the
> kernel source.

Zynq has it described.
arch/arm/boot/dts/xilinx/zynq-7000.dtsi:111:                       compatible = 
"xlnx,zynq-xadc-1.00.a";

And make no sense to describe programmable logic which are that other two.

Thanks,
Michal
