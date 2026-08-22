Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B0394785
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385834; cv=none; b=sdCbApiraY3ar/wQSu9n5czqM9yCgnMefxA+ifZjCFTo6yEJwGI8orViFDhRIMdH/li8NbbSd80GnEv1OQlYhu8FAUpjDYgPZJGRaVEIxspmexnGBE53++KzYFaIqYPJaFSG2wl8Ua6dTcVH032XGcx/JFj/v47p2fIHWs2L9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385834; c=relaxed/simple;
	bh=6l41p3FE/6+JjX+H6jgLrRqNj8Wrqh18ubwDrAujopg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjspgjDm7fFzx1NgABEcK00Vwt78h1/trvz5q8BxfucI0ihkCmBLQGMT9O7ehHVQ1DUH0DgF3aSORF7rQtOvM+aO0Mm1EFDfJt2zO5z14A9K8CFMtV/RWLUTF0sieMGoeyE/uwBj6RXGZhQAD/2gv6wPnOFp0S+hXatsWksbYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBCbfT4f; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBCbfT4f"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so3648036a12.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385829; x=1787990629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cM8/YG85/sF7rDkGDtNu2mFOGLLuQFiAl0boqB6W3U=;
        b=cBCbfT4fTkAUqASqX0rJZFeE/x7kYsSWoB6x52vhmUJYmXGlkjBwIAG0oOzTz5a4no
         suPt65d0Srlvnse8d3GgjPm8clMwqk7DrZ2U+9Hmoho0H3RH99uQxjLWqPK+SWjUJy9P
         hW6pvAnFN/EZlkJJCPTubLgplEgy5M50DT4oM1Af+mfHkW8nvY7wKd1AdwZVozi8tTf7
         AVxskvDMZyF7pJiEz/gK3Jc+P4S/GTedp1MIWsxYzg9feRUHI+P8J/DAqzjPTG4kTFki
         WyGzDlCdjPIP8+JenbHsqZtz1lIPXnjMfSzghWZUPnbEB9U4vfI/Eu6ILD3E9hx/cjqm
         FtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385829; x=1787990629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cM8/YG85/sF7rDkGDtNu2mFOGLLuQFiAl0boqB6W3U=;
        b=RnfRuvLoL0LGf8qUB+yIiJCYeqQN18uMDC/XwBEaJiM9R5FCO+8oOJ2bWbagkRS2w3
         m5Q7j8hlVjjc8lgLr1E4LM2f5NqwmSCpzoPz0TALNIlrTp13RfvDCt4iTvHc3b2XdEu/
         kcL974D0hHrLoLugiPAzAe1JTR/bNr6lM2akdwVGAMSVeAGV3YyOfa8MJHTNGlGGUSi+
         /T7VkZPMlsQJ9I5kAq6V5Mtn18r9G65OB792ib3LXJ2GzUdh118O66CUJB0lNfpB/tmC
         vOocDtlbC9vqBDBbpg0766LWk2TgNApLRyo4q/VvUPkkNfJCNbYgolffXdL4JXaiqaEb
         ChxA==
X-Gm-Message-State: AFuF++kxxfLXjWa2pMTGL4kyIE8qPqGZibJEN7ApMQ2hgZhYz8uWrBlJ
	g+2CzB3lLBy2BYCQUfQNPM2NcXnOQgaNp022PlL6FNrYDatfoEfnzD2I
X-Gm-Gg: AR+sD11bqFz4Mbwh8NdnVM3761/eXgieFBkvWXYwLY0BaD7Too/VyS7uYK+FGtl6Luk
	NKzJzqCoIaIegBFth2B81kBziLAi/AdC7JZwZbL/Z1bLMs2/8CyL6+0/81taotmJXZI51jqdry4
	eizr3+SJMWSH+FwY95uT1WeNqcscviqwZqCyeIsf+n2vz4hgVH+E8rxedQpZdE4AUjYF+RGYyCu
	8EYmkd/tu2c79Rk2IL0zpuEPRlrsgKitMQ5kaethrgs39ye44ouRuMdBtV/QmM0jD4p27u6Nq8M
	BjoTb4TJN+8sqqwfIGjzVdqC+6nMZk78tfsHArIeB3lbutIb9Y8zavkteRNSvqGTGipbRRXLcBR
	pfBHOQnicPDRKrBNff4m338d6DPFO7Rm0pUuDn21Uin78PzTQN0XiIWPVYOoCRzjxEbDvpp9VPV
	yOflTHsivLuZOg2tmjJwSxP3OcXwsP7hA2yqjN2/Es3byuWAnwrLrsZUshXFHySsBPaPHOGfxIs
	5YsJcktPUx/kfErJmZAoweU0NYgrQ5zxh0rBAuKgQRgpDm3XEM1iYtnyCdJwEjFkJ39yiTG61HX
	ZtUaORQ7TKVAH6SHNhkwVJDG3h4mutvYKzceqxiaE8kc0cyQcUhLDqMCsZr/am6twlyc9HeHNK/
	RLcQ1rWmwRxK0S9LT4ibwdJ5L
X-Received: by 2002:a05:6402:a0cd:b0:698:ac8a:9a21 with SMTP id 4fb4d7f45d1cf-6a42f185778mr12192018a12.8.1787385829487;
        Sat, 22 Aug 2026 01:03:49 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:49 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:32 +0200
Subject: [PATCH 05/14] iio: temperature: mlx90632: sort headers
 alphabetically
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-5-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
In-Reply-To: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=750;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=6l41p3FE/6+JjX+H6jgLrRqNj8Wrqh18ubwDrAujopg=;
 b=q/3u76axEl4aQPB4WHIgHMVk/CeYvB05NECysQPeWKKM7Yea/eUsWcbfCeXpRFzVYb+EIog+W
 sF42TIY0HRKAH8h6Fq5lQv6gS+gJv5ur4MzXEdva3Pv4jK4IhtGvF4V
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort headers alphabetically to improve readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/mlx90632.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 2fde48f337e2..73c935364d33 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -16,8 +16,8 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
-#include <linux/module.h>
 #include <linux/math64.h>
+#include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>

-- 
2.55.0

