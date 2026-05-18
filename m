Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004B221723;
	Mon, 18 May 2026 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098329; cv=fail; b=oXEA8uq+9F6XnvWFhkQleJ2Ij4ixJM/C7Vf09SJayId3fCHGPnUGZoy6Xv2Sc71yKy5rPzcM+1jc7WUy35zLLKKxE7kHWS2gKFXPoneesKk1ZEQaAuTm+rBbeaaIHb3QZdU1zYNbfvpbHo1Y/KIJq312j/k+Nz/2pzZVL6jz4Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098329; c=relaxed/simple;
	bh=fP5vCliHKmZPyPgAsYJEOLrTYVtIqkKWfNX0d19Lj94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=epaQzrmLEu17ruaMyaRgx1n3p1binXnUySUwrLnfQHygSMWO6cMDKZJarNc6gmp480tPf+47sDmJOz4FlbgcWlzsIcPv7APDuQXOfRqtbN34JRJMj2CyUlBiOANkcMtlTDqDWBZr0xyiZOxbdws7V4Sy4dD+sJBF+euH6Pc2LDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oQ8We9qn; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oQ8We9qn"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I82NEo3811232;
	Mon, 18 May 2026 05:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fP5vC
	liHKmZPyPgAsYJEOLrTYVtIqkKWfNX0d19Lj94=; b=oQ8We9qnydlPi1XfqtWrs
	/qFNWmdJ4zo7o3owmteAOfiJBmzi1j0PWwL38YBqDkFmHJE97i7kOeoa2OuxGzhJ
	jQQVmEzBFY77KF7uFZ2zOybeZxNhELOk+kBKqknxXnCPdmKTP6GADqmr5HES2cKO
	KPTxmHFLEAW5o8AJ8Lxy01jJL4zYOboJwITYENEJvNQ/nKiRqVE2Z/d7uNJYPI37
	wJQkpiRkmSf+j5+MCTByAxaOR8MqLljGyegcZhzIjRnZAMHX+HoTHwBzouHyn8Vh
	1JMXhK0nP4g27lDcEMa9l8BGnkOPaS1MukzHfaj44JSgy1MY5W24TUxeYZObEnLi
	g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e6n744stn-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:58:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM3quhaGk2LRPrcSGOVEWnXS3Ns5vsdH6K9ElDORpz0KzICFnuRlNqKIjmTDXSBsoFTmvHD8Y2trAQIEdFIWLwiB4Usddsw7AYyh30SLgfQe9NDM1ErhF8G02tpStMdwJ6n4MgkdZY9wUovFwJzPGb6J389zDR/vck/1a3NSOrX44KHSNiXHm8HeUNeJq4e1/tuS8AwlKnWVK3wmnCvGvZ5z3F1yg+0CX/hXiaCFYWlSst7aNnYbjViGZRK4J5kuPMCLubUi7kWabU9I2Usl7BRESaMBPkwHsLPCtNsjzhEMIIvG6Q/BwhX4c7xVFv0bp/p0WZhCGMaO4aWASb7hYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP5vCliHKmZPyPgAsYJEOLrTYVtIqkKWfNX0d19Lj94=;
 b=QU+uA4hAubyEojWGHqcOXC0aSIU4kbgixiSHWMP8sSKFuVtDxWwrPEZnGLjQzIYobvnVPlkmGQU2RD5oqhput9JzzmhqTL2Kdeb8ZPl50HJwR5ul2caKlJKrM+18S3o+rJv7EUveaMzBfpb6LhQKnMJEgj9DiGxDDWHycjCU98VYtyL0NZQZeSAMfJN2IJAzZ/yIkyVoAXDee9efgau33Y4DpwOBpfKrz7ZpjLgQpIzMEmWl7OA5eoSGn3vmRkh9sZc/YfXYQVICmGLtqtj2pS7Ta8Ed/LO4j7VhXtY5znwH/LpdwxgcGCkP/8qdWYaqQhKyouyINWe9wSzkOeIxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8425.namprd03.prod.outlook.com (2603:10b6:806:47b::8)
 by CH0PR03MB6067.namprd03.prod.outlook.com (2603:10b6:610:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 09:58:17 +0000
Received: from SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f]) by SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 09:58:17 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Topic: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Index: AQHc3inmJrOqLx0RyUyaZwFfTl+ZmrYKRGEAgAL6q1CAAGhWAIABLIPAgATJd6A=
Date: Mon, 18 May 2026 09:58:16 +0000
Message-ID:
 <SA5PR03MB8425D5431D62F6207A62D8A3F7032@SA5PR03MB8425.namprd03.prod.outlook.com>
References: <20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com>
 <20260512121326.189817b8@jic23-huawei>
 <LV9PR03MB84148EC966F80CB723325B46F7072@LV9PR03MB8414.namprd03.prod.outlook.com>
 <e17532c6-3568-4c9a-9d6f-64af7e4736ba@baylibre.com>
 <LV9PR03MB8414852B21F8B66AF821055CF7042@LV9PR03MB8414.namprd03.prod.outlook.com>
 <4b9fbf8d-6dec-4e18-a3c5-a4b87d34af08@baylibre.com>
 <LV9PR03MB8414852B21F8B66AF821055CF7042@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To:
 <LV9PR03MB8414852B21F8B66AF821055CF7042@LV9PR03MB8414.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8425:EE_|CH0PR03MB6067:EE_
x-ms-office365-filtering-correlation-id: 53fc4a9c-85f4-4d11-afeb-08deb4c3fbe2
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|11063799003|56012099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info:
 5hhlx/9qXM/f+2HzShQnNDytIny2d/0uYhvGVgg0IkFRGIfcyHU74eFZxxFUoN1T9UogmcpLvCjJ1I6qFNQmEYpm4d9/56lppR1feZCtg+xT0WelMgcxfQSqMdwVAy7UFaW+UtiaAtxty+rn65GwRV+JVhDGGWVyIxWeA+eK/iXD0qnpc6fRrw0Q1iDG7HVizBv+aNLkump75tIZD4CKJADPkoxMYH6wd15W2HFrilWZVnbl9lA81Jd+K4CbSaXpeC9AklbWRk7FaNN+q4q0UAavp0JC0yNTdBNbGJHhD6uuah9ruP9496/AEaGeTDwxkz3D016WTZSxGRanf3Lt4qRGyjY9+8vWSEhoI7m6HTlxsnsibDfgr1k8aInUZjJ/ysu+rdr6L7i/fSNxP9rJ+Tvqf31c/KSGLEzpKQlHbamjxSiEbysiexMJdwUJP6IY5sNMp2wNWjV0/Wz2eS7GeZyLRaLOjEBtdcHpywaTY9geMzg+95jft+n0N/uYvJD9IWulWZ9ole+yw2483PQuUU1X6DaoutwUZnDdfbeEciV4orisgAQkeTneUEMP2ShFz6nV/xsl1qXPNHgi+Nh3EYB3U2kZ8hcqaW982hH4ye2jGIOVRaPlNHdt4jcaUU3q3+amw8YWsV6WLpqSIc/DMvx9BPdm5/QfH7/KRoV3paW9xrKLJSKBSkeJh1NbujuG8otMzsLbxUiAkiSAcz98iLeQU0bntAorkFiqX5KqZCVVencvsxKt8F4TyJusd0oX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8425.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799003)(56012099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGtmSUJndjMyYVZiM1oyYjRsL3VLTFlHanZyNXFra3FOaU1QdlVucjB4ZVFi?=
 =?utf-8?B?N2hPSUhkb2hMdVYwdk15ZXkxeTVQbTIrZFlVYlRFai9QR1JnMm40b1UrTXpn?=
 =?utf-8?B?YWF4Z0pQM2dWdHVkWVdBRzZzOWMydFRiUHBMY25DR2psQmZ4UFNPMmdJWjNw?=
 =?utf-8?B?dkpYb0ZpL3JHZDN6cVU0T1ZUS0hhMFJmNW9RSnhXazZRNitEcFZyUDZpYk42?=
 =?utf-8?B?bTRkK0hTRGlZMDA1Mi9CckdaU1dzUE9oOEtGMzg4NXdhTHFFSHN3cmNQZnlk?=
 =?utf-8?B?a3JCZXBkZXhnLytmaWx6Wk11M2lhRVRKa0UxSnhXYUFWMXpLcmVod1ZybGFY?=
 =?utf-8?B?R3lGYUUySWhqaE8zT3dvYUw0TnJzS3pKS2xwV1FLRmlmcmlqZVQyN0tmYjlW?=
 =?utf-8?B?RHBHdmZBVEhTUFg3RnpJcWJRYkRGa01mbm5OMGgxYmw1aGxMQjB5b2xkNHRR?=
 =?utf-8?B?a3NSb28yMllxTHBseGxqNFduN2Z1SkQ3TmhTYjI4Nmc2TnBvcDRobkl3ektU?=
 =?utf-8?B?ajVDVWxSMmhIc1hzYzF3ZjRaYzc5dzFidnJvZlB0YVhpTDNlMkhoUGpaS0FC?=
 =?utf-8?B?MW1JNVFJTnlJUGd1SGtzeUFFZ0JyUm1tQlhpY21yeWRDbXhqL00vWnE2Nmht?=
 =?utf-8?B?QWEveEw0NVRxN0U0UVBHZy9kQ25LeEIvZDY2emxUT2pCbC9KOGw3VHUwR2Z6?=
 =?utf-8?B?TmdBVDVKcUFqWEhoMjM5OC8zY2ZiNUI2SFRpUTk3SGJhYWJLUmkzaGdQbUYv?=
 =?utf-8?B?MmNSV1Zydk0yRlFlS20xL05oQ0JMRG9hbVRCdjRienZ1WmVuamRhMDdNeXRI?=
 =?utf-8?B?WmhxaXo3ZEFuNzA3UzNPZmVIa3NwdVpYWjMrWGpXNEFyeXltS1FLT2xJY0JN?=
 =?utf-8?B?STc4S1Z4d3FaTnd0Yy96MkZITmtucnUrQUl4N1VFZDhscm53V1JuZGpQYm1m?=
 =?utf-8?B?WTlsbmxUdmdxZUZha1hkOGg0K0NNSU9ndHB0K0xGSEtXM2VDWjhmNTlOc2hU?=
 =?utf-8?B?c3luL3RlMjc5ZW5uU0xXdkk4bTdSMTBZNjJ5MHdqVDNJaFJvYURnR3NvQkta?=
 =?utf-8?B?UEJHU2pSVjdMRVBLdzlYRlI4WWFMRy9UdzVnY0p5T1FuT1BJVkdiZHJyVytm?=
 =?utf-8?B?eWtKVXN0L2JHeUZMa3BqcG85SWE5WnBDdk1iVTArVm5qUFExR2Q2RUlYZ1BS?=
 =?utf-8?B?RVd0QmFVVGY1K09WRG9IalY4S2I4QzQ2bFUrb1hMUG1WUzhwNFZpRzY4Ujhu?=
 =?utf-8?B?MlJXdWRHS3VaUmJ4cGsrTHJEc2dRVVV1TGhxam1DYmU1RUVWSStacGpQdjdZ?=
 =?utf-8?B?eGxTN0pWMFVDU1RJRndTMVhVYTlRTFhxdERIcFU1WjZBSlR5N1g5b1ZvbTZV?=
 =?utf-8?B?UDlOZXFhUjVHLytEMjRGMWZXazhVMnZGd3VWV21NNUFLWEdoQytHNUxoOFYw?=
 =?utf-8?B?QmpRbkUxeDNob013R0g4ZElHL1ZjQlB1TWR4VUpUbzRhSHNTeDJTbFAzL0xL?=
 =?utf-8?B?NzVvT1ViTUQreWtMN3RGRnphbklqb2l0Zi9yY0xKaXlmYnJLUjRVSjdZSnBz?=
 =?utf-8?B?NVZnallOSTdYRk1TdmY1b05abUZzd3Nhak5kK3RvZXBuNGo4bno1b1F5RmNz?=
 =?utf-8?B?VFZYOUl5SHNEbnVvZWVmQ3FUeUVUeHk2TjM5L2FIU2RCNzA2Rk1XQk50M1pt?=
 =?utf-8?B?c1ExNTd1RmVuTmtZMjZBK0lveHE1NXBEa2JpdTNUb0ZlcEx6MmdSNkl1STJi?=
 =?utf-8?B?dFFKMnBZa2tRVzM1MkJSWWNCSVZ0cDBHRGpnSnN1RGJCeldlU1FPOTA5WVpH?=
 =?utf-8?B?RTlWd3hSYXhmWGQ1UGoxb1QwaVRCVFd2aEwvUCtTbjNRVDJyMVJqUDdoSm9S?=
 =?utf-8?B?VWpiNGhxaFFXRmlPeGMzUGVzd3d4SXI2bTBmcnZSc1BZajdhQjYxL1U4Y3pj?=
 =?utf-8?B?elVEeU1iTXA5cktqSVh6ODFESUN3MUwydU91WXVscDVCRnNXRmYyalJQVDB0?=
 =?utf-8?B?R2tWSFkvR0trOU9MVVNNOVJNckw5MU10MERXRit1U0dhbEsrbzV0Z2NYeldq?=
 =?utf-8?B?UVk4ZGhZZTIrcklDd1kvcXBpSnE1U2g0Z2w0OEhZckg0YWxmRGQ4T3hIN3JN?=
 =?utf-8?B?c2RDQzBTQ0I2MkRDMEE4SGFKa1JCK2Q2U21XWHJZRXdxR2FyVHZQS0lacWdH?=
 =?utf-8?B?VDU1MjdsZHBjci9NZTg2Wm9wbnh5YUE1VXl5OTlOQjV4Vm5jclBSNlNBQVlz?=
 =?utf-8?B?STM3czU2VmZWbk5jYlhpdTc4aE42S0RVd2IxK0NLdGR3WHFvQnZSOVVDV0Vp?=
 =?utf-8?B?c3pQYVd4aTFUWDNONDkxL2VwaDFQYkMwRXBLSzNHcFBucUlaVHlmdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qwfegAZf42kTl42aIum5vCAF+qIE3vTW/IsmUUUw4+WTFu5zJrdUxrBYfw3/TY8z6u4mHjWnZIDmwrpGon1OlDf6Lnl9hy6TND4T+ATO3c3H1VE9HVMrKv2dobq+7otMR6x1FJ31cVmC6Q2NFRkbz6n0RCyNBpwIMS0JhNhh5jXIvUxaZVKnXWpU6D9hxi4ol5Y0hCSr2uz0QqqX4kpr4Gmu5NiP8gS2zvEqqR+ZJsj0NuWxdZZg7H+FA16YGLqLXE1yM+gctoZLBG3SkUTl0J3mUFkSpfIsl4TX13uq/mkhfexUCKMvUp20INyZt7og+ROQo8QJKbOWSQVsi8V5uw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8425.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fc4a9c-85f4-4d11-afeb-08deb4c3fbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 09:58:17.0412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAvLSsgEATutWId/ngx0d0o7UmVIGCJk78LIDWp1bQQXBpTQ804LECMRoTbIQuguN0J8I8NCaItl4lHOjwDCIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6067
X-Proofpoint-ORIG-GUID: ZvnHGclIsDCWaMF0RwGfzuIeaVq0y3DT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA5NSBTYWx0ZWRfX9RTK8ThgE7SL
 +qV1gNMNUJPswaT8mQ/fR+npDGjnZGBiTq8r77lTXT6nagHC900leAVdgQCPsOmrKKet9soAL0H
 s+K/B3X/eay4xAgkubMOuXqhczYoXO73tqxuFS/oqPyA5dqfsWsfzWkWQGKDZRaBvK41fUlt5ok
 q58x0yNMRZVPKXBhyDYumdeZSj2yGnsodd8wD6wF/+QzJ2zsdKPjMEYClZWSW0vEJxjlF6Hb3Lh
 AxwVjeUtWRavVIqZZ/zmiuOk4R+4UeZW3U1zgCTS+W5GbSYL7AwiO71EWpFCyTZ9KS+xvryTHw9
 ZFJe4uYhiGgcgWDOQ1vAaDfdSpOolB3dsAPju1BAz9t41EGF6Nt+F0OyE8+azNnVCIPg9X/2mE+
 5OZBqeofhtVzGl255k4j3UZ2SRUi4ImxJTIzguV1Vw9lH9d5dpZWZpA83HxNWRuH5HHT9xzbMUK
 dVe8/SNgfnWeBVmivog==
X-Authority-Analysis: v=2.4 cv=eoHvCIpX c=1 sm=1 tr=0 ts=6a0ae2bd cx=c_pps
 a=dVriaH61pmWkicxGRshTTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=NQGmCUM3ZyTZEluFfU0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZvnHGclIsDCWaMF0RwGfzuIeaVq0y3DT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180095

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWJhdSwgUmFkdSBib2dkYW4N
Cj4gU2VudDogTW9uZGF5LCBNYXkgMTgsIDIwMjYgMTI6MzggUE1cDQoNCi4uLg0KDQo+ID4gPiBJ
IHdvdWxkIHRoZW4gc2F5IHRoYXQgdGhlIHNvbHV0aW9ucyBhcmUgMSBvZiA6DQo+ID4gPiAtIGFk
ZCByZHktZ3Bpb3MgYXMgd2VsbCB3aGVyZSBoYXNfcmVnaXN0ZXJzIGFyZSBmYWxzZS4NCj4gPiA+
IC0gYWRkIGFub3RoZXIgZWxzZSB3aXRoIHJldHVybiAwLCBzaW5jZSBpZiB0aGUgRFJEWSBpcyBu
b3QgbG93LCBpdCB3aWxsIGJlIGFmdGVyDQo+ID4gZW5hYmxlX2lycSwNCj4gPiA+IGFuZCBpZiBp
dCBpcyBsb3csIGl0IHdpbGwgYmUgdHJpZ2dlcmVkIGFmdGVyd2FyZHMgYW5kIGNsb2NrIGRhdGEg
Y29ycmVjdGx5LiBGb3INCj4gPiB0aGVzZSBkZXZpY2VzDQo+ID4gPiBhcyBmYXIgYXMgSSBjYW4g
dGVsbCwgdGhlcmUgc2hvdWxkIGJlIG5vIHNwdXJpb3VzIHNpZ25hbHMsIG9ubHkgdGhlIERSRFkN
Cj4gPiBpbnRlcnJ1cHQgdW5sZXNzDQo+ID4gPiBjbG9ja2luZyBkYXRhLiBJIG1heSBiZSB3cm9u
ZyB0aG91Z2gsIGFuZCBwZXJoYXBzIHRoZSByZHktZ3Bpb3MgaXMgdGhlDQo+IHNhZmVyDQo+ID4g
bW92ZSwNCj4gPiA+IHRob3VnaCB0aGlzIHdvdWxkIG1lYW4gbGVzcyBjaHVybi4NCj4gPg0KPiA+
IEkgd291bGQgZXhwZWN0IHRoZSBuZWVkIGZvciByZHktZ3Bpb3MgdG8gYmUgdGhlIHNhbWUgd2hl
dGhlciBub3Qgbm90DQo+ID4gdGhlIGNoaXAgaGFzIHJlZ2lzdGVycyAob25seSBkZXBlbmRzIG9u
IHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlcikuDQo+IA0KPiBJIHdvdWxkIHRvbywgd291bGQgdGhl
biBhZGQgcmR5LWdwaW9zIHdoZXJlIG5lZWRlZCBpbnN0ZWFkLg0KPiANCg0KU29ycnkgZm9yIHRo
ZSBjb25mdXNpb24sIEkgbWlzcmVhZCB5b3VyIHJlcGx5LiBZb3UncmUgcmlnaHQgLSB0aGUgbmVl
ZCBmb3IgcmR5LWdwaW9zDQpkZXBlbmRzIG9uIHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlciwgbm90
IG9uIHdoZXRoZXIgdGhlIGRldmljZSBoYXMgcmVnaXN0ZXJzLg0KU2luY2UgcmVnaXN0ZXItYmFz
ZWQgZGV2aWNlcyB3b3JrIGNvcnJlY3RseSB3aXRob3V0IHJkeS1ncGlvcywgdGhlIHNhbWUgYXBw
bGllcw0KdG8gbm9uLXJlZ2lzdGVyIGRldmljZXMuIEFkZGluZyByZHktZ3Bpb3Mgc2VsZWN0aXZl
bHkgZm9yIGhhc19yZWdpc3RlcnMgPSBmYWxzZQ0KZGV2aWNlcyB3b3VsZCBiZSBpbmNvbnNpc3Rl
bnQuDQoNClRoZSBjb3JyZWN0IGZpeCBpcyB0aGUgZWxzZSB7IHJldHVybiAwOyB9IHBhdGggaW4g
YWRfc2lnbWFfZGVsdGFfY2xlYXJfcGVuZGluZ19ldmVudCgpLA0Kd2hpY2ggcHJldmVudHMgdGhl
IHNwdXJpb3VzIFNQSSByZWFkIGZvciBkZXZpY2VzIHdpdGggbmVpdGhlciByZWdpc3RlcnMgbm9y
IHJkeS1ncGlvZC4NCkknbGwga2VlcCB0aGUgZHJpdmVyIGZpeCBhbmQgZHJvcCB0aGUgaWRlYSBv
ZiB0b3VjaGluZyB0aGUgYmluZGluZ3MuDQoNCj4gPg0KPiA+ID4NCj4gPiA+IFdoYXQgZG8geW91
IGd1eXMgdGhpbms/DQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gUmFkdQ0KPiA+ID4NCg0K
