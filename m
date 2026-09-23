Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BF37F306
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137709; cv=none; b=l7yPwSBE/LgoorjIP3aeOBfX3RzG8YpgAgsD8mpY/aH8X/rHjlLKHIop2hGZ4xEaXds74gJkKi5o6G9myZ6sL6B6tQ/Zxfq1Hy6OSWzMqeFye2qmyROjl3esbw0QzkV9GsKeytgnB0JmY+O8nlRp+TKXxjLTCVRTmZtTMaETjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137709; c=relaxed/simple;
	bh=IqV1Sr0fSrDMt47qWNQ+9YAMvUWzYdiSXARmQmR1aMs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OSaicYWXebfbYo73UkcpFdRAgUUGjQlz+Fjd1mhvbxxItX/zgnEwy6vyZ7zFJlCBpmVFVSCfRaHcaPA6x/JtlqWeyJeEdk8QycKRybGpyfUaQ7joxdsThv14dsbaL10+gTNh+rERC/43tXjanPxk/l7SVlcovOU9S3acdX+67U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEkbdkaw; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEkbdkaw"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-396901263b6so602198a91.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 21:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790137708; x=1790742508; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ngy4XhNxX90C6pR7bGxz/LIb3bO/nvGfahStoZKtl5Q=;
        b=YEkbdkawAy/a8+2S4ylWed96ck+j1g+9bGox3XZ935krOO8g48/lUGl8Sx9OmuQPJR
         AV/szlby6OWJKuV02BqVeC6yQUbSc226IgiC+BcbuVtd/b4i5Tze+/WFKpbaXFzQegea
         /2xIi6JdvR2U3Y57zMe2n9QmxzRoCtks2CR2D4mTi2XztUs2M5eCmelpGI3HeV6F2f6m
         DdtAzSn3OoBUw6D/pdqtzPk57/WmLQVlR0VLYQU3SoguJefm5nkCqbzWTG5qcH3leFzt
         coruBivqCIr4YQK9fbDRK4btcq5VfreJTZWDdEt18ONv9SPz04mRvxv2u+oMAcLNdzLZ
         hm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790137708; x=1790742508;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngy4XhNxX90C6pR7bGxz/LIb3bO/nvGfahStoZKtl5Q=;
        b=i5Sm0Ku0R9kTrjajxb9+yvjaURCFvVRZ2/a0CR5kI+hgLu4c3vgad4KH12s6fZQqjq
         KeT+8TDAyjKVT/r8QuZcGjbrFFOq61uKCFs0u75BXygvVsROXNmZRw/v5OiwbRIO/jP7
         +w7KjVkRh8sXK1VByXUFMhAi6Xl8e8ls24SAUPVb9iafmubrj5sFWx+i5PoFy+6K1Je3
         dp57JMK7/MTif1SfZpE6BsfofpR7f9pE8v7CeNZD8anuW5mzAzRIYPApwpdUK/enQRLH
         U4Ws6PyCeo/rrOZ50iOlYNjdJb/I0E1U5wU8omQrfcygqBKL9yHnRH87MzFifhi2RstV
         OOzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHHSH7SVnKTIg6kTsbojjmOaao8xKAxQxrUFggabIib3n9YU0GoLdms5QiJYkqkTZBS9mo4o6ABfA=@vger.kernel.org
X-Gm-Message-State: AFuF++mUIiaiCrNb+SgAOo0TAHS+FkiY7ad9m0o/5v1x/d+dQFLLe0XF
	Rk8f3uw4Lp0af/Hlfpk3MrHdKHZRbkxMZ2AxPRu7PhT4fq77oh3mIJzkdGlLs63vG/pjLQPe9Mp
	L
X-Received: from pjbkr5.prod.google.com ([2002:a17:90b:4905:b0:3a0:7de0:6fac])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f8a:b0:3a0:42a9:9c81
 with SMTP id 98e67ed59e1d1-3a07e65d0d7mr1242952a91.17.1790137707448; Tue, 22
 Sep 2026 21:28:27 -0700 (PDT)
Date: Wed, 23 Sep 2026 04:28:25 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923042825.2558762-1-morbo@google.com>
Subject: [PATCH] iio: add __counted_by_ptr attribute to channels in struct iio_dev
From: Bill Wendling <morbo@google.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, "=?UTF-8?q?Nuno=20S=C3=A1?=" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

In 'struct iio_dev', the 'channels' pointer refers to an array of IIO
channel specifications ('struct iio_chan_spec const'), and the size of
this array is tracked by the 'num_channels' field within the same
struct.

Applying the '__counted_by_ptr' attribute to 'channels' allows KASAN
and compiler-based bounds checkers to verify that accesses to 'channels'
remain within bounds at runtime.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 711c00f67371..20505139a61b 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -648,7 +648,7 @@ struct iio_dev {
 	struct iio_poll_func		*pollfunc;
 	struct iio_poll_func		*pollfunc_event;
 
-	struct iio_chan_spec const	*channels;
+	struct iio_chan_spec const	*channels __counted_by_ptr(num_channels);
 	int				num_channels;
 
 	const char			*name;
-- 
2.55.0.1082.g2b9226bbc0-goog

