Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42E3D16E2
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921560; cv=none; b=tmJ8ohBh+VBKN07Bt6FlhxSu0OdoNN07RaatvclvmqKSCLrEzVHRnTk7KOcyxA7WNjokwOP8+OS486pwD+SypLDkiHN3N4F0byPR4tOlSZD4BvBDuREWFFJjkxgEs73GGnIY91LopBF4Po78aUEjTndgra9OPPDZsPCtdhdTjV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921560; c=relaxed/simple;
	bh=F8JhpNRtISwTJCZ0mFH9huui70rVNKoYVUHt0NiS600=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVBJsuXTh8iE+9MZnD1mMAuSG30hMkTVcLzsT1MJnmTIEYX0mUA573p2Trf16S5IJqYmDupucek79XHR0lNSvj/DEzTRAupfEXRil/MKglE4E6PJzBa8CN4wsqJHgpezjj/JuHoSMbmfK/uo0Hpq9weaXkrvNrxuJrRmK/qD9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7rH3nYs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7rH3nYs"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso691929a12.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921554; x=1774526354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwqEwLydPXTJh37lAhGuKLAvUQ1T9VTG2r0Fov0v/5k=;
        b=M7rH3nYsa/1bYKGY4Vf71pP3ixR4qLr4GhC1P0jTJIjtx5qT/eBaAehYKmQkQpG9eZ
         mSx71J0pmLip0//UK3SM+JCNP0myN2WkeWAIIyDM+x2YwDsybMPOsNzin9I9nln5x3JH
         gCqNDVuhtPNxMJpyxdoPX4GPLjlxX0neoyfVKBBdJoSZrTsWcC+qWQggc8GPqGU0x4Oi
         zGu0Cug4cI2MHvrPqlTOvq5RsjaP1s+ve5agb3g7ksc3chx8JLpeNe9/XSThTO+v63rV
         jcnhnafRbxBpc5ak9DJGUeLTk+ByWl8KXah7ZAmyGCCAZ1KEGmYIePNoDOLH0VOahtnD
         1Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921554; x=1774526354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwqEwLydPXTJh37lAhGuKLAvUQ1T9VTG2r0Fov0v/5k=;
        b=Mau2eJY7zmimDR3e9ouskN3/bN5LFRenoLNd3XgOm+A5haPFOHOJZlrjKcKZ1LtnjR
         6XuDxLlCjpkwMPAKv7aT5DqADNebiRtiH6Ug0CBUUwcAEnAxc8l90W2apmNlsOMpw6o2
         2o75Akg2y5/q8jAFIBT9RTvdp/onAWL4iObO83ZvVLzyjjlHXzoOnEZUiMU2jv/711hP
         iCd7g/2UskxX8RHNdA/oxeIeSzCI1JmOqTIPBGQJlnMC/b2f7MPtFu2OxFFcZvzyevdC
         B7tJML3vn6/wgcrA7+1kYipyeMSIAQSUEUgHOlUjrwBNtg/u54p4D6OVCbo5PptfWvNl
         tvrQ==
X-Gm-Message-State: AOJu0YxRr9PI+pPP6VPyceLRMYETqxojUC0/JtA1+/vJBdPQlgsJiyLz
	e71/BlvgMHvp8GzDUNuoNXMl8vV3IfVDs+spFSb74df1WnL8Pw8ij70q
X-Gm-Gg: ATEYQzzNocgbNe9/MbopMqglPPZrDn4Pn+rbUkICyLAZA7SlLEFuza3CL8tIygDVY2W
	NtDH/hKN4fn+0/261KSpHTxJjX7ghY8XPcCZRvxJhUFYXEO1bxwtz8R55+LXXC1jcBfD3wA123W
	0vT7vGH9OPsLVZPL+NdIPgAPlVepQK84/8ai4uTLgMwTeH32HAlvHVnBIVNTBJe5wYNw5iINzPF
	agL+QSwvbuWURmy/EijCLqtFRMsN1c1XFCcTQ/z2fHcf4WTz/GPcUXW8VvvD/M+Lc8EKMFOsRpn
	SxU9CmbI7Bwcm570zWHA26FaRH84WirZb7kzVFKw++NhmY+oaJ5Di84WPAwDgmR9NsV6T9VZ9hd
	BCg2bTR2Kf/4tcDWBUg1F1KsPm5I2zBlzZz9/4slfaX+T1LzISx0nOPC8eGLsdcmgCwPwPJL6Dm
	drrpR5Fu3r3/bOMUvwVJiro6Y9OQ==
X-Received: by 2002:a17:907:3d4a:b0:b96:f329:e66 with SMTP id a640c23a62f3a-b97f4b010b0mr492191266b.51.1773921553701;
        Thu, 19 Mar 2026 04:59:13 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:13 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 19 Mar 2026 13:58:43 +0200
Subject: [PATCH v5 5/8] iio: light: vcnl4000: remove error messages for
 trigger and irq
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vcnl4000-regulators-v5-5-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

The error code is available in the log after return. In our case,
attaching a triggered buffer can only fail if we are out of memory, as
no other buffer is being attached. Remove duplicate error messages to
reduce noise in dmesg.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cd7e6ee42cc5..76aee16d479b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2033,11 +2033,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 						      NULL,
 						      data->chip_spec->trig_buffer_func,
 						      data->chip_spec->buffer_setup_ops);
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"unable to setup iio triggered buffer\n");
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	if (client->irq && data->chip_spec->irq_thread) {
@@ -2047,10 +2044,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"vcnl4000_irq",
 						indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "irq request failed\n");
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = vcnl4010_probe_trigger(indio_dev);
 		if (ret < 0)

-- 
2.53.0

