Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862417;
	b=UrmkvnVSBYWRITQsiP33NKj/kjp0V+lA07k6IBVm6GAfQHUpA41Jb95APt2jPqhQ5TyS
	 UoAhCxQ6u9Kz7TOAb7DemrkP2C1gassDYXMLnXfcz1R0zkmqsM7/lqpJcTxZkASqvjmnR
	 zXXaWNYQQdOwKPMQB9EKzZ5OSUtVfsPM3fUnHYsvgwvKLcAWcwUI/mUfn5R7fPo13mEd0
	 YeAnn3d3geaIUySrFxDbN4NDjKZ6/PU9X5I41diykXSDkcpLjK6OFGMnXEjzbRE8ZfEoP
	 hdQfnZzTKCbK5T6GCgZrABnFvRbsTEMmS29pa5QITyucwmEWNGYXOzDNrKpnPa2Pthw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
	b=3LSy04ue96x4zGCykivxmS2dBXsDKdcuYM2vZEEUt6+aeW5AKhd8/ptCZCd+5Zwako+Q
	 eu1lEdCiQ6WaWtNYbTlZTcN9DCk5986gK97sMqHw02L34YTT54UFgrha3h8VgrFOPlG/L
	 CsFNFFAsSixrqilCe4e1dpA4mWgBLh+m0BXHI9EPZJuDF3rK/NMHJKt5/EZ/8m0k5mf0s
	 XejTHjF0Q4mXQsb8nXA9DMhJ4jAgE6rFJY0m3VNGza/kXCbxVgdnotrgkRMhiupP+gTqP
	 f3et1JQNycTXiHVHV3B5uGlb83r5EmJt9L4+KsapDkpR0Fv+tvBv52bYiHTzFqZGjHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xW/z8CSs";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AA606A33A
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 20:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B05AA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xW/z8CSs
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a3c08d6928so5461635c88.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 12:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862416; x=1795467216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
        b=xW/z8CSs/dQ+KxWFVc7iuaSL2cI3AXnL72PhWAygJfADarjfqHeHIhtR95mBzNFUfZ
         qkDDLRNkpcnZz04fr0Hbv+fAI8tXoiBsNcIaDdfywCdYZ4AuumbQmERMYcGDKvnIao/L
         kDb56Q/OJM9ZOdfHIou7VYP47gE06GfSku13Ytho9A9+wjbXvA//nVczilMNdS3ge3dS
         IZUynst+XsGZxHuVHRkWXVQt20kHbNw5df1tKEZXGV7AXU3lrvdDQvtirfPpqcQBdTjI
         Oi6qGqWBfnhTApD8t2aadBkSwDk7jRGZNfRAGmdQPhT6+uIrDDGjFILeesvXPlbZRBB/
         ZB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862416; x=1795467216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
        b=t+jwQK9/Ffzj1mjW5BsRtqy9omRzP73XdW9Fx9KgE7zbba+/iFua5TNtkJrIrgYyCL
         Xh6vDjljFuQobvdrXyEgFh04i9acVToQclELvK6GwtYx50OUDdlfcT8FPAkV/jDD1uNw
         vE1+hWFADa+bs/SWtJ08a+wY9rbaTyqRpprWv83oF+Tcp4Ti6EPjS4SfFR4GghNl4aD8
         wEZ8wgfyUK5WaDdHiAkdDvSMkOMv+MQqJEX/c6/ssoOQ8qN0X8/o9KmUJiFzPOyRu1Po
         BosYTlEsCRzXx1wHnpi7NrhF/I4GIo6Bh3LzcFqi5ISt5F3wFDFjA353Wxr19cz0c8df
         aLNg==
X-Forwarded-Encrypted: i=1; AL+hErEkKS3Ct2HTYRjHduv1kCmDCtYFJPgLVYsIX/iJvjDZnIJoN0AvTRw5H+SWDCGsfyNCCEP+mj+ujc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z++iodRsUy18fDV5d3PfcWzLPO/AY/tDz/LzN7trAUlkA20MEpW
	KUX0ZnD9ffx1Vs2Rlqy6EIfKwpruklkwcmgecduFRKaRigWT5VjWlT32
X-Gm-Gg: AYBFou1c9yHvPKo8vfolWQDc0SebK1o8CpLHCBv5H6JeP4DJW7M3eFX0Yy0W/bA3QoM
	EeuDmh65UfBfA6tIcgaVOgrXwJJI49AGOVlz45U+SaQUebcS4B8VeiRpx6177yPlxQxtLYPAijW
	KO8C3ihs4Kl+wNsf/Gp+8mj4rQwd7fLzXlVseWG2C3br4OnpqMIE5wUuEiQtcvnsbvdss3UCqE4
	LTQudXui+BDB0OtgaaM/EOkifxLUkTadQvEeDHOhHPTUNW+zcEB8ilsDVD7iTQvTA1N+Nf1LMqD
	z0cPSP9MlfgyjgIydstX6M65ib5J+M5u39JTGdarHObYxijlTK7gddULonhCx9EWgEZqIBFiZSY
	vwHaCgo/VYwoBe7QUbRv0cspxk9awgZH8hyr+LeSWHYaYbrxQ/sirAXo0PqO0IRHTvGEpKR4scW
	FZqwYXE7LdBGBWgQnlahQ0UANM9p7Av1Xv1nsPiEim9zPrGm5kNWFVPtl22rkLf96RiO5ZNy7jJ
	lXXyMvBpFeLZxxIdkVYJBaIopqDl+UWuy0Qu1n1UYayW86jHjXhAwOEErq8PafU7fGY+KUPFSMH
	WIq60tgtTv+94kcAzQi8olMRA1M5vnT2iEJnQqe8QmkbE0olxP3ELTg+XZsG+4yR9FrfV93iBpx
	WdmL7i2CkpKfFyYr6tJbBcrMC1OZaQgiEbYidSCM9rifla6BG137iu2lPvkfMe+4W1keknONki3
	Vn19GoyYtIWrd/ZAf1LwbtPVXBhPapZthC66VJn/C4Cw==
X-Received: by 2002:a05:7023:a42:b0:1af:16c4:d06b with SMTP id a92af1059eb24-1b5030a3490mr10088341c88.10.1794862415822;
        Mon, 16 Nov 2026 12:53:35 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm15293497c88.4.2026.11.16.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:53:35 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 1/6] iio: proximity: sx_common: fix raw reads while the trigger is in use
Date: Tue, 17 Nov 2026 02:23:09 +0530
Message-ID: <20261116205320.26070-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116205320.26070-1-kapoorarnav43@gmail.com>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx_common_read_proximity() only reinitialises the completion after
waiting on it, so a complete() that arrives when no read is waiting is
consumed by the next read, which then returns old data without waiting
for a conversion that includes the channel it just enabled. This
happens in two ways:

- The device trigger has no validate_device(), so another IIO device
  can use it. While it does, set_trigger_state() keeps the CONVDONE
  interrupt enabled and the IRQ thread calls complete() for every
  conversion.
- A read interrupted by a signal reinitialises the completion and
  returns, but a CONVDONE interrupt already raised can still complete
  it once the mutex is dropped.

Also, when it is done, the read disables the CONVDONE interrupt
unconditionally, which stops the trigger for the other device.

Reinitialise the completion before enabling the interrupt, and leave
the interrupt enabled when the trigger is, as set_trigger_state()
already does for pending raw reads.

The interrupted-wait case was reported by the Sashiko AI reviewer on an
unrelated sx9324 patch.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx_common.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 4d4937395d9a..66d06435da05 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -167,6 +167,15 @@ static int sx_common_put_event_channel(struct sx_common_data *data, int channel)
 				     data->chan_event & ~BIT(channel));
 }
 
+/* The trigger needs the CONVDONE interrupt too, leave it on while in use. */
+static int sx_common_put_convdone_irq(struct sx_common_data *data)
+{
+	if (data->trigger_enabled)
+		return 0;
+
+	return sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+}
+
 /**
  * sx_common_read_proximity() - Read raw proximity value.
  * @data:	Internal data
@@ -188,18 +197,22 @@ int sx_common_read_proximity(struct sx_common_data *data,
 	if (ret)
 		goto out;
 
+	/*
+	 * Forget conversions that completed before this read, e.g. while the
+	 * trigger was in use, so that we wait for a fresh one.
+	 */
+	reinit_completion(&data->completion);
+
 	ret = sx_common_enable_irq(data, SX_COMMON_CONVDONE_IRQ);
 	if (ret)
 		goto out_put_channel;
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq) {
+	if (data->client->irq)
 		ret = wait_for_completion_interruptible(&data->completion);
-		reinit_completion(&data->completion);
-	} else {
+	else
 		ret = data->chip_info->ops.wait_for_sample(data);
-	}
 
 	mutex_lock(&data->mutex);
 
@@ -212,7 +225,7 @@ int sx_common_read_proximity(struct sx_common_data *data,
 
 	*val = sign_extend32(be16_to_cpu(rawval), chan->scan_type.realbits - 1);
 
-	ret = sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	ret = sx_common_put_convdone_irq(data);
 	if (ret)
 		goto out_put_channel;
 
@@ -225,7 +238,7 @@ int sx_common_read_proximity(struct sx_common_data *data,
 	return IIO_VAL_INT;
 
 out_disable_irq:
-	sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	sx_common_put_convdone_irq(data);
 out_put_channel:
 	sx_common_put_read_channel(data, chan->channel);
 out:
-- 
2.53.0

