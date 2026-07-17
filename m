Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012046.outbound.protection.outlook.com [52.101.126.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C83E51F0;
	Fri, 17 Jul 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281596; cv=fail; b=P1hkKQbgcFE08xSfdrPmIa5/6bqiw82CjAQ59+1dhO1hF/NqmiJ2d3V1jBxTNjs41oAQ2iFVX7FmHVRIyKNT4KO+4hnRpffRAyW4DIwKbng2nXJjZ/BH647E/YE850ZRLdsNj+Dx3KK5XpnZjMrHQNL8fIoPq0DtXlLMInAWgsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281596; c=relaxed/simple;
	bh=RiEgxk1vq/bJtjg1V65jzyry9D8arXwTNASVBCiZrxM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbKSPchBlLQFDK6wJGE2NH8qF2zR+cd6ue/+TKIEqR1hUUeAH7tN1ApBwCb8MznVrkq4p31gXgFnW3TILgXSnGHklCDPckADMFSJ34SMZ5T++eRLjvdE2dpqW+OMHfBIccJ+1kZjzoIWkVis49wemPBXoERbkWZqifWqF3GLTtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=o/M7VTfO; arc=fail smtp.client-ip=52.101.126.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="o/M7VTfO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axkrKOOFqbSEosLj46O7ZTHBmJ5i2JIQI8+wVuolhw6dvLFGIBA1c0RdDxYHAp7a8ypMSk5iPQCFxE3CF0Bjn9hWGdGp63D9qLMhQ2+NLIvFfalxkz/2nn5617zbm2sUOVUwBy4Qvpeqbbw9Yo9j/3YJf85JxsQdfU+8o0c6B3ANbzmFaBUG+9d+VByK83hdr+m4Un+nfZp/Fbo/+ADLs9Dc6Zru1UtU/MZMQjarw/GqWwV4hm95bCGUKjN1bruKCComco0Fp9c8CTAlE9P8u46w7uLbNfphVRotwPDXG38+vEykEIWa9IDc/sKWA/4zmfkFBKhy9SOcUZ7i6VF02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if4F8T0tiVK/nlg2nyNf9d76w6p9XbTv5yAMh9WbOtU=;
 b=LM5u7RR5pKw1em6MkXF+Dw9Vdd8fct6LVQ/NkIg9p3GshuhEAzxpANdTtqTh5QJJogX5If44Y9a14cpWKEo54QBBPfSVe3avmy57yQGHd3v+Zc072AV88WvDZCYi0/TO9OUJCE/EOcnGuK95pUlSg6FBcfDuwJklPOBtZl/9d3wXLYZy7o9tDkXfKNt5dE0C4fkf3cd0TN4GNS7yq6ILuos5OlnhpJNRaULLCSGlordbmrdNENIaBbmtjUhOMihDcsfF/gA9Dw7Ot9eD3RqSgrdEAzqot3xfo2HciL+Qxoq6gkoPg0WeMsxkP/HleIoixrVq2DsYRMTzqwSd8KJETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if4F8T0tiVK/nlg2nyNf9d76w6p9XbTv5yAMh9WbOtU=;
 b=o/M7VTfOd5Lb6dPuMc2xHiczzSqgpT8LwJ1QYuIGffiiDsH5tIvIQdd5X4H0TFgClD0OX1sxFQ92L6GSUAiN6hRlGzZR7tTw/6Hy1mO4oi8zQogKTgduq2sI3pTIe1XR0TJ0a484O5vMJkKeQffNfRf20ZT6CZGAXzq3qpZgFNgJP5NDhrtMwfpuyO3FwPRtGI7LcEvDCKT9p6DACeI3LSHjphVFYs+gZbgvfBZdDPb9ejKOAQzJRDSCY3YfXa6HgvpsY0NS3dIrpKFKznFgI3kKj38g5xLAI09WM4/hOElchgsANeB8VUEY6JD0R2d4Z6KkKfI+udckZBk4HYa4CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:32 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:32 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Andrew Davis <afd@ti.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pan Chuang <panchuang@vivo.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/13] iio: health: Remove redundant dev_err()
Date: Fri, 17 Jul 2026 17:42:29 +0800
Message-Id: <20260717094408.509583-7-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717094408.509583-1-panchuang@vivo.com>
References: <20260717094408.509583-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:405:379::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: a562b49d-8a19-401f-66e9-08dee3e84860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	WnBzeTjC749G9rgIJi7abiV4fBdvFM20bkt0x6ZkMFYoBN/WrnT2ayOL8kGU0l1S+vZCpp6F/1PpYUUVbCgRefsrf9j1I5fRLvYcgKAOvxHVIuUUKWP5XYaMfVEZY8XYBEV+ZYk7310SG4nKT12tegNv7SCExGoevLfu+gL/5twhmussWu+fyKpihpLmSIWgFT2PeHk/HlwTarmrqez/ucRtqS4q3cB9Kyh9MLjDzhjqfz+Ht/+huHVEqO99LiVjpNpe0aUOFXvLm8s0dfY85o5QcGboXxndbj+V0uOpThTVF8NgjaXwb9xPULDOj39Kb8nv/LhohXsG1kLOOx/4OetHBTMxVDOD4ciJmNqhT6zovu73ypLH/dNVkv3uaCWqPX0Q5y23ZvzD1VK+BgLcQec3JoNhFWT1Kxta+STEn6l5g33STJrVX4CK7hsPJHf2SFVv78yCtewcHMkvyb130AMN57kGZELGTRkkeJigWyngPxlTaGjm+gPCMgafPnZQqt4dz0t95fQmVf8Pvytx5NOUe3AQTKq/EtnC5oVt89gBPAXpuuN4vEp28Jl9tBQtmpowZn3ASr2Xj3nlpNNVbXuWd59SiXDhF4xTlIqpvKf5u+BqT5caDtHysQ0l+vAJthzoB7pakRzyuGvFU9EpDfuFkGR5wn8YRcmovmpeZm3hu4eqj71v7Fo7Cvy1ziiDRrcqdvdjH07mFyvau+P042JX8JPAFRZL1uTQOQgxizI0dzaxznsMFWkICSs75Gzz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HX92qdSZjhy6KqOKSWkPgvy0C5N2QL7cg/x5BtFpoBPNwbWUddmXEwmBTffA?=
 =?us-ascii?Q?vdK2C8jGQiZtPMWp9BZZtCHSxyCLDGvm0onw8reV8MLBxOKQXUca8fy8MfUZ?=
 =?us-ascii?Q?YIvEkuRhTkXnTmL70yoAlqHEUCZ/Ro3+OeI0px8iGxONX1qUMAItDhMctD1U?=
 =?us-ascii?Q?b4pqf7RPRvY5TKBwdrDltfJviexQJG96vXfquZ8o/6EeiX5XXTYmr1u4u6SQ?=
 =?us-ascii?Q?BMsO5heBLtosr7VbNw5jZ/QBFVUyFnxYvRXBvsiAT4pDdCnYxPCYDEv3no/S?=
 =?us-ascii?Q?oR/zQkb0QtLW8uqsbleoWDcZ/lXH8x4lI7BpV9HT/pkvf+b0EwigaoYTu7Wm?=
 =?us-ascii?Q?nRpD8ZD+yYxSsT9I0GXRjhkfSjqOBxFGSKunWJinQwVxiv+QMQmgkTGzDXcQ?=
 =?us-ascii?Q?FFvRmqprjWcoZWxj3NIzyzBlLHxhDwBtgwsmcpP5yTKNY1tnEY5QQjcjuC3e?=
 =?us-ascii?Q?003GSeF5BincvQ2snk1MFyPV/lewB1jYp2ZEJibpWDGD6KszU+nDiSt8p6rQ?=
 =?us-ascii?Q?6jBPPe9lCyFJrX5z0MwII4tq2wVQOwAX93jtpCSBlTRX620MMmAL6RMAXwxI?=
 =?us-ascii?Q?uz8QtrLcX5NEhqT7f9TkoDHX1aopkVCANBj3cGizeAANuZlBx7OERzKL9izP?=
 =?us-ascii?Q?6kO4IWF1AQVkCsP5aGGHT51HHRC+AEJhDtsqcZAGQMjYLfQHmACPisBBiT4r?=
 =?us-ascii?Q?FN4z41GA49iNgV5YW2Xp+Bib5hY7GprHi9/o/uR/czAMl4FD4EOR4kW/s9+u?=
 =?us-ascii?Q?EMlEe83k+FvusK7icfPmp15h6LEZxFrWNBUlxtHg7K5DUJ5U85q4Seip5Wkv?=
 =?us-ascii?Q?vJfOoOMg0VOKNjWMTC6Wwt7/ajQ3cU4WZ0nBFJZhyXD69HhPbYlPhvgn5IrR?=
 =?us-ascii?Q?OnBVPK5btM5AE0MdrVBWVyO+4honb4iFVS7TEKEdUdmpRugjsTBOAYkOpMnC?=
 =?us-ascii?Q?ePFn1oiZV1LMF9LQFpJ2C1Vhx1Iomb8czDJPzo2fnl6X48ntR2WGiDURAY+5?=
 =?us-ascii?Q?MPnMrCa3Xbg573D8xqgvFBHzwBrj/Tgfhx/t9btBGaXYj+Dng+T+FJDkTLwv?=
 =?us-ascii?Q?zeIdbj2D3OxVyDU8gchfZ4M1gUfJaSLCpjNWKu2+RLS+ex/mkk9JcbgYczuJ?=
 =?us-ascii?Q?O81ffg5YmXgfDZggb/loiUCtnqnRWZ2ECisx0pU9HV5vf7cAKzY1/U8BVYQ3?=
 =?us-ascii?Q?iClbeQ0BGnuIYMchgoJlu2hkPdG+Bzv6oyuwYg9H1lehCBS6EdsqaxwSxugi?=
 =?us-ascii?Q?4rQdqo0b8ku7OKTIm+TU4tSexjCyElujuKU26Yx/3nOYUc7DgTY6riYo/HoU?=
 =?us-ascii?Q?PuqDrVLpc97PLgYQNYOhPu26tYPioTwYa6MYazs62T0f52L7eqv3i/WQot1m?=
 =?us-ascii?Q?tDQsUmZ9BiolBMbMUmoZ9wras0ygj37be2QJhv+Mo8OZlUNPqFCxk8UlL04J?=
 =?us-ascii?Q?29m517+87pfIXqIOiJC+yxxTS06zrkTpYpvCCeUYHMqat0sPpbpQLLsVZgvx?=
 =?us-ascii?Q?kNHt45UbzvLuWWEk6zO5iFEkM7c2gvhOTOCXZ/AqzUBqz338WB81pUkds+S9?=
 =?us-ascii?Q?XuEnGiCdeQS3YephsakAP7k5TIb50ELDdQFNcFIEk1ELOaWuRCX4ocluUcZK?=
 =?us-ascii?Q?jdMXC6W0ZsX90oyVvJviOj0se5F6gpFPdo9+L3OiBm3Ly/tC+mxTDOLJzeCo?=
 =?us-ascii?Q?2tUkI3ZjJWOdCgoKXbAaMmoAESqWJ9QXQQ4Z+Nsdd0cGVJTTg5hTwEmTSmWM?=
 =?us-ascii?Q?9W4D7IfmhA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a562b49d-8a19-401f-66e9-08dee3e84860
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:32.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKZkll4MT69E2NvuJvb7GuxhnhQo3Rqawqa7HOTo7LIIPY+jE9Vdc4XjzUv+v8cnBN10CbepsHowPymN/ZKbhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
automatically log detailed error messages on failure. Remove the
now-redundant driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/health/afe4403.c  | 4 +---
 drivers/iio/health/afe4404.c  | 4 +---
 drivers/iio/health/max30100.c | 4 +---
 drivers/iio/health/max30102.c | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 27e32707f089..2a648532242a 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -544,10 +544,8 @@ static int afe4403_probe(struct spi_device *spi)
 				       iio_trigger_generic_data_rdy_poll,
 				       IRQF_NO_THREAD, AFE4403_DRIVER_NAME,
 				       afe->trig);
-		if (ret) {
-			dev_err(dev, "Unable to request IRQ\n");
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 2357e2dd7017..22cd46eca217 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -551,10 +551,8 @@ static int afe4404_probe(struct i2c_client *client)
 				       iio_trigger_generic_data_rdy_poll,
 				       IRQF_NO_THREAD, AFE4404_DRIVER_NAME,
 				       afe->trig);
-		if (ret) {
-			dev_err(dev, "Unable to request IRQ\n");
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 97352485f5e2..191540e10c20 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -489,10 +489,8 @@ static int max30100_probe(struct i2c_client *client)
 					NULL, max30100_interrupt_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					"max30100_irq", indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
+	if (ret)
 		return ret;
-	}
 
 	return iio_device_register(indio_dev);
 }
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 0eeaa378b10d..c37316c86f14 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -577,10 +577,8 @@ static int max30102_probe(struct i2c_client *client)
 					NULL, max30102_interrupt_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					"max30102_irq", indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
+	if (ret)
 		return ret;
-	}
 
 	return iio_device_register(indio_dev);
 }
-- 
2.34.1

