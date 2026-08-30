Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99837242D9B;
	Sun, 30 Aug 2026 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788133722; cv=none; b=G+SkDHJMLORI1604ayIXWOPIBebpqQM2OHJ+mWDh/3MX1S9686l52KMelPk10iagjnE1w5VXAYFJEHwgImN2M7KiiH6l9J9pGE9gAUc8RanFrk13fSV7Qh1nC52arBlmf/z2u1LDbxj/cSvKd/U1eT1t8xnPkPRJEf2kBf/+kUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788133722; c=relaxed/simple;
	bh=GcbGA9JYdBBBGqKEus3i6V0Fog/Z3w6buBjf28Sw1xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYZqWKfn1mOT501MQgWp7aEBzClzYnyz7K/ZhtyalfkLhuX0ZD8r2mJNgydN+NbwUZncjaWmGfWcRs5jglR2N+yeIKUxVo2SaNR8dw4k9nncZ4EOvv+41ilFPliPpqzwpsmeWup9185XOnkg4fh0W4RhqwS3N55nmpP7g5Yp6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+lJzqRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+lJzqRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4C81F000E9;
	Sun, 30 Aug 2026 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788133721;
	bh=PcO0U45IrwGYg9QXoz22ey3QRhX6/6WwzaaCcty5J8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g+lJzqRsy0KUPUwU2bqb4dtlgiZFTYQjo+vXkFM9A1x8beeCtdzzGFfw0U/+WTkv2
	 3DEYZZkyxazpMiePZxbvoEywVhGke3JFtbTQn3aYYDVcWtBoIdGTKuQtmQ9E0RbQxn
	 emh+WlFn5u4EXoREZerqcuJHnd8m+LEF5nab0Wxp3tiH8giJH6T8+yWckwPQgFWCHc
	 ZwE2saepbBPXu1aQXgL/8GTueKOgicsOYLgjnK6LvM+YfRYTLL5qclDPkFlmiaVuOn
	 XKIo1OUzVmS0Ky3/K6aU3CZk4ZM+sDpl2CalkrDDJFHpVY8mghHvxfM3B01bwJkbBS
	 hqkGk0go+Grtg==
Date: Mon, 31 Aug 2026 00:48:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Kees Cook
 <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Weiss
 <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 0/5] iio: light: stk3310: per-chip match data and
 STK36C61 support
Message-ID: <20260831004837.406a1108@jic23-huawei>
In-Reply-To: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 19:54:04 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
> colour sensor whose register interface is compatible with the stk3310
> across the ALS and proximity data, threshold, gain and
> integration-time registers this driver uses. The part name comes from
> the Fairphone 6 manual, which lists the component as "3IN1 ALPS/RGB
> sensor/STK36C61". There is no public datasheet; the layout was probed
> on the device: chip ID 0x95, the stk3310 STATE/FLAG bit layout, data
> and threshold registers, gain steps that scale the ALS reading
> accordingly, and an RGBC data block directly after the ALS data.
> 
> Since v1 the colour block's controls were located, confirming
> Jonathan's guess on v1's patch 3 that they sit in a register we had
> not found: the STK37660 datasheet, a documented sibling with the same
> data register layout, places a clear-channel gain field in a GAINCTRL
> register at 0x4E, split from the RGB gain in ALSCTRL, and stepping it
> on the STK36C61 multiplies the clear count by ~4 per step while the
> other channels hold still. The STK36C61 patch therefore now exposes
> scale and integration time on the colour channels.
> 
> Tested on a Fairphone 6 running a 7.2-based tree: this series'
> stk3310.c, byte-identical, built as a module against that tree (the
> i2c core files the binding behaviour depends on are identical between
> the trees). Verified there: DT boot instantiation, the colour
> scale/integration-time interface, and the sysfs name behaviours this
> series changes: a lower-case name selects the full profile through
> the id table, capitals no longer bind, and a full-compatible-string
> client now fails probe with the missing-driver-data error. A board
> DTS node using the new compatible follows separately via
> linux-arm-msm.
> 
> Changes in v2:
> - new first patch lower-casing the i2c device ID names (Andy), and
>   probe now fails on missing match data instead of falling back to
>   the stk3310 profile (Andy)
> - new precursor patch moving the data registers into the channel
>   .address field (Jonathan), split out of the match-data patch; the
>   bulk read gains a regmap local variable (Andy)
> - the ACPI table entries use named initializers (Jonathan)
> - the STK36C61 patch exposes scale and integration time on the colour
>   channels (Jonathan's suggestion on v1 patch 3; the clear-gain
>   register located via the STK37660 datasheet and verified on the
>   device). With those branches of read_raw now handling the intensity
>   channels, the ret = -EINVAL single-exit form promised on the v1
>   thread (Andy) has no unreachable branch left to apply to
> - picked up Krzysztof's Reviewed-by on the binding patch
> 
> v1: https://lore.kernel.org/all/20260810110423.41697-1-jorijnvdgraaf@catcrafts.net/
> 
FWIW I took another look through and with those small things Andy raised
tidied up (including a more concise commit message for the final patch) this
looks good to go to me.

Thanks,

Jonathan
