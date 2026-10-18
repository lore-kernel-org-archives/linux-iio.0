Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BB4DE712
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359498; cv=none; b=lf1iuzP8P8SP5XRgCKzBPLMj0Gm/VHZnEoCBwTAws4f7pm3Oegk3Pkv1ey3aAaI3KNpsYjk0WJyQrZumzxPoMMKbEYGf4i3aKc9Kfogud2mCpOPmHlq5D0+lynpnWG1NYNPC+kHJLSD0tQtnHhq9sl8DZHfVTI7LRm9qUZnwxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359498; c=relaxed/simple;
	bh=r75zBVmugnnLzV+NcNmRfpcT5eTmGOYD4BVPBqzaA/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oddL2Wysz4tGuTuSnJAGv+WAt3BNth4HM/d4tUwWflNfUcQ3uoWES2fGVF+14vB9GMvvBdTUUt+ExmldfOyvphxu+Ps32bcBJX1csXOgssXVKwk+4Hz6vYQPXJ3zyXXpesXrfDCLwrGBtEFlVGB5bXf/AdMZMGUB/vhay67RqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ4IuHny; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ4IuHny"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4d648aacso1263339e87.3
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359495; x=1792964295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqnHzvfmWXKTXBUOY4n+0mAVt82slF3AITsKMweBycc=;
        b=UZ4IuHnyZc4V19WnHhuuEaIecdmf1ikMb9OBxJVAMjgLQUpYPbyFr19LqPvE7DMtwe
         Jq1TzK+CMyiQCJdbuedDJVXSNCzB+c1UH1Ion1TmL8TKkSavhwPjJa+UKU3wYOnowgSz
         uKiJ/2vCpvUc1Ez/PnUQ9Y9g30bWDKTvJIawwcB5PdvGvqvmc048c1G3sECIZ1WjRolH
         6vent1xicYEozZtYwvvR+Iryaaa8blZCrzJ9vwbRlajTLteNJlnGZjwxICbjRM1MRPOt
         Ejj0Rt2AfkyqaWkzoZnAeoMBXnavjBTEBb4Nt8VNXGrirglkozKv3fjjTKyc24i5twfe
         fSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359495; x=1792964295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqnHzvfmWXKTXBUOY4n+0mAVt82slF3AITsKMweBycc=;
        b=ZQI1rTRi/UwtCGWm9RoQGxq5UG9959RauBdPkpMDnzluASiQnR4l9gWvqeWV+N4mYT
         A83rocGUDJTttGPEbtwz5SNr17/GmoAdXc4a3jN26plKN6g5eNtmXKDK8II/ZzA+7kER
         Ra6YU9vZV+2ftRo17J5NX5qk6HnJKYtLCgLoOcud5SdaEGqXIvextvN/xVgpKIJmSRKA
         6L1/OcYa9VIfYN+3o8CChswC8ztQbakOe6D8LzPbgXKfU4Gfm8N6fjAVfeMnaigz9Tk6
         a7RMjJidVVZIDx/grIaby2CWm46wWRuuOmtqzRMRTtdCrgZOlOT2DI1uL6nGZUpX/4ON
         iaKw==
X-Forwarded-Encrypted: i=1; AKwUvBy//aNLTjErvQKI/omRaQglLagLAbFEucwVpigG3STbeDP0Oo3A1hzc24PjhN3vBipnK30B2iWpMjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCSfCA3340nNcr5ew/TQCYkILFN2g5da1K+827GVecq6Jp6/zK
	ZWo+4CgrF+GB4Fpx9+dPrzLk0oOWtiee87XM1T3g4Rt0sOMjPKIVc9bZ
X-Gm-Gg: AYBFou0aULGC1y+IX3D4TWdxYUPQ7hGMXqNn/gFDiSBrt+PK1oVyV34M+ZlHQOhMUws
	zIo9rOaVE96/+PhXJwHkg8C6MgQmHO8mGorMRo73Vvn456Q/Kkiz1CY5UmP4pRd+lsnLuJ4lUk6
	KB/scvw0A/IivMaVtvFyvhHcH3rySNZbX08Y/bBJ2TC9dEDkw3Y6A9zRVR8as6ai4+LjvmxXNaQ
	CKetf16O2z5fixV/pziUKVn0BLJQwpG5LOgU/dbKWy7S+zSzkKuQPsC6Nfwqrau6yuVJe6z5BAI
	a2ioH0UddyU8ewU2RNBoMRiTZtV7+w7cO2ljOEqHG+SEqHnbF3iV0VoaoJCSTelPcdOzwXH7PPu
	gHHSE+qCKNo8qLOEOq5M956weI0oQtAW/lN7xeY+HkS8ZfgSCkKljg2YGBr2SstFh6UIIStTrqa
	ZQSsQ+rPpTtkIzmyF5wiB9BRekgQKdxX1ALLFncUQ43y1JuYsu+3z/RgPUZTyLuddCohuq007nq
	bMXtweMze0FVuQ/vGiTBlju0T+f8/sd4GFZ+IkyBc2ZEOzF9a7Bk56LwoGA2jX/EPQ8Oppnc4bQ
	wUrBQJQ=
X-Received: by 2002:a05:6512:2349:b0:5be:58ad:1b93 with SMTP id 2adb3069b0e04-5be58ad1d08mr677208e87.15.1792359494523;
        Sun, 18 Oct 2026 14:38:14 -0700 (PDT)
Received: from yantra.. (nekmmqtaaozvmkd1587-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:5185:c9b3:741a:edb7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a3fcf07sm1584244e87.3.2026.10.18.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:13 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on mutex helpers
Date: Mon, 19 Oct 2026 00:38:12 +0300
Message-ID: <20261018213812.56858-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <asIRkK-uUz4FKQBN@ashevche-desk.local>
References: <20261003214516.128573-1-zoone.rupert@gmail.com> <asIRkK-uUz4FKQBN@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 04, 2026 at 11:42:56AM +0300, Andy Shevchenko wrote:
> On Sun, Oct 04, 2026 at 12:45:16AM +0300, Rupesh Majhi wrote:
> > The __acquires() and __releases() on adc5_gen3_mutex_lock() and
> > adc5_gen3_mutex_unlock() name adc, a local declared in the body. With
> > context analysis enabled for this file, the build fails:
> >
> >   error: use of undeclared identifier 'adc'
> >
> > The lock and unlock are split across these two helpers for the ADC_TM
> > driver, so mark them __context_unsafe() instead.
>
> Doesn't sound right to me. The __acquires() and __releases() IIRC are sparse
> annotations. If clang has something special, it needs to be addressed in
> the compiler-clang.h, no?

Sparse support for them went away in v7.0 with 5b63d0ae94cc
("compiler-context-analysis: Remove Sparse support"). They are now
defined in compiler-context-analysis.h and expand to clang's
acquire_capability() and release_capability(), or to nothing.

The argument is parsed at the declaration, where only dev is in scope,
so no header change can make adc visible there.

Sorry for the slow reply.
