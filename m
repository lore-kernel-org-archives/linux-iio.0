Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9AB3E022B;
	Mon, 31 Aug 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176780; cv=fail; b=T58VRoUaTf/TeQ/mTIqY/2gXB1MKsZzOoFq1UFwmqnhwl5Jhk803vVSLV9lD8Y2ekxRP20qEYOxplYPFYvVkb2Ga4FS0RNDdJlkwSjHYPl7W/O+TMxxZzIOqStBmZJr6pt01HmQr0WM2ULo7UndoR0Bivdtgv7YMfTdsIFk43eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176780; c=relaxed/simple;
	bh=KaBHTDWTzlX+KIte0tBVjpY9cl1keME0NcWoIem83mY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UtuX4cRLkZ+1HlqXjsk5OpEqysFYlx4MVy3m4yiTn5Vd/VNNI0QXIkQzTtKPQSEzJoV5ueKcJf6o0QM85omEWY0EorlUGvXL/J1dNlD45TbOMfDmyOI/QEIVtvV/Q9EC40TgIM+HRURpVEvji3COBiFyiJgIyTmm3dfTYMXcJX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JUC7ad/F; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JUC7ad/F"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VB9nKg793175;
	Mon, 31 Aug 2026 07:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ROaa3
	XEIwL5gJT7Nochken3J++WLwwYl38EDgsIiEAg=; b=JUC7ad/FIVl6EXa8zsI2i
	aOj3Ixo4oSLtJxYGTWswwIamFPfdpn3c7CVitoITS7cQBFV2LU8An+Pg6PdepGHv
	FICA5Qq6HbJDs5Jps/qiMCzcU7PmID9x9eM1SO/U0Whz6Kj4LthG09OcaahV0J3e
	YXBYFVn5K5TNkW5UPLE9F6wV7t+eTRwwHoPfoCfUTlvwXa8CZgH8udyUIzwyC3Od
	0Pr8tgDLwmB9L6UGpAKoW4NhIvUjhCEn3l4MHFzU/g5ibzeSuBboAEjgDtHHeUtG
	YOulWnqjRUVkuvxrgB3upoCDadwaLo8GPESAZxt6Vo99avuMxJ7hlGcTSlE8urkN
	g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcg1hu8pt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:45:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu1/iaQdMMI7qEiUkPil0mtDujY9nZI5MpQ3YMl4CFJwFXAM7qblOVFzyoZZ+8AM5DK2368jmC7x7QtmzQm+pMMA/bSDcaMnQ+fGcLcc9JuIrD23YQoHzgforw1z/e6DER4W0vxcSosmHuRqlgOM+nAxxazpyuvt8rINRHrQOZfVBwpFbbAb9xbb5wYtlRmB19HehHJ2oBLZHP4p/Vm2YhktlQg8vmT03L21exDPmzpuZhLrfHA7s9IXVk4SmmnVfkGCwdmLgm+Xog6DmqffwcuXDZ+4xi8x1uPrKCe3RiCI9CXBevep7OFe/T5kkSAV6sC9xHWP5xAA+zZRpYQDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROaa3XEIwL5gJT7Nochken3J++WLwwYl38EDgsIiEAg=;
 b=EI66LRJeQVZ8BitTtPGEtYUUJhxgOCkz2dJmbpZGVXBzAr3wwykC6AdSl82GAOwDwL+7BaFuwmEDOQxCWMZh3Qn40DQiSo7Qqn1pNcPhv2Ab7OFmuQm54K90V08eGLm0KuBB9jsWiRD5V/JXFu7HL5vn2erCjSvaPHsiTrYAIVlQoiTPLd+O0IDdnqp7EJ1zQy9uZyfES9N3z28FM8Duu5q0bu24rF+91758fPlelBFI69laJduxzhliI1cNOunZ+h/Tkwj07oo+4sq1dAEKPhzhSY0sysJAxt6+8FlirbS78B7UR9ghDlWBtMtY2EqlBbG82wzAW0+f9wukdQrOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by EA8PPFB3C90C3D5.namprd03.prod.outlook.com (2603:10b6:30f:fff5::855) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:30 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:30 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:38 +0100
Subject: [PATCH v3 1/9] dmaengine: Support bus widths of 32 bytes and above
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-1-507d97496f2d@analog.com>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
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
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=16418;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KaBHTDWTzlX+KIte0tBVjpY9cl1keME0NcWoIem83mY=;
 b=Kzz9zh53DpY5a8ihazOSU5SRcOqGt9JnXQXUtYKu6Br6yjP/0tXBIVY1YTUVja8siQM+gWw7R
 ltkcjbIdWx2D7q/cZoDp7H3j8uWzms37SxDuzld2M0JvdbhnaFpXSqZ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0067.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|EA8PPFB3C90C3D5:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e457bb-1611-4ee7-4b2f-08df07555b81
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
 sBn2rG2YYgDsvKC5v35V7RGbw+gUXTZ1wTG9vSUUcHxSz3sLEviFkA7mkgt9HCZjyQSB85DBCggFHR24yMBv7X0Cby/SaDOwOa/YAuBGOWBc6X1S0Tzp+BxbIBQ6Vpd3PvjKjJZS2wF8LMyLD9sHZawGJb92syfNUPPpRtRNRojMfDmr0wWve06slWkrePE0xLufXw93bqZV1v6QHcOchv165hptX/T5gsNO2L3BhYIEJUe6sm1xbBMyPF2CYQUvg9K7SdWFM153n5N1S8VKOjzHxg2VKDJUGNxvAyw2Uep6MO9tzRQzmOWPpVCe00prmsFqwFe2LMjctWS7EMYSWCCRQ5mCs4oMpKoOoz5Z/RonBi5FxXDUSe1wnbGuCltJ7YYfKYks4vs3pxBdpkemMW+asqc1A+LhyBEHi95FJIvo7UwORH/oECgY393PsaRcH4PBdh+//a8ovsOz8vIlt9os49NNqAPcHxVMlWarP7fv5zkAIrOoib+eTZ/lQ7YNBdWC+T4DHLvOI9zT3BMpyv4eOXFYuNfZF4QJ4rQOLDEyl7i9mrrJB2pWMQUs3tLOGUBWU1jjV0HG/dQofsuBGhlOGcWIdCMiKGJ9HqglAw+989Y1hSdw/L1d1KZUL3JhOJWNY2XgYkFBadET+P9Jl9xhxCPPzu3eN6j456WHQro=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WkR2SXdtTWlEWG5NVnVLcmh4RE5iRDhQWC9haGZ0NXI0MEhIM3pmbG5WTEtO?=
 =?utf-8?B?M0pFZUZaSDFCWHBXVFh0ZU5zd2ZUaU5qMjZDblRIbmlGaHF3MEEvcVVaMFBw?=
 =?utf-8?B?YmdhSzMwb1FWOUxDV0tuN3lqL2NsVlJmaXBHRFBZMWhuMUJuYU5UZUVtdUFZ?=
 =?utf-8?B?NE84VUtTQ01lUVBVczJPckRzZGhsUmNPbDhFVEJ3SjlJV01RSjYxSUJlVlFR?=
 =?utf-8?B?OWN5eXFxKy9scVpwMEhCaGh6UG5HN1VvYStNMFhYR3JKeGMvS3FwMEY1dzQ1?=
 =?utf-8?B?S0MxNFZFR1p2YUtXSG9va3BKeFBqVFNMbktobDNWUWJ5bXhncFRiMjVlelRj?=
 =?utf-8?B?bjhjNkJRVTh4MU1NQy9wZ0V4eWpPUW1PdmNEUjFjWVV0ME1KQStYbjgzZmRo?=
 =?utf-8?B?YzNHNHg1bVgwRmthNmFBN0xvQVJTbnE5NUxnTjVTT3dlYThhenVDaEl3Wi9o?=
 =?utf-8?B?aHVRQVQ0aEw4MDBMWm9kaHF2VW42VUY2RG12Ymp0ait0UWRKeFpKeXJhcUth?=
 =?utf-8?B?enc0R2VxeFNvSE91a1BDRGxKY2ZrUDg3am1aa1BaUzA3Yy9kMzlUZDU4TTVZ?=
 =?utf-8?B?elBHUlVxeUJSTDVRYTg0RHhqTjZyQTlISmVNb2lEK2RkSnpTb2dHUWNEV1Jw?=
 =?utf-8?B?WGE3NEZrT052UFRCU0xLcEhIYTNQKzhTQkVVL1VvRmZXV29IQ1M3cFZjTlU1?=
 =?utf-8?B?M1l3SkMwR1QyRXZocExBK0RnNzVyZWE0OGQ5K0ZoZnFVcGtkNjFhRGlLbUZ4?=
 =?utf-8?B?d0VNVm4zNUFFc1ZuVWJvSE9rUHhXY3dWV1oycmNEeENLTVJ2UTJjVVkyZVpo?=
 =?utf-8?B?em9KOFpQTEdwdSt0czU5c2N6eHpJZXEraVUvbXVySWc5czlMdzF2T2FxQjFT?=
 =?utf-8?B?eXpFVUUyMEVLQ1ZUWExKaWc3UWt4M21GU1dxbGJxL1hTQTJNSWFTL1JtRk15?=
 =?utf-8?B?OTdidjhTUDJMNTNRT0RLYjZyTWplT01xTFY2bFUvaXFRb2JyY21jcU9EbFhQ?=
 =?utf-8?B?TisxK0p1L3FtdSs3Q3dGZWQwdlA1VGNUdTRkZU5pQXViSXNaN3cranp4SnVp?=
 =?utf-8?B?aC9WcVlWd0FmWndhSkF1d2V4Vzc2NUp4UDVjRUxLSnoxQUxjalVTYXQ4dHdu?=
 =?utf-8?B?WHFELzhCN0phbDYra1FRZ1NXMXVQYnFCVWVUbTRzc3pwdUF5ZDNTMDNSRUd6?=
 =?utf-8?B?VUs0Z20yNlhxdXVuYTZ2aUVqNzJqL25WUkhtcjYyZStLODhPdm83N0dITkhL?=
 =?utf-8?B?amptdlJGT2xxa2lsdCsxMnpKY21ONlMzK3FUK0pHV1ZDN2crM2F4djJVNGh4?=
 =?utf-8?B?RjdKN3FCdVBrdmxPYStTU3k4V0h1UUUrZkNEenZCcHB0dnNNYVZ3Y1lLMkpl?=
 =?utf-8?B?ZXNoTi9Jazdya1lLNm5ISEhOQUh2dXZlV0lLVEV4VnYzd3lMZ1grTElkS1pt?=
 =?utf-8?B?aU9FeTZ6MlJoZU1uTnJIR294Y2c1Y3VYQ282amJYWHpKZ0lCbVgyRXpPWUhi?=
 =?utf-8?B?R2oxc0RmVE44dHQwMkU3ZkFQNk9vRHlnQjJuL0d1ZnM3K2dTc1oxRzR3UFBv?=
 =?utf-8?B?Vnhpd0txZ2ZxR3FTTHNacldqa1JZRXdHOVNWZGhVKzVCbHd0NEhmM29lYXhx?=
 =?utf-8?B?R3pDaFh3RVBOVlJSQlBtZVJubEJlK0RNUy9MeGJCZ1FTVTNFb1o3OGtoZTU2?=
 =?utf-8?B?VkFzeHJRdlk1WnprMlo5aWpneWdQT1F6WXhTMEZMV0wxMDZVY2pkNXgvZDRB?=
 =?utf-8?B?ckp1N2o4dGJEMHpadHFhejF2YkhuZHczZWRrREkzbW1jVXNxR2xLM0NHenZ3?=
 =?utf-8?B?cHhMa2p4d0ZFeG1WMTZ4VXhwd01yazdnREMwaFhtL3FtNjhRNG56QS81RkJz?=
 =?utf-8?B?NzdMMk5telRYelRyU1ByOHQrdVRiUGc4R2VYbGJFeXdzTEJneDBONnFYOFpt?=
 =?utf-8?B?RnNkV2ZpYW9HVlMyVXRueVloODh0UzBVOUtqZUJxYzYvbWo2a0kxalV0SGQx?=
 =?utf-8?B?bDJnVDUvNTZOQU9HQjN1dDBkRkYxMU9BdHRZUjRnbUxINFhLODVvRzNnQ0hW?=
 =?utf-8?B?SkFhUXhoWHI5blhQVlpsVUR5VlZrTmMvbXkvY0tCSHY4WWRJTXlBQlM3RFdB?=
 =?utf-8?B?a2ZPNXBIN1ZTNWtITkhPWThWaTVhZlpUMkFNNDZJUVY4eG5teXBXNGFsMzFV?=
 =?utf-8?B?Z1VuKzJlSkkycVhCTTlrQUlsM2ZHWFFYTVEzZ0tvZWpSdWtua0daOFNmVkVa?=
 =?utf-8?B?bDI4YWZGY1BVU3YwQTVycU1lNHFEdDVrOEFUVWtxOFdSU1RmTWVPOXBKNEVn?=
 =?utf-8?B?aDB4SlgzajlXZUxFTkttdVBSV09vUW83eitNZkQ5ZGpwNFpiZ2dxUT09?=
X-Exchange-RoutingPolicyChecked:
	Z/o23GM1VFMtSEJm8fdsZ1TIjtdrUS/7fLxpaEcim1bNTpOxNjBTzSe7I7uXJgzrwPxcukKggRaShcSwdYlDKj7HUxBo7Ub8XPg7D6ZO8zUjktM6KiUnt8BGpYTE9U3xSwR4lcH20WuDjgWxwGgegQ5uUWPsyOdK1smgJvae7mbQ9N1E5hkeQkmY31bP9LTsNqu/HNYFJMN0NfSIFU1Jwktea2IItaHLE477AQNJuMDzbRUtfeWvydrnNkwb0S+LE+TX5hnD+TQ+5AVs1/XgwbPoGSybdBwhC3i2lcxEH6x/xaIhOg509fFPBwMdZ+f+ACy3UhTysuP2VsSXMQzVKw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e457bb-1611-4ee7-4b2f-08df07555b81
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:30.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BiuU+hj50JSF5dHbTsnEqbxXcQri29VI+sqHfqxTiZgTmrxoCjHFr7kCwmMDZ5Lg1nA0ixWEZsZXKcWcv2Zmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPFB3C90C3D5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX9W5uqukdhAaA
 D8e2sgZ5w/L2p2QSG9UhlKeLpjPJ3DdoI6kDQ7N5md8n/XWUkX3qYKFI7b0NdcOvi5w2CJVNAlk
 uxcJhMtPIAhWmGhL6qnWUlUvnyqcOndGkWAcIh4Ia0Lc0Nw+J5Tu1fRo0pRWm+vZH7Yy/miOeOD
 +HHyKfWn/ACC0nEmxR8vsNrShasR6UMIu3+RaIe7kK4CxwthRwrv78qOQ3v8u57cdbKACt8a6/y
 PK+AeocAi8E0VO8pzzPTDdnA+LMZ52TBDBnCCrY4ArwfYozpya96AHdSS40oAfjCdQLh+xpSL1+
 UK3rx+uGPjVxx9BvehEVnjbsyuXmLAOv76CgYnzGcrIDo+GKhp3WsqVHU96BMgvsZHxDzyGz027
 HHSgSU+/RenJLosleRmcLW3dr7MWsiXxM9ZXWtnzr1cdBfcrWWT0VDivJU/0vK2Ifz+KkRd2lp3
 eFYfd9Wsh9CWPLX9ysQ==
X-Proofpoint-ORIG-GUID: Jn9ye9FxGN6I7TcMYQnM-kvglrcoM0Z7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX6tUy0MELE8Gx
 dmzRG99DO/Q9N9jzISuH1egk0D66aQTqxWz89gzeZPX5Z5KRSxhJcn3KDITXRp5iKgqVDbpKsbH
 JL4ky6rRi+EYaRjmTA+89PJ9eyOn+/WX5rEeZXXXANND0vlnp9ez
X-Proofpoint-GUID: Jn9ye9FxGN6I7TcMYQnM-kvglrcoM0Z7
X-Authority-Analysis: v=2.4 cv=fLkJG5ae c=1 sm=1 tr=0 ts=6a95695c cx=c_pps
 a=e24IK3jsPB00aLvKg+wNHQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=154AB15e2GutjyN8M5kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

The src_addr_widths and dst_addr_widths capability masks encode each
supported width as a bit whose position equals the corresponding
enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
4). As these masks are plain u32, widths of 32 bytes and above
(DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
be represented at all.

Introduce bitmap-based bus width capabilities that span the full enum
range, through a new dma_buswidth_mask_t type modeled after
dma_cap_mask_t. To allow DMA controller drivers to be converted
incrementally, the legacy dma_device u32 fields are kept alongside the
new masks and the core folds a legacy-only driver's u32 into the mask
when the device is registered, so consumers only ever have to look at
the mask.

The new interface lives in two new headers under a new
include/linux/dma/engine/ directory instead of growing
linux/dmaengine.h, which is included nearly everywhere:

 - dma/engine/types.h holds enum dma_slave_buswidth and the new
   dma_buswidth_mask_t type. Like dma_cap_mask_t, the type only needs
   DECLARE_BITMAP();

 - dma/engine/widthmask.h holds the accessors which are based on the new
   dma_buswidth_mask_t type. This gives us freedom to change the core
   without affecting consumers as they only see (and should only use) the
   new type.

Note the fold only has to happen in one direction on the producer side:
nothing outside a controller driver reads the legacy dma_device fields,
so a converted driver's mask is not mirrored back into them. The legacy
dma_slave_caps fields are different, as consumers not converted yet
still read them: dma_get_slave_caps() derives them from the mask when a
device_caps() callback adjusted it. Both go away with the legacy fields.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---
Frank, I dropped your tag because there's lot's of changes on this
one!
---
 MAINTAINERS                          |   1 +
 drivers/dma/dmaengine.c              |  49 ++++++++++-
 include/linux/dma/engine/types.h     |  41 +++++++++
 include/linux/dma/engine/widthmask.h | 164 +++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h            |  56 ++++++------
 5 files changed, 281 insertions(+), 30 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d294df29a0d..f6b6b3ca503c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7649,6 +7649,7 @@ F:	Documentation/driver-api/dmaengine/
 F:	drivers/dma/
 F:	include/dt-bindings/dma/
 F:	include/linux/dma/
+F:	include/linux/dma/engine/
 F:	include/linux/dmaengine.h
 F:	include/linux/of_dma.h
 
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6ffd8bd82154..ae85d26b4803 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -33,7 +33,9 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_dma.h>
+#include <linux/bitmap.h>
 #include <linux/device.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/hardirq.h>
@@ -592,8 +594,11 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	if (!device->directions)
 		return -ENXIO;
 
+	dma_bus_width_copy(caps->src_bus_widths, device->src_bus_widths);
+	dma_bus_width_copy(caps->dst_bus_widths, device->dst_bus_widths);
 	caps->src_addr_widths = device->src_addr_widths;
 	caps->dst_addr_widths = device->dst_addr_widths;
+
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
@@ -611,9 +616,31 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	 * callback to override the generic capabilities with
 	 * channel-specific ones.
 	 */
-	if (device->device_caps)
+	if (device->device_caps) {
 		device->device_caps(chan, caps);
 
+		/*
+		 * A driver already converted to the bus width interface
+		 * adjusts the masks, so derive the legacy capabilities from
+		 * them for the consumers not converted yet. Drivers not
+		 * converted adjust the legacy capabilities directly, in which
+		 * case there is nothing to do.
+		 *
+		 * Goes away with the legacy dma_slave_caps fields.
+		 */
+		if (!bitmap_equal(caps->src_bus_widths.bits,
+				  device->src_bus_widths.bits,
+				  DMA_SLAVE_BUSWIDTH_MAX))
+			caps->src_addr_widths = bitmap_read(caps->src_bus_widths.bits,
+							    0, 32);
+
+		if (!bitmap_equal(caps->dst_bus_widths.bits,
+				  device->dst_bus_widths.bits,
+				  DMA_SLAVE_BUSWIDTH_MAX))
+			caps->dst_addr_widths = bitmap_read(caps->dst_bus_widths.bits,
+							    0, 32);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
@@ -1170,6 +1197,24 @@ void dma_async_device_channel_unregister(struct dma_device *device,
 }
 EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
 
+/*
+ * DMA controller drivers not converted to the bus width helpers only fill in
+ * the legacy u32 masks, which cannot hold widths of 32 bytes and above. Fold
+ * them into the mask so that consumers only ever have to look at the mask.
+ *
+ * Goes away with the legacy dma_device fields.
+ */
+static void dma_device_fold_legacy_bus_widths(struct dma_device *device)
+{
+	if (bitmap_empty(device->src_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
+		bitmap_from_arr32(device->src_bus_widths.bits,
+				  &device->src_addr_widths, 32);
+
+	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
+		bitmap_from_arr32(device->dst_bus_widths.bits,
+				  &device->dst_addr_widths, 32);
+}
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device:	pointer to &struct dma_device
@@ -1231,6 +1276,8 @@ int dma_async_device_register(struct dma_device *device)
 		dev_dbg(device->dev,
 			 "WARN: Device release is not defined so it is not safe to unbind this driver while in use\n");
 
+	dma_device_fold_legacy_bus_widths(device);
+
 	kref_init(&device->ref);
 
 	/* note: this only matters in the
diff --git a/include/linux/dma/engine/types.h b/include/linux/dma/engine/types.h
new file mode 100644
index 000000000000..92f3dec18bc5
--- /dev/null
+++ b/include/linux/dma/engine/types.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Basic types shared by the DMA engine interfaces.
+ */
+#ifndef LINUX_DMA_ENGINE_TYPES_H
+#define LINUX_DMA_ENGINE_TYPES_H
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+/**
+ * enum dma_slave_buswidth - defines bus width of the DMA slave
+ * device, source or target buses
+ */
+enum dma_slave_buswidth {
+	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
+	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
+	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
+	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
+	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
+	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
+	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
+	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
+	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
+	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
+	DMA_SLAVE_BUSWIDTH_MAX
+};
+
+/**
+ * typedef dma_buswidth_mask_t - bus width capabilities bitmap modeled after
+ * dma_cap_mask_t.
+ *
+ * Each supported bus width is represented by the bit whose position equals the
+ * corresponding enum dma_slave_buswidth value, e.g. a device supporting a bus
+ * width of 4 bytes has bit 4 set.
+ */
+typedef struct {
+	DECLARE_BITMAP(bits, DMA_SLAVE_BUSWIDTH_MAX);
+} dma_buswidth_mask_t;
+
+#endif /* LINUX_DMA_ENGINE_TYPES_H */
diff --git a/include/linux/dma/engine/widthmask.h b/include/linux/dma/engine/widthmask.h
new file mode 100644
index 000000000000..211c29712bea
--- /dev/null
+++ b/include/linux/dma/engine/widthmask.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Bus width capabilities of DMA engine devices and channels.
+ */
+#ifndef LINUX_DMA_ENGINE_WIDTHMASK_H
+#define LINUX_DMA_ENGINE_WIDTHMASK_H
+
+#include <linux/bitmap.h>
+#include <linux/dma/engine/types.h>
+#include <linux/types.h>
+
+/**
+ * dma_bus_width_valid - test if a bus width is a valid one
+ * @width: bus width to validate
+ *
+ * Return: true if @width is a valid &enum dma_slave_buswidth, false otherwise.
+ */
+static inline bool dma_bus_width_valid(enum dma_slave_buswidth width)
+{
+	switch (width) {
+	case DMA_SLAVE_BUSWIDTH_UNDEFINED:
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+	case DMA_SLAVE_BUSWIDTH_3_BYTES:
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+	case DMA_SLAVE_BUSWIDTH_16_BYTES:
+	case DMA_SLAVE_BUSWIDTH_32_BYTES:
+	case DMA_SLAVE_BUSWIDTH_64_BYTES:
+	case DMA_SLAVE_BUSWIDTH_128_BYTES:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline int __dma_bus_width_set_many(dma_buswidth_mask_t *mask,
+					   const enum dma_slave_buswidth *widths,
+					   unsigned int n_widths)
+{
+	for (unsigned int i = 0; i < n_widths; i++) {
+		if (!dma_bus_width_valid(widths[i]))
+			return -EINVAL;
+
+		__set_bit(widths[i], mask->bits);
+	}
+
+	return 0;
+}
+
+/**
+ * dma_bus_width_set_many - set the supported bus widths
+ * @mask: bus width mask
+ * @widths: array of supported bus widths
+ * @n_widths: number of entries in @widths
+ *
+ * Return: 0 on success, -EINVAL if @widths contains an invalid bus width. Note
+ * that the bus widths validated before the failing one are still set.
+ */
+#define dma_bus_width_set_many(mask, widths, n_widths) \
+	__dma_bus_width_set_many(&(mask), (widths), (n_widths))
+
+/**
+ * dma_bus_width_set - set a single supported bus width
+ * @mask: bus width mask
+ * @width: supported bus width
+ *
+ * Return: 0 on success, -EINVAL if @width is invalid.
+ */
+#define dma_bus_width_set(mask, width) \
+	__dma_bus_width_set_many(&(mask), (const enum dma_slave_buswidth[]){ (width) }, 1)
+
+static inline int __dma_bus_width_clear(dma_buswidth_mask_t *mask,
+					enum dma_slave_buswidth width)
+{
+	if (!dma_bus_width_valid(width))
+		return -EINVAL;
+
+	__clear_bit(width, mask->bits);
+
+	return 0;
+}
+
+/**
+ * dma_bus_width_clear - remove a bus width from a bus width mask
+ * @mask: bus width mask
+ * @width: bus width to clear
+ *
+ * Return: 0 on success, -EINVAL if @width is invalid.
+ */
+#define dma_bus_width_clear(mask, width) __dma_bus_width_clear(&(mask), (width))
+
+static inline bool __dma_bus_width_test(const dma_buswidth_mask_t *mask,
+					enum dma_slave_buswidth width)
+{
+	if (!dma_bus_width_valid(width))
+		return false;
+
+	return test_bit(width, mask->bits);
+}
+
+/**
+ * dma_bus_width_test - test if a bus width is part of a bus width mask
+ * @mask: bus width mask
+ * @width: bus width to test
+ *
+ * Return: true if @width is set in @mask, false otherwise.
+ */
+#define dma_bus_width_test(mask, width) __dma_bus_width_test(&(mask), (width))
+
+static inline enum dma_slave_buswidth
+__dma_bus_width_min(const dma_buswidth_mask_t *mask)
+{
+	enum dma_slave_buswidth width = find_first_bit(mask->bits,
+						       DMA_SLAVE_BUSWIDTH_MAX);
+
+	if (width == DMA_SLAVE_BUSWIDTH_MAX)
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+
+	return width;
+}
+
+/**
+ * dma_bus_width_min - get the smallest bus width of a bus width mask
+ * @mask: bus width mask
+ *
+ * Return: the smallest bus width set in @mask, or
+ * %DMA_SLAVE_BUSWIDTH_UNDEFINED if @mask is empty.
+ */
+#define dma_bus_width_min(mask) __dma_bus_width_min(&(mask))
+
+static inline void __dma_bus_width_copy(dma_buswidth_mask_t *dst,
+					const dma_buswidth_mask_t *src)
+{
+	bitmap_copy(dst->bits, src->bits, DMA_SLAVE_BUSWIDTH_MAX);
+}
+
+/**
+ * dma_bus_width_copy - copy a bus width mask
+ * @dst: bus width mask to copy to
+ * @src: bus width mask to copy from
+ */
+#define dma_bus_width_copy(dst, src) __dma_bus_width_copy(&(dst), &(src))
+
+static inline bool __dma_bus_width_and(dma_buswidth_mask_t *dst,
+				       const dma_buswidth_mask_t *src1,
+				       const dma_buswidth_mask_t *src2)
+{
+	return bitmap_and(dst->bits, src1->bits, src2->bits,
+			  DMA_SLAVE_BUSWIDTH_MAX);
+}
+
+/**
+ * dma_bus_width_and - intersect two bus width masks
+ * @dst: bus width mask to store the result in
+ * @src1: first bus width mask
+ * @src2: second bus width mask
+ *
+ * Return: true if @dst has at least one bus width set, false otherwise.
+ */
+#define dma_bus_width_and(dst, src1, src2) \
+	__dma_bus_width_and(&(dst), &(src1), &(src2))
+
+#endif /* LINUX_DMA_ENGINE_WIDTHMASK_H */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index fe33a20abc61..31c57d3dcb53 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -5,7 +5,9 @@
 #ifndef LINUX_DMAENGINE_H
 #define LINUX_DMAENGINE_H
 
+#include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/dma/engine/types.h>
 #include <linux/err.h>
 #include <linux/uio.h>
 #include <linux/bug.h>
@@ -384,23 +386,6 @@ struct dma_chan_dev {
 	bool chan_dma_dev;
 };
 
-/**
- * enum dma_slave_buswidth - defines bus width of the DMA slave
- * device, source or target buses
- */
-enum dma_slave_buswidth {
-	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
-	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
-	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
-	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
-	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
-	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
-	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
-	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
-	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
-	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
-};
-
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
@@ -495,10 +480,11 @@ enum dma_residue_granularity {
 
 /**
  * struct dma_slave_caps - expose capabilities of a slave channel only
- * @src_addr_widths: bit mask of src addr widths the channel supports.
- *	Width is specified in bytes, e.g. for a channel supporting
- *	a width of 4 the mask should have BIT(4) set.
- * @dst_addr_widths: bit mask of dst addr widths the channel supports
+ * @src_bus_widths: mask of source bus widths the channel supports.
+ * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
+ * @dst_bus_widths: mask of destination bus widths the channel supports.
+ * @dst_addr_widths: legacy bit mask of destination bus widths the channel
+ *	supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -517,8 +503,14 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		dma_buswidth_mask_t src_bus_widths;
+		u32 src_addr_widths;
+	};
+	struct {
+		dma_buswidth_mask_t dst_bus_widths;
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
@@ -811,10 +803,10 @@ struct dma_filter {
  * @dev: struct device reference for dma mapping api
  * @owner: owner module (automatically set based on the provided dev)
  * @chan_ida: unique channel ID
- * @src_addr_widths: bit mask of src addr widths the device supports
- *	Width is specified in bytes, e.g. for a device supporting
- *	a width of 4 the mask should have BIT(4) set.
- * @dst_addr_widths: bit mask of dst addr widths the device supports
+ * @src_bus_widths: mask of source bus widths the device supports.
+ * @src_addr_widths: legacy bit mask of source bus widths the device supports.
+ * @dst_bus_widths: mask of destination bus widths the device supports.
+ * @dst_addr_widths: legacy bit mask of destination bus widths the device supports.
  * @directions: bit mask of slave directions the device supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -896,8 +888,14 @@ struct dma_device {
 	struct module *owner;
 	struct ida chan_ida;
 
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		dma_buswidth_mask_t src_bus_widths;
+		u32 src_addr_widths;
+	};
+	struct {
+		dma_buswidth_mask_t dst_bus_widths;
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;

-- 
2.55.0

