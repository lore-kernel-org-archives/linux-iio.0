Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDE3AFCE4
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307773; cv=none; b=lvwNd6skQumUjSu+ekGl71TaFxedKJhzmH0oqP7nQ6KKHpC6zPksBw7lge91O9qywUfj1qOago9RvuWqWAEXdoxOEH3Sse3xPLJbEJmylWq2jglRJ3m1oGQvBGvuwzFzZ0txOTAahOXZobWpokJbFDU/U8wRfzIbhebUDNOShyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307773; c=relaxed/simple;
	bh=TajKrkP7iAilCm/Wf9qOw7yL7OS5AMPI8Bf5cDTLAK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=DAKz1wviM/BjHvSDmRN+cTnCEr6EWBBbLtXr18hxhXhw6qAeWZ+bZ8qRRHrvrEqTrsZn7Q7p2TkC73iTuX7kwNgpR7PMlS7aljyqojfKq9zM57YnvbcwdYAXFDSnn4qWbmMOdF2RzUretlGhDMKmL41vAOV9PHRpFvBP4fGHy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c2ae02f69eso705214e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307761; x=1787912561;
        h=content-type:cc:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZ9qFWwtyy0CyLFBazZArycje1mFKlJigB1GC39CAP0=;
        b=ELq/lJf3ahC++xnN0UQLVBytdHTFQAyYza1mTAoPyz2qF0+orgHGisT4T2LSWXQR/+
         29V4KsQWFbbLdExhtBETYNQHPIsh+qMmJENuE9+5lMq0W87A46UEAw8uhFsJEMoDahLz
         hDYQWwZgNon4hCIglzzzQF3wnIa+FvGJo54vbBLVv0TmusGwMGsyQXYK/ktvbZiKo0Dn
         xGNBnLow2bOMSxxIW8OTWAoTXTrDb0BIt6JVpj139x712zXTcBdqSe1Y92+OJ9YF/n8G
         1P4JTlexJ3eDbK5BAUEGjEbu3xKAljdVvlJiRYAZc6oW1KY5bUkWVBx8RtKW6lrsV/Ey
         Q2Cg==
X-Forwarded-Encrypted: i=1; AHgh+RoIEBMlGi2YItw3GXXDTaP0+NF2ESLdaBxrw9cMI4gYSBF37+7Crok/w6Dam8uA4IvDWVBc+z9Mi0A=@vger.kernel.org
X-Gm-Message-State: AFuF++ntnHX1G30hJO5acN/O14oMax2QbNVz9mJUVVGpEGGgL6Y8Vojv
	etYcMkVx5/eA+djcSzLZpqydGT5+Q99TTLLa6tgMBqc/ysd5hBx1P+uG49wk5bsW
X-Gm-Gg: AR+sD10EMk45Zj7HqoyTWvxl8DDMNngJVyFSfdv06Kz+sVdeobIDUeJ9WxHFOqCj5Zx
	VjR8WaPUttIGYqlQQq5LhVJ/7y28yBxl0ds9UY+ieipYlNnuYmfYSfWnUxPKRSX6vIT9KDkrdVm
	P35aULHlGsOP1WFtjerpvsKAV40PnSPNyYcKFz0YD0w12MJTCKDYR6m9kyCbta+MsegVYUVQZ1L
	IO1c0lItDvhoxn5Pug8eWllMDH8eQAw2fpp3zh2dPvitNYCZs1S8eUw1rNLNnf2qGN3WfeEaD9m
	eP1dweBtUwO1gn3jrxlKqMnC3QEJ3nTzVp+11RSoKlIq6rNLsXEEfxHKS/XATBdSG2Pa3fYN7jV
	Ap45J6736iR4oVRYmYKcA7A6TA1BJvuD7Ho/uqTk7mD74JhwrZ9ykoYaMWJaEXHOn50w9iU+7dm
	DuC2SMMCLbcT2m3ZfvZHdlEUWXl83e9v4eYNPteOgilvkzTpGwqIb15RdJGOHSOXoBhizsmXmjZ
	qytuzmm5DHyic1rZIhiOmgHjQ==
X-Received: by 2002:a05:6123:142:b0:5bf:5edc:9aa0 with SMTP id 71dfb90a1353d-5c5ff765aa0mr2422907e0c.7.1787307761059;
        Fri, 21 Aug 2026 03:22:41 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2837fa0sm8346350e0c.17.2026.08.21.03.22.40
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:22:40 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7475a4f8b05so439280137.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:22:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp0TEyAPWS+AE68LDfEAv6EeScxQbDfZGhjY4Bi/VRlionEAbRw66gHf1amzsMU+IWdzWShev+OzQw=@vger.kernel.org
X-Received: by 2002:a05:6102:a54:b0:74f:4162:3f58 with SMTP id
 ada2fe7eead31-77a634443c4mt4162123137.6.1787307416387; Fri, 21 Aug 2026
 03:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787165329.git.geert+renesas@glider.be>
In-Reply-To: <cover.1787165329.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Aug 2026 12:16:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaxV9K8=yQ3KU-V2dV-eFqFqMR9WDyt2RVKADLS51Dcg@mail.gmail.com>
X-Gm-Features: AcwNN1XMP476J77X05DStUZ6YHTKoquM1cTbXZSuVIS6ygsja8ReRo486qzyWdY
Message-ID: <CAMuHMdXaxV9K8=yQ3KU-V2dV-eFqFqMR9WDyt2RVKADLS51Dcg@mail.gmail.com>
Subject: Re: [PATCH treewide 0/5] clk: Make sure clk_init_data is fully
 initialized (part 1)
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Nuno Sa <nuno.sa@analog.com>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Sunny Luo <sunny.luo@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Aug 2026 at 21:05, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The clk_init_data structure contains three mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  When commit
> fc0c209c147f35ed ("clk: Allow parents to be specified without string
> names") added the last two methods, this was done in a
> backwards-compatible way, using a priority-based scheme:
>   - .name, .ops, .num_parents, and .flags must always be initialized,
>   - if .num_parents is non-zero, .parent_names must be initialized,
>       - if .parent_names is NULL, .parent_data must be initialized,
>           - if .parent_data is NULL, .parent_hws must be initialized
>             and valid.
>
> However, not initializing all members may cause subtle issues, which are
> only exposed when CONFIG_INIT_STACK_ALL_PATTERN or
> CONFIG_INIT_STACK_NONE is enabled.
>
> Hence this series makes sure all members are fully initialized, to fix
> such bugs, and to avoid future breakage when converting drivers to a
> different method for specifying the parents.
>
> This (small) series is part 1, and fixes all cases that I identified to
> be real bugs:
>   - The first patch fixes a crash I saw on BeagleBone Black,
>   - The other patches are only compile-tested.
> All patches in this series can be applied independently.
>
> Part 2 will be much larger (touching 185 files), and will fix the
> remaining cases that are currently harmless.

FTR, I split part two in 13 subparts, per subsystem:
  - "[PATCH 0/2] ARM/soc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239869.git.geert+renesas@glider.be>
  - "[PATCH 0/3] ASoC: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239902.git.geert+renesas@glider.be>
  - "[PATCH 00/45] clk: Make sure clk_init_data is fully initialized (part two)"
    https://lore.kernel.org/cover.1787239813.git.geert+renesas@glider.be>
  - "[PATCH 0/2] drm: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239944.git.geert+renesas@glider.be>
  - "[PATCH] i2c: bcm2835: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/9f82f37e6d6c069cd44326bcd5e5a2a8069a13a9.1787239980.git.geert+renesas@glider.be>
  - "[PATCH 0/2] iio: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240005.git.geert+renesas@glider.be>
  - "[PATCH 0/3] media: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240035.git.geert+renesas@glider.be>
  - "[PATCH] MIPS: Alchemy: clock: Make sure clk_init_data is fully"
    https://lore.kernel.org/3610b51df642abb1fbb39f5bd93fddea43f8f164.1787240060.git.geert+renesas@glider.be>
  - "[PATCH 0/2] mmc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240090.git.geert+renesas@glider.be>
  - "[PATCH net-next 0/3] net: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240118.git.geert+renesas@glider.be>
  - "[PATCH] peci: controller: aspeed: Make sure clk_init_data is fully"
    https://lore.kernel.org/48aa77c45e109f78ccd806bc3b7bf380c5bc5e71.1787240145.git.geert+renesas@glider.be>
  - "[PATCH 0/2] phy: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240165.git.geert+renesas@glider.be>
  - "[PATCH 0/5] rtc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787241693.git.geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
