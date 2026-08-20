Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BE40F750
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220578; cv=none; b=Egge8VCUi46Fr5nkJYaG4bucSBK6i8b2fKn6uA1SXMyBagBhbw4MbN3zeza4A2nX3kCzPpsScvYAD2ONQoYV26nw6A5YSYC3RGKm4D9LABMGjytfGar2Djy0bwus0f/CDLF+Tmlu8hNipas3EayJO352s9UFkvc4eG68dfxMJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220578; c=relaxed/simple;
	bh=Lx6dG9h1cuSzfbbee7rUL35gEEuG4OyI/9dY1QQnSFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEWQM9TtQa9HTCf9gcusvywk9ZW18GZnFY/WIlM9G5kyI203ZhvwMhdOk+6sWszsazc65OMYs0o0fSXeqq3uu8ccnP9FTL9NRjKrv9EVapHchHke9L/LmctKz8MDQ5MXVuakIEtT8UPZmdBmeXxJZDiizqOZfhFJsE2IX0Y+/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHA83QJZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHA83QJZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so21228495e9.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787220572; x=1787825372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AHIZmdtuQlI9QFSmqNoHA5LobKwPmC0fvttFj8Fm4m8=;
        b=FHA83QJZuVLr4SbUqv1V++bNc17ngeSZyift0wGmhWNbxGqOLGYobNgAuvoX0uvBvk
         3gFxxeRf05a4ivdtgcas+q3Lm5cCoWTgu9gRzicM2uQYpDo1ojHwNATI/FLU9qE1Nywt
         7mbFGx8YnEEpvPfig1R5Hkwq4L9TXw8VqHSql6TGJLprrX+tcjLhtUleXzA9XYqaWIl9
         xbb3zER9LLCFgS8cryikJp6tOFQxTrNj7hGlBGMnN+ZrklBnG4JDXzgJ+eR6Vum1g4S2
         EWoi/HYpVg6Q98z1LktXPpBxHmmC7XPoJz/wrupZ8bzRJDJOcAsWkZ2YKPFLJsU0q81d
         5k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787220572; x=1787825372;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHIZmdtuQlI9QFSmqNoHA5LobKwPmC0fvttFj8Fm4m8=;
        b=IESXJXEodJnfD9G/ipfPzhBjKdFY5DR1/nKwZOc0sDzMhW1617nzHr+1jUVEpSyO6m
         fdKDQ9SjQV14bbP/0/sx1pHZc8FnX5eUuquU6+IUMRPt94lHUBkmmaDIM5JV8A5yy+mq
         Za5tPEGe5kDKMwTbe/6kPqMj1FUijqG2zP9Tfd6KcrFCzU8wR+W2Nv8d5EU7MP5DXSL9
         oER7klQ91erJ8eMWNItqwTYBIJt/+M6vfOUjAmhaOYzv0yybHj3u8hnnHxVd53BZZUyc
         mBcliTymg5a1yHPFTgk1oW62cwuJcH5HJmINm9fDoCm5VTVpQyPYbQiNqlIcMPTXTEj+
         i0bQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGWbJnW65GURMpBO3Z4n6JB1xypB0GqP06mBu+fRD0O0+/YxitARR/dYXrlF6CpppvWUbS3/AqxU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8UF2XalfV9MlO2jIYg92rPxinLjrVlPeOxI68ErHkg02jsvp
	0VNOf2oIyZJhTxmBjxwgJxCdZFXSmjpi5BBpsbzpLsGZu8+M4eqgz5DZyLYvP24bMMU=
X-Gm-Gg: AR+sD11OBX/yPAKyTy8hzKJAp0gz/3+be7yCmT6URepvruREduXuHbAfiRkx9ke0zwk
	a5JhIc+wlOzYmdquHDmQV4ZXYIbEPoP8R3SUOjrbtq9hA6JcE3lSDWHk8LlROTw5LWSNRgUKhwj
	MJhMA2DLMy69tkjVnKr5hYMArH8QEsESgVSPV5lh3wv6Iw0QLuS5eYeciJZD3jjbY/VRmz1x1DR
	Qu+FzTCm2d8rkAVDe9uII/P8eAxghavthGQa4P925WHccKCLr9rbFOyYn6Ql+9OLugtVtiUirb/
	8Shk+gVZ8rQEk35q1Mrd6wixVsua5San327JX1eukoxHoXAxnVL4ok2sUw8iWjNEMXThvkqPRfT
	NrYFOdOlKkYW3h/V36A5pCVlOaygqdUCfitrKEQWbkfGZiUNtoVPh0qf2xvPHWdxqCMmw+TEx23
	20crIX7LK57fTy7s0BeMJLarMzS6jMYq/9xZ8v2mXvnicSn5HIj7e+dnke/vr1tyH7Btd5379uF
	TzDWJ4hn/e7vwGZd+GIkmkcf76APXugIvo4vKVwZkDAsrbM8IVqmS0I5McDmmsOkMQEuY1V8yXO
	/DZYuxcrnsKcTJrxNHz59O739XS2xlzJMHjLa3R6/8lRUiJpMmvoNyLC6wzsaoBx8sROfEO9vED
	3nGKmdp1F55OAzSGw2aXdel2ulaiVY0S5rfB6a0odgZ4wYpJfkF7eE0MlxLy3G594X33UDw==
X-Received: by 2002:a05:600c:628d:b0:499:8ae1:b900 with SMTP id 5b1f17b1804b1-499aa1c9610mr214296435e9.12.1787220571751;
        Thu, 20 Aug 2026 03:09:31 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1947c6sm127708055e9.15.2026.08.20.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:09:31 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:09:24 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4377: Fully initialize
 clk_init_data and clk_parent_data
Message-ID: <20260820120924.00003f65@gmail.com>
In-Reply-To: <ae48ed1dc6b1ad9e10cad0d9df28d9fab213f653.1787216909.git.geert+renesas@glider.be>
References: <ae48ed1dc6b1ad9e10cad0d9df28d9fab213f653.1787216909.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 11:19:52 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> adf4377_clk_register() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter is uninitialized, and
> thus may cause a crash.
> 
> Similarly, adf4377_clk_register() fills in only parent_data.fw_name,
> leaving other members of the clk_parent_data structure uninitialized.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
