Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83442EED9
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607209; cv=pass; b=Q121PyOjlKRXtkPpoRS2lFrN3Vx1gwVN5/qZ4V9gfUZ5vvO4KCzdnajAH+BjBUgGxKbOXtxvF52IjYK25rZrdZtxEof3bdRH2Cu/d4IXswewq/By56eV8YkVqC9Wh5i4KnzkoPKnl6BxsbDqap9vbtbLYxALCiZoreVQQuXSqMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607209; c=relaxed/simple;
	bh=N8jfqtDqkFcR2V41hWjXXdTsDb+mE92L2soubvNIyr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd78eZyTUhMdES4COA6tU8KLe+vVpwhmCfby5fR7aTlZF9Kar9AHFXgz4qGD+h7GyFwcYtd8oF1S4xvbQK2VVbQ3pVG1Yd6q7Ne5kiJ1aTN+xCBX9NnQGbnaHdJkfw1diY/X9Bod2u0XlYSITvqMBgWlN1SFkZ0euyXxmBcNATk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZWZ7/Qb; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZWZ7/Qb"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c029505b389so304200166b.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781607207; cv=none;
        d=google.com; s=arc-20240605;
        b=ce59ggkCMnHNXUBi9hlemjtdPDteeRQVXkFF93I9XpXa0EDuLLNJWToPPwotiXpOza
         f03mGK/0r4fpRLGCiss5dlNIMQnTCZ1SixbVBol15041+OmcLSIBqlk88Dw3bw84xpDV
         pecQ1siFaflmsNdH+l21OCpTtxA93MSbqw+tmZFlX66iyf6OmDtYNg9ho15LCemAy6Pp
         8hcvCb4ZdG5SPikayqNkmXU+CO4mQAybEkBhBHxSLwQl0+Ua5UeLfE3jOpthclqOlnNT
         F6CMQ7kMmFzcgfyEW0InftROyJPtDwXGgjH+iOXJhyp/itHhyBJ2Y3Y6BMd6sQExmmd+
         Dv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8jfqtDqkFcR2V41hWjXXdTsDb+mE92L2soubvNIyr0=;
        fh=1KzhjuLDiEeLKfitNowAeewGc4vVJTi0QbteKVl0txg=;
        b=dBaILBaocXp39iEZnZAXRyzohrmVQLJ9qzqMEggqi4j+oerZ7eHaUpfu82zGk7fwUX
         CIPBGL+rxVg7F0SJZNbwi9EMz8ujO2KTEC0Aqg/l71Bpioz5OxI/NHHKgi9wgH4APm1o
         tg4vT2jD80bSx/Qx4JnrkCT3IKHgC7QuhvKArtGYuORKUe0qo2ofSY362T+3TG3kam1+
         R3FPoJ2CjLY4Xmhw/be9tE5nxf3LuMiPpdnYgPRy1DXukOelVrg2hV8bh1H1CF/2ReTJ
         wWy8Bvfaf4yzEOmN+Y8t9hwAFmXHhwKD9O70QzUsw0kEWoty0bbji497oKrnyVdoQiGO
         9O7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607207; x=1782212007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8jfqtDqkFcR2V41hWjXXdTsDb+mE92L2soubvNIyr0=;
        b=QZWZ7/Qbu5/wXKAAe7BBWE8TKojhl14Ylh5uCK6xTtqKHldqqq2LvZGeyjX8yzSdEN
         ua1IR2Fyay9Qj4TNSURpztEpThuW4ERYTO2PYRAP1FtTguBtuAVHBr+O09m5gTansP9x
         ++g1tXW40DIPrYV+Qf4W5BclVvy24DbxBBNjNNfjzF/oeF0a3mf/nyH2hytwKAucYaHO
         vi7U4xvdCnH8vNXxX6lhrtSUyAYkQkuBS8RLiu68mkPS2JxB1dO5ez9YjuFPR+K8T7XF
         1g3Facb7HmzvdRSm+v1fQzr3uT8kjD8MRGypRP3ab+x2ga+UJC7kXh95yJlkNBjdnwiP
         zNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607207; x=1782212007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8jfqtDqkFcR2V41hWjXXdTsDb+mE92L2soubvNIyr0=;
        b=C+uUTjJYeog41jW5Dj4jRS6fIqWpuMPCEYCh3fqO7UiD4uRdrarP14AHRghRXO3T3Y
         rhyB1y1mXQQqlHTLvhRnQH+Lb80vmJ9fNnKfiHNRnNb2I7JHXxhqjskDcXJS/eDysNGJ
         y/pns+PqfU0XyO5rx53bYigZm79lwBXab2e2wXnSew7SjRHT0Lvqi8lyWdLaks1sfEx8
         no+X72yxnFCvwU3ynaW+unKmTiwZLq+mSfhu6uZwb++oPM0MfwzDheuFKQ/ZkS9/TDcq
         FRmfAQj89jW4ZjVlI3l0qQC2AgWNr4OeeFo52xY8xmWV8o/r3qZ4pT8bSEx4vnlniwKa
         QZuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9n5Gy3tShFAA8xBxS6BngNfgxfbwC+2XWSOLjOjLnxDeJ4ZVFxGlMigVIShS02N5bwbvxzxXBVkCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbvO7c1Lyw/uPbCW6w7uuyeavV7bWj4m/nwB7r+Sc/7DcmGrd+
	ZO7xDC7R2aLRiGS33j+7mcmuiwP5VDtAa7xWPfG505ST7pGMSHwc4HNVMZq23JRjBXBGqjePfNk
	b4OB+zCmCPXrmJDQJUNYvZ3V/95I1U4s=
X-Gm-Gg: Acq92OGYRA385AW80yq73wOJ2m3jIOOf5+k6BJzWX2E79hBkkpQbAz8pDKUDVKTByZ1
	1y26wcZr5F6D2eAJqndvSO8Yrx3/O55J9VT3OHMYeLCl4nroNKNG7TZNqhp16Q8qLVfDvvunsH4
	LzdZgOp3w37xaP63eow/RmHxbUOO2Uv//2d6ITMeKqMaLZkbYL/Voe0PsoB52HbSA45O1chAgZp
	zeo0mnPeLjrrW0/GCo8hOqI12/QUo04Ij7fUfriGC6vwBrdM0JCVP+oatd3JzEI9kNDpUoK2ZxO
	8wgxGS6NY8M3+SMNS9VBaSFDQO8pt4oeHpeK13hrpJ2uhbraN/8qhPdSub78zGMUZSYSQj0dZ7M
	WHA4q9j/eknO4DBjLy9cGcX8BAV9prhF99XVCDRqKoJkAATTzJN7GVuoJSGetBd+mJYvB
X-Received: by 2002:a17:907:c248:b0:bec:7185:d3d8 with SMTP id
 a640c23a62f3a-c0416f22ac9mr172531466b.6.1781607206622; Tue, 16 Jun 2026
 03:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-11-f829fb7e9262@analog.com>
 <ajEo5pOp3ElX4cP7@ashevche-desk.local> <bguen4zngbwsnoxbis7mfrmo6q3vbccpntfzr6bsiog76kdhvp@3lcygxwlg2kv>
In-Reply-To: <bguen4zngbwsnoxbis7mfrmo6q3vbccpntfzr6bsiog76kdhvp@3lcygxwlg2kv>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Jun 2026 13:52:50 +0300
X-Gm-Features: AVVi8CcjIgkH8qO2D3eGoKeWXqvaH9stwzT-OUvZz4L2E19OrwgaPU72O6N3ARE
Message-ID: <CAHp75VeBE12U6dELhtxnL7ah4WEmAMVk-jq7vky1ynzdp_SAZw@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] iio: dac: ad5686: read_raw/write_raw: use guard(mutex)()
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, rodrigo.alencar@analog.com, 
	Michael Auchter <michael.auchter@ni.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Maxwell Doose <m32285159@gmail.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 1:50=E2=80=AFPM Rodrigo Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> On 16/06/26 13:43, Andy Shevchenko wrote:
> > On Tue, Jun 16, 2026 at 09:21:17AM +0100, Rodrigo Alencar via B4 Relay =
wrote:
> >
> > > Use guarded mutex lock to facilitate code review when adding new
> > > attributes. This will allow for early returns, avoiding error-prone
> > > locking and unlocking in error paths. This also adds missing include
> > > linux/cleanup.h. Gain-control support will allow the scale attribute
> > > to be configurable.
> >
> > What about interrupt handler? You just added yet another mutex lock/unl=
ock
> > there. Perhaps this patch should be done before the previous one?
>
> Can't add the guard(mutex)() in the trigger handler because of the goto.

It might need a refactoring then?

--=20
With Best Regards,
Andy Shevchenko
