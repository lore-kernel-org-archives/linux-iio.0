Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708113;
	b=1J8UkU+BYNMahJmgfSh2ChnnlyR5GbADkd2TjQ8EiiAzES6t8t0CNDWCpo5/expK6E0a
	 oO7PYhOkKh+CDQ6o0nxjPmImyfdJKh8kX4thGB866QSHERWNt0oVSSWSkMdOiKd/u5tRv
	 j6u1DGzWQqV+hMmCYeCctWP9LNsZkFEfxT4PbYN1vnIF5EeP5spoHFxvlCA+tmXBI9vVo
	 AbXQJ9Mr6NJmzT8W0Uhf1X0HLxdvUHeMc8Zanlq3u1OGiJXH7uq6ywfYGnSiO9GdVnBiL
	 pl4rWbCV8Xtaq5+iDZKZgqlCh0V9kzo7gvbkYdAFchul1f+gdyoH5p5Di0+8yHI61Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CQUJEsM41kQN1gS1eh8fcKksxwF/ZWRkcSj8ZZ5afgo=;
	b=DTLCzCC080djxaHPKx+1X55mCOBxHaslbetBvko2E96eG+wubXcqm6PzDocD/doDsVaU
	 Gm3OkFMryGGZE2idTRhfFL0WItEkvuqXV8oTDqy89hdma/ExymtKIS6XGWxl++QWH4qcH
	 fDULXjn5afPJdowsuEGm60BIyJSirqbd1xCgCxXDAGdDUQ0NmPjNNTHx6Z1aI8m+5T5dv
	 Qo1A7tWrPbSCMdSOOi5MkTjP13KUvLBQMmTNNp1UTQICAGomCgRnqDL4pD4SSIDPSxrmN
	 MVbbkv/iBVhf4lFFWcFQ0+PhpM0tGj0nym/MtyZTU1EvuCIcMfG5vpd69lyaQOpRDtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtZWb36q;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6291606A327
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 02:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6291606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtZWb36q
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36dbde64409so3399221eec.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 18:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794708112; x=1795312912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQUJEsM41kQN1gS1eh8fcKksxwF/ZWRkcSj8ZZ5afgo=;
        b=JtZWb36qW7JSsf2oREUwNmV0N73WQXL4ymDp3d3pF8nvydsVsmIvBN4L09dB5MAeJk
         pqpocR1/1pFMUUfgYwB56cxqGBk54gEgkLqjvCsO73mlaV/bgcbLB0+ifML5FVmouXVI
         RXSEZxg4xG88cT993gOJ4V7B1+Prn7mUs/N6iVgPcjC+5aPtFicwoLgr3EashKHfgEBG
         /wBS0xmQ4B9Wtvt1WGUgYPeuI55A74dGGySEjQWd1v/3Wt1RQNp0Vmx4liOZvC9I7s6+
         aCdm34i4ervs9AMsSvWrfUjp/qBoRU+1xUan9UUOw+E7DwGBfSxeiRfC/mchYFVm/o1Y
         3DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794708112; x=1795312912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQUJEsM41kQN1gS1eh8fcKksxwF/ZWRkcSj8ZZ5afgo=;
        b=frAGMo45ulI+vxypNN2RNOFg0iHoJ45mdGnu0zI3kPXQXATwav5ArpDZgnkbwDJAfi
         AF741I0naGx9Egw0XlpIiMZ3lUQBjN7bjXGlMZNWc4zvzMKVnXJSWcPFr0ycSI6qASeH
         8vLvAApKwsHtqHzFTivRekpJWlK/hnCr3cCK1PzDi27YBBNHUlQbGK9s7QPKzSbwcs2c
         aIU1kXxqVkxL8aLPBrDzpCastMZ+oJ6yP93haHeUbAI5WDMUjXwpulEhOuFqApTsr3vV
         f/azYiKmobsGvrZL0B96QHIsBVGChKNGbFiarwMZdHxoOg+7KQPoyTDspHBxXK9v9l/K
         s1gQ==
X-Forwarded-Encrypted: i=1; AL+hErF3ZBEiCS9MhEji2qropBr/PU/hg0bzTvfqVxTjWRodQdUY20Mv8pZcljhMtNiNIXdktQpsh2qVW1I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Vtf2kdXYFkXbHl+W3Hsxlm2hALMNW171YcvAeSRD3bgjvNHSr
	74JZjtyE2lQlz+K02luvuO3CVQMhpgW4RWfP7UumBbyK9gOI8AJ0WeYE
X-Gm-Gg: AYBFou3swVs/JzSllSMNWsINRbwCr9ZZdOlQPHZlLt2OH0meCXlx6Nr+c9SrPRxanSW
	eqzBZtgz2LAViqYCuH2/BFq2hk5KuZSFAGZAYVYBl9IkU/uRplsD3BDPSRMNzLfpNit9gwGq+pw
	BdMpNlswumQWgyKBfQsaTZ4TYvhPyenzzxvB4lE2NQ1ZsO20FrN3fXxKTD/CiB+MU010Qi8QIgD
	/XKavH60N6ttzDjZ1+aVJEGani35QQJbx6Rcvln7qD8J91VKYcgZrScOXt6DUT6bv0rn3Ku4xuI
	5heG6QB7ITVbdV8+zusfffPmfgR5YOD3zIk1aePSJE/j/Dc+kjTiSthYWfPqVksLXpG0GPXgEW9
	5Ke7O8Vy8pp2VTmW4Zoss1F7dLmDuXL6PXy0K2j+nU7OIMCG/LwD7D4bOCIiIC8hdtiSuxS4hOA
	l749TiY5AFe1Qr8FDj4I6Wls89lh6QiG+ojjtWe8lt+tVasrutTe0G5s/X9BUfR9tUHqOzuM3jb
	u0P3LmboeX5H0vbUln6NlbUw6TY7a0vR8oyO5W6CJ3LWUZimHWsz2lerafHzKVkWwCKkGyvkQUP
	Cci1GfJvQDxH7hE3QPGY1sVmsKN9NurtX+CWY+Cou2gOPnspHLMT99TguN4LHBbJZdhL5Ab4fnL
	g3M48
X-Received: by 2002:a05:7300:ff43:b0:36f:6b99:f963 with SMTP id 5a478bee46e88-37966d408a7mr6873878eec.21.1794708111511;
        Sat, 14 Nov 2026 18:01:51 -0800 (PST)
Received: from kdev ([131.179.133.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955ffcbc9sm30588433eec.18.2026.11.14.18.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 18:01:51 -0800 (PST)
From: Niloy Meharchandani <niloymeharchandani@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niloy Meharchandani <niloymeharchandani@gmail.com>
Subject: [PATCH] iio: accel: msa311: use devm_mutex_init()
Date: Sat, 14 Nov 2026 18:01:29 -0800
Message-ID: <20261115020129.10259-1-niloymeharchandani@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Initialize msa311->lock via devm_mutex_init() instead of mutex_init()
in msa311_probe() and propagate any initialization error. Include
<linux/mutex.h> explicitly.

Since msa311 already manages all remaining resources with devm_* helpers
and defines no remove() callback, using devm_mutex_init() ensures proper
mutex cleanup on probe failure or device removal when CONFIG_DEBUG_MUTEXES
is enabled.

No functional change intended. Compile-tested only.

Signed-off-by: Niloy Meharchandani <niloymeharchandani@gmail.com>
---
 drivers/iio/accel/msa311.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index caf9b1b6397f..0e1af4761b7d 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -29,6 +29,7 @@
 
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -1156,7 +1157,9 @@ static int msa311_probe(struct i2c_client *i2c)
 	if (err)
 		return err;
 
-	mutex_init(&msa311->lock);
+	err = devm_mutex_init(dev, &msa311->lock);
+	if (err)
+		return err;
 
 	err = devm_regulator_get_enable(dev, "vdd");
 	if (err)
-- 
2.53.0

