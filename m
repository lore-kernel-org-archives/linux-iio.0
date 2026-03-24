Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672BA3F076E
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372858; cv=pass; b=ItOwB3NxEZktStil9CIUKSOQz+mwFbIh6ImDcfBYyBvsSeVckZs5sXMYU1A7kKZwkAig8Tvzecgf4tryYql2RBbznRyOwaxJTamwwFop1jQtIJRopj107q5O8n+lzGx+jMHe8H8xcG4tHXZCxuYgbwp5Ppf2yoLKqIiEoQ6JLb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372858; c=relaxed/simple;
	bh=WCBe6xC/pB6p+aMNfwKmK2EHutkGGduXZX/L2BqsHYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVYkcE7rjYh8+YjDxZILWO6fsEalzGZh64nvsJ1H858FwO4EAuNTY6RW+ewMPDG4eX5YWAIp7/pgFgBY2j7ecAAiK0XNzYl2oJUk33ABT87zQHUKhqHH44MwoOWKCxSULeyNRblXb2p4NZNPV8W9U/75eXtWUiJjsSA/07FLm0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/NlSpte; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/NlSpte"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-799001d73bdso13586517b3.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 10:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372853; cv=none;
        d=google.com; s=arc-20240605;
        b=Re7KbcUNaUh7siVUjZGQzer+DbGubu0kYPeYo3uWBZSUEc08+zgIMAB4oUQmze0nvj
         W0Ozci4IPqM0DcRFwa7OM5r6CbgxHubkIPEuBwLXM0sqOmGMLKrqhomKCHrnzDCzbE65
         1noW7+5fKR4ILzWgx0ZASCPVoCUQGQS3/UGx0+p+GGO0Vm8FRE4HTM6DP9VTkwFFDEyi
         ExL3Bm6yAnlUbbBVuPJjYFjDHg2/ktELIA7TaKcqQoai9/7Xf6hmsDZWN70uNc8wHzil
         ouTjUv+fpoDSLQtDSn6hRYTZTmJqCEc21sGyNusTz+S8vAEzBRQf9uahFAT2LFH+gSjM
         EZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WCBe6xC/pB6p+aMNfwKmK2EHutkGGduXZX/L2BqsHYE=;
        fh=t8POMALac9yIkdVauzstvk9o9YjR5pDBl7lljz3rAiA=;
        b=Wx9JewZbmCuG/9vZfGH8Wrpbd1+A0NqgLple7tLIVr25+CKLdlYfkQRx1fPhcOEWcU
         UPOzM94ZpREKvPRKSV2pZ/nx1n+N54fOIlG6KfcJVu1ZEbHwe/s0aGd0pGsI4/pLIdFX
         uEMFK8JqJgObS1259JCZysDl4DdyhAY2Ohds9eSggGyR4cWLqR8HpdrTgyNgEkhpfU4f
         UGcStds4qD/nZeLAxHxlrLuoyO+MYg99QnWhQ4XPL4k9hmhlSZJDVcjIIkuGWdmS4ABu
         S+Rsdoeo+7Io+o8AYP4avJGieJKnjPi0T1mTONbUUqEFlJhN5oPyg8fS0XYdANn1g6Mc
         vxLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774372853; x=1774977653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCBe6xC/pB6p+aMNfwKmK2EHutkGGduXZX/L2BqsHYE=;
        b=X/NlSpteYyH81K4nNxjpxDMygjfA3azE5w3bxcFhtg3iHKVTJkrTGfweRDZNTUI8yZ
         gStSGIhvDCye/J7YUjIQKW6W2OQnpVgsgd1RMF7lLXANb7+ZZwuPPwuFAMniw67XIzVx
         2Wh466gpBlHnHYW3AZf3urUMS639JxXL3DH5oEIfVQpCIfffqMDXhgeQ0tfdCbnChhWx
         cN+o4z5zUw7pfIizLwraSm2HIB3757WgnYa9o+RdZ6vVvNgPDqzC4Fq6TZ8clHeN9I8B
         p3rEC15M8djfkE1NmQHJCADkRLocXGFIKun3I5xCRdIvDk/0KYWNFbkLOBufATev03Aj
         DZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372853; x=1774977653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCBe6xC/pB6p+aMNfwKmK2EHutkGGduXZX/L2BqsHYE=;
        b=Y69+XX73M5/2r/jKmKZdlUi1eQw3pkxfisW7KE7X296ADIhYX9+6kfxF4SbQaKJSD4
         Y8Mw1S82DbO0/wNvAkgsDg8PMm0Jttsysxwbv9fWrSy3HPa4p1fr8zDIhpWDiFCoA0Vx
         M2BZVsVx2+rm0U2EP9QC+u8JIPs5hczkFZrk5Q8Bg+tR5a5oof6xfxA6bigRwfHCUeJE
         fzJPasTGMX/KU8hMVW5KsFdsc6FdxtHaUpNevvQJWs49xtv7xo7sCxEmZiCSUCHKYIHd
         fzQOr456y1KHA8dPRhpTCI/W6Zd9joB+HeoDQsMrBWrtMBNyqn7N2uB08/ATDwjOiVnJ
         x7sw==
X-Forwarded-Encrypted: i=1; AJvYcCWdXHzSY/9ZVK/+MCnVb7ko4fCr/pLkvfgCxb6/Hc8E7LybvRjHPNMQVqK0I61H47FRYHmvckCpsAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgozeidgF4ZT83H3XGWAm3JG+Lm3LkgB6iP8Z9Ai50ZObHPZ3
	R8aZBJmhC784k/dzjbeaAYLc+Kd+/Sk50qDegEG5Ajzs8DRBGgwXB5xeGTtT3uB8OJ8LFuUg5fF
	Pp2j1EjH7EzWDh/8AiSM7eykzlHFgc4E=
X-Gm-Gg: ATEYQzyEz3hmf3euhmqNBXU0Wj0PlAemsn6+XtCJ8w0T15at0OxIaN3LQ4+8G0l6aKF
	oopGC9zJbXhs8CwHAItRalvk2p/OGuHscwDrIdR+PUcIlgyiKkkZuNHJINNGfF1++CwL8Lsjhix
	U4d0qbQh2w7TYcQLipMMcAPObqTTUlRyM7Ef3srtx2SfXBwuJjGiY0q+jmuaGlrUj2AIo5cWq6L
	uTCEZtFRpetok0KWINwsmkvAih3xqIrXWXBCj3Ik4JaE57GHMjzsiPu8Akym6e4Tl1Pts0lB2wQ
	S2AHp88sqc3t707jQB6o2R9sC+WdH6C5cWtW9N44mOjS5D6BLIjEU6iGMct7uQA88SVp2jU=
X-Received: by 2002:a05:690c:ec5:b0:798:138c:76de with SMTP id
 00721157ae682-79acf6c8528mr5404347b3.41.1774372852853; Tue, 24 Mar 2026
 10:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318092715.42538-1-architanant5@gmail.com>
 <20260318092715.42538-4-architanant5@gmail.com> <20260321182710.1621d1aa@jic23-huawei>
 <CADJHxWADo9rA8vt6EEVLXSBb9EqXvyBg=L_YmusaMdtRnOr0rQ@mail.gmail.com>
 <eaaee132-d5ff-42ff-9f68-5d6736127caf@baylibre.com> <20260323175519.00003b58@huawei.com>
In-Reply-To: <20260323175519.00003b58@huawei.com>
From: Archit Anant <architanant5@gmail.com>
Date: Tue, 24 Mar 2026 22:50:41 +0530
X-Gm-Features: AaiRm50fVU4XvLJ1Cao7roR1u0mpa8WhOURP1OasnKa21QaZVfaQKrpJ8vLFHLk
Message-ID: <CADJHxWBXTorkb2BkhsjFCjN3cL+QcDKGg9urQPUou-d2r2TktA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages during probe
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:25=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 23 Mar 2026 09:39:44 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
...
> > We can't do this unless we can be 100% sure we don't break existing
> > users who might be depending on power management working as-is.
> Yeah, I missed the use in suspend / resume for some reason.
>
> Not much we can do to improve things :(
>

That settles it then, I'll implement Andy's style preference changes
and send a final v6 shortly.

--=20
Sincerely,
Archit Anant
