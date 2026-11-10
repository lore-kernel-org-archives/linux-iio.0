Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343197;
	b=PoE/ee3FB6+ll7RUlm419bDdxFR2/IAYCwXHpVOE7XnHmzZ6F4mwlAZEenFDkeKMViXC
	 d+Qor0S8w6qxRJkNYdyBqAsLq4lm4pcjLhLO8bRmy03Cr3giY1PmS9TaXd+IoVnoYkx4n
	 T0EqFe4eTo6Cmo8UZbRIDGMJpi6tg1bdrzYgLOlXwYr+FFJP5HXh342ARhnfH3zZEcWMD
	 ekSFXVkBn5RZb3ERji7sqxuOWVtPQSr/75cRJKVD+pZQGGxF+PoHdXmRZDoTy7Y0JA66+
	 NIQwCtdLSwCYLqpsLsF6ZufwxQG5/u5rHGalVnde2fkBfgPeR4ZOj7f5zxIMWEEPfVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343197;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=P6sd8Fxw8RgJN2LkojRTcxAliLWNvv3VyjAmV4UhwdY=;
	b=oEaTaKvNcGIBpPJQnrmos8LbWS+gysyvUe9aViozg4CFRsCLi9iDW9FZBoPmbmwG3Pkh
	 k9VB6q/InbLVjCdqHypn5a8GjEoCTVwf05iJqQ5ltqBeIu71sZ7ZYI2c/f/sAGX0b4H27
	 zuHUS5w/Iw1i4nYIPz5U7GQh+FakFWTidjHG4KpJX9Y9Sm7UbDlToAqP1Wwom8xsDQ8Bh
	 DVMK46HrryZkfj0+5tK3wWPhwDTCnR1FBNnl5ZnzHUVHmDpaMN1ueB2RK5INIWJhB1Mz0
	 JGPJ+iyYawS+tTSf4lphLNAbIxh8oLr74AxDOE2c0m3WfjrEpHWpu1jPSNDFqKHPGZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=UKFr5+vd;
	arc=none smtp.remote-ip=109.224.244.116
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C660A3803
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 20:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51C660A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=UKFr5+vd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794343192; x=1794602392;
	bh=P6sd8Fxw8RgJN2LkojRTcxAliLWNvv3VyjAmV4UhwdY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UKFr5+vdS2CcKQZ66wAV33bnnPfsWmXwFMwOlmX55jrq90/cy3ZOWQE7R0LpGMm9j
	 NpbnDyyko9nK6WMnY+H9zv2GtO7vNKUKrVhBW7AYBPbTKt7RfLHET0ZDO5KiGF6kFF
	 ex0G828YnS26lw44xlyff/ZmB3VsIUC682ZzCiOngu+WEG+ZACQzC6R3ioGpoMy+pq
	 NVh1qYrCQhu/DUItaOFzm7w85pMpUv8AUPYz2V5d7asVTu1nTLl3/ZVILGFYBzUerc
	 exbSKEyNX8+SZRxy/Y+j1s+NomMCcKGVd5ikryYFe04u6rpTGjwrdCNSuKsUKGjXsw
	 y/7gdetRotjEQ==
Date: Tue, 10 Nov 2026 20:39:47 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] iio: adc: mt6359-auxadc: correct channel types to IIO_VOLTAGE
Message-ID: <LVXIwHr3ekY5Ao7bcfza5XGvBZor-SdLtC_MF1qWu5S0zG2vylGpgamn2xVPcw5hQ5Vedb4ALvs1oyzs7Td3ssP1pF6OjogIICu97Suo1bI=@protonmail.com>
In-Reply-To: <20261103234237.0dbbe924@jic23-hlaptop>
References: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com> <20261103-6768-6358-fixes-v1-1-2a868a33152b@protonmail.com> <20261103234237.0dbbe924@jic23-hlaptop>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 9649aa0484921d7e6192cd8e212f588f1aae299f
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
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Wednesday, November 4th, 2026 at 1:42 AM, Jonathan Cameron <jic23@kernel=
.org> wrote:

> On Tue, 03 Nov 2026 18:32:07 +0200
> Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wro=
te:

...

> >
> > Correct all channel types to IIO_VOLTAGE.
> >
> > Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Aux=
iliary ADC")
> > Fixes: d6f49313272b ("iio: adc: mt6359: Add support for MediaTek MT6363=
 PMIC AUXADC")
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
>=20
> This one makes me very nervous, not because it is wrong but rather
> because there may be a bunch of userspace relying on these wrong
> channel types.
>=20
> It is horrible but I think we can't touch that :(  What we can do is
> put the right interface in place as well. Thankfully it looks like
> the channel index is independent of the channel type so we can duplicate
> the wrong channels with voltage ones + some comments to make sure this
> doesn't propagate to any new supported devices.

Sorry I forgot to include this in my previous reply, but do you suggest
duplicating the old channels and adding the fixed ones as separate entries?

That would cause issues for in-kernel consumers. In my tree I have a
battery thermal zone driven by ntc_thermistor (which is actually how I
found this bug, as it refused to probe due to the wrong channel type),
and I will soon send a new revision of the PMIC thermal driver. They all
require IIO_VOLTAGE channels to operate properly. If we duplicate the
channels, consumers will get the wrong type unless we reorder the array
or add a custom xlate callback.

Existing userspace tools would get bogus values from the current ABI
anyway. The driver applies a raw mV scale to all channels, while thermal
needs efuse calibration with a special formula applied, and even plain
voltage channels like bat_adc and cdt_v were mislabeled as resistance and
temperature.

Given all this, I think it's better to simply fix channel types.

Best regards,
Roman
