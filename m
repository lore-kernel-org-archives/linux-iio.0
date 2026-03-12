Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B003976B2;
	Thu, 12 Mar 2026 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292435; cv=none; b=bL8uvPGF0kwd8qfdQFA1ZG8UqN9JzVCxwhjCCgZ2jD/LfQ59wkxHQvVE5vK9ao/aK6sGoTH162q6KEKwaAxA9p30u6vhszSZJ2Xw9F4CwsROfz6d3YTIZBFQ/IzFs2MAg4FWMPpR6O7UdVp5S4UhoI4An+Yxibsytvs55N5InAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292435; c=relaxed/simple;
	bh=cTOfBxHzfarYeGfNaDbiX5oNBEoFTS+Badi8sCb8hV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z8YGmkTx1f3TaEkhrEwwWihK87l3P+oZ5faIJzWuGYjx1TcgpTBE6gHXAFajAQPsQoNDVdkuUdVceuGVvhG2FGcdc7kG4qXlT+SzQvnbKsAhvkmMC6gpDLS0HfSmBFFdQ8O+ldgciVQMh23I5x2gUOWEBh/pO30mJaANPg8td28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vSy72RjV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vSy72RjV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8xmSRS/soK7btPTkWRRQk60dsAQtRusWAyvVEzeVOZs=; b=vSy72RjV2Gjend3Pf0+Ru8uk55
	XQZ9mqunlfVtHZ85uaKbjJ3ly0uAtS+a/P/F029ereGHM15J0KA/L1LnOiqUZq2PWQXJHwOeUCDc+
	MtV5ABp1ro6gyKNFxZKL6lcCT8RDS/RGmevdN4iQLEAbcozmjRHppLG2Avm+QabGxfR+N9gKbffvf
	9siV5k/iRyS7r+CtxFE+bowILId2iBaixvXI15OfKa3jm2Y3MRea+j4C37os7VZqLreuGmVko36VR
	w90PeISpP1j98kn7e32+aeG9QpL1Y7cx8lUptgUhG37sDYGuAw3Wxx4mm2nvgalQyVJimMx9shdlo
	qTs/l3og==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0YMq-0000000DL63-2awJ;
	Thu, 12 Mar 2026 05:13:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: st_sensors: correct kernel-doc issues
Date: Wed, 11 Mar 2026 22:13:45 -0700
Message-ID: <20260312051347.681042-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the proper kernel-doc format and struct member names to avoid
kernel-doc warnings:

Warning: include/linux/iio/common/st_sensors.h:184 struct member 'int1'
 not described in 'st_sensor_data_ready_irq'
Warning: ../include/linux/iio/common/st_sensors.h:184 struct member 'int2'
 not described in 'st_sensor_data_ready_irq'
Warning: ../include/linux/iio/common/st_sensors.h:184 struct member
 'stat_drdy' not described in 'st_sensor_data_ready_irq'
Warning: ../include/linux/iio/common/st_sensors.h:184 struct member 'ig1'
 not described in 'st_sensor_data_ready_irq'
Warning: ../include/linux/iio/common/st_sensors.h:219 struct member
 'num_ch' not described in 'st_sensor_settings'
Warning: ../include/linux/iio/common/st_sensors.h:263 struct member
 'num_data_channels' not described in 'st_sensor_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/iio/common/st_sensors.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org

--- linux-next-20260311.orig/include/linux/iio/common/st_sensors.h
+++ linux-next-20260311/include/linux/iio/common/st_sensors.h
@@ -160,12 +160,12 @@ struct st_sensor_int_drdy {
 
 /**
  * struct st_sensor_data_ready_irq - ST sensor device data-ready interrupt
- * struct int1 - data-ready configuration register for INT1 pin.
- * struct int2 - data-ready configuration register for INT2 pin.
+ * @int1: data-ready configuration register for INT1 pin.
+ * @int2: data-ready configuration register for INT2 pin.
  * @addr_ihl: address to enable/disable active low on the INT lines.
  * @mask_ihl: mask to enable/disable active low on the INT lines.
- * struct stat_drdy - status register of DRDY (data ready) interrupt.
- * struct ig1 - represents the Interrupt Generator 1 of sensors.
+ * @stat_drdy: status register of DRDY (data ready) interrupt.
+ * @ig1: represents the Interrupt Generator 1 of sensors.
  * @en_addr: address of the enable ig1 register.
  * @en_mask: mask to write the on/off value for enable.
  */
@@ -190,6 +190,7 @@ struct st_sensor_data_ready_irq {
  * @wai_addr: The address of WhoAmI register.
  * @sensors_supported: List of supported sensors by struct itself.
  * @ch: IIO channels for the sensor.
+ * @num_ch: Number of IIO channels in @ch
  * @odr: Output data rate register and ODR list available.
  * @pw: Power register of the sensor.
  * @enable_axis: Enable one or more axis of the sensor.
@@ -228,7 +229,7 @@ struct st_sensor_settings {
  * @regmap: Pointer to specific sensor regmap configuration.
  * @enabled: Status of the sensor (false->off, true->on).
  * @odr: Output data rate of the sensor [Hz].
- * num_data_channels: Number of data channels used in buffer.
+ * @num_data_channels: Number of data channels used in buffer.
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
  * @int_pin_open_drain: Set the interrupt/DRDY to open drain.
  * @irq: the IRQ number.
