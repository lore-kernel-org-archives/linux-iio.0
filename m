Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C238E8A0;
	Fri, 21 Aug 2026 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316652; cv=fail; b=V7JONDj9Cb2cV2xUEh1YaIp498HlySSAD/LLbgS7DMIrQiUHT7xkySTl7me7H/DEBjG+v1ROhK573KZbUySMeIX1q06hl+/KkKcwqmPkEAyUOS+cUSSvzjETMZ2e3Tw8MpZYWeU/zONhOFlE8Q0wPDJJyiCFP2njOarOHRt/Ruo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316652; c=relaxed/simple;
	bh=adDKUT95TZzaOuruNgpgZU7s2uIGfLp0Rn6N9DwDMWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ccq4VfAoVK4OkgOHhRyFyCrbTnSwd6Oi0QN1K21fVfGSW4x3NIakW79lKZcqak5TUQaXH8m6L32CKez00aqD/f1dfna+P/WThIEWLhyYMl+CyanRJWvihfyfwym2qn8s+frk4COgFf7mbaU+gzEmvnm6gGpwOteW4TqCx7qGtRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=lJXkVp5+; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="lJXkVp5+"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCmWO93630619;
	Fri, 21 Aug 2026 12:50:44 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010038.outbound.protection.outlook.com [52.101.169.38])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4g4ydytq2h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:50:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EA5p8gjiN1PPFigzSVzSbk7dK8fX0T8WIcCw3d6Es8B9KBW4HzWT3SxUzl5HahGZMlbnp/8GsjUzCq2DACYCsqFnQPmqcru9x+exH4cMuoLdshEFiT8BT27Vp0ro8Yl6m5sEMv8PRaumbQBeeMyUa3d2FVTHKC5fSYXiJsmlpH0b6sfh7v/NyZybV5V1JEMhuiyZRWXpE1hae+hvSAf3JMaCaipWHTe5DWLAoiYDoNRbaJ1vIq+bRhwCTKwMxyL8sx2+UUzKf0MiWSx5OMF+D/nCzEFjXwiFv1Kw3ZyWxArIvPE/bduh4XS2NU0FbzEeS3AukNvec/MYrKEr2+ibNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adDKUT95TZzaOuruNgpgZU7s2uIGfLp0Rn6N9DwDMWw=;
 b=dp3ADWw7PEeCO/wb+AM+/W7kHxaoOc0BKmxeFBj8u5pTuchRlg4+FaNFHfDMkKZ7TlQQn1dqKsGKsqtHk/YgWNIPsyFLAFhSrmT41cSUN6a/VrFx1/MDa9n2VBUi11dCUbmgrGjn1QzRYhAmlIgwUWzBxLWdd1oi/a0Px74k6AEMJCXvks6MXM0L8maPgN7CcIcp6rse2nBs966N+t0Pl1EfHYrKnHbSLIsDrFL6vYy9q88WSMRluJ+cAZIjILE+bSO1d5+vOdB+qNdFVornuQVsAMbFcsHSpIWxQYyID0tOUSrjiWqer2X6gi38n6F9XqwUYA3Wuz7mmS14PVdC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adDKUT95TZzaOuruNgpgZU7s2uIGfLp0Rn6N9DwDMWw=;
 b=lJXkVp5+WESJi2iSP/FhZSC4duXRtwGJA3nR4EDJJuTzxZqq3b8kkVftByb10X3mq88dlQby7ogkjKcuin4jWuh/BUab3Pqy4l/jyozwNyefoI4r60WolVyjJbOCUSpnchXq+R/n+1mXOfua2vSINxb78r6XUTTg30HoFacsPSJVw3cRgGxbt1OkW0jhpJVdkfZQnAEtdhsFqVAcbOKDh0/1ehnDBOlc+smMqG3g0JnKP3FhMl0w2M8BqMbUq0hJKkEODPn7dMDLYSbdkERdGwz69Bql1sXHAmvLO77+VZQkOMKnOSCQpBWvbmXCN4HKh2G/Q4lbn/9QyC96FMwAuQ==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BENP281MB6127.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:10b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 12:50:37 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 12:50:37 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Thread-Topic: [PATCH 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Thread-Index: AQHdMNaCkfw3JSjenUm8FyoeTF/EqraoWu8AgAAXu9o=
Date: Fri, 21 Aug 2026 12:50:37 +0000
Message-ID:
 <BE1P281MB1426D50075F4223A98D870F7CEA32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
 <20260820-inv-icm42600-enhacements-v1-1-075a881db557@tdk.com>
 <aogzNOaeOHQ732oP@ashevche-desk.local>
In-Reply-To: <aogzNOaeOHQ732oP@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BENP281MB6127:EE_
x-ms-office365-filtering-correlation-id: 81ae3f65-029e-46a6-45b3-08deff82cc90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|23010399003|19092799006|3613699012|38070700021|56012099006|10067099003|4143699003|11063799006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 87lqpzlL/II2sFUmcSH8n/Jbk9QQGVA87XkCcJEey0GAUOa+ZEUyERdCaDOP+VC/JwZB+yWNRVB3KTbtJIf1rKa1oTirGBb28coIjzdCPtQmY3NqDpT7hvBZQuacFQk0dtdfqagAJceTHK5aWuAQe/X2ahtq+jqDg1FdPmE4hz0m5ollsc+Ny77ZDuA75Oh3k4etQxMur7+LlAuhn1mnU1dpylaCjAI9ZEqc+AykdUAUe9QlcVpzLHDUEo1CIImPK/DGWNzkHn0RX6paE2J3KHbvgVqPI2e6A48aV61n51NibM3xxKdjeJf+9NrCx1hyyqWF3qdgiHcNIEUUQOFlbkisix3emxu94gTzsmTRURtrIfODhLrjsCf+GNDq/KvLfFVzZi/QSIwyLSkpmPC+Fuee+Mks9n/QU9FbGUJrnLJAdKdaOrp5RocAJajQWMfPIm++/2q3TrHtOljVx8QySv4P80AQ+0rCfK+80ThqL+MV+pFdmVw9ICnn8yq3hS+LUj+2rLPhjCjKS40P6b/OqCVZ3osNmkWTAZAeSgBGJ7pgX7NX4aXe4RLOQURgTJi4lfmClauCvGQbEqS60Tp2Rl5vWqF+vUp8L9x+nMFOj+iXs0LSYL+YEuAmO+IYEdgcxFuuyhqwi0sqKnIcr7N8UtsAEpIXzg3pXIkQnF2HT/p2YzsyuI9XNHXj2/ysnV03E1u/w9mOIcT06rS5oJqyPehu1TLGc3Hv82ZfHKP1aJaucIgOvMJczApq+72Uiztf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(23010399003)(19092799006)(3613699012)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEZVMk9CNk9FZjFZVjdqTEVoVXQ4bjF2aURxYmZnYlZnVW9OTjlHSndwM3Yr?=
 =?utf-8?B?TW40Z3pNcEtBR0ROSnRvS0ZrMGE1RkhpczFPcUJlUEt6L1hSWFBaQ0Z1Tncw?=
 =?utf-8?B?bnRyY0lIWHBoQzhyRndjWTdpVEVLN3hhMnN5SHRzWUFjT21EZzFPRXJSY3Fz?=
 =?utf-8?B?K0ZXZ2FJUVg2SXFzMHczNmZkUk8xaHk4QkRVblZkRmh4dk1tTTBXcUtJTGlk?=
 =?utf-8?B?V0NhZDdjaW14UU41Q08xRUFtRGxzOG9ZSFM5Z0dnaEd2MzNZY0wxSGlyUmxs?=
 =?utf-8?B?MVpKQWlpRVhqdWc3T09sTXpZRk5pSTNxV3NnZU5iSHE1QTlzTE8wUENFYmZ1?=
 =?utf-8?B?SCtrdHJNbEhzeFQreTNpeTl1UmxJUllLMXNDcDhLMWtYUmF1T0V1d2hDNGFO?=
 =?utf-8?B?clVjbkdBN0dVWXlYL3UrbWI2VG1YYTJ2YkYxYld3RGdONDdpOU9kQ1JEck9k?=
 =?utf-8?B?Y21pa2dqTzBua282VWZDcFFNMXV6SXJ2YnZtdkc1Umo3ZW0zZExkNTBjWm1a?=
 =?utf-8?B?QU9CVndWVFhsdm1NcmpHKzBNd0gvSTFCdGtrT1MyeVBmS0Q1aXo5TmRPRENq?=
 =?utf-8?B?QWRQd1djVE5SZkVoVVE4SVNPb3kraXdUMFNOQ2xZVzdlQkxyR2FxMWdUSURM?=
 =?utf-8?B?V21sUksrVTRNeHdXWFBDTk5pM2gwQml5MW9sa2xLS2gxcTN4dUZuN0p0eTJF?=
 =?utf-8?B?TGdhdTRRYWZPTW80dG5rSXJiKzFDUkEvbjNaWVdtYUt1QWt0cEpkQnErSWwz?=
 =?utf-8?B?TC9VTkxvMW1LL0YvZW9JZitJUUsrWmJvdW91blBrYzhDZWc1dDZ0Q01LQ0NR?=
 =?utf-8?B?SDZBT2tyOFFLR3ZQdllVd2hOU3N5ZVZuRzA5ejVSY2hOeUcvNmovWk8xUEFM?=
 =?utf-8?B?WUhtS0x1cmFJRkdQdThpbFBPUmR3a2FZYU5zTDlYV0dTVTRidlhYMVg2bS9Q?=
 =?utf-8?B?NGxKdkx2QWFlZGRnUUFyc3N3anc3a0ZJOWs3ZWpmV3FNMktSWFpkQWtJb1Vx?=
 =?utf-8?B?aURUVmplUDRYblhyZ2dyRzY4MXFZaEszcVNJT21tcXUwb1Fyb3pqV0pyOGFI?=
 =?utf-8?B?ampHUVRxVEFWK3FqVHBjQWxMZzRoNnZVdjMyVGVHbGZFaVhkWUtOZm84MW9x?=
 =?utf-8?B?MW1BMEFIL0R2MThtS2VTZzhPSGQya0VvS0RFUHdyRWpiSG4zVlltOURmUHVi?=
 =?utf-8?B?QXBzTnJHNjljUVlLL3lGTjFJUnhWU1RpTkpqamUra3U1Yk5xMU1SODZ5akEv?=
 =?utf-8?B?eC9uNGo4UXlpMURuY05mNHJacElkRDhoRDFqeHNqczB6bUM3SkFua0lJcnda?=
 =?utf-8?B?NFphbFdKTkRBeURFcjlHVzkrRStVK0hya3JQbEhpaUlGc1Z4TW51ZTNyMENx?=
 =?utf-8?B?cG5tRER4a1hxTEI1ajJXYUpYQ25RTEN0YXRTVFlLN2RIbWhLSk5YcWhlcU5T?=
 =?utf-8?B?R2JWd1F5VEVNdXhFajBNVzZOYjBwc214SUJZWlpndTZ2SmxqVzBJUXhlclFq?=
 =?utf-8?B?M0NxNUptSlQ2eUl0SDIyOFdhYW4wRTNvVU51bEMra3R2Yk1vNXlRNUxNd1ls?=
 =?utf-8?B?YmVvMXNZOHhFbGVNbWM3VW1IU1JFVVVUaTd5ZUFBelpLajR3ekhlTE5EL29q?=
 =?utf-8?B?ZVlFdTA2dDdYTzFyeU54MmVCeWYvYkoySm9yc0hZS0Ird1lpaEo1akpuWFFX?=
 =?utf-8?B?KzBDTU5raDN0NWV4L3BQSll0R0I0cWk5YUF4eUY1ak90RlMwRGxBVzhKZTc5?=
 =?utf-8?B?MVlBakVXYkl3MEJDdEZMZVY4Y1dsUE53SEFOL2lSb1R2TW9VK0FLSkJFbm1V?=
 =?utf-8?B?aTY0WCs3R1RpMnA2NUpBZWRzYmRUMjlJVGtzVkUvNDU1R0gzdW5YQUNKUXZ4?=
 =?utf-8?B?V0tXTktneXRVYWVYQmtJdWZLTS9NK05KdW5HZnNkdDYzT1JwYW1rT3ZoRVIz?=
 =?utf-8?B?dk9EUHNiS1RBSVd1dEN6VzRoRFJvdEJvOGd5SlZVVlk3ejNjMnBBRHFzMzZF?=
 =?utf-8?B?VFE5QVdiTnFpT2VWMU0yVUIyWkRCcm14dk8wOXlsRnZ2VFBQWE1rclE2MTlH?=
 =?utf-8?B?LzVISlN1NFd4dzdxdWlTUzRmdHoyLzRrQmZ6ZFJKak5DN2U2eS9LR3RJbmc5?=
 =?utf-8?B?K3Fab2FHZ2V0V0tRcjhxMXNxc1RzMEZsZmZ4dHEvUHBIUG9jRVF5b0wzOVl4?=
 =?utf-8?B?WFgvMVlHSm1hcFNydTBYU0lZVHoxQ2ZDOENzQWRjYVVhdkNKNlRmakhqRVBw?=
 =?utf-8?B?WGc0Nk0wSi9XQWJ2UHVibVp2dFNHL1ZMNkhhNlRLK01jYXJjbVRadVdWRW4y?=
 =?utf-8?B?cmwveWdMcnZ1UnRFVjhZcUt3V2gyYUxNc3RERnRCWDRnZnJLTVc0TnFCUm5l?=
 =?utf-8?Q?1hwR+siYrvd9VVWolddoaDA9kW0Sasfdag/wYsEQ5PF18?=
x-ms-exchange-antispam-messagedata-1: Z/vGc0UeIY59Rw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XUdxVvm1f3JElYfv5Ho/JqgXsodkGmAw6b98ATKw9qO0E8EKsxwnkdbSUQ+kStpcGH3tVlLWmL4l2mcLsLle41ZLUdsQoZImn+rcezhTUZS8wIb0qucQ9FC8b2b+Wk+b8x08qpJmNTXv1BzK+2qziESMq85H8o/TZYsoUxokbiZ9+dvnNbPUOIIU374rx5dOGqtdBfwXe18oEy5gcZ6QUyqC4UCxyTWep+61fT8kMP4OFxgEyl5qKrv6k5QkncWngue5oUyaWiD0/09BXOoIHRrD6hv2nE1IYd3GuWbHXVjArfZdIK9J8sOFssAiJHFmVUy8H1WQyN9IoA+erjMH0A==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae3f65-029e-46a6-45b3-08deff82cc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 12:50:37.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05z3f7rtbC8TgPX+PpM4Hkkb50SYFYXXSU3saaM/kefoU0+akBUoz4m54wVwhAOFAAj1uKL2QBUZYBa06jxSBYmSmwEs1dhwxT/g4Dd+Xt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BENP281MB6127
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NyBTYWx0ZWRfX85W0P2/G2vwA
 Ufx7soqcEUE8iM+Cz72wixnRIHGqEPXREtc6eb5mLDhNXesTE5sf3kNdU3oaMaqMAPbj/h6EEOE
 oJED271GRhv2tLx+KayzOg62c3fPkj048YSB131c6Otyw/hWevCg
X-Proofpoint-GUID: L5PkhYl78Xv-9Thed_Oj06zakNo2Q4xx
X-Proofpoint-ORIG-GUID: L5PkhYl78Xv-9Thed_Oj06zakNo2Q4xx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NyBTYWx0ZWRfXwzxwFBOatPC/
 hPRWP8CFRuVnhaa4lbnBWspI9vawwVnUOib/dZgUdvNjQG9SUKCOnaRxd+F+JSLbF0QFgH/P4Xk
 IeWrge3mcVgLSUdKhdEqY11EjE8INJwrQLNxnWdaq/fRD/tT2GtGwvZ+9ytBcfuo0DmT2IlpIaB
 tbYkhtG3hXuTkDQs2CxkyWsaL4BPBrv/vqvVIgRMZEPQj1yygqeo5RQ7OGkPxTFLWbRGTlPzhPW
 hA91+tSPvV7PUxKznaoOYfH1TuP480fhDukiTYfkmtYlUEemiCrGm3TjtC3R/cPbNyj8q+Bru1a
 hfWhbEWQiQRG1sM+3Omv1yWTU7Qi7IByxk0uBnakKUDaTtkPGmWflhHrfcoouSSNsSsrqdA0tI3
 gteMzLMTJ+4A7gdhEHjr/T6fikwNXqzARNOkOXaZLno5KA28AkTLGq1osTmukHUoj6k0akspghR
 KG8DHsprQ2TJ0n35Few==
X-Authority-Analysis: v=2.4 cv=PqyjqQM3 c=1 sm=1 tr=0 ts=6a8849a4 cx=c_pps
 a=KuWcwYso/hODYCsjht2v4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=B7BNX458KI8VPRx4wg4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210097

Pgo+Cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5Gcm9tOiBBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4KPlNlbnQ6IEZyaWRheSwg
QXVndXN0IDIxLCAyMDI2IDEzOjE1Cj5UbzogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbAo+Q2M6IEpv
bmF0aGFuIENhbWVyb247IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNoZXZjaGVua287
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wKPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBpaW86IGlt
dTogaW52X2ljbTQyNjAwOiBzbGVlcCBiZWZvcmUgZW5hYmxpbmcgRklGTyBkYXRhCj4KPk9uIFRo
dSwgQXVnIDIwLCAyMDI2IGF0IDA5OuKAijAyOuKAijM3UE0gKzAyMDAsIEplYW4tQmFwdGlzdGUg
TWFuZXlyb2wgdmlhIEI0IFJlbGF5IHdyb3RlOiA+IFdoZW4gdHVybmluZyBhY2NlbCBvciBneXJv
IG9uLCBhIHNsZWVwIGlzIHJlcXVpcmVkIGZvciBsZXR0aW5nIHRoZSA+IG1lY2hhbmljYWwgcGFy
dCBzdGFiaWxpemUgYmVmb3JlIHJlcG9ydGluZyBjb3JyZWN0IGRhdGEuIERvIHRoZSBzbGVlcCA+
IGJlZm9yZQo+WmpRY21RUllGcGZwdEJhbm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBh
biBFeHRlcm5hbCBTZW5kZXIKPlRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9y
Z2FuaXphdGlvbi4KPgo+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+Cj5PbiBUaHUsIEF1ZyAyMCwg
MjAyNiBhdCAwOTowMjozN1BNICswMjAwLCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBS
ZWxheSB3cm90ZToKPgo+PiBXaGVuIHR1cm5pbmcgYWNjZWwgb3IgZ3lybyBvbiwgYSBzbGVlcCBp
cyByZXF1aXJlZCBmb3IgbGV0dGluZyB0aGUKPj4gbWVjaGFuaWNhbCBwYXJ0IHN0YWJpbGl6ZSBi
ZWZvcmUgcmVwb3J0aW5nIGNvcnJlY3QgZGF0YS4gRG8gdGhlIHNsZWVwCj4+IGJlZm9yZSBlbmFi
bGluZyBGSUZPIGRhdGEgdG8gcHJldmVudCBwdXNoIG9mIGluY29ycmVjdCBkYXRhLiBUaGlzIGlz
Cj4+IHJlcXVpcmVkIGlmIHRoZSBGSUZPIGlzIGFscmVhZHkgb24gYmVjYXVzZSBhIHNlbnNvciBp
cyBhbHJlYWR5IHJ1bm5pbmcuCj4KPi4uLgo+Cj4+ICsgICAgIC8qIHNsZWVwIG1heGltdW0gcmVx
dWlyZWQgdGltZSAqLwo+PiArICAgICBzbGVlcCA9IG1heChzbGVlcF9hY2NlbCwgc2xlZXBfdGVt
cCk7Cj4+ICsgICAgIGlmIChzbGVlcCkgewo+PiArICAgICAgICAgICAgIG11dGV4X3VubG9jaygm
c3QtPmxvY2spOwo+PiArICAgICAgICAgICAgIG1zbGVlcChzbGVlcCk7Cj4+ICsgICAgICAgICAg
ICAgbXV0ZXhfbG9jaygmc3QtPmxvY2spOwo+PiArICAgICB9Cj4KPkRvZXNuJ3Qgc291bmRzIGNv
cnJlY3QuIEhlcmUgaXQgYnJlYWtzIHRoZSBhdG9taWNpdHkuIElzIGl0IGEgcHJvYmxlbT8KPihJ
bWFnaW5lIGEgZmV3IENQVXMgZG9pbmcgc29tZXRoaW5nIHdpdGggdGhpcyBkcml2ZXIsIGlzIGFu
eSBvdGhlciB0aHJlYWQgbWF5Cj4gaW50ZXJ2ZW5lIHRoZSBmbG93IGhlcmU/KQoKSGVsbG8gQW5k
eSwKCnRoZXJlIGlzIG5vIHJpc2sgaGVyZSBiZWNhdXNlIHdlIGFyZSBpbnNpZGUgdGhlIGJ1ZmZl
ciBlbmFibGUgZnVuY3Rpb24sIGFuZAp0aGVyZSBpcyBhbiBpbnRlcm5hbCBJSU8gbXV0ZXggaGVy
ZSBwcmV2ZW50aW5nIG11bHRpcGxlIGNhbGxzLiBUaGUgZHJpdmVyIG11dGV4CmlzIHVzZWQgdG8g
c2VyaWFsaXplIGFjY2VzcyB0byB0aGUgY2hpcCwgbWFpbmx5IGJlY2F1c2Ugd2UgaGF2ZSAyIGlu
ZGVwZW5kZW50CnNlbnNvcnMgaW5zaWRlLCBhY2NlbGVyb21ldGVyIGFuZCBneXJvc2NvcGUuIFdl
IG5lZWQgdG8gdW5sb2NrIGl0IGhlcmUgdG8gcHJldmVudApzdG9wcGluZyBkYXRhIGZyb20gdGhl
IG90aGVyIHNlbnNvciBpZiBpdCBpcyBlbmFibGVkLiBGb3IgZXhhbXBsZSwgd2hlbiB3ZSBlbmFi
bGUKZ3lyb3Njb3BlIHdoaWxlIGFjY2VsZXJvbWV0ZXIgaXMgcnVubmluZywgd2UgZG9uJ3Qgd2Fu
dCB0byBibG9jayB0aGUgY2hpcCBhbmQKcHJldmVudCBzZW5kaW5nIG9mIGFjY2VsZXJvbWV0ZXIg
ZGF0YSBkdXJpbmcgMzBtcy4gVGhpcyBpcyBldmVuIG1vcmUgaW1wb3J0YW50CmJlY2F1c2UgdGhl
IEZJRk8gY2FuIGVhc2lseSBvdmVyZmxvdyBhdCBoaWdoIHJhdGVzLCBhbmQgdGhlcmUgd291bGQg
YmUgZGF0YQpsb3NzLgoKSG9wZSBJJ20gY2xlYXIgZW5vdWdoIGluIG15IGV4cGxhbmF0aW9ucy4K
ClRoYW5rcywKSkIKCj4KPi4uLgo+Cj4+ICsgICAgIC8qIHNsZWVwIG1heGltdW0gcmVxdWlyZWQg
dGltZSAqLwo+PiArICAgICBzbGVlcCA9IG1heChzbGVlcF9neXJvLCBzbGVlcF90ZW1wKTsKPj4g
KyAgICAgaWYgKHNsZWVwKSB7Cj4+ICsgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZzdC0+bG9j
ayk7Cj4+ICsgICAgICAgICAgICAgbXNsZWVwKHNsZWVwKTsKPj4gKyAgICAgICAgICAgICBtdXRl
eF9sb2NrKCZzdC0+bG9jayk7Cj4+ICsgICAgIH0KPgo+RGl0dG8uCj4KPi0tCj5XaXRoIEJlc3Qg
UmVnYXJkcywKPkFuZHkgU2hldmNoZW5rbwo+Cj4=
