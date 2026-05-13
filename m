Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC12BE65B;
	Wed, 13 May 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680625; cv=none; b=lvW9zp63HizG1J/EmN3X14+jXNpxDmJC/iU5xYK1TpNlB+gXnenKpaKu1V9I2fF9iWTcRnh5M6e0cXLKoRjSfM08TCF2nkDjZlaIkQwPPSrabGP+GxYebL5Z9M3QGaPhjcTNerrt0Dd5/i0rB/k3uqdcaAkcMqGQ0wOd1eiiucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680625; c=relaxed/simple;
	bh=c3xbwWqqAIvE4mFdSGwWCaxg5weV3pobvcOvTfppfOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1lpfv9KvfB0OZrdYisJfIDYvfK2gJBBW3jr4JlrwwWmLvPpIRauAGRikgYHKFXnq/25yZbeQVzs32RF1Jo9xu6gruEpXZJZyDe7xM4hZXjH73r35eSXufqaiwmmjZn0t/HjTgRPtii4n77pWvk3ZPJAvQNp1oFxkLJTBTK7HN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHPV0IIo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHPV0IIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD7EC19425;
	Wed, 13 May 2026 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778680625;
	bh=c3xbwWqqAIvE4mFdSGwWCaxg5weV3pobvcOvTfppfOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tHPV0IIoVwgq4OahstojtJftBNYZDnoZ8z41Mtw0fxKp2vq7RuOwFxgyV9IUMDWDI
	 dPa/3VejRvkmgNKNmquEFJ8Pq+fETlSSA5pH/dJfEwvx8Xu9ybSKa+BB43lSFYoidj
	 tHi1MkGub/nDdZNUPKKyjKRPrZB3D9mgr1WPA+5f3Bdoo0Ye/NN5Kh8UsnWCel78kx
	 oaAaQ+XE2gdznN3R6LIYNek+qWgpVufWR9q1hrTpfXutPGF6ZZ0AyWtVc0cT+5yJYo
	 lEwj6/F9fsNHVAlgHBcacbMlfh78h8tg1ECq37q/zXMdAeCFBUzPsrhnVYqETuh7bY
	 /xDwGWHtKPRGQ==
Date: Wed, 13 May 2026 14:56:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann
 <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 10/11] m68k: stmark2: enable DACs outputs
Message-ID: <20260513145652.7db72ad2@jic23-huawei>
In-Reply-To: <20260513-wip-stmark2-dac-v2-10-fcdae50cf51a@baylibre.com>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
	<20260513-wip-stmark2-dac-v2-10-fcdae50cf51a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 11:14:34 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Enabled DAC0 and DAC1 outpus disabling shared ADC inputs on ADC3 and ADC7.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Subject to me knowing nothing at all about coldfire.
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
