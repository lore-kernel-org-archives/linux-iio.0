Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E223FC41
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324484; cv=none; b=FxhH6Q1XQaVTZjzFFRfTf1VTIQRPoSYYF1qA/5GZMcHvxAyKspXdDKOcrhjbrt5RdKoKShBZAL9cub/zPOmMlgYMDipTUAsvncWzrjALivtlKcIr48ADMfxefi1GP3Kd8rbYu+nCwPk6wcAeOvswmsNolmIxH12pXQrBHHgoX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324484; c=relaxed/simple;
	bh=95ZOlu+UCqK/6PDYEHKpsOu15pHXemLSfdp6T6OaAPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qore2X07YIFM69SDhndD7xk2C2IKckod3BPxiMvi2gjPO/ZUhQ9djBUswrRUFRVguCrlGZO9GjSyD27OMS/8nVJefls9uyJgJP6O4W0m4hbGeumeJiXZdGOD0Od00fOs71vaibQOMRM/YOzII8mWMfdpZ59Wyu06aSrpNviOpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXT9BekJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXT9BekJ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c160420289bso173459566b.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787324481; x=1787929281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZxC6JqTERX5WpPVmdr7ZT9okF8G/EJ/Q4aKFYdQZiRg=;
        b=qXT9BekJ1sM5W7TQdfdFA3PXJyfq1sbWPlmhvH+EB7y2iWKvCaWDPEaiBcJdwAbrib
         j3lmOk1yxDdDUhGVcnNdOTcE/4LKWGhNX0+RHA+C5BSfSxb7+UkdYHmTq/9eRFYy8uqm
         Qui/dTW6C615tbMXJHBBUBndigOBLPcrfvgGY7o4M/qPO8VOvr4BH0Nl4COZxE60cWU+
         5SKxuSAHMiXhVemP77i1jgng0Kd37rLew4nAaGNz0AqA5iA7Z39rNasJVWbstddT2d2E
         tBuR98oTIOqZFn8u9pEyFNUJvF7iTVp7c2LglWIkbK69XDyhtr21lTn6AflRBOMSmTMK
         EQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324481; x=1787929281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZxC6JqTERX5WpPVmdr7ZT9okF8G/EJ/Q4aKFYdQZiRg=;
        b=gd5NMojh05gKCPj9ZBZIIYaOMq/Ab1CK0bSvUkWt6Bb7QnEUYgP4ynG8CVo0VKVnns
         nrn+EmrdHmn7O6/NuXKcNniYS82lXhlvIWnO+GXWb2uueXBDb9UUHxvxL9fu6KoFKzMU
         cAcRFsesg0tL92u4RMgIfO3EWlg24GTHIgMC/HZq2QSsvsI26MI0CDa8gtEZHrXFvRO2
         fFb1kV9QHL1m2ODznBKgSbWRQ3tYxrga9IUYq0J5ya2weuna48kTQqxKbt9SdwhReJN8
         xmPEbf2CPY96dYZcAZNQ6R0VtpQbnwpOIRTyX1f/Xv8LATo0OXhIHs2EKKPuqcPby00Y
         O4UA==
X-Gm-Message-State: AFuF++lY9J7W+ms1OSUTr+fL2P0P4zee5kOkJw0vqDmU0sOonz/gCTVn
	KeRTeDJKqMIdFsdT3L30Cgk9KKqnA3E0AX3VHIz7SpgEgiG4gCCRwKjgEoiW6Q==
X-Gm-Gg: AR+sD11TCNJvF0aXMk62fxIxHd39+ULdkb4/hYcdjQVYbyi4YEyN9gNCIFMW3xrBBWG
	owVrz74brBSGF5sU7oEKdeTbcsBFISPGZJUwhmIg8y0JmM/poltl4FxMdSj0Tu+C/TAd4nMo5SP
	F07HPx04DLOZ6isC54aPihzpH+GXsEJSLoF/Dg5FY05u0fzDK9h3wlkKQ0nejkJYVzBiAY/UZP4
	Fxe2UBrAYwEUNHZq+7NUwDIAq8Acp8MtF/F5CkB9YcTKazDSNBYcardAAawxgI1CCjIStKHZqk9
	SRYLekvZbad1TjJuzCxm5SqO4Zl8eeHcssdY3FY/NMM71bJnhOjo7sikSReyNAZiTL/FJIrJo+O
	DVg2VTY8bj4nm47De8l6B/Vt3+bsLP9blKqzFrlS0cJQZEgpjI6a40WMZxIX/kdz7/0dIdCdUKT
	40Q/zPI7bIYmyI85RWzfjGZAjIbDR8tecwO3MCfyavUDMoKtnHErz2rPMFGD/W5E+7sDAhGl9EG
	89Q
X-Received: by 2002:a17:907:3d0a:b0:c20:74db:50c7 with SMTP id a640c23a62f3a-c246a697ac4mr794550966b.13.1787324481027;
        Fri, 21 Aug 2026 08:01:21 -0700 (PDT)
Received: from localhost.localdomain ([196.235.131.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591979e6sm621734966b.33.2026.08.21.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:01:19 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2] iio: accel: sca3000: fix frequency divider condition check
Date: Fri, 21 Aug 2026 16:01:12 +0100
Message-ID: <20260821150113.45972-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting the sampling frequency, the check for `base_freq / 2` is
followed by an independent `if` statement for `base_freq / 4`. If `val`
equals `base_freq / 2`, the second check fails and falls through to the
`else if (val != base_freq)` branch, returning `-EINVAL` erroneously.

Fix this by chaining the checks with `else if`.

Fixes: e0f3fc9b47e6 ("iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes since v1:
     - Add Fixes and Reviewed-by tags

 drivers/iio/accel/sca3000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 573831199bba..cced5cd82b02 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -638,7 +638,7 @@ static int sca3000_write_raw_samp_freq(struct sca3000_state *st, int val)
 
 	if (val == base_freq / 2)
 		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_2;
-	if (val == base_freq / 4)
+	else if (val == base_freq / 4)
 		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_4;
 	else if (val != base_freq)
 		return -EINVAL;
-- 
2.43.0

