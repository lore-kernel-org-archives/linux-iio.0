Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E3466B58
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756655; cv=none; b=qkv4sbsXZDfbNlcQ6+392dg8tOXX9g0r1fG5lsTymtVbXpnbwFjb+QwsVFx01HojDWceDb4FFIZnZphI0AoYSiK3W8sFWU9ZGbjRaQWloX0dHcQCn12cPq23V243CYpCLHusOnkl6GMi7xdCP2lHo7wI94IEfvQSu0knJfJjrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756655; c=relaxed/simple;
	bh=ipGQ97f7MUkelnfRrS7W0DNwckkxAJ/D9GjaelK6Pms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+ZR4oJzC74xdowiHjaDsTBzcLp6ydI3tKiBpXHGPTQdMIFTpC+JmssQJSL+PR2GogfbcZWv7Ebkm1RXrJo458aGlKSbiykky5Y9R9JuFZQL0sMh0NQ6NdLyUy5rRlf1UYAIKrTgFIrD6b1zUtcRWzABe2pF3lC1L1kWmituYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRoGKwR5; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRoGKwR5"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885d4825adso3055146f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756651; x=1791361451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/vpu6nOACLN1GW1gZlQkN6/DVvLR93ljsvBEfccVh4=;
        b=pRoGKwR55/XDsZT+XJlovQU7LhMuIxeOye+WtxKF5BB/1Y3+p0LU7K/jD+7uQwAH3g
         conNn+NZiavStVhU4Fhx0BCODGaLoDIEu24YOyOx8+V4e+zP6vAYnWaWP0fwAKXx4s15
         cMH4Ny//dvocLzYYjIa1WEdAHMD4l/PK8Tp96dOpVPNAJwQxGvxpYWiKI9QkefqUQLpo
         z/okCCnRpUiuR1PnqQcSWwnkV+c0EdlkZ/DUWWphSSpuHePneG1dPLzBmrmm8U3UisXr
         NaJgY/k1OyiYVaUOM3euOsIc6EEe71wmXa1XJnBS9Q1VZ1rW+r8xWE0B+I7QD+c5/Hl6
         FQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756651; x=1791361451;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/vpu6nOACLN1GW1gZlQkN6/DVvLR93ljsvBEfccVh4=;
        b=CQwMRzB2c/iUmqu4Ir3cV+CEhWFqNqodPiAmE8I5Nh4+rWSjnhO9fNUVIwlN9thCJG
         TaUfyQryXDF06wSbWqBu9pKffP25WBH/V6wNIrq1cS/q8LQ8i/VvwSd4bYyk+4YDMFm3
         UjPgxgp0Gb5eekZj+jBdI8Crq4ZU9VCJkgK/CgQ5e2rNZGSL9d7OowRqsg8hpPpu3OiG
         RtKL8spKEDpGDNmjFxkeZZ5023iP9QKhpJ/amzsUmvbLU2MFx1vpeBTlazhfy30Xm+Ai
         B9K/odTWTZJFsDNlvmV0zpZmgFism6+S8yEe0nkPPD+eY2hgu+LxzlMjxIWdvDqjCOcn
         iDZA==
X-Forwarded-Encrypted: i=1; AKwUvBzMj7FkDrNtIfG3CNf2aOn2dm8DdcqCqksnKcUAcwuQ3uuWg2lfORJjbnRMHT3iwY/XyE+si1HUHmk=@vger.kernel.org
X-Gm-Message-State: AFuF++m11gTBMVc8Oz+F8r7XV809w6UsL5DzFnxg4dKYy+mdE87g9OJG
	FPxSJMHmSN9Nl0BzC3SIByULHikvCcUztbvlGtwvc13PwNaXsko3FBPN
X-Gm-Gg: AYBFou1I3gHk3QS85ahDOAR5DlGuPo3ogsYtdD7zI1Z5juQaLjsrZjBwzFGwvfX5qps
	5fnIVxx5wakhxpG6/8562GgY7UJ+poYDwv8LxAX2Bx1gZSsNSv/csl7P95lAWUElsrOjTlisNr+
	M8isqlkpxPapStpDOOY+y+DA67zS3CC6V7wi5gDvBshkLMZHjMo8c4RWX8lVJ3gDKLZvFo7EB2y
	6UXEw0mGOw7yfvQEnYrSsWFey+MvhESVxub3qRRlGeD073KsXDjcOwIejfSkWwBaYipiWPPKFtO
	fUmv9xdEYLpli3UYmDxWlGvNdpTShnyHi2vNfaCNeKzOVKVHbwlY+pCeL4ChEmHfLymjWrakRIC
	5avLbAsBtbXDRmn+N6h1YW2zHFXvpPT+buhicvOh6qvCt6Ja4PTo5dmPSq+1+sFfVDYUFa3TTXD
	lMwMuHxfg/eBQNJRrPz2STbOStGi77JPsVQRca20fRXFCJ6vflIymuj14cOuC4QfFha7uBVrwS1
	eFix4FZ0LOdhznr6t8MjUZFSES7I3Ow7aIySs0sa0W1cn9EfN0BGpXR4jfxNR5X0R83iKPxESDb
	wP/xLBpTDiKUINKNh2ZF33wUVJfZ28mVmlgj2lKZCbsndwmYEYO65y4WsV5Ooe/yHt8vE8TtZVb
	G1fdSaYeeul9SdmYbHhl1gC0nRYYicLZEFQvxg/10BWKP0yrE5nQ8OAmqOb6O7x3YP7kKLpsqKH
	jq71u8
X-Received: by 2002:a05:600c:3b9f:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4a01b212757mr10135465e9.23.1790756651411;
        Wed, 30 Sep 2026 01:24:11 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174fb909sm40727985e9.12.2026.09.30.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:24:11 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:24:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, error27@gmail.com,
 narcisaanamaria12@gmail.com
Subject: Re: [PATCH 1/3] staging: iio: accel: adis16203: fix inclination
 naming and remove unsupported Y-axis
Message-ID: <20260930102409.00003055@gmail.com>
In-Reply-To: <20260929184900.39515-2-abdelnasserhussein11@gmail.com>
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
	<20260929184900.39515-2-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 21:48:58 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The ADIS16203 measures inclination around a single axis. As per the
> datasheet, register 0x0C gives a 360-degree output, and 0x0E gives a
> +/- 180-degree output of the exact same measurement.
> 
> The current driver incorrectly maps 0x0E as a separate Y-axis. This patch
> removes the phantom Y-axis, updates the naming, and adjusts the timestamp
> channel index.
> 
> Note: The ADIS_INCLI_CHAN(X, ...) modifier is intentionally kept to
> preserve the existing userspace ABI (incli_x_raw). Furthermore, removing
> the phantom Y-axis inherently shifts the scan indexes of subsequent
> channels down by one, which is expected to correct the hardware
> representation.
> 
> Fixes: 2df79e1bddc4 ("staging: iio: accel: Rename source files and update Makefile")
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
