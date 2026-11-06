Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983496;
	b=YKexliVEoKuALcIs6rXFAchmTTS4jpiDluSmQwk6dh29RlhJqonm7eL+NAFLi9O08baH
	 G4tFLc678prOf9XF3a/dcMRkbx56BvibkajqsDa6QOHLbGc/Jy1E7bZOhdVtFStQcRt4c
	 lshXZnxqUK3VswBgZYvSCDeF/O+3pXGJ6FjBOeVHYxG3ahAxyKOOZ6Yw/DBJT3IvMnvHC
	 5E/ICtG3E+NQ8pEMX+snWXviEzbONY9x9IqEIRzGIkIUAtcjs6e+9AsE6NF6sWQEutlLR
	 Q49H9/y5OeHmbB2Peh4DkU2rw4PoCGXHA3xk+vWPsN52pD0WYCRm3Ojvy8VSb/j0f9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=AkkhwWikm9vacM3XjrJcYU5w9hh7TbvHGqZ6r0PhUZM=;
	b=dKsV2RjefkxI53+TM7bLj3wS9tyWGHAyt7x2Q+S6UzGFfthla3olWgYMcV74P7t8jik/
	 Kmk9uwt2qOkVHpXRu0bxzYsljDA1B67yknscgDb1JzMdMA6HnzWGcYIj26QRIxvU0LWu+
	 TqDrn+ob27HXfxZaJrfn2XmjoUKUnrphV44Ao+YlMob8DF2W6wgx1bu5Ex1lG65e8Mv/e
	 eFc9qu4AhBTguQyx7lOyTj5cTJ7/Hh94rPTAl9WdDDEbJ/YaMgUnqg7tpsVxPzxhqhVBD
	 R1gtneVZ2gGnVL0Cmg3CV4HQ+ojg2gcv8rfmdMmByNw+IJlU7bZwUgYOMeqHCEwS0MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OP2qMBHr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B1606A32F
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 16:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B75B1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OP2qMBHr
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df4f540ebso540095f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 08:44:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793983494; cv=none;
        d=google.com; s=arc-20260327;
        b=rjwYcfvizb3UmhE0mQUsOZsL8nAkZpXMraIPXkw6IeMTfPTH+yyZ5V2u/aTxINocEo
         fk2TS8xgcTcIacPJexVP5kx1R5j+HmF5uS1TKQGQuDbVOmX3hioayBGh6rIHDzNFca40
         PjcimkKy2JVbX28CyJ3SKRmnFpUl5uxnkc/mfK0AbXicNYap9IsjmzRdoRpiPjHqBDBA
         sH1y/4qZhNKEh7982nroJqcf2+MbHiFV4jaWDR77u7L0OZaQRWjYxyNpzo4119L2c7H7
         YyGmZSkjtIHHntAIH7KSxAI/HXJ61g9i2pMItq72buWUJqaRgRiLIqjNQVPT7W2rJ3B5
         QPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AkkhwWikm9vacM3XjrJcYU5w9hh7TbvHGqZ6r0PhUZM=;
        fh=qm+ffoan3cJHobsP4EfKZyY0GQ45yXOuOmw2zxlMCew=;
        b=eNks99HUX/jXRBY1gHP+bXlEW7ZGOFoRWpMD0yeBnUISa6tyZ3KEhc3PF9R9k/FHiF
         tiQ3NFp6nwAMjWiRsFI6r6bPwrFcuaW88UEPrzOOHWHlz3aQW5s5MwEYei1BaywboL7T
         fUP2yNve8BZyOjkqqiW/82V9a3yeNhzNY7sLWy+WWr864mZV0HRHthcjE2reGk8S77MC
         ydRyfS+6wJmIRGQc3kbhYzF+06JkaX5Iv8wdtoSSoOAkQnqn50MefE1iklS6VPcs33fY
         crnoD8agk3hth9PB4aQRWNzwnhaP/sOCFqACWUwSZrsYDwWPdu5zSu2RAbkHXFhCzKI3
         0HIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793983494; x=1794588294; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkkhwWikm9vacM3XjrJcYU5w9hh7TbvHGqZ6r0PhUZM=;
        b=OP2qMBHr9lioDRKtgRhNaWh39ghwFAMLP+ItBQRdo487l9X9yhOL7IL+mgxh92U3XZ
         61z8LnXQ82zOha4YmDzQFKQhEo2kg8C/aH6ISUupAn1DKDNbSk4QFEU+n/a5oykVQa9h
         9xut4hz/rU6/+bZjHzEHzZpdmWFZvw2nsFR88JeoM+cCkCvACENCixwemQW27gWTSXCq
         97IvaV4lP6bTIj0oafsxfNJ8Wi323YAR9IKCKxB0QRHc3uW2758LP9Ji/NGC2lwwetBQ
         Tvn+TVJ3ktAVJPs6XI8YbrxUcr9PnzAibMdrmW0PeEAAWdR9OS0UNVD5Q6pIx0PTO0VD
         yqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983494; x=1794588294;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AkkhwWikm9vacM3XjrJcYU5w9hh7TbvHGqZ6r0PhUZM=;
        b=hL5t90Hqika7TyPgRSZAHUtVyp+lYC/+8LFctlJee5A4fTPA3CkjW8RagONkddDGMq
         dgPBJt0XFSmY6UlVVTdUaNyxv/ATjIG8XFSIkcSRxXOoRv6uU+8HPJxrQX9jz21vU95h
         qwORN1PeANALr3Q0BaTiUQ9qbO5Oe/9J1ogI2WO6Y5/rPfvWKh72DeKYwT4yrOd4Do33
         /9oogNERBJP3Zd4k9hl68HmEvBj7agne43iKTOF0xjznffJwUOiFtBJ82tYzyYPDUVgX
         OYd9GQfgdY2ya7n1NzcOlJRZ7eO2nAsyHwC1IdeNh2f7QWJYmGlKGoESkip6eVbteSA2
         E6nQ==
X-Forwarded-Encrypted: i=1; AKwUvByJECKJFemVEnNO36UP9732tPe/dtrV1Lk8zlK2blzMBJzS5EeP70Rv1Vz8XLFmw+kqC2nfsb2j2KE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eWcy0umOabPdIeDhMMPT3fpXS9cp8dwGGGJBtiqb3JMmMGvXO
	jjpGQwfDm1nPQbyc2MI5rZvw680QNZym3Dvvr/Vvswz+oQv4zFM1j6pMMqfO5gztCPEqnFGf0UV
	MZDV8TCtTt24rJA/aUSFjKSzmj/W5ab0=
X-Gm-Gg: AYBFou26RBhWGWiebHmy0/cKShQkhRWpiePANjEXYq9eP09x9JLXX39FqCZu6MTdz8t
	G1Rb7sZQcx0vv9F8wHHR5jTZnCud1qDxsJdbS4vTSd3CqTMKwF8iy3Ore6YLn7niLg3CohwZa2G
	qUhQxWj3l7yw4p0V1hWgjOZOSEqtZJJAAlnPx86tOi9qLPxKUunfvgBQPQdO4voeagj7P3vdCXI
	ybn7YPNiWV5e16dbODXUwNJv1cR4p9NWj+wnsIMB/dE57V5T6MBBnV1opYwfdSeJ4iGScUCqW/9
	Hh4Jxsh0bWAfMGT0+JAue0AZf27WsgCW643AcckmIq4aBleZ+BZfagUeytZOHPWo1pOSnuYe04r
	2hchceKMZSxNoirWpNpeux/lYk74DJ1V04J5EssJk7iG0Fqulwpa9bgxY0K2Lq0AMmsj0Qw==
X-Received: by 2002:a05:600c:34c8:b0:4a1:f90d:6f4c with SMTP id
 5b1f17b1804b1-4b6de4a6eb5mr56702895e9.7.1793983493852; Fri, 06 Nov 2026
 08:44:53 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tle493d-v1-0-3246e91e6394@gmail.com> <20261105-tle493d-v1-2-3246e91e6394@gmail.com>
 <20261106030419.23ca9b26@jic23-hlaptop>
In-Reply-To: <20261106030419.23ca9b26@jic23-hlaptop>
From: Viral Patel <viral8854@gmail.com>
Date: Fri, 6 Nov 2026 22:14:42 +0530
X-Gm-Features: AclHuK_XeKU_SPo2lA1aZ8rEbHQTHoj1b1QTs8FYVvCmAA2aREqqEIZJNa0RqzM
Message-ID: <CAFkCdFyi0GD9aWMUZfx=QrZMg1ezjUDCdRr+LTsD0JMMT1DeiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: add Infineon TLE493D-W2B6 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 03:04:00 +0000, Jonathan Cameron <jic23@kernel.org> wrote:
> Seems sashiko isn't done with this one yet ...

It has finished now and reported no issues on either patch.

> Use FIELD_GET() to extract the 1 bit values as well.

Will do.

> Why do this after setting data->regs[TLE493_REG_DIAG]?

It's deliberate: the cached Diag holds the frame counter of the last
frame read, and the next measurement waits for FRM to change. Updating
it even for a rejected frame means that frame is not treated as new
next time. I'll add a comment.

> I'd be tempted to just hold the lock a bit long and do the simpler
> case IIO_CHAN_INFO_RAW: {
> guard()...
>
> ...
> return IIO_VAL_INT;
> }

Ok, will simplify.

> Generally avoid any use of cleanup.h magic in a function with
> a goto.

Will switch to mutex_lock()/mutex_unlock().

>       for (unsigned int i = 0; ...

Will change.

> Is it same as SMBUS Quick?  If so use that.

Yes, the reset frames are Quick commands (read at 0x7f, write at
0x00). v2 will use I2C_SMBUS_QUICK and skip the reset when the adapter
lacks I2C_FUNC_SMBUS_QUICK. Note 0x00 is the general call address, so other
devices that respond to general call will see an empty write; this follows
the manual's reset sequence. The Pi 5 controller doesn't support Quick, so
the reset was not exercised in my testing.

> Can you add a few comments on what this iicadr is for.

IICadr in MOD1 selects which of the four addresses the sensor responds
on (User Manual v1.11, MOD1 and Table 4), and every MOD1 write includes
it. The manual's write example notes that IICadr must be kept at the
current value so the address doesn't change, so the driver has to
write the value matching the address the device is on. That's why an
address outside the list fails probe: there is no correct value to
write. The ID check is only informational. I'll add a comment.

Thanks,
Viral
