Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021136.outbound.protection.outlook.com [52.101.65.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E143090FF;
	Tue, 10 Feb 2026 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720848; cv=fail; b=eHljReZntI9Q6MTTl1D+vLCn3BrXITCp7WHFlT8eXEbwIqOK7NmtV1xhEAwc1ntFIEQJ2pcaq1zHPn5Phs1ytygx/nX1jdoq6TQzM4VLvP5vilb41lpTecAwNyOkDTvX+12GjLCsNAOeLW2Hw4INqLV5XobNCAJ2T0gl4LAgPJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720848; c=relaxed/simple;
	bh=Y6svenMBwQGbZujRu/l+fDU1LwVcq0MSj+RC3Lc+n/c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tUuBs+SEaW3LMZpjYyAuwlWA5eC5O9+OwttqyUowDuzkVIlWZUSnlgVYcEZvjWralHiudg6Rh81Cu3GIA+q7FmO1YcKqturwipTR0NpPTk1Upr/PfMkrwt95FWXFLNTpQuZL1WhsUxZguq63UpEhKRWFxsC1pL7VYJcVFitHikg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=v7Lv1dfW; arc=fail smtp.client-ip=52.101.65.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="v7Lv1dfW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgIuaVM5dI9z+bldEWT1xJyjWq2qwn51JuzUGxf8qKFNfDZ+MifBeVxugsUG7W4nVw5CKnE7dL9AYOU8yBXioockBa2/1IDCow4xL3hp8yBxpS8qWuZwcXmSXxAk5dTdoHXt5voojS9tW/A/WngqfHQDHPDkMaPFKpHKgnPSlIt3jfMUe6gPhMbNf3nQFCC8Tdxn88epyvDPG2OK8UAmQ7weLVSAsnr/+Fy+Kw7ir3RKlk+MBlp4QOKoWqd5lHAgMOpKykx6hPyRwqQdCh5h904uyOsk57OYjYSP/5v3+oai+FWHn6M0C+r9YpjS7FJDPZjXzemzUY3Td7sbTSGiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxb0lPMzjyBzrjrsKjQ09LiykOUzBigyTO+KhG7PvNc=;
 b=K1weLUyZerVXTQsnzR5MwlRkZMeANB5K8St73vLJGvNwXRjN0ZoCcLNxB+cERAwIA2jK9lkLODUk1ItZ4uYx7t35Fe4svI4cMixkE5Dq/SGxPW/U3cGTBfT/FIpF8sWc+S8RlC1Q5giT1aeTGzxakq4xGSG62xFe5XMs0aYE11TwlXLdbSwIlKpQFTLqqV5nVpl55StE3S1tCf0wyUoVVetVv5j9AqKgY022PBU6rwp0RCsY1BgrAIlt7fwvVdcIzFWGB+p/Hs45oLqUmtLkFRLxyKfj2f3RP2Vyr4y5ljhNtsMwdjCq1aIIZ4Pvr12yhlKrm1t12Guo9qIzTugdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxb0lPMzjyBzrjrsKjQ09LiykOUzBigyTO+KhG7PvNc=;
 b=v7Lv1dfW5xamXLUaVpHuGLEw7B3nHpvgqtDSObGUn+CTYQexeT9VzJIM3Y2vGHHHScz0G80DQmlooR5RObMzZHPrgChEkBzB61toxXVqK15/YfHKrPCFV/7PMqJKaUejvqAZqSznY12D1Tq5YRuvi7xeqZn9n6pbgdMB8TOOISupARJ2mQxibvUi/kvoAFfHKgtuD5NVaYdVSGg0yhvCVwl6F2wlqk4YvrE5UnUreh6WK42VxGjgKl991w9nE58pHDYplsOy0kh2ee8rjYqYSdKVoQQl02CHdqOIjvG4TieSHzfnVZrvVv1cwDQ4Dmc+p2gfzSDjAwC2i/ze/wHylg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10) by DU4PR06MB10173.eurprd06.prod.outlook.com
 (2603:10a6:10:621::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 10:53:59 +0000
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee]) by VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:53:59 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 10 Feb 2026 10:53:34 +0000
Subject: [PATCH v7 1/6] iio: industrialio-backend: support backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260210-b4-ad9467-optional-backend-v7-1-7a590ffe02df@vaisala.com>
References: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
In-Reply-To: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770720837; l=4298;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=Y6svenMBwQGbZujRu/l+fDU1LwVcq0MSj+RC3Lc+n/c=;
 b=LerhAYrP+4aHN26gc+IE9wOy5osrlMCP6f7LeZZZE+62DR+KVeTy9Tw97BpPT8cXYCzUkEM+j
 CkWZqJGlgUgAYcm4fuuBOsVc0zS34QNDUIS2mu4E1iKo3P5rHjgpWBc
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR06MB10639:EE_|DU4PR06MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d715a3-57f2-43ac-8bd2-08de6892b1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUlUUzYvWXljR3N1RmdYSDlsUEdlZVgwTTBJS2E0QzlOMmtyd1Fab3JCUGZY?=
 =?utf-8?B?cDhwSFNQMGNTb1I0cW1TbStWRmpDMDh1NFVDcVAvOVFjZnl6ckNlNGtnNktt?=
 =?utf-8?B?dFdyWVFEcEM2eU44NEdsRi9FYmM3QlkwY0pxY1NHOG5RakgzWDJHQkVYSVNK?=
 =?utf-8?B?T1VJS21uQ1R6UGM2NWloZFN4YUdYMCtaRjJUelRmbCtiMmFtemEweVZLT3dU?=
 =?utf-8?B?VEQydVl2L1NOT0YwQTdLZnNMRVNVWURMZ2dhUHVPenVJbFlQb2p5TllvU3JP?=
 =?utf-8?B?Um82TWhWWWFuQ3orUVNlNGVvOSsvcWpTY00ybENtZXVWUjUzc2FiNWQzUm9U?=
 =?utf-8?B?UHExVWFLN1U2OWhnRWFYNy9IYkM5RHcwM25RZ08xSHJmS3dTVHpDUnVMVjFT?=
 =?utf-8?B?SmxhMlZKWkt5emdLSGl6NmNlNStzNy9HdDFDRURzVHBnY0VQYnFvV2o2aDRR?=
 =?utf-8?B?a1pVWXAwc3F5K3p2UVJLTXViR1IyeXE5TWtOQXJ4WTNiZTJhRy9KRFlySER3?=
 =?utf-8?B?MjE0WXZzYmk1eGxxZVljNGZMdlFkSk9HVzFKeGNocjFkWGZFam15Q3ZaTC9L?=
 =?utf-8?B?dUdRdHllL25HcERscjlsdzZZL25qZHdzRWp5MFdoZmFGVHlVREl2c2NMZmox?=
 =?utf-8?B?YUJYcVVRNmljOGFGMUcwaDBzM0lUZlR0TU9XMzliSmNQbXNrTGtrVVdaaHNj?=
 =?utf-8?B?WXpPNjdsRUpPUExUQkRPUURnOFRwOEhIeHNrWStTNngrYVN6bWRXaWtOSHJP?=
 =?utf-8?B?TzF2UEFxNWJxSlZiWENjSmlsTnlvdkhhOGF3SE5xN2taZUxDWG9sRUVyRC9J?=
 =?utf-8?B?c1NCWXBHQ1BLSVg1L2prQnVvSFlhQlBDa1pwTVMzekVXV3JUbUxiUi94OUlx?=
 =?utf-8?B?bnlnWituOEtTLzgvYXdTaEx6V0dDL2gzanhJbmNyVDE1L0tBQkU3Y0RPYk1Y?=
 =?utf-8?B?YkR3eWVOeFZsQ0dVU01XMjI5TUpQcko1VzNtcUJWYktjNHdEKzN0T2VGMlNw?=
 =?utf-8?B?NGVmUmdFblBtKzdUSDNNUGloOEVNRzl6bThuREJXWldJM1Fiamdta0FiYUN3?=
 =?utf-8?B?UmN0b2xSODR5RVllNXRYMzc0Z3dqN28rMjluN01Oa2RFTjdsMytxeVJnWmdE?=
 =?utf-8?B?MnJLZnNocE1PMHE2TjROSTF0NEs4WVh0Y0MyRXc3bGkzT3NZblFJUVhRbkx5?=
 =?utf-8?B?cW5OR0ppNDlsL2tGeVhsYjc1OGc0bldRVVZmZkx3MGdOS3pSRFNjY2VBTXJk?=
 =?utf-8?B?Y3BqS2VwcUJyK2NzOTNmZGhOMitzZE1aTHo0b1B3V0lmQWFjWFI1NmhTRVU5?=
 =?utf-8?B?dnVjS0NqUHgycjBsN25CdjRhdXVlK3BTb2hZcmpGem5BU3ZyMlVWN1N5Wmdi?=
 =?utf-8?B?UUlKc0cxK1NkeDJEcys4bFl1SmJmQTY3RElqTGlJaE1DMG8yeDVtbVE3VkJk?=
 =?utf-8?B?WnRJcVBSUlQ3VnVqOWlHU1cvcXZkWnp6OEJHRWtBWnBFK3cvZkR3QU1IdXcv?=
 =?utf-8?B?anhnTnBpQmYxRU9YWW04T0xLSVgxQjYvRThIVE9GYmtaRGxzdFlwbjAxQU5S?=
 =?utf-8?B?MmQ3RnZCWGpNV3FqazJLNVVyOEpZTkJIK2oyVnc1K2dzQlIvU284T1kxQkJl?=
 =?utf-8?B?dXJLZkliWmN1Y01vbTlVMThRN2J5VGYvUThoSjF0VDQ2YmtYNDQ1TXlQWi9M?=
 =?utf-8?B?NGhMYmJYZ1NkZlB0TUpYQUNtVnQ5M09iU0FLOTNQQi91Q3B6QzlKVjczVmlU?=
 =?utf-8?B?U1BBNmdtSjdqbEN0YmpRSGNmZGJ2ZVlXdXVIYTVaMjhyL3U4MjEvZWpTOVZ2?=
 =?utf-8?B?NDhQQ2NVTXg2dUNTOXZzTDFNTy9kUWhFZ1hrTi9TMVBBMVJuUGlFUFZKdHlh?=
 =?utf-8?B?NGtxTWZtVVNNM1FpWjFleE5ldGZyMTZoSHVCTW9qTkxWbGk1ejJBWEtPSFl2?=
 =?utf-8?B?cU9IV2IxeUZuZGxkZXdSeCtnaFVCLzVkWldkU2w5YlpZNXprc2o0RzBaVWdK?=
 =?utf-8?B?b05aWG1mODNkMko2V2k0Vk5McDhwSm1pbjFQWVQ4T1V1UVNRek9USVV2QXVJ?=
 =?utf-8?B?ODd0a2hoTlcxc3BVRm5Dc2xGeG9nVk5EUzd2S1R4bi9pWVRiLytMSGpmT3Q1?=
 =?utf-8?Q?ZhUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR06MB10639.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHZlTXdmUDF3QjlmQlRyeldQSGtEMlJRZG1Ta3kvUnR2eE9JUUN4a3pWajl0?=
 =?utf-8?B?bVJQZGkzajh0NG83N1BtSWo3eGtvenpsYnlPaE9iY3JFTmRibTlhQklLbG1R?=
 =?utf-8?B?Q3hHQlhNVmtBYU43a1RTa3NrZ2kyWW9zbnZ6Wk5nQnNTcVluZFArTE1hbDg1?=
 =?utf-8?B?SzlNY1Bvb3pPaHZvckcxRlE5SlY1SFJDYjlKSms5NkMyMnl5dC9pWFNNOU9h?=
 =?utf-8?B?QStzV0pqU3BzM3ZhMHpZM21USDZzYVl1K1VnVzVUNUN2S0M4T1A5MmJET2lL?=
 =?utf-8?B?dS9Fbm9nNmVROTdvS1pZdkdJaEtqTEhGaE1VOGl3ZldvLzQ2VGMvajlPdHAr?=
 =?utf-8?B?dFFoREYvT1hFcDJDY01sZlIyd2JocTB6ZkdjZkdEVm9GTGVwb3YrQXVCQWxB?=
 =?utf-8?B?M1c3Tzhlb3I1c3BMbmZYTTZlcDRRbk1QK3l4RFMzM3haSkR5TkhaUXBDSngv?=
 =?utf-8?B?cFdJbUhXQlROQ3B4TG4yUGNyVm83RWVkNmVDQ25PcGJTU1VlK21XZDd6V1Ur?=
 =?utf-8?B?Y2NVMEd2Um5tVWFlZFRka2NoVjl5aHlTR2VMMjcyZGpqUnNEWEswU2Y3MzdE?=
 =?utf-8?B?Uktia1E4WDIwalJYaUQ1a2JHYS9wOGFLZldhTnVuSzRBL2RWS3Y4ajZPTXhD?=
 =?utf-8?B?SUg4U3JZM3p5WDMvZmdRejA5Y213V1NJSUdrbFYxQm95WnpsNmxnSU9pS1l4?=
 =?utf-8?B?RW55bXJMbnVMOXBpS1pGZzRLWE9SQVRQcmxQRUcxd2kwUHp2UUpsNTVqaVV4?=
 =?utf-8?B?WDJ6TlJWdlZxNGQ0QTZ4ZEs0VHpLNmEyaG5oRlN0dnM3U0R3dG5rdkhTellx?=
 =?utf-8?B?S0dTb3dXaU0yMi80SDFtRUVPNzlzTllEMDNkUkl0TnRvOFhzZ2dtM2tsM2sr?=
 =?utf-8?B?elhwZUpMa0hYVW83eG80Z0VVbnpmZll3eGZuYjh5VGF0U2xPdUtDQWE1T1Q4?=
 =?utf-8?B?TFVQbHozRDRwbEs0K1JnVmZvV3ZIcER6blJac1Y3OUY0MTNPWVVJY1ZwSjh3?=
 =?utf-8?B?Y3Faa2FFM0MzRlhHbDRHSWRlVXBXTGJEVHdBeWlxbjFHNThZa3lmZVJmWld5?=
 =?utf-8?B?R05oa1o4M1dQazVLT1MxRXhGQUxOQjZaNFNtZm1RdmM1YU8vME5sV013enky?=
 =?utf-8?B?eTlFZFNTcHJXM3dGMEQzaVRld3YvaUU5SkMweHlhRzdWRWFiVHdLQlRaMUJt?=
 =?utf-8?B?Y3ovRFVYTVZBZS9UQS83YWlMaWV3bmxRc1lucThzUXFmRFVkNTlOV25JZmdJ?=
 =?utf-8?B?ZVo0SGlVNW9EWVR2S1hZRkIvWnp1NXREZGR5SGcrMzI2ZkV3TG1uQTZ4eFJL?=
 =?utf-8?B?SWV4eHRKdVhmVXZoSnJNWFNtUjBUS1p6NHo1VkU1WU55cmk0OHora0hiLzdW?=
 =?utf-8?B?TmhsOGdDd2p3S1lGeGFjalEvZXRXUEpEYXJTWGR3K2RQcFFyTnZQbWg2NGpO?=
 =?utf-8?B?czlHcVR0RHZ2dnEycWE2UFpwNFFZVXM1MnU2eWl3K29zSWJYU1dMUEhqdk5k?=
 =?utf-8?B?MTVGNU9WYjNZVk1oa21hL3kwM3JYLzRaVThNSkE0ZW9JRXVRY3lsNjF1Y21k?=
 =?utf-8?B?QXJPd2I3eW5NOUFsZHIwaHJVenhKMVRLS0NMVi9pbnBvZmM1NE82eTh2S1FZ?=
 =?utf-8?B?cnlVVm5YWnVCaWlHZk80ZVZZbklMN1R2eEc4NXQ3MkN3OVN4UGlZRFlEUk1G?=
 =?utf-8?B?MGw3L0VwV1dMbkU0WGZzeHZXS0JCdlJVeUxiQ2RBOTJ1Ri9ybWY0M3JDZkQy?=
 =?utf-8?B?RGEvYlIyNTRhaEJEaXlXVlZvMWFwaWk2em9RZHljYlVUMDg1Ti9jSXFzZkJL?=
 =?utf-8?B?ZFdaWUV2MGxoMk50ZnRIcFNXekVSL3h3SEEyVFp0WTVWVTJjVHA2OGV1YVJy?=
 =?utf-8?B?MnVEOVFIMldoZTlCd1hycHNBeWJ1bmc4TXNIUjVoVzFTdXA4d2o5WjBmUzJS?=
 =?utf-8?B?K082aHpFNmZLRmd1NEcyOCsxeU9CMFRZWTM1M2VkaWgvdzg5TWNvTkNHWWNt?=
 =?utf-8?B?Yng1MllpZnlBU1JPWjBBdGsyMHNpU3lGSGplUDhPL29yWjNDVHpPOGJhMmFh?=
 =?utf-8?B?Z3dveTFEUWZEbFhsOWZYZ3AvVE43TXNiZStQU29zdDFNbWQ1SStwNXR0eGJQ?=
 =?utf-8?B?NTVZcFN2TFRhZjhoNHRkaC92Q2VDaFlxZHR2cVA1ZkFXMVFnL0VtbEpPR2Ew?=
 =?utf-8?B?MnhoREtLbXg2T29vY3Z1Z3JIbEVsRVVZWVdQempmVVhCd2xLdUlkSklsb0NR?=
 =?utf-8?B?czYvdnBtUzBZeUZ6Ykh6QXlvNTE1dG82OFVoQW5ELzVWZkZlNHZCM3ZNNDVJ?=
 =?utf-8?B?MWV6QjRxZTNwVGJFVmRsU0FqUll3WGw2ay9rNktCV3dTMzkrTEJiQUkzc04w?=
 =?utf-8?Q?DUY4BG7xVsnwLYPk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d715a3-57f2-43ac-8bd2-08de6892b1ee
X-MS-Exchange-CrossTenant-AuthSource: VI0PR06MB10639.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:53:59.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/wxkrCmQfLNMvp32595z0b8/RVyzWuJIffE/xn/UzepitvWcq0Du6teQoUB8TlKUCrelquzLI0jdN9S9yNbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10173

Not all backends support the full set of capabilities provided by the
industrialio-backend framework. Capability bits can be used in frontends
and backends for checking for a certain feature set, or if using
related functions can be expected to fail.

Capability bits should be set by a compatible backend and provided when
registering the backend.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/industrialio-backend.c | 16 ++++++++++++++++
 include/linux/iio/backend.h        | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 447b694d6d5f..1afd00763da9 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -56,6 +56,7 @@ struct iio_backend {
 	void *priv;
 	const char *name;
 	unsigned int cached_reg_addr;
+	u32 caps;
 	/*
 	 * This index is relative to the frontend. Meaning that for
 	 * frontends with multiple backends, this will be the index of this
@@ -774,6 +775,20 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
 
+/**
+ * iio_backend_has_caps - Check if backend has specific capabilities
+ * @back: Backend device
+ * @caps: Capabilities to check
+ *
+ * RETURNS:
+ * True if backend has all the requested capabilities, false otherwise.
+ */
+bool iio_backend_has_caps(struct iio_backend *back, u32 caps)
+{
+	return (back->caps & caps) == caps;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_has_caps, "IIO_BACKEND");
+
 static void iio_backend_release(void *arg)
 {
 	struct iio_backend *back = arg;
@@ -1114,6 +1129,7 @@ int devm_iio_backend_register(struct device *dev,
 
 	back->ops = info->ops;
 	back->name = info->name;
+	back->caps = info->caps;
 	back->owner = dev->driver->owner;
 	back->dev = dev;
 	back->priv = priv;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 7f815f3fed6a..4d15c2a9802c 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -84,6 +84,27 @@ enum iio_backend_filter_type {
 	IIO_BACKEND_FILTER_TYPE_MAX
 };
 
+/**
+ * enum iio_backend_capabilities - Backend capabilities
+ * Backend capabilities can be used by frontends to check if a given
+ * functionality is supported by the backend. This is useful for frontend
+ * devices which are expected to work with alternative backend
+ * implementations. Capabilities are loosely coupled with operations,
+ * meaning that a capability requires certain operations to be implemented
+ * by the backend. A capability might be mapped to a single operation or
+ * multiple operations.
+ *
+ * @IIO_BACKEND_CAP_CALIBRATION: Backend supports digital interface
+ * calibration. Calibration procedure is device specific.
+ * @IIO_BACKEND_CAP_BUFFER: Support for IIO buffer interface.
+ * @IIO_BACKEND_CAP_ENABLE: Backend can be explicitly enabled/disabled.
+ */
+enum iio_backend_capabilities {
+	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
+	IIO_BACKEND_CAP_BUFFER = BIT(1),
+	IIO_BACKEND_CAP_ENABLE = BIT(2),
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -179,10 +200,12 @@ struct iio_backend_ops {
  * struct iio_backend_info - info structure for an iio_backend
  * @name: Backend name.
  * @ops: Backend operations.
+ * @caps: Backend capabilities. (bitmask of enum iio_backend_capabilities).
  */
 struct iio_backend_info {
 	const char *name;
 	const struct iio_backend_ops *ops;
+	u32 caps;
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -235,6 +258,7 @@ int iio_backend_read_raw(struct iio_backend *back,
 			 long mask);
 int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
+bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,

-- 
2.47.3

