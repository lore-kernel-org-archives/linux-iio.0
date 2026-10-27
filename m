Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793067216;
	b=f234NQbYqZuxxXEm2nP0nRvXwZITX0nv5+bS3wyyLkBuR7PuDajfzhUzIU21xrCFHJX8
	 4yXiPXsVxAvMO7B4uIBUdVxRQ3fXcgbFMD9hgeUDWb00KsqC9WawOcD4J2IXSr/Oib+7C
	 +pDzTLa9/kj2RlBx+T585WxnlvuQ9UZLdWYNSTWlv9JD02eDAuDXLcuRsDS+3XsxSsiQd
	 DsX2dYhKQn/gkiqhKrQDe8ZBZOTybGTQ28df61Vz44lGCgKvn3sgVE3pcZYE+uLwMZkOo
	 xGqg/Hs1WGlwI3X0CS0U+MHHtyxR1qLEYMndzjX/Q21Pm0OW2/XNhxSxvsi/mOgYHjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067216;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lNoVkPZsencIeG/dxRIbqL+XiLs4G8X9a3QXQksBHZc=;
	b=dT5W12OoLqXNA5yAkeDENElqfQpGb5upwJVgl48JGwWPhl5lJsJfAqSgWeONjh66Xh9w
	 JWlRsuuJK64YUmjFh1DMTTkvO02FhTsf4BjSwi2Zb2LDs/470tmO6qL4PORQjRZ92MlsW
	 GbJiOl/jBZllyfpsf4kmOJJq4hkYzjykHp1MWh0jpq7LpAPFFUauHWXbewzXU51QbKP7Q
	 6RHbyq1pKQ1WfOja5NdRrn7+5dSM646V8vMt1tcgvDebctTahyEYClYZ/vo4si0k7pqH9
	 xS1boKa6pyTEvda7GI5emjJlt5tlVlbS7w7kfgpYl4SSy3QWINA/I79zxcL8FRPp1fA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=d7YDgHNL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.28
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010028.outbound.protection.outlook.com [52.103.23.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D8606A31A;
	Tue, 27 Oct 2026 02:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B81D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=d7YDgHNL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6M9ylzpSM+2QbnkJEKdiSwyle67bnTZ3PVMtHD/spdS9++IoWX6pLdJgr8m+5Xj80f2n3P85N9Sw9M3Nu0HkD0hIGRzUB8aLJl8YpSgxwrRHjBl3mWXHC3DIV9j9/63MpUDSwb84UK4mEd5VqudhuoHSVXVLVCsINjnIGgKpj69Ueh6HW+iYmoSYEWYzbMK/Dt83PLJfa6NLqPvG5awnSvqiKC7S8sK3w6MfHaD9T26VN91Fq7l5b/uDYXAkfRJErY1hlOkgWHI+Ml5Q0QtD1pAuTTLUh/6BiSzYaaQk4W76/we98/dJsrotGLDDFCd7ORh2fyizVxMXI6xJkPx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNoVkPZsencIeG/dxRIbqL+XiLs4G8X9a3QXQksBHZc=;
 b=bI2qvIwZeJgrSW3/QF2MUFigOssysvcRx5TrHiiFXgAOVbssruhF1IBZkPqsnfsjbudns+VrNnTG8cNX69uNdm8/tFYsH6n0bBz3ug416EsCNZUB4iV2JpQBusT8xIIK98IKXuEfi+4A2GsY0rE9ERDaLMmKK+YVjhFe+pcwT3FMvXJVVfcPqJVYTiHgQ0sse6YJ3Nk+XwGF6Hl1ET73xZYdCz+ZAmc0nGJJ0LXXECtKy+eZTCICc/AEMQN/5MY6p+26gpFFclcShU97qP29jybbBaW3uAlrk9THoif7eRQd+6HrqV2NBmnpmDJew+xmvPl/tqAhnWqYOus/wToD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNoVkPZsencIeG/dxRIbqL+XiLs4G8X9a3QXQksBHZc=;
 b=d7YDgHNL7kOcmQMNj4TArptXBvXCg3luRN1vvcETMLOUj58JzPEcflYDEEynDXR5C0ggsPVwOMY6FaU44CopGmqxhc29TFSimebv3Qh7YEhaNz5lnYsNnLC/fyudI8VZpD6a3ICt7PHL8jlG0rljBVHSXgJWI/viShvTKl4gvLPJnik7CTk21guJTWdurHwiChzk2mxXaV3VPnn7SmvKr+weYPjBtFtLZ2oelrSVP4RzWupC6ZNkj6XY+xVuJmjZRqV6CydOQJynH+fooj2wOWumdEKJbhPzlcWQNOl1JkpKDTtnqjkH8KupG70CFq56f5kLgoh2Hy+PGni7VwGnDQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA4PR12MB205676.namprd12.prod.outlook.com (2603:10b6:207:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:13:33 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:13:33 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Mon, 26 Oct 2026 21:13:25 -0500
Message-ID:
 <SN1PR12MB2528986412BA8C9716B3F87FA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at-0cXiBV0RM-Att@ashevche-desk.local>
References: <at-0cXiBV0RM-Att@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:610:e5::33) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261027021325.144853-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|IA4PR12MB205676:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d8e409-bc19-487a-61d3-08df33cfe6cf
X-MS-Exchange-SLBlob-MailProps:
	CLk2x5OX5VamqICzye+315pYcDqahkiGydp5MQERJoXjSzueZ9tU4x1bsSU2xfWf1mjoyLFBvPT3aUF9nS2L1UdKgjWXI+mMBiuemwseyVqSbJDWHImxDqjqT3UGJk7VYuS4AW5WLINa4uVr2KdL6SgRBQagTLTFJLHqIAlLyyhclaiaBmkmmf+ETXHpBOUZUG451/TEAwY0IqLLZTeLD3Yuf2bdNzX4gItjV9iQMSn3OWtIW/Mhwq3Q/Q+VQ51JY8iv3ptuZwoVwCcy8ohD4jGkAKm/N9iDdRnb2GAS1deQMFmJT7RvRihBQhuBu+KitenvBN67n/ZHF8OkJkUGk7FwSJhkkO4DeIRwcqwqqL6qw9PSx+a/qJVemPLORBsHHjzc5bZFxv4q2+7hveFNsgU90fcnKS3czV4tj9TEfdnWwmR4OIzsxc6aDCyvxYyguVxeusOxZJ9eInzvS0ixLftUiiztPVCMQk2HDq7gep465Sl62J12PPyRM515ve+YINKJgWlCjLzVVep1GUTyycqoshcZcC8sOKGF+QqRPJVfNuSwHGOSsXmbbcQMn+z17yVcqe4oiAYFuF222AZ+XEusouGtzkihq6OXsd4JNCcaH4ShxWzIlWkL4H73dQ/sjTGV+An8HOwx5kvbxSsTav784+4yKKo9I+a2vC+iOF/OHNu/ALTKSsDtz8LssvA1flfhIqEgMP5gtgqQwFrlzg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|24021099003|15080799012|20031999006|23021999003|22091999003|24071999003|24121999003|39105399006|41001999006|12121999013|8060799015|19110799012|260925184616899003|25010399006|4140399003|3412199025|440099028|261007181701699018|26121999007|11120399003|261005200801699003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1GXqX208hdi0bwOP6RQpQrqtlJft/mcmRhifeHtuSu/FKYrOBYRImpq8Ssnw?=
 =?us-ascii?Q?e5a37MyEMucwYytE4ilB/PYxOBsijuZdXLwuSJX2KxHvAe7wwful7X72Osjq?=
 =?us-ascii?Q?CQw/XCWIBsY1adgVZFVdIwYI2FKb6hwasCe+LfLgK+UuSBK6yIPrQsb25b5B?=
 =?us-ascii?Q?zghXsqWprfCKYoX3qf+3OAxFlP6c79KQSB5sF2D8U1uH3/40ixapQrL+lQPW?=
 =?us-ascii?Q?yiTuQkVvkfltdt97CVeBqYApqm0GbX82oG8zXDe+2vFrgbO4fbeYk5/n0g7a?=
 =?us-ascii?Q?BijY/+eqrV7+OT7XeqN6zXwESQ7f+OAhBZQkJ6PCcaj//ukZlO/invX24SOr?=
 =?us-ascii?Q?38uwZFKmPeZ5YgX+uN2Jf0Ca++JiGAUAqir5VYSoMdpBSqvEU9ldmx2gS0r9?=
 =?us-ascii?Q?aJEXZXTGDhp5HVaV+Vd9pMtq8ubKPFT5f/qG3FquWoILEE9B37aPl7cmAGTj?=
 =?us-ascii?Q?rFkddPTpHJ49panH4Mp1eUPU9T7HytC6VG0BlszwCsDONKE/zGiO6OYyszLk?=
 =?us-ascii?Q?pfJ7rUswkSMRHE9s/yNCa6UY2FdnAJZBNfY3vMoJC7XD/fLjufJjpJz8NKtL?=
 =?us-ascii?Q?olS5TjGuk8rXOEbRBcud6NgD9nWS9QCKNAgll8w5JAMWJOdNWI9i0lUQsX01?=
 =?us-ascii?Q?VFGah5BSPtgUKV31/HLEuWkh5aSJsRUKVadhq+WUapq9M3etBmz7E6aMaETP?=
 =?us-ascii?Q?Ns+03vDcH7iggVNL0yFmgU04GYlGFHU1Sk/0B3selnpbacwmelgnKi3vLrQc?=
 =?us-ascii?Q?kp1tGalYhuKTciQMwv/4NoXzdV6x3bSbZDhpBwvWkTsFe3N0x6YKKSqLG5QD?=
 =?us-ascii?Q?CZwsxdbWA1wVCAM1bOYOVpDhsme5N9FfE3kG3ir4v+o4UwYY9uv9Srf5WWF/?=
 =?us-ascii?Q?EEtAs6Q/Vo2tqm2iF2yH6VOqSTbpfuZ6mc+aGDslzpMRgp07hS2ZPoveAQ3I?=
 =?us-ascii?Q?sZBq41es5G95HSLW/77ErRXN0eal1Y1cvwUw/b4JOk5jJJ3uFKRPO5B+cloy?=
 =?us-ascii?Q?9cI3rkbG45P2WfveUnVZ+tQG2hu0fEX9MD4GavIq7vsyd8DIbtuwsqQ5VOye?=
 =?us-ascii?Q?Dg6lHTC3FmT1SBgD5bMEYbFY/9R5rmA+UmiK3Ock+oLxWD3/8VriS38KAhB+?=
 =?us-ascii?Q?RYrT9mJCPnryqyyI9BPpr1xKnk5X7zv3VvFn7DoyKybYX0KpxvGRUBe0MmZ+?=
 =?us-ascii?Q?xPEAIturxLBZesw/XscJSzwpujrwumljL7QeGBK6kCag1mItpJlk9Rr9PH0?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wvCZEClimSwTh30Ty4/VfSbbR9haP3yhzF6GwuqoS6QS1a6XLrAAjHvkuvX0?=
 =?us-ascii?Q?97npppP2tua/eY2XwGR1eLW44DZIh4988FcQcgpyMs4q7pfiXLXGLDaCOlGl?=
 =?us-ascii?Q?cfL+b5kISOMG5CLaBhr8FX3LW6cZHJLnm2tlnCBLe8RtV/xQYl1eWHckXj0P?=
 =?us-ascii?Q?uVWz4qHTS4pSYOGdOAlRdV3dhbzvJoRKrbXRv6GxQociRr3WAnKtxUJCKzeI?=
 =?us-ascii?Q?PZV9s0Cqp1GnWOk931qH34957NgbZKQqNWdMorarEN8XbPgO/5BoLN+0+0lI?=
 =?us-ascii?Q?do0J222veT+eNlsRGwdL57RMVNZjjCN1zd3mARpmznc6SD/ii/DfgVp4WzhN?=
 =?us-ascii?Q?OnPk106qmtz63ir9TVESus7kknESMh0Ybs1Hi3s2HWRlLvKavt4V5vazcASO?=
 =?us-ascii?Q?VHJTwJ1eXUvlGmyUy9FjRGX3WTLE/RiXiwbq50Cb4ArhJGeYqfYQsh7XN7/c?=
 =?us-ascii?Q?9l/TdnxGf+EtJ1S4bn3/nSYPNhgaCR4YXXqSNW1m7Im6dU/oqThLYJdoF0Xe?=
 =?us-ascii?Q?KSRveO2MdzrYje/LpIhCUBIuJOeR4pu6VwESIahDWVatwt/N/jGWfhO69Yj3?=
 =?us-ascii?Q?98abRU1vCHOglz3EFHQPTaji91f4Lc4F2bnWJudRIjhxutsFR7mF7kMgKMBE?=
 =?us-ascii?Q?E8wY8B1Pbe26APDfjPGfiAWF08QlopL/otGCjD4h/bIYCROoDtFyeVLBwUyi?=
 =?us-ascii?Q?z5EEpyYQj+CgOBmM0EWNPLU6UuOQMEeWeBzp4JyBRyGL4DvppW2cumAa+En9?=
 =?us-ascii?Q?D5l/hcm6gi4Ag1hAWZv/eXuKoalHY5KMgo4T2LbXUPTv/91Fvf8Uanr4fetY?=
 =?us-ascii?Q?HF0X+JpRC5SK08ebcRHPbNj/W1Bxrb+HR354TxWsRnEwibjPzl3QW4CuYjVp?=
 =?us-ascii?Q?CrzsAnO3tmkHeyU7Bx17IuoM3aYX47QoQIzeUFmDaLIiEO9ruECM+d5Bcn0W?=
 =?us-ascii?Q?Q2+g0AtcGso6dkkouzrxn61lKWvLkhMM/0TMWMN9V4II+sxWuPXxk3N5HwjG?=
 =?us-ascii?Q?SPFU9SD1mI86chkU1ND0+FMQNXNwTTMu5NPmAFVCfYKb/xzCd5oo7Qnrj9nk?=
 =?us-ascii?Q?xpWzNHuwsxAB3IITnLkZpZEh3VbccZnRM0S6QLMiTkpbeY2EQTuPjBWdx/AN?=
 =?us-ascii?Q?9tngxKhz8XGWPnr6TQcROMqP0nZPCNs0Jx7Rqy5roj0b9UEIeBNc8vEvzfu7?=
 =?us-ascii?Q?9NlIWoJkQur3wcbKcWItQ24HUbMT48+1MCGXk3Pn4tNnK1IdKMo93Iht8Nfo?=
 =?us-ascii?Q?ZPkI2UeK/WBVMNk7qN98PfOHagxHQ/O6HrvTJeNB0IR1Aeq6tfGjDs1NET+I?=
 =?us-ascii?Q?bW2j8jEqffJILmVeKc0DA4qR7n28+WG5z101mZmIj59MVHEr0KEpNmQd0w3x?=
 =?us-ascii?Q?CHwH/vm1ni1Q69vZ0tVemLyaK0jFgaE2Bh633dC+hTs5aM5Scw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d8e409-bc19-487a-61d3-08df33cfe6cf
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:13:33.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB205676

> > +		/*
> > +		 * Now read the two registers making up the measurement.
> > +		 * The datasheet says to read MSB first, LSB second.
> > +		 */
> > +		ret = regmap_bulk_read(map, FDC1004_REG_MEASn_MSB(0),
> > +				       reg_vals, ARRAY_SIZE(reg_vals));
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);
> 
> We still have two shift operators, so it might be not a bad idea after all to
> have a combined variable with wordswap done in case of LITTLE_ENDIAN
> architecture. Jonathan, what do you think about this? Reading the whole set as
> 32-bit value and convert it if required
> 
> 		// also note in this case we don't need to have _MSB in the name
> 		ret = regmap_bulk_read(map, FDC1004_REG_MEASn(0), reg_val, sizeof(reg_val));

I agree we could drop the _MSB if this was the only use
of FDC1004_REG_MEASn_MSB, but we use both _MSB and _LSB macros in the
volatile register table definition, and it would be weird to have one
macro with _LSB but the other without _MSB.

> 		if (ret)
> 			return ret;
> 
> #ifdef __LITTLE_ENDIAN
> 		reg_val = swahw32(reg_val);
> #endif
> 
> 		*val = sign_extend32(reg_val >> 8, 23);
> 
> 		// I assume the following is also possible in this case
> 		// *val = (int)reg_val >> 8;
> 		// but usually we use sign_extend32() in IIO even when simple
> 		// casting is okay
>
> This also reduces stack usage.

AFAIK a good optimizer should be able to see that reg_val and reg_vals are
never live at the same time and reuse the same stack slot for both (whether
GCC or Clang actually do that for this function, I can't be bothered to check).

If you and Jonathan prefer that version for other reasons though, I can
switch to it.

> > +static const int fdc1004_calibbias_decomposed[] = {
> > +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> > +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> > +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> > +};
> > +
> > +static const int fdc1004_calibscale_decomposed[] = {
> > +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> > +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> > +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> > +};
> 
> We still haven't decided on this one. I think the 2D array is better for these.
> And with the above we effectively have a duplication of the tables.

I don't like the duplication either, but I think the real problem here is
that read_avail is just a somewhat awkward interface that doesn't allow me
to return s64 values directly. To me, having this separate decomposed table
just for read_avail and otherwise working with s64 values is the least bad
approach.

