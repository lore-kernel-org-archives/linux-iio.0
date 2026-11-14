Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682137;
	b=lByVpWmXM44qyk6d+8TaJEyL06xSMfmYQ+C+QM3EHPcX6fljoScMjBUPJFhmuYUSnVqf
	 YeTcWef2wucve5QnxvDNLftl9rBBzOHgEpNtZHWv51HTyWVjVQML5AsPUcdLg9B0gR5RQ
	 csnGPhov9A/rcfxNfVNQRVrPosfBtgG9bcSnYEAVBQnWMUbQTzOFo9HPwhcHyICg+ElxJ
	 nxrvupFiZtkjPfU4FCk4L0Cmhzcw5WUEC1xXztxU82I6GztTVORAm3u8q9vD2PKIvbF+P
	 JKKZqDQQ8iKNcD/VgFqVwJohnm/KxCr/1DB++svOoKspmcCSHDv4By5ragAPPwLEjBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682137;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LPmuSB4GQqVZUVPJgtjDEsgFvIRG4UWskQFfExXoCUc=;
	b=5jWaiAsCrOc2gNzQIPpQ/YD/AwW/CfWjX5g4S3TgkjlEt2T4Wjpx5CRAHUWOQyYhfKCi
	 bk0peCK3YDKCcWvXAPmMsdTFvLoQcYEUqam4ry77jSMxrakrvqotTtIo/6wK8R88TlkuL
	 BWkCYo3rNG1PcFx0zaqaRpUCuAWT9jj/xu1xRiCBA6t0xvn1NbB9J200MpcjVd5Vpkw4N
	 efhtGWg0SQp095WbAZOQGdAAcJ78Eeohnqc7g1ph9d0axuHV7hLKKnKoJ56XF5fgKjWKT
	 NiOs+IBTd2qEE2HFpM8MDhq+3tZb5hGr7R4F/SSSmjnmERcX2vCaFqC+zp4Qwp3SO2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qf3TA9Z9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C6606A333;
	Sat, 14 Nov 2026 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qf3TA9Z9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784E71F000C4;
	Sat, 14 Nov 2026 18:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682137;
	bh=LPmuSB4GQqVZUVPJgtjDEsgFvIRG4UWskQFfExXoCUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qf3TA9Z9IUpGXCTCgXO8VGJ+5zD41Nhg53sssKh9r+3WC0nHHXYXHTG/AsEvRLrid
	 1wDu48Z7mhY/Sku+jBg7GS7COL5lzOOW14Ycr8uIUEh/qyQRhchbH0LTq1LaCsrVI3
	 SiEE11KJZ7HOwWEsiONpjUcJPfLxPl0FFv8weHhscfI6lBFAQ7Ma6kRZBF6coW/fBk
	 vG/HwO3oyE+rT4xONb63unA+WU/WZD/sevxJNXGYvcNuUmH3N4b1M1wz/XOf7lKTCz
	 keLngttJk5aFQ8SRZAO0wzl9F4/DC8pCrvxmDwU0Yb8v4SpM8JMeWTnw5dqLb4E8xI
	 g4KcVDb/lJJIg==
Date: Sat, 14 Nov 2026 18:48:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "=?UTF-8?B?TsOtY29sYXM=?= F. R.
 A. Prado" <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] iio: adc: mt6359-auxadc: correct channel types to
 IIO_VOLTAGE
Message-ID: <20261114184847.70ae590e@jic23-hlaptop>
In-Reply-To: <LVXIwHr3ekY5Ao7bcfza5XGvBZor-SdLtC_MF1qWu5S0zG2vylGpgamn2xVPcw5hQ5Vedb4ALvs1oyzs7Td3ssP1pF6OjogIICu97Suo1bI=@protonmail.com>
References: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com>
	<20261103-6768-6358-fixes-v1-1-2a868a33152b@protonmail.com>
	<20261103234237.0dbbe924@jic23-hlaptop>
	<LVXIwHr3ekY5Ao7bcfza5XGvBZor-SdLtC_MF1qWu5S0zG2vylGpgamn2xVPcw5hQ5Vedb4ALvs1oyzs7Td3ssP1pF6OjogIICu97Suo1bI=@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Tue, 10 Nov 2026 20:39:47 +0000
Roman Vivchar <rva333@protonmail.com> wrote:

> Hi Jonathan,
> 
> On Wednesday, November 4th, 2026 at 1:42 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 03 Nov 2026 18:32:07 +0200
> > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:  
> 
> ...
> 
> > >
> > > Correct all channel types to IIO_VOLTAGE.
> > >
> > > Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
> > > Fixes: d6f49313272b ("iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC")
> > > Signed-off-by: Roman Vivchar <rva333@protonmail.com>  
> > 
> > This one makes me very nervous, not because it is wrong but rather
> > because there may be a bunch of userspace relying on these wrong
> > channel types.
> > 
> > It is horrible but I think we can't touch that :(  What we can do is
> > put the right interface in place as well. Thankfully it looks like
> > the channel index is independent of the channel type so we can duplicate
> > the wrong channels with voltage ones + some comments to make sure this
> > doesn't propagate to any new supported devices.  
> 
> Sorry I forgot to include this in my previous reply, but do you suggest
> duplicating the old channels and adding the fixed ones as separate entries?

Yes.

> 
> That would cause issues for in-kernel consumers. In my tree I have a
> battery thermal zone driven by ntc_thermistor (which is actually how I
> found this bug, as it refused to probe due to the wrong channel type),
> and I will soon send a new revision of the PMIC thermal driver. They all
> require IIO_VOLTAGE channels to operate properly. If we duplicate the
> channels, consumers will get the wrong type unless we reorder the array
> or add a custom xlate callback.

Indeed, one of those two solutions should deal with this.
> 
> Existing userspace tools would get bogus values from the current ABI
> anyway. The driver applies a raw mV scale to all channels, while thermal
> needs efuse calibration with a special formula applied, and even plain
> voltage channels like bat_adc and cdt_v were mislabeled as resistance and
> temperature.

Ah.  If the values are effectively useless we can hopefully assume no
one is actually using them and hence the risk is low.
> 
> Given all this, I think it's better to simply fix channel types.
> 
> Best regards,
> Roman
> 

