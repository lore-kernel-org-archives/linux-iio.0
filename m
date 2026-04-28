Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626943C043
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388014; cv=none; b=N8UeXqKDjJTSJB0jm8RdgUGPQw6tijdf3GievnOouHWYKWhCEtaLc3uBcv/NGvq7KEiPpf+N6SM7iCalYETdoXorjFWg2dE6ZwTuBZMkn7PEy87Y1I7ryF1sU9nTqCyPyg3UfmZLLw4UXKgBR95z6ue31JETGHNgGIqVhSVybhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388014; c=relaxed/simple;
	bh=FvH2Tq9sg2iWFKvI2rxoy04fXf16C8+o/UVOEHdEM7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rTle5MCChKlM+7Q1QACMvvvAipkBLLKkzzqr9DIZi9rnCPf3lS2ELLooiHLalsBjlsr2S3OskFB94sKEoi9Z8373kWQM+vrEIoXmET42uwKKTwNjC9qpsK52arWJna9DW/hq8R8frxQwHOEzfkcUZQIcxmnCPWnC8vvs2f1BCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czh5gzhj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czh5gzhj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so6891473a91.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388012; x=1777992812; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MCksz8OXzQRknN88hplFcT6UVgogcBC8tS3XrnLpgU8=;
        b=Czh5gzhjTmvVGWmFQYEJf5EFMepmgp6jSkqMqPoXr/waprXmICnL+V9ILzd01av5B9
         mu7BlCQJ6/AAkcExl63RNPxs73VZvdjlbWhCX6Q/AJBWlInqdDJx7Rf4EB0VIn7tkUj8
         +ccLmBxTs5MpppEL/eynJ6G18A59IFQ9Da/E1xxQpNEBfVLpg9erfPiU0X6346dhubuu
         nWFLS/uC5xm0Oee1jjgO2RItDmZfKU4Gx5ydXPqSBsld8urixM+huhusXZMLHX579QZ6
         fe8psiYo0IEMf4aXEa1LO5WEB2o3IcnWWovrcsACYE7cw4I/bEVL23YxD3X6YpxHaw4Z
         i5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388012; x=1777992812;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCksz8OXzQRknN88hplFcT6UVgogcBC8tS3XrnLpgU8=;
        b=acq8PJj5PqWfW23TMUMECdFqeXUBQWvuyU2Tq2BUrSubR1ymgkee+x4u6MdaHozqzW
         ve5lSKx/pUOQSRV+yiPkpDKp0qTx0tGo+JzsQ/Ke3T8HN2Gx2SkN2s89VlETJi3UNoJt
         QamGap7MHCE/5vfSrsoPI1QK2VaPR8haTuQcMfBuIxU0wUWHYECLwiOmLmnA1M1X3YPH
         yi7xxjfgH4PONLr5OxE5vz+sp4ryIqeC+WzkTsHIApXD+q+6yawF8jFuuo+VQeAuS71z
         +6zNBZWtJWxcoDggyXd3yKDyaNbIWkREy9rTarQOA7Z3VzBmD9tAoLJlLaF+7K6hZMKr
         Gz3w==
X-Gm-Message-State: AOJu0YzTpg3YYGVb45L+5iZYJAeXgTMQq41wby0vLoJbkpGKkrb7krEH
	6wRBTg2UMO9IE7lpPKk5TdVTM4AtkwRugcHMjfzkARIHf5S3hUP6BWpO
X-Gm-Gg: AeBDieujrl4h5r8LWSlQWrrdVb0zKtHq6JEfNWg+fsLV2aB84p+dVV4JUbKYJgsJsr1
	vRd6Wvw1YeXaN0NAbDXFI3QUtxRwX37dVErjKtCvXx/qQWK2UVl7aN1N02GxUBpzavpyN6ywp0c
	Wd0y4yExs0AnTJnN4wtBNC85snb8B+xBVHW2Oj6DTPKq0yTIYv8HLKtRxTpSt/vQbru1oB8g6b9
	cYTf9+hVRr5eLCNSZirIb8G2v1/ruyuPzMZ3q/lKYqYMnUDB4EuU7p75kuartKxdpxNGgOPdiDg
	C3EWn1wIvOWk2KRLksRd/YttzYn6qPObQn3Sp6GVWQVIpw/uS4dkglA5Z0RxYAaEDA84nYsN67z
	7AMseXk8Tr0kw40j74HsJGy+5qMOeK3CChPwvqJ1JN+BScapnWH1ZLSVakUDJcYlV6YXIi5uW2+
	V8W8SJVZO5zybfphE9qmVSCwaUT12fpN8z2s7xjC1NkNXD8u4iq6VI9rXKXXlVkhjOXQxV0wUw/
	Vzz1soFdbnt0k83soBHxJrJw/uh7J4=
X-Received: by 2002:a17:902:f645:b0:2b0:beb4:3bb with SMTP id d9443c01a7336-2b97c3f602dmr34619955ad.10.1777388012083;
        Tue, 28 Apr 2026 07:53:32 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aa7bbd1sm31950885ad.15.2026.04.28.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:53:31 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 28 Apr 2026 22:53:25 +0800
Subject: [PATCH] iio: buffer: hw-consumer: fix use-after-free in error path
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-iio-buf-v1-1-dcc63ff7b800@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOTJ8GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3czMfN2k0jRdk2QLU1NLAyODRFMTJaDqgqLUtMwKsEnRsbW1AA4
 VIxpZAAAA
X-Change-ID: 20260428-iio-buf-4c8559020a54
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777388008; l=1749;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=FvH2Tq9sg2iWFKvI2rxoy04fXf16C8+o/UVOEHdEM7s=;
 b=omBp2ylCwZOKjbt6WVarpP82l/pR5nrpV801kKwbJG4XpUGT3yRkVfdz1EjL59h8k+mL7/Hhe
 NBfisK7dZmmDfwCDLANoEgzQhUHhDmaPCCm7xorLrR8UlzIIReqBX4Q
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
was using list_for_each_entry() to iterate through buffers while calling
iio_buffer_put() which can free the current buffer if refcount drops to 0.
The list_for_each_entry() loop macro then evaluates buf->head.next to
continue iteration, accessing the freed buffer.

Fix this by using list_for_each_entry_safe().

Closes:https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647%40gmail.com

Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 24d7df603760..7406efefc123 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -85,7 +85,7 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
  */
 struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 {
-	struct hw_consumer_buffer *buf;
+	struct hw_consumer_buffer *buf, *n;
 	struct iio_hw_consumer *hwc;
 	struct iio_channel *chan;
 	int ret;
@@ -116,7 +116,7 @@ struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 	return hwc;
 
 err_put_buffers:
-	list_for_each_entry(buf, &hwc->buffers, head)
+	list_for_each_entry_safe(buf, n, &hwc->buffers, head)
 		iio_buffer_put(&buf->buffer);
 	iio_channel_release_all(hwc->channels);
 err_free_hwc:

---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260428-iio-buf-4c8559020a54

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

