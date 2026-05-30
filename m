Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09313446AB
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173761; cv=none; b=pA1MzGjdRD4zDAXqLqKHhm6FjseFHzDgSJdShO0wiPRPY1uw5xsyKyET0AXwyX5lLN4vGbyMAD6bi1RbtpspW3pYWfjTOtnlCIhbW/zO1tbcRhy2sOCfZJSYXCKVBbj/yU0fHFDE+eSxd6o42RS5+TFqXygnLakoPYWcpR2weiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173761; c=relaxed/simple;
	bh=nCy5H0yYPO0n7/jb3nTGCKwYSi+iROuyCfMWemB6VAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sY8oe5KVXsSRXyHlNvjJVQW0bUQ/Snayfzue8chd8i6OZm1xQJYDefoWDLsfxr6GfM1y1Pb3UYEOWIfnB6uCTqlbYHVLQpOTbtgQH08dNzMWe5JrKjdIdNGDM3BE0G6wzThzEOH1umjeJbftl8VAb/xBNI8u9kLP2mg1LwnlvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pV6KNqea; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV6KNqea"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a765f47aso763785e9.1
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780173758; x=1780778558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sGWvr4odaFr/sdFXxkB9IZN4+afYuvFDh8G38c3Kek=;
        b=pV6KNqea5NvIkh38p5abpZTcJEHj9H0kFCkvQXNGmLzfdU/iI29dsYwj1xwTaYd18v
         vkgst27x4Qop6HDQ68ef1gc4m6qWjqb4HzgAVBUJNH0LKLrA24jGWDgzAs9jAN+Nq8DK
         S1UiMzeeMY0PAF3zXinNxPgDse7gWq2XE9yDynUB973IkupozRRyVowFflW0BNCo5qko
         Ggcdo837dz21x4qoVZ7UkQZCPWAjf7IAp2OI7RGTZO1p0bXhsRtuJxMzP61KJLChIE1c
         0re2R2119cXz6hDDv/uIl6BWD+GueiFGGk5q0wfRRuyxnGFnV6NfKvSVVfdqV6i4WrxQ
         GWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780173758; x=1780778558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sGWvr4odaFr/sdFXxkB9IZN4+afYuvFDh8G38c3Kek=;
        b=PKo1KxlFesXAGo1MDaWPKTMvFBEUxKebHrWfti2WzU7gzh5L/iSD0/2HL4IQbMaq+j
         vNeLeT7LiRKXMQY7L3IVY32cOsRNPlk3PGeeFM9BSAybwlRFdxxGIwsBvep2jzKR+qje
         SA4YZC8BQH7RPOvDyOBCWN5x1n0qRQ/C9Lzvr+KFgiqHyRNEVClfcybi0B5U7yd22EF2
         3+cPpguI0xUHvYJmspiDIWFB/sGhFbFVApgFGPNM+/9/anEqMKfIQpDqMM2bE1ux75v9
         UDHZrFOVptYGSMqytF9F2jFWh4T5uTHvOKp+MAJB+zODHcbP2cNyfu5EllBumXpGEQR3
         I8og==
X-Forwarded-Encrypted: i=1; AFNElJ/zTrDdYZkOIKoeQVe3PmGfYBRjtkVyjSVTw6P4D1wxD+4udCLiI+EnN5YMgTCA032+hNALmVkAHWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYi5jfwNTOZb8gBxvKL1nt9FWW2fq08Jw/xKHpcD2Y3by05Uu
	6lQyjUFObtop3tC4HDR+ROyyr8SA23F4Hz5o7B/S97TFsmWd0AsnhtEM
X-Gm-Gg: Acq92OHkxdWPz6n6myqz5uazYgeIJj7ItbIf5+pJIwtaJ0jgE+F6buuBu/gLcGwQucj
	nsYcc9OCT14zmXGD5Se3QMdY79wmDag6bdvTMxTQGzXS85HqVU3MtDhCaNWZBuaKaItM794VUrn
	lQs8f5Q8uETnZpzxXTSEtxRiWL00EsQnwZ8Hxjf1GkXHO11KRRlXIHR4y7YG4SaZ8pbZVVQzNip
	mKYQgJ+X9VU3GgmvjXSTof1O0Aa/KMagrGCzcCk0A9Snw/V9bD1dMVWRZKHq1eDNE9G9llFHj68
	ynOqdvOscx8QmLxUWDR79995sfTgRPpSnFYnFbCQqnl/VMVbPXsN7M9H+D79OVuXoWslghYSulm
	bHj/vbeqWr0LVtHoJ6DhX+USHefVvD7qIFqYo2GLzYvkte+PEgT7wjAtsiI55MnGLNCkvMYar+7
	MivtB9JJnsDZPkQng=
X-Received: by 2002:a05:600d:8494:10b0:490:47e3:929a with SMTP id 5b1f17b1804b1-490a29122ffmr64554585e9.6.1780173758235;
        Sat, 30 May 2026 13:42:38 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356a4c4sm13944636f8f.31.2026.05.30.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:42:37 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: flow: add Sensirion SLF3S liquid flow sensor driver
Date: Sat, 30 May 2026 22:42:06 +0200
Message-ID: <driver-reply-1780172596743720241-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528122244.2e408dd3@jic23-huawei>
References: <20260527184257.141635-1-wafgo01@gmail.com> <20260527184257.141635-4-wafgo01@gmail.com> <20260528122244.2e408dd3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 28 May 2026 12:22:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

Thanks for the review (and to Rodrigo for jumping in). Inline
replies, will address all of it in v3.

> Check these.  I'd expect dev_printk.h for instance.
> Follow IWYU (approximately) for includes.

Will go through the includes and add the missing ones for what is
used directly.

> I don't think this [SLF3S_MEAS_LEN] constant being a define is
> that useful. [...] use ARRAY_SIZE() for the loop

Will move the literal to the buf declaration and use
ARRAY_SIZE(buf).

> I'd put this value [SLF3S_TEMP_SCALE_MILLIC] inline with the
> comment.

Will inline at the call site and drop the define.

> Probably more readable with 600 * MICRO / 30 * MICRO / 1920 * MILLI

Ack, will do.

> I'd be consistent and have const u8 block[at_least 3]
> [...] Use at_least, not static for kernel code

Will switch both helpers to [at_least N].

> wrap at 80 chars

Will reflow.

> If this happens I'd go with the detection over the dt provided.
> And dev_info for the mismatch [...]

Will invert: detection wins, DT is fallback for unknown sub-type,
mismatch goes to dev_info.

> More than likely we need some level of sleep here for the device to
> wake up. Is there anything in the datasheet?

Yes, tPU = 25 ms max (time to sensor ready). Will add
fsleep(25000) after the regulator enable. Also tw = 60 ms typ
(warm-up until output within spec), so will bump the existing
SLF3S_MEAS_START_DELAY_US from 12 ms to 60 ms.

> How useful is the generic compatible?

Will be dropped in v3 (agreed with Krzysztof in the binding
thread). Also moving sensirion,medium out of DT into a sysfs
attribute, since it's runtime config.

> Sashiko (probably correctly) identifies that the formatting that the
> IIO core does for an IIO_VAL_FRACTIONAL only goes to 9 decimal places.
> [...] maybe switch to using IIO_VAL_DECIMAL64_PICO
> +CC Rodrigo

Confirmed, the SLF3S-0600F scale (~1.67e-9 l/s/LSB) gets
truncated to 1 digit, the 1300F loses some precision too.

I would prefer waiting for Rodrigo's IIO_VAL_DECIMAL64_PICO over
bumping the FRACTIONAL formatter, since pico covers all variants
and avoids changing core behaviour for everyone. Plan would be
to send v3 with all other points addressed and respin to v4 once
PICO is in mainline. Ok with you, or would you rather see the
FRACTIONAL bump now?

Thanks again,
Wadim
