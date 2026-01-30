Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022140.outbound.protection.outlook.com [52.101.66.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0232B9A9;
	Fri, 30 Jan 2026 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764653; cv=fail; b=skuBVA/RkiyddTjDP7lGZElqqy6TUKbi0RRJEfJK8u0YTUHdHrFO7nDQ/IiK3FumpU6L/C7DGtJ3HbPDGcHE33xyT2chsh2+jCoz+Hor739jbCFMlzm27xMdm9Uz49Mc7zt13bFfVAKDvoChPcn06vh3uQJMSwYMbdNxDCzjIGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764653; c=relaxed/simple;
	bh=nWZad9bRDfAFN5+rUhPh41XhX3+44rOVXyT/izsHyxc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r9FjS+w4eZAVOrC6KpNldG0Am9kPkD5usboQsRYf7/FGMbJ3FbjyJvH8PI+eHVr5z39VttS5dklDTc3tOzmcS8rFK2/7HERZa0SoOuCvttQvNaDyPVk4/FPEL6/ysWIqZDDUJJlSu7wqT0FcfsZWeYVsKs2zm8+OEZWqG3bqBtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=yQwGr6gD; arc=fail smtp.client-ip=52.101.66.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="yQwGr6gD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Inz+F1zXM1BiSbiFrjiiCRrgHbcj9NYicBjXDaePptpxIqOAyBXNeFXzW93lE0fezwp8LuXpn2P9cbE52i03C74gsmbb8UhlI56S78xerPk9K+LojiKRHtVSJZEQqNlG34TP7Yu4FEX/FQi3cY7f7tiJ6UbKZY+7lm2eGoQL/HTTWGgUsX4QKJJsPS59Gnq++PeFVO1uaXipTKxJgnZrUFs8u+fyLri3w9BQMJPRJWo6BnQWzy3zN5dCBwazNS+1yyqXp9Be3L5qugxWFxUd3QS+CuExFhWtEG/7kyeKl8yseMBouPMTU8D7+eRxaXi+/Wwtoa4gGC1ADP8d4Msuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oizW4RZHbbDiRd1blSFokETgQJnOQi6d/UCSkzhP/As=;
 b=F79Bh2vKrFdQ1vgGvKRuCr3T48b5V+PBz1l3mkUmSSy7ZZ7w65E5iutH4ax+yV0IDu1itRqP9SXjuyxcmL+dggg83ISGsP4wJWNmnHNthyvxrPHLIspHeEwW/5dDhSM7+0DFOp5i6V7EDYrnEHAbh0GoWir6LuCkUCTTjtjyaBcURf1DftVDXSlbR56VPyTgpmt4+cF8I0rwTs6ZTGBCzTPMchsv9JJmFqe2kRQLBmFhctwL8D2/Rhybpqdy6yeS401keha4A5TXIvPhTfSitNVcKGMhsijpqE3UmtEtidIVl+hm0wZMBZwxCP/XNyNyq4J72BSk4VX/gNShfWi3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oizW4RZHbbDiRd1blSFokETgQJnOQi6d/UCSkzhP/As=;
 b=yQwGr6gDx8+0f/UKv6XCccB5ngvl+0UJZ5gb1iOazOhLtJUygYnDM2eYzRXiCBFPfj6lg1aDu+Cu77qzHbp3P2JLpduKkEN4HCwNbfRy6mqt4eZv9K9JgHRJ35OikbrTU06As4YG7HIUqtJmS/SmQUjqVDP4d3FbG4xg5rVZECL3eR8erEl7qoAMk5JvVd5qrXlFr+EmNgrSNsPD8VIEAlyoM5aeC7tQ4tm54V0uysVR1+A7EhNIRe0C4uDM0mSbVty7rM5EmITepVN7Rwtd4HjoLCiSnycHRNNeqJQKdtchaat6PWfvvbUdceyDqv2XA5/zw7FFuyqRvyMHvwdT5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM8PR06MB7361.eurprd06.prod.outlook.com (2603:10a6:20b:367::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 09:17:12 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 09:17:12 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Fri, 30 Jan 2026 09:17:01 +0000
Subject: [PATCH v5 3/4] iio: dac: adi-axi-dac: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-b4-ad9467-optional-backend-v5-3-7da803ba7326@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769764629; l=911;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=nWZad9bRDfAFN5+rUhPh41XhX3+44rOVXyT/izsHyxc=;
 b=pX+NbXCLz9Vl06U3OtqHdAUcYny9lxW2h0t/uLir9LUrNHAmK9mqd3crRNsOJf1BnhWcMcOhE
 UCrCqiiVpCjCCGbsWJg+SJ5POLX6aJ88WCFbrj/JOOUmVJd5jNBzcpc
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
X-MS-Office365-Filtering-Correlation-Id: f5977d39-9935-4139-0cdd-08de5fe059b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3NyZVVaVHR0WCt0d1dwM0tUTUdFeVo5RzQ5YUtneEppWGtBMFpyb2oxNEx0?=
 =?utf-8?B?NngwRTFhOENZZmt1a1FSNU0ydmkrR3FyaEg2WHIzQm1YQ2o1eHJHZzZsMzlm?=
 =?utf-8?B?QU85WFpDUmhZd2gxSWFIUlRWOEFJemFuRjM5bmxkVk9jMERhTks3YlFxTTFm?=
 =?utf-8?B?WDJ6MU9nS0tCWnl6T1ZhSTFHMXg3aDFtendMdGpVU2xRUlpTOVFucDVqdERQ?=
 =?utf-8?B?S0NObHNxdGJaQzhHb1FHNnFod0lodDl1dzRoREVsVmR1L3VHR0pLRDdLK1l3?=
 =?utf-8?B?YWZTczI3My83Y1NGaXdNZlk4R3ZmdmVndW1wUFQ0MURMZ0FRYld0VkhYY0tj?=
 =?utf-8?B?QmY1bTF2Y0xtUU03RzV4WUhPTUpDTzdqdk5tYXdMM0REOVRKUFM5QldkbDdX?=
 =?utf-8?B?WW5uNWthWnE1NHJ6eE11eWhLT0czMVd4YzVjRnRZVnpPWVhuV0h6bzZBUFJS?=
 =?utf-8?B?NFdhQWZIZlJsdDRSNFFSa2MvaGRQMnYyVDNud2FwOFQzOEFUR1JuYWZZaERT?=
 =?utf-8?B?MmFTVUwvQTRkM2tvVUlWeG5JZVA4VmxYTHhndHM3TnN5Ym1EeU9Hd3c1ZS9u?=
 =?utf-8?B?OFdJZ0VNZXFmKzBsZEFWUzhxcFNFcXNwRjlkeVVyazBqb21VSTRON3VlRWNJ?=
 =?utf-8?B?azg1K1k2eXpMQW0rVDFpVG8yQ2czeHRpblU3WGZFQ1F5VjVyOS9QV2RNcnox?=
 =?utf-8?B?Z3V5Tzg2TFd0TkFCNmdvTFVhK3BjanBxY2FCZ2FqWjZaTmZXWWc3QWFjVHJ5?=
 =?utf-8?B?K09NcmdVTHh4MjNyc2dBeWduem5zcm5qUFNvK1YycHU0YU0xVXl3eEhNcm1w?=
 =?utf-8?B?ZXpjL0FsUGJ0a3NBQ2t1eE9ZRHgvT3pNVnpKVTB5cnBWRDNMSG9NUy9QZnRa?=
 =?utf-8?B?c1EwRENuZCtDZ0VJTTJDem5aOWdBejhTa0xUVmJVcVJ5ZTVJZXRJQVQ1b3h1?=
 =?utf-8?B?WFZSSWozRGVIK1BBMWxyaDdMNTVMbkEwQjVhS1RxaWsvekFoMW54WXhmOHBE?=
 =?utf-8?B?anpRZE5JUUJ3Tk9YWWxHaUExY0VNVU42azFiMk9HWWs2L0NHMGNNTkRKQ01k?=
 =?utf-8?B?dDZJYnNMVEpjM25zU0UwSm03ZkViS3VoaE5QZUY0NHcxL29UUzl2V1JUeWVZ?=
 =?utf-8?B?MjluZVpTQmpGb2c2eUxETXBIclRrbTJyYkRsZThzNWxYQlF3MXBHTEhVS2Jm?=
 =?utf-8?B?ZzRSd3hkL3FpeXJ1RDNlaUZ3M2orMmRLc09PV25lczlERkN6Mk4zMDJXMkQz?=
 =?utf-8?B?aEZhTFBGK2Ywb05rUEhzQmNUS0UvOEFhZStkQ0RIdEV0UUZyVDVYVFNIM1N6?=
 =?utf-8?B?a2VMRTJLeWJ4dlZqcEhRUkhhN1RVejltSURKbjVIZlVTd1NtTUMzVGhVTUpk?=
 =?utf-8?B?NFljMVJTSE83dnRIWER0WXlKOUl6eENleTRUQnUyK0VkbmUzTXlRby9LV29V?=
 =?utf-8?B?WDVLNm1wWG5Gd2dManUvcksyek8vWmVGQkNpaFd0UE9MUmM4ZmZkSjF3NTVF?=
 =?utf-8?B?NS9ickROUWg2MW5zWXNkQ3pmbnJtMDZtSFVXZ2JVaHJDMEFFSkF0TlQ2SkxP?=
 =?utf-8?B?K09uSlU5UThBb0tKTXJoMjVoanZHRWlWNUZ6WjA1NDB6NmIvUzRGTjQvOHBk?=
 =?utf-8?B?UTQvMFFiTFBSNHlrbjQ4N0svNlZENllEVTlXNzVQbHFmNUFQdHlqYzR1MTdi?=
 =?utf-8?B?d3ZJblZGMmIzN1hMNFd4YUd6NkVwV3BsYm1HMUFMenNldnJianExM1VlOWp5?=
 =?utf-8?B?eUsrWUdDaEdna3VaWXlIcEVuWk9BS20xTC9qMExSMzQzQjU2clhNZ2srTTNy?=
 =?utf-8?B?WjRZL05SbDB6bGw5Z2gwdmFPRzdGV0pxelJPUnhnZmRWNEQwa2FmN1duaFlv?=
 =?utf-8?B?cU44aVY0TVI4eFlXdlc5S1MwWXhraDJQejgyQnJmWXptajJpRm9KZnVMWHBE?=
 =?utf-8?B?VzlwbDhsSU0rMVJza0l6VlBtMUl1NncxcTFieS9nUFpCSG5YYWJBSmxERWNv?=
 =?utf-8?B?d3c3ZlU3T3ZZQUpWUTlRbWJuNW9aOUZ3cWphN2tGN3NySUU2RHJwNTZlaExz?=
 =?utf-8?B?a28xVmlBcTArNTlCRmVFRUxBTDhXZHdTSEFWOVNTWTNSQ0NZVEgyeFlCUlNS?=
 =?utf-8?Q?S3NM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHhSREljdnlQQVJ4T0ZuYUxvOEJaZG9RNWVOK3k2N3h1N2dpYUE1M2g3VE9J?=
 =?utf-8?B?MS9RNjhqandwOUJTYy96U0xiL0lGN0d6L2s2T3U2VkUxRUlMTkVRdmpCTUpn?=
 =?utf-8?B?bTVWQmJXQWt3K2UxYXNORVNMblpmVENWUGw5TnNOOUdWbmVoWTFXVkRacWdG?=
 =?utf-8?B?aWd1VitrSjc3YjhpN05XRmw3Uk5zT001WlBRaklmZ0tlODQ3dzRZOGxqcDlZ?=
 =?utf-8?B?d05FaW42amhUdnF5Q1FiWDNVVmFBZDNlYWx1NFdhQnkzdDExdnFBamV6ODVL?=
 =?utf-8?B?RDdUeUIzN0NyRCs5SE5BRDRvZ1NIODJvd1hpSjE3QXZxNTRwdW5KeUorQ2E0?=
 =?utf-8?B?Nm5qWlkza0lua00zaHgwSkMxWHpyME8yRGhFNThmeHY3WWxyYXd1NzlaaVpz?=
 =?utf-8?B?eHc1T1lteXl3ajQ2K2ZCVVhxMXFGRDdFSG1vejlleFkzckZ1WmhwOFJCVVVT?=
 =?utf-8?B?NDY0aFM4SXhrSUFpaHBnRzdkVCt4OStPOGs0ck9NaUpMVDA5VU8wK0puVUJs?=
 =?utf-8?B?QVZ5cnM4MTI2MHlOZHgwRW52QUxjeUFEQkw4SURnT1Y2OHhXdkRoOGtCM1Zo?=
 =?utf-8?B?MG1MWmpiUlJhU3lHdFJTKzExSlJHdytNM3FUWVRNa0lveTQrdk5yd1I5L1RU?=
 =?utf-8?B?eU9ud3kzYlhuZ2cvdUNQL05PQzRySlV2b2pQcjlKKzB1SW1KUXlCSWtMczQ3?=
 =?utf-8?B?Skt0UjhwNi9teFU0OTBJbzJjYUp2MjFudG9xbVNpaTRXTExtdENyWEVWODda?=
 =?utf-8?B?Nkt1MmtjSEVZcGFVS1hZc1RnMmNGQlRuOXpVdFlUMWRycC9iSnVPM2NTWFZv?=
 =?utf-8?B?R2NYMXp4VFpyTXIwM1NkT2Zjcm9rdGRKRWpJZVhJVXExMHVrZ2JvWHIrTEU0?=
 =?utf-8?B?VTRNU3JXZEZ3LzRNZThBVlhIRC9GZjVTN0lZK2ZqUUtxMU9GaVo3NTJjMjdZ?=
 =?utf-8?B?S29XYnpnMGZSNXF1S2x5cmNLOXhWQm56MDR0aDFKNXVZK3F5TnRsRXR2eDBx?=
 =?utf-8?B?QmUxbGQxVTdQYTRYRUt6NldESTZ3aTZOclU1cWVhRGRwem9Mem5SZFZzNk5n?=
 =?utf-8?B?R1dGUGV1TXFvVUMrV3p5SWR2SC9Hd3paN3UzUm9kTmpXZ0k3VXQwVDBRQ2ZN?=
 =?utf-8?B?bENCS3ROT3N6bit6WTV0UjljVEt3U2FNSDBpNGdORUpNTHAyN3JObFJvWjZO?=
 =?utf-8?B?TVdHSkdBMWhsVEtTdlJ0NG5VaU5RYmY1L3RqZTNKZ09NR2dlODVqUGRNNUZ5?=
 =?utf-8?B?ZXJsdkIyMUczN1UydElQYUt2Mk13NWdhZWh6ak1weXYxT1NLUElTQ3RHQ29s?=
 =?utf-8?B?RjEvREYycitxUWUvSTg1MHMzNkZtcWZodStOY2l5SmZPMG45dUxqV1NLdHR4?=
 =?utf-8?B?UTBNaVorSG5QaFlxRVRQeUFOTU9lZCtPOE12ZXh0N29mL294aHNaZkZ5c0wz?=
 =?utf-8?B?SjlicnpsUisyNFdMZy9jdWFZN3dZdkVWU0Q2bytXNnBYaFJSTG1ZVjJNZFhV?=
 =?utf-8?B?U2ZQZU02QWp3ampJQmJsYVc4KzlDZlVkU0dVcC93d2tKK0JJQlZqRkNENmxP?=
 =?utf-8?B?SFdHLzNkclZiRW5Zbk4vRjVBbGRGZ3dFRzI2dnl2SnZLeFMva1hhQWRCN2hF?=
 =?utf-8?B?ZjVqMDhrYjZSaStMTk91aXloeW5aajZvR3E3cWY3YjhIUFNFY3VmNFBMZzJh?=
 =?utf-8?B?UEdlMlNHdG0rbUhvR21RRWdLcHRzWHJUUWE1OFRIRjBsOWZVMTNlTCs0ZXZt?=
 =?utf-8?B?SXpKVlNMb2FjT0Q5dnhOcmtIdnFweFQwZWZoV1ZDeEgrNjZFa25RampqSzBj?=
 =?utf-8?B?aEtsSUM1Y2RTa3RPR0ZWeTlRQi91Rnc0dGxwTWwrelRlV0w0Z0tpNGhXL1Jn?=
 =?utf-8?B?ckhIMXFsck9KKzhHYVpzT2lHd1ZPRWcwdWw4OVIrVHZrb3lQSzlERDhsL1Ax?=
 =?utf-8?B?UXBjc1NCa3F6d0FTT2RQN09BMW4rS2dmRVZiY0c5clpXazBCcU1LQk9MU1Rv?=
 =?utf-8?B?L2xQZU54MkNWOHprVHJRVTZwaFhkcFpkZTN2L2lBMjhJNFIvc0Z6dXBOcXZj?=
 =?utf-8?B?YWVPSG0rZzlwVWR0dHNBMW1uMm9jMzd0dmFmNmdGcWRYcjJYZlFQd2xBQ3Fh?=
 =?utf-8?B?ZHFSRXlnYnF1dDJUOVdLaDVSdjQxTE9kb2tKT0srUkVnSHdJQ1lDWnZTcGRp?=
 =?utf-8?B?KzMvbjVIdWxjQ3Y2RnB3eVRaZHcwUUFaT1FRNk02Y3ovdXRpWW5ZVXR3MTZz?=
 =?utf-8?B?OU5JODdUZHBjOUo1YTNwMDFMbzlkaWJZVXZtNXlEaHBJZytoNXdjVGI3aXZj?=
 =?utf-8?B?OFpyM0t0K1kyZyszcXZmdFhaTE9iODRBRXM1bG00azlXdndZWUNYS3psaHRs?=
 =?utf-8?Q?J2porHJAMHsJh01U=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5977d39-9935-4139-0cdd-08de5fe059b7
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 09:17:11.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyHViXchLDMxk+6qP8X6SOVQmYpyCHlVnIdZrJEjC0UUUQD4sPEloFeQqMO2mf2FGrI4El2ZfR6BfLdxaGeH/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7361

Backends support buffering capability so advertise it while registering
in case a frontend makes checks for it.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0d525272a8a8..cd06cd4587af 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -869,11 +869,13 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 static const struct iio_backend_info axi_dac_generic = {
 	.name = "axi-dac",
 	.ops = &axi_dac_generic_ops,
+	.caps = IIO_BACKEND_CAP_BUFFERING,
 };
 
 static const struct iio_backend_info axi_ad3552r = {
 	.name = "axi-ad3552r",
 	.ops = &axi_ad3552r_ops,
+	.caps = IIO_BACKEND_CAP_BUFFERING,
 };
 
 static const struct regmap_config axi_dac_regmap_config = {

-- 
2.47.3

