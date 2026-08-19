Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99253DDDDE
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126425; cv=none; b=KbELwRk9LjSEc+4X1VEAk9+GykiUwRYFfgccQYuAYQ7xp2xfuj7kmloKcjrAkrMpx57PhSeg6I40uI9HRDd2u9WuoJvSlXU/s7jbUYxJDOIAdBcJW3VIbmTlEOCKvAA7FYFPCze+6XWkHKUuCLhaquf1TEbo7L2FXdPAIq9e+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126425; c=relaxed/simple;
	bh=O0t9qk8cRjvR1W8iG5/jIx4GP/yhv1rQ1ckZ56PJR2U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=lGiDQQOlCEuW13IiJuNmQdO2lPR6GaUAhfxsCstCPzShdTuE7g6qZxy43GVqKCa4IJhNp/gPpl46rmo8iSGXKyXNY8/Nb5gI2xtSuvJE33MAhpjydbGgnoIiLBEYTxBnrZWJDNDsiFHcZezjj4u5PH8jaM005SZXfFlb3DUIMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ulb3Ulwr; arc=none smtp.client-ip=95.215.58.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ulb3Ulwr"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O0t9qk8cRjvR1W8iG5/jIx4GP/yhv1rQ1ckZ56PJR2U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787126418; v=1; x=1787731218;
 b=Ulb3UlwrDJi7rJRjOlIuVuxchNycZWs9+Gan7hKa6H+lXf8hXX4tS/Ww6qMaOI1SldqdbE4N
 UpvZKcR4NUztg+sL/6BtFIuL6lM/aYpwpCZ2ENOoGuZVouiNKfw18t4Im5ZCeegrK8wUtpBZOPk
 P2iLSgdCDb0nriXpwLvo/Lm4=
X-Envelope-To: linux-iio@vger.kernel.org
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id 662ced0c2f743159;
	Wed, 19 Aug 2026 08:00:18 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 08:00:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <38ad21d4eaf5c7071aaf45d2ce650daffe16ef6b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v7 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
To: "Stefan Popa" <stefan.popa@analog.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux@roeck-us.net,
 joshua.crofts1@gmail.com, ciprian.hegbeli@analog.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Stefan Popa"
 <stefan.popa@analog.com>
In-Reply-To: <20260818142928.8244-3-stefan.popa@analog.com>
References: <20260818142928.8244-1-stefan.popa@analog.com>
 <20260818142928.8244-3-stefan.popa@analog.com>

August 18, 2026 at 8:29 PM, "Stefan Popa" <stefan.popa@analog.com> wrote:


>=20
>=20The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
>=20
>=20Add a direct-mode IIO driver exposing the current and voltage channel=
s
> with raw, scale and hardware-gain attributes, a configurable
> oversampling (digital averaging) ratio, and PEC-protected register
> access. The current scale is derived from the shunt resistor value
> described in the device tree.
>=20
>=20The driver operates in single-measurement mode: each raw read trigger=
s
> an on-demand conversion via SMBus Quick Command and returns a matched
> current/voltage pair. This avoids the latency and complexity of the
> continuous FIFO mode while ensuring each read reflects the current
> state. The two selectable current-sense ranges are exposed through
> scale/scale_available.
>=20
>=20Continuous FIFO buffering, threshold events and the alert interrupt a=
re
> intentionally left out of this initial submission and may be added
> later.
>=20
>=20Co-developed-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>
Looks like my concerns have been addressed. Assuming you are going to sen=
d v8 with
fixes for Andy and Jonathan, feel free to add my tag.

Reviewed-by: Siratul Islam <siratul.islam@linux.dev>
