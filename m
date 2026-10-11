Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722042EACEF
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791694460; cv=none; b=PDGpSe/pHJ+SSvqpkyBhc2Qxk6J8F5mKcddEysrJqS2pAesyMPO9uKPpvx5wtxihC3ySUia8dQ5uvK07unEbRo4mGd6xxhx1/DwPaHpaAxBEaivdnBFl6+dxLJQkeXtMWUa373pHcMdGgB8B9l67ZiPJXZIITwe4mS9LBsZXHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791694460; c=relaxed/simple;
	bh=PajRC5vUMiRr6CbTVl3zKRdEDLQRI778cFy62JClji8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVdEXQ0AZ/EESipHarovub9DruAkaBQE0bwPIwKcfkdl/VmsVwyLzeg9r4FOhRAVG0be26K+xuCeFQph80l2GmsM5wkR725wvjlr3yxTvAMnGjaHYwYteO0TSGr/RHUmrYTkJrAIDj6VrZzHE3mU8VSL6tiKkBfDJIejxErIKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUO73iaP; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUO73iaP"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535a54bed9so1216379eec.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 21:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791694458; x=1792299258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=auMfHamRfTcV/GZLqeZ5Y5LbcqKOtpZq3cZN7xkwVsI=;
        b=fUO73iaPK05Xn94AFMEpHFtZ0nJle9zw7fsi/K1ZBoT4zE9tpfQ4AxlGdF83QiZ+dy
         CSxWLPVd4uTa88J10SAdAkXte9cYQA11+SBt2OsWxRoaIFkcrq79uRnVBRYQ/xoNEyu8
         ce8NmF0KJiLehtcOFSiBLIdF3KVDLEhHDjgo9T0vtp0uOM7h3IkT7pAIp/Gtkkylwnq6
         2dro/8MWeK8BMh7r2qDAzgKVJKxbr6qNz4I4RYqucu3YKa2lGQMw0b4+f9iKebBf7oka
         mvOn/Q7CTNJmuvw98MDEvU2hbzJ7LhScTYDmsuqWSyBBKxTDKaVh0C6IeFc2XTtSM41a
         fzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791694458; x=1792299258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auMfHamRfTcV/GZLqeZ5Y5LbcqKOtpZq3cZN7xkwVsI=;
        b=qYW/M6eTcYWyefhtdSj1lx/UjeNmtuomqEYK9Z6QpMzkqxT8uQfWU5PsM6wQYyxrCZ
         l5z7USsfZ4Awh9qMSJlwbgKapQtedzKeboDmbBeazsLUpWRYSXyNPdf81oMKdQTJ9Sfy
         KV+jNOu6Ri8JZ+kqbbokfGwf8zaOfCEvRjHvQjOabH9vH6XYUUJfJI2DsimmKu+XMRKO
         FCOiJyqiwu8ac8/VXN4a1XNyo7ZXMrSZFNuhB0C8e6RmO7ptDilXCrgwf19H+raNXTVa
         2WaCk1T17t0XKZCv9o9TQHlsExID156ZpBDFWCqnUDHP2XxZwXDQfgzdsU9Ykxvt6zAv
         jHHg==
X-Forwarded-Encrypted: i=1; AKwUvBy2riViLdgs1RAhkmHn3fQs8b2+EFShOmvM8zUcBX9VJHyVUIXmkThqNkKiaQIjYEYnuZLyvESZrUM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIedACy9TvCyBRVLru02BAz0BqCQZ9pGT4fiKF/lpOn5UhUqlsd
	gAywgFBu5w1+pK4SoYicW8gxRD7j3FvCl9ddu4ZQ6oAGpchYQfpR4oEQ
X-Gm-Gg: AYBFou0fA93VfMBP99Kk24I8kS59BxPx5v9GZpTussTqRkx8UGRVcDYZ6ZB7Nd+uC4K
	1yeJKLsDzuB+WyfqfQ6TWkXKNUSxoX1k3Eg73bXI/u13Yv6zovd/NlkjWFaU+e/TOboD2bhzCs2
	qXSranBjXzcwvqvWXBrP9rsJsqyGDv1LiA2H7n8JlBLDYIyYjse7d2UNpkM1nH7OTqydaGDOi5X
	KHrG2ZwHt7ziojuUqyagGacXwCrnsTPrgaga8XQUFrJY3V+usiplmebLvvvS6wWn0lTvNvw8Utl
	l4XKPMqbE1DMb84xNQmRT8JLjyQegbrtyPLv/UycPwrS8DovrwQHb+gUV8fYOC5o/V6VyBYTURW
	CyZzbmJC8ObkP8liM7UllCoY00MO/ZOS5oasvDUg9a7wlBcSup8NkEOmw9xwuK/98zzhqiJSTSn
	dWXIHhfM0JhqhWsX/QwYQ/PtmWN8oBAD89L6dtAzPalGle0BzBR+jw9Se5/6HuB4YLLvhtUMVcO
	x6iouro6L/IGESkebVcseWYXKPER3MIgj/mzKquY6qjpPj6oO7TvmGSucuNmlaxM2T7k/TdrhFZ
	SO4JHhpkkSBVPNO0UgF+KzKCeWqGBQ==
X-Received: by 2002:a05:693c:820e:b0:34b:d8dc:430b with SMTP id 5a478bee46e88-3537e0be0dcmr8619947eec.24.1791694458226;
        Sat, 10 Oct 2026 21:54:18 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm20678181eec.16.2026.10.10.21.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 21:54:17 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: common: cros_ec_sensors: use sensor_scale union member for CALIBSCALE
Date: Sun, 11 Oct 2026 10:24:08 +0530
Message-ID: <20261011045410.356156-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IIO_CHAN_INFO_CALIBSCALE read and write paths send
MOTIONSENSE_CMD_SENSOR_SCALE, but set the flags through the
sensor_offset member of the request union, while the scale values in
the write path are filled through sensor_scale.

This only works because the sensor_offset and sensor_scale structs of
struct ec_params_motion_sense happen to place flags at the same offset.
Use the sensor_scale member that matches the command, so all fields of
the request are set through the same struct.

No functional change.

Assisted-by: LLM
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Compile-tested only (W=1); I don't have ChromeOS EC hardware. Both
union members place flags at the same offset, so the generated host
command is unchanged.

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 551b86236abc..2839714f5bc8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -70,7 +70,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_SCALE;
-		st->core.param.sensor_offset.flags = 0;
+		st->core.param.sensor_scale.flags = 0;
 
 		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
 		if (ret == -EPROTO || ret == -EOPNOTSUPP) {
@@ -178,8 +178,7 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
 		/* Send to EC for each axis, even if not complete */
 
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_SCALE;
-		st->core.param.sensor_offset.flags =
-			MOTION_SENSE_SET_OFFSET;
+		st->core.param.sensor_scale.flags = MOTION_SENSE_SET_OFFSET;
 		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
 			st->core.param.sensor_scale.scale[i] =
 				st->core.calib[i].scale;
-- 
2.53.0

