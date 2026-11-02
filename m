Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793631291;
	b=P1Xhql5lF6wzoo5rPvrQQwoUt0ydGtTVkAiAUs6gba76HcIV3CGJ13r7xUVtMqYQ6fNs
	 u3wk2x6Py8abos56q2oCW5xj5y/P4WFHUfBDBd+L4pnHrTwf0hpxtPdbyRRBsCe22Flm/
	 bi9eWdJ+sYwrOubUqzwTg/gH+Pqt1pJAEjfXnBKjbRWdzYyqg2KT/QpYC646GHxquZ3KA
	 y0RgVHe+Q0ejlw9kzJ3TaGF2zrqszMMxIdjKyGOwYqFPNpf2n+NVi9lBW/oH99muiVCeI
	 EYufvTjRqyyngf70R3PqlYXcDKQ9RxsQC8Wq+OCax+mCnSJxo5WCXQi6t0hb8K54mPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631291;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=zAAwoNkCUcJg+yXylU70r6ApsOcaaniUAb5hh/aFJU0=;
	b=xTlMHMnGcvnw3RFfwfHvqno/ip/yS8Qx5HlbujmbzVz+Q1KaTnnsbGknGNZgNmIF2StY
	 4PmisX4ksGV2YUrWR28XWT2cal7szP/hSGtwo4rBGgkiLzmy41z7a7XFc7nwifUE1HOm+
	 meP617evJmVSGyJiam7SwxjjW5A+hwHjHbQuJt+BUnKyZH0RLGkDdGvgARoNc68TYW4SY
	 sl5jINrmYAP/FPey/h8TuJv/9Vnw02pAJaKQ8RYijiwpsQnaUwMdFsXIBXGy88vtAVE+O
	 LTW6XoTMjAVkfVv4AcMscKiqvlqa66Mg9wlZDf5gWzCInXI+rCqFqodhg5yRAo+xoDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tmvo9mZ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.7
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7E607B45C;
	Mon,  2 Nov 2026 14:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D7E607B45C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tmvo9mZ+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRbcFvIeM8vNH1d2gazLALb4PNNT6uXZp3/mdrqvdLFj56lA6yntUBdE6RSH5FzHk//tzAh/SriTi5JflLv5Lx+zwB00vZjH4J1h7Rgot0XSJvQeMOhQfDOu//SqRrQOoRzEBhwT21h6pPFOdQaWO+s2BsrgNXOaCUXzrUROVPeBRxFIDeXfmlOtOOtVHwCp3NewOQi1LxypNCTlGRKYGIXWcEHma5mq365lskcWC6a3T5MYd1wblgYkS2akXuwHpVzXBICKqcccyQpEuWPf7Q4bJHanVEdxDrZ9OTtFni00IWdkwHlkw9Twe2wneYzbmQelEEpAV17zrP3pQinH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAAwoNkCUcJg+yXylU70r6ApsOcaaniUAb5hh/aFJU0=;
 b=vdVkG73FM/7ZwkXNOzjhzS88WeIaGlzJsMhLYnXKQwUgWOZt8riZgAz4gzIgDteTC4NFN8rhg9X/lkpMweBXGn8oovgDve1LEHrFBMRVrjAWwQsQCiHwmHaiTXThf9FRDtnohoW1jI7T31O6/vPU9nzOA58Wh3H8YnY/1bD2ZDliHbg3TsU9y6UmPd9S+LGCYW7qXyppuUU+LUvfebxZTXOf4eNX0qA8//EjRUmeyEAf9zmMsuEGHQ2Lo7WvTVgBmEHCzx/03loff/I1sORiItmc2LCp/bdafiLKeHLDgxLYOPnvNiiIHr1y8aHC9ZxEzi1S2HfhzkEnxVYg58T07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAAwoNkCUcJg+yXylU70r6ApsOcaaniUAb5hh/aFJU0=;
 b=tmvo9mZ+FRZa5mlLeW/3YNE/vfL4AEb9DYI/gsCsT4c07fZHygiNtu+1KCmPFAHQQscMDSl4UwSZ51FhPw2ox0c0VEVnccUbeAToRfwD9mFeNLFN0o88q59EfQrSQtjtulT4iVAMFgMnM1VvWedi3AA+TnkUXTyZzqPibZxSTFA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:54:11 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:54:11 +0000
Message-ID: <065bd297-efca-4a07-840e-ceefc881bd48@amd.com>
Date: Mon, 2 Nov 2026 15:53:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: versal-net: Add SysMon and thermal zone
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amitrkcian2002@gmail.com
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-6-amit.kumar-mahapatra@amd.com>
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
In-Reply-To: <20261102122112.1723130-6-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0044.eurprd04.prod.outlook.com
 (2603:10a6:802:2::15) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
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
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fa3ec5-e6b6-4e10-6891-08df38f127bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|6133799003|261102123227099002|18002099003|22082099003|56012099006|10067099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|4143699003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	ALXyaQFZPJ/24YjwjS0ExvVqP+vWOgZY+xopJIioFM6503zE/Gs9ypDI6Lhn1UqTKX2RbIX8S6ILq2qLzn7le28t8Zq4Zfh+lbcCdYER56Z4O7KQcmjAvbd/KmDbUQoem4Rfauun6JZp1+eY9pb+sA3DmVKM8FdoaIfY3LoxE+nPXOb6b6RmUfFXSCnloRutVRUSPfuC7wilbpf3D/y1PW2itb3BZrIAbxi/N9IzF4IS5XrRLA78cLnESCxXmxiZqhH9YOaEJjfiWBdmXYDzm+7LE1aqAlxY0+LIKI8IKa/g8M8IQRKN2/j/Z/Il9hSp+AjduHvjGR9glqkYZ4a8F07LDr/00XIz8ufQskW5KaN7GU0yHMZ89NHbyfyHCJc9JjMqkvyUdHf/9YlZJqzYVFHv0oVXqnD7dEswhlsCuC6KehigcprYc+0Y3zi3+vrVXjSR3rDuJL2xA3YFIBcyOHlQPmanuF0DTyNUyPBSPFvYpr+gU/QwBS/onC4rFFXCddPW37AJHSgt3x62tlUhqHrUGWZk40JnpsJmGJV7DL3LG1XEmKAQIZPkW8hF2qYNjwsUIBV2H54cNylCf0wsZnIF5oWU+SSj9aKtOlVhTiASJbU8lPI4jDM5sJvY7XvvwKpYyJPyUsDU18GQ/k/L0WrbseMReeUVSZ2aAVcvxqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(6133799003)(261102123227099002)(18002099003)(22082099003)(56012099006)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1ZMSmFBcldiQjR2MmxjNUtQaTlNNVZ0NURNUmJLVXdWbnY4N3FJYXdzeDZw?=
 =?utf-8?B?cHJxeHZScEN0WXJKTWZiNTVXbEtsU3RDdjBtZlBWYkZXYU1pUG5ZVytBcDZB?=
 =?utf-8?B?bmx5RFMvUjE5ME9aNHVBUWp4Nzl2aUtsa2xDa3NZZUN4d2U1bktMek10Rnpz?=
 =?utf-8?B?Y2tETkhWMnVTakxwcTZDYi9EMWg5NVd1b01PdWljMFFQbUhaaHlXQ1dXUU9a?=
 =?utf-8?B?bE9IVW9TeDBFNWx5aCtlYkY1UkZ1bkI5eHZtaHlDSEk0VlFEOHBmZDBoemQr?=
 =?utf-8?B?VVhveE5XWWZJTDhhczNzTzN4RSt2aHcyRjhMeVl0S1I0SUo5OTR0UFBtUE9u?=
 =?utf-8?B?b3R1WnZCQld0a211MU9YdjdWcTFzTk1iU2l1NFpnMFV1ZmxTRFR1U2FLY1Z4?=
 =?utf-8?B?b3ArYndkU3NXbEd5TnNJOEhHSjViTXVLcDBYREM4Qk9BMkxteDJGb25NK0Nt?=
 =?utf-8?B?UXIwdVpkRStKZkRMdVgybEJsWlo1UHNwaUJWYlk1QjdaYlhTS2xGeVlaVmc2?=
 =?utf-8?B?SWFaZkhVUUNid3BwSXhqQ2wrU1N2dmxTSTllTUM0Q1F3MzZwTFhSaGNmQnY1?=
 =?utf-8?B?N0tqNzRoOWJib1NZeThlZ0trWXRPZVgwR250VWFOVmxuZFo2cXJHM2xTTUZE?=
 =?utf-8?B?SkhqUUJuZTVaZlIrMllnZ0Y1ZTNFbW1Mb1dqNTkya2xnajhTV09QQ2c0N2M0?=
 =?utf-8?B?NWZnRkxZQ2gzQ01DMXg5VXJ1Q3Z3ZTZob0cxckJBbXYwR01FWVFiYXNYQjhX?=
 =?utf-8?B?dllXbEdYeDJYYlNKR0xPTXR6Qi9wQndIWis5MnBYZnhxbjVicVB1KzNKY0ho?=
 =?utf-8?B?QTZ1K095OGZkUitBSTI1ckZTTFI1NVdIaHBiMkdWYUdIS3N0aFdsR3JjaURF?=
 =?utf-8?B?S1p0b05mdHl5UjhvdmZlcnlGZTNVYVorNU1acnFRV1cwUGR6MDFsWS8xQlpZ?=
 =?utf-8?B?emc1OFhtUU1oSElYWVJ5bUVqdlkvKy9KMnd5SHhBaW9WWnJDaENuTTUxdWRl?=
 =?utf-8?B?TUdCQkN1ZDZjWmM1cnV2NEdQR0U2OGFEc2VLbFVjUTJQUDkwTDJQRU81R0hZ?=
 =?utf-8?B?YjNxaVB6Vmh1Mjl6dmlVN012M2x0dlFyWmlwNnhubGFBb1lPZWI5eHpLU0dT?=
 =?utf-8?B?anE3Rm16SUFzODVkd3QrcFE5ZVBFKzhKRzd4NEo2SXVYdFBGeXM5MklzZXJG?=
 =?utf-8?B?N2dyQXZodXVoeEhIS3NVbzkzS0diUXBBUGFyNVYza3JzbHJEdDhkZjB2SEpx?=
 =?utf-8?B?OUdrbmRQcE9Ca0hoUVJvNVFXMmRHNGNPdzh5SlRFVjFvWFZrZjdmbUcvUFNC?=
 =?utf-8?B?RUY1QzREbEZqajNaTUVaeUtQSU1aNFhnUWx3MmF5dUY1M2w4azZJTTYwRGhY?=
 =?utf-8?B?MjEzbzJKa3VaVm9HcUpVMG1CRC8vWHdXMHAyb0dMUkk0WHAyMENFSGtrbFdh?=
 =?utf-8?B?QVpCc0FHT1JKMzJuZGNVMnBFZzZET1VVU1c4Sy9TRURSTlhHK2d2cy93cWFw?=
 =?utf-8?B?WjU5cmNuMm9HQStaTEVtTjRSd2dzYjQzaFNXZ2ZTeUN0SE1nd0tvekh4NWN4?=
 =?utf-8?B?VVFXcEFueXNsRVlBaGVObzhkMlZiVzQxNzNGb0FuV2hxZWxPS2QvcUl6UU9n?=
 =?utf-8?B?cFh4dnUzT25nWUNHbFJaZ0lNZEdFTGkveXk5UWNRQVkvN3Y0RHFrbTN4TVZ3?=
 =?utf-8?B?TWtabG96SExmTUlYa2RBb2FFb0xzZGFSWVFsS3VZQXpLWURwRlN3VVZIYVdB?=
 =?utf-8?B?M2c2TW9ZdzN3Tjl2Qm9WUDZoRTB0RnNVYm4zYUZNeVJTWG5HUXpEaHlBd21X?=
 =?utf-8?B?L1cxUEVndVpwdmdpU1N5MlgrZFdFRi9LMmNGd0QweG5XOWpydXJ2MGdIRnJy?=
 =?utf-8?B?VWN4dWdNYlpaU0gwU1owQjV1SGt5b2x0eHNPQ3o2UjhSSHVQZWI5VW5WWjQy?=
 =?utf-8?B?ZUpnenhmall0ZWxjQ1ZXN2R1c1Fpb09DZ2x0QnAxcWhpOWI2SWtCUlk1TDVw?=
 =?utf-8?B?SjRhSjJtV2hEMGJQQVpFdDVBcFZ4a0xUdUtGanB3OW83V0FrYUtPMHl6YlBy?=
 =?utf-8?B?Wm5QZGF5aFJqSnhsUldvOTkyM09wSGVtTWVlcGRnYklvRlZRQ1lqa2hEdGdU?=
 =?utf-8?B?SzVUQ2ZPNzZESHJmY1M1NHJKS1lTTUFBY2tHQ1FpdkR4Z2M3VG9GbjNYTXY3?=
 =?utf-8?B?UkZ2blNad3BtczZXTHZOSStCbmQ3ZUdiSTJiWTZ0VnRhZU9lV2lpemVFMWdk?=
 =?utf-8?B?SHd0aDBFbVpOSVZYSUFjakhacUhMOHZCT0NVUTNqeDBYdUhlL2ZLWmgwOVBU?=
 =?utf-8?B?SUNRQWRMRXAwdnEwZ29DTGJXdUNCTkEvaU5tY3BraklpQzJUUG42Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fa3ec5-e6b6-4e10-6891-08df38f127bc
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:54:11.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLkdcP/MHiXTUhd2k10vKdDXA3nwRboIGOEaRNiaW8j340KYVmjwwy5A+O+/Sf4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837



On 11/2/26 13:21, Amit Kumar Mahapatra wrote:
> Describe the System Monitor (SysMon) block in the PMC, which provides
> on-chip voltage and temperature monitoring, and use its device
> temperature channel as the sensor for a thermal zone.
> 
> SysMon channel 0 is the current maximum temperature across all active
> satellites.
> 
> The thermal zone has a critical trip at 125C. Passive trips and cooling
> maps, voltage channels and per-satellite temperature channels depend on
> the design and are left to board files.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>   arch/arm64/boot/dts/xilinx/versal-net.dtsi | 29 ++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/versal-net.dtsi b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> index 21bb917bcba1..394181c9a751 100644
> --- a/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> @@ -735,6 +735,28 @@ versal_fpga: versal-fpga {
>   		compatible = "xlnx,versal-fpga";
>   	};
>   
> +	sysmon_temp: thermal-sensor {
> +		compatible = "generic-adc-thermal";
> +		#thermal-sensor-cells = <0>;
> +		io-channels = <&sysmon0 0>;
> +		io-channel-names = "sensor-channel";
> +	};
> +
> +	thermal-zones {
> +		versal_thermal: versal-thermal {
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&sysmon_temp>;
> +
> +			trips {
> +				ot_crit: ot-crit {
> +					temperature = <125000>; /* millicelsius */
> +					hysteresis = <0>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>   	amba: axi {
>   		compatible = "simple-bus";
>   		bootph-all;
> @@ -1033,6 +1055,13 @@ spi1: spi@f1970000 {
>   			clock-names = "ref_clk", "pclk";
>   		};
>   
> +		sysmon0: sysmon@f1270000 {
> +			compatible = "xlnx,versal-sysmon";
> +			reg = <0 0xf1270000 0 0x4000>;
> +			interrupts = <0 202 4>;
> +			#io-channel-cells = <1>;
> +		};

This should have status = "disabled"; because I expect it is configuration 
related and it might not be available. (Or not available via MMIO access).

Pretty much this patch should be sent separately. This patch series don't have 
changes in dt binding. That's why it should go via my tree because there is no 
dependency.

Thanks,
Michal


