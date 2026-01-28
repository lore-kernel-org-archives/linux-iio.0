Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B52E40B;
	Wed, 28 Jan 2026 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580178; cv=fail; b=NvzDe4Oy4f7SHDa2eUecIhqioaxPDmjufgfJ4P1X+K3YlQU8YXZU2uWa/DDJS6NxASZjiGFGz4RMEed5c9Y97dJaLc4y0MBcqqLD8RinIBIaNnaBH0ntyTrNOw3EiW3BtL8raFG5PZxL7WhCDgJplN8D/D10sH1qO9OPJntvBzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580178; c=relaxed/simple;
	bh=vCBOvbShySEVXugjQCn7a+KNDcx4Ji+nNUjxDae6BLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uSo7j0a7KKd3xcpi8y8pMhH29F9nz1rpwjbtgIEHy6t1UyUWnk+ezkvVV7iQxcYLzIKEZVBldwowOXo/kDX/exGjPrHoowqvAkUBvHadb03a8EWO5GR6x8urL7lcW5YcdbylxoB3p/KrSCp6dXgRtCS/Svvzm+j+Oj7TsM4CiR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZO8Qb7UF; arc=fail smtp.client-ip=52.101.70.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZO8Qb7UF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwYNSexqTfV8qHsjx3hNRTK3AjuOjTp/RB70yvjUIReqL/NBz18AqyuoahX0KeR3LMnxMkj7mv4oMXKkSdIw2hH1q+sp1D+JkBb5+2cH2Q6bJ/NOvTQJd4Sxln7EZ/maJ2wBImfLkRt2atsYtva943TuLhqmKa+XGOHTpl8qsMFxN3EUs41UYPnsGuLNnMws+fL6kLKpcsKFKfsIRj3d1RPqCkN/7GHVAMjloBccAyxRoMC0hjmp/PqSHK4NOeSJg4iYnPgOLFInQE24rOeu4FfgI4cY1lKFgY5Z+spCW38gE/HVUVal630Fk6cULoBb7aXNzgdIKgNK1iKFtMJrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCBOvbShySEVXugjQCn7a+KNDcx4Ji+nNUjxDae6BLg=;
 b=GKHpSgS3SBMcDAUr1iW/f7e9TrBivNhOzKExc25oDD+godFtorYcCqFBHsm3LbOC07PfJmOkGXpyuOcYYhb7tcde5DUoSL9PO/MlTXpyTn9tFeetTr2y8WVU9UZ06WtRBpyRm/rBGtvi+pUPnHYKwI2Pa1Llls4E4ypcOO16Fn1gwaLWpMN7TKVWYAYa+D7qQiglvRpeP0hXu+A+rKPhIAc41IV9VQBoFT07CJ32hSpvCy31f8dAaPK2+/5OGs1dzaoIAJn7Uwhs8G5wX3dbvDt5GG3xAcDmnotkmC8DixVGhQaxMksiCann2Xa9LIT1lEpptoLYC4ep+lhm2RJQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCBOvbShySEVXugjQCn7a+KNDcx4Ji+nNUjxDae6BLg=;
 b=ZO8Qb7UFyqYgmuVqjJvBByQU8/tzG4i3kI2qiDCmv9S46EKzA/XAD4rtpVwUib6kJne6iWZ7MLjsLlf48DlCW6ch8+XpP9ksim0QMOUe9ic3uuw0rogZt6Zl4f4sJKMlUv2hAFV3G7lEkiTd6YGEmh/wLu04oabI47cR4398ENH3NvD3MqGm0Q18wh92JolWCs8EOMgNx5vskGY6BIs0V3n5PQ7oD+mgX0bEJsSOm3c8cBNXSEZyisjNt/1PJ5+nRayJQjjyd9onFLVkV11CDtWdr8eVAiu7jgcUeUm7Q8zgWRgSJhy2C4fGxqLv0+wr8o2fFxhM+VoWSXwAZfTrvg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by FRWPR04MB11102.eurprd04.prod.outlook.com (2603:10a6:d10:174::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 06:02:54 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 06:02:53 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Chen Ni <nichen@iscas.ac.cn>, "jic23@kernel.org" <jic23@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: vf610: Add missing check for
 device_property_read_u32_array
Thread-Topic: [PATCH] iio: adc: vf610: Add missing check for
 device_property_read_u32_array
Thread-Index: AQHckA5uUI7LOEkFwkCd4aQPL/02pLVnFuPw
Date: Wed, 28 Jan 2026 06:02:53 +0000
Message-ID:
 <DU0PR04MB9496A39912A88B4C1A6491799091A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20260128042700.2260803-1-nichen@iscas.ac.cn>
In-Reply-To: <20260128042700.2260803-1-nichen@iscas.ac.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|FRWPR04MB11102:EE_
x-ms-office365-filtering-correlation-id: 470f8710-5be6-4d91-2a72-08de5e32e03c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?cEVuYUhkamI5SjVvT3ZBY2kxclRQaFJzdkFhZWtKei9vR0tiN1loeG8yRjU1?=
 =?gb2312?B?amlKVFVPRjR3c01mdTBDanB0R2k5dnowQ0NBVUthY0RQVVI4TWpaMC8yTC8v?=
 =?gb2312?B?b2lXcm9xLzYyVUk0RFp6V3hURmUxS2FFakpVMW1LTFFmYnd0VERQRk85dmtM?=
 =?gb2312?B?eUxxU2xQWWNSOU1ld1RWQXQwQVc1MmtWaU1oeGdWL2ptN0VTZDdYTEsrVXp6?=
 =?gb2312?B?ajZlREJab0UrTG8yTlNvOG9zZFVtTWtxMkhGbHg4Nk9rUXpjMDNEUjlJUDdY?=
 =?gb2312?B?UW5oKzA5Zzh5YkZwQ28wNGtON2ExZVlicnU4SXVVMmQvOHNiWXR2WE5TUDZO?=
 =?gb2312?B?aVI5eVpGcFhtSVdoRnF5TnMrNnpZSW8xWm9mbUpDWWJPUGpDRGNqNUlNRVA1?=
 =?gb2312?B?MjZQYy9qMEZGNTJQTlE0azgzRkVtR2g1WmM4YUFZV1lzeTIyVy9BMklKem5q?=
 =?gb2312?B?OWhkQm5sTnFPbzBlajY1WDlvVnFXbnJlYVJnWGF2NVBTM3NKTjczeVV6Z0hn?=
 =?gb2312?B?Smh4bjE2dnRTQUhCQ2FJcG5VT3dacExrYTV2Zk8wQk1hd3NkRVlkRVc5ZEd6?=
 =?gb2312?B?MDJkYzFNdmNSY2R1WnJaL3I3K0p0aVRIdVZFSTVpb2lXd3VuSlZybXdaUjRZ?=
 =?gb2312?B?Yk1Kbkl4QWlYaVdhYmsxMkpRVmdRMjBodzRoOFdYUDA0YWRlT0RBREwvYXJB?=
 =?gb2312?B?YkhmTDEyQjZmeldWM1UyOWl4NVZWbkFOTmN6THUzRExPV01FdUluaTdjUFZY?=
 =?gb2312?B?Qm1hQ1JMUUNUN3ZQZWNpanBsaTVtNlZCVTRZVUVzMi9UcVMxMWNRNlgzdjdi?=
 =?gb2312?B?WjlWVWdrNTgrUkFiNlRCTERpNVRoU2d2aGVIeWRyRTd5ZVc1ZElFL0htMzQ4?=
 =?gb2312?B?OHlwQ1MzdElRQmpvalE1VnlDRlZ6b1QxYjBOOEVoSXAxZEc2eFJSL0pCcXUz?=
 =?gb2312?B?OU5Seko3RWVzT0lZSExEaGlBcU1zWHhTVHpyenBIYjcxdGtac1lDTkx5dzdk?=
 =?gb2312?B?MW9DUXVDdC9oL0xOM082SVJvdklKNkRuaEo2UXErdy8zTW5oeXRReEVNTm5K?=
 =?gb2312?B?OTE3VWtjZ09XT1FYc3dvL2JyRUhySVFHbWgwMWttenhqYlpxVXQwOTRNOFZj?=
 =?gb2312?B?WlpVamMweWhHRzVPM0xqaDVBTkd1OW0wcGxZS1dlTWI1ZENJdjZvTWJpWnF0?=
 =?gb2312?B?T1JRR1BUSnJuajBUTWlnT3Z0QkhmTjBGMHRIK2l5SGs0ZFJPTEgzMUR0V3Yy?=
 =?gb2312?B?VmUvZCtQMHBhK2s1bStndlFtMTUvQ1lpcWcyT1hlR3pkeEZ5VTVnTmVrM3l5?=
 =?gb2312?B?YitPd2k5MU5MQ08vQ0dNUWhEaG94dzIrUWlRT25pVEtrcHNobzZCMzV3TDNS?=
 =?gb2312?B?VnV5c0ptcGdIaGF2WTlPb285d1FjZlpiUVpXQnFOL2YyZVBKME5PcEpuTTBU?=
 =?gb2312?B?aWNLSkRMS2gxMGRYZzVmREFtVGE0WDJyYkI4TUlCVnZ2blRFR0s5WitnT3RQ?=
 =?gb2312?B?d2tRU2d1MUVFbXdIUlViSWJBaXJuN1lVcFNjakV4a29VOVJDVWdkOFpOVkh3?=
 =?gb2312?B?RWwrRVh1Z1FDK3ZDWnYrdFpmTEFoaTNzNXBpaHNXOWVwWDNMdCtyeXIxNnpW?=
 =?gb2312?B?RE5NbE9acTJkYmVYc1YyNnYxaEFObDZOdldOZS90WElxOS84TS9rOXovdVJw?=
 =?gb2312?B?U0pwSm8zWDJWV1oxVEluZmZYSURIUlhTOGZ6cnV3S243RGQxakhxOGRlcFcr?=
 =?gb2312?B?ZGNXNVJSVWN2S1l2MWdqMVVVWEZLZzJ5N1BBZ3hOb3I4MTR1TjViNjYwZFVR?=
 =?gb2312?B?bnhvNzRUUXpsWjNnWmVnWnZQNm1lRDN0TmlCVVlpVHVySXE1TnptS1FUS3N6?=
 =?gb2312?B?ZlZPaDZQS1ROOGIyL2NWVWYwTDdPYUpuR3BaRFd1WFNQMkVkYUJ1WlRWd0lQ?=
 =?gb2312?B?UlRoNzRDZ0tMS2V2dk9lcDR2TjYvQmEvbTNpTzM1d25uWjBtemFuM3kyTGVL?=
 =?gb2312?B?eGVuTE8zOVIzZm5SbmJ1VWJmZTU2YjU5TDEwZE1Jd3kwTTQrOEhhTEZ4RWpr?=
 =?gb2312?B?OGZ6ODNrMzVaUk5mREliUWJMYjBjQlJpS0pkWE1oWmdvc3hRaWo4c0Z1bUEw?=
 =?gb2312?B?VUpjTlloYW10WXZYTnVNWVBmWDcyNnRpbmIva1VndHlmblN1MVNDT0YySkt3?=
 =?gb2312?Q?UCbw99K7os3RBO7viP07GfM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?R2RPTlQwb1hXOE0rLys4eWxjQkFjQUU3YnFvY0VVWW9mUXJQb1lGMlBubng1?=
 =?gb2312?B?T3B6bnNscDZpUU55OXprYWNjRmlPL2RDNUkxOGNQd3h1OHQ0WDhHZHF2UTRp?=
 =?gb2312?B?ZENHcThNblAwVkdyc2ZKUWlUcXRXdklHNERURm5yNThrVE5TUjk3dWlNckZO?=
 =?gb2312?B?ZzRvanliTTZrM3lFZXQ1T28rZFBQRSthTE9xakprNkJTUURqcjIrbTNzQ1Vv?=
 =?gb2312?B?UDMwVDJUQ25kNStEUHNrdThVaFFrbSs5TldDam81ZlNuUkFRZkZFSmJxQ2RB?=
 =?gb2312?B?RmUzcExMYkZwdmtMVzh3dVBPaW0vV2FzWnpDSFJWTXBMZnhSS1pSdWI1RnB0?=
 =?gb2312?B?YXJnYW9xcUJlZG13UmJGeWN6S0prL1Y0a0ZxSWNKRWlHRk1QVEVZaFdrREhH?=
 =?gb2312?B?UXpDSlpaK2ROL240d2pDcHN0eUNlYUdTd1d6WXV6SENXblFWazJZelExNU9H?=
 =?gb2312?B?dlB6ejFXbXo4K1NGM2liZXhYU2hBM0xsUHhiNFFNTjdwS0FWMzg1cGZGeUNB?=
 =?gb2312?B?TmZvdXRHQ1NUUlV2QVUrR25jTld1OXZpa21SQVdaT3dwUzlNbFVWbmdySUd1?=
 =?gb2312?B?UmE2VkV5WUlXTlh1QWFHN0VwTGdkUXdEcVRFMWU2Z3h1OXdGREV5cGNRMFND?=
 =?gb2312?B?Uzh0a2NMNWhXUkk3N290S2x4N3ZMZHVUdzhIS2N0U0wwYjJBQWVjOWY0dVBV?=
 =?gb2312?B?Z3lKYUFTYkRFV21WTUdGUURKUy9TNHd1NjkzcEFaQ0o5RUFqdmJRZlFHN21N?=
 =?gb2312?B?MG9kNlNmZklHeEtwbGsybHg5bitOeG81S0RjM0QvSXI3K3gxWjZtMGVZMnBo?=
 =?gb2312?B?bS9CRE05L2ZhUkxEZE9LUEtXcjVQRVZkRDBMdGx3S1JiRDV6TzJvQ3p6alc3?=
 =?gb2312?B?Qk1Gb3lhd2ZjeWpobUdKNVpwOVVyOUxxZnI5MzB6akdpb0dxeEM2SFgyeUVL?=
 =?gb2312?B?QnIxV0QzVm5pZDNGQm94ZlJMc21zSTdVWGVHNE9IY2dXc3BtVlB1ZENBY1BZ?=
 =?gb2312?B?ME5CSjNWbWdWR2t6QUFjNERjSDZFczA0S2orRkc1RHhYWmtlVnRweXBrdHZW?=
 =?gb2312?B?OG8rOTNHNjE4V2FaSEFqSXA1YUM2MGNEUThEMEZhd21UL2tTbXRyYVkrVjZn?=
 =?gb2312?B?NmVIMzA4akxmQ2VFbEY0aTkvdGpJcms5MldIOXU3RklCYXNRdjFJcHo4OVF2?=
 =?gb2312?B?b2NHSDY0Zm01c1JmVkNmdDVzdW11YStocFJJaTVNdU9FYmY2bENtTnl0Ty9U?=
 =?gb2312?B?MGVkdG9NeUJpRzVEZmRlOXdObnhvQWNrN05zZm5YdW1MU05kSnE4cXh4bmw2?=
 =?gb2312?B?YUZJQkZzSTY0SVhRVnREVGEyckkzNXBjMEpKZHBzK0NTTUdweVdRQXp5TmxH?=
 =?gb2312?B?M3ZJNFhZelpyNVRBZVRob3BqS1pOaDIrYW5UL05NbC9Obm1US2NtOGI3RTNx?=
 =?gb2312?B?a0xjaHh1RklxK0Jza1YrbWVRVFcrckpBejUxekUwR2RXaUFRL08zNEgxdEU2?=
 =?gb2312?B?TFM1Z2lQcTFVMGVMWmxhSmQ5eVljVTUzbGV1dTdvb01YRTY4OXZYeUNkcmV6?=
 =?gb2312?B?NFo5LzcyY1RDWWN3dUxXalBPY0dWZzladzE1Wlh6czhtTTEza2lBUk9pdnNj?=
 =?gb2312?B?eDhWZXg5OElvRkxvQmhQMm9CdEFBWDV4ell0dEYza0RDRkVIcjgvT3V4Qm1x?=
 =?gb2312?B?Q0ZmK0VKNlZIOWVHMnFYVUc1elJCOGsxOWpOd3ZZZDdnekZCSmhGQ05YaENQ?=
 =?gb2312?B?S2N6RmZOSnRmQnRWSWJtQStPQ25vTStheU5xS3NhbnN0eEQvaHRSbVhmdnpW?=
 =?gb2312?B?WjFxKzdkbzhEMzVjejdlTC84UXNVQ2FLQlpPRzBsWmlrOWZRZ0JCMEpZeXRj?=
 =?gb2312?B?VmZjZGZ6ZHlXMWJBNks0ZWhpanNINTJUTWFOeFQrcTVVMGFDeVA4RmJCZW1s?=
 =?gb2312?B?MCtJOXBuYjNENlpuNXh2Vk5oby95ODg1YWhMdEJHcmhWYmRacEt0a0dGdG5j?=
 =?gb2312?B?RjBUUjBRbVNwUkZGNkk4cEtRUmpYRzlzY1dJZmpwcE5pa0tVWDFpckR0b0Nr?=
 =?gb2312?B?bEdNblA2cVNudDFnc2h1ZG9lODFZVEN0WjJoYmJGbFBqM0d5N2hNQkkrQ3RX?=
 =?gb2312?B?bUJSSlVRWnI2N1Urd0x6MUYvazdDUThTSXJJMlp5bUxYbnNoQ0tCb1ppUnU2?=
 =?gb2312?B?cVFrOEMxcVI1QWplYUtsODhwNWRkWDd2TWZCVTJVOWFwS0dPSFcySzlSNEYy?=
 =?gb2312?B?YnJNWXQvRjdmOCtUOXlYS1pBZWt1TWpmTFVsVVBIUThTVk9VOGJ2RmcwbDAv?=
 =?gb2312?Q?sv3oqE+zalq4NNZN4d?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470f8710-5be6-4d91-2a72-08de5e32e03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 06:02:53.5841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3c01wCsXMkCIpigeH9UuBjD3HeQof7q4jKq/x3H9AJ2xfvHtUgaI8PZRCRS1zZf8SSlQUzRjwER1QQawigitiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11102

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuIE5pIDxuaWNoZW5AaXNj
YXMuYWMuY24+DQo+IFNlbnQ6IDIwMjbE6jHUwjI4yNUgMTI6MjcNCj4gVG86IEJvdWdoIENoZW4g
PGhhaWJvLmNoZW5AbnhwLmNvbT47IGppYzIzQGtlcm5lbC5vcmc7DQo+IGRsZWNobmVyQGJheWxp
YnJlLmNvbTsgbnVuby5zYUBhbmFsb2cuY29tOyBhbmR5QGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IENoZW4gTmkgPG5pY2hlbkBpc2Nhcy5hYy5jbj4NCj4gU3ViamVj
dDogW1BBVENIXSBpaW86IGFkYzogdmY2MTA6IEFkZCBtaXNzaW5nIGNoZWNrIGZvcg0KPiBkZXZp
Y2VfcHJvcGVydHlfcmVhZF91MzJfYXJyYXkNCj4gDQo+IEFkZCBjaGVjayBmb3IgdGhlIHJldHVy
biB2YWx1ZSBvZiBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzJfYXJyYXkoKSBhbmQgcmV0dXJuDQo+
IHRoZSBlcnJvciBpZiBpdCBmYWlscyBpbiBvcmRlciB0byBjYXRjaCB0aGUgZXJyb3IuDQoNClJl
dmlld2VkLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNCkJlc3QgUmVnYXJk
cw0KSGFpYm8gQ2hlbg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBOaSA8bmljaGVuQGlzY2Fz
LmFjLmNuPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy92ZjYxMF9hZGMuYyB8IDUgKysrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMgYi9kcml2ZXJzL2lpby9h
ZGMvdmY2MTBfYWRjLmMgaW5kZXgNCj4gZDcxODJlZDBkMmE3Li5kNTM3MjNjY2M1YjIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy92ZjYxMF9hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lp
by9hZGMvdmY2MTBfYWRjLmMNCj4gQEAgLTg3MSw3ICs4NzEsMTAgQEAgc3RhdGljIGludCB2ZjYx
MF9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gDQo+ICAJaW5m
by0+dnJlZl91diA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShpbmZvLT52cmVmKTsNCj4gDQo+IC0J
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KGRldiwgImZzbCxhZGNrLW1heC1mcmVxdWVu
Y3kiLA0KPiBpbmZvLT5tYXhfYWRja19yYXRlLCAzKTsNCj4gKwlyZXQgPSBkZXZpY2VfcHJvcGVy
dHlfcmVhZF91MzJfYXJyYXkoZGV2LCAiZnNsLGFkY2stbWF4LWZyZXF1ZW5jeSIsDQo+ICsJCQkJ
CSAgICAgaW5mby0+bWF4X2FkY2tfcmF0ZSwgMyk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJu
IHJldDsNCj4gDQo+ICAJaW5mby0+YWRjX2ZlYXR1cmUuZGVmYXVsdF9zYW1wbGVfdGltZSA9IERF
RkFVTFRfU0FNUExFX1RJTUU7DQo+ICAJZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgIm1p
bi1zYW1wbGUtdGltZSIsDQo+ICZpbmZvLT5hZGNfZmVhdHVyZS5kZWZhdWx0X3NhbXBsZV90aW1l
KTsNCj4gLS0NCj4gMi4yNS4xDQoNCg==
