Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493B175A5
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466715; cv=none; b=ai1j3UbB+1OjNlf+Cf/R6QHKBncDQ1+XaI7gZ1ZsVYeMNdrhu7tSjRZnwQbgwtm0KorfLaObsJ3uyfRZpFErgBHAdGduKwCMXLEU/MzfWGzJqbN9ruO71cgrZJTw5W20Ogre5IvyD70WPft14oKLefmNwR1SAcQvZzK9rhE7SDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466715; c=relaxed/simple;
	bh=vb7R1yQybfDBF115WukukZkLEfPQzU4PLJn5yOLJdYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VnDKzMD0Xet/ebTsU6Dk13ygpTvshXowYST9NT5Ht0v7Qen/qhAUiiAVWNbRt984T+RCKmn83dIx5FFl0IuJLENlqISJPDEXU8nF0/tQgcClpCPmhrXeded/C6uHYoMk54w2f+cym3Tf7oprEdTBxUU6WnxSy3wQdZNyHOobSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gek1HqPh; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gek1HqPh"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12c8f9846c8so5313565c88.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778466714; x=1779071514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5dJJxDTuelTtKgmCQMBBHtFYQaNXdMMZt2BZbSIE3c=;
        b=gek1HqPheBOB9bFcCYRT9YExeVgA3PcLN+ymVQGaoqun8SBGLEaqQ1os1UyKGmZixI
         /q/lWYiP2SZjPzOidRs2eW/rB/8thuFx80O5sm+tBTo1z2/IKD8EH55LZO9zWXvASwvI
         7mtdQooPMcyLJyBc96sHdKrCj+eZ5zTR2p7cAl3mlgtoMx7qFpKk2/3S2QbfYDZmSRmB
         27TjeYP2gWxe7orTSZWwtBwkeQZobtT4BWINazuq6qFdDfhaCawe+cWA0+EVLYswqR8b
         rbdBGW9yojMsFgQ6IU5Zpqy/QxdO93sr9M/a0hROF2jFIEu+WnyA5s3HHRhZnZHAafph
         9c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778466714; x=1779071514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5dJJxDTuelTtKgmCQMBBHtFYQaNXdMMZt2BZbSIE3c=;
        b=m2Wt5cJvlcZJGgwh1D1474p+Opi8cpMyoTpMIsEDh44NMX22ad2EUPW/T+kk22Hcmr
         FtDBazIbUZBRZ7HeMUKW161NGq9UgjGOZVTh0b1fuk6lwlipiiRJlrf/jrEU8dXZK8L9
         J3iGVTUchTDAgJxxdKj39iz6BNA5aN7s3qOxaWvB+Y8jaIGMunr1londOIfnowSws1oL
         fA9Rsz6VZgWZTBnaiEs7Vb2UqdGjX9v/1qikoIhM5fvWLujSdyQ9r+6tfNz3zeohRtJx
         3/VzBvhyPTXr53NjYclrCU73ggUHcx/5Lb97+qAKIwE1mfsAk42FWuSrgrp2LccbxFn1
         kWJg==
X-Forwarded-Encrypted: i=1; AFNElJ+akO8SUPNyEm7eBFb4gBkWZSRKWg4qt6VcwWyn67E2wMHneZcLXevoljRSIlBxp5DOJwGkOsLz7aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeBo0R+i832ev5f72T8xwjZv9X8v990jguuKxOKWi6jCI48eN
	GO930FMgfEfzoUicun7YF5Y6ieX3BNrZEpEaaMnYmdl0wskl32BgtSROg93iuMYs
X-Gm-Gg: Acq92OFWNxVI7yteyzNzqjkqo4E0hC+qLgmceVOWLzqEgIy8s+8pEuDZg4RjFIQ/+cd
	zD1OtuAE/ShfISCe6WSTAQIZn2OVKJQtZcUz67cz4b6ljGvTOfBzLhSF/0yi1OaTXh+ATxeX7Fm
	+DXcz3mPE5SjLv1azeVUW86ShEztcSxUFQ0I0157ybikOsTlVlALf6na580XU+2qUxlFqTyMuOJ
	IRRTtrlW0aonRlaifcht5BP094V848Cc/7QsEVU3KFN42/UYnIyM9c4Uy1Mu13aPqjW/Etz6z15
	obF/cNLQnCt5Qa2vZ/EeUDaAHBXbiHdbhbfFoDA+4mU6sHnsEBoumoQGlOgdZT4VY9VSAycP6ow
	LwL4EAs9CmruHepkPO4FxlDTQuxz927lN1JGOGVmPelPHbzCtvKiSzcBa5El4XC4LLXF8JxIk/C
	yi0AEgsHvChGblm8O4Ws5sXlSXFRnZ5Guse1X3P0SFZtEAE85sEKkbn9w=
X-Received: by 2002:a05:7022:672a:b0:128:bae0:e043 with SMTP id a92af1059eb24-1318eb4a66bmr10666104c88.31.1778466713575;
        Sun, 10 May 2026 19:31:53 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fd00sm15597932c88.8.2026.05.10.19.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 19:31:52 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	m32285159@gmail.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v3] staging: iio: addac: adt7316: document SPI interface switching sequence
Date: Mon, 11 May 2026 02:31:27 +0000
Message-Id: <20260511023127.86113-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device powers up in I2C mode. Switching to SPI mode
requires sending a sequence of SPI writes as described in
the datasheet.

During this sequence, the device may still be in I2C mode,
so SPI transactions may not be recognized and can fail.
Such errors are expected and are ignored.

Add a comment to clarify this behavior.

Datasheet: https://www.analog.com/en/products/adt7316.html
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v3:
- Add Datasheet tag
- Use datasheet name in code comment

Changes in v2:
- Add datasheet reference
- Add TL;DR note

 drivers/staging/iio/addac/adt7316-spi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index f91325d11394..bd92dcddfd91 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -106,7 +106,17 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		return -EINVAL;
 	}
 
-	/* switch from default I2C protocol to SPI protocol */
+	/*
+	 * The device powers up in I2C mode. Switching to SPI mode
+	 * requires sending a sequence of SPI writes as described in
+	 * the datasheet "ADT7316/ADT7317/ADT7318", Rev. B.
+	 *
+	 * During this sequence, the device may still be in I2C mode,
+	 * so SPI transactions may not be recognized and can fail.
+	 * Such errors are expected and are ignored.
+	 *
+	 * TL;DR: Do not change this!
+	 */
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
-- 
2.34.1

