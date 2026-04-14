Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3F3C13FA
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159052; cv=none; b=VAmGL8+XGZacBzyaxLmOmvBVNG0WPr8cwKxx7+cAKiT1C5gxn9yJ/sVp9tT6a+OyD45Yky8jBSFNYw0y2BYASLyIzu0161F409Qcsmi9k0MJYlz7tssFC/xd8LG/Tokf3VcJykvs03O1qgtjuAyOrmuwzOJ7U1Mk0ftp/w+LN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159052; c=relaxed/simple;
	bh=ciCdlj7lgbV7krZc3z8m96MIDYD6GXqu6aRPf9fyf7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFXz+LfSTH8KVnX1G0stILbtj955UbqiuRxX7RAwgV2xbe8n90soK1tpgp3yG8ubolTNXG2NPcOFD5pj/wfWbfwDnQc1qJ44Arx1YZugskTntibaLduKEi3w0M/C7Tz6FzZh6Jcrz3GvFEwquMDZNrulJgJVQ6S9kiVZNWT2pdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=vLwzJ4+H; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="vLwzJ4+H"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso5509592eec.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776159050; x=1776763850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLYpSTtxjJcxt6f4zYCIirPQgRpG54kMZdNT9vSr7Io=;
        b=vLwzJ4+HT6e1LhrAxMYa1soTBcnzOLR8RTzyDUWGfXoRIE3WyQh/1Vsz8CgoGnCmZN
         2elKQkshIaOwt0D+qSkH/ITpamlHTe4bUHmbSH6ilOnTXMz2HxnfiDI/LkjXt6NcEZWZ
         JJTtLax4LKZWEXmYeYPS4lJhKJZUPuHpqPG7VnNYsrUYilLZrQZt/piH8nhHFygNgL7p
         OVlJQ3qHVIp3/CLjuPzN0zq4LJMbpsxO/fK/K22BPOvCkhPye0Df7DCT7dvx2UlcQW7u
         p9fUhpw9FcHIrrmDd9jrd9oR84WJdUtmBQKpNHbjWmrMRzGnxrSBnzZKJAhSRLg4HmZi
         4i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159050; x=1776763850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HLYpSTtxjJcxt6f4zYCIirPQgRpG54kMZdNT9vSr7Io=;
        b=PiHt1Nch6QsqaOSdJIV5xTZpJxoWUO57J77ChpRJGzOUhL6WyMaEEnrXRUryFu9trs
         X4kO+V2J+6b+zWV7ysYNamigVvTm2Uz/ujOfXqW6HWnLF/kbf0m3FvqcLvuXxbJLD9sg
         w+oh0uG4FOgXrZ7pzq93Xmc9qtYMR9bpv6oeb6uw5ijHuVnDMke05ia14P+OkjMGn1NV
         QXKlBXpktTZ/8MnN49T6fCN9SivWjJUWG+l65kH9yHnawXnWugc1JOKTcMBVEjkW1IEn
         pQrgcC8O5eY2Xz9cYFcXcFIdsAJdscj8R1QMebld6hjCkgfW+1zGjbX7T997gaQnTCVV
         U43w==
X-Forwarded-Encrypted: i=1; AFNElJ9gEuiiGQoIMpSvx9STBhJD0rI1Ac7520756mzlpk1uLC7CU+IHow5VsqWySpnJFT/Ud2JFqq3szV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24m+mmBSEv58eNmD+deG1vIJmktliiPpNeHuwkHoju4xqUAhU
	h5nD1gbZorw5BbAHauAkrBpSbgkRlGopeaZTmhAQ2qKZDPEqpTaKcx3zl8pssT3BT2U=
X-Gm-Gg: AeBDieus9ad3f7xR/UCJl3hQCzodYYusXFm3U91avH+Ht0Sd+NjDlUiecKaqmwLKoXw
	FDlj70ibqyXXN5q8YcfWfJNZ2QbX8OoP8ZKs8ClkA/6yvgK7HFY9xI/Vbjls4THOGmJqzN6ywar
	jb3HJJaPWIKDbrau0evVPJLa+Zsk1SWuVMOl/Bbq6FW3Niomh0RfuZ85uGY8yJiwEFcY8RL6S75
	BWHKWP6InmFqeUOUm2M2PSY6e/JGW39DYNetaenHuaouEHdX1RXEUeu9wWcRLssXy4rgO6FfyIx
	OUuMPE03hRvwAxdlEHVnF6MV/RtCpvN/pHfIEoM7ox/Enczkr5ZpL9e+rcqjuddvMJ8Lx6UUi7U
	YzR5SmMZkLc8/k3tKwNju6w9SMI7/LpCeryWeqGjdsteWADR/2T9NFgoM8axnJJxL6pjbnCyJ61
	qaGeaK1imqDJ4Rmx8s+nvZcCxQN9zjToY3T8tPe6IebUDTEQ0Dcw/Pv38/LWGOaH4czpKVkOnYb
	QRyIY6MiLw52jIYNncTGEeUsnPzrw8NH77KW3iNwKKvX4oHfQ==
X-Received: by 2002:a05:7300:2156:b0:2d1:d434:d022 with SMTP id 5a478bee46e88-2d5832e2f63mr9521823eec.0.1776159050147;
        Tue, 14 Apr 2026 02:30:50 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db6ac8sm20327599eec.26.2026.04.14.02.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:30:49 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Subject: [PATCH 2/3] iio: adc: xilinx-ams: use guard(mutex) for automatic locking
Date: Tue, 14 Apr 2026 06:29:29 -0300
Message-ID: <20260414093018.7153-3-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414093018.7153-1-guilherme.bozi@usp.br>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded mutex_lock()/mutex_unlock() pairs with
guard(mutex) to simplify locking and ensure proper unlock on
all control flow paths.

This removes explicit unlock handling, reduces boilerplate,
and avoids potential mistakes in error paths while keeping
the behavior unchanged.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/iio/adc/xilinx-ams.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index f364e69a5a0d..1d84310b61a9 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -720,22 +720,20 @@ static int ams_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&ams->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&ams->lock);
 		if (chan->scan_index >= AMS_CTRL_SEQ_BASE) {
 			ret = ams_read_vcc_reg(ams, chan->address, val);
 			if (ret)
-				goto unlock_mutex;
+				return ret;
 			ams_enable_channel_sequence(indio_dev);
 		} else if (chan->scan_index >= AMS_PS_SEQ_MAX)
 			*val = readl(ams->pl_base + chan->address);
 		else
 			*val = readl(ams->ps_base + chan->address);
 
-		ret = IIO_VAL_INT;
-unlock_mutex:
-		mutex_unlock(&ams->lock);
-		return ret;
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -939,7 +937,7 @@ static int ams_write_event_config(struct iio_dev *indio_dev,
 
 	alarm = ams_get_alarm_mask(chan->scan_index);
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	if (state)
 		ams->alarm_mask |= alarm;
@@ -948,8 +946,6 @@ static int ams_write_event_config(struct iio_dev *indio_dev,
 
 	ams_update_alarm(ams, ams->alarm_mask);
 
-	mutex_unlock(&ams->lock);
-
 	return 0;
 }
 
@@ -962,15 +958,13 @@ static int ams_read_event_value(struct iio_dev *indio_dev,
 	struct ams *ams = iio_priv(indio_dev);
 	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	if (chan->scan_index >= AMS_PS_SEQ_MAX)
 		*val = readl(ams->pl_base + offset);
 	else
 		*val = readl(ams->ps_base + offset);
 
-	mutex_unlock(&ams->lock);
-
 	return IIO_VAL_INT;
 }
 
@@ -983,7 +977,7 @@ static int ams_write_event_value(struct iio_dev *indio_dev,
 	struct ams *ams = iio_priv(indio_dev);
 	unsigned int offset;
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	/* Set temperature channel threshold to direct threshold */
 	if (chan->type == IIO_TEMP) {
@@ -1005,8 +999,6 @@ static int ams_write_event_value(struct iio_dev *indio_dev,
 	else
 		writel(val, ams->ps_base + offset);
 
-	mutex_unlock(&ams->lock);
-
 	return 0;
 }
 
-- 
2.47.3

