Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022124.outbound.protection.outlook.com [52.101.126.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE21F875A;
	Mon, 23 Mar 2026 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229701; cv=fail; b=Vt2cuqbv2hcJzq+dGOOTOWYxyCAnvCBXUyYYF6AA9rhTZDMnkqucqlTULG2NUNfEUil+p2jfTU8gjVIkKAgYMMLA5E9j7hXa7WVEj+LRlbtdoAaxC5BK/jd1qAPBc8Gs8skhaUq86ElgqsTFxB8fXGpquVGaA414bURq/tHJDWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229701; c=relaxed/simple;
	bh=EJaXMgc7lP1xP/hbVRjobBlLjZV/jvuU5HEv1gK6k8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q79lmfS8fTnsx9Z6xcxemM70id0g6DG2KQzvtT20DQr8V18pB2+XiYr4/lRP+GaLXcakuIg0+tDQe7rdtSj6fZYNcOJqzM1l2lyd74xE6IpsZodijY6s0L+hqP9z1JT5LgA0+hmr5ydupZ7vbb3ejxpjor9PRdCNQQC4tQOdHIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=52.101.126.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ+okd+l8CwLZV5Do6ANxe51GgNrShBrGTQicypJ+XcQqqX7Ftc4a0Bl9G5JpFZ5Y7nfC6oZoiujLSWDtmCiZoSXb0ofCxy7+9I6fTsVzqbIbiP77+7ErUVGMcbHPmBJwEpqnxT57I+SnxpmJ4r/h3I9cYipERQjaYF/8yhTWxZ4Jlg841JtQtIGdnE4hUgwlZMATvVPY/5uoG17UNS+IUbIWIg1fIGDEzyhSvkaPjwfC5GdSVRY+EOb6Wpl4W9DYJZyL7y3ztcIoupdNJ9f84fOJfrcALStIKo7/RyFCPd/akZL1A7qHDz4NdTz4f9r+WhSv3PSSmL6LPki4wpOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtvUjAvhqJtybZyqnvdeR/sbC0au+HcAv5HgTmfixqE=;
 b=hgj7r4qDtqB0Y12OcoG/4v0RL6h7zg55PUpm33YNhg7HnArlXnCktTwHUPVBcqzNHATfHgvKsNYVf8iNeeus0YslizGU6x5N2VfsihZw6faLdAKPpUreEJhkh28IEVm0mZ2GTIuMnQeCZW8XIOKMptaXep5Tnzie5sNS0s0KEsXGvNOflfA72ivUt2NzJUKvEjJBqH9dEZCm+v2qbbvkHl/ziiS81j0WKhX3tra9EmUsRedSs6z1eB55HzidKR62cNnX7/gr6668nZu3s1400iKSPaM4IWeq5Sm3ys3yRh+HFudKcsbV89Voh+5CseqBjUVIoq/saZxoufoC+2KGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by KL1PR03MB8142.apcprd03.prod.outlook.com (2603:1096:820:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.30; Mon, 23 Mar
 2026 01:34:56 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:34:56 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add S4 compatible
Date: Mon, 23 Mar 2026 09:34:05 +0800
Message-Id: <20260323013408.429701-2-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323013408.429701-1-nick@khadas.com>
References: <20260323013408.429701-1-nick@khadas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|KL1PR03MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e98a543-a157-4ed7-efe7-08de887c63d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KtA0H8FJ+tJgFdtDWNzZ+/QZsotMvTSuw3LJCgSMb96wLgK+chWmLvfEi2t7LblqXx0MnhwB8Wlo0FB7Th+n2lnNkqckWaJH1KC7f4oI4o9QCF55CWMvpZj+zBzDXwX/Q3JgqPMrPRlB+E2ByO811wnUldEHbds5AKr6kbGAz2XCVdwoKq9HsKxEp68LTaCuE5W6JnsU6xr2s5N+sFewwuHhyKwX9+1DgE8aEPV1iVEppbopbws5F1SJo2P+TKGuPo2LFKn3XploWqUzWQUciwj7evO4h+lXZ8IItyq+eIYotw8EsdIMRMYHNJfGwDYbG4XIiPZO0vOiffjo/oFSpmZLZO5iGM2pn58Ntw4cxf72XEeKmG3OKcZ/HXeEHS7Bc5ckSvQ2wgb+CkK3hJxVe/DXqvTfa7c5fsOCvsUbYQvaA/FZIvCvEU9Nz/ZKQNYYifwm/kUe/GMTZWjdFWa9U8UkGcGYdm14emfppo/SziqYs0UbwYuLrHYzklwuKDOMIRseJFCHO9FX7YlFJaJP0Bcs2oaxURqC5u7falpYgojFzA/Ee24/v1+nJhvMMJNp6h28i01sJp6t2J7ftjs/qA3tVsYz8ZBfc1en2GUrrPUKr4SrWiz9aqTNBy9YfEetlbbjQ4NxK+k62x+ws2vusNcrMLERpVOaxZJ2c+9SD6o5dSjhcJ/Vd50ahAIcPLSA4lAs7b5PG4pwpcGy1I9VDrJj4dhGiXBI1GeeiQU9o5TGgEXHIAHuyrdph/FdC1+N22EDzj3k3WQnJOJCQFh4Tb2Go0sQg8w2v9Y+ZjGR9sA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iATqwKePFn2tCdjy9tt6F8ZINK+VawkgBFT8t5uplAf4MC8/TpKqI5beicXX?=
 =?us-ascii?Q?4KmjoTF3SuH8tQ5+mlnYeng745fQMQj4AXZvIDb5g38GHjor2QhTHjaLE91V?=
 =?us-ascii?Q?uNUpLPaClFLCMNAD6GJSUJ2Z54DwUCsjTRNpPrJn+kZvUulTObN94a3AoPOL?=
 =?us-ascii?Q?PDP6nemF5SxXqNjwCxd8yiexg8Nl0kO774bsttUQS/6eG31ql2uE5CuZloDS?=
 =?us-ascii?Q?LZh4jXATauFt6l6/Oq1NoRyq7t3tDqIlY6rGB1mBH8ODGJiTjjRPJBpeLq0d?=
 =?us-ascii?Q?SKzljiez0jj9HMVPyvGANMMMtOOt0UMSECFpBgABQfpMrBxg8K3uTa9+3DDV?=
 =?us-ascii?Q?vCODDJb7+QzjPaf/Rd7DeuBB2ynlMW1kLum9a9MjMVekdLe5Dfv08Zq7FGFK?=
 =?us-ascii?Q?KjbT6Ch+Jw5dny7vQIIDOgdBn7Nmbo9VTxJXz9AXgUDej2NRuDvXQ8tIcehl?=
 =?us-ascii?Q?IFQRiN/HSi/YBvIe45oijwbFOXrtAWFDyrzoOOAhBYC9HwztnI1PE89stelw?=
 =?us-ascii?Q?l2OpUVLqOsDT7gKndP0HQI98GC5B8OGuJD36ubH/5lQCEObiqvzWUioSxvGW?=
 =?us-ascii?Q?uOBSK6yeLsmv4wv3WzhbUpXd/XByOoO+H8ftakX4MyDkgJhhp17G0vc6X3uv?=
 =?us-ascii?Q?PBNRu4FnNnkVA/bkARKliKlIWwOv/K1Cr/lydOFFyWmQ02RrSRi4mVqOq5kj?=
 =?us-ascii?Q?ViE+u4NRnzhJG67Ne12HXelloUHXDA0sEDdvwDWMtH3gsCk4prK/NWJrYygI?=
 =?us-ascii?Q?8JKTdAdh4t4B4w8wLi73Wc1EnXy12qWdpBedVHpw+8lEaGngilBO9ZQZxlLs?=
 =?us-ascii?Q?8oPWOkDomeaznoM8n/gnzxWXS7qDLLkzXAnNCq7cIejizo7ILOa/VnDPhBSn?=
 =?us-ascii?Q?WeKP9XlReJzo9Y13ATztLCku5f1LB/NFDY3Gpdoh9s0rs9n4WmjviyO5u5/4?=
 =?us-ascii?Q?Dr535G0R4JwDeuCCUnISbQPU+WW43hzfj+/0Piq21XGUXDY58roSjViSoHFJ?=
 =?us-ascii?Q?Q8Td4d5GRtisIpQh+YIshdVcfh5ie36Z12AwbbKNfTh6fl4hidLuyKneGRJV?=
 =?us-ascii?Q?vT/APekIirk5iReKKnxBQC9y3eC/N6rIEd9g8QcTYmwrMtPs27zd+1Y7xZb3?=
 =?us-ascii?Q?5g9SxdyDNx1I/Wfi7QwADDjygYA5x0VPJ377ShehGWahbjPUhipn5bVKFdtW?=
 =?us-ascii?Q?jH2iCArRS2EZYTo/17EV+9XoNo3Qtmfc7G0T8a5jC7zskkUUrCGMSw2vK1Lg?=
 =?us-ascii?Q?U2PyYpD7e0MfVosB9BLKThX3dcqv2fsZjLbCYuxyg0tL4CM0Wp6ROHfLfgQo?=
 =?us-ascii?Q?4Uyou00y7Df5jITdeG9QpoPgdWieGj35fYBf/Vns0mL2V03kK+U14BRhdfBN?=
 =?us-ascii?Q?rJGXT5wMFte+UQIx8m97d9NmLah+QycOBdWpOm7QNPBag3mlDarPKuciwLdU?=
 =?us-ascii?Q?mVUIcsl/vMWJlRTZdlRGSnUhCHluGwYj2ihP9hwtcbv7d+dNTD4aoF/9L3SS?=
 =?us-ascii?Q?yR5j2HNUBYSULnGO7Rg1bs1ifETESCWhctjPExsm4IVXwTkK/x0PW+JG37FC?=
 =?us-ascii?Q?KVIdHwBytkFuwb9N6e6ddQXNsxFKsDeJQQidoxc5P2OT+74D5TXCpGDwwU5e?=
 =?us-ascii?Q?xvqUoCVSl0Nlq8X+lUq7tvXWD/QHFOrKEGOTh6K7qq6eG0o/wjG2P+H0VGHT?=
 =?us-ascii?Q?LPWxvl4Q0tAg38qTFY2QnSvq8EVufo/GTVSHpA1za97+AfPD?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e98a543-a157-4ed7-efe7-08de887c63d6
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:34:56.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9ANdl4MoHD/tQeXX4F5mB8FLmCuf8vc3W1kDMFkyDjmZVmaqR3GDkZmkOwliRkq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8142

Add the compatible string for the SARADC (Successive Approximation
Register ADC) IP block found in the Amlogic Meson S4 SoC.

There are no known differences between the SARADC on S4 and the one
on G12A. Therefore, it uses "amlogic,meson-g12a-saradc" as a proper
specific fallback.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
index bb9825e7346dd..70ab4e140e71b 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
@@ -27,7 +27,11 @@ properties:
               - amlogic,meson-gxm-saradc
               - amlogic,meson-axg-saradc
               - amlogic,meson-g12a-saradc
+          # Usage of this generic fallback is not allowed for new devices
           - const: amlogic,meson-saradc
+      - items:
+          - const: amlogic,meson-s4-saradc
+          - const: amlogic,meson-g12a-saradc
 
   reg:
     maxItems: 1
-- 
2.34.1

