Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C03BF69E
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271970; cv=none; b=gcUDK4Mw4R8wphtbadQJJ0/QPNPNyYRxI1BmJFXbaenVwJeRLoEhN2DUSUFTQQm978yqB9oi68HhYAU9K3ByFC9GJ05uP8sAsuNHcNPu+98PaarDahNkiYSm0T5tYO6eJnf4IzHpvEC9qCnPBFBQhoq0i++zlcFC9vUu3v6ZLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271970; c=relaxed/simple;
	bh=0B2p36/qTj2Fdw815lUlDWHFRk7MfZrklT7ORDPhlOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukSAMtx9/d1zVHQ/nA4IPBjPa0yKS6pgvJw7KIDjRgKv0tteku7SdRpIrYZEQwGObjv378w19YGofSXlG42s18mSQOgQJQdMXxtgEhSy2vUKSTJmZu2iPmYBk19JrQWq+9Z7JWm6IZZKVIGXaM+yqchsMz8yDc9pO5IusXVQ2Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmA2MsAz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmA2MsAz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45562c41ec7so2875560f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779271968; x=1779876768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0B2p36/qTj2Fdw815lUlDWHFRk7MfZrklT7ORDPhlOI=;
        b=OmA2MsAz2sR5y1NO37zy6c2vazFq9jIQ3DAafBB7de1wK3bso3yVKR3rD+KWTwClX7
         NDwWrbGiTwC8TIdBBpY7hOhFZpPksgZ+QGOofg+Uv/TxA51xrHbC2bPI8Wlr0nEXm7td
         BAq4DFQ+dZNC2vzeHrs1Dpi8a7jQgQsm3LLUA7AmQEYAJFjYWeSaHg/ERq98KtKA3YOf
         pjC1v0P6A0bQBgVK6pKhewxcN4qGyl19yAOsiEwvCe+aoQJcpj8CeIqblBgN7615nMnJ
         gndP+vEYPeOiS6L31/DNXz1kNZZy7uttNmx1UFp5hXSKo8Xv065R7ugwnGfdiOa+xQVd
         KYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271968; x=1779876768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B2p36/qTj2Fdw815lUlDWHFRk7MfZrklT7ORDPhlOI=;
        b=rhlvRC1XRuozLq/IcsbRVSLdktvWyOb9va7yetWT9CYNhmOo94R5lAyQ4O/Wvu9tW7
         ivC/6zCvuTpsbd7C+aq3ZWtOwJsNjV7RloMq6CRtocNKYUekn1rq1FkbiXsNOzABdjH+
         vEHhOJCdETrSEfgUUQosx6DqfpEIJSI3bJO5T+PV6Odfg9jTwUHwuVrzM8eqvEt6jBPs
         sw9xwvYGf5GECG7JNhvAiOTcCR2D8p5SWCA3EJD10Ql0fI/V6DNmB/KUPG/NYNdbsZzH
         4MY6Th9J4FKDJuE9235pn3JUGu8FEYS5/NoPubhsiuVltbxxXUD3tGgjuQeNMakfznGr
         8NLA==
X-Gm-Message-State: AOJu0YzlCtZFVrmr263y2AATIHVECrhAU5fFkr3hMDm0HsECIEHUozl4
	Bv+TOtJeetELP4sYEfs+yV3qwiOU9cI678sE7pztIAXTONV3INijWPbV
X-Gm-Gg: Acq92OEHz5HQtTTp+LMUV99NYJTC1hveWKaiL/rW8GzgQlAR7uJjIhtSnxOSrfpYgmd
	qc+wxYy9Q0cXS/Kgvr130sgazvESODwJBFzkl3YkinQke8b/5wzjLnDIoNqoE0vOolHlJoTo+SG
	B1ZKBJKmwqcDPlB3PISiT+qcqMD9u0lu6afOboIH811yx0/jo0Cvup2o8AKAiGkvTaxkGLeQeeC
	5LgdwFb0QaJ+OeOJzY4/1FVeRzUt8NQk/yjVGgE+kUKOTSyGs8RUzLf4Nq/VwWr5VGe+v/ZnNu0
	Du40dT5L2+fuX7tt/cEBXsoaJy8SUw0MdzrFbZPHdaRP51YdzUSpZw5l53fmjS0AeHnj0dkoWF+
	KI06ky7BRFO7Se+5q0YfSwt84qzfZODmid3Wg/sVO1FtTLXUroFILHP3uq/1bFfD9One3O7B+w+
	RHZatYdGPeBoqBEtfs7iTX01WLfm1qdghaFKL1GI7Tlea3J1wKg8LqCnXgIwyKtps=
X-Received: by 2002:adf:f64c:0:b0:45e:73b3:4515 with SMTP id ffacd0b85a97d-45e73b34553mr17891059f8f.35.1779271967665;
        Wed, 20 May 2026 03:12:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:ed18:5665:257e:fff1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm48760228f8f.26.2026.05.20.03.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:12:47 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: Re: [PATCH] iio: accel: bmc150: use guard(mutex) for mutex handling
Date: Wed, 20 May 2026 11:12:44 +0100
Message-Id: <20260520101244.64434-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Apr 2026 19:15:19 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Not sure this list is useful in the commit log. Rather verbose.

Dropped the function list from the commit log in v2.

> I took a quick look and can't see anything beyond an if (ret) check
> in bmc150_accel_get_axis()
> If it's the only one left I'd use scoped_guard() for
> bmc150_accel_trigger_handler()

Agreed. v2 also converts bmc150_accel_get_axis() to guard(mutex), and
uses scoped_guard() for bmc150_accel_trigger_handler(), so no manual
mutex_lock()/mutex_unlock() pairs remain in the touched code.

> Unrelated change [int ret; movement] - here it just acts as noise
> [...] don't do this sort of code movement of lines we aren't
> otherwise touching.

Reverted; v2 leaves the declaration order in bmc150_accel_get_temp()
untouched.

> return sprintf(buf, "%d\n", data->watermark);
> [...] maybe also return sysfs_emit(...) is appropriate.

Done for bmc150_accel_get_fifo_watermark() and
bmc150_accel_get_fifo_state(); the intermediate variables are gone.
These already use sysfs_emit() in the current iio tree, so v2 keeps
sysfs_emit() and returns directly.

> Unrelated but [...] val = min(val, BMC150_ACCEL_FIFO_LENGTH);

Left out of v2 to keep this to a single logical change. Happy to send
it as a separate cleanup.

Thanks for the review.

Gabriel
