Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B629B795;
	Mon, 17 Aug 2026 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786932953; cv=none; b=jWiy2KtqSJzCTHE+wBppL6w6IeXbrBQtIBjUpjkJwWSeWG38qCitDxOaxVAPeARF74MXF4rroniHJHLeR+dC2N9HBpIC7D9lh7cFulEJ3Q49Yi+lSjJ3cvcrcSGKzFFhJA+9tv/4DkYN4Pq5Q0l3jusfzkyPCSsE0rTA3QPfZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786932953; c=relaxed/simple;
	bh=uf5rmz0+X4t5r5ExXC0G2TCiu2L1ZfhVgN7ULyI4/yo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQmuW8qz+w9/aMwMRzvJJn4UDyfQ13ymv1cQeSOqLQOZZ3HG6/BEMX6rIgddcrY2Gh2aNxUD+Cgz+0uIvPjXSXw4+AYv67G2WuQSxM4HUStu3hfIjKPazhhXkjPH9mk0wfBZZOji9rTOBe5bkltq9hWqwCEuBBryNGL3NbNZKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyMBa6Ey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyMBa6Ey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94041F000E9;
	Mon, 17 Aug 2026 02:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786932951;
	bh=TWfrmKp6pi0YDcTofZl4Bydou6O8L1/TYe8seUAuLkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iyMBa6EyvQYWZ4MKN9l1Vg1yaIVeU5peIJuj9yldr5gjxwLXApVBy3E/fPxKDNI7u
	 vIzccCQIf+F/CRGW40K6Dl2DgKgtLmPfoC3tRYvRhIduk4DWYhyiWZ/lqddLXL1Ypk
	 WXncG3oS1MRes5POvWzJ45Tbx76OwF9I2snCa9QF3bT6pVwrcmZaHd8gX/FkQewPol
	 FdTJEAq2tCs6yhRUZ47VxcLezOGbVps6vn8YCe6YTJOcmxzQvI8CqBH9mguRB951VL
	 bUUMtolTtcpN0mYxlfUAcWP8v9kwiXhEz+2rqtnbR3gOVIyyHl34QdoNgh/b3YZsXB
	 tuZtNOpTLH7gQ==
Date: Mon, 17 Aug 2026 03:15:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Kees Cook
 <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Weiss
 <luca.weiss@fairphone.com>
Subject: Re: [PATCH 3/3] iio: light: stk3310: support the Sensortek STK36C61
Message-ID: <20260817031545.731fc980@jic23-huawei>
In-Reply-To: <20260810110423.41697-4-jorijnvdgraaf@catcrafts.net>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
	<20260810110423.41697-4-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 13:04:23 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
> colour sensor (chip ID 0x95) found in the Fairphone 6. Its register
> interface is compatible with the feature set this driver uses: the
> STATE/FLAG bit layout, the data and threshold registers and the gain
> and integration-time fields, verified on that device (the ALS and
> proximity readings scale with their gain and integration-time fields,
> thresholds written through the event interface read back from the
> chip, and the FLAG near/far bit crosses with them). Add its chip ID to
> the known-ID list and the device table entries.
> 
> Whenever the ALS engine runs, the chip also measures four colour
> channels, laid out directly after the ALS data as 16-bit big-endian
> values in R (0x15), G (0x17), B (0x19), C (0x1B) order; the R, G and B
> assignments were each confirmed by the matching channel dominating
> under red, green and blue illumination, and clear by its broadband
> response. The ALS data register tracks the green channel exactly.
> There is no public datasheet and therefore no counts-to-physical
> mapping for the colour channels, so they are exposed as raw-only
> intensity channels; the gain field the scale attribute controls does
> not govern clear either.

Hmm. that's unusual.  If the green at least has known scale / integration
time (as it's used for ALS - dirty hack but a common one) maybe expose that.

I guess the controls for the other channels are in another register that
we don't know about.

Otherwise, this looks fine to me.

Jonathan

> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
