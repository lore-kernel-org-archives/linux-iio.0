Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715313D4112
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658017; cv=none; b=PYF7jJuzx72XsnBMklkMza1ezDnX59LKNXcyNnp2LHs8mv3JyT+1Fw8kb1nsB9Rarasr6vy1QK/oAVDjUTPl/joqssIkcl+0ghdfPCncVA913uq2r6kTpVNo6vOPRnzxS2PXrSXswRiJwaJ5FyVe3s8rWhsYGMJfZAqtqLDZhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658017; c=relaxed/simple;
	bh=M6IF5YB9Ms7ikCs0h7PlwhA7b1dkMEzgFjwgA6Kd07c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzv+5/jSiG4AV2vGigs3YXDRkifT1xFLo2rC+PehVDUb9kdS+eZ+7Lf/Ry30gPFzzSC5myK8Xm4aCP2CY9AVW98yPm6uhG2bUVyjhkEwIRxgWPb3fNuVH8aEzkzLvK6SVldhwHvYqCqjuTWsum8OkB6+LRL4uY+oZtVHaIerpW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjcN0k0j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjcN0k0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281ABC2BCC9
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778658017;
	bh=M6IF5YB9Ms7ikCs0h7PlwhA7b1dkMEzgFjwgA6Kd07c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HjcN0k0j8IMDmeyMWq9IC1+RMwcF2uURrHo4dFG3F5jAwJg6VjTYwFi2do9fvW4b1
	 uXrMIIchbuzuxLiAt9TFOOhCiGOoW0Xmddh7y58UooTJW25CKUZSu9RsYTf0LWxB8N
	 DGSG7r++j/SUo3Y26ZaiEk9hhMtt8Tu/t44v+0cWjrffushvh+W0W7khVn1Bwspwly
	 97xJ8bhJ3idHX5pCuS1xVJTeku1/6hn/hkgoqlPalMRBeOj4E1V1a2VEGg9cjJTdKq
	 OifKCmj2/wqt4NYLNb7SuyY2XrIi4A+dazQRegBf6MKFv/HB6jKUALzBBCd6YBsNSL
	 xqay+x24ycF7w==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-394421230afso11596081fa.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 00:40:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8U5KXttIZ31gG79iSH0aBTowjgKJqcFk5lBue26x4W3A5X/xAFWdIhdPQR1y4RTpZ4tsyUzKw/TkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFzuUaCazpijaKu1kxD4ZJv41nzV1GQSC1web71VOfVrYVLhr
	hwsrnL8x/u1n7112K/PF+5GtguQc9XMeSffMRuxbp9sa8IZFgP6+dzfcXTGGpkCEt//y8l1aXQw
	llBY6JtX6L84kkXEomRR/WH8T/gOTaWo=
X-Received: by 2002:a05:6512:2396:b0:5a8:9f6f:31fc with SMTP id
 2adb3069b0e04-5a8ef9352c3mr674739e87.12.1778658015719; Wed, 13 May 2026
 00:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512033317.1602537-1-eleanor.lin@realtek.com> <20260512033317.1602537-4-eleanor.lin@realtek.com>
In-Reply-To: <20260512033317.1602537-4-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 13 May 2026 09:40:02 +0200
X-Gmail-Original-Message-ID: <CAD++jLkdq+43N11xNVNvq3wYhhDzvFZ=yJL-SCRDhQPbCAVQLg@mail.gmail.com>
X-Gm-Features: AVHnY4LBwJ6oIR5aJTDwxQV6K4gULrWZodoEkRc6fxJoapre3LNZvomIzuavyFI
Message-ID: <CAD++jLkdq+43N11xNVNvq3wYhhDzvFZ=yJL-SCRDhQPbCAVQLg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: brgl@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	afaerber@suse.com, wbg@kernel.org, mathieu.dubois-briand@bootlin.com, 
	mwalle@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, dlechner@baylibre.com, 
	tychang@realtek.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-realtek-soc@lists.infradead.org, linux-iio@vger.kernel.org, 
	cy.huang@realtek.com, stanley_chang@realtek.com, james.tai@realtek.com, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yu-Chun,

thanks for your patch! I really like the direction this is taking.

On Tue, May 12, 2026 at 5:33=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> Extend the reg_mask_xlate callback with an operation type parameter
> (gpio_regmap_operation) to allow drivers to return different
> register/mask combinations for different GPIO operations.
>
> Also add write-enable mechanism for hardware that requires setting a
> write-enable bit before modifying GPIO control registers.
>
> Consequently, update all existing drivers utilizing the gpio-regmap
> framework (across drivers/gpio, drivers/iio, and drivers/pinctrl)
> to accommodate the new reg_mask_xlate function signature.
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>

linusw@kernel.org these days.

> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

The rest of the comments I had Andy, Jonathan and Sashiko has
already pointed out, just hash through it and this will look really
nice in the end.

Yours,
Linus Walleij
