Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B58395AED
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583960; cv=none; b=u/4HMTZPSgLgeChRGAq7sqfBTwya7F1laOv33r6wZw3jCE9ru0RU2arkCwjiFNr+lJt+f/6M2DsC8nIPIhJ439o2zMW+tF5ybvg2kL5klzA5+qr3mbP2KJkAPru+mLNnK+EwuURizsewRB9Fpx9Na/BsIX43zNdICXh1Yzm7hDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583960; c=relaxed/simple;
	bh=yihKF7r74w0pKwj7IKwES1AT1LtYO73g8Ehu3pfaJQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coLyFeIPwECJqTK6elxIRlTpVmyLJ8gXPCkYUQUtLUIUblpjtBj9B1jbtfrIxTNPXCRcXJ37pdo3frhAowfzHyWnlGIqWpTUuLcwF3bnIIJVP3jn3yBLrIbvendrr5YXBRGRb7eY5p1RmG7Ty65wDCu0dfRGk5ge/FA7V5TZO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeofbcTZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeofbcTZ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4585a116a4aso1645863f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778583958; x=1779188758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OidTfMPPXPs1lrurNfI8WbziimaZNAI/uHskYuG7YWY=;
        b=jeofbcTZ3AqRExLzMOU5OAbgBEice6Dmx7hiksNZsgW55ETvj/Yqi69CX76JEj1FTg
         ozTJXc+igDhttCAeVq824OnhPrQbX48AElDsY0mwoeyifFwrBbW9mUi2/gDO0LUEORIC
         eZlojqripnru9Hq040ccd88Xo/XjGGI+fCxDpWVB5jqZtYWYGf++t7HCMesK8H+Jtoe8
         ndsQ/wOri2axIUuMK+0oCLeSwuCKH57AU9NlCkI3YgZwEibZ58zypqXLPEqIgUAoFgnQ
         trBnI4q12XN5eVSftDwCETag1fOXRrlpmf+E/b4DPaQ513mGPMmA8QYsBax+zExDsmXg
         q7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778583958; x=1779188758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OidTfMPPXPs1lrurNfI8WbziimaZNAI/uHskYuG7YWY=;
        b=PUC/SR3cHmATl+YO2H0DM4BTjb5K+MBZ2dptPxG9i93inhkXevprugUa0tx+Xc33WO
         1UBvCnqkTQaBwd83umh8FS6OhN7eXVIRp7+h3Wb/Au7CgQMcQvh6LUL0RloPiGPLnpe/
         0p/PFae5eLGe+K3Iu+cWVnI7nMpHmcf1TUE+5z4uKDFOYDkKIUfC3eG7A999Vz2a47Z+
         hTzIw1iEviLHxZcCJwtjMsOUD15pAsg8JoGpDJHZ/sDZQfaSDMC3ErpttiO25MvxzkHZ
         aFf5ORvy44yPnW7xPLonrZXx/Lu/5G7CvZ/J8Srw7Z5otjEm3xZyEL/0TXqukZSYSbLB
         NH2g==
X-Forwarded-Encrypted: i=1; AFNElJ+AVtsdOh7f4YKS78hb1yjvVStG4wHeoOsPTcZqjsPMiduaSXtGU4iU+PaN87qJ44yKAi+O2PFzCug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUp32IxsR2RRw3oJhQBg5T3ddv0PQsSMsZRk8x5BWLVwJtF2Kq
	Gbk6sMKm6cSMDbGmokuAM8NOFQ1YBXBn67XEP1shAVv7Tp3Iu91o6Qte
X-Gm-Gg: Acq92OEIGkLAi80Ypw/t4UPQW1fLWsOgEZV64zYqjPtVWg1d8ixQxju/Lts8w0ySsXW
	hraONhLEHBpXHAiUQtInLA393NGLwORmLa6MKnxJv55eI7tp+4Uml1uwE/bD8mzOp2gVkQOnkn2
	/3+ExkBtFxA/IM6zwgakomeSRAuURUV8OZskq6Hj8Aot+fqUGYm9aibalN5k4eemBPkv2LSPoey
	me0J/gJG9vnwy8Atv469w7DL7Se7MPcjzfzFCv64OGqc/WGNnalAKTOe6630ioHL5lR3bOB6h4y
	fLHILrhXYYxTjNewEUali2X8sphZbEutHPgJXTiuNiAqYK8+uARohOgtK55fvkLG0AqkNE07HCz
	AfUKFBwJCrsHLxI5/x6aa0v0/qN8wz/ff09VEpcSeiojyk+sHU2/wQt2tWHZ1V1KADLLKTqIsn4
	XIvnwioTgyEtqhqQ==
X-Received: by 2002:a05:6000:2c01:b0:43e:a72e:ec5a with SMTP id ffacd0b85a97d-4515ce1c804mr44450540f8f.20.1778583957170;
        Tue, 12 May 2026 04:05:57 -0700 (PDT)
Received: from nsa ([185.128.9.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eab7sm31284036f8f.23.2026.05.12.04.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:05:56 -0700 (PDT)
Date: Tue, 12 May 2026 12:06:51 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Stan, Liviu" <Liviu.Stan@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <agMIxeg1zqz4n4e8@nsa>
References: <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af3oezNmmBhI4Yu4@nsa>
 <SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af4LCQiqNaiMzFkX@nsa>
 <20260509154600.02e2d11a@jic23-huawei>
 <SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <20260511121820.3be9e635@jic23-huawei>
 <SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <agLhb-S2ISSjaopc@nsa>
 <20260512115520.5833ce45@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512115520.5833ce45@jic23-huawei>

On Tue, May 12, 2026 at 11:55:20AM +0100, Jonathan Cameron wrote:
> On Tue, 12 May 2026 09:24:27 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Mon, May 11, 2026 at 12:02:31PM +0000, Stan, Liviu wrote:
> > > On Mon, 11 May 2026 Jonathan Cameron wrote:  
> > > > > > Ok. So what are our options here?  Present it as simple resistance and leave
> > > > > > userspace to figure it out or add a new channel type? To me feels like new
> > > > > > channel type makes sense.  
> > > > >
> > > > > The current approach presents it as IIO_TEMP since the chip outputs coverage
> > > > > (using the custom table interpolation) via the temperature result bank, not
> > > > > the resistance bank, but I agree a new channel type makes sense. Should I
> > > > > create a specific type like IIO_COVERAGE_PERCENT or would a general
> > > > > IIO_PERCENTAGE be better?  
> > > > 
> > > > For ABI purposes we don't care where it comes from.
> > > > 
> > > > We already have some 'ratio' type measurements like concentration which are
> > > > percentages and similar to those I think we need some indication of 'what'
> > > > is being measured given it's unit free.  Hence IIO_COVERAGE_PERCENT seems
> > > > the better choice to me.  
> > > 
> > > Understood. Will do that in v2.  
> > 
> > I do wonder if a complete type is what we want? How will we present it?
> > 
> > in_coverage_ratio?
> > 
> > What I'm not too convinced is that coverage is relative to what? Well
> > it's a percentage so I guess we could not care and leave interpretation to
> > userspace (to know which device is dealing with). Still I wonder if a
> > new iio_chan_info wouldn't be more appropriate? In this case applied to
> > iio_resistance. So something like:
> > 
> > in_resistance_coverage_ratio
> 
> I'm perhaps missing something - as far as I understand it there is no meaningful
> connection to resistance in what is being measured.

Maybe I'm the one missing something but as I understand it is that the
more coverage we have (more liquid in the sensor area), the less
resistance.

> I think what you are proposing is similar to measuring current via voltage
> drop over a sense resistor. We don't present that as modified voltage, we
> present it as current.
>
> Here the thing being measured is coverage rather than resistance
> so keeping resistance in there is confusing for the user.
>

Hmm ok! The above two paragraphs make sense to me. Hard to disagree :)

- Nuno Sá

> If we wanted a type to modify then we could do this as a modified area measurement.
> Channel type IIO_AREA (which is new) and modifier IIO_MOD_RATIO (also new).
> 
> Jonathan
> 
> > 
> > So it's clear what physical quantity coverage ratio is affecting.
> > 
> > Thoughts?
> > - Nuno Sá
> > 
> > > 
> > > Thank you!
> > > 
> > > Liviu  
> 
