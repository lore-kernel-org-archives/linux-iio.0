Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939E4E3234;
	Wed, 14 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987608; cv=fail; b=abgVAhl7lUu7YeD9ZUlh0HXiOS/w1CPmA9DQ16SDS7PRyzcUIgWTb71kpizNXfe2C0EWoBCw58LmFOmhby17dneZRK+kzVzPFyGMUnZT3Qx2oc/E0OL63kFScFR2XTsm2+OlJOscYa9xU7d/XJAudtc01YHPzdrFO8Xc0HXzN74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987608; c=relaxed/simple;
	bh=/sigtXVh+YweK63iNRI9Kc4B5quKprdvmw+/YvhEXNY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Wl5psCNcanGkZqGOS+kjpYugHlWfzHzXo6y/gyzr6CrtVtTSRqpeF7drOvay6utYJNa3h3DRYV/4UAewBjzfi6tIl7/TBalC+jf8u9D3zqhXWrjJOVEycOrrLjophrNJ6uz+Ht7YxJofoEkKNxTOUDMKYXwNtQL+O4MvSITvLbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=af3jI2Bw; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FHZ77jVq; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="af3jI2Bw";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FHZ77jVq"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ED6Ylv3826798;
	Wed, 14 Oct 2026 10:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=D5ZwTzYHKzHL5Ux1C7O63dT8kPtv6AivxTbc4hQLfqQ=; b=af3jI2B
	wUj5xG7HYMb/m+TiB+QFVeYcUt6fbsAxF6b0XBVAlF8x0gx0Zu3PuWPwCxBKYzvn
	bIlSj+1VGMBDJT7/+OhXXRhlHOUDqlfWbmNSmwd7kEnqoJ5wNazCz4vOB93fI4xZ
	6MGE6VR98nelPMO6jjEsy4sPJ3Y3tlirftKW3raagghYJZO0hxG/DPCP5cmbVD9z
	QUT8rJnvR2AD/G3LLwsDyBjDVauhHS+4deHL/yTluQevorJlsFq9xmRe+NQra3B7
	T9WMIHDAe6Hkr0ptiDZOc7EJh6bIn9nAa7cF0/DAXieV/5KL51BTMl9MuE1UwElF
	vgXSQqJIpQ8HSYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=D5ZwT
	zYHKzHL5Ux1C7O63dT8kPtv6AivxTbc4hQLfqQ=; b=FHZ77jVq6Qp8g7dilfSGu
	KIm/xq4czgEWiQ+fLqqG7NuzY+2zprfY2eg3BJ8vKysnSoUnfX6MFuUba/mtHiqv
	eDX15D2DgsNFISUECs38HAjl0P/iSYRWhFaS0fzjtP7S6l05cEAEpI0c2DxUgtqh
	1u2Zyrz4+Xe6aNx0dmWYfgDZRY6xHNtMtRdjViDaIxELBQsXBMAeCMDL+K6zlPZS
	oyi5AmuNfbRIYGN3Mi5itMRbK/GU2ki6A4QFlBwLkKvxyha2oIpSiQZIXcK0kT8J
	ZzB1D1vdTJwumY36T/+tU8FN/mHIeF1CEJXSDV7ZuL9YHm2CKtJPSJvvznEPQQfy
	Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haab60gqy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:18:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH3LDExjo4ll/+ks8DjDHZHubh6FpMI7ZvacSOUqLBCx0YF71Va5pfTjKv5y0tCPt0ai9Lo1epWZDA0ctO877Yr9n4kcg5/EVH7oEC22yrR+79sIgrImx+wAboA04/cDy0HLL+BqXWPRgWavyU+iAg7JhqfVIHEoJfqf8RTdC/Ol7lJag+aWg5l+7xFKai2c0O2rc9aI1RSU+IJIJA5yt49s9Wu5XkUSpbYrhifDqL/LVUDGrvGX6799YTREd7eJosuBOUsZZQhw9/uaNcOmgnFNXxXHvaD8f1empGcbLXJxOxMXMOmx4PNhRibOkoez6iPam7/jcgPwMSSpuhAkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5ZwTzYHKzHL5Ux1C7O63dT8kPtv6AivxTbc4hQLfqQ=;
 b=YjBoRRIEv7BuNCOoNs+2bsVWLHHlVaON8XR6FLt6Zawj4iVdBExV4Jspo7jevAZlu8lQaRqxz8eNT8l55bT6DhEV8gBBU7CqB80WnXRwZiWor36IYCLel1VAS3UUBPdG2aD/ekDnQpqmMwi9k+u2X6DtUoHt9vtxeK+3nBASageBjZqGnyI78b/xbOoDxlHHyj48Vi0unZ9EPym2WDnzy85nrHJAO7362ryfc8jFuY2AFDVwEXBquR7K3pMTFF82J9c/IM4VLrLFmOR2gBDVswtaoaeWLkCqY9e0B0/Yle/Tgj+PtG9DaJmjCe4f7SDlSnUGzztHMeLKwkRsd7LNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:18:13 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:18:13 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 14 Oct 2026 15:19:15 +0100
Subject: [PATCH v6 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-5-5b3ffdef8191@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=3868;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/sigtXVh+YweK63iNRI9Kc4B5quKprdvmw+/YvhEXNY=;
 b=RdCJ9furYBOdhx52HVvtCaZgmFrv9obMNY4O5v96M+HfEtN8/zzikWTlXkka36fMUcJ+xsxIG
 89pfl4cSpBWBWPmnxa6oe1UMburMsYl0FoEp2+MxMR0lw4aV8xkClgM
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0180.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d123df-0ad2-4efd-bc7c-08df29fdfb50
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 lDBdmxIRrbpEITbAzjvt3g5TF6FUuOwZk3g+Llmin5u1Sjieh520uZSgyqDxb91+znAZ7+cqxmJiRJOywkxlJQ/SDHlA56efvHA3hbQM9bHPHpQmmhjmhx7MOrkNTSESr4s/ICibbPKCQnEfjPpX/gPiU7aiSHMwAlfgaspf9jThyvNKJVHobDI0SSm8ApIEuVLqtnHYrgxguAdxOOFjlAYYHXhFGloU49foNIPFJMBa3EFyQU1scl27zyCCznvfJmnb9Hzp5mdlHtbKrQHc3f9xt3S2d/WUld5Crc6eS+7BDKXozAmZph5DyqWHa9eo9JTv+xvETiDcLOHNq0TW1gTVXnx3eT6voVUCvPnZQHqtdMHQT7yjnEFrd4QFWs8dUPYX28B8a5PvD5qStJOTriNg5gPyyt48H06CMwS6hUi4rUlcUNH0VdfJdi7eDScd69mVK+mBCMPNMOLSAkGQoNFenrjCPxaS1pTpOCpQUcSHXx2bh9IF++PvwHauIGOBtZZA43D+dEA9yrv4xfAsARN2d44vJjH1rWone26z/wxTAuAjeLRAjUEHZmDE/5OaLzTvQ9HTIDlrDtJ6MXcWFFdEjzliZixyZi5cb5t+FFaNLCjAcrGNVOrtdWzHhN8mfYu6X6h7SOLw5KfGEgL0gF5Fa/dt1Dwa2gfWtlowsKo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VitPWG1lQ0duV2FsMW9GNmplYU5ydUJJL0JXWWtpYVJkWnhvc1F5b2hSZDVw?=
 =?utf-8?B?UDllQzhhV1hLVUZhZ0wrTHBLSExFWXBtbjRPN2xjZTl0Mkk1ajdQTWRoTGl6?=
 =?utf-8?B?eGRwMzQ4enpaVTRqdG9SQXo2K3RzUnNxblN5d0xQanJQR1A2Z3RVdFEwLzdJ?=
 =?utf-8?B?dVVodUtwMEkwWWtCRk9YdjY2ZEZXRk03cHdYVVpMamNPZ2hnRlFPbkpzUURj?=
 =?utf-8?B?UE9LWEVaYWVZRUhuSGQ5b1BOcmZIcVJWSWN4RitxaTBaMDg0SFhKY2F3L3ZP?=
 =?utf-8?B?bXlKcktWVG9PTk1lK0tQUDQ2elBjdlV3Y1l5RjdQRXhFamRFd04vMUlPZkM2?=
 =?utf-8?B?REZGRUR3Z3p4aWJhR2R0QmFWek4rWWFPYjhVMExyOEdWK0E1QXFodGNWSFBN?=
 =?utf-8?B?TUpjVnBoUkZna0IyS0VoV2ZaN2x2MEhLRFZ1UFd2UkpXR0U3RTBFZmVGUmp1?=
 =?utf-8?B?bXBSSFFBWGFPY2F5ZG1waitlREYzK1hhcEpralZxOHJiMEtxbkE2ZVlHWXp2?=
 =?utf-8?B?blJMajM5VHJkcWgrSFNieDdMdFgvNWpLa2pKemUvUWZRS2UrRTlNc1JUUmUy?=
 =?utf-8?B?L3JHRFV6OWpCWWU0bFNHZjBYMTZUSmp0N0hDaUV6MUp4WHF3RkNsaWlkcGdR?=
 =?utf-8?B?YWQxV3JVV3NoUTFNb3FaRTBUaWpXUFBITVJMTFdpOHZ2YWFZWk1ucEJ5RW5Q?=
 =?utf-8?B?LzloQmwvRmpnUlViTEF2aTJyMTdTalRzb2lrbDFDTkhDZ0pZZGUybmxjNmIz?=
 =?utf-8?B?a251ZEoxcEZOVjVRTWh4dVU2TEZ3RHNoTitoNVZIelpzZXFKcTN3MEFxdjZl?=
 =?utf-8?B?MHFMaEZSWlVtdk1QWVZRY2VFcXVLak1RNlpJNTZiY2lsOEhvNGlQdGdqeU5O?=
 =?utf-8?B?S3YzYTJrbVIyaEY5UHFDSWlNeUsvK2xDNXJnVVdydEtOU2RXdWJoMG5zL0Nr?=
 =?utf-8?B?UEJmZkZISWtjYXo4Q00xNkJUdEJIRFNEMU1zc2ZQU3NqTkhHaC9tWGh1aEhV?=
 =?utf-8?B?cm1leHNkVlFmU0NUUVA0SSs4WGtwTlBHbTBMYmFNdllxemR2Wi9jSlBzRHhp?=
 =?utf-8?B?bUI3K0RzNURGUUVyYnp1VXh3c2dHNlZPU1ZzNWZaZThwWVEwMmRrdjZsSDg0?=
 =?utf-8?B?Vk5FQThYUktiVWZqZFdHaXFGdXNMelJ2ZzZwbThuOHlYSzVXVmRPZDNKSUVU?=
 =?utf-8?B?QVNsYVkxMEVZdGQzZXpJVHRwa3dHYXRQUzNvUGZXa2YwZzVUWlhMdWwzYktj?=
 =?utf-8?B?WThkM0Z6RE1MVFU4eVRnVDRwem00b2xEa2U2TVljV2ZSWjRkcmYxVGdsdUND?=
 =?utf-8?B?NkNIR0RtZ1VGdUt6cUJDY2ZRVUhEdDNDaFhwZkJlZERJeGVXU0dscmdCZHhn?=
 =?utf-8?B?Sm1SdGdKWEFPb3RuQUkxM1hjNmxJOXU4c1pLcHg4YTFYbkFJVFU2TnNWd01z?=
 =?utf-8?B?NXJFUlg1MFhTdlUwdWFDZ2dxOTNpUWNCMGJMWEphYnYzbHJyNFdXemoyVWdT?=
 =?utf-8?B?clZrSnkwUnFwVm9XWFJJYU1XVHJyZ1hJSlhqS0R5Z2ZBNUtwNEkzRVM1Mkhz?=
 =?utf-8?B?NjdBOVJLTTUrM1Q4NENGelRET0RseTVmMk5jS2NRejRvTHQxYUd0b2c1Rkto?=
 =?utf-8?B?dlVzdGNKS1hHRENnSmMzeEcyLzJsY1c2WmhIYUVyc2x2OVRERXhVTEg2UlVH?=
 =?utf-8?B?Rk1IcXRVS0JBZzJ4VnJjb09kNE0veUo1Y05DTmJyVFQ2Z05qLzVWR3BlMjJs?=
 =?utf-8?B?Zlp0UE9TK0s1UEZlVDRjZnNhbHdUUFkxRjE4SEc5UkkvMjhmMUI5bHZ2YkRn?=
 =?utf-8?B?a0E3cHBtcFZoajYzenNCb3pJalhnZmRlakQ5OEFHb0hVbFQ5cjBPSFUycFlu?=
 =?utf-8?B?dzBMQlpIdmx2d3Fnald6cjBJbGIwdTdXUnZxbHNEdW5SYVJieXlVVTFtOXA2?=
 =?utf-8?B?eE5TM1VyUUxDTjEzbFp4dnk3K2FRd2dsdlhTUW5WZTVkZ3JuL0JyS25mUk5I?=
 =?utf-8?B?a25EcnpaVUd5MzRuUEtOTEl5V2VMKytqU3g0aW5zdzRhSnlTKzhadnJUbmpr?=
 =?utf-8?B?L3AxbWszTXlxR0F3Z0tSdVV5cE51aWttcFhUNnlmZ29sb1dKZnFDcG5oWk5i?=
 =?utf-8?B?dTg0YnVodkdNNUJyODlFa045UzlUcmtkREVZZU12cmZvRGF0bDJXOTVGRk53?=
 =?utf-8?B?VUJ2UUJ0clFaWnFRUjVpb0RHRlhMS2sreEJxV2JFcHdjdVpnRkROUnl5ZHUy?=
 =?utf-8?B?T0ljWjAwcWw3RG5WcUkzN25ZMUkwTkltV1pXRkZoZlUvbWdzbjRTUmRiOW9v?=
 =?utf-8?B?WWlyV3lHU0FzMkZpZHZUWHA4WHg5RzZ0b2dVQ29ReS9jRFJaTHVYdz09?=
X-Exchange-RoutingPolicyChecked:
	t8AYcHPQNYOvJhENU/Obu/G6snst6IsGt3WzgyDXxEixoWKTnNSNxmBAi2Gte+S+iw5XHUcvC+owSlAbqbR+Nh1s7Ff9NmBykm+/6H9jh9oSnIVl/aCv1yTq917/80bPvxedu58sQqDFnr4lnXbbcCz3Y/0crwend1LIbmNl9mude18J4WqUEznR5hts1e7sRIZUDLxioKzWgAoFHPnhV0ZcL0R9InZaVNoJO1UwSv3v0DHCgke5BWsYwcSf9UoaWYYlngULsCu3FUwOUT2i5xk6/AjIeYWlJ3WPRQiaKPvD2JC6jxsPw2lbry63vCRpDffWtnus6mQzj+dYPiA9iA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d123df-0ad2-4efd-bc7c-08df29fdfb50
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:18:13.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezhfPBhxbBum0NfTz3EhGI79dRNOKsoJZMNx0SYIz7S3bl6Rg1r6zNaGWJlpnuOYCll6XENolyD0KIcM/oxUxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6acf8f29 cx=c_pps
 a=f/vGOH3Q9iIJglbWlzIglQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=8AirrxEcAAAA:8 a=8b9GpE9nAAAA:8 a=gAnH3GRIAAAA:8 a=hoLHniV83FUdLTyWGJsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 8yXCS_G5tbXuQAgYX9Xqo0qmW_eUDdfI
X-Proofpoint-ORIG-GUID: 8yXCS_G5tbXuQAgYX9Xqo0qmW_eUDdfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX3fqmdNnPOGcD
 3MovFdVpfaILSUCnb3QcTWzQbBXbWLVZszCY+Nbm+0y/6sluReIvGH4esn8Uvb7FkRdYkyvRLTr
 OQ7s8TabumP23KQNDRmMMY3/UhTbx/BQZCYiFq7Ahv7zfGOz3yjhvMvYaYx4798Pzj4xqnw8R8V
 Bo6eFPboQOOCk2/7GPM5xlpeENv8u55n9bk3u4DR8XRe4v+YTRsBJepW02kW6mGlYDOEt+yo0J/
 RtT5ot6BJZtVDu8NZ4radOhI2FuYyUBRYeRbZn8GEmmhkfWU2qgf0WSVW1WDa7nJICsWaJz2Rqz
 6la9IBDPC7ZaENRAkpIGVmmu6OK/pWvubQCZngT2w66JNkMSQuVAnXRlCNOezXLsVN45FB47uVV
 bSrjZA1RYYRnE1hKAQF9aCKiGona3zN6bhvsDqfLj4g/vu2w+osYZ45yt45y5LcDG2Qk3bAbPvj
 WMlO8wPf1FRCMA8ijNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX1SEvD00ticAF
 xapJDqb65Z85iLjAQDRHbF08jM1HUsT5YBHNjSozeUNPDpR6hQ0nC332XQ9D4EB1EnSrAyNjbPx
 cGuXtXDXHiYgLlOGA0Oeyt8T+ceF1Sm4yaYTiKbyOo6YogPQx39T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140056

Advertise the controller-wide bus width capabilities through the new
dmaengine_bus_width_set_many() helper and clear the per-channel
unsupported widths through dmaengine_bus_width_clear().

While at it, validate the requested transfer bus widths against the new
capability mask instead of the legacy u32 one, so the driver does not
depend on the legacy field anymore.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/stm32/stm32-dma3.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4fe226541efa..5d0a4ac4d2cf 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -583,7 +583,8 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 	dbl_max = chan->dma_config.dst_maxburst ? : 1;
 
 	/* Following conditions would raise User Setting Error interrupt */
-	if (!(dma_device.src_addr_widths & BIT(sdw)) || !(dma_device.dst_addr_widths & BIT(ddw))) {
+	if (!dmaengine_bus_width_test(&dma_device.src_bus_widths, sdw) ||
+	    !dmaengine_bus_width_test(&dma_device.dst_bus_widths, ddw)) {
 		dev_err(vchan_chan_dev(&chan->vchan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
 		return -EINVAL;
 	}
@@ -1464,14 +1465,16 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
 
 	if (!chan->fifo_size) {
 		caps->max_burst = 0;
-		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dmaengine_bus_width_clear(&caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dmaengine_bus_width_clear(&caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
 	} else {
 		/* Burst transfer should not exceed half of the fifo size */
 		caps->max_burst = chan->max_burst;
 		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
-			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dmaengine_bus_width_clear(&caps->src_bus_widths,
+						  DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dmaengine_bus_width_clear(&caps->dst_bus_widths,
+						  DMA_SLAVE_BUSWIDTH_8_BYTES);
 		}
 	}
 }
@@ -1729,6 +1732,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	struct reset_control *reset;
 	struct stm32_dma3_chan *chan;
 	struct dma_device *dma_dev;
+	enum dma_slave_buswidth buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+	};
 	u32 master_ports, chan_reserved, i, verr;
 	u64 hwcfgr;
 	int ret;
@@ -1770,14 +1779,16 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	 * channel, and can only access address at even boundaries, multiple of the buswidth.
 	 */
 	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
-	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	ret = dmaengine_bus_width_set_many(&dma_dev->src_bus_widths, buswidths,
+					   ARRAY_SIZE(buswidths));
+	if (ret)
+		goto err_clk_disable;
+
+	ret = dmaengine_bus_width_set_many(&dma_dev->dst_bus_widths, buswidths,
+					   ARRAY_SIZE(buswidths));
+	if (ret)
+		goto err_clk_disable;
+
 	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
 
 	dma_dev->descriptor_reuse = true;

-- 
2.56.0

