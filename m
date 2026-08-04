Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60093E558E
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887046; cv=none; b=lIhK7L5joiBYgwgqp7coEB1iX4Jqy6EUfDcM1qCA83TqxB4GSXhEdXJtdbW+RZFkC9ZI/0iCe96JyhV87UMLBsQjvY2uhnun6HokV+c6ZV83ZMy+eB0jEFgT7LuKKLwZxShhzOV3i3/JGv8xjVzF3c6NHEkrGazrymXwalLoyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887046; c=relaxed/simple;
	bh=DtTbt5i+D2OCvx/aRI5XRtXiLSS69WHUcjWzWwTq7qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNoTm5OaEYTFziHpzO+HJKAA6B5LzWavFgNw+9oqdk0Afh5YhKAZskuOsdcHiqCUhRbTY4kxmOsivDWE6F7MDt5RehIs4KXolMgCrVLiNlS4uhrFp8ekc3iVgASoosP7PzUzocf3voAUT02Ffh1wYT+4H3Q3lc1o/jCAhMB+Yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXBAD0re; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXBAD0re"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfad59921so2774421cf.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 16:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785887043; x=1786491843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNEml4qcgpU6hriWeNPKlpjEWwzAoG1Z6BmVURttkRY=;
        b=EXBAD0re4ssfYYPJjzHztHiO1RJIsbEs7SUD0YQg/Fvu87PoKGS1VkyojaYEup2K0v
         BPxi1vgy3EdQmtYByEyeWmdStvcBHBA1O7tojSLbwBvV79PFFNqIcZbxYsB3zJ8takpd
         NW7lx0PMjhTCFFseG5lTL1M17a2yIqZUJlzGPZ7zICiVojbmrAn0A4hvodOwoTNT25e5
         pr1bTEJ2f92Jtvsf+AxiQTKYInpkCWbkHbG7fFmEZ5m7pb9NKoRSlzCbP6oei7+ls5bu
         dk/GB1qV49uBxjadSzTWGBbF9DdUHHUNCHdRCGqcn/7trXXilbsHmCGKqzJaMYytUmcw
         lUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785887043; x=1786491843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNEml4qcgpU6hriWeNPKlpjEWwzAoG1Z6BmVURttkRY=;
        b=bWZ3Ycvy0bWQrSAQBZQXGUtTV8hST5isqL085ewcEXnH6LX0UNHR2k7F0Tyw8lMy3y
         TeGhg1wAu7u6vSdezFgLPkmYgsG9ubFXtJzontGbplPL9/SQnLhmWjvNAQIeCScU3E72
         hs0qTEYOVxGcPohL8XS27cF0tmBqL6gUAVO0ZscFOr7E24FjKlMXvxjB5GHYZYDhjL9/
         j89P3n5J4B6r/HRVZzXkm+yvKf/IHgfHgw+1rt0YRxCansekdTltXgmn7MvgYsrNdJSR
         y5ws8dG/anC3sxz38k4ZtNm1wqwHZAkHVLBwSlOKWy0kEAPs0kdOLJ3xfYHfROYCWkg8
         1JWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+RfkeOA4SEHopKug5ZW6W0dnY8YFjTbx2/t2h22rTx5URKM/LV1fAU/+9VCFD4iflL4HaFPplNBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFW51t3X5THlmWIbiWdP/fDv/y/fytvnc8agbY8XD0v4C8Y8xM
	PGfP5QGZs/kjgCQV93cIPgjbOKbwtMrzdsv/hylaqnrXfjKf+0n5HOer
X-Gm-Gg: AR+sD12OXmWmfMKJbK1aefGiserHVdkiY7Fo4Ndi9mWJbF4My84gEIpNupKT9m7LzLQ
	O0ejzN9tRUEvM6eIK/DO8UTtgTg4U9IYoOP6L+zhNgklJF9E+aT6i1x3xlKv9xBheMeIoDKWWWP
	HdxcAt2gbccnqFZ3b3JXeueGS8b6Ql9kfL87nL/W5LjHv/ASoEexl/FDcSxZ86FAVd1s+ZEuoEw
	1asTGDqFI10+k8GpcRTYs0ACmhlHpyn4DDAYH5vsHEfQVJAedXl3+F7X2/CYObHir1zWcamG6Eq
	nZRU8KfEnBaH9qrgnKUw/ezI+OMGTbfxb1L11SpTM39TuomAnm5YVzwN45YQSoPYqc9gXbs5cdY
	wsfk42iVKL3uRL0jaHQQ+mt17MWAPcPMd6BesUTJyoo+PBbmd2/Yz63meBmkYCLCiAO6CYyVatx
	PoAvSfUJMAMfT8Np0rBt113qyymsL2cUGHnz/GQQ6ZQyA6dfLXeo9yV8pLsJr3Vqrvb+s=
X-Received: by 2002:ac8:5acc:0:b0:51c:61a:50e6 with SMTP id d75a77b69052e-52ce5f41d0dmr29604361cf.3.1785887043478;
        Tue, 04 Aug 2026 16:44:03 -0700 (PDT)
Received: from localhost ([2600:4808:5693:8201:bb19:d9f0:6e53:91ed])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffe09f0sm13298226d6.22.2026.08.04.16.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 16:44:02 -0700 (PDT)
From: Marco Chen <marcochen.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	pmeerw@pmeerw.net,
	matt@ranostay.sg,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] iio: health: max30102: fix NULL dereference in interrupt handler
Date: Tue,  4 Aug 2026 19:43:55 -0400
Message-ID: <20260804234355.65319-1-marcochen.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt is requested in max30102_probe() and stays enabled
for the lifetime of the device, but indio_dev->active_scan_mask is only
valid while a buffer is enabled. When an interrupt arrives while no
buffer is enabled, the handler dereferences the NULL active_scan_mask:

  Unable to handle kernel NULL pointer dereference at virtual address
0000000000000000
  pc : __bitmap_weight+0x64/0x98
  lr : max30102_interrupt_handler+0x48/0x160 [max30102]
  Call trace:
   __bitmap_weight+0x64/0x98 (P)
   max30102_interrupt_handler+0x48/0x160 [max30102]
   irq_thread_fn+0x28/0xa8
   irq_thread+0x184/0x30c
   kthread+0x118/0x124
   ret_from_fork+0x10/0x20

Read the interrupt status register at the top of the handler. If
FIFO_RDY is not set, return early because it isn't our interrupt.
Because FIFO_RDY is the only interrupt source enabled by this driver in
max30102_chip_init(), an invocation of max30102_interrupt_handler()
without FIFO_RDY set carries no data to read and can return early before
ever accessing active_scan_mask. This status read also deasserts the
MAX30102's active-low interrupt pin.

Since the interrupt status register is now read at the top of the
handler, pass the status value into max30102_fifo_count() instead of
having it read the register a second time.

Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
---
Changes in v2:
- Check FIFO_RDY bit in the interrupt status register instead of 
  active_scan_mask, because that was racy in v1, as pointed out by 
  Jonathan and David.
- Read interrupt status once and pass it into max30102_fifo_count().
- Check the regmap_read() return value and log on failure.

Tested with a MAX30102 on a Raspberry Pi 4 over I2C.
v1: https://lore.kernel.org/linux-iio/20260731184124.112124-1-marcochen.dev@gmail.com/

 drivers/iio/health/max30102.c | 37 +++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index c37316c86f14..b949ce36c248 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -235,17 +235,10 @@ static const struct iio_buffer_setup_ops max30102_buffer_setup_ops = {
 	.predisable = max30102_buffer_predisable,
 };
 
-static inline int max30102_fifo_count(struct max30102_data *data)
+static inline int max30102_fifo_count(unsigned int status)
 {
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(data->regmap, MAX30102_REG_INT_STATUS, &val);
-	if (ret)
-		return ret;
-
 	/* FIFO has one sample slot left */
-	if (val & MAX30102_REG_INT_STATUS_FIFO_RDY)
+	if (status & MAX30102_REG_INT_STATUS_FIFO_RDY)
 		return 1;
 
 	return 0;
@@ -290,19 +283,39 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
-	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
-						  iio_get_masklength(indio_dev));
+	unsigned int measurements, status;
 	int ret, cnt = 0;
 
+	ret = regmap_read(data->regmap, MAX30102_REG_INT_STATUS, &status);
+	if (ret) {
+		dev_err_ratelimited(&data->client->dev,
+				    "Failed to read IRQ status: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+	if (!(status & MAX30102_REG_INT_STATUS_FIFO_RDY))
+		return IRQ_HANDLED;
+
+	measurements = bitmap_weight(indio_dev->active_scan_mask,
+				     iio_get_masklength(indio_dev));
+
 	mutex_lock(&data->lock);
 
-	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {
+	while (cnt || (cnt = max30102_fifo_count(status)) > 0) {
 		ret = max30102_read_measurement(data, measurements);
 		if (ret)
 			break;
 
 		iio_push_to_buffers(data->indio_dev, data->processed_buffer);
 		cnt--;
+
+		ret = regmap_read(data->regmap, MAX30102_REG_INT_STATUS,
+				  &status);
+		if (ret) {
+			dev_err_ratelimited(&data->client->dev,
+					    "Failed to read IRQ status: %d\n",
+					    ret);
+			break;
+		}
 	}
 
 	mutex_unlock(&data->lock);
-- 
2.55.0

