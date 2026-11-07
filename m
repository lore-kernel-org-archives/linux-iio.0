Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016542;
	b=YN4VeTkcDJtCxy+YTr8j7+a0ZIlJrJUj9/JymeLAJvIcM/sOnZc4lP2JpreqlpG7Q3qN
	 gNmkdEG5JXDgW440FLzSzNtqoCERYvpsxeakCiclOI8b1ZcFuUHvZEQ/nnMnvILUl22PJ
	 KCVmXD1QRUWPI3hcYIyGoYeorAibTtQHUqLz1Kn9KA/SxWxGQDEjyqByMAXf+ux1pxGw5
	 vnvFxVYyHozeoPDQqwUvKTadPsKMkC7brBAAacW9H2UMIXUhfjvFAIltv6AEIPghGnVoU
	 zW+lLi6UD9x4q4cl/pmqDpM3LiECXTBrP6aja1l69kh08DakuPSN+Dv8IaLT7zd49nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016542;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xprqEVmfr//EXHms83gU6cHf8/6IxtL82AoZClkBneo=;
	b=RzU9wLH6yw3eP7nUAPOfa0Gwl1jUfYxFmK7XdGwdFMQIMvzv7W2cI7v2E0QfyI6ke+MK
	 c6bWnBDD3JLoQZXoVMkBsf4nJ70wGKFzTmtQN94nQnZF+W/zlzvvJPfwPgSbvs1zYDBrE
	 N8uVLlbqT0Ylq5kO158iL0VpUT19m/LkTr5Hqq8A7FZyOHB8X/HhM7Pi1risEYNUj2pe4
	 VyL6r7zU/cOiHu7LloY8mlwr+qxMvt/lz6STG55gyCss2M6Tzfh+wMNTnD9HuSEX4qnee
	 iS/SOE+Vlevc/T7FVN3tQDtooqIyLfnDVb6bQCF2lpBTh7Y0eIbHwj4IBlDM1VnB4wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXnpRJMP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4CE606A326;
	Sat,  7 Nov 2026 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXnpRJMP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EB91F008A1;
	Sat,  7 Nov 2026 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794016541;
	bh=xprqEVmfr//EXHms83gU6cHf8/6IxtL82AoZClkBneo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lXnpRJMP2ghnVvUEw/mvpXAeMFN5igS44fMYEAFurda0JSaJ9F1k1tqvb3IVimEu5
	 bJI5xRaCbC8mBDcms/pte2i8VnLNyHAl8aTjuZx6uKmJGHr6ZkCiBHoDjng9NyGlAk
	 KlzKTDyvbbEUFh238bgJN3RE2bgwMvi1mj0PmuZ7v2quDyuN/LVpSuzbtUMRNqSjnz
	 JpZU6x1Jp1RVdbFHZUj2adqXc+l6jqOIMZXS7RwEBBD/zstk9B9ji1q6DuBsSLhUOQ
	 IU1LK+Q0EdOSC5j/Qi0bRvgiuIRtcj4Cw15mSIl4dJib1VR06EbtsU6thpWrNHwT26
	 jYqtJLD0ykMTw==
Date: Sat, 7 Nov 2026 01:55:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, "Trevor Gamblin"
 <tgamblin@baylibre.com>, Joshua Crofts <crofts@kernel.org>, "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] iio: adc: ad7625: use standard unit names
Message-ID: <20261107015531.32328dbb@jic23-hlaptop>
In-Reply-To: <20261106160529.876251-5-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261106160529.876251-5-Nicolae-daniel.Deaconescu@analog.com>
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

On Fri, 6 Nov 2026 18:05:16 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> Use standard unit spelling and macros in existing code:
> 
> - Rename vref_mv to vref_mV and ref_mv to ref_mV, spelling the voltage unit
>   as mV.

What about poor Heinrich Hertz?  If we are doing this let's acknowledge
his contribution as well and use _Hz as the postfix for those.

Also Volta isn't doing well in some of this.

I'm generally in favour of this stuff but it is churn heavy to
tidy up in existing code.  So my preference is keep these improvements
for places where you are modifying the naming anyway or making lots
of new use of an existing variable.


> - Use HZ_PER_MHZ instead of MEGA for frequencies.
> - Use MICRO / MILLI instead of 1000 to convert the reference voltage from
>   uV to mV.
> 
> No behaviour change.
> 
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>

> @@ -517,7 +517,7 @@ static int devm_ad7625_regulator_setup(struct device *dev,
>  				       struct ad7625_state *st)
>  {

>  
> -	if (ref_mv == 5000 && !st->can_ref_5v)
> +	if (ref_mV == 5000 && !st->can_ref_5v)

Why is it 5v rather than 5V?

>  		return dev_err_probe(dev, -EINVAL,
>  				     "REF is 5V in unsupported mode\n");
>  
> -	st->vref_mv = ref_mv ?: AD7625_INTERNAL_REF_MV;
> +	st->vref_mV = ref_mV ?: AD7625_INTERNAL_REF_MV;


