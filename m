Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31753E49C6
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840823; cv=none; b=iWwS3u5TVAnegADi7dox20Li9gSqu4n77SeZRAJFdewghBxXJFUt88UDSLW6UFUYX4pOzrSNa+8QVwojBF2QhoPRm+ICYIDa/G0YOGFfkB4eKAhDO8hPtBo0Rz0jaDu2OtnW3uWPcfqnwWMe+zuwkvXoxHbGiqRS3xOAcoU6kbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840823; c=relaxed/simple;
	bh=2F4CTL2BzBGbJ/mb1DEXoRCZ8/lHFVULuOlS7x9hEgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nW9O7tKNwSN55iK/IXpNQAzfEBfhlymqFtRhsPSbazf+k3R8U/Kg63ypWn+5TNZLbz1E4vNlTkjSvZOwNk4y+aYFBAs2tttBpnmJdye0KwqdHX7bFAGmqa3hpG/DaWGImEisw8HrwZ0wPkmboXiJsit66CXek3TTfwJxbAw9R+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvRQBxeH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvRQBxeH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B601F0155F
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784840819;
	bh=2F4CTL2BzBGbJ/mb1DEXoRCZ8/lHFVULuOlS7x9hEgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XvRQBxeHJ8IGuBiyBscGTyUsWY6KjOOQGb5zlp8Cp0CPui9Ga89Hu7h31IKp3nzf6
	 R/fsOF1UN4aubtUh2gnbLcB3LzKLHFvb6EjZtFawsT+SMHNsDMTlSTWgYXTsWiK1ZP
	 X3hs4u7kdJq+axeBzzHRoA9UAHo52fYgQr5QfSYGYz0nArNc5+4QsEiWfmQWWKSNjY
	 y+gl8DZOySzv2/lSRP7qPPMOfnZAL9PxjZfpSuMau4Wlr7mluZHWDhKs8E9RIKL2L6
	 +ULPTmR8ZXESntAhHB8LUM/KfSILpmPQWsTEIfZ5sfkLi7t/x7Ww0k7EG0yPAQsvZG
	 DH7uRdEw1Pn3Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c86945164so8750971fa.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:06:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrntn0zO3qphPykfv1F/PWROIsYXIJqxedES/JiRt86+BtgoKQRAZhjgV3OCnkZ/qg5R04kLVyLgcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1FnmcPFP7u/zsWoCE4RC1DK2Uic0oFpAtn2Y1wgck5YrzTmb
	9OjUfy6FbFk4MItn5RqHyW6fkYjtbMCMlcH7ZPH5EvdhTQY10zNE8/amMpJFjWye4MZ6exC+IOk
	Z8fo8J++dZtSUglakobDItGpdMmx3v0Y=
X-Received: by 2002:ac2:4898:0:b0:5ae:b0c0:16bc with SMTP id
 2adb3069b0e04-5b2b2f54f6dmr632866e87.27.1784840817527; Thu, 23 Jul 2026
 14:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065802.689530-1-eleanor.lin@realtek.com> <20260721065802.689530-2-eleanor.lin@realtek.com>
In-Reply-To: <20260721065802.689530-2-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Jul 2026 23:06:45 +0200
X-Gmail-Original-Message-ID: <CAD++jLkmuLq0r_mUJQdD_zxgvYsJiDQgFPGm5mkMey_U4oqzMA@mail.gmail.com>
X-Gm-Features: AUfX_myDly8tDD54v3kipn3n2HPbZEMuZ--u4-RvGSKAjf0H-3AkWAXErQ3NZnE
Message-ID: <CAD++jLkmuLq0r_mUJQdD_zxgvYsJiDQgFPGm5mkMey_U4oqzMA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] Revert "gpio: realtek: Add driver for Realtek DHC
 RTD1625 SoC"
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: andriy.shevchenko@intel.com, mwalle@kernel.org, brgl@kernel.org, 
	tychang@realtek.com, wbg@kernel.org, mathieu.dubois-briand@bootlin.com, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org, 
	bhelgaas@google.com, o-takashi@sakamocchi.jp, dlechner@baylibre.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux@analog.com, 
	linux-iio@vger.kernel.org, cy.huang@realtek.com, james.tai@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 8:58=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> This reverts commit a57e27c43b0315ee86c6896510d69be5257e093e.
>
> The driver will be rewritten to use the gpio-regmap infrastructure
> once Andy Shevchenko's patches for gpio-regmap are applied.
>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
