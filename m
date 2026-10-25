Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792907353;
	b=JupqKCSZMMkwwD5CrY6G98HUtU402h+JxOYKJv0IdPfuebix3vxhf3Ic9e+FIPZ931rt
	 6+8F3H8yGdXy2yp1WrkPkoX+16zyWI3igzlI+L/lfRbrBeOD/qLJG0YhphEdsrvqlLoZi
	 KCWnPDMBAdz8zVei1xLocyNoeYoznYrx/HC0qGk0joDeUslCSvXtrhOCMvQsvdL6yDr4j
	 bvgPTbjSsz/LJriTzdANCVMoorbEu4fq4Ys57xWCJTAK8xtjNYTRnyrWMNtIo7v3ax7U+
	 riH2tprT+fBqIP3vYV75J32yNKYWaqs1G3O+YwyRZnGA98rSe30BoE15/yDUOz5jJ/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907353;
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
	bh=pWsFLduvp2sWtyF+aI1H+l0Ow/7WteI707xKlJrB4jQ=;
	b=S4KCuzmva7RD5Z23EVrOVO7e4rErGRDbPD16TlFJMwCwhY/LvyEWS2FWxN1RZfVMYQ3R
	 9m6JLITyNt44NAdnxBUs3aBZqiKOWLT81lobqo0smG8X1Gv7NEAdmQsjeFYq+9eKZFlxr
	 zmv4lusuqji5EbmrJ0a7+jKFwyGTjGixBwifbq8HTPW3GmN1pqwqS2X0J+hRYrjeJ1cle
	 t33axbj9ie9yLjLzehis3TKd3JRaFhNOSU5lNTrn2eQPPe28+sUFQnTib2FbcUypeYGVC
	 hiD9OtWwwr1qiD+nfj+6WcpPv723pbK64ZCKizQZtJnPzg8ClugrBUSw/+SCi1qtM4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=CFL04OeV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.49
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012049.outbound.protection.outlook.com [52.103.20.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E7606A328;
	Sun, 25 Oct 2026 05:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC7E7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=CFL04OeV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh8hy4Bdm9CcsqGRobP9CK4vrrenEfTZlXXaRVl91sFAeOtw0w9/DUdefjyUEmi2lKZLtg+5d5XkX5Qb7h7O1F8y4OeS7Vql6RwjpcwBtBev5J75WkG2wSOL461NoQoIt2RqbRTff5MLL6zSqG0sL9WlsPa6Jzp4+jSMp8IkGlaxM9gcVl1Dl+SrBPkGzyDVFyAJ2wPwvA/hG1CTz3tjZyjiHE292POOpLtNdGw8mTL4+g0fg5Wy/FlIu5uGL46Bz9WOV7X9vXmVnnvnCnWoino+TS2renUKErhMsCn2sPq5SlolfQSVotG3R2W5ODb9Rt63Vr06YiTrJ5pzmBsX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWsFLduvp2sWtyF+aI1H+l0Ow/7WteI707xKlJrB4jQ=;
 b=WhVD6fJ5gy209aZcOJpzL1RWAO4BWVafEDGr9YzAWAUVsEtaF/BYGqRHZrAVtOK2iBjQB/6dp+wI2snx+a9LvbVNJGfcthGQXPr5Azg7f6H6beT7zVu8YLFfj0up5shLbNA5WvQBnZRu8l5C4bFQKxTFSxP2KjE//VTz/OeZMBejekt1/2NHnnxnXHJIpO/PqOzFM4wSSO/kSOmHqyRPO774+vaiZmGJmT0lTDqnln4JKKqzRf2VTF+pBxtIwfHUrVVO25l6u5PL8KGV9nTsXb6FOo7OwPiHVVy9nUbXkJ4zuImgUsipcthw1hGgdLSz9U4Z9GP7k1MXybS48sTkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWsFLduvp2sWtyF+aI1H+l0Ow/7WteI707xKlJrB4jQ=;
 b=CFL04OeVSFJtLu+XK8tc64yB5/Ni0dC5u8wjCM3UrEKS9lWEBC1j8K1JVF4RYg15Z5BjS95YVuN1GxFtx2W/miEfY9M8kuTHNiAQaZk1tIcW/S6q5sTQ6+m+CRqvX5nW+c0yyZF+Gf202hnfYl9+jmjnF9G46ptC9DrX+vFBNW2K+8pIoaN3X1mNl9y1Wpc30vdJgwRiMmU8/gmX8kGrjQSJM+8+YOuO9jlDeci50XyUPQNH/jfhn1hiWtXnGgE87c+iUK+3G0KWFb6zkn8+BhtYJq+DhyEju9uP/bnyGvps/1U2t9aSbOq1GzhViLQ8SwBwmqh34aDJMV4TfbG0jQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sun, 25 Oct
 2026 05:49:08 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 05:49:08 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Sun, 25 Oct 2026 00:48:05 -0500
Message-ID:
 <SN1PR12MB2528E69DFEDBE002A60CBA82A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025054850.33748-3-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: f9411584-8e6e-46f9-3a63-08df325baf6d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|51005399006|24021099003|24121999003|22091999003|23021999003|41001999006|25010399006|19110799012|8060799015|260925184616899003|440099028|3412199025|10035399007|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rWrnk6N6Kz8n1b7vmaOScDP+uZbqPJMO8XDnUUOF8lAaLBZPyUUg0VuByzA6?=
 =?us-ascii?Q?A7FI5KOxOobj114aR07PueE+jIvw3xMb3yLVxRMJKBcCTOzIElpTVc4W4bUr?=
 =?us-ascii?Q?CrdR+1HyfJEsrhps+rxGu0WHxyNSyjDWlv0nMoT8CbT5kIApeGYcMnfkM+qw?=
 =?us-ascii?Q?itdfCJ35uX/E+CFuQtaDr168Yrgv/zLWf/BOKfb7//obOzj01S0goPjEEKcR?=
 =?us-ascii?Q?FoTR+OVmcMHdo+ZRX1KwRQue/50pJbvjkebkso7YKUaz/dtS4E3Kf5O9IxzE?=
 =?us-ascii?Q?D3NyvXUnPduTCaxMJ32G1kfUGzdhQbr4WlEt9K3+V6XpNAvsdAUnhhrfTktK?=
 =?us-ascii?Q?YQBZytlI5rd818fT3osrLR/4t9RcJoR59Rlq9+tv1ha8kuBZUWAx8bUfWGlS?=
 =?us-ascii?Q?3vszPez8xYtKkIDzrvAkV+DuIAC88ljENn0hryRLCokSvDvJO304OM5a/CkJ?=
 =?us-ascii?Q?CSLlk6VhlaMd4JfzdkHH9kRhGdbwdxluV54UGZlLYN9sVFJDWIT/gaiMAykh?=
 =?us-ascii?Q?QKw1+LVMpMnjKzw03dqvkfNHzbsR1LbZEQka3CzC3Vck+isM/T3mcMcAzjgS?=
 =?us-ascii?Q?0gKmESzjzk2rk/Rap7CQtCfe+U4zgqi7lDMpXxRCqAXCSCP3oUdaE3/frI8N?=
 =?us-ascii?Q?/fqBRbSpv6S08xcDtkeF9mrwzoqKJPi9u9lQqSjsEp6pgpesWZyzc3SoOqGD?=
 =?us-ascii?Q?5eBFTZd5s+eU3obpVNCYcTE9IznsKQ8o3fmR+sdQGGbmZg9/OPBAXgxMTEHr?=
 =?us-ascii?Q?JZKwo+HggRZLG9vwlQKfomsP6jsKs8KU+iKdKmGVpYEG0IeiAtDyih9crgjg?=
 =?us-ascii?Q?8GHaoVAQgXSNUIsP6au/Kx86jG3r1boN99+UNY0iGr/SJfzkI9mC5dRCN+7w?=
 =?us-ascii?Q?anQQfoqng37yt2cqHvydjaldR51pijeDuzgGZur8jAxwHDE3tsus7Ka57Sey?=
 =?us-ascii?Q?uEvpClzzgxgktKQqNd34jNzhGzgCKYJllXeA8OaFp4YS1Reb/MgU2qFPCZmK?=
 =?us-ascii?Q?UBWrnADJFHOFNn/Cpqa0YxWxz+3Rq5wkd5QYK2MjnUhXVhY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siCO4lRBBAYck+YLrUxgzkTGbREIyJMAOJ8TlnAHeqUHCK9FmJxEF1YZXuGU?=
 =?us-ascii?Q?jMXbzNwD2ycuNMNC2Zprc/7y7EgulynbtzGhGx+UYzt2AwWq9f5G5d016UDY?=
 =?us-ascii?Q?mutGL6kgZpm5HXTV/afuTJw+ujjTmbt5G742Df/HVCSnhrnInVZI9J25m5gJ?=
 =?us-ascii?Q?D0ErZprOCawKRcX84ZiIVi4JTDNgmlq9eeRNR4d4GWy7u7/m+lYojoGdVo5R?=
 =?us-ascii?Q?e9lWFOcY/xRBVP5vhM4Z1qNp/X8ll8xAVndJ9IzxW7A5vnIWQk7bR8qdGRMB?=
 =?us-ascii?Q?NVSH1uhn3wnjtbf/P/H+6TXyN/g3lNsKg1yETCtFTu9a5fnLFHX4dArPQvO2?=
 =?us-ascii?Q?ZeAgm5FeBoMBiG01ynI10FjdM6MuUgeoWBhgT53cVsgB07u+nufBe74/wzQB?=
 =?us-ascii?Q?X11lGYdRA43Zveo1vxShs7K6WM1gpwHS4tLmyCg+WX9ZZApxUbcN91l3tbNi?=
 =?us-ascii?Q?hsXzi3PSyw1ArDa43lohLAX5TZXX/Q6k1pGIXxNj4unp+oWUDdgmI917G/W5?=
 =?us-ascii?Q?px6HPqK0r/+4Bt768AFv2eo6B4EoSE01nFB2hrcDsI936rCa10hhlixfq0gO?=
 =?us-ascii?Q?1iJwfUAMPqeXJtgUsWFpn11ortQ8HktB6SitdoVcqucbVOTFi7tebSt9UZF9?=
 =?us-ascii?Q?P/YrpIprrFHUcsTcZLea/jgFq9gF0JlmYJb+suxt+2bxWmqsFy2wvQd2WtGp?=
 =?us-ascii?Q?Ch28fCwzGgatz7iWTrLWYLzx2xI4e7xVDBLhK6WNUchboodLTTpTSMIh2BoT?=
 =?us-ascii?Q?TRsgCGQUcE0VuodYuoPgASFrStE7o92Uhep7czUlYxCmRN9jmjNPToRVqaLm?=
 =?us-ascii?Q?ONqDtkpVMoqKI/AbFPCsI6qlCX16+nrw9tM/BTl6IUQaaEac8gIMyQdxFPSf?=
 =?us-ascii?Q?TFK4+uB3IGVsMLmiMGz7xpl5xrVhbL5sTR1HCVRkXaTyCWmiwm+H0Kg6j8I2?=
 =?us-ascii?Q?OCeK+okZTyzHtb/mH44sjjEGfDbrT/6/L0uoz6t3Ajb8TtuCE7xA0DGD75W5?=
 =?us-ascii?Q?pA9I8iqDyhhqVLBT89ZVjOVyNasX6a+qjESpXOfwBMTQh2XyPxuaCi88szyo?=
 =?us-ascii?Q?lz+ecq0rSe0kPhkNgti/2Gb1VU1YZftBim3ROGW5dLem8iejvuj5a9qMIqkM?=
 =?us-ascii?Q?TXaHYMYcK2fl2Mf5juqcYvGifHQNBhzgbX03v2RfqUJqfnWlxtoF+j96btL1?=
 =?us-ascii?Q?Zzg6yaiuxO+mvS5gVqutHDpE245Zx6u3rqP7ioWpoqYWsfY2J5xIZtK6TWDc?=
 =?us-ascii?Q?ijA0YiaHghjgFcZow133WMjDDM33h6A4pJrb9CfEqFX2wvzrTdKBGhv6HpEY?=
 =?us-ascii?Q?BlEcyDKae7KNknpBsM8fZS8Xk+b+7Fu+Hi+gxa8slnGUS4pbUF32Lj/6DVGH?=
 =?us-ascii?Q?VSdstKO6y4UGSOGBwceDW40CoNZLFKz7Zw05/pm40qSVolrspQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9411584-8e6e-46f9-3a63-08df325baf6d
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 05:49:07.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

Add device tree bindings for the Texas Instruments FDC1004
capacitive sensor.

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 .../bindings/iio/cdc/ti,fdc1004.yaml          | 46 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml

diff --git a/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml b/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
new file mode 100644
index 000000000000..8366afd025a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/cdc/ti,fdc1004.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments FDC1004 capacitive sensor
+
+maintainers:
+  - Victor Chernyakin <chernyakin.victor.j@outlook.com>
+
+description: |
+  The FDC1004 is a high-resolution 4-channel capacitance to digital converter
+  that works over I2C.
+
+  https://www.ti.com/product/FDC1004
+
+properties:
+  compatible:
+    const: ti,fdc1004
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cdc@50 {
+            compatible = "ti,fdc1004";
+            reg = <0x50>;
+            vdd-supply = <&vdd_3v3>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 360977678f70..69c23ae21016 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27388,6 +27388,11 @@ S:	Maintained
 F:	drivers/net/ethernet/ti/cpsw*
 F:	drivers/net/ethernet/ti/davinci*
 
+TI FDC1004 DRIVER
+M:	Victor Chernyakin <chernyakin.victor.j@outlook.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
+
 TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
 S:	Maintained
-- 
2.53.0

