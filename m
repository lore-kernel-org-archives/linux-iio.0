Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40092F260C;
	Thu, 13 Aug 2026 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583413; cv=none; b=lV7D+eLkUV9519MW2DRMwA+ElIiGwz4bLSmgYgSHN3kzBteLWYtTaXeTmAEJKa+yZdcgzHBfBYjSjUz16hb39QWXDlbEU8vDeY4B00SrtF041kEYTFZsuq7aRBYJfqKiYxC2a0dkUgB7DyuPawno2T5QgRMz1jMvrwUZqvXm/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583413; c=relaxed/simple;
	bh=5oHIXdwRMlw7mG/JtjZsZn8KwsuypBEdaI6oHICdlaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPMfvixLWfZBisHmqUxsobVaDnAUxrwVM9kBaWNm9sXa7icp5DS6i6RCh8MhM+A8kbfNjhWVFOe187LSG7cShHBaTyjoztti0NN/86p4hqGVHGiTe39EyHNatlyUJfH1tS2D6v8DAJ0NczxB+q1/AAowpt0bjr6Mcf5Hpc443Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT3/Ll7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT3/Ll7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842381F000E9;
	Thu, 13 Aug 2026 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786583412;
	bh=q3prjzild7GI/cDnnwF60WjWE2l0dBm22oVauOsvXbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aT3/Ll7d0zTDUOpsRYMih5nIKZHrRsUfTSN3Pu+L9XJA1Rlw5NdK/FxDaCVCktwMS
	 cmo1JhdjWUrO6cLV5q7+rTI6MpC7jJML7fnGYi42DddVvvD4hMmoMvqnQckRD20GBf
	 ok/Mkmam3xCYu0v0AUhMf///PWMCt4DHRZZWgSWFDFlKkOw/5efAjkk8YFBOg3CUAz
	 H+ZhkFEP0bK2/ykR111KByKwi7a1rIsLT7LCojJuFk6lVd2aXAYLnpOxc4mhatGbuw
	 wuN/eH7CYMI1I7y1pLdiLVta/BCQX0x2PTtsVifsmVzk6NeQgLDcWILawrOjY/H7xy
	 XqfuN3biLcDYg==
Date: Thu, 13 Aug 2026 02:09:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] iio: light: veml6031x00: add support for
 triggered buffers
Message-ID: <20260813020958.5fc3f0da@jic23-huawei>
In-Reply-To: <20260812-veml6031x00-v6-3-7eef6e4ce290@gmail.com>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
	<20260812-veml6031x00-v6-3-7eef6e4ce290@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 22:27:42 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Add triggered buffer functionality for the two channels the device
> provides (ALS and IR).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

A very trivial comment inline. Feel free to ignore!

> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> index 021bf726c60b..43a701f62aea 100644
> --- a/drivers/iio/light/veml6031x00.c
> +++ b/drivers/iio/light/veml6031x00.c

> +
> +static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	IIO_DECLARE_BUFFER_WITH_TS(__le16, scan, 2) = { };
> +	unsigned int i = 0;
> +	int ch, ret;
> +
> +	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
> +	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
> +		ret = regmap_bulk_read(data->regmap,
> +				       VEML6031X00_REG_ALS_L,
> +				       scan,
> +				       2 * sizeof(*scan));
I don't care that much, but you could combine parameters on one line in
a few more places to reduced the code length a little.
e.g.
I'd be tempted to put the two lines above on one line or even

		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ALS_L,
				       scan, 2 * sizeof(*scan));

> +		if (ret)
> +			goto done;
> +	} else {
> +		iio_for_each_active_channel(iio, ch) {
> +			ret = regmap_bulk_read(data->regmap,
> +					       iio->channels[ch].address,
> +					       &scan[i++],
> +					       sizeof(*scan));
> +			if (ret)
> +				goto done;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_ts(iio, scan, sizeof(scan), pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}
