Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B037F8B2;
	Tue, 28 Apr 2026 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392264; cv=none; b=VBrenVAHtxCPLtB2mYBfhPJfu+M55Nu6Rf2t8ve+dv1vhwROxH4HVpwQrXuv4v8Xu4/04RFSMf4mFWqDmO0oc92Js15bZZsxkH+HxajpudbvY6ICc87s0xowO7xbqfcwjvyOJhhN/s01aeo32XKaLjZwIzgzSPYikW+4XJGTbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392264; c=relaxed/simple;
	bh=oAFGHyAbaznajOADcROGc0s+B+vqvXX8dS1s4apJaHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp8fAEIxB7PeSKcXbqj4ZeCewZ3HDywbzucNOIAmfXsTCYlxyPzr3paCG7SSu4vbPCgqkdh/oJkgP1T5O6C4Kv09NVN/QtrDs+OFBcjB1tdyvHCKK6u9vljP8MnV7c3QTl9oG1jg/Dm+aTawCaBtih1GNeD5CNrFXBjDCSx32gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i75pryvL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i75pryvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8C4C2BCAF;
	Tue, 28 Apr 2026 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392264;
	bh=oAFGHyAbaznajOADcROGc0s+B+vqvXX8dS1s4apJaHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i75pryvLzPjrSQAv3Pp3D5Wcjjbcgc72SPTvMyCJzmcu4pykiaFKe1z9lwKx3Wems
	 hxOBWfy5jq40Hb4CJqwgazmE0CEgRMJWDROG5N+Ena/RNBfBgp26NS5LgHo/22JNcx
	 XJi+ex0ehfH22LndbZihCLj5sHKhvmiwvzr+qqjua8tnPvbxhfXkPuZYdanbVWWPkS
	 EfMBvy47vV3C9JYdJa2N3jsRqsyv68d+N6sxWJej/P18KJXIA1ROp64cYFnSzkvGAG
	 e+/sLs7FhQg0o0HEQWvmdZQPRT8yM7sv2cwblK3dp1K/voIdJ3GnnrWqVao95vP2YK
	 PLhV9EevLKxaQ==
Date: Tue, 28 Apr 2026 17:04:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Crt Mori
 <cmo@melexis.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mlx90614: fix missing GPIO direction return value
 checks
Message-ID: <20260428170412.41791bdb@jic23-huawei>
In-Reply-To: <afByF-0BV1szTbzE@pc>
References: <20260427215800.28082-1-salah.triki@gmail.com>
	<afBpBNLucHg25So0@ashevche-desk.local>
	<afByF-0BV1szTbzE@pc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 09:38:47 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> On Tue, Apr 28, 2026 at 11:00:04AM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 27, 2026 at 10:58:00PM +0100, Salah Triki wrote:  
> > > The functions gpiod_direction_output() and gpiod_direction_input() can
> > > fail, but their return values were previously ignored.
> > > 
> > > If an error occurs during the GPIO configuration, the function should
> > > abort the wake-up sequence and return the error code. More importantly,
> > > failing to check these values could lead to the I2C bus remaining
> > > locked if an error occurs after i2c_lock_bus() is called.
> > > 
> > > Add return value checks and ensure the I2C bus is properly unlocked
> > > via a goto label in case of failure.  
> > 
> > ...
> >   
> > > -	gpiod_direction_output(data->wakeup_gpio, 0);
> > > +
> > > +	ret = gpiod_direction_output(data->wakeup_gpio, 0);
> > > +	if (ret)
> > > +		goto out_unlock;
> > > +
> > >  	msleep(chip_info->wakeup_delay_ms);
> > > -	gpiod_direction_input(data->wakeup_gpio);
> > > +
> > > +	ret = gpiod_direction_input(data->wakeup_gpio);
> > > +	if (ret)
> > > +		goto out_unlock;  
> > 
> > While technically it sounds correct, the potential problem here is that you may
> > fail this in case CONFIG_GPIOLIB=n. Is this GPIO optional?
> > What may happen if GPIO is not optional, but for some reason setting it fails?
> > 
> > TL;DR:
> > I am not sure about this patch. At least I'm not comfortable to take it without
> > testing on real HW.
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   
> 
> Thank you for your feedback. Since I don't have the physical hardware to 
> perform the necessary tests and ensure there are no regressions, I agree
> that it is safer to drop this patch. I don't want to risk breaking the 
> driver for a minor cleanup.
> 
Maybe Crt has the hardware to test. For now I'll assume this is not
going anywhere wrt to tracking in patchwork.

> Best regards,
> --
> Salah Triki

