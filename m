Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47B307494;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289411; cv=none; b=M1vuzWNCyr4QAXZz77nuaGj0cYQGwUBUV3mhwsNLYAGf9jo2OYF1St79P3uqTvzGrddyqWNVE32goUanrVn+p90/6EbHsuccZ1RcFyY+A8qxIU14ssgbbUEvaBLAc9GhSDJ1vmHskk3aReyK0BuRdPPVW6UsqVM3eLBHSk80Mbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289411; c=relaxed/simple;
	bh=+kEuOTi6HFt1h6pe8+FJT8nRA6d52Eomg+JJe+vbkhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqACrjw4Ldls0aVo+ij4Awkra5AmOtDT9LM+HKKqA1OvdANu/wCHKHjZWPOXlE+qZbPKtHKqnAlw6OX6Jxm7rWG1wzW8zuMKS/1YPzMJbzUIKxzJN0CNj98fk71A7hs3JaD/GuL7FH9wHdzYni2p0rGtAdOaaXdd3KB/on0bdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIkBTQDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIkBTQDW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B07BC2BCB9;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289411;
	bh=+kEuOTi6HFt1h6pe8+FJT8nRA6d52Eomg+JJe+vbkhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TIkBTQDWyOPti9CNaPpvV482GmZZoqSaPWyoFXVN2CPF7T9jid6PJwPQsvKMiePv0
	 MK7oqR8rNzjRCZsHOAeQEDjHyURkkLvWVmWbA1PQUC7YxhVEhwp7NPou27gnUv98fV
	 EAPv6kG0stdT2BL10aaTKzwlX4EFzL2/mAKVeyBvWpWLD43RbxVbymMO6VtipCQwbz
	 Q5hq58P5hQfJwZeAdciHVggc6jk2XcxJxLH8/0YRpzdpy9ZUqHdgU7C2/0iVXrShso
	 RkS3berQdxPOOxtrkKL+E857J9AIX9UYt6ZN24zut0GbZu4Q3NSey16DWcJ/o6DcCB
	 4LxwypN7+UpOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09860FF8862;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 27 Apr 2026 12:30:09 +0100
Subject: [PATCH v2 02/11] iio: dac: ad5686: fix input raw value check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ad5686-fixes-v2-2-188e05199368@analog.com>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
In-Reply-To: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777289409; l=1003;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=e/fvywK2NRINysG0ft35kgBAMfBvOW51G7Ogdkjn8kM=;
 b=enBRO36oR0s2lj0Zmbklbhkh4k1yLnafIVWlpe+YoRjC6j6seW/C6zMNGXDIzdKapAPgU3BEV
 3lAXmU10de7BUErzRCg6ZvGAymaanuuzCA0ZsoaiIk/MqSlaEiAmGVt
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Fix range check for input raw value, which is off by one, i.e., for a
10-bit DAC the max valid value is 1023, but 1 << 10 equals 1024, which
passes the previous check, allowing an out-of-range write. The issue
exists since the ad5686 driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 3b48ddf8dd3c..24f928ea2b91 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -154,7 +154,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > (1 << chan->scan_type.realbits) || val < 0)
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		mutex_lock(&st->lock);

-- 
2.43.0


