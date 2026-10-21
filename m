Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588187;
	b=qlzKmjRZ2QYBgQY1D8vmEm+qfnItr4tET6vi/VoOOgtpydp37Qef0luSk12UVdXgeeqg
	 uWpqyIZanIai0INcJzEZbUk2m7C6h5lOcLJX3RDIVZIS40TUj4OxoUtCQctHjQCF6Vucb
	 y/a9emvhfEuiGFW7Ou1kEY8fADUIcduDIrjHwDzTF8Kx94QDKeYghB2aAYymW8gIyOw26
	 gVcQ4gAqmQ5fAq8GDK/DBLSu1IOR/TJPwZ1DiixnXNl+OTz5VS8rtCGPWwWRilhi5UTiB
	 YRPQOoyYCuYGnYf4rBIaSeDeNpGq2f4xGBdp9U69hWXdhFQ8KDfvSije4MUyNx9742g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q08y28kaRtiqf3uk8BV+2BQPytUqi6HBvnka7EjTRCE=;
	b=Wt+tb58BTybcMDWWzxqza9sTYod5vurd4TS08WKtFgLTt8hQ2izYf/Bg+CqomNhAegM4
	 CrQRjknHeuowkVyw3gNXsAHxkIhJtnn3INarMR74M0SXziyWgw5AHK8fXaD/Xshf/YcZg
	 e1XbFjAX5N1rQWKKKxfoG6FXbuUYjGphEeo4c25ZfzKbXhr0lllouscRr0QSejzYh0yb8
	 A5bBsl59P9nbKG2R+Q7I5zjrNndiH1DmWk8okmnv9CuYatmRs2UNl/YX1eBr9UMF4ne5n
	 SA3FW5A1IG8siwULuB8XG9+9LflFWERdk+XbZHtp2pGxSqeUT0Rac8/bflO9tRJPs4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fzRM6wbX;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6087606A319
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 13:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6087606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fzRM6wbX
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e20edd106so507687f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588185; x=1793192985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q08y28kaRtiqf3uk8BV+2BQPytUqi6HBvnka7EjTRCE=;
        b=fzRM6wbXaiaCzuT+9CevqVF20mKC2vooPhqvxyiZocf4ThKWiQiRWxjmNirvf5znqh
         mazbzo0FJ32fDAxyn6hmY1+afGgeMK92SL7paM8gSHU0Lx9uXZdVYd38TcmLINfQgrhL
         eJ5xUSe9anfkMVU/VhKhNb1cw3OA7/ZgP5BeCdz8oPO2QUprkgCmiMboKpGWyiSBvd8F
         +JGbsrRPMzRKeMCMw10vQubojtNALkApJugc/cUH6zKi7Y4f1e0Y3g2PIWZ9OW0y7B+1
         03LjhnuQp5wlahzUCboYBZ5rhdYzoZ6G8gwSPOdHwaKWxScCjwVHQjx90N4kl8NYmrKs
         390Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588185; x=1793192985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q08y28kaRtiqf3uk8BV+2BQPytUqi6HBvnka7EjTRCE=;
        b=foVmkTMUUAhoEb+Ka0e7333JCNe/J/FJEjS01RqiqaiNQE18G9xJaDToZNrOkLXhcs
         yHU98ECekw2RbiLOWeNCoD4C+lU5TKN+uyEnAK//RsXnKrul5xLWhZ7qdPBuE0dU2Sz2
         QUiVnWQl1t0XueUpSZmhJZieKy1vTbrYSiKe0HQgxywifFycKieQMvcbQPulwm/hrGLC
         KyQaKtHvIeGZuMwtWT+WtmFuLRVNCF6XC2KpXK3kD6P+B46Q7D/qQUnBZQuFO4dJPpCZ
         gO3MkDqT+q6VQi11hvXb+EJ7qHDahQ97LyVyWuGlA5SszNUTk/NL4MShp3MEr0PvZQHb
         xPwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNDdHI8ALyuZlZGAeZKsRX3N8/liLoxbEIqV3sHOFb6l75U751xyv6dl6Zx3fUa2IM3ROqi0/sBU8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIaqptycAr3NHIlUl/fgX7yy5kFB6z+Y+GKJG+PdR/RTU2NzyL
	IW169EBbeNKZWmges/oTzPGxICd5W5xpKlpLEOutiL9T///6GkQ+7VZT
X-Gm-Gg: AYBFou1MsVUTKO3OFY23UyKDI54OaxFPGuxIXh2WlUVtXc5BtK1qJAVLjwmdUJQlmX9
	ULewPjdduY6DFYwhHWakVAxMuhADiFot3BRWaQErdkG7cdm8QVXmhllMS6A7DrQtQ1lutvW/AtX
	B1gzn5/p1maiz1fJdWfxDUGyaSHCySYWLhkM7UhAde2o7XG4UcJ40pv4A7dpmamd+mDMCkecceN
	gA3L/lv3QqffwD1zCp4/3C/HSWaMDOLWXd0Nm+xivajCJLMkajx5clZXKZkylBqRLOTaUzItUNS
	ul2wO1fhExGWpUoF4lYx33+6/eh13Y/F3iZNlSww8rsbe2a8PTfTZE2/mMZ5OvQV54pCtgCp58W
	PRzxuh9hQYlc7pTPHTcQMOzZMDPgdju4s9or3E9m0U/oyfnPzFs3Q8Re8Wk34E7Zsjdip4y55Ph
	a+BrP/PvpA3IKPxepgLhzAonq0jrCTrRBjSiOpGcrROaB6IlM9fkn7aUDJbiXGESPrdzCK3pg/f
	tVuuE3kA+STrJd/WgjNZRZ6+4VxzMgKe+Q1FAcFzhcLBKqiD16y8w==
X-Received: by 2002:a05:6000:15c8:b0:48d:f3f8:f910 with SMTP id ffacd0b85a97d-48e264ca949mr2913670f8f.34.1792588184900;
        Wed, 21 Oct 2026 06:09:44 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d28d:9c92:be85:1c3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm5360894f8f.22.2026.10.21.06.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:09:44 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:09:43 +0200
From: Jan Remes <ciakval@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Message-ID: <ati5lzd2KotvmMC6@mm-ntb-00805>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
References: <20261014141650.259929-1-ciakval@gmail.com>
 <atEdM6wi_FAGFjrr@ashevche-desk.local>
 <20261017031411.05dee323@jic23-hlaptop>
 <atXSBHbOPYYltHUW@mm-ntb-00805>
 <atXZwm5DzCK8S0_K@ashevche-desk.local>
 <atdRJ3JqAyGWOnxf@mm-ntb-00805>
 <athxOKkugAYL62F9@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <athxOKkugAYL62F9@ashevche-desk.local>

On Wed, 21 Oct 2026 11:00:56 +0300, Andy Shevchenko wrote:
>
> On Tue, Oct 20, 2026 at 01:31:51PM +0200, Jan Remes wrote:
> > On Mon, 19 Oct 2026 11:50:10 +0300, Andy Shevchenko wrote:
> > > On Mon, Oct 19, 2026 at 10:17:08AM +0200, Jan Remes wrote:
> > > > On Sat, 17 Oct 2026 03:14:11 +0100, Jonathan Cameron wrote:
>
> ...
>
> > > > FWIW, I don't think it to be very urgent, as people probably don't use
> > > > it on x86-64 (seeing both as it had only DT probe support and that
> > > > impacted users are likely to have noticed the oops).
> > >
> > > What do you mean by the second part of the sentence? It's as easy to use on
> > > ACPI platforms as on DT, we have so nice trick called PRP0001, which allows to
> > > enumerate "OF-only" drivers on ACPI platforms via SSDT overlays (or other means
> > > of DSDT/SSDT provisioning).
>
> > I did not know about the PRP0001 (thanks), so please disregard that
> > argument. Still, I believe x86 users to be few if any, since the oops is
> > quite easy to trigger
>
> True.
>
> > and AFAIK most x86 distro kernels ship without CONFIG_OF.
>
> How is this relevant? This driver doesn't use any #ifdef CONFIG_OF or alike,
> so most likely the driver is available for x86 as well.

I thought that CONFIG_OF was needed in order to be able to probe a
device using the driver's OF table. TIL that missing CONFIG_OF prevents
only manual probing (`echo "tsl2519 0x29" > .../new_device`) but not the
ACPI mechanism.

So:
  1. Please ignore that argument
  2. The wording of my Patch 2 commit message is not correct ("cannot
     be probed on a kernel with CONFIG_OF disabled"), I can send a v3
     if that's preferable.

Thanks for getting me to learn a bit more.

Best regards,
  Jan Remes
