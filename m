Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385D5221F5
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550843; cv=none; b=sBHnH6+bJhp2HXpx4JQh4HJZBAfrVdcLQJMhVtheugEAzx+QEV2G0yz+mFP5tTkVL9aMtw2befwgIHY9mr0sFbT5t7tcdozNckEjr6Ve+joByvQYfUKO8wku30shPe+SoydB/VzWVSD2hp5lPejIHdu4tmT+GfyE7wK2nwZVR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550843; c=relaxed/simple;
	bh=lxGBmQaRhy9mdZLR1PJiHsdMBGqQHmddcF9WF6eOgAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eun5xNX8ZwDC9uqVCMkMYwCi7Dlx4pCT5oJp7AonO/0Er6o8lwMeOeOdJsbcu+7Eqi/Xy+9ANIVxEC5AGIWkijONUdCq+birGSJw74OvaqAh3NLbxeydcpW090grmyTOr7cfrZK7Zzck0/dn+VgFOwURs3lN9FVKOphxGrcWc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjqBNytT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjqBNytT"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-86e7f44b773so17354077b3.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788550829; x=1789155629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=srSTts7XJtXRSQX8o1LNKKWt/r8EHn/nfOIuyJlMJm8=;
        b=kjqBNytTNoUk5wApc0GnvixkAb90SSRk9iGmFS2Ctt8SITjJXKBwWvCdgdbmESu+h3
         gCQvIz6eAo6UxcWT9Pt0Y+2Sw2gV97YrgDq0M91tTpmID/NDw1cy/S/l1dTItSmFyHkz
         9RMSGULocd6aLyS+2gcuoo7vcGK7dslpEnvyLVhwtRx7O8ffKVMNV6ezs3nuKwILe05v
         5JMHawDd3pct1UMf8JlHs9igcus+v25L9qrUXpO37NSi+UyNgFl1ZV9eAAuIs04+yeRr
         Yu4H0odn44PpOmK/gsaCHeiiKW2ajuJVuxQdxTtEkuYSy0qjkRgmqGGcZaRFViuQm8Ma
         agtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788550829; x=1789155629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=srSTts7XJtXRSQX8o1LNKKWt/r8EHn/nfOIuyJlMJm8=;
        b=FcHjEoSFcwteWXIoZYz0fZD85+4shhhQfOINsUv3369RYqrcfKQIaMbT/sKt4ieuaj
         hGNQ3AYlfmRL/xDFPHYLiYJG5+xXEpIynF9u/MhRmHOnFhIv3PwAEmFRq8uspknBn60t
         ILt2gTU4vKT5/EzIOWJgOdYsE2BI6/E7v7jK3Wh72UYHVhyF0XZWl3OcKhmTEdT5Xssq
         eSioBVM8r53Zpehlo+Is/o/2XJ3R0IJ+uPMoZ7zhkW018cCakIG3zaxID1UrQ+v2mBm/
         SI0H5HVLZd6bvGwpsLYjrod9Eq5mbGKVGTCfulm0OnghLzofUlaeqbf7aV7SlspKFHAc
         J63w==
X-Forwarded-Encrypted: i=1; AKwUvBxUEIIXK9+XjNDyAuCmQgvsso2iUUvL3Shjs2b1Vm0g7ycAXI63dL9007A0Ga70DN9sV9ki6TG2Pss=@vger.kernel.org
X-Gm-Message-State: AFuF++l2h3rf2lrbMtBpW8zul9Ir6O7jT1ZTtvQmMWvLajneLW3GsAK0
	SQwSps5PvU/M8Z8bZbmM8zMtr/6wAxHysE3DVBVfjQbE40auyJVhOBYZ
X-Gm-Gg: AYBFou1by7QCL83QpSrcjnfTWa1q2AoJsJI20rNXJOA4Xg7xk2frSgmpZ8t+1tkX5rP
	NRr5nxHVZNuMib6Vo1RvQQJlcDP43LmwxbElyGRCOIejp+GZ1m+juaV+d9ysE9Z+MXMHmrKgqsn
	JXuj1ccDzpGSUh8Tnu+rAPo+sP2MNrKlrgyTRz/6puyS4Ic7Vuy/UcvUfqYimlI/MK+1sYf5Sih
	6tt/Y20DMPqSbdA6ZrKsnU1kytm16c3v2jeXPspkAqpELW5+VRB4WzlRZ+GAsgytyHejeRp+jYd
	MEPbPPIowKF0D+C+LFtbWiYBVYHEZU8Tk5ibwGU9FNTRobiiKjtXQ04vCqsFVIJAlvl6iYmjCTq
	JJ18u/o12lV88l+8h3aQYbk3k8iNFuPdi5PNd1DicPBqCteRCApOnFyKog1PLZt2Z+GSkDXRNP5
	Fq2uICNDXmubFtnutowiHXDJztA8q/W/45lXReH3+GYT2oo6xfEjmSJkI8038hOZ0DLHQ9
X-Received: by 2002:a05:690c:e190:10b0:81e:89b2:91ae with SMTP id 00721157ae682-87126aa5d51mr30794567b3.21.1788550829584;
        Fri, 04 Sep 2026 12:40:29 -0700 (PDT)
Received: from localhost ([2804:30c:94d:7300:da0f:c2c1:1aa6:43da])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439c4566sm25792517b3.4.2026.09.04.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:40:28 -0700 (PDT)
Date: Fri, 4 Sep 2026 16:41:22 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 01/13] iio: Fix typo in vendor name
Message-ID: <apse4gHE2pblXnN2@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <e508718734a06f005704051b8bc3d3d7a1a3b48d.1788368334.git.marcelo.schmitt@analog.com>
 <apkSNlQuQkjdNKvx@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apkSNlQuQkjdNKvx@ashevche-desk.local>

On 09/03, Andy Shevchenko wrote:
> On Wed, Sep 02, 2026 at 02:21:34PM -0300, Marcelo Schmitt wrote:
> 
> > ---
> > Now
> > find drivers/iio/ -type f | xargs grep -i "Analog Device "
> > finds no leftover occurrence of such typo.
> > 
> > Also,
> > grep -nrIi drivers/iio/ -e "Analog Device" | wc -l
> > and
> > grep -nrIi drivers/iio/ -e "Analog Devices" | wc -l
> > both count the same number of lines.
> 
> Why not `git grep ...`?
> 
Could be. I'm just more used to non-git grep.

> ...
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> But you also want to fix possessive suffix usage
> 
> $ git grep -n 'Analog Device[^s]'
> 
> Documentation/iio/ade9000.rst:7:This driver supports Analog Device's ADE9000 and ADE9078 energy measurement
> Documentation/iio/adis16475.rst:7:This driver supports Analog Device's IMUs on SPI bus.
> Documentation/iio/adis16480.rst:7:This driver supports Analog Device's IMUs on SPI bus.
> Documentation/iio/adis16550.rst:7:This driver supports Analog Device's IMUs on SPI bus.
> Documentation/iio/adxl313.rst:7:This driver supports Analog Device's ADXL313 on SPI/I2C bus.
> Documentation/iio/adxl345.rst:7:This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
> Documentation/iio/adxl380.rst:7:This driver supports Analog Device's ADXL380/382 on SPI/I2C bus.
> drivers/iio/adc/Kconfig:108:    tristate "Analog Device AD4130 ADC Driver"
> drivers/iio/adc/Kconfig:124:    tristate "Analog Device AD4134 ADC Driver"
> drivers/iio/adc/Kconfig:136:    tristate "Analog Device AD4170-4 ADC Driver"
> drivers/iio/adc/Kconfig:167:    tristate "Analog Device AD4695 ADC Driver"
> drivers/iio/adc/Kconfig:182:    tristate "Analog Device AD4851 DAS Driver"
> drivers/iio/adc/Kconfig:350:    tristate "Analog Device AD7405 ADC Driver"
> drivers/iio/dac/ad3552r.c:699:MODULE_DESCRIPTION("Analog Device AD3552R DAC");

Ah, thanks for bringing this suggestion. Will adjust the possessive use as well.

Thanks for suggestions to other patches too. Will apply them for v2.

Thanks,
Marcelo
