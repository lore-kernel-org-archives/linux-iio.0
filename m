Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19226CE05
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777238424; cv=none; b=DYBsQptnZxRDhjQncIdEbPODwfySd0U5daYwUkaPxPHN+7IhOCVwt0J9EfCj88k6N2US5wC+JSgmORFXMlmHZyzoMCxDNxt4HMnUB5tuCbdEcbxccGkt/x8t7H83VZkgAwjvg0j3aYvSw6I4d6XkEXrzRxWei1E444rnbLgpomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777238424; c=relaxed/simple;
	bh=bgewlr+ESXs5oxt5BClsfyz5Ry4E1qFQ1Lz9SiPfKTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlkQx2OeR+7nG+i92m9Ykfddyi6zB415yOEa/PM4QMozWZxSlQ1d3mNIqP4Y7BIqx0Lg8THMOKuigoqduM9ltD2JEqMvZLJ/MYG7UHGpINCCnkUM0LeWNxS4b/f3ZcwgwK3GIfWnyzzrWJ7ie/b7klPbdSyFB+d+q/bLfqIfB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=cKmUDESa; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="cKmUDESa"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2d96243c91fso15466994eec.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777238422; x=1777843222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4aQAS1VysiNLcvWOiSKb/FtmRaSKYwCs5hFH6xhhq4=;
        b=cKmUDESalTNgm9eD86D0rl9eDl6ZfKa6oniOVu/pm1CBhF7QxKi/tu+6A9QlaZ1Q0A
         RP8mRE+KoR6sfu1P8luB3AbcgpWvNYAKZGAZKqDbescNHx5IWo/W5QGWh3WSmNrG0Ji3
         FVSq0RDYFenp/V4urjNsFsFASNCS3o4uw09k5LmZ76SEXUWPJqFRExBOzL8Z9m9f2AIc
         LBujt/4R3XCFnqJPXsbzhbD+jQNJksUeJrTyFZB8JIrFmzGHo0MhhQEauJ3P6L8a1H/E
         RooXCHkImMyLWSxiVnR6g5F1zQQCk5Phj8sAeZUJqGtrDWa3j5/8AjqvZ9SE5DadSeW/
         yHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777238422; x=1777843222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4aQAS1VysiNLcvWOiSKb/FtmRaSKYwCs5hFH6xhhq4=;
        b=I53qKBMFXrmhasqkZn0UdvGiiL3/mkRxC+1TicIa/boL5y5+JeUwpO3Wk+/9izewXE
         7DXPXzc3ig46l46+DdJSCLQW91vZeAg13Fa9lEzgx0+Vi6uCpI96xwOkOpjs/h9e06XT
         hSSHGov8nPt6VWgXJ2ODrG1Pf0lo6Mholt3KzcNFvCxkxfOLs71UVQIl920rBW84wGtK
         STNUDS5+TGIVyjxkwWrThV2+oQusOtlMhZmGe1iO94N7QY7ERe7ls+RMzZG3a9MRBOCK
         7RuxTp9wy3M60YW4dceyyffY9WOB6jagcn7gEgmhVvpWwO+sHmaG4cA6vLPb2tWAjxWR
         A//g==
X-Forwarded-Encrypted: i=1; AFNElJ/tdJjnpOr9V3ECpii8IItMS6HF6FBBhsTZH9hY06Mfr3jpAmezGK9r+fkrs8TLLawHSMz7piX7JlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymZwL8BzFrLZUisbXoCxcQ32jyTFBfVdWwZZnpIhtMVaot+X66
	QOUhVOlchTqSpzoXT4KR5P469BBTJuFIDPR1kLrNnpmDgh+8c81qnlpwWzAxYYLgMtQ=
X-Gm-Gg: AeBDieu9KOvUfSMewsWfEUT/+yMJsmgORb7kwwIxzz5dkEeTtREi1j6vKC1Vd0a6kmh
	P9GM5k39gskq0hTF4nGon1fcKAXclFLL7oknJf0MhGIZzvIpaYwjYS2qFfKZqUO7JiskBUXnVjF
	pqSIkhy70q1l4lxBld5aPHPJZqsJWDX8Zi4T7Tqqwh+0FYP4T2B2mWnS8iTGQBSV+BFAqn47n1j
	60XfHP9WU2s/Kzceq4GYpsiBIh4kKxzhhhsKtDmqGYtNbnaRCkV5+6MkRy3iB65CSCW/RAU5JtV
	c/cVEbHVtTLOZBOEjeVrYwmlYVCOj9TTS584MDlccA+/4QyigfEewzeeXdf7uZc2dcfppEYGzwC
	AydWvSAtmxriHH/YKEt1q7tYvSTT2TnWbxARho1LBpwOM5enUbe95vAgxK2DZ4l/d7M5wKc43MU
	bIAXofx4f9Z+twe+rHzyxJ7oaFcuh0q3c=
X-Received: by 2002:a05:693c:2b15:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-2e47a105b1cmr23742636eec.22.1777238421930;
        Sun, 26 Apr 2026 14:20:21 -0700 (PDT)
Received: from eileen ([38.10.153.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm40799122eec.17.2026.04.26.14.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:20:21 -0700 (PDT)
From: Caio Morais <caiomorais@usp.br>
X-Google-Original-From: Caio Morais
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	michal.simek@amd.com,
	nuno.sa@analog.com
Cc: Caio Morais <caiomorais@usp.br>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: xilinx-xadc: remove unnecessary includes and add missing ones
Date: Sun, 26 Apr 2026 18:18:00 -0300
Message-ID: <20260426211834.3318306-2-caiomorais@usp.br>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260426211834.3318306-1-caiomorais@usp.br>
References: <20260426211834.3318306-1-caiomorais@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caio Morais <caiomorais@usp.br>

Signed-off-by: Caio Morais <caiomorais@usp.br>
---
 drivers/iio/adc/xilinx-xadc-events.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index c188d3dca..31cda8e69 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -6,9 +6,13 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitmap.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/kernel.h>
 
 #include "xilinx-xadc.h"
 
-- 
2.54.0

