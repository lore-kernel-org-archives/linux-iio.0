Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459626;
	b=5S/Y0qbFdp3CNbq+MFN1SJDhR8bAWvEK6X3bevwM1HIyDfR2X6jsgog2oU0slJgxGNud
	 KuTNjFw3wO62KTVkcL5qzlIccsKwskKzjss+Zjj2fq+b1iWkH+poL2UxGagk2js3Kd/M2
	 vbN+2wY/TIzBWvt1OqElYABThcZUyyhromPBKc5iElsXNfik6vdPvt7U8yYqMDJt1y58U
	 yZTIpjIQCCnE2mDfWXFUYLJM9zPCc1LssIiT2yz7qlANwLImXiQSN6UhudVI7PY4c7s1F
	 QOFUOd50BgG2WjbrPyuAd5epXHD4KTyT+vzQ+T0/t1zVQ6ruE5m1lzTmuWOtIasuL4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459626;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XaOB3fX9Gh9cbyk7mMQXBvuLXuWcwzH9qdKqgXI7izg=;
	b=hKKUKM8kWxBls1RQsDkOVPwmEXzx7tSRKnhmLapIptRS3zy979CUeBa90yNSqLlZglq3
	 SuJxgkyUqvCYDJJBm0lAIhk5jAFqe6kEVOW5qQ0GMi4QpSNLatqKerOGXI/0YbQ0EqSAn
	 U1N1bEX/9jhKot0fbkfj4mOMVPMv9nXhracODLPOO+FS2wwTZAb7VmhmwQlSyudUc7Ki4
	 9EP5RIw70WKWm8ZvEfBRgoXD1LvZLWuzPFz0UW64zBxhxberdfEZ2Djv8dmqibQcJDMRy
	 HxPYjNj8//71Ah8jEioWX1g9D/yBJWiNJ1MqTHHUoyA5E2Hr1P2ZbvR2waKUq/h3O+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=GpNa0iBQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.23
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010023.outbound.protection.outlook.com [52.103.13.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AFA606A31A;
	Sat, 31 Oct 2026 15:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9AFA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=GpNa0iBQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIWOF6L0DPWKIWKLb6vHuj8JlVevfD2eZqJB9sb6HZHu01NT21Fxg61oOL4XiIjflzKPr0E7TeHg6sAvXnOD5f25ExVYS0AseysaBNpgQ7d8mi2cW/f6tD4YvKerWtCZmkB/kxFFhJugqY5gNKw/6+X0aZoio90PhGNGGoSncbz2EYfP02QebPavXN9PLr+A1x7160RPhWBfHsz/oJRd56OEN6s90J/BqCT4PsGIWYIcbOUpCJsg+jqJ6unk8ui7f6GJlrrw4WFJrzoQvc3Kyh7HH7Xg5OMU89yHHYhHkaNl98x07dy/7ZS9RbQX4fXQgKVefyDaZ/LWQnYjvm+nPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaOB3fX9Gh9cbyk7mMQXBvuLXuWcwzH9qdKqgXI7izg=;
 b=UFnvIfo1rb43GvCXwfCbiGVgI6SaiaCtHj5OutW+kQ8rRwI5ur2NN7+ktftxfStbuPkon+sgiNWKRDvnYEGPwPvNu7BEOMG26mEkuiUBtSU7t0ra+w/AQuMQjjxhTxIUcF7gQgtFoE75rHNrZBpoSo05sQk7kLRB9fkaUM2bjIUaVkl5x3vpuebO+pp3Q5XzEUZBBXs57Na8MKIftYfCsvlDHMZHZs7egMTLiPYYSaIV91SlMz8z99B5gUz3zGdQ0EANkxhAfPkuOA3F0Xf/g2sSgt2PWDxGMy8AjapXeXYzV38E7gjMA1PdT39T59w+Rcy/U3EMqCdBhxo3O0shlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaOB3fX9Gh9cbyk7mMQXBvuLXuWcwzH9qdKqgXI7izg=;
 b=GpNa0iBQkINBZto95Wm6dos9JJO/7bkhfawJUOApvbbU2ZURSWdbghCj+8wXBSTUY8hYs9Ch60u0Dr0+g6r2xWKO6wsMYKhOrCvu4RN8nGY4HV1vfTyHZcYhtkPacNFTKqYjqj0RpXDAIwIEUxbI0Lj0dOY2t4V+bfKFDADGoY1Lbg1cWbH7+dwI88DgymVkoAGqyFIZ1gOIr4hEWnMH3HJx4XNPfjaLivTdaoDmguUWHPEmNaH75pptl5Z0YgmT7psnBESiD05jWHnDjgWnFV1cNodrphFne9AZ7w1JHjFeggD0bA6nH5sfTlhxNgZvjICOWbYayDAPbah30JqO6A==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 15:13:43 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 15:13:43 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v4 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sat, 31 Oct 2026 10:13:26 -0500
Message-ID:
 <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::23) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261031151331.140654-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e97ca3-d5d5-4e85-0f8f-08df37618c01
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|8022599003|260925184616899003|25010399006|24021099003|5062599005|15080799012|23021999003|5072599009|22091999003|24121999003|1602099012|10035399007|26121999007|3071699003|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/xFFjqTfpcPyTYFe5S4td+GRwcy1fB3y7k2Q+QPQ73sN6rZ8tEqwRiajEt0M?=
 =?us-ascii?Q?UnrMHscC/h34ARx4sTY8YG5O6rB/lM2sA/nmw4FanA4D5iMyMKAB4IQx8Tqr?=
 =?us-ascii?Q?mVZou1Z9vPYg4BgJlEd2Y5beCfqU3NHChB2awZTUOs1vGcWTnIcY47W3nOv8?=
 =?us-ascii?Q?IqGWVHyPFZ9eJbBQmvgsHsIDd9AnjtUW7a8hfdwLd1JvDHZfl49Gsl7BKGY7?=
 =?us-ascii?Q?gXs6zlNUt4XhvNDrIU5kBXmhWRsiRYy8FyKswnMaSi4r/vXdvPypNpE2P3A2?=
 =?us-ascii?Q?vo1Ubw0GWjbxhr5y3LY2hjk/+JVSREJPJCKJNnYu9n1w9doGG0eXim3nbpok?=
 =?us-ascii?Q?qBmgRWnxhUzZ5PYPhcYmnmNtqSwKt6KQjTHclXnCjTjbZD+49s0RQ0+s/ZyJ?=
 =?us-ascii?Q?u5PVSPpCjYV1zcVKERcDyvEyn+kK81/sm405u/3rsvaHzl1+CSEVIwOwWBJj?=
 =?us-ascii?Q?w+9142lhUS8mbhY5WfB7N2OJs41SOY7oXJtt0AHZurmp9KcmT2rt+1I5nJXP?=
 =?us-ascii?Q?/JsPHlGZ0L2WUTG4dJSu/Xo7NnO7lzMISrLyY/39/UTp80HI4AB7BA2Ncrdv?=
 =?us-ascii?Q?EWlvwotnHC+7qLWjjPAZ3hkVCI1Eyn/n1OJzfR9lHFJNoWaVpAdIt0CWpIzt?=
 =?us-ascii?Q?n97xcjJJCsAfkC3b4jIdQHAUYqi0+npu2U3G7FtOQCFwH7pEvv4Br3W3BEKr?=
 =?us-ascii?Q?ZQIze0J6x6Kwj4e1S2ADgD2F80hS0beF6z4+up9MH1jglLna4Z0RI44qQR2k?=
 =?us-ascii?Q?saG3VJGg9caMPCNfHnfo8Cj/2dTXOJt2jY9UwevMm1WkEX8qULnRmizoAerX?=
 =?us-ascii?Q?JsOXZHKj6KFNIlkOYM/QSou0po+Y3VsBkhGQ1f3xw527eaNv5J4Eone2zo72?=
 =?us-ascii?Q?AL/8OrE7CCpbmLTqx1NyEPRyUEKVtH/79jocAYPyYb7VMlRVovwVjVDS/Pq7?=
 =?us-ascii?Q?uMS7OFUIy1Qyzo16Qf08VeR9dsGVe87QcZKOKCKpZOsKiPjqIJkGvrljfvag?=
 =?us-ascii?Q?2vyPBhTJSE+VZtQmOt8SuwtwVKaG6bXQZNuDdxMoOT2UGUEWMcsj6ytSo0rH?=
 =?us-ascii?Q?eCMeQHgWMbRHpngZvIAEkOGkp9FduJmsorkp9D8KEr5pXvLCJ0j6P9IsCyEV?=
 =?us-ascii?Q?5wPL9A1ubbtX?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tG/v7BqJXQx0dIaYlUoACrLEfVTZIpBJAyyEH5D89Rh47WMhoQyRWgULjkCG?=
 =?us-ascii?Q?a7RAYaxiNIjwbOyRcuJuecnNUpnm/hTyk9vZ1ZedX+LelWzuAeNvz5ajUeWG?=
 =?us-ascii?Q?DDMEI4n53J28cjWCIMNSDNZYsLwb0y/bpyNKsDIN9bBEG0DXcwvi1VQZxjwr?=
 =?us-ascii?Q?dgA9lPMddJ7uLMBj2an2srq4ENQcwg95cF7YEBDo77Tn2kJvVQEcRVPFQEZy?=
 =?us-ascii?Q?d3vNTp0HGq01GkrncvcoBnuNjYqN2zGn8CEj/63J3thhUcMff+Zu4QEvg2EC?=
 =?us-ascii?Q?kB40b5WS5QPONPqn2OoeWo0G8SDXQGUM4Sxsqxofq7qf4w3WCMxcI3A8uTKU?=
 =?us-ascii?Q?XXUJfMFVO64tphhr3WT5RnvLKJPYwEkNSrU5QMoCAcBZsPRMGvYDA1pgOZ6x?=
 =?us-ascii?Q?QSHUg/CRMw+sxv0sy44XU9OGhNaUuCJuLoJgtoi83/FTGUW7Vhd2oF0TBE7E?=
 =?us-ascii?Q?AmENNhRRQMnXzkXa7a38xH8cW4UsQWWAAd5ijTv1pk6WbtmVV1WS+4YMMg+o?=
 =?us-ascii?Q?9r+bPglcv6Guo4Ze9Jl+nGDOELxggkWmaN+RPYb7C7q0qwdDI7n+i2asJzy6?=
 =?us-ascii?Q?E6iI1dzWBcA0b3ezgIThgFlKyBYNB2iwFKvs6SZkt0Y3ZKlW9rBB5ciISFj0?=
 =?us-ascii?Q?Dlf44rapOg/HBwAQljF/8iaVhL5AkuyDWadyeUOb9QnDxN+s0hKRX6Jjr0NX?=
 =?us-ascii?Q?RKm9Hk4FtKrC0l59tx/TES/8FHjHqf8e5SIRAtdBmFL0cf3O23QbsbkZp2J/?=
 =?us-ascii?Q?DFwFnc/+LjTbTbJZEqINzewhz1c8Io8EnYOb0/aiq05tj+lKAytSeM5sccdn?=
 =?us-ascii?Q?MiHK+slaku5Q00iTLD6QpF/FxOhKgJz0fblQJPnZx3I3AAZqbeHHYjLVh7Te?=
 =?us-ascii?Q?8RylPqDwvnrwomUAqaqnMHgNzWbToyx2FIMVuV2eRhQU4QR87YJfg5uMPC3M?=
 =?us-ascii?Q?1/6cO/DSM7CgWcKTygqjv/3GkeMXa9oChauZRhAao3z6uNV2/KLesDifXlZL?=
 =?us-ascii?Q?AkL2KRiYy21+d3Ei+esG5mTfnKmN5iIX1Rb5GXCSYhG6XO2UxAg0wkLj30DV?=
 =?us-ascii?Q?753xhJW0nzo8YMpTZhy+A6NnU8eQKeYa8bdTzENPIV/H8nh4hczA2yy+TnhH?=
 =?us-ascii?Q?/hi+YcxVDgRQWrVlspFp6vsHveD2UneK3q3qM9LbJkOojnD+343qRfYNM5KX?=
 =?us-ascii?Q?lie+nggFireWhb6Po8BnDyHuAvyqoUlK5L9XGGivM4r+eqKa40+KpynBAhwF?=
 =?us-ascii?Q?FUCCm8pn2/NxHk16DTGYRFtaDe2q6VZ7XGxdXa0I49l640kKCf4FZJF1Mjlt?=
 =?us-ascii?Q?uI255uyKK7iBUdlguToHB3+bWhwcFm4SR253ySJzTM47r4KVQAbnjtaeEXDR?=
 =?us-ascii?Q?UjTCJDkPrTEQaPIXdIM79CNEXHhtM+bzTp6nP1oNVI/uO9LE3w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e97ca3-d5d5-4e85-0f8f-08df37618c01
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 15:13:42.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

This series adds support for the FDC1004 4-channel I2C capacitive sensor.
This sensor can report single-ended measurements of any one of its
channels, as well as differential measurements between any pair
of them. It has a measurement range of +-15 pF and a resolution of 0.5 fF.

Patch 1 prepares iio_format_value to handle IIO_VAL_DECIMAL64_* formats
introduced in Patch 2.
Patch 2 adds higher-precision IIO_VAL_DECIMAL64_* formats, used
in the driver.
Patch 3 adds the devicetree bindings.
Patch 4 adds the driver itself.

Tested with the sensor connected over an i2c-tiny-usb adapter.

---
Changes in v4:
- Patch 1
  - Moved the floor(log10(S64_MAX)) constant to iio.h, renamed it to IIO_INTLOG10_S64_MAX
  - Added corresponding floor(log10(U64_MAX)) constant

- Patch 4
  - Added "select REGMAP_I2C" to Kconfig
  - Style/whitespace tweaks

- Link to v3: https://lore.kernel.org/SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com

---
Changes in v3:

Split Patch 1 into two patches.

- Patch 1
  - Expanded the comment above abs_s64_no_overflow()

- Patch 4 (previously Patch 3)
  - Added comment on what a negative capacitance bias is used for
  - Reduced some line lengths by introducing a variable with a short name
  - Joined consecutive assignments into single ones
  - Fixed indentation

- Link to v2: https://lore.kernel.org/SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com/

---
Changes in v2:
- Patch 1
  - Added tests
  - Fixed overflow in iio_format_value on 10^scale and UB on abs(LLONG_MIN)
- Patch 2
  - Made the power supply mandatory
- Patch 3
  - Switched from direct I2C calls to regmap
  - Added of device table
  - Removed scan indexes
  - Build up complex values incrementally
  - Adjusted list of includes
  - More designed initializers
  - Various style/whitespace tweaks

- Link to v1: https://lore.kernel.org/SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com

---
Victor Chernyakin (4):
  iio: prepare iio_format_value to handle higher-precision
    IIO_VAL_DECIMAL64_* formats
  iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
  dt-bindings: iio: cdc: add Texas Instruments FDC1004
  iio: cdc: add Texas Instruments FDC1004 driver

 .../bindings/iio/cdc/ti,fdc1004.yaml          |  46 ++
 MAINTAINERS                                   |   6 +
 drivers/iio/cdc/Kconfig                       |  11 +
 drivers/iio/cdc/Makefile                      |   1 +
 drivers/iio/cdc/fdc1004.c                     | 490 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  30 +-
 drivers/iio/test/iio-test-format.c            |  16 +
 include/linux/iio/iio.h                       |   3 +
 include/linux/iio/types.h                     |   3 +
 9 files changed, 602 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
 create mode 100644 drivers/iio/cdc/fdc1004.c

-- 
2.53.0

