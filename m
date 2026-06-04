Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2923502B8
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590494; cv=pass; b=c518nRzUqToR27BePI0dTn5TUde5uuOiV9AKoYWMBxBFfb1csRparkzTrYPxvW1CP8b9xAK4UDywOMFVSRgyx+w3ukJCz4RCgZEg1WI4gUigEH2IpY8BE4EiulrJjhlklAkP71EIkQqoY8bnzPnXr7VJATXZF7EXIQCs0PNj9y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590494; c=relaxed/simple;
	bh=jYNQ9pKUs5ZXuflPxI1p7tlZHKEY8KvfKZaQnDmMflw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF2YK6lDExjMF0v2IUjG/vtiJ8ISCNdvw0jQAEcK1Z9npoOxJg/jKb68AiBltEdT0hTDI3ehEMH9sOGoYrKaKSvc6uK7nqPtJMdhCAOm/+Vc4Zn5XTwNKYQuqDzgvLP3cUrokKL3h81P3gwqaWtHkcBfpWry6oQItYMMufqMC+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SuV7Ltrs; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SuV7Ltrs"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5174a3a025aso8713111cf.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 09:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780590492; cv=none;
        d=google.com; s=arc-20240605;
        b=WNjE4XDaw7vV9dMQWxfmRhfSH9tXrhkkp/kmCbafjkgWUelUs3EvfwL12QXYjt9wc5
         0oSut8Cxyaqqi52AOSUrMWoi8L1iFKS3X8UDTled0Iw9VfCdjMyWlWeQg1+RkmMrjsX3
         puZZnzJ3S/9wMIjXyf6Q5QxyzLY/YTCtC4gorhNk6wUR/Aq4sh/pz6/LCz8pDQwQPBIy
         jjq7UBJaok+ZCBr4FX84W/T2tBI+GNob4iqlaeozNocCxO6rc4GvywnLDHvqp83rVWFB
         kZRJNytrB7nKZYSV/AxhvYM4t3MahYvY8HTRG2hsDK59dwGb9NVYVGTrAFAEfsw0wtMQ
         AmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYNQ9pKUs5ZXuflPxI1p7tlZHKEY8KvfKZaQnDmMflw=;
        fh=AfQ17D90haVpw3SxSK+OAz9NXfzpye/Op4pZ77ivblk=;
        b=YR2VeX4iqziFobQHIFKaw2I6arNRGBSPaKvfGVs1nACIvAjouTftyqBcH7m3Dv7jej
         sVHE3EZzgo3kWAmEr77ZUdbHberTTctkVJvnc6eej2/I9gUZ6mUmf8wwUKT80SLXPIX1
         Cektpi/oj5F2kffeB7qehE2l4h9KVH+97uEnfb9x2/0HHuOjb2cou1Zh7r34DfiGJMwL
         dpVq/E9sbJcvYs/y/o9A9L1xD2N25K8ou8Y6aYk8OsbVb3e1WJrP00RsgRS1HVKXmSkg
         SzPvId9jloiqSzDxSXkg0kQAHNOMMSbPOjYfhOb0QIO0wV75PYfXfAmZeJ5FSnh3qIJ2
         Kffg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780590492; x=1781195292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYNQ9pKUs5ZXuflPxI1p7tlZHKEY8KvfKZaQnDmMflw=;
        b=SuV7LtrsyoDCr5t+maKK+Z6mD0MBpX1bzK/btoHSrkQaLrfS1AcAGPT9sbDqidQj/l
         gl4ONlrgto7FXNmwQFHhmB7n+03mRzFOfubiojpSKsQGGHfT43Zz45MVrUjJmX1ZTNUL
         fkxhJm8/pHp+IzaM8xYhZJJcIVk6qql+yjKBaXY2CeDmonu/fWWiaQuDnv7UkbTxOAOZ
         CAgWYnX3GpYEiZgn0F8vGYxjLX8qvbcLLkodbInXc6Y2d8Ndctm7jj/OjML7yIppOkF8
         kOeZmGxonPEJgZj2W6hAbeb2HfsBLadVBlXwDMk9Hgxu5VP4sIRopM7zFPpiYLdP0WR1
         +JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590492; x=1781195292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYNQ9pKUs5ZXuflPxI1p7tlZHKEY8KvfKZaQnDmMflw=;
        b=QWKcTH+1Q+JzXCvdjqpetrFP0Rcf45TEONQgkgo74g/Fxc/PPL5IVh+/3slU2rww6p
         9ErJ0vTZLj9npy/8xI27WZlmtFuX7pmXYjIWIgrdI+TxYYAV3cd2d3NzATPRt+LDzuip
         MFuJswiWdLAGpKEyOkrTFASGtTyoSaMPA6fM0mBB4ITAz1TnwtF7OfL3bYAonPkqnGMr
         FqBvaDBI75dzivIMva0JKbQRVUZoLrcmHWPo8XkLJImIlt0yxocQVqGMN+eDlxq+up85
         PwGAW4pCln2yRPsm01oA4NZRZnEpzw40JVfaBRfIfz8ZW3Dr9kkt3Xh6e2rFh1UvhFnI
         lMEw==
X-Forwarded-Encrypted: i=1; AFNElJ/+yVmnrQ4O9qlibgGiiGWUZZXL0ETy4AeMehSr5ZjZPKTN6EsbGbpo4k4GgaketJsYxs21kaXH9Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3WbHJXTCLSwL3GteN4gFU9YzgxYqiKLC/8Gkf6ERiRxPKOwIo
	CK3ZBn6/x0H9Txs/pMd2ueVFOyiNN149Mz9pJma8P9KWWQc8gYk/0F3CaBgZkbrAPGiQvRpqdFI
	KENGFCw/k0Nt6Htz61Z3aOWHyqCJRlwEB8asiPfOmwg==
X-Gm-Gg: Acq92OF5SO6LXzwvlLz2bCr7hj5wIvDR34h055S2wc2jyikKFvLQp6NIA0ZVFnSyBCY
	WkpIjaBXZphBI05/0jejZSRFTNMnf8xr3UeUvd7Yg210XJGomh0TCf4GQTHpmBAhR0TzAgwNvD1
	uzbG+ZI3IX+zrFZHzRauoVIPryQyvl6Yb+/H5JXy/aQJH+zIRXfDgMiNyKw3vhh86KXwhlkQ9sh
	DBLgWfJOCqLr8lvyDhopaSXqEOesYqWkZxXZkdzwj/8XEMk/MpdHStDFJJnesw/UsV9lzGSPZdZ
	/B6Cz72dWYuKyvKnDpdG+UQElFwnLbnANhVDzXQsan30xhQwBg==
X-Received: by 2002:a05:622a:d08:b0:517:8353:3496 with SMTP id
 d75a77b69052e-51783533d66mr79560471cf.32.1780590492160; Thu, 04 Jun 2026
 09:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-mcp47feb02-fix4-v4-1-cd6ce03749a4@microchip.com>
In-Reply-To: <20260604-mcp47feb02-fix4-v4-1-cd6ce03749a4@microchip.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 4 Jun 2026 18:28:01 +0200
X-Gm-Features: AVVi8Cck1rBHYjLrPjGxlfUmW5duccf3KSgBHPk-6t7kxEgR7LfDq0JAevi4ub4
Message-ID: <CAMknhBE0udo56sJMzXdqB3+r6JKtsfTy89-V+37vFqnE_GfejA@mail.gmail.com>
Subject: Re: [PATCH v4] iio: dac: mcp47feb02: Fix passing uninitialized
 vref1_uV for no Vref1 case
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:47=E2=80=AFPM Ariana Lazar <ariana.lazar@microchip=
.com> wrote:
>
> Ensure that if a device has Vref1 but reading the regulator returns an
> error, mcp47feb02_init_ctrl_regs() is not called with an uninitialized
> vref1_uV value. Also add a device_property_present() check for the Vref1
> supply before reading the regulator.
>
> Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] c=
ase")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/
>
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>
