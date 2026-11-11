Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794407051;
	b=SlV+82IxlLbuQ5SGzNicijAfKgQDGCmGgdwaulf4eJeNeVwKbRSoTC8eFbdxmAoShu8F
	 m5WrrtdARoPru+IBjbKSD48v4IgiGCkYYUPbbgnmNEeW2Jsbgz68N6M622OCPpuUm73BE
	 J8MSwfmvgKrxhx+Fdh8Hi7rl5hN07UzsK/wbdPgfYvUPXeMFTJb7OZ1Y9KzfYUHzoIC1P
	 rLO5S0WOXN+7qx82NxY9n1ZlYqu3ItGjIh2ACudYXm/8pB6k3YcZj4W1sOulJ+YAnfuSQ
	 mJssc1OEmXo4erKd4+4JgXpkm3RQmZMO4m3Vj2gYG3v/tc/BefiZzuUnIza7vsXlODg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407051;
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
	bh=S0lcEJInzsdaBAtWmKll4G5pdySo4Nv1+cU5SUBoSBs=;
	b=zXgmReMELqSQ9K+b5yoe+vkrhpUZCInPWAPNgBimDte76F+vQbBeaWE9t0YTu6guF7y0
	 P8Jmiq1J2ozsl6V/H8244RvEVr8Cypm0EV5Om2XyCKnz0d2hM5OZgXwB2CuW2Ts9XrPVP
	 NX6geeIna2Z6uLyhwzBipcyPtMjurc4pOHmrvY8KT8G1uHB7YY5FGWcqrVZB1cMuBPsAc
	 MXqCUSP9iaG9x/W4isp1mr4U7kobDfKA069P5zinlK0vx2AeJh2tBLdI4RuWH0micjR9H
	 vb01mqu/Tg9ct9J4JlEwShy5k1Kyv05TP250/s32PqiNqT0jUqH8cynx4fBZFhu+0Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=qtklzCOB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.23
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010023.outbound.protection.outlook.com [52.103.7.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760BD606A321;
	Wed, 11 Nov 2026 14:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 760BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=qtklzCOB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTSU50+Om+mxk1Q7+NVF5PsL5UKCOM9C1/fs2WqtRlouPEqO5+BdQDZACBcseBz7eln6f7v7JagNbnE8WHb5gEgNMEVr02abBd4IReGQXdnw6WO61bfibYcQJJrleyktdTfcOYbFtALMuVWWErCrOQKayu1CIqU3lagNUXsbZssJpaSW2dpV/OzDkNJSEnCA/I6Z39rLm3dH8/jP/6YtBULy0g8CbfRkLdbsUdjCYi23jNF+hak08lOy6A28Py4FNJKQ4cuaAAWt/fFS+VGVIrYVxTyPx9oytSQ0v01AspqQ+hyoKgeiHenseMt49uRNnM1qezKdQh7HE8NqXkC83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0lcEJInzsdaBAtWmKll4G5pdySo4Nv1+cU5SUBoSBs=;
 b=b83B/u5UHWuNKHTRTSz+QZ301DSNJBAqvXVHT9LYJ20s3p6VmFfoRS5sa/drLAsT2AL1luUoocx3qzwlT68LoKVukhrnP5m5yuRJgYH8w8cmOsJ772ifoRcH8o6bNivAmAjYpXFOFp+UO0jYajcxRWq4c7eU9ObxYJexkdBeYS8TsTQfkru0c1mi4qqzghmpFIy41pOdxSAaWl+6AvsygabnM1w6QOD3vu37YKiLvoc2yXf3wQLRLwx3ym4Kh880HLI87soLYEgxNE4hOoMXayNT0qr3/Xx8hhCnfS8cGin6O9Kw71XOrU2imWBc7gOw0FaaupRGa65DBvhhj5/pUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0lcEJInzsdaBAtWmKll4G5pdySo4Nv1+cU5SUBoSBs=;
 b=qtklzCOBJx/ZFtYP2bTt6RF8U0zSukNkVEUuLCDkXd2+zivW7Geiah1gnPidt4VSOTNfrDTocRMNNqci2IdMOTmkjS8LXCOGT0JN0SFl/9Re+pufmmhQ0i+4NAO81M5hAWfcbW6c0GZL9wNyVWnOEIi9E6UdblqgQuUDV1/iSknZvafpMmBK7ChrYvl6TqkcfRQWsw4j9iVi8XeCNpP2Sjc2hQVQx8Z2y7wCKW+l2en7W4+eyKNgjpr64317RdPQyzWsxXhDQkk68B1qzCIY1/XgbTYBoOxn9s2kF/DGrilQYpI3fubuoYZfa2fQkphzwxJo1IIkxcF5nL4JWOMH6g==
Received: from MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 by LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:24:07 +0000
Received: from MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352]) by MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:24:07 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v9 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Wed, 11 Nov 2026 08:23:53 -0600
Message-ID:
 <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:610:e5::18) To MW2PR12MB2523.namprd12.prod.outlook.com
 (2603:10b6:907:11::22)
X-Microsoft-Original-Message-ID:
 <20261111142358.22099-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: 68adab61-c47c-4360-bbbb-08df3fff71a4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|22141099003|260925184616899003|4140399003|24021099003|25010399006|5072599009|19110799012|5062599005|23021999003|8060799015|15080799012|22091999003|24121999003|39105399006|10035399007|1602099012|40105399003|26121999007|4302099013|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DZoZKJkqLsvHt4OAPxxI2Xp9EdZT6Thmb22C+R2EXw1A2ZZEmLOq55NyQRjZ?=
 =?us-ascii?Q?aJaL/rGPMoO6jXvbpzZPpl7Qd5yWOm3JX2rO13dLKDqOkbz6TSuJd/AZADfT?=
 =?us-ascii?Q?dOD06YmYh6/ax2baLRQsb5LfX8gx4Ve4XxLDMAnLn1mp9l7IU/j33jW+SJPS?=
 =?us-ascii?Q?c+kq+YZxi8S+U89naJi/DPAAogQQhT9OS3lL181XErrymOs+qVEK+22QipNu?=
 =?us-ascii?Q?8KOYbuQktxismT6C0eCgRuJV5pnOE7buVvM0uUs6YxTz9kd1FBb+5kC8LIDP?=
 =?us-ascii?Q?7MjnlrwbX8YS2f0ECrhyKFuBUCsYFtwO6Cff3Z97kwaWDTZY25HA3r4SSvFh?=
 =?us-ascii?Q?Ft7VD0pTwAsIVWxJXrqa6t1Gx0AWkvEdDf9c46/t3yc0fnv66MUXaDiuxrnt?=
 =?us-ascii?Q?T3uRdmUiv3ulEAZP8Wqrg4+5ZNBzIwzXKJU3Yp3D9L/yxhEQYdVKbBXa6E+3?=
 =?us-ascii?Q?2kxZKPAnbgXsRsxqfdRgcgvzVJ6wUwHEisyAnG5lvYBIjDMQOp3Z08Han7ds?=
 =?us-ascii?Q?JjTsJrOsd7umUoFZc5HB8PWYhLSF228e8wGc9b+L44gQCz0EZ463paFmkiYk?=
 =?us-ascii?Q?5Ug95ELGBE3l2pug2Zj0Rx9ZK/GAPZBDyMYU2Hb9tzow+JHbS3Lkk4Jhx3C6?=
 =?us-ascii?Q?mub+/b4DmFNY6JbffvAF6rkIDnlIzkINHtgINJHuLiaEx94Y8cufSmOSvRz+?=
 =?us-ascii?Q?M243loWi8oMdTcjT9noim+rMEi3ScUw4InKhgrwEs7IeF9jKudCuP/Kn65dT?=
 =?us-ascii?Q?fThAZeeQjgryiEMwv4dIFoQ9pGmBZ8/EqzIYXdlodlKmQIkupwTsmKi3YNdt?=
 =?us-ascii?Q?rUphKVaEMcBCbZIVk68Lz3P0CmV55Co8gHJ3vD/PGitiyA6qiC/lAAkrFUax?=
 =?us-ascii?Q?D09iiEB7/XCbvRfi1EQVhFXCx11WAqVqAW4PoSSY6V5lUbseaXn8qhUsGPy8?=
 =?us-ascii?Q?Idg4vprN4xQTAHlof5wKOhyoc8Zcg/Mva6+/iFcyBSzq4IOipZ6Nu2h8yw4j?=
 =?us-ascii?Q?sDmdCD99KV7SRhxgASVQJnm+cA65NtCW+StOotpCDQg910HMy7U5QiyES20M?=
 =?us-ascii?Q?VM6EwD+ZT6VYk+P6qCUCHtGXP5nPT7NAZcHH+MIJ+TCDU2QzhtY+oBWaaOuW?=
 =?us-ascii?Q?hBbTAYMBaqrFNYOIyBEKFV0wBoxzOS3XxLrvWMZUcI2dmbe+3YjX2pA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9NR2gRX/5Yc/W5au8R88GgVqlAOGnmRPJ8SIuelpNux82t5OEM2MVnoqVeK?=
 =?us-ascii?Q?8oFkuW9MOIxHYVzmlIuVB8O5H1OsFa2oXXprQXE/kSO+qUEucVueQaeokzPo?=
 =?us-ascii?Q?ysTFHDS9g6eneNU5Z2bq+mg3bzqfaFhFCMIw8qarwAme902utgznZYxr78E+?=
 =?us-ascii?Q?Jt+uP7ymS6SG1L5EOE9i602Vhj9eAg6IY+CO6HXmscThidEKQdZQuoAGzPeR?=
 =?us-ascii?Q?n7q1IwRcGDHM1U9J55XlD9Tq+ocU2Ft117YMvi6SiyTDrtpCxcgpORp2DYyU?=
 =?us-ascii?Q?jBIuDll7oHdCxVRI8tsZOeDnEkwArz5L0sis0/oYI/QBKH7AL+uWXpBb6LMn?=
 =?us-ascii?Q?ZtKTREdw4eQPjHtNaXsPB5cASUJD2EoXl6UNiw39g+H+0S0HOEnt0OK6h+Mk?=
 =?us-ascii?Q?zfjXASNNIiHuxBEvogH3Mu8ndnWqJK7vz5FubmZsgEEVRJUqlIOW+yT52Nn+?=
 =?us-ascii?Q?ceNny9hFbKUg1o6qV+swkj26TqCUkjjS4PpJq2B2Us5gkVcoITTeuQ+leuwF?=
 =?us-ascii?Q?cbvDZUTSX7KWlHWM3qiaujVWys4+WN9a1HMBEolhl4i9pVdSGkXBg0kPdCXu?=
 =?us-ascii?Q?k2HPEMaXIIRhICqvm5I3HCDA7IGNcvnkEN5W4RuZQJs5RzL4vV8QDmJ3rfUY?=
 =?us-ascii?Q?057WVggXfm6/4vuSy8Hiso/hFwnTrVNobzvnFauCHnj2voT6YhrqXAHtIxOE?=
 =?us-ascii?Q?75h/ulTIi3WWHmDH6FHK+h5LRQCB6r75k8vRbelOxHXCKVvBjAk6GpMX1Wz/?=
 =?us-ascii?Q?bdaOfUd9bzEkHDD5f8o5w9ZA7ohrxaUJD5wlt1b8iR2AoLW3i7fQE9ynFyYQ?=
 =?us-ascii?Q?92aGai6PLHgKI5UvFxEyIxau6lvDJJjk+gAf79SKLOsEMciydGH7eukw3fYY?=
 =?us-ascii?Q?evd+WXF1HPPvkDoO96XYD9vxQBTHYebCGgwc2jRvoapLX2KEw8ZGw7LRaBfB?=
 =?us-ascii?Q?vmnYgcXUwKihpomG0EpdOdiOlG/MLPlJulTkK9BzruNVJJGCgSrFbceCCoVL?=
 =?us-ascii?Q?3x77ejTO42p1tNPA/X1UXvCKH7MhtbetZye6bNCy+q//AEK3hHqTXODPpSkh?=
 =?us-ascii?Q?OuW6U7jg+QEd2Hy5sBWnvVhJvxsWGWZnoZ7T5OV5UoRV9RwUnIaul6/sVb37?=
 =?us-ascii?Q?+umVBNTnukyS72uj5eIIg7RYwhdM6hq0Pr8OFfs6RPtSd+Ltrg5+FF6BmTDT?=
 =?us-ascii?Q?FR3MEO0tj/tFr2Cb0WJdKHbHq7y/3nKM8EAFfM+K7igcciy2zdOOJ4yoYwLf?=
 =?us-ascii?Q?tRTHtBA3mciPSDStctgFKFTi9HHDZTuXKSWxXKYcY6q43CAvWyMice0HkDuO?=
 =?us-ascii?Q?vaQD2qiCf1ueyXc4/Da5uW4A9T4EO9sJE/XC+zAY0qKmBKkUCaEpR9irXdST?=
 =?us-ascii?Q?T24eFAXnI3QqqZmYD0KrIB9AkLBKstm1BqQqBYt8zJ1R5wg+aA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68adab61-c47c-4360-bbbb-08df3fff71a4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:24:06.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB248855

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
Changes in v9:
- Patch 4
  - Added comment explaining why we set use_single_read = true

- Link to v8: https://lore.kernel.org/SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com

---
Changes in v8:
- Patch 4
  - Reverted the cast to (u16) when setting calibbias. Consensus after
    discussion is that it's unnecessary, regmap handles it:
    https://lore.kernel.org/SN1PR12MB2528684E196432864FD48626A5722@SN1PR12MB2528.namprd12.prod.outlook.com

  - Allowed the user to pass an inexact offset value and made the driver
    round it to the closest step.
    Rationale: https://lore.kernel.org/SN1PR12MB2528754241E5C6271A02734FA5722@SN1PR12MB2528.namprd12.prod.outlook.com

- Link to v7: https://lore.kernel.org/SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com

---
Changes in v7:
- Patch 4
  - Set use_single_read instead of use_single_write in regmap config

- Link to v6: https://lore.kernel.org/SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com

---
Changes in v6:
- Patch 4
  - Fixed 32-bit overflow due to assuming long is 64 bits
  - Fixed fdc1004_soft_reset testing 'ret' instead of 'reg_val'
  - Added .use_single_write = true to the regmap config
  - Added cast to (u16) when setting calibbias in fdc1004_write_raw

- Link to v5: https://lore.kernel.org/SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com

---
Changes in v5:
- Patch 4
  - Fixed 32-bit build failure by switching to math64.h division functions

- Link to v4: https://lore.kernel.org/SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com

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
 drivers/iio/cdc/fdc1004.c                     | 494 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  30 +-
 drivers/iio/test/iio-test-format.c            |  16 +
 include/linux/iio/iio.h                       |   3 +
 include/linux/iio/types.h                     |   3 +
 9 files changed, 606 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
 create mode 100644 drivers/iio/cdc/fdc1004.c

-- 
2.53.0

