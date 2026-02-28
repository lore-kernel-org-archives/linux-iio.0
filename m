Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF91F5842;
	Sat, 28 Feb 2026 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247883; cv=none; b=BdP1ptGlDnwnnTOqhlwQwCCEyGfwolejEN6CtY4QaOvAx77XpWQFvh9GvYJkn089I3mE760sBow0uQRK4osIeM55A0d1/y3DBGnktsj1VsqOxxilds3LfQyVnU7BMWEFzmNF784mycXyQMX1kLOxw6wiFfinNDVjRyt/kQNjU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247883; c=relaxed/simple;
	bh=5mfcAIhNSUPx0pw0tUx+Mr8DKvh0NdGx5n72xzcHtyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l18XdLjfbVBUIHbgWH7FaPJRWY/PYNOjvLsxTVIfWHTQDzz+J9X6t87nD3HSihUb6vY1LtqCeqED1mBTtQdy3WnE/MYldC5tPwIrv/MTt0VylwlTS7CI60h2xZp2D9M8wHb+u5pNFizUqatjW5OUlrhjyvcxCbLler6NB6DEyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ps9iY5y9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ps9iY5y9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Au
	Z7PdXXTgpZbi3GTYkQovZq9tQJfN8+WdIW4VKGn28=; b=Ps9iY5y9jLPIll+CZ6
	CxsaKkdJKLu1V90Qj7IeZy8SukyzuPMbCajqSyIavX02FjP4e2H+3Msxq1mUSNhT
	amqd0jN+1AhbX3ko+ZzZ/G20JMjVB8ckAqvt1kyFkxrmMukS8v1ymMFgPHfA6xXU
	1CV4UjGYD+vszTlFXFIsb7prI=
Received: from fedora.domain.sensetime.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXj+QrW6Jplb23PQ--.48492S2;
	Sat, 28 Feb 2026 11:04:11 +0800 (CST)
From: junan <junan76@163.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	junan <junan76@163.com>
Subject: [PATCH] Replace NULL thread handler with a dummy function.
Date: Sat, 28 Feb 2026 10:36:46 +0800
Message-ID: <20260228023643.12000-4-junan76@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXj+QrW6Jplb23PQ--.48492S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4UtFykZF1xKFy7XF17Awb_yoW8tr4rpa
	9Y9FnrKr1kKF1xuF1j9Fy0gry3tws5JFW5WFZrX39Yy390yryvkFyxt345Za4UCry2qrW3
	J395XFy8Wr4qyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE6pBsUUUUU=
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC1AzklmmiWyzvMgAA3L

Hi,

This is a similar problem as [1]:

[1] https://lore.kernel.org/linux-iio/20260227071409.aEG-iBFD@linutronix.de/T/#m15ab81856b42f72169fe51bd87fa399b5147441f

Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
in IRQ request and gives a warning if there is no threaded handler.

There are two iio devices on my machine:

```
junan@fedora:~$ ls /sys/bus/iio/devices/
iio:device0  trigger0
junan@fedora:~$ cat /sys/bus/iio/devices/*/name
als
als-dev0
```

The function calling chain is as following:

hid_als_probe(hid-sensor-als.c)
	=> hid_sensor_setup_trigger(hid-sensor-trigger.c)
		=> iio_triggered_buffer_setup_ext(industrialio-triggered-buffer.c)

`iio_triggered_buffer_setup_ext` is called with a NULL thread handler, and the flag is set to `IRQF_ONESHOT` inside it.
I am not sure which flag to change, so I replace the NULL pointer with a dummy function or can we just change the flag?

Signed-off-by: junan <junan76@163.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5540e2d28f4a..ec251beeca92 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -202,6 +202,11 @@ static void hid_sensor_set_power_work(struct work_struct *work)
 		_hid_sensor_power_state(attrb, true);
 }
 
+static irqreturn_t hid_sensor_dummy_handler(int irq, void *p)
+{
+	return IRQ_HANDLED;
+}
+
 static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
@@ -240,7 +245,7 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 		fifo_attrs = NULL;
 
 	ret = iio_triggered_buffer_setup_ext(indio_dev,
-					     &iio_pollfunc_store_time, NULL,
+					     &iio_pollfunc_store_time, &hid_sensor_dummy_handler,
 					     IIO_BUFFER_DIRECTION_IN,
 					     NULL, fifo_attrs);
 	if (ret) {
-- 
2.53.0

