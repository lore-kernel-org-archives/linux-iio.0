Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5B306776
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088862; cv=none; b=Ju6ThKHWe+NZ4jw8QLvkrztyJGvcTGvwigvgWk7Zdlupv45Qi4e1OcfaVmlSEC38sQf1EaK95YHySpte07ECwZWA4bvsu08k5Kuz4LDOu18RNFqm9TNLpSp0mYkxEKHN8+edgyuYcg/8zk5CbZBcJkJ/q1pMqW33QZ3R+y8gCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088862; c=relaxed/simple;
	bh=3GBgSmIVEYV2VT4SDgyGxgaPGwJfxUgy9WRxUfX/mN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3GGPrCdZ+0Lbj86mhabG2wwlG11HiBf8SX9KNd6hGMcHckSkpoONQnkxplIK9kR2ophrdh2Ckx5c6sakhv+sO2g3EuT3+wvSoGq4lMaYb5q94Kfu12S/ijyopocCWlhMfZgCNNZ48YLVmE1kZUT4QzdbGPhSgC6HsqH729IEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuGp0/aE; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuGp0/aE"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so21728f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790088859; x=1790693659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LyBD//VE4qO1En/MwJ/nVv64zoHUUCGTj/1cLFvcgvs=;
        b=AuGp0/aEXmaH3/ezaeQA/fj6sMXgapyd5GaNrqT9KCuC6oIo9zKNGs2bO/EPMQn/DV
         t45ET6yni2oVHlsso0d1RUkW7wJaScYAfRHYhXYF1QK/PLpH9oS/KZ53W5vhW3dXnLSJ
         gxu4dHUAf7bI7r0Dpcoj2WRPQvXTIAKLxDVQPwKgWXS7HwNL8fr2N8NxIWaelFuUArJC
         780i2NP7JVw5ATAs6CJ7UILbkiIen81qZbeM+wtFbosBypK08GVDwJzfYV1reE0ZBOZs
         7ngkSK4RrtSC9rYjhCc8mXJQpAiLatw4uaAuvYbrqX/3kG+m26alQmEgH4HlqQ1ZDJ1C
         S7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088859; x=1790693659;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LyBD//VE4qO1En/MwJ/nVv64zoHUUCGTj/1cLFvcgvs=;
        b=sdHw6I/47gynea3yzLs1r22DwOc5aQNvhmPnmklM/b3dMOxs81KzeR0LlvuiapF/hL
         QsCpSOHjpTYdCf5JlTeKSKxx/Un69t+alUnw5FKg7cySsP2zrTTWvvueTbyc7mmG6GIm
         22x/RCJ4UXtUqzVetb5qo7OKRp5/zX+qDb+pblV1gnbWC3CwNKtZ4FMQzVDZ+s11pe/t
         bdxhwmNKGLmkFeQn4tNz3TFk9x3V4RR6l/QtzygkpmdlQJJ68ibPB2OZANLgPWVseHW9
         Ad917e3Vt7hk7WBZ1+Ek8kbV4AJTdOqVV9BTfD/nTJg9si2EP37DtSJZDwcIXDHA+PL5
         Wp8A==
X-Forwarded-Encrypted: i=1; AKwUvBzFAKnU3GNgM1Wl8ueSCPd8mQeYgyPqGCrnf49QuWVoq2TW91mKWqPMX+e85VXpklfZ7nWeUsghW1s=@vger.kernel.org
X-Gm-Message-State: AFuF++l98BjU6kpt9EdmYpgibwIN5YqMSEGMLdBUjc9/I+lej8pAJzkh
	2wKrgGDleQyIAp8lWSee4A1I1je3+XyOEiNtOiLe0jHa5BNjPOZrMs9D9zjinw==
X-Gm-Gg: AYBFou2AYco3RvPv5qYbxZRmZbUXCKBXpAEzhl7PuV9jwmX82JsXCXiZcH3F14sHACc
	88YcQqdhuU008CjEVkfUD5H8bXGaMW/UNDwZITaIZyMpwB/v4aayy7pbrcE7zWlsVfplP8sQ/iH
	OeQdSPAo76d+0KZfqs42hLDBjbIJkyAhfMWmG4rXe/4de2UXP2qgoClXeymisWxdojPGYfEml/5
	oAE+t67VkXzj/d4bW4852wvGwX+BCMsbIimaiK1sVJNEDZzS35jOOnKbNloxE7GWR6dddvz8SM3
	MrHD1VVyd0TuJG0Lx3nuVXtfWNzVTVuBtTsabByLpHu9QnyrJS/JzyUnY02R9/V/RhhOhoELtKU
	3Lv+qGjIL8g1RDaPfmkXquLfiEuAfVNhOI0KD1SzzMI3kRyYUC39EFR+UA/ZCMFSErOZEWifeyP
	guE7Lx7pifKTxpJ2mKAwXMZ4LllOzitc+HU0baTFLhV6rAFZa/bucPaIGJIV+GQn7xjoAZtQDPZ
	+6jx4b5GJ3Y2PgiK5C+7y7Ir9k3FEt+qUPXoa/hhgrdmbkEqut5+Y3kUGM7WEJTlzzYWA4RG9I/
	9w8ZENd98Ob9Nt1PAJnbErQH/qmgbp/Jt4AsgEXnQSczwik11K4WOxlmhJAlTTGY3Rk94I0OJem
	sqQXcEoKLyiXj1tSnv99gI9fqxomrfVwPXBcop3KAIzdnlblPinASjWgO+cUUgoHME8Uh8zisLj
	O7HagV+Od60SaV31zU
X-Received: by 2002:a05:6000:2312:b0:486:f980:2367 with SMTP id ffacd0b85a97d-4871e377f7amr21063007f8f.48.1790088858815;
        Tue, 22 Sep 2026 07:54:18 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862773ee0sm5537769f8f.6.2026.09.22.07.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:54:18 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:54:17 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org, andy@kernel.org, nuno.sa@analog.com
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <20260922165417.00007e51@gmail.com>
In-Reply-To: <4c87fa3e-170e-45e3-b72e-fb1a6ee1a7d5@kernel.org>
References: <20260817111825.000063f6@gmail.com>
	<cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
	<20260818090652.000020bc@gmail.com>
	<a77309b9-7317-4d74-9593-a1f9705ccea1@kernel.org>
	<20260919113546.51a943e6@systembl0wer>
	<4c87fa3e-170e-45e3-b72e-fb1a6ee1a7d5@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 20:53:36 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> Maintainers file already defines git tree. Patchwork as well. Please
> >> read existing docs first, because it seems you propose to duplicate it
> >> (including submitting patches and other process documents).
> >>
> >> Subsystem profiles are expected to document things which are done here a
> >> bit differently or specific subsystem expectations, narrowing general
> >> kernel process docs.
> >>
> >>  
> >>> - code style - the TODO is fine for existing problems in the subsystem but doesn't
> >>>   point out idioms we have in IIO, i.e. not using (the awful) kernel.h, preferring
> >>>   devm_* functions, not failing on a mismatched ID to ensure fallback etc. This is
> >>>   stuff that appears a lot in patches.    
> >>
> >> You just described standard kernel practice. Don't create documents just
> >> for sake of creating them.  
> > 
> > I'd like you to point me to a doc that says that fallbacks are a thing
> > and you shouldn't do dev_err_probe() on a bad ID (to name one "quirk").
> > 
> > Otherwise I agree that some of it is repetitive.  
> 
> You wrote devm and kernel.h...

I was referring to the next paragraph. Yeah, perhaps it's not the greatest
idea to add new docs if people don't read them. Someone should instead come
up with a way to *force* newcomers to read documentation instead.

-- 
Kind regards,
Joshua Crofts
