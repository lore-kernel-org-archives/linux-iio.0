Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1914388E65;
	Thu, 14 May 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753275; cv=fail; b=FvL2MEVAxw/Jn0VqQLyI28R5j24bR+/ccX05VWBsCRN2K5ISb8EUvunfekM2alguS7hiJU1/NOiNJpTT7JYOTmh62nWX3pW9Ax77cyK4eplaJmmOfGw0ZNAhVFrII6TxADApRB6bnOESyvm1gV4gCIIiaE52VLlBA7w9an+DRj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753275; c=relaxed/simple;
	bh=Kz4CaAHItsDTSjcuHfr3m7J4UpAK0HLd3wKoNoaJoHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=My2EdVZgxrGs1cpqKX41SpeOQxQLjEbfQWNgAgHjRPphIDuPLRXilOB4BbFU/cOfSP+yUrtp2nnpy1UgZMfwZVhiCFKODPatalGiIBewvWig+Sh/HFnX12foJVkrcsAKHSp3VvvOYQFDZvCADDjGo2n7HKKUMZ3J5Ja9FUrv+MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OtIek/bW; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OtIek/bW"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E6ebdR1715006;
	Thu, 14 May 2026 06:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Kz4Ca
	AHItsDTSjcuHfr3m7J4UpAK0HLd3wKoNoaJoHA=; b=OtIek/bWp9OYLHzveBQOG
	fPFVSv3fca0eqjeDQIloc65h1HpqP5kHX1L7dkAVBliD3876H3AE+8k2+11C7WRN
	cfasU6U1f3fsPzExe50ksmtwwbBK/JaMwzF9ixmVm1lV+g1yqQt1dK4Fp3NzIw1E
	Uju/1xvWb/TvDRw8s+ggNI6pr+Z78X00tw6ldnCgp440vGprsVgOA7VjpV+PWCsD
	ymAoTWcW1jVl/BP6vVW7vOH8+deJdjPSmS+mocF3a0V4IulCmdz8XpY/tvfhSu3z
	eZ3ZSQr+72+q6rPxTZDAKOGXAeAbkNJS7mxLEa/ljAqw6WTE90Vu0P002EDYbkyI
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e54xgshvm-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 06:07:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq6akyW+dZ9PfAivOO5szW43X7YvSnr8Nl9VSylJoLFybEsYwi07ZnkqbKGm1B99d4Y7BIw9WysqTgpjUPM1YMCyKhc9Dz2FMO796F00j3dWNRqRMLay9KbNyfth79vpQtMUcIQ1aOnMQVeWPQ5+ryd4lceMer64Buxhj3vv/lskulwL8pmDOktsawPu7L3VB6E/CodT8jP0HMElaqq4ovZef7VJr+r3VyYKvbHz2DHN/jMkkeB/kGmpW6wVgpvVek2qadthZSavgF9NePX0jyCBn/er7+HwuirUXDlTUsR/G7kXEax2CCKpjW/PggUVrWuGsKC0SWJapHK0ievm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz4CaAHItsDTSjcuHfr3m7J4UpAK0HLd3wKoNoaJoHA=;
 b=MQkxkUd49iWO0lJLPuHElUGvQ0bExtRuHdNHbCsKvtX6tOWGcvhQ64Uua63tyUP+xLDiK3GE1aC1QQb92bB+WQH7j2kjuXdsa+b9IYZOkYVgEN9ixJs7+Pa9r/JxoUrQgqhmJ/xZsC1NzP6pgI39C1wyD+TCVSrJR/R9NRZ8YPmUPjyKJdnaWLj+0b2bDGOqQAintJ6kIixSbfd3X9OyytTVH9CdIsJ/GxLIVfsI3m7sKUZ398qE3c8VIJp6MlbQp2AsOFn2OMs2bO75sBfQXxP3S4Dpf9hcoobXVX8Xw4TrxEyo+HlWoPhiopIPrsSwudFHlPW8hD4VRiJ/10Izhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DM6PR03MB5114.namprd03.prod.outlook.com (2603:10b6:5:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 10:07:34 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 10:07:34 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Topic: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Index: AQHc3inmJrOqLx0RyUyaZwFfTl+ZmrYKRGEAgAL6q1A=
Date: Thu, 14 May 2026 10:07:34 +0000
Message-ID:
 <LV9PR03MB84148EC966F80CB723325B46F7072@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com>
 <20260512121326.189817b8@jic23-huawei>
In-Reply-To: <20260512121326.189817b8@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DM6PR03MB5114:EE_
x-ms-office365-filtering-correlation-id: 95bba602-18f8-4e15-d87a-08deb1a09e76
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|3023799003|4143699003|11063799003|38070700021;
x-microsoft-antispam-message-info:
 U75cm8fK/bcc9ssiKQAqmmL6LXTeG22Fgh43t97LOcyT7Sdqdo8EWoqGxSCCJmuBamYHgR5rmyWNQfPjHodWcNIGE1QOwJHe0efs5fbojExuQFue49O8uktHW5vKpeug6qpZNDMIvPkZ6+MK0goI/+/60qEJ1ZZzI+ocLml48O88VXZ4FXdvvFiQr79px7v+JD6beILROAW/xynAlVLBpIXRQtRxdcb+PvH23LPER5TuhsD5pnFfOLgc6xb//TfZec903h06d3XtP4IC2Fg0tzV4emc8hP2WervS6Ey5FOFm7Euyv+sSuU7Z7+0w2C5a1ekzr0ZP8ERKuXQNSZdBJ9RMv733K8ryj1Lhvt2iZyONVmPwVG5UjH9ODrsTx6Zw1YYweueLbU+w8wK7ilkOsqB8Ma3c8WilydttcGx74hUbQyE/+3m0YoiCkkzzPRmYrWpXxWosRLLTKH3ooC7810yAehKzTru14PRJ1jI9lqPX4CV/4umNHW1PDDp0JTMSFV3aIwYiF3/W+j9WIJzAVS8k7nKRvF9IgKZu+n2mN+Renuu/mq5RY0xfIwvBKBv1Cg+2kqhj4NIZOOpvdQVux6NUVJU8autwgfYJazZX+KOibOMbFuYNTbJ5G33SGn/OLjSMaRnGbWL8uxOhXvhAzvIWdh5Dkx5ezfgJ9PgVF7W8HljgvqL7l/jcGffE3kT8lipV+AQOCOFhJ5/ad1YoICaADcD5/8CYYGUVMbz+VVxSpFP0K4X0coMfz0uxAsll
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(3023799003)(4143699003)(11063799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDlLcFVGUmZ5U2lRVlBERnpObmxxNy9yVU5QMDNIWGF3ZG1wbTlxY3RhL3Zh?=
 =?utf-8?B?ZGNGU2RIemg1UXlHRVFueGx5MkJWZGc0QXJPc1lpK0JhSHd6NHdGNEx4VmE4?=
 =?utf-8?B?YXNSWWdSb3ZlcUxvS0NwQlVFVGtsNzlKRkJCMFJuZHZSOHN1VzFNNFdtbjI5?=
 =?utf-8?B?LzYwVVdSZmx1OUE3OGhxK3VtZjFMcDUxU1hGYjU3akNwUnRiYXBmZkJmMUpR?=
 =?utf-8?B?Q2JuVXVuaGw4Q0gwbE5vNk02QVhjL0dTQ3E0VnltN3JBQ2R6S09MdnpPWHNH?=
 =?utf-8?B?MUl5aGRZMCtGdUdMRVlYeDJVZGNKb2JuaHZ3Q0dLWFZNQzNKMStxQllaSlAz?=
 =?utf-8?B?UnhMTU94cS9YMzBEOVlCOEs4VGxEd084Z0gvckdISG9iVVlmUUxYQW1nR3Jt?=
 =?utf-8?B?ejNSNURJQ0YvMCtEY0tnMGUydGE5aHpJWHRzNzFxS3B3Y3RlQ0twTE5NOWF3?=
 =?utf-8?B?YkpxajEydmlCUHY1aGh1Zy91ZFNuV1JVQjVQTjFZaWY3MitXakphVW5pOFp1?=
 =?utf-8?B?R3BseGZzcFRaalhJZUxFbkREaldzV0k4TUlJZXN2SkUzTHZPZHJpREhqMVNM?=
 =?utf-8?B?cmZ5VDZHLzA0d3ZBU1dtWU1ZSkNLZEhzNWdvWC9BcTFWeXF3QVU0dDkxdXR1?=
 =?utf-8?B?a0lVQUNCWHZ2aE1Ea1hVTjhaWGpXMW9oTURNYlNGUmlETkh4TGZvQUt3ak5G?=
 =?utf-8?B?QU9ZaVlYR0FOSVVsanErdVIwRHJUd01xL3lKT2tsUWcrMzN6V2dYYVhKdEYx?=
 =?utf-8?B?dlhmSjlqa0JYRXRpZE8vUzYvTVp4R0lYSXkvcGRudjgzUy9UeXBvZTJVTy9n?=
 =?utf-8?B?MUxRYWthcXptbmUrYkxoNkdZZXNNVDcydWJsNFdMekFadk5zRUx4RDZaTHZp?=
 =?utf-8?B?djZoMGltWk9QalIrOThzckY5b3NUNnFocEJHOXNaUEU3eFNiNkowWnFXRHZM?=
 =?utf-8?B?YkdFNllGT2R2MkttWmxPM0JyYWh4SFh3VG9RU2U5ajVyaUowbUpHeUxxam1S?=
 =?utf-8?B?OHd0Y01QZDZseFlVY3JBUFUyT0dRMkxzdjFMZi83bDlqV0R0dTQwR2dJSmNP?=
 =?utf-8?B?bDNKOVhzS2ZxL0EzbjR0VUlURzM4QzA2SzJEb2RRUUI1Nk9HY0Z6ZG8yM0FZ?=
 =?utf-8?B?RGY0azNBNXliUkVaMFhicG14Y25DN2FPOExRR0VVNmVjNUMyQkt5a0xjV0Za?=
 =?utf-8?B?NndaODBZMFhKSmNiTEVvYnVWdG9kNEpmZTByV2NqYjlsdTRSVXpYR2ZycGpU?=
 =?utf-8?B?NXYvbWxYMXlBYSthNTVSbHgxZ1czdHl6aGp3UkdjSVpNSUFIMWlKdldvZGN2?=
 =?utf-8?B?ZmN1SVJwM3haZXNCNVNhcWRsR2lBTnBEZHpnYUJ4R0FkenRMRU1kMkJHTS96?=
 =?utf-8?B?SjI3NHc1dUtEeVBUWTVtcnJuK0c5NzVhZFVZdGpDK1dzdFAyU0FBbWtFa1Yx?=
 =?utf-8?B?NzdYVFYzZWdvOHQ0L3pQdmJrT29hamdXSW5LN25hSi9XVXkrNHRPaW05OUJK?=
 =?utf-8?B?eEhQaWIrZnRJWXY1ZVdiZGc0RXdDcU0rRlo0NFA4a0RYLzA4aVdHMVQrMFRz?=
 =?utf-8?B?UnN0eHkxU3BHaFJsMGRNSWorb1crekNQNHB2QlNjaXNGNi9WUnFrNFY5b1hN?=
 =?utf-8?B?akMwT2NFZWI5VVZ2WmxUaTkrSU1NeWIvSVR4OWZGdnd0cVRMakczeTZEVHEz?=
 =?utf-8?B?c0YzM2xKUGRQNTIra3FLSkRXU3hrd0w0MXpFNE12RXIxQkZneS9CZHNScnFo?=
 =?utf-8?B?b2VNWjhyZEhDamVObVliTWZJVlZrNVZYVkZNN1JxV2FpODduYkxOZkNFcEhL?=
 =?utf-8?B?UDlvc2JkVlNMUTFCZnROVzFPZzViWkd0UjFVc1RQWkZpV3JPVmZoclhUWXJj?=
 =?utf-8?B?WVkra244T1hBVWlWcFFrdzhlYWo1dDBBdzRyUHdnS1ZHZlNON2RENDdNVUJR?=
 =?utf-8?B?WmpxL3lpWVhTSEJkVFFTbThUM3BNVktwWW1GK2lseUlXdjBzOGhIM28rSXVV?=
 =?utf-8?B?elkrMGZVVUhTaExuQ21LYk9GUjBCSnl1VDFmOGhIVTNaZGpXNXFwTmVtelhj?=
 =?utf-8?B?b0VXa1I1NGl3eDNmTmg5L1pjOE9SQlVONVFKOGQvc3RxQWNTbnRaa045RWpo?=
 =?utf-8?B?QThNQ0hlRGIxM3BLRzVSYmhYV3J4S2xzamZXeWFxTXpWWXBkcFd5Mzh0NUxl?=
 =?utf-8?B?TEVCY3pscXFGUEJ3YW9EUFMvaXpFeGNNVUw5TFZCZWdVWUxub2xJdTFJeFpW?=
 =?utf-8?B?T3AvWmZ3aE9XWkdqMjR5MEdlZmE1MjhDOFU1VkhsOEw4SHBobVlEYmdYaG9C?=
 =?utf-8?B?dDBvcE1yS2VOeWxyOTAvbWNHb3FIWXNtRjFDbUE1ZktuY1ZTVXJwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fY9M/HVd29r9XqSaGzJexpkbgpU9ydl35SReeFul1t3p6vewhr9wHqkiaNjJ8BADCFFV63H83+O3QWbB9jWc7XTG/m/0LZOZWqUyzq8x7wxyHGJsXZHL65jjjZsRZdhiSrmEKukossTb2Y00n+qliCTAa2Qwk9OkI6+u3mQoV2xsSPzeU7tMzo3a9yNw5yFaBrEl15o/8I8dp4ZBuhv48BkUbhi/Ci6LM4kTAWckNrWv6WZF1ofu7mdfe3XdT87AZ1je8S1YjssuTNtX+boi6b2wl1AWI/vdaLkcz4AKRxEvfxOEPPzpX6xf/bpCfBPxEB0Yv4UT6ybl1NVy/gVy3A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bba602-18f8-4e15-d87a-08deb1a09e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 10:07:34.4038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7w8qSfbJVi+gzk3Q9mt2LofbB6bpGNCKmmwecoCGIIQE/szmtqe72DobI57g1zaNxwK0M36pgi1mqqsBo65pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEwMCBTYWx0ZWRfX7Gr0N8BH6dqu
 J9FxKez9fTuhg/KKLeJ9LfM53CTqpcWcScikP2hEzoA4LBXOTxzL6OFZ0wxEu8lJXvzj50IHKVO
 rfTr+IK7twwUmRqWw8jrJW/YW9T0SW1cRAgMOxv6eu033xWYNhF7WVEAHDMagTbOmAvhWcdAQfe
 0Hcyksfrkf5CoFTFHruPDiFNLbuT/qHj6K2kwaKevebdfnZeeHhrH4L7H1atUeiJbBRIuLg9Omz
 6+KuH7Pa5y0HMyBD6nrUxYF5+qYn5zn0sAuwEUAzPlznX5I1un9XeCOO9xPqGJiki0IFyUXtnpt
 rzlIXO6OeMxWCAP13g0M2RS4ldIC6iebDqn1iwmpPZ/lIfAFnu49fXjS9QwDlARsX+qJSYeWpZq
 RtXBynvavJidlZdJUiAwVeidFRXqKHHwQWgWMFa8qB+TDrqdz2X5dqiUA3n/7P5+e0GyRyJDl6p
 DktF/qcciGNHZWGSK+A==
X-Proofpoint-GUID: YqUXiMEORdIwMlek8iAtqag9DUWwa5iI
X-Proofpoint-ORIG-GUID: YqUXiMEORdIwMlek8iAtqag9DUWwa5iI
X-Authority-Analysis: v=2.4 cv=MMFQXsZl c=1 sm=1 tr=0 ts=6a059ee9 cx=c_pps
 a=L+Py7vYzrJWCdJtBuFK3AA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=bFF3RyNeSQnQY8OrWK0A:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140100

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTIsIDIwMjYgMjoxMyBQTQ0K
DQouLi4NCg0KPiA+IEZpeGVzOiAxMzJkNDRkYzY5NjYgKCJpaW86IGFkYzogYWRfc2lnbWFfZGVs
dGE6IENoZWNrIGZvciBwcmV2aW91cyByZWFkeQ0KPiBzaWduYWxzIikNCj4gPiBBY2tlZC1ieTog
VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUmFkdSBTYWJhdSA8cmFkdS5zYWJhdUBhbmFsb2cuY29tPg0KPiANCj4gQWN0
dWFsbHkgLSBkcm9wcGVkIGFnYWluLiBJIGZvcmdvdCB0byBjaGVjayBTYXNoaWtvLg0KPiAoTm90
ZSBwbGVhc2UgZG8gdGhpcyB5b3Vyc2VsZiBpbiBmdXR1cmUgYW5kIHJlcGx5IHRvIHRoZSBwYXRj
aCBpZiBjaGFuZ2VzIGFyZQ0KPiBuZWVkZWQpLiAgSXQgcmFpc2VzIHNvbWUgY29uY2VybnMgYWJv
dXQgZGV2aWNlcyB0aGF0IGRvbid0IHByb3ZpZGUNCj4gdGhlIGNhbGxiYWNrcyBhbmQgaGVuY2Ug
d29uJ3QgZXZlciB1c2UgdGhhdCBrZWVwX2NzX2Fzc2VydGVkID0gZmFsc2UgY2FsbGJhY2suDQo+
IA0KPiBJJ20gc3RydWdnbGluZyBhIGJpdCBvbiBob3cgdGhlIG1heDExMjA1IHdvcmtzIGF0IGFs
bCBhcyB0aGVyZSBzZWVtcw0KPiB0byBiZSBhIHN0YXR1cyByZWdpc3RlciByZWFkIG9uIGEgZGV2
aWNlIHdoaWNoIGNsYWltcyB0byBoYXZlIG5vIHJlZ2lzdGVycy4NCj4gYWRfc2lnbWFfZGVsdGFf
Y2xlYXJfcGVuZGluZ19ldmVudCgpIGFzIHRoZSBiaW5kaW5nIHN1Z2dlc3RzIHRoaXMgZGV2aWNl
DQo+IGRvZXNuJ3QgaGF2ZSBhIGRyZHlfZ3Bpbw0KPiANCj4gQW55aG93LCBwbGVhc2UgdGFrZSBh
IGxvb2sgYXQgdGhlIGZlZWRiYWNrIGFuZCBpZiBpdCdzIHdyb25nIHBsZWFzZSBwcm92aWRlDQo+
IGFuIGV4cGxhbmF0aW9uIG9mIHdoeSBpbiB0aGlzIHRocmVhZC4NCj4gDQoNCkhpIEpvbmF0aGFu
LA0KDQpGaXJzdCBvZiBhbGwgc29ycnkgZm9yIGZvcmdldHRpbmcgYWJvdXQgU2FzaGlrby4gSSBo
YWQgYSBsb29rIGF0IG1heDExMjA1IGFuZCBpdA0Kc2VlbXMgbGlrZSB0aGUgZGV2aWNlIGRvZXNu
J3QgaGF2ZSBhIENTIHNvIHRoZXJlZm9yZSB0aGUgY29uY2VybiBTYXNoaWtvDQpyYWlzZXMgcmVn
YXJkaW5nIENTIG1heSBub3QgYmUgdmFsaWQsIEkgd2lsbCBtYWtlIHN1cmUgdG8gbWVudGlvbg0K
dGhhdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCk9uIHRoZSBvdGhlciBoYW5kLCBJIHNlZSB0
aGUgSUMgaGFzIGEgc2hhcmVkIHBpbiBmb3IgRFJEWSBhbmQgRE9VVCBhbmQNCnRoZSBiaW5kaW5n
cyBzcGVjaWZ5IHNvbWUgaW50ZXJydXB0IHRob3VnaCBubyBzcGVjaWZpYyByZHktZ3Bpb3MgYXJl
DQptZW50aW9uZWQgdGhlcmUuIFRoZSBkZXZpY2UgcmVhZHMgYSByZWdpc3RlciB0aGF0IGRvZXNu
J3QgZXhpc3Qgd2hpY2gNCmluIHRoaXMgY2FzZSBtZWFucyBpdCBibGluZGx5IGNsb2NrcyBvdXQg
d2hhdGV2ZXIgY29tZXMgb24gTUlTTy4uLg0KDQpIb3dldmVyIEkgbWF5IGhhdmUgYSBmaXggZm9y
IHRoaXMgYW5kIHdvdWxkIGFwcGVhciBpbiBhIHNlY29uZCBjb21taXQuDQpJbiBjbGVhcl9wZW5k
aW5nX2V2ZW50IHdoZXJlIHJkeV9ncGlvZCBpcyBjaGVja2VkIHRoZXJlIGNvdWxkIGJlIHlldA0K
YW5vdGhlciBlbHNlIGJyYW5jaCB0aGF0IGNvdWxkIHNpbXBseSByZXR1cm4gMCBhbmQgaGVyZSBp
cyB3aHkgSSB0aGluayB0aGlzIHdvdWxkIHdvcms6DQoNClNpbmNlIHRoZSBJUlEgaXMgcmVxdWVz
dGVkIHdpdGggSVJRRl9OT19BVVRPRU4gYW5kIElSUV9ESVNBQkxFX1VOTEFaWSwgdGhlIGxhdHRl
cg0Ka2VlcHMgdGhlIElSUSBoYXJkd2FyZS11bm1hc2tlZCBldmVuIHdoaWxlIHNvZnR3YXJlLWRp
c2FibGVkLCBzbyBhbnkgZmFsbGluZyBlZGdlDQpmcm9tIGEgY29tcGxldGVkIGNvbnZlcnNpb24g
aXMgbGF0Y2hlZCBieSB0aGUgSVJRIGNvbnRyb2xsZXIuIFdoZW4gYWRfc2RfZW5hYmxlX2lycSgp
DQppcyBzdWJzZXF1ZW50bHkgY2FsbGVkLCB0aGUgbGF0Y2hlZCBlZGdlIGZpcmVzIGltbWVkaWF0
ZWx5LCBhbmQgYWRfc2RfcmVhZF9yZWcoKSByZWFkcw0KdGhlIGNvbXBsZXRlIHN0YWxlIHJlc3Vs
dCB3aXRob3V0IGFueSBwcmlvciBwYXJ0aWFsIGNsb2NrIGNvcnJ1cHRpb24sIHNvIHRoZSByZXN1
bHQgaXMgbm90DQpyZWFkIGJ5IG1pc3Rha2UgYXMgaXQgY291bGQgY3VycmVudGx5IGhhcHBlbi4N
Cg0KTGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGlzLA0KUmFkdQ0KDQo=
