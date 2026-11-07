Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066028;
	b=5Q3Xkgxc9V79wjhNLon6WKXn1nFM29hVCTk89dMeYkeXgJzX5WmLOkdcy+sc9r8qfSD3
	 uBRdKp8i06nyAj5yvzriTsBDG+13DYtRaFXrXGAeCw0XaLq20tSw8XYdM9paU13sHiVpi
	 c1oV0v3hwHy1CcDBKHmm0lapLNTGKOMqnEH45+I0eqxZsaA4Phh4WOzjCvhsWjTMtGHq4
	 C49Y1q9AHJrdiPgS7r4ZspCONmIKlZEqs4sWZhLIe47eMULTtMPTH2A1r6mISfo0dMe7q
	 44P4OGtL8IYlUPUimRjku/IiHMVJ1Ul/c7ckb9rg0ggdEFQRGkiKu/CEKf2r/oOF9ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066028;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=leMhWkQuWoXw3/AXsqHUQ6mqtJqDPcpmsnM5+TvBACg=;
	b=svxEPrvhST9maspBEZOUZcb8IYrvPu2O0l/PUJj0IAfHsmMTnSMVwCRFNNvvvg5urioW
	 vXwdiXFn7dFx1yxZY1UsfotGkbS27WdhT0pZOuvJhPHqj85gQ8hVHbIc6W1HUU7zgCQ8D
	 Psyi1DNZ2QM6UVikYJXttjy1gkh1x+g6MT2CmOq0L0yHiKcNbmGzOGCAE8TpPoFrOrgwP
	 gyvVHqUuLBoa1ZDu4KSBx5Qv3yinImZ4SKMDE/cMZ2+qxjlFMass6uCCFMuPSKSdh3PS8
	 V0o5HhgvAOw1F7bIhw+/X5DieB5O4bH/G+VbijsWRw5r13efQkxygdR80aNdNIbpQqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CX/mzydT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3662606A32D;
	Sat,  7 Nov 2026 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CX/mzydT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6AF1F008A3;
	Sat,  7 Nov 2026 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794066027;
	bh=leMhWkQuWoXw3/AXsqHUQ6mqtJqDPcpmsnM5+TvBACg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=CX/mzydTluBXcqx1PcNTmYnuveJJz+JWTXHV0ysvAV0LMoVOffngJyvAJLVsgL/UK
	 EmS6b5D4dHCyv1Wf0CUJv2kciQnKk/P2TIYLa7JHHUCYNhT5Gzjd9iLU3erhQSNcPi
	 hlSdQFDx3tbO/Zr7U443wZlLpxbK5/uiRyAXUlMiXHKhq9lxlxYwwzw5U8XMYGykgw
	 COiaD/0VoZ3vk4foeSloT7O451N6fje4DTJyOFJyC2iDG1zsz5jTTT/hlPAa2SRKUB
	 4lJZIvedDb/Yv7MZebktAm1l5LIvjTS5MSygwkKqZ/k3EJEbGeFS0NvjBUQvm69TW5
	 Mpm6P631qsu5Q==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 81C8D2AB366C;
	Sat, 07 Nov 2026 15:40:24 +0000 (GMT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 7/9] spi: add KUnit tests for the multi-CS framework
From: Mark Brown <broonie@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux@analog.com, 
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com, 
 jic23@kernel.org, dlechner@baylibre.com, andriy.shevchenko@intel.com
In-Reply-To: <cb439b0d9a5b0daa5109929debfddee21b56778a.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <cb439b0d9a5b0daa5109929debfddee21b56778a.1792435248.git.Jonathan.Santos@analog.com>
Date: Sat, 07 Nov 2026 15:40:17 +0000
Message-Id: <179406601717.3424803.16289581332801277294.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+KmDtdfmQh9j2QDezL/zfpq4N7QGtA8DI3IwSkPFqm4=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeu2WIP3D99sngxrntMffW37juVlPbe3Df+v57XYUmi
 g/yP9962FHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJSG9l+Cuwwyqq6bfYl12K
 4Xd3+GiWaLuq10RktQWs3GH24NmZl1EM/5TXPDPb/tnDimG38q2CZ6xf9zYtaWHYMtft3AttTu/
 /5zkB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Add a KUnit suite for the multi-CS feature in the SPI core, covering:
> the CS suffix of the device name, considering the contiguous values
> restriction, the last-asserted CS tracking for single and multi-CS devices,
> and CS array validation rules (overflow, out of range, duplicates,
> non-contiguous and descending sequences) and filling of unused slots with
> SPI_INVALID_CS, implemented by a test-local spi_validate_cs_config()
> helper.

> +/*
> + * cs_index_mask only has bit 0 set even though num_chipselect=2:
> + * slot 1 is skipped by spi_for_each_valid_cs, only slot 0 is checked.
> + * last_cs[0] matches.
> + */
> +static void last_cs_index_mask_filters_slots(struct kunit *test)
> +{
> +	const u8 cs[] = { 0, 1 };
> +	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
> +
> +	/* override mask: only slot 0 active. */
> +	spi->cs_index_mask = BIT(0);
> +	spi->controller->last_cs[0] = 0;
> +	spi->controller->last_cs[1] = SPI_INVALID_CS;
> +
> +	KUNIT_EXPECT_TRUE(test, spi_is_last_cs(spi));

Should this be:

 	spi->cs_index_mask = BIT(0);
 	spi->controller->last_cs[0] = SPI_INVALID_CS;
 	spi->controller->last_cs[1] = 1;

 	KUNIT_EXPECT_FALSE(test, spi_is_last_cs(spi));

since we're not checking that slot 1 was untouched.

> +/*
> + * Validate and normalise the CS configuration of @spi against the controller's
> + * @num_chipselect limit. Arithmetic Analysis only, no device-model calls or bus
> + * scan.
> + *
> + * On success the unused chip_select[] slots are filled with SPI_INVALID_CS.
> + */
> +static int spi_validate_cs_config(struct spi_device *spi,
> +				  u16 ctlr_num_chipselect)
> +{
> +	int idx;

Should we expose the relevant core code with a VISIBLE_IF_KUNIT helper
instead of duplicating it?

-- 
Mark Brown <broonie@kernel.org>
