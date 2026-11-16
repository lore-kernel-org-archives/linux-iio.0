Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832045;
	b=DanfBqPFpZkw95rvywfgEDOxn/+2iG2H1R7ZJot84zB1MUkW3hFeHSGZ+A06gUdSggYA
	 I7SAqum6Ep0hcWu8x3rzhfbKP+CDKUonxLe538amlN/C0lU6521nUff9YSJK++BvWbfVV
	 gtjY9v5HsqKUzF2ZdCC66tYXxxzVxD/+B0cF44LzE6vfjkObskH2MitGqMy+8lwL7yo7H
	 KRHOpeb2WLXuXBhglb2SigMrUmgosXAx+TW1O65EIBpNdwalzrOwBpOAfoDZIOIWm2+3R
	 cbv7w1q+qzrzdlIV7flLyH5HebYtliTOD1W2Qs/Rg4V2OQU3c6rihRHAX27g/+WK4jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832045;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e+MXT5G42ichN0VEZBqXRUEe1pc7/5RJl8z2YA8uggY=;
	b=FfBv5x8Kwi86O6wdjIgkHSov9w7TQhd19z2dweMMqOXnF4QnrWVh4fCptJiYjrgYW0IG
	 9Wd39BLrBglLlLm7yrvJvRt8T/IVDkr0Mb2w7+xkqACA/4gfAGjJW5jkBBrwkzyTXETmP
	 Qa11Lv6agNe1P2eyZOPHcuFkkiKjZBMX11ucSeND5iVsp+SIvZ5BEJm+qy+ceVHw1JyVN
	 XnpTg+kgRCR6HC+gScTsnc0/VHlucnlGs5punEMkEp1IotdDhAYV9JzeiOzUXNip2jJmI
	 wOGOh85jm6jXXU+kMpBeEKUZ6cc5wCyKSuHPuDmd1VKVmJmyFaLh1NlKJRA2u8eLlTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPgOJ5oY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2877606A32A;
	Mon, 16 Nov 2026 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPgOJ5oY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E071F000C6;
	Mon, 16 Nov 2026 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794832044;
	bh=e+MXT5G42ichN0VEZBqXRUEe1pc7/5RJl8z2YA8uggY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WPgOJ5oYivlHCrBMgmJ/+iUI8QDUenv567pO0kaLiMgZ4J1WZqZEEpuAoECboass9
	 30GO6vP4s8UPYt7pcyd8NjurRl0gKMOy9feY4TgPeKgq/ZpdzkjqMRO1slxKcwqocm
	 2P+xa1LTxDSSEC1/1NgTQOUJ3cslLylri5QSuJ6F5JhsSsHXbgj2qexOkXuIDB8QDO
	 zcKopcc6pe7mBm7t0SelS4+ZT2jcXougqsy9cigZg72FATGTzD3WHBc5+IC23BGjr7
	 VzXXJv0uJwY7WiCBJF106OVWwif1ipA6aEYAthWWc/EJbFQwJeGNEC79/pzCgWxk8G
	 vzImZpZ8UUWbQ==
Date: Mon, 16 Nov 2026 13:27:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: infineon,dps310: Add
 interrupts
Message-ID: <20261116-neon-spiffy-chipmunk-cc91ab@quoll>
References: <20261114083828.18059-1-zoone.rupert@gmail.com>
 <20261114083828.18059-2-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261114083828.18059-2-zoone.rupert@gmail.com>

On Sat, Nov 14, 2026 at 10:38:27AM +0200, Rupesh Majhi wrote:
> DPS310 signals new results and a full FIFO on its SDO pin. In I2C mode
> the same pin sets the address LSB, and interrupt polarity must be the
> opposite of how SDO is strapped.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> v2: no change
> 
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> 
>  .../bindings/iio/pressure/infineon,dps310.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

