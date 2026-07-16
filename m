Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243A3161AD;
	Thu, 16 Jul 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211546; cv=none; b=Y6tQKWIREDINgVaZP3uJLuO3CU5R0N6iBNR4BZ0k0tjJ3vGEIkEaarTOvFVRJSj12HYaB5pQr0PNRjHeXiYUkF9+157m7lhBr7QPAy89dtHoMAyaRRm+5b+oonsNhdwUNVU1ajW1N2+9dGl0ecfOHgJZ06e9je0EH4mGezckX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211546; c=relaxed/simple;
	bh=SLY0oV4TBTL7M/7s1q+ymPUnu5ynagvJFtt+tTz2ZPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI25BgZCnrSmi6WGhhnZB9bp+0Yr+On+w0ykCJGrNWlVtIadQHsSUMFk7o9r/fwNP8B0Pmh6fBQXpfxcB/wQerFhHv2oLQHTrQ13cNrb37kVEozOKx15Ww7PUQNmBo9g8J4IRFPDosAdX+ZeQtDTiH+Hb3kSpXN0GbHkWMuDKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=162.0.218.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from MTA-07-3.privateemail.com (mta-07.privateemail.com [198.54.127.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4h1FXQ5n7Jz2xBt;
	Thu, 16 Jul 2026 10:19:02 -0400 (EDT)
Received: from mail.privateemail.com (unknown [87.215.145.39])
	by mta-07.privateemail.com (Postfix) with ESMTPA id 4h1FX03VdJz3hhTG;
	Thu, 16 Jul 2026 10:18:40 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Siratul Islam <siratul.islam@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
Date: Thu, 16 Jul 2026 16:18:37 +0200
Message-ID: <20260716141837.83326-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net> <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net> <d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sirat,

Thanks for the thorough review. And no worries about the formatting -
it was all still readable; if more than that opening sentence got
dropped, feel free to resend it.

On Thu, 2026-07-16 at 15:52 +0600, Siratul Islam wrote:
> > +#define QMC6308_OSR2_MASK	GENMASK(7, 6)
> This is never used so it's dead code. Are you supposed to use it
> somewhere?

It completes the CTRL1 field layout, but you're right that nothing
uses it. The full-register write in qmc6308_init() already sets OSR2
to 0 (= its power-on default, filter depth 1); v2 will make that
explicit with a FIELD_PREP() in that write so the OSR2 policy is
visible in the code - or I can drop the define instead, if that's
preferred.

> > +/*
> > + * Power-on completion time (datasheet Table 7), also used as a
> > + * conservative bound after soft reset, for which the datasheet
> > + * gives no figure.
> > + */
> > +#define QMC6308_POR_US 250
> Describe what this value is here, and explain in call sites why you
> are using it for something else too.

Sure, will split it that way in v2 (and that covers your later note
at the qmc6308_init() call site too).

> > +#define QMC6308_AUTOSUSPEND_DELAY_MS 500
> You can call it QMC6308_SLEEP_DELAY_MS to align with other values.

I'd prefer to keep AUTOSUSPEND here: it names the mechanism the value
feeds (pm_runtime_set_autosuspend_delay()) and matches yamaha-yas530
and ak8974 in this directory.

> "reading the status register clears DRDY" - This bit of information
> is not describing the mutex. Explain it at a call site. i.e, where
> you read STATUS register to clear DRDY.

Agreed. v2 keeps the mutex comment to what it protects (the cached
range/odr/osr and the atomicity of poll + data read) and moves the
DRDY-clearing note next to the status poll.

> Use reverse x-mas tree order.

The natural initializer order is fixed by the dependencies here (map
comes from data, dev from map), so reverse xmas tree would need the
assignments split from the declarations; I'd rather keep them
together.

> Why not use a switch here instead of depending on 'i'. In it's
> current form, we would need to keep going back to check what the
> scales, odr, osr arrays look like.
> I would suggest following the same pattern as the QMC5883L driver.
>
> The arrays could also be flattened like this if you follow the
> above suggestion.
> +static const int qmc6308_odr_avail[] = { 10, 50, 100, 200 };

The arrays are designated-initializer tables indexed by the register
field code, and the same tables back read_raw(), write_raw() and
read_avail() - so the value <-> field-code mapping lives in one place
and the accepted writes stay in lockstep with the advertised
_available values. Switches would duplicate that mapping per
direction, and the flattened form only works once the tables stop
being indexed by field code. I'd prefer to keep the tables, but if
Jonathan wants the qmc5883l shape for consistency across the two
drivers I'm fine changing it.

> This check won't be needed then.

With the loop kept, that check stays - it is the loop's not-found
case.

> Another issue I noticed, what happens if the update succeeds but the
> "status read to clear" below fails?
> You are returning an incorrect error to the userspace even though
> the scale change took effect.
> I think a better approach here would be a log and continue instead
> of failing.

Good catch. The range change has already taken effect at that point,
so failing the write would mislead userspace - v2 logs the failed
discard and returns success. For the record, the residual cost: if
the bus recovers before the next read, that read can still return one
sample converted at the old range.

> Might as well assign the default values for data->{range, odr, osr}
> together?

Sure, v2 groups all three before the CTRL2 write (which consumes
data->range).

Thanks,
Jorijn
