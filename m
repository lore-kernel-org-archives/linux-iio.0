Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACA2E4257
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195044; cv=none; b=uCKKu+E1pC7pLU4HHyQbD4Z0Vz84SMuwO+v4Zz8J7Nza/776iMGHTBPz63YOUDwqB2JFvnso2HnFISZSiI+8breSwpCgBCYU0C2QJhGv1NG+/kJGmvRgEy0BJ94duTwGQt9+V9ljCk7MqfI58LqTj95mAJtPVqp5yv6dl26ro24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195044; c=relaxed/simple;
	bh=wHcoKlL78nBhRyDMLTbt2iDqkMc27QuBm8do+Cx6NEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tiy44bmnlnPt9VK277ZHvm5pyBui0jEj21zF+FjjqLjdEYi+SphKqZe8ivPmFYZnN3JBRQ/K0yUk4iUOsqpRYuGcD0m/J3Bpe6YQNTMSyVjnrO2WNnoQVkgbpYpqYSWUaTtCI3IMvVmg+JqGgioDRAB5AxaSkibGl34UzDek/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFn1qxvS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFn1qxvS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so3448991b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195042; x=1777799842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvODaVSbHp02WCBNt4rFmF38W1sWqtrn/KhBswPq1eI=;
        b=dFn1qxvSOjNJyUMM6SG3FsgeE5ze+JwAAeQrBmdVWl/iD19/NNc8+AIacH2pT8XlfG
         jZra0Gx+SdXv1hZ2ZePUBTkMbYO0tuqoAWwky340Nq5xXo32VsnoarysD4/BcKCjWl0m
         DBHpTqecNDpDd5/qL7BGMl+2L0g3JosK5nrOf2jyYaVa7s//2IRIcrxmgfD0+JOuJ9nO
         GAX5lr5nDxoScP/7/9FexJwqXAR8Mcp3iJORAkjPdjXO6Oirdq5qipOc9LAbflyI6F8J
         Y6LOR7u3iqWdzRSI/gQ4t2rQuVh3L+R31oF+Ppfd/EA2yATrE8OxVUyhqoPKSXDG0xCm
         2vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195042; x=1777799842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvODaVSbHp02WCBNt4rFmF38W1sWqtrn/KhBswPq1eI=;
        b=j84Lsdu4pT9fYuh9TgO/clA/84Q1qBb5Z78fxtAQ7HEmE/sASaa/MooMhIxmy/OrX2
         LXz1JgtcSfZjwuCdgKMLWrnjmU9IB5vMylhcFEAZYL6XSF8B6mzltCOqg3F+v+ZHd4+D
         FZlvUPG/vGucf8eiAwI90HuwzN7Jmue1uo14hzIGuFD8up4aZz3ORquXrTbFfhYP7NGH
         I6Dxjdn61kmX6kjWtyCsam7/nfH/UJ8oQuuxRDXf5sisZdrJDXD8kNMSdVniTq5kwdB4
         Jz9zuOtqU6eS+W5KkFK8PGkLFSwlZKPZsOVW3UfdmM0hKJt3rOBOOCXebgCAV4vNxuoe
         KuwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mc12fe2U2Je1Azn+dX4YQhpQi5JecB2I1k/2xDuTqB7TNXWAVlVjAUKViv+YZcWgxhCUkdnR1bLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4H6sIFzQGC1P1vru12kOFpHztFLskm922CmgZYkj8kVTdwIU
	3cDNp1o5bAOUGMNQK5Kp6Ps4R7ZJodIBgn4p7tZdRDOw6QVGggZjvcud
X-Gm-Gg: AeBDieu77liogbO7ky2cJPfMknVee3Xkul+jhSBQ05Cw/0mdOy6+JIczu5n7TVAY127
	SsJUy6ut3jErvygi7lMbZ7d3E6ubXpMlGrsGLIDLm/3wEi+L/tiQ/JZOzLekGBRLHdVrTdTJn6A
	Jy//3zSvrJJ3E/8Mjet7HblWi/hZlmJKlzdPJ6WIYyTtiAKTKt0X/qJUNLV7tWx3io+ho5P9OeA
	E3bqRavG+3GPFwzNAsrpvAq/IA1g0jP7qnbA/jsEdMRvwmWK7vMFw6Ahh7S4I5epx0AokVrzMqt
	jfTbWuG5zeCOP3o9HGd4ze6tmCQuCIPi3NpfAaTBqDQakQ74fpPZ3qHDGWCoO7xgHCClBZwjnJY
	fqxEfQ75/myQbkIdrgOCg6jTMUc3MiPD/bEsH2bMFSPY02FB4GgGigqR7HVqre8GTIsGOGNi5os
	nMnPQObeFhZj7K+BWP2RkEG1dO2UGTlJH6W8WzG1X/xNm7u88/9LA+Y33L4dM=
X-Received: by 2002:a05:6a00:1acd:b0:82f:cfd2:6ca0 with SMTP id d2e1a72fcca58-82fcfd27015mr22832601b3a.40.1777195042277;
        Sun, 26 Apr 2026 02:17:22 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:21 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	kyungmin.park@samsung.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/9] iio: ssp_sensors: cleanup codestyle warning
Date: Sun, 26 Apr 2026 14:47:02 +0530
Message-Id: <20260426091710.3722035-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426091710.3722035-1-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/common/ssp_sensors/ssp_dev.c

WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index da09c9f3ceb6..7d07fae295fd 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -28,7 +28,7 @@ struct ssp_instruction {
 	__le32 a;
 	__le32 b;
 	u8 c;
-} __attribute__((__packed__));
+} __packed__;
 
 static const u8 ssp_magnitude_table[] = {110, 85, 171, 71, 203, 195, 0, 67,
 	208, 56, 175, 244, 206, 213, 0, 92, 250, 0, 55, 48, 189, 252, 171,
-- 
2.34.1

