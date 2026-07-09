Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892961FC8;
	Thu,  9 Jul 2026 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577238; cv=none; b=axWtPgPxYDFTeAXX2kqKLetI/N1Ql4znVP1KmNK0f9jEZyeSwXt+N9WMKUOPNZxP5DDgpDe8Kd86+vlLX7BtnysL5z1W6qLV29Xj7cHFryFwAIF0zkAhQjxp1SziZB1VIzcX8PM8hjh3NjmhN71Q+CsNdRo/nZyVZ3KTaZbwRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577238; c=relaxed/simple;
	bh=CjJeHWxWFa6PPoS9CmePlwGc9hxSLrSdSk6AodCBoFE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtC2oz5fBa5J5MXPQpHrPBs7BGVKBDoXAa/b9CSyqIGpqhi3ufyJ7eVtazvJLQ2xa246/UPq1mFU+CkxZyN7W8Pj8mBHelYOr7mA9p4zlGyo0/9iIAHnmgkL8XEYj+o0EvC9HZNNLJn9EB0207vstnXDpFoTwjAfS3YcWhn+6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cCfKfgnc; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cCfKfgnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1783577226; x=1783836426;
	bh=36b8H8C5d8xCfDp3UaNB3wNcVTtCzGBrEnzYSQk1yMU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cCfKfgncEAuSlZqAq4s8IHmC+Io4q0gH0nyONnU9wiuFpHDPdFTclJoWYpquyvHjt
	 yIgt/lxIA6k+QwRoQvbhPGn3PTRIujDSX4YCWCLFH/rC3+B0OiNUXcfMNzCvHY8q5d
	 5asIuw4/O2rQGeXz5tQDQwFwmejAcwmiTD6I3aQu9uN13IwlNLSBQ+LR03zetsAcad
	 sQGdcEItr8Ej6DOjOlCN5HxEj4SYUDtLWY0Nmoh/M8gMapEsj4flMLz5LquLAsMVmB
	 f/ovYdSbTUmham6xeddhJh+9339/6RHoTHWWRvc3wVv1cpmoMOw0MCA475GZoovrnN
	 PMtZxp/52WY6A==
Date: Thu, 09 Jul 2026 06:07:02 +0000
To: Lee Jones <lee@kernel.org>, Jonathan Cameron <jic23@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v4 3/4] mfd: mt6397-core: add mt6323 AUXADC support
Message-ID: <UV1EGIwox4bkh8ufCFb4GS_Pafo8bovmSI9jzRbQunz7AzjHnmItA-lLCPeeIxOLMoS3douarVEpoTF7DVffFJUcXZTdGTQ6-dfAYdomwak=@protonmail.com>
In-Reply-To: <20260708211056.GB1727174@google.com>
References: <20260623-mt6323-adc-v4-0-299680ad3194@protonmail.com> <20260623-mt6323-adc-v4-3-299680ad3194@protonmail.com> <20260708211056.GB1727174@google.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 2e5f52e3bdeec32ab13894ebd60e7725e6f99467
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Lee,

+Jonathan

On Thursday, July 9th, 2026 at 12:11 AM, Lee Jones <lee@kernel.org> wrote:

> On Tue, 23 Jun 2026, Roman Vivchar via B4 Relay wrote:
>=20
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > The mt6323 PMIC includes an AUXADC. Register the AUXADC in the mt6323
> > devices array to allow the corresponding driver to probe using compatib=
le
> > string.
> >
> > Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2n=
d Generation)
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > ---
> >  drivers/mfd/mt6397-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
>=20
> Doesn't apply.  Please rebase and resent with my:
>=20
> Acked-by: Lee Jones <lee@kernel.org>

There's a slight cross-tree conflict. Jonathan has already picked
patch 1 and patch 2 to the iio testing tree. This mfd patch doesn't
apply because recently merged mt6323 efuse patch (bde6556744888).

The iio tree doesn't include mt6323 efuse patch, and there was some
dt-bindings merge conflict.
Should I rebase on top of linux-next and send mfd as a standalone patch?

Best regards,
Roman
