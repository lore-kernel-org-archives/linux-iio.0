Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916427FD40;
	Wed,  4 Feb 2026 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234620; cv=fail; b=XC9fmF/PHnZWF8Sy0yP6PsXciE2WeLRPHhh5EcTUIsKlLenRez7r8TZbehFOprqptHaZHCbFJudS2E7c1dLQiYFnZM7JIuC4gBq78XfBfHkIHuQob0UOguug4PPCnzJCKffY0K0BHj9CfYgYOU27YF8Gs9l2eVCSNICSw2NoKEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234620; c=relaxed/simple;
	bh=nacJI5wrC+WURuYA1sv1ROXjVK0KmqK5UYMzr3cEALY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWsN62MwWpjRF4R5FX47iI2lFXvOQATJODkQ77bhx7zb2FVUma7XIH6hhJRLAWtOWxPXlru8eplFHeyDiquy8+n2P7PxxyakfTexFAyl3sst2jsmMWMzqi4ipm/hKu/xRwmiAuBvBfK6ZdW3/WiaYudh7q2684vTaccIED7bAak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=VXfUXxec; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="VXfUXxec"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqoaRiTcCcKXTIghUeBsP0nzMSeAjNha3xvLiRLTQM4cHA3L98yey2JLv9bTol5c58yOzRRxe1E42Lrl9r0nOr0GlqDKYSxX6huZpaPSe5cDbIrl/VTvVSvnufgEFAD9Mwo+EIt13FRtCiNhVMwwz0xqfTV057UIrWzCB35sXXuwk3or57PpAdf5wAQrEaDB+GPU78I6DBhHmk9hrweezpJL165ksNMrDpus93FibT5jSlr30NaEusmTgJggFzhwEHe9bB3si4LAf31J+Q4wFjVH3cmvyGMBJPSMMSRwduH0q/jRN+8+VgsozdD/06vY3v35E13CFC7wSwRaf6RU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nacJI5wrC+WURuYA1sv1ROXjVK0KmqK5UYMzr3cEALY=;
 b=Y9R6OvF83H0zyKWFwOJto31ac+X1oYnM1yWEPQ5BjnQylKpRoo1vdqFM+6lEg3Pv5Io/jLJDPfLL3r82PwywZKvHEDgoPueqZ1vxOrYrMKXNoymbaaLZKRLdVbg5lOVeId+jomuFNTRntq843OkWeFRZY5G72dc6Mh5aPS2Mj97Uf0n3FQ/OjA00YVJY+u6JQD0Le/p2OcPTwW13uNIVBxTdQu0bJ0iqCGDMQGP1z2UwtDxY55cz9mLT7cTYzW8pqtdJYNLZWlqxWTBm+eYEVZubHeszFJsHu+ducLfgwbZtJeduPKubIQERvTKOP/5TU38gWLcQ3Pvdt38SWm6HmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nacJI5wrC+WURuYA1sv1ROXjVK0KmqK5UYMzr3cEALY=;
 b=VXfUXxecUkXvtmsKIfX4hE6gUx4dxxTgVDaFm0FShy6l+1+GSt+wf4S4Y9Sn4FSRUR6Np0rfu5Lq2GY3JQQiIEAIwCNWDHstHIGBdz+GLlYgC3TdlyXgwbiZjOlWD/g1Kx+cfRECzbxthXvi3wfbMt0LQ+j0rXxgL2y92XeMW0A=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by OS3PR01MB8906.jpnprd01.prod.outlook.com
 (2603:1096:604:17e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 19:50:15 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 19:50:10 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: ABI: fix current_trigger description
Thread-Topic: [PATCH] iio: ABI: fix current_trigger description
Thread-Index: AQHclgB+fuErNtSC10i5UQboTxeOZbVy8UsAgAAAfVA=
Date: Wed, 4 Feb 2026 19:50:10 +0000
Message-ID:
 <TYRPR01MB1561962BEB21FDF013F18FB9B8598A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260204180202.515393-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <d297fa4d-c8fe-4ec9-91dc-e15125adc711@baylibre.com>
In-Reply-To: <d297fa4d-c8fe-4ec9-91dc-e15125adc711@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|OS3PR01MB8906:EE_
x-ms-office365-filtering-correlation-id: 7546004e-ffd6-4c5f-79e8-08de64269ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWFUTGhGTHBYN1pOMDhrWEJyMW00eHA5L3BMNTVmMGJxcTJFdkd4OTJhOEV1?=
 =?utf-8?B?ekJsV3g1ZkdFaENBTC9JSkJPZTk4blcrN0RoYVdwVGpRVVc3bGVKTzRWa2RU?=
 =?utf-8?B?N2hsTnNCN2R1b3BCbVUreUp3MExLd0oyRW5aWUFRZmgvZFBtMVRkZ2ZjY0hI?=
 =?utf-8?B?UHFsM2NvajRGWWNWRnRWUlhRMW9jREMxTDVJZ01GbXV4aC9vRWRENzJqdWdZ?=
 =?utf-8?B?aDdqTmxVYVMzc3FCWmNiVFBoRk9XS2ZPenhsMkpYbU0xSGFqQTVhSXFhQW5I?=
 =?utf-8?B?WDdJU2IyMTB5Nk10c0xGTXZpSnI1V0tiZkVVRDNGaHFLVTZpZHNIcytVNzFI?=
 =?utf-8?B?bWxvZzN3SGF2ZkFLYndxNUpIdXNJQ2ZYb1RqaFdxL2xHc3JMMHpTSURab1pz?=
 =?utf-8?B?Q1RuREJydTJLUG1Ub29CRjlUUDF5aGw5VjNzMTZzNERZc29VakxqcjhYbXBl?=
 =?utf-8?B?b0tjUERkZHZIWTVIRXprS2lpT2cvWW16Rlh4Ym5PQ3c4MVdQUFFQYzlKWFU3?=
 =?utf-8?B?T2huclhad2hhTHkraG1WNnhkNnB5bis3dU5VdC8vdVU2NWRuU05IaUtRNFdp?=
 =?utf-8?B?S1plaWl2Rll6cytXSGhDYVBOOVdZTG9uMGY1eWdNS3djdWJQS0EyWHdheU5n?=
 =?utf-8?B?ZUxleXBXcExhUjFtNTIwZFdlaG14TkQ1VlovN3Q0TytuVjZwS2dGc3lRUnpF?=
 =?utf-8?B?aW5hSlFwa01adzltT1VJekFVd3NsTDYxTmgzS3NJSVlnU216RzVzNDZ2bHRz?=
 =?utf-8?B?bU80ekVodGQzeEdjN08xTm9BNzdvNVRnZEJtWFFCWFp0MlhNWCtXRk9XVUww?=
 =?utf-8?B?WjdpOU5JTzFIY1ppblNLMi9Vcm5hNyt1UFZDR0lEODV1MEEzU1VQaVhIcWZu?=
 =?utf-8?B?VkRueWJKZ2xXeHBpUTNSQWlySFFDSjFiZjVSRmM3L201RkpjcHdEVC9rV0Fl?=
 =?utf-8?B?WHFPcDNobTJKWGc2eUFZQmlSYks3SEZsNlorTCtIM3JhMVNsNWQxd1daaWdz?=
 =?utf-8?B?S2Z4TWpLUEZ1SzdVRnVKWi9iRC96M0d6aFdVQXRLZmZtUElRL2ltY2RpelpV?=
 =?utf-8?B?WlVJeFhKMWRHd01KNEpWckcwUlFmdmQ5dEhhSWtVWTFURkpndGFGbURtdmcz?=
 =?utf-8?B?WnNEUkEzUzRiZTVQa2RwM25CU1hHOXJnZXk2dytPd2ZkbFB3aVF2MGtKTkpZ?=
 =?utf-8?B?a0xtQm9MQytrYVI1cU42QnNjRCtNSXBGNWduQTY0V0xpY1U5dW1CRHZuekJ2?=
 =?utf-8?B?VnRRekRlVU53UlB6TVJ6R3AxUVRsQTEwZ1M1TXkranE4ZkRJTnN5WmQ4NWdT?=
 =?utf-8?B?MlY2Q0ZlVlAyeFdUNWJyaDVSc09jUG1MMXk0QWJqb0drZkp4SnUyTU5hUDEx?=
 =?utf-8?B?amlmUktCTFk5cXNheWlyZk9ETE1kLzNTU2lLR1RPTmJaYnBTWm9GUE1yMkZ4?=
 =?utf-8?B?YUZPVmhTbThETVR4UlFjRmdFeGhVb01GcGpaemhzc3dHZzdkUmtGRGFXS242?=
 =?utf-8?B?bUEwdHRyVmNIWldBdWlMYldoZ3pEUFZrOE1OVW81cXJKc0d0eHAvRUJaK3Ni?=
 =?utf-8?B?bWtQaXdiUFpBSDkyUnh3TUVKZVVFbkpyMVdJcEF2RHdpZTh1TWVadllmQVhi?=
 =?utf-8?B?TGVJMXYzdjNKdFZhaDVVOE5Gcm1YYlJHZTAxT1dEYnBiOWxSU2FLUTRBUTRp?=
 =?utf-8?B?VWF2RzdDTWZKZEl0SVNpSExldWt3ZHdRc3MzMS8vSExVcnFsMjZWa0ZhajV3?=
 =?utf-8?B?QnlkY2daT2M0WitDUzB0UjBpUVc5bUdIbmlPV3VXS296bUFMT1JkdXNyNWk0?=
 =?utf-8?B?WEFBK25rcm1JVDd6eUZkUlZWQXVKemptcTh0ZW13K0ZuTkV3dlpZZy9IZzRQ?=
 =?utf-8?B?YWQxRWw5MzFqWHFadTRkOUFBdk9ILzZDY2JFS05KbSszdEIxWTdDZi95Z09C?=
 =?utf-8?B?bS82ZEd1d2E3MjZmMDBFOTRjNCtQT1J4QTIwOVFWNm9QWHd4bVp0UkhxejlH?=
 =?utf-8?B?eEovUXBZbUNONS9nRHcyZTU2Y1pJVDFLWkV0Q1A0aWVYaVV0ejgySWJyYjc5?=
 =?utf-8?B?NGM4K1pseS9VbUpkaE9tREpqSHM4aVBUK20xOVRkSDVSb1hyMS8zRkZNTW1P?=
 =?utf-8?B?YWZBbjFmckxBblYyellQdkk4ZG5tQVVRSHptLytVelhmeXlwUXJHU2dBSWxR?=
 =?utf-8?Q?U+Yl/Pxq2DLudHphB/lj/VM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yi8ybHFsY3NZdDI3MHdYRkw2M1owa0l3eDEybUp0VTNlbGNpOFZTVTJ1Z3Vw?=
 =?utf-8?B?Z0VlTDFlVjY4V29JVUxER0wrcTJySmtUM1k2NXVldXVoSlhoYnU2RkEvbSs4?=
 =?utf-8?B?bFlTL3oxbm4rdm4yQlI1dnVaU2lZN0xQL1RtT3dMbExaRTI0V1pRSUg1VWpz?=
 =?utf-8?B?d1NOcDFBd1QwdFZxeFMwVzNtWDJiaFlOTDlaU3lMWnQzdDRXMUhJYWFVY0c3?=
 =?utf-8?B?UE1IbkZzWmxTWWVYdERkM2ZCUW9SaFRtVkM1MHZuYjQ0QnZzSEQwTyszd21I?=
 =?utf-8?B?cE94TFhCN3dvSEtpK29TSVhiV3h3U3YrbmYycUFCd0Vla3dka3RXRWFJRllL?=
 =?utf-8?B?SHRlVmFWYnlSZStQeXB3aVNzaVNDYThWNFhod0dkZXR6cEs5SzVPa28rNjUv?=
 =?utf-8?B?NlJ6MEVwV1hLVncrYWF3N1hoZlg0bXBYckxVanM5ekliQlBSc2hObSthSEU4?=
 =?utf-8?B?SzNjSmZKUjN1N1hvdHhCaFlPTkRjLzZpd2hsc3JOc09nU0JjTzdmMUVoL2F0?=
 =?utf-8?B?RU9WQm5xUFl6Rzl5SGczc2kwUVBCS01uelFaMHRISW8rOXZIckhjK0lxWUJw?=
 =?utf-8?B?ckhnRGxiU1VDTXlWVEdMcURYZXRGL3l3R2I4cWFNbkJHbXFXUU8yU3dMZks4?=
 =?utf-8?B?TFlacEVRbGNkMWVsdERZOEE1RXdNNXllc1hiR0ZiRWJZT1FxVHpJVTJFNjZI?=
 =?utf-8?B?czJmNjJPdHI5R0w3OCtqUnFueXhySTFOSHYwdTVZZmczUHJUZDBadlFSNWty?=
 =?utf-8?B?WUNUc3UySHA5Yy9sQ1lRQ01ra1hmcGppRXJtMW16S2sxdG5JSDJLdHk0eGho?=
 =?utf-8?B?bW9wTHhmYnloZThCTFJXa0IwWHhQNUlGZTIvNTgzV3JBUG0yd1dFeWlWNlFy?=
 =?utf-8?B?LzdnVHBLWGE0ODBrRmE1WXZDZlgvZTNqa3VpL1A2TFVheGFCbldBb016aTdE?=
 =?utf-8?B?Ukd4Y0RHc0MvWGRkeUN3MXhoU00yOHMwTmhQN3FwTStYYVRIQjdmNEw0bUVC?=
 =?utf-8?B?dFFOMmg4WDV5RVoyUVdQTEYzSFRWdlFNVjV2eGhoWGhWb1k2ZGgrWEFrVms3?=
 =?utf-8?B?Zmp0YnEyZWhFNk1RMUVTcXJXSTVkOFQ5SDJuOUV6b1Q2ekRPTEdBQzUvMTBJ?=
 =?utf-8?B?LzdSa1hmd2IzclRhZjl1QThoV21xWXNZRG9CaklZMGVQZUpTZnJkVExuckNS?=
 =?utf-8?B?UXJ2MFlUQXEwSzZtZWJQNlhDZzN2bzVRd0lKNkh5aElBUUY1R0EzYjJrK005?=
 =?utf-8?B?MlpmekhlMXdVRUk5TUpPK2FXRTFWVU5qMlI2UjdjUmh6cHVVUUZXY0I5QVA3?=
 =?utf-8?B?bTBlVnNtRG5pdE5Jbmtqcm9vekJneFZlbGkxNTY0YklBcDZsYW54Z2NncXR1?=
 =?utf-8?B?M2h0SDlxNXp4Q05rSDk1YzJtc2NSRVNzNU93ZmlXbXVsQjBici92Lzg2VkYz?=
 =?utf-8?B?OWM1YllLdEIwanVuWHpWTVR0RDVhdUFnc1dPbFNPRzRUR0REb011NFo0Y0tZ?=
 =?utf-8?B?YjVDOHV2bWVjQkVSY2UzR092VGZDRDJEM3FvcW1OVzZ6cml2SjJQZDE4b2V1?=
 =?utf-8?B?eFBmQmxvT1IrSlRJcHdyZXJ0Um9uNjdqb2FoeHAvL3hsWE83cVdaZEsvUDVQ?=
 =?utf-8?B?UHE3OTB2M0NlQ1E5a1BDVDVRQmR1UmY1SVJOZXkxSzdRRWJybmx1TjgzbUUy?=
 =?utf-8?B?NW9BaGpBTGc3dS8xeWJrRkZaTGx6TnJIWWVDUE80aGFmY1pHMVIyL2o3WDV3?=
 =?utf-8?B?bGFIKzZ6VytFNFBhVkx0RnlDL1NPTnNlekJiVFJBaTJrTHZPaDVkM0RCWmZV?=
 =?utf-8?B?ZjN4OHQ1Y0pqSThNclZwN3djRkxZL1c5aVk0Ui92WTZrM0h4bnNITmE0ZHE3?=
 =?utf-8?B?ZllWc3dTbU8wSEo0NGFuMW16MTlrZks5VDlDN2k1YUpBMHNmVWppR0hCbWc2?=
 =?utf-8?B?dXZjbFE4YmpjYVdkZDRCU0NtVVJJMlpGQVBURTV4a1lsdnBTN2NmalhrKzNu?=
 =?utf-8?B?VWN2OVM4dDlFTmJWUXpqeXhGUFhnTThTdmNJVFN1SDYwZGdUTDg1WFBZbWha?=
 =?utf-8?B?eTFCQlJyck5adUlFTS92ZENMU1Yzdms3REQrbXJZclZVbSs2QUp2VVdRQkhu?=
 =?utf-8?B?YWtqVGdWZFArRXd3ZkZKRitIT1RkUDc0YlN1TXpaTnVwK3ZxYWNBaUtlS3Az?=
 =?utf-8?B?QnlSa0hRWGg4MEdDWEI3aytrc1M0UjJsemhTekkzQVpUOXdxbndJN2UyYXVW?=
 =?utf-8?B?aE9aS3FPSS9LL1N4REp5YzNDdk1SZXJTQm9lVlkxNE1LRzQrd21PVjU4WmJQ?=
 =?utf-8?B?TTlKRHpldmVsZVBJZlYrak5JSE9laEErc1JCRHE1YUNrQzA4MEZKMXhhZk1W?=
 =?utf-8?Q?dSbDv0VZ775wYjhD1TO7OEsP4phIsTGBvLXRI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7546004e-ffd6-4c5f-79e8-08de64269ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 19:50:10.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQU5ROR64nWaN3DWwkycQOr8M0SKM3P74k6As6i0UThCtOcaeftbnFqMN8M/cj3kfd5sQtH0VTii5FtVQqj3JxJjept69Lf7KwI5/pWHsLiWOd/egtynPo7wo4hC17wM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8906

PiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgRmVicnVhcnkgNCwgMjAyNiA5OjQ0IFBNDQo+IA0KPiBPbiAyLzQvMjYgMTI6MDIg
UE0sIENvc21pbiBUYW5pc2xhdiB3cm90ZToNCj4gPiBUcmlnZ2VycyBleGlzdCB1bmRlciAvc3lz
L2J1cy9paW8vZGV2aWNlcy8sIG5vdCB1bmRlciAvc3lzL2NsYXNzL2lpby4NCj4gPiAvc3lzL2Ns
YXNzL2lpbyBkb2VzIG5vdCBldmVuIGV4aXN0LiBVc2UgdGhlIGN1cnJlbnQgcGF0aC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IENvc21pbiBUYW5pc2xhdiA8Y29zbWluLWdhYnJpZWwudGFuaXNs
YXYueGFAcmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vQUJJL3Rlc3Rp
bmcvc3lzZnMtYnVzLWlpbyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9B
QkkvdGVzdGluZy9zeXNmcy1idXMtaWlvIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNm
cy1idXMtaWlvDQo+ID4gaW5kZXggNWY4N2RjZWU3OGY3Li40ZmM5ZjZiZDQyODEgMTAwNjQ0DQo+
ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvDQo+ID4gQEAgLTE0Mjgs
NyArMTQyOCw3IEBAIEtlcm5lbFZlcnNpb246CTIuNi4zNQ0KPiA+ICBDb250YWN0OglsaW51eC1p
aW9Admdlci5rZXJuZWwub3JnDQo+ID4gIERlc2NyaXB0aW9uOg0KPiA+ICAJCVRoZSBuYW1lIG9m
IHRoZSB0cmlnZ2VyIHNvdXJjZSBiZWluZyB1c2VkLCBhcyBwZXIgc3RyaW5nIGdpdmVuDQo+ID4g
LQkJaW4gL3N5cy9jbGFzcy9paW8vdHJpZ2dlclkvbmFtZS4NCj4gPiArCQlpbiAvc3lzL2J1cy9p
aW8vZGV2aWNlcy90cmlnZ2VyWS9uYW1lLg0KPiANCj4gV2hpbGUgd2UgYXJlIGZpeGluZyB0aGlz
LCB0aGUgZG9jcyByZWZlciB0byBpdCBhcyB0cmlnZ2VyWCByYXRoZXIgdGhhbg0KPiB0cmlnZ2Vy
WS4NCj4gDQoNCldoaWxlIEkgZG8gYWdyZWUgdGhhdCB0cmlnZ2VyWCB3b3VsZCBtYXRjaCB0aGUg
ZGVmaW5pdGlvbiBpbnNpZGUNCkRvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWlp
by10cmlnZ2VyLXN5c2ZzLCBJIHRoaW5rDQp0cmlnZ2VyWSBpcyB0aGUgY29ycmVjdCBuYW1lIGhl
cmUsIGJlY2F1c2UgaWlvOmRldmljZVggaXMgdXNlZA0KcmlnaHQgYWJvdmUuIElmIHdlIHdlcmUg
dG8gdXNlIHRyaWdnZXJYLCBpdCB3b3VsZCBsZWF2ZSB0aGUNCmltcHJlc3Npb24gdGhhdCB0aGUg
WCBmcm9tIGRldmljZVggYW5kIHRoZSBYIGZyb20gdHJpZ2dlclggYXJlIHRoZQ0Kc2FtZSB2YWx1
ZS4NCg0KPiAvc3lzL2J1cy9paW8vZGV2aWNlcy90cmlnZ2VyWCBpcyBkb2N1bWVudGVkLCBidXQN
Cj4gL3N5cy9idXMvaWlvL2RldmljZXMvdHJpZ2dlclkvbmFtZSBhY3R1YWxseSBzZWVtcyB0byBi
ZSBtaXNzaW5nLiBUaGF0IGlzDQo+IGZvciBhbm90aGVyIHBhdGNoIHRob3VnaC4NCj4gDQo+ID4N
Cj4gPiAgV2hhdDoJCS9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2VYL2J1ZmZlclkvbGVu
Z3RoDQo+ID4gIEtlcm5lbFZlcnNpb246CTUuMTENCg0K
