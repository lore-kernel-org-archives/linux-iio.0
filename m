Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557C345757
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818048; cv=none; b=OwH/FRMAb7rAYRNf4809lvKb92MsKD7c8r+L39+ba9vukdHzJOm7T0hIY0je2Ln+D2x7wDhJVnGPoM3gOkcEJpGNA2pQNUlKxTEe+GuzvuiFdzdu7jKWS3NQ0Kp+hlk88PwK8JhW6S9PSIqN7XClow8VTJ9AIpNiAmePGOeP0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818048; c=relaxed/simple;
	bh=I485GX0Pog1oelKG+Cg/Ejzrxtfwd894VBCKnHl1O+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxIw6MPbbPz2fd6ntIWgKuypN5mQfxVbw0PS1uhTFgqeWWqkTgaoc4NcNUeeLhmktoi8Eib/1MTrFUlS9iWFLJ9KTN/+9vZzaHkYfeOrVGtGbxvg+KhU/YBBUqtzugdUhxvUCDeWFVi9DyBpK9RKwdv57WpwpfwZwyZYW7wZTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqA4azGQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqA4azGQ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79801df3e21so35769777b3.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818046; x=1772422846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCgYbsV8y/lXIHufgVowxyqz38jANK3ZckW9ccKdzyk=;
        b=eqA4azGQV5dumcrWYZCLN6rIVTKbb7O68xE/jYkNx6UAOOj6u9jN5kzYBaxS1tw757
         pVhlqab2gm0mTY3QNH6D2IR5ORTdOtFMi4aH2WIEOmkF1i5c11EWjY2y7RCjtpv1XykB
         yrtkVhi1izRpPHHPHTwYWdBQjtMSBxnkXOjf7PYGM/44DA7EIp+s6Gb+L8oDbrUA8Fgj
         tE+bkJseoe/fm/LUATjS+VxUvbu6QRj9Kif+OeX/LO0XiOeI58HsGxaQj/AljxExhHTy
         2543eTc2nm6K5UBF+g8x43dZqMkfqL4Bj5K8Py1HFr22kBa/AfYNVIs9Xqnv7PUPzzxi
         W1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818046; x=1772422846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pCgYbsV8y/lXIHufgVowxyqz38jANK3ZckW9ccKdzyk=;
        b=reHDa8DS3LtHefEc6CbKSvTIINBvZhDrl0lB7NnK+n4pe81CEHhswz/aGNtCt/s1aX
         enF+5txXU2ZNO6fypPef23p05fHUur5Vy+zbb9JDR9ycaxyaeVQd8u4BYta8atkmeFec
         ybpF5c6926dEoK3Zss0Oa0fpNaMPnzWjRs/l71YMmqLxI5nhE0tSNy1d/UxcxwQ2Nb+z
         q31Va3q5s4AEt7IiE21lEVIBP4XK3CplC9vpnYlOf177CYQL0B3sfxdO63FUGfJLPNyL
         sth2yiIf1qWM+VKbcvpzIAtC1FbBEyKlklLDpQ08Y5D0jbm8noHWbGH++592NMj1vqe9
         nq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRlHj/HzRe/6M7w6sdDUVqbKQZSOp56f+a/O/yhhXT1lLHao1m//h8ZINBPLfpUODrafpwINj2Ei0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrX54Jpm6Pp61+Kv9+QzwKasmwKTJQrSddoOpx9oKjUwn7z4/
	lLrOAr82zr9MHp0DsUipVLGXvfGRT3mNKyvJsoRVTa9J9FdaEnW7ECu6
X-Gm-Gg: ATEYQzw7KNZS7nnhsmse2c8XemSgsRKzJp8NXENEFajDQukRXfQRRt16WaerzlcXVXO
	5LLwSQoXIJGGa99YcsUABZmZ3yuFNcz72eKbyDrlOMUbkBlE+x+D4RYDuQXnbhJG3PedoJlWHxI
	U5DZrIF9Stp9bW60MXXEIqN9aINxhYHctBcxuWD7J1D8rwF2qkmMK6MDmHT06g7k3TB9w5urJU6
	K3/Am/28pZs2idfbcFxHvNbF7wG6pAbeLepY2CZXA8AAmyLNvGE4H/jBPvF7ZqZf0yPzXVnKH5e
	cyiwtcQu5x0hvlCqOpI6DNesrqKzHA4ePqzebPX8kzhfg1DFbAXr+cA2sDegURjesfciQd+9wJr
	tPjOU0XZIM9z4vZKXjpehFUqdGJcL0Rf6IEkeVaq2ifPeRWBBFUH+fKZ2VNLye1+fpgsCMz69O6
	ixMoeyXEEaA0XSk0I0qaBE9sOtmh4QBguE4v2R/q0ZK3knrdGShjonnUo9HbuiuimLTWt25XgUd
	xdX3lYYGtZYyPdiVKkt+T76
X-Received: by 2002:a05:690c:6706:b0:794:8d58:cac0 with SMTP id 00721157ae682-79828eed47cmr62376017b3.16.1771818046404;
        Sun, 22 Feb 2026 19:40:46 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:45 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 06/10] iio: light: gp2ap020a00f: Replace custom implementation of min()
Date: Sun, 22 Feb 2026 21:40:16 -0600
Message-ID: <20260223034020.27625-7-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Replace custom implementation of min() to save a few lines of code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v5:
- No change.
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index d2156e133b75..b2434d00e10a 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_work.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
@@ -45,6 +46,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -454,9 +456,7 @@ static int gp2ap020a00f_write_event_threshold(struct gp2ap020a00f_data *data,
 		 */
 		thresh_reg_val = data->thresh_val[th_val_id] / 16;
 	else
-		thresh_reg_val = data->thresh_val[th_val_id] > 16000 ?
-					16000 :
-					data->thresh_val[th_val_id];
+		thresh_reg_val = min(data->thresh_val[th_val_id], 16000U);
 
 	thresh_buf = cpu_to_le16(thresh_reg_val);
 
-- 
2.53.0

