Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE83BC68E
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791694321; cv=none; b=rgK+hRyYsTpnr9C6pDg0EkM3BS7PYDjFQLEfRa8ioVAbGW7ty6YEdC7ppvhNPOxuPDBMzBzLrjWOiCVsrayuznL01YpRj9zT62DexrLH8seQM76jX8qp6AoQg3XtYLJTkKx90ZFE6Xs+dkSE2rn+aSAas3jziQjjSLUUPsMx85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791694321; c=relaxed/simple;
	bh=4lfV7+sqzyweAXYe880vnuGKWpBB5jmGdvI8y+TeBCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdLQGJVHJmcjXBoQJY/l6UnDYnnpE0Lnb5YxOJChDESlAy73OkWKWQ//YDhRbH3O624neHm2pLfLsDL3SdnsisPe/F/Qdi1vw71Sc9t6Ncv9Vr1Fydd8rpQmXs7NkPE9v070n8D+aJFi4tbfX9T2FIuQIrVvLzXk5Pg1e53fwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmLzTy5C; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmLzTy5C"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30b6dad2382so2127600eec.0
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 21:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791694318; x=1792299118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/+m3dioEgJeXpogr386BWGDMeXCqTiF+8xcjGlIA8mg=;
        b=dmLzTy5CHZCDuTBE2Yd0eB1IgYME80rWOMB1tPc1gF8lfJ/CNcHKirDNyAXsnCNBES
         kMPzAyoldun353uao73HtY8/8wieuI/zxU8px6L4E5lulTUAdolcQteO2tDrJPClHDXJ
         fydYFdifcb/XNI3J/ABMhVo/BU9MhIDO5rb181OsNa8tZUs6yE4dT1uIXOKiFm5jrML+
         3l7E9h8nBrMsPTHv5beCz0ogOoX6qIpp/Ym0PzOrju85EDqPfR04HXKg3s7oOkqXM+uF
         17bfZyaUVgyAdtC9VkFsWosu32OAeQz6rmV0Xak4Wiu/vSoe1WySYxxFIqEOncM7vRZH
         Rkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791694318; x=1792299118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+m3dioEgJeXpogr386BWGDMeXCqTiF+8xcjGlIA8mg=;
        b=rzvDyQXJh59e5BZyBeIwLnUg0g0PohUimmuhpPoMoNue3nI0zFjvySLSr973TSgyCX
         g1ibf42R+P+EIoWvN2vBn82nj+ZH+USMkmS+eLmGTuZc7Vdi5SHMW7LkZ2jPIL+MU80N
         2SRBwxRoJKPBQuP4MlrdE9t/E5wOa02hVReu300hzCJkMOs+0pqUQH9wuHCozMR9an3d
         o16IYF9IYE3hB4RPSG11rJNc8uZ2tyzw1u8/PXtkmpXJUJJocEHweiBotci8mMJQPgIV
         GU/gjFVgy/6eDQWpyuLCOHgUZxGARQ0IFfwHPJa4BQZB4RQtTCgKM7dJ07c6M669tUn+
         Zl/A==
X-Forwarded-Encrypted: i=1; AKwUvBz4hTszIJdmxE1txHM5cZtU1uXnC+mqeys5Te/Fh1x2DSpw0JLtVEKNP78T7ZY1mqj6ukEYnqrw+ak=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrI1s0s1lUNxJsbRXAc7rV6t8St/+FmT/qdxi5wl2hpOitBaA3
	3Wh3e7TkKm12Cvd7EUjR8HGX6lvN+CfN9kUGGgYbUz/z1C6aj3ucsvc9
X-Gm-Gg: AYBFou1SYUTb4kUAmaj2QspVu2c7NWcoo/xHDxsKzMfkgkK6i9gMLY5AkZ+KnY2Csed
	uZbyiVGkzamSydCNdd1wkhCZGfr2rI2fc7a9tSMJXsRwWoPPLK8qYQZh1AvwpoR0js7sxCDhP+p
	aRtF98Sw40sL0qbfCUBefsqoFNikh6Loty2ovg2eKePGSkl5+t67tE78eybotOc5Hsr7mCp11Xc
	bpv1hYh1h72Ug1IY9ODaG0WBVu5P3cdhIm4h9Fu6eiS2u+EBYuw3GuRviaF00g1vG8nW5kI1dOc
	kWGpKBicg5fnIczWnZ8HVATvca/l/WFVL32e+jZjKV+2tU9jkmDJwuvtfbfBMyCoq4ts+rulYax
	QAFntC3Qxsf8HUYgWTqTohNQ4ZzCLde1IXN+4dPtu7tpGjQ6q4z5COy7MAAcmS+1P3/4theXbCr
	JT9S2GM11Ojp29plhY/UUQlpUJDjZAvhcSfjCKGcS7foBoSAuY9kky9PjIwNyUY8DPHTnaHk+71
	PuhmuRVsEStJ/9WRuVH3nfMk1gcJ/ClUWYM/p9QkDr9N0NNREJiScOBil5dHk+rJflSPj9rMn0d
	27q3Qahsc28TaTslanqx+8L33PuY3w==
X-Received: by 2002:a05:701b:4212:20b0:168:e942:4e62 with SMTP id a92af1059eb24-16a61789c56mr8352937c88.40.1791694317514;
        Sat, 10 Oct 2026 21:51:57 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm35733139c88.13.2026.10.10.21.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 21:51:57 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: dac: ad5686: fix channels member name in kernel-doc
Date: Sun, 11 Oct 2026 10:21:47 +0530
Message-ID: <20261011045149.353929-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc for struct ad5686_chip_info describes a member called
@channel, but the member is named channels. W=1 builds report:

  Warning: drivers/iio/dac/ad5686.h:95 struct member 'channels' not
  described in 'ad5686_chip_info'
  Warning: drivers/iio/dac/ad5686.h:95 Excess struct member 'channel'
  description in 'ad5686_chip_info'

Rename the entry to match the struct member.

Fixes: 0357e488b825 ("iio:dac:ad5686: Refactor the driver")
Assisted-by: LLM
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Comment-only change, checked with scripts/kernel-doc -Wall.

 drivers/iio/dac/ad5686.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 482bc70515f7..4f2ac1e96643 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -85,7 +85,7 @@ struct ad5686_bus_ops {
  * struct ad5686_chip_info - chip specific information
  * @int_vref_mv:	the internal reference voltage
  * @num_channels:	number of channels
- * @channel:		channel specification
+ * @channels:		channel specification
  * @regmap_type:	register map layout variant
  */
 struct ad5686_chip_info {
-- 
2.53.0

