Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4630BF69
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701046; cv=pass; b=TCzN6QtUW4xi1ls6ZOGVRL1EWkB0pyA32tIm385YuQ4ozuziJJh69dcJxcB0H2nvHVZ/4rIFZ16+b7HFWWV96ujc+P8I5WcbV1g9Azv3STLwlioNUK7yEIy5o/mdfRoUSLJ5AYkRV+cv6Ndz4quBisP8WbdcqjW+Msra4t+QcYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701046; c=relaxed/simple;
	bh=FyTzPV5WlRyEqbfHDKno6beoQQZo7f6ORda2KXadw6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgN+gfUz+MMzTMK4Nn8imBwC+OPiIRe1YALMDXjrapO4gAD9rVnbmqe0uRil3sYiutOfLoseuC6Wiit2u7fprecmf+a4JRo7/9YXupmEAS/JWJEjyJTYLvCMFbPqPl8pI0fRXZmGKBypPKAaY5OnKbeGGYX7mx450+t9vGPCOno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI5wklyd; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI5wklyd"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8871718b05so193288566b.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 07:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769701043; cv=none;
        d=google.com; s=arc-20240605;
        b=VvHZbRKCJafZKlmb0MKhf34f30E6Jm/Z9M647gRPGNvKZqxNquZBXyyYwcIUV9FBl0
         dG0I2S0JE25068cv7ctBqkhcL3D6X5IDNkUvee5rEdvMLd/Zy6mTOcur08g9mMQoqo7U
         b+RMbm4cb/cUyMugUDbPcEKvf5O8lszaUZivSKpbyPXOdY+naxKw4QF6n9OVuETESNEk
         iPRYDHZLYauUDniJo8YZo6sH70bE8uqRTNC5Mi0+ILHGt1tQCZbcbADB3Vw3B0CEX0I0
         S7FMeP8vzml9OJ1qz1/Diy3zePrGdnAVuHSNonA6qwJ0x7MmZjgoZjjGsEq18F04I/Gs
         GY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FyTzPV5WlRyEqbfHDKno6beoQQZo7f6ORda2KXadw6E=;
        fh=VMNuRQgpmnv+EwnUqdlrE/ZCmCwLY1GXMPf9eaOGX94=;
        b=BsExQuEjOw5aPQQCJlqcZkTlud1mcThKN9HLfano0S9NBu95WGtLIu0C9AY4JhHaZ1
         aFjhYuo2p+cCYiL8XoPUrQ1ppOobV5WNZvm69Yrbhb2d61kcZIdqwWBhZ+nCdFas/OtW
         vmJhRDdWnB+MWGCQ1Qhjr3uxMzDmjDhIkOgvKBhvZegi0AE8Q3QghtQTvGgWU0Git/YI
         Om3BGp/fY2slqC9+TzNq/mywDA2CXcgnuVpUwF+g5mmdEGMWJu5LL1n8YWEUuKqupuTo
         9Hy/XKD3eD9axLhJFcqCccF9E9CwITUB1r7Rd/0umBQZUSzolydxHTIUZdqStFTZrk1X
         fLHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769701043; x=1770305843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyTzPV5WlRyEqbfHDKno6beoQQZo7f6ORda2KXadw6E=;
        b=FI5wklydIPio3rNc7/+9f1XYQMvc0blaNshqKZF+MGuvArV3XaYhR2xUlcPabo/3Kq
         Yt0jEcSi1P6rzw3MpwuB34dtz/BZJ4PQZftIqWxiVckbCo/cD2JoxUT9xonvA+2EcekO
         BTzbO0qWsmkocBYeTskLHHhH9K2KL80l9DbuyojcD6DCjsYqLPYofKJG6jZcM+eX/BK9
         ealcw8jd6jBAI18euK6UixoEj9mc8YFtKKITI2ax9Cubmwbsbh1AWG3KCPxuRnn8mQL4
         9HjzrCtRqWh/eJBf0W3pHUR6OxhfctB1LVV4RdF/KuvWhEMQrwmrFHW+ojaYjrjptYty
         2iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769701043; x=1770305843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FyTzPV5WlRyEqbfHDKno6beoQQZo7f6ORda2KXadw6E=;
        b=Sxx4wwVF0fCxQGFsx+dWAmml/mlov7uObrO7BVeEVBJV7xSZCZRxQE46sbGgoJFa6Q
         rfnPXy0j6ryC8jlQFEkVOeRAYh3UvI2m9tHE14skSrZXqxJvRdDEo5ZEHk5u1B69F3NC
         fUMseAboH/hpGqwXVGadQZh4dcLGIRK0kXYUzFRV4l3sepBdKX15qi5upAvz6WpiT7hr
         ULwDtpiAe0WsMSREvVs4oVYwXlx0YEmCFl9kkDIhUAu8SMj5PQwrzfqmickYe1pgM99S
         dBUi38Olne5R3yLmLTSvObb374RLA05h0egxB8BdBtPJ6Xcs6L1895bOdvKJLy8kBvwZ
         69Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU+wdsw/ZU5jEkqkeST0BZjT1ISxSorIh5fcxNlSTOreTaZolVZVZkC12NEB2CNVO0uJGznJHDccpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0gjBIiKY9aEYAC6u7X48jAGZ4OBjUpXER4brfDdqY6WsxKvL
	rf6h4z4eyQNEnHrzMGuOgcj/XIXPLsxaSlhbF8FHVxfsyiRVVWug7LhQ0CNZ424k088Umk8S2lr
	3Fh4ujOWwYbbRm3MP3+Wxbokq136T5Z7TH6Japv4=
X-Gm-Gg: AZuq6aKLYalIj9OBdFROUoR+l0PKFreGNW5oqvpN4nWrVMrrmTP9x9k7z3bog9rfWAF
	e5n7ptqVHpklq2UQb/SkyOaPs1unCZZydIn9kJ3xKvh1ibuEyYyqpdlGg1nKj+u0HkJuZdy6z3h
	nMVmszVlTqulUDmHKRHjHXauchHQjpVhbDEi9+p4OVXQpkwzjRWlfn4sGZFRQaFqwChEIkf+z8J
	qi/XBI/gsxNALQVhZbPoIOLC6xnakB+9KwjNVHfT+7dTzbYYnCohdXvNbP9Q92xGV0AUUBzAK+B
	zTtc8hr/N8naIXKL6JUY9rbgiFr4OGzcE1BbIpsCIMyZQ2gG7G+FsKVBHJCV6ypspTurfYw=
X-Received: by 2002:a17:906:dc92:b0:b86:e938:1b3a with SMTP id
 a640c23a62f3a-b8dab2ddd24mr597806166b.17.1769701043258; Thu, 29 Jan 2026
 07:37:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
 <aXtuexNdZhKvfAg6@smile.fi.intel.com> <CY4PR03MB33996493A5C4921B8C8C3B899B9EA@CY4PR03MB3399.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB33996493A5C4921B8C8C3B899B9EA@CY4PR03MB3399.namprd03.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 29 Jan 2026 17:36:47 +0200
X-Gm-Features: AZwV_QiFqg7FEq9hN5KtAYdDqDBFxlc67c21GZ_n6RpWHsUBooCicZI6MxKWUH0
Message-ID: <CAHp75Ve6OVf4zaDWg-DF8fHDx7sU=ugtCoV6QiNfjskOQ+zF2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: accel: adxl372: remove unused int2_bitmask field
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com>, 
	Andrew Ijano <andrew.ijano@gmail.com>, Gustavo Bastos <gustavobastos@usp.br>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 4:38=E2=80=AFPM Miclaus, Antoniu
<Antoniu.Miclaus@analog.com> wrote:

> Btw, for these small changes if they
> aren't placed in a series but individually I guess I can skip the cover l=
etter?

Correct.

--=20
With Best Regards,
Andy Shevchenko
