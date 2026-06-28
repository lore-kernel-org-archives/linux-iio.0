Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A051C695
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618515; cv=none; b=n3ktdM250UaVPLxtETyOV4QmDJ0iSe+doyFHMJcgIxCy0AEVckTJtrMjQ+0pskdB744ob48ODHegJ0t9hLjCJBkCPgCqiX5TwLix5AXqqCbwj4NkF6tbXFZFlQkchcC76sSA7fJamt3e+YbDRNWRaSajXw9l+DSCR3A22JzIxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618515; c=relaxed/simple;
	bh=C6dm9h4FCldfYL0DRrmWcPjha9R4ntM5dvKgdo3Q5+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0ib7JRNF8EEbbfFva7atc+oftImSY5lj3yI8OrqAKbTdCJ9uwbnqAlJuwuJL5otwCKXp1rcQ9/XxlC4MyNceN5GIUXzPbqoZ3xJOhwmI6zZfY/uHssFvkpquFWbWqEv2Vsjp2igP8EdrvAw5vjZaMdzWgqGHi32Oz/BiAay7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=aMxq44Uw; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="aMxq44Uw"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13810b63a1aso5250529c88.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 20:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782618513; x=1783223313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ18AVQFVXPgnMpHvHRAwu909mrm+zckiNGiDpyp6RY=;
        b=aMxq44Uw8GhNgNiq+fOAjS9RAhLpuyMHPLk8sXVGRQSgeAA5uQgAmWTFK3z+fSxHSS
         97MPiVNnX41dluvCY4X4vuM/Wa8JCmlRmtwC2QF7T9X88tKimH2SfZidZx2TMUsdH1pk
         edGGGU7Ho+Fdaduadq/vOoFN3KOwDQpQqDSDdEwWkyFCAdc6Gxp3XMGw7DdR50iuqKdU
         E6w2u3jdSXHghlqKUroF+1BMuK4yVP+u70CP828CIhQG8FymNZAGjoDNsEGjnOdCryqW
         3PAFs623ts2KuSojJdtwy1jLJ2Ot4+ZFvQa+wQAPbuY9I+KEbG5ADdmReDtYD0ZyRNVG
         bvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782618513; x=1783223313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mQ18AVQFVXPgnMpHvHRAwu909mrm+zckiNGiDpyp6RY=;
        b=Unpfb1064Fj5S3dbx03/kii9QOWE5RRoiavu10hYV0tDVva9BuaOS2sgl/oMHxBxu5
         RFfb9pDqWjyUa5xnUnTNrU5SDo5HbCc3zfygXDkKitqhCVBh3JoDtjBDAssZn6Z0xe+W
         AIgiNT2H9m5frmZ/WyT4rWx3vwIKFO4M+PNAPjQSgy7uN0jN53WfpTlUmDHWo1UxiX4t
         8tFIA9c/GSPLo7GUPa1IH11hd/zksntTScsLmEElK8LfFUpEOaxcCx+D+iF41qyneVhr
         DdS2O+GZEQmm+YZhdK7kg3h4YaDM6Gx0zXnRhG+XtLHaAxLFJOxrrZaoWHs06uic9SIS
         3UIA==
X-Forwarded-Encrypted: i=1; AHgh+RraHyU85eQ5tp9JOXoE9x/oHAiNkjiFK+JRUM1MKgabW87p+ZLE4ww7LIxAg7BykQLkEyuMnFJBJEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnCSiICdVgWnR+/Sb1ydZIP7Yba8VSTru3O0hAK9GEhm0gk+C
	WKgfKBQr0ZbCL6sEtBJNzZo6mSRCNEGmTo+bwbV5ziYkOtOJhv1twspc5CO0bVbHIz0=
X-Gm-Gg: AfdE7cl0vUOE2vHxSIIdosEZvd5wVtwAo633uUzepqRF6o0LWSGomdkJHx17l0CjOZW
	Wb2WF48v1d5R/ventPZvlSU5n4IFoYdbPOR8vGjHWEQSftY7jN2CPk7/slVjofEE9vwZ68mMfhH
	WDEOWAx0ZxprAq8+HtpFMV00uAR9c0IUnFG11a5J5sEzdBklRcSYY80lBBz0Fd05FsAwiozbc4R
	JR1ID5a5J259uLEW8wYTyUd+0HEaAb4xos87a25ZfDkOMWPcZRUk+M/GDQJ+4/tQYhggPiwc5Ep
	tTL8x0pnoklxVPv2W9Dj9bIhMGAJ8cLoz0Acxf65ZkBIsaaAVUkc7jmuAxELnQL3UY4m+ojPpNH
	cY+xh6n3EZ46IlaBl4Ro2XZdKBbKeWnsblmNPvUgOdU9jdHmhgND8rD/wazwSzIH35uGPuwkbtR
	K9r80SNbsn7D1e08hFuxnVNDGIOZY=
X-Received: by 2002:a05:7300:8bab:b0:30c:6ac0:5d8c with SMTP id 5a478bee46e88-30caae2e94dmr6556947eec.7.1782618512942;
        Sat, 27 Jun 2026 20:48:32 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:dab8:1927:ea27:9d41])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30c7c4c691dsm31546809eec.5.2026.06.27.20.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 20:48:32 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v5 2/3] iio: dac: m62332: Clean up header includes
Date: Sun, 28 Jun 2026 00:48:10 -0300
Message-ID: <20260628034811.152946-3-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the IWYU principle: include specific headers for the symbols
used in this file and drop the unused slab.h. Add array_size.h, bits.h,
mutex.h, pm.h and types.h for symbols that were previously pulled in
only indirectly, and add mod_devicetable.h for the device ID table.
This prepares the driver for the guard(mutex) conversion that follows.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/dac/m62332.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 56cd0081afde..ee8fd3a71315 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -8,10 +8,16 @@
  *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/types.h>
 
 #include <linux/iio/driver.h>
 #include <linux/iio/iio.h>
-- 
2.51.0

