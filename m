Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049206;
	b=rV0YxoLvMZB3PcgPRH98hWqfIKu9HFUktKOXdZPBxI9UQRKpxlcp+0d3s0tCoC2jmSI0
	 AKRjDD33DCdYfXw/OH1K2rSWzd6lGzofLylGt9uYjqhBH7m1HgAT5Bsc1tpQbVsbWlwYC
	 QXONZGndJhGdw2FJDOxuFYCFpZyIlEpn7wIf4jdZ9yKFs4V2heUTjU8/yY0KgmYiPyO+K
	 eBLviZkuH8EvwPft7GuWeya3q/Hb/JFyx5Ed8nnU8TwKaNzP/vSdHUr370brql42h33sx
	 g0XDJl3eNYm7NitmGkatFamkxp9kRfjqqW3VttZPkF4OWQh0T2s1Ke5nzm05rsyVpPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049206;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=v+mfU3i9Xx3x4HW9OUQJogS5t2b8fZA7ceUvljhNg/I=;
	b=Kr9XhUN85TAbj+WafNOa1KDiMcGTi/f3EV4zWOE8aqFF3Ca2Yxq1r9wHdZjMPz9zirMh
	 nhkMXYQKQ7Lkvx3mx5hzofIv2pRsP+vXC53EnR+4NMraufbJP6z2YRGylI9af5YjgBiHJ
	 lmalz8sr0hrNTYdkb+CxGObflX5pzSrqXDlVUo6imss1YWWwOUrJjd73lLp0p8pOIHJyF
	 /PztBf7/+JdA+bTPq+f0RzXpHmaa71ux2sczG4a+pLgCAp80gh3xStgA9NmT+xxfsPEJF
	 8JZFpg5wJyP4H/ABVZIh+p1PURMgGyd+wk8MyM5ETvuyLi3Cq22n7hVyd/jWLV2fbvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtG5KUwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2C606D80A;
	Sat,  7 Nov 2026 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtG5KUwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D50B1F008A5;
	Sat,  7 Nov 2026 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049205;
	bh=v+mfU3i9Xx3x4HW9OUQJogS5t2b8fZA7ceUvljhNg/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NtG5KUwkvyadC9D8M4RJbbiAlm2ZxztgfJ8Blzozor6sde1E7FlDPuGB/JgP3aDCI
	 cxiPQstqp0iNe3xiArbRYJ6c7iUdVVFAGeXFsjJvWBlP0exNws27AA4KKq3Kcgsvcz
	 7wy7ltcWU6Bp2UnneS9pGfK5z2JmHDqu9Wk7jbc3jqSunpXaMpLPOAp+2q1097HnmO
	 niA4i1jgtosznQO3hubAxJbTrGr7ac9LMmTaJjnHqKxLCl9N5pJeXy7apKqtBCTxh+
	 3fWL5DpV5Gvw6r4nFOCSgKODx6r99t5ODHbzChPQhCGKMgLR0UUrkH+zFCFCjREXJ8
	 S/V72xWIZZU/A==
Date: Sat, 7 Nov 2026 11:59:55 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Esben
 Haabendal <esben@geanix.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Pan
 Chuang <panchuang@vivo.com>, Hemanth Selam <hemanth.selam@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Nikita Travkin
 <nikita@trvn.ru>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: light: ltr501: Switch to read_avail() op
 from manual attribute registration
Message-ID: <20261107115955.4d99259a@systembl0wer>
In-Reply-To: <CAPVz0n33sktTgdWge64c+XVSDiijXgyY-uRfcpywhJ6LHjPPEA@mail.gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
	<20261106091943.35783-2-clamor95@gmail.com>
	<20261107032042.0dd311fe@jic23-hlaptop>
	<CAPVz0n33sktTgdWge64c+XVSDiijXgyY-uRfcpywhJ6LHjPPEA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 12:10:06 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:
...

> IIO_CHAN_INFO_SCALE is by type and IIO_CHAN_INFO_INT_TIME and
> IIO_CHAN_INFO_SAMP_FREQ by all
> 
> > The current way the two Intensity channels is done is very odd.
> > The .info_mask_shared_by_type should be the same for both of them
> > (only one set of attrs will be created).
> > Ideally fix that as a precursor patch (don't label it as a fix
> > though as it's just a code consistency thing rather than actually
> > resulting in a change.)
> >  
> 
> No more precursor patches! I am just a random contributor, not a
> driver author, not a subsystem maintainer, not even a random code
> janitor. Stop using me for random unrelated fixes!

It's not an attempt to use you as a janitor; reviewers often suggest
cleanups in the adjacent code so that no new patches are built on
inconsistent code patterns.

Nevertheless, it's only a suggestion, so it's no problem if you don't
have the time or just want to focus on adding new functionality.

-- 
Kind regards,
Joshua Crofts
