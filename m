Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE65372EFA;
	Tue, 19 May 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217753; cv=none; b=HUW45M4XPP9/oXqgHdqf6udwQICGid0q4fYI/pS3oYrAbzUI9l1YxRUEIbT9uTvV9hFUZNn1Aa6f8OqgwVgpiagLjNOl22+Y25zwl09FQDiqE/5oynW/TDbUXrLobwrzVU2SE9QOt5fiImg407n7HvLhwFTYXixw9GdMp9D0TVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217753; c=relaxed/simple;
	bh=5kBQH/y2BLO5AKfM+Wp7lb19hU9ddDiCH1CkjQQ2ks0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxUadNQ5yEvkqtazJTMiJ39E6yVngN7iOE7pa/SOO2n+/pmG0x0EIrBWvGit8ksKrwyNIL599Zda/lmijO7ez9vNLyxzAK1Vt653hoPALRwtacOYfen1uSdrn9AkxemhknTEcIm63gHEhIdAXfcSpaLQehCpjOUMzU8T7g5+nmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNo2EbM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNo2EbM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AB11F000E9;
	Tue, 19 May 2026 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217752;
	bh=fEtoPOmPN885BzjkB9Seg7NARzwXMcNHxb1zKs85g5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DNo2EbM8xbn5RXSEg3k3Ne/e2qWrkWAiGY8N58uIHoN9z50FDawyY0aT/wJYNiJJk
	 it1wdDRtiPFISdJl6Z6UqD0eU+OoKMzi+/ygpcJU0y9QvqKeSz8XU+YMOCkFgkXV3u
	 3ala6gSH9aIwYvo6758G1o2OPAi8lE3ZP3jF+AP8/YFGngNU4LgLa+QB1MhbM/HeMX
	 BB1WrIRFltpVQy+fg7y4cFTF/GZr+QkGKxSIBzZqSyUE2jg6EOhUoXeKB/sHjIiflO
	 Tht0isskKdRt2m0iJ/Gvm6KpMBmLBzfn5ZeI1/362alSMPXDAlf6u2PsG0J7b89K1x
	 sLpiLFSDPx0VA==
Date: Tue, 19 May 2026 20:09:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iio: proximity: sx9360: Drop unused driver data
Message-ID: <20260519200908.469a9727@jic23-huawei>
In-Reply-To: <871db08b55e227d60299f48726cca5eb81662c73.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
	<871db08b55e227d60299f48726cca5eb81662c73.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 10:13:08 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The value assigned in the three device_id entries (ACPI, of and i2c) are
> unused, directly in the driver and also the sx_common support lib. Drop
> them and while touching these arrays, convert to named initializers.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied.  Thanks for tidying these up!
J
