Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390942B73D
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379814; cv=none; b=ubuHe6bIZhODRt1UFG04iR+6gXSa1zmjUBQo976qrW34pSCOJfP5N3zZ0r3RbmNNADLq4g93UGNiaSa/GT3M0wt57cIBGb7DO9Aps+Of/CZ1P8jfudEHHVQI+w69vBdWS0cOXa2ajI8qTbcvbP3TaAOxaNI9RFpubUIh1CT1BmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379814; c=relaxed/simple;
	bh=G0cEtM/RqwD+i562v7/w0BBBUpZUKp+Zy1tyVG8BYhg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIVrlth7ihBMd2A/TG2rEAsqySEhTPJL3WiVlJNW633nvR65Tu0LQWTcTn4mqPOip4TUi/4OZHah2kOrzwpZkk7WlTF1THKak2MB2xzvRcJzezKy4l850j7G/WYCjwFqQaszTDYKOInYnkkEYzL/nnSr6Yn49zsx9XxBBElBW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQzaiDxO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQzaiDxO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891f625344so103048615e9.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777379806; x=1777984606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QwBWq0hgunzkZk2TMgQTcmjfyJm2LqzA9SF6YjXsyP8=;
        b=eQzaiDxOz6OSk52UQmVdLuPuwa7pBv63GssT9h6jR1Uf7PaFTiqm0XJ+CQaYPGKKTR
         JjxAjC8mOujlm5gMIMC5hF7fEV5ElQmFBCLik/DOq2rmnpVxoLasRTxBlupeuBo8Y8O+
         r6MrVlThgEgHXtk5UcQzkJphrmeiL3oWBPnHHjZ6x+zpeYWgT2ZZ1N8Fl/tPvZG55vM1
         ACJxAoXtOC7Pmk+5h3NfsBo3KYgDqXJzdVEkK+asxXbY1Ze6Od96xZSXeZrM3JihnnGK
         TxmJjOxGKqEaOQLr8PKXWdMpoc3KGJnLQl+dUmWc0tBprIsxESbxRHeQNAT8AonhM+zh
         lEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777379806; x=1777984606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwBWq0hgunzkZk2TMgQTcmjfyJm2LqzA9SF6YjXsyP8=;
        b=Bvz9gkey8/S2DsYlaItagBOinXJ3j/Xjt65VNjCI3EAF1x/sODhU5D2YBA0zok/OFx
         tE6lLwAcQo65zSlc+ZTR9uF1XTSps40LBZuW9kUKm6Nh616fNcs1hR/+/9xrGUaIfaT7
         2Gs/N2s0I0dGaehxCpYb7ZeDe7s+7lkvsyBQXihQWBdl5G/YMSIzrHgOu0pEYB5+2HgT
         w+tbhzXx6sVEDwVwk1oD858uJ/G9AzNHBINdD7+xeJEggLg5HABSziCf4+dwjE9JjVjd
         29Kvh788nTEftGFqe+hdNe30hctrkLeh6qrSJamBtnwV/V7qPsE4X/ORYFLo9lu3p5WY
         MnjA==
X-Gm-Message-State: AOJu0Yxh53KHkjCxtvuGQXBIGQ/WIzpiyY/RltwrBTwjKMbwHXqaKEmh
	qhK9DJQmfZXtzaoAGIgtcjP/7YYNYisz9/h7mpXlLGaC+83R4aHasPWhWy8ulAYe
X-Gm-Gg: AeBDieu2TzxKLniudsYcvwm6i9DgDQdK8QFLo2ADhd8PhizRNeeJfZuT4hdGb8RjTzV
	1yx46ELIyFJ0xmphTgBZM2Z3BwjEF02iXLmY4sWbUD+iV2qtF8Q5z24Z4QrYUi8fCRKvOCMvtET
	lYGBUHGSBPYw6PzRdzqzT7vqBtb1rnOjGwAEoTweEs7rvepFsARmzX33Dbm9bDrM0qApmlc7c09
	IRHuMyTyLjHFPH/Lh+eC5H16og0IrVJ2cwBf4VXXMgFrwANa9h5X2mqVP4AwFpHgbtHSfOEM7sK
	V69iwwWoLrUqduTMQ+G+7f/3lFR/RjhcxHC2eQf9smXce5ZOvBxXOCVMy/oLtRMdh31wAyG0O/g
	AbxkWShx1e3ZI6wpLreFGP3i0555o1hsSZvORY4TpPhx3xpPPN1S6FKtLWxIpF+sqtUq7ds0RNv
	5ykJhbXdweE6zT6T99LdDHLjDb1rORuvHohL2RCGR6Dsk2P0rBB9ClJcF9sqUngZ3TYAR2oRaT1
	DXZfsDDnFxhhbzeQXVRq7LG1VHOMnPtK/K1q8Cbapgr7IyLbACBJi2Pwev6Rg==
X-Received: by 2002:a05:600c:a08b:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48a78a536acmr34725835e9.14.1777379805651;
        Tue, 28 Apr 2026 05:36:45 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a79ab6ec7sm19674585e9.10.2026.04.28.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:36:44 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 28 Apr 2026 13:36:39 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Michael Auchter <michael.auchter@ni.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 04/11] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <oertvxexvwsdkducew2hgtrnxh47uiwzwy4vmza7gno32chmf3@725ayfhynu72>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
 <20260427-ad5686-fixes-v2-4-188e05199368@analog.com>
 <ae-kx3Igcj5mpEYc@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae-kx3Igcj5mpEYc@ashevche-desk.local>

On 26/04/27 09:02PM, Andy Shevchenko wrote:
> On Mon, Apr 27, 2026 at 12:30:11PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Fix powerdown control by using a proper bit shift for the powerdown mask
> > values. During initialization, powerdown bits are initialized so that
> > unused bits are set to 1 and the correct bit shift is used. Dual-channel
> > devices use one-hot encoding in the address and that reflects on the
> > position of the powerdown bits, which are not channel-index based
> > for that case. Quad-channel devices also use one-hot encoding for the
> > channel address but the result of log2(address) coincides with the channel
> > index value. The issue was introduced when first adding support for
> > dual-channel devices, which overlooked powerdown control differences.
> 
> ...
> 
> > +static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
> > +{
> > +	if (chan->channel == chan->address)
> > +		return chan->channel * 2;
> > +
> > +	/* one-hot encoding is used in dual/quad channel devices */
> > +	return __ffs(chan->address) * 2;
> 
> If channel->address guaranteed never be 0? This is UB otherwise.

All the possible values are managed within this driver, so this would not be 0,
if so, it would fall into the if statement above.
 
> > +}
> 
> ...
> 
> > +	st->pwr_down_mode &= ~(0x3 << shift);
> > +	st->pwr_down_mode |= ((mode + 1) << shift);
> 
> Now too many parentheses. Also do you guarantee that mode won't ever saturate
> the bits outside of the given mask?

ad5686_powerdown_modes enum has num_items = 3, so max value for mode is 2.

...

-- 
Kind regards,

Rodrigo Alencar
