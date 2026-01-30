Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022140.outbound.protection.outlook.com [52.101.66.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4670244665;
	Fri, 30 Jan 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764640; cv=fail; b=ZNzpYArY2jAT32DGjh5MQyo3kQsZTquf5MH9dTM7MIlcGHQ3wJ7vP7h6vk1Uno74FwCxcOyO1WobU4IlccX9/I8bqf5u1mZsKHMJEKdOhizwDKk5xUTN4vVfyvhHFIVAYzcKl79uD7uQBGsSYwacdMVZUos1bNMl4nPWltZxPf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764640; c=relaxed/simple;
	bh=SPkN7H3a9ZHTAE0q7IcH9nWpwP97HAx65XLcHquk/CM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gQrmO/tcHqfduKstgjviL4O0FN20pHlwMV1vngooBoJUK0g5d21HOGPmozcShxjQ04qppcABm2KDZzAxNn3MLQhBcqbK6uHznUL78DEU+XyFks044kxi6uTaaTsqO1n+YmPiDAupwoCvaU5dhh3esIy4PWJ8bC26XoGf+e3EOpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=MPPTVkTv; arc=fail smtp.client-ip=52.101.66.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="MPPTVkTv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5cTI9vNRLKuTQ37piya81Bl8wYdaL63L+CO1r0xBmdTPhQVkAzC4yiWuIlf1PePxhul1EFxDSbW1iHoeS9xz8pPqsewOWrTRunQQKqcXN+yoP6ud4ukQBx9OQ6ACsdkzxaJisiKqijF4zm+NW4QvYzLZxv+3fu+FgEs3yGHKGGVQzbZOgSOL/H0Fqf7nJHuhgMAaVyhez2lozJhZdNpWYHE+g3LuqzbOzKrEOBSQp67phPM7ipIFBWBXJhYNhRdhEEW/IPRjRi/C2howtnKB8EI2whWfcM425Ja1Wo8UFmimZeNyvS3lxjJkZHRUxrMybJbn2g7cyVjP/TIHU590A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19D6br8c+RE7F3IfLWPhBuYiYO9nEAysr93AFg34610=;
 b=hg7kmJMrVMxId/Ytq5Wvtm2yErWi6mV3CoVec1prVcHQs70GowUmwlfXrW2avQ78ZH1kYfkHffH+a058LmBeq0Mb/8uQHviuvQT5XE65ka17h3m5lJVpRwNySMmdHK6WaV7JEGccj2Ar2NP2JhzapAJziEGPjasX8gBHbxfLZUBOgVCr5FoApN/Zv0KD9oDI3kYBQziWBlR7F59GxMSwkvLioX+z4ljAl5aOfCLagrln03we9fxtDXvdBPytptmGlmOv1Y5TN2M3NoXwXU0MIKGC6EzRfs9g1FQPYKkhWOOZ6zUfITyUBUzB/RAPoG2f/1uiCpgs7vWCAQcmRxkvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19D6br8c+RE7F3IfLWPhBuYiYO9nEAysr93AFg34610=;
 b=MPPTVkTvlMzH/Mrv5BpWMf6SKPcBwyViJnFiL5NniYUV/Orbvax0XLEUYbRsDq3NfadJOuMTj6NTxrnRO8ljGSanVvvH3tYN3i/frSu10/OVzR4BwEb98/tF29SsnPOVLVZ44d0NxsOOUfII06hyVh57cEJSi+vp+Tfj94c1Lx284yYkBFYw/sfm7xuah2BKcut43VvAUiYiD8rQv7MGuKPk4nmZnZT7Mw2vjHxirM+8NOIwKGkMeo74ULvlyGOi1wZn9OhrwhC7JYJEsByZACbstlgNTpdsOJKfmEMrjM3prMyravAkKmjDwIzUhYJ7EqrTZRE4ZMW8X0bdDNIm1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM8PR06MB7361.eurprd06.prod.outlook.com (2603:10a6:20b:367::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 09:17:10 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 09:17:10 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Fri, 30 Jan 2026 09:16:59 +0000
Subject: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
In-Reply-To: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-91501
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769764629; l=4230;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=SPkN7H3a9ZHTAE0q7IcH9nWpwP97HAx65XLcHquk/CM=;
 b=XB8OpUkc5YEwhUjSXaeelTDslkBtM40Tth/opy77DyUn4nCJyZ7izOof6Y3hl923xUQi5Dl7Y
 KltDfIVLZmWCePt/UMAHQ3E+U3Fjo7YEdmBS3XglnZGJ/osdZebWkxW
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF000167F6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::667) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AM8PR06MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: d99a4993-34ee-423c-1d97-08de5fe058fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVc2emxjU01oNkpqMUNCS01mbkRaZ0JXQmdKV1JnUnpuNUlrYU0yZEN6MHZj?=
 =?utf-8?B?TG1MejdSeEdRemdacTNrZTVSeDFSOXJOVzlHaGNIODk5SCtFb212Qy93Z2g3?=
 =?utf-8?B?MFM4bEV0OTdqM01CUzZVVUk4UHlKN0tCU0xOL05iS1g3dXpXTGgyUE14UFJt?=
 =?utf-8?B?TFZqdUNrNEJKVXdMd2l2RHRmVGJEOXVYcU9TUFlOK1dDbnVSTDJPbGJTYTl2?=
 =?utf-8?B?YmJiWDhtbkRFOTNwc2VMSkloVmxOeHFhb0ZXRFBsSDYvZWszYjhBSW1JL0FC?=
 =?utf-8?B?anFlV21sMGw1cFRoZkpibDhEVVJsMUoxcWpqa05rVTJoNHRFNTZmM2ViRzd2?=
 =?utf-8?B?TzM0Wm5FYzNyUk9uTWUvb2F3UHM2dDU0ek5pTVBvQ3lQajN0c0R5Qzk1MFdL?=
 =?utf-8?B?SDBnN0IwV2tOMlNjbjRnRUpQaHVjZ01JUUhZMUUxbkFyTks0ZXJ3ZzRaUzNJ?=
 =?utf-8?B?YnZpM1RjeXRCVmpTYmlxK2V3UkhhanJQNVRnMUdMcUZCOERmSVN6anVhZUp5?=
 =?utf-8?B?YmdiU3RFSXN3dFpXbWZZdmQyOHlJbE93WVpmd0IrTG9IZURDcnBRR0tRL2ph?=
 =?utf-8?B?TVdmdTQ5eXUvQzB4c09lQkthWEM3RzNyK2RQeFNJdzRiSDZucituWTZtaDJF?=
 =?utf-8?B?ZmJtSVhwV29SY1F0MUpZUXducFpqV3dsYUZyODdCR0ZWZ2NSVXFSQjd3RndV?=
 =?utf-8?B?RnJZZkZ2K3BPVEptQXBHL0xXK3pWTlhmYkpkY3N3TXgrZWtQMDlVZUVuQ3pE?=
 =?utf-8?B?cW1jeHZEeENEUStlVGdlNklDMFFhaWhCeXZEdW9USDJ6N0hYS0JaYi9HRnVY?=
 =?utf-8?B?R0VJcVFmUmVYUTRwNHpUb1lWYkxKRTIzUnB4MUtkUDRTdmxYcFVlUVRKQXlp?=
 =?utf-8?B?aXJGbXoxeEI3TUtuRU12QXhlU3MwY1JMRnRBa3VuVnhQbzFSeEFmcktINHlU?=
 =?utf-8?B?a245eTc1UnE4RDlKV2FJRVkra251VXhTMWRqeWJTMWdURisvUTZ1SC9CL1Rm?=
 =?utf-8?B?eEIxeVFYcUp2dDhvMitOSWFuMkQzRGNrOXAxMUM0VVFLVmFSNEdicnBuN05U?=
 =?utf-8?B?WlRUdlJCZUVvbVIraXpFVUlWYWpLM0h5RDdtb1RnUVJYclhkMnhRT1hkUG1x?=
 =?utf-8?B?NjBRamdnMmhGbFZISDFZYzNUTXJQcWtlNTl3UjhRRm5IVHRYdytlM0J3dlBu?=
 =?utf-8?B?cXhXSlBTMVBjelRPeXhORnhqdkZOeEwwRUVjR25aeFR5RmNOOUdVUnB2QThF?=
 =?utf-8?B?L0h3OTMzbjBxdE9wQzMzRGlxYlN2Z1E4dkdsRlE4MnZwQisxS1RueWlSdk5u?=
 =?utf-8?B?czhnNjFmclkxb21HclBoNnFBKzhHVzM0ajRtM0FOVG81NHljQlhVUU1UT25n?=
 =?utf-8?B?dzMrOUgyMXNyS3JtTk0ydWEzekVkcktrN29xblcwelB2NUhpTDVaYXJzMnpa?=
 =?utf-8?B?RnlpWTNidmRwcXNtQ0Ywc1V2MVdqN2R2UDJWL3YyY01iSUpMUWVMbVdQZFNP?=
 =?utf-8?B?TUp5NTRsZVNEQU5uSktCeS9PWldFK2pUSkpINUUzcDJmVElYY3ZYQmo2RTdY?=
 =?utf-8?B?VkZVR21GakNtUEVONDhFcHJTM3FPcFZsTlVSQVpNekZmbmwyVUJIaWdzM3ZP?=
 =?utf-8?B?dTd1Qlc0WFV3YzZwWDN2VFpkV3RZbTBaMTZwNGZkZ3Y5MmZqcGpmZ3ZrOXdK?=
 =?utf-8?B?NEFYaDRES2tSamFONlVubGEwc1ZDK0tkQUhCdFlLQ1h6WCt0bDNyRUFSdjFm?=
 =?utf-8?B?bUFqWnNVRGQyMnRWVzZibFdvVXQ3YUo2Y2tlaWZYSE1ETzJXUEdHQzR4Q20w?=
 =?utf-8?B?MmlEZGNPQmYxUFNpNTFtTkF5aStlamwvdGtrY2lQcGFuSjBYL09XdnRNclZn?=
 =?utf-8?B?SFVTK2NzajkzRUw3MUF6S2NqRjdldk1YMW5IWEl2OVBLdkdMcDhqd21vRkVk?=
 =?utf-8?B?Ym50VTB6V29QcGR5bXJOTWxEL3JBRFBOVVlZaFZzdytKeE0wWDI5SVdLYUc2?=
 =?utf-8?B?ZG5wUFlmSExPZG80b3lNUnVpMXlwQW5aU3NyZmtqcDVscW05Sk9IVUhUTExr?=
 =?utf-8?B?UzJSM3pxTnRtY240WHpnVG1wdlhoWURjczQ5TmcyUW0rM3N0VlpTRCsyQVB2?=
 =?utf-8?Q?/VqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmNrZkxESmlUV2RMcTFqSDhIVGp3TWtheUJuN1k5bGI2K2h4NmtIY1FJNTFG?=
 =?utf-8?B?L2hDMmd3RDlHMXdkMEhPWFVSanhOdS94VE83QStGSlhNTDBDaDZ4YVA3WVFZ?=
 =?utf-8?B?NHNlSFZESXVuTllwTEtaaXRRcmVXbjRVb3IxUHhoL3AyV2JncVFPTFVWTENw?=
 =?utf-8?B?WWJnSjk3VTY2S0E4K05EcFpDaW8zemNQL1l1emphdjlFMjEwYThQUUF6L0hw?=
 =?utf-8?B?SUUvUFlwcGpraUVMQlVXT3dHdjN5dy9RUHBNc0lMZGF0MHRTSHVyRVMrZjJS?=
 =?utf-8?B?WDdmM05LZDg3aHRCVWdzSWVaaFA4VjNUZWtVVHB1ajU4N2J3NkhaN3pJYmQx?=
 =?utf-8?B?eG9JUDBlZXdMSC85MkQrZm13SnM2UW92S0FSeWNPc0I0Z2R2eDhXd3Z1cjFE?=
 =?utf-8?B?MUxJYmJndFJad0dtQVBDTWlQNXhQTGYzYUJMOURkMTZJM3U5VStBdmE2clVw?=
 =?utf-8?B?bnBKemlLRkJxNys3OWJNZFNGZytES3pHaVJsS0N3RUpTekU5T3hLT2psdWo0?=
 =?utf-8?B?aW03TlhuVGh5SldrSDRsci9OYUZSTFlrYmdETU9BMFc2UTlIc2g3K3FIWU1G?=
 =?utf-8?B?aHY3RUMrWFQ1MTJVM292OXlKWGcyUy9uQmpHMmduZndVcll0em9YdXlzS29I?=
 =?utf-8?B?djdFUlVvVURjMS9GaHZMRmlNemlTR3BuYjhoZE42djBXRnovYnFtTk0yQk9P?=
 =?utf-8?B?dzU3dTBpOGpxME43dVhNL1pVK1RUSXI5SE1XNCttZ0RGY0xxRnBYZ21mc01M?=
 =?utf-8?B?M2RZOXpnQTB6dlRubFNEMmJQREZMaGgvaUlVU05hcXgxTGtJVzN2aDZlWEd0?=
 =?utf-8?B?bGpxOGdDLytuSlVtOFB3TzM4ZGdWdjJXcFJ3Q25lOGdlRUlTRDlHelZ5RVdr?=
 =?utf-8?B?V3pPQ0RHdk8zdklPeXhicmducSswWTA3MUdkZVE2cFdRRkxyMitPL1VSM0tG?=
 =?utf-8?B?a1BRNlBUQlRIZmhiQTdvNVNUT1Z6SFYzc0Ird095NDdSZHRIdCt0RlliMTIw?=
 =?utf-8?B?aDdYcDBqT3lKcVpLMHl2MGJYakxLY3J5M0l3NlV6ZVlnOVVtYmFZNXZjUjZQ?=
 =?utf-8?B?Mk1mTkpCRys3TVV1WDQzR2FrVmVER004Q2hHc0ZWWlBsdlRoaDkzdGQ2bWZZ?=
 =?utf-8?B?WWgraFFuSTZqYlVNaHpLMXNKdzlqTW55MHBoVHFwVGpCbkFlZy9xNTdsL1ZR?=
 =?utf-8?B?aW1xSmhuTUE0RWFkR1BrUGpiUCtONEZXYTlrLzg2T1I1SU4rZ0ZQbVl5WWxM?=
 =?utf-8?B?VjhWamptbUZVTWxiakMxQXd6dWxqblFZT0FUZEUzeHpFUnJqa2pCM25IOFBP?=
 =?utf-8?B?Rk04ZjNidTVLR0xiNTY2RWVRY2lKbXkxUVVJeGFLVjgwMnBjaThnakEyRE1H?=
 =?utf-8?B?ZnUyOEZIRHJwZGw1NHA2U01YV0w5Z2F3UzVsQWYxaTNkN3JTaDFXSmJYSTZD?=
 =?utf-8?B?aDVIU1lKK1VpVkt2ejkrTW9QUENkOVo3ZWhQVC83SmhWaGJOUktra1I3Njkx?=
 =?utf-8?B?TW1jWGttd2w1WDJ6Qko3RFZqYmZJM3J6bk9kTkVwdTNwMUgwSWpRNVpkNUp6?=
 =?utf-8?B?SjliVFVYRTJVSDlqSFcwN3VQTFVvTnlpUUdwKzM5bFJVMlA2SmxkTU5UazZO?=
 =?utf-8?B?ZlhhL3MrYlZqdFZITS9qR3JYSmx0amI4QkpMdmh4N094am1sQ20vekYvdHdW?=
 =?utf-8?B?RUpFczlFdnEwWlhUeXR4b0FVdEFGbExVVFZEMUxqZ1ZUNTB1aHBGZzg3cE9y?=
 =?utf-8?B?NDJ5ckluSFNCdkUxbjA4Vit2OG8rMFArUFZyeVdnYkx2OTNJaVpTLzFhOS9s?=
 =?utf-8?B?a2JjL0lXU2dUTEtsYWhLRTNPMitXOXY0dTYycHNPZmU2c2xYV2hSUFBrTkk4?=
 =?utf-8?B?NHZsTWorSHZjc2k3d2pUc2QvTVYyYTF3cFhRa0o1UlpUMEJ6bnpQMlF1TXJQ?=
 =?utf-8?B?dSsrYnVvSDZpNzgvYTRKU04wQ0d1QmJpdTVSSUZOM3ZORHFSL1VFc2dleVhj?=
 =?utf-8?B?SklpVnFSL0NCbFB0SnE5OGlGSnl4YWVDM0pzLzZXc3RvL2UyZzhscjRkY2FK?=
 =?utf-8?B?ZnovelB4UUJpQzJyZWVtd0N2cDhNeGt6VitBYThXZnk1bGVWYTRtNUp2Tlpl?=
 =?utf-8?B?NGl5VDJ4MG5YUHNHOXU1VVNqNHNkS3ZsUGsrNEd0Smd1WTFlNFZTTXNSYmpS?=
 =?utf-8?B?czFrb3ZtQmE5V0NmdGpUS2FNY3piSFJvREZrckg2bnZoZUhZajdqS1docmp2?=
 =?utf-8?B?VzZsNjFNZFdIdjRNRVpTYVdpY1NhT0hLWGlzbFhOWnNZYTlKMnBGbHV5TE9S?=
 =?utf-8?B?bXRkU1FMK0xrQm9WR3p0RDdLT2t2NExkbW5QQ2ZkTGdSeU96cXhZR0dicWt0?=
 =?utf-8?Q?Kd7LtARh65XiC0JY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99a4993-34ee-423c-1d97-08de5fe058fd
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 09:17:10.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57QHnWUn3UvSqnuZl5SLhYY6Axt8tTrGpfnibklslgiqDLfTDcKHmK9xyFxxb3m8jYgRmqz/g2UX6FFdVSDBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7361

Not all backends support the full set of capabilities provided by the
industrialio-backend framework. Capability bits can be used in frontends
and backends for checking for a certain feature set, or if using
related functions can be expected to fail.

Capability bits should be set by a compatible backend and provided when
registering the backend.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/industrialio-backend.c | 16 ++++++++++++++++
 include/linux/iio/backend.h        | 25 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
index 7f815f3fed6a..ac80abb71bbc 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -84,6 +84,28 @@ enum iio_backend_filter_type {
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
+ * @IIO_BACKEND_CAP_BUFFERING: Backend supports buffering.
+ * @IIO_BACKEND_CAP_ALWAYS_ON: Backend does not need to be explicitly
+ * enabled/disabled. It is always on.
+ */
+enum iio_backend_capabilities {
+	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
+	IIO_BACKEND_CAP_BUFFERING = BIT(1),
+	IIO_BACKEND_CAP_ALWAYS_ON = BIT(2),
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -179,10 +201,12 @@ struct iio_backend_ops {
  * struct iio_backend_info - info structure for an iio_backend
  * @name: Backend name.
  * @ops: Backend operations.
+ * @caps: Backend capabilities. @see iio_backend_capabilities
  */
 struct iio_backend_info {
 	const char *name;
 	const struct iio_backend_ops *ops;
+	u32 caps;
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -235,6 +259,7 @@ int iio_backend_read_raw(struct iio_backend *back,
 			 long mask);
 int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
+bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,

-- 
2.47.3

