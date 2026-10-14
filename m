Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF45452B3;
	Wed, 14 Oct 2026 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987595; cv=fail; b=IblFtoDre/l82D7Ew4YPjgM830NzlHAg26J5aBSbo9fJAUPcIT7ELxrYw7eFZv8C1SwLoslFDqVhHdIpkS2BgwowmHAaOkuE4MxxP8bdmz+f3RUoS1LDw9vXyvp537Gl8mrvDrxpFQTMWiApHZOJkQ00RAhZFvUzz4O4vfmHFKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987595; c=relaxed/simple;
	bh=r79UlESOjVE1LfAC4DHPkWolGc3uVaPOz4o3MdPT2Iw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DKOPR3gLjiG5mecjm12/D0eNZESJ13YSDSfGgQaTpp3wbwTXsePdAmAS//q9kEFlVw8FTvyC1vRjdUBxer7q4yT5BPBqbgjyzPKQzYv7jTvOhDFojr01cO2lwssRTVOB3kQSNQSunbeZ4xyMh5N3xi5IrD+yed6z9f+uNNAA04g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=GzXto5p6; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pIgKLMl2; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="GzXto5p6";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pIgKLMl2"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ED6Yb13826800;
	Wed, 14 Oct 2026 10:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=j37ZzyLbPwnayVJ+0FDwohLl4xSF/kBLFForAgI6Qpk=; b=GzXto5p
	6S5MNTuc08f4dhZfpsmssVw2FXr1XRdG+DpB6kW+rQgz0d0j9Rh3ubCjjtrHsxYp
	jUhCFqAE7fE8kxlWipCyJPwarf6CFLzn0xAUDliEgEwbAc7IlHb5uyE86AuMV8oM
	92hr66oBIB68aTzwXc2I9uyQE9uEbLnfiWVKt6sZl6/MC3TH5d6qf0K4T5J4ZKT6
	IW80EQm7PJPhnZiAdhmThjf3TzCDGL5IcLo9rxGyk3hpfC8Ju1U5e+e4oEQaMZYL
	vIAS4tSQ1MjFnqdNDRXuZEZPnahVMJvjXxe6XeVfbBy1QM77TTntLDNL1EduF7bT
	YmLe7+FseUD31lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j37Zz
	yLbPwnayVJ+0FDwohLl4xSF/kBLFForAgI6Qpk=; b=pIgKLMl2w01tIki20tbES
	3MdjuFH4oBRlsROXSwsxiweRKQn4YtaUDNKIBYppvAIiC2KZeD75R2dxacyuTO65
	BIOIE+TqlynYpVolDcRQKvyW2i9pruTO7m5owyZqjAeI8G7oj7XZNruS61mo1luZ
	Gm8EjVVkMihL6RDL+v8H8Ccskzv32Q9I7Zz2anxXVbHOTwSBJjpxmJbWPgCNNpZ/
	x6YyylCO2qk1MrLZku75AzwzrtyHum+S9H6R4XruSuZrJwL973VFpVmXbWnEYtmE
	pbuJAll7rTmihb6ecOyBA3jaOp0yJCpqOLLz8j/QY4mvJwtp737SVoumOillQxQG
	Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haab60gnp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:18:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGP3mCayjzSWd/vlvbBObrEL4Q3Z9zIvH0xuQ+GgCxGrQQDfsaAOyLrWD62hGsCTf8/U+PtHi1tnj8yjqEF4Ls30DTCowHPUveSXQ1qONIjqkI8IhsUjUnmCllFaIXspl8t6ltMFYt2MlHfepuK7RXdFo4IVoiQJDqRo+1SHJ61l28ETJvcYX44r2zXeHYTEv4X8wq8dP7cDgm4vwYFF2rEPdhEoc5Lkat3R0CdEfnUMoarFnx/lCFB9ED3SDZ7KWXFoIRPQbsGdIEGwUUGLKi1CVPAdLFaJr2O5wHzR4XuX2dCY6SYmgFjacgntZ2Y+ag9nrIX4ypPd4ymrzLyxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j37ZzyLbPwnayVJ+0FDwohLl4xSF/kBLFForAgI6Qpk=;
 b=SB9DW2i/H3K219XuBCmz/3kmDxCsnr+kCGxbzaPOOXYy5YmGEt0mpKR3THfZlxBuLPVAAVhG/jVmGaYkm639vTRZGdblCj4s0246ERj3WlDZ8W2pJNBcan7G0QGBi/qpgYbXXCptLluu1qfY9QABJNUQgsELD3mIC/cqKgvdN9yUg/lbGJUseV/vDw+x8ubWkGZ7ErzgTxRiUiJdafoGLXfwrQ/fq41XkM40yoKniIXxlWD4LRc3CAlaiGoLM3Syenper1T9Ljp/HVM37GJVwD1VpZnSiNCCFq7cIbmTYPik56rZoZZ/WFQW9Q2zXcN8fbgqW93oPIftJskaiEDitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:18:01 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:18:00 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 14 Oct 2026 15:19:12 +0100
Subject: [PATCH v6 2/9] dmaengine: dma-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-2-5b3ffdef8191@analog.com>
References: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
In-Reply-To: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=1850;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=r79UlESOjVE1LfAC4DHPkWolGc3uVaPOz4o3MdPT2Iw=;
 b=xf0/Xi7Tq+wLb+ZA4Ic9CIdMgoiFPPfIDcVmArsD5Lh8X2EwnQTxRjl5P6jle6MJ/vxUUIYEb
 GWv6zPfDOHsDHr2BN6HGXsFV6MKGPfx36N6f39/BqsmLwdcqejLs0j/
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0178.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::22) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4091c9-bea3-455b-7024-08df29fdf415
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 A7bq2gfEpFYa3aNkbIUe2XW8VOcbftdoNko5pQ0cMAuW2/Bw21X6aTy0nGT71tavVZRbByj1RCKkjj8PRDUxYN6prFAUko1W+R9ralXP06cbiAZW7/BgGJzUaF3Rgw2hWXDeyjcQr9yqGJgTRgQ+RjltvbLlcj4XxYAqXCJv25PKUyjtjwi9L+RmKID6UjNnXPvfMqokY19RBv2/K47TA5UzJ1ku0e1fNBHFUTKqpuQDPAvdradQDMTIVWZULOPSfIZSsFFoUz9cBD5nD371dhbpKCAPkrhNpcYoQZ6sdpVU0TWarG/vwEd2Q6Q1ZBg0Gk+jnsUfEtwdtOjeshTB8FxUT3tHVMAoEp6fFfpZUSYyD8ZG9jP6HJVRutn7OTHbgDI7VeY/4QgwkVkkyTZE1ZRBIz8STGQIclKkhkWaYycVmNYfAUc5JSln3Jss4zZUqvBX+FlzAL+rbLlIzjWADv3IlxTrT6++OyqxiaIhOLF9cLXXXR33WWYUvoijsK3vnG6PtAX5RjcbZSOc8Klg0vKzhyw7efT9KtgFyBZHP6Lv+WpZa+jAMLDstgQMaQZ190NQftLlsSA/UHR1G4RbvJq21FKauWkwLe2nmq56uSo3AoVje94T9TQKi8uUC3kuFU2xCykj4Gua38BB6gemGEt70a8vFPCpM/MHe+zkJ50=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MTFHQ0lwUG9mWGtjOEJsTDNhK3Ezbit1RkpDUmI1Vjg2Yk9QTzB3TjhLNElR?=
 =?utf-8?B?b2NYdEZWbEV0d3U4cEZtc3FoQ3F4QWNDSml3aTQwOVExbmN3dmU5UjFSRkJY?=
 =?utf-8?B?SEcrc2FrSEMrR2tCYUdRd0NhbzZuTnUyZUowcUVTUk80NWRUSFZDTUVTTHpF?=
 =?utf-8?B?bng1ZWVnS3BtZDRVeHozL0M2U3BnZkVSQmduUU41bVRKWi9INWFDYUw4cmYz?=
 =?utf-8?B?emZMUGVhZGF2ZHlzWW9SVmNibHRZZ3ZMZEVoanA4aWphRVUvUHlOTzNDa01M?=
 =?utf-8?B?dG91UXVrb2ttMDd1OEpXK09USkFVYXpxRmZaV0VGN1JKa0RqRXo4MzMzaDZi?=
 =?utf-8?B?TVVnWHN2RnNtRnlBNGVjNUdaUEM0SENnRndGTWYvbE1zQnJ4UjBXdlJ4ODB5?=
 =?utf-8?B?ZGhpRngvTEsyOWw1Q0FVZzNtU2pRVjJ1L2pyQW5HQ0hzbEdGN1RvTlUrY1dU?=
 =?utf-8?B?SnFFeDltVWFKL2pUQUxZTmRDaEJIbEw1dFBhMG13cytLSllDT0lFVUpsMG9B?=
 =?utf-8?B?YzFRVmJaVXNmSGk4L3U2ZE8rTWErTFF1b3BPdzk1UXJiU1d5SXd2VFFLb0hm?=
 =?utf-8?B?T0s0NENaVmY1VDVWYU13L014NkhKcllLTS8rKytNQUZSeEFaK2dlaE9CTncy?=
 =?utf-8?B?WWlET05RZGZ6SmlSL1VsQTB2TkZZcndOaDZhYXhSZG5KK3FxbXppK2pDa0ZS?=
 =?utf-8?B?d0lkazFWUXN6UjNsM0ZDT2NCTnhuT0FFZHo2a2xmV3JVY1A3UE5kRElxckVI?=
 =?utf-8?B?NWdaSTBTYzBLQ1pqMXJTR1JIdnZQL2tlWm5hTndzNjdUSHV1djRnTUFnNDNK?=
 =?utf-8?B?ZUJlSHBJZmNHaU5wdHJkbThFQ0d2akRtUlFXdWVTV3ZUY1R2UTJDTTFXdElH?=
 =?utf-8?B?Mit6dy9qZmxXSFRhUHBCTzJ6NTZGWGFrZTcyb1J5eGZjTkowTTczemhray8z?=
 =?utf-8?B?Mm5aWU9ZcjlKeGNqR2xxQitIc0Z6ckhVZjhUSGQyaWlZdXZzMlNCbTFkQVdm?=
 =?utf-8?B?Z05JQUpTN3p6aHAyQ2F5UUlSQXpzRUpZUzRZVEw3akF5VDNDUVM3VFc2V2t2?=
 =?utf-8?B?OFROOTZjaU9CUy9FRlZCNEJnVGxFYnR2Q1BxSGNWekduYU1nZkFUeUhLUTZX?=
 =?utf-8?B?SmZyY2RIRlhaejJEdytCQStHQThkZnFqdDUyYkRNS0orRkZ2MzNyUHRVai9L?=
 =?utf-8?B?aithaHFhanc4RkI2ZjhDdkVia2cwdjg5QURIYmNndXFObFFlYnhQdG9Da0Nt?=
 =?utf-8?B?eEI5QjNyQW4vc3NvZ2hFUTVBV2xEMGlpWGxtck94d2pCWG5aWTR2NVhzU0ZU?=
 =?utf-8?B?WlJpS3B1a1p6OVlFWTJGOWl6akJYempJSG1tS3pDZlhHZmIwYTl2TUJtOWc2?=
 =?utf-8?B?czlNdFVLeG5wMHJ1bU9hbUgxUnQ1OWlnWDl4R3R3SEVDYldUNkpCSDRWK3ow?=
 =?utf-8?B?RUM4NlBQanQ1TS9Xd0dNQ2U0VmZDOWFsSkFyYTZYb2hrbU5vdWFoSWJFTTJX?=
 =?utf-8?B?UGNZL2pnNWo3NjAwSFU5WDBzdWdYbTdtU3daRTJMNzhoeEVnL2E4N1Q2d1pp?=
 =?utf-8?B?QkI0cEp5ejFyT1FWYlFyV2NaeGxmYytQRm5kNysySDZCdUJXRWtFMDg2c0cz?=
 =?utf-8?B?TlRGVnJqaitDUWxVOXVLeCt6MVkzMWZndkJtQUxoSkdPSmxvdGkxaTVWaVhl?=
 =?utf-8?B?WXd4eEVjb3BXNFcvZVJNaTBOU0dRN3FhMm5aVHlLenY5RWZEZkdBZitqWENV?=
 =?utf-8?B?YUJrREhnTStKMGY5NWh4dmlTZnovamU4cnB4UVhHbThubnJ3ZjZJQklYQWUy?=
 =?utf-8?B?VFZWR2lMQUhkNVhObldKL1hGZmJuQlZUYTBuZ25vd2ZaR2JyNUlVN2lpeGk1?=
 =?utf-8?B?Q1hQWVNUclpueGNialRuSy9SRmFjc1pPZGhacm5od1ZlQVhGeXE0bmE2ODV1?=
 =?utf-8?B?U3dURWhia1ExS3lRcExDRXM5aWowNDNHb0ZFcVFwL0FQYU83THY2YldpNytR?=
 =?utf-8?B?MDFzd0Jmbm5zZ2t5dURHeUVLdEFyeVVFWnZ3SkQ1Y3BNRE5DR1BOWjBwM1g5?=
 =?utf-8?B?aXdMYlowZEY0OEFiN1JrSnZKWmo1QzlpOFl1WHBjQlRYR3dvcEdCckp6cng4?=
 =?utf-8?B?UzRNNFYxRUNwaE9ab0pQU1dUY0NhVHJFRTFTbVBBVmljZDlIQmU5L1NVMVFE?=
 =?utf-8?B?M1NtaDlIZnl1UzRGR0VrajhMcHltZWFjZllvMndsOXNmcCt5L3BSdmJIb2Rk?=
 =?utf-8?B?R250cXZNeGtCTDdSai8xU1JTckY1clkwRER5TWwweElraGphbDNTa256ZmJJ?=
 =?utf-8?B?R0JvVXB1Ujd0dlNMK1B4MnFyY3FIRHhadTZhUjAwMnBNZVZaeStydz09?=
X-Exchange-RoutingPolicyChecked:
	rL5W9ZOzVDOtkVgiQfn82vQczUhLaedpRq//hH+pSXfvuj9aWcrZr53bFRjBP/2mhMrlR1IFoOBrRUmLjMmxozEqfQKNC21Dm6cEkkRVVR/pOd0wReAxfJG3sZkxLkf4P4tRPAP/cCbrUpIYsYKTNVh2r3fmWt1LjrOe8lLgUnboV4LqT2jdnobimOz8XFPFZwcsf3TV2azFa0epYDZRCLqkAmNG6MHtu4pDM+Q/vPxXkUt26gAbhUMG+P0lkl3sYxhyw8J2nOGQTeBQ4yaFljI4x7miJrn5hkXA1pWUu7P/vp3y6rD6fvkHXktAF+x4yzsPaxzSe8zb+vPkGNK4qw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4091c9-bea3-455b-7024-08df29fdf415
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:18:00.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ptFXuuID9bnU2qkLZZirPx+5Nvmz8sRD2gY/IcdbKqIjYekmqjuExH4s38cGSRVMhgSCb3DlffUx09b6fCZ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6acf8f1d cx=c_pps
 a=73h/HchST80NzqUzJRdbyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=VO7gjKh9a35wxgc9tPQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: g5RkU4sB1lUZvrJIKnnRGZaa2LREodeQ
X-Proofpoint-ORIG-GUID: g5RkU4sB1lUZvrJIKnnRGZaa2LREodeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX9au6x1tWPj1L
 04iHa5ssDxLvpPm0EGUtBAMNDNK6NTfQGZa2CZWoKFMOhy31fE0LFg1M+tUrXZrwnUQoWOzC8/I
 jN101gyQH4wzYZPCRfs+6Q0QM+jcDRUO1/cE9QHT0P85Cq1z8Y0kBzWIBt2SANU5o4UmxMjfh2+
 g0Nfr5XCbhLOrtL0OtP+Pzxwd618nm8USiIXatDP4W33FM42JoJ0S0MBK1ZECKRTMbHRPJHhGve
 XnHEy1t1XJVWvRnBxLAqOxeAOUfPbEJ1AhUgYJkiRXN/L2KwqZbtpa1zIN1Ga8+kNq8l0gI0hKP
 7uS6/h5esqYXPpFyHSdJm6dM+bHqT54Rhy9O9zYGI19S3+lgI+HbmTeJQ3ns8KPsFOUnbyIK3Rk
 r+FuiWR4rvrjUr9fqFhCj7yJk2Tn2Ln/7NPcSbKnR6Huub0sHH+cyvL3D9xVz8q5oa5X/oyxhdv
 B2JT4eOKBL8aBRaFp5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfXzOwHkAJO6PHM
 B7bsPPEfB98vRt6Z1cvQkP4aQjY6bJ27kBgQXM0Hr4bJZR82BsKiUgtwIyWfqoi1mIYwX0BYagk
 uoTLtRYcM3C+Oi1BRc7v8NP64xtoQumkWve7iO4j2v9j79r761+l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140056

Advertise the source and destination bus widths through the new
dmaengine_bus_width_set() helper instead of open-coding the legacy
BIT() mask. This moves the driver onto the representation that can
express widths of 32 bytes and above while keeping the legacy u32 fields
populated during the transition.

While at it, give the channel width members their proper
enum dma_slave_buswidth type.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d47ff27e1408..ab436e9d6cbc 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -152,8 +152,8 @@ struct axi_dmac_chan {
 	struct list_head active_descs;
 	enum dma_transfer_direction direction;
 
-	unsigned int src_width;
-	unsigned int dest_width;
+	enum dma_slave_buswidth src_width;
+	enum dma_slave_buswidth dest_width;
 	unsigned int src_type;
 	unsigned int dest_type;
 
@@ -1262,8 +1262,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
-	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
-	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	ret = dmaengine_bus_width_set(&dma_dev->src_bus_widths, dmac->chan.src_width);
+	if (ret)
+		return ret;
+
+	ret = dmaengine_bus_width_set(&dma_dev->dst_bus_widths, dmac->chan.dest_width);
+	if (ret)
+		return ret;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */

-- 
2.56.0

