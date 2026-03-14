Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830132C15A5
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530042; cv=none; b=dYtPZuylYBbOqaOojDHFy74HEitgSxQFplm0ezY0qDJ8nhIMIuCLnpSNi27R826PjP005gkEDolBsyj7oSbovxwfTQOWpLD8V3zJLkUgsEKcRk6KhobuTXQGWck+Yfw60FCjZjBsQYhj2KFVhgE2zz+IKnQJ9mPkSdvrnomEfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530042; c=relaxed/simple;
	bh=fGfyis6t/Ry46Qwb8/dBeCQRr3Wr1f8vI9aiWWfC998=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOXVClRfTQZGl5RpaZ9sEZqpm9PyN9ZD2RhK2aBWe8DKCyo0u82tPTv6kKjPieFCwvi5A8faBXEnV+Rno17wzxFQhW/aIKAjq5wOfKdDtmFHkJTlS1y0IZjecwcFg1Ek88V4OHrDLFnes5nW9qqxv7PAk3vvV2aRbuNTkXYxSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=acpL3WBe; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="acpL3WBe"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67bb04151dcso1948646eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773530040; x=1774134840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MicAn7Xk4zQrWKvmWkO1TXtuDrpRHYiaI+ZEk3zmLk=;
        b=acpL3WBeGPxGoMSU3qQhNMRaybBK2MjN1eOANq2jAtKwJaEUjCsFnV+lCYS6KhKL5J
         F4LJ7uVocZbKuHu9hXF5N4ochu466p0lfoesN/B44x5CGTvG63kErxonCCFqi748sco8
         l3OsbzCShtUL+o5EMEwheCWasiGJ7VRuMuhkHNhupTeIP/4JEkF7NXuuvwa1TRtfB/kw
         rPj4zEjo9fFe8iVTS53F2y12ykfOF4DzE4yeKYJlAi4sivrjnR6TWzq7yEfsSnl9Y+z9
         1pwLW8ZZMlmnvwfw2Eej+CtUZnCeFIPn0UTFmt/Xpi9iB9wHRZ8e7Qmu2j+1S4k0H5tC
         XiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773530040; x=1774134840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9MicAn7Xk4zQrWKvmWkO1TXtuDrpRHYiaI+ZEk3zmLk=;
        b=DVZ6Zu6lB5nOuMOWj4bLsvgIzkLIpnaKNuLrtkuAZ8+kEczHeNh36oMNOc2Nr4AYHH
         E+/pRCkK/0Z4hAmCJdZbX76XKr97sGfNcgapAWrzqTSsFO5IrK0rOPlszSPEqeXuwJyj
         acffdtIxn4xeO1oGV3FeLHx2AqCKUraUJbPSStSU5g2kryNZQEZV/SBrbO+V3Tw3qL6v
         92cZpQ2e3sTOUBbjROxdAMo8bS/4TrOGdJfrYP9kO8cmJjVjPtZr/WZ/7OHDweq6pT4L
         Anuvhtgu7AKhdkUEG4B6mw4zSjIYr097eRFSgTn9IScS6lWPcXL/PP1XKoeZQ/NsGxfn
         i71g==
X-Gm-Message-State: AOJu0YxTeRWUQz2H0j0T54/m5gyylulEuIa7Ohnj48GUIZuToXBaY+oZ
	Ppq1+4E/lj85eWLbtoSEFFoaSNymCkWt7LI2Ek1sqLtye3SyaVhDQgyoSpbobNLaFNg=
X-Gm-Gg: ATEYQzx0GiWoumrLchdJsdBOL9alQIYBcowAObdQ/ZfMKpN1LFUOXk6DjGRJD+FLPJn
	ckSmUi0+iyWXEoY7WRGPCXnfJ3P8hBUXiUvVNa1I5kw42szq4UunlcoXNPokTavrJY+oHq2NpVk
	wZ4h9Kv4amE06uQQQpe7Fc80skU1gGWA+ZjAZp15kTsCA6L9Ulchp1mrlhnR25zjNZcmcP/9z70
	Xss4GgQ97WT8Fbs9cIr3SNujIY7mK6l88LoQsDlX7I3Caa70aFZyY9IQrwWLWCj8Go0ehHe28HU
	UuREFcA3sbRxC9vNtAWg8hNZdFA6oHSHo5BHBIh8xn3Fqpw9nDWH2aMiB1bPzAdn8ScS/PaWBQ+
	6oDj14RIA8kX3Jon7tYYu8bmkvRWHCOPS0VqwxJj1BgYVPUVHYs6Xn5xhXuQKSiBZTpb/PbdlgX
	2e+w4nQSoF9gIrxtBT6Yl56iTVDGo8psfEver90f0=
X-Received: by 2002:a05:6820:468b:b0:67b:d754:9524 with SMTP id 006d021491bc7-67bdaa2fb76mr4435577eaf.36.1773530040425;
        Sat, 14 Mar 2026 16:14:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc93279c6sm6850885eaf.12.2026.03.14.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 16:13:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 18:13:31 -0500
Subject: [PATCH 1/2] iio: adc: ti-adc161s626: fix buffer read on big-endian
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-1-56243b11e87b@baylibre.com>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
In-Reply-To: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=fGfyis6t/Ry46Qwb8/dBeCQRr3Wr1f8vI9aiWWfC998=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGm166ShrTRsFVGRM4hqPPObB6pf9bkQp1bzSjMgmz4saLX9J
 okBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJpteukAAoJEMLMIAH/AY/ArAgH/3LT
 Ub/8cusfHRw5Rrbj5/T5ZbSWSevPRM9LCBdSfWKtivbBqC8kHdjlImZQMcY27I84ddBjaP1puQT
 ACZIAoN4oKuefkJF7YkeYunRPjNIN6dtZV/NBpZj+j50jt+G4mPhzGrSP+zJ2qKuHGX2zAAap/n
 +EjfS5DgAGuPLWtD70GD/XW8Z7ki+jgBtWU7jUS2O3XW7YbioS0unMBU5fYiaOCZW3kGGcCuHJZ
 csuxdJKY29xM9Q3v9KYW0k1LcHd9/O1TL4DweXDpJCcCUOXqpP1YDgrli927yd0oDSxbPJ4MXON
 KMLB/lHUbeeeMy8E8u3y+ON7JRyAdxyFeIuWrE8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rework ti_adc_trigger_handler() to properly handle data on big-endian
architectures. The scan data format is 16-bit CPU-endian, so we can't
cast it to a int * on big-endian and expect it to work. Instead, we
introduce a local int variable to read the data into, and then copy it
to the buffer.

Since the buffer isn't passed to any SPI functions, we don't need it to
be DMA-safe. So we can drop it from the driver data struct and just
use stack memory for the scan data.

Since there is only one data value (plus timestamp), we don't need an
array and can just declare a struct with the correct data type instead.

Also fix alignment of iio_get_time_ns() to ( while we are touching this.

Fixes: 4d671b71beef ("iio: adc: ti-adc161s626: add support for TI 1-channel differential ADCs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-adc161s626.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 28aa6b80160c..1d427548e0b3 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -70,8 +70,6 @@ struct ti_adc_data {
 
 	u8 read_size;
 	u8 shift;
-
-	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
 };
 
 static int ti_adc_read_measurement(struct ti_adc_data *data,
@@ -114,14 +112,18 @@ static irqreturn_t ti_adc_trigger_handler(int irq, void *private)
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ti_adc_data *data = iio_priv(indio_dev);
-	int ret;
-
-	ret = ti_adc_read_measurement(data, &indio_dev->channels[0],
-				     (int *) &data->buffer);
-	if (!ret)
-		iio_push_to_buffers_with_timestamp(indio_dev,
-					data->buffer,
-					iio_get_time_ns(indio_dev));
+	int ret, val;
+	struct {
+		s16 data;
+		aligned_s64 timestamp;
+	} scan = { };
+
+	ret = ti_adc_read_measurement(data, &indio_dev->channels[0], &val);
+	if (!ret) {
+		scan.data = val;
+		iio_push_to_buffers_with_timestamp(indio_dev, &scan,
+						   iio_get_time_ns(indio_dev));
+	}
 
 	iio_trigger_notify_done(indio_dev->trig);
 

-- 
2.43.0

