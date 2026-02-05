Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023141.outbound.protection.outlook.com [40.107.159.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB03D333A;
	Thu,  5 Feb 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294265; cv=fail; b=up2sRptNnwOMjAxVD6uBr+rbm1f02jVc9Slra0UUXvDsnNwgDLs87HfSB4lzxVhx8fTNQBJ+jf4KJtif0mcKdAVGn55rzC5vXk68OkQM0DhK7th/xJ8c36gInZgSDBCk4zRLbJ14PXqPmtnVyAt5lQotIJdWHn3nZaH0Fh4IAPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294265; c=relaxed/simple;
	bh=7LWG8v/Z72VngDvGQLMYxaMtsEWItosJylf5HWFXaAw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nzF5Alm+bvoUkdfl2bqB5EnwXS8ysckqjXoZLuqMGe1LH35S5Ihr1jMFTirPehOYknWhqhKCL+KpTQIJZGBHXlW7ScDjuuVqXV0XFFjlgfvImcAtKklK9lFP6Jho0ZpXLsfxqttE4Cmwat2NEpgzvzZ4i2nN1Z7JVAzoTipLz3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=tj/EJ3NS; arc=fail smtp.client-ip=40.107.159.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="tj/EJ3NS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2vcJ7NxOnAxDf2WXuP5B3FDy4vrOWMF5ES0gwdwhg19bNNLEuT2VEk41xpPLRDQzON5+Q4AsLM92O4qhT3CE7jlTBBVzgOTmZPruUrTbeRtrNB7RpAqr7lmiJgCFzWXPzlJoehbzdOworiatdlDsKrNd4M2D/moGEQTZWPsOkE3MOa/HooRpsH/ZIjU9XNBAaB8x/LAgSY2LZla2AHaro7NcMkg9+ZB0XOcIzN5Mfj6ZvvKVNPznsg58gSlK/XODkjv3OJX+CN0/Mdrr4fliRTWpa4WVOxcxb7zy7G2rYo7buJzjTrwdmj9CnyPZipLrPqFNGwD9ErcZ4lxJtjRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OS/C1NWy4JXaUeSGdQ8yYIzccVQjBtdG64ShVD5TIA=;
 b=EvsFSp7hMNYL1MMZC9pRhp3oxhaEcz2kLc3uBmXUBOrU7MBi9XLNvsQThMB9c/Br43S5AVAlohvTlOTxkKYolmBzzsMmlE1i7RmrqkX39lJnOy5TCZ+jRwEcpz+7SEJVF3l9RGsGFkguMKO2B9z+oIQ6BBu5czTPau9JfyhENX3fZiVlMXd8dR58mx3dFEtghEdwQrc3R4/61N1161csD2TeYeTL2/ILuyUjCGMuZ+V+zzmMaSIIqAgSYHonm88yTbEXObHJCSpj5dRP7MeZaMDggLuNPzoFk9XiNWxTZC9k5bevXuuUzDF5ykdGthFIEL8spxSj0jsIe98j0GXMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OS/C1NWy4JXaUeSGdQ8yYIzccVQjBtdG64ShVD5TIA=;
 b=tj/EJ3NSlz2U6WFoOlqMrKGRD7L/pEz+zKezYVdFxaOfXbV4WF1dvIplz3XJkMcXWoJDRuOacMDzZitdH7USqHFSZF33Km/dVQrZkl07ZnDesjfCrFmwaJucJuPR5B8Qfv5iQh7B1sB966tdktELutAontIQbm56SDyqnBaSy9pXusyxDzAw9tMJfQE/yQ4I9cQRWJoIsBSIK/h1NLtsgoOygggAMUZ3U+r4XK1obrWeFyP7WLgW+PueYQgXrPOf4dXZzHSx1LsdJiSFV698J3AwmkQpDMJu/PmalFfo69Tn4DQxsM6NIH6iPE1FqX3njEcZSlsvt68YsoeHADg3Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA1PR06MB9233.eurprd06.prod.outlook.com (2603:10a6:102:454::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 12:24:16 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:24:16 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Thu, 05 Feb 2026 12:24:09 +0000
Subject: [PATCH v6 3/5] iio: dac: adi-axi-dac: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260205-b4-ad9467-optional-backend-v6-3-7ca20c40c59a@vaisala.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770294252; l=1009;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=7LWG8v/Z72VngDvGQLMYxaMtsEWItosJylf5HWFXaAw=;
 b=R+/qtEk3Cz1aqpikawcvOPCIZYfp1LIBhhVpsewCi/NnTdecn7SQDKq9XkC9nN2yIKIz0YvD1
 qLubSaeewPKBM1fNInXAOlSil0+0irPrFRHvrLzkwxFXiJWN4XDOr8e
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF0001DBC0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b2) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA1PR06MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c9600c-18b0-4818-3264-08de64b179f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1dNVk1YRDZvOS9SR0taUm5XTXBNQTRkWVJmSnZlaXo4WFRwRk9GbTQwS2hk?=
 =?utf-8?B?c1Y3QUJRbm9sS05oWDRTTTRka0xJOTZYRWhqZUg0M0hjYUU0Q2lpNzFtbEFq?=
 =?utf-8?B?Uy9Yb1lrS3lkMjZtbXk1dExEM1l1cU4zWjZVRHlibHhtdVIveWdWRXhUOE1N?=
 =?utf-8?B?bk1zam9LRzFqbnFuRG5hRDVMejBZaTkxaWRTL2dzaklFWW5xei9WK0JkWUFJ?=
 =?utf-8?B?WWRkSGE2RE5oZmpYWmJNZkIzeDltTU8vWE85Tlk1QWtvWjRTVm8yWTVjSmZH?=
 =?utf-8?B?U1R2ck1OTmNiOFR4SEE4MmVIVVV0RUNMc0hyU0tBS3JmamtsTXh5dDFCSkI2?=
 =?utf-8?B?azdyMzJjUTN0djVkcThVdVA3VklHSjNmbkVFcmxEUnVFYXBzamE5NVBhelBk?=
 =?utf-8?B?c1NuUDdZL2hLc2NyVk5hc2tBNVJDcjBaZXFMU2tiYVMxQ3U4K29uRzBIb1Q4?=
 =?utf-8?B?bVp4dnlzdXk3L0trNE1zclhsbldXMGZ4cWxzZjJVMHVhQlJlYnZNMnoxeWRy?=
 =?utf-8?B?UEJMR3k2ckQ2Q2NScnlySVd3S3NLQ0V5M3ErNVdFSU9uenZuSUhaWW1IWWY4?=
 =?utf-8?B?REx2ZS90aTBJVEZueEhKNDYrc2FkYzZNUHNqeDEwRldab3hJek5oWGZuRWc3?=
 =?utf-8?B?dk9yYnd0Q3pNaWJTVmE0WEphejJlQ3VlMk8yaWM1U05ObXlrMVQrQjNrQU9V?=
 =?utf-8?B?UFpwMDZLcC9nMTdpTXAydlVJNlB1SFBIL2hzaEJPMVZoT0dxaktnYkZCRWo5?=
 =?utf-8?B?UHNwb0xhdEU4SXg1Tno0V09zRzN3WVpNekQ4U3UzK0JSMHdLVFJMbjc2WG9n?=
 =?utf-8?B?ZWVVbVJoQVhxWFcxRWhvZ21qY3FPKzNIaVZZQXN5MDNWWmN5MnR6cTc1OHFx?=
 =?utf-8?B?NDBLSFpxeFl3UFpYdzA4YmlGU0tTTjh6dkxhZ0xPdm5CR1dnRm5LUlVoenVq?=
 =?utf-8?B?TDBqdlhQdHlYbGlKWWRUQy9IUEdHUUpycURCRWlqYTlpV3IzNk8wRWNvYVAx?=
 =?utf-8?B?WTBwdGlCRWZjVjJsb0tkdUFzdGttS2RpK2ZKVnVGMXFoS0ZTc3g3enpEcDVK?=
 =?utf-8?B?Z3lacjNid1pLVmJueHNjMXc5bkFNZnE2bWRONVJLSU12aUFCVEoraW1oV3Bw?=
 =?utf-8?B?eTJWcFY0TFB1eFdYUzY5OGV1YkhMaTRQOFVzU256Q2R0Y2w4b29xVERMNE5U?=
 =?utf-8?B?ZDdYRW96bG4zMDNPbjNneGhlbnVjVThCUEFhQVU2OWJnMk9vNWZQOVdvdEhr?=
 =?utf-8?B?aDZsTmhzRm9zcHJLcDQxVWtjVm11SkhOWkxYVWMwMEx4WmNhUHFCUVpEYnFr?=
 =?utf-8?B?M1FJb01iQityNmtKdDBVbWJqVkJCYysvWFhGcVNhWWgxSjgzSU9ndnRWaTI1?=
 =?utf-8?B?YWNuR1pDUFdaWEJFQTc3TnpRR28rWlJ0UitQaExJWGlqamtVM09SRjR2RndV?=
 =?utf-8?B?UGlpc0g1cmtycjFLMHRGY0pSOEFaNVIvM3BsUTUzSWdIUkFKY2ZlK0xBQ2Qw?=
 =?utf-8?B?SEYwaDVpdFJUMWttWVdCaEhJMU53bGRrWDgydlVIS2ZoZ09MTjc4eWZkcDcz?=
 =?utf-8?B?bzBoTjB4YnVYaEZGTHozT1Awa09ySTNleFk1eW1pT2VkR1NxUjhnWDFoMlZl?=
 =?utf-8?B?Z29ld25IbWlNcStZcDYxcTczN2dqUVFmbkZ0dlFvb2NnNkhrQ2xFRklxdENu?=
 =?utf-8?B?Zk1KZDhIc1RhVHVlYnVXRkRuN3R1OHRQcnNFKzFIUFQxeXRCT0tIa1ViVFc4?=
 =?utf-8?B?aVdZdHNBaitoSk5tMi9WZG9PZHp6V1JRRS90NHo4ejBVQThkdHdpNS9zczVj?=
 =?utf-8?B?SW5GSVdYSXltay9Ga2drUEZnZUtOdXpyc3ZtVW9rR1ZkUTdlWk9wMGRGWWpy?=
 =?utf-8?B?dmVsZWtqMjBXQzMyMzhCeEc5YUZHTWVxdzJ5NWQ1eS95bUFoeVEzem5kcTlW?=
 =?utf-8?B?WEpJSFdGdnZ6MXNDY2o4M3Z5bkZ0aDVCTHVnWU9zNCtXSVV4TFcwN3dSQ1JS?=
 =?utf-8?B?QWVETFNkWXRZdlpENlViZEJaSjlhb1N4cmRRbkFBTUVyN0ZqS3NWd3dKQlE1?=
 =?utf-8?B?VEcyUDlnVjF2NDMvdlM4N3lGOEVWbUEwV1N4dGRIRTNrRzk3SUxTdXJWcG5O?=
 =?utf-8?Q?YJzk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y05TUW9HUzVhQW5nTExVdVRBVjFlSW4vU3pOS0pqNlAzbU1zalZ4QW9BY2Jj?=
 =?utf-8?B?MWdLYnAyVGE3aDJSY3NyYzZDMzVERjM0dWZjdkpTV2lFSjhQUFdESEdJc3Ev?=
 =?utf-8?B?Y0J5aHQyMFVibWhzNkl2QW1uVFBVQTZ5MDlFbXVFUnkyaWZWRmJjV0NKOHQv?=
 =?utf-8?B?UUdLV3ROYUNwekNLY1ZOTUZlcUI0WUlURmJkb1Roa2E5TjdKQXBNejV4dDBW?=
 =?utf-8?B?bzVUVk1LZk1RQ2FSbzA2dWFwMTQxdjZFNU02K002ZytuVGFxOVFIaVZpTE1N?=
 =?utf-8?B?WThQS0FFcHFENTJsalAycHo4Z2c4Z1IwZEw3L2pPNmNJVUs2OENQNlN6ZDli?=
 =?utf-8?B?Znc4aGs2ZjJVOHF4K2MzNGN0OVhSWVBiQzlsbkVFQ0RKMnp2SXgxQ3F5MlZP?=
 =?utf-8?B?Y3FYR1FrVWYzdVNaV3J6WmM2Q1V2SFJObUdMSHdIamVuUFpxOE5FYmlZSFZP?=
 =?utf-8?B?NGVXMXpCbERVUjFhNjhnVkZPeXUxYm5NNmk4dWtZcEhoaHI0a29zajN1NXY1?=
 =?utf-8?B?Nmt4TFo0Tkh5UzU3OWVZN1RIZkR1ejVFc003LzlFS3dVZXBTTGFUUXprUklR?=
 =?utf-8?B?VXpBWjd6ZFpHVVJYZlJnaERESmhGNXk2TWlkb1EyUHpzSUJIY09PUlNlWEhI?=
 =?utf-8?B?WU1LcjVGVFJwY0w3dE9lRy9qc0sxWjZ1dFVRbXB6V3V4VGxUc0sxSmwxQXFh?=
 =?utf-8?B?VkVDN2JicHY1TWdrMTJFN2lVZUVtK3ppR0duRGwzd0hBSGI2U29PdDZZaVdO?=
 =?utf-8?B?bVZaTVVnbmdRblBpN0NTMEV2cFQ1MzNndTJlRTNvb3VYRnRuZThhbjRYa25E?=
 =?utf-8?B?bHBZRDVFbXJEUUlsbkEzSVdiYVVPZTlLdVhtaE8vdzVsWUc5bUhNZmlreDFl?=
 =?utf-8?B?WUhVTWdRVTltcllGRTY2ck1CNit1VnZrdUlQRnVwcnVCaW1KQ1NSRnp6QmF3?=
 =?utf-8?B?WEdjOWxyU3hLSWNFZTZ3NGJ5N3ZyQlBLV3VGYStldEg5bEdOcGROenZYNFNr?=
 =?utf-8?B?TCthc1dCMmVnRURQd3gzSmJiTllRT1VWaFdBeHlIckVXOG5ad1hPK0VYNXRW?=
 =?utf-8?B?dXRsc0hrNGJNMlBQSXA1RGkyVllBaHdHblZhNnhyZ3lNdk1JT2tUeGlIN0NP?=
 =?utf-8?B?UHRhWWlONkFqQ0hydW12UWZjZzZPZ2JMalpsMjRUVUtDQnVqOGdFT2h6NjB6?=
 =?utf-8?B?VnRpOXZpVGJ6U094dE9SSWYwckhOVWZiUUMxRVNoQkJicWl1SjRDRFhyV0tS?=
 =?utf-8?B?UzlnUXU2OUlQbEJvTy9XUEFXK1ExWlN2SXJRVklsbW90c1V6aDg3anpUNy9i?=
 =?utf-8?B?K3JvaitnV2dsaXJhdnpyRC8zNHBDSnBTYzBzNUZoSnloYXNBTjA2cHpRVGwr?=
 =?utf-8?B?cm54bjlJdW1YSTdlQzBVYXpWR0M0NlRjOHVOWXNoaVdadDc5ekNBNEJNQXZ6?=
 =?utf-8?B?Y2tObDBvQ3V1MWFrdWI0UnpMUndmQS9rckpGS1BBeFVEVVVycHhHWFhkVEhx?=
 =?utf-8?B?Q2V4aTVFOXNQNFpYM2tqa0M1MDZBQWl6bHpmVTAwcW45TGh3amR5T1I2ck5Z?=
 =?utf-8?B?WlNvMVNZWG1pekUwMzB4bE9PTXZVSlZKd0gwR2N3WVFkNzZML2Y0S0dra3do?=
 =?utf-8?B?TzQ1cWowejFvM3htakJjNjBWaGtmYytjWWZkNjhzWGpRMmdla0tIUlkzUkJn?=
 =?utf-8?B?T1ZXYkttd0ZNMTRqVGFxeWx5alJ4WnpuOVh3SEVNMmpGY0ZoN3RYckhPL1M2?=
 =?utf-8?B?Y01NUFpCallsdTgrMVQzU2JUVjdSMTFBa0FQRE40ajkzWERoV29HZWtpdFR4?=
 =?utf-8?B?Y0NWTEpacGFLR1NJQjVTMUdraklsZHVYazJvQnoyVlRNcGFkczhjejlXcU5m?=
 =?utf-8?B?R0FYdjJheVlkWFZYWXM1cVlTenhlSHdxVjFZS2EyYm9YTEJVU1A5UDNJNFpx?=
 =?utf-8?B?UWd3YzlIZ09aRHVoVDhtdlBVNnI0cGRlRVpjUjB0UkloL0Y3dUlCcVFBN2or?=
 =?utf-8?B?aDUrajd0cSs1aEpOcERZUU1BbXVmS2NlRWRxSnNpUzRJNFJSWnd2dFdwRGQ4?=
 =?utf-8?B?eWdUZ0kzcWVLMW1HVmlXWXdoeDE5NTkyNFJ2TlVvSzNBbFZ3MVNsWjdDNXpr?=
 =?utf-8?B?VVFUYzNmVi9yNW44bmQycGp1UUxqemRDVjQrWGJUTE5USGFITWcybktXcFky?=
 =?utf-8?B?STMxQTRWaGZQQUZUMkdaaHZMVXVocVVmLzhGTmJVcEhWc3NTZG5jeGdCTVpD?=
 =?utf-8?B?MjVzTDROUFhQdDFnbTdGRFlVNTA1ZFNMWndQeXhkYVBPQzBuR2JNY204SmMw?=
 =?utf-8?B?RmhNV2FQdTYxQlVqWUJ5L1ljVmU5U0EyQTNzcENPM0w5OEZHRUNLUmNEanZU?=
 =?utf-8?Q?SwNKhlHabgP9Odfc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c9600c-18b0-4818-3264-08de64b179f3
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:24:15.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6u8LJ7Kc2B2ZGwezDAXHjnWZq5MOVbqI0Phv1glJ/NR257CmosyQadsEiw3ea8B3r0O9qZKQqzTKS99MZQ7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9233

Backends support the buffer/enable capabilities so advertise it
while registering in case a frontend makes checks for it.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0d525272a8a8..b02498aed43e 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -869,11 +869,13 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 static const struct iio_backend_info axi_dac_generic = {
 	.name = "axi-dac",
 	.ops = &axi_dac_generic_ops,
+	.caps = IIO_BACKEND_CAP_BUFFER | IIO_BACKEND_CAP_ENABLE,
 };
 
 static const struct iio_backend_info axi_ad3552r = {
 	.name = "axi-ad3552r",
 	.ops = &axi_ad3552r_ops,
+	.caps = IIO_BACKEND_CAP_BUFFER | IIO_BACKEND_CAP_ENABLE,
 };
 
 static const struct regmap_config axi_dac_regmap_config = {

-- 
2.47.3

