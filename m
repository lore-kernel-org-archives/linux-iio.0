Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204D38424C;
	Sat, 17 Oct 2026 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202587; cv=none; b=iIlcUR2+qUhR4u9fFwRBeXNhQ7IxYZMkTEoqreUfJY9kF65VCSbcrASVtXlfsVfgAiNbnPu7o1PZ8TN4OsTR6F0Gd3d9zuf4Tbk2ovg2XUAChjBmGMCWQ+5XCy21f4YWW6J91SNcrRpn0OZn1x0VLhBZmKtGYKVcISNnNOwOR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202587; c=relaxed/simple;
	bh=zxDyrKoG6b6BMQdhx2eHnKWY9oMDfv7nDAtzugsa2nU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1rG/8tP1WBferPXKwSUwCxzNnswYI9+FyD0HComYW/ttfz4ZoxU/+q6Z16ZzKtvXukaUYog7k6fIm4K73vpZqXKub4Bv2pksbAAUeWyuxoHvPdKHL3kAi4NKJsc8y5QculM/CuNzTxFv3iR/RLQkp8sXZ3zisjqxhZasfoW57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtOQI9Rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtOQI9Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC60B1F000C4;
	Sat, 17 Oct 2026 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202586;
	bh=LizRZHLnqt6c/yrgA4GIqDBk6Yug6XyQhPvTm9fd++4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KtOQI9RnFHw3a0CoeXTkSzBwQJ+27pgqXPYhVy575/zUoRUQB4hIQDSUtfgjJ7bw1
	 Gfe9NgGIKeUcYqvFxksMarZM4M8pZmo9vcD0Dh+4jmjVhJDnIPE5rTy+9A8VVxLaJL
	 GS7ULmg7O+sq/qv8mAnnRXT2IoM6DEw23O//sC8sYz0/tvyVdNsau0cvHZLs0TgLvu
	 6VAjQccSKrGRP2+H/TqExBzD69Egh3kVt0pp8c1rLJKQSF8R5O9IWE0JyjIQ8ImYsI
	 bGRM6OvkwrYueK24NXVmnfMuRbwj1tkx3Amdv9Tef3ZYXxPWrrqKP2n6SAExISaNg9
	 jXjL6+gvevMiA==
Date: Sat, 17 Oct 2026 03:02:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: imu: adis16607: Add external clock sync
 support
Message-ID: <20261017030258.0157e651@jic23-hlaptop>
In-Reply-To: <20261015-adis16607-v3-5-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-5-f972d4efee85@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 12:33:02 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for an optional external clock (clocks property),
> selecting between SYNC_DIRECT and SYNC_SCALED modes depending on the
> supplied frequency, with the internal 8 kHz clock used as the default
> when no clock is provided.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Just a very quick look as I'm out of time for today.

> +
> +	/* Default dec=0 after reset: period = 1 / clk_freq */

Why does the comment make sense now but didn't before?

>  	st->sample_period_ns = DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 1000ULL,
> -						     st->clk_freq);
> +						      st->clk_freq);
Tidy this up.

> +
>  	return 0;
>  }
>  
> 

