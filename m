Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108CF426D2B
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892532; cv=none; b=jV9vY5iopqogcVpqGzujy6bho6TAg5cauKVQs1YHckv/cvGwfx0d1XPTxr4/+M2EZVj93qpHRWgx6mm31kSDmVDc1dluvV8nRIsiPHZG0Qd7tQF4BglK8z24icZo6cldv3H6PAM09UwzBGCbxQKgSgvxW+ZTMRkQQ2915hGME+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892532; c=relaxed/simple;
	bh=P4wkV9mEDD23BeKG4vbE2EM7CHolhjJ2JRjQJMeo9kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuTcmbfE1tITwJFmlVsi4cUUkSgIiG+kTK6gLW+urQNMyxv+Pjj1btL5YnQKeOb6vgbmaSogksqPf+lgVBt8Ou8IaZrHni1klO+K7GlYk+orXnDHVwjriLRwSWgYjJydOLwyhQTFwlvxxmwFm3bCqDSRKMat7wqHsNNkpYWm64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqcVKvfO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqcVKvfO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49068493267so24348485e9.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892525; x=1780497325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vua8WCuJgrLlWDfrDB827XHjkp+v2MUAOu7XMIUMLuo=;
        b=mqcVKvfOYp+DM15QeRBAI9Zm4J7Pvam+Az4FOSTiezQonnOybXs8VhnUkeLkTUWcNr
         xghQa++Kq20M3BHpXk2chPFVwSuQE+YgFqzROMKWjEfSP3v4lwDB+FRrcR9TFXSySGLz
         alUuw/pmgrcMd4V98cOXlMzZXQPTpChQa7cpH0QbTs9jFawEVq1uwo+FOrQAmyvu6G0P
         IxXAAJPiIbmxjw6LuDRr1Cy9qOgPhjJeZr+2rPlCyPkfzit2SEWs3MuqxO4XPJqrhC+u
         8ULbfFoTASPIP9Hmm6ITF5G/4zv4UI2aFV0mGz7jKZl9dYTAckpamhbTmOEHl3e6gcpd
         F1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892525; x=1780497325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vua8WCuJgrLlWDfrDB827XHjkp+v2MUAOu7XMIUMLuo=;
        b=hgcKIAocabbPqrer3fL2GReT6aqJuVZlhos3v2+ovIwiN5MzCi84BpEVzComEI7/2Q
         LWsE/QvXkJuj2otf8ydWKAYR3kI5YiF1qfXhir7uBT4partOBCMyZbifsCjS0lEBHn5O
         ob9iwiFkYi2tcE2q1TBdkgNEaC5xvrE1YRLCE+coJQC4KoCEWkgvMKNMyZY6EAV9QitA
         zgTRekBENTngCH6yXDOIxJz4rW1dfzvbJS8R+dPqpU16rbS2B3rWyLtIGAe/79T09ojG
         /+rCxE3TjEwBWZXkXTKBlcUynw/nRUpNOJE9QfrcsG5NkZshxi8FB6mPJK3ocdVJfYrR
         i8gA==
X-Forwarded-Encrypted: i=1; AFNElJ+Lxpn4B/RG2dHaOIn2/hk+th9zfK+16pXictVii+5PUZdahEY2V1x6ogJpiAUJzHH3+tEv/n+3V8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM92a02t5rkqkhrKH5LdFwFjCYKAH0HuTfXMcksNmmZtg2bRx3
	G2eW1Z27kHc+b9Ws8h1+KwyCBEKzM0e6OXebSj0M7Qcb0DTZ3eo1cw9v
X-Gm-Gg: Acq92OHybJAbYqBkt52AvH06xKCGhD4uNZsp9kMfysEZq6kt5BrmdaVXHPV8NB8bErF
	cvT8jmgnY8RN8ipIXBYeVgeqCp7n/Qu0BN/M1v8k6dvftqcXPcZNoFnhaL88xwgBHFNwF/LWHjo
	Cy1eGAeVeCz4IvcrVvL0h1OeX8y6+3eyBiROB52DKletaDynlQ66c8qieONCYGIa2yIku4+k1IS
	bOOuvOPfV3zfWJqalFuPcZpfy2rSTnYDCacIiq/W6ypBsCGr3T5voH5OywBVkoFxKMVpsJSHLXg
	h5aEMc5a4oJLpygZsoU4zaZptl/mopdEJ1AFsErcYoXu4LRM95n3NskpbudHLEAM+/9G9ME6czG
	erpNAL4e5q6Yo0KzGloK1fXfQrDtFTK0/+YZ8t2/zs3Aousl9vO31ey8Aq8liny9SCcCsnvCQ2Y
	4PtiWQOk4xy3eZLXZhP0zJjtiZeA==
X-Received: by 2002:a05:600c:c4a3:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-490426ceed2mr394337305e9.21.1779892525073;
        Wed, 27 May 2026 07:35:25 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm6239763f8f.11.2026.05.27.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:35:24 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/4] iio: types: add IIO_VOLUMEFLOW channel type
Date: Wed, 27 May 2026 16:35:05 +0200
Message-ID: <20260527143515.102794-8-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526165950.6ebbf673@jic23-huawei>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260524205112.26638-2-wafgo01@gmail.com> <95f0914a-cb25-44ea-9cef-d203c624f74d@roeck-us.net> <20260526165950.6ebbf673@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 16:59:50 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > Two questions: Why restricting to liquid (there are also gas flow sensors),
> > and why litres/second and not per minute which seems to be a more common
> > unit ?  
> 
> I'd rather we went to the SI units where possible.

Agreed - SI in v2.  in_volumeflow_raw / _scale stays in l/s
(rescaled SI m^3/s, matching the rest of IIO's "kept-small-for-
userspace" convention).  The ABI doc and a driver comment call
that out.

On the gas-flow question: rather than adding IIO_MASSFLOW now
without a driver, I dropped the "liquid" wording from the channel
type doc.  The SLF3S driver is liquid-only, but the channel type
itself just means "volumetric flow rate" and could describe a gas
sensor reporting actual volume rate just as well.  IIO_MASSFLOW
for standard-volume / mass-equivalent gas flow can come later
when a driver shows up.

Thanks,
Wadim
