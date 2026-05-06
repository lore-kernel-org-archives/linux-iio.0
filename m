Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC84A2E12
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092184; cv=none; b=iUMA/RUEsk4aOjZFXGL/BdgUsMTJNoord3R7z9sEJADR6n5q9HCdPd8/8tYfQo2HhH+cW5ccWyYRTKl2ARAUvMrnjJ4vSmT1h6n34ti6xAAW38qbjXuc81a0Dyli9S4rku5f69PGc59lQFynopQuwofj+gKsSth8FGotBX/G6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092184; c=relaxed/simple;
	bh=zaXlGvjkv/M1xdsjF/NALFV1iR7tF9iRYdqmcdEPhoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VEevec4pRicT2oLqO4TypRCrcp8ks2qfenlEgw7xnbXdJu7LtnIgwqtOCvp7Z3RYNJcAj0vlxUfxTygQebVCRl4aDzGNfkJyaAykpXkz7HIdqYyeJnzzUoE+D/DFIW6k0XjBqjMFW4ZSNWaAikX129HqnUsJ7gXvHvvYZAEeIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH+7Vump; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH+7Vump"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so6949695e9.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778092181; x=1778696981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLRjI2zYzDvs41xELkxGQonUgerz4v6nxvsRNIkfO/c=;
        b=mH+7VumppbAHkPniXy5zMOKoYA3KZAWHWCxUTQbM2YPkSQ+00jjloPij6VAIGVsRu+
         y2dMqAJi/r9gjgxM/uV9B+HSvrZ93aV9K6v08OzMWcP9hM7inKnkDjlwjYX1c9pVSqEp
         KIfZF56uI8FupRUFoYSi4XlksgtTUDefzdF1ZGtFWquwm9FZqgSLJOlRg7j54z6x8mml
         bd0BNelYgw+BH4Lt/QensB5XUU2m+1C9XWoD+xKH+ldNh138DIiyTtoZ8v+CeoxOCIdh
         jrMRMMUkx166g0Ak4EWV7ufD1QqgnmJZCF5wZIYdKOFZiozakXT4Ik+VpUBwJfHsgZ2x
         RY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778092181; x=1778696981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLRjI2zYzDvs41xELkxGQonUgerz4v6nxvsRNIkfO/c=;
        b=j6VhPs3PvdJECdyzwgUp+VFZFm1ey1ylF1GIjHxK35IM0srCchvfH3XBNoRhydVAYb
         JDEojKXWqhNyb2svwfCYjPDIMuwV+1WkWgsb2tuUIahwx7DP7yQeDUW3VECLYGJ4eb+s
         tSME6i3pOmXiiQx8aCSuHhRyCrhwRO3ODIshJaVdNaKl1NlZL6viwyLRH9gl0EQ583f2
         T2dH1VoMuLQb5eXg59IsQ9L9zo8DpOIXNFcACMJxE1+Tglkp9zZAcwr6IeDO0tHKiqqZ
         NCPTUpvpZUFyJ/tmRFHkDu+wllupt/M+e0eO6KGhYctxG1oRsquSr/hb9AYzsSdYgYX7
         Lt6g==
X-Forwarded-Encrypted: i=1; AFNElJ8J4+TLFIJ6PqryPh7BrpAAjjLTbhs3YnrzfyF9za8WcN6uNk+/69rbuIs6wRfTWLFZHg/u10aQkhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74Uye37+xe6nxl2tTXnwrhcVZyCsmueieP3/al2NQ2phFgl6p
	j8/H9JnQiKws4L/7wD/7uZl0lWdfm5p3zRNif4SvmhAw16JSDOyBNr9K
X-Gm-Gg: AeBDieuCP6NX7E9Htn2mGEpObKUB2GJOc3K08RM3haRXGR7b+auLaW8j/3yritzpc5F
	2VTwBgbHP3Q5ywMZ2rwYuA3eT+/1t8PKWmUGcKqzdGO29MZ3XGygiKWu9LyLQILwqkc3263uVMA
	VZUR9E+o+jBCryf1bLzblBXKL7BuhYIQC7rgYdbjJL8Rt7k/phDM9GtIvpqnv8UTYLbaGEzpWwO
	qmA9Cp95cdTQTO+OSGeK4riwQ5dcj2rNshqmjyAOdr5xAiv6okCgFduoLuHirJtxMHpKz3qi2iG
	E9ZvFQpvY/T75xzwbY4MpnAIP6uYKUYBCa8c4ZcOJl8eYyyKoW+My4sczj4yuERCXqD1ypJ3nIg
	HmRjJk/T4kUpsqieA/w0w7TjADCM5ofM3IGG2wK9PCzGCIUh6y148zSU8brHPR8QTpFwnM4cPFM
	lu4dWijzSpC9osFRpedis08BPlHlgRjU50ZtfdkibDvj3EfWH2FA25ILyMEJzHlsU=
X-Received: by 2002:a05:600c:3549:b0:48a:56d4:7274 with SMTP id 5b1f17b1804b1-48e530b0584mr35532385e9.3.1778092181196;
        Wed, 06 May 2026 11:29:41 -0700 (PDT)
Received: from LAPTOP-9UC0RPH4.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b6e9bsm107381755e9.10.2026.05.06.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:29:39 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH] MAINTAINERS: scd30: orphan the driver
Date: Wed,  6 May 2026 23:29:29 +0500
Message-ID: <20260506182931.494-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maintainer email tomasz.duszynski@octakon.com bounces with
"The email account that you tried to reach does not exist", and
the author has had no commits in the kernel tree for years. The
driver is in practice maintained on an ad-hoc basis by the IIO
subsystem maintainers and contributors who happen to send patches
against it.

Drop the stale M: line and mark the entry as Orphan so that future
patch submitters and get_maintainer.pl no longer try to deliver
mail to a dead address.

The F: entries are kept so MAINTAINERS still describes the file
set covered by the IIO subsystem (linux-iio@vger.kernel.org).

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75af..417dd6d48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24185,8 +24185,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 F:	drivers/iio/chemical/sunrise_co2.c
 
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
-M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
 F:	drivers/iio/chemical/scd30.h
 F:	drivers/iio/chemical/scd30_core.c
-- 
2.43.0

