Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794168533;
	b=xkca6JuMy+7FTH7VOB0zlzqiv4gaTwWmwBhuUJfsmN+HWeXIoCcxAVb1sY+f/mfXgnTx
	 9QejZWngAz6grNKd6/HjwJqtsEjY/B4WXNOtdYmq8+2rngllCvmnzraSR0Fio/37O7nhI
	 K8rXHD+YSe/LJmpk+25yVpLCCmlnwFJfew+0CsA2Xsx2L1TcIxFGdYcfVGJ08SMLxAKDz
	 IDJBYwmBkiE7QsMhshaC4cKLb1vQ/Scxu4Mm9Sv6GOIbdbJq134pVg1fd7mZaDh7W9+fA
	 g++Woc19s1HQOG/rrPa3oTu/FFl8HD5S2vQBYv3oRlQMKpvVqNnlnNC9lE84BXQFkXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168533;
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
	bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
	b=UWVZk8aTPwP/KA0z3ZaAL+NEcXNZUHYq7ct3YRnVhjWSTz491aRH2MXJAPk0RwJOC8uJ
	 rTm177NUAocdHebJWHNpdB1GC5DnIxNaznQ4B/nB5+FY2iXZzvpiMp6Hqfd61YYQTBeQi
	 ZpF4SZesIjPlEmVoVmlt3jzGv2h76sl7555oigPIX+jjO0GWT8S4jMH7tXuOCFvidr3+x
	 kCvGKKYWu3Jbz+CgskMVeLdf/Qe7yP87N54YKhFuh8YNbcBWYRynLzqu7Jwnrawxy92pN
	 V0etW4hCGZhSc8nydqJdJ71OlfFcKfMd7Rz5CLQhsiZsbJlwgjxFWaGDEppQYaaYmiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="EuC/9zcL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.1
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010001.outbound.protection.outlook.com [52.103.2.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317B606A320;
	Sun,  8 Nov 2026 20:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9317B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EuC/9zcL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sw0iwv8NhqSeYnQXZOZJ/KWGycCyrYLieOxpw5+WQlV5GWUYsf0Rzuq1omlawwL5SQiYNjm146GDUMaZvkXf3iaPAm5mW7VKESQB3EQ8XJKbhtqH8K3uquT8U9+b3Ha9j0WeytG6wnfYm55qZdmdTaNdwy5lPVojFsRlfVINqcqNnPnne2XTMsQIYt8EiAKYnYXvYGoWQtM7QUhVvI5zxwKx+q1Vy5IdnCCiNTk18qhWndgwjPynZc4hUaAN/EU93Em1nkrR4ahLUG9N+vL5p1yvwx30K5/S5lnnYFZvZTMKmJ74tIWMrkQY7hqHb0dtQPh3Z5O9Mf5fuD9UuLMnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=HI/UZgL5i7SFhccp721qiJCeyWO1Ab9xNBnQeXXaAgNE9HWn9Spv4PrJFFh8SleVCgcjO5YfkEDvXR9168YjTHLfqOg1k5GsF0ruQibz3kty+EkGbD1kJj0Td+YZMCdPyS07b157hgw476n2AixsLfXwpK6ulwGDpBix78cc5m2IDJyFY9xGVAHclNZ1GggOeUecYbPF7MQDBrALQHvIyfgG52omuLla1+5SFkA1HgO+lg4Pla1slx6XPmdGhjbid9o7No4yLYI0fnxf7UdUrwv4tQzmFy9+5xfRomoBOofVhPODXJi8DVii/TxpSmcj8oYnSjsaqYAxaxfjIyi2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=EuC/9zcLTq7z7r1AHIwBEiJsl8S7O2sTGC5kaREj23eJmddPfNNWLzhP1Pc/VQiZQeF1V0kTVFJaLcwR88KQv3AlZiAqNamyfAPvzrr8+j627vm9Pk9TlEM4fdH/htUYdGcLo8FGptNQwszWP+t/BxCw/aDG3IqeXqPldLESV95U65xkpoHNbSnIIhDGnD9AH3VRotLMvIDNVZZNH8k6CLzDExMwi3L4540hKPUPR9cYrRbg4CS2pU+88wBKkHpA0w0snNpEF/IYTHtPyAqGdcuVAf7pwcOd87JcxIvwjJfF3w4PjnIJC84UpiFo9Gdu1k+QTMp9JCWGoRJ2nV1afw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CH9PR12MB721654.namprd12.prod.outlook.com (2603:10b6:610:339::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 20:08:49 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 20:08:49 +0000
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
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 3/4] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Sun,  8 Nov 2026 14:08:28 -0600
Message-ID:
 <SN1PR12MB2528CE04A19E0C1EB96EC569A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108200835.981970-4-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CH9PR12MB721654:EE_
X-MS-Office365-Filtering-Correlation-Id: 1669aa25-82a0-4c33-b8f9-08df3dd418be
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|23021999003|22091999003|24121999003|260925184616899003|25010399006|4140399003|5072599009|16041099003|16051099003|41001999006|8060799015|15080799012|19110799012|10035399007|40105399003|53005399003|26121999007|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?07WuDVVzB9qJU+sNbt7A8mD7+/sKvYT3fz+LQOpdtfaJ49uicQlzkoloLS6I?=
 =?us-ascii?Q?64sltZQBxQcAB97CjjS5ViVM76vue/y84CS3X3/7dg40UBQhl9H/BNKDt9dm?=
 =?us-ascii?Q?Fh6ipJUkkW3oqUJ3SstzYKpM4TEoncqpQBN9L4KQDKr9o8zZMmO3DdAwLTuC?=
 =?us-ascii?Q?31CpMW26r1qnzG5JUEgNuTUWzBoDuTMbViumqvIdjQ6uQqOz4orsccQ29Q05?=
 =?us-ascii?Q?krA/XAPqQpXEM378PpThu1n6DUeO+IV0ZZa1QQeQgmicuNjd5WbVG9m2PcW3?=
 =?us-ascii?Q?+uGOKEgP1TLxkuJmgLFSGRQAfC3ImURgMiCfbcOQA08ppoyj5gDKul4ebrzY?=
 =?us-ascii?Q?mRMdZg2Ua2m0rwE5ImjUrslb+nNUmbV0tguVjtiKwNbLmVULPUoJ/sh5HEYI?=
 =?us-ascii?Q?g8P0hCTNMjALk5MJvfZQ0/BTOA8RQF5+1uhvfXuOzqOUwiHszNhWBukOTrz7?=
 =?us-ascii?Q?0QtV9ZrOd9RXFB7QXbc35eY04MrLecnxWyVeEXqmNJZomtcfGj13zPENtWzA?=
 =?us-ascii?Q?WXdWPOfZKwh7JVP3P4ychlqfSAnBpAPXxr79fcD0Y+yamHhGQYiOczSR9Zjb?=
 =?us-ascii?Q?NdwSzUKTfiItsfqJ9/1oLaQfm9pXvsN7DLH+ybKITJiy87zA2dn2Dm4Hzx+h?=
 =?us-ascii?Q?s/v75yAouwcsmANKzCr1if/vDVCfLrLk1dGg6XKHI+R/7ri7ReFZJ3cFALNA?=
 =?us-ascii?Q?hVKnI/FM9MZVbKLHFAOIHUpvBQaRm3JDTz6K+jrxxWM8EeaszoqOS9Xoxk/G?=
 =?us-ascii?Q?tt2QlTEUkvDfa29c9EyLt6pIAXMQu1jUXWNaWc6zH0QNO0xtDx6vsjyrdHy/?=
 =?us-ascii?Q?iYrMHWh2mopbWdWew1NCB3lalDTVMEz6Ap71ilkTJwLXPMrTklLVGYOt4Qcj?=
 =?us-ascii?Q?0+KKEPcD5OhLJ6JR0juZVfDHpG3IhB8xTLO5GS5VyKUGZfj65uYZkeUVgE66?=
 =?us-ascii?Q?GITWBPxLqG27qDnu7Rq4+dsiEcwjz7QePy6Nwwrc2pOt0DRrBKzihm4UVuNY?=
 =?us-ascii?Q?9Sr8l7dkDDTbnlmjQtFUK4rJkltl8x/DOr0/rnObUdKoe0qFu/TeIuWPrwIV?=
 =?us-ascii?Q?udk9t7qIw+IDFAe9FTfiDQcwTVhF+4wCjgWJsxwudHGUCIrXM40aViQmNsVH?=
 =?us-ascii?Q?lAndwEoVbo1Vxq7t3Dyco2M2tMOdt53lbg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cWpv58HGEHZn+ZshAxNd+Uwqq1Cb2dJo8DHOPxh+zQzOhBipagAOzL1TjP/G?=
 =?us-ascii?Q?eA+4zQPE4mwkiis9ivAS/rCgcudguC2qf6LwHeoEbpvqRxWe+JG+yn5tRPO/?=
 =?us-ascii?Q?n1CKS4WiVTnG8HUQ0yH+T1OEDdX792lAY3C6a+QBtLgQnPsSeMS/GiDJvlcI?=
 =?us-ascii?Q?7ypTRFzNWimSPI5XHrA3H3FPe5ibGM9fD6eKwT4x3uFJFyjKeJY/vnX51mk2?=
 =?us-ascii?Q?WI2lWRmBQa2q/wj6hzs0naVb6c/Lc4i6Iwv5wr9m/fWX7hLJUqfW8tLr+m96?=
 =?us-ascii?Q?WjxpobUlfzc+a61N5yWSNtl4fH98io6VCWQt2NSQFajh4GBqNx1kBfvqgqaG?=
 =?us-ascii?Q?8D7OjXG/9E/ev3fMIMHsHzB0RtmvUGlSATr4RQ8SK3tX8Xaag8DN40SPt+EV?=
 =?us-ascii?Q?F0HmJxpIO8hf6TWDSlOwl+KxIlUSg6WigcXRz2688pX8SqkrGJRmp/FNN+ty?=
 =?us-ascii?Q?uuD1QOxwYUg2iE5HXSnhe/lnpYBZn2BDGqWIbS/QD6MgRu1ZiCX9BTzrvcHl?=
 =?us-ascii?Q?7f4Lk0VriPSZNFfX97SMCpAFIh3HzgLyGk7H6qrtDcDfd4+Y+pIouZHvmuN8?=
 =?us-ascii?Q?PH1lqgU5FmjGyhQd2R4nLfi4Jbo8r9NJ45s1oYMkWhYNCjPorAdK2tv0OSem?=
 =?us-ascii?Q?O4AlqeTT3LmG8AU7WJHbBIKws+A7aRVTMeGC32/EzZiADkreHblLnBlV1zxX?=
 =?us-ascii?Q?kPTpr/ok83nI8jbzmPIYnKWad9qHFrcFk4mchfPLCekJxWLPEv55rdaFiwDT?=
 =?us-ascii?Q?Plek58UFxz8UvYHyOt8RXyprodUcTODGIm6661E8N4jpZ8E3t8rm1yGVWtH7?=
 =?us-ascii?Q?Qvph3lhTKjt0wvGczfAEqMh8GRSHzafRaYaBAFTF9OTNudlFg69WDZ86h1Fe?=
 =?us-ascii?Q?b2+7xBRZanro6zWJDSpvjUGkHjNfPKdcKtsjPkFvEO1sqvKUZQ/Tg5dQ3m/W?=
 =?us-ascii?Q?oEdGhPdsO4I/2M/OryhxxwiHHtX+S16J34Gp8D4KTlfYDgqWTTQb41WOXPYD?=
 =?us-ascii?Q?DprEsIxtiWosxxt3dNpEgn5xmGOOH4W5ms/usTnW5IPHnllWgwJyl7lTVokO?=
 =?us-ascii?Q?C5b9muf+MsOx5VnneSNz4zhjNGHkVR3paHzImEfVbkfenXXJU29VF1flQJZf?=
 =?us-ascii?Q?zCUBbuQNZU6DNhPXy/lDEn9Jf3rktkNo2CpyvQYas/cMXYkmkGy0LERkUWFl?=
 =?us-ascii?Q?FyrVlT3ZuMUvCDV+AeTOeaTup9EUE4ro2o2UrPDtpBYoQFsZr+iACRNy+TsN?=
 =?us-ascii?Q?Z/QK80IwldaBV9e8eCJdDGEAnpbWQlDWwjJEBZB7NwBwp0QUDhKg8z9W16G3?=
 =?us-ascii?Q?lPWnjoYy6azuyZLaLCtpIiQvA6TBqxmtbBcUnyZyKNGLjiGhPd0Nm0wv42DI?=
 =?us-ascii?Q?gQ68HCTWDpojd5uZ4SNZjZaPrVL/0Rhe62JxhjpY4xTwLh+DHg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1669aa25-82a0-4c33-b8f9-08df3dd418be
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 20:08:46.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB721654

Add device tree bindings for the Texas Instruments FDC1004
capacitive sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

