Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003B42DA3F;
	Thu, 15 Oct 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096989; cv=none; b=N2aGpSJf92/6M2KJfzsDPuoUm99huo0BhgDyIWDfvNNk/v4KoQbw/FJG3yWR8MMCHk0tmN/w7kOzYlWTMVYnkNcCuBnr0yInEWEcjMGX5eVS++pud/xojI+lrLRwLIML+1a1PsBkV9YvdivbZbpIQm+zX/ezrPcIyar3nbSoGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096989; c=relaxed/simple;
	bh=pr5x9Oy5kRt7mW+BUk7k/FVWfwFLBzKn554o/sTZ1aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjyY9o76POETbR0sgT4GH/sA1R0TBb7+9xVpaipp/JlqwYYsZvttdQL+raTnRV0dknJo5ggs8zWQGC1Zr4N3s2g+qUbiAPjJn6Iw/6kw/886AFl7gJbPAyNcnkce9ojk47g0FX1CPSlaOdRuaWwyPynFLee8SqKoGICXUd/On5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWKUem4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWKUem4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC251F000C4;
	Thu, 15 Oct 2026 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792096986;
	bh=Z32cr+2zpC1ByPRqQb3sKosGGUM77X1spoPfr6I4FJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EWKUem4N7fl149UT/ZgYdhE09OSePyi0EPkqpkhRPbVf8ClPuqV9o/lTMD6BqE7tT
	 RDUfVhkZcg9+1i5eUK03pKIA/06nB97+upAAv051ZuupUarnsIJdjV3F6x5JoB6BWG
	 kzOpur5y9Cb347Rh5ux7uJGiViqrzNpX5HOKkP0f4ipBMIP42aWK6Sk1phBZqXFM9v
	 6ZBJu+Khb21srN7Y8dAXkahbvh/PTGiNgoLQJDJpN7iEqtI7PC+C7z7uVV7DL0bpfc
	 HVskZtOvrSrtkgGp3+5qiOi3VZOP2EXvq4tpmxfGDhpwrEMu/7GS6LAAcQtMM49FQP
	 TW3+hx9ZhMPsg==
Date: Thu, 15 Oct 2026 15:43:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Radu Sabau <radu.sabau@analog.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <179209698354.3152231.7674208347588415958.robh@kernel.org>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
 <20261015-adis16607-v3-2-f972d4efee85@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-adis16607-v3-2-f972d4efee85@analog.com>


On Thu, 15 Oct 2026 12:32:59 +0300, Radu Sabau wrote:
> Add device tree bindings for the Analog Devices ADIS16607 Precision
> MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> gyroscope, triaxial accelerometer, and temperature sensor, and
> communicates over SPI Half-Duplex.
> 
> Two variants are supported: adis16607-2 and adis16607-3.
> 
> The binding exposes optional properties for:
>   - An external clock for sync mode (falling back to the internal 8 kHz
>     clock when absent)
>   - A hardware reset GPIO (active low)
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 82 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 89 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

