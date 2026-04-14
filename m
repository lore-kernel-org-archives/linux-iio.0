Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95738B7A6
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158589; cv=none; b=GjiAyqd1fdCPatut9CAV7taNwZna5FuSYRZp4mW4ZMepSJiiiP6tF8t1y5QxgRFSn+p/N1eko6qv1JTbbxKsekJ2xf1dFlfxyozzJJtkIeo4XjbmiYMGwXuv2Ml0IePafp3KszCuJLAntsZZm14AoAxlaGZxn5svDfjb++awxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158589; c=relaxed/simple;
	bh=pvmBPcWN4A887uPnBNXuLeM1stz4t3fR8yFPRDr+Tso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJ+1HaY3eO2J3vKQIptKXWAQfLj3LHUPE4aGw8/vutACQiyTSklol7yNPWTGH2YjWnNQu4GW1eqBt6POVoOjpQr0ujEADR272RfGgDnXQMYWtR2JcC7DYgHfqbRYNh53t/zwr/VVL37WsVfOgpkX/ctxyd6tScb7qr0Fx8+3QAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSl6F0kX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSl6F0kX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso1358299a91.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776158587; x=1776763387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8B6vSWt2j6maKUZK1Ot7k49dmTV7f/8h7ldensS83Q=;
        b=nSl6F0kXylM4gR3oSY3nS54YDdSBFFl7PFLvPkns5bsSWUW96giGrqoFhJuvfvx/Xt
         rve/k2l6BXh+xLTgVpH9m2Fo1hTXWYwUrYZWIMeQ7WAT1FazWdQdWS9xoHfk15mDb3T6
         sO0qJ7kulRSQ4kjOEmTjKDMaarGfYo5rU0w3CebABK6TUtuRqqFlMy/2HZ2biGgWwNnv
         2YZy59RuoXbanS78Zqwz/0u9hRfgKxvTAMnWBJtioNRcAQwM1Q5mCNz95WVeWaCJaIPg
         4fpa+LtaH6GImZFBYc5Xy2XJnPzFFBZ6/li1GlwGpVYzRlT34knWy4NVr3bq9IgIwQm8
         vkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158587; x=1776763387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T8B6vSWt2j6maKUZK1Ot7k49dmTV7f/8h7ldensS83Q=;
        b=B8LS0+q023DAioB22P/Uy4JK+GnLuMWKDDwXA/z2YChcnKCrghUgRIT6GCoGeogQ4G
         ZK07WtD1Re2xUtlQW4IxWn6eX8hOENViB0/VySDSfpZ5unvjb0WL052VV03qAKjUZvOy
         ZiyfzBCqeRTv3kIGJle8sMmuNUwjFXdM7itcVn7D2KICQMKWCcce5nY91r1teuPmd2I0
         jKcATQxqe9egqcc2AVKobNe6Z1hRrOhTc7+dBgqOO8NSot2eVD/fOFTlaGGGgQdABJLQ
         47VbTxdrSpF7DNt0VMNXVPFCmkMP8kraMM1+Ccu2B/Qp7EvM0O7GybaHI3Ns5Iu1pTOr
         EASQ==
X-Gm-Message-State: AOJu0YwcLEkYd+GJtQa8SLfMlxIPAczxoPZPJ9FfTNs7uJgS4+sheFSx
	hAJb2lTWtmF+e0250unPADwDyUxnreHXS/XfzjXEmU6ix+yNvaJLf55nKCeqrsc=
X-Gm-Gg: AeBDieuVu5Y9HCdmVGxsmxDYmo65FNIDNO/o9iytkrp0sFNDHrjKi1kDdNQzLEo20r2
	Yz1YveD0x1of5efbphLazMWvCV7PlGqdbeoIjtTrBHJeBcDk71Emi2FGyKAy7xQIlowgwCHThFX
	sBzDS/ejytjiF7Z0JFwz/GaRqgAc/nK3ipio+zlWskh0EifaaloVF4N5tb89yC4B3VsOwDOfqd6
	4pAm0x2jeNJ4W8ASGszIEwJfno9xL+tpuUGj7MEOSAzUglNe+dCiw5Bd2QKgZsPpB0wCbLjxxoz
	tb1j2+oQsC4jKSta7NUiyLwlU1ZXgmb9Tg8sAvKiWnejWWNsepE4jlXqD1q8PIgJbM12XnBUFc2
	T9lNqzyctJcjGztGq2+vCHK5poddEzBj6ap5dlTLgrxl8vh8l9lVhwhmprvgz+5UFGooHEnEATR
	3oY7R7umP2+pEwrIv3DIXFwRM3k0oZ0fMIzbCg0uQ0Ms7RNQqJrYWgRzQ0dVkMideYA+sWaBAek
	7P9FRcoe0MA4KidqK5XOhMrRUVfuYk3WFh0RM/Es0qFx/mUzfOc8hqs
X-Received: by 2002:a17:90b:2fd0:b0:359:d54:846f with SMTP id 98e67ed59e1d1-35e4275f708mr17733393a91.7.1776158587255;
        Tue, 14 Apr 2026 02:23:07 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e75c38sm1448991a91.11.2026.04.14.02.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:23:06 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v5 2/3] iio: dac: mcp4821: move state initialization outside switch
Date: Tue, 14 Apr 2026 14:52:52 +0530
Message-ID: <20260414092254.34883-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414092254.34883-1-nikhilgtr@gmail.com>
References: <20260414092254.34883-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the iio_priv() call outside the switch statement in
mcp4821_read_raw() to avoid repeating it in multiple cases.

This is a cleanup change with no functional impact.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/dac/mcp4821.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 29187f2a9d3c..102ae3718514 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -115,11 +115,10 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
 {
-	struct mcp4821_state *state;
+	struct mcp4821_state *state = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		state = iio_priv(indio_dev);
 		*val = state->dac_value[chan->channel];
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.43.0

