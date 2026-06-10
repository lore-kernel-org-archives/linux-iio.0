Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464F3358CA
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130286; cv=pass; b=Ocd2BMUR9LhGg/L+6ziMt26Db1iaj91EFxZDVOAqR6kV1NwoQfoSlk/Tvv9p18GMAVWx3Yx6gIIDUjg78vjAN5rNqQhyKFhC/sk5PBGXiiKpBJO6DO0rnYUa2UfmJ00D9MYr77Bndc0t26ZRvU4naG3QBcDR0TNfkRag5iYTH+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130286; c=relaxed/simple;
	bh=GFOUhfT9LXVoIexQueNFZG57jnrIS8Fo28w9PXTMHIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dY2s2XRuHAJ5v/mASBvuIXgVEsPg8Rmk9Py1H55lxkgx7PmQJqIXlbXWL9W5z9WjJlG7pCpx9jR7cPcxL6PK2a0P4VyuFPrA9vLwYa6bbtUAVYuQDrr9y6Po8lPkwmO43/GeW6WT3VGZl6+MvXbx+XkhvCmWGybIbvqT5PyxGFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebQpNY7j; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebQpNY7j"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66077f6c438so6623074d50.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781130284; cv=none;
        d=google.com; s=arc-20240605;
        b=iGiEqp2Q6gut6eY2UTbnUIffnhdiPmDURpbHr5Uv4fs8qrLd46ERxYkhlC9Y1QRcaS
         1S8mnfgGVFOnvzS/Whqdr/TOuU1AgU/LvLZ12r31qxFBpyU2TkkOrYI6vb2IG/8B5Itn
         QSHHsc7aOShL1gzL+LBAoiEechk3V2Ke6aiXwWYPnZUSShM4iKF74Bo334L7edZxgLuu
         kjqvPrevhjqbLsx7992Ck5N5t3bXCvXv4Swxo11Aky6kZVvOvPRQKNngUeYAYkcTd7YJ
         MLsIbdNfm5JR5pFjx5AZp89dE/iV0JKMI/02cek1/pirhWZ/a0LSxhsuGVH32FEtoA7J
         4neQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GFOUhfT9LXVoIexQueNFZG57jnrIS8Fo28w9PXTMHIY=;
        fh=POvyY0hef59M+SBwCucPKdslannBxPxrwgHJZ89UAQ0=;
        b=jx7kptJnAllacYBxnveYOPSDM0W90INnXSoMd7OhIVle1wJvx/BH6Xz6w0Y68/CDsF
         W92F+GG0pzcL00n0DbAVjSwCIpiVYnCKpawAr3ZdQa242fDvywkjLuF1UOig6v/gcfcY
         ZGeKkZ4lvS4g1yTxAnrhArcHyQ4qERYXilAFZ6/Z7hE815ZW5LQO78f4bePFzwDdQfBW
         1Fenslobun9mia/du3S0YCllRqwk1lcRA8PdGlRyd3vq0n5j+3mJcgPp6EhLRqEiak2I
         6mKhz5UHT/lr0fnUT3i2utM/72uP4HZ/b9dJS790xeeu5IFhmBiBh4fYxdbC+v2xSJsk
         SeoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130284; x=1781735084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFOUhfT9LXVoIexQueNFZG57jnrIS8Fo28w9PXTMHIY=;
        b=ebQpNY7jzgduruCcPrOg8SdioIRDchbS5MOIeeJAQAgUQqLmudo/mcmyUGy5yZdZl9
         TlvNeCZ5x9391NzFa4fCCcQc0sdtH4lpqgpeb0XY0sCCcx+t4UiKtrjmpNYWq0zcGA45
         GILznmttyS5fhgpCzOQdHvanYRY7OQxWJ64hRIy9CVwWqIKd0/MkD7HxO2rjOQ2up7pm
         DTDdvBspKzkl/IL7vSs2dTqweowhzcLHdijSWCiKJZzt6+Ub/WKTxdipRxaVY0fo7Bm7
         xcZlRNxMCgXKIZcDbe3/GvIP/fp0L1h8tX11s99Id/5ThvL4sdYQT1QzVEx1TNELHT/5
         /DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130284; x=1781735084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFOUhfT9LXVoIexQueNFZG57jnrIS8Fo28w9PXTMHIY=;
        b=Fskq1zGE5EmkuF5ojr+zifDx1Tjq+N10EtAh/n6n/RWEwUfH9JKbF7YIO7C4VfM8nV
         i2qIqLpiYjP30jpeRwTogWI9bFjYV/U2MeZrBng3le1X0IKoFDecrO/rEkDfZ5uTRPA0
         k5WhzMl0RcNSP8032JGMUYOoZjCh8lre7N4wMG35VzoA8mYA5xQkNJWUJo5SHOnjPU+k
         8tzNwFY07CsQCS0ZX5NqtuFe9goolRz/YEtgun7VptfLNuuwk+dJ7t4e4WgjnJgbUv6T
         e1eaUHq8/OU9y6WYdzUuWznAINHI9eKM5ghRv7DeZQr9JMHx/XMhwZI3o+hkw4MpN/Wm
         GyuA==
X-Forwarded-Encrypted: i=1; AFNElJ8/KNKNbvPAeOuOxLAOLmEsydS0EByrufMSjCF8wL9qb3E2LEz0s1lvAr3nJdZxSU5T4pJgg1rFOBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzatOx0v1NWjSXpmKf9JCn9c4JPwkX9Lrmb8NwPdOmG2HIEs3h
	3Fmr/DL50PjYrOZUo18ZTtfxCGobLZEqDySs6RSOg9iThHeSayURK/+hPBat4I+n9jaj3NEwrPm
	6oVhatGMRS4NeeEgF6vSyoXdlabCiE60=
X-Gm-Gg: Acq92OEM/6OElnlLh/3rMwnJexfxaH75zmqQmFHXhMSgWR4S5CZdVgxM8v4hihsUIgu
	AqZDFJL+XPVTJ9ojZ+lDXRE6/CHK5vALgnRiYdr0lJdX4TAUC0h4/DWqhMw/YF9NWZRlrCzD07p
	Ex8J+QbvdcXD0ricN90vxanJB0JpTp1BXkDipmM0aPWyypPxGSeHvcyLelCn9ElS6cQYV4zenuE
	m9UaCKcY1PQO+RYMcZdLl9jFNDgOty2/RdmaUlME2tO116zPZBicQ+/MTN9LxVVTe3tinfIAbVt
	giIqkkYLfT3mvTk=
X-Received: by 2002:a05:690e:1908:b0:660:e9fe:48aa with SMTP id
 956f58d0204a3-66106e0dfb7mr24207826d50.15.1781130284449; Wed, 10 Jun 2026
 15:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609160326.45123-1-m32285159@gmail.com> <20260609160326.45123-3-m32285159@gmail.com>
 <20260610-pastoral-dark-ostrich-5ca3f6@quoll>
In-Reply-To: <20260610-pastoral-dark-ostrich-5ca3f6@quoll>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 10 Jun 2026 17:24:33 -0500
X-Gm-Features: AVVi8Ce9qyMQsXZ2KyCqcF6JmCNIPGuspde0vMgV_QNyC6PkUH0aSbo0weFE1ts
Message-ID: <CAKqfh0Hi8EkShh3s4dUqAJRDExQLR0NVOvd4An+bY5hat4-Lhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duszynski <tduszyns@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:09=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 11:03:26AM -0500, Maxwell Doose wrote:
> > Tomasz's entry is no longer valid, as he is not active anymore. Add
>
> Why is not longer valid? I see activity in Feb...
>

Strange. According to git log --author=3D"Tomasz Duszynski" last commit
I have from him is 2023. We also did have an RFC open for a month on
linux-iio with Tomasz Cced with no response.
