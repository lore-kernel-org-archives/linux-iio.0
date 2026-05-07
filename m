Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E381DF75B
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171320; cv=none; b=W0JRNZ+zVym9BUtZoc52oTLLQbMSulQDlqY1Q5oLw6rhtoJiEqC0rZZl4Qiz0IhOM4jMVDOgWFoWTsWbcCqeFzX+2KNzsAPdIFmR36fJvljUUtDt5DykfRlvNMt9SYFHHVz2GlYc6Vo2mP8KmqzWth6o/RM1ctEWhc4GX84/PJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171320; c=relaxed/simple;
	bh=pwZ0Ke2yrpG5Ss5tVS/ttzElgT49ozq3iEhHeGIqCNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMgQFTkPg/w46t3E1BK3MpM35yXHptlbryfGl0x37PD7eWKU/LaWeDI9b7JvN0TbWJWkDNg9IYkrdO2weHfta5jTgNrL/Xwx3bDLE20OEPT7HcYTdv8JwHveBW0gX59PDzVTXjhALdVTlVSuFMlbfWKkPK/4G7dJO7v6ksuHc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVfUfguS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVfUfguS"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7b879691so70226f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778171317; x=1778776117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8AL3Z61ICxzdlcnq6alkQAX3KWNxGv7zH8ZNYrPVpo=;
        b=lVfUfguSH0qvFJkCMkyL+uzlNWv2gvv5Pn3cMnn+SD43MCzfY26+/TYOYk5TAMJCXJ
         4sH/7NJVIZ1RxEmEZA9+DVUG3pQaVWm4ukN3BaN+uIeHPfsvjliquQcdXIe5K8blKYtF
         hpJZAiklJFSWipxFUi89SEndZhgV2Oqkq1pZx3U24TwNgywzipIfrQIiJMADxC486UF4
         l/b/iU8HlIRneli+ZQFr18f869+k3RiC+b/HFNPwOSLvzU2M2+G6Jii+kdR2mZPyCfRf
         rBBb+JlPVvJTcOmeqhfRqZJus4RyIiOPdYchEH1GWEb0aGMzcLY38iIWqS337h4nrJ99
         WorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778171317; x=1778776117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8AL3Z61ICxzdlcnq6alkQAX3KWNxGv7zH8ZNYrPVpo=;
        b=sYkGf44uV+F5xnD+0MyxAo0Q2TP5TteFskAFpQPYR1vT7ujN+84km9itk7C+uECLcA
         zVwa7qjEgvLCeW9v6O6eLOwntYsz4rWZC0uLOR9T1kM3iXEjo5Iii1DHYcVG0Na5WUNb
         uS+hq7PaYF8VwRWy7CIDuErnmQFbgFTfnJMWxJbn3wKUNza5XwItg1tBd0QWhdyX12Cb
         iAmyW9CB5y9zfhkt+biQfaycl9TkNMcJBb09PAJbdLzScLF/6RC64l1V+w8lJEgRNkAB
         V5XnDibaxzXugBIkijw5c0p0/X5yxw91jVjeZ6XPVCfNqeTTBP3xq+QQ+PWnhZmJ6/+a
         1xGw==
X-Forwarded-Encrypted: i=1; AFNElJ8Xch0PK1OidsMXCKWpHTwqGdSj6WrwvsZMrhugsoHQsWzoWsnaXOiFR2V3+3gm8C1aZOBmhK3v3sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevPYJAQYRxB7fH//jAldpFZVxcRoR+EceQCe01bCNv2zk57hi
	FEzbsG0FWHLGK9YZ/g1jMlQOzURJASU/LV+z+dSqTAYvDXcNPcEC82aF
X-Gm-Gg: AeBDieuov8kb/ZwtMbRLEUxhMhEuo6+rj5SOYjC541BtkzHt4hL3q6ke8zR6p54nLtm
	fqVrXc48V/pKkP/OUnQBFPP12FuBiu4lmKaaa1TbA9dG+t2RlOiPOc/Qf0T8tkCPD79g1ZuL2/Z
	C0QgJUJxl3I/GIjRMXEY8lEDZtW0hzlGy8+sgLFvQXaKNPf1buZsmES2r3ZMzvYN8OGN82+QAlQ
	mf2OlCH3gxiBhQQSnzTzaUn/nonKRItZCdgKVleuBTmQsB431BZJTUbeJuLft1xgbOqQyR8+5iS
	+RlYkLTfhGx+c6lTg7wNHsgx/udZAmBDLlGwgRt+irKAXNKDft8VdjDGayLZfYy93e3pWztRjGn
	wpRUs2zHr3q4tF72k+XDiP4PyQDCSWfJwzvPuisBNpg8em8dXbSQ7xrsDx5y9pD+GXGwfUqCzQW
	3040lXn86WSY53rbG3WN++TRwTnJlSJmwpwby9SD2HOkVj766tlkXtkVs=
X-Received: by 2002:a05:600c:4588:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48e52f1574emr66634255e9.0.1778171316867;
        Thu, 07 May 2026 09:28:36 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53907e8asm131473185e9.13.2026.05.07.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:28:36 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH v2] iio: chemical: scd30: reject (response=NULL, size>0) in scd30_i2c_command()
Date: Thu,  7 May 2026 20:28:00 +0500
Message-Id: <20260507152800.9062-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260506181533.409-1-sozdayvek@gmail.com>
References: <20260506181533.409-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scd30_i2c_command() takes an opaque "response" buffer plus its size.
At the start of the function the code already checks if response is
NULL (via the rsp local), but the response-decoding loop after the
i2c transfer always dereferences rsp without re-checking. With the
current callers in scd30_core.c this is harmless, since write
commands pass response=NULL together with size=0 (so the loop body
is never entered).

The (response=NULL, size>0) combination has no useful meaning: there
is nowhere to put the bytes that come back from the chip. Treat it
as an invalid argument and bail out at the top of the function with
-EINVAL, instead of silently doing the i2c transfer and dereferencing
a NULL pointer in the decode loop.

smatch flagged the inconsistency:

  drivers/iio/chemical/scd30_i2c.c:104 scd30_i2c_command() error: we
    previously assumed rsp could be null (see line 77)

No functional change for the existing callers, which only ever use
(response=NULL, size=0) for writes and (response!=NULL, size>0) for
reads.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Move the check to the top of the function and return -EINVAL on
  the (response=NULL, size>0) combination, as suggested by Jonathan
  Cameron. Drop the v1 "if (!rsp) return 0" deeper in the function.

 drivers/iio/chemical/scd30_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index 436df9c61..845c59a6b 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -71,6 +71,9 @@ static int scd30_i2c_command(struct scd30_state *state, enum scd30_cmd cmd, u16
 	int i, ret;
 	char crc;

+	if (!response && size != 0)
+		return -EINVAL;
+
 	put_unaligned_be16(scd30_i2c_cmd_lookup_tbl[cmd], buf);
 	i = 2;

--
2.43.0
