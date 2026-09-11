Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596434A99B2;
	Fri, 11 Sep 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147770; cv=fail; b=YkVUHacKTT0E+NmbNs8zm1d6oqCmAPZfpYxPIr6Qy+45rzTYyxfGCchNRuvQVeaZhD6VMdT5pRMy29X1JXF45WfJQti/G+sXaY1/x628zhnLJ/FHlnPPTuhsvj1Ci4REBkuoCdCtKTlBF7adn8oj/cNDd8blr5IhUOVLnXdc7ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147770; c=relaxed/simple;
	bh=zv64eKL1Q8aK1uNb7IYkfNoWr00BXiSe+gM/IYT7sIE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XtauiR7pU5VG4KK1w6MkyFIOIA1RwLNzz6hxOR0Fa6wUBEvnopV1sp2yzXbnBgWPKbIoCmHzWIFgUuApcPUznMz9Pi3ctdHZUTRm5vrZvZ6RBd5oupNQc756ti+peaMETHg7w8vhBTtRLO8SMCwYW3vP/UPOOxKC4awkN5GlDGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lR4FQ419; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lR4FQ419"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEjAnx1800239;
	Fri, 11 Sep 2026 13:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=U2arv
	UyAXYFJPJRNcJ3/mRN+xH+HW+GFR7PoE4IYr28=; b=lR4FQ419rm55oNoMa/h5k
	ajcox1M8yxO74WRri1qTD44ooDjN8/aCpYhR165sP44OBnxggvFRPCqsa9uMw4d7
	NtrAGkSFWs3hXC982yoU8jlD4+rBFWeC4zuMRuyeOZIrHamTpQ8E8xq/xWttjxKL
	gc73Em1Whv8KcqG1OGY/azHLRgrvYBdfdR0jwgyCpfdIXEAiEC1ZWRU1EY9s2Yd/
	8ouq/QhgAFjNG29l1ms++2LzWKEB3zJnDky6tPx78nJeHkaLqhgOEp613wF9nasa
	0GM++hYD3VGPHs6qNXEge1AfeADdFDBaLzWfuf8dF7+1M7NbAJmZFy8Sdgq3B6Ok
	A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxcj45r-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:28:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS1+kdNnXLaNxM8EUUi5T34yRVsWjY7X4LVhkB3BXWuZNtDN8RFRwjuEe0W17jjY2XxJpVaOWBfIrYyHx1t4jygNAAPEW2gkfEGMCHgyDPNTBe3Kl1uQjD2QqVKwKxA8leBV9ZpLXfqLBWCY6KjHrZKyfQAhxRqqx6wThET07jPGH3d9KMXrZ4mT4xOboVj1aPqPEr1nK+V0pI5j8usgiZegQAdVri3XPXX/GjWxIQ3qD0GWc5+CZ8v9FWh/oKbzTRqno2yo51idpzZ8SK0K77LdqLIvY9DUbfqZKXCp7V4hW2m97qaj+vvb/cIB9ZEMwKBz4ooLATqlOiigf77zOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2arvUyAXYFJPJRNcJ3/mRN+xH+HW+GFR7PoE4IYr28=;
 b=CGJx5bQx4X5egqnPibTVpvOPtcwaduD5jtwLpBrdvEJyczPXtxMh5ruJgSgSfzXm0hzmxrGlQuDGJsgPf+JraaP2lrlFdELfHyQzws561asNov36H17u7EtusvyOkpfrgNWANlDtAx2aPqatv95V9ujak9jGZmT+KA79y/5t6KWa0LaK2NHd/iTHMqXHseJTFNXSoF43ZwEDXzp05ip2EQMpaZOYa+ERjuUEs01fLlsfZU3qkyP8WTddakVx+3OUP3okIu4Jrh+7FbhisdxVdJ76jX8e8pd4eybthrBTx/ZPdaMBYxPB2iwIg2sLPwcn3GTzoUG054kK987N/AyPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:28:50 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:28:50 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:37 +0100
Subject: [PATCH v4 02/10] dmaengine: Support bus widths of 32 bytes and
 above
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-2-72b8fd4cc78e@analog.com>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
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
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=15088;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zv64eKL1Q8aK1uNb7IYkfNoWr00BXiSe+gM/IYT7sIE=;
 b=rrplM+TXr6wl5K/11wE/GOkvLmOnm7ZkS6yqJnsrAVR2X895L+eLQeThlAzk8eNz/XLK7AalJ
 y4xInjZ3d19AnSCBSeAfRpWr8zwm0o/x6Q7yWji7dsw+oR8MYfULSSY
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0007.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 270ec2e7-db17-4456-a1d3-08df102a24f1
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|3023799007|10067099003|5023799004|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 aBhfEgavlLkXi9eqzCO1htIRbSC3qHyBh+8IYvwLbYg983HXvQokIMo5dGhv8j3vSUmC8ZepkE6mhCj0RBdSoGdLA/PnfcXINsz3DSxhxFjK/mhny5wUSxE1ssHgJL0nRo2ZFlFewrsp7njC/gqIjVvOyoN6J7Ip/zMeFAecSpAGJIusRlriTgHf/scjl37pvHliiEfDX1bpsMjRJRkA09+pm77i/MmG10LpXGJEa230q6HmnMXQp4Rp5T0YD14GrH5HtGfdRoM0cl6tCXOuLIb0/U/Id77fBmI9kB295QlTcjPnmPI0EfZCR4Ii6v0wTbP2HP20mPYBo5Lh0ncPE3yPAVGrVHJVB8oxFxyUJyfWqftMo0PAynjwVjDtM1b+edei/KgGXl+TrftLVSOVh3hpSyNz9W362PIpQf4R1Pht6K29iWi8A07QgeUBvFmbWpGT/KdOxnrXx2jW3Lh0b2zP80+kybKz9etJQF+CNNnBoWW5v4rMPF8vqK9qWlsDo3vz01HfcYov0jx4EE+E30Q6KvYKnvtAPLYbXW0pG7nGudPqkdQNg04BHXcQZmci+pfcudH4H3xIGUU5EPGOYMhScBGwVzojDbpF+Pxba7dHvJWJz7sb7a+GxggD9LMuPv92EpeSYM1C1sVmMaXfKk485wi9ISFPPadjYLqgQ1o=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YnRtdU9LSzZYZ1pJeGZmc1V1Tm1Md2Q5RTNsVExOcGRjNFNTcWRwV292M1lS?=
 =?utf-8?B?VEFHM2pteStITVgxOUEwbmJpWk81bUptckJsQ1dnUElXb2ZmS1RPVFpxRW4r?=
 =?utf-8?B?blllamhEZzlhQ0tmU050TVJxcElGV1M2SG1hYVVudWhOU2pnb1A0c0NLSzMr?=
 =?utf-8?B?MlMycDZyVFVNQVBSYmRCYTMyY3JtR0ppUE9sRUpWSDZaekJaVEMvOGxTRDVi?=
 =?utf-8?B?NWZJa3dURTZTQkdUVllKUm1FUk1WdHpRZDYzR0UvRERobzIyWEFSKzBoUW1u?=
 =?utf-8?B?eEFnUnlLUEcrQlZOQlpmV1M1QjQ5ZXl2YWxzOFphYjBZWmxpMDJPNnd1WVJG?=
 =?utf-8?B?U28yYnRCVlNFRTVIVFhIN2grU2JkdHdmVTlMTXM2clgwMUN0MFZWQnhkVmYw?=
 =?utf-8?B?cUhOWGdBZHdiOFp4WTFmNXhMbC92SEtoeEwxaEsrRGpnY1lLVVdpR0hjZkNZ?=
 =?utf-8?B?QWc4RTBkd09LMEdWVVFLWWpNazdIdjMyTWE2cEtBckFldURGZ3BhSGhWV2Jh?=
 =?utf-8?B?cmo5bDBPYzVaa2Z1bW0wWFNidThJWEI2cDJTT05YbnRMclhmcUd6YlEyeEMr?=
 =?utf-8?B?eUk0blU0bGZENEU1WXRha2hlc292UmJXSnk3S2NzYWdGc2tnbFlMWDR6aUh1?=
 =?utf-8?B?Mk1YZGhiKzJYeUxDY2QyeWF0NzVNcG9wbktQWmljaWZNdHR5L1hZOWxQckY4?=
 =?utf-8?B?TE1lSFdSQTZIamJOSnRsd2preUQ1bjJhK3kvcVFpbHZYWkRrbi9mUHZLUDFE?=
 =?utf-8?B?OHJQU25MNHdjYjJ3djlOMlNsUEFvdUR1VDVtOWl1WW0wSDlsQ0tOVUlCMWJ6?=
 =?utf-8?B?TThodkc5T3ZDSEdVNDNJL1hnL0EydUo1eWZrZ3ZFZjBKbmJoSXZjM0p3ekxP?=
 =?utf-8?B?U09ReGFPcHM1ZGUzQ1I2WWk5ZUxvUU9WNWVYcDZBMUEwRHRpeUdIOTFnbWxp?=
 =?utf-8?B?a1BlbHNnejZ2cHRSOFNWZDV0d1R3U0p4aHkwdVplc0FlNFVQZmk3TmZuTzhH?=
 =?utf-8?B?eGEzeEJMeVhiOG9HeGdaVTkzN1BaaURrUlFZSnd5R1JmUkQ2cW5SUlhEZnNP?=
 =?utf-8?B?MnNLZmFHbkZjekxnWkthblZudSs1NzIwMmxmYlIyeHprOE1GNTNlMXhjQWlN?=
 =?utf-8?B?MGkxa1ZYSUJ2Ly9GUEFMRlNkbmNFRCtVamlxd1RMVHh4YlA4UWM0MGZwZkFv?=
 =?utf-8?B?bEZCcnJVb2lTUFY3TzVrY3NNQWs4WFoza1JLeDlMVjU5SnZXU0VrQVVrcmF2?=
 =?utf-8?B?SVk1VzNvN2F2cnp2MmNidlNRZWVTTEZpcDlOWWV2QUdzVjFOamhqL1VVWU5O?=
 =?utf-8?B?eEcvRit2QWFUTjRyN29Zc1FpRUlVMWVoTStPZ0pkeWtoampvc0ZpTlJVUThU?=
 =?utf-8?B?VTBXcng0NTM2aFBhMVRGcjErVExXcjVHb0hNaDBuY2k0bElndGZIR1Zrd3do?=
 =?utf-8?B?YXBRSktTUGV3RFE5ZlArVGNjbWFyVVdVWSsyblVqR0dCdXUrMWp0VlBhQXBn?=
 =?utf-8?B?TXQ0VUdJSnFMakRNVW9LZS91ODE3eG50aWt6bHMvMFpybGV5YkVSWUErT0pj?=
 =?utf-8?B?WUdUK1VkQUVWT0w0cWcyaDdPR2J0aXpTd3kxeFdWUUNYeWY5Mi9oT0RteHhY?=
 =?utf-8?B?cytXbWI1b25xTDVHNzkrN1Y4OTVsNmR3N0xQTEZVV1FGZnZyOUlHSCtRT3ZB?=
 =?utf-8?B?SUNOaWdjZnNzUlEyUmFtelJwazNxa0hOZzRxRWhJQ1pkSlh5Nm9nVjc3Z3hU?=
 =?utf-8?B?bGVCRHd4cm80K24rdCtZOUlxV1I2WjhNSzQyRXlmOUxGTzZlRlRmSTVIWG5P?=
 =?utf-8?B?SG54SFQ5SmlvMGI5MmJHS3pyRlR1aXQvQTFKdDN2SjFWY1NoSHpQYUZRSzNF?=
 =?utf-8?B?YmNLU1JSMDZ2ZzNPaUk3aWs4QUlINmg4TFR0VU1ySVYrRmRSVW9oQnlvZjJ2?=
 =?utf-8?B?VW1NQzgrNzVra29DaDg4TFVXUnJYc1VXUzU5eG4xZWRVMFAwdzg3VUlkSVlj?=
 =?utf-8?B?V3FUcGplNDFkSU1XRHhNRzdLQ3ltSkwvMFFtbFFiQUJnQXJYM0owOC9JMDJh?=
 =?utf-8?B?Vys4dGVXWmhWNU1rT1kyUVJuLytucU5EbTllMC9TUjN4Tklad0lmTkhSNGtr?=
 =?utf-8?B?Vm00MlI0R1BLdW9FOHVSMzRrbmxLckJpNEI3WVhJVVRwY1VNajM3aEszZjB5?=
 =?utf-8?B?RUUwT1VNeGlWSGJXVkJmcmJQdnQ3QUh2NC8zNXlWVHhkZjQ2VDFIWGs2Uy8w?=
 =?utf-8?B?QjJYVzRTVWkwQ2NZNWtXUjFGWVdUMkJlbm1pSUhIRXJBWXFmbHY4aFNaN1NT?=
 =?utf-8?B?UGpUUldONnpVeVBIUHFEY2lnS3Juc2NaYlV2RmE2ZTl1QXQzT0d0dz09?=
X-Exchange-RoutingPolicyChecked:
	ZUllCaxxb7ac3CeWDZCv/1oIpPFC4h/tCX+JxUUlwvfaBQ9W6mM1DpvaL0KlPeovei7dJVZI+u7U3WKqPbhAEtfU2DI7LFM3FcwKPsaLOVUmGUEDZsF9aCkyHRZHmVE6SO+l59STILHcBbQKxnRL8UHt4xXdY2gv4xXzLK9BFjMdye3uW+LV31mMCOYHH0i6sVotd76zQsRwCId2+Wfepe1eOYtytXYKEpldlB8gsJNtz7h1EKu2KbjdSfAEv2ZOKZo+UdSVM/dBn42kQoKyAhP0g0lg9yDL4BYfAJoMIepwieuPe42xWeFlOb+e39kbqrHKRYcybDKGqxXmq7LQnA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270ec2e7-db17-4456-a1d3-08df102a24f1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:28:50.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqGIWd6WPRGkzDJM2BpTdt5sCMSu6MyJJV66qZTpQnOZLsowgCXXTq7OLlW40SCv0a98f7X7ls9tMHh5icX95w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027
X-Authority-Analysis: v=2.4 cv=PZFqFShd c=1 sm=1 tr=0 ts=6aa43a56 cx=c_pps
 a=z9epfWMNo9LgPPq3nTJR4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=zqpTpWyWpzdCgpraOQ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CinYij4p_jZrwrsc6RUiR-W4vIh5j0GV
X-Proofpoint-ORIG-GUID: CinYij4p_jZrwrsc6RUiR-W4vIh5j0GV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX8ENn9rTEs7u8
 x4OB8bwn3sQ8zaYNgYgFtNg+amqxZeLuS6mKVk1aVgsb/gYVylG52ZGMX9CwOEkTgggs3blqoIu
 VcWHjOgexOKS5Epkr0N6AeM96P/vW8ZXO8Ru73eVaPMqRCEFZK5Y/v/Pwo3FDCa1fWdausUEbX1
 ZgaiLOTmjTcVey/rnG7OJVo/tktaS0M/OsQSYUQdQ2/C8H2xWHcdi9eV/DsxfwhpakXqD2kq1o7
 wwDxXFcmDg7L4zN77RDb58aVlfbVvvGa63xgrdnt8QIXwU4bLJuA6x1GLP2igYoSWgqq83xLvxD
 6BgTiv3bhrc2sWBXLh8Xv80986Zf92U12WsPCz349jETh6OGTg6/zlKNU3egJAXoxBjfxo/1wT0
 I5qz8nTRL2sD/+ekDex883u0yUFBO0gSYnQ1RDsPK9cT8CqDyWoQTkbch8124EbevQDnqt2kAXl
 E9fYVrFeKoAvwSrxGMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX0GUy5MLnfvgn
 YGoIunXxm3GVJvgXXR19h7pp1PHo12wUSCHiNUUMIeDe3Hj3ETTWRjzygHloE2fvLaDF1LlSFGt
 Epw1Q1JOa18KchoAfNCv03hGRgmE8roD/4cSUP/gFE08Z2pXzAAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

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

The accessors live in a new include/linux/dma/engine/widthmask.h instead
of in linux/dmaengine.h, so that only their users pay for the
linux/bitmap.h include. They all take a dma_buswidth_mask_t, which means
the interface will not change once the legacy fields are dropped.

The fold is bidirectional while both representations coexist. A driver
that only fills in the legacy u32 gets its mask derived from it, so the
consumers already converted see it. A driver that only fills in the mask
gets its legacy u32 derived from the mask, so the consumers not
converted yet, which read the legacy dma_slave_caps fields, keep working.

On top of that, dma_get_slave_caps() derives the legacy dma_slave_caps
masks from the new ones when a device_caps() callback adjusted them, so
that a converted controller narrowing its per-channel capabilities is
still seen by the consumers not converted yet, while a driver adjusting
the legacy masks directly keeps working.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c              |  52 ++++++++++-
 include/linux/dma/engine/types.h     |  14 +++
 include/linux/dma/engine/widthmask.h | 166 +++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h            |  38 +++++---
 4 files changed, 257 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6ffd8bd82154..8e68921cf01d 100644
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
@@ -1170,6 +1197,27 @@ void dma_async_device_channel_unregister(struct dma_device *device,
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
+		bitmap_from_arr32(device->src_bus_widths.bits, &device->src_addr_widths, 32);
+	/* consumers not converted yet still read the legacy caps */
+	else if (!device->src_addr_widths)
+		device->src_addr_widths = bitmap_read(device->src_bus_widths.bits, 0, 32);
+
+	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
+		bitmap_from_arr32(device->dst_bus_widths.bits, &device->dst_addr_widths, 32);
+	else if (!device->dst_addr_widths)
+		device->dst_addr_widths = bitmap_read(device->dst_bus_widths.bits, 0, 32);
+}
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device:	pointer to &struct dma_device
@@ -1231,6 +1279,8 @@ int dma_async_device_register(struct dma_device *device)
 		dev_dbg(device->dev,
 			 "WARN: Device release is not defined so it is not safe to unbind this driver while in use\n");
 
+	dma_device_fold_legacy_bus_widths(device);
+
 	kref_init(&device->ref);
 
 	/* note: this only matters in the
diff --git a/include/linux/dma/engine/types.h b/include/linux/dma/engine/types.h
index 2e8a266e42ef..41c8771f9c0d 100644
--- a/include/linux/dma/engine/types.h
+++ b/include/linux/dma/engine/types.h
@@ -24,6 +24,7 @@
  * @DMA_SLAVE_BUSWIDTH_32_BYTES: 32 bytes wide bus
  * @DMA_SLAVE_BUSWIDTH_64_BYTES: 64 bytes wide bus
  * @DMA_SLAVE_BUSWIDTH_128_BYTES: 128 bytes wide bus
+ * @DMA_SLAVE_BUSWIDTH_MAX: number of bus widths, not a valid width
  */
 enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
@@ -36,6 +37,19 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
 	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
 	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
+	DMA_SLAVE_BUSWIDTH_MAX
 };
 
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
 #endif /* LINUX_DMA_ENGINE_TYPES_H */
diff --git a/include/linux/dma/engine/widthmask.h b/include/linux/dma/engine/widthmask.h
new file mode 100644
index 000000000000..eb50fc2f81cc
--- /dev/null
+++ b/include/linux/dma/engine/widthmask.h
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Bus width capabilities of DMA engine devices and channels.
+ */
+#ifndef LINUX_DMA_ENGINE_WIDTHMASK_H
+#define LINUX_DMA_ENGINE_WIDTHMASK_H
+
+#include <linux/bitmap.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <linux/dma/engine/types.h>
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
+	enum dma_slave_buswidth width;
+
+	width = find_first_bit(mask->bits, DMA_SLAVE_BUSWIDTH_MAX);
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
index 573e5ea34707..8236a1b274fb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -5,6 +5,7 @@
 #ifndef LINUX_DMAENGINE_H
 #define LINUX_DMAENGINE_H
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/uio.h>
@@ -481,10 +482,11 @@ enum dma_residue_granularity {
 
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
@@ -503,8 +505,14 @@ enum dma_residue_granularity {
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
@@ -797,10 +805,10 @@ struct dma_filter {
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
@@ -882,8 +890,14 @@ struct dma_device {
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

