Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F654AB1BF;
	Fri, 11 Sep 2026 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147958; cv=fail; b=auno3DNtDeLtUMuxIS5tC4DidqQoAXnzF6W4E38Jx28sFOnPRkbltaPma2xnrqBtK+ABaE0zH6gaqP/yJ3nOKI8uBbioN/0HzGiHUaFGszNa55Ipr6//Q67o4j8BVaEZAEDhslbZKM+IsGKc/de4N4nCM1c+gAC2jUOU806XQqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147958; c=relaxed/simple;
	bh=D79BjEQOBpK/lp/PXps5EVVumwTED5Zo7X13w/9wZF0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FdUHXHdWtqvD0VRb7mR8wJzxSg+cOZvnm4swRIWQ154Vepk0qHTSuCMjO2YjrEvedolblJSGknFuLmBRWxEGBvgsm8ljmGE6ORI2iLAH9C9xNG7gUNs5N9giS6bV8iMupxUbNJ4dW7gUAP0bPYM35iHqkQHoV4aoIPHTR+9uwTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VYDqjTMW; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VYDqjTMW"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEiv5G3945936;
	Fri, 11 Sep 2026 13:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=k7WoebOmF7ijmUWceOyVK1wqqSm
	LDpBmSdhmMe+CCbc=; b=VYDqjTMWMOZR7J90tfdI7qSmYQU5BcKDU8rc0p2SCdi
	5y1VBLw99NeRP5tkDK5sov4Gqz/zrXTNHkBm1m17gEgedXjPLtFktzg4qMCTXI7t
	I0oPo/2kktCy5rAgG3JTZOfzziQXonIPS6B+mCmuJzNRiCDUyDqOyXEAAL4mI3Ug
	09aGUjkv7Q8hi7Mp31fv+qrgJbZX/fKM2+KmAAK4GPKtFCvSJsz/Yh7zzBDqmdJL
	cfmkP4HsXOAmJbxd2e5+XSa0Wml3RqtdtKbr/soll2+jzrjfsYCZf7B44cJPZRh+
	aVnhUjk3hC01146Vdxv9uTURbxq0cxRgWk33qs1/l9w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gmeeg9j62-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:28:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TanE1LPiiX34C/9N9l7L3NBBUh5DB2Sn+V7RL3l62KXlXD5VUzLjZADsqz1akMtb+m4aN552GmxFQOo8D7YO3rnTCcKj8TS5c4NM5GbX6mxCEva7BBiS7Iv9+YT4Wzw4vHotZf1Al4feqqF/kv7LHQJhQc9LrqLYXQSyinB885UxhFc/+yJOOLf9rBVnfIY7t4/XDA2AFR/ND4B5wXeeQI+bQjQw/qAMjRfZO6pDy2cE5yL5//Wics1HaWd50GfP/uyMPFJIddxR68Tx+p49/a/T4PuHoNWP8tZMeeJzS+A4wcPXaIb55gOIRsOrQy+ZrbBDD3ew3Geat29eHiqiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7WoebOmF7ijmUWceOyVK1wqqSmLDpBmSdhmMe+CCbc=;
 b=WGfNIO85KVLg33x4lXrl9FKXFxNcPF7wko7DgQm3FH439Uc8Bx5K9qAAypKqx+wwzHNukuWVmczc8/yxWsb//E9l8QgL5Rtm6p3+5d8XtYky2pO1EBhXLxabggp1y50jnIUjmQ5oP54oxPsoK9MTqapL7l2eirM1xp7Bc5sujgG460kxmdAGpM+qQGiL4vRSTvc56bB6sB4KV5wDKoLQV/296Tg+VEsjl4tNBlL/5IXeZUt5uYthIH3/eRp2/eH3NiKdPNfpYryQLaOyU3xSm4RTBwtYdjs7ccRlBUP/bVQ9/lG6I49b/IduJdHZkTPwTEFQi5e3GjEvI791+Yi0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:28:43 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:28:43 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v4 00/10] dmaengine: Support bus widths of 32 bytes and
 above
Date: Fri, 11 Sep 2026 18:25:35 +0100
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OzU7EIBQF4FeZsBbDT4HiyvcwLm756aAWGuhUz
 aTvLtQYx7jp8tzcfOdcUXE5uIIeTleU3RpKSLGG7u6EzBni6HCwNSNGmCSSCmwncHEM0eFymee
 UF/werMvtjicorwULAENZp5VjClVnzs6Hj73j6fk7l8vw4szS4PZxDmVJ+XMfsdL299MnD/StF
 BNsgXHorRmUkI8Q4S2N9yZNTd8pxclRiivOPPXaagO3VNu+st91PT1EskpSrwale0u48P9IfkN
 yeoTklRREWa06LT2zf8ht274A4wKKGNYBAAA=
X-Change-ID: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
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
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=5007;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=D79BjEQOBpK/lp/PXps5EVVumwTED5Zo7X13w/9wZF0=;
 b=bEGJ9I64uaBFRXiS4hH3fGJm9bC+otkcEbSscABKKmp7V8m9Exuk204beMD+kMTnRtBHkMTi4
 jZDvxLCtaT+B18zLvZuy4BHOm8o9B2xdWLmf2FQWYk3A5RsToLVN/RO
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0023.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::18)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 38883b45-6450-409a-7814-08df102a2062
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 9tUz0ZBJrFUEnK7qEaGnX/iS4MtObeaROpCjniBmTWL1wxoxG6GlHKV1dtEGrPNNGeabqoWkSLQ7KNgWN78WYFg+tM9m14V9LINuLpamryTeUMjKPInAJTghtjpYWfNBv1pKpwdP95wWgbl+JArOkOhgEFLw4q5D6lrsJimgzHv/jdqfz4NjIKw2BdyJgsgrwtcRnq6Sa/zUVaVYw9ufo/RUPtDtrW4/njQdya8YYNebUT5thZbgjJMEDXHToWLZBmzRaN9dZBGuU496fn0S46wYxyIngldvPTWlGrIZLKQHIC+punusZXMPp+uxxjglxeyOKTQJlF0iloEUAflYgLWj3mM9NVFX+KHDxckTh8ZO7uNMw6q6E5WZVVfmzBmIO4v4ZGw0kw1N0sQ1bjxBf2ssQbb148XagWwmYJZGoR+M+mjobXwdRtj59kJ4MohhRJsnC2lA4NQZyuwoEtffG+3ND0mk4NwO9N4KAPS6HWNyUxLNTlO/vUt7OpLDP3oP9zwMFQ/5fjE0KXuLrwvoztusHfWeLIWR5nFN0+crwhH4VJGLUSgaXysVCBgbBEqG1yuDDoD12GEh8rQdzjy3gaY6dhy87QAA//r3CIug/AdoxU3MvINH5ZdooEj9+lky
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QWIvbS8zQXYvdjlxY0w2UnpTWTZRVi9uS3lNYWJLZ25lTkFFTnRvcGl2Q0wr?=
 =?utf-8?B?TXg4K2tmc2cvcE8wK2lHb1Q4MVhnWEpaZFFnSlZtSlBHYmxGRnFwTlRHdWFC?=
 =?utf-8?B?VnEyamtDNnozeFdqLzFWc216Rk9IL2tqNWE3K1RzYTMralA4YUlLV1NJQWFF?=
 =?utf-8?B?RkZmdkQ3ckMwdmwyL1FFZVE1QVJwQklibXJZZFU3OVV3V1daamJJRWxNcWs5?=
 =?utf-8?B?QVQ1VlNLNVdPUkVTVWNJc0dRdkliUGJ1Q2NQL3FvK005dmQwT3Exa3F4UEhW?=
 =?utf-8?B?OFBhamRmaEJFZWEzUW9uRTcvSGxwa3dPWm1iUWhHaXFPZFhYdGpLU2VRZ2Fz?=
 =?utf-8?B?V3Mrc2FyVXdCWmdZMG93dFFxZGdmZ2FDWGlnRitaNkRGaGpLVnM0cSt1TDVU?=
 =?utf-8?B?dXpmdExCRi8rZC9jWFQ2YmNuWFVOMXpHOUNRMzI2RmlNNUxLZHhLNFVRYlow?=
 =?utf-8?B?UHY4TU9PbVVZWnlZc2k2QWV0L0ZsZklJREV0b3VMS3lIUDdZaitNZ2VaRitJ?=
 =?utf-8?B?K3ZGcmo2TGlWU3dpZVV6cjEzRktCNXlrN0tjRmFodmFSVUxNME4wdnFWSW1B?=
 =?utf-8?B?b1VxZEdRcEh2MVBpMzNjMXJBeFEzdEhvMHd0U05kbzVLVEZ0MGNLN2xGMVpn?=
 =?utf-8?B?dk1tbUZ4T0h1S2xWeE1UQkE4SmZQSDhaSTJYbDFOenFaTXU5aHQ2eENVSWQx?=
 =?utf-8?B?MFVlQlZNOXhMRXBzS0RNSWZMYVVUV2kzQlJjdmUxdTNielpCVTdUSkwwbDZo?=
 =?utf-8?B?UFlGUGFaSVMxekpJRGZGb3FFUVRDMlJ5U3ByUlZjdkgvOVdJd2VHZGRMQXNR?=
 =?utf-8?B?WVF2RlJCTnRZRjFEV1ZZQTAwNjhpKzZ0OGhlaWxaREIyQ25TY3dhUnZlNkxQ?=
 =?utf-8?B?SlVnTUplSWpLN2paMjFhakc2OE1zZGVDZHgycFMyUjh4YVcxeThDZktiU1lK?=
 =?utf-8?B?ZFJnL1ROaFlzRDJBTmoreERkbXNHZDl4bDRYNXIzRTRKV2JDbU5LZDBjVUZV?=
 =?utf-8?B?aHN2SHdLbXZNV29ZWjluQlhQSEZDSkhmSlFVVVR0VnBYd20rSUM2OUFuV1BX?=
 =?utf-8?B?QlVpTldDemQzMGJYOFZXbXVRbGpBbHRna2QvWWVOR1hZRkZnOUprRDRXaVlt?=
 =?utf-8?B?WHQ3UEtoU2crOUduQkNKdUxmekVnV1d3cWRrNVpvYjBTOHVLTVJCUHlBZmJj?=
 =?utf-8?B?Tk1xcmZ0R09VUWN6b0thTXNLM1FwWVgxVnh0OWwxeWU3cGZVTWduQ1g2c2h1?=
 =?utf-8?B?RkFlUStWbW5PUi9VUTFsT3hDbTZNWVJKQkpWVnJOcWRCbW1VdDFxYnVCSUZk?=
 =?utf-8?B?ZUlUSko2czk1eU13Q1hySmZSSEplYnNZbkJFbE1SRTg3V3pDN05NQVFaMHNy?=
 =?utf-8?B?SHFzaDZNMUZwL21yejB1VnlqbDJjazJGU2I0U2tOK28yS1pQVDE3UW8rMDda?=
 =?utf-8?B?SnRoVThLUDlpME1lRmZPNWUrUzIyeWpxN1loL3BBY0F6aXJYd0I0MlBid3Ba?=
 =?utf-8?B?YlZvaWt4eFJMKzJCVnFwWVBKNmc5cW1KWmdYb1RKYytKR3VXNkQzUkxCZUMy?=
 =?utf-8?B?OVV4dWpqamdFWjFlc3ZhSGFRYzNrT1dJcXVQdEV5NzI4eVA1YUk2STFiTlVy?=
 =?utf-8?B?QkFUL3ZiVkVhRlg0Z08yRTJVUUxvS2UrL1NPdloyREhxUi9MRDNRdlJFT2xH?=
 =?utf-8?B?b3RUSGs0VG96SHZPZFZJRmVBd2RsaVpjVmxSRG5jSG1zTXNTdnM4U2pzbGt0?=
 =?utf-8?B?Q1VKUGd0M3Q0S2pva3A5eGVMQkt4L2lLclNmc1NrTVQ0STMwSnhGbi9mT0lk?=
 =?utf-8?B?Zlp0V2VEM2ZaZHlXd3M5MkZWUUpmTlR6TmU5UitIdDRkbE5wbXdoSnQwRWRY?=
 =?utf-8?B?R3VCeno4TFlCd1ZKTjM5RWNhK1dmQk1oczNhMHYwQVJ4TzQ0Q0ZBdHd3TFpC?=
 =?utf-8?B?cDhwQkptZjUwY3djblVmWUU0ajV6SWRGUEYvZXNYTTBNL3hQckFqZGdnWFRB?=
 =?utf-8?B?V0czR21ia2N2Ky9uZ2drNXpzeDhPeHlSNkNaRTdYQ1BEZ2RjVkV4SDJrZWxz?=
 =?utf-8?B?dnFKN0VwRlRyNU5ScDJ4ZzN2UllJTURLR0d1S0ppTk5DaHU1ZEhhQWxnZmt6?=
 =?utf-8?B?a01FSGpOS2pxNXZLZFdkbHJubFBJUXh1eENlL0h1cXlnMWFXZlI5SnhjVTVx?=
 =?utf-8?B?em01Q3N3Z05vSHl0UW5IYUlGY1piUm9iZTQwd2NOVnRDL2pRWUJielFPRGM1?=
 =?utf-8?B?dXh1MGdUdTFUb2tYKzNvZkdaTzRGUUxZTHQ4aDJqZUZPSlEvY3ZXYjdQYmp2?=
 =?utf-8?B?eGtiVzF5YWJjNXhnR2x4NXR1WlAxOStEUUZmK1dmNHNKZklBRmdRdz09?=
X-Exchange-RoutingPolicyChecked:
	OkT8o3wDBZCx0Ycp5pIxodphFxYk5MthqhTQLvnQPZr84DiWTO3IEJ63jLvv81tbIBzXcfDGptRTBvUQr4Ihf9BCzaTszZzrIOIzr6K77jOnulZfwYZuI+LtlkP4Cz/NMujyZ4c9rtKHZOr7V7H44nj+lXDzZ/awcaQwV7hn+P2R0F4q3FVUXk8/TQFMvpLz8WByrGggesuT5ysZe9EAFf7gNsWcmBHElYCyj9z6n12XvpVs/ES5LejbSxqTolO0ofy7+mEUgAeycaQVp0Gmr+IztzKgDh8PorYNEJvPBlYORLlznBynUd6DrI+99ftqYmuX+oTqpQrlLb1dmrdqLQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38883b45-6450-409a-7814-08df102a2062
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:28:43.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7Tx4p5PUabsjiIqTUfskIa8uKWtKywQpVyQSo5V6Evay7sraUa7kukODreEemsUAat5T0xeAWRQTOp/wUFIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfXwhBD/2Mg/5hF
 qriuL3iTFsNUcwWomZtNONLcAIiKfYV9PYifPmNnkJqNYv76p8KyuDjWzfTCY/hTR0IRAPC5CVV
 wkqWvjzFY+v7ho8IRPCpSNTn5dpHzuzvuSoK6yA7dHVHUEdzn4XZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfXxLkzc7C2Bd+f
 l64v4+RLSdMNqtyiDHcTbGeohJj1/hpBtMsvHa+AngAou0Ho//BTxKrvF3R4pyks/DEvfL/uDM/
 6p3LIGGJ67/iseQn9wurweUpICmaGMOjoaTsALadz4Aboeowd/LfqbzVI1/E2AR1zJ8wvEugun1
 TtvvpdcIl84NUvTVZtw8sXA46/wJcwThzWp+RNysSUQ7DEjfm8zPmXyWJ9bDkL4tKBZRncOxAwr
 +agWo1k9GGrp6MAmtf/6zfmeS5VLPBfp8Hh7BwsBOOZ4sz8VUBHzv6DjpzdQSghnrZS1u8taK4k
 3oEoMdTH8MAkmC3/lRPL4gYJdcF5nLzjhGaiPkJfw5M1fefmBnga9SrgYiyDztMI+6QkL51RG77
 7RJAMcgfPI3uAimYIKmGnh/vdnfQZv9+A1ASMhpMvxQ2qrxX8gO2OU3YFftv5aLvrjwURSAB7mp
 EA3RTQlpWjSUlD2rc0Q==
X-Proofpoint-GUID: JLoKg05gLc1OeBorAJaLgqVz3wUaPdOU
X-Proofpoint-ORIG-GUID: JLoKg05gLc1OeBorAJaLgqVz3wUaPdOU
X-Authority-Analysis: v=2.4 cv=HubjiETS c=1 sm=1 tr=0 ts=6aa43a4e cx=c_pps
 a=kgXPJ/cF3Xw5T7/w5pCavQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=fcaa2srF5AgiyTku_9wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

The DMA engine slave capabilities advertise the supported source and
destination bus widths through src_addr_widths / dst_addr_widths. These
are plain u32 bitmasks where a set bit's position equals the
corresponding enum dma_slave_buswidth value, e.g.
DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.

The consequence is that widths of 32 bytes and above cannot be
represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
32, 64 and 128, which do not fit in a u32. Hardware with wider data
paths is becoming common, so add a representation that can express these
widths while still using enum dma_slave_buswidth.

This series switches consumers and a small set of producers to the new
bus width capabilities, represented by a dma_buswidth_mask_t modeled
after dma_cap_mask_t. The legacy dma_device u32 fields are kept for now
so the remaining DMA controller drivers can be converted incrementally:
dma_async_device_register() folds a legacy-only producer's u32 into the
mask, so consumers only ever have to look at the mask.

The new interface lives in include/linux/dma/engine/{types,widthmask}.h
rather than in linux/dmaengine.h, so that only its users pay for the
linux/bitmap.h include. Every accessor takes a dma_buswidth_mask_t,
which means the interface will not change when the legacy fields are
eventually dropped.

Once the remaining producers are converted, the legacy dma_device
src/dst_addr_widths fields can be removed as a final cleanup.

This issue was discussed before here:

https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

Changes in v4:
- Patch 1 (new):
  - Split out of the old patch 1: move enum dma_slave_buswidth into the
    new include/linux/dma/engine/types.h, with no other change (Andy).
  - While at it, add the missing kernel-doc for the enum members, which
    kernel-doc warned about already before this series, and describe the
    UNDEFINED case (Andy).
- Patch 2:
  - Fold the bus width masks in both directions in
    dma_async_device_register(). A producer already converted only fills
    in the mask, so the legacy u32 stayed zero and the consumers not
    converted yet ended up with no bus width at all: IIO fell back to a
    width of 1 and spi-dw disabled DMA entirely. Derive the legacy u32
    from the mask so every intermediate commit of this series keeps
    working (sashiko-bot). Dropped again in the last patch.
  - widthmask.h: include linux/errno.h and group the generic linux/*.h
    includes before the subsystem ones (Andy).
  - Split declaration and assignment in __dma_bus_width_min() (Andy).
  - Group linux/dma/engine/types.h after the generic includes in
    linux/dmaengine.h (Andy).
  - Drop the include/linux/dma/engine/ MAINTAINERS entry, as
    include/linux/dma/ already matches recursively (Andy).
  - Drop bitops.h include (Andy).
- Patch 3, 4, 5, 7:
  - Fix the helper names in the commit messages, which still referred to
    the v2 interface (sashiko-bot).
- Patch 6:
  - Drop the claim about an unvalidated device tree bus width from the
    commit message, as sdw/ddw do not come from the device tree
    (Amelie).
- Patch 9:
  - Sort the new linux/dma/engine/types.h include in spi-dw.h (Andy).
- Link to v3: https://patch.msgid.link/20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com

---
Nuno Sá (10):
      dmaengine: Move enum dma_slave_buswidth to a new header
      dmaengine: Support bus widths of 32 bytes and above
      dmaengine: dma-axi-dmac: Use bus width capability helpers
      dmaengine: dw-axi-dmac: Use bus width capability helpers
      dmaengine: qcom: gpi: Use bus width capability helpers
      dmaengine: stm32-dma3: Use bus width capability helpers
      iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
      ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
      spi: dw: Use dma_slave_caps bus width helpers
      dmaengine: Drop legacy bus width fields from dma_slave_caps

 drivers/dma/dma-axi-dmac.c                         |  14 +-
 drivers/dma/dmaengine.c                            |  25 +++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  38 +++--
 drivers/dma/qcom/gpi.c                             |  12 +-
 drivers/dma/stm32/stm32-dma3.c                     |  34 +++--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  16 +-
 drivers/spi/spi-dw-dma.c                           |   8 +-
 drivers/spi/spi-dw.h                               |   3 +-
 include/linux/dma/engine/types.h                   |  55 +++++++
 include/linux/dma/engine/widthmask.h               | 166 +++++++++++++++++++++
 include/linux/dmaengine.h                          |  49 +++---
 sound/core/pcm_dmaengine.c                         |  21 ++-
 12 files changed, 357 insertions(+), 84 deletions(-)
---
base-commit: 0613e7934ee233d726af8d8c89f251a1c4df738d
change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
--

Thanks!
- Nuno Sá

