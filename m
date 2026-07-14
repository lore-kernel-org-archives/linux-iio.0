Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2433688A
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035623; cv=pass; b=DrY4SWLLKvYwka2vylDnYbqabU8kkeAnqK1VZmMu9mZOHbalUUNVZDeoY4I0iBNyOpI79nmKFOyoD665QMPqUIOPs3VpvPwr8OgbqCK4xjX5guETq/1lZ3sb7En/Sz5he2nRNYNaLNsRQ6rYlM/pLA5UwEg3/ECOwAez0VyQZC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035623; c=relaxed/simple;
	bh=nO1TZgVYGZMERjIgcqsTAqDB/ZWtf6AUfRwRoLJPVvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQpjbf+jGUNrchYLm0YO5qaVpZESLsxYdPfPffObS2XE57xQqbGH+pLACgT999KcG1j7KlZ48uNCc9wddSVZmcuJTnKTAEKB9+cNQntUG5N89oJkd57nfIcEU2MKAucvwrCy2LKqdfIn93LC3z/VkBghLlUOG2hzTk2FGKbDBc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZf1aXd0; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZf1aXd0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848d21bbaffso3254037b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 06:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035621; cv=none;
        d=google.com; s=arc-20260327;
        b=cVAodLplAStsqiW4cgvqfkDTRlBLxbjH9yStGuM5LcETBJ6cwHXAv52v/Kn2VOs0mf
         0CGrJ3wOKNEjLyy+dM3/u7lhM1b3w0zaOnpxC/Vvhx7ONsdkoFHyoKm2is+Fz5j9U+Mx
         pUdWZm58b7XO49AVie1To8FgUHs8dwyzJ/36gErCDGkMsDejl2j6BvQLkpjrMHI0UF3w
         wOdzKuAMWelIooChGsmK8OsM/mYdsTm7yyfrQ460EeK3e3RecYoQj2Oqrdk95sRSpREO
         VvAR3UF//WM/FND4HW5T3FXBfW3+blHG6uDejI6OWo86/z9mAHIM59zIqZ7LVoSGrvmf
         8beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nO1TZgVYGZMERjIgcqsTAqDB/ZWtf6AUfRwRoLJPVvc=;
        fh=X1XNngYKTIz9b1db87xXFwESCwEibtc5g/uTa3erKmE=;
        b=VR1+JrWgVnKLEyF7lbagoI7l18K3CGa+MjvkDIY9+KySL0geImz0JAcmDcUSqK/zVK
         zxzsDqk7/mQrnuFH/3o/Xf3qjMzwmLcRpWycBdIDSSFxE7bqLCQPjjgqg9BsKTYWkmYu
         uHLos9+nAuqSIHqznDTzP5HucG73XQyJElYBe+8edByNJsyTcruP5iOx/tKNrf4kyysK
         vr/YeMa53MbA/HG8tvrHM9HcsyuEaRvAlI3eTcr+IQiAEc+md/QLeHNDABgo+KwSm+00
         vIomDEucrEMzEnzbcxuvgsd6yY+BL/bEO933uP+RWQWSslALO4NyIj7vR1Dt/ytGElrz
         ZQxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035621; x=1784640421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nO1TZgVYGZMERjIgcqsTAqDB/ZWtf6AUfRwRoLJPVvc=;
        b=LZf1aXd0NDZy+HyoV9fvHRsX5BLLkFdBKmoUP+hsams104OkhJru3dmMG/oz6E0o9P
         0rBAvVrCSCSIhCrYr1gNqDhOAvm3PLyO58snWKTApbRtlPeiTym32NPpIKOblXD7z4Au
         XPt5nXHEqkOwfqPqyrJhnwospmkSKWhwS0H/L5pvhr62cA74ZAcmldmq8cvN3/FhWLda
         ubfOxB4awH73kFJIDmWFoVzv1PT8p7cjjTzZTp67yTxK32oHIm+PEFbUlkuQtf0pJRUo
         ZYu+Ih1/KqqwSaHohotBUtpxiEb1E2iGPgYnM25zKGGTr25K0BBTuVvChnaBs+5J/TMp
         A2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035621; x=1784640421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nO1TZgVYGZMERjIgcqsTAqDB/ZWtf6AUfRwRoLJPVvc=;
        b=E0JeCIlPbc51opHQPiWeogbV1jg7sEVER07nxZbTmrfi8iFhbfHtFQIf7pqAy6lFVh
         +QDIguncaIDTfnsRuYTccVGbQow8yN6wZlvgRKjE0Rw0MDJpoJGk7HLBMdFvJMYrLlTj
         2vsnmMLkPE+hs4mEUADs5NBX9FnpcKx9syCqgsRrf8/0oaonQWwuoR3D81/2oHBxXgcG
         J7CFxlyt70/78XUIkGc0ZxNU63r6M5/ExqAZ+WeYhmQrWhTLjvf2Uj3tAqNX7bQxHBYa
         ysACP3A5qozisZ24/2mTBRHdHzKh5JHEc/GsuRfZeMkmTI5z4EGYInvjGDt0s/cYWdY5
         GOBg==
X-Forwarded-Encrypted: i=1; AHgh+RqN22rm4alJMvyvaebgkFxUovJVtnh5iSBpV8wylGOmCgI8nsy3sJ/Szximp7Jqtkij2jjrjxg0Vmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EtiwdfK9sCLIngzrA0nWNxm81v7EF7vkhpBAzUf6xChfG17u
	16n8YNzBthzwr7wRTBu5MzeJCtciurzAdmpIYYSMa8fTJs4KIJMX8h0Jf7/G+5wHIu0fiMCGuYv
	f8fZXVYMS1e22S2OA3cZX6bLCjjqNO5A=
X-Gm-Gg: AfdE7cka5mQKNobDpknejY5YHJZqpjo00pYESEBFHQW/2jH37EKvid+mZbNTUUO7CuP
	BIV1Qm28469lZDMLQWCnOoQHYUaiyqt8d7EJ3x6DHgujJMICWeNGnd6EzYqx7zUw19EK/fpDd6b
	QX88vPX2r8ZcAcuZRpLKUwceTtZHXpkkKepzVZRnuQFCwHX14wRNNMpHbzCUIkfNahIyuHNC+by
	MQYEXM2Bb69OkXP+o2jjJsfpcdpsnqUo1qsKbjbIHWNzqTY8L00Ma5f3s2oOfmrKzx6aq62aq8T
	AWASqg/KtZmrXMwmREmWGUIbybysgg==
X-Received: by 2002:a05:6a21:730e:b0:3c1:279c:526c with SMTP id
 adf61e73a8af0-3c3576426d3mr2584439637.63.1784035620851; Tue, 14 Jul 2026
 06:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-3-clamor95@gmail.com>
 <akeEd0GcHSqScGIl@hovoldconsulting.com>
In-Reply-To: <akeEd0GcHSqScGIl@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:26:49 +0300
X-Gm-Features: AUfX_mylEu9Yyzm1iZHwnL_3qQ4wX-qy21nMalz6S1BYQvhN4kmLF8d5IT5che8
Message-ID: <CAPVz0n1aYREgo9Mqb2fioQKTKa478rhMYPJJjcUagjCGNTzMgw@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] mfd: lm3533: Remove driver specific regmap wrappers
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:44 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > directly.
>
> The commit message should explain why you think this is a good idea.
>

Removing custom wrappers over standard regmap helpers is always a good
idea, that is self explanatory.

> Based on a quick look you lose the errnos that were logged on errors and
> also the register debugging provided by those helpers.
>

That is not true, regmap helpers will provide logging and you should
not include debug stuff into the final submitted driver unless you
have a extremely valid justification for this, debug logs should have
been removed once the driver development was completed.

> Johan
