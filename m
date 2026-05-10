Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122F36A01D
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778402740; cv=none; b=DEVmyeKFH7pbZNWs3rNuH9zULUTuOyalHszd9BLNeTwqaolvsX8jQWwWQLtYEeJ2wwU/dpxGDyz4oHNbwoyZPjwd4SFJk+zNfptVN5QIktYu1UUms7pbjjuFzvjYC3KVpjau4UPrJUBt30AuzmzKd+R8L8XVb8cLwK/gFw7Q8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778402740; c=relaxed/simple;
	bh=IQJ6sJVzVWNcMT9OEaBuhqtSV1CxBt6HpxBFeoui21Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtwTeTdg5t+5fB0OCQ5VFsYdAZrEseYJ5eHpYl95rMGot1E0sAarLZZRBwHNl9ArlVX2jJ/9IpctYWWJsUPgJLCIVaUYq8DkUpsCqScphxoXQ3ZmeRWXT96PUJyNqEcwP05Me6rvKU4DAIIItxA2FrFujRs42FxRXNqVvhzLJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbULIywN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbULIywN"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-393ba0616aaso36154831fa.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778402737; x=1779007537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itXqe3lt1DLEoFiF+ciGqdV8SbuYLFWJlkz9sUd0WCc=;
        b=WbULIywNr6uroaT1yJtHcXPTVXRms7+xv32dIT7OrCUpgOUK0wZw9F/DWc/k7szKQG
         87AFpTIZdONHfTVUrZuLnkW9/cOhCXHsCt1yugS7x8rh5pdpfzJiN5Gaxvi9vhWK8C1j
         TGQ98ZiZ5iFZ5zPVGeCR3Tb9IgZuC+t3INC9Sq+xpMM+geDy1+iA/RnozDR56xG1BCFZ
         aKUvWenAP46oPfdfgCQVFZJzyDx3EayEYxaoROt1HrccFVArIkuBveA72TP0ZKYSh6Hy
         ngT3hfOOhcgPBtnTgPpg3Q9zQMWLMKGJcvseQe9iMPMyepEtKis7zMpcPLoZsDBIhmrz
         sMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778402737; x=1779007537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=itXqe3lt1DLEoFiF+ciGqdV8SbuYLFWJlkz9sUd0WCc=;
        b=mE8mh+5+EwaMFbSKKWkDtkYGr2n4EqOq8mV+UpPEsW4+ox/9WZbVnT6eMH3bTV88Mx
         nSQ7dse2lQNwdJOYPxTMytYAVbZ7HypsE50JWBILg/tzglQw03FYILh2aklXI7aiJiz6
         K81ja8TQAgCoo1UN5HFo4TVs4DpWuGO3K+YgjaEYY0zl0YsuxfhzzrCCJhPOd13YOFsu
         Dhx0Sr6GmxesXJmPl+3tE/Q+ljHVLh014xx5i4opIKy1wCYQUwmJmUCDtztKhSlo/2sT
         wbR6GsmJXeD2EtvodzmAx9KaOhUGH4Uv3kA28W6NJFQOeHxTmBtJx3FKXAh3jYIMJX/Q
         gXtQ==
X-Gm-Message-State: AOJu0YxgeRAqflGM1JfVg+i6liWPJl91ucuaMBJUFUsfy3s9Tf6FYGek
	l8Ndam0dgXHfkno7MQHdayf1jeiPYVHu+pe6n5EAq7dnd2SH+MYvXXM2nqyfYB7d
X-Gm-Gg: Acq92OFCQFc1oO77foYLbwn3mmExJj2anEgLcm25uBLzxrVEuvCrh8gJ0nfCkjOnuQK
	W9C2AexadVkeKC9RjpceHygJrvvLcblFlE5HkhwP5NMqjttE2untMdxsGnxiwGl0Te4TbrnYlOj
	c3SLfb+/FaOykWzn8pjTpmz1rGTGfR3Kdx7SlQXQibYvCyTnAzW0WFmKjokbGIaZQJMXb1YsgOq
	vFUUZ1LXn2hV2qXeD2ijlzGjvl6k4ddxO0hLue3RdwZsYLL1znAAuVsio45QICe1gv0c38lSau7
	60kcctKVCZ7ohBOUxsDoBB+d3FkZCBaGGLoblObZ/RdzVrah+cyVCCMhUIqBDhRSZibnxl5Ee/v
	791wfHKOlo3TEE88/9iUv37gXRROjPPg3BDda1D7R/jcnUevCozpUj7Cil4I7/2A8h6jgUCpx3z
	buZPZQAU/23JNilGrb2joD+br9QhYp/YyQB1xQhPPH8PLJUQQpZfpoIzLNEBCAc1z4
X-Received: by 2002:a05:6512:128d:b0:5a8:82d2:4c33 with SMTP id 2adb3069b0e04-5a887ce6c8dmr5804755e87.31.1778402736973;
        Sun, 10 May 2026 01:45:36 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95280f4sm1821737e87.35.2026.05.10.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:45:35 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlechner@baylibre.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	andy@kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2] iio: adc: ti-ads1298: Fix incorrect timeout comment
Date: Sun, 10 May 2026 11:45:30 +0300
Message-ID: <20260510084530.3986-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260509071910.12345-1-shofiqtest@gmail.com>
References: <20260509071910.12345-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the lowest supported data rate of 250Hz, one conversion period is
4ms, not 40ms. The 50ms timeout is deliberately conservative to allow
for kernel scheduling latency, which can be significant under load or
on slow machines.

Fix the comment to state the correct conversion time, use "lowest sample
rate" for clarity, and explain that the extra margin exists to absorb
scheduling latency so that no one is tempted to shrink the timeout to
match the conversion period.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 4 ++--
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index cf5f954206..6625d9f0d0 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -210,7 +210,9 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
 		return ret;
 	}

-	/* Cannot take longer than 40ms (250Hz) */
+	/* One conversion takes at most 4ms at the lowest sample rate (250Hz).
+	 * Use 50ms to allow for kernel scheduling latency.
+	 */
 	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
 	if (!ret)
 		return -ETIMEDOUT;
--
2.54.0.windows.1

