Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D232143D
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952229; cv=none; b=iMsuJP6GNTrLJGQiKKrkwtBdtGIR8j0AL2CSnJT+ywl8yOgI2eXq57QfX96+SySEwxNPOJIfOVt7eTayzf67m/Sm3u839jyOm/HIVYzjwc6WV8lO2Me8U5occ65aQn5g0Dk8XAmLCdGtC9Tp1qddfbEBKuFfl4qprvtRi9NmRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952229; c=relaxed/simple;
	bh=QuwSiXxxAz9s1imVlMmi43QZsNuj1bTIesseCFKmuds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0pgz2EvHjQGfJ/UDtTdhqPLCSxlqFn4jkMUF7t/ha92Ae1pfz0jGRNuA+v0LWW0ClTiPuhjivYhnYPyrDyAWG+rTnAhQaDyJy6WDxDeRLmic6gAyH6+ak/IydBmzsCX7uNGvoCFSd7kfV0CF+RD7paxh/WrWgMEFkzq/9Yio9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRexWF2g; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRexWF2g"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fe62837baso7310118f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 00:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779952226; x=1780557026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgbYyL+BoS+xdVnnxGKDCu+Y3jq6QLq8J99nhT/iuUc=;
        b=CRexWF2g1F8t2Cg3wXuBm9BzWsvbr+MYhb4+8mpofnoLNx8IDqXodAhLEsiCFDJyLK
         wpLJyrUkUuO+hi6Xh0F8JoFKlwyMHvCFNbH1uEYe00Kqqq8HY3tOCXbh51n4y5v/6yaG
         cR8YMn3203mZbI9wjU416MjVMtE7hec21RH/GsJi4beYW/bvxtcWjR1I5sk3Zzy0UjPA
         EC4civs64ClReApGBtexybIYBVIYbnMJsazL+ZNlu+HkKx9lsbVM9oQxiyiZhuFANpJE
         /3fsJQZzagc5PTpGrYHJsEPNPvEK885eIf/w28lDMbNxW1V/3Eny7hYdmPGx7+vcrzX4
         VHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779952226; x=1780557026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgbYyL+BoS+xdVnnxGKDCu+Y3jq6QLq8J99nhT/iuUc=;
        b=j5xDYMSQPWiS5yhiLGh7lDOET/XnPr+wiZ/gttAtnHUwAruLqsOWyASL5G3lUFRG8u
         aBqEwTwlITV4s/p7UtaakSet+GLu0Vv+Ji4MEsUYyUpWaGtrX3YJsR/6y7O5NukmdNLq
         Mmoi+ChznqNVfJH/It1L+ZhJKJVB4lrTbeeKH81oxo0JpkuZpbMribo+ulC+3U1p3YZF
         uFwj4udmMrBgvRmIICVqhgmqgI6ocpDVnknt90gsCNkuZvzDdt5cRYCTFLsLg75Y22RI
         ehnQts+AO46lNoK2h10vQn2cndT1RCMFtMwPHyP9dajaG46+BTstgVjFwpBKgaS2lgRs
         TRag==
X-Gm-Message-State: AOJu0YzvrsSl9Y0TEYjycIlnObtiacFE/kMqUwHOC0xvb9itc/AfYeno
	FZAtt6sNyH+pM7weUnvCLH1ig8Aat2cMrozm5aMEZIBZOwkqU0pUb/R/
X-Gm-Gg: Acq92OGvAoj0wykV8GuyetyCEM0ipJb3Vh7/C5lQna9xpbZa5lR0NdzB0gU1i/VNiab
	eSvcvhjK7dg+itaF6/QjjU94ccQ3J+QfBW65V0AV2GiWTesWwbxj1aQdv//x01PNhoWwGkCnHV3
	LQfeDJoyha0Tf48fQfQ+NgsUIxnd+3oA9JqsZRhLq3XKQ2FE6qqfrG86WktP9fL22PA+/z2+7pY
	8O/CvDr2TTdpZU+TUUyTY+KZM+BbCTFO0ZrSBBj85rmzeiRkBOKyv7D81F/6XsO4343DSdG5P3j
	vcVuJrrKDvfvjPY3ZsSgeRUIrh1hDbHTw2y8W1THYiYLPIAkJTl0gWDBHeNTaHPcLWYs9wvNYD2
	DVXY6yP7ayNTUL4gQausMaihDDT0+Okk6Yyw1356EbGpvxSbukPX/O/UctZ8eDC7kkWg0r0pAIv
	o+iAHjefM9N1O7Pn7LEsm4D5znoLzw63tAxg==
X-Received: by 2002:a05:6000:4a09:b0:43d:762e:76c6 with SMTP id ffacd0b85a97d-45eb38a7f6fmr45658380f8f.7.1779952225866;
        Thu, 28 May 2026 00:10:25 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54903csm11874184f8f.6.2026.05.28.00.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 00:10:25 -0700 (PDT)
Date: Thu, 28 May 2026 09:10:22 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v4 2/2] iio: light: add support for APDS9999 sensor
Message-ID: <ahfp8oFEa026vqzi@gmail.com>
References: <cover.1779781224.git.azpijr@gmail.com>
 <3219ec710db09eff8a0324b2f6ab3b78e883df9f.1779781224.git.azpijr@gmail.com>
 <20260527170656.4ef393bf@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527170656.4ef393bf@jic23-huawei>

On Wed, May 27, 2026 at 05:06:56PM +0100, Jonathan Cameron wrote:
> On Tue, 26 May 2026 09:55:46 +0200
> "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
>
> > Add IIO driver for Broadcom APDS9999 ambient light sensor.
> >
> > The APDS9999 is a digital proximity and RGB sensor with ALS
> > capability. The driver implements the ALS/Lux functionality
> > using the green channel, which uses optical coating technology
> > to approximate the human eye spectral response.
> >
> > Raw IIO_INTENSITY channels are exposed for red, green, blue,
> > and IR so userspace can compute its own weighted lux.
> > Proximity (PS) support is not yet implemented.
> >
> > Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Hi Jose,
>
> A few really minor things inline.  Given how minor they are I've applied
> this series to the testing branch of iio.git with the following tweaks:
> (shout if you disagree with any of them!)
>

all look good to me, thanks!

--
jose a. p-a
