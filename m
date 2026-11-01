Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793558129;
	b=1YXKGhYdl6cJPZcl5vUJdks9rpthZ4ikyFEinJb+ZTQ0IeGYnwso8UPDvAR81Wjzthdm
	 Y4o7XpR3A1sp12pBEnuwFYmjAABDNt6XppaLDZ+i11TVM5uy06qQKbwTXD9/ih9vMaRBS
	 TIWAH2cxF2pHHvTm/4hYfB666/Q/Hm9EabL4MDF/yjw48rDjtOmxIFS97DMMpg3w2wpTl
	 R2Tw8+Ztq/b4iGB2Cb33uAoYq2/cfMPYUYHygcpQANoOc0fRhrKIdm4ddCALyPpHwhK/h
	 mAL5kfAXWzw0oMe0J3TsVNd3fmWAiKkr+ys1g03BGfRNEEi/I1Lej75xPaUCd6/Pjgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793558129;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=714q+JQndWob5uh3djoFeHGesUURXR98SNz0mVZNiR4=;
	b=AHESfhVf11EhTA9cfkqfT2VFKkbEwtzuSU2kLyli3XWY3HaMPcqgTGAP7KW2SXcc8AY1
	 A9reHckwf3FKF+crV9TmySK6Ak3bc2P88adZAgidb13dR2sbIPae4tqkIs2zA8dRlxHOi
	 mEyqVkOu8kSyqcqW5kzxmBYi/olb/KxT2RDd5HwOJ1ODz8QjV3NtKeohU50rX2ZAbMLEt
	 RSTXi+VHg7yrQ4UMrMepilGvdbEA7QwtalfUVW6KwxiHgs2HhG1L0SpT0nsXarL3xBcYs
	 CTQ/rQ3IlmGq1n3BQXBFt0h+YWqV8w7GVONSYBWkp3zgErv/NXAxKxxMBYQJBylvIdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WW+Il0lZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D5606A324;
	Sun,  1 Nov 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WW+Il0lZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29CA1F000C1;
	Sun,  1 Nov 2026 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793558128;
	bh=714q+JQndWob5uh3djoFeHGesUURXR98SNz0mVZNiR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WW+Il0lZGSBKBlhrFX6Q6wAKYQUoX9LIXnvKUVAFsdQZFBaQ0exmpyezgWrSAJA0N
	 9Z0rzTGgSBNRK+jEZ+0BR93PaNlb3k8tnQ90s5poMYuXIrSmyNtC3QYwvx+oz0fZ8z
	 tmgV8W/33IqOeyttrg06C7DkhQZfHkEdLoodgvNCEJi7eu3EbpBpwXJhX45oRwqSu7
	 E+i/4dkVEBiIwdOKCtCm6xwkTSse4zI7lPYKKO8w/NTXM5lBppOChtbHTe5zbOttrd
	 90EweljoeYp+SZS2YAMcBuOWZBjE362uZS0pcVg6VRUShhtH16k4N2uHsJ3E8RRfRP
	 ZUsRFdgh54hkg==
Date: Sun, 1 Nov 2026 18:35:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261101183523.693e4b48@jic23-hlaptop>
In-Reply-To: <at-0cXiBV0RM-Att@ashevche-desk.local>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB2528DB8EE8ACEBF9551ED52EA5612@SN1PR12MB2528.namprd12.prod.outlook.com>
	<at-0cXiBV0RM-Att@ashevche-desk.local>
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


> > +		/*
> > +		 * Now read the two registers making up the measurement.
> > +		 * The datasheet says to read MSB first, LSB second.
> > +		 */
> > +		ret = regmap_bulk_read(map, FDC1004_REG_MEASn_MSB(0),
> > +				       reg_vals, ARRAY_SIZE(reg_vals));
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);  
> 
> We still have two shift operators, so it might be not a bad idea after all to
> have a combined variable with wordswap done in case of LITTLE_ENDIAN
> architecture. Jonathan, what do you think about this? Reading the whole set as
> 32-bit value and convert it if required
> 
> 		// also note in this case we don't need to have _MSB in the name
> 		ret = regmap_bulk_read(map, FDC1004_REG_MEASn(0), reg_val, sizeof(reg_val));
> 		if (ret)
> 			return ret;
> 
> #ifdef __LITTLE_ENDIAN
> 		reg_val = swahw32(reg_val);
> #endif
> 
> 		*val = sign_extend32(reg_val >> 8, 23);
> 
> 		// I assume the following is also possible in this case
> 		// *val = (int)reg_val >> 8;
> 		// but usually we use sign_extend32() in IIO even when simple
> 		// casting is okay
> 
> This also reduces stack usage.

To esoteric for me.  We'd have to add comments on why it worked to limit
the future blast radius.  Now, what could we do that didn't need that...
The problem is that the regmap_bulk_read is feeding us two native endian
16 bit values.  Well, you could 'fix' that...

		u8 be_temp[4];

		ret = regmap_bulk_read(map, FDC1004_REG_MEAS_n_MSB(0),
				       reg_vals, ARRAY_SIZE(reg_vals));
		put_unaligned_be16(reg_vals[0], &be_temp[0]);
		put_unaligned_be16(reg_vals[1], &be_temp[2]);
		*val = sign_extgend32(get_unaligned_be32(be_temp) >> 8, 23);

Or something along those lines...  I'd rather something explicit like that
than Andy's suggestion, but I'm not convinced on this either.

> 
> > +		return IIO_VAL_INT;
> > +	}

Jonathan


