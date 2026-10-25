Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792937636;
	b=kKo4FcvfeYZWiT1Rs9PfXb2UKqMafNC8G/9RiOnN4x4y3JktvwHGsSTrjg0EZvvL/mBZ
	 MHMVpp7Za7Izbmnhi1eHIl702zDWYQ8WIrgY80rJS6ql61w0K4qftmxfNrOt+bSR6qYFx
	 h8jJg+XnkbLsOWWHfrSCq5egw7qXQRKTrW2zJcJBzsE+jcVGOUs8Edghwr2hTYW5lNJgi
	 4IqfjD8Ql+FsXMDMfEOroZx81SvpohRy8SACQ5hk2/8Ukzea4TwYidEGgGFvwcOf0vE4H
	 5ua2KJKWqwrzEcpVj0sLpAWI6ym+bAr0aogWvwrkSfFvpfJb1IF2w7y9VrPNdFpTC/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JCcriedaG9Q2J0hr5lnlt3xuWfc+MNZlG5G08p5ypto=;
	b=ZgqwlV6pDt4HD0oNYYkGHuUY7H0/gIhTg7eAGbqwAH0F/AniEUeB/J5XwZF/2YzsQNZT
	 vb5rpIvV6NVthkFB6tSBxUX6vMqtibFvf9+uwEVyr3vorfVCr7dbLJL+iKTN65RKIjU2X
	 nE2rB49apTb6DQc7O9oCmQ8rc7Jb4etib+MdjED+UXL2ssbrE1J3EO1ImbtCCMbTvQpzz
	 lqrZ/egVbtn8/jtrdpCbAQ5SsXJqBKZp9WPCf3a9+gWoudDrP9RT5tDYjuQoH5uEt9gS3
	 qCmCvqKOdRK6NN6V3aDi0oDR1U4ieYV1uGw9oHk81+Su42Ni/ampv1CGFfcwmlBlJVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIpEXc9T;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0B606A31B
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 14:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB0B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIpEXc9T
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso1429529a12.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792937635; x=1793542435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JCcriedaG9Q2J0hr5lnlt3xuWfc+MNZlG5G08p5ypto=;
        b=qIpEXc9TDiXymyFtrf93QEMwbHa0MLXw+nOWWTYZwDMbGl4gHheJBoomqYOghmDnZA
         wlDoPpeB1SNvFjn8cZP3oFaSntUKmfOkYy/NGnS+1ux1n9xyB7iUSrzhDyHxmeuuMgcy
         ZG+5uK8WBcXaOuXrYL+J1ENAE0RTI8AMEMFcYWhcmJhA2iADoedu8r54JwWVHcFCvrbJ
         21RYvHP6m7Qk1xxY9HIF/dK8vyUehiUJ2Qe3zkDqQdxILYZtUH36rnRxAtQB/AL3lQuF
         lKmWKnHUWueJxVBYstbmRq4+vRoI88ZtXALBtLcYy9KFxdvo8gHa372FgDaJyJjFl11D
         Fpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792937635; x=1793542435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCcriedaG9Q2J0hr5lnlt3xuWfc+MNZlG5G08p5ypto=;
        b=T7DbQy/Kk11CSOaQQGOln/cUng/2B/IFNZFVzXVAc9NqTC/LSEXOj7A+9rZqyWDntn
         EMWITNrvh02hv2zmasgXMUpwNB8PrWrLCQKyS6D2+GVXr4V/sIKQqcFBvBC2DjNBfCOs
         a1Gja7963gKmlCnE0WSZXZuaQkJTG1gGoVtRKc4i4fj3vd+pjwLke7fIFlff+Ek9p+R0
         lbOikTs9IM2Jgtpbb6hkhAaYkAZgjPjJ8BSMoXA6/hL6KXlsKELNz0lRoFyV6N0tQKlb
         hYKa2vady75x6Cj0wA31n8oE7Ii46dRPY6daoGheuqCbJlaEH9HuLaG/Gq6SNJHH5jak
         Jz9w==
X-Gm-Message-State: AFq9FYK5mbzajSBwUJiKgo8pMvtfjHPf0cSzpFVaATJwuYTo2cJx4hWk
	t/L/VwwwVbyVSv4JA6gVN3OpfUA3D1RYaRr1xvE+dzvA9pkfT7IxoPN2
X-Gm-Gg: AYBFou1veEoLwi60pY2kv9NohiTRHsVZkWeQNuU7K9tdKLVSzp0kPKV2TUncbuj//1J
	/NWlMpzZi5hYAmoHnw65M1wcNn+kCAwsALUKA/GHcv+rKDPG+WIF8GCsbi+F8gdP/N58wOs/NRe
	CQy7W7+nPMhL69ZhP/2pZYy/UHLnOfeSR5qA8tGdn0CVQ7h+891H7SDWhx3I1Ku/kYKkJdy+9Mx
	k/PtlJdxo6qktRlmt+9RSmjf4LP07tfT+J7imUTSol5bbMaDwtq0YSJjqsPl9DVxHZJijBgvU0C
	p7poAeMmzWbMsJIzX1iTnovrylwoEobk5fSaiiRPwrfxuKPEYyt0yZCMxTXQZirW5mF/nSlomX1
	QFwc/bpFg9WRrLVMF1Ow5lgjwSKbottuhQus/GOUtRdwpDJ05ttr6kpG8m8D/vFMl3sEhGMpcAD
	AzpCKUr1k/SehqRXcudcbwddYyMESOLn5uVz3IuEEFy0ZD1xBfT2AKCAy28tIZS/CxhQgTpR8ds
	OizMgZ5HBuNcVKv0rjIdNOuPv3RVMkVOpME1KEJ/xvDBDFKpg37lGQ2W7zOw9koZuJReRpu
X-Received: by 2002:a17:90b:1c88:b0:3ab:2d46:1dd2 with SMTP id 98e67ed59e1d1-3ade9b2f1dfmr3782956a91.6.1792937635105;
        Sun, 25 Oct 2026 07:13:55 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebae7f3csm4086746a91.3.2026.10.25.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:13:54 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] iio: dac: mcp4725: Update the cached DAC value only on success
Date: Sun, 25 Oct 2026 23:13:51 +0900
Message-ID: <20261025141351.33554-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
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

mcp4725_write_raw() updates dac_value even if mcp4725_set_value() rejects
the requested value or reports an I2C transfer error. After writing 1000,
a rejected write of 4096 returns -EINVAL without an I2C transfer, but
out_voltage0_raw reports 4096. A later powerdown exit sends 00 00 instead
of the 03 e8 frame for the last successful value. The EEPROM store path
uses the same cache.

Return the setter error before updating dac_value. This keeps the last
successful software value for readback, powerdown exit and EEPROM writes.

Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Tested on ARM64 QEMU/KVM with emulated I2C peers through the MCP4725
and MCP4726 sysfs paths. After setting 1000, a rejected write of 4096
returned -EINVAL without a transfer. The baseline readback changed to
4096 and powerdown exit sent 00 00; the patch kept 1000 and sent 03 e8.
All 202 assertions passed with the patch; 40 failed on the baseline.
No physical DAC or persistent EEPROM was tested.

 drivers/iio/dac/mcp4725.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 3fa7acc69aeb..94d51af83042 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -356,6 +356,8 @@ static int mcp4725_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = mcp4725_set_value(indio_dev, val);
+		if (ret)
+			return ret;
 		data->dac_value = val;
 		break;
 	default:
-- 
2.55.0

