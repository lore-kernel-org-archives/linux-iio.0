Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE132B105;
	Thu, 25 Jun 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378235; cv=fail; b=n4Th/R8/5kRgFcB+qVSHD1XTG1IF97T5817rl3TNmyKzsXrjOsvTbw7+HZ8yd2vWdcWrtCI1G8JyJeTF4jTH6eSGYNxwjIfxK+U2+gfJ2EozfypK/lMSNaHbun8U1IeyhS/Tl26PrExgw1U1KcYZyvQlC4fFvIBjjciSGyGMGJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378235; c=relaxed/simple;
	bh=dEdDRCCg4gKab9sOvxQpHBdFPa+sJZYfzHGSdsDN0rg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B9dWw53Wnh+JkOIw0w3wTRo5sL8h6a0EnfVUDKLAd/Vdm1H02vTIGVzTr9wMqFxO8M5p86JWb+l6XBFD2s9Wi7JpXXUOK/Hdp3jx9W8nnyJUGy/AvQS8+EVEkpBM1oyzJX2vU5CyGZYLwTC3D8YQ7PFoeQsGXFVKjSrBVmW23JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=YclUkLKq; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="YclUkLKq"
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P85t1H797209;
	Thu, 25 Jun 2026 09:03:32 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010049.outbound.protection.outlook.com [52.101.169.49])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4ewm7hvdsa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 09:03:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpRsaJTNjMMxoLssLf4bZlsInDYTrLSHv3YBYQAPVZlYjoa/760rmYS4524Mp3nFvtMok2aK9IQhR2h1UYMLEqyN5wFpvV6YFg6r3Cvn5uw6AAs3Ce88uOD1z1RDJW+w0msO4W1WXjXWPMPrv/kDr7C5i44gGkq0JMq+SIGQhST4EO+UjoezDp+1W97IfeegFxzyMTe2mi4vV7jWrhd8+CN0UtWHdI/7D9TrFaEI+ovaOzAlPtiRd/6rHcGMcH2QE3XztJwDs0d1XfpAIfsQAVtMtye1sDSp5vFvydTTgIYG5Yf2iQdTtLZqhiMoP/Gux+co/MOWTw3JuFjUiMn4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEdDRCCg4gKab9sOvxQpHBdFPa+sJZYfzHGSdsDN0rg=;
 b=pUhGf4h5Nhn3/YJk8be9CvHGH+nrfQPkGG8mAfsj/4kc/fJbsfRFsNYD65kb7+2NO43KL6sSGATf2URTh183W8PcjFXneRNM6LP7DiXkKvJnUZFvmnmZg01u1BU4ZGfSlGpZFCeEsFINQYSEH6mOiYrmJnsLhp7wnrP1AG07w2IoFMGjHBk1BKIDV6OHvtBmBJ0T1uKqqyAPvUIxSV9cl4tYNHDLQYzzlwuFiiUmM3XI6GZe0caib6sGmlAbrpJPH1wWdUT33yh3Qnx5Y3cX7tNs4DOl4Bi4cJw7Az7JKT6B6PDLTcDl2AniUDPLbMXHCHuN0UiLWlTkFN1aDTPcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEdDRCCg4gKab9sOvxQpHBdFPa+sJZYfzHGSdsDN0rg=;
 b=YclUkLKqQzLt0uPn9j0hPXXsbmlMosZfcw3U7KqykHoYFQ8m36Ofo0ZYlmfc1kyTfpp43c4hkZ2iF6/MtLJwDiq0YQTC+X8kjCUE/Ksopzt3XyDPpXzHUO6n2fgfuD3bf99eZfv1cNf87Gc3Tg6Kt7SZjs6rOB/dVStVUQzKxFKyOXaN2u1dqKW5mMIZAYbi9bftrQZb5rrq08D6zNQc0TyR99PtBJv1rWcJxpEaKur8pJHUElJxfI5h9PVxc34GKhzlL02A8WR86Ly4WNtgp3JKohtfXuL9ym2BxzMTrdgF8WGtFBs+DXm/GVRk0/6dy6W1DrWPgsWVFXutmn69Dw==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BEVP281MB3709.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:8f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 09:03:27 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 09:03:26 +0000
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
Subject: Re: [PATCH v3 1/2] iio: imu: inv_icm42600: reorder includes for
 buffer module
Thread-Topic: [PATCH v3 1/2] iio: imu: inv_icm42600: reorder includes for
 buffer module
Thread-Index: AQHdA/WJydNTHJX9Gk2YxpSMBIiqn7ZO1a4AgAABvgCAAAB2gIAAIoiY
Date: Thu, 25 Jun 2026 09:03:26 +0000
Message-ID:
 <BE1P281MB1426FFB25C3D16681EB8843FCEEC2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-0-5d9a4c662f50@tdk.com>
 <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-1-5d9a4c662f50@tdk.com>
 <ajzPhi3ymeIBYHRr@ashevche-desk.local> <ajzQ_FUr--jTxYWr@ashevche-desk.local>
 <ajzRX7Zr7BzUJFNb@ashevche-desk.local>
In-Reply-To: <ajzRX7Zr7BzUJFNb@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BEVP281MB3709:EE_
x-ms-office365-filtering-correlation-id: d0602c1e-0e71-4ae9-a0a2-08ded2989e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|1800799024|6133799003|56012099006|4143699003|11063799006|38070700021|3613699012|22082099003|18002099003;
x-microsoft-antispam-message-info:
 wJTHSLsXajImnUA1LM/894hPqOtEuiEI/QAiyiCeIJ/GYiV7GJlILLo/nrnudmTRCPByBSIXuIH6Uy5hp5JbFPMnBSG0ZApRIGgwylysiDZZyDTHUXuXLimyR9iz13rpXS6x0CTpeAS4s5Sp6QKcushQMrKh5DMh3kUwDgkxOFaqM+dDmHVbFD41PkHYlW1SAW1k8hcGOcHMEuWFBqg3fboiiNeVx4kyyBmcoKT7sJoZ0QFzaGtFOTieCOE2dvrf1PfEYQBQEba0oUI0/OA9fvsNWnz1AlpexkJ3RVq1lC2nrseGEn2/3deHo/LMH2Q8ldLv4Ksfczq7J56TD+1ErC91WwDl7WT6LSU/tqSj0t6OdcbQc89nrvIUjan1IaY3UfJUNjmOPlbSoe7GbTMWHdeWULBO0Bzvbylp0T3UVNCFwLPeqs3dI/JgS5aMwAH2Lo7u9kcDWlpfVDk+CxSTkfzOtopj5LwSclYEgZnuw5p8uqK18D9JETio+PdiW3DFUdStJIge6U3cDiP0UtxUOjH+vj1vccmZmxMG6b+86blY7CfWkHl1SQnnRWeROx1RWw3VEnKUcfjSLk53hwnUp7CJhiW7/u4i/KvZ8/skN6t4zd+26Qk+NA+UWAJETx/FHJ5nt0C+jryj0/X6owoiIOZTwSF6yYEAQwRoZPOVBAKE6UfNWlz1+E6vvXGj97KN6eC+GxUuR3zBN3jGCQYpm0NbS+7/+f+rZ73mbcnoGU+FPeYR8hGjWLRfrDiSCboK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(38070700021)(3613699012)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckZuQnFvdzNvT1ZmSWEra29JcHlIZ29ya0cvMDM0M200MGhUL2hNSUxEejho?=
 =?utf-8?B?bjNhNk9adXRNSVdZY1ZGUE8zbGYzdFRkL3ROOW9DeXBQckVSZUtIV1pKblYy?=
 =?utf-8?B?WVVuTXpFYmxwM2RaT2Y0ektLRDFUcTNKQ01HRDBrdGJ1WnZPaFpadm90RG0x?=
 =?utf-8?B?aDZYMTRlZnJSN0xXK0tYWmlJS0lsQktWTldBUHVvNk1mS1RGK0tidUhuak1X?=
 =?utf-8?B?NEhES1IreXRQK212V1RIY0NZdVZwZkRHRmV1ekJhcHlaUzhCU215WGtLOGNE?=
 =?utf-8?B?cWdVdXBZT29OcHFreHMyTE9SZzNHdC9WdlJ3QU1GTGliRzJLV3V2N0VCS09q?=
 =?utf-8?B?SHBoTk9aa2trVHZTamRTYkxic3pXU3lwc2lIQWpaRFRiRWZ1L1l6b09ndDVX?=
 =?utf-8?B?bFFxWUh2amZSK0ViOWkxZXppZDcrTnczSHdMZmdaWWVOUkJWcENBSy9sem5L?=
 =?utf-8?B?MmtqaGxRRE9JNit2NTlqVXNiRndZNVBXWFEraE1GclpRRnNrNlZuS3A4MVkz?=
 =?utf-8?B?dlFVSndPd0ZhUERvUk1LQnRuY2lKM3pwZThrdGk5UHJkU1lQQWlqYnNCVjFo?=
 =?utf-8?B?UDBwbXFaczZ2S2lneDI4Z1pKMmRUVWcyNS9RRkpIZ3Z2Mk1oVm9IWnZBR2l3?=
 =?utf-8?B?dVkxelQzNEVockxseVlSV0hLb0NVMXBldEx2L09EZjlaeEIweE1NVGwvR1do?=
 =?utf-8?B?ZnAvUlJHTWthVEw0bXZNYUVhMnRWOGZiOUFVY3RIOTNpRklSNGhsb3p4Nng4?=
 =?utf-8?B?TVpaTjBCa3VQaUZ3UjFBVEtyTGRscGlsRmpiZFYvZUl2VWJ6TTliYUdMbGh1?=
 =?utf-8?B?d1lEQ29wNndKUmREOURTejVBQXVLZzBUNGVEakNQT2dYbUZEVnBnVnBJUEQx?=
 =?utf-8?B?L01jaU1jam8yc0k3RStpRjBKZ1FhejBVUU1rc1hwMm1KME1Kczl0eFo5SlNW?=
 =?utf-8?B?SWhGSXNKSUlUbnB1aDMrMjFHNVpkaDB5amtZV2YyM1N2VzRzeHRNeDZaNDlP?=
 =?utf-8?B?OGlnZVptNnZnVUdhV2QwMVlIQ3gzTHVJSUY4M2U0cjFLMjk5Qmh6VGd1ZWtI?=
 =?utf-8?B?S0tnZURVN0QxY0lPN1dmRHNHVVgySTlPMUtIeGJpQ1Y2TnVoUExrZVN6NHVS?=
 =?utf-8?B?ZzVyOEZJYk9uWnVpeDFHUnNuVUh5THlRTHhQcU9sRExaVTU5aFNOVmNtckNl?=
 =?utf-8?B?WlJ2ZGcwOVNhNmY5VVYvZmtoem1Za2dGL2kzTW1aVFUvVHN2eGZwT1dUTDMw?=
 =?utf-8?B?ZkpXOVY2TWlMRU1vUlE2MTlFdUxMWjhPcnF4b1d6UHZLangvVkN5US9FT2l2?=
 =?utf-8?B?M0xHc2Q1YnJNZ3ArTHpMMFRqMEgwTWF1RUdYblBLTGVxbUIvLzFJWG9TcCtJ?=
 =?utf-8?B?R2luaGdpQ2hmYnlDQWpicXZGQ28vVk9NeWROUXBoN3BMOVR5dmN2ekZQZjRp?=
 =?utf-8?B?WVR0aUdNb1Z5QVZPRU5FM1VqQVFLT085b1VXdFljem5MTS90Rld1YXM2T3Nk?=
 =?utf-8?B?ZmZCazI0U2ZYaHpGVFRtRG4yVFJ0UmN5N3dtTmhwWGI1U3dTeHF4ZWFVcG1z?=
 =?utf-8?B?c1lTTTNzNCt2MkJNbE4zU2h1RzRYWmdGU0sxUUgwcVhYL1V5cjIvTXNSWjR4?=
 =?utf-8?B?bEVyTVhMYVNIK2U4OFgvRTRzcXVLbUZETFZucThnNGlDNWltcTVWaUhTV0Iy?=
 =?utf-8?B?YVVxT1Z5bWNIVklibnhLck9XRzVBczRzYk1jYmJFS2tnTGtzWFRIeWFTalIr?=
 =?utf-8?B?QkhveGNRb0orVVkwUzhZM21oUU00YmZ2VStBN2ViUGlrK1ZkU2kyWHczVm5C?=
 =?utf-8?B?YjdSWkQzeHlDaXFNalhXLzk5dmNlYzBlblZIa1ZkRmI1bHNtSmduMllpc1dE?=
 =?utf-8?B?SEtKNnNIYVJnWGd2TEE2UllSb0ZqNHA0WktjMlhoM3dNSEo0S0VPZUdwOUZw?=
 =?utf-8?B?ZlNuNmpTWmNzcHUrY0J6YmNmd00rM0dYNG1FZXNrV3hmRWErbHc0R1NseVpG?=
 =?utf-8?B?cUlzUnBzeWhKWDV2b3hIakRYa0hrUjVUQmpJaDlZbStObjZORlRtZmZscmNh?=
 =?utf-8?B?MUhvU2RNUURzdWk2OE5kd2VQRGNjR2tPOUdSeFlEb0xnaWFRNEwvU2lzempy?=
 =?utf-8?B?QTZLbnR0VXhhTWszeWtucVJYdHVYU1MraDBncU52Qjl6R0dBd1AzQ01ydVdw?=
 =?utf-8?B?cG1LRTVWaHV2YjF5dkt4cUMxMS92cldVZE90QnAydk52RGN0ME1oZndlY3JH?=
 =?utf-8?B?ZHArQTNMUGM0NjA4ZlpLL3RuYzRqUjk1dkF5MGxRdHFSTXMyU3FNc3hublJ6?=
 =?utf-8?B?Lzk5Y3ZSaCtmOFI0ZW1Ka1hDREhtR3pvNDdtOHcrbUQ3VVU5YThhMENpUnVi?=
 =?utf-8?Q?Zk2RvOGWBYIxQheg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HtQSUJ7LHbWgHIUcP+9EhAYQIzAOl4/nnpNBvQVdGaw3tR5QAQvoMr9Op3DhONQwFovZQCA2yMGtyV5KiFYcM1RppicYJYgE8xr0DyOlBkFQUAF0c6pfMdmyG8hD6oZQkMmD1PxIW8jjYgMFwuaf7cuyCTxNE1Gh3+fvGvFj+JnsghS8IAve/MnNeExErece4bHlKHYm4UOeEMIDiZCggOpRaWRdRUKHdp9CSqyPn3ZKIdj6lF0dIeSA6eQQBoKg0If6uQcw7ErQ/08s/bSt5j8wOJfS2eUNMlbQ6RjSkD/N1Ifc3ws2MkTIbYlyMHOlesbz0qD0SzWdqYowVbNTug==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d0602c1e-0e71-4ae9-a0a2-08ded2989e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 09:03:26.6421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OyvPI8K5aAbVMbodg3XmuWkFT8xlPbmO0tUWlu8wDn5aJOYZtyupuB8PJVqsNJKtqGJnGSfUeBQeE0j9WD+orarg5MwOT0tE63CpXIoMh/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3709
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA3NyBTYWx0ZWRfXwk60wU9P88g2
 UicrVuiUYFNN/T56aQWG5bu2HyYUKYb5SpSbyHLTN5OLjDgx1BZ/kf9EYpkddHFPuMrp4cBZcfh
 iPITage6drdMjwNwMcMApD3JiopE69jI2fcx8JlBB6gge915mqa8je4ULm2C0ABkHbdyZm4cQp+
 vPZyXvv72SI++HQyh4fNHQ608qvwugzom617DflCh3ArfWbMeJpybRIhZFCryikBLxzfkrgAh23
 PnMbKnilRIxIW0WsYXZ+CINny5QIi7V4tti0tNZMaWfCziyjffktbzBFg3oXCfaRZpw44U0Zrf1
 UDRjaebJBOzNOIDRahEW7eYuiV+tcAibgfJoY0AWWxQnNSJAGLTXmBSYRTtPCcUBWqfbPuC9qG8
 Yk61AhGWHqA68fAOVlWSErsi6nnrotp4ZciE/K/KicjyRVk2ltHIPvKaLyiMhJr7GOtSGDmOo+p
 AaC4Sb5ZoIxurPk79Yw==
X-Proofpoint-ORIG-GUID: FgEs4-ihQf_9RcHRJZYmAxIqR4ky9gNE
X-Proofpoint-GUID: FgEs4-ihQf_9RcHRJZYmAxIqR4ky9gNE
X-Authority-Analysis: v=2.4 cv=Ivgutr/g c=1 sm=1 tr=0 ts=6a3ceee4 cx=c_pps
 a=635Tz7w1hMZbSRr5Z2B8Rg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=Wq_5IC91G7KhcYQU-csA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA3NyBTYWx0ZWRfXzFPNcaDrCxQZ
 wxN7QAW9M2/n0i0XgVxg5v3Me6/8eIkBO6404mY7ei+7rnlCwN6uFAMhXMWv0jktzYApF+Xe0tx
 JYVgShLjzj1alFB2Yn/6cqn4kO0VdN4sm71SMYd5lWFNNpMQRV1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250077

PkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPgo+U2Vu
dDogVGh1cnNkYXksIEp1bmUgMjUsIDIwMjYgMDg6NTcKPlRvOiBKZWFuLUJhcHRpc3RlIE1hbmV5
cm9sCj5DYzogSm9uYXRoYW4gQ2FtZXJvbjsgRGF2aWQgTGVjaG5lcjsgTnVubyBTw6E7IEFuZHkg
U2hldmNoZW5rbzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZwo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIGlpbzogaW11OiBpbnZfaWNt
NDI2MDA6IHJlb3JkZXIgaW5jbHVkZXMgZm9yIGJ1ZmZlciBtb2R1bGUKPgo+T24gVGh1LCBKdW4g
MjUsIDIwMjYgYXQgMDk64oCKNTY64oCKMDFBTSArMDMwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3Rl
OiA+IE9uIFRodSwgSnVuIDI1LCAyMDI2IGF0IDA5OuKAijQ5OuKAijQ3QU0gKzAzMDAsIEFuZHkg
U2hldmNoZW5rbyB3cm90ZTogPiA+IE9uIFdlZCwgSnVuIDI0LCAyMDI2IGF0IDA2OuKAijIxOuKA
ijE4UE0gKzAyMDAsIEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgdmlhIEI0IFJlbGF5IHdyb3RlOiA+
ID4gPgo+WmpRY21RUllGcGZwdEJhbm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBF
eHRlcm5hbCBTZW5kZXIKPlRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2Fu
aXphdGlvbi4KPgo+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+Cj5PbiBUaHUsIEp1biAyNSwgMjAy
NiBhdCAwOTo1NjowMUFNICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4+IE9uIFRodSwg
SnVuIDI1LCAyMDI2IGF0IDA5OjQ5OjQ3QU0gKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToK
Pj4gPiBPbiBXZWQsIEp1biAyNCwgMjAyNiBhdCAwNjoyMToxOFBNICswMjAwLCBKZWFuLUJhcHRp
c3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSB3cm90ZToKPj4gPgo+PiA+ID4gUmVvcmRlciBpbmNs
dWRlcyBmb2xsb3dpbmcgcnVsZXMgYW5kIGRlbGV0ZSB1bm5lZWRlZCBrZXJuZWwuaC4KPj4gPgo+
PiA+IEFjdHVhbGx5IGl0J3MgbmVlZGVkIGFzICdwcm94eScgaGVhZGVyLiBJZiB5b3Ugd2FudCB0
byBnZXQgcmlkIG9mIGl0LCBpdCBzaG91bGQKPj4gPiBiZSBhbm90aGVyIHBhdGNoIHRvIHJlcGxh
Y2UgdGhhdCB3aXRoIHRoZSB1c2VkIGhlYWRlcnMgZm9sbG93aW5nIElXWVUKPj4gPiBwcmluY2lw
bGUuCj4+ID4KPj4gPiBTdWdnZXN0ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AaW50ZWwuY29tPgo+Pgo+PiBBbHNvIGZvciB0aGUgY29uc2lzdGVuY3kncyBzYWtlIHRo
aXMgc2hvdWxkIGJlIGRvbmUgaW4gYWxsIGZpbGVzIGluIHRoYXQKPj4gZm9sZGVyLiBJIHNlZSB0
aGUgc2FtZSBpc3N1ZShzKSBpbiB0aGUgX2d5cm8gYW5kIF9hY2NlbCBhbmQgSSBhc3N1bWUgdGhl
IHJlc3QKPj4gKi5jIGFuZCAqLmggYWxzbyBtaWdodCBiZSB1cGRhdGVkLgo+Cj5Gb3IgdGhlIHNp
bXBsaWNpdHksIGp1c3Qgc29ydCB0aGUgZWFjaCBncm91cCBvZiBoZWFkZXJzIGluIGFsbCBmaWxl
cy4gVGhlIElXWVUKPmNhbiBiZSBhcHBsaWVkIGxhdGVyIG9uIGFzIGl0J3Mgbm90IGluIHRoZSBz
Y29wZSBvZiB5b3VyIHNlcmllcy4KPgo+LS0KPldpdGggQmVzdCBSZWdhcmRzLAo+QW5keSBTaGV2
Y2hlbmtvCj4KCkhlbGxvIEFuZHksCgpubyBwcm9ibGVtLCBJIHdpbGwgZG8gdGhhdCBpbiB0aGUg
bmV4dCB2ZXJzaW9uLgoKVGhhbmtzLApKQg==
