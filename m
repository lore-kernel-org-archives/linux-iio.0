Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C24B3364
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403985; cv=none; b=h4xLulY+yZ5+svgOOt79Iq4XT38UzOcP21fOvkrWAoa6Qo6ErbGmCo/Vqoz1pcvtlRy+FyATCz78Wv+PhnTeYPfExvX3cdAXR2XQadEsArmXSmyiahXlBKC1qVo3dAuGdFM1nvCsmSVtMUhXazYfuZZyQ0cu68EZOfQdkFlu7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403985; c=relaxed/simple;
	bh=6bNcxzUVlmQvjet7ksUI2Ld7TTjqmjQ//XfC+z0s0z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0eGP2glFD7UBw8nvVJzyDV/k8p4Rii2nvI7fEodQCnOUa2GvsBRTC05q0j0FAFzdShQNyzaER+xp9+5yPJuThOKjGrzF10jDAXhJbo7avaraV5A1f57HMDafXg1ATRnv7eSPU6VAfynDSH8klxNWWoq9s4HnoaKsAty1NZpZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcGG5T6D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcGG5T6D"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e608cd460eso10019775ad.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792403984; x=1793008784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EGOLZT0g0vS6HQl4RNLoJTQMf+l+IbI+5Jp/8hOXDLs=;
        b=JcGG5T6DMSW0yCslPPmZMiWSE30yIYwQnkBWvriZ/vZPzRWHTpW95a7uGT3nGZdrTT
         TXbPmk+beKg6ulF4VDwjin0mmmR5QI86OBrTV0zXbSgzfUvzhP7OgMAUp/uLYnhjynIc
         AsJBubu26kIubSjUGzN12qRRwxmWv0Pvof/MzmeHZbJRP7ZmxMZzri9zoqBcDIQ48oTu
         nZVLgv7GZ3TjeMfU0R7od424vQ01oKbrEfpMre7u2nBCG5K/oygsVzUFJmztviLps00X
         gOxI5vuo5jn7sGYdZh8WypjT07Np7rvfP8NsDlQWhFkbof768CNPR9JQSgD8b07VYInN
         M/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403984; x=1793008784;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGOLZT0g0vS6HQl4RNLoJTQMf+l+IbI+5Jp/8hOXDLs=;
        b=qupwKha0JZkDWIvnFPQJceNzHcwTSlzlBoMvjRnUOHvIeo3uXUx5Su+ZCg6G3Q850N
         3xMh7JWAeaY/OmXMUwnsAsZiTbY9KO/9e7nSh/KjZVYA6bdn3eEvHwTunA9Y9Br/pzcT
         jxKbHwdGOArXzz3BjLG5qHdB7FAMoowlbLuzUvus7EMbgnYE/rHFSLL5TjvfE23n4AFa
         q/2zQrp2Vjko9mu0QK0DaVxbuQ5/M5CpbE0U+57W5XGyZc2wdJm6DF8PMzkSa1ccVs2+
         TeUXHHiQPBitVPI1CpCnMQ4sDaor+ABIAMNT03kzA6tcyiviCg/GufJPHM5CnIgq0YtG
         v6oA==
X-Gm-Message-State: AFq9FYIPBAECIYIN3P2ekSiNCwn/Jw+ARuruc6/O9aMtHl4nXFezDnla
	R66s9cZz47qdrslEzt0n6TaeSrZgJK8iW83KkWu10Dnr7Ia5+O9xOp7Y
X-Gm-Gg: AYBFou29Jd3rfHiZaIfOMCupieLhERdmB1i/bormG7tpHgv3rMkKOmUjrVxT0W54avs
	aCOKzZp80QUJO5EzU+SzOmGM+e0Ui/p2nLQ46Qb1x5RGlNysw4JPxDSQ1lJmGvXBnBLoJ946KkP
	cbe0L6egp32KYTfGcBe7l+xIYwPirsvkWUwK8yCC0hvUWCDGpPzs2/KtPwDtbsbAVTkI/D6Gj8P
	fMEIEKIJ6jktFOhsU8uWEOdJavZG2u/Ti4tEBq7ajM/0Y/yfBUHhEXV0HJ84BR2wfD4LO98lYoV
	aubCtzkgP+0zEsKABYS7ZG6ksQ3sI2qk9FqRKhyhp+uFP3z8xBdSuHmojE2NAZdzhOyLv1C6kEF
	Z9NrsjBh179NmqqvHDPv/3y3pU4ElJCYb0ue4g1qzocOMJJy+pvVbLl9lqLjAOrK6pdMYm59JBY
	3Ys6arfv2qp7+DFCinnR3pih9WbAOQ/j2xXPBURJNVzdYQvsP/w5nFDdCaE9bAToUOgX10vbUYv
	r/YYd4/dYSwACBf3hvk7cteNazgeYP0TPNZYIVjN7A/biPnNWqOdpDiLfUHNJ39eSadTIkEBrRJ
	Xkjxo5c=
X-Received: by 2002:a17:902:f603:b0:2e5:70cd:b606 with SMTP id d9443c01a7336-2e9a705c7c9mr54901255ad.56.1792403983748;
        Mon, 19 Oct 2026 02:59:43 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e834029sm36631725ad.31.2026.10.19.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:59:43 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	llvm@lists.linux.dev
Subject: [PATCH] iio: osf: avoid a large stack frame in osf_core_init
Date: Mon, 19 Oct 2026 18:58:49 +0900
Message-ID: <fc593496353a60a15fd5ef1a2786d41dd9bdff3a.1792403576.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202610191514.fRYyu0HX-lkp@intel.com>
References: <202610191514.fRYyu0HX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Clang reports a 1344-byte stack frame in osf_core_init() for
hexagon-allmodconfig, exceeding CONFIG_FRAME_WARN=1280.

The aggregate assignment materializes a temporary struct osf_device on
the stack and copies it to the destination. With the mutex and caches
added by the IIO support, this structure is 1328 bytes in the reported
configuration.

Clear the destination directly, then set dev and initialize latest_lock
as before. This preserves zero initialization of all other fields,
including when the core is reinitialized for a new session, without the
large temporary object.

With the reported Clang 24.0.0git compiler and Hexagon configuration, the
frame decreases from 1344 to 8 bytes and the warning disappears.

Fixes: 7329986669f2 ("iio: osf: add IIO devices from capability reports")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610191514.fRYyu0HX-lkp@intel.com/
Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/sensorhubs/osf/osf_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/sensorhubs/osf/osf_core.c b/drivers/iio/sensorhubs/osf/osf_core.c
index 4f73ff5e9572..62b086f67e6f 100644
--- a/drivers/iio/sensorhubs/osf/osf_core.c
+++ b/drivers/iio/sensorhubs/osf/osf_core.c
@@ -16,9 +16,8 @@
 
 void osf_core_init(struct osf_device *osf, struct device *dev)
 {
-	*osf = (struct osf_device) {
-		.dev = dev,
-	};
+	memset(osf, 0, sizeof(*osf));
+	osf->dev = dev;
 	mutex_init(&osf->latest_lock);
 }
 

base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.43.0

