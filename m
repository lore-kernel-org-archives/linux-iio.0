Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11548CFC;
	Sun, 18 Oct 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289452; cv=none; b=eIncVWVYbqsKd7udgJZGFjRUQzMOecrMrxzUvCDfurJ3yoXADsuzaByVL9Yt0LOoPKdGpruuDB12BrVj93AxkuA+T4tuK0n2UHWply3pIx4S3HBUYzxNSuyxg4lNtBhjPKM6WCmmSo+ZwyUjYrtGoq72dxVp3U0+AU0/JWqYdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289452; c=relaxed/simple;
	bh=zpXQBn2XhZVzpp6oTvsw/Ay1RZBgakS+WFRDhrX/Ggk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYIhctXsBTy3PbPaEYWb3gjt6gIQUPr+vuKek7BljUyR01SeXxn7ns6wxCOAKKWvDGJUwb+wzMifHNdLgxl1otzdeqpnZSRVBMKHAmrigmczpzDw2muO1sYNP1+etAgNUc3zX/+O8qqX8vtVpe7dxCSu1IzZE+279drvr8+uVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iftjxYD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iftjxYD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DEB1F000C4;
	Sun, 18 Oct 2026 02:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792289450;
	bh=cWWC0GEZPuaee9rjIqCpoxEVHOWDSeFCw4ifYzRKZM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iftjxYD/Cna5z8zfd8DxoSbAohksxvrcAuYTCdRRezhplSi5bzGdtU7KAKSN1YDBO
	 X1/uvYgxMwi3Gx1PvzMQGyZ3Rxuq6zgG8cU6gbAXiDGjHHnj9/C5dK+/nfyMySuiOx
	 29YAudYM8xq2wIboxkBYcBm28AHIn8aQZY+SWv1t/ytQe0lXwe8eszVrFIEwlHhMJI
	 rO5DolIt8PFJ54RNSEsTB/2o9+KfIBJkwkfqWuAAcTfpNIjknYPOkq/+KQznwJm9++
	 zRiebsh/tyLd4YyAOm48AaMaYi420LhCp/STgIvCP7X4SWMeHimBvkk6ES2E93q8gk
	 19vga3ALxk80g==
Date: Sun, 18 Oct 2026 03:10:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, David Lechner
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
Subject: Re: [PATCH 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Message-ID: <20261018031043.004c9f13@jic23-hlaptop>
In-Reply-To: <CA+V-a8sj8LnuHGYOV7Et9KXtcKYrSZgP5cgYqxCiE0VCSH_Lkw@mail.gmail.com>
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<20260929124248.237032-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<arzX2pzq_0JreVJe@ashevche-desk.local>
	<CA+V-a8sj8LnuHGYOV7Et9KXtcKYrSZgP5cgYqxCiE0VCSH_Lkw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 18:14:35 +0100
"Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:

> Hi Andy,
> 
> Thank you for the review.
HI Prabhakar,

Small process thing.
When you agree to all suggestions, skip the email and instead
thank Andy in the change log of v2.

Too many emails... 
Note I send this message about once a week as everyone is
too polite for efficiency :)

Thanks,

Jonathan
