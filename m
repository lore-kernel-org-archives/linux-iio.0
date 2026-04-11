Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31D3368AC
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897084; cv=none; b=tHyPW92MhLctiWoAAS7uPoRjmCsh+R1bW1Wd60MLGqCv0d88G8LYwazvkpbA+eP3YuhjgjmeqmWF9Z2H8vRWLaAXaRyLB4+Ddp0safaMCIUbQGPvQc91HSy0sk++ranFWul4nuulbB8lVCaZdwuhDcHzq0NzZExEbNi/aUxrL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897084; c=relaxed/simple;
	bh=jglBWZpM6gb6r4jnk+50+pDuOMLGeUPfxSTArYCfDN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cr4zqZp7kNznIjSzxAE16QcbZFlEl7wzUiZhtMVz88bgCQnawfToO7VEh74NoNJCivnF731hcN25Cex71od/DgvFcaV0s7EpnI2N/0zii6kaELwOz7Ezmde6O/B8OCt+8jFqjHAyQ7C5b4zKnSkCMt+JEsHs25N0p0ZTWVR1MPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnWTRV5r; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnWTRV5r"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso29672105e9.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775897081; x=1776501881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqmzVUPIgrnm/cJHXSiJKFWklEbsgCfd4TNnk6J9pOM=;
        b=qnWTRV5rODTIxqQPCA9vwYX1Gx/f5if1xFM1lZThp9KpR5lB80MSCTZ5jzkNCFEt9O
         HWAdC9s4nRnGI4UkEdsLLL57ajYDTF91Vs2rXWXT8xdxWMJlYJ8OHkP6GKUrYW2nlGLN
         OxJ3pbhPQc+PYlWFzwpI/9jjx+Q55ifP6qjxCV2S8irC2uM43Tzi9DyvrxOD8sKIOGNA
         HYlBBHpX3t+HcxUbX8LF+P/+LJsbl5L/FeQZRP06jhlunks/aiLi0ZaLG9J4rzvD+OAt
         7+8bZheL8aJxU0PNJ/sY3F6kQ1Vi7z7Y7MmxU+VstniQKpDWIfgwqBAc4HynFOSInLyH
         czXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775897081; x=1776501881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqmzVUPIgrnm/cJHXSiJKFWklEbsgCfd4TNnk6J9pOM=;
        b=f8JXnGPOT/p4iRpR0wupf0WN7Fh9gS8z63IOJ6UF5FXj92yKhzA31h5okz1W+NwYs6
         k8wNVJiZE7OwYnte/fLk9xABDtfJsLRx3zoTtY8aFcXOM2ulvqvqIsdMHuspJaPNjHgT
         jUzzu5W10bKhGR1Oi01+FjiKECvnqlT5SUOm5jLiYI4+2Mv5tyNxoBh227CGxRCLy63b
         oCpHD9mWaDdfTAbMvOjb+jPSlStFlYHmHOxeoLMMZkqGQwBiOCi1U2B+XqqXK6dzhHoE
         c5XbSImHb+qmNffBbRJB4LKq/EdgL4Ucey309iKxAp26JxZU2cDSbhnuq8qsk7V00AhI
         IFdw==
X-Forwarded-Encrypted: i=1; AJvYcCUXpZEPGfXacVz5bdNuMVt2kHSNO9NGotsEx0RJ8CKt+4WyrOZnwIUK3RoWvRlyXFdysRPBW49Tspg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInfZVVCDfeSu3QiOGslzeC6yXu8k7rMu3+bjtyZqE7exRJFng
	k91Qyj2Y/ZpipD1Wbmlc2Q7xj3snY8skI7REW7eVTdb78ErYIfaiN6cW
X-Gm-Gg: AeBDietHiARH0wWioDBtoT978se/dxUH8gONuAzPTpkMHgNvzca/QGED5b6BPh5GqGq
	TKBFcsfP/nfZj0AJY3GgJBCGJVxJJ8Mfr/nlZaFNklRorvRrooTGG40e2pctwIrWWeH4+jnEZ7j
	DtvOI1eSvAIzrrBjCkwE5pXNlclpR8UOWpV5El93Zgmt8P21LfkxIhT1RbhoeKqhcqbahFE0PM5
	eeBrGgeellJG82SZqdut8JG1E1wmp+NKsD92rYZCuGIRfz8H8JAVB93idrpz6kLkrv2fkxPOikL
	LIhPjaVZ9+5+dqSJ5VluqJC3SoV3h2JTwpdeWQlZ8tnsfl67NARGoWinQFshfrZw+xQPHk5VYYp
	WFMO8nnWwioIjIQ0lY0I295HoxwDJfeisIM/eQPBz3swbOYWmCDpdajRLV5e455o72i4eo+zX/i
	TZ7mja2vPiCteJJHJm6c7J/qZVoZIk0NH1APkN9y8smEea6P7oCKKoG+GitrtDjs6271Am+ub78
	mMjKFWR3qdOekoyHHA9tzxGvUc8kQLAM7rvbclT5rNZ4w5ACKdEaclsggnkJgL68K9QHjIgP62l
	GjwKWK0gIIUtbgOQJgE=
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488d68c2cb4mr78895705e9.24.1775897081174;
        Sat, 11 Apr 2026 01:44:41 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d689110asm41117715e9.35.2026.04.11.01.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:44:40 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
Date: Sat, 11 Apr 2026 10:44:01 +0200
Message-Id: <20260411084402.71837-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411084402.71837-1-joshua.crofts1@gmail.com>
References: <20260411084402.71837-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove kernel.h proxy header and add bitops.h for
better dependency control and code clarity.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - removed redundant bits.h header

 drivers/staging/iio/frequency/ad9832.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..8873a6d11e 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -8,11 +8,10 @@
 #include <asm/div64.h>
 
 #include <linux/bitfield.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-- 
2.34.1

