Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347D3AB29B;
	Fri, 29 May 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044050; cv=fail; b=CF9/hYNe8IV16YZQRQIb5iy+XI6nkZ0H/UoLsotENec5OFObm1RUwFkZruHBiwPvYcQMuT+/qw8Y3HaF86oxL+SpQ8AMMTJJxy3QC8sR9ODwrjvSsCkA0201w/XhNa027IsHQSQqoUo2TQpIBBZgNYW6/DJvQNYyWI7BpHwmyCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044050; c=relaxed/simple;
	bh=ZomlfwcPn6n31kuzF205cCuBqxVtsSOZAAR0S/q4PQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nWr9fduPw9JUwIUpGl9StTHOoan0Ll27aeMuyeP6/e+poAjhPYq+dQp+7AuUXe0cwzYo0dbuNm49YaGz5CO/l++Qe11Dn5FJLeA8qPUQj8hH5ybKrVQxcUfV/WLEGng/3UUa7RCLUfQOPrHwHl2Mvuqh6Mgtvla5P6qhwodvft0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=i54l4pVe; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="i54l4pVe"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T4kbIt651298;
	Fri, 29 May 2026 04:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Zomlf
	wcPn6n31kuzF205cCuBqxVtsSOZAAR0S/q4PQ8=; b=i54l4pVekBkucXQ8HMDVq
	ZdrvokJTqi8K4j9RAsd7nmXbv17qHc89swTQV4934EqsH9qcldn8CezMT/4kxq7p
	3W6MvL0ZggcQDBa0vebD3A9fpN1fHFuB+NVcaOzxQdjBGPoXBsebN4wwJ5VaO6kR
	zeeSN24cQtfk4Z+gp/L8WXG7FxeuA6j50ShJZLvZPbJ2x3+aODwOXEqe++fPQfyI
	Ne2oUbpHQbju/ClhK2+Hcdsx33Q07ArvyKZUowy1qH1+wOPpEmAayLWEwo6RC1jy
	o1mwOLYym49FRpYg3MY3jbYI8JQFNaEjq27oJaMj6/iL6NFqY4kqExBaFOoJ2zfp
	w==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x46jkh-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 04:40:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLq2mvXoA06nfnFyURCs0b0kh07js4o9jQwnAQx6IryZICuOgGh1Z4ZZR9ctK5Kpex5+wO/QmrOlyK4JJYJ16KANypejIp/XNBSd6Kx0sc3N9ip4540Shc69mfP0GVuTct8jFDVgxgcSCh1XAAuYuie1AJUfpWHtAsPIp2fDP9JUjNnIB8cemPL2m9A7YIk+2KDXtx+a7Lrj5scAJj+Q/L9woO2kfLsHlhz6WgsrS+wyp0TfPknw4c9YSGV1tYlhfzdPD2PEkdWBmNg4DaE1gbb6JjB5FfxI55jKPOhgwWkmfzxE9SLIsJSP5wmLjq7PkdHqhDqPDH9gxK2pJIjzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZomlfwcPn6n31kuzF205cCuBqxVtsSOZAAR0S/q4PQ8=;
 b=ss1tv4GY7p2gBl46B7ilLYfhmL6RKTBNiz+AbYoaf0NzpmXKRq2SY3cuVODPn9ETsIr+0j3Xt1jhVdSHgrOBJ6+RsaWCWLYnIpI7VP7Qoy0LpeNXV29qNpzilYdzDzKFNc9pt8jhQHCc31zm52Aw6bVmXvs050R1xnYt0Q2uQVnZfEZ1y8qiozDD43lFbzQLaU+I06AV4ic8wLTpDGW1a5JUIZxBsWmIR92m+XC/aTZJqzdYZhZWFXs/BJnn4WKSiohxNGTyksgBda1vrjS0GxFLP5GVBLneDmu1vDg0RsFBj85mx+9AE7/9haXRV4Pm9AAvwJtotUGi6FFE4TCJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH4PR03MB7603.namprd03.prod.outlook.com (2603:10b6:610:23c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 08:40:31 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 08:40:31 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
Thread-Topic: [PATCH v5 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
Thread-Index: AQHc7byd2pmkxnhCyEGz0JO06WUlabYksZIQ
Date: Fri, 29 May 2026 08:40:31 +0000
Message-ID:
 <LV9PR03MB84149A6090F959B829CBAEB6F7162@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260527-ad_sigma_delta-fix-v5-0-446fd2bc7330@analog.com>
 <20260527-ad_sigma_delta-fix-v5-2-446fd2bc7330@analog.com>
In-Reply-To: <20260527-ad_sigma_delta-fix-v5-2-446fd2bc7330@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH4PR03MB7603:EE_
x-ms-office365-filtering-correlation-id: 0c38cf68-d440-473d-a7b9-08debd5df16a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020|3023799007|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 NyftfE3BvUvOypMPi/4toMlW5vRmzNisXU1bTadvRhqLiqW5X9k7Pd34hqNCwiazrtuBpejdgQK+mCLPuMa9gmQA8k27hcs8yspy/d1UsPLqCFhpKxuI7d3dYeM5gN6F2KsXbL2/JW4bzKTRhTj7kQgPdrhd0rQVVrGsE7jc5T5cgYc1mPX8xbvFeIMbTRzW2dcJ/9NJ42Ggc0eA6ADiqDtSfoJ7NSGMMa+DqpzoEijF8Aa2zSXXfpIjfuMzftUvYdUE9YoMcynfeebD6Z2tHvl8JIjKTsMFKYsVkvUnmyDEp7+JLM3tgZL9ltKw5gdUsaa4urEHdiaNCUHj+jw/jgM+Lh7Tune/kyXfcPzAqb7yVt1CYaQiJzCf0mrLX473nGheYUB6QxoEXC5i3qERSlxI+Kn2x5VHhmfdVhGZylqaZGZkpNkXr8ByvhHPXUjjKBS2iOXXvN7jEOtMS84LlNqT79RyYdx13o9S+BFD8llxDeOzO/zXnSaOpp5u2rtIxWbdXoh3Z4rGHamey8tIReOgOODtTgrNT51Xw4458Iqhkku2xs49XPiU+F5CQ7mgV3bn8X2b0tkkC90F6bcF+OxUFkMf8s9vGxEeK02sESZ6fpcIqlLd8uBw6y0rjiuEc1YA/i6/4/WKo3rhFiRu6QZz3l0+H3A852pEa15l3RmYXpqEI7XS4fayDGPBN0sSCEQGYqCNPSPsq0CHo0Rg3ecmWgTYsXoAqv0SHK5D57zjw9XWRDpCali7I94syOkSoDx8xJqFe6DUhcWI7yTSGA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MG5MbkRGYWhNMEdYZWRScUYwK09pRFBhYlZoMGhXMTVOL3ZESDYrbGRoQ2NC?=
 =?utf-8?B?cVpjc0NIU1d1UDZ4M1hGS3dFbTU5cU1pSVVTYTNsYU44TnNXdWdrRXd2Nktz?=
 =?utf-8?B?dGlOcUQ0RFlhTWFqNjdMN3ZyMlBlVEpyNnhDa3hQdHhCcEpMN1NsL01mbEpJ?=
 =?utf-8?B?OUFYeVV4aGtNbG1ZUmYxQnNhVkVGVFpwRmx2Vk0xSUlVcmRZTk9ZVVZTdTV2?=
 =?utf-8?B?eTdsTVdlQ3J6NTRpdE5hdWpSVVRTUGZCa0p6MnFubDljK0czRmQwVzBXeE1Z?=
 =?utf-8?B?NUtMRk1ZdU5ETGMyeWdXTm5kbWprUHZyM1hrU0hZV3VRd3BJYXJzazBkNmlZ?=
 =?utf-8?B?T3RXVXl0MHJ3UWpNS3cvd29KMTFHclhkc1JNM0xRUHJTUU5pT3VJdDgrdmNQ?=
 =?utf-8?B?elN3Wm9xRUFpZTFFQXd1aXJzYzNnUnVmOE1wS3RrTkU1OVgrcTBMb3hNTWVD?=
 =?utf-8?B?a2NBaURaUlJVNTF3RkJ5dXZZelZUcmpESEZrcUh4ZGpweWU5c2Q1dklCZkJJ?=
 =?utf-8?B?elJva3NJT1JTOVNxek5Ddm5CU2tqTXIwV29XYnBjRjY0U1dwTnUyRGpHNzVI?=
 =?utf-8?B?c29Nd3B5alExQlVKZ2U3cFpLY0JyeUdpMWd4bUxkSW16RFZUang0eXpvcEE0?=
 =?utf-8?B?amtGWmQya2FFWEVvWWdsZ3Z1Y3g0M1ZGSGZkaC9KNWZXQ05ydlhDSE9SdWZW?=
 =?utf-8?B?RTMvUVBJcS82SG13SW9aQWxsYlZVT01hem9zWG1oVDdxK3prWkdOK2c4dXdQ?=
 =?utf-8?B?M3BERTVCSlQ5Zlh2VWQxcVlrbkJVQ0xicWlJVjZXTGJpNTJZSjdsMTM4WDlW?=
 =?utf-8?B?WnY1UzBhWVc1dTY0NW8zS21hN0l0NEN2aXd5eTNVRGh6Y3dYRWhCTTdLNktk?=
 =?utf-8?B?cjUyYWxKMEJVWEZpanFCL1o1YjlXeStMbS9DSnU1M1BjR1FudkJVYnA1WmpF?=
 =?utf-8?B?VDROekVaZ2FxQWlEekZySDFWYUlDUkhXNXphNlVBek9tS3JVSDRJVVhLU3BB?=
 =?utf-8?B?SnFTQ2t0MytqZWRXYk1IVm5Nb04relgveXNGL0ZnUHRBSzFtckhsc1ZFSXQ1?=
 =?utf-8?B?ejFHMFQ5UDR3VnNPcDdtdDVNcTZ6MmpRNjBLMmMxUVVVVHhBUDJ2WjJDaFBG?=
 =?utf-8?B?akhBVXJ4ZTRka1JBaGRJemxLekdmZ28yTVVDMXh4Y2JhV2RMbnRnMDExNGg2?=
 =?utf-8?B?eUM0Nk00NlZ1L21qVzE4M29uUlE2ZHRGS1VYaXlqM2E1d0hoRkc2dWFEbkZv?=
 =?utf-8?B?WHdtZzlXcm1aempBTkQwbU1oOG1uakQrUk1sWUxDY1NVRWdEcUFXbk5BNFlU?=
 =?utf-8?B?VXhyVlZBNjhNbjdyNXFGbm1MUXlWTk0vTCtxUFp4RzhuZzd5UzI4eTQ1b2FK?=
 =?utf-8?B?bTR5V1Z6WkJXeWQ0RWZzTU8vbDB4MFMwRDhXbWFCeE9SdDM3a3JrWTEwWklC?=
 =?utf-8?B?MUVFUHNoNFhYSmtFYWp3OTRyenI4UkVIem1tY1dZTC9jTmhOODFvWWEvOUVX?=
 =?utf-8?B?Nm5CRG16ak5Jamo4RDMyaWlXZ3Z1RlQrOW5ValZZSlNaZzkyM1NkNWNqb0p6?=
 =?utf-8?B?YzB1Y1VTWFRqQXlnbGNJQTBJeVE0clAwbG4xM3I3bXpaZGlIeHFTQkJKR1ZI?=
 =?utf-8?B?U0xubUdBZ3lVbFF6TVVDUHRycWxtZEQvQUdJd3E2OXZsNHNEdzVyWm4ySHZl?=
 =?utf-8?B?U1NFbmU1WG1XUE1mMG0zclMvL0NMb3VRc0tkUjVGQXlsMWdVN1B3SndhaWhR?=
 =?utf-8?B?TGFaZ1kvbFh2ai9xRDBWdnJ3R3NRT08zcGtDSkt1dDMwTmZ4c01JZVRsWWRw?=
 =?utf-8?B?M2V4U2Z1Q1pzK1A3bzFTZ2plcXpZT0l6ZGpOZVJzb2xtVzN5Q0JHbEt5Rk1x?=
 =?utf-8?B?SDQwdGhrUThrSnpPdlJjK05hcTEzK2RqNzRyaGhRTUpJdmRRTDd5Q1pCMmV4?=
 =?utf-8?B?WlZ0Q2tEQ0hZaUJENG5SYUxQcjhiUmticEkwdXV2MU9LbEVvN3QrdDRCSDI0?=
 =?utf-8?B?SUs2V2xPZWdrTjZVUXl2NWVzdEo3ZEt5QlpwZnBzVVQyaXdKcEl1L0pZaTBh?=
 =?utf-8?B?NHZmWlJZWmhFU0laZUtGWnpmSjlWZnhpUXVJTEl0Q3NNZ1U5K1pTUHM4bWU5?=
 =?utf-8?B?QVl2QUQ1M3dVSlVRNGZjcHhwT0NmdGp0dm5xSnp5dGdyMk04bm51R3BqMXpQ?=
 =?utf-8?B?TWlwWlhQYmp5NE9CTmd2akNRd1BacGR6S2hKVGN4MFQybDJDY1lEcTJsOVFy?=
 =?utf-8?B?aEpKK1RGMllmaDk3SDBZUWVlbk91YnUzNTA1TXIxRFR2SGhQZ2EyUmlBdjIr?=
 =?utf-8?Q?qiFZicS1eQE0YtrqnN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gg/3jCcEvvBg763itiyKZSLV65HratBcoPb/o0GTLphxBLZMh2CSMSErZKG2nbh8pQNyoeAzwusfIkxptv8w9MQd93TcCj0Y8h7AxJDh0SH9bW/UzXWH6U2cHp1svnw+3UxhfQhJosJp2TY+vubDiTBkNOF3dEY6c91zdJIs9LyUz81zugzPSAFZQ0hciAEaiQFn8nk2EFaJic9t4+BHLECsYIJ4Kr9dIAQinFvMuLM7DufuAZ1eUK87VdH10s7BeW9XVHbfog8QZB0EIt3xhRZWi7HQ4FzO9GveZBDv0ZbA7UHBmkr79myKeJ5rqRg3RVds4KS/AURY4GtdFl2Vaw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c38cf68-d440-473d-a7b9-08debd5df16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 08:40:31.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GYfb63JKPVAD9nd2f0eAEkRj+mCbOsk+XdWknpJhBECcNmNV+XPZlFiFi0uRvthnKevukwl971DC81mppW/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7603
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a195103 cx=c_pps
 a=KTU/bV3Cu5xqMUx6SKv27w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=av_-ow1lR_VGE7P5mJIA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA4NCBTYWx0ZWRfX9n4KpH76BhMu
 j3ujVh1qlLw8h/Am66pMfdVFKYIDBxYjr2lrct1GzVc8ui77XG5LEY5yPouA9tLqX2lIe+iDJZF
 38t0jBLSkXsnCZ7VJE05nIit004TvHdJZa4fsGY2GYfAexuWygLcX1/GVEMiETRxnEvFtXzvsDZ
 MWDyscVNdoXooXB5rMVweiM+fFUEUZevidIc0gqPf5HWI+4+N7qXS0aROpPtA1ts/V6N03r9NAo
 d5VW7QJmVIZmFg15Hi01Hy+kVNImAL8kd+g7yaJW4MS1AkMffg/5HpdHTx+CjZJ+dqyRWlSyBxQ
 SbUmyHbd/zw0CKzFdKiDdGF/TyH6fbf8eSFqTO0alS6I2judBPh5KOqA9IvxWDn1v0GNGlgSnlg
 MRoD3WgWZFbIrJBHq/SuAXF1mEjp6N6LW07ep77VeHdRzbxF7rfA6Jhg0nO1KMAO2TYN9+d62HF
 lX2c3TWkeegepUBY2lQ==
X-Proofpoint-ORIG-GUID: q4bpxjFJKsOQHA66kkenTfcg5QY0sExK
X-Proofpoint-GUID: q4bpxjFJKsOQHA66kkenTfcg5QY0sExK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290084

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
V2VkbmVzZGF5LCBNYXkgMjcsIDIwMjYgMTI6MzkgUE0NCj4gVG86IExhcnMtUGV0ZXIgQ2xhdXNl
biA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5l
cmljaEBhbmFsb2cuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47DQo+
IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IFNhLCBOdW5vIDxOdW5vLlNh
QGFuYWxvZy5jb20+Ow0KPiBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IFV3ZSBL
bGVpbmUgS8O2bmlnIDx1LmtsZWluZS0NCj4ga29lbmlnQGJheWxpYnJlLmNvbT4NCj4gQ2M6IGxp
bnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNh
YmF1LCBSYWR1DQo+IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogW1BBVENIIHY1IDIvMl0gaWlvOiBh
ZGM6IGFkX3NpZ21hX2RlbHRhOiBmaXggY2xlYXJfcGVuZGluZ19ldmVudCBmb3INCj4gcmVnaXN0
ZXJsZXNzIGRldmljZXMNCj4gDQo+IEZyb206IFJhZHUgU2FiYXUgPHJhZHUuc2FiYXVAYW5hbG9n
LmNvbT4NCj4gDQo+IGFkX3NpZ21hX2RlbHRhX2NsZWFyX3BlbmRpbmdfZXZlbnQoKSBmYWxscyB0
aHJvdWdoIHRvIHRoZSBzdGF0dXMgcmVnaXN0ZXINCj4gcmVhZCBwYXRoIGZvciBkZXZpY2VzIHdp
dGggaGFzX3JlZ2lzdGVycyA9IGZhbHNlIGFuZCBubyByZHlfZ3Bpb2QuIEZvcg0KPiBzdWNoIGRl
dmljZXMsIGFkX3NkX3JlYWRfcmVnKCkgc2tpcHMgdGhlIGFkZHJlc3MgYnl0ZSBlbnRpcmVseSBh
bmQgY2xvY2tzDQo+IHJhdyBNSVNPIGJ5dGVzIHdpdGggbm8gYWRkcmVzcyBwaGFzZSDigJQgbWFr
aW5nIGl0IGJ5dGUtZm9yLWJ5dGUgaWRlbnRpY2FsDQo+IHRvIHJlYWRpbmcgY29udmVyc2lvbiBk
YXRhLiBJZiBhIHBlbmRpbmcgY29udmVyc2lvbiByZXN1bHQgaXMgcHJlc2VudCwNCj4gdGhpcyBw
YXJ0aWFsbHkgY29uc3VtZXMgaXQgYW5kIGNvcnJ1cHRzIHRoZSBkYXRhIHN0cmVhbSBmb3IgdGhl
IHN1YnNlcXVlbnQNCj4gYWRfc2RfcmVhZF9yZWcoKSBjYWxsIGluIGFkX3NpZ21hX2RlbHRhX3Np
bmdsZV9jb252ZXJzaW9uKCkuDQo+IA0KPiBGdXJ0aGVybW9yZSwgd2l0aCBudW1fcmVzZXRjbGtz
ID0gMCBvbiB0aGVzZSBkZXZpY2VzLCBkYXRhX3JlYWRfbGVuDQo+IGV2YWx1YXRlcyB0byAwLiBJ
ZiB0aGUgY2xvY2tlZCBieXRlIGhhcyBiaXQgNyBjbGVhciwgcGVuZGluZ19ldmVudCBpcyBzZXQN
Cj4gYW5kIHRoZSBjb2RlIGF0dGVtcHRzIG1lbXNldChkYXRhICsgMiwgMHhmZiwgMCAtIDEpLCBv
dmVyZmxvd2luZyB0bw0KPiBTSVpFX01BWCBhbmQgY29ycnVwdGluZyB0aGUgaGVhcC4NCj4gDQo+
IEZpeCBieSByZXR1cm5pbmcgMCBpbW1lZGlhdGVseSB3aGVuIG5laXRoZXIgcmR5X2dwaW9kIG5v
ciBoYXNfcmVnaXN0ZXJzDQo+IGlzIHNldC4gVGhpcyBpcyBzYWZlIGZvciBhbGwgY3VycmVudCBy
ZWdpc3Rlcmxlc3MgZGV2aWNlczogYWQ3MTkxIGFuZA0KPiBhZDc3ODAgKHdpdGggcG93ZXJkb3du
IEdQSU8pIGFyZSByZXNldCBiZXR3ZWVuIGNvbnZlcnNpb25zIGJ5IENTDQo+IGRlYXNzZXJ0aW9u
LCBzbyB0aGVyZSBpcyBubyBzdGFsZSByZXN1bHQgdG8gZHJhaW47IGFkNzc4MCAod2l0aG91dA0K
PiBwb3dlcmRvd24gR1BJTykgYW5kIG1heDExMjA1IGFyZSBjb250aW51b3VzbHktY29udmVydGlu
ZyBhbmQgY3ljbGUNCj4gfkRSRFkNCj4gYXQgdGhlIG91dHB1dCBkYXRhIHJhdGUgcmVnYXJkbGVz
cyBvZiB3aGV0aGVyIHRoZSBwcmV2aW91cyByZXN1bHQgd2FzDQo+IHJlYWQsIHNvIHRoZSBuZXh0
IGZhbGxpbmcgZWRnZSBmaXJlcyBuYXR1cmFsbHkuDQo+IA0KPiBBIGZ1dHVyZSByZWdpc3Rlcmxl
c3MgZGV2aWNlIHRoYXQgaG9sZHMgfkRSRFkgYXNzZXJ0ZWQgdW50aWwgZGF0YSBpcyByZWFkDQo+
IHdvdWxkIGJlIGJyb2tlbiBieSB0aGlzIGVhcmx5IHJldHVybiBhbmQgd291bGQgcmVxdWlyZSBl
aXRoZXINCj4gbnVtX3Jlc2V0Y2xrcyBzZXQgb3IgYSByZHktZ3Bpby4NCj4gDQo+IFRoZSBzYW1l
IGhlYXAgY29ycnVwdGlvbiBpcyByZWFjaGFibGUgb24gYW55IGRldmljZSB3aXRoIHJkeV9ncGlv
ZCBzZXQNCj4gYnV0IG51bV9yZXNldGNsa3MgPSAwOiBpZiB0aGUgR1BJTyBpbmRpY2F0ZXMgYSBw
ZW5kaW5nIGV2ZW50LCB0aGUgZHJhaW4NCj4gcGF0aCBleGVjdXRlcyBtZW1zZXQoZGF0YSArIDIs
IDB4ZmYsIDAgLSAxKSByZWdhcmRsZXNzIG9mIGhhc19yZWdpc3RlcnMuDQo+IEFkZCBhbiBleHBs
aWNpdCBkYXRhX3JlYWRfbGVuID09IDAgZ3VhcmQgYWZ0ZXIgdGhlIHBlbmRpbmcgZXZlbnQgY2hl
Y2s7DQo+IHRoZSBzdGFsZSByZXN1bHQgaXMgdGhlbiBjb25zdW1lZCBieSB0aGUgZmlyc3QgYWRf
c2RfcmVhZF9yZWcoKSBjYWxsIGluDQo+IGFkX3NpZ21hX2RlbHRhX3NpbmdsZV9jb252ZXJzaW9u
KCkuDQoNCkZpeGVzIHRhZyBuZWVkZWQNCg0KRml4ZXM6IDEzMmQ0NGRjNjk2NiAoImlpbzogYWRj
OiBhZF9zaWdtYV9kZWx0YTogQ2hlY2sgZm9yIHByZXZpb3VzIHJlYWR5IHNpZ25hbHMiKQ0KDQpU
aGUgc2FtZSBjb21taXQgaW50cm9kdWNlZCBhZF9zaWdtYV9kZWx0YV9jbGVhcl9wZW5kaW5nX2V2
ZW50KCkgaXRzZWxmIHdpdGggYW4NCnVuY29uZGl0aW9uYWwgZWxzZSB0aGF0IGNhbGxzIGFkX3Nk
X3JlYWRfcmVnKCkgZm9yIGFueSBkZXZpY2Ugd2l0aG91dCByZHlfZ3Bpb2QsDQpyZWdhcmRsZXNz
IG9mIGhhc19yZWdpc3RlcnMuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhZHUgU2FiYXUgPHJh
ZHUuc2FiYXVAYW5hbG9nLmNvbT4NCj4gLS0tIA0KDQo=
