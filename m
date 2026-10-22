Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792684574;
	b=hO0XVyOOjWT1v2Q3UEdpaogRUOW6bPQPEot86r90nZix606crYm1nCyJ5UyRKrK7kwQ5
	 ry+kv/LXhSTJlENE7CiRR1XieBChPGG5qXJ7FxUZYC4NVumTXnFwL9Bzym2WgEMtTcRAI
	 qBPYuBQd/NGIUictIc32fxN0l8ePLxOeqHrks0Em5qeA1JwB7md5esScP7va2zouRXK1f
	 gtU8e5gVDIfhthuBAHAvh8K5XGBBXkB1pKmLMPzBMpIwiLGOL7YGIgfVh/axrhZ+f3BL4
	 taEO6gIOZWqz+Mg5iVXwIId8FHEa/4o8KrhupU2OZHPGcC+NLAgboV5ERdfbvgHJz8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684574;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9irhYSs7tYnwBabFDIG38h/JX5qepDmLAZu/Ak3BZ9g=;
	b=dTPbU982c8pGXX4fOvIFpgEtANeRxz5H9Bj2NIMmTjFu5D+Rab8CtQt9/KVGNL+s5IQp
	 VnIeN7+2JlunPInvU7Fd4qFd2H1Apjw3tVmxl2X87kngPs799ibpaGyt2EwlNgGF/yNTS
	 Q7yDUAVFxbwY3wu8YNh8ZF9Tr1bPU7L6+8QzXiiG1Kj4nzZQbnFTYCiqGTL/bUmcoZDxE
	 q4yCvkuDqNKyqV/IVyJbcwBIphUvN8p1IRl8cnrlQHyU87C3h3Wjrz3bT/kwYFX43/r9H
	 YFmqet+yRa2c5d6EMNUkBp+U5eeT6pfMz8bUTvXbx/PJSV9Ose7QIDsEW+4L+CK/X3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="XgoFSB/I";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.46
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F0606A319;
	Thu, 22 Oct 2026 15:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B55F0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XgoFSB/I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeCLvgyEc8WJojoCssFm/TIW/bWa/N+Vt5DnU6wps8D3M6bxQP3A1Cu3xvRyR17FOX4vpEQytf96mz7Yiuk3aOZKalbTWbDxdBuALKByUM34NSJlokwTnJUbEHAq3dTXsg4/td40zqyU/DoCgwQKiz+iTORsdCy2urYmFGRvQw/PjK5jAo/3i9ZtyZaJ3/+hsLq9ds57On16xSd1o89IUGkInslc3oYrUD/oC2mtiPWJkEhMd+Qnhix0YFhTFCbBCaIzkIvx2JuQhFsllfO6RgXVJecbanybwsf8f0bmtzj7zjE8v4H4amFT+rl12y/pM6uF6NNaZhYnkwsy5eWv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9irhYSs7tYnwBabFDIG38h/JX5qepDmLAZu/Ak3BZ9g=;
 b=lZ4/lwNw1NjJ3e7zThLwvixWTfM81oURbj4yvXdwligDY3JBB3ym3xbBmxQxK+j+F5JVMwsLrVn3gHAmHRPz/mgWK0k+GPezIimfvJZUG0oNf+Ttmi14i5hcQr5v16vk8iqE7C9oTr49iMupSOLFZC2iUQLn/kTpZ5j4w8+jC9IXDPtrML8HcdmbAKXlH3exCjiIcNCj4mb40mSdDJZxPfPRoyny2fBnpfXxTyw5+UObOuuo2GTVHaptPTJG5UeDCXszz0EeNjKlmuSxbsRr+oFxCBpAgMB/WnU2ca8m7RKCsTca1WBgwkGorbiprsjek3XvQSuxN6b3Jnyd4p2EMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9irhYSs7tYnwBabFDIG38h/JX5qepDmLAZu/Ak3BZ9g=;
 b=XgoFSB/IZk6WcvRYlAK29U7UBCeORvuRDePZmfQckjchp57he44fChywRLl0nbETFSWL/E+1+7RL5Y1jBsuKL2BUv1smYFuYpEjCE/CNVGAYGlAI7/9B/UnUTSluBK9SZc2HALUlVd3z4CnKek+w5mWi/sG2nGf25fJ+EkNPJotLG9cwHBaDyeHd+U7P1QMFJp13/6uY3t9v4Y9U8D/LAKrFAxm86cVbyd+g5u0b37QCtpohE0C/QQv/TRbQhVTBfUA5BPdJ2AjV9vf8WBnSkTnWYVzgRhJrvX/JqEaG8miTG/c/Cu16uY9b5MECn78ZbDoX0bwhiqN815M3QLqR4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:56:10 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 15:56:10 +0000
Date: Thu, 22 Oct 2026 10:55:59 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: check the return value of the
Message-ID: <atoyD5GpW-4uWKjq@SMW015318>
References: <20261021225450.628499-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021225450.628499-1-kapoorarnav43@gmail.com>
X-ClientProxiedBy: PH8PR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 2085cf5e-b34f-4e09-709a-08df3054fdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|19092799006|366016|261021121427099003|56012099006|261009223027099003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	W4W5Hn9lfPockmGEjYxdFYgmxDTIG97zJbiHGa7hRcgm2GexqpZ5mEhTZOwK2N1XttpZXCSoJCEWqDIuc/OFI4kWrqsV2LvYn2Vn/Oucesh/y65DtaTjpGN1pOxEx103jkzFwkrFFFc/BFL+lAy7PYSP20Ym0bDtqbnXuWMQyu2TetmfyNgRCaCgwXysn4kanGjquRUGWZKCPZO0rEz47CVCiZ5ycisfO0R/8SyLY+0iHM/gC4YLm44PVb8xHmOw2K6GLhAJwq6eDPlN6lZRnml/YeUoGgVeuIchk7Xv34hvsyrYmJ16vYEIvx9T7mrC4HzFMjbyjgEk4EEgT12Zu2XIn0RbFh5V9zOJLUGgCUWfLJ8eOk+DutpnLQ5RSju5sasQtW5Mz1sVEpr3qw3t6rdoJaJyjBrJmj8RE9tGVJ3/dDliSoMmuVLziF2E0d2YN0Ite29F3vf61oe2qhz0VURMqNNG+CXTuKJg13Wvt9ogiLx23BMk1b3JBsNQJfzf4ilZXf6EUupJo8AFc8mqMqyME+qmGEkX7/AgE6ceTgwKvhB/BULBBvbB8QxHsRmKw/h7Co+P6MwfbDuF0LUYPvRd13JYM6XMDzcqhJ9A/9gbF2Rtxqe9B/yRTGwXV7Bz1CYRcQwI9aMEFuA3o/kcETYmK71V3ZEA10qpOdP+qb8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(19092799006)(366016)(261021121427099003)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jmjS5MRoCSaO3uEW4GVOkWI0EgHcx9TizGUOIMQ8tb9PpnYChGLg7ocvdJ8I?=
 =?us-ascii?Q?y9NO8SUYEZeWARIhylkHCsaq4ntgmz9Cr3+irHp3JRDNir7yu9pDMJQKWFak?=
 =?us-ascii?Q?w20mxJKrw/e2bBabdxA2ps4D0GwGeiavXBh1MTVs2OCaPtnFiWjFzaEsucoA?=
 =?us-ascii?Q?TUvYJkClxRRIOzJA7TBu6rm1Qg4NU/cN9WrMVfVprntysgj5UJFR1bKlpTBO?=
 =?us-ascii?Q?Np4quAO0npvMKsBsZUACxDQhYL/A1f43tWIpWFwh9Ce3uPZBHSubpMPSOZrO?=
 =?us-ascii?Q?7YpdaAorlk+51DrKeJZGxwJwQ6SysWUABc7O9dUNdIU2itl2zLDXxlFTfZ/5?=
 =?us-ascii?Q?RhOrBVErM3VXXK4F6INWuFfwyoguAcH+FX+2On/FpRw/qgXT6ikAnTcT7KzV?=
 =?us-ascii?Q?74URAucPnjvEQJUWAavomujApX+PWdfYzjEURqYV94Hu7nzraUAImnEJaZD9?=
 =?us-ascii?Q?R27c1RHWEbfnDG1OOwZn1fh08M+GKq5bEA1C3m+fWMVfDFlZAIS5kcdJIHWz?=
 =?us-ascii?Q?4ULvHK6LObZtoCd7N5Jxpf94Cx3RHxFF3xHrn2Z6QPFvOl8ngK9s7aWgyoEu?=
 =?us-ascii?Q?kc+ffY2l2v0DktrvOl7TktQm01TGelYEzjCOw7I1vYhVX/amghrX7k3yqOHy?=
 =?us-ascii?Q?SNrb26FNRcfcgBMRHvtYTALYcEOf/V3Ky57uz3amDc2Ay9gWYth/1WvV/3Zq?=
 =?us-ascii?Q?9Xe+/sX//H8QgLaYkAIgPtgCZYCKLEyfy/zRASVJPBk13oBXQTJxxQR5EyV6?=
 =?us-ascii?Q?FzGn416lYukQCr2W1gT+gfpRGv6iDe1cwrh8qis9jgmb9Ajl3jYSUoMJTfiy?=
 =?us-ascii?Q?ynF0PFlXSv43il2HRbP7e/GRa1O5lGdW5m+Ig+5N1YudbVt4MPWWSb1wxSHO?=
 =?us-ascii?Q?8CVKp55SKXaNNzknDLpUoSvQJyGYqcgf2AYv7qt3sEzEFFYORbzUfPZSczo7?=
 =?us-ascii?Q?UO4+O86jObpb+qOGUd7Yp7+ve7M3+T9vj7Mk/O30iipL7T+QD8JgSyr0OlyT?=
 =?us-ascii?Q?0RWRt4sfQGPGNrt5QY3qOptENec10OVDf/Wto3zZwgN+3LOXkWVQWmifln67?=
 =?us-ascii?Q?71DDFxNGmnaXAJ53nEK22XFXcU+cHH+a89mRVvFBaO6O7atntYt0q1SlRx96?=
 =?us-ascii?Q?Z2eZyO1hWzNMhnXnG0/QpJWgsqw5owZ4Npwy8bFMYkCVyiT0hqwov2aM/0a4?=
 =?us-ascii?Q?R/fUOXJJCI7OkwJlpkxmWspceJGkwtvZiVxB/w3Z4lyN6VmAobQlP+eIT3wB?=
 =?us-ascii?Q?704k/XcKbAWojJ0XUE+/k9zTKe2HwI6kspefZySPhX/VDArNCt336xsGGGt2?=
 =?us-ascii?Q?AldW80q4zqOHwtIAJEzmJ7LET6CqHG+L1pODku8+T0Tmt03KL9vWUtvNqpBW?=
 =?us-ascii?Q?BvxFsx8FK1+3/74k6T438SSHxRSOZXOctCy/lX9dHheu0Bc8ACGl7UzCqap/?=
 =?us-ascii?Q?pgvBcxj8COimNYeB0/HtOyU2ohHBTmi+iCqaI891vBpX+ZUz3MTAu2sKLyDN?=
 =?us-ascii?Q?HBP1JVNHJlDQtyVIGNdRItQi1WkxC1GAwxcBYoaAf0QJteyaEqf3gQU7fV1g?=
 =?us-ascii?Q?WmYzDWEZ+Tjkm/gim3ThL+BLUltok/HAjluzcogJ4wx7OOeX5BYgu23X0Kr+?=
 =?us-ascii?Q?GAYvCCmHiiUkewJagvVmvxtLi8ZyVZw3c7/oTnFq54LCi/MZ1oj2F7w0YMLd?=
 =?us-ascii?Q?e6lgu88vcd0sKOegfbgrnXl0fsLB9jPfM5yTso9rR+5Hqa4hJdEJ1GYSsDBE?=
 =?us-ascii?Q?kTuXQeREtVP5wcULdBlo1HmFNVTvr/TC/1hkqvXyJVmFSI5898eM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2085cf5e-b34f-4e09-709a-08df3054fdce
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:56:10.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HA3vRY+ztQcJiLS7cDLlgLpaTOd9HwzSWotS+ZRhlQWJKH1PVIu0+1bFYn7vyKdfWOhJYcJrcw+HlXRlp050gr+ah3WELrgV5jl+d0UyQoEEawv5IknLKuEXe4kn854k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061

On Thu, Oct 22, 2026 at 04:24:45AM +0530, Arnav Kapoor wrote:
> [You don't often get email from kapoorarnav43@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The driver ignores the return value of all the regmap accesses. If one
> of them fails, e.g. because the memory mapped registers can't be
> accessed, the driver just continues with an undefined state.

MMIO never return failure. if write register fail at irq, it will cause
irq storm.

Frank
