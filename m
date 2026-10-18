Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005812EEE92;
	Sun, 18 Oct 2026 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290380; cv=none; b=Pd6sBLwOEbkgVzSbE4SmTq3oOQywIqjwuGpyaq8acYutBsFu1n65V4til9iJ9ZHjPs3IXiD9pcmTmuVd5ChPuzgcEawqbN5aIUCHO2/k0/MMtbthx5hxF0fVkw9oS+oyFumtakbbD70DEfvOfeocPTDH0hjYdr5kmKyeoBnn7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290380; c=relaxed/simple;
	bh=Ve795yvJwUGgK/kSEsrvMHMiTuVSoavvckp9tX5FzFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3IJB+qTFqYFj4zHh+E1MkkvDSDm/5pRFqHqepnWlOStgh70CkwvzXm+7U4So932gExFtw4ZEzjE+T8aWRVfxQoEWAjboXkekCSvK9vV/tDqhaNYeaqnqb94JKCgCM1ODtVBmOGCS+5YovSkCSTH/wOXEkL7u9cf0gVgHZ0evuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO91ovrH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO91ovrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9FC1F000C4;
	Sun, 18 Oct 2026 02:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792290379;
	bh=xXKPyHl/LGSTvD/ZR1AJX6i4+EM9IomOsateGYpjTQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AO91ovrHR6vvesRRRjx/EALvi0NsHERwcFXNpi0ywuQTqy/HijDrM7j70lbTKOHJ+
	 KPzNMi5k8dzY71BALFuWTpFCBvXlFa5O3IvfY96ot9jg4mAeLbneyHFs0C8JjuCzoe
	 Igs7V1q2Gi85rOb3ht81vZpj/vefPnEPJrCWOy7bcnJh4LpEDUK0JCi0XS7NSneoD8
	 zXwUzcC1buNL2Gh9SDzsW0Imjue31LvVePcbijWgYa76tJUFTWLlr0qJCqxsq1ZhC1
	 /0xy5TgFHIZgf1vyiXiHVfBzjB3V7YA+FE1vVvXJyLFOg1aV0WVnKfmWdFHzH8pRse
	 zmEEnHNvCv1wg==
Date: Sun, 18 Oct 2026 03:26:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 0/8] Add ADC driver support for RZ/V2H(P) and RZ/V2N
 SoCs
Message-ID: <20261018032612.3e50ba40@jic23-hlaptop>
In-Reply-To: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Oct 2026 19:41:14 +0100
Prabhakar <prabhakar.csengg@gmail.com> wrote:

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi all,
> 
> This patch series aims to add ADC support for the RZ/V2H(P) and RZ/V2N
> SoCs. The ADC IP on these SoCs is similar to the one found on the RZ/T2H
> SoC but varies slightly in terms of available channels and configuration
> options.

FWIW, I took a look and this seems very clean to me so hopefully
I can pick up v3 with the minor tweaks being discussed with other reviewers.
