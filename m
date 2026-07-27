Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC53E9F60
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143142; cv=none; b=M/g3/T3Df5gBPxMNsjXrtH5YPZYk+joJC2PcIHgPANtiikSHOB0lvrlTQYNx0xMDKS+pjjJffCKx0FLNIDZHpAGAhiCTRegFS2QVo4gBzUxa7cmZFlXg6Qb0DVIrLDN42wad6Fun0xMrLGKNwgGhgI5TH1tHquyGmulIrbCDfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143142; c=relaxed/simple;
	bh=Zy/C1kSICIxQV8qJ5+qR9sxTNqRgcuri1YslBruhkZs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbiHjNItb6tAQEQuchfnkJAfXfVGyiWrkciP9aNVaXIQrePkT6Y3DIJcOFyX7V0FLxjnCCOr5OjpmVwReFTycvmTYkhxttwqaQBeTYBl40xMLSu/FlBOxcIMKIa9ISdSZiQtV+njfGU6S5sS2FG8o4vbrixh0Mm9CKooPsoCur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgq+tAO/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgq+tAO/"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso3239197a12.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785143139; x=1785747939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xa6du2hskAfuvL5DvwnynjBiYF7AzqZLEYEbhlKLATU=;
        b=Fgq+tAO/Nx2D1/ADm4l3n9UXb289PWRcfGa4EHeijKE8zQEKPt+vP1LwZBOxpWYY8E
         CK4C6VuCip+p2dElRiSIARS6bs2gx+TPDtbGIw8rTLz2mqQwHs1UXuDDyYoBQ6R3V4N/
         RCiPuFmG2RRSJrndOpz4kW7KFQ74GuylVngfmHPC34VMxUFMy7nZ+zxv6C2M3p4C6+7p
         AFQHu4crtbR1Nutk6BjS0up3u/a5OEtNVMYeBfaoqdspD5/9IxkMmjMAUcNubrbOaBN7
         xFlvUAJDdqDU7rXGWZABbdCsaV/c68H2q/b3ap1P5v6QxamsFBYW4mUE9L5Ink5MI15W
         QbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785143139; x=1785747939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xa6du2hskAfuvL5DvwnynjBiYF7AzqZLEYEbhlKLATU=;
        b=MSgwogBqF2cTQ/3pO4DoFGWJOV1cqABSpQlnW+ZmVPc0cEa3mdHYLK2SBt/nCJ91Is
         9AUSwQSeXNrtUi4itcJTOJfudnaDPI4Nib3tM2YliNO3kYFwGhFVPhKYuxPTCuux7+DF
         FkiCi0Xv/qrEiCudVY/999FIxEH09NuN11WFluK7TFuCDRkMbKLlChpJraOHRiFeIfRb
         tBP8KEL2t2L3M98aQiLk5vTTA7Zwayb12AlkXU0qgyduxb90+aWL21IhBqkl09a+2g4T
         rHDs6uY4u//eEPDKFuoeQq06l5FXIzHQG40gbCpv6p5FlE7fah+0WsAPo4yQcOvSUYxZ
         y0Ew==
X-Gm-Message-State: AOJu0Yx95YCvISDPEI2Ipat3/OuAG4Jh55C0RBMyXBPQN4R/7MK05oxz
	5NkFr6194kF4MlfC89F1thV8S2HEaSZIE7suIG5DGbNBnMkn/d371v3k
X-Gm-Gg: AR+sD11tiQKunKytNVB/bQObN16TAdAC6W7FZCmKfUVYM55fXedov1vlVyJ/UxYqR8v
	eFvCbkkhnY5ebYlKbyYS5inSyFAWRrsWDXYV9Vpq7xHFU6jqPNz2DQpjqsU8vM2iA34Mdzm7LlZ
	/LWB5C43KRomu8i7SkqMQEvMhniJJ6iu/woIYBZlPtfZovhGMkwzg0+UVsHt3mTp7lS85KuuCO4
	4qFZX74AFERyX+eT29DqYwFLA3ouIXK6v1e7Iy6CrjNUVGKNRazWjDyUb5BmDSFj0eCpX+OaeS2
	Wja6f4a+KvN7MncYLt8ots8dVWMftasRbya4a9eUqZQplFsZNwzuM3BF9xXuHjv1ij0v36BQl0C
	VvgRiVaiaZXsHRlPOF4nFot9fN4BcTjXsBY9FB65V7dHHCJzrwSGYxq7Y52BhaPQDEJfobGzPm9
	eGl9UaEyrFdRjf4IvJnjie7aJ20Ivan0L5F8KpIbtVcT4ESxRVZC8g8yg8S/OJXzaKUkF3OcpD4
	3wG0g==
X-Received: by 2002:a05:6402:5383:b0:698:9251:2f87 with SMTP id 4fb4d7f45d1cf-69fc11a2e10mr2408351a12.39.1785143138950;
        Mon, 27 Jul 2026 02:05:38 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5543ab7sm2278741a12.17.2026.07.27.02.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:05:37 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 27 Jul 2026 10:05:32 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 15/17] iio: frequency: ad9910: show channel priority
 in debugfs
Message-ID: <wdxe6pwcgwlunpjpx6veymajt4tqxkakr2tg3k7wwqpxq3rqnl@klrmhb5qe263>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
 <20260722-ad9910-iio-driver-v9-15-459d1df5ac56@analog.com>
 <20260725235621.6dd73e71@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725235621.6dd73e71@jic23-huawei>

On 25/07/26 23:56, Jonathan Cameron wrote:
> On Wed, 22 Jul 2026 16:50:24 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Expose frequency_source, phase_source and amplitude_source attributes in
> > debugfs. Those indicate from which channel the specific DDS parameter is
> > being sourced by returning its label. The implementation follows the
> > priority table found in the datasheet.
> > 
> For this one sashiko raised some questions and made me wonder how this
> actually works given it is using active_scan_masks and so far we don't
> have any buffered support in the driver.  My guess is you backported
> this from on top of some other code that you haven't posted yet.
> 
> Please have another check that this all works with just the series
> posted.
> 
> Note that you will need to claim buffer mode successfully to mess
> around with that in paths that aren't inherently only used in buffered
> mode.

Yes, I will drop that part for now.
 
> 
> 
> > @@ -2078,6 +2092,171 @@ static int ad9910_setup(struct device *dev, struct ad9910_state *st,
> >  	return ad9910_io_update(st);
> >  }
> >  
> > +static inline const char *ad9910_frequency_source_get(struct iio_dev *indio_dev)
> > +{
> > +	struct ad9910_state *st = iio_priv(indio_dev);
> > +	bool ram_en, mode_en;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	/* RAM enabled and data destination is frequency */
> > +	ram_en = AD9910_RAM_ENABLED(st);
> > +	if (ram_en && AD9910_DEST_FREQUENCY ==
> > +		      FIELD_GET(AD9910_CFR1_RAM_PLAYBACK_DEST_MSK,
> > +				st->reg[AD9910_REG_CFR1].val32))
> > +		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
> > +
> > +	/* DRG enabled and data destination is frequency */
> > +	mode_en = FIELD_GET(AD9910_CFR2_DRG_ENABLE_MSK,
> > +			    st->reg[AD9910_REG_CFR2].val32);
> > +	if (mode_en && AD9910_DEST_FREQUENCY ==
> > +		       FIELD_GET(AD9910_CFR2_DRG_DEST_MSK,
> > +				 st->reg[AD9910_REG_CFR2].val32))
> > +		return ad9910_channel_str[AD9910_CHAN_IDX_DRG_FREQ];
> > +
> > +	/* Parallel data port enabled and data destination is frequency */
> > +	mode_en = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> > +			    st->reg[AD9910_REG_CFR2].val32);
> > +	if (mode_en && indio_dev->active_scan_mask &&
> 
> active_scan_mask is only set on a call to iio_enable_buffers.
> So what is this checking?  I guess today it will always fail as
> active_scan_mask is NULL.  Once that is in use, it will be racy
> however, so you'll need to claim buffered mode (or fail in which
> case the null check isn't needed).  That claim will hold it
> in a particular state - under the hood it is taking mlock
> which is what sashiko suggests - that is just meant to be opaque
> to drivers so do it with an explicit attempt to claim buffered mode.

I will have buffer ops implemented, so I better cache the current
scan mask in a state variable and have that protected with the local lock.

I will drop those checks for now.

> 
> > +	    test_bit(AD9910_SCAN_IDX_FREQ, indio_dev->active_scan_mask))
> > +		return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_FREQ];
> > +
> > +	/* FTW: RAM enabled and data destination is phase, amplitude, or polar */
> > +	if (ram_en)
> > +		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
> > +
> > +	/* single tone profiles */
> > +	return ad9910_channel_str[AD9910_CHAN_IDX_PROFILE_0 + st->profile];
> > +}

-- 
Kind regards,

Rodrigo Alencar
