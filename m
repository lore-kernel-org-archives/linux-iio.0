Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98D40F729
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764654; cv=none; b=gJ1eMcCDOATQbyzMVR9xXGRM4rRfn5QL/O+zFL27+uDHcRadVrd7J5x2hdHDbIgNPxiA7cgJmJTlAI6/j2aajmnyLEhEr09XV0+H0D2mqkq3+zlJRIlWhLXhKdnwLGX6+v8vjTD2OXooqwBVmgvCMGfg0tgQuV8SLf+tjSQVhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764654; c=relaxed/simple;
	bh=lhQg0++53cN6YWLsvuYUtWRHnABUxZRuUet4RxtPuNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPN6tIZLev/zAwVH7jAL2P+3CfRRXgZzWKV5AC0YpZzrXHudD7EBOrPhydgSq41dflQZRVAVX2doM7cCwOLy8Td1c7koUxU0EFiMONoKXj5lCeNiUzLLJtiiiRdMhBJMBBTdHHCr41CZBQepWS+PQssQgPhC2Y1k7pYuFhNgqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7N4Ncjk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7N4Ncjk"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47fde295992so1032113f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764651; x=1786369451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opTcDvpoHFRHn9n+WZGobddkXtZDg7nJ4XpbwWq3BKs=;
        b=R7N4Ncjk7l42lOULN9LZzVTtMer4ESR+yo+rBJHGQakMHxDJT9RNth3+VZBilPT5sB
         LubDAM2o998ccbANNXaiiOcODa0LsVGiQFORJ9xTAqt3vWUjV0c7DtQfDzp/IAKEmZd3
         XAQz2JPnILvaSfkRtAgr+Fh+GjwSKZMu+VNzK5iM1d3zFyZjOxLdWc1sCs8NwfhguVFJ
         xbFZWnMaUhnFm3WDObv51l2G5OErByjLpdhJlRMTFg5DlF7MsNMh1KOFs1dzNPamInC1
         M1jNxwEhQY2K+dWedFQlTNYKGyx7P2YLbzs66UbmxBBDYydzSv+M/s2sHoNvTR015eff
         RQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764651; x=1786369451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=opTcDvpoHFRHn9n+WZGobddkXtZDg7nJ4XpbwWq3BKs=;
        b=OlwGtsgSbMPIoS5vS9Lc4j5s/4p2Mk9J0OHBUZdJh9X/4wNTquVBQ2AkqQflUTOAN0
         MMn9ZhLOy1bX8ik7XQ8VH/yT5VVtaWSuD1YmOuz/qGVLZSDPTZhItE9bZl90KYFPeq9e
         xwG5VMqKydzoox+Wqb8ila1X71vVUOsD/rDQKasEC2qeUuNRG+CUo6WGO5RrBFNMEAGf
         JTivU7lDLV9ylrDUrGB8HPV7ipMdN7aLHipKTbBWf1plLuAdakrypmwbXeR8uL5AFVIF
         zJSan+WeibtdoHF/062ra1GDNJ+KX22JSqF7gJQ2iFy2oJ/XleQGYJANvGcZUql/eQVE
         pOyA==
X-Forwarded-Encrypted: i=1; AHgh+RqoyRwdmyVjLMWyE2FiXjY1Qu9Ja7nVMGUyySTZZuIHoWYZpXkqx6i04YhOCVsB0kNmI6S16RVa09c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoF/s4/fWH0MNk7PN+A4saOLz7pZFY23KDQNBtqU2IEB83Nzw2
	kZYK0UOFPE0TNfGwNOEV2/V5P418YyYICAXkghkIXRrjIcC+aJtm1zMA
X-Gm-Gg: AR+sD11FfGWXQQaF+6/ZBX9CN2yY9zjoNxSpo11MTUTnQtIepsVN4REXTj277MVDigd
	ouZ4zMCznrZaapVXDJ+ZNFQ2gSBgnPPYsIUnBPFm8a2x9Sx0OCRO6DNiCp8e9kPuBN0gQpMXf+d
	QYpCoUQfUYLCIUmx90WsitHy/iVNSrNPTxzfjU2FceYCwhOiPzQe1o5B88cajqodbNUp9l/2npX
	1j/nyB9+qFKWglWJjj8XjNAn1eSpwF8AkYA5+xu/IUsPNJf+uTLBX1ABBcX7dzs/qOlYATohCP8
	cencJux04jCdEHOTuQ8SrWpyApF2dnob2IVkGsUXc5nY1lRKikslFkEBTFFIcSNDUn0JZ5ce0Fp
	w2MsGyFgU6zDuUlGms8dhfZkPEpxe5rKDiRdXl5UkfT0HO4/huMydvHRak7cEdrhlNPfpc2PhWG
	snKZePJA7dBDIvXkFegV5TiXD37rvsa7V4JeB5RsqEXwIYtrCbwmT6KqGpdaHeDgAeV73vSsjdr
	ThScUlLnw==
X-Received: by 2002:a05:6000:1846:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fd729208fmr23158328f8f.14.1785764651304;
        Mon, 03 Aug 2026 06:44:11 -0700 (PDT)
Received: from fedora ([154.182.126.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm34328908f8f.0.2026.08.03.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:44:10 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 2/2] staging: greybus: audio_codec: remove redundant else-if check
Date: Mon,  3 Aug 2026 16:43:45 +0300
Message-ID: <20260803134346.6733-4-abdelnasserhussein11@gmail.com>
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

In gbaudio_module_update(), the widget id is validated earlier in the
function to ensure it is either snd_soc_dapm_aif_in or
snd_soc_dapm_aif_out.

Remove the redundant else-if check for snd_soc_dapm_aif_out. The
remaining branch can only handle snd_soc_dapm_aif_out, which avoids
a compiler warning about a potentially uninitialized variable.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606140347.gGVWDnbi-lkp@intel.com/

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
Changes in v3:
- Split from the previous v2 patch to address the uninitialized variable
  warning separately.

 drivers/staging/greybus/audio_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 295222ec0f1a..6daa4e706792 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -322,7 +322,7 @@ int gbaudio_module_update(struct gbaudio_codec_info *codec,
 			ret = gbaudio_module_enable_tx(codec, module, dai_id);
 		else
 			ret = gbaudio_module_disable_tx(module, dai_id);
-	} else if (w->id == snd_soc_dapm_aif_out) {
+	} else {
 		if (enable)
 			ret = gbaudio_module_enable_rx(codec, module, dai_id);
 		else
-- 
2.54.0

