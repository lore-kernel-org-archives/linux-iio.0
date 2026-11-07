Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022429;
	b=JJre7a6w5/LCXsSyXyhJp+4z3fD4UW4l4GtLpV0HQVbXc75Zni4cuekO/w9ZR4OzKEkb
	 phPMHqQKauqJIljrtDr3MVBpfm6U/LdFzGN7TJOlgqruA+0BnNFw6jlS3uGKqsT73561X
	 OjwqxSWEHdjA+gOsXi17jQfwv5s1rTP2xRDBzarv7+HIYW5OJRDI6/Ov2R7TO6Z5BPm3D
	 rup+Zb5GOQTkfG2XtKQbBq/4nE49UPzH93jXtnwO5bhet3Qn0u8DCm4KhXvgnHbiHUINy
	 Pk1+q5dxeCvKN2c3UtUcoxUdNq/dS4zOl2Rdkh5N4ZRRBsrVMcfKXeHRIzb9X5DnC/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022429;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qDSVjPseL3QAEULLVfJL/AdxXAU5ASZY412c98qtMFA=;
	b=2kQ8oc4kdXBgO+9HOad5v7SEBUczC2s181/Ea20WwN1ojcokA53+vehAwrNVBiSAgYBP
	 ZyyADQuRnUcKMCVGIJedfxfZOZoiohIkVWTLwWnqBj7nsRoajr6IdJIEoiIwhKEbtqYiq
	 H4yjmXRPWeVVrrIuxO/FTAOhB1I5XBvIU3LNzJXozOuKQLStDmkIXNYdsRRucR1MS5tM5
	 CRqQG433MZQytvkvNOGrSMRqe8hY866vawSx6WQo/hifjO3uP/Er6/WMTjz+2Rjcvi0mf
	 R+b2QftDEzV2DdbU+8zV/gWRt0ajx5VGkM5eMk1TWxe6xnrrRQ01nIHyIKBOFGLtcEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C50r/fU/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8F606A326;
	Sat,  7 Nov 2026 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C50r/fU/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB701F0089F;
	Sat,  7 Nov 2026 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794022429;
	bh=qDSVjPseL3QAEULLVfJL/AdxXAU5ASZY412c98qtMFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C50r/fU/gYCO/scuZDU1ZoiTeRX2i4HNsWCLeerlwwkz8MHbM49wIYZ2TY9oTOnKM
	 Bv1L3xvm0JXpAuSS84jpjAOAFNTGMoMfswCcmY/V8sHvE4kMwiTkuRNa4zV/cQ6qwn
	 BSAlbcEG6jGCYCp6tvW22417kFS3XezoMcfL7iX0kIsLyarptD0EekpW6MAuFthCPK
	 5ZX0ZS4aBp0Bo3ETeEiu2V3JWXpwBL05apP/dl6nAb0EEzJxEt0XbKIKzM+I9fRbQd
	 Z0VoXRr+rc/yW+jR69hQAuAo5FqMJh5qoLnIZr2JC3X4iEU8x4t4t6GLOWz6qN7T1W
	 F9OoCzF8EwMaw==
Date: Sat, 7 Nov 2026 03:33:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
Message-ID: <20261107033340.64062192@jic23-hlaptop>
In-Reply-To: <20261106091943.35783-5-clamor95@gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
	<20261106091943.35783-5-clamor95@gmail.com>
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

On Fri,  6 Nov 2026 11:19:43 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
> nearly identical to the LTR-559ALS-01, but omits all elements related to
> ambient light sensing.
> 
> Add a no_als_support flag, similar to how no_irq_support is used, to
> isolate ALS register access for the LTR-659PS-01, since ALS registers are
> marked as reserved and interactions with them are discouraged.
> 
> The ltr501_trigger_handler relied on the scan index to identify channels.
> This approach is fragile regarding channel status flags and can break if
> the index is not strictly set. Switch to checking the channel type
> instead.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/iio/light/ltr501.c | 73 +++++++++++++++++++++++++++++++-------
>  1 file changed, 61 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index d5ce6468a229b..e7762115df913 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -151,6 +151,7 @@ struct ltr501_chip_info {
>  	u8 als_gain_mask;
>  	u8 als_gain_shift;
>  	bool no_irq_support;
> +	bool no_als_support;
>  	struct iio_chan_spec const *channels;
>  	const int no_channels;
>  };
> @@ -192,6 +193,11 @@ static bool ltr501_has_irq_support(const struct ltr501_chip_info *info)
>  	return !info->no_irq_support;
>  }
>  
> +static bool ltr501_has_als_support(const struct ltr501_chip_info *info)

Is the helper bring enough value?  The !info->no_als_support
where this is used seems clear enough to me.

> +{
> +	return !info->no_als_support;
> +}
> +
>  static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
>  					   int len, int val, int val2)
>  {
> @@ -656,6 +662,29 @@ static const struct iio_chan_spec ltr301_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +static const struct iio_chan_spec ltr659_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.address = LTR501_PS_DATA,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
> +						BIT(IIO_CHAN_INFO_SAMP_FREQ),

The sampling frequency applies to both channels here. I'd just make that
info_mask_shared_by_all

> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 11,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +		.event_spec = ltr501_pxs_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ltr501_pxs_event_spec),
> +		.ext_info = ltr501_ext_info,
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};

