Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F73CAE7F
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686817; cv=none; b=XPgioHKiTIEE2OwUs0p5pEhAlBZlgJF2gYHFswx0Z2ERpm81KOISM1o3X2HB7Ob8ZKQJE64ibM9u6KA9FOTMObeYZ4fn3UP83cJ2wrlJIRQ+cPe6+n+yFSipI1hClorzDNprSLOjPAiyiMWVbU/wpxlAiu/p5h95GlZyHZZHFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686817; c=relaxed/simple;
	bh=+bi5jGBnSxCY5PYumdFsQECiuBCaWnyKppvHa8+xDc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqZLIsxfD2sWi/geUCng/2+SmrRfJfBQYB3N1q8FiMqza9igzh1Ht0U/6dZLMhke8OlS7zaufCXSSZ/CobamxXapRb6y4wGYepnY9oem/lTV6mKZ9d+L3O78jwEDuodtwOUQja3Y2KO1LlKQaeQNPnpncjr8FnwuPTZID/STIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkP8MEOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkP8MEOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBBC1F000E9
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787686815;
	bh=+bi5jGBnSxCY5PYumdFsQECiuBCaWnyKppvHa8+xDc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZkP8MEOgM5LFXa5ePQCQEg6r0RLg07vST9oR51xGsr1SyLFuUptWakGMNJdgnvtU1
	 uBnc+ce/oi8PxFGxbkHjG4YoF3XrgbeuPiH3eaczGxQsDUnW/+4XyKIk57dnS+dlSk
	 AmaCkq/J0RDa5VSSk9fIqL9+kocUBl4dWcJiJV84ij75f+4dauv9syfrLpJbnsl7RV
	 ymRjcWhr0h2Xnz1b9VEci27J8yCrd9MPHkB899SyMZ096mLdGZZ/udzWmhKTgAU11/
	 5qOftfqOze0nC0lnOVScrJ1kjfjpS8E3WJEEIOAORKm4ld4dF/InEXQIK7qTWrIA2y
	 oA1vOyDiXfz8Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b159850b16so144426e87.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 12:40:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpOD3qdQtrVzExOO/Yue6borXU/fjxgR8pIhl5Dt/0qf9BIDkUQMq0SG3vXKZ+yVCT8HpKpjfRhG0w=@vger.kernel.org
X-Gm-Message-State: AFuF++lLSKzsa+rnQORS9bItT1p8wARMFW5LSvGdD6UTzQAOHs7kVBTf
	NKJ/kMgG4VnseovoFvKrybMR8nPtBbAozGLVWoJEQLOddXFo3bKzy2gUcwsVor6n0wreAr8MQwz
	Dpo+3pV+Dt7qATFMg540lukRAIerkGo4=
X-Received: by 2002:a19:5206:0:b0:5b4:9d34:eb67 with SMTP id
 2adb3069b0e04-5b4a908dde8mr146322e87.24.1787686814322; Tue, 25 Aug 2026
 12:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com> <20260821-ad7768-driver-v4-13-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-13-bb8fbd06d4eb@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:40:02 +0200
X-Gmail-Original-Message-ID: <CAD++jL=ETK8XYitifYtiqRT=EEhajRuWVsMbQAy-6Nruan+E_g@mail.gmail.com>
X-Gm-Features: AcwNN1WP7nDYWVtAvRI7jhAlCMM2p-ol-X0Bi9kPCmp8cnoNKcXXSbDuEyhIrG0
Message-ID: <CAD++jL=ETK8XYitifYtiqRT=EEhajRuWVsMbQAy-6Nruan+E_g@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] gpio: ad7768: Add AD7768 GPIO auxiliary driver
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Michael Walle <mwalle@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	jananisunil.dev@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 4:09=E2=80=AFPM Janani Sunil <janani.sunil@analog.c=
om> wrote:

> The AD7768 provides five GPIOs controlled through registers shared
> with the parent IIO device. Register an auxiliary gpio-regmap driver
> and use the parent device for runtime PM.
>
> The device has separate input-state and output-latch registers. Add a
> reg_mask_xlate() callback that checks the line direction and reads the
> programmed output latch for output lines while retaining input-state
> reads for input lines.
>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

From my PoV this is a beauty, so:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
