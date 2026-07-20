Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569622F851;
	Mon, 20 Jul 2026 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542794; cv=fail; b=uPck4kcPc/YuCI+1i5ZnjwmBABqYZ22xcR1NVs4DbcRY5RImcNtm9VaMG+7Ve3ptyteazOPlsEczQUK99dMu7CAf8N97W1sp5Pa6r8TFbNLyZptAduaOJ6qfYOBqfmNHbhWoOisCLvI+yUvuW3FgfgLULmEq/xoj0YPFwypDnm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542794; c=relaxed/simple;
	bh=9lL1SpEEIeonsH7ts+VzBbNINWhIbK+Cnd9G++hOdBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZjcqueuH6Zr/KyR8eMyXx3qVosVMaLOooLu0PKLOw0Bd3meC4fxujx/pb9oTVWAVO5Ulx7t7bkjzG1YpstDVgW1Wgy//6ApNSydHSDaO2SDdh4rHgM5JHj1hCOf0C/2J1vI5po6JMpSKYeRucd4ieCSeMAVK9iLxiAomNb7lrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=bGGqXiUz; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="bGGqXiUz"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KA23Ns374303;
	Mon, 20 Jul 2026 10:19:47 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012006.outbound.protection.outlook.com [40.107.149.6])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4fg2a9181y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:19:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuLvIa6PrRY7lVbWi2dTOY6JSLSjCyp098ydgSi8VuBr1Vq8uqrleITjzt7ZRyzQ2D8QNoEfGPbxALh6rMoWoqHinMZ2Y5gSwZrVVunXVAV0K1w83itLvDwvuRsE+FoNkTFv1E8bVdQwTSUb7QVpdW/ahY854CmSK4MIg+e3UBk8FVEOdFK7EDyA7XMXehuLLi1cTo/9I6VxM9CP+AgvjQjPph/flEOZXQdEG36ZGtRlYAQgZrHBFAGscjXZsD43HVPxHi9JSn+Tqoxj2cb1m6n6WdU0pPSHoelJLCn3EQC5AAhi9LiN665lqdYFupNQMqPLbNJ72Z+L7mQDrMa7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lL1SpEEIeonsH7ts+VzBbNINWhIbK+Cnd9G++hOdBA=;
 b=nYQF+aXYEe6HzYtPPkzYwCMwko5KwuAQhzkiYUHQikcmImMazfkHiPHGK9/FN3Hy0s/lqdOnNG5LBIyMC/kYZNN9721n/APTPqua+KA6DFKPjj1fQtD/whM2mZkwr3lpUXdUZruzOhkRiDcJDk3VW1H9pETsdIOz8/c/asIxU6AReCK9AMsbnH4qQvi6aeOm38ILAFdat7Giz6lCITm1FfIWWuOplx1NZdE+awf88tdH0pzGhPzf3qO9mjt49pXwWcwPnojZR3WcyK9TmIcVZG7XrzmiqcvLfS9q/bxZ1HJFZ4Z3tmU28HOpXtBDPQHJHdQIc8Yt1+ax5mSRAS7VQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lL1SpEEIeonsH7ts+VzBbNINWhIbK+Cnd9G++hOdBA=;
 b=bGGqXiUzPwA1c1F52brODzX3OmmJufTASWTViQRW9cFcCJQMSgkxs6A6ZKgnCc0crlHmz1jIFFvJFJICocGfLb6Frg9GNK3H5kb+ExKgfafFUvcSBvcuE/rP452kYlkuGIjsVjGSdypdaRPUk/ObhRfyJnhWSLtlB5H6MoPj+fx9J22s/JyU3nM3ziRESss26PrMSTUzhcUP42FjT5vcRZUcLzq/o2Wo9/+lUIkUhi0aQJ9pEzTLa/NOpEAGe9/waLWNgCkvW7h46kmEjhNCKbicv3HIcFGgHf0AF8zSSUIrvd5Ja+p9XKZWpfF7MJJ8lB/FfOKHApq9XSIEqVWZ4A==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR5P281MB3986.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:19:41 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:19:41 +0000
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
Subject: Re: [PATCH 2/2] iio: invensense: improve period measurement by using
 a longer delay
Thread-Topic: [PATCH 2/2] iio: invensense: improve period measurement by using
 a longer delay
Thread-Index: AQHdFelmBIzgDfBlVUqCSVilknmnubZyAxwAgAQzMns=
Date: Mon, 20 Jul 2026 10:19:41 +0000
Message-ID:
 <BE1P281MB1426166A8309227570DA7810CEC32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
 <20260717-iio-common-inv-sensors-timestamp-rework-v1-2-d1afee2805cd@tdk.com>
 <alpv8rAJk65aW7h4@ashevche-desk.local>
In-Reply-To: <alpv8rAJk65aW7h4@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR5P281MB3986:EE_
x-ms-office365-filtering-correlation-id: 946db6bb-17d0-4e71-1c93-08dee64869ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|38070700021|56012099006|4143699003|11063799006|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 j5QCeMngp7Zi57XJgllCJ3pzn6pIJDGqz+LoQL1c99cUCw4B+sDHp497F64H50ol1H19znG+ZqdvI3UU4RrMJKoZhQl9Osh75m4MY0BoJCtdEuXyng1IwewObRe9WPuvz8baOitFfXg6qyEIgpoUqR4W44CQfl8SYV34j+dHFMa13RwnpBMcyQ7XDGditvZdnGnh1+3Di2iq4lNOvGMus7Eecvei4kcbyqsJ4JP4oEbNBCnT2rSV6zn+E3ILhEpMrrYc4XP3JUDA7iKjtDwOE7rQlv3G45ku8zGrLdvegQLCWEGSYpBI4xr8EKvS/8+bJSWe2xXj1v/0gQdxkp3TfyNylQpokIIbEnC4x6nI8kg6TJq4Nh42pfPlk6/xs0nszERe51nsdfwrXBLXjOfqua1atq0cGNzLVNjpatACQD7VIWqfkZlS2tRyzyYEt3YGa/ctBTocqT3bKFjvO+xfPjojH2DkbTwa1OaqE8G5fYltki5+5BUwx7Xiu1KnaGxoP/3MMJbNNkQ8Tkmp5sThOpfSLGWRPjg8yua5zDBviQprj9eTVh5A0ZdbtMahgWiaCTK4XC4JscYAuhAvOIFZHlBoLTTwKzlAzckuAnhLxZVfvPgnUiBPbgAEsuyh4vMqcmghSbMQ8TAcZmeQVxTJB6Lm1ccZD4kq/O/JYrKuuDZ4wrO6tgW5ZVZGlZxz0DWsGrs7dqnJnisIeFF8s1DQmv5Qhy1MO7H6Kt2A3m6ZuIg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHYvcmlLL09scHVyL3Mrd0RUMVJlL2lRUE12Q3FyNmNjWVhSbVFpYlZGaE54?=
 =?utf-8?B?eG8rZGlYaFo5ejREWXVRTGlEcXQ0T0c2QmFROGFJc3BwbGZHbTNlYnBFMXlX?=
 =?utf-8?B?LzFHQ1ZENkwwZ2Y3Qjc4cXAxMldGTTNXdU5Rc094RlVWRkVDUXJFVXRDWENx?=
 =?utf-8?B?SEt5b2Q5a09JK1hUZDV1cTBUc0xCcEdqaTVuN3g5YVdSdTRuRkNpd044b082?=
 =?utf-8?B?Lzhpb011Y2F5OXZUbFp1YTFVYzNkd0dOWmpWeUdpaG1jbzlRck9WYTJhMkg1?=
 =?utf-8?B?M2tDNm4xTW9hNWVyZVA3eklHUHg4OEVtVHVKS1p5dC9KdVUzd1kySDlwV0pp?=
 =?utf-8?B?bGxTZW44QlROQm14cGMvMVBFQ3FYWXRGK2pnQ2QzMDlpYm5RM3pWNm5ZMFhT?=
 =?utf-8?B?SlRhaHpxL0tNc0tRVy95dUZ2WjBZTkZhZWRRUlVvWHZ6TWJBNUtXU2dwenJp?=
 =?utf-8?B?YXE1aDd0d2VQeDh1ZWlxVVFPbzE2eDVVU2gvVEdKRFpBMzRIYnlLcXQ0NGU1?=
 =?utf-8?B?blRDWjRiTnZxK3RaWUdhYXc0Y3I0L2ovMWt0VGJxZGQrRjg2U2p6dmlZSGgx?=
 =?utf-8?B?MDNEVno1UklNdnV0QmlmRzd4V2w4UmtGV1R4QUhPV3hsRlpDQTJmQ1l6clRL?=
 =?utf-8?B?RE5ZUkZiTzZpYTVuWFlFeHdDVW9uUk0rejdEdUdMR2dXWUJ0VVY4Nk84RUlM?=
 =?utf-8?B?RklGRG5kOGVOaGZBTm1LRmNVZ1g0VFZJRTJDdFV2WGhGeWNaTWRNOVhDbGhH?=
 =?utf-8?B?T1k3aUFNUUx0TEc1K1BUWUNMSkQrdFJHNmlFRFBoN1ZySmR0RmZzNzdkcDBM?=
 =?utf-8?B?eHB1WVY1Sk1JYXpHV0FaU1pmY29LOHZzUi9nVGJ0Y01hTWJIaUp6a0wxK0dV?=
 =?utf-8?B?cWM2djFwLzNtampTTVJQcWltOXZEOEZpWnhjT29IR2Ztbk8yd2pxeSt5MmtK?=
 =?utf-8?B?SUxSMnN5ejg1OEE1K2Z6T1VqZ1FqbG40VUZ4cWRvN3VnK1NlRFQxZndUbmhO?=
 =?utf-8?B?MVBCOEpDc2JDSGhwWlp5RWkwSFhnZHRzR08rM3Eza3hwTlZHOU94c2N5aE5y?=
 =?utf-8?B?UXpyK2pYbDdPTHF0WnV5ZkxUSmtMMXVqWXdzbHA2UDY2V0plTll0MmdNbzcx?=
 =?utf-8?B?dFEvajFoYXFFcVg4VkQxUXhqY1UwWGVTbVN1djdOMlBHUWJMczhSRWYrYmhI?=
 =?utf-8?B?eGJTM0FoOVJ1aUFDdHVoY3FqTThWSGpVZC9mZVFUSUN3SDNGWGNUcmFGZFE4?=
 =?utf-8?B?ZG4rM3dlN3U2N2N4ZDZacmcxbDhDek9GOE1IZmRlc3RDeXRGeUVKMm8yMklJ?=
 =?utf-8?B?cG5kSjNqSituZ3lnMmJzV3dvK244SHJLWWcyU0ZORGtwUEpHL1NNRUZIb3cx?=
 =?utf-8?B?YXUvNjN2QkE3UWRYRlVyTHZqdVppZHozOVFkUXhkOENlZUpoSi9rY1FpWGFI?=
 =?utf-8?B?MU4vVjlRQ3hycjN5ZTlMYzluaWlVR0JGRzBUQW5ZUWsyRUdoUStWOTM0T2lt?=
 =?utf-8?B?NGRSb1NUMFUybTlYWVVqL09DUmQxWWYvaExVRHFLMy9OY3NORXRobDg3VFdG?=
 =?utf-8?B?NG1JOXN1L2MxcTdBdXhHNmE1UHZhdTEzbHdncis3TzdScENpNjJvMUFVV2Rv?=
 =?utf-8?B?bmQ1UVNlVFpJTzd1UWhtVHdpQjVCNlA3TGFvUWxhYVlSK3YvSllXYnJrRTRI?=
 =?utf-8?B?N0lUWHRiRThVRjFFWllOazFncEpuOHRGRzVLL3NBb0h0eWpUcmo0c0YyY095?=
 =?utf-8?B?Wnl4NjEzZGdnR292THJPbnlZVTRCQldkenV5RW5wR0JOWmpuemhkZENKU293?=
 =?utf-8?B?NDNVQlpXM2ZZRFArM0JZaUp4dU02QzNSeEVxdlo0bmhBc0lVQWxKMS9KRkVp?=
 =?utf-8?B?bGdtOEVnWmhPTDVsTW42aVYzM3ZVNjhYeGZIZzFKUS80Q2pDTGZvTTFJRzJT?=
 =?utf-8?B?aUxibXFDS3dFZldLdVYweStLUG1URWovbGszZ2F4ZzBEU3JKUGNMTkt3SVdT?=
 =?utf-8?B?TVIrTmZzQlpnaDh6WCs4bG1DSnJ0OVZKdk8zS0FhbmxKemdZbHhNb2dlY0Nw?=
 =?utf-8?B?ZHJQeVk4ODc1YnZLK3lOUEMvVWVvMFNIN0ZjTXhoZmtIMkp6N3cvUFU3eGNJ?=
 =?utf-8?B?aWtRazZBY2QxRWN3MDc0ZGV0T2NEcUxSY3NYb21ldTJ2VFp1U3d1YzFZejE3?=
 =?utf-8?B?ZVpQWEcxbUFFcjNsZFBZaTVycERhSGtMNGFUU05KMktoZzBqMDUxdWJ0b3A5?=
 =?utf-8?B?REl4L2ZPaDNHM0NGcjhNZXUvbDRHbitwSUFNY0ZnY2xBRTZEU3BqZE1CbmVy?=
 =?utf-8?B?SE5yZ0ZrZ0JVYjE5YXpTVnlSRTZ4QTB1SHA3YldiTlhCRklsY1FsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QEOLcwSFeHIi44031phQOxhnu9xA79u4QigNQEFc7NcvkL1WztGvkqI38JFLw+FC5NZWoKApNHnSmhSZZA0TPCn+NrMRLdqWEUB1d1TAMGTdlpGHN/WJ9ZiaNlBr0cPTDbnvOt8HqsdVyldsjSWZQXhwVm8slbuH8EjLHBCOgPEOGmBZ0B4eUpOrXWUHlx3VgF2H4zHkZcNY7oymyMPXVsq/2GSCD1xAxQvL0quhfCfjwMZP2lqrmbSPuFVAfIDL9RTn5z2dlyAuTVS5oE54XxBUNE+Od1Rh+3mQybiFpeklzCKJyPMBZQE7uWkYCfJmZqpJ5mWFE4ESJrIDH2lJ+A==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 946db6bb-17d0-4e71-1c93-08dee64869ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:19:41.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObqVa6sNxywjTYkwStAldYZ8g533C2brRU4zyP+fjyE+2C9557XEFjs2PGMh+DS759WoB0xsqXFsxS3++4f6Lo2hFpz5qGT2lTMGGFejZpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB3986
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNSBTYWx0ZWRfX6UUdIDmD/wyF
 xyrqzqVMkRRo7M012RcRGHnyQIGBYxNvTvg9R4/nys9KROx7hzPeZqa5XQF7YGiBb/C1eRKSGFH
 UTuuapaTDOHmVD3Kt7npgHJ4+Br8sbiCINjgGFDXsl5i+6fj7Xo5
X-Proofpoint-GUID: 29dsRIZYPrzHnJ2CB7IYj1C07zOnk12q
X-Proofpoint-ORIG-GUID: 29dsRIZYPrzHnJ2CB7IYj1C07zOnk12q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNSBTYWx0ZWRfX4ht05UskGrwO
 3jr4gd4MFeOtJixUmThAaX77Ecv5Z5aGSNpt97Vv0QImoRXjekPzh3eplL9vdQ6KXowoyb3OZjZ
 JpFw6NQ2lnKof418xoMFt01t884W+iMz4xcA/qNaidr7AQH2OQTsPazgm9ypu+r6LFX/xysEWbu
 Q19C9b/tM6W7HiE2FY2SLNBcYjpQQnPHhKjZe4gcuIVAaYQNXxaZwxvm7sKmSEE8kBKHeDtr+rM
 QMHYklV88wTwyxoNMBx94qC3QEb/ixxSttj6g/UbHWTpZiKe3DDY4xkiXxqIU82maCcjgw/Y6Am
 lJqibNXDGSdKQO2JhLWZFfcDCLburOec+moqq0Frt2BImbZ6JdThIv5ZOOHTthpu2K3ct/bz54Y
 sUGphEpdc+nmv/JalcwDtkZujpk/0eegRF+BD+wPmtal+iHxe6sZEEWEMOkc+JP4mJWgztKFbDI
 rdpL46WbZd/PoAQNGuQ==
X-Authority-Analysis: v=2.4 cv=W6oIkxWk c=1 sm=1 tr=0 ts=6a5df643 cx=c_pps
 a=7AjyV/po3zt6/MkOXpYVgA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=kXqtAGAV2RImNV55mgMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200115

Pgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+RnJvbTogQW5keSBT
aGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+Cj5TZW50OiBGcmlkYXksIEp1
bHkgMTcsIDIwMjYgMjA6MDkKPlRvOiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sCj5DYzogSm9uYXRo
YW4gQ2FtZXJvbjsgRGF2aWQgTGVjaG5lcjsgTnVubyBTw6E7IEFuZHkgU2hldmNoZW5rbzsgbGlu
dXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+U3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIGlpbzogaW52ZW5zZW5zZTogaW1wcm92ZSBwZXJpb2QgbWVh
c3VyZW1lbnQgYnkgdXNpbmcgYSBsb25nZXIgZGVsYXkKPgo+T24gRnJpLCBKdWwgMTcsIDIwMjYg
YXQgMDI64oCKMzk64oCKNDFQTSArMDIwMCwgSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCB2aWEgQjQg
UmVsYXkgd3JvdGU6ID4gUGVyaW9kIG1lYXN1cmVtZW50IGNhbiBiZSBkaWZmaWN1bHQgd2hlbiB1
c2luZyBoaWdoIHNhbXBsaW5nID4gZnJlcXVlbmN5IHdoZXJlIHRoZSBqaXR0ZXIgY3JpdGVyaWEg
aXMgaGFyZCB0byBtZWV0IGJlY2F1c2Ugb2YgdGhlID4gc3lzdGVtIGppdHRlci7igIoKPlpqUWNt
UVJZRnBmcHRCYW5uZXJTdGFydAo+VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2Vu
ZGVyCj5UaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uCj4K
PlpqUWNtUVJZRnBmcHRCYW5uZXJFbmQKPgo+T24gRnJpLCBKdWwgMTcsIDIwMjYgYXQgMDI6Mzk6
NDFQTSArMDIwMCwgSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCB2aWEgQjQgUmVsYXkgd3JvdGU6Cj4K
Pj4gUGVyaW9kIG1lYXN1cmVtZW50IGNhbiBiZSBkaWZmaWN1bHQgd2hlbiB1c2luZyBoaWdoIHNh
bXBsaW5nCj4+IGZyZXF1ZW5jeSB3aGVyZSB0aGUgaml0dGVyIGNyaXRlcmlhIGlzIGhhcmQgdG8g
bWVldCBiZWNhdXNlIG9mIHRoZQo+PiBzeXN0ZW0gaml0dGVyLgo+Pgo+PiBUaGlzIG5ldyB2ZXJz
aW9uIGlzIHVzaW5nIHRoZSBkZWx0YSB0aW1lIGJldHdlZW4gMiBkaXN0YW50IGludGVycnVwdHMK
Pj4gdG8gbWVhc3VyZSBhbiBpbnRlcnZhbCBvZiBhdCBsZWFzdCAyMG1zLiAyMG1zIGlzIGEgZ29v
ZCBjb21wcm9taXNlCj4+IGJldHdlZW4gdGhlIG1pdGlnYXRpb24gb2Ygc3lzdGVtIGppdHRlciBh
bmQgdGhlIGRlbGF5IHRvIHVwZGF0ZQo+PiBwZXJpb2QuIFRoaXMgd2F5IHdlIGRlY29ycmVsYXRl
IHRoZSBwZXJpb2QgbWVhc3VyZW1lbnQgZnJvbSB0aGUKPj4gaW50ZXJydXB0IHRpbWVzdGFtcHMg
c3luY2luZyB1c2luZyBvbmx5IHRoZSAyIGxhc3QgaW50ZXJydXB0cy4KPgo+Li4uCj4KPj4gIHZv
aWQgaW52X3NlbnNvcnNfdGltZXN0YW1wX2ludGVycnVwdChzdHJ1Y3QgaW52X3NlbnNvcnNfdGlt
ZXN0YW1wICp0cywKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3Qg
c2FtcGxlX25iLCBpbnQ2NF90IHRpbWVzdGFtcCkKPj4gIHsKPj4gKyAgICAgY29uc3QgaW50NjRf
dCBkZWx0YV90aHJlc2hvbGQgPQo+PiArICAgICAgICAgICAgICAgICAgICAgSU5WX1NFTlNPUlNf
VElNRVNUQU1QX01JTihJTlZfU0VOU09SU19NSU5fSVRfREVMVEEsCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzLT5jaGlwLmppdHRlcik7Cj4KPlRo
aXMgaXMgbGVzcyByZWFkYWJsZSB0aGFuIHRoZSBzcGxpdCB2ZXJzaW9uLgo+Cj4gICAgICAgIGNv
bnN0IHM2NCBkZWx0YV90aHJlc2hvbGQ7Cj4KPkFsc28sIHdoYXQgY29uc3QgZ2l2ZXMgdXMgaGVy
ZT8KPgo+PiAgICAgICBzdHJ1Y3QgaW52X3NlbnNvcnNfdGltZXN0YW1wX2ludGVydmFsICppdDsK
Pj4gICAgICAgaW50NjRfdCBkZWx0YSwgaW50ZXJ2YWw7Cj4+ICAgICAgIHVpbnQzMl90IHBlcmlv
ZDsKPj4gLSAgICAgYm9vbCB2YWxpZCA9IGZhbHNlOwo+PiArICAgICBib29sIHZhbGlkOwo+Cj4g
ICAgICAgIGRlbHRhX3RocmVzaG9sZCA9Cj4gICAgICAgICAgICAgICAgSU5WX1NFTlNPUlNfVElN
RVNUQU1QX01JTihJTlZfU0VOU09SU19NSU5fSVRfREVMVEEsIHRzLT5jaGlwLmppdHRlcik7Cj4K
Pih5ZXMsIEkgd291bGQgZ28gZm9yIGEgYml0IGxvbmdlciBsaW5lKS4KPgo+Cj4+ICAgICAgIGlm
IChzYW1wbGVfbmIgPT0gMCkKPj4gICAgICAgICAgICAgICByZXR1cm47Cj4KPkFuZCB3aHkgdG8g
YXNzaWduIGl0IGlmIHdlIGhhdmUgdG8gcmV0dXJuLCBmb3IgZXhhbXBsZSBoZXJlPwo+TW92ZSB0
aGUgYXNzaWdubWVudCBjbG9zZXIgdG8gaXRzIGZpcnN0IHVzZXIuCgpIZWxsbyBBbmR5LAoKbm8g
cHJvYmxlbSwgSSB3aWxsIGRvIGxpa2UgdGhhdC4KCj4KPi0tCj5XaXRoIEJlc3QgUmVnYXJkcywK
PkFuZHkgU2hldmNoZW5rbwo+CgpUaGFua3MsCkpC
