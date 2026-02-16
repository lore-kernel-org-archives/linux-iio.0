Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548B252917
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203220; cv=none; b=igEAEiEZqjMrYMMYX5ltIsPIgQhLmJGAUt19EkzHi+ZZt0uorb1q4hUnUfllw1WqZ0DyD7HXUlEwp1fVjaeIPSt95a8jDcFY+WFCEbKPF6gTQF+ugHyLw0RkGk5ObQPgHF9pTQOLESkInLnzaluRXCkiwapUfVGmVFqCNDHK0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203220; c=relaxed/simple;
	bh=60hN41ih3iOsAB6ymTysRnh2xYyZO8I9uzHpwFHZRtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUoHBMCozlt+uP6C+iyrbkNs9uAG7MaFhLjaoPmouNrHId2qwpSBc/kH2dkjCIo98J45U3Qox2nkimCQak0pDbC5bOn3FjiFidbvFRUqD0ojHUImixZQpEtyjRfRRyixzqAtStyWTeeJvz6U2D+1zujaGwwZe+HKqgyVYDjMspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsaBWMP8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsaBWMP8"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-797ab169454so14781117b3.3
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 16:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771203218; x=1771808018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXcdPR7MA83++rX9pDUuu51PyGAjXa4lMqkkaZ3K5L4=;
        b=SsaBWMP8l6UOFllBy/vn+6aqDdqS+o14Vp2/soOKl20pBH/gCpU+5DeM5i3YJuHWB0
         v0DVBSMGlFQYZwDTvdGabDwYz3Zy5qGcerhyxtrnVnKncDFZgJKLIGmBVvzKqgwtQ97i
         g+JRf0fCUHgMqeOEQ/ST/HCjtIJ2uZZO38GWTwx9ldEByhhqrxAmlGC/XrNxDBERyv2J
         cnK0B4X+l1qFyDLd5UzZdCPbaJJAKnejQ9mVBhdMZfgULZnPM50C83gOHhFbrnW6jTss
         DQX5G0SSxRVdxoJZk2JkOjXhHKVGNnMlCunFClRwIKmduCxsG+TM7Y+AyXvCmcX0WU0e
         2faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203218; x=1771808018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vXcdPR7MA83++rX9pDUuu51PyGAjXa4lMqkkaZ3K5L4=;
        b=tyJZ2cybpYGk2gSdZffsVE9g69aP5QasiJX4PiTwcQLuLKBs6fHWmRLgXs64/j/M1E
         hQWLA3dsjfNwpcFp6S7EZjFiAtIRIYLa20kDs/fWN0WH4YK/W7g5iQVdivW66CBs1UxP
         n7qKcoMCwoueJH1UwnTjeYotdGO1tCDDTc9v+3AJvfyRHP27P7+cpxf/+POS0aQkkBhZ
         3Gsm+SGKpjQH6xmw1ur/qW4nPzQPCf4BIiB0VtjJbwDcT4oRcjf2WE5A/UyAgGBxl4Cm
         rjTBwEHvQixbt9MWfG+H5J5mdHh8IBiB3mTZ3iLugbdhCqOo5/sNaKq5aCLv0YyJyOVS
         /Pcg==
X-Forwarded-Encrypted: i=1; AJvYcCUSkRABwR5pUnAusLExNxXvq3yDQ5Mna7EDZgOtytcTUQeZtDOybFlI5yBkmV8s+N0RktEzL2FMNME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2QhKQiFn/j7fCnjUG5TGKx4cRisSqBOP77+eLQs+8ePTtldZT
	F/NBZWzWKqemWvPM/JwmhoTIUNaH7vV+WoFizrkoaT+J/yLA22+ldTLn
X-Gm-Gg: AZuq6aKCVwoXQES2lLstF1KISoHA52pcglexOk41pDWDuktF4jz/HApdmYwXv+YTCT6
	t6nU0UcFGG0ZIqK7U7STJOLLQjhVnjp5qMvqVly6jMaT8tO3bvJQE50Wzu3TFN1t2s8y6b+auVj
	XZ5qABK1ynN2gU9yk678TapuPdHz6/QoAtCTQRxocz3xLIr65PQjZvoCiXSAcQrpZ7+SNxboJvR
	+hZTeShTiwk1/t5b0GAoiUh/RxhhVgMyOTg7XnuVqnfhRl2KvUVeJDxLSgklXwpYvN4Ejr1mGq2
	vjvhTKOnuHGbabDLurKbdQGHkH9PPg0f8iwvrltX7GjimgSwhXwCh0NWLnp5da4JEdA7zn01LII
	Wo9m/+HL/Roci9emfL3AGk2J8bTFrXIZE0b4fuBGoG+MgxdJNuSnNlAJEe8oouIJJHzIyVLOnh9
	mDbY1FYX4UovenAqGi4YTJqjVFfdQJcdoEdqmJWugF/kjwJG0rne4BDgKrm7b5SrqROTrxbvjOC
	Tfa1tCYFOrPhO4UQvClnlduXvHm634BZfMjdqAwc54=
X-Received: by 2002:a05:690c:d96:b0:795:294c:fd31 with SMTP id 00721157ae682-797ac5d3737mr46326717b3.38.1771203218448;
        Sun, 15 Feb 2026 16:53:38 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c257ed5sm94797637b3.45.2026.02.15.16.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 16:53:38 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v3 2/2] iio: light: gp2ap020a00f: correct return type to int
Date: Sun, 15 Feb 2026 18:53:17 -0600
Message-ID: <20260216005317.11763-3-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216005317.11763-1-ethantidmore06@gmail.com>
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function gp2ap020a00f_get_thresh_reg() can return -EINVAL in its
error path. Yet, the function has return type of u8. Added error
checking for gp2ap020a00f_get_thresh_reg() return value.

Detected by Smatch:
drivers/iio/light/gp2ap020a00f.c:1013 gp2ap020a00f_get_thresh_reg() warn:
signedness bug returning '(-22)'

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v3:
- Remove Fixes: tag.
- Added Smatch warning.
v2:
- Fixed gp2ap020a00f_get_thresh_reg() parameter alignment.
- Removed unneeded whitespace between assignment and check.

 drivers/iio/light/gp2ap020a00f.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index d1a511ac7690..fae7605f2f5c 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -993,8 +993,8 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
-					     enum iio_event_direction event_dir)
+static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
+				       enum iio_event_direction event_dir)
 {
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1024,11 +1024,14 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
 	u8 thresh_val_id;
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 
 	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+	if (thresh_reg_l < 0)
+		return thresh_reg_l;
+
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 
 	if (thresh_val_id > GP2AP020A00F_THRESH_PH)
@@ -1071,11 +1074,13 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 
 	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+	if (thresh_reg_l < 0)
+		return thresh_reg_l;
 
 	if (thresh_reg_l > GP2AP020A00F_PH_L_REG)
 		return -EINVAL;
-- 
2.53.0

