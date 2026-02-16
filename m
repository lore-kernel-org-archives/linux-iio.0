Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A572C08D9;
	Mon, 16 Feb 2026 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771233859; cv=fail; b=dWkGm1ZITJ+5/9NgxhyEu9OdCVo06Acta25kwko5uRhuphwlOTdxIEQ4mcuQq3LGNA4hTsM/Jjge479ukbdUP7P6j7Dx5P1uTVfHMNJAAFKpWDEeNBf8Ravj0/qX634k0apgR7cbCm1/6RA9IlLDYH/nx9GZqHKsL66IEyuYRdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771233859; c=relaxed/simple;
	bh=Im5G31RLm/kVuK4l6abwLdJpt4PJMpTRNL0wA9n2gXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=buEIllwYVSo6xfbbnzexC40FZ0lojbnBN/lvNApN2E/ezhOyszUMZX00B9qGCZi++jIulTXhx7zi3Ew8kkPfUWJ6/dYNm/OAFb9ZATqoxWcuB1wvdS5PdXW7eqHh3LcTvCChWgkZX73TMJktguAhmlyX85zyyrPwFnNbx+cgtHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Zxho5cIa; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Zxho5cIa"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G3ud8R1305909;
	Mon, 16 Feb 2026 04:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Im5G3
	1RLm/kVuK4l6abwLdJpt4PJMpTRNL0wA9n2gXQ=; b=Zxho5cIaGWc2sF6sbuhX+
	Tnahgi6goWh5QC2T74qIk0uWBKMYF44NrJYh5D76IFnZWZ/r+zOtRd9gISXuXSqe
	60zJfWPoXiapTnAUIDYikCNm48dn0XLNoCEXCfI/Hj09+PqAijUbMRQuMbXvJ1RT
	zpm5hN+WEGQqb90eMJM15dduw6UzclKg06AK/a0kQ442VGqB6a6A925j4mijj0+d
	ilZmpHprMpVGktV2/ClIjxwSVb7PMbABR7ImNT0lBhdC+M74Ai6OiTpHYwFYVhWn
	wahT+nqH5KKm0+H7PMcpfeszKfCLnHh3P2ZMNlCxPR8yX3kmMXCfOCptNX/lJVrZ
	w==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4caks2f0ah-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 04:23:52 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewGnlfiZKxXab5qc/SFMVJpB1eakY6eIh/Lw1JxnFERC3D9ZiDsyx0qeVn5MLu203Z6HwM+4KGbgLjXmPVrbmNt9AdcZ8zKzXc2Bd3RmI+uBBut6oYL6kAXlhTi8BcMMxc8wuDX3D5bmCsJooTtSvjKvXvZYkOfpYrKOwdF9z0cdmv0pd8bBvwlzyvjf2QcRgGsNZ3gJNx4v0UOE0o4+xRmw3Q3N8bK9MktyAn44UmAAJq2p25HOWKt20TelQajEECi8dWkECBE7CVsAfFiX65v+Mfsff/775gynYFdQ4I8OUTk8gt6VizoNWhhYv+6XqPfPWyKd+cBm7zNqFJy8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im5G31RLm/kVuK4l6abwLdJpt4PJMpTRNL0wA9n2gXQ=;
 b=LLWPL2/1eEw2jmYSutuQ12190DO2ee7Jbgcc6LPyUzvF+P7qhgYoifd75I0njFDAWB4pW2EZqetHJw4Zowc3J9eQ6//qA1CrEs0UvJtH6lSPbP5rU5356XXZ3WDzWuy73iqwNdKx3YEJCj1cV/EQ5JEgl//d5sm1WjSfaNenju/zv+pWjpf/nMDWej+mqdBGDwkLtV6WtNiUEtDi1h1ZdByrnKv8nVBtAv6fUgeB9AwHJQNN1YXN/xGj+ew2/aLKASFrils8KR4oyyXEpuDRilW1KSdB5GXTwczYSKzg9FLkNKYb1WZHNW4t1LBPyYdUnkTkdCMWFsH4nFDnQTmAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH4PR03MB7553.namprd03.prod.outlook.com (2603:10b6:610:23e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:23:48 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Mon, 16 Feb 2026
 09:23:48 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] dt-bindings: iio: adc: adi,ad4080: add support for
 AD4085
Thread-Topic: [PATCH 3/6] dt-bindings: iio: adc: adi,ad4080: add support for
 AD4085
Thread-Index: AQHcl2nQYHB1lMHu9Umv5JGfHL4oa7V3EQKAgA4KEAA=
Date: Mon, 16 Feb 2026 09:23:48 +0000
Message-ID:
 <CY4PR03MB33991AA5BC33EF3786EB01A09B6CA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
 <e1ef83150eea89864d4bad8d9b43e60503fc5f14.1770382796.git.antoniu.miclaus@analog.com>
 <20260207-hypnotic-passionate-crocodile-e5be30@quoll>
In-Reply-To: <20260207-hypnotic-passionate-crocodile-e5be30@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH4PR03MB7553:EE_
x-ms-office365-filtering-correlation-id: 1d5ff5d6-c3c7-4cc8-92e9-08de6d3d1718
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?elhhOFpPa3dWeFkzMVNQRWRXYTVCRVhRWHhLWDBTbkJIZjFxc2N1dTI5ZlNx?=
 =?utf-8?B?aWRId0R2ZW9QZ1JUa1VXYXZBN2xCM0JRY0U0bzZseS9XSGtIS09kcVBwRzF5?=
 =?utf-8?B?aWFsdkNPTlVxS1hORk5IL2hQWG1wSHNTdTNxM3NtWEhVcmM0cFJtTXpiNjdy?=
 =?utf-8?B?NVYvTHZoRlRwUWRFUDE5RkFydmxjTVpEMFpKV3JFancwT2tkU0JoMjg2WG9G?=
 =?utf-8?B?TjNjdzVWRGlMQkpodnVucHlDNFJ6VFVsYVVEaWtQYzl5VzEwQ0I4aWpnaGF5?=
 =?utf-8?B?V1VRR2d3NlpOSVdWVUVQY1pNZ05Wb0ZtcnZVRFVHczdGYTRJci8wZ0Vhd29Q?=
 =?utf-8?B?VXlTemUzTWZBQTZVTVVtV3FGVlpZdzBHWUhzSENZem1IbVNFL2J1dUlibFBp?=
 =?utf-8?B?aWRqVzhqQTZFTWZHWFdtU2F0dzM5TVJOeWE0R1hnUWdicERkNkFpWXF3VldZ?=
 =?utf-8?B?b1ZkZ2JyTm1PSC9DNHlsaVdEdXE2TSs0OG9GajB2S0Y1dnY4bVVrcWI0RnFl?=
 =?utf-8?B?WXBxbmNHVy9XRjgyYVVUMEI4SGNwNW1tU0hTNjY3ZmRheS9hQzZzU1JNTGlE?=
 =?utf-8?B?SW5sendZcDVpTzhkdjB4NzZnamswUmJ5OWUzUzNiejNHeURRT0V6WjNBR3Bm?=
 =?utf-8?B?L0tuRTVmbndTMVo3S1MraWdIQUVmNjFKR2I5ZkdlVkNhNWFrYWNDWE9LRk1y?=
 =?utf-8?B?aFpRM0tjWndLaWVnN0V2YnNEa1BUYkZlU3NlcXNHNWlBemw5aEZGMXRINWQz?=
 =?utf-8?B?aFFERFVtSVFDWjZQN2FzQm9tRU9vVGdSNWtjUUwrWGdNUGZSL1djdFBCRG1X?=
 =?utf-8?B?WWdjWmNjSFYybUkwUWRrSFhiUjYxdUxzS0tCYXRqRWtDa0ZDdC9DOU1Sazh1?=
 =?utf-8?B?QVpWVWRDbE5nVlROQ1Z3OEk1Z3FrVXBIZFNpdWxsRDF5dHRPYlhjbmZZWjNZ?=
 =?utf-8?B?SXpPZVNpUDhHVmxYNEREc1FsZktjWk9LMXJxUzBsbzZJY1U0bUtseGNkWURu?=
 =?utf-8?B?enFOT0g5RmZHdUJuaG9yZlcvc29OY1BHRGJ1WXpLRWtoajVEMGdxNmpNOTVm?=
 =?utf-8?B?KzZ4ZU5GZTR2M291WDhWS3Fpdjd6NzRsRWhQWW1rM3dVVDhOV01DRVpUaDdt?=
 =?utf-8?B?SCs4MkJMcFZJQ0FtUVNSdGZiblBVWWUwN0xqREJnUFk5aWJtTEZBeXdyZE9K?=
 =?utf-8?B?UDkrZWxmYW56eUFOckpqdm5Wc2xwOU1jdVd5eEVDRUl6R00vMlluaDFobEpB?=
 =?utf-8?B?S1VjWHJGZHAra2podlIxbDZWZnd3ejl3NU1xM2tWcmFGdWhUaFFBUSt5WTMy?=
 =?utf-8?B?SVl6b3djTXliNUI1bFJqcGZXU2FWblF4NlVyd3ZQdExNSVdQZWRpeHQ2WFph?=
 =?utf-8?B?VFlOcVNrNGs5ZXMxWmhaTGc2Rm9VTStnZGVPWVhneTcvckJrS0NycHJuNGZp?=
 =?utf-8?B?VWJhZG14djBaRnh5WEk0MHhrRyswRy9SQS9NYStTNjEvN1YzVUptTHZkUDdk?=
 =?utf-8?B?TzJKRUM0MFVZblNxWjdpZit4Nk9KZHkzeWhNZ0NUMXVtU2hlZUhVWkdpSjdk?=
 =?utf-8?B?b1dwT3ZreXlWYWozRHE0bWhmblFwcXdXRHRlTHdyODluWTdKbm9FZjJuT21E?=
 =?utf-8?B?dmhRb0o0VWt1azhFWTlpRkN4Ym1mUzdOKzByR1F2NUl3NHkxKzg4dTJmYWVG?=
 =?utf-8?B?bkFzUUszZGlnKzR5SGRqUWJlK1dCUklIalZ0QXJqeHJ6VDBCRVZEZlU4ZFln?=
 =?utf-8?B?RjRGazJzeTBhays0eG9RckJQcHJZRFRsZ0l3NUgwNVcxbGVPbmtPVzMzSmVs?=
 =?utf-8?B?ZkYvSWVYUnhScTRpc2pjY3dwQ2lRenJBYTE4b0szQjVpMUhHYXhER211Slg1?=
 =?utf-8?B?SkovWGZDc2hxL01ISnYvVDdCVm00VWcyU2hGRTB5M3RTZ3dTM0twUk5wa2xV?=
 =?utf-8?B?Uk00MmM5VTBIOWZMaStXYW4rcW41YTArempVM1RvWjhMSnBub3dwYkpGSkNS?=
 =?utf-8?B?OHVCS0tsNHFOUHZyVWJ5TS9pSElOc1hBVjFTSjlVMkE3ZWtkdXZ0SnBBZ2xn?=
 =?utf-8?B?cXh2MmY3aWhpV1hVUi8xTnVZUkxweDl1dXdQUTZaalVVTUVqWFZreVhCZVhU?=
 =?utf-8?B?ai9zSGh5MysvMGhkdnBUQk5XY2hNOFQ1Y2V0T2ZjRTFCNFNaYTh6bXloNlBZ?=
 =?utf-8?Q?oIIxS7A41iviMZ3uWHuFKw4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2ZaTUtGZVIyVWRTRDlVRCtZMGZSYXBSSDdWcDNnY2dXdDMwTWJVTDZxOHNo?=
 =?utf-8?B?dU9pcDdtVHZCUVNMM1RTVnFaYkhabG1pVUMrL3NSbW9DOHJUT1N4WHc5TTVm?=
 =?utf-8?B?MXh1WEh0bXNFQTR4bDdFYXRUNjQ4QkxWU08zdWh6NEo4QU5QeTJoK2pDSkxW?=
 =?utf-8?B?YjRMY2FrY1lQV1VHbG1FVFI0ZFVEeU9ReXZVTEdvaExSQzJqczhEdXhPSkJV?=
 =?utf-8?B?UExRcHN1Wno3Z1V6SWduRm81Q0REZDY5RkpiRVpHcVAwMVp2ZDhINU9RaDd4?=
 =?utf-8?B?aDBxV0NnWnR4SWJmMHFBL01jZGZBREgyTVl1K0ZqTkxaYUdIRW1UYk9mTnh5?=
 =?utf-8?B?SDVUZFpaaTJITU1hWlB2Q3VRank1dkdHTGNkUnVZK2QrSmUwKzBTRE9DTnhB?=
 =?utf-8?B?dURPZTdpY0Mzd2lVSllKOTdCa0s4anB3NVcvZUExZExoQ2x3OHMwd2RzQTZs?=
 =?utf-8?B?SjRPQWVuZWJTaVlLSW5hUUs1bmp1eVlNNTR2djloZ2Z6ZWMrVVZOWFFteGVL?=
 =?utf-8?B?Y2N5SHB5cGpVN3dZZks0Tkh6LzNFdWZSUW42U0NUTE82RDFZb0FaRDJlRHBC?=
 =?utf-8?B?dkpqeWJVWnFtY2t5alovbXJhS2U2WS9SaDNSYzE0dE9PNVJIL1pvK1JHR1Nn?=
 =?utf-8?B?RzRuYWM5QzBaS1dRcVdabmorSGRsKzZqS3NIS1Y1MlAxR0xQNTRTV1krSGoz?=
 =?utf-8?B?bUZoVDcrRVlKbzgzdFR6blJIQ0d5UUU2aFdYSlNjOGhJeXhNZDNDZVRRbkVG?=
 =?utf-8?B?ZGkzejBOUU9vaEQrc3hxQVJBbFBtRTZLZDg0UW8yUnp1bkk3NWxKZmM2dGRs?=
 =?utf-8?B?NG5LL1l2SVVoaURXalV4elZaNUgxYkhMOUxBL3FoWXYrZFZ4QlRqbDM5N1Fu?=
 =?utf-8?B?NEVrSWhLMCtHN01qRjl3dWhPVVFsQk0rMGZ4THIweEh6dDA2QlJvYXZHZmZE?=
 =?utf-8?B?K1VQbkg0NEttMmpBNE8ybVhjdGgwd2xaa1FDZjU1TTZGREJtN2JSQTZoWDEz?=
 =?utf-8?B?ZldSVGV3bjVobEdSeUVXR1BRUUZWK0dCNm1GSDdBc1JqV25MR2pMVlNYdFhP?=
 =?utf-8?B?TlJndUtNY1JKZXhTU1FHM0JoZ1RwSFlwTFk1MXJzaWM2S2V1K1FOUHB1RnRN?=
 =?utf-8?B?Qk9Oa3Vpa2pQbkg0MWlia0JqYmlsYUNrRnhBcjYxUDNMWkVYaUNza3NOOHhG?=
 =?utf-8?B?R0lrR2ZGR2FGd0s2RGk3NzdLRmJWZ1QzUWFBb21rNDl5RTROUWRCUDl2R21v?=
 =?utf-8?B?cDR6aEZTL3Q3RE1lN1d1cVFEbFZkdkE5eXdvMnNidkJYblc1UFBhT1dqWDVL?=
 =?utf-8?B?ZW1FMVJoT3BSWFFXd2Q0Yy9CM2lSdmdxWHlmNGtHR2V1L3hWOGZvRUR0bmgw?=
 =?utf-8?B?Yk8rUHZjWUkyOHRDbk1VbGJYb3hqTE4rQmtlRHFHeUpoM3JaeXlhaWltWEVT?=
 =?utf-8?B?S1JhM0tGMGJiUGRqTXdzeVJ0MVNTclFrUGhTTytISU1xaWhxUlZDOVM5eGNP?=
 =?utf-8?B?cHZHSXlrdUovV2czY0o0Q2hRWm1Sd01aMWJRbU9XK1MrWTMwa2hYbWtyMGdZ?=
 =?utf-8?B?MEFpVTBuNDIvMDdxVXcvZ0xvQ0VwL244NzU5STJyL2VYajJ5MWQycEcrVFZJ?=
 =?utf-8?B?QTVKU0d1TVJKWXhHUWtWeGpYTXBpd3dkSW5pQUdEY3BwUEloTTdQVTI3RXls?=
 =?utf-8?B?bUxiQndtRk5qblJLbDFzMHNUTWdTWTJqL2QrTkYyQWlGL0lKeU8rSDJ2M3ND?=
 =?utf-8?B?d1ZYM05qSnNIMWpxTG1pMVBjL3RYaS9KK0dDZTBpWWNYMkI3cER0SzdMcGhk?=
 =?utf-8?B?R01OUEZLenNkenBPQXpORkVKakRyRllZenlHeXRmWkRLT3VKczJiVXBweUxQ?=
 =?utf-8?B?Uzh3b3o5bXNCa1p5VDRtdnlkdXZkbGV4c0NFV2NnOXNESE9uNzZwWldaQUZa?=
 =?utf-8?B?SHJ5Zk5CdkxST28wemoxN1J0Q0FVSm9YaGtGc0ttYmlhaHR3L0E1WE5PQlMy?=
 =?utf-8?B?UzFJRUQ4Tnd5R3ZhZHRuQUNSc0hJVkZLNktZYmdrM1NLQnI2RHdpcitNRFdI?=
 =?utf-8?B?Y2k1OCtvdnZPNElJOUN3d1Qxc2xRVHg4ZXRtM1RKSFVZYm5saitVOUROTERx?=
 =?utf-8?B?RlFxcUY2VG43Sm1lWEVUMmJVR1lVN0pyaDZIbEtIeDh5dEk3VlpXRHlMTEFR?=
 =?utf-8?B?QjdJWEF3NnVCRTc4aDU2SGlIZW4rNnRqUlNNTVJmajZjWDY0Q1lMT1J3SnhF?=
 =?utf-8?B?Ti9GeFVnVzNjd1MwbldSbkwyZlRXRm5XcUdGQmVIZGxUZXp4a0N2aFgwT1ZL?=
 =?utf-8?B?dzlsWEd5N1k4aDVQbStBazY5RXgrZjZoSmg0dzZUNVNoTGI2dHEwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5ff5d6-c3c7-4cc8-92e9-08de6d3d1718
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 09:23:48.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqcE8H2wifu80oWrZHvPI0BB/ixLFjbB3Oc8XdEeuK+Zl/+I2lPViiIV43XKqlHYArEK7cwjTMik2V+h0hj8dX91c64qyvue6BKaMOXAMzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7553
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3OCBTYWx0ZWRfX5gHlsKhRL6il
 pSD6YsYz2jDjS80uTeVqFB5HxYqpHRok6oZaJ+HrEzWpi9BcYxHYPAfcbHLMitRADJbMyyEOn84
 0aQ/LvNWwnNjJq++G1sxU5WO7ByOeTotZNssG84vW2z9DtgYt+ks2N+GC1LcQf4A59l0kV50CCK
 S0uau25qYZmvSE4YYnLNrYgg+RTpHBMKKR2XGxW5cNMcXHZOyxxuq5Y07kqq5zbFWEci8fJAtxv
 Wh8rBsSGzsxmjxss+g+8zBhH6o6/Aa9SsssMQH8CIlVi0NoA/WCR+6Mlg+t6cmYX8PolYnhRpjM
 ewjRU/O2KHcjpJbMvi1GGLpdFyUp5PMGTuPIqm9ImnsP8/yoNi9trbzGW8xs77rZ3LTW174kLZ4
 3nfiMhYxD2ITs5WUsFbEVDtBV3NBmmBvLqYYELqdGQVpABEMRs38R8nUFA9R5T21ZNqpamH/zWM
 9KwrGt4vt+yizEm/D8w==
X-Proofpoint-ORIG-GUID: NuOVJaGhwRh6Zhpo0h0pNSMoBR0oe2Tf
X-Proofpoint-GUID: NuOVJaGhwRh6Zhpo0h0pNSMoBR0oe2Tf
X-Authority-Analysis: v=2.4 cv=TYSbdBQh c=1 sm=1 tr=0 ts=6992e228 cx=c_pps
 a=DSCxmJijwPVh9NBC5YRuGw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=iJHqnOsZQxR-P40QC7IA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160078

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBGZWJydWFyeSA3LCAyMDI2IDEy
OjUzIFBNDQo+IFRvOiBNaWNsYXVzLCBBbnRvbml1IDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9nLmNv
bT4NCj4gQ2M6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNo
LCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbiA8amljMjNAa2VybmVsLm9yZz47DQo+IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxp
YnJlLmNvbT47IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+Ow0KPiBBbmR5IFNoZXZjaGVu
a28gPGFuZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4g
PGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDMvNl0gZHQtYmluZGluZ3M6IGlpbzogYWRjOiBhZGksYWQ0MDgw
OiBhZGQgc3VwcG9ydCBmb3INCj4gQUQ0MDg1DQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBG
cmksIEZlYiAwNiwgMjAyNiBhdCAwMzowODoyMlBNICswMjAwLCBBbnRvbml1IE1pY2xhdXMgd3Jv
dGU6DQo+ID4gQWRkIGRldmljZSB0cmVlIGJpbmRpbmcgc3VwcG9ydCBmb3IgdGhlIEFENDA4NSAx
Ni1iaXQgU0FSIEFEQy4NCj4gPiBBZGQgYWRpLGFkNDA4NSB0byB0aGUgY29tcGF0aWJsZSBlbnVt
Lg0KPiA+DQo+ID4gQSBmYWxsYmFjayBjb21wYXRpYmxlIHN0cmluZyB0byBhZGksYWQ0MDgwIGlz
IG5vdCBhcHByb3ByaWF0ZSBhcyB0aGUNCj4gPiBBRDQwODUgaGFzIGEgZGlmZmVyZW50IExWRFMg
Q05WIGNsb2NrIGNvdW50IG1heGltdW0gKDggdnMgNyksIHJlcXVpcmluZw0KPiA+IGRpZmZlcmVu
dCBkcml2ZXIgY29uZmlndXJhdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUg
TWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDQwODAueWFtbCB8IDEg
Kw0KPiANCj4gU3F1YXNoIHRoZSBwYXRjaGVzLiBZb3UganVzdCBhZGRlZCBvbmUgbGluZSwgYnV0
IGNvbW1pdCBtc2cgaXMgNSBsaW5lcy4NCj4gRXhhY3RseSBjb3BpZWQgZnJvbSBwcmV2aW91cyBj
b21taXQuDQoNClNvcnJ5IGZvciBtaXNzaW5nIHlvdXIgY29tbWVudHMgZm9yIHYyLg0KSSB3YW50
ZWQgdG8ga2VlcCB0aGUgc3RydWN0dXJlIG9mIHRoZSBwYXRjaCBzZXJpZXMgc2ltaWxhciB0byB3
aGF0IHdhcyBhbHJlYWR5IGFjY2VwdGVkIGFuZCBpbnRlZ3JhdGVkIGludG8gdGhlIG1haW4gYnJh
bmNoOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9y
dmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ODMxODU5MDNiNGVjYTg2ZTBjNzE0NWQ2MmU1NWRl
NzY4ZWViOWU3Yg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9NmMzZTcyNjU3MzRiYmRlNzM0N2Q0NGZh
OGU1NzIwYmNjNWFkNWNlYQ0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ZDM0YWQ2NDY3MjAwMzgwYzhm
ODMzN2NlZWZlZTlmM2Q4Y2VlNTQ5Mg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ZjExZGU5NTIxNTMx
MTgxNjU5NWExZjJlZTgxY2Y4MjM5ZDliNjYwYQ0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9NDAyOGNi
Y2YzNDE1ZjZlMDgxMDMyNmQ4N2M2ZTBiNDk0ODE0YWUxMg0KaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9
NDVlODFkNmFjMGUxYWYzNDllNWRhMDUwZGMwYmU0OGE3MmZhZDlkZA0KDQpEbyB5b3UgbWluZCBp
ZiBJIGtlZXAgdGhlIHNhbWUgc3RydWN0dXJlIGZvciBjb25zaXN0ZW5jeT8gKGVhY2ggcGFydCBp
biBpbiBpdHMgb3duIHBhdGNoLCBub3QgaGFsZiBvZiB0aGVtIHNxdWFzaGVkKQ0KSSB3aWxsIHJl
cGhyYXNlIHRoZSBjb21taXRzIGJhc2VkIG9uIHlvdXIgZmVlZGJhY2sgYW5kIENvbm9yJ3Mgc3Vj
aCB0aGF0IHdlIGRvbid0IGhhdmUgaWRlbnRpY2FsIGNvbW1pdCBib2RpZXMuDQoNClRoYW5rcywN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
