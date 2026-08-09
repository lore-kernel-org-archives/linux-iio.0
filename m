Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705A3AC0E5
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264119; cv=none; b=D4VQ6btSeL5bhMi3W1+KwFgVxySv75XhSt1jS3zKpKOB/mhO/lr4hhmt3JCtABfJxF4prHvLn8FJuXv0dDlQ2JKYHsA68TARcaNMCBT38csqiYkGJHf+KjgTgtwcwBgVTEGTAN3Umk2r/wtmBdgokgWdfODBksmG3CzB3m4D1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264119; c=relaxed/simple;
	bh=YXpLRM6umo8V4xg323AreRYHizHOiOHqe7uQwFnN8ZE=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:Mime-Version:
	 References:In-Reply-To; b=ka2tvyV7mgGdkuPPlGZuudO9/pjbB0tV1yNZTL+a8c0wZmwsie0DQqOZTE/zKzYN8rLm3TjjLgVsL6CJDpjAuiixp+ZApxdfgDMyYUUnraaLujXv104ikixIVPaACrPQjCn3WM6gsE/qfnVfq1t5K8Lf5oSWQRwAd/iRlGyOccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0PN7WTv; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0PN7WTv"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-966e7380109so694219241.3
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786264116; x=1786868916; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7G5oRky/QdUuCGIgfMUBx7pkDbVBEGsOaieaMvV9e+M=;
        b=V0PN7WTvuG1buv6lQvFxECvnLhwSbALA0MSWRhFrM9aSpe+abCq49TDPKzIR/kF3Ad
         pxj38vjDuHfpIJJqG3n6jGih7eRH8YFDXwjJp8vEi354H85qI7R7EqtW2zQ6ZN9/92Hh
         HfTvrtPVEvxO4Xeq8MzrpF2AMD7hDlrbLdfn00MwB4lzAlB03wtYpDUIEUwEYuQhKvXg
         d1tQiYxzvbrq2jTM+/yGUyVRvGksORX3mvw4+enHbmnhNRhC2G35H/kdzrso7NT6APeL
         atk3Syqz5aBsHP/WQavj+BwBOA5HDbyNLJ0LJc54yZTuAL4A3YBdQX3O9Izh1kZQw84U
         tFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786264116; x=1786868916;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7G5oRky/QdUuCGIgfMUBx7pkDbVBEGsOaieaMvV9e+M=;
        b=Ly5+rHK83m+9axIldUznizFYrdSNe9Y/d8Z3i15ZGbWX8rkvIafLdyYPE4G4xfPRKT
         /PWR0p+KPuD7butzPJg5a4xhQ4nMzR7LuH1XgpY7x6XLS4NauiQ+VJneTPa04MkRxCcQ
         w+Byj6tokIvrFcnAVTUtn5u8I8gWBQybd1zVk7MpshmNaW7ufc9Q4yVMATQpFdpn8vd9
         YN9wxgj5S3ZAd1f1jAfcJIXpUnYWY1FAoTaSeu+GTzTefJzjtm8gva1yfsSuTG2rnWEG
         VeYF8RNEF3v3DasYwJ3W6T/Fa+FI6tF21LfnemFgclSWxa3iM0C0vlpmaM7hrr38QM9z
         8Ryw==
X-Forwarded-Encrypted: i=1; AHgh+RqXqI4MA482MnXLgR2vSyxDKS8eorN66aig7HaVZgq6wHMy/vogpt0u33Nroij+jEBQdF6aTsr5IqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZZ8VkpjELP3Zw44sYhb/8d7GI/B/xKN+5L1Vyd5B2VZblnLI
	QLIAJ6LDP13fT5gXGQXODl3kaVQejAPUpkQO2K/EoOCV3Y5RROEzD3qg
X-Gm-Gg: AR+sD10/NZgKxFdhY/7NnnoSwG8LkF6M8lELAYK17QNJEi8vVFKNdleexRkPHnRFRCP
	d3rj7/FXQz80bZzvBsnUl632RsgWUsHOTkeGnyg2OPP/7Xe1tezXN9UCuGU+bjVPUPfWaJkTzHG
	m2kZV8+blqYPiFdLmpN+x4R2ECEB9mGUdV32P2AnJqwkhf9QRlYnxWqfPp6WDOToRcCSvdl3oxR
	uzfe4fl8YYCNERkDjyNiJDQ6JxvSNjBi0oLjtX4vvu/rxQRD8qYpBqYQ4bsgw71fol5/OL0Twxr
	eI4XpNkLwDwLVT/gqmO6/Zs/TLngJ2jGFoHw78GHTzKpNfSHdJcrDDlaxXlJ8taMpxpcp19jBll
	xjcuPn+/I0MTPlScCY5seppCTv74XfmmZWhMXFyRW6HsBp2W04t72GDmM/zkZw767KzQOEPGdLH
	g/9VzxAhtU4pwRIYPuYWiRozayqoJ/c57HDd+8GHGWYaLEvOqRFAQ=
X-Received: by 2002:a05:6102:3e1d:b0:739:15ef:cdfb with SMTP id ada2fe7eead31-764e5a4fc95mr3401685137.5.1786264116471;
        Sun, 09 Aug 2026 01:28:36 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-76400dfe036sm3211129137.8.2026.08.09.01.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 01:28:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 03:28:28 -0500
Message-Id: <DKK9S36LB543.2T124NE3TNETN@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] iio: adc: ti-ads1262: support triggered buffer
 sampling
From: "Kurt Borja" <kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-7-f89925d72792@gmail.com>
 <1b6b6981-1a08-42a2-a03a-4366b980da13@baylibre.com>
In-Reply-To: <1b6b6981-1a08-42a2-a03a-4366b980da13@baylibre.com>

On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
> On 8/7/26 10:58 PM, Kurt Borja wrote:
>> Add triggered buffer support and a data-ready (DRDY) hardware trigger.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/iio/adc/Kconfig      |   2 +
>>  drivers/iio/adc/ti-ads1262.c | 264 ++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 266 insertions(+)
>>=20
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index dbf76427912b..b9b561be8347 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig

[...]

>> @@ -241,8 +245,16 @@ struct ads1262 {
>>  	bool need_avss_uV;
>>  	bool bipolar_supply;
>> =20
>> +	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan_buffer,
>> +				   ADS1262_MAX_CHANNEL_COUNT);
>> +
>>  	/* Protects transfer buffers and concurrent SPI transfers */
>>  	struct mutex xfer_lock;
>> +	struct spi_message msg;
>> +	struct spi_transfer xfer;
>> +
>
> Where does the 11 come from?

Size needed to hold both transfers for multi channel read. I can use a
macro here.

>
>> +	u8 tx[11] __aligned(IIO_DMA_MINALIGN);
>> +	u8 rx[11] __aligned(IIO_DMA_MINALIGN);
>
> don't need second one to be aligned, they aren't indepedant.

Ah, I forgot this observation in the last version. These are used in a
full-duplex transfer, wouldn't that require for both to be on its own
cache line? I just started learning about DMA.

[...]

>> +static int ads1262_enable_and_read_last(struct ads1262 *st,
>> +					const struct iio_chan_spec *spec,
>> +					__be32 *val)
>> +{
>> +	struct ads1262_channel *chan;
>> +	int ret;
>> +
>> +	lockdep_assert_held(&st->xfer_lock);
>
> What happens if something else (e.g. gpio in the future) decides to do a
> register write here. If it wins the race, will it unintentially read the
> data? So do we also need to read the stored data via command here too?

On each trigger, we are holding the lock before we enable the first
channel, until after we read the final conversion. So we don't really
care if there's concurrent activity in-between triggers. Am I missing
something?

>
>> +
>> +	if (spec) {
>> +		guard(mutex)(&st->chan_lock);
>> +
>> +		chan =3D &st->channels[spec->scan_index];
>> +
>> +		/* Group 1: MODE0, MODE1, MODE2, INPMUX */
>> +		st->tx[0] =3D ADS1262_MODE0_REG | ADS1262_OPCODE_WREG;
>> +		st->tx[1] =3D ADS1262_INPMUX_REG - ADS1262_MODE0_REG;
>> +		st->tx[2] =3D FIELD_PREP(ADS1262_MODE0_INPUT_CHOP_MASK, chan->input_c=
hop) |
>> +			    FIELD_PREP(ADS1262_MODE0_IDAC_CHOP_MASK, chan->idac_chop) |
>> +			    FIELD_PREP(ADS1262_MODE0_RUNMODE_MASK, ADS1262_RUNMODE_CONTINUOU=
S) |
>> +			    FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal);
>> +		st->tx[3] =3D FIELD_PREP(ADS1262_MODE1_FILTER_MASK, ADS1262_FILTER_FI=
R);
>> +		st->tx[4] =3D FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate) |
>> +			    FIELD_PREP(ADS1262_MODE2_GAIN_MASK, chan->gain);
>> +		st->tx[5] =3D FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel) |
>> +			    FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2);
>> +
>> +		/* Group 2: IDACMUX, IDACMAG, REFMUX */
>> +		st->tx[6] =3D ADS1262_IDACMUX_REG | ADS1262_OPCODE_WREG;
>> +		st->tx[7] =3D ADS1262_REFMUX_REG - ADS1262_IDACMUX_REG;
>> +		st->tx[8] =3D FIELD_PREP(ADS1262_IDACMUX_MUX1_MASK, chan->idac_mux[0]=
) |
>> +			    FIELD_PREP(ADS1262_IDACMUX_MUX2_MASK, chan->idac_mux[1]);
>> +		st->tx[9] =3D FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, chan->idac_mag[0]=
) |
>> +			    FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, chan->idac_mag[1]);
>> +		st->tx[10] =3D FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->ref_p) |
>> +			     FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->ref_n);
>> +	} else {
>> +		memset(st->tx, 0, sizeof(st->tx));
>> +	}
>> +
>> +	ret =3D spi_sync(st->spi, &st->msg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	memcpy(val, st->rx, sizeof(*val));
>> +
>> +	return 0;
>> +}
>> +
>> +static int ads1262_fill_buffer_mult(struct iio_dev *indio_dev)
>> +{
>> +	struct ads1262 *st =3D iio_priv(indio_dev);
>> +	unsigned int chan;
>> +	__be32 val;
>> +	int i =3D -1;
>> +	int ret;
>> +
>> +	/*
>> +	 * This routine enables and reads channels in a full-duplex fashion.
>> +	 *
>> +	 * When a channel is enabled, the previous conversion is clocked out o=
f
>> +	 * the shift data register on the same transfer (Section 9.4.7.1). Thi=
s
>> +	 * allows for low latency software sequencing but forbids any
>> +	 * communication with the chip in-between or data corruption may occur=
,
>> +	 * hence the need to take the xfer_lock for the whole operation.
>> +	 */
>> +	guard(mutex)(&st->xfer_lock);
>> +
>> +	iio_for_each_active_channel(indio_dev, chan) {
>> +		ret =3D ads1262_enable_and_read_last(st, &indio_dev->channels[chan],
>> +						   &val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/*
>> +		 * After writing to the channel configuration registers, the
>> +		 * conversion-cycle is restarted and the data registers are
>> +		 * cleared. This means we have to reinit the completion after
>> +		 * enabling to avoid reading stale data.
>> +		 */
>> +		reinit_completion(&st->drdy);
>
> This seems racy still as DRDY could have been triggered already, in which=
 case
> we would time out waiting for the interrupt. Or does the DRDY toggle agai=
n
> even if we don't read the data to trigger another conversion?

Yep, in continuous mode it just keeps toggling. However, data corruption
may occur if we read just before DRDY is about to toggle again. Which is
why...

>
> Would it be possible to make one big SPI messsage that contains all enabl=
ed
> channels and just run that instead? Insted of waiting for drdy, it would =
have
> to add a delay at the end of the sequence of xfers for setting up each ch=
annel
> that was long enough to ensure that the conversion will be done when we r=
ead
> it.
>
> Or we could just do similar to the start_one() function and don't leave
> it in continuous conversion mode. Using the delay option of spi xfers, we
> could just tack on two more commands to start and stop the conversion aft=
er
> after writing all of the mode stuff so that it still all happens in one S=
PI
> message.

...this gave me an idea. Instead of relying on delays, which are a bit
of a pain to calculate because the datasheet only gives latency values
for the nominal clock speed (I'll have to reverse engineer the formulas
for settlingtime :]). I can actually read in pulse mode here and stuff
the start commands inside the same transfer. The buffer would look like:

	6 bytes       | 5 bytes       | 1 byte
	--------------+---------------+----------
	channel_cfg_1 | channel_cfg_2 | start cmd

Thankfully we can chain commands without having to lift the CS line so
this is efficient. I didn't know this when I first started developing
the driver.

The buffer of course can be further optimized if say, all channels share
the same IDAC and reference configuration, but that can be done later if
needed.

--=20
Thanks,
 ~ Kurt
