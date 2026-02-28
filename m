Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023140.outbound.protection.outlook.com [40.107.44.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47886322B6F;
	Sat, 28 Feb 2026 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261939; cv=fail; b=qwM0CNWo5EULWfooGzaqE/ddAPd1uVGo/je6k1eVa8uWa+GzmDob8NGXOgO54Z2kRaB8DCB4cLGp/sUgmY2+8Ngp4fdP3z5h6LVySTJ7XlX96oq9LzO46vYu85cSecSYWhF9peqLyFodLpMETu6Rsojbkh7fvDh7nprEho8I1Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261939; c=relaxed/simple;
	bh=hzUBkv3cdLIw8BTay1V8Zj1CR3imQ8AObFsq7gN8ivc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=exrg2g8hUdkurkb4PsBnAoNf6/1sHQsgk5eb4sCM1rc/JeK8NiD29np9NqH1bIB0b2dO+HDM/ecC+9vrp0i7ySXAvZbw6DZ/9VrP1LS6lPijUwvN6lMKbMeGmDRHqoYgir3pKWSIkbCUMwaoCVeISNFPT6I9LAxM9YUGVyjCBao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=40.107.44.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GA8C/gx/VgZim45o1FHa0knHmAbRc9c9W9bXT6a0kiYv6KEoYqByLwiFISW8vTjNsucX/xAgZLWSfuMKiksjvoyIcJ21dAl2AE9+9Kg5j1fP7Tat2Wun3VEyalCjYulq9z8r6x351v3lqnxKgoSgR1SnqkSBkzGMlCo2wHQV6M506/R7LVrQKo2FF9ZUSWYZo9AHyJwZ9zo/QQm9yPCF+83hRS+Qq4ylGL4y6OjBlHnVIFAaMmA2aNLVhDS7WVrXwNaXN/QL6UNf5AVpa87mRXJsK0gLNrFFFdtUrGIk8fmQQidcIvKlcWOAofZ7F1jH/SXWuhZsazeFHbmbuOTtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPrlDzf+xVPa9e7rjlS6DxTqLacHiB752dPJV77m5Rw=;
 b=NUsxEeDTckUh/TDUw88SBJU436PhH6ILX85SLwv4sf9MNzCq2NCWGY6XWAdqsMRwbpHzIAjGmNlBWZOxCmTHwx9wDEKCVh794URsXQkl5aU/lUzeHcLy2ocEjBX+2dpdw/Hv3H6ggD8CDgpgaNyGo82TqGoTGmfdmex7sGQUHYex4DJxuxM/ARSTzaZ6uAadO/3DkKs44OTWfKxdQeoBEK92fBbKUGAgtZmXR0eM2d6m/tNzXHiCMFh8QGKAcLPyS+FImfL4F8Jk7SWig9W3+rmVAVMLgZr4YFhUK/0yBKu0MTbaim2k8S0qUHJDWfbzouUQboZkH7E3YVEz4E2w4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by SEYPR03MB6722.apcprd03.prod.outlook.com (2603:1096:101:6a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Sat, 28 Feb
 2026 06:58:56 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 06:58:56 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xieqinick@gmail.com,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v1 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add S4 compatible
Date: Sat, 28 Feb 2026 14:58:37 +0800
Message-Id: <20260228065840.702651-2-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228065840.702651-1-nick@khadas.com>
References: <20260228065840.702651-1-nick@khadas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:372::11) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|SEYPR03MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: dda46485-3173-43bc-480b-08de7696d770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	xx9OgWf6bSoXkyHIhcCIGUOAM3eYRVLSqfOvOyy9tCyFg5GJN8wklhsz+a9bMQKrOKD9aiiXnbIdx40AJDDZEmDPV/YJv9go4GBiInKd4XYPgDeXmXOmh6QwEiyT5gh194I+IDDR0Kr2jiCNKV4DWraDoWOEs16MgnMEqSU4ySLQD9pZVhyHnzTSkiTpOfW10weI7qcFtHYjQ7I6YF8oW7EpYKW86vSihIe3ZQaVWiFpiDMNWt+wV05GmEooxiAF3hFCI0AUILdYV37Pc/l8/4AoU0TBd2upElTJL3MYUd8i2TU1vrzbEsBgn4YG+cdygoE7GAShoYtZUr0+DKK6lBGtJUPKI1LyId18VlHYMu/kyxcuLXZ0BJ4NPd5OS1SYayxKraCFFqwHOr+J8DfnxXzLMDrbZpW5qXG6Bku7tEXey+Rlw3O10DPNa1QcOwVmlRjxKIATl1WrD/e4bREJhF5bGJnpP8ac9MEcj7Sc0/z7txHYiUbYJqZGtfzh1ceH8jdBescQMtcKutHvLUl4+nmsvUaIMwzSvnKLMDmMM5bbiXh5eQQK04Sf3zvdK9lo67+tpa/Hh8YgEbW7IvNmd2o/HvTj2K78rCDhtlxMxE4a3ZkjYn0z0rhauCSewsLuzbu4VEhsbDpqG4sR6F82ic4ZwpDi7TAijiPkudl1X+85nxXH1jtdvmgpvUj/LaTwXNUt6qV3OJtsEVwFxlVXvp1gXHmQuztcBRKFXacWEExZcVfi1EHlXfBpJOofjIzGBcnP7tzjfdo9glnqYxZ1GTNnHXWv3vY6eoowv24tg5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hGFODWfIS7OhJCFYfSeNGn97qhw0PusMTLENmpGIc0vow6CvHK7e8/JXi8HW?=
 =?us-ascii?Q?2tMprxEDDxtdjaJZJ5XDPtGFB9VS8PDc/zXGpAl6SXPYFSvbcWUYr8P4Fyp1?=
 =?us-ascii?Q?1EFo8hE9OYupB+W1tkT+P+DVpU5FX3ToUhlLMnKF9L3vCxdY93sYHMTtDFZi?=
 =?us-ascii?Q?J9ubgumsI+KdHq8inBaAG7aNzkPN76v7sE7C8vRzC52u4vmR0k+EOvVtG/JK?=
 =?us-ascii?Q?NwAiHKylBU02AFTSAiYMpHcu6qsgeTEvAnQsrQ7HMSG1xIat6nIGMzRNogRN?=
 =?us-ascii?Q?1mZs6N1PFOUyBiJEJHHTRrjUfi8gk78jDousQpcKwl5M032gb+/YNLMQOGhf?=
 =?us-ascii?Q?MsvXn6l4/ac7Subf7PydDfMltq8bihDzEmKQMEKeA6zj6MdVosjG5sypZYPL?=
 =?us-ascii?Q?maPEPEvL1xLpv1K1qELq/aNQgQ8q3nPql1MUVjfUCP/cGQeSqSvuATuul2AY?=
 =?us-ascii?Q?zXAPVq5NgWPIAwqS4q68HeOq94f1jrFqFU1i1ikWchdIfD61dEFhFm9AFu1B?=
 =?us-ascii?Q?8R0eciQXe8pyNzuxEVyK9V+vCziloky7QShs+UQLJ9077sj80sGQcM3h1Yh5?=
 =?us-ascii?Q?m94+l3ZMsdWtTjUPN0b+wDX7MP6BC52C9F9ZjWpo4h5iVXcO8ggc/7aOVR8o?=
 =?us-ascii?Q?D/pzcLyFW8eHhGVl6bzV4sf4X55j1u+7ZLYqmPhl2Qz+yB0TK0Ll4f3AH7Nw?=
 =?us-ascii?Q?fsaA4x+jMX8ZhV12nYxcJLTIKpc1SqdZek3PQNpDCWEAb739N5kvJKjX5Kv8?=
 =?us-ascii?Q?xx7CIuweyDoxruaAxvgLv8PJAs+LSpbC0L1fkNB1+aO8umztcZ8hPAtjn4a4?=
 =?us-ascii?Q?VYc29LwiDXEfzgJr+UpRBWo9yupEsQO0JFekF+mEA8FVjGxtYnpLOUmIEXGo?=
 =?us-ascii?Q?82iVLBUcrKHHx2nkp5BWJjeNgMGRcZk6X2ZO61CQnfoh/3rlTCXoFOMnlJaI?=
 =?us-ascii?Q?6Z2sbiXHn8Hu6N5ZiE4qz51q/wiZ9fqwnWzj++tFCuHfMwExAPaa2udg2Dhk?=
 =?us-ascii?Q?qrZkL0F6RHeci6EyVIcCzn2oBv7ApSBnlmSJLZjlI+gaxQinjn4MZiMGB5h/?=
 =?us-ascii?Q?761MH6HOyJebqNfOyf5X2crx8Vcy9G8gGwWJp5nW2YGsz3WZKBzUdRMZ17Y8?=
 =?us-ascii?Q?j4W0JdNXhw11sJAHOhvdFmCJeBlsqDMh0PnkGRozoWvM4y0M463+XKTUDnBk?=
 =?us-ascii?Q?WrVNKkynZs2DZ8ZmeZhScJAnd3g+F/aXLgsdyN8gUai9qza84+cTevxg28Uv?=
 =?us-ascii?Q?JPsFQIhnKA+O3tghT58RFunJyNj/jk2gYi9wDNlzbrm064TiDjwNKwYejAWK?=
 =?us-ascii?Q?9L424YfPkfFnnCl7nNQi7tWtd3ffTD/kuhmFjk9PSSB6uplzlMiGkiA4RaRk?=
 =?us-ascii?Q?ZpH8IHmR1lrikibHvrIaInhpz3BIcJTQoGjlfkKaPn8doppOoi1Mb5BGGFvl?=
 =?us-ascii?Q?Bfe08FWlpWJVn4esmtvH7RGziIB+/IETJpd+nr1c2Yv7aEQtdy06ek9Xr/B7?=
 =?us-ascii?Q?EcS6tKFYvyESLQ/7+nHcIYOFYTu9BHYJstqFLsBRJcRyZur63wvtxWTI0olt?=
 =?us-ascii?Q?09Rcn/eNEJ2Cxq9nGicdyQjM17U6CIHDODWpq1nC4ipR5uMEqIjY16lq+a63?=
 =?us-ascii?Q?qFO8by/QlRkodNe+eWITiteP59igQhNXnceOvHrBS33p54k7beSlw3vkEa3o?=
 =?us-ascii?Q?avl53qABjrcbjFGoosIP1is852C1HHOE3i6jzDQBo1z42/pu?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda46485-3173-43bc-480b-08de7696d770
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 06:58:56.7059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmFmZmJ1vZ8UQ7jEQ3fLPS6V3kDovOy1Ac4kkvj5DE5XK9H4cj590mzzxOIzFMQp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6722

Add the compatible string for the SARADC (Successive Approximation
Register ADC) IP block found in the Amlogic Meson S4 SoC.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
index bb9825e7346dd..5496a0dc714aa 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
@@ -27,6 +27,7 @@ properties:
               - amlogic,meson-gxm-saradc
               - amlogic,meson-axg-saradc
               - amlogic,meson-g12a-saradc
+              - amlogic,meson-s4-saradc
           - const: amlogic,meson-saradc
 
   reg:
-- 
2.34.1

