Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C716403156
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764642; cv=none; b=Kbsy9ii7mxxoRbrMt72MBWnDNj4NDuyDi0ipwj1DoOOouC/DfvisjRi/KQRzGj9jTOpaKZSeydF6B5CNz03ctpJRJt0J2TdBjfpMb99AQ7DYejJHp6OU5M8DyPoDzVmr1hFvIJ6YHNhuI+S0rPFIzhYqjWIzTUmo0HibMyH5jNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764642; c=relaxed/simple;
	bh=a4fUsm0sri2CJp9Xa6+EfCy3v837PLIvJct/CxDUWxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH7eECKfKGFsp9GU2NPtF/iq4eFA3u9HTtUK06X19SBfEiGCgGpd/HTZECdZIonhZEr0AKpcUxF+te+dUJnNNRBCb1dEHVlL5EXYpzKeyZgHYmMbJTkdYdNnu57+TqxlRzqsDqWSFxjQ9TS0nC9VWzlOlVFjS+QFNT8BEhlp3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4iXkmBJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4iXkmBJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so2608878f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764639; x=1786369439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ovn4XB3GgCDHVcufiauy/1mVBNPpRS6FI6cibDiq4A=;
        b=G4iXkmBJ/ugmNIVrZJsuk7Cv04P75n2u36vrGAfeyBM/86kqAHOe5eohdjOrjpBkLo
         rSSIBZ/0DfgR1ItnU6yUuD/YJUigBzVgbqXNyhTOJH0NndtjkQpbnAQv3/MNjLiDiybZ
         YYy+fwSohYmZEZxXJ+MjDGC/LSli5lrmH0tliTFMXj0NyBJe0NYutl0s1ViniV2jh2al
         XJbOpiiOE+V0a+OXRaa/nfhbmzvie1loeH9g4brzwHundjBwBI8NdYGlyLZ4cxpq+eEp
         MPFouC/ZZk6gu3kxOxipcq1RPKbr7xatlTqXHEht+bJydBvG6eFpi3k7q8Pi+VppG0/+
         FeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764639; x=1786369439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Ovn4XB3GgCDHVcufiauy/1mVBNPpRS6FI6cibDiq4A=;
        b=YL0XWpertAqatFbbn2RbXVkH3WhS3+tjUSCrPBzJBn6WIge02b0ESuBRcF3T2M3TLe
         dyIN7r3ZeaQCfmiIXSgbagPWZzH2ZU/MLPiuwbINNKGoTfKBefHYB2nE730sC+HKFnTy
         Vg0P0hTMYM6FrZySyHG0lSPk87ZIcYjMnnxTsmIu6XbdeBTs7S5l8/jPfxDGtf6aqXE8
         2A6VCr+1l8OypnG40RHD21gLUvox4hMBsRGKlY/eleqHamnLbicZuWCW6b8+idPRP4Q9
         IYnqFCaTNRHtbQ3GQ2rLTJXQILRNmXmfXGeEdO9NiDMDbLh8qxgv9ISW+6hRDNl3YSCH
         wpsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXoGehNlNkHOOWja9+7I+9P5Wg30NWGrxFKncDXma/aa0kBrwyL9WD8PhUurMhnE2iVXUpp22hKx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSc7Vy7uJGQ5JBh69TBhxj1sLNLnGVm+p10MYhvlG6cblHovF
	qwCE5O8bge770HgFKLwW0ZGgBnBPU4TTVw7B1RGTbrbMYJ099p6XIyvY
X-Gm-Gg: AR+sD10TB3gX/1DHx+oHy6Zc8uUYQz191rgnvNFuQhfsWzO31Sh9b7jlKIKA+3ejSzn
	PpL4DPfZ46J0itxKQ6BanhDuCD6R7fzrneTaguVH290P3HghI9akgbs7U9rSHCcek1x5CjDliS4
	u27qL+0TrGev9CiaKvRa0y2EDWLPhc7Cvm7kuyHbDxaXbMNCPZlHpE1XqQIsTVmNxiWLZd0YbgT
	8RRjVO25SIG2a5tEluCO0X/QdSsSbWUBJTKAGOVT6l6aamnOx+iTRKheNihpF254a1egUD7bsGe
	z9bC7ZaCt7DpIi6A5xTidEc5YhFsNK5DPgGUQ775/d7wYAiqAf0wi/xRoV1FzBZQIThcGtFBJR8
	pGZynZRGdGENKIKJ+m+/FI4+pds04e0ZAt7yYTNfmEcovBpfz1q9bnR2/lCgTr97A1H2P72XtO/
	5EWMDm7HFQKYq2TQl9A6Je/OgQ54XwVZpnRkhLlPmAXT+h+s/+6/LR2qS4He1qCcpxBOxu2REhA
	eoLPpLpjg==
X-Received: by 2002:a05:6000:3102:b0:47f:5a97:2a63 with SMTP id ffacd0b85a97d-47fd729fce9mr28593445f8f.9.1785764638595;
        Mon, 03 Aug 2026 06:43:58 -0700 (PDT)
Received: from fedora ([154.182.126.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm34328908f8f.0.2026.08.03.06.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:43:58 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 1/2] staging: greybus: audio_codec: fix sscanf return value check
Date: Mon,  3 Aug 2026 16:43:43 +0300
Message-ID: <20260803134346.6733-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
References: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch static checker warns:
drivers/staging/greybus/audio_codec.c:335 gbaudio_module_update()
warn: sscanf doesn't return error codes

The sscanf() function returns the number of successfully matched input
items, not a negative error code. Compare the return value directly
with the expected number of conversions (3) instead of storing it in
'ret' and returning it as an error code, which leads to returning
a positive value on failure.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Closes: https://lore.kernel.org/all/YoOLnDkHgVltyXK7@kili/

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
Changes in v3:
- Split from the previous v2 patch into a separate patch.
- Updated tags to properly credit Dan Carpenter for the smatch warning.

 drivers/staging/greybus/audio_codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 720aa752e17e..295222ec0f1a 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -311,8 +311,7 @@ int gbaudio_module_update(struct gbaudio_codec_info *codec,
 	}
 
 	/* parse dai_id from AIF widget's stream_name */
-	ret = sscanf(w->sname, "%s %d %s", intf_name, &dai_id, dir);
-	if (ret < 3) {
+	if (sscanf(w->sname, "%s %d %s", intf_name, &dai_id, dir) != 3) {
 		dev_err(codec->dev, "Error while parsing dai_id for %s\n", w->name);
 		return -EINVAL;
 	}
-- 
2.54.0

