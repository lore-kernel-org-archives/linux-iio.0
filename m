Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E32BE02C
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181632; cv=none; b=NiJ/vVzBR9g81iMt112XJ7d4Go3xNV/3nokqaG4771HWk2M0goU+wC+sIjq9On+L+O6eShs6rivcPRgEcnw3x4ewIzBy+ATSW3LblaIz/GCWoqfuyhhz908z2eEEN7QYQZppBDe5tvA2TftFbgDxlBXQCSZCz3u5MraVeSAJtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181632; c=relaxed/simple;
	bh=2rPejXcedJKCMo8/yB/7E15DR/CbLvfiEl5cvaXdWWA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=D4OUZopQwWK+Ud0XYfn97WCNtiF0hJHmieb8J5lX6KB8dXgIrCtcGgdlBPaGLzInk7qPpVIyIEc6XzEUlSWl7EbhOnzuKLAYTtY3j2KBS+v1ZoJfRgWH8RYO+JwhhcsmYFkfB08vWg6yQ4jia/YO1o/Sga4LAq5cvGJUaRIRD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGR3KZQD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGR3KZQD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so26723455e9.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181629; x=1788786429; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2rPejXcedJKCMo8/yB/7E15DR/CbLvfiEl5cvaXdWWA=;
        b=eGR3KZQDHhZy+xEWHVvuPHnOapxuFIxX9oewskArZMr56KToVmqI6s67vg3yp4PXwO
         L3MdwSt7qtx0Ey7coZjOnaXxCASvNOMi3HZV60amCeIzUdgyhVUBbCMy8sKKHABfIDCo
         H954YMp1Y+myo/YQXyhjFWhPZbuUtbkjQbPKBATYRXGb53ust2qGONxO9ezqparBNl4c
         2aHWoHP8J87imRlEPzFX7Mf5qskCv2RszofqpA8DE84ailLqTTzZCOyAkdzBqmvT5y92
         BLyX5VqDIImmCrFl93D/iq3ePZ1bThL30mjNUQxpwkRMeh/G1yQIvstF8/eecnpIQ+/J
         UdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181629; x=1788786429;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2rPejXcedJKCMo8/yB/7E15DR/CbLvfiEl5cvaXdWWA=;
        b=GZZBWsagOkkw2dZX8xZq51oO7IGjkC8YIjorl4lQGhfTckGwxtLxRS8pTR7paxJiiE
         1n6S6zfHNB5ZfogiL3MTclTWLgzfB9ya8qZR2Z3+R7vD2pLO7w5JO0yw5q5173yaJY/K
         zI226GZ2RVbPMgsvbNIx3xT3EorCEEqnsFW0/6zlRPAlO1vemugTux3lACIiyN5r5qp6
         S0HnHZ77hoX2BmJeBAVu5CFo6FQ4jAUQSWL+QESTMa5gfJVV/l2urCmDAo4MVfdzJfFu
         aDtBufO2IyzNHVvuJMVkCWu3yifCi9LYCcedgLNGE90zFLvQuMQIPAAaRgzpk/ZEjHY0
         SuyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdVN6ff0KfgPAZCGQUX/Ek3HkUKmVzXpzlcfF9lj898hTM//abT7T+/O0P97zBcP+bIA8BwNZZVp8=@vger.kernel.org
X-Gm-Message-State: AFuF++m0IQfkPWutpPHsUW3nhns/2kRQJBrzIOgsrKcCzaIaBfwWWHeQ
	vRAfuZIFio5otN15ob/5FO+LLmCMvTrLtrWsxZpZ2FzI1M3zFNmIuVkQ
X-Gm-Gg: AR+sD12yOaZepgGXdCUDI8Naz2lhE6UrPSipYzwVsVePDpbhVREUZhkVJAfi2rBhvCE
	tToOUk8ASnoSmWieIZqrEIVx9w+mWKZqHARK9nw+9oNDDk/Ii2m7xFKh1uzOzW/SGexh9ejfU84
	0QNfpuNpc7UWHn9flWOVzNkGEUzfPryhMDgazmYv7pPpzV0MQ5eKbJTZ4RWlxdzL+RlcWaUuwpk
	Djmpij5FIpR77EZ1DWiNzF8rd1hzIl2xRVV+pqAYMOJWe82rbLwg9JvkCxxE2v5GVRSPfdAo3sF
	hNZEQsyQ9IlLGjrn7cy6GpnizFM1JNBlMauGUSNyqIwnvi6FKjFswlPC0JslivASYcMEMs3dBV5
	qLd/UA9nAul/8PeSbLDoslp5C2Kit1dGk97c/jn3o6CP7gapl4J140FqdOiuit5yTbQwkOkdy44
	UHEoI1UJQOMOIQPVHnkQbgMgo0HxfbdXgBlxWDBkF9ROpero+g2iCPkXjImLXZEoOnlDWM6gcW
X-Received: by 2002:a05:600c:4e44:b0:49c:dca2:ac47 with SMTP id 5b1f17b1804b1-49cdca2ac80mr75225e9.2.1788181628351;
        Mon, 31 Aug 2026 06:07:08 -0700 (PDT)
Received: from localhost ([2001:4bb8:128:b749:8793:c76d:302:4caa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd775dae8sm128195985e9.9.2026.08.31.06.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 15:07:06 +0200
Message-Id: <DL35HECJMI8L.2J440RRGS0HNB@gmail.com>
Subject: Re: [PATCH] iio: rename stale IIO_DEV_ACQUIRE_ERR reference to
 IIO_DEV_ACQUIRE_FAILED
Cc: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260831-doc_acquire_failed-v1-1-3c8e59c07d18@gmail.com>
 <apVp6vRQmyPi4EQH@ashevche-desk.local> <20260831143004.00007913@gmail.com>
In-Reply-To: <20260831143004.00007913@gmail.com>

On Mon Aug 31, 2026 at 2:30 PM CEST, Joshua Crofts wrote:
> On Mon, 31 Aug 2026 14:47:54 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
>> On Mon, Aug 31, 2026 at 12:09:09PM +0200, Javier Carrasco wrote:
>> > Update the kernel-doc reference left over from an earlier revision
>> > of the series, before the macro was renamed to IIO_DEV_ACQUIRE_FAILED(=
).
>>
>> I would argue that it might be good to be backported, but who reads docu=
mentation?
>
> Only LLMs these days...

And at least one human ;)
