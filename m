Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AE40148E;
	Thu,  5 Mar 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740771; cv=fail; b=Lf795MCtL9GVzKv3OyTAHpA9SepvpIre4qMuFhKEB6NmSyfjkA5GpFfuI2zq0O6f0mBQkOk0vsBJfp6Hc7dSsoevIHUk/OVJMOzFlwvNiX2HLIkoMYQL1lsHq064k5ws6gKeVWVt5MsMHDqQJ9FbH3e+hF/HMDd22rlzVVLTlvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740771; c=relaxed/simple;
	bh=Z6HldUMVHQkAJ0tiDiG7K1ytGJRPeEVGUt4AX3cF7G8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=brMZ9BE5rDm9ko2KTaB1pANGQzLEwoCPYe3fEGCrD6yloRz17m6aeIEI6CslIK77UCpYx2Pr+uIteKSxBr2h7HHuz10DK8joFibtXqU63SVOMU4WG7gAzabUkdNUwZUAZz5zoG8IEDM5Huh3ft5jh1mgmxcmgHd6FKkc1aXNKko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DObhDScR; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DObhDScR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnjYVpY3Q7OBPGuG+gLrNcgoKxbJKx70RCmSHX20DN13w4EW6ZW7aubPODGceXF+mzMzsGc9G8+EZe5A7yqaXYWi7ksuC40ZRIqVS2twFZv5SJiBNAQdffuto8CL8D5bNT+9J2npbg1PBuM6popDpOdqE9VGxcsz7KtX3brElU8mQVZt7Iz9735NCAeR/mVuoz+w4GWN+OfG05VvHOHwb8E8A9ZnjDA00jZ8zlhRA8iY3DM0mIq0jJq/VMASXA7Ny02RibMr5UXQVc5Cb4sNATHZjIedhDOJp9cyJzr8HLDcebZk5KBRbGzQZIA0484oF7Dys738ge2qOIaI3Izv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+/91yoOzHJUkNNYR81kJvZ5vtCIBWcP/BK8bTNiYZI=;
 b=S1uukFtDgHioInKxUNYDNtin5TyiLpedcywJJUNK+KdQPWzPd4z6gZgAgXn94l4APjJ3xjaAmdn3816nmgK0WAwtK2NukwXgspyvguMMt9xulZVX0wzja5dLM95YBhngMizPvcRubvWUDFQ4ohoBOliIBPHaSex+st1yR3gnP2pzbLWpApRr+IqOWYjVgbEcUNgY5eofjmyEkiNl6jZGvGxSgIZZ4/WIX2pybuKzgwUaFk0q1vXC9O7eojcO+wsizuQK//mhWHaZBeAD5ep4nRUXjYtZclcu54TRnroZT3LuPeotASkO6OcvFuHq2z+eomaHs2Hk/+SoikS+Olm7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+/91yoOzHJUkNNYR81kJvZ5vtCIBWcP/BK8bTNiYZI=;
 b=DObhDScR2Wv7pEWv0UG/yMi79phMxFw/Qv2U74dIm+XH13OtCYjwTBrL+s54qbMeLboXNn8+osRI5rVr2DEntbV6giRZksGbi55YFGVbc1UNLKxN+eqIgdZKVI0a3i7xIB7Z1QY+s3nNF6LMcZQStZKfZ+yxA8G+8/MFpPE2gNQ=
Received: from SA1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::14)
 by IA1PR10MB6879.namprd10.prod.outlook.com (2603:10b6:208:421::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 19:59:19 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::2e) by SA1P222CA0004.outlook.office365.com
 (2603:10b6:806:22c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 19:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 19:59:19 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 13:59:19 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 13:59:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 13:59:18 -0600
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 625JxIEY2951411;
	Thu, 5 Mar 2026 13:59:18 -0600
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nikita Travkin <nikita@trvn.ru>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] dt-bindings: iio: light: ltr501: Add liteon,ltr303
Date: Thu, 5 Mar 2026 13:59:17 -0600
Message-ID: <20260305195917.831104-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA1PR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: a95e7e87-12bb-462f-edad-08de7af1b01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|34020700016;
X-Microsoft-Antispam-Message-Info:
	j60HtKlyx69T8zx9aQK18Ry6MRILDgF9XxPE/+du5uL6X2VNBkFVLLgNPdoBtqi/W53UdcsupZDvvhUEp9MwMQQU9oCwQkshBZ4iM7/G9GTbDZg1jqo64DcOBW01BhDOV7afN/qWDUi9Yq0NJ78wLMDxK5wrwS1wkYGh6u6YK4b/iziYVIGKKV/9l9DkDvUie3dyA5gyvDLNqsswyak1uu6/sQJv+W8eBQoWL79BXOU/Ag2SLmAfJiJWi5hNUuURRXBPfwOcDTh2ToOtyMRjxh2uqjbAuC11J3ND2BlSRLeBh6npxP3JAIHGCQm0lqXLCR18WSCK12QTbkFvVyKhvnD5G4JIdPzgVH08cfAdrxLTj/nFXIBhtJe6h0lgQ4B6fmumCxFahI9a92LyyCuY0HD+XVX49mu3L2vxzkg0EDI63xJlyQOyKxGF6yvima7JcyYangi/y7gPMSdup3D8MNh6PoLnpZftyoyDgZrJHHJYFeoT61sDyvdtdACTggOHfiyy3r0AY8VcaJFf9IK3LsuXRArxOn0f3rK7DCLWrU3xf3keTjSTLzVHB2nvV9lWbPEi4BDm7VNY9DvtAE9qq6x3ixdkI0c+mai67PyNakSf8xDAKzL6qDfXZKqoBZ3jN9w+ArV3SDmmcXQm3Q9gFMdLOtJAKLYyjZAPK3N7owU8nbZNMnY3EMvHFqfnuNK3pF4nZ+UE4LJJ4Urb5LVgvm4z9l3nvkvwUPxYsnm7zafjeOdrp2cefGxXslSj1jNkUFk1thXcFsFHCAYAUuovLQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(34020700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6r1q891vgxb4Dwc5wTmaldrLXRbX7eBw0j9KATZSo03Govj/YDCyErG2tsYL49QbCfs5YT43Uz94jX7z/96w+JTJ++s6/yBO5856HQ8nNAShVktiDTczp9vx/mQzCphCbEvCiGLdOswBB/r8BorHpeSWCHQNs+3Wegc5WRPkwFzvzH+E9aXVSxxhP7zWFUo7S+6LsMdGiauBU22+FDsQ4VDNvUreoq4PLAi6Xpx2omTZqb2ZTEbRlgxaqE/8iR9Sbp0av3W+TjbR5Nx7FngAKcZhIGQ35/yvY5huE/hyocT2fIytK2vNpKe2LbTAK7VsAYP8lalnfy+RwaHXU34Zbz2n+onMS5TfWgULmyk+h+rSi6IMHvD4ZyOWGpIiOq+CwJOLbcyDsP3h4vXEJ+3IHOe4NtrOI1jgArce17ZudiJ7mxkUapEYRwP5fo9JPUov
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 19:59:19.2820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95e7e87-12bb-462f-edad-08de7af1b01c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6879

This device is already supported by the driver and this compatible
string was added to the of_device_id list but was not documented
here in the binding, fix this.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index c8074f180a793..ab9bb68dd7363 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -18,6 +18,7 @@ properties:
       - liteon,ltr501
       - liteon,ltr559
       - liteon,ltr301
+      - liteon,ltr303
 
   reg:
     maxItems: 1
-- 
2.39.2

