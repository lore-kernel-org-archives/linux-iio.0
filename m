Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792969967;
	b=AOr/h+HHbQ1JsRq5rJxCmbOzLcGvYIDp1Ok8ElNq5/WyJ6AeiGcIWrXcicDvbI68e8Ql
	 1qHG9lcZWEkWUR/f+7tWl2z9sVKQ1PzYvcjdMV0kdHh+hidb8tevnaqeYb/O5KAtS3l14
	 udZpJQ9c/L6HiYZPiqy8uQAAywZ+81SyZX3RP9zSoYT8FnnJ5oCGyRSo81rQFoO+nYYHE
	 fqY7xsQkAoxU2LZkU7WfuHhGY+EiSrWac+1/mJjWHS+hnnJP59ac4oSyjatqQb6S558hf
	 1cF54KaivGtMmKbGEVd9Cr05FdtW7AIE3WeoPR3fucx0mTdsHddUNdlSH1qI4iAs3ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792969967;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aIUFJoFYTsajTpY+ck7fTBnjmSDJNtvuj8FkCBnGqao=;
	b=rnWMCJwPOrc458mkKwjv+7PNh1jZPCE/ikvHoybVj9/kUgrkfI/HpqGq3mUiR2226oHW
	 +ndqL+uoehiJWe0hFSEC9XuDrNnflUCdm9dG+YKMDb+c+kCNuQrh1r5IdeVYi9YpNE0ev
	 vj7rXdrC23WgTtcZH3kYPmZhcTRepCOSV9NKH3uqVzTUcDzAFjSgm9ova7o+w+4b7dNse
	 UonwdIxayehYSoIgg5ygPzbn/jb0BAPet8EajD87YedSDriZNq9U4fWSZXvGIB0gDORPT
	 8RUuIkUum9+Mhj36ubghJZvNpGFsoigwvJl34h5ZkPX1ueYINdUmLIjPktum3Zwy31g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vd2dFF9+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0B606A31A;
	Sun, 25 Oct 2026 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vd2dFF9+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB361F01825;
	Sun, 25 Oct 2026 23:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792969966;
	bh=aIUFJoFYTsajTpY+ck7fTBnjmSDJNtvuj8FkCBnGqao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vd2dFF9+J1LK8EfBQv8o40zxH43ruMAtF+hOdYbAQ4FkMOhQWzPypTQHHaHMEZKNc
	 v/x3eooK6IF2tAZHpaytPQpJltkD01bmRatAjaKBFU+ZMHg62K/Fw4lhR3Hrqx6Lar
	 XrIMl7l7ItrZZ5+/mmEpxcrcBCvXfeKtygttRoaOYWlm7AAP+dUbGmsfXRiSm1KeOd
	 ppAREyo7OxMJdHSN0ImPBlPV/BapKM4bE2ttzJpnY8l6Bv2w+BXiFXT9MBLc3gRX1S
	 txMb3yh+iAxZA8/qx4qlX1D7rhS09pivbTHPN0AyFas8Rqam2W3UdsvpQeCIkNQLy2
	 n2slycruHCVUA==
Date: Sun, 25 Oct 2026 23:12:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: adc: ti-ads1298: fix scale, ID check,
 regmap and Kconfig
Message-ID: <20261025231237.55d4ebd0@jic23-hlaptop>
In-Reply-To: <20261024231335.280955-4-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
	<20261024231335.280955-4-stephanbrrs8@gmail.com>
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

On Sat, 24 Oct 2026 20:13:32 -0300
Stephan Costa Barros <stephanbrrs8@gmail.com> wrote:

> Fix four smaller issues:
> 
> - The scale divides the reference, in whole millivolts, by the gain
>   before it is reported. With the internal 4 V reference, it is 0.099 %
>   low at gain 6, 0.101 % at gain 12 and 0.025 % at gain 3. Report
>   VREF / (gain * 2^23) as an IIO_VAL_FRACTIONAL; sysfs still shows it
>   with nine decimals, now without the error.
Move this to end of the fixes. An accuracy improvement is nice to have
but not necessarily something anyone will backport if the previous driver
is working well enough for them.  As with prior set, separate patch
per fix.

I appreciate that will mean a lot of patches, but they will each
be simpler to review.

> 
> - Only the channel codes 0, 1 and 2 of the ID register are defined; an
>   ID of 0x93, for example, gives 10 channels. The IIO core then reads
>   past ads1298_channels, and the RDATA transfer writes past rx_buffer.
>   Refuse the reserved codes as an unknown ID.

No problem with this, but it is hardening against devices we have
never seen. So after fixes and marked as hardening.  We should never
have a fallback compatible issue on this, because they shouldn't
be using larger numbers of channels.

> 
> - The driver uses regmap but does not select REGMAP, and fails to build
>   where nothing else selects it, such as tinyconfig with SPI, IIO and
>   TI_ADS1298 on x86_64.

Interesting we never saw this in random builds.  Indeed good to fix
but has nothing to do with the rest of this patch.

> 
> - Bit 0 of CONFIG3 is a read-only status bit and the GPIO register
>   reads the pins, but both are cached, so a read through debugfs returns
>   a stale value; debugfs can also write ID, LOFF_STATP and LOFF_STATN.
>   Mark CONFIG3 and GPIO volatile, and the other three not writeable.

I don't really care about stale data in debugfs. By all means fix
this but it isn't something we'd bother backporting.

> 
> The ID check was found by review and reproduced on an emulated device
> only, where KASAN reports the read past ads1298_channels.
> 
> Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
> Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>


