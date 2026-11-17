Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913661;
	b=25pVS50ujA1Rl9Q4aIHVmnm8Wtmg/Y5kXKigYlNybCIh1GDAj1k3GKFuw/n1wisb6Sik
	 vEVX+LKZKCDZRRJQgXEdkdD6AAfhoWlKUGeA+LKB90Osn73nO5h6txNEp6DMAGYaxaILq
	 KQ9p3ggh8SHLEOFilRaa5HtHyxiuP/ouBZLZG1yJvJO3s2wFi6knAm4NAb+cG9PwYcLdf
	 ilsKIK/ObGT/2Ki+1oTxmmf2jGqrawYe6/ycw/wopbWFgoOsZ9IOhcgpIqTNMFOsa6x8/
	 Ues6Dkpa6iggj6uBPUMmVkEPIoKFV+uMbfdraJY5yDGT0cRxpRNxNDNIlTvmDE3Kxsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SDu+8SSFg3qgFJ8GozgNasE9VCP5i/wjR68oWFn0pao=;
	b=Lf7UXgGyIB8vPUBf+B/v4olHG5ENbty+MsuEfdGvnle6T6hgwLT3wL/+MWv9lkUMUpeH
	 NVOKj84sLR/arPxwWO1FuxNTZVGC4TyplTf/S4xlJ15XmW8uds0gePp+NkwZjCGsx0wgI
	 eWFMhddOYXrqLS6KWDMIKNt2ktf5yEl9+t+VSSGA3HVnebELU+CASXLLJYE49dSDMOK1G
	 EE3mBv5V2RyTJRfzC3cZhfZui31H8HI9GKZ4fGcStYkVZOx0PvX9yaE+XAkmCC/wQHVrF
	 bzGQ8/ccPxBlfNpNhT13KpnxYwP/NAcSlKVTTi/7V1iOn12b+IrtBahhIOM8l7BxOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f+Z4L6xj;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB143606A32A
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB143606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f+Z4L6xj
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be416e603cso3320002e87.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 03:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913659; x=1795518459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDu+8SSFg3qgFJ8GozgNasE9VCP5i/wjR68oWFn0pao=;
        b=f+Z4L6xj/dCgh5W9WP9jwevl1qBdc/IXGonzbBcUUUwG80wyK3QSzgIFTPJa66aCZr
         sFfdsmVLn1qq2mVmZT8He1t26FEF2/Z1+VbllkRIOssBeT09KnAaV5KnVoyL7ZhBqLYo
         2Md6mTiOHAWoRJ7hFWzGqAdVIV9DtnOpdnmAJ+yi0/A8hfGFlVKJdTQR+Nu49YHEo3cf
         HetZvk4LB9BB9BLLy0jThtOpZ0LlZyimUJqo0U4bnxCtkEXFiX/YoxpruM7Jpg2xGf2L
         6d9Drcwukh/6zOs4MvoU9sBRguxXrqlMMEGJnj0jOUr6eYbUi4lYGRl24XGSnZ2wb9Jc
         KGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913659; x=1795518459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SDu+8SSFg3qgFJ8GozgNasE9VCP5i/wjR68oWFn0pao=;
        b=aETaGdXWLkWaT+4PbEC2IsiaOJFABAqooAtfTr3htj6noIf9nHustNlFaVnysffgRy
         d7rAx+wONkvgduU3gFkn+o/O0s4AQjMTCea8YTFqJ2OXRtbKuRzKUyU+w5M75e6oqysP
         kJCXViGB1NIp4TqQlduDoiAIG8GLKUHQ3CKE7v08r7CXfoN3umLDMWInvfTOmZF7c0Nx
         ML90nYrIdb+LU7hNbDYxAXZCy3drLIW60SnPMxJHAn6RT93FwY7QlARxtpLQCZVQbVLx
         WsP4fTu2rPmZaNIqspXjms1Ik0lMMjOrn+e7Mb23c+qbjkXwWM8yQmro8gSZds8Bi1Ae
         glQg==
X-Forwarded-Encrypted: i=1; AL+hErEwM2uMXwCU6pB9enr7qXHZzedBQDVBcPCFtGkmscwvVrkcIh3tZw4gXEuaNazOAa4qm3Pi3werbb4=@vger.kernel.org
X-Gm-Message-State: APuU4Z87b/s+BBHlHI53iwwK5VOL2+RlYGWVtdxMDF83Na2KtJIQGvV6
	YqKVhzojVgokQOEl80Jrjp09BG/vlfgTmK7PQkPpYto9KNQBxS8n48uC
X-Gm-Gg: AYBFou3t45TuwFqiz4S0f0k+rAKyiviVogoIRn2dx4OLsxR7BRHTuPhiGaD9EkAZLlb
	1xZblclVzkk/UU87yWv5DnXDFn0pCa+SHHuVD/n/+XlwhxA24YYbQf5N17LfaqIXJQSG1hABSwr
	oQkh7npD+jwzyNzYKS5kPMBfyHF8qAK4f6AfNMjQ/PHKQP+GKnhwA4VLifpimsoBIhVZ/M/w4AJ
	01dfpdoSIll0++FnrUdzuG7PCmjE4H2O1fWpb1k7TDqUQW7LS4SePPzhTNWDw+0E3buVGjTDaAd
	26v9X/Y6imJkK//VmhjVyy0hlTcv9vgN/QFUnhHt7m1mLlwVwQVqwsrmmDgncyoajmZidJxxskO
	IUQKKXxD2i1Jme2DyKvBM0bNZujoM9J7d9NfcjBWvhvQDxSmm9Q0hXPDp8yoAAgaJ4uvydZYXFi
	FSzkE3DOVkEqsnnTE+K+anYMkil0PkpHhF761QhyPpChKojJGbqKGrojopweUb1Y/jD6JAC6cLr
	LemoeZOyRv4pqzE3CdIHMFY3APGtwfOR49grk+EYuG2MT2MfHHGZEGa+QU+mq5gtFwIrFb4mEJ9
	qdnd1BpvBLJZBrfb21vNwNjn0KbP7UQjqHAvorA9BIW1TEU/bbxHlpyqgouGQIo/xQRYvRnHY4/
	JWrkv3DuHEzKkfbMyM0RBrt8VkxvxSyDCj4+ccuGxI3gaHrYBncDxCWEGkg==
X-Received: by 2002:a05:6512:669c:10b0:5bf:d063:608 with SMTP id 2adb3069b0e04-5c1a132425cmr611403e87.17.1794913658742;
        Tue, 17 Nov 2026 03:07:38 -0800 (PST)
Received: from yantra.. (nekmmqtgno85zc1flee-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:5d24:e63:61b2:db16])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133c8f5sm3935812e87.44.2026.11.17.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:07:38 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: don't wait for new temperature in trigger handler
Date: Tue, 17 Nov 2026 13:07:34 +0200
Message-ID: <20261117110735.46400-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117033741.39724519@jic23-hlaptop>
References: <20261113230241.82046-1-zoone.rupert@gmail.com> <20261114013817.476f8fb9@jic23-hlaptop> <20261114083525.11972-1-zoone.rupert@gmail.com> <20261115010203.2a939bd6@jic23-hlaptop> <20261115183949.11591-1-zoone.rupert@gmail.com> <20261115203150.7faed0b1@jic23-hlaptop> <20261115223817.10568-1-zoone.rupert@gmail.com> <20261117033153.608b124e@jic23-hlaptop> <20261117033741.39724519@jic23-hlaptop>
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

On Tue, 17 Nov 2026 03:37:41 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> > I actually looked at what was messing up this time.  It was just that
> > int rc; had been dropped.  It's just used locally in this patch so I
> > put a declaration in.

On testing (d922ed738439) temperature read ended up in
dps310_fifo_interval() instead of probe. That runs with data->lock
held, so enabling the buffer without a trigger hangs on the board.

Diff below on top of testing moves it to probe, tested on the board.

Thanks,
Rupesh

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 9b52cbc2372a..ebfaa67a6b91 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1058,16 +1058,9 @@ static unsigned int dps310_fifo_interval(struct dps310_data *data,
 {
 	unsigned int drain_interval_ms, fill_ms, want_ms;
 	int scan_rate;
-	int rc;
 
 	fill_ms = MSEC_PER_SEC * DPS310_FIFO_DEPTH / (prs_rate + tmp_rate);
 
-	/* Pressure compensation needs a temperature from the start */
-	scoped_guard(mutex, &data->lock)
-		rc = dps310_read_temp_raw_locked(data);
-	if (rc)
-		return rc;
-
 	/*
 	 * There is no hardware watermark, so take it as the number of scans
 	 * the user will wait for and drain at that rate. Scans come from
@@ -1478,6 +1471,12 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	/* Pressure compensation needs a temperature from the start */
+	scoped_guard(mutex, &data->lock)
+		rc = dps310_read_temp_raw_locked(data);
+	if (rc)
+		return rc;
+
 	/*
 	 * The device measures continuously in background mode, so a triggered
 	 * capture is just a read of the latest results. The setup ops run the
