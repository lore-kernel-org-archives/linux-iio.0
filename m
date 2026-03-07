Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCA219A8A;
	Sat,  7 Mar 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772884710; cv=none; b=dy3lTEjl303UDoaTf+95GmSWixo2vJacpvfR40qSGYLbYCHIXr6ZpdlUg56H88Y/PZQCtm+/URtGkIvYAcq9czk5NQOoVNhxs37O7JPBV5EpnT3pOiErYDeJ7EdoNMZV5Lq6lP5tlZx7xxBzEy1Tt9XHKPsAOYpUnGsR7TfZ81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772884710; c=relaxed/simple;
	bh=YuASOyN1RkqcXSjgc05lQ+Q5kLhlrgG4O7R86/5IDcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLt7XneEZ8yyBxG7THzS/r3U+s3EhmVCVHcDgRmwOO+VfizdUq3+9roR7GrBPp/itBrIvLSLBa+YHQxKJAWnsKJSyqJSYc0Bp9BFnfF8PIvFnCrVJbaftKm4Ub6JcB9RVXC1x1+3wjC2lGJ3oHzk2lbbNuhZGsS/ZcpkiEmryBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKEES4tN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKEES4tN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F6EC19422;
	Sat,  7 Mar 2026 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772884709;
	bh=YuASOyN1RkqcXSjgc05lQ+Q5kLhlrgG4O7R86/5IDcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CKEES4tNNLwar+MkBLek4JnSKr2p4LqcgIwpyxO3OWKZIJajy6XJFtEGHuoaTqodu
	 E4q1VyKSVH4eo8nQ+c9w/TjmQsmyYsrVrMi0yZcuiMBDgJ1626NBLowYJ5YAZtTkqV
	 SAx3P7SB4pyKoDJ4zyXc/FEZB5cAYcFbGUFsoCpSP9qbFp5/vGMN+paSMuSMKLSbxS
	 pr8pf4DDFcWlORylE1OasUv5lZ0M5ZdjVZiHPciqw9Pdyi5oFDivqOQfn8BuxOySq1
	 FeGfWa/ti6dP9Czqx21oDzbcy2BgloWUXVJFrUdcEYC2BL79tmuquAfy6XTK+W0/O/
	 CSfLshtmb1AsQ==
Date: Sat, 7 Mar 2026 11:58:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260307115820.2fd7c708@jic23-huawei>
In-Reply-To: <20260305113756.47243-5-antoniu.miclaus@analog.com>
References: <20260305113756.47243-1-antoniu.miclaus@analog.com>
	<20260305113756.47243-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Mar 2026 13:37:30 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
>=20
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
This LGTM.

If nothing else comes up in review, I can make the code movement I suggested
in patch 2 as a tweak whilst applying rather than needing a v6.

Jonathan
