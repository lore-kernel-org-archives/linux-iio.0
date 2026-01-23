Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C8377574;
	Fri, 23 Jan 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162968; cv=fail; b=KJM+uuPf+0sVTxCRYtATJ1fmUXgK/YTy9lUTGg2n5oJ/cj8+VJvsAdfLRr/HoApbh0bIgRU6CYjGEK7MXsXEHVRwJ2vFiyDzRE3cU3Jdh7R6wbt++WPKxefCPaCj1IrhU7MYgxaR3nusUO9RB2ZzAmFkPg6+WUW3mDQg+T/iELk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162968; c=relaxed/simple;
	bh=+jb6VBSER++KLYKTj27ZFiksTSoq5k7FjV/BzJO9Qhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TYPnXna/+HW6JQ96wFo6lNrDUQ8WWr7CTDzcte46vm5wBXsCYXqBP8CxONUiOBEyX6ztjHK3lyOoIIfvltiZwarDVq5Iqz5dpqp4DFdfO272G3AQQgDonB4BbjEssfDiPB2rJnRkvDAnWdfqvF1a9NbVfuVe++qMN9GHcKebnvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IOq0JGt2; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IOq0JGt2"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N70alW1500335;
	Fri, 23 Jan 2026 05:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+jb6V
	BSER++KLYKTj27ZFiksTSoq5k7FjV/BzJO9Qhk=; b=IOq0JGt2BJXNGU2lsA5mO
	IGCa3MHEtSz+uSz1VbsVFoqHKvwN8paPBFuOtS9a65r0gwCcGkXCOni0KQpAxXQV
	VUSaOLeNv3YDhle8Jhsgy8KEPxBFnl1FTzd0y3ot9VDe3wIkfriwqnqhHn9mL5eE
	+BQuVFFCvyn6ALd8DL/4fGOZLy/aC8mw9KK4zfyNwd/NJRc2qeH+ER6I8vvJHuhB
	byQvhCi+MsCHKicvS1t+1dqxepxKrQLQxBH5e7tiL/e0HBnaazSh/eUPNxzoM1HX
	D7+nVR7DFA4cMMChNZ8QYlp0GvX0ssp02zvCigan/6XutPRk4dFTyH/8CyI3Xsvz
	g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4buepd71xj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 05:08:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtcyLbArrv+PI1Aq/cw35+HXHU8izxYbrSggHH98WrwWxAtjX7Z8ikiS+XYCvJthxvYRSlZlIXTn2XzZz7V4uYgpjLMvIIWjEkOKR/eiq/YVJ9z1J59SAlEZ/u/HI3MFi9SUAcgXUujKjHaLqsT2yv8Nd3lgJrqV27HLgvGOFGsWu92upUWTiEroToiEtmtOFnVclD6q4afH+k8qyhMMLYZc7LQGg2eUdXNzZmh4c+uQfRMNFSBeIinf2GhfPeJAurRm1gjNnLtcHpil+v+F91Xs/N85raunnDh/WM3yFCjzvJjh+wtTdVOxNfalda8gRFSXD75u0lWgFmylP/fa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jb6VBSER++KLYKTj27ZFiksTSoq5k7FjV/BzJO9Qhk=;
 b=mfGiPPPoYkKdeyb0lSpH90YVh5wlde47yKS5Y9xdzDys9RNyQz83fVATw7mkshZjuMoaeK6CANxuUV1U70gX+SFF58DD9vfmqGhHANWMsijiaB1NGAo1BoV/EJZCWP97Rv8V7Pj6xTFL/jjrjwfU4pDBxSHvv3YZ7Cp1yU01PPAuytxbGz55poMo6fzIBe0bH2KY5N12JFLVtiiVdwfTb1qs+3xsREgy9grV3atxhCRezudqlpkozJzzNoF8pKj4Z/jC9rTlQZL6gOrtLhDhixrQOuwd1nL4phV00+dWoaFFaMLyEaj2BevPBU62dKAr3zacf+UtrMY1ikfXS3s5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DM6PR03MB5052.namprd03.prod.outlook.com (2603:10b6:5:1f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 10:08:55 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 10:08:54 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>
CC: SeungJu Cheon <suunj1331@gmail.com>, "lars@metafoo.de" <lars@metafoo.de>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        David Lechner
	<dlechner@baylibre.com>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset mask
Thread-Topic: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset mask
Thread-Index: AQHceY88Cl0xKNm+LEeFgY0rhC2VdLU7m54AgBFXhICAErNkgIAABdcw
Date: Fri, 23 Jan 2026 10:08:54 +0000
Message-ID:
 <CY4PR03MB3399B1BF1A562DD3FBDF43179B94A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20251230123609.210454-1-suunj1331@gmail.com>
	<20251230132126.217802-1-suunj1331@gmail.com>
	<CAHp75VdOX_h1Ksm4MbYyipiSpGrTp84GTkUAO9L_0o3auR3Xkg@mail.gmail.com>
	<20260111120857.5087e396@jic23-huawei> <20260123094409.111e971b@jic23-huawei>
In-Reply-To: <20260123094409.111e971b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DM6PR03MB5052:EE_
x-ms-office365-filtering-correlation-id: 1517b564-b615-40c3-42f6-08de5a676a5c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yzg5MnBZYjlwQjk3YTdEYUx0STI5WDluRUovT0VEdFNMQUdnRXcrVTJXRllD?=
 =?utf-8?B?ZkNHQTNsTzA1cyt5TG9MZUM5enR4TkNtN04yU2JCQlZHejVPRmhPZlJzUDZw?=
 =?utf-8?B?aTlPOGdEUVllM0dTa2FxZTZBZ1BiYmFESjk5WDJpOVJlRFJyZi9JcVphaEVY?=
 =?utf-8?B?czc3aUoxd1F6TThDZzBjYTVOaXI4Ylh5SG5uVFNiVFpQaXBqbHd6R1o3QXp1?=
 =?utf-8?B?ZEZLajhURnIyaGdERkNyeTgxSElEMlJpekZFOU5PbDd0Mmpyb2o4c1BLZkdH?=
 =?utf-8?B?TElLdEJrbHBHNGtwZUNDRmZTSXIzcFhvamw3TGxPb2hEQjBramFHN1ZmaGVB?=
 =?utf-8?B?MURHcG8vY3Q5OXpyUCtvSWFjazJZcVoyRE02L2xOdmt2OE0vSkcvRkdvQ2NE?=
 =?utf-8?B?aUdBSVNFTlU0WklEWHR2M3ZNbWw1QmtTZjlsM2lGbFA3MCs1YWpwUXpvTlVs?=
 =?utf-8?B?amVsaWVUM25BMXhnSVl5TElHbkZsNTFGWGVrVDRtQW9CeHBMOUdTY2NYVWpl?=
 =?utf-8?B?QWZFeENCdFJGRlJ3aVAxZFBGL3hJYWpjSXJiZlRWbW5KcVFCL0N0UXpUeUlU?=
 =?utf-8?B?WEtJTGdpOHBRQXFMeXN4OVVzSjg2SGZPOWNLQmp6enVoRWRzRENJK3VNZkh1?=
 =?utf-8?B?UnlUR0xPUGpQcXpMeGxKeEZ6aS9Bd0xPVk0yR0dkN0VtTExEYVg0YnU5WXZy?=
 =?utf-8?B?eFZqUEtVUFliczhOZGFjd2g1UStIbjZXMjgrUndBTEc4ckpuZkg3MFo3cjAz?=
 =?utf-8?B?aE9pRU0rWXp1czVzaEZJMHZDV2U0MngzczFyQTlWK3VVL0U4OW00N29qd2xI?=
 =?utf-8?B?dUhLeFV1M1BzM3RzNVhVN1pscjRDMDB4eVpzRHBkTHJQbnpMRG1ZQ2sxV1N4?=
 =?utf-8?B?UTFtSVFESVAwZVNxdTlRcXlrTkc1TFk4d2p3am96aFM5M050eGJidEJRMkls?=
 =?utf-8?B?MS9kWG8wb20rK2JlZ2JzbHE5cnBhUEZ1STI5N1UwWHRkMXdvVVV1blRTQm9E?=
 =?utf-8?B?YWJYQ1RnaFQyVVhPSWU1S3E4eG11NENGWGl5ZVFwRzVzaDlJQXEwendIbmwx?=
 =?utf-8?B?N1RHK2gxeWZ0ZnRpd3Jkd01aeHhSNjF5V0dUdlU4T1Bjc2gwdWVDY0RPRzZN?=
 =?utf-8?B?aFhwbVh5d05hQk1YV3hkQlBBdW1yRjR5RU9xKy9EcndlOVJlZGdVclMrQTQ4?=
 =?utf-8?B?a2dBK2d1azBmdlBubUVrR1lLYzVaSjFpMURYRzV3b004VWw1NXpVYkhTbTJy?=
 =?utf-8?B?VXk3QmpMYWxpaGRkZDd0RFdVZE1vYVJLaUNqRnNqYm9DSDR6blFRbTBYTXYy?=
 =?utf-8?B?Y0o2RzRWWHhPd2J5cDE0OWFTSUgyUWhPRHlDMGlNbWdidytacnNwOUovclRv?=
 =?utf-8?B?YVZDYVdwM1VDeVF2Sm1UbkEyMTE3Tzh0ekdDUHMyQll5emJ3WTNZMWZqOFE5?=
 =?utf-8?B?bis5a1MrR21lRUgxUG5RbVRXT2xlYUh3cjNibkhTVFBpUlJoT0IvZ3hWc2cy?=
 =?utf-8?B?VkZJcmFVSU9XK2d5WWVZTDZqcnEvTDc4V3hIV3lySk9yQzJzSmJ3QjE2YzJY?=
 =?utf-8?B?RHFrekk0aXhPaGhvMElISmNqWmVCYXJkZkN1c0pycEt2U0hVYStGeFd6Q3dq?=
 =?utf-8?B?ck5QM05yWnVDeFBKSzloWFNNdW1OZkZTdi9VbzZqUjdDSTd6b3ZjQlMrRURy?=
 =?utf-8?B?WlpPYnFoL3loUG9ZRkRUV1JTZ1dIUjU2MzNMQWRRbEMwdFdIS2NKbWIxaGRR?=
 =?utf-8?B?a0dCSTdTTlRLaElyVEVaMHhWTFlZMHBsS2xSSUxGVmxHUUZGWk5VV09RN0ox?=
 =?utf-8?B?QVRmNG5JNHRzbWxWZENsK282STRtYTZOUTJ4dE42SmNlcXRqRXdzbHMyc2M5?=
 =?utf-8?B?d3V1SVNxb1RTRGF6THoyYW9CMUdpdW5udjBueGU0MjRDdjdJeUNzRUM4L0JE?=
 =?utf-8?B?N0VVcFpiUzk2SElSSjFOMFJMaFBIUTJMbFVMK2RPMURSUkZIaXhrKzVIaC9a?=
 =?utf-8?B?RitqZHpORUtyNHNkRzhiZHk3dGxOZ3hKODdsNUFYSWZKUzVSSUVqTzRtNWZ1?=
 =?utf-8?B?S2NRd3F0RmovTW9xMjhWMnhybWRBMWVYQ3hIbjEyZUdsd0Nkck5qczMzS3Jr?=
 =?utf-8?B?VnIwVU9yYVVISUFNdmkzcFZLWk5UYUVEV2JVMHlTRmpNOCtJUnJNY3dBeDR3?=
 =?utf-8?Q?I2YWMXLcarx7hPZzRCWdJMQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWZRM3hqSHU1ZWR2aXBYeEJBN09Vb2VBM1FKZFl0ZjhpR0dVTmp5REJXMEdX?=
 =?utf-8?B?b0ZHU0oyQlNkdk9sTzBwQ1o0QnBXajY3NURlRERkREhBckZzK0h4WmJXVkQx?=
 =?utf-8?B?MHNobmtaOERQclVJS3J6eHZ4SEo2cS9JdkJGM01pMVowNko3b2J5RjB1Zk00?=
 =?utf-8?B?dUh6YUJhN2JtUCtaQ3hoWFRmbW1QQkZaVlNTbGRPNUdHVnZHZWwyL1V1dWYx?=
 =?utf-8?B?UHpva05hTGtSdFRrc0N4V3NIZzVFUlczZm9CR20zREJPZ3NBK2FKazdYUGRt?=
 =?utf-8?B?NzA3bktESmwwZUxRSmJrUHhPbndqR01tMjJLckxSM1RjbTIwemI4YXlhYTFn?=
 =?utf-8?B?M2swNlYrUFlEQ3NZL2pSRFNnWTg2YlRka0RCVVdNMnN0cysxQ1J3d2U3dFVy?=
 =?utf-8?B?RlcvQmRlaklBNjJLYWgxY3p2R292aGxGOEJSbFBHbExsQXgzNXFJc1F6Vjcw?=
 =?utf-8?B?d2lZY3RkTENBNDdES1Q5UmFKaHhoT1g2c3FiK3dJZ1IxcHlvNzd6aEV5RWtC?=
 =?utf-8?B?RWkzdEpWRExsZ21KQlE4UVlBUlVZcm8zVk1QVlhkdEg3c2d4dnpjL2VENjVC?=
 =?utf-8?B?MUVBR0NoNTlUVjZGOGhiUnVtVUtOUXNtZGtrNWU2MEJIbjBUdzRXUnJSM0pj?=
 =?utf-8?B?VkRmZ1AraWVVeDhmQ2dwQnRQQllpYzRoM25GMTBQYmxTRkh6cFdOZkQrUkZv?=
 =?utf-8?B?cm5OaXZqVjVZOVdoMk5QMzBkdGI0cmloZDJoRVVSZXFiWlZoT05YRHhNUWtX?=
 =?utf-8?B?RlFIRWhhQXNXOVp4OXJGS0REeElZa3pXSXR1RmtCdWNCeG9OQXVTVlh3YUNR?=
 =?utf-8?B?a0JMT0FYUTlLbXo0NnIzYnN6VmZCNmt2d0IxbEVUakU1dml4U0p3cVhNYWNJ?=
 =?utf-8?B?M3ZkamhzZHVmU0tWelR0OVVIOExGMVJTaEN3UHAvb1dtSHZIZ3VZdktkcXNr?=
 =?utf-8?B?Q1ZHUWg2c0txVkJTTlJkQVFnclVFalhrclEwUnZHWEFDMWdlVk8rdXZtS1Fi?=
 =?utf-8?B?MTY5N1pzK1EwSkZqUk85QTcwUSthTVdIS2grUUtJM2ZseGVxc2kxejZta29j?=
 =?utf-8?B?ZHozdXdhTkFjWE10WC9ia1dSNXYvS0NCeWd3ZWlJcXhVOHZvcWRJT252bnVV?=
 =?utf-8?B?aHJGMHZ4WGxHSFBkTmRYQ1NqV3RNNjJTNHJ6UVRLbTN1QWNCYkptdFJhYTBE?=
 =?utf-8?B?RHdRZUNnRG92eTJhME1ZcDhiMUVhcEFKekdsblk5T29OQnltZnh4VTNxTW0y?=
 =?utf-8?B?MTMzUGJ4TkxoR1dkdlpnNXpXd2d1ZjJva2laZWVkZG1Nc09BRHhkSHY3QjBs?=
 =?utf-8?B?OXpHcG5ocHJSRGVBOFhtTXFTWmhzTlRRcEdsNzV3dm0xV2NuWklvOHFIN0No?=
 =?utf-8?B?a003SUdhZ3c2TFlDZHJwNGVENHYwY2pTYXZWMllvb2Jld3RkTVhmSDFYY0xQ?=
 =?utf-8?B?NktQVUJGcEZoZkZmV2toVVVpUEk0NWFPK01JRjd1WmZXWm1iRHVTY2gwN1RD?=
 =?utf-8?B?RkRFbnZCaytzaGFoTVduS0w5YkZiK2dLM3FaenF2RlpuMUYrcUZWbG1wK25y?=
 =?utf-8?B?QkF4d1RmTzVqTnZWekVqL1RIUnk4dWtpWXZpYkdtRXRJY29hQ1NYM3BPVmRu?=
 =?utf-8?B?UEJUYW82emFPQlE5amVxVXhQV0R3cUp3TUsrYVR3TTVVTjFZS0JGUHVZUWJB?=
 =?utf-8?B?dWxSSzBoR3lYdUJEOFZoMy8yR0sxWUh3VnJFZXQxc2ZwTXorMjNyWkFTRmdL?=
 =?utf-8?B?MjJLWWhSSFJkeUlDL2VEZ0hVcDE4T2hGNDdjNnBOUjM2YnM5b01ZRmYrVjlj?=
 =?utf-8?B?WjMrYVpDbTA0SUd1NGtPR2FUYWp5Z1ZEVFBBTnc2eE4rOUs4ZWRqR091N2d5?=
 =?utf-8?B?ZDBVZHY5K2RZWjZlN1k3VkRpY2d6MGtiazI2YmFiamtuM2hBWGszVk5KOVNH?=
 =?utf-8?B?WmxwbHVablZwU0k0TXRPYmVtbC81VnpBOVlTelFBeTJPOW9PU3BudWhpbG5L?=
 =?utf-8?B?T1RmbGlORStzWlhlVlZ1QVloWGp2TGlndE44Y2JQS2g4VkVTVGR2ckhFSGJQ?=
 =?utf-8?B?VnlOOFZHcDdmQ0NBVWp3eFRwQnA5cU83cXM4UFBmQjJ6aENSSERQVHNiREt3?=
 =?utf-8?B?RDM4MjI4L1VaYWk5em5naWtxdlJyRnlzVjdTYkhSS1R3SmpEK2JPd3hCRTl2?=
 =?utf-8?B?eFNaQm54MlN1b3Z0TStLQ0dsWng2TUJibUcyRlBSdEYzUFhoTkdlSk1TYmhr?=
 =?utf-8?B?YzNuODFzdUtWcmNYSU51KzBPejFYS2Y4ekk2Ujl6WER3YjY5TStrQmNnNWQ4?=
 =?utf-8?B?UXpNWnBsUnB3ZEpjMDIzNTV1MjVTS0x0UldRdUNMWGZzWTFhY1ZyUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1517b564-b615-40c3-42f6-08de5a676a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 10:08:54.5286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8Z4VG5BYbXhAvP3ClVS8idYEzWenGXory3WyhsbG5XwRoyequ5mZAc2+bIYyyAcJ1mggRNb9EVeGcW92eEqCBHPylKuwzQuIaRxKj4NgO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5052
X-Authority-Analysis: v=2.4 cv=fPM0HJae c=1 sm=1 tr=0 ts=697348b9 cx=c_pps
 a=D1syOSCgd/TrkoObF8KiHg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8 a=tsG90sIZ840xWLo4wZAA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: BcLpFqc7zD4cmJq56sQ0e-YdWZjsFgg1
X-Proofpoint-ORIG-GUID: BcLpFqc7zD4cmJq56sQ0e-YdWZjsFgg1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA4MSBTYWx0ZWRfX0vOhmNYmdSGj
 H68DuDj89qI51eaCa45IHBJRmG7AqUK2TSQxbGVWFJ74X8ZFwgwwkChD6TnJNXKxrJKJmCSL0bB
 udu/ogE6RempCKf2uwZcZiUakXQxlSrsvaGSXO062q3qv6xUXikqyIuiRRRACMndG0dqmcoqaBz
 BBt68BXXuWA/7ai565AWwbb/+NZ1QMVmy0CJONVEgztqi3TrE200Zgxjz0wbkKEjKvg17apOGg4
 LmLOI8eU0tuO1ySqfL5gSFZW5WJeDSOaGYs7qJOuzE4Q+33+iKHcGPF3bogVVM4bRc/TYSF8v2f
 wSq28qUrGlpkbcBYLHHyCEUKjPp4kJXRxomhExjBV/fxzU73vnHGL76EiP3IHlPSObr6sUEettA
 r/dks2wDeUp6mVrtq0H3EddNLW0ipSyyijiiJjhDl1otcOSKC8/3H1CXwb0yXHHRrIwYQ5EMeFP
 mx0n9Bl5XvoucFuPINg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230081

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjMsIDIwMjYgMTE6NDQg
QU0NCj4gVG86IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IEhl
bm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IFNhLCBO
dW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENjOiBTZXVuZ0p1IENoZW9uIDxzdXVuajEzMzFA
Z21haWwuY29tPjsgTWljbGF1cywgQW50b25pdQ0KPiA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5j
b20+OyBsYXJzQG1ldGFmb28uZGU7DQo+IGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbTsgRGF2
aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsNCj4gYW5keUBrZXJuZWwub3JnOyBs
aW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGlpbzpmcmVxdWVuY3k6YWRmNDM3NzogRml4IGR1cGxp
Y2F0ZWQgc29mdCByZXNldCBtYXNrDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTdW4sIDEx
IEphbiAyMDI2IDEyOjA5OjI1ICswMDAwDQo+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPiANCj4gPiBPbiBXZWQsIDMxIERlYyAyMDI1IDEzOjE5OjQ2ICswMjAw
DQo+ID4gQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+ID4gT24gVHVlLCBEZWMgMzAsIDIwMjUgYXQgMzoyMeKAr1BNIFNldW5nSnUgQ2hl
b24NCj4gPHN1dW5qMTMzMUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUg
cmVnbWFwX3JlYWRfcG9sbF90aW1lb3V0KCkgdXNlcw0KPiBBREY0Mzc3XzAwMDBfU09GVF9SRVNF
VF9SX01TSw0KPiA+ID4gPiB0d2ljZSBpbnN0ZWFkIG9mIGNoZWNraW5nIGJvdGggU09GVF9SRVNF
VF9NU0sgKGJpdCAwKSBhbmQNCj4gPiA+ID4gU09GVF9SRVNFVF9SX01TSyAoYml0IDcpLiBUaGlz
IGNhdXNlcyBpbmNvbXBsZXRlIHJlc2V0IHN0YXR1cyBjaGVjay4NCj4gPiA+DQo+ID4gPiBhbiBp
bmNvbXBsZXRlDQo+ID4gPg0KPiA+ID4gPiBGaXggYnkgdXNpbmcgYm90aCBtYXNrcyBhcyBkb25l
IGluIHJlZ21hcF91cGRhdGVfYml0cygpIGFib3ZlLg0KPiA+ID4NCj4gPiA+IC4uLg0KPiA+ID4N
Cj4gPiA+DQo+ID4gPiBNYXkgSSBhc2sgaG93IHlvdSB0ZXN0ZWQgdGhpcz8gTG9naWNhbGx5IGZy
b20gdGhlIGNvZGUgaXQgc291bmRzDQo+ID4gPiBjb3JyZWN0LCBidXQgSSBoYXZlbid0IHJlYWQg
dGhlIGRhdGFzaGVldCB5ZXQsIHNvIEkgY2FuJ3QgdGVsbCBpZiB0aGlzDQo+ID4gPiBpcyB0aGUg
ZXhwZWN0ZWQgdmFsdWUgdG8gcmVhZCBvciBub3QuDQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gICAg
ICAgICByZXR1cm4gcmVnbWFwX3JlYWRfcG9sbF90aW1lb3V0KHN0LT5yZWdtYXAsIDB4MCwgcmVh
ZF92YWwsDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAh
KHJlYWRfdmFsICYgKEFERjQzNzdfMDAwMF9TT0ZUX1JFU0VUX1JfTVNLDQo+IHwNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICEocmVhZF92YWwgJiAoQURG
NDM3N18wMDAwX1NPRlRfUkVTRVRfTVNLIHwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEFERjQzNzdfMDAwMF9TT0ZUX1JFU0VUX1JfTVNLKSksIDIwMCwg
MjAwICoNCj4gMTAwKTsNCj4gPiA+DQo+ID4gPiBPa2F5LCBJIG9wZW5lZCB0aGUgZGF0YXNoZWV0
LCBhbmQgdGhlIGJlbG93IGlzIHdoYXQgSSByZWFkIHRoZXJlLiBUaGUNCj4gPiA+IGNvZGUgZmly
c3Qgc2V0cyB0aGUgU09GVF9SRVNFVF9SIGFuZCBTT0ZUX1JFU0VUIGJpdHMgdG8gIjEiLCBhbmQg
d2FpdHMNCj4gPiA+IGZvciB0aGVtIHRvIGJlIGNsZWFyZWQuIEJ1dCB0aGUgVGFibGUgNDMgZG9l
cyBub3QgbWVudGlvbiB0aGF0DQo+ID4gPiBTT0ZUX1JFU0VUX1IgaXMgYXV0byBjbGVhbmVkLCBh
bmQgYWN0dWFsbHkgSSBkb24ndCBzZWUgd2l0aCBhIGJyaWVmDQo+ID4gPiBsb29rIHdoYXQgdGhl
ICJyZXBlYXQgb2YiIHRlcm0gbWVhbnMuDQo+ID4gPg0KPiA+ID4gQW5kIGZvciBub3JtYWwgb3Bl
cmF0aW9uIHRoZXkgbmVlZHMgdG8gYmUgMGVkIGFzIHBlcjoNCj4gPiA+ICAgIlNPRlRfUkVTRVQs
IFNPRlRfUkVTRVRfUiwgUlNUX1NZUywgYW5kIEFEQ19TVF9DTlYgYXJlIHRoZSBvbmx5DQo+ID4g
PiByZW1haW5pbmcgUlcgYml0IGZpZWxkcyBub3QgbWVudGlvbmVkIHlldCwgYW5kIG11c3QgYWxz
byBiZSBzZXQgdG8NCj4gPiA+IHRoZWlyIFBPUiBzdGF0ZSAoc2VlIFRhYmxlIDM0KS4iDQo+ID4g
Pg0KPiA+ID4gV2l0aCB0aGF0IHNhaWQsIEkgd291bGQgd2FpdCBmb3IgQUQgcGVvcGxlIHRvIGNs
YXJpZnkgdGhlIHByb2dyYW1taW5nDQo+ID4gPiB3b3JrZmxvdyBoZXJlLg0KPiA+ID4NCj4gPg0K
PiA+IFNtYWxsIGtlcm5lbCBkZXZlbG9wbWVudCBwcm9jZXNzIHRoaW5nIGFzIHdlbGwuIFBsZWFz
ZSBkb24ndCBzZW5kIGEgdjIgaW4NCj4gcmVwbHkgdG8gYSB2MS4NCj4gPiBJdCBjYW4gYmVjb21l
IHZlcnkgY29uZnVzaW5nIGlmIHdlIGVuZCB1cCB3aXRoIGEgbGFyZ2VyIG51bWJlciBvZiB2ZXJz
aW9ucy4NCj4gPiBNdWNoIGJldHRlciB0byBqdXN0IHBvc3QgYSBuZXcgdGhyZWFkIGZvciBlYWNo
IHZlcnNpb24sIGFuZCBpbmNsdWRlDQo+ID4gYSBsaW5rIGJhY2sgdG8gdGhlIGxvcmUgYXJjaGl2
ZSBvZiB0aGUgcHJldmlvdXMgdmVyc2lvbiBpbiB5b3VyIGNvdmVyIGxldHRlci4NCj4gPg0KPiA+
IEFsc28gZnJvbSBhIHByYWN0aWNhbCBwb2ludCBvZiB2aWV3LCBpdCBlbmRzIHVwIHBhZ2VzIHVw
IGluIHBlb3BsZSdzIGluYm94ZXMNCj4gYW5kDQo+ID4gc28gaXMgaXMgbGVzcyBsaWtlbHkgdG8g
Z2V0IHJldmlld2VkIQ0KPiA+DQo+ID4gVGhhbmtzDQo+ID4NCj4gPiBKb25hdGhhbg0KPiA+DQo+
IEFESSBmb2xrLiBUaGlzIGlzIHdhaXRpbmcgZm9yIG9uZSBvZiB5b3UgdG8gdGFrZSBhIGxvb2sg
YXQgdGhlIHF1ZXN0aW9ucyBBbmR5DQo+IHJhaXNlZC4NCg0KWWVwLCBpdCdzIGEgc3RyYWlnaHRm
b3J3YXJkIGNvcHktcGFzdGUgdHlwbyAtIFNPRlRfUkVTRVRfUl9NU0sgaXMgT1InZCB3aXRoIGl0
c2VsZiwgc28gd2UncmUgb25seQ0KIGNoZWNraW5nIEJJVCg3KS4gU2luY2Ugd2Ugc2V0IGJvdGgg
Yml0cyBiZWZvcmUgcG9sbGluZywgd2Ugc2hvdWxkIGJlIHdhaXRpbmcgZm9yIGJvdGggdG8gY2xl
YXIuDQoNClJlZ2FyZHMsDQpBbnRvbml1DQoNCj4gVGhhbmtzIQ0KPiANCj4gSm9uYXRoYW4NCg0K
