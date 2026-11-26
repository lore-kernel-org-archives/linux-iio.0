Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678523;
	b=BU68/S0YKqJHxD5HDEm8zjmG8388u0XjDSevpYOVXaY5ldddRydmsO+w16CWII8nP7Ci
	 p839L90YdO1QHuckvqpr41n3kZ5BLN0ewDVQU0E5uUGc903KQxG5xrxswfkqf/1dfy7x6
	 AfNNRc9eSNqlp99gyo2ZefmpRXHF3tEmJEthJ9BDLckcUHcgeRoECvJTeBayaFcMWCnms
	 3WNecdxpuYo2Hip4XqWe5/JGvc/d7Kh6nqrKLsTcdzzjVuKxkoFDsL12h/SfEY9xhaMWm
	 ChAECo3NlXqXmJZiKdW8fSqDgyfrAeCGMjWep9eabliYjQ1fWT4shPP8lYG0kE8xOLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678523;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XUSJGTide+xDGpIYleL0SwfRegZX5gU/UVkOK9ZOXc0=;
	b=vay9enI3KJxIxvljKsGVAAbVPZ02P8jHV5RwIOJ+i2YBsLkh+sNS9laxe+1tDboSFy8V
	 o+Gtw+r8JZg3sjy8EcTuNY4/ZdethQeQAnTlgc31cbP9sEIY7yB8baw8Km9Du9BMzlldB
	 aMR/Ekcq+0Tst/Tegyvdt9AzxGk4V+BwLwaW78c384K0vkpQ6ZXV4akQ7m8/MuAKGe0rc
	 zu/aW4TLW1kVhBZu2uOnmf6q7LXg/tlQrdLshQxFhV7VaMdpgt0m7ccT1PHyZZv8DFXPH
	 pXb/RrQxGKEu2h94UEe4hm5mU5EYHX4qHWwLE3d6MGkP2p+0wZxIxSD7Gc1r0OXvJ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=mtM9STWX;
	arc=none smtp.remote-ip=109.224.244.122
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B86606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 07:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B86606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=mtM9STWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795678520; x=1795937720;
	bh=XUSJGTide+xDGpIYleL0SwfRegZX5gU/UVkOK9ZOXc0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mtM9STWXKAqD9WGspzMlHKmC6U4qA0TSAq53ucmxbzOIASs2A7rXAYkYTqoiAm35v
	 xTKZPc76zxQPDHAA6sbS0mkDMDwY8XHGl5OimhViNuEwG5c7UkVDDtLaj9oGjW6L6G
	 r5N/m7aUP/LY2kMjM4VjtMiBVlzWjCYuLvDG2U9spFA3d6796bSicAk/l4b3R2wVuD
	 tcc9h3bK+rHaZ/YzJWhiEzHzNh2y0t46Mcw5rk4LiRa/fncrRFEdH98kkxY2ia7LB4
	 RWDr4t9g/9LjPcxHaMOs94wo1+FxqiLl5IbGi4s/wqhRCRNgeO0ooxx/daMPvnm6Gc
	 d75jHqlB1vdCg==
Date: Thu, 26 Nov 2026 07:35:14 +0000
To: iasnezhkov@gmail.com
From: Roman Vivchar <rva333@protonmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: mt6359: fix MT6358 VBAT impedance resistance ratio
Message-ID: <RyeVHYGoYxuKtlQ0QPskoF7emL4yakkPeBUW--rPVYqvaAM4Q5Pm1GACcF4t-1DjyxPPOMNyfAiMnTxVqugYC2MBKxUBhRiDDjtcPNK4Z7Q=@protonmail.com>
In-Reply-To: <20261126031013.27701-4-iasnezhkov@gmail.com>
References: <20261126031013.27701-1-iasnezhkov@gmail.com> <20261126031013.27701-4-iasnezhkov@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: d24a110af2aa28dfc2cca5959e1a53a29ffd220d
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

On Thursday, November 26th, 2026 at 5:11 AM, Ilia Snezhkov via B4 Relay <de=
vnull+iasnezhkov.gmail.com@kernel.org> wrote:

> From: Ilia Snezhkov <iasnezhkov@gmail.com>
>=20
> On MT6358 (and MT6366), both BATADC and the battery impedance VBAT
> channel use a 3/1 voltage divider (5400 mV full scale with 1800 mV
> VREF). mt6358_auxadc_ch_desc[PMIC_AUXADC_CHAN_VBAT] erroneously uses
> 7/2 (copied from MT6359), over-reporting VBAT impedance readings by
> 16.7%.
>=20
> Change MT6358 VBAT r_ratio from 7/2 to 3/1 to match MT6358 BATADC and
> hardware.
>=20
> Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxil=
iary ADC")
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
> ---

Although this change looks correct to me, it's a no-op given that it's
not possible to read the channel.

~ # cat /sys/bus/iio/devices/iio:device0/in_voltage13_raw
cat: read error: Operation timed out
~ # [  243.402155] mt6359-auxadc mt6359-auxadc: Resetting stuck ADC!

You might want to fix it in the previous patch.

Best regards,
Roman
