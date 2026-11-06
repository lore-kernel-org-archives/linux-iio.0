Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979725;
	b=gtQWfKq5thwJ1djtSnJ5bJHNnUb+dQ+W+VC4aYPLpyWf33W51uoezZbQykHFL+VZdujK
	 QcjtcHlU6/7UGZ+cwnit8HZ6D49d5murTWpyg0Wc6BrKphRicauz2dr144ZHYYrHWbzM3
	 kv6q4ffXwM9GpTjw1yA1ytBAWQi+CUPT6ddoCsOckrYnsKi0AyZob0C+ph0iDnTx42T0+
	 FHMTkLED0W1FgVV6t4tl4dY/BR0k7AVPkUWtK11bYi5LLeT6FN49/LtNYFG8bKsJFQPtE
	 AhG1BzKsXuufCtlAv01wBA54m0fyRSmSQikhcSgA+iB5s3mjU2szIuv/BDV9U/xfSnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979725;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
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
	bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
	b=VkcR1lG2Yo19J8I9H8Cg3Qdp5d6nV1FaByZ+GXui1vurETstrK0oKLNuXaR3CIQSdEZt
	 pRN/U5aoqSIU5u19/I3J8nzF2g0oXNR1KP9+Y1TrtSLAjjGXyIZKEoVlncAUV9ho4EzMk
	 kVs9V+dObb/LpQRdtaqy0lFXzuAmMw3evzo/Enb9r9KE17MmeSXo670Tq/ZpgYyB+TNIg
	 CVydysVYBsfg+9FgDbo+vGwgOnP9YagrzLX75Ep9yafGNReExyyIX+s/hOtV6V+4gQLYU
	 E/6a6iaSNDZRFB16hYELWtYGuemINvo7WyHS2CqMWNBdJ2NJDl1GsVweY1LIPlb12DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=uLRzIvqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010020.outbound.protection.outlook.com [52.103.13.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCB606A335;
	Fri,  6 Nov 2026 15:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5DCB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=uLRzIvqY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkVH/ATY9/XvakvuJlttg1Eug1am5VsKXkr7MtOYA+12nLAAn5ZVc/7OWBemSK6iQVh7t1gsKUhAbDcpkZPY1jCB2txl6So3Dybj+ARnWkmrzExSug8oshJ/OHFWOUyKuJCLkLUFK49fW9qBoEBgi5/CG3CtoVf/fN2nt6o13BsNbHMnoX9eghFy6GLtZziyRCGawP96dopA6+cF7qng4wZxy9Eo3W9L2wDVbY+qJJ/AA7/r8XmYmfPmeU67fY3d0MR+l+D7v/AM1gpgB6S7obWo4Eqeod7vgokl85+QrDZ/MOWqMbOEOjIMy9VFCznikDKvdwzd0i4v48fMsqodlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=Bk+V3QsvVIp/xC+RPdh2sgD2cyk1Mly37UwXIRsEvpWOixEmmT1e/Zx7zpWx4NpbYXPlbWmVKewN8fWwzzSVGJIm761oLuU/YhADTVruDdnFVt9kfWF47UnjAqLhGIWKfYIqHmOUPRB9JSV9somXHoLdEd09N3DE/aBjo273dqd7MBXY13fMgGH1v7sb8lrnzpZ+YLEfjMKLWhFMhjj1kl61Zunwha7E+wn+A+/GDEMl/A6HLUDc69q+CaPoRYKZD7T/u8q4F9oUhhqsMZxyhu8NZz+IedttFnNedDbE6SEMPvr7ZYLvyr40nTIUtZ92KqPgi+o0shGtD38ncVkUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=uLRzIvqYOCVu86+aW31YO0INsNGA2OwNwZ0ec9sAdthDEBk5JHg6Odpylpxfb0U+NNNwQk9B2yTsIKEOUbATr6NBNk/NpVyIVTgDRZ7zs42GgPgF88OHcHr8ze0JFMNvkA3Nrvggx5mib+h88ViJeM7AvaUo4X7aGQ9SuiTY3NMNssTPzA4PTqBjYNFsg8MR+gkzxAtlPE7ryJt6HDTUl/Yvhcd/q6u72Q+fOs6YlF0EJH9DSvlBjOJO5n+8nlwKO4u3AVn0zqReuhO20P8jfS2kiTKnJcZqJ9D+7ILgWAUSPqidFjkFk2oGyELdI2yXo7i7SepsKEnCuF5qKjrwNg==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:41:49 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 15:41:49 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v5 2/4] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Fri,  6 Nov 2026 09:40:27 -0600
Message-ID:
 <SN1PR12MB2528AED4BE53440058892509A5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261106154136.804370-3-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d0b9f7-680d-4258-7b41-08df3c1c77e4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|24121999003|22091999003|24021099003|15080799012|260925184616899003|8060799015|19110799012|4140399003|25010399006|440099028|3412199025|53005399003|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K/twPfNVAupC4S3DOsEiuC4BJN1ezsv0Kg44WfDunR6lyzFskxmLlmeEWazu?=
 =?us-ascii?Q?glCp5Kxbv1sXseylAtBmeKbXQNZR87dYQ/wEI+K6So7xQLkoBaxFiEVDuFFy?=
 =?us-ascii?Q?i1fpW0Wc7bkqnQ/XTr4V9adY3EO/TOtKcxIkNU3AO58smrL8HCsk/B2D9lAB?=
 =?us-ascii?Q?dQhoAUE1d/X1y3E5ueIya7sTkrWU+64q8GmaW1wwc44dy3vBYKHkqTN7m4BA?=
 =?us-ascii?Q?AB9BP7w6xGLhlXmiYThDmBZRC9I0p/s0pPYfU597IpidkP/MQ2WUHEThh+cj?=
 =?us-ascii?Q?0ICzYCvHT2hWyps1yTRuN1W7N954qnSoZwkfMNJeG51ckes9NwiTc0kITeaC?=
 =?us-ascii?Q?+JUieBoo2oqVMZOnK9VDmPpnDRK/Rhmt6PsFoHnTaV+408L23ACk3bCSYU2v?=
 =?us-ascii?Q?miUgAxRZaoYipDg44UDZpxpQGRq50vmbhbzeHPdY52rbeQvBhnke8P0MNv5p?=
 =?us-ascii?Q?TsCcIukGEmdXMlMjcagZVoi8NbusubPEacQCUdFr5AMVgudUHOgewOrXwr9B?=
 =?us-ascii?Q?JrGAXbw5CHPtIOg20n+9R8Sr1zNU9q7qoSZbHx+1LQjx7MpEm3FwlRFGt9JR?=
 =?us-ascii?Q?6djiyiSuZ6SOX4bdBSJrR5GxSFukNZDe45HlY+4Y3Ql7qWAHxwkPzfaP2az+?=
 =?us-ascii?Q?T3qMYfw16l8EaTovuN7ifGMkIwc+2fV/z/FQIH9JqPN3xim/eQRvQl0BfVoZ?=
 =?us-ascii?Q?1XKe+dqjRe8E4Y23pdSbQk+ecIDoscjjKm0ooQ2lOcs/LDCjQn5CWekOFpEs?=
 =?us-ascii?Q?FkFRSi0v2VjZoRho2tkjYFVOYwXJIvCQPYyhD8rfFntDBF2DjbPkkub7j84l?=
 =?us-ascii?Q?yiBG/E8Q2HhMsYu5wRi0+u8qo8W+5wZxXIwkPVDWZ0fIvqqalB6Xf70bz4XT?=
 =?us-ascii?Q?VUynyFut5p/kEIF6/e1AUYWFPDFE64yuGFLL3TFR9/3U/sfAggq4eMLh4chm?=
 =?us-ascii?Q?Sk9nl3d1XskOqbjYb01hFPdSNdpk09++1bCxMHPAAWpJHHmNxTrs95XRE9Z+?=
 =?us-ascii?Q?Fshc/IviisITA0LS0qHNZCjwop6ZDNdvdX5p/j/vsNPIs/aFF/PBBKq5vH2W?=
 =?us-ascii?Q?hXYo4/H9?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jPRmas2tZQMDgJh9E8VgbrWVz+IN8Fsn637DN3DDSvkSPI3sSTwTBTEgvWqE?=
 =?us-ascii?Q?R80KTlYRmdeJsr7B+zCERsqaQgOr2Fy/De4/tCTew3jLCnB9cXfqdoQejrEt?=
 =?us-ascii?Q?SmWL51NuanE+Fr9sCbTqWpbOBsE9cH2D7dBlUK+ODOASUQXJta24y+bKu4rV?=
 =?us-ascii?Q?3BZgzANcDyuZRWSWJ2JIrSYBFwWqe+xtT/kRGc5WpfbHaFRXB3zu4IYLkifX?=
 =?us-ascii?Q?2FjMZHJjlSvqN8b1VFkF84LURPf/WI2VXLhezO5LcHN8VkXELIyry4jKbSGl?=
 =?us-ascii?Q?V1/57/4AgtART23SCClBk7mhQ3/W0vS4Tghqqf+YlAJoAsJ1WcgVTOJ1oHS3?=
 =?us-ascii?Q?nfFu33BlbnXCl5PAyC064WpXF/au1f6D4L8ySsb9+zsFWBBpMwMhXyFNhIE8?=
 =?us-ascii?Q?AyGpNBv3PSQeuOqujFKT77fohl7V5v9I30lCQ+9UFzH2ZH578JiUiqsPxQWJ?=
 =?us-ascii?Q?iJm12D5Y258jgorFow8bUVtEt3W2epX8AcZIHrlWZjqVr6sYb3+Z3RzfSNN7?=
 =?us-ascii?Q?wA3Ez080mp6QQkCS1hRXMvGh3HtBv9KnFMombf80ZbIB7WSc+lRoyIwdZRLT?=
 =?us-ascii?Q?GcJNoMIZ1GGoTAst2ChQeZLuQgq7z/g47Irk96Ihl3wxf5ho1fjFFejaGgK2?=
 =?us-ascii?Q?CpNIsWzN26F42mPrZjsgd3IlWXKVePlI8NjkqW0sWcdxq46zNhOFxdJfj6TD?=
 =?us-ascii?Q?9+hJwFzY6dSlTKjDrSbiyfbT+vrjo53iH3fmyirQTmd5l8D/j4dquUhdbwXC?=
 =?us-ascii?Q?yrhMDx2eeYLuCFAJPTza4OibJ3WvOm5iOxHW1Q6yezLhVoquZcXdvKWRRKkJ?=
 =?us-ascii?Q?Ao3gw5kxKi6fSz/ml7A0tcjx+veYUORZi1WHhXLZg53cUrMWDLHiGI3pNkTI?=
 =?us-ascii?Q?sMW2DDTeHad+8fOkYzCCIdIi+gmyyTxSPbmzIMGWWlgtTbDN2lGvOy0RyEbo?=
 =?us-ascii?Q?km4qQYs/x0JcP/St3y/N5t3VMWXtf8uVWZOAU0g83dgOCN4CajycVRgL9UdM?=
 =?us-ascii?Q?icOuDBYoTrGq8waPDkPuBbIaV5t49u62YcfGSMrWzsUVkzOFpdzxCoPcDWbJ?=
 =?us-ascii?Q?zw8SycXg97cFC3C1ozuOucqj/ZE8TUynXxjw8gMT4LLhU9pJvatCQ4AePt/F?=
 =?us-ascii?Q?sCTmrwtPF4VAdLsn3YTMki7ZuQBaJh6UxbZ8NdA9dGUE9YP4IblfBkedSdcE?=
 =?us-ascii?Q?eOEpCh1atNV1oSWFuwI38hHH2o0ubHXDE3XyqS7mVQRRkeBwz0TSOMREr+r6?=
 =?us-ascii?Q?LVrAYzHAxlt8/Qw9vNlMHnMAp3WcxhvuPJz1+mMWGDajDDH0ogMKnCnkFPwH?=
 =?us-ascii?Q?lR29CcVxsJ6bk+ZpvuLFjzT0UAjODofQib6AKV6b1RZZQXpHvNPWdzF3/Cz5?=
 =?us-ascii?Q?a0aKyBiHM2OkVmIxCX9aaf4Sqzid4D6c08ETZilyKQpSik1BCw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d0b9f7-680d-4258-7b41-08df3c1c77e4
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:41:48.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

The highest-precision format IIO has right now is IIO_VAL_DECIMAL64_FEMTO,
which gives 15 decimal digits of precision after the decimal point. This
is not enough for the upcoming TI FDC1004 driver, which needs 22 digits
of precision to exactly express its scale value. This patch adds higher-
precision formats, up to IIO_VAL_DECIMAL64_YOCTO (24 digits of precision).

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/industrialio-core.c    |  6 ++++++
 drivers/iio/test/iio-test-format.c | 16 ++++++++++++++++
 include/linux/iio/types.h          |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 42e92a79d1ee..21594318bb9e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -726,6 +726,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_DECIMAL64_NANO:
 	case IIO_VAL_DECIMAL64_PICO:
 	case IIO_VAL_DECIMAL64_FEMTO:
+	case IIO_VAL_DECIMAL64_ATTO:
+	case IIO_VAL_DECIMAL64_ZEPTO:
+	case IIO_VAL_DECIMAL64_YOCTO:
 	{
 		int scale = type - IIO_VAL_DECIMAL64_BASE;
 		s64 frac;
@@ -1050,6 +1053,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		case IIO_VAL_DECIMAL64_NANO:
 		case IIO_VAL_DECIMAL64_PICO:
 		case IIO_VAL_DECIMAL64_FEMTO:
+		case IIO_VAL_DECIMAL64_ATTO:
+		case IIO_VAL_DECIMAL64_ZEPTO:
+		case IIO_VAL_DECIMAL64_YOCTO:
 			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
 			fallthrough;
 		case IIO_VAL_INT_64:
diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index e5d0a2ac4670..43a80952a50f 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -286,6 +286,14 @@ static void iio_test_iio_format_value_decimal_64(struct kunit *test)
 
 	/* limits */
 	iio_val_s64_decompose(LLONG_MAX, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_YOCTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000009223372036854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_ZEPTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.009223372036854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_ATTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9.223372036854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_FEMTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223.372036854775807\n");
 	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372.036854775807\n");
 	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
@@ -294,6 +302,14 @@ static void iio_test_iio_format_value_decimal_64(struct kunit *test)
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854.775807\n");
 
 	iio_val_s64_decompose(LLONG_MIN, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_YOCTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000009223372036854775808\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_ZEPTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.009223372036854775808\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_ATTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9.223372036854775808\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_FEMTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223.372036854775808\n");
 	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372.036854775808\n");
 	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d8944c9e5e90..2ef9b2a8b119 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -43,6 +43,9 @@ enum iio_event_info {
 #define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
 #define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
 #define IIO_VAL_DECIMAL64_FEMTO		(IIO_VAL_DECIMAL64_BASE + 15)
+#define IIO_VAL_DECIMAL64_ATTO		(IIO_VAL_DECIMAL64_BASE + 18)
+#define IIO_VAL_DECIMAL64_ZEPTO		(IIO_VAL_DECIMAL64_BASE + 21)
+#define IIO_VAL_DECIMAL64_YOCTO		(IIO_VAL_DECIMAL64_BASE + 24)
 
 static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
 {
-- 
2.53.0

