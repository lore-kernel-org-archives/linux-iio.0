Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793437993;
	b=m5h3eO8XZLX/Q9QsB4XN87Mf3bKWOoob6vuI5QXW6j07QrcrZdbu8cZw8vXhnEaHtq6j
	 83tvnwfiHpFX7wQ2p1nuvydIXNkLoomLvkGuHfn4XxU2va90HEMmI5oYat/8hmlpL4hqO
	 ergD63vxJdtunoJSvdoW5tqfZjD/6duq0H9zMlEuUcMikZjWjofAAzv+nOixN/b1rk5Hv
	 2VqVgbOSC1kceyuOr4iEbEczQtNAJ0NXK/QfudPeFSV9TQgiRser5ngvjKVsis9Z14fJv
	 eZtXKRk7rO5HcBi4eOrMYQBqYgb3qwjiiSOAlEk8APGp6IIGwgiqp49xpe6DUk+i43A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793437993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yvb6WJh+6K9JJR5AEaTQbWzXxWner501dTBgAUHA8yQ=;
	b=TEMyNibZLg2C1Hhs9eEkFfBWZJ+sq+0ORnri55LGG7aMRas17N1cK3nS/YurIcnj8XEj
	 I6X4uwS4bGROQkPf825rXn7guPkZkQWuCJtfdiVYwBOJkw/DNtkOadpqHcwy3acnp3Uuo
	 m25MdL9eKgYBycdD6yLZUwsEPyqQHEk2tU4xa9IXok5qCT3cpL9GMUFUoUEZOKOhf8xOH
	 8mvh8QYerzmtQdnrae6OugYUQJO8iWxKE6jK3iJsKu4QJt0B2ft+3X6Xhv5Z1igGg3WqZ
	 Ydiu9tDA1K/XfR8UpQFjQo/pr35tKOukX4zAY2PDAyXHwDBQZoPnjTTlQX8gEcMMutQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8TRV+nK;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BC606A31D
	for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 09:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA0BC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8TRV+nK
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1872717c88.1
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 02:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793437992; x=1794042792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvb6WJh+6K9JJR5AEaTQbWzXxWner501dTBgAUHA8yQ=;
        b=l8TRV+nKZq27poYKUBpHFHNHKP/A+FczxkUjgPZVg+TgooT7d3lvIHeADPQPVRY0lA
         ZnItKG79DJ9KXKc9uCmGPVHZfqpf8LCTG6ViNOh1WAdo7ydTAS8gYl+GH4u01SA2+KU7
         lG/vGR96+URF1BiPqfinuaUFYyeClCicViVPlp9lFumQgAY1Tz7pzl/Yy0Dzv2hyv6MZ
         EW4Tvlswug29I0wvMtsMAE8js/f0jjfd6vBZPE2R50YSSlBPKqnwA7XVS0mVjktukqGW
         tBYXmhpeZkL8+szN0YCHIUl0UvwvwQOdzIPSFab110vwhZF5O0FIx99fsDeZwHyqpQdw
         Qm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793437992; x=1794042792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvb6WJh+6K9JJR5AEaTQbWzXxWner501dTBgAUHA8yQ=;
        b=MOz+0wXtgFIidVd6FTPkq4VljWCVT6UQSWohjCfIUa8MzfFbF61zOP8xVbjBJ9RaKo
         Mtkqtvw5HgDoa/a4UiUvWgVeZNtcOw0+UidHaQ+fRP15WKFCVYeaBW8M2+Yj/XtBycPF
         wEjgTwN3Z4oW2pZGxsQtVfhfSpHnKLnMAKHdiTcNBYc/Pvnw7thXigHvtQSTWcnAcpdl
         0dUpXvqV9hIOaXXDXYPmhZHeQwzSGlNzgbijq/aKf3EbdWPBnO4oHUCrmFILN7bjhV5i
         /YVsKGBeSwpW3MQ3LgouidWU/9iw36GXCW/jWIRdUVImhPtL9FPyJRXuBzyJjj/bFsKq
         jJUw==
X-Forwarded-Encrypted: i=1; AKwUvBx+CIqYWlBZK0rTRiiCNvRqbS4+eAh7GVcQSN/yEjb8i137jyiWqM8V82O4/LlMH/Xy6hRh6cb4Dzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHEGKQLqhjck4TZujotBnCYUqSIANK3hkL9Roa8cR4fHPkZVqX
	l6/rkn9fND80CwNpxFlSqu2sHVDPbHoYwR1ueGACMFOLI1hEBzPcURQp
X-Gm-Gg: AYBFou1LtDQ8ZNQkdNAJeUyWIRNQVkLL16PIkokGVW1H5bwTwL8cvI1Hdumtdi4w7FL
	Z/GXISQEtj+VGOf6V8/8ViJkutgybsi+R4ZawZ3IROCQFlph6/vHmgFgO+xPAAA/eB1fXZ2H7Ve
	XJdWlXS647pttUobPz5bI119DU0RDvr2F54lXdvlaSu4ksOpkD5qJDEH1vvs3YB7BjuM0CoNdN3
	F4ngQIBhrxI5AQTvEaBPN5dpL861aBX9kWxMP7ozsMEoSz2xDXkFGmJilmcwjQyw4vrbJmSC3Cb
	QJkBa+rYRM5LKdSpCFRAXgaMohwI7mwpPujRq+Sc1gQuQaHgKMIsIXqgUsG4JdzHywIUcMEeD9F
	65IS16RNBAFqPHaNI/dP0786Rfn7iDnsDCPUvlARX1hdFrweEw8Qkmi+rSwrvnsto4WyO5zZkzv
	mA8OTCb7choXRq+JVg7/u+PBj6iChgKElRnkgLhbVOzaJw2kTPsAL242GAchXdjgNDvFMjaur6q
	4kZDWiJfEMOi2E6LsnXjOu/aL3gZQH/nYWNuu+soku0E58ZKHy+IIyDJg44BfvHsJ4ySXhdYlMO
	DOeQLAXM4osblEvahVxfxPCqJ0jDPLGcpxTo
X-Received: by 2002:a05:7022:3b88:b0:1a8:ff0b:a4e1 with SMTP id a92af1059eb24-1ac5c8380aamr7862765c88.18.1793437991368;
        Sat, 31 Oct 2026 02:13:11 -0700 (PDT)
Received: from archlinux ([2401:4900:ccca:8aae:db4f:18dc:62fa:a502])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm15771014eec.24.2026.10.31.02.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:13:10 -0700 (PDT)
From: Nithishvelan M <mnithishvelan@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	Nithishvelan M <mnithishvelan@gmail.com>
Subject: [PATCH v2] staging: iio: frequency: ad9832: use devm_mutex_init()
Date: Sat, 31 Oct 2026 14:42:36 +0530
Message-ID: <20261031091236.40401-1-mnithishvelan@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Replace mutex_init() with devm_mutex_init() in ad9832_probe() and
check its return value. The driver already uses devm_* helpers for
its other resources and has no remove() callback, so this ensures
the mutex is destroyed automatically on teardown when mutex
debugging is enabled.

No functional change intended. Compile-tested only.

Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
---
Changes in v2:
- Add blank line after "st->spi = spi;" (Andy)

 drivers/staging/iio/frequency/ad9832.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 35f823f24f..e3b4e19a8d 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -325,7 +325,10 @@ static int ad9832_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->spi = spi;
-	mutex_init(&st->lock);
+
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
-- 
2.56.0

