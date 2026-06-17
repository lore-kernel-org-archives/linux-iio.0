Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4232DAFB0;
	Wed, 17 Jun 2026 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661857; cv=none; b=nf7RZ+9Nhaj+0QXTJkbWMdmWuk+P9sd/FeoAfHe1AiWNiS01BChuYjwli+unTp82yZfaDKQePLm00o7Q77eoEWRFkAwI39/QpR0wRUFMrbCcYyuhF0zHqMeqLV4RammzazqjLSn/z/q96/xuVXHJSULftU8Skx4p6eKxU4H1H0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661857; c=relaxed/simple;
	bh=FhfSYVm3F0bLH5URDUwkddaTqy8yOatFVx3dTmfls6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BV9g9FpRyTy/WafoflOjVipoZ8A5mlEMcQ5Xc0u4x/Ky3nKRhH64B4wBrUMf3YKkJFt0FJ7dKcUZRYawj+f1/zeXWiONhUs4dr/IHuCEmT72DrDawaAKJ4H/SJ/4sNyddEqHwmK9rHbgb0rX9M74I0Ysr+C4mQX2JkiSsQDsZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Aqp8g4rV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Aqp8g4rV"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLWngg878691;
	Tue, 16 Jun 2026 22:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nWF6F
	6ntQyewEsS7eA4VlYeGjRHpfU4y+XRxCuGPYBA=; b=Aqp8g4rVXmk2o39YLEtdx
	bOEv3s6NGQO4ohzZbthNtovJ+5jnqrgRTY1Os4p6jcj8nrZxgKEtt62HF4+WlFNN
	KvRQi+bnBnkE6sgw/BXYelFtlsGV+SH/OW5zU2N5Ds8WmQi5mpaN63VWh3NQXX2S
	UBgeAUbGM8UeETcBju4RZKY6iDOe4evUtqEBk8LT9/shXNLQpAjn5QnQOcGskwaC
	AHzxrWkq3m+GCxMQRNq/uq9obQhAIXfrLprjcXPKj3flBfiTVG0g57rcfqiCDfgc
	Qjhm10qGgqujTzXF0ynismN2Sb0FdAwVLklH1FtjdjPD3/C+gwb4PGCgLWpjQmTz
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4euegdrs95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 22:04:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65H24BrC014056
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jun 2026 22:04:11 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 16 Jun 2026 22:04:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 16 Jun 2026 22:04:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 16 Jun 2026 22:04:10 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65H23xlA006741;
	Tue, 16 Jun 2026 22:04:01 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [RFC PATCH v3 3/5] iio: buffer: Extend DMAengine buffer interfaces to take extra sysfs attributes
Date: Tue, 16 Jun 2026 23:03:54 -0300
Message-ID: <a09f2cac2d26fe385f1f7790b0db64b7d9953ac6.1781661028.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1781661028.git.marcelo.schmitt@analog.com>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfX8u2wxR34PnJ3
 71NNxhgcBeU2rhdpKqOwXNDoZ+DxJZ6JbnQ28MCsYZRCI+LF69bbQTI5PvzAthrtm27H09MAncx
 w54Fp0WCwU1s/iVidAzZjaJ+CLkgsAH78/qZrcBNeNAv6jdtvK8GecVWnljWmC3QyXSbxV4QO4Z
 NwTCpsUzJgx4UozsqvUJz9XVAN9rpRXD41PmXizwXhAfPKInu7i9JXnLl5DjbAG/ggJw4f/IqQf
 j4frWK/WgE8uL4eSmd8w20YBairJnVVvRTOZSWeYZQTMR8nFNWTpaW+t0fbS+XvmRgvlv0acdr+
 GW3gXYUM6wBhv5U8P2XRi8ZkaAt/DeQqKwDErEE1xzQ4OtXI7fua2uqJheCVnKS7n5v93L8ETDV
 vT00NgbU8XpR11tCtZW3zauN1wAw4vsi2xgOoKMmrqZkdS/8JObOEISSSbUgyiba3hUPZQyyIHn
 GdTtMbymxq+zlIbRLGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfXz5kH6ph4GSO8
 CYO3aYon+FnCvN7wrrmsPc2wOL+qf+l33Q4qTDGkFHaz6fp1+oOxLzfn1qGDrIf0cQXD1EOCjUh
 xq7EZFODlLrxm44AvrXu8nojh2fGo7iLXeyUc/zlQn2bNdXFuBc1
X-Authority-Analysis: v=2.4 cv=BbvoFLt2 c=1 sm=1 tr=0 ts=6a32009c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=hDpiA95YCBQlF3wP6JkA:9
X-Proofpoint-GUID: TUJsY0GfnoyWZCTV_dsF7OcdivoKBFgJ
X-Proofpoint-ORIG-GUID: TUJsY0GfnoyWZCTV_dsF7OcdivoKBFgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170017

Some devices using DMAengine buffers are connected to extra hardware that
allows setting how fast data is transferred to/from the buffer. However,
those extra pieces of harwdware are external to the sensor chip such that
supporting the transfer speed as a sensor property is a bit of an
inaccuracy. Expand IIO DMAengine buffer interfaces to take arguments for
extra sysfs attributes, enabling the transfer speed to be configured
through the buffer interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch.

Now that I've come to this buffer "solution", I have pretty much convinced
myself it would be better to instead have some sort of IIO trigger to control
the signal source connected to SPI offloading trigger module.

 drivers/iio/adc/ad4000.c                      |  3 ++-
 drivers/iio/adc/ad4030.c                      |  3 ++-
 drivers/iio/adc/ad4691.c                      |  3 ++-
 drivers/iio/adc/ad4695.c                      |  2 +-
 drivers/iio/adc/ad7380.c                      |  2 +-
 drivers/iio/adc/ad7606_spi.c                  |  2 +-
 drivers/iio/adc/ad7768-1.c                    |  3 ++-
 drivers/iio/adc/ad7944.c                      |  2 +-
 drivers/iio/adc/ad_sigma_delta.c              |  2 +-
 .../buffer/industrialio-buffer-dmaengine.c    | 19 ++++++++++++-------
 drivers/iio/dac/ad5791.c                      |  2 +-
 drivers/iio/dac/ad8460.c                      |  2 +-
 drivers/iio/dac/adi-axi-dac.c                 |  2 +-
 include/linux/iio/buffer-dmaengine.h          | 16 ++++++++++------
 14 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index fd3d79fca785..b79b627310af 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -871,7 +871,8 @@ static int ad4000_spi_offload_setup(struct iio_dev *indio_dev,
 				     "Failed to get offload RX DMA\n");
 
 	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
-							  IIO_BUFFER_DIRECTION_IN);
+							  IIO_BUFFER_DIRECTION_IN,
+							  NULL);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to setup DMA buffer\n");
 
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 9c5f19321e3b..713fe95176c0 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -1400,7 +1400,8 @@ static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
 				     "failed to get offload RX DMA\n");
 
 	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
-							   IIO_BUFFER_DIRECTION_IN);
+							   IIO_BUFFER_DIRECTION_IN,
+							   NULL);
 }
 
 static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index 548678adc2a4..9845fe9c4725 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -1980,7 +1980,8 @@ static int ad4691_setup_offload(struct iio_dev *indio_dev,
 		indio_dev->setup_ops = &ad4691_cnv_burst_offload_buffer_setup_ops;
 
 	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
-							  IIO_BUFFER_DIRECTION_IN);
+							  IIO_BUFFER_DIRECTION_IN,
+							  NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 53642de7330d..78faeade19f5 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -1779,7 +1779,7 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
 	}
 
 	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
-		rx_dma, IIO_BUFFER_DIRECTION_IN);
+		rx_dma, IIO_BUFFER_DIRECTION_IN, NULL);
 }
 
 static const struct spi_offload_config ad4695_spi_offload_config = {
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 9f77990a03f9..415b8e1be920 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1874,7 +1874,7 @@ static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
 				     "failed to get offload RX DMA\n");
 
 	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
-		rx_dma, IIO_BUFFER_DIRECTION_IN);
+		rx_dma, IIO_BUFFER_DIRECTION_IN, NULL);
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot setup dma buffer\n");
 
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 7e17ccbcedd0..760b54bfe208 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -317,7 +317,7 @@ static int ad7606_spi_offload_probe(struct device *dev,
 				     "failed to get offload RX DMA\n");
 
 	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
-		rx_dma, IIO_BUFFER_DIRECTION_IN);
+		rx_dma, IIO_BUFFER_DIRECTION_IN, NULL);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "failed to setup offload RX DMA\n");
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 598936e47fd2..a13ac31281d8 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -1792,7 +1792,8 @@ static int ad7768_spi_offload_probe(struct iio_dev *indio_dev,
 		return dev_err_probe(dev, PTR_ERR(rx_dma), "failed to get offload RX DMA\n");
 
 	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
-							  IIO_BUFFER_DIRECTION_IN);
+							  IIO_BUFFER_DIRECTION_IN,
+							  NULL);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to setup offload RX DMA\n");
 
diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 7722cf9e8214..63852a6c2acc 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -843,7 +843,7 @@ static int ad7944_probe(struct spi_device *spi)
 		 */
 
 		ret = devm_iio_dmaengine_buffer_setup_with_handle(dev,
-			indio_dev, rx_dma, IIO_BUFFER_DIRECTION_IN);
+			indio_dev, rx_dma, IIO_BUFFER_DIRECTION_IN, NULL);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a955556f9ec8..4b88e1c72c87 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -820,7 +820,7 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
 					     "Failed to get RX DMA channel\n");
 
 		ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
-			rx_dma, IIO_BUFFER_DIRECTION_IN);
+			rx_dma, IIO_BUFFER_DIRECTION_IN, NULL);
 		if (ret)
 			return dev_err_probe(dev, ret, "Cannot setup DMA buffer\n");
 
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 98acce909854..343dbb6d1446 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -289,7 +289,8 @@ EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_teardown, "IIO_DMAENGINE_BUFFER");
 static struct iio_buffer
 *__iio_dmaengine_buffer_setup_ext(struct iio_dev *indio_dev,
 				  struct dma_chan *chan,
-				  enum iio_buffer_direction dir)
+				  enum iio_buffer_direction dir,
+				  const struct iio_dev_attr **buffer_attrs)
 {
 	struct iio_buffer *buffer;
 	int ret;
@@ -301,6 +302,7 @@ static struct iio_buffer
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
 	buffer->direction = dir;
+	buffer->attrs = buffer_attrs;
 
 	ret = iio_device_attach_buffer(indio_dev, buffer);
 	if (ret) {
@@ -329,7 +331,8 @@ static struct iio_buffer
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  struct iio_dev *indio_dev,
 						  const char *channel,
-						  enum iio_buffer_direction dir)
+						  enum iio_buffer_direction dir,
+						  const struct iio_dev_attr **buffer_attrs)
 {
 	struct dma_chan *chan;
 	struct iio_buffer *buffer;
@@ -338,7 +341,7 @@ struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 	if (IS_ERR(chan))
 		return ERR_CAST(chan);
 
-	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, dir);
+	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, dir, buffer_attrs);
 	if (IS_ERR(buffer))
 		dma_release_channel(chan);
 
@@ -366,11 +369,12 @@ static void devm_iio_dmaengine_buffer_teardown(void *buffer)
 int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					const char *channel,
-					enum iio_buffer_direction dir)
+					enum iio_buffer_direction dir,
+					const struct iio_dev_attr **buffer_attrs)
 {
 	struct iio_buffer *buffer;
 
-	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel, dir);
+	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel, dir, buffer_attrs);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
@@ -403,11 +407,12 @@ static void devm_iio_dmaengine_buffer_free(void *buffer)
 int devm_iio_dmaengine_buffer_setup_with_handle(struct device *dev,
 						struct iio_dev *indio_dev,
 						struct dma_chan *chan,
-						enum iio_buffer_direction dir)
+						enum iio_buffer_direction dir,
+						const struct iio_dev_attr **buffer_attrs)
 {
 	struct iio_buffer *buffer;
 
-	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, dir);
+	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, dir, buffer_attrs);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index ae7297f08398..024607adb915 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -448,7 +448,7 @@ static int ad5791_offload_setup(struct iio_dev *indio_dev)
 				     "failed to get offload TX DMA\n");
 
 	ret = devm_iio_dmaengine_buffer_setup_with_handle(&spi->dev,
-		indio_dev, tx_dma, IIO_BUFFER_DIRECTION_OUT);
+		indio_dev, tx_dma, IIO_BUFFER_DIRECTION_OUT, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index 6e45686902dd..3c5fd71d5add 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -921,7 +921,7 @@ static int ad8460_probe(struct spi_device *spi)
 	indio_dev->setup_ops = &ad8460_buffer_setup_ops;
 
 	ret = devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, "tx",
-						  IIO_BUFFER_DIRECTION_OUT);
+						  IIO_BUFFER_DIRECTION_OUT, NULL);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to get DMA buffer\n");
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 451fad34e7ee..23028a92ceba 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -162,7 +162,7 @@ static struct iio_buffer *axi_dac_request_buffer(struct iio_backend *back,
 		dma_name = "tx";
 
 	return iio_dmaengine_buffer_setup_ext(st->dev, indio_dev, dma_name,
-					      IIO_BUFFER_DIRECTION_OUT);
+					      IIO_BUFFER_DIRECTION_OUT, NULL);
 }
 
 static void axi_dac_free_buffer(struct iio_backend *back,
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 37f27545f69f..bb7a348db72d 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -10,6 +10,7 @@
 #include <linux/iio/buffer.h>
 
 struct iio_dev;
+struct iio_dev_attr;
 struct device;
 struct dma_chan;
 
@@ -17,23 +18,26 @@ void iio_dmaengine_buffer_teardown(struct iio_buffer *buffer);
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  struct iio_dev *indio_dev,
 						  const char *channel,
-						  enum iio_buffer_direction dir);
+						  enum iio_buffer_direction dir,
+						  const struct iio_dev_attr **buffer_attrs);
 
 #define iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
-	iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
-				       IIO_BUFFER_DIRECTION_IN)
+	iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel, \
+				       IIO_BUFFER_DIRECTION_IN, NULL)
 
 int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					const char *channel,
-					enum iio_buffer_direction dir);
+					enum iio_buffer_direction dir,
+					const struct iio_dev_attr **buffer_attrs);
 int devm_iio_dmaengine_buffer_setup_with_handle(struct device *dev,
 						struct iio_dev *indio_dev,
 						struct dma_chan *chan,
-						enum iio_buffer_direction dir);
+						enum iio_buffer_direction dir,
+						const struct iio_dev_attr **buffer_attrs);
 
 #define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
 	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
-					    IIO_BUFFER_DIRECTION_IN)
+					    IIO_BUFFER_DIRECTION_IN, NULL)
 
 #endif
-- 
2.53.0

