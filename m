Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09A38E8A1;
	Fri,  9 Oct 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561225; cv=fail; b=oTVu6bTATcLDn4qyJJkAoGHSgJg4WzHnARLpzfNj3qBqx9vXLSiWCcK6qjafMb/uSuZONnuOs4pbH5Ftf9cvzE/KDIJMOlm2NjxtsxmZFif8Ayk039pRKTGzIa6ADW8OVQdWEtkG1WVfNVuAU4Cq385PDi8NOUMfd0ZkQWDIyUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561225; c=relaxed/simple;
	bh=R1kasKswpeP16RMxsmgzmUSMLnsjXU9QuGz8Md6woss=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XtjzPzN1/b78XQjHC0hpWiejoHlUkEKwwFVoYsi5QZG6rlj4ZfMLIr0SsOuikp5446MtF4e+y4ScLWPIXqeXTXk6JIAmj4hsIYw7leh1eRMeFxEbEUETDJaGfuPKMWzxLmnu6gTZWdnbQi4IYCMxNDZAghE2x8WP+5htdJFSUH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=ax0Hg0KO; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=t0M5DsNe; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="ax0Hg0KO";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="t0M5DsNe"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699FKwDb2149848;
	Fri, 9 Oct 2026 11:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=disbyrhC+/La1dbUAeaB1xtWXaez43nD3RwwqUOjd8c=; b=ax0Hg0K
	O8UyhrIkz7neWmc4XwDRaV6asNntpp4v3pmk2k9JaWWwQTky3oJo06sB0d3by+tH
	nMkmgDraNNOh/cm7cy4pSwa9eWLGfpmzL6ELvDYwiBPp4DHQnRqEB26a9qbxkcsy
	TGsCL8UV1IIOtZk7Y/s5O0Sru3WTZjop8L7GGfUZIkMkv2DcowjE7lPX6s+Z+2Je
	ia6tTuL5oHl2q9z12OBOp8T/k7xLdlNkSC6FvicB4xgCjRlSh6vnrF2bXJNBu/iR
	f1VuUYh++mOBJMWd6c2n8zfV4KSKcEbzFCb6KoRuRWOZrfSFcAjI9c5O/gMfhRWE
	lUA1EikwbO8Krhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=disby
	rhC+/La1dbUAeaB1xtWXaez43nD3RwwqUOjd8c=; b=t0M5DsNeVKUk5/9/UryAI
	7t1GdN2pZ9tM0vYpecs5DI4anaLZcPSbkxAcxkJ3FJ5O5DBsRMpeyOTNAK8wjoZy
	ejVkwhAtQS38wgFHCpS+VSAMhBIRuZwN2WIENFleAJoGeMwMe9HHXodSqU97UgSd
	Txc4O2BoTZArJwth/TOXadQObZZkGuYkiwr3AtLLzf28rCwdumZdVaEjDGvXVdHA
	kZFuDy5hW4uEcqK7hD75H8epz2KtUMDrII9DLLWKkZg3mWJ0FADl/z0EtXZozyjx
	8AHogMQArzsZjg/hprCqZ7CA0KXEOM8I0JE8+rdRTSnSvY3mEwn67V+b9XVyUvl4
	g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h6kyswdt9-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:52:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kj54jDwk8jMUQDUMoz7D//Z6K4N0Ja82sQGnpIYXEi0cT6lrHQVlf/6PmG8k1r8mg32NjIlf7AEkzw+HSUOXDqPN0mLZE9j4K9MA8aP3kvoPJXjQ9O8609DCx9n/sEkWIoBponUX1P3RNM+zQBLb6M7C398/0KW8Z+Rb22OLNUlaVi6V220gCCC7HoD9sTMXY5xv/DUnGH9FN212p/L+sBfDop3GHogMhlZv65GsN5cJk7LxlQBtSbzRN57KzYO3h9iP3nBolnkDrRRtXHJ8PeujG6iyXgk8+60ifPS4atuW4PER8ZY61/g45JxFUn3e/52mdHkNO3EI9hAhusqJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=disbyrhC+/La1dbUAeaB1xtWXaez43nD3RwwqUOjd8c=;
 b=F+icqKfR8c9GVahSsMFoZFiAWAWktMRib0ekyJGlP0ALbh7tCOu8t4hxl4GIFzB2zsPA8GWKinQGszvZXbHXWyddI+SOdMOvS4fruxwJSUqUyzU0LwF6ag9fjax8LqSLu97jbrhmBMb+zDJwzLp1ThnlibkGsLIHPIrLfwaHY4r3IJC/lntlStQhFm6a3t6XRpnv6d0Rsts/5er+g+BEIBcAzZflxXKpu5jPu6YhPguwLVifiZtxpQhBf42HN2OgcFIUtm77KZ7wt0tGzUk4OFmOyxNyvIZMNbNsgvL0X2C8Dlky7pw1nkZMTHBRvl2PbkqAgg7LxaePfte0P7u/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB5496.namprd03.prod.outlook.com (2603:10b6:5:2c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:52:05 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:52:05 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:53:00 +0100
Subject: [PATCH v5 8/9] spi: dw: Use dma_slave_caps bus width helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-8-4c4e63a7a1af@analog.com>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
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
        Frank Li <Frank.Li@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=2297;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=R1kasKswpeP16RMxsmgzmUSMLnsjXU9QuGz8Md6woss=;
 b=+E8K3w54QmUBHlnTEFfg9gb1ocdA/DhrbouDHGw/iIRtZjzKWluMO4yRIXQ9N0edw1RZ4xQIu
 D9y3Wsq+hNVC8i1jmshSRnKTLm0B78/5U5HoXi/JHWemZhWs2aHW/w8
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0013.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 18dfd38e-0a66-41dd-b1f9-08df261d4448
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 3wPZU+X4nb4F9whFbbbtjqUYY0EBEITkU+4cN+FwpsMoT+B/Iw7KH5WVLX6Uh7zvEZo7DnQzv2wKncNCYoaU74JLmAVIUf6tmTYbyAPnwRBxTcXJiPpH6RTpsM99n1YmSvneJQhxoXz0iqEBNNuVUfOYhJEV2UodG6IFlpZQdFh5rPkOVp8ASY1RCknhubNGU4d0pO92lmSLj86bY93E487X2eA4MRP0t8PR9O3Cr3XdOTsjILk3aVnxdf3U3R+zu/Sj6zE+ZUfsF/pruI3u/lnetTkTclyGpBV6MVCmKiRhAyR6gXZeoRXCPZtuUtH3K97IriNNhgT9wCj63m1DDc0C7VYVhyVSQRY9/YfPiapTKw5u6ensPAiFUoGif7zC1AtvDK72QdmNJWn6O0uoxLKjNkAh7LSY4kODjZqzx3h1XGKYlIo0Gxgiyhca1kNJVXDhDnxrPliFOELYRBo0vGE0ff9Uy6uQE6F/rT3BCAYHmrp27yKyU0DmDn3eZ3z/hBp4UQRthkIcfhlEZLz7PMfR6iRaKp0jC9UpSLTU4EKehSBkwCTapeHlTcXlX1uj1u+mvvEpDUtmz6OU2QKsqLJkyqlIsVQ4dJu5EzE45cHvCiDiO+fVbyYsO5LQJXZEbY7LpjXncxzyc8j8dMx9q14MFvipH84WUSEweaW094A=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YkpqOUVXL2svUko3UW5YQnoyY3Z2OEw3cVBZczJGcm54S0NhR1hrQXVSODk3?=
 =?utf-8?B?bkU0cEdxR084MXYyeVFsR3hvUFFPZGVtWDc5T3FDR2pwR0lVR2xNK0dJN1VS?=
 =?utf-8?B?eE1LYlhiM0JEZTlqN2dNcTJjT2NTTXg2NXlScksra3J3WS9IYmdDT080R2sv?=
 =?utf-8?B?bU1VNVU5anFJektIZGk5ZWZWV0c0TEJ2eGpLYWdJZ1JTRGphWU5Ub1BqSzR1?=
 =?utf-8?B?cEhzcFhZRGxPNENHeXRkdFB1b2RpbmJ4SjI2SmVwSlN2NWFpek5tdXNCdHJ3?=
 =?utf-8?B?TlRoQ1JzMVNCWVRzZzlYbm9sVjdWOGJ4OUNsVEFseGlYMjU3aG1NVXc3cTAr?=
 =?utf-8?B?c08wbWttWHhuaDVqaHRFNnJubnNJdTRCR1dOU2xMVFpyZFhoR3Q0cDN2Yytm?=
 =?utf-8?B?MHpueDMrYkV5VzZ0V1JubmNaeFJkWHFWS2pxM0UyQTRmWjlvcExLZzRPMW11?=
 =?utf-8?B?MnV1OUUrMDRzd09wWEpHVDV5V2tiQy9NN21RT0NrSThPSG9OL1BCVEtudW1s?=
 =?utf-8?B?THQ4ZlZJcFZ5ZFh4d2hQWm14cHEvLytwOVNXOWhGUy96Wm1NMmJUMzg0cWs5?=
 =?utf-8?B?Z0ZuOXdFZ3F2YmFsdVBTbFVhcUovMjZkcks3U3ZYTldHMURxdkpOMys1VXpT?=
 =?utf-8?B?Mmhzdkk4V0taeXhhMVZYYUNtWkNiWUhoMk9BclREY1NMcTV4Z3c5Q1c2aHdj?=
 =?utf-8?B?c3lLcTErMkRBRVc2dU1YNG1HVjNYeGZjRmZ4b1FSR3dBNUsyak1UNHpPcDhM?=
 =?utf-8?B?TE9BVVM1UnQ5VUdiLzFxZ3FJclg5dUc2ZFE4YUhUR2JPV1ljY1dKM1gzQkpI?=
 =?utf-8?B?V3BsUnpTUUJCR0N0bFI2WEFUUkRxUjgxMFpjUTVkbTFKUldwZ2UyalZhRFR5?=
 =?utf-8?B?NzczQzNZQ2J6b1lGOW8xU2lzL2pkdzY3VVlaTHJTN0taTlhFbjVpeHIrK241?=
 =?utf-8?B?eVZDN3FiSjNsZTRZR0lUNjBSMHdvcEtETnZsTW9FZVU0UU9GZ0xDNHNYNGZ0?=
 =?utf-8?B?eUxhRGgvM215YnBxd0piY3grdGgrRC9sMmZrYlFhYnFmdlpEeXJRL29TVU5a?=
 =?utf-8?B?WDRxZDE5ZDBwbzB5T1N3VUJPYlRnQ3AySzNyMHJpeG5JdFJ1YUJTQy9DK0R1?=
 =?utf-8?B?d1EvV0RwVWkrMVVQL0lHRlpEbXV0cUpZZ1VoWi9Oa1I2WmZITXJHd3RDcDg1?=
 =?utf-8?B?ZnNiM0tlTWcxME9uaTlBazdOaUZBZ2xIaGtCREhiNlVTQW8wdDhLZ1hCSnZw?=
 =?utf-8?B?V1lxNklwZTBkdnFnQ2k4cEpaWHRIak5JZFJ0YXNBMFViT2RleUpQK0t2Ymwz?=
 =?utf-8?B?NWxDSU1tMXRSbC82NDRHRmZaWnMvVnU5OE93RnBPTHRPR3BZaEhGLzlVd2pI?=
 =?utf-8?B?SFBkQk9qVktORHA0SnBpMjJNZTVBV3hvSzFoNTdPcjNrcFlhbDFhcFdjY2xw?=
 =?utf-8?B?TGlJdnBPblJmVzdUT2hXRzVjcVdCQ1lNL296L2w1TklHeGYxVEhBdmpyVWdU?=
 =?utf-8?B?TkdJT0Y1RGRLY0ltb1hPdVpBc2pEYndoMnRCcFZYNlRpdkZ1OHppaC9UYlNo?=
 =?utf-8?B?RHhHVTMrQjB3ZHptbkYxSDR6dGRqazM0NDl0aXM4SU1Ya3BOSlovWXoyRGdq?=
 =?utf-8?B?SHFvZFJlU3cyY0RoNDBUeUVGVjlhT01pY0J2TFVTWWN5blA5SnNEbFBGM0dU?=
 =?utf-8?B?eFJNZG9NT2hEV0tlMVZIalhpZHdhKzRkYXE3aDNhSGE2Q29uWDFTczd5YUNu?=
 =?utf-8?B?SmFtcVFjVitzc21tTTU3eU0xb25tV1FQdlNEeFBKQ3A5bTBTUHMyRFBKMnpo?=
 =?utf-8?B?VW4zbGRNLzFzeW9Hb2FhZ1dES3RpeENsS1J6dG9KbHVxajRwclV4bHZkTlJ1?=
 =?utf-8?B?Yi91cjkvTjBVaTlWekZpM212SUs1NjhBb2RnV09OaUk2eUlycldsMHVGRmIv?=
 =?utf-8?B?dUdzamdnTituRGFKQ2ZJaEVsK3FqVVFuQlRsekJLRDF0aS8rUThBWUlXbmd1?=
 =?utf-8?B?dExXamxrR0FJRjJXSEJDM25oSVUvOWtFalNiQnNlNksvcFE3bHhzRkg0T1E1?=
 =?utf-8?B?Y05SdU5VNzhKbVVneGxHS1RMZ08yaUxKQytiSklHOU4zcTkwbjZMNnoxSlJk?=
 =?utf-8?B?NStua3lTMkV0ZGJGY2JOWU1hVWNpY3l5UGdJa2lOZEo4YjlpbE1mTzBrRHFp?=
 =?utf-8?B?T3F6dWxEYUZlaXN0bjg0V0FLcERFWXFPOTVId3gyYjhnT0wzTFRIY1NzajYr?=
 =?utf-8?B?WjcwdkU1Y2FZZEhYZEl4dVhURDRjWGhQMGhRMVVreXBzQ0RhVzYvVHVCR3pl?=
 =?utf-8?B?V1M2amFkeUsvV2xTU1lWN0M0UWNPaktmRVZLZVczOWZZTklXVnZ2Zz09?=
X-Exchange-RoutingPolicyChecked:
	naqzHIvDmYKmhNoEodkXP9ihztPAe4dgITxI8qAjdQmq2ygP6bzqjnAe9N6zhfTIsN9zhK97bbm3V7AVAlJQRBRNhxdZlTmvRKMBIW3x9EpN+62IvcxYI0BjIr1cC/SOft+tTkuhkc9OgNYIIpZTOv7FQY9ft8iFBX1sDUG1WdKP8IzH5/iP3sxeuZ0iX886U4NFEU2Srg5IMoAq1jPJTLps3WkEoohnpudvmdQgFAh5MUpOMKAEm4sT/lKQTwlcWPHGX0zJrNUFuUESMRBE1vBPvFqZ13icYBuHXgO7hd7dshMNboz+gAGOdeoHfUagZNvNEEbJi8PfUjfBH7Nq/w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dfd38e-0a66-41dd-b1f9-08df261d4448
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:52:05.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5dXxRy017fkF0veBNl1wYIaFUsHfsenY8GBoyuFk2kZaMGRFK7TpeN023M4mAuRalMyNLpY2K3d4Pto0NJSIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5496
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXze4To5VV+1qF
 dLZpxABfk5YfUalZRF5bpyJcvIXTqvJfU5ZV0UokDH9/v+/sSX8k1F79qv8Lfq9d5Zy9nC1j5sc
 Ioh83U+WLDACKmxTjtityTKD7VmPYJWVTLnCocKZeRvzEvLssLJZZIHVZCs+CjK5oLLfIL0MHD4
 q/66uGNNYU46fpMzcWzyL1saQKuAtVXCHq6NA40LoaWyfOt9z3c4VAY+XNfk99Nnd7oEMKO6UxR
 FJXcIEF9MEQ+CXoFzpuh0mAP5FWjQFDWhbht5nDNIkGonLxakbh6Dl5nnBeLR/U8Q7WAx6iUmJI
 4UwUeSuX4cDFzEKQuHAghDvPodvFkC1S1Meq08YEh7cYdBg7tMT2Px3FuuIzsTFO9GPFIWwZFc6
 7LQT0pQt1ABENfvmb3IZ2Q/x+pDLJ0f/SaxRIw1QTPNt6v3eUZRNqlAcQG8BggtI7U3naomVTni
 RnlvXlk7DcQ8O9D78fQ==
X-Proofpoint-ORIG-GUID: gHw2jU17EDiRkqkCwGRmW5K4872tdCvE
X-Proofpoint-GUID: gHw2jU17EDiRkqkCwGRmW5K4872tdCvE
X-Authority-Analysis: v=2.4 cv=VbVir1p9 c=1 sm=1 tr=0 ts=6ac90da9 cx=c_pps
 a=uEqrJT4jjddHaitOG1ym6g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=vrfzlmHFqV6-XNZspV0A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXxA4hSttsza2a
 fa5ZgUNlyMlpHC97ia/ri52tANMJrN1xZ6s+vrZ5WmRQlOQQpEOvFjH0D3hsFzaBkW7vJ3CrQ90
 lJLWW27ODDONosoUlmZETsq/vkDl8MN9J9K+90nbNNdWe7PDkVJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090063

Store the common TX destination and RX source bus widths in a
driver-owned DMA bus width bitmap and populate it through the
dma_slave_caps helper.

This avoids depending on the legacy src_addr_widths and dst_addr_widths
masks returned by dma_get_slave_caps().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-dw-dma.c | 7 ++++---
 drivers/spi/spi-dw.h     | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f7d848fec9ab..8fdeef653f5c 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -100,10 +100,11 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 
 	/*
 	 * Assuming both channels belong to the same DMA controller hence the
-	 * peripheral side address width capabilities most likely would be
+	 * peripheral side bus width capabilities most likely would be
 	 * the same.
 	 */
-	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+	dma_bus_width_and(dws->dma_bus_widths, tx.dst_bus_widths,
+			  rx.src_bus_widths);
 
 	return 0;
 }
@@ -254,7 +255,7 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 
 	dma_bus_width = dw_spi_dma_convert_width(n_bytes);
 
-	return dws->dma_addr_widths & BIT(dma_bus_width);
+	return dma_bus_width_test(dws->dma_bus_widths, dma_bus_width);
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index e62f919f1188..351034bcbb97 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
+#include <linux/dmaengine.h>
 #include <linux/irqreturn.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
@@ -228,7 +229,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	u32			dma_sg_burst;
-	u32			dma_addr_widths;
+	dma_buswidth_mask_t	dma_bus_widths;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;

-- 
2.56.0

