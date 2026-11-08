Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794099926;
	b=LUZhOeZZQ+eVnUN3E20CIwtEDKWC/MBECJYmqekYvmtKNmg5sF3Tc49/fosbMzkBYaGe
	 COGgI2MSIcjp84vVP0pB6mu3O3V7vh7LdnykpvNapXLwui4tCeg6nM68+u6DIlRFJLnXd
	 Ee4tLvlx8hOMj7MXoIUvBRxqX45NQ3fq2Dswqll5hXakmq1nDaHeXnELVjZa6bGiWK8Av
	 AfuxKxWV2lHRG0rszTua4Zl1gV5fNaZV1r+siX7p2Nljy5BpQ/4snuZCtiqNuJ7ZkLF7P
	 YuPlXigWny9M4ZWSBtCRgUFHpGmfX4AXpEtDQbwB6H+3sIYI/hpLcDHjAsop3t8oAwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794099926;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s9vNl6j5keI1fuLJDh2rJ88aQPvi378GA98mWcOoxM0=;
	b=l4hnjgMqgPjjMY5QqaHkbAQJWnBXmos4EodTy0t7ADzILMMtwqwz6R5lRrF2Z21t0McH
	 nmCAb0PlylSbWTBKgw8rso+0Qt6fdmqX2mNPkUWLQdc+zvjhafu8aR19EdjRJrL1Bsk3E
	 3U4uIZeIv4w7rCCGzhC55hfbMr2V5H6j26CqnlIZwFBT2inIfFV7pLV27vMKqSeI/YtFm
	 l7uT+MHtGDQXQ55CPgWBN+5LkVdg86+yCZ8SmrYKhJ+KYBKRjJM4XbI9OlyvTwqWLtb9p
	 rizxnusmT3zggT5WV9x+lOpKqJZgScjnPg6q9AtOu0RZ9TNnpcwXLry+OTsfdAt+3+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVtJM0TD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E914606A326;
	Sun,  8 Nov 2026 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVtJM0TD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C441F0089F;
	Sun,  8 Nov 2026 01:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794099925;
	bh=s9vNl6j5keI1fuLJDh2rJ88aQPvi378GA98mWcOoxM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LVtJM0TD1SsHZ6XH6hK052Dfux16AhUkwsdi+N72suUy+6OzcZhZLORUN+XdwEkRM
	 6L851rUEjHaU1MEDTf5yKlY5/l0UfCBGgi/rpY7i5zbaeflpb09bgvfmGpYLBe0gik
	 fVGeZ1RN61qd1nzDzOwtvw96aDoSGbJK3aovl76G2QosGQDYPxN7msxjBf0xsU40kA
	 3jZR6MwgFxE0yJVX5HTFI4eoRA831R2529F+BXvCWymg900H3Kl9LVPuy0cWVDhlLr
	 kUXUPUDt89bU6orNp/FM/QFyH7m1u3CLYGF+fvanj0khkExEUYUmV9lTsMqeUuTalL
	 664NPVtGLyfbQ==
Date: Sun, 8 Nov 2026 01:05:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iio: chemical: sgp40: Implement
 turn_heater_off-command
Message-ID: <20261108010518.5d9c0016@jic23-hlaptop>
In-Reply-To: <20261102095602.333752-1-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
	<20261102095602.333752-1-jmatko@utu.fi>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Nov 2026 11:56:02 +0200
Jaakko Koivisto <jmatko@utu.fi> wrote:

> Add functionality for turning the SGP40 sensor heating element
> on or off manually. After turning the heater off, the sensor enters
> idle mode. Track the state of the heater in the driver, as the device
> does not expose current heater state via any register.
> 
> Turning the heater off saves approx. 2.5 mA compared to regular
> operation. The heating element is automatically turned back on
> when measurement is performed.
Hi Jaakko,

Add something here on how long it takes to power up.  It
isn't obvious so far that this should be just done via runtime
pm and autosuspend.

Normally the argument to have a manual turn off is that time
is huge. Otherwise, why not runtime pm?

thanks,

Jonathan
