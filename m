Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37398223323;
	Sun, 18 Oct 2026 01:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288720; cv=none; b=ZVmOZZKbF6TdDmUl599WioiUCww58y+2FLOptmK5OG2NDIKYhN8spensJJwEMuYBcpW/BVLzjoQOXrZK/zBel8e/XTQ4wo44CGc4rmwuvqeMAeREzNs8Y1UN45ksIM1IYHkSpVUQiEnHL604pdcTOer14ffAX6trNY0Tgxgil1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288720; c=relaxed/simple;
	bh=P6aBy6S7q609HPky1XXLJG6LqAk2c3vL9aXkEBZjGTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TK5vSYlnOBeDFk8vHdq25JIMx1up5SfROUQdbmKfqLfwN/XcM8G6CsrN8HTFuTTZ3lcHqewwQs6EhU/c1jfXMy0QxtPmbRiog7R6/zmcdwzqtdtfwftBtrVIihq56kkIVeff9Id3NDpWpr/qjApn/W1gFnUEnHTztpJXTWOdgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5FVT1wH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5FVT1wH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A911F000C4;
	Sun, 18 Oct 2026 01:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288718;
	bh=dXoumNlDNDQ85jCCZ7MtTcY0yu6193pOQRtkOkke3mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U5FVT1wHisDMKhwWJ8RQ+x/aridB0seUUK2SYBGBreo59gVarNbIBZ4TCy5/8wqau
	 aEjUAMdraA0UWv+c3LWa8bEm74XkjUXVfB/r8cNMKIdw72RSfWi+LIzIyNanmv1i8a
	 wpk8U9um0On2S2COZI9IW5brdBcWSw5nGwCgWbztbX89pd6WWc+lICqe4jGLQGpvnm
	 71Z2UEBrQOTdKU0oWKZC2YU0NWVXahsotB05yVBD/d/BkF+IIPH5ea7kk2fsALxuTt
	 eeDpqi7fluu1/5tkUp0eStEfAsLgxjcYqbulr2qZksR7xxVbMsq+QFfXz1BFvDt9GR
	 lzOU44gD7nGRQ==
Date: Sun, 18 Oct 2026 02:58:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH v2 0/2] iio: adc: ti-ads112c14: add gpio support
Message-ID: <20261018025836.00de5da4@jic23-hlaptop>
In-Reply-To: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Oct 2026 18:25:50 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add GPIO controller support to the TI ADS112C14 driver. The first patch
> is a small cleanup to make the GPIO register field macros usable with a
> GPIO offset. The second patch adds the GPIO support.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
I took a look and have nothing to add to existing discussion points.
So from my point of view waiting for a slightly tweaked v3.
(At least Bartosz' first comment + whatever outcome of discussion is)
Thanks,

Jonathan
