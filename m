Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A273EAC71
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144535; cv=none; b=nzFKyayNm0XvVUZ1+RfuEJaEvHo9DkT+54sHibbx6vhKfnn2g/MyaROLofEgwNj3t4TYt5G2yNbPm0VzDsFbHn2W52z95X84yNLvDLX6zgTSWakO6+vaq54pbZygasfCfemmnsdRYywlaezsHVaOApW4e8wHFB/Q4HevjRtaZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144535; c=relaxed/simple;
	bh=nQlx2kWnHJd3XJ5B5weviO3lv8P9gLWs39NgJOYDu0s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i27rtTXQbh0K/7nsSs4FdfAikPW/GQ0sfatbNB2+lFrIA5XrYZr/LSRKllDlqbrvzkAz3/XI3dqCERCzTivM3fQ7Pl8FRQdYasMdGLAUcrFazFQytbvUL2GrHHXsc2zb+ZJ+aAU4TtKxPTPvRsNbwWtlNAB+jpvkUFL/49312cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJmZjSsb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJmZjSsb"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1c26d7e951so356270166b.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785144532; x=1785749332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=INc0UxFlZdOC07viPjgsMk1340wWs0bSyky3tI3iXLg=;
        b=pJmZjSsbXuFe6ZgStpU3UH76pfLUdBC1BnYqqZtZbhRuGv99RxCCnyfEvd232cGC0R
         cjfgqSHp+KEROsvrZK1XmYTqZoTCEEvNiKb5U2lRJf8iA0aDEyD3Whg5EvDPpd7q3jT5
         1mMgH31oJrnhhyehgboY9IdeS/MxCMnAGF0+JDQFPWcu5BGGDMka27Bum78HjtSar+Fn
         kCU3RM98Ry9+7a6Za780sByXcZD9/fTya4YeWmuXmvHsWQbzXztuHIjnYfbvnhi2Bktf
         2fYM3Z3z+F0bH6bFnnS6zaAWHLfQ/tPmywoRfsqYR7FFTVBdDOQw47wYiqGDsTBKSY9R
         VXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144532; x=1785749332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INc0UxFlZdOC07viPjgsMk1340wWs0bSyky3tI3iXLg=;
        b=qrNMmfPH9P0Ic8zIlv/8GWRtXzZm1l++xB7Ha85H4WU6SADvmRoj5nQokIK/ncc1Rb
         y3QqnH0pWFlV8/YvaBi4Hi61CkyenOPBtw95FHNj7c37UciJ7yW7CFjF595zl2iYyhoD
         PNvQJNjtLhcznx6HHtCQChqfoNs7TTG4U/GEYg/RfGEgv1a/87tg43RlZQU3fJdcR8hl
         tr6nzYU0r5+5XGDrTdKXCs4f4EnR46J+tOt+0ga2jjxP9+8ikdvVrCS3tVSWzIx8Kjzt
         qnOmrpygjRhCh988Fp47ODebPQqNHUyBqtBMpwpNTycIAIzESzKgQAFZoAdDzR/Znjq9
         LbRA==
X-Gm-Message-State: AOJu0YxIw9pM8lMYbGMuQw40ZqziChLVcV8gQU7cVROz4kPxBjmomDtF
	fUMSugIEij7nvHsms7gzxdftZJvTW/tjejA2OS1YLo1BrtadCwi1JSJH
X-Gm-Gg: AR+sD11vFXhZ14pJl3vHL8jjuIEgQIhjy/Flb/DpPrwwiOrwmJQbQqSTFRUWCeGpDH/
	/z4AlCMrBTkWIv9S4odQeUswaMyZkLmnqBYko6Kuomh3GmNN1PIjiphlPWil+xqWTmV4OQixkat
	d0s0mYW4JqiF9GgmSvGhJrZmvHm9i9ymA5BcEMt3dfZSwnNrIbszQfVapg/YP9XA3VEepiM67/R
	jhm1NKKtoXQXg2z4OGmg35Vhj4moRlM2TI0bLJFOEh2sOWU86FKpST5cKMHNjCKBjaL841Q++bJ
	/SYPkptX3/f+71kLxY58Ei3WjOnwrq56+Zpsz6jyHEq3enNFSPUuhwzNsVIMc2Pfvzr4CLhzhKr
	dHY3tkne2kUOKmilEe+Dqt3QP9a+/s/PugMEiqkms9MXuJ+MpymssOdpV5s/RCiXCp+Xwy4GTFq
	2v31zQyTv3UZri06DTmeLBo0q6zlVzE5lsYz2/OBL0KRSqMEm2kDQ5U1k83AuVav3YI5wwaGKhv
	OGofg==
X-Received: by 2002:a17:906:6a2a:b0:c12:74b8:9d3 with SMTP id a640c23a62f3a-c1f1eabf2f1mr307455866b.3.1785144531681;
        Mon, 27 Jul 2026 02:28:51 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebbaf5sm607779366b.44.2026.07.27.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:28:50 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 27 Jul 2026 10:28:44 +0100
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
Subject: Re: [PATCH v9 13/17] iio: frequency: ad9910: add RAM mode support
Message-ID: <fv4zpxtmvobho3xna2pvmgdnpnwleil33bp2z6w3grzonxf6fq@yukanjhc5fsz>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
 <20260722-ad9910-iio-driver-v9-13-459d1df5ac56@analog.com>
 <20260725234637.4ee42657@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725234637.4ee42657@jic23-huawei>

On 25/07/26 23:46, Jonathan Cameron wrote:
> On Wed, 22 Jul 2026 16:50:22 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add RAM control channel, which includes:
> > - RAM data loading via firmware upload interface;
> > - Per-profile configuration and DDS core parameter destination as firmware
> >   metadata;
> > - Profile switching relying on profile channels;
> > - Sampling frequency control of the active profile;
> > - ram-enable-aware read/write paths that redirect single tone
> >   frequency/phase/amplitude access through reg_profile cache when RAM is
> >   active;
> > 
> > When RAM is enabled, the DDS profile parameters (frequency, phase,
> > amplitude) for the single tone mode are sourced from a shadow register
> > cache (reg_profile[]) since the profile registers are repurposed for RAM
> > control.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> As mentioned in reply to an earlier patch, I haven't looked in detail
> at the firmware cancel path stuff sashiko is unhappy with.  Whilst
> it looks like the sort of esoteric path where maybe it is fine to fail
> good to take one more look.

Yeah.. it is considering a cancel request right after the fw-update starts,
with the fw-update failing for an invalid format before the check of the
cancellation flag. With this, a second attempt on fw-update would fail again
because the flag would not have been cleared.

Unusual, but I can have that handled.

> One other thing Sashiko commented on inline. I think that is either right
> or a bit more detail is needed in the comment.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > index 6c794e1b4b1c..844cc0cc8f3e 100644
> > --- a/drivers/iio/frequency/ad9910.c
> > +++ b/drivers/iio/frequency/ad9910.c
> ...
> 
> > @@ -1119,7 +1220,7 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
> >  	struct ad9910_state *st = iio_priv(indio_dev);
> >  	u64 tmp64;
> >  	u32 tmp32;
> > -	int ret;
> > +	int ret, i;
> >  
> >  	guard(mutex)(&st->lock);
> >  
> > @@ -1156,6 +1257,41 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
> >  						   AD9910_CFR2_DRG_DEST_MSK |
> >  						   AD9910_CFR2_DRG_ENABLE_MSK,
> >  						   tmp32, true);
> > +		case AD9910_CHANNEL_RAM:
> > +			if (AD9910_RAM_ENABLED(st) == !!val)
> > +				return 0;
> > +
> > +			/* swap profile configs */
> > +			for (i = 0; i < AD9910_NUM_PROFILES; i++) {
> > +				tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
> > +				ret = ad9910_reg64_write(st,
> > +							 AD9910_REG_PROFILE(i),
> > +							 st->reg_profile[i],
> > +							 false);
> > +				if (ret)
> > +					break;
> > +				st->reg_profile[i] = tmp64;
> > +			}
> > +
> > +			if (ret) {
> > +				/*
> > +				 * After the write failure, profiles 0..i-1 were
> > +				 * already swapped in SW, but Hw registers are
> > +				 * still pending an IO update, so swap them back
> > +				 * in SW to keep the state consistent.
> 
> Sashiko's follow up question about whether a subsequent use of IO update might
> end up with these stale values seems like a reasonable one. Perhaps a little
> more detail on why that doesn't matter is needed here?

Here, I focus on protecting the cached states (reverting the successful writes)
rather than reverting stuff in HW after a SPI failure. The spi failure is delivered
to userspace, so user should be aware that something is off.

What would happen if reverting HW states fails for nother SPI failure... I don't
want to go into that...

If SPI starts to work again, other write attempts should be able to sync cached
configs with HW.
 
> > +				 */
> > +				while (i--) {
> > +					tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
> > +					st->reg[AD9910_REG_PROFILE(i)].val64 = st->reg_profile[i];
> > +					st->reg_profile[i] = tmp64;
> > +				}
> > +				return ret;
> > +			}
> > +
> > +			tmp32 = FIELD_PREP(AD9910_CFR1_RAM_ENABLE_MSK, !!val);
> > +			return ad9910_reg32_update(st, AD9910_REG_CFR1,
> > +						   AD9910_CFR1_RAM_ENABLE_MSK,
> > +						   tmp32, true);
> >  		default:
> >  			return -EINVAL;
> >  		}
> 

-- 
Kind regards,

Rodrigo Alencar
