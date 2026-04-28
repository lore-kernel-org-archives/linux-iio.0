Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9712D6E5C
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344223; cv=none; b=TOVwYzPzH/RMSfjUsaemleI3S0ZKnMbCx2s3ojUPuWOGTsDBmws8rOfoSJDt1kqmLUzKR7TURxiU9eM2s4ff020YR/Nw9L2KOzxlARLhwzDb0JalQqEkXvsdhYReXiPDbeEezjXR0ta2Owy0kO7K7FTAMKN81XcW4xq0mQn3d08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344223; c=relaxed/simple;
	bh=Y71N8eKxDCp0VV1VlfJaPqvRp3u9Hr+MGy29HAjkkKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnQIDlmb1QEnAyC2seeKrGvO3TSBn/CNQCAQ48jVU/qDZylWMNUylExBeJggeIYIt86GuXcMXaEDW1yvy3d8dfbSTwqZo/5QZlKP8Va0NgkshuJjW3aiPMEOjBBDlo+h/oT8RjS69TF3+Cmwr5qOT+WP0miXPHbPPBFARfL6Lbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWya9Zt/; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWya9Zt/"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479d593a0c3so6360592b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 19:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777344221; x=1777949021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMbkXhaO78cxqekiQSMtDGZ66UsoUXhcQbMuyCEpzTw=;
        b=LWya9Zt/tfFjOo9+rAKucJh5bDheDB6Zpkg4mneokklFUBezQoXKvXe+PMyz6CCjRC
         bR4zBqJYttqPhkxPACCNKKN5l9TtfqaNyR8Lvqkg7ejtXi1ahvmZiqFQosnT9wjS2Qni
         O8i4Buke4KLoVk+bXQ+cMGjt3qAeGZCoVNYQG/XgRKzaoLohJ+XxFc1SJilc/xWXVEz8
         3hZgc13rJZ+n9vVp6WjiJrH1LGnlxALCI1yjVfuf0ahEOhKl+Rw1+gaOEAEfLsnmPx9z
         trHfd14RW3g3fD++ypqfqptdeFHeJ7VLBLjKCohxh98W9JjWBDKDn9rpPHkLL4jy4QOs
         ddtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344221; x=1777949021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMbkXhaO78cxqekiQSMtDGZ66UsoUXhcQbMuyCEpzTw=;
        b=jVS+zTDiZNGfjxftb0KNPGkEUOdm9wM7OvPM9ovh/Jxvz0ZFtljnFzQBsCm8O6DzOL
         X2LLKzc1iY5n+Y/W0FA57/pgpSA8uldxe2hfH5OPfW0iVLteULzWS6tV0qpCboZ02Q1t
         iSilHDFovYhPz7Jragd4jlwTnrBUDa6lZH7VzKSsipTDNelXhEmme1QKKA6bAJiNNNsm
         8MehRgj2AK6zcliUJ51CJFTqo07OAW0q4xuttMHV5e1xzpDo8eAS+utdOcFB2Ut53bht
         Hz0h3oCQCBQgTKxqBMEGQDyxkhy3UQkzV+yiJZ6kbrXxH4J2QTZREZqAD3vdFmQ7k1PD
         3LEg==
X-Forwarded-Encrypted: i=1; AFNElJ8a7pRDYUribWQGViWCqKFAiDOqJH30D1IHPYHj7h7BOJpKU2n2meHzYtzNafuME0c3pMCoS2PlDIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+oU4xdQ/O+kmfGEYgXeo40iRGsE/1i1wjWm105zha0ZguvCx
	esYvIrLDMj5u/SLOqcN/pWHvg1vpv4sldABTi74FypceYef46Od5kL++
X-Gm-Gg: AeBDiesA0RNTbfBw5U2VGJYE0akle9NkrjC9by1Q7X6IMs1moYWekPJrK8pGSO1qgdR
	QarQe2K8ZJfBGdUceFAMkHwldNyMQJJzgo9CECYuC6d41dnXSPYMdRfOn9pUeMTVbGIdKA7KjoD
	lmg+VvliFWVS7kNWVUtsLF9oQRLbBp6IxkoccQQWRePXl/OnP2h6iR7iLNomSN4XqNOTAxKMcow
	5GYqTLBNGFk6Eb8FMECcNDU9xdntxZXIeUgHNkDa69ITJATsmdfu/rZ92iRNrmiTp21YIaSO3z5
	nYLb7vefq2d8Sh8qUdWMEC2KuY4hQ+5wRddN8+0U0ZP2+6EFFPqVd9twr5z8wpheoqB1xJSe24A
	ANcyllMUzDITRlvMUjraMLPT94YXdAUPR0ouNKQDW4rFIA0GMLryRHQCh6s0QlfUxHPV/PcGYqK
	48K+813OCa1cNLuv02D+jkBF5L1p9RRnMiV7XDrrDBAGq09awUNxyMRgEJrDAa66x8oIIX
X-Received: by 2002:a05:6808:1509:b0:47b:be30:5b35 with SMTP id 5614622812f47-47c28b93cd2mr609012b6e.6.1777344220721;
        Mon, 27 Apr 2026 19:43:40 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433efb816e4sm958392fac.1.2026.04.27.19.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:43:40 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iio: magnetometer: rm3100: Modernize locking and control flow
Date: Mon, 27 Apr 2026 21:43:35 -0500
Message-ID: <20260428024339.45109-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patch series is to replace the manual mutex_lock() and
mutex_unlock() calls in rm3100-core.c with their more modern
counterparts, guard(mutex)() and scoped_guard(). I've also done some
minor cleanups, removing what are now redundant gotos, and enabling
direct returns.

Following feedback on recent commits, I've learned that it's a better
idea to split changes to be more atomic, and I've done that here in
case any particular change *somehow* causes a build regression. The
changes have been test-compiled however, and according to make, smatch,
and sparse, should be sound.

Maxwell Doose (4):
  iio: magnetometer: rm3100: Use scoped_guard() in rm3100_read_mag()
  iio: magnetometer: rm3100: Use scoped_guard() in
    rm3100_get_samp_freq()
  iio: magnetometer: rm3100: Use guard(mutex)() in
    rm3100_set_samp_freq()
  iio: magnetometer: rm3100: Use scoped_guard in
    rm3100_trigger_handler()

 drivers/iio/magnetometer/rm3100-core.c | 129 +++++++++++--------------
 1 file changed, 56 insertions(+), 73 deletions(-)

-- 
2.53.0

