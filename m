Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC23F3289
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841123; cv=none; b=LoQBvHtI+yJ7q2MoUa7jhmNM3xcINxLf/kRLXde41o7mQHZAkzQUoml3lXg2bqiNa890Ome6O7bKYqYm4PdxHm+nxLMALDS/wKDwusSLtfeHjrr3eglnwz8erEPwvjyykAq/7B5lo1wD6JzHNWUBHLd3/u7qr6ORsIYn5HPabeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841123; c=relaxed/simple;
	bh=QkjxQqaqKFPCRgz3gYm9WQ7javlrCg8NwBlF5T2Nfow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O667WHRY7qgylxuVejYLEHFshFdIcd8lHkx4nbEfaskh06iyx9290h8viX+jZHeHf1dYOBGNKR90vRqNe6lR4v6Mzw2z6Ar//brtzQLN+EP4ekZjZUoex5kREK//4FjhtNDUI/GLDHg2LL9uIAYERel8qXKYmU7Yj8oB5LLu4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH0FIzpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH0FIzpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DDB1F01563
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784841117;
	bh=QkjxQqaqKFPCRgz3gYm9WQ7javlrCg8NwBlF5T2Nfow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GH0FIzpon0wyHFz1+ab2i3gSVs4VF9UWnaaSWuHz9AHR5M6H1zh87fgmIjB/4WDHO
	 aEjivS/g/OWqbB58gnQi4KADEUo8sF/UK4CJyz/cbfQWJ779FBxMVVTFehxrnBF+Ny
	 8F/8jiTrwMQVBl6m+Qvj7LCY8qWKi9F/Cdu8sLCKfkFvkV39ypkw6J91pe4vMGa4hK
	 mpTUDkajgIGxpy2hcqYp8JGfX+nkO+KP8EXEul0cbxj8La6TS/xhC+WBJEh7G3Lrbh
	 5tF6jp6ZmT7YpbMrEeTKuIEJ16hDGUrUoitaEpEtvsmacaAsA+W5h525WY0/S+LX6R
	 0xRmviqKNbHSA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso9552151fa.2
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:11:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqY6jaDmADtQaKjcodtAvFN7+TUDbl95boRou1Y7YRWZNx3CCoCkwZxLVOsOpDHMrfyStWA4aCWrpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeVEWoH5F75xQvAd/BEbrtkMEgSNIt/Pv802nJt3AhZ1JSrPlK
	w9HryKh9Izi/2C9gm+KepfyLmTQVnmXYET/Nq2b9afsoddZP0Ct1kJwRXtuBxJTrYW9vDJwbsfq
	cWyEU87gPBk67rsDC53lhn1DiyUBBhpI=
X-Received: by 2002:a05:6512:3e23:b0:5ae:c201:c3d7 with SMTP id
 2adb3069b0e04-5b2b2e49942mr952489e87.8.1784841116593; Thu, 23 Jul 2026
 14:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com> <20260723034237.2501507-5-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-5-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Jul 2026 23:11:44 +0200
X-Gmail-Original-Message-ID: <CAD++jLmoFb81mhK3oavqGn4Voefbk3tzyafL8t646XfoTMvArg@mail.gmail.com>
X-Gm-Features: AUfX_mxay0kTe58qvEju40HZKzbygsY4bjFlPypSM3QbSK8RJ7IXv_SciOTFz9Y
Message-ID: <CAD++jLmoFb81mhK3oavqGn4Voefbk3tzyafL8t646XfoTMvArg@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] gpio: regmap: Order kernel-doc descriptions with
 the actual appearance
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: andriy.shevchenko@intel.com, mwalle@kernel.org, brgl@kernel.org, 
	tychang@realtek.com, wbg@kernel.org, mathieu.dubois-briand@bootlin.com, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org, 
	bhelgaas@google.com, o-takashi@sakamocchi.jp, dlechner@baylibre.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux@analog.com, 
	linux-iio@vger.kernel.org, cy.huang@realtek.com, james.tai@realtek.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:43=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Order kernel-doc descriptions with the actual appearance.
>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
