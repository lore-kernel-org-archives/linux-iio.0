Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021125.outbound.protection.outlook.com [52.101.70.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9B3033F5;
	Mon,  9 Feb 2026 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621881; cv=fail; b=sUlfOcKvVwYGgARR0qNULVRCcHe/sR2r7Ui1SIQv35TGpjlSrm4ydAo99wVfvuXWQHaYMNoNMV+ktyqIj7nh5rOE69nHynkTEq6K23YiFS2CBtX6pbAnRON0LyZvLYtQnIuJlz9UzWTsOK47G4hZQE0GSIRubCiiRAJFlT2BYJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621881; c=relaxed/simple;
	bh=4R3CbXIJt8BnGLTDSxrf9xDvTq4OlMg0bESsIne8SeI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OtMo3j4cHJK+jVPZvMCYmFNgc/e6gINPNDj9OZv4jalS/0Nw5QZ2ofZChzCNU+qJTXkOAnUQ4vNj3j28RpKDhb6AU4EBY7fE9OzUbtxCCGYxEnqH+JDPyD9ewbxH6m3L1mnL0tc60rTpcBcD2tseyJoZkteksEvTKBiAui7vx+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=GirUtIBg; arc=fail smtp.client-ip=52.101.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="GirUtIBg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF5azYKaD/zPSjaEOcT3Ei1roJXXK1my+1k6NWOJW1cOTfwxXvWskPqW/Gmp0J6gG4rj5O/6IdOMyIL2lf6qhxq1PwEXW4arIUXfh6QTHL3jNMWiYILDn5MyH8xa9kAkp102w+7tt3sywI1ruLEZtJ179cSrMNCDLQWtm4gnvHW2/h2BEXMk2fzysCIuKFfuxIpwojvDih3cTLKzmx1A1/xWCzRbcxVFKoqx6sbGt2H8BafRWkdN5oGTlD4PMbWd866IyO3cvwtiWXMJSt6AZ8e3xr3dPOZ9CdFBKb7LK2IKbUr1yHxSbgLjnRR2n0yLThP+cCkIke1TwMxhjP279w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+vlM/sgHqvDn+FgJ15vLxR3Ip0GQ+jSonSBxES59Nc=;
 b=p3U5CrqEF1x1o8ZVbz2eRfSA7OukHCe4LbT8mVROfJGyhP633NadnOpJjweS6fe8RqSMVEKkY21MlwWq+TGjyWQePuf5jwSYWHbMI48y331WQnhQHg2STTZ/FEGemudmbeHxdG6hLrKC2BYqaqwT928IrdGpSAQ/VE9C6DVJA/cCZzBXAlimzt4GDYpo5O5K6Tuav3N8XZgHMK7VXzUEphDEcgLLV88BBbYI2hZcV6H+uFqK9lPPWu0QIF/h40IAvzN4+UDW5aC1JUJgccLZVpmx5VGMzGY7EXI5lUYQCxOhEFJ7ccyAvNA2m6iG16hn88cPufD7JonWWW9g1JYeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+vlM/sgHqvDn+FgJ15vLxR3Ip0GQ+jSonSBxES59Nc=;
 b=GirUtIBgPujGWKsyoWOB5hVXEyvd5n27vaUXRswbzURqfeCgY2pyBxMuUGN3jwfSbKroUdTJgzIq9GBgTejSA+nPc1sZ5blzytIZABzOOzj/dUcRMb5U7L42befk/tdrBlV+rNzn5Oj7cSNlpeVf8eGkqfDT4IPyQhIuzLNn2N2cxRIO9LkdWn3U8qlt3dJWGx49FQww////ZC/TjRRu8EBgfGb/OgRF7E+c0XInlqFl7iTQXhO27ujfJTHz+DBfQwDwWWGM3tbzSi+6o6V2Z2krdE7vf7BVe2M44ZJFFvAeo9VxfV6yoC69NLXOf00GtepjDS5C8/P8lNSEXRuI1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA1PR06MB9251.eurprd06.prod.outlook.com (2603:10a6:102:464::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:24:36 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 07:24:36 +0000
Message-ID: <56254198-c45d-427b-bcfb-fa9c60f11e71@vaisala.com>
Date: Mon, 9 Feb 2026 09:24:09 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
 <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
 <aYTGkAf7Ue7goDnw@smile.fi.intel.com>
Content-Language: en-US
In-Reply-To: <aYTGkAf7Ue7goDnw@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::9) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA1PR06MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 550515d8-8321-439a-97bb-08de67ac4784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzdpVFN3WVFsTGRmNFR1ckpaU1dMUGdHQWU4d2ZKMFRCZFcrR29LN2hMd1Y0?=
 =?utf-8?B?N2FNU3JtZDl0Y0JQUTFzZlo5Q2hxM1lsSkFpVjZ6MHJBaVFjK2RVSVVuUkxM?=
 =?utf-8?B?dmowS3VzM0h5N0xPeTlaTkhkQVVMeFFQU0JMTnJ1QkxvRkR3NU1xS0hkNGpu?=
 =?utf-8?B?TVVjc3g0cXRNZGlUQ2lKRFQrUEUzbWR0bHpTMXZ5eUdWTXc1RVlUM0VrenlO?=
 =?utf-8?B?Qkl6V1pBTEhIaDIycHRuTENrbWRQNFN0dzFReXo0YXo1LzllTTlHdW9ud1RY?=
 =?utf-8?B?Ukc3SEdHVkR3Y0NmOVlsNHBaUnZWYlhRbTBUUXFST1ZvRlJSQlJXOWdZUUdr?=
 =?utf-8?B?Q1V5ZUFCOUtjUFNkWEFGUVRKLy9ZRFlTbnJwUndmWDRRVFAwT1ZYUVZhS08z?=
 =?utf-8?B?R1lZN0x1RHhjZG80SW1xMDBRVGJ5TjVETHRVai9DZjh5RG1jUzR1UUF0UW9t?=
 =?utf-8?B?R1JKK2tNbXFCdUsxUTN6NDd4Q2o4RkVTQngrR0g1UjA2Z1VVbkFVTlYrclBr?=
 =?utf-8?B?VE04ZnVwcDNaaUFNMitTK0dmdFJBSEpCVW5uY3l3ZGFOY1IzeXRWWG5WNFV5?=
 =?utf-8?B?SmJSeUdkWDB0eFE0M0ptM2lmR3BLdStSVlFyUmErQVZNWVhYRlhQNDZhbFhB?=
 =?utf-8?B?UkljWkRZQU5PdFppZ0lqcFBGaHozYzJjWDI3MUk0d0RTTmZTRzA5RkFiK1A5?=
 =?utf-8?B?UHFOa0U2NGVDN0F1dFlTRTIydnVlZ1hPcW1wV21XbzN0eEtkQnU3a1dSTGlU?=
 =?utf-8?B?TDQwUDdpeE1HVlVDY1VLMVlPOHNLNDZ5Q1BrcnpWV0hRSzcyWC9yTkFMNFRZ?=
 =?utf-8?B?aFZvMlVVd0Myb254V2crUkZvUlZMNDVDZVVRdWY1TDVIZk5ZQXpTbXEyby9N?=
 =?utf-8?B?aC9MTXR1dE42dWY2a1RRN2Q5S00yem5MSG91OVRvVTNITnVuN1dpK0lybUdo?=
 =?utf-8?B?U3R6OTlNZDkyWGJGOU5zVHpYNzg3RjRKTUNxYkMrL3NRRk9oK2xTMTNDK0FN?=
 =?utf-8?B?aGVZYzlkeXNBbFNPVE1zNHIzZmIxMHZnOWYzQVhac1RoVWkvTjcyUm1nWkFo?=
 =?utf-8?B?U2JJU1ZQR3pWWFZPSzNJWHZ3ZkVkeXRaMmJkWjdvRmhWNHA4OXlTWHRCRnRT?=
 =?utf-8?B?MENmOWIwUTNoUnlrNFkrRkZ4OW80dWttWmo2ZVFNSlI1bFhsb3NubTN5b01n?=
 =?utf-8?B?RC9ZcUR2QXVUZHNTVExWc0EwQm85dUhFQmZGWFlxSDFTTnRDdDB6Mkp3dExI?=
 =?utf-8?B?ZlhseUljTm9EVU4za3dzb3RrOGpKTitkSnpHYnh5aEFzK3VYaHB1SDFaamdN?=
 =?utf-8?B?UGFVMnZvS3F1dFBtN3FnZjFPVjVYcUVGTXI2MGd3aHhGZ3cxaWxBZVpDckd1?=
 =?utf-8?B?YndUejIzZzBjS0pFZGNrVUhsVXlHdFVVRDIrc1BJdEZ6UFpNT09NL3hyUW9E?=
 =?utf-8?B?ZFNNd1kwRHdZWC8vYnJCRWVreFhtbGZtS1cyRkVnbFJNQktuK0VvUDhMUVFm?=
 =?utf-8?B?bGJUU2l1bmFsbGhIa1NMeUo3Tmd0RGZ5YjJJVFZlaDRzZTE5VGZKbjhPU2Q4?=
 =?utf-8?B?bzVPQWw1VzkwNzI3VGgzaXZ4ZnNSZ3RRLzVENjV4MnhMU0N0MkZ3MWJsWHdL?=
 =?utf-8?B?aUVaVjZhbklHMVc2TDJRa0ZBa1Q2d3JRRisySFc5YzJ2L0Y3aGpaUGdGdnRY?=
 =?utf-8?B?SGYvRktmT1lyQjVQcUNCTnRCQWRXR29CZnN5bzJVOUpuSHFmeVUyT0lhaEU4?=
 =?utf-8?B?ZURGZ2xoM1lhdlp4eXhRVlNHQzgwdmR6TU5RNGN4M21odjk0QlAvaTJCRy8z?=
 =?utf-8?B?TVZsQi9JeFl4MkVXcGltbTZhUlRtQzVqcnlGLzh5alI3cTNPNjFrRytXUWs1?=
 =?utf-8?B?TlA0N2dGazhBaVlDbGpaeHI3QkZ6VzdZRHRUSjF1REU3Wnh1cjlaS1EyY1RW?=
 =?utf-8?B?SmM4YUp6M3RTRUtic2MvT1hoKzZsMmNpN2MxZnY5UnNja2JkWmZaQlJtZEVN?=
 =?utf-8?B?bkUzN1RJdVo1cTlBM1c1SGFaampTMzVUYzZCemRtNjM2ZU9TWHU4cyt1WEdD?=
 =?utf-8?B?bXozTm9rbHMwa1YwNkVYZWthMXM1UlZkcTRvazJlWXRRUFAyeVpTbVlqTXNl?=
 =?utf-8?Q?PLLA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVpXa0t6YmpLMW5vemE4UlIvT2M0OS9YdStsMHZYZnZLNWhNT05iTTJya0hp?=
 =?utf-8?B?ZFJIUUJXM3NmeEkvZy9tN3Z3M3hiQk5LUDF0M1ZQN1NRaFVlWWhCcVJlMFdn?=
 =?utf-8?B?WVNFTGtiR3VKV0QrQWN0LzZiVEpoRzNjT0JnUHUvNTFvL1FaRE0rWnFCbUZC?=
 =?utf-8?B?dTlSNTV5MTc4dlpJS1duR1czNndPVFY5MmFCeVNYdTBCY01uemJ5N0pQRzNE?=
 =?utf-8?B?UTBvSlhzbit3U0I0VEh6UHN6d2wrUkVpYU5YWkFHT3Z2TTJWWWdpWHdyczlJ?=
 =?utf-8?B?REhrZzhXdWl4blZWOTkzVW96MS9nRTQ5ZEhpaG9Zb25kdmtab3V0d3NKTWlh?=
 =?utf-8?B?a3BkRHd2emYyamx3NjJsRmNpN0hMRlJtcFY3MTVudUhaTjljOFZIaVlTcklu?=
 =?utf-8?B?d2VmVytCekhJc2VOeFJQZkY3SlkyalB4TWlYei9tMTN4UjZzdldTRGxjdnJr?=
 =?utf-8?B?ajRlU09RVHd5cTVLSTIvbjV2TWg0QXB0R214TWxPSkJtWHJyd1g3ZXQyVUlk?=
 =?utf-8?B?YVM3dXg2bVZ5K1J1N0RZREtBMlY5RnJqano2Tk92bDBsK2M5M3JwbHN2Tk9v?=
 =?utf-8?B?d21vNmZkdGJQa29GZTNKbW0yeHVsclVoWGg0Yk5ydnErSkZKcUJ6RUJYZDly?=
 =?utf-8?B?Nkpoazg5UkxWT01FM3lsTkdSS1ZabzlmTWFDZkhyeHhHN0ZEdWhRSEE0Y1BQ?=
 =?utf-8?B?Qzl6STVCcEcyeE1JM3hFNzUwWEEwWlVmUjc0aGJteEhIVUwyY2Y3THVudkpk?=
 =?utf-8?B?YXhEeFBaUzRzUjd4cmgxekZQM1VWTzNGVEl2NW0xUkJaQ09wSGNMZ3d3QlNW?=
 =?utf-8?B?eVNKRS91RnlOYXpjWkhYS0FMSE9KUjRoTWNFTGlLZ0VtclJ0V1FyZUNMRktR?=
 =?utf-8?B?NFdaSzRsWDZDSmdKV0pqdkdPMDJnbS8yREd2QTQ4ZkVucGt1OEJNcFc5bWp4?=
 =?utf-8?B?aC9pNVhValJZUUt6aE1uZDVvSTgvQitUa3VqUWhwdkJzeDR1VVRhV3JTN3lo?=
 =?utf-8?B?SWRIQ3VVZ2JldTRKeEd2VDVZSU9DK09TeklmNHJQRnhCUXd3ZXo3cXZnSTJK?=
 =?utf-8?B?R0VQZEV1NTQ0VDZjdnQybVRoSlllQ1lqNWszV253TVVRZys2dHhOS1VsZGJK?=
 =?utf-8?B?a1BxTE5EcEdaUytlOVZHNzdNdUc2N3JzZlgzL0NWQjNWUDlUazZOUWNDbDRq?=
 =?utf-8?B?K2NTZmFjMndDdEdYTnhJWVhEOXlkNkc3dFB0WU9icmxyMVhLTkd0WVczRGQ0?=
 =?utf-8?B?aWNBaCtzNklhTzJWTEcrRk9ESDNTQ2JNN3FtR0dDb2xxOUFraXJ0SUw4dmJ0?=
 =?utf-8?B?eTFRRytBM1k0UE1jWjJFVTRYUEpPME4ybENwdVlWUVhsbU04WWNLTlJSc1BO?=
 =?utf-8?B?cjZwTjdFMThxWnF1Sk5XN2FhcDIyQ0FWUXZnR1A1eTcyYm16THlPSUN5a3VK?=
 =?utf-8?B?NTZNdktNR1hFSXVKNUllWE5zZGVtSkxkdE00QWpKL1M1SmRqbVV2MUhwZm9J?=
 =?utf-8?B?b28wQlNDRGswbjhUK0xpUGVMN3ZDSlZUK20xUFdHZTU0WnM0VXB5dzNxNnp3?=
 =?utf-8?B?UXZiaWF5d1FtNWVxTTllVUhpekVLOVo1RGJxQXBPZmZzQm05NnpqUUJrUEkr?=
 =?utf-8?B?SENtZTNxT0x5Zzl1bWpsMFRmTC83TDJHcjZYSUFUbEdzaFN2K014dStxMFFE?=
 =?utf-8?B?eHZxYnIrelRTbHY3OCtEcTM1eVN5dksxc3gyYlRHTXRYdkcvV001TDdmVE1Z?=
 =?utf-8?B?cjZJWjM3QzhvQUI4S3ZnckRtWUpTck5CcUJtaTBiV0FOVGEyNlVFVDJlZ2Zl?=
 =?utf-8?B?cThSemo4bDlDa2hpWUZhUTNSR1ViWGlOM2Ztc0lDYnZJVUxVd1VmTVBwQjhF?=
 =?utf-8?B?ci9QZytZSnRYNG92aUhyek5IcGh0ei9maTNxbS9oZmNBRzdxdGhqS0lyNTFZ?=
 =?utf-8?B?T0lSSEZUZjZsZkJ2UUJ5cm8wMVdvVi9UTkN1R2NkbkdWSWtoQWtZRXhmaHg2?=
 =?utf-8?B?OVl3U1drak5VbzlGZHNGR3BQbzNySGg0bmI0UFFyRGYyaWw5enNkaWZVWUVi?=
 =?utf-8?B?UnRtZCtvczJWNTFJMXBHbFdIQzNWbDVtaDRxbEVQZVRkL3ZLQ0g4dnB4bmlQ?=
 =?utf-8?B?R2hFOW5wY0QzZ3dLTUpiaWhLOXJNbGVra09Kbmp5bW9yVkN1UmZOMGo5ZUVG?=
 =?utf-8?B?OUFZUXZXdHlTK2ZrZnNiS21aR1lYeEtOVms1S2xxZnRhcDg2dkJrMzVLRkhq?=
 =?utf-8?B?TUxjTXpkZVJFd0t3TjE2cVpqbkVMeXM3eXVGQzVjVVNkOHJDYjF5WFo4WGpj?=
 =?utf-8?B?VXdDRVlGckgvZDdnWmVVM21iZlpQQ1IrcmpqcEZka3VteDk5czZwRHZmdkFO?=
 =?utf-8?Q?r7iaEW83jUsHfckY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550515d8-8321-439a-97bb-08de67ac4784
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 07:24:36.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeE1IAJW+pK5jOmJ/7TAAm+tMTkHcgLQiPIWCn1frOr6v99Z3RZ/3hlgnymeZVRetrB8cYDwUhQTZWV29LgkhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9251

Hi,

On 05/02/2026 18:34, Andy Shevchenko wrote:
> On Thu, Feb 05, 2026 at 12:24:11PM +0000, Tomas Melin wrote:
>> Add capability checks for operation with backends that do not necessarily
>> support full set of features, but are otherwise compatible with the device.
>> This ensures a fully functional device, but with limited capabilities.
> 
> ...
> 
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
>> +		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
>> +						      indio_dev);
> 
> With
> 
> 	struct device *dev = &spi->dev;
> 
> at the top, this one becomes exactly a 80 character line.
> And in general it will help cleaning up the rest afterwards.

Given it seems it would still be 81 characters long I would like to
leave this change as it also creates a bit of noise.

Thanks,
Tomas


> 
>> +		if (ret)
>> +			return ret;
>> +	}
> 

