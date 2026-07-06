Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD22BE644
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359915; cv=none; b=qE7Te6qO49Z4DJm4R0k62uVrhJMORcxrDhUUr5ej6IZ66eYVtRsN0CctTb7wRQKqRTqDy/ddRb1EqqtjGapum30nXwwAQVmUYFriCL2O/EDSe52UjP0VaWiylxvMf5Sce6W1RODdygWZNRmjZDTOHoaiW1fr6LaiAgdHDAl6RQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359915; c=relaxed/simple;
	bh=1bUswKeZxkJqyx9jXXa6PSF7WDDoUXzqtKYlLWP43ro=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:In-Reply-To:
	 Subject:From:References; b=lqsXCTiJNy49OYf7HxthtV/tKjLlKZNEnm+up4maVnPKhJjdrhIwCNxgu4YJn07xEDhATuBEaAbekkI7yEsEJKu/1F1YoX1UVS7hAJwkN7vx0wrgeLmd5RxXcj7xKJ31QntjWoOIlyiiXGIK/R9+5WnxQS/GXAFSSjL+QhNpt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOjFsQiW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOjFsQiW"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a31c05e092so915427eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783359913; x=1783964713; darn=vger.kernel.org;
        h=references:from:subject:in-reply-to:cc:to:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9Fx37IX+p4mp7bOpenNmKENM9Mo6Ak3ki28L2VKT4vI=;
        b=jOjFsQiWOTIrJt6s9N/oFGAJAuvM2ryQ6tqg1L5CG6Th32Od+TWU9J11SecbFcMLRV
         iSekc4B5OZeXOOxCmLR8H2rIJClEmvTGyu834841V14qb5bYO2+40k2zm1zt8dgo/Yyc
         DvYRwKxDOhaWg0gihLwPMNAFrnL3Qy/Guyz4XIPi/C5InsuVYXQzTEDEoEpkkSFRj4uI
         voC9E5T489Dxj/ERLNvfl/zRqsjmgXd5I+rVEfF9rL2anqSaD2iT6lYCeRXSW6wrFNJU
         BLKkwFMj/xdgjZnp8OrJ26QCMlDwA+5c9H64pJ5COaSQqyWE1nXC4OruB/+hCK0G/bIe
         ZDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783359913; x=1783964713;
        h=references:from:subject:in-reply-to:cc:to:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Fx37IX+p4mp7bOpenNmKENM9Mo6Ak3ki28L2VKT4vI=;
        b=Ly6KXUJ+JNOC8yMQJA+G27ts+OnmJUhNCLbn3mnT69JhRYSepZUu9RbhotPtiO/Gt7
         Z4XLj6UrtXgBXj66PYQVCZg5+laJehefO+RdJqMSSpUv9i2kTmIGWaT4blrdqDNwAcTc
         xy5qwbv7M/DOeCOQAySp2E8M+O5PEIOa5yfHU6OQjQ4Z3j3ilkcyv8OEmVqT+Uhi81rw
         iTyPWaTd6x45Xcgamkz+y7IlPu/HvYj1aZOesHxdVf/jMQ97ZOWyVVwDIA3UUYTPwaTj
         VFSY/xg00T39chxjiipIapkYjV08VZHJvrDI7Ftzd+KLcRzvCuUkWUcT6bKUXoDLblqc
         sjEw==
X-Forwarded-Encrypted: i=1; AFNElJ/HtHwlQ4FD8cuD3n9qGIUEN0y9SuHFatSkH6eZcUOEmD6Pv7juYdFWCUMIL0qheHPpfvpCGR+Bkcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueaQTCKGTvHYAwumBrZ9FcgWMLi7hOT3BfmosdPQwwrvFXOws
	6UyMgb2cyGTc0jX5uZQbeQebv/+wtJskt40DRoY4E/Bu9Rh12ylAVtyB
X-Gm-Gg: AfdE7ckQY0J0dbpyUO7zA6uvXsmlbOnqJmxUJuNY5oIEoSdseVnYymXf0xaJ0kRrHbQ
	Qp6vcUfFfaU6OrLjnRujWjQ+XVD0Yj8wWc0ImM+/lLFb9dw9bea476ikK6XF+aQBv8HBl4zhm+8
	GmMogfj9DFfs+grypPYT2wCA7vVoKRsTAZqr8yoN12y+LGpN5p11ef81HtNdmKXatYy1R6QR9WP
	IPiTx0VkcJTk4C4gN0GF48QCjRU1Vp/ltvw7Y0+qixaMgnVr+o8ynNHQNGCHpIc21938XjbhfmJ
	IahoJlas8D+G0dkCUAcIWJ9oRO89P+jbyw4geqEvs5o483RNb2sfur9e9zZAYNAUrTBzcgzHa+Q
	f3/3OmbMkP0VwP6Q1Pf5oP9XGz7L3VE2nO/n20uZwUOKsqgJIgwivv62GvWRMinfhfcQn1Swtfx
	rjgO8EJ/61dna4akjyiJtOS8Y3MfjzyQ4mdX7T5Pa3i5TBd8ZvBw==
X-Received: by 2002:a05:6820:1688:b0:6a1:55f8:6bd1 with SMTP id 006d021491bc7-6a35537af3dmr953250eaf.34.1783359912751;
        Mon, 06 Jul 2026 10:45:12 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a31fd2cf7asm7035176eaf.4.2026.07.06.10.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 10:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=09bac0a84a9e3c1cdd362f0289819500505a9961f788ba5d22e34909ea99;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 06 Jul 2026 12:45:04 -0500
Message-Id: <DJROBQ66JZHX.5QSG0W2J2CWQ@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260706173541.4f25ad81@jic23-huawei>
Subject: Re: IIO: Merged in v7.2-rc2 + anyone have comments on whether to
 ask for sashiko emails to the list?
From: "Maxwell Doose" <m32285159@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706173541.4f25ad81@jic23-huawei>

--09bac0a84a9e3c1cdd362f0289819500505a9961f788ba5d22e34909ea99
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 6, 2026 at 11:35 AM CDT
Jonathan Cameron <jic23@kernel.org> wrote:

> Hi All,
>
> Note that I've just pushed the testing branch out with v7.2-rc2 merged
> in.  There were 3 conflicts due to Uwe's work on restructuring the
> headers for device_id tables.  Note I haven't (yet anyway) updated
> the 7 additions of mod_devicetable.h that crossed with his patch set
> as I didn't want to complicate the merge.
>
> For new work this cycle please base either on v7.2-rc2 or on top of
> my togreg branch (assuming no problems that will have this merge sometime
> later this week). This should only make much difference for new drivers,
> or for any IWYU / header improvement patches.
>
> On another topic. Personally I'm reasonably impressed with Sashiko's
> feedback. However it is far from perfect and I'm a little concerned
> that new folk might not treat it with appropriate caution.
>
> What do people feel about me asking them to enable sending replies=20
> directly to the list?
>

Regarding sashiko reviews on the mailing list, because IIO seems to get
plenty of new contributors every cycle I'm also tad concerned that new
contributors will take the sashiko advice every time without putting
enough research into it. It's probably better if someone else (who's
more experienced) looks into the sashiko review and gives them the link
once they can verify as we've been doing previously. On the contrary I'm
not totally opposed to it and I think it would be fairly helpful for
most people.

--=20
best regards,
max


--09bac0a84a9e3c1cdd362f0289819500505a9961f788ba5d22e34909ea99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCakvpoQAKCRAQghIb0dl/
iYLSAX91njf1DfUvBJRxrIBeMK3lpsIpgmkWorlkZ2YYPp8ydZtn4/3WtidE7CoS
FadCau8BfjQ5hSdCLwAIeaxCSHdiHvullmLi8hsEuiFYzPJrDQwqHn+1p34N6skx
Zh6d+MSX6Q==
=Hd17
-----END PGP SIGNATURE-----

--09bac0a84a9e3c1cdd362f0289819500505a9961f788ba5d22e34909ea99--
