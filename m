Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751047;
	b=xsLBG++AIFIc4dc+aEOXMdkpXjvfv3tJqKF6gm/fpdvHQi6Nyb+nAXF+38MapsrnCVLu
	 HwcA+t5TKj/JhGo7PicqA5I9JRUF1/fgdOW5COn4auouBi3cS8QaO6xU+AoFq0PRD38Kg
	 6pQ+W0cHjlDsachq+s8OqeVf8vUdS0/TcMlJb1pcKVwQNax7vZxaX03uSksl1xSg2zVcr
	 BdDqdCBwHcS5IvNo6eB7A2fQNVHFICBz/vZ2rj7UDurykv2poVNv1ecxAIbpL329HNhDs
	 Eg0KIwhO0C4Gcd4DrEzTcE4NlMimlP38MXtzP4r6vBxxQiqM59ZrENAK8uZFEVL2L0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751047;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3vylrWaRZ6HTp6CEg2k0KLkoq+UuiUfB7tpMoG7CCXM=;
	b=jsvDl5anMGbV4CoMUHy8H1kVSntaisvCYH1BqCHU4nicFLv3nj6ROrEj3rJZCfT6XHmb
	 WvU6jCHJoNGEdtCxEnYHVR9ic60q6n9crNDfnhdcxcHd+wXE5GEsm+7ww0XwAo3LW39/c
	 eFYzmRd/u9AI7qX2+dQOyYUeCg7TcsQpNKDa8xV2GrebLoO0qQHcSjtY9/6rHh6SXdrBp
	 XJN4NVgfIz+iOjOZ5bb9lKDiXvL0nyQkch4nVQWrXnieADsmgczgwCFOcRmWC3epv5XBp
	 AWmUYKPVy6HQZIOFwwqbZxlEngdptUn/Y8iOgVmhw4TsAQaRHR6DNXpR1KBsnZukknA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=LcTLJLdN;
	arc=none smtp.remote-ip=79.135.106.101
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B58606A324
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 00:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1B58606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=LcTLJLdN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1793751043; x=1794010243;
	bh=3vylrWaRZ6HTp6CEg2k0KLkoq+UuiUfB7tpMoG7CCXM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LcTLJLdN7dls1Eb42LjjU0sljfzej/j0mRoJCoI/JEqpz84Og45n/iAdrYUTB7qG7
	 g4zwCByzoKv14Lg9zt0AEEq+MZ7AXrWsiw2bO47lSaY3F9cMLdb2KF3mrra2drFOcl
	 +RIsuP+9RS5hgnNbCT6DbgLsdNEUrnYeGkDfevYF6tFuuC1uugqvLCCm7i5u6NZaQ+
	 /yNolww2zoiJrn668P4B5LcgdEQNEDrwd2tJbeDdRh+0xUYcD/XQ+e/poKB7QTGEZv
	 iJORxSXjVKAOJfrDjGJSiXAXYNG0ArLRwPuYYH46IQ9RcfJ71dBvuQ2mXwmMoXysPp
	 NHyujTgIkhH8A==
Date: Wed, 04 Nov 2026 00:10:38 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] iio: adc: mt6359-auxadc: correct channel types to IIO_VOLTAGE
Message-ID: <NgiLKE_H7ipL5Sr4a9BtoD_3Vgwbi2p9ENNExEER_LDALvpVi6rifnVhx_RgWJGljssso5HfyJ6KD61_viHbOnbv5EAQ7HpKZXWy4vsSf5c=@protonmail.com>
In-Reply-To: <20261103234237.0dbbe924@jic23-hlaptop>
References: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com> <20261103-6768-6358-fixes-v1-1-2a868a33152b@protonmail.com> <20261103234237.0dbbe924@jic23-hlaptop>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 301f01c9cbd70ca9bf64fe0e7c75769350a9adc5
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
>=20
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > All mt6357, mt6358, mt6359 and mt6363 declare their channel types as
> > voltage, resistance and temperature. This is wrong, since the PMIC
> > doesn't include any built-in conversion block. It simply measures
> > voltage, while consumers are supposed to convert these readings to
> > the actual temperature or resistance using efuse calibration.
> Hi Roman,
>=20
> Useful to have an example of the consumer that is doing this.

I have sent a PMIC thermal driver in the past for mt6323. I will send
a new version soon, but it will take some time. It should be compatible
with both mt6323 and mt6358, since they use very similar formulas.

>=20
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

I believe it's a bug, because all MediaTek PMICs I know can't report
temperature or resistance without consumer. Some channels like battery
voltage were overflowing sysfs, producing garbage result.

> AngeloGioacchino, why did you go with the different channel types?
>=20
> If we do decide to go ahead with this approach, are there other channels
> that are validly using the channel type for non voltage? If not change
> the macro to drop the parameter.

I think mt6359 may be able to report battery current. I can't really tell
though. mt6358 seems to wire current sensing to FGADC, which is separate
block. Perhaps someone from MediaTek or ChromeOS knows more about this.

Best regards,
Roman
