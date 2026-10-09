Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4183939BD;
	Fri,  9 Oct 2026 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561250; cv=fail; b=r7mR0OuE04X7IqmwG5nZ+fV3QoRo8t8/3bLJW0TBjQvurw3aEzy1XOwYeTFg9NRG51mFwGq5Z7Yptf8Qh7VAh/e4cbajr09hspXHHRbtdZuHMv0njw2jt1QeDNuav36AjOXkN4pGjJxUlHtkKrEVLK+SsolPxRKRTf1g6VmhPI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561250; c=relaxed/simple;
	bh=7ycJ6r2G3VIIbbrxEMM+PagZXwqXqVpqj0M6WltyCPA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f/OTXxqa6auV+0zsmqa1U3oQtCLVoQZuAcfe+dgLaBfXpBk8ehdxwQ3aWyKgkreD2LPrY7tCoUTSsm6LdIIWE87QQzCREu7kVIh+FEl5Hoj5t6AA2/ZXBCSISQq4TBmkEgHUexZ1Jmhw9yeaMaEmONQztWvey2pm8tH7fbIXHlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Hz1t6023; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GMUmQ4+/; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Hz1t6023";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GMUmQ4+/"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DfUwc2367337;
	Fri, 9 Oct 2026 11:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=CNtHXeK+vfPA0BneMXmCQokk2yIfZCjhj9G3jLByZuA=; b=Hz1t602
	3oLRfw5nBFPAqBGjfugQL23Hu9T7lgSba6zcGABjwwHuV6Hk90ByK4/dQmguoIcM
	l+RP4gEtvr6Lbk3V1zDXmV1NwVepgp9D3z7WazrGd9A57LWeeDdLzKxzgvv2H+oh
	entxci+H55k6u/qDLMgIpfy+AGacY3oBb40aEjIGXmaDm+fi8noA1XZS+8lcY4UU
	QsjQfiBdrHDaLXaKSblOHBKgPNfNbwgrOBb7g+sghq0g+omWhoMyjsADKcPRZ4Dn
	YICUl0jCufZyxw++jwZBb/Hd0yFNCu3Mj3xYZyzGxMQUboTply+YHcBlBpzOPQ7P
	gwhBzCilk7aptNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CNtHX
	eK+vfPA0BneMXmCQokk2yIfZCjhj9G3jLByZuA=; b=GMUmQ4+/Scnv0iFvBHzjJ
	QmdouhM0YQNuXwI5ycRUp45PdBg7rFiy1/4HN4X9lm5rrxMwi0cSN2I0fklh4rFb
	eR3szctfhjr5YdO0wpo5x22H1zIgW6yCThWFpEHHCbgtUHjueLVZaqnWKKRqO7hn
	zowLfWyzE33nwAx2ky3bYF+HGI1j9CBv4ixkH4JFR5CWDLN0BMvWf9n99QFPvLa3
	+8X0znDaws+B1fW4lr089S4BGBj5lqF9+603gpjjly0GAXO7NucxdbHOPvT9wUm+
	8urwCcALwtzW3yihbTmL/cKBZdCZyv1Pq1sgkARkM6bG0YuceyRQf1LD87Q6IHNy
	A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h71chrp2a-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:52:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNhL/CPkuksXryD7jTqRC4DDE/80QjcSzI1Jkf/4D/tWeUkkKHDzz/Qj31EQXlBFe2NfvUU0fADAuiJjng5gvYW5Ozy6+j4DTnTYfMHLtVgU/iGq/Dxzintg2y9VwyjkXSzpKF7mOKaRP98S5IMih3mF+VSDi1uupjgq6T6oscZKKi9DRapv7PHWwVo8oiFhiJY0iwcyYiCuiHOGwktES5dCAD27/bYUrlm0TQdjVj9BHJDYAa3GexbMugt8Pi5mfL0FQE8LrfNxwjWMuGwCFi2236niHIeYf/4IjuP0TzgvOAQXfKL4IhxeLQbLiYgQXKCr/iQ7TUgzsb91RsjvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNtHXeK+vfPA0BneMXmCQokk2yIfZCjhj9G3jLByZuA=;
 b=fr01UGC283AUeYp+WCXSz1bYG4WIoZa3eJ+maFOyiPanixCOqFfZTPBz2k5VsjS/EDRR41fYZcomepCoWRj++RLI3F3l/+Oq3DEmRdoug9O82kW0B18wmaaSTpFW2k6p18lErV9E6yFMdbc2fSqo3baCh4KRDTL+W8lMidZG3yo1MRcz5EMOEEkWS2KyNAHXR3fNhMYNTac0mHe8de/u1NJ+iyQlCdnaODgOAuNHoDeQtMWBrds1IHIe05yI696uarWj8Ktd3GjIWdRIeMyFaOQugs1MK2Syy7VLN5olZa02k8RrLJhzgvkyMbdt+k1h8LNWckrMujh38GSABygUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5051.namprd03.prod.outlook.com (2603:10b6:5:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:52:01 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:52:01 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:52:59 +0100
Subject: [PATCH v5 7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-7-4c4e63a7a1af@analog.com>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=2723;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7ycJ6r2G3VIIbbrxEMM+PagZXwqXqVpqj0M6WltyCPA=;
 b=lmXZ4h8Ssm16EvggBGuWIvD77ATKDV1dyjg0wqcetrDxRpiGfd15PVGvX/IkbYRYVs62MyUJ7
 sS1c0xIcod/D+0Skzj5Uc3SoEUBnJDLtP4K4uEihOJtZHSKRj+cXzYK
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0010.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1c4819-2b0d-4501-37c4-08df261d4207
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 Y+Bpkjuj29nEQuCtguUY9xKWsRK0KQsJWYQvAr9fO1b+Lf2Jbe2pLy5wJRgDH0cAbJQ41qdq5Km0xS0pKnbWEgZphm+6JMHN0swSyX2pFap39MTuoWNmzsZwS/nUAXZC70PkbMXOk9NW0/JQA4j/AJCVmzbfi1TW96JnJkZzLd1LJIBttYUtgPyuq1phBimhB1aL32wlwZoaejnQEUtoqRprJ01VVjoYlBNUiviG2rw6/MWosKJihngQkpXZVYAg7JUXzz/sz1cNgr9DHDlZVjTAXhZgInqCtwzEmkp+EbBS2cbSDEn/YR/3itW+Nr39Pe0ZWwRit8/YAAW+9zE3GrrSceDG9Tq4DuF6ozaeAsnIl4r68YFZc7AWgcUTd+dxfAB7A8Y7ayJz3K2+89Dmm7qE9dLZn/g05wr7oLBoYfKkN6/F3bbXrAu1McMAL2P962+VyCP+QhLsvNAjvcknA/WUqprjGJNQru914nMtN86EokoCFhrjjtx2cNfUejMtGpvPDRmXWKqpeHDi9s1teUPe7aohxIBehANyzZifRuGQzGiZLoZMg0tfk/XSusQuG4n5YTxFvEStp/x8oSIDJrSWnnoYjBlQkWmJ6IXbtkU+3ln7y9dpCipciUAErgDmmzsT6JAfjTO6khbiSva3lkFFGIfDO5HfY/jyLu6ki9I=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aVRxWEJkVjkxc3lUTnNzVXFwKzdOWXZ1Y0xIOGYyNCtRaDc0SDdyM2NLQkQ3?=
 =?utf-8?B?aG45d3dHUlc1ODdPTGs5K2xkT0VRK0hSb3AzWXllWkpFZkRiZlhqL0c0VU5G?=
 =?utf-8?B?S0NVQ2gwSlpEUExkNk5ZaFU1bXlIUmNrSjh4Y3diUlRTRFhVTkttYnZHVjdk?=
 =?utf-8?B?RDhsYkNuM0FxTS94L1dWdGR6N3Q0OXFEWjNhYnlUUkViRTFjUGRyT2JQbmx1?=
 =?utf-8?B?dHZjNVRETk1RMGt1L2ZYVlVFTXlkaXI2ZnBJYnNjSm5pNnBuN0hIK1pKNFYz?=
 =?utf-8?B?SzIwQ3BHTkV3eU9oSjh1MEVvbTNqOUppSG9sV1BYckI1cHc5R0p1bzkyVXdq?=
 =?utf-8?B?TW9hM3lnVWtqbWV2NmRXVnpyV1V1aThLSjArN1I4OGRiQkhFQmx1eStocDY1?=
 =?utf-8?B?TVdERzNkQjl2ZktMN3VwbFFSaVhiNUZaWUxHRE56aUNMd2ZHRjRPTHpmOWZJ?=
 =?utf-8?B?Vjl1a1JUUVA2ejRHNUpGak9Sb3lDUERMY2JaS3VqRUV0NWQrMXk0bGZRT09H?=
 =?utf-8?B?Smd6a3huSU8zaWY0QnViY1p6NjB1VnpSMkZHcUhzaEtHbDRlOU16U0piY0w1?=
 =?utf-8?B?SWRKaGRHcTFPZGNFZkx5cndYU1ZCeExOSVBYMUZkdE1yMGlNSGNJV2dWcFQv?=
 =?utf-8?B?LzVYRTZGRjc4aEJPTnhqZFlFbXpvMTNyamZQWmdkczFxN0hmd2FsL1FBVnZE?=
 =?utf-8?B?MzhJWVVmT3VTUjh3Z0NabmU3M24vVFVtd0pzcFNTTCtuY29WVi9NSC9za2Y0?=
 =?utf-8?B?NXRESWFhbmgya0VLWWJ5K2tzNHV5WEdJOWJCaU04bHdqM2J3YkZFcDUyUmVs?=
 =?utf-8?B?SlVCQ0NEL0twL2doTG1PcEprS1k1cEFncUJEYWVSbVcySFNURDhld3pXZHpq?=
 =?utf-8?B?c242ckwvUFdSYW81TzRucWhzY0xQV1lyT05wazVRclVVWGkvYjhoeWJFSXNU?=
 =?utf-8?B?QVdkeUlWNkhETk1IV3dHdFFFY1lUVVEzZzM2OXkvV1hEMzFHdlFWb0QxYlRs?=
 =?utf-8?B?bDQvbmxhVDV0RFpXcElJUGdmYWZBVldiOCtVb3ZsUmJMWEFiN2h0NnNvT2g1?=
 =?utf-8?B?YjJlTnF1MUtuV3BFOTVyQ3NuZ0ljTXlpUnhwYWx1SWF2eHBwYXJXVG52SHBI?=
 =?utf-8?B?UGx6TkVodC81bGtjZUdOU29velluMnJpRVdiaEdiR2I3VlJsNllFMHdUdDRQ?=
 =?utf-8?B?WDdRSGM5aXFxOHduNnZqTWVIRnd2YTBqeHJmcUJnOFN1eWtiZHVQNCtnZGtk?=
 =?utf-8?B?cTlSL0QwRlBzTVlZQ2RaL1ZGcldXTW14Z3M0NXByRnZuZmlsQXIrV1VjYjl5?=
 =?utf-8?B?a1ZISVMwVkxVNUh4Zm1wZzBicCtaRHlHNG1qdEdZZlpNTkNMRFBhWHdJdjl3?=
 =?utf-8?B?a2FaK1Z1Qm9UdzFxdnZxb0ZFS2h6NFVSQW9MdU96RnlqclBVYjFsVHhrVWJR?=
 =?utf-8?B?a1lScFZQOW5ET0lLa3ozUmVIYkgxQmhkcTlBdFhCa3dIR2FwTER4WmI4YkVt?=
 =?utf-8?B?d2FMWC8xQ3U5N2w5Skt2RklGS1kzbmxpeUZMSmNGZ0pDalhibEZBMGRSNXpE?=
 =?utf-8?B?UWlrKzhBWFE3UEd6Tk9xTzljR3RYVWJSUjFXcTVSaEI1VDBJVlJTVUEweERt?=
 =?utf-8?B?YXFLQ0lHN3VPY2pCbmUybHVpVlQvRUpQSTcvbDI5LzJhZlJMZEloVzJZb1JR?=
 =?utf-8?B?UWJ0UTNhbWdQRHlkWGZNWkJ2NkRqT3F3bSttTHZSTW0xQzB2cjR1bGl2MVpm?=
 =?utf-8?B?dkNRSUNOT0Fxak11U1F3NWw2bk5TZUVURGM0TXdiRldKdytOK3hUaVpZZVFX?=
 =?utf-8?B?VytCSDlvQlVNNjlMOEhwSzNyZFVvcUNoUmZuK2pjekRmT0FWZXpsYVV4QTVW?=
 =?utf-8?B?TzRXK1pOajFOY01uQlN2TDMvQWdtMzhXU1pVMjBycmZIcDk0Mys1MEVhOXBQ?=
 =?utf-8?B?RUlTdUxnNnBFTzhoRU5VQm5vWGd6amNqY21CdGhhMEtnUEUxZlRsdWZueGN6?=
 =?utf-8?B?eUE2bk5WbCt6NGI4MGVNUDh4SUQ3Q1VCbnRnOEVzOHVLTlppNGk4MW5QRnZs?=
 =?utf-8?B?TE5kM2RNUzY0czJWMlozRDJDa05QVXJqSlIxaEt0K25aWjlvVlV0NVR6TThh?=
 =?utf-8?B?Qkp6NC8wRXNrUFhKUWZIQ2NwcVZFa3M4OXFWTTJmWmJsVUhERFlOUGVXTnIx?=
 =?utf-8?B?UEtoYVdkRXBHT0lsRzhYSmFqOHRUcjdyQm41S2E5MHM3WlBxME9YdERPdXZ2?=
 =?utf-8?B?VGt2YnBkc1BSWU81cTJzS2FwajlUaEF5NUIzbGhKOVd0OE93YjdBZXBESlQ0?=
 =?utf-8?B?U2NtL1A5T1FCRHZVcTQ1WFpTRklXY0p6dEQyaVhJVkcwcTVlRG96UT09?=
X-Exchange-RoutingPolicyChecked:
	rhm6qS6nnZp9EvHcu7WizQPgb7XfOEASmEYzHYNGlP2DX/VaU5yxizULo0oW2X5QfpzSiMcLVY8bPl6NB1BIYboxUFMav2jXfaBzdllEgkw7qUwERp4G0U+fJUy+HtmrovS04S8a75VWI6kj6hJEeGiluwlRV9pxe6UVjJoDVMATJitcGa3Ia80TENW0l0/UKH0l0hRg7ISxEK93joDBkO//QM5hYs7hyTIcDPvAmL4nu3RHsHV+jQ7e0V5pKc115JHpeFHeMz0KnHZYbID9v9YfsD2KbK/J2SbF3TEWWuaw1oadA1+0Cf/n8ahIBWanVW67LTep/L9WAlX4XcWfJw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1c4819-2b0d-4501-37c4-08df261d4207
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:52:01.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsabiA+5tKWvK6HHhyWXvlqGxxLVZA74iZRx8vU7tvCE3Nn/7vOuKtnAXoiIuYfh7xINQfrSZpTmcVh3V/62lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5051
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX9UobPVkJBo2d
 O653PO9QEAlRnJ68J7f1O20HXRWtmrroCs0xUlywzo4Ylr3Ihcxd4warhzX1ZXX61CZar4T2mCb
 yOCXbA+ZYtEFuU+4Zwm0phFQO5X7vPWDxCq9zHLq41CTeIv+zfOT
X-Proofpoint-GUID: QKOafewiPK-oU5SitADYYY0XS18zlCst
X-Authority-Analysis: v=2.4 cv=cpgOAF4i c=1 sm=1 tr=0 ts=6ac90dc4 cx=c_pps
 a=q3M5bEXgJc9IxHNyMLvWsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=RbNyKOt0vjK77hBBhwsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: QKOafewiPK-oU5SitADYYY0XS18zlCst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXx+xfXZs2Wa7J
 TH6tzDips++onXCrKhkbqPnE2UqlsDr0gVtXQuPgDs3mfoHam5RutzIkRNxfnh70Mo6zENk7NzY
 wc4TOmq5UTjkoGxHhETWTmyiKQvA6yBf30mtRiWcvoz7RwuaYkkPveMwsyhiDswyQyirLU+dfkg
 62OYukyo/wLQFxCa+46fIdwCIQeMKOZMJ3DG9DjLSH2vy36+9FevDwQJF7IqVV7p6tmV+G9dq8X
 6PgA5wv8DXRm6Z1UOIRWe3LCj+a9OFjQO6MVN+gGpMOeQeTpcUWxrOVHjTwkwK1bq49Fvv8knzr
 3TGBKRWHihsELsGyPJE1QG88bLZ+8zH9nee8cOhu45CA+HwZ5EjRH7oW/6p2xPOfA44HB5ytsrs
 ZvcEsMJ60lUk2wm0OTMWJj4Fo6ICj2Nsumci7qZRkrkAEsDbCxNb9SaeCwMgZ/yrUr1g8C8Yt+J
 nMBHdL+57Zl9gKIfbDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090063

Use the dma_slave_caps bus width helpers instead of reading the legacy
src_addr_widths and dst_addr_widths masks directly.

Keep the existing default assumption of 1, 2 and 4 byte widths when the
DMA channel does not report slave capabilities.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---

Andy, I decided to not go with the implicit call to bitmap_zero() in
_set() and _set_many(). The reason is that almost all the users are dma
controllers where the bitmap is initialized (given it's part of the
dma_device struct) so it seems unnecessary churn just to make one caller
"happy". These APIs also follow bitmap (set_bit() included) semantics so
it makes sense to me to leave as-is. Added a note on the kernel doc
though.

And it's easier to add the implicit call in the future (if it proves
necessary). Removing it, not so easy...
---
 sound/core/pcm_dmaengine.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 1306b04be171..f7a061f07e95 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -408,16 +408,24 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 	struct snd_pcm_hardware *hw,
 	struct dma_chan *chan)
 {
+	enum dma_slave_buswidth default_widths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
 	struct dma_slave_caps dma_caps;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_buswidth_mask_t bus_widths = {};
 	snd_pcm_format_t i;
 	int ret = 0;
 
 	if (!hw || !chan || !dma_data)
 		return -EINVAL;
 
+	ret = dma_bus_width_set_many(bus_widths, default_widths,
+				     ARRAY_SIZE(default_widths));
+	if (ret)
+		return ret;
+
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
 		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
@@ -426,9 +434,9 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			hw->info |= SNDRV_PCM_INFO_BATCH;
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
+			dma_bus_width_copy(bus_widths, dma_caps.dst_bus_widths);
 		else
-			addr_widths = dma_caps.src_addr_widths;
+			dma_bus_width_copy(bus_widths, dma_caps.src_bus_widths);
 	}
 
 	/*
@@ -460,7 +468,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			case 24:
 			case 32:
 			case 64:
-				if (addr_widths & (1 << (bits / 8)))
+				if (dma_bus_width_test(bus_widths, bits / 8))
 					hw->formats |= pcm_format_to_bits(i);
 				break;
 			default:

-- 
2.56.0

