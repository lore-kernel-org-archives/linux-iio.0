Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9120D4E9
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681895; cv=none; b=JLIqLzXx7bkmSdHCk3Gxg9WOZPQuitPORsugo++ItSltuV4FCTNwwMPt8Zd6nHr4ZY8CdA/8AoALXKvNhz+LDnj2iUhR+dtQhmGylyKMnfCrso3M4SQzXYDA3hDU0S4Z4JAdKR6rgeeijVcV7pztgFdwdKMelb8OO9l6r7FpiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681895; c=relaxed/simple;
	bh=/LsPFOJmzIPzWxLCW+NnifEAp+ar3S9FlHUtZKBGOJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSP5NFpghLzz2uZNOdJd+PXLp/dc3LlSl7KguCLniioHGCNgzaAyIqGv4kktKRjQAxxCm1oWYOUHtV2G5FBBsDrKqikdg/GCpLQiwbjYMVaYeWm5r4kUfYxMCDzlRp1DA/1xtpIcbEmvoiPt7deI0bwSun7AtOg2Nh0I2+kNmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMIhet1X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMIhet1X"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so816768a91.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 21:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681893; x=1787286693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBpO2YRHAeMLE3X30baFA0npp58hMq07/JMAZ4L3PQU=;
        b=HMIhet1XEGPV/CIgQB1u6VixlcmzoRKzz4c+6O8SDLmAFznaqYqMl5SL8GYZqHqEIK
         TSYF74UZ2JHr+gO0+s0gEPJZ85wNQXVK7sDwHtKCPFv9/bKFVr03ebL8oQ6WaPEhdaQk
         onC0yocebkz96znuoA63Ndu+uV9IDL7NUurlWQkueVEfeLImOp3Thh+7PkC5m+0QDoNG
         Tjys6XAv7gdFEcwB8mQ6nRDLTMRYuJzNtZwCJKgIb81//yJl76O7X0W1l7Q6PKebdtFe
         qnwfnGEk3e3njR6aKI83jiL3G3DC/Gn556DHewETa9VrdV1VBwgjCmN8U+ZGaD66u+7Q
         DxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681893; x=1787286693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eBpO2YRHAeMLE3X30baFA0npp58hMq07/JMAZ4L3PQU=;
        b=aVSddgBzfLHEfPwi7y6HVegtvCKHs9KkBgb/b95rD4/Ri/a59t6K00hxRsiA+kJBvJ
         7zOs30DKdjs/+Ym73eF+AbpGfEepCaG09M/GWm10X5XgMLP7m6xH4yTJG9dJqmnVH5vV
         p2CelyqsagnpxDSuc+fH+6pjuPrFD8sX2rnjycA/SS0vCSQsgA+cBHmmIKoMClehgYiH
         54yxtbbymuiWGCJSmVbPmVdgdkrjDTsUP7/BZlqmbDCJtLTBqE7QWSxZyw3O98Z5lFFc
         MsdQWN1NeO9/aL3E9zH+DQJ366MC9iqjmOIAmWBFNJ4658uYGwjupIqmIjhgiefjTZDl
         C1pA==
X-Gm-Message-State: AOJu0Yx3BKqVmv+g31ztxQmzOqADtb8Jj3fTuMyYPMtVPmqu83coXZol
	6539rIPQqxyeNMgjKEfJMe6sWtOsqi4CURQ4arZCGdSyUpxR2N2WuT40
X-Gm-Gg: AR+sD12Llr5BzIvLONvojT+swm7sh0LrtPhM/g0di53UxRrAY361GLqc5S9lD9onqrP
	021O94XymecAmS6RLuIXL8ud46KGlq1WeooBQ8E9J3+jIK7jUY3ll3P5ye8zQ8lCe9rnjUlCxkN
	RcfevpVixzczViw5zmmCTVLIhPThOjGgYmX9xmzDrO9wLSbc4YNLWCUpxBQ1yDj8beiZceBU5Ad
	yH2HICQDbJmtm72Ijp1vfStEdzEDXkPdUEtVE+cVRRvwgkAzVjfMxkh9H40S6NNiueP4TvAF6qP
	94DjK52Y4lmQ4GYT4N8fpPlUFp6jw+NIGwvMamkaaleynLrqdkzc/X7PoKTDDUaCeORp3ViLbRU
	uXjzCBynylGX7Ks3DjGJA4jxyxI9bccjS4dR8X+AdNmSUaUlDgxUvkXk/APUNqH7bDhpaTFI+wi
	DuyOOfvX9ekiODirLuRSLGoNPtqIgLL7w8SwC+YY7RTAwc3m9E/x6gqJ/nVRgxY5yxkfo+ah4fd
	EwjaNjhleLo+JL6hAbHjQfKreQYpdzLBQEg2Zo=
X-Received: by 2002:a17:90b:4fc1:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-3933b8f143fmr3530854a91.12.1786681892895;
        Thu, 13 Aug 2026 21:31:32 -0700 (PDT)
Received: from [192.168.20.42] (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee65sm4238288c88.10.2026.08.13.21.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:32 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Fri, 14 Aug 2026 14:30:42 +1000
Subject: [PATCH v2 1/2] iio: light: vcnl4000: use correct channel array
 size
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-vcnl4000-v2-1-9b771290cc1d@jacques.com.au>
References: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
In-Reply-To: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

vcnl4200_spec sets .channel to vcnl4040_channels but .num_channels uses
ARRAY_SIZE(vcnl4000_channels). Use ARRAY_SIZE(vcnl4040_channels) so
num_channels matches .channels.

Both arrays have the same size. No behaviour change.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 128ae3f94074..663e623da833 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1874,7 +1874,7 @@ static const struct vcnl4000_chip_spec vcnl4200_spec = {
 	.measure_proximity = vcnl4200_measure_proximity,
 	.set_power_state = vcnl4200_set_power_state,
 	.channels = vcnl4040_channels,
-	.num_channels = ARRAY_SIZE(vcnl4000_channels),
+	.num_channels = ARRAY_SIZE(vcnl4040_channels),
 	.info = &vcnl4040_info,
 	.irq_thread = vcnl4040_irq_thread,
 	.int_reg = VCNL4200_INT_FLAGS,

-- 
2.55.0

