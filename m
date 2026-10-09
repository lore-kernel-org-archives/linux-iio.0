Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434738837D;
	Fri,  9 Oct 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561208; cv=fail; b=grWPcv4bwaUOu49LNBXgfazVmsz/5pk57e6h2bFx30c7rsZCquwIN8zCFtd5c9DZWtFKuLEanHOfCSBYb05kSDDXj0C6Dd+18VARHvJn9Po+NiAQ5pSd+/YnlHHZaGp/glyjl04NqfN3spSiAuP7lMaqJgrZUa6Fqsd12xLzTdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561208; c=relaxed/simple;
	bh=i6eGbJpnesnmwckll91gtKivDQsCyX3Xb7L4uirYROg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lmui6h4X1VNyzwQai/cM6G6aS/EhfhemJ1YO1oesaAis6gz9r5fGZZ7tFVO9RpZJ6LTafQ10mQ6ukj9kFNkkoen/1HmDBrW1diu2hBiVPUKnzsanwVkxHE+FAfM+1bJ37yb3M1P464S27Ag7FtoYJDalvy9cVYfc+041LcSJuMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=RjLKoDFS; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BbLHxdtT; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="RjLKoDFS";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BbLHxdtT"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DN9vM2289188;
	Fri, 9 Oct 2026 11:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=u7oVZD1MkFU1drqMyInhONPz5h8zMS9R6gqJSwmciZg=; b=RjLKoDF
	STiRsyQMYdrb+bTWau796v1w+w1oH3NDe6cXjOKsPSFkH4YyNra1JuVx9DnHcnFP
	SY3ujRt12Pn0dvOokX5JCI0hVvCngqtvgaVdATmiA9DqQGWnAPpVqIUGIVW8uGOc
	c9YXNTM9C89SeMZXEigGNKgvwH0qcwSTPtGAIGrZAQMcTdAElv9abGixhsz7ZCt1
	YKpNjdcq3Jdt6o5vHfZDjDwr9EhwbOzPIiF6+Ts5NDnXf8bglTp/3PPlC5NU1cFR
	5tQgN1ORAvKc1ZwyilyojyeyepPuGBAgy8Zvsib8HTLBQf48JAxlmZQnoqAPQsL1
	qxTemHoBrXNRpDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=u7oVZ
	D1MkFU1drqMyInhONPz5h8zMS9R6gqJSwmciZg=; b=BbLHxdtT3ug5lpQx+XbzI
	hoFEKumnTYYYsb6n4kINF1BFsMe+zJYsle/KsARgZPrNzTYWDNev55D7RYB9+aYZ
	CH1nwb/OoyWWJa5irfiWd9Fg1rnuHpiAEQRonJosA53l29wsx/PuxK2d+bJvM6cy
	S8/4vBLTO9qdbUI/3XrfEjw1+1ooTEx6CcNR4FJdzB1I6g1W8D0NzWYmbBVgmmIq
	N5naMMqbsIFnzQFTxObuFH2ZTIMZ6gNH5LMThz5+h5xE5dBn77AVW8JUKuq2faGs
	gnuWDVoB/Of/6oOayBOI4FeD6FDZYUBl97GktCOqE04vTF5SehPqGRS/UvgC540F
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h6kgmmvam-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:51:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1b1ePB7pFOh491iZ6vxB9id514zP0oajIuc/P0B0QocgFr2/a8zuPYjNWYWqJZ8sOQqRAZvkLNS0OPwLzN472z9/i2/n2Kr7muwA9NbqA6pCzt8dVMU3Rj3RUZpdrcEk/cQn6QePsDXiWKkfcnKARNJzjoV/TYrDBVq9QuURNAYDaQgs8fAnFpl8YQ+/LqNOLR0hP30mPpkBLZVw6hjD8pUtiFi+c1uB2t4QehJ/bFVAF69CN7ok9k8TEzuGyoupvRtbOodyKFjdV9+J93PYCkdlhh2RI5fNjDlh6asxWpSHHzMXrGXVobvf2wGLcXT3f1c6nb2u5CLqoGVcgI5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7oVZD1MkFU1drqMyInhONPz5h8zMS9R6gqJSwmciZg=;
 b=SMxOPqGs/LEV6MglwiR9cZwCcx+n5H4DZSCRvyOAAVgIfkNwLL6eADrEzs3cR0tnYv9+0TPNF83tF/t07W6sXA/i9L+uTw1CCeUNbpsUl0oDYbKUEunyUlkq1dRWT60R4AKEBbBH3Im1KulVlNKtG6byCDPW/eP85JDXq0SOAAh0wbYECipvX6FUnsyqgFsCeIE400eY6a0StN8u8cswltYARgzEXp515fZJuwh0Qz80QamCCIWe/Q4mLD/GbQe9ku7dghSToMwnRiD7WyRBaGCq/ILJyhfkpAvJMTySp+FBdDYXdfIqBXj+8s6oZsvG7UzJDyp1h2UEBJFKP9SpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5051.namprd03.prod.outlook.com (2603:10b6:5:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:51:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:51:38 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:52:53 +0100
Subject: [PATCH v5 1/9] dmaengine: Support bus widths of 32 bytes and above
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-1-4c4e63a7a1af@analog.com>
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
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=13891;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=i6eGbJpnesnmwckll91gtKivDQsCyX3Xb7L4uirYROg=;
 b=Hg6R4RXO8WyiLHw6UwrgUa6vAh0E/pfI8P2LzRqAIH+FGbuquefsjAWMSt6w0+tkfJ0DYsI+3
 krM2ktwuy7ECxBvmB18jekpCFgUf+QMaKo38P3tTqGMEpmfRYvZtmrN
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0034.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c783bf-c012-445c-6a12-08df261d3425
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|3023799007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 EOFswDMTRU7jTRtYStjE4J9VqnH9/GSTZSHlzb9UgDcM5eV8B86RNm+jF4asVO4lWXqXmwNnBA4UB0sG/O4SUjjZYPKUSnxCtuyvns5jCe2JB17MUnWhTFdC7WCEUdlFA6Bt4DvnnnfJL9iBPvuIY6koSwWYMHhfTog5CJ5r5i6mp4DAMKreP4p1hn7P77vFT5LjNrGT6OSFaml0jdbvuzgJ3XJ3kaE7268oTy568iJwwoKglxhdwRtFuWBiuhwgHjag7bORPbIT6e1UF8AfzkgZW0GAME2cDThTguhi6wiixBiX9STCyKFGe/MDiK57m+adHwjlq0QMX0IRrm6mluxmFRPqwHe1F8I52/O+JG5tx9lgXO0k8Juyn0HQZ4s9eS0ykkmN6jPtNUnUG9v99TJ0erNJyVd4jxHrwlf+coG4+NIoQQsOgJBTJ23umro69Y7f3cm2tTDHjgHnAJM8pa5JA2BUmFzkPF88qOT4c5Gfn0mEhCn2hQoJf4r8Axbi1YEXdr1TIQPVTYhT9xIO5L0rWDaAKonI2Lb26oOKx7JKg0s16DKVMTniUdD7N9OE4WAySfmKgcxdEeCd87pG1rK8XXI0uLW3jFIXZRIxK86VFx87TEgArkOXaveR5dFkPDy5iSegUArOtlVksoxe71UyCZrE6HBloumoJJNIfRw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UUk1Z0REYmN1dWd1ZklsendyM1IxVXhKYzhXeFBBbzVhbDZhWWhFQUlmK0tE?=
 =?utf-8?B?KzB5bCtyOWlnK1NaKy9RbS9lN3JVWkxpQ1lGTGZNekQvZk14RFZMQzREUzR0?=
 =?utf-8?B?c0Y5b08vSm9YQTV3UkVoWVJJbktheUFzRkN3dVIxZ3VvSFhKbms1VGlHbVBZ?=
 =?utf-8?B?NGZhWTVFZmFPNWJkN21VNFBOdDBwM0JUQVZib1JMbHVpaC9mN3BlZ1VGelJi?=
 =?utf-8?B?S1I1N1lZYllwYjE0bU5UNDNkblphNUFVclluL284THhRSUs0d3BBbG1LTlAv?=
 =?utf-8?B?UDNkZGluOC8wYnQ3dVBNNHVFaHB5cnJseityMzlxK1lPV1hmbHAyMmw1MWtj?=
 =?utf-8?B?a3NCUnNkVW01QzJOUkYrMFliUStXL2FYamFuRDFqMlFaeDFRcUdOQ0NEYWZO?=
 =?utf-8?B?TEV6UFI3c2R3UHE3N0xrMUV1VnQ3LzQ0RFpTbGEwcVhHMHgxMUxaRW92c04w?=
 =?utf-8?B?bEJleW0ybmhrVGNnOEZGT2VJcVhrS0cyOFBBVlY5UDRRdEtzSXAvb1BYRFZk?=
 =?utf-8?B?cFpUenptZWFUcmMyY1RoSmpBLyswM3c5bjZCeTRnbVRwR3dXMlE0dUdPWWlO?=
 =?utf-8?B?M2kwY3FFenVraUh5T2JsNjJUTDdybEt0MW05c2U0MmRaTmhuUllGUVVPNXBI?=
 =?utf-8?B?bVhrOEh2RTJGeHk5aEljWnlBanF2dEhiY2tVZzRlbjduZC9pa0ZoL1Urc1N6?=
 =?utf-8?B?enZEbGlBKzNvS0lZemRqUmQya1M1NTJWYm1FVUhlbXIwRFBTbHJ5RTF1YXBq?=
 =?utf-8?B?NEMvRVY2V0NuNTB0WUNxZVhuMDNES2FlSmd3UGU0K2tSYWNVZWRmYmYvS3cy?=
 =?utf-8?B?aFF1VUhwKzBSV0c0L21YelRlN25oQ0tEZjNoaTNsNTMyQU1WZWFxcXZBaWFM?=
 =?utf-8?B?dDl3RmhCTWJuMXdmK0hxcW41UzJoWUdOcWt5VWJ3akYvekRxTjRZaElNQkFl?=
 =?utf-8?B?b1lrNksxM0oxeGFLN205eFpMUU5ZcWpBZEM3ak1kNFBLRC82UWhabHJ3YTFs?=
 =?utf-8?B?STFkRVpIVnpHUzZCZ1krK1M5LzI1elMzZmkyb0Z6Tkt4WlpheVAwV21LU2sw?=
 =?utf-8?B?M1hOZW9xb1ZnTU1KY25pQnJQZEhsUWY2WTFhZExXNzBCSVF5N1dDS1Rqa01h?=
 =?utf-8?B?TEg5Zk9ESDlZVnc1aTM5R1pxUDJpYUpLNkkvZkFQZFloSDhBVGhFbEIvejVp?=
 =?utf-8?B?Wk90dk03WmdBUGU5TmtRN2tFVnFLc0lOYTNWT0NuQ2Z6YnU4bzh2blVteHJD?=
 =?utf-8?B?MjBUODhxUmNicmxTSllRRUNrTE1QUVEzY2pOYy9Ra2JNN0lxMmtyanRnR29k?=
 =?utf-8?B?RTJmNm9JZnlodWFQVFZHMVJFdnB0RTN2YTY1MVNOQlBNQnlRZGgrYTlKKzFX?=
 =?utf-8?B?WUdCUHdlM0ZoS0hwUTNlVC9XcW8wYlkvNnAzVFYwMzhJUHo4MEVEdWp0NU9Z?=
 =?utf-8?B?RHBmYzQ4bzlESk1UNUZXRGNKS0NIS2ptaitlQVc2MDhoUEVIT3V5dm52c0d5?=
 =?utf-8?B?a24xS1hOOGJZeUM2VWhEaVd5WndHaHNSR3ZoQVBQajZIU0NwV0hiSWtIa202?=
 =?utf-8?B?Rjh2cG9FSWtZWjVFdjBsQ3QrMlhwbzRhQ25KU3dNK0RtQ0NWSUFyMVlacXpF?=
 =?utf-8?B?dlMxeGZhWXVoZFNGWXNxcTBleVBzT3FpYzR5TmdJS1lDbzBRajRhNnpJQkNG?=
 =?utf-8?B?cUQ2UVFqOUpJdmtJUW5xK2kzcHFYUHF0MXA4SzNGS05SakNzbmhZaWgvbDdV?=
 =?utf-8?B?ck1TU0QvVUdMUW81U053S3UweWx5RC9CZThNWUxIYW9tU1V2QTJSdnUzT3pM?=
 =?utf-8?B?RkNnZGx4bFVzZG4yR0M2djdxeW5GQVZ3TnRkemdhSGh4Z2tKTDdRNzJ1THlF?=
 =?utf-8?B?MmlucGtJSGhTdFV5TU5IcFVDdGpKRCtGR0MrWlRyN2FPMlpGdjJFWVJ1Y3Fj?=
 =?utf-8?B?aHRTbFNMLzJpR3B6a01QMU1pYVpTSE14Z0h5VDlHTXVRdFdDanZoa25CZVQr?=
 =?utf-8?B?clRxVUV4aXl0T2ZXOC9LQUJmTVNZbUlYNjhhT0NERTY2aUFBVjUxNkR4SGJ0?=
 =?utf-8?B?cVNjMUNCZ2hoMUdmWThpQ0tMQitlYnhWOHRqb2hDazA3aTlzVGp0TC9PWGFi?=
 =?utf-8?B?SGp1U1F0bEFiNU04bWlEbTFkY0wrYzVPaC9BNTllc0ZiOFpYNXJoTWVrRWND?=
 =?utf-8?B?NG9LcHh5M0VxMWpUMDJFZGtkYisyWk5hVW9tc3UzZ2NvWUZoV3M1aFhNbmZR?=
 =?utf-8?B?cnJUOXQzbVpldTY0WW9waEt2M3ZRY01pRkt2aG1OdnNxZTRjTkpxSjBBbUtR?=
 =?utf-8?B?Y05PdDQ1V1E2R2xEWnArcGk3cjV1YUlkNWJROVpmWk5iZUZOTHViQT09?=
X-Exchange-RoutingPolicyChecked:
	OH2n55KpphvGsPUYS/D4NRWISafdOXPeQOMA6jsav5i27qX4HHm2y0nFRFssuwVX/oyQFZNCxWOPa8VSt7ZW1o6Xihnucm5oifpt8DVMVbGtg2/jur7oYM5OAjD3VVJXRTZcVAm3JPbNq9yJRv9VeWlR/1r86Ekvi+9qgpQk0dBt4fszD36/5K2umEhDu2jhIfUzgQ//fn8qqrfQRIUWA3ZsAVZBbP1nBGJfUBiRAl7ugioO5vUrS3z3s4Ym/WaSJE+5uREulc/HKdGXGAZvB7XFD88iVK6QPJSUq0r0X/udKDl4pJ5q3R2bnIB43GNIgLNXeC3NufSYYe63EyrQGw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c783bf-c012-445c-6a12-08df261d3425
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:51:38.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cn5OiDy7bDRxBNNOpez1xkmHbhgxr81Te7tPQxt4xpQo6HF5V5X5V4hXwg7r8r4koGhFv9oETCHOcfKRQ622fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5051
X-Proofpoint-GUID: 07gfubEU9_qKjlcQkk4ATxhAvgQGUPmP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX4/MJyAILblLI
 bUHbQT9MMUlJFNAk0cii4YeysMexZa9gP8nBMVvCEIUG9RD/uvc4y+4H7+R6R0vw67VBwiMgIbw
 zUbMJxTxfqPGAOACnYrQjQfVqFTfRbgw2HXkCUbEDEe5x4lBRSKs
X-Authority-Analysis: v=2.4 cv=Avx7T+9P c=1 sm=1 tr=0 ts=6ac90d98 cx=c_pps
 a=WfYMUjdTTdEkkNza/pHfSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=bbKM_mjVB8olCydZLLoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 07gfubEU9_qKjlcQkk4ATxhAvgQGUPmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXxmb9Z6ZcU0x7
 SV+DnoOAfuwdJ6Cnh6E1QbO2LaEGgcY++Te9upXAPbBzYNCSkWAGMqwdAl/l0lnb1uR2ukE7iuS
 kbq0xozqcodi+HZmWPl3W2tiIqrLOX+APn7XXliyPrF/giI17IdOl6HdBbPIbLQpAs+8OF0RLMF
 lx+hZOdpk5+3XYwPXmaMEBEVtw0ANCOCLh9OGj6hUHFZDVGyrLzrcnRHDOtELCzdHemOUYDCGGS
 USPnayMWKRbDtux42iBhdXBpqihbYxLgtX8CVoxQyyJ7G1Y2xVQtKZaG99o+r/aiqGVZzXyj8zl
 G+t5na7pGMrNzJrJVitBIoerdw11UUVqYNaKwkb6VqsdM07gD6Tc9cGd3omrch2WZkQ87xSmLeJ
 XwbG1at52fNHo4SHwUYAWU7fvs3AHYze7wYsOTrrmSWuNrFUsmdyI5Rz1LlvnYQsDXgP/ObZcEu
 bH31J5wW05riQWk6QUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090063

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

Andy, did not take your tag given that you're the one asking for the
split and since we ended up not doing it, not sure if the tag is
to be kept :)
---
 drivers/dma/dmaengine.c   |  51 +++++++++++-
 include/linux/dmaengine.h | 208 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 246 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c5fef57b5adf..4ba9d6c7448a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -33,6 +33,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_dma.h>
+#include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -592,8 +593,11 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
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
@@ -611,9 +615,31 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
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
@@ -1173,6 +1199,27 @@ void dma_async_device_channel_unregister(struct dma_device *device,
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
@@ -1234,6 +1281,8 @@ int dma_async_device_register(struct dma_device *device)
 		dev_dbg(device->dev,
 			 "WARN: Device release is not defined so it is not safe to unbind this driver while in use\n");
 
+	dma_device_fold_legacy_bus_widths(device);
+
 	kref_init(&device->ref);
 
 	/* note: this only matters in the
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 71cde09ff240..eb68eea840b5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -427,8 +427,179 @@ enum dma_slave_buswidth {
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
+ * Like __set_bit(), the widths are added to @mask and the bits already set in it
+ * are left untouched, so @mask must be initialized by the caller.
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
+ * Like __set_bit(), @width is added to @mask and the bits already set in it are
+ * left untouched, so @mask must be initialized by the caller.
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
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
@@ -523,10 +694,11 @@ enum dma_residue_granularity {
 
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
@@ -545,8 +717,14 @@ enum dma_residue_granularity {
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
@@ -839,10 +1017,10 @@ struct dma_filter {
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
@@ -924,8 +1102,14 @@ struct dma_device {
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
2.56.0

