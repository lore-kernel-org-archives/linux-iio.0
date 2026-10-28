Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153979;
	b=GxlqUZnGMRyvE5drQje5r9CPoQ9jFy/Rx9BJ1QDurlEPkP7u8C8kSVxuR+8D+7bJioB2
	 eMY3frPdIXBfkofvVRGDxOv9JTcaz0A6GvszXUirhlrZA6/dUQ4yA0grX4BwIv3bDl59z
	 /rM56hD13LHL5cRrY+auGM/4QHCcecfNC+POpZgZWSBiWaNC4r5y+bpT0lS0vWJmqjET+
	 +ILUEJYcLsFdzibcjn+KknaJQoOQkJ8vnwNCNJp2XijkZPIZ1KwFKwdbTRYclti4hXNCp
	 ZiphU2YtaylmrdA4GpCyON6S/c04j9+if8+mFxDF8b23q25BBj8CH9HbA2LnyjNeC4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d1zxzlRIebjyBsptrZ+JHLQ00yEGCQvdNik5g5EMBYk=;
	b=mT0Y8kCUH30DWoU9bWlDDm3KXh2m870kvm1TXMsxe9wQDlq4LhFDW+RuSm9SrrLP6wMR
	 QRzkR/fI9b4xYEmmMJCtOySB3PkL96GacScRVo5kn4+/dPr+eAbIRwJAVH7ArhxR9IdGs
	 rIQdYLaFThzgqzEARhu+eTi+4fSVvjERU4PMGIRRHmx7ADwITZRETPfhU0vxLdw0Rjhog
	 6diIgYVHkILgwWCvMK5mKPJv5iJ7+7WlTRnG/+W8a5OtCq2fPW8QoVwvazZDIeIctMxLC
	 Ngy1Fyq5wM7//fJpaiPNvQ/XK0ybwC5Sdax7Tk5UAgkT2GsqWYxpXW58Am8c8cvSp8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4SMamLo;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD98606A31D
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 02:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD98606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4SMamLo
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so385315e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153972; x=1793758772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1zxzlRIebjyBsptrZ+JHLQ00yEGCQvdNik5g5EMBYk=;
        b=n4SMamLoTIFOHnFw0lvHy0iwz/3qHhNxe1RiXPeL9oaFo5riHEeGD9b6Dn999/2hZF
         B7S20IjNaxsr6nSAkCJxbcrnA5WXYvXGVJd0AjIt6igDi7LDiBQAOwqbxqTYL0B8VnKI
         r36iFO9+J4hwSgO+Tjz3UGUiVYFJmBsf47LcTszJOv5OtTbaqMyNkoKLjp3wMcRFB7FX
         QY+hYL7ZfBNzIX9rmBFFuK1NHTULFCCQF9MqEV7J8Dxyh+a3ZRusedAg2aUnXxCMcuhz
         BO130H2o5A2kV6cSpYLyy7XFxRB48zLJXYlNrYc/HcOtajxsyr6Zgsd2rVi2Pg0Edz5x
         gwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153972; x=1793758772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d1zxzlRIebjyBsptrZ+JHLQ00yEGCQvdNik5g5EMBYk=;
        b=YrGSV63tc5+LmJjXbmUhPpKHoKz0ICwpQ37vMUJOjM9hi8Y8boshiAdZqsZhb8tY/G
         iA1ySYR4U//uQ5vmNOrkojolmwtciIYfBnJbmooKueQxFmZZrTpecJBBsPgPIGehRvZ0
         NyLUgaoYLQQhwvgaLO7lChUADzgkWAxx9/s+74tZByIbnSKMM70AGiv0kzkRoCXuOyS2
         KF6RAtmV657iJdsJYTxAuslM+dNXieiLVnDF+Pa9RCbFIaOy/RU0NOwTyvlWewfhVFCM
         y2EJ3vYOfmroPxs8mlfRVwACejkAEKGc4v1RXceaHRPwu/t2MWOMwsM850r6BJUBteky
         z/YA==
X-Forwarded-Encrypted: i=1; AKwUvBxMNPQTVy85mxVawGcJA0JiAx4j1ipNHMRfiAGtJxPvsSn0ZXVXGJDKocM8mV8dZcE06joi48EtEoQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/j2XBrPqc+uwVRMMrY3tDXLd/Vu6KaQ2isXRQ0JrpQmEo/tOk
	YLPHhQE8C5M89Nt2PngoAbNoatHipIjuzxXqfD2VEzDr5sYjQ0I/yc8J
X-Gm-Gg: AYBFou1ErCq1QAYw9i5O+BKFlwVIjYafG186XPtqhSheQxee4pVSRzRKbBMFSxngVUd
	bxDAc0wd4EpJIDxEHVzYXyhT+u907nCr5C//IJjeN3O+hGH4LohwnWVBdSupeXdcPyUG1zm2G3P
	5XIZ7PlrlfrefhoVuvsFBJAxdlozj3uzBBd/N/7/hCnBC1+nZEjF5Mw0dwiRSBppYaqjHtddx0Z
	iy8Tnh5HRvFXN6/xkWO3zjwrncCAfx8kpWs6x7aTd4xRQkP6a2bsZK+6z8MKKbXoIzVDgXc8Gbz
	02YM6nb6QJwFmjtwt408A/IzZ/5jTOIeHOslDsuiaZfF3In6gjUnvNmKpiFZFYPkXQukVYaDrn6
	jFDU6R+vRBmNK0DYrPb8sUww6DZ2rdrYAE1+jkUfrc/XKC/S+pql56D+x/ibCOvSrWI2o9CsBEp
	YpNKgD2JBcQPRwZfhDRqQkHpNcLdXeiVaNSu69FeMFD4KI1UZHMFMkhUVVsoSNibFbj3sFa8+Fq
	BJesE86KMqc3zjPxMSYdeD5YlQKvMB67Qk0ySWdDtFIvybBV1MXXCrzq/gXvt4ZEvoT9+ytq0z9
	8tD6
X-Received: by 2002:a05:6122:328b:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5ec4cbc5ab1mr563052e0c.4.1793153972570;
        Tue, 27 Oct 2026 19:19:32 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:4df:52dc:4559:394e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f9210c3sm403450e0c.8.2026.10.27.19.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:19:31 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: adc: ti-ads1298: fix power-up and clock handling
Date: Tue, 27 Oct 2026 23:19:15 -0300
Message-ID: <20261028021915.29695-1-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <184780c8-6d87-4983-8399-6e509a250cfc@topic.nl>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com> <20261024231335.280955-3-stephanbrrs8@gmail.com> <184780c8-6d87-4983-8399-6e509a250cfc@topic.nl>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mike,

On Mon, Oct 26, 2026 at 07:27:22AM +0100, Mike Looijmans wrote:
> On 25-10-2026 01:13, Stephan Costa Barros wrote:
> > - The datasheet powers up the supplies first, then the clock, then
> >    waits t_POR = 2^18 clock cycles (128 ms at 2.048 MHz) before the
> >    reset. The driver enabled an external clock and the vref supply
> >    before AVDD, reset right away, and did not wait for the 150 ms
> >    start-up of the internal reference. Follow the datasheet. Probe takes
> >    about 280 ms longer.
>
> The driver followed the correct procedure: Keep reset asserted until the
> power is enabled.
>
> We've seen the chips misbehave when the power supplies ramp up
> erratically. Keeping them in reset until the power supplies are stable
> solves that issue, if a reset signal is available. The driver is based
> on real experience with these chips.

Thanks, that experience is what I lack here.

The patch keeps that: RESET is still requested asserted before anything
is enabled, and released only after AVDD, VREF and the clock are on.
What changes is that AVDD now comes before the clock and VREF, and that
the driver waits t_POR before releasing RESET. "reset right away" meant
releasing it without that wait; I'll reword it.

Is AVDD before the clock fine with you? Section 11.1 asks to keep all
digital inputs, CLK included, low until the supplies are stable.

> There is no need to wait for the internal reference startup. The
> internal reference only affects the ADC performance, it isn't required
> for digital communication. By the time userspace gets to use the driver,
> those 150 ms will have passed already.

Agreed, I'll drop that wait.

> We actually have 8 (or more) of these chips on a single board. If it
> takes 8x 280 ms extra to boot such a board, it will fail to meet medical
> specs (reboot in 5 seconds).

Understood. Without the reference wait it is t_POR alone, 128 ms per
chip at 2.048 MHz, still about 1 s for 8 chips probed one after another.

> The ADS1298 datasheet says "18" clock cycles, not "2^18". Quite a
> difference. We would definitely have noticed if the reset timeout was
> that far off.

I read 2^18 in the current revision, SBAS459K (August 2015), Table 38:
"t_POR, Wait after power up until reset, MIN 2^18 t_CLK", with the note
"When using an external clock, t_POR timing does not start until CLK is
valid". Its revision history lists "Changed power-up reset wait time in
Table 38", so older revisions may differ. The 18 t_CLK in Figure 105 is
the wait after the reset pulse, which the driver already does. The
ADS1299 datasheet (SBAS499C, Table 30) gives 2^18 t_CLK as well.

That said, I have not seen the missing wait cause a failure on hardware.
On my board the supplies are up long before the driver probes, so t_POR
has passed by then, and that may be the case on yours too. Does the
driver switch the supplies on your boards, or are they on from boot?

In v3 the supply order, the t_POR wait and the clock rate become
separate patches, as Jonathan asked, so each can be judged on its own.

Regards,
Stephan
