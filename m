Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFCF36493C;
	Mon, 19 Oct 2026 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378902; cv=none; b=pgg5rufQmgWgaF/IKPICOuKeeQ7DHhup6daL/dPufqwjWcnljR83PyXxKNdJcnUYP5qq+TT1LTDnm8XOEAnqW3+z5pK71MigHAg1MhvJm/drpOKTqCZJxAkeLMvKEOdp130NR3vAe7fsuBnDXxeYOvvZiBs63/jom4LKkSq84dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378902; c=relaxed/simple;
	bh=VWn0uQoOEoGiJIbN/zvdT6e5+n9Eufqzc2wlyytqKwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij4Cpd7cTtnp7Aaq+Tj0koIwRBnKXNkvdCSMskJrhKlqLS+4JDcFlYF7vDoZwz88hrzKsTyM5FxGvYSBV/9NG0bLXJyB5eyX+lCGTzSK2bSMY2Y6Y8nxtse9uuZRfHpCbU3vKdsnHGeGehWMNwqxH5aXBdhxN8G/8mblbtry80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifXDmOXQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifXDmOXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E3A1F000C6;
	Mon, 19 Oct 2026 03:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792378901;
	bh=Nm/7u4OXmRI/tZsZaERR4EMWmMNSAf7Kf2Ba0pBac4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ifXDmOXQq5BHAIYtO3rs41GppZEFu3ne3YbVFCyY7Ownj09lqlFV5wP8QxLvJEaou
	 BbfBd6nSfvUhGQ+p1ceUJCS9bJ0VmVfClCz2ZS52Jh6y0yP6eL1bL2kfVGEO3Utj7v
	 QlTvXPFLAIhQaknItdrPoLlwB4wozeL1q7Jcs05CAVeDZFTBPNu0sYFwlv8UL38tmR
	 4CDy1O/Ffs5IfhqJLxF3cuNbzbaq7KMOa7gOicY2EJW2KhpoOlhkX309TdOfo8uS36
	 NIwYQhn9pTqCGSaCIA8OYEGub01i6J0d3BQy09R1cQer2WrvZnoh5V1jmaLyoZ+RiN
	 ZWcGhazbnq3gw==
Date: Mon, 19 Oct 2026 04:01:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Crt Mori <cmo@melexis.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mlx90614: Fix dual channel probe
 condition check
Message-ID: <20261019040135.1da889ec@jic23-hlaptop>
In-Reply-To: <aqvoH9ohxkJ6iPei@pc>
References: <20260917110121.631587-1-salah.triki@gmail.com>
	<CAKv63utdoBrCFiw8vkGsMhY9PrWX0DWdxqP5szvTGpdmfSQh5A@mail.gmail.com>
	<aqvoH9ohxkJ6iPei@pc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 14:16:15 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> Hi Crt,
> 
> Thanks for your feedback.
> 
> Actually, the patch primarily fixes the behavior for the MLX90614.
> 
> In the current codebase, MLX90614 has `chip_info->dual_channel = true`.
> Because `mlx90614_probe_num_ir_sensors()` checks
> `if (chip_info->dual_channel)`, it returns 0 immediately for MLX90614
> without reading the EEPROM CONFIG1 register. As a result, dual-channel
> MLX90614 sensors are incorrectly registered as single-channel devices.
> 
> For MLX90615 (`dual_channel = false`), the condition was bypassed, causing
> an unnecessary SMBus read to EEPROM CONFIG1, even though MLX90615 only
> supports a single object channel.
> 
> By changing the check to `if (!chip_info->dual_channel)`, we fix both
> issues:
> 1. MLX90614 correctly reads EEPROM CONFIG1 to detect whether it operates
> in single or dual channel mode.
> 2. MLX90615 skips the EEPROM read entirely.
> 
> I don't have physical hardware to test this on; this bug was spotted via
> code inspection.

Explanation makes sense to me and as Crt hasn't come back with
a reply, I'll assuming Crt has no objections (shout if not!)

Applied and marked stable

Thanks,

Jonathan

> 
> Best regards,
> Salah
> 
> On Thu, Sep 17, 2026 at 01:27:48PM +0200, Crt Mori wrote:
> > So this fix is for the MLX90615, which is registered as single channel
> > operation? Did you test on 90614 as well?
> > 
> > Best regards,
> > Crt
> > 
> > Crt Mori
> > 
> > Melexis Technologies NV
> > Transportstraat 1
> > 3980 Tessenderlo
> > 
> > Mobile: +32 492 46 22 15
> > E-mail: cmo@melexis.com
> > Website: www.melexis.com
> > 
> > ----------------------------------------------------------
> > The contents of this e-mail are CONFIDENTIAL AND PROPRIETARY. Please
> > read our disclaimer at http://www.melexis.com/mailpolicy
> > 
> > 
> > On Thu, 17 Sept 2026 at 13:01, Salah Triki <salah.triki@gmail.com> wrote:  
> > >
> > > In mlx90614_probe_num_ir_sensors(), the check on chip_info->dual_channel
> > > is inverted.
> > >
> > > Currently, if dual_channel is true (MLX90614), the function returns 0
> > > immediately without checking op_eeprom_config1. This forces all MLX90614
> > > devices to be registered as single sensor (num_channels = 2), making the
> > > second object temperature channel inaccessible.
> > >
> > > Conversely, if dual_channel is false (MLX90615), the function skips the
> > > early return and performs an unnecessary SMBus read on EEPROM CONFIG1 even
> > > though MLX90615 does not support dual channel operation.
> > >
> > > Fix this by negating the condition so that single-channel chips return
> > > early with 0, while dual-channel capable chips (MLX90614) proceed to read
> > > the EEPROM configuration register to detect whether 1 or 2 object channels
> > > are present.
> > >
> > > Fixes: 3d5ead238bc8 ("iio: mlx90614: Factor our register IO and constants into model specific descriptor")
> > > Assisted-by: LLM
> > > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > > ---
> > >  drivers/iio/temperature/mlx90614.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> > > index 27d6ab5f5d7a..4f79da1f905e 100644
> > > --- a/drivers/iio/temperature/mlx90614.c
> > > +++ b/drivers/iio/temperature/mlx90614.c
> > > @@ -565,7 +565,7 @@ static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
> > >         const struct mlx_chip_info *chip_info = data->chip_info;
> > >         s32 ret;
> > >
> > > -       if (chip_info->dual_channel)
> > > +       if (!chip_info->dual_channel)
> > >                 return 0;
> > >
> > >         ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
> > > --
> > > 2.43.0
> > >  

