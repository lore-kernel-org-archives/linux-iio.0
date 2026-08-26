Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE32E764D
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779916; cv=none; b=UuoIJounrcxPwGw1yKTrjF8DW9g88G69Trxdn/0lj6kRppM+t0zn77EXRKX6haFKhjE2muKXyn6+uBgc1Z7sf8auM3roUBUZQjvJNk98AiVEgMb79zqRkuGuSpE54VotIXisGxpYQ6L+ZiMbv92/4mLDqbAcgppCQYJdr4XSZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779916; c=relaxed/simple;
	bh=SNPzm5JdOhbwwM8EqeYbuS4iFwsKT5z6aGCH26wH+Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIK8RWtxM17tUAuGyd4Wj/3rWiOAU0N93bO/n+mJH1KRokbMZQ6ePszcimsdlOkilKwGOxFV3bel2oV8yFThck38paLxVOpDlv4EM0WjGTWkaDIhezOyC3YXsHhqFR1IjHv1AUjBcwrmQcR713QTaqfgNIKcr2gd/2Xsc5/ZsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL6DNxxP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL6DNxxP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso985561a12.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787779915; x=1788384715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vo+9nPRwdIVHjPr+RVsyNENB5+Bs0JcZeloNo7tg6D8=;
        b=CL6DNxxP5yZJ7d+DLAizHLHLRz4RlCJMIwGxlKZwG4Sa2IJ949jD8rychNJiQ3XlIf
         jtUkB+Y54jEQN8N9A/gU9X2H34SfaZ7GWA7M1oWhV9CfxpkbRTFJVhX0V8vD0ormaokN
         U5zeorSnpeRmRbytKYo73/b1s0u8k4bVaxERC4FGmQMopNxf/oBiso37MvipqdKxzxdz
         cGEeLJVQ4xgHCtcapoleYJd2kILT8Jl2+W/ixGFAUz+2yoTGFyM+m/CYHDF2jjlpXOgd
         /FfHPe3sIZaaALMxrYtkIAEazy1eN8HHl+/TVITAVFbKnZbxyuBs5YaN/JZXaHhQ0Ygt
         erAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779915; x=1788384715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vo+9nPRwdIVHjPr+RVsyNENB5+Bs0JcZeloNo7tg6D8=;
        b=QUSw+jYos7JN2t3qNnj7dZAB/Pkx5GHfB/yAWcCmsNBC8rZRrlqchh66IlU6THWWK4
         4rFueG0Y5IL04UD9ll8qwhDt1zZcqi0MJVmFWD3kZAHyuOLld6xyiw4W/8qGlRS+1pXH
         nXc8UuXXuh5QHFsddXCAZMA47Sqm7/v27b5MCx9hMeGn25swxhf/q/XPx6T4FBWmRuCI
         tFknJt5vpNe+SF0LSFiHI3NZ/3G4Zdcjl8NX2y876TYdDXVOT3LthKouhjpG55YfIDwM
         ynplrvYybtRzjW9cNgBwm9TjC8spvf5nOzOXBoUs8eSts6S1Mv+osL8QoI6LGrmwiBBG
         1shw==
X-Forwarded-Encrypted: i=1; AHgh+RpKVAPYHfTxwWOCEpMki0dOpyzfnXU39TeCtyXWlsE6VFLZAc78C3UvoEZMnhi/EDDyEVnQsjCpEt0=@vger.kernel.org
X-Gm-Message-State: AFuF++nUWr/DA5uIvWgEIvGOFRZZB91jHFRJ9ElMrbX1bEaAjJT08sgk
	mOzFXauXYXH48FPc4eTqvbIw3ET+njgaokgvesMs0VfR8EyDHdNXC2WfU7G3jzFX
X-Gm-Gg: AR+sD13qUlk3FSWj+cvkTZZ1AEeH9OhqsChn9HSVVOcaBnLOtJPW3fdu89PCTyIuYsV
	2mSf2PGSUg675rsv0MBYQfFsimjQ0AnFfQuOFY2+UPuk4lxcMXpN7uTZjEDhDwcxnrQEEBJIVx+
	kC+XjZdhwsrYWCe2wDzJ8oD79DhShvvZQ19oW7cTZQ0bWqE5AXRk9MeTvS6dGd+UkWfg8PcC2qj
	7842foxx/78C1sQveKyywB8Q18CnV6tVLYNO53CGnzB8++7bXcCTxej0eqVMlh6NchU+oO/bFLl
	l1yq7qJ4eo4fdM+XspISyahYXE2i3jssOnE6+lYFayAAyzota10tvVuLBk89ZLwR1OCOuKu62sg
	hTKTthZpHlFhWU9Vk8kVN7kSJBkWw0rDqr3pLm37PBcz9/CGtsqZI2CDmTPY26Yibayf4h474/A
	Cci/iVpPoOfN1w3UpDhR3jZiO+lcS1JTphtbSSRFXrHcTfMtWq5UMKDxlgnGnKnGlB/i9oh2l4s
	8i2iO1FkK+a/ekNrntnr9KdWkJs3GptDxMJx+TdNqc+rA==
X-Received: by 2002:a17:90b:1e46:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-3966d8d6220mr17244323a91.16.1787779914570;
        Wed, 26 Aug 2026 14:31:54 -0700 (PDT)
Received: from ubuntu-vm.. (c-73-189-122-63.hsd1.ca.comcast.net. [73.189.122.63])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905b959sm10291147c88.13.2026.08.26.14.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 14:31:54 -0700 (PDT)
From: Rishab Madhugiri <rishab.madhugiri@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rishab Madhugiri <rishab.madhugiri@gmail.com>
Subject: [PATCH v2] iio: core: Replace BUG() with WARN_ON_ONCE() and error return
Date: Wed, 26 Aug 2026 21:31:40 +0000
Message-ID: <20260826213140.37437-1-rishab.madhugiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As documented in Documentation/process/deprecated.rst, the
use of BUG() and BUG_ON() should be avoided as they could
cause a complete system crash, preventing further debugging.

In iio_get_time_ns() and current_timestamp_clock_show(), the
clock type is already validated against supported clock
types prior to these calls, making the default switch
branches expected to be unreachable. Replace these with
WARN_ON_ONCE(1) followed by an error return to avoid a
crash and to log the highly unexpected condition.

Signed-off-by: Rishab Madhugiri <rishab.madhugiri@gmail.com>
---
v2:
 - Use WARN_ON_ONCE(1) instead of WARN_ONCE() with string message as suggested
   by Jonathan Cameron.
 - Reference Documentation/process/deprecated.rst and clarify unreachability
   of default branches and reasoning for using WARN family over BUG family 
   in commit message as per Andy Shevchenko's feedback.

 drivers/iio/industrialio-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 767a7794624a..819a864d1136 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -341,7 +341,8 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 	case CLOCK_TAI:
 		return ktime_get_clocktai_ns();
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
+		return 0;
 	}
 }
 EXPORT_SYMBOL(iio_get_time_ns);
@@ -1518,7 +1519,8 @@ static ssize_t current_timestamp_clock_show(struct device *dev,
 	case CLOCK_TAI:
 		break;
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	return sysfs_emit(buf, "%s\n", clock_names[clk]);
-- 
2.43.0

