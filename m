Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022106.outbound.protection.outlook.com [52.101.53.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A3365A11;
	Thu, 28 May 2026 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955844; cv=fail; b=rPiC/sVTLEZRC0lGEe9naXevVDEA84I5iz5gx54LqHW3Ky5krt7m9GU/5+1nZ/HVuWRYTEJ714bTGhWj8sczUY37fLezgj9JISVQfPBCgEclJqo92JxhiDaeYUzBrRiY9mCSn3UFi0WSVntiBveRad6komGBLrGYSayAUkqaliA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955844; c=relaxed/simple;
	bh=oZwj54S6GeraynTPRl4io6K6NOnDyFKE9UPr3K1KbpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7e3jjZS2wxVRHAh01ULnyKJcYzt/T9gGx4A6Vas4VvJAgQSqeaFVLNYrKWgMXdsfwT84F+iFk711i/yFFQnCC1nEkpIT7TuILtvPgH9X0PrtkYDHcqMHz1HI3w0+hmUpxNIU3Lvpbag5eW6V0gbNStUZyAgFW7zqCGN10z5bzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=BS3iRBXG; arc=fail smtp.client-ip=52.101.53.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="BS3iRBXG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgkLFf+62ymp47gvi3QLOm2iDu4jMqTX5wRgX7xNknGQQVw/wrbZFg9wicojUEAdcnKsl6tznyKMs+csw4l4hCFrNrx9B08DCEUxVLIIgDfXAYY+LsN318n1JDzQTzSC1nE1KuxzNZIfp4q4H9hFj8x32uTb0PZNEuPlMrWsyIdpJOHcwxJQGI1W7dqSOA+TtCZ2r+aX6MJ1n4j/pQgpD+I2jYPyyfQPqs5nXEUGsgrPCaEX/BwrIGE7M4SZrbQsEOYzRYN6Bom1sTMJOsJjD/CI1+64W16Nvr7m+aYtwjI59Ci+Q04iOGIrPAX0ZMhc1jO9CF1AYbEpf0sKouJhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDWiYE7iv0Vl0Z+0FFW2Y3Tt5O2G+oj4Udx0CoQ+kXM=;
 b=KzowELom5XcCJ9gu6iM8ZfV1y2i58/xK2M8V6z67PfyOgegp427lu23fPyL918v9Q7YyPsgtGFjIiHFmG27gKe2nSd0iemMaEabQiSwiQwIUcgujTeCdGDYYSaLefIixUDM7/ervfGBcQk5lcBU6QLUf1XXBBH41GDfa7R4l0BtwuEpL8o46gQ/jlFKABhVmdn/zNKaAzkXOuNfpHH/NeV5I1KVOPoosbINKCz2rqUEtZxemaPFPKs8ZCnq0SG3A6XE8ehdFm6S3uFKn4S5tTmDzDuHW8fjLt6svxV5JAdlSQtI1IG/MxwUfHTohr2WGs7Dfz8Psw9mc0me136S++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDWiYE7iv0Vl0Z+0FFW2Y3Tt5O2G+oj4Udx0CoQ+kXM=;
 b=BS3iRBXGsOtGP+NCPr4IYGTUtCekxFvhUkG+yQzkN6rAxZ1JIrF1giq5tW+Sd+qWMq3W3y57yk4EaOd6SHggb+iDKWKKfiHgpm+LcfCoxmDuy2VM+9BKpGezFU1WYeS4KkuKWhMaL4Gp1rT/bRUJkxdSihwpLU71QZVDDyvY1kMxYq3av+CWQXlh32LC6dPXu1w1v79b1DTmOQaXlNvmbSqQmIeLyZXqhK9gjei43Pu+cTVvODmm2ZSgeyMBHdf6bsmBUVRIYQ7X9PMiNk8keFTEvSfC4mJF+1qFMmozmBY7vIJzJkGyXy4gH/d3LXzsvpyU7SuERf8RSyd5NdD6yQ==
Received: from CY5PR19CA0130.namprd19.prod.outlook.com (2603:10b6:930:64::17)
 by LV3PR18MB6283.namprd18.prod.outlook.com (2603:10b6:408:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:10:38 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::a9) by CY5PR19CA0130.outlook.office365.com
 (2603:10b6:930:64::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:10:37 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 8DA714186B5D;
	Thu, 28 May 2026 01:08:17 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 28 May 2026 01:10:25 -0700
Subject: [PATCH 3/3] MAINTAINERS: add Axiado SARADC driver entry
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-axiado-ax3000-ax3005-saradc-v1-3-345dd5f6608a@axiado.com>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779955836; l=860;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=oZwj54S6GeraynTPRl4io6K6NOnDyFKE9UPr3K1KbpA=;
 b=dwqFPzfDb10JdzbgWzXg5QufKGeKVe4R/GfCkoCxi6b06XxIwiecMQYf17xxNGL/d7VTsny4E
 Wzwt/xV+LEiDy0ednYu/VISW8PPt7m/ZSe8lMpcniA6hKS/7QAJEuI+
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|LV3PR18MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: deefa784-519b-4068-edbf-08debc9099be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vrM7CmRpbQP4oA16uW+L1XYWYVxf8fypt+JXahMgn7aJNwS0ufdl6bHmy1ECJ1eFiJta+CxZaith6v//n/42pyzxdEPC7hzOKojnSwba56L0Y3Ie3GN2Ki8J1vmZpAq0CQYDR5d/wDL3C+dLOk+WHBOggpj3ywIVqcwszZkKGXfEUQPTNTR/Kr+vsJFAQt5fq5bYPWYrzx3a81tvyYSwcxZo2si4BpmnAWoecJ3/PuelOot06jxaUjIoq752blmedV8RgWwoA1hTTzfOi62x4sUzBRYRojv+l0g466PB8z3aADfVOmEL787FWW41BjYp6JtrqBnu7s8DX/8K45YAXF3wjnRGFxlBJa3MB9k2szx1UJ5ps/RdrO7zUsS11FDj9QYOHcFIN9jlt4l306lKeXww3fxs4EfUAtyoNP6eToYlAvYaecuw/yJPbJ694pNTl9+WKUMg8fcM/VmOakE2IlCKptcM5yCMeea/k2BiGZAj7DsqzRC422knHrume7ew41WOLlWl1L8qPCWOjnI7DVkVXVhdgCSGJ2Fc7oDy9rBzzY1VzPWLptbS/1ZukGEr7Mb7Pja4FTEZNV4tyoQk3vJpMP5yWyx2p/0ZCHkdZMBDLbU94KulUuaLBAn5osSyDbrAwI8tZg7m/mBHYtfTfBfWqKsM/dcY9xvYuusHqLQrvARzNLtByq34rnJchRlYVo61mf8P5+vTvGFURvNOVs/IDVOM98B71M405HJW7GZO2lecUBlLdZvnPcm1LJWEXXOLqF1QTvy0n/xYwe4TOg==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a8B9H1ByW3KEagZ0lGZhQ8IdRPN2DrIn8khNTGf0Y1ouitfzDRyTdnh/7xSn4KoZy9x8+hZQA9UAZJjRA48JiH8HpKXCFdsit6bqKKJFNyjJ9bc1Kdu45PlXhxBrH2QRw1L2q83em624O2bDZKpZlDCFt6+2IN1hpnEXhis5GHeMl1EHhimLQbRP9qk+rJO6lsFVQ/S7L73ajG2CU1mafRSKg1Jl2MM95fPdAQV0cOXy5eHr50etljHDl0guP0H6AueNc3xHTYlqOefzLWLY5OzHBhPwuIXF+YKdlQ1TABI9PxIVKKCnVRmBwkDdVwNXeYfa1RAVfpjM+zOY/g1R2yMiZaDl1c7VdcbciVGLo2SYpgOggBTk3xpD3tfY4C+cOstv3mP6qEQrt6Lw2LAw3rabt0Fkc0SAZ1GkWQ7JQ/ak4TBGSWWNHyokRM4/GZMA
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:10:37.2992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deefa784-519b-4068-edbf-08debc9099be
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6283

Add a MAINTAINERS entry for the Axiado SARADC binding and driver.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a386..e6dadfa65ee0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4312,6 +4312,14 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
 
+AXIADO SARADC DRIVER
+M:	Petar Stepanovic <pstepanovic@axiado.com>
+M:	Akhila Kavi <akavi@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
+F:	drivers/iio/adc/axiado_saradc.c
+
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>

-- 
2.34.1

