Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFE3AE199
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763009; cv=none; b=DfedAZCxyzKxQDTGCPXlmu6me+XPauUaqqCIOy3qwcXz6dje5DnKglFFoRQmRS9j+1sCQrOy+5+Ul+MK2Jqa3KZhFyY7GEGjym3Oc9/8XoJOo45IXd2BlOemfOXKv296bqY/Qk318GoYQLx/YeViQ4pJmeaO3ax2q6dFGjt8KpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763009; c=relaxed/simple;
	bh=g925oDHJpCLjUvom101ukrVWFkHEpx+c7c6wk313MJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncyxFsSlFeUN6NZvYufKR6yRWW57gOVYAs7ZTBRuFR8F/4e81dxjvNdP3BIScLdsHdzX9gzcowQ01v+m53wKLWcZAHaut3RlnBJxpJ2S+AWwIf+QaJyAl8WD90HuwtyDSbyfc/2nCebGwyZo3oMixkzPfLTUiL5BKPsXpjvybW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWH4bzJb; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWH4bzJb"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66fa10f35caso2306948d50.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 23:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763007; x=1789367807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ocoYZDUBL0oSCHSm39vxqV2yz+NMY7WJASmnMs0VSY=;
        b=pWH4bzJbBxPmc7BFUpJGiHUmBmLRtG4y+BGUfLThl3nsCt3Ia3g7vtbIAfiMSYksKG
         hAqvQPqIYYyXmY3LX0S5tzdRwOSKNqzclgCtRdDu6NNC/DMRwD1qscfaMrrvsFEw8H5d
         VHl94hGYohnIwvKlI2luQFd2Zz2K40KYq6y3ma9pHrU3npqBPGSTyoW9oZqGsXseR413
         RDxMMxwuaB9hjL5SPS/yOeaZSs3iKTMG+PEFCUnuTa/Vtu+xt6HKuCcRRKbCoKlzxQsG
         7j9CiVvBTYQILJ757v1ZOyiT09qxsZD8cTJyqbsOhliPrnh75Z0PXCxJ53ZyuuM+eETp
         zPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763007; x=1789367807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ocoYZDUBL0oSCHSm39vxqV2yz+NMY7WJASmnMs0VSY=;
        b=AD/29Bp8wsTqVDdmZkzkD816vtGscQvcRjdWY4RHRl732nrZNZwvq0wrtfLFZWW+2w
         D73iT/ceimz8/JGuNFf0xhwpnfQH2KqtVwt20T3bnUeVmUX7gEoOpr+iTBcfKoJUEgWm
         q7dO7cw+B0N2yRnPpI3Qwo/NtDuJ3WoJY1gMZ8foTfBAflNCe+JD/FQJHBWV6qNASSQ3
         caOXVNJ4dqL2y0uDTUpRRldc0a/mytmsLL/mNggxGSVm1RkMQ7GVc5vLRonZo6diSAbv
         F4XL5hQSIbsC18NhfuW7oaphiZAf9tLI01J+uBR9DfqmdpZm0lxYFjMQv0IeTLk9Ddiq
         htfA==
X-Forwarded-Encrypted: i=1; AKwUvBy1ZrOc5tYRkSI8j7f7BaG60mWkKYVvdE+mXDcPi15aEV1O58yeTxye575lmFPEpDo6R5qTceZF87s=@vger.kernel.org
X-Gm-Message-State: AFuF++mHWyco/3fUkrOaQYg05EESQja6jtvRZCRVVyeoz93apGsIderi
	5rAGAtfLLs/Xr4+piknSTvt0+JofN8h8R3Vvnagndoe9LgsI7Psp24EsotHHae4xkr0=
X-Gm-Gg: AYBFou1fzIGT9Q93VZYrV1NiUIqaWvGUvDIRaw3IFBrRGN29I1eeemaf/6+BliH8lFv
	KDc77HVDryKZGV3L42dsKUXWnFb8DmDFNi0Zhit3JwX0kazfC9fj+9cEeudhjEYEanAe9f31SwA
	Mu5CoVzF/P2GVZE1TZSlfUbQ7TvlURF6qnjxgQBx18PUoI3vqynPAVFTGVVYHKY20HMmFMjhdBB
	BQk1o03x5h/Zd958mr8G4XnMbU2krRmrwcmduV98VV/6Sc70ppuaUzhGSD/I0E2LC2pWZyqe0Mr
	Ohr8rsWBfKR49zjwXrtA3uhqmSaoBlzysc+3vmAS7pqAuVZXox+EWvpGwGNqVkx6x72ECjNg1KO
	sSqxnlqCnfAULwmoQ57uZo0M/Vw8Rj3oPXiN7EMRr1tKl7Wf1I+fCBO3UHWMcphwsRCYEBwME5W
	FNQrB+6ScVnqcc5KKjr9egR5/Gpyopn+PutWCHL5ySvE8=
X-Received: by 2002:a05:690e:4853:b0:66f:c1bc:4019 with SMTP id 956f58d0204a3-66fc1bc492fmr2668552d50.70.1788763006713;
        Sun, 06 Sep 2026 23:36:46 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48d6ea5sm7811628d50.7.2026.09.06.23.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:36:46 -0700 (PDT)
Date: Sun, 6 Sep 2026 23:36:43 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Chang Yu <marcus.yu.56@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: add AS7343 multi-spectral sensor driver
Message-ID: <ap5be0ipNiS5lUI5@gmail.com>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
 <521c26094635bae6376d92f3cecf84c911d5a740.1788586814.git.marcus.yu.56@gmail.com>
 <20260905084258.350fdccb@systembl0wer>
 <20260906011145.4a0f4933@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906011145.4a0f4933@jic23-huawei>

Hi Jonathan and Joshua,

Thanks for the thorough review. Just adding some clarifying comments inline
for what I plan to do in v2. I should be able to send over v2 within a few
business days.

On Sun, Sep 06, 2026 at 01:11:45AM +0100, Jonathan Cameron wrote:
> On Sat, 5 Sep 2026 08:42:58 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > Hi Chang,
> > 
> > Comments inline.
> > 
> > Josh
> > 
> > On Fri,  4 Sep 2026 22:53:26 -0700
> > Chang Yu <marcus.yu.56@gmail.com> wrote:
> > 
> > > This patch adds a driver for the AMS AS7343 14-channel multi-spectral
> > > sensor with I2C interface.
> 
> ...
> 
> > > +
> > > +	/* Set 83.4ms integration time and x64 gain for now */  
> > 
> > Good for an initial draft, however you'll definitely have to
> > implement the write function for this to get merged into mainline.
> > Skimming the datasheet shows that there are more integration times
> > possible, not to mention that you can also set the gain etc.
> 
> If there is a sensible default / initial value that works most of the time
> (short value probably to avoid saturation) then controlling this isn't
> a requirement for merge.  It's a nice to have though!

I'll defer controlling integration/gain to future patches then. x256
gain and 50.1ms integration test are the defaults recommended by the
datasheet. It is also what adafruit uses in their arduino driver
(https://github.com/adafruit/Adafruit_AS7343/blob/main/Adafruit_AS7343.cpp).
They also seem to work well enough when I was testing on hardware.
So I'll use those values in v2 for now.

> 
> ...
> 
> > > +
> > > +static int as7343_suspend(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > > +	struct as7343_data *data = iio_priv(indio_dev);
> > > +
> > > +	return regmap_clear_bits(data->regmap, AS7343_REG_ENABLE,
> > > +				 AS7343_ENABLE_SP_EN);
> > > +}
> > > +
> > > +static int as7343_resume(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > > +	struct as7343_data *data = iio_priv(indio_dev);
> > > +
> > > +	return regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
> > > +			       AS7343_ENABLE_SP_EN);
> > > +}
> > > +  
> > 
> > You have suspend/resume functions, yet you're missing a
> > devm_pm_runtime_enable() in probe. 
> 
> There is not requirement to do any specific combination of power management
> for an IIO driver because what is necessary is very dependent on the usecase
> a particular developer has. So runtime pm is a nice to have only (as is the
> suspend / resume stuff we have here).  May well make sense to use the same
> for both types (there are macros to ensure that).
> 
> > Additionally, you could enable
> > the autosuspend function as well (note, you'll have to wake the
> > device before reading, there are macros that simplify this though,
> > see PM_RUNTIME_ACQUIRE_AUTOSUSPEND)
> 
> All nice to haves indeed - but not strictly necessary. Many drivers
> don't go that far initially and it is fairly easy to retrofit this stuff
> if someone cares.
> 
I'll fix up the suspend/resume stuff per Joshua's comments. But I'll
defer autosuspend to future patches. I'll mention this in the v2 patch as well.

Best,
Chang
