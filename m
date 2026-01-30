Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022140.outbound.protection.outlook.com [52.101.66.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412F32142B;
	Fri, 30 Jan 2026 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764645; cv=fail; b=Ca+4IcBEsUgRbr6SYYEIAZDfW/xPJQTgPnaXh3FOdOV9V8THyFkrUvBmfDw9IwvuxAQGnLKBrnzMOElmSO7L+sd880yOBm99zY8jSmC8TDCqJO3JcQXxs5JvreMUPDVO6q6Ib4e8uYaptJvF1EfUTRC2d1qDY800crlhLBumujY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764645; c=relaxed/simple;
	bh=YrLbUQGpIin/WbOqZKHSVbNtsdIr1APE4cWdvfVhopg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=SXJjDtsZbjfB1Hs0ZxltigKAgF/g5ctoSHxKc9Fse/uASLVNvYNhIki0Qu/Pg92B3Fi6EWN8+CMLHU2P+JzY54e/KzpxOhNVwO7mFxz/xOYoKehwXuAxMtlXo7KSmrWwo00IKTtGqrZki78yVfeXyzFI0X5MLT2WlAnjJRLnaPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=EdqaOxtQ; arc=fail smtp.client-ip=52.101.66.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="EdqaOxtQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swyJi4NGH5Wut8gSYY0l16kRr85XozVf2jbrOP9Bhx8soCEzbQr7GuybC+3KqU5i2hbR9qAuG8uCKDR9vfU1mtWDn79b7kLLrKpDFO9W8B0tN1cZ7bD/5u9nQpnnyuC32fE/JNk3gecX3RkkecSnd6Zm5BM31inF2+z8Xi7A+Hvryh5uWkLhlKvMFR6rlTbszhJ5sqnse87bp5smM+Tfp+STcEZ2/TiKNiSEybFIfZWzsptgzYOzqXpN7YKnnSZJWgYFNHmSsLQzKTC5h0SIl5FUtHiG1lHzExpyDhODWHq8QLVlKWaUz3IgFMuLak1L7r4Cc1I5aWO2eCoVRVcRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY7xc+UEIhAqccFY75c69KZWlVVzOcqfG/1qEOvl8Jo=;
 b=iKjDCsgH9loVhz1RDpvo/Zc5rkFu0DhcwuKeoNWCUNZfj13U9Ok0GbqHX9LdxaZmMWkDs/pHHNG5FuCzHT06t+5PEP0fgNMu9+UT7ofkNd6mcKWTe0ScCyMz5IS0lP1S823/CJk4Iy5+30r3VXkrBR/5ZJgFSHaexbbSN1TbVzzMi7ZAUCNY4wi+OKpXZgfCbG0VAGyaNizWJ2OjHOfake7fPZBHzbs5XtatvPZq+4E97MWjh3BxKGSHH56/zTv8p3TMjMGc7dcxI8KFTuzjILvtMa13OAG2yFswYdyvxcls5jx6K//jc4SAP+8qauKqmrcnvzRxCTa+YTcsRJ6x1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY7xc+UEIhAqccFY75c69KZWlVVzOcqfG/1qEOvl8Jo=;
 b=EdqaOxtQYitHykI2LvPA/mEoKdyyWBRQM1+y2vXxYFtHPQJXFENLdKLq8tqbTDlisZnT/TL3CYvA7d8ndfn/s6PsGi6a6LzsGR+U4TWHg5fAP48lY9BzWEOD0JrVFdbmTuZ1t2Ve2KVTRz+ZFovzZe7C/hzvlstvncjWX7QwRc7ckZTkTX5X3faImPifXXeZrsGdk26mLhPr0Z98FOkM2wPbGkq+HQqD0o/lCSVVqHbon484OQ7wDytQghFXnqwoPO18hcltiPn+/IFrVefAvsFa8Awvq6uWkUTMy6j4PPDjdk3VDeWm6PqcGwuPziCbN3uMDEpIOFRrway5uDZZbA==
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
 09:17:09 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v5 0/4] iio: adc: ad9467: Support alternative backends
Date: Fri, 30 Jan 2026 09:16:58 +0000
Message-Id: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAp3fGkC/33NwYoCMQyA4VeRnq00aToz9bTvsXiobWYtqzMyl
 eIi8+4bBUERhpz+EL7cVOEpc1Hb1U1NXHPJ4yDh1isVD2H4YZ2TtEKDDhCc3pMOyVPT6vF8keN
 w1PsQf3lIGm0PxntmSq0S4Dxxn68P/HsnfcjlMk5/j18V7tsn2yyxFbTRneUGnAXuKX3VkEs4h
 k0cT+oOV3xijQGwixgKZgK2LIM9wSdmXzFaxKxgCWNHvvXJgPnE6AVDWMRIMOiEM4mcifEdm+f
 5HwEw6AytAQAA
X-Change-ID: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-91501
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769764629; l=3069;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=YrLbUQGpIin/WbOqZKHSVbNtsdIr1APE4cWdvfVhopg=;
 b=F+1aqEPdnothqc/R50RdczNEAekkSADOweAar/+Kz+WLKPStbdbIn0xxysfInqQlEvZ9hWG/c
 ESpVxq5h9/bDfWoeZFDsVhVsU86oboF070Re7Jv25U/kXD+9e8DLL+g
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
X-MS-Office365-Filtering-Correlation-Id: 5e31f1b1-f659-4c35-417a-08de5fe058a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2YrWTZqZ1FaLzhkQWdHVDg1UGZ1VzhZWXhJbE00RXY4SS9XYmk4cFlsZXRn?=
 =?utf-8?B?R1hxcG9jcFYxZStGZGRHRjVhYktzQ255aytaYnVDMmdWalA0U3EwYjkzS2VI?=
 =?utf-8?B?UGZuM0laempzcHVMNlBUQ3FPZDQyNjBrNVg5VmNmd3JCeGZiTEplc21CYUM0?=
 =?utf-8?B?N3lVWVhMQ3RpK0tsL2dLSGtENmljZllZNktkNG9CTVo0cFpZQTRXbXM3RXE5?=
 =?utf-8?B?WE5RR0tOdWtMRW9XUzN5L0FOa3BtWldZNnhZNHN6VWRQR2xIZm5Vb25CeTFL?=
 =?utf-8?B?cGRGcmJac1FpQmdlSTNHa3o3elVPUHNOenYybjMzZFFQNzhoTlVWUFFES2pY?=
 =?utf-8?B?ZHhYRGtwOVRUZ2VYNUNWQjc1M2Q3bzNsWnVWNGJpeGE4VjZQVTJ5cXNQVXUv?=
 =?utf-8?B?TjMrVHZhNER5NnFhTmJFNmpRdzNIeExQZVlEUytnS0xmQ0s1Z1k5djduVG1r?=
 =?utf-8?B?S3V4ZVlwT04ycklrbFRibTVpVXBrVTZPV1RaRGpwK1I5anBJUXZmdUovQ3Ra?=
 =?utf-8?B?TVhHeWxVdktPTGJDRkIwU0IreG1aV0EwVDRtQjRMUjdDTUt4a2kranE3MGw4?=
 =?utf-8?B?ZENDdlFlOEU1R2Fhanh1djZQVGVTNlNGZ3RsNjJ3azdPZTZFU1Q0RHNmZUNu?=
 =?utf-8?B?bGJUd1RZZUVwbll5MHNVVmdkODl3cU9BWk52dmxnQlVNUVJMKzFoN0J0ZnBU?=
 =?utf-8?B?Z1Y0OS9rS0hHc1VyYUQ5WUFrS2hTWXk1cUhOT2pyZUViL0dsOTBkY3g4TndF?=
 =?utf-8?B?SnU2RjFGdzVRRXhNK1Z2THhmTEtoMkxvOHhoNHYwMVM1SktPM3ZIbThEdXln?=
 =?utf-8?B?VUFZRzJ0MDYyZDBGVWJjaVRZZ3VqbzF4bXJsMjIvSnVzV24rcUIyTnlhMnQ2?=
 =?utf-8?B?Sks0NWVabUgrSWMwcklIeGM3c01YM3FJKzJ4dmhSNVNZK0Q5VHplYjRLcE00?=
 =?utf-8?B?VUNEbkhZd3hUNUFlQndVT2JIdjlvQVVobTFSbTJXVzFiem5HSmxvVkFiMlEw?=
 =?utf-8?B?OXpqdTRoZTVDdnhGRWxCaTFmREZxR1I4VWdaMUxVbUdFMm1mREU0c3dlRHhI?=
 =?utf-8?B?dmR5R2czQUl1MHgyYjdUaTFpZ3BRK1lmcStQVjZjL3IvczhOcGswcmw4eHZ5?=
 =?utf-8?B?YzRZNVU0NXVuQzBYMDQxM2RGVEpCWmpoKy9RcE41N0lVZTB2RDg2b1puT2xM?=
 =?utf-8?B?WHVuRWlOQTNsQXozbHJ2c2JMOWkrN2tuUEIvOEJpL1I3S0ZrSE1OY2dHY1ZU?=
 =?utf-8?B?WkduTWFybHlqVlJWOE1MZVVXNGQwM2E3S0hjWVltUFArbWs1N3AvRlM5ZzhK?=
 =?utf-8?B?d05BbHFseXBKNW1HcWpLdnpPNXFWSmRuRkN4cEV3bzJBKy85L1dyVzJXZmYx?=
 =?utf-8?B?QUdpV2JBM204Ky9xbWdLSlhGOW5JOWlTL2Y4QjFOUEZlYmJ2Smt5YjREZ2cz?=
 =?utf-8?B?WmwzRWVkOXRJZHp0VFdvY3VUK1pORjlxemFKS2NyaC8zTmx1U2U3MWtjN1NY?=
 =?utf-8?B?N1JTZmxtZXdkK1pJVWpOVDA4aUlJUXE4bktzb1IrTjgzaGhrSndBWUQ2ZmYy?=
 =?utf-8?B?VHEySFE0ZnBuZXc0MVVrK1RNa2ltLzhQTVFzNnA1SGRudG90bGFaWUlPUmhQ?=
 =?utf-8?B?Q2dyWjF4RmJlTUhSOE5JL1JKTSs3QlBvakZmbTI3QmROUkVlQ1NvM0krK3Rj?=
 =?utf-8?B?MW5MSjcxcFVqeEUvSEgwcW9KZ3NtS0g0UndQSk5zQlBINmI4VUlyVkMveDk5?=
 =?utf-8?B?NjN4SW4reWx3ek5XR1EwR2xnMGVVNGpaMnN2TnJWT1lZcjNJcmN0anZCenZN?=
 =?utf-8?B?d2xsN3hoWmpVNll2SnRNYm5vN0MyY0drNm5FUjF2UWRITmtMOTdaVXBBR3dx?=
 =?utf-8?B?cVVxOWZWQnU0eWN4djdtTHZUTEcwQjVUUDR2YTV3YlJGS1RrblhjeGdZQlZw?=
 =?utf-8?B?SmljZkNGMjVFc3ZXaldCMkh2OG5PcnRCRDFBT2MrNGJSc3YvM3NwTmgzNVJS?=
 =?utf-8?B?dmlsVDVVUDRQZzd2d3RhSWhLbzV6Nk9QR25nZ0tBZkxOWUxZY1RVdDdNcGZm?=
 =?utf-8?B?OHJjMEFNR0VJQU5McUQzVVNZNUxRQTI1WEh4dEQ1MC9Yc0VNK2lnOFkyaDRn?=
 =?utf-8?Q?Qg688UlXuD1YWXyrs1HHfjrhl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVhDa0V2S0p2cmx1Z3JXd2xNZWlIYjZQTmZMZHBtd1dvYytIMHBHbjN1b1RC?=
 =?utf-8?B?Qk01d1BxRGtPNHRZMityL1MzQnhteWZHajhiSTNPdUpRbXY1NExxNHk2aTlH?=
 =?utf-8?B?S21nYlpydUM0eWxBQVgySVBhUTZYalpwN1N5eUdIeHkzZUZwQ1QrUlV1VWdY?=
 =?utf-8?B?U3B1RXlseGltZlRnNmFOdXlnRGR1dWN4YnhRNjNkZWI3OFFXa0N2ZzBWdzBI?=
 =?utf-8?B?Q2daSHZHQ1dBNy90YUlNUWRPNEJCQVVzZFFSTGFTcXkzSk1hZkk2SU02eWRY?=
 =?utf-8?B?MHFJQ1lNeVh3SE1aRHUrdktqMS9idGtLY1NCMkQxTWhQVDFva2k1dGhRWFhS?=
 =?utf-8?B?djBwNDlmcTZOZGZkR3RlenpnSE1aOVVOVmx4YTk2V0hTS3c2SW1qZ2FCMHhR?=
 =?utf-8?B?QU1PSnFxbW1Vamp0TFVQcWU3WFdZdlNUUVZwSittZHdQejBmUzYvalFPWkNC?=
 =?utf-8?B?SzQ5anJrME1iOFJhVitPWDBaNUxNdXYvQWluSkduVnMxL21qdHhVT0NLQnVC?=
 =?utf-8?B?TGs0aVlxd2w4dEMva0RwaWlJcUZ2WEdDOGxIQzBGRUV5SkZsTFVNaHErc0VJ?=
 =?utf-8?B?VHNXNDZsemxpb3hBVUF3MnhkOVoyRThvZG9GV2p4UzV1MU8rOWYyOTBtR3ND?=
 =?utf-8?B?MHdMb0JabEdpTWl3UTlhOFI3QzdxRFNNRmVsRE5hVDM4cUhoTDJ0RkltSEw4?=
 =?utf-8?B?WG9ORFE3eDhXV2IyRldENVZacGRpYmVmQldhOThxcVoyRGRKQ25mMjh0SEk2?=
 =?utf-8?B?Wm00T0Fvcm15ZjN0aW5sRk5ENWFNeXpCZXNMeWZjcHE1QnBFWDBzSm9STWZE?=
 =?utf-8?B?aGVaeVVCTmZRbU1wT0dBU0lqLzFHTzBjQUNoMHpoclJuNEtKUlYzdHhUMzdY?=
 =?utf-8?B?UHpDTElaNitXc1c2NlY0a24relBENnI2bG4vaTJsc3hmQjVNUzQ3VFFCdU5w?=
 =?utf-8?B?b1lZRyttOG5DUldiaHM4bmdBTk9yTVAzeXFZNUg1bjFzSnY2elBNczI3cDcw?=
 =?utf-8?B?NG5TY29pRnREZU1lK2FjMHIxSW5RY0wwNERqQng5OEV1ZkdJZ3VpWkNTREw0?=
 =?utf-8?B?OUtIMHdkdVV0bUU2TE5DVmxpdEo5bTVDVUFVN1FtQmRnOXovUE5FbUVWWHFj?=
 =?utf-8?B?cHk4WHVxUngrU1dUVGVjKzlOOC9aM1BLdVRPT3JYTkJaYnE0ZU1lb0tFakN4?=
 =?utf-8?B?amZmdDRhZHpDZU5SNVdKV20wSzY5dndvV2FsZkZsMUU2UmhCM3R6alF0bytV?=
 =?utf-8?B?RnJsNERFRGZqSUJ0TXhmZ0xkc2w5eXVwVE9BOUlhLzFBejRTaXZmdWZLMHNa?=
 =?utf-8?B?MkVqL0diSzUrTG9nem5zRU1xWUZhbkZMR20rN09NcGhEZW15OG4xK3ZKYVJL?=
 =?utf-8?B?c2dSbVMzODdPcEJ5RXJrQnJVOTVZWGhpdUIwdUVsUElRWmNJZkNKbUgvbU5S?=
 =?utf-8?B?NWswa0tiZEhBYWwzcXoydG80cTVKQUo4WHZVR054SzA1TVJHY3M3ekhXTEFY?=
 =?utf-8?B?SDRBdUhiODdqVXRPR3Q4QWRMYnZzSTcydkxUNFozMmZEYS9pcXhJY3JHS0sz?=
 =?utf-8?B?SDRjU1lsdjdoNS9DZUw5ZzJEeWQ3cjBzd05kUXNqc3BYdFN3RVVZNXUzeUMx?=
 =?utf-8?B?TnI2aE41M01mK3ArKzg5NVlJYkdkVTAzd0dnVm5iWjdYTWRLS1pNaWJvc09z?=
 =?utf-8?B?ZDQvUEdJT2ZBZ1k2M0c4d21PTlpwTWx4UjJWWmtCZkhreDNUVzAxdGJOcThq?=
 =?utf-8?B?RWRaYmZ1QlRBMkxWdVYvOHBOQmpiSmRGZ2ZRYXJsTmgwT1RjSVp0Y0lkRnli?=
 =?utf-8?B?NUxDZDhTS0RRelNCbEUzcXB0NDZNYjZaellybG5md1NPQ2VzYjZ4Q2VkclVm?=
 =?utf-8?B?ZFhoZXM1WjFsYjlmTWttQW02a1RHUXdGcjIxS01DelRDcUZrekViMkk1aldB?=
 =?utf-8?B?Z2xUZHFtcC82Nk55aTR2b1B6VEtMZHhrQXBBYnVXQ2RYenVsMHNLYW1ENFlI?=
 =?utf-8?B?NmdFWmRYZVVQTlNjYjI5VEEwb0hSQkNqSXNDMzlPSHk0QXp6SVd0d1FsTUJC?=
 =?utf-8?B?RERJQ2d5K0pQVGYyWE1zT3ZYY2loeHIyUE1wOXVWd1JIaDJ4ekxxaEYvNENU?=
 =?utf-8?B?djJCUldrSldIaXZMblU3eGNlYUZHRmpPOUNVc3hjWjdsY3JoTkhmNEdURVZ3?=
 =?utf-8?B?bEtJbUtVWHhPLzJkcy8xN3crS04wMEphRmRybVhjM1FyS0lJUjRCaTUwQUVW?=
 =?utf-8?B?Z0RQWVp2RGNHckN6R0ZsUzhjOTZkWTVQRE0wVXpiaHdWWVFBYjBzWXprOFdJ?=
 =?utf-8?B?NWR5cFFOQkpBcDVxZXl5U1owYmVtYm1MUEdGUEtLYXVqWUZzV3d5dlBya1M0?=
 =?utf-8?Q?alasupczaxSSmchY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e31f1b1-f659-4c35-417a-08de5fe058a1
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 09:17:09.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbmjbJqF+Kj2Oje01x2K8yHkwZNOIpfbBQoyEkwpo9kjJBG8sNrCE0A4LAbc/halW8NWOPIjsPdmZxeuEMZUKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7361

To facilitate backends with different set of features, add support
for defining capabilities provided by the backend. These capabilities
typically extend beyond a single operation and are therefore not
directly linked to if a single function call is implemented or not.
Furthermore, the capabilities determine if a certain set of operations
should be attempted, or skipped by the frontend. This way
the frontend driver can work with a minimalistic set of features and
still have the device in fully functional state.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v5:
- As per recommendation, use guard for whole block
- Typo fix in commit message and cover letter
- Link to v4: https://lore.kernel.org/r/20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com

Changes in v4:
- Readd CAP_BUFFERING and also add CAP_ALWAYS_ON to support backends
  that do not need explicit enable/disable
- Don't mix checks for eopnotsupp and caps. Prefer capability checking
  also for caps that map to single operation
- Move capability checking to top of call stack
- Revise iio_backend_has_caps to use bool signature and fixup semantics
- Amend documentation texts
- Add capability checks for axi-dac
- Drop two's complement patch from this series, already applied
- Link to v3: https://lore.kernel.org/r/20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com

Changes in v3:
- Reduce set of capabilities to only include calibration. The other
  ones propsed in V2 can be seen as subset of calibration, or single
  operation failing with opnotsupported
- Rename backends checking function
- Relocate caps field inside backend struct (pahole)
- Add kernel-docs
- Add capabilites for exisiting backend variants
- Link to v2: https://lore.kernel.org/r/20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com

Changes in v2:
- Added industrialio-backend capabilities feature
- Removed acceptance for fully optional backend, instead require atleast
  minimalistic backend to exist
- Switched to FIELD_MODIFY()
- Fixed kernel test robot reported failure for missing bitfield.h
- Link to v1: https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com

---
Tomas Melin (4):
      iio: industrialio-backend: support backend capabilities
      iio: adc: adi-axi-adc: define supported iio-backend capabilities
      iio: dac: adi-axi-dac: define supported iio-backend capabilities
      iio: adc: ad9467: check for backend capabilities

 drivers/iio/adc/ad9467.c           | 69 ++++++++++++++++++++++++--------------
 drivers/iio/adc/adi-axi-adc.c      |  3 ++
 drivers/iio/dac/adi-axi-dac.c      |  2 ++
 drivers/iio/industrialio-backend.c | 16 +++++++++
 include/linux/iio/backend.h        | 25 ++++++++++++++
 5 files changed, 89 insertions(+), 26 deletions(-)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7

Best regards,
--  
Tomas Melin <tomas.melin@vaisala.com>

