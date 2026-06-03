Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A88364053
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482014; cv=none; b=bINfsTCfnKzebzGN3/I37T0+TF2O6podNYTKE5dNeNk86/SpKHQ1QNVIOaYnf3rEcww98WezWfmP4Qh+9rZIeYN4muaz9LONNVNS/H48F/SP2PjFeaLwJuFBDc++1FBEcVuHu/e3QvR+6INi3bhsgBNyUwxrnXTI+UuvwkXO+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482014; c=relaxed/simple;
	bh=6JWuCjrtHouuP/SgAZ1opeRT+EYE2wYDmIx2BHv+9Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2IkQGau9TL0UGW73sRxZaBcuFzR3brdOSbobkKebMI2H+k41KTmfVAq5c7p9iiXOkVVeYjyR6EtsOvl/ZDQZCDivNQWYkr1bS6XEYLOP75Hwe5uQg8IpNqb48o3xUzrnai5vWGU1PsEvlRLg0O1iieuLZgwMfSLRXsF4HNELoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/i1EOdj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/i1EOdj"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso8787208a12.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780482012; x=1781086812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzJK2sZtZ9lh2JDEqWKWxmwImBV/cnCe18AOQPQmCZ4=;
        b=Q/i1EOdjKv/pa8OBHsNl8o5H6tl1AsU8n7PECT23/zAGBWWhaK/WrOU+fQJgldu28p
         IfsxYCtg5Oy6yBkhhHG16R/+JsyCbjcAzBWV7XkoPLEH0XNh0HOpUBSiGz+s5tgNfkjD
         tKnwHdyc1eEiWJta5La+j+A0jkP12yoMKbviV81qSCruBp+ZA3Z8jiwe2pIOSJStjNB+
         U7zcnIa/Z+cxUEDzUC5+8Un5wEdCtViJfu0xq7UqaGKcIkXbZ1/3hh5uUKqkWvtAIPQr
         d+n7HjPABsBvdcQN9pp5Z7ZkcNEuMq2BncMpRyw/n/x9BwEsC28BA9Y01ZfGXPRuLnlJ
         QK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780482012; x=1781086812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzJK2sZtZ9lh2JDEqWKWxmwImBV/cnCe18AOQPQmCZ4=;
        b=Zo28VkC0DMzaI7RmYvENWNoYpXF2OoMMuMKnZBlKI2W7BHaVxp2Sy5Qy5ePqxZHswK
         tefuWCSqi9iIOvTQcwUrkLVNxBYFBvZihI+UtVULrt0XNvwk11zZFXAuSK1kdHn+q9tS
         CwW8oG/yO+1KtAxnb3QcK1y51cRtsikzpLBqGmYTCbZdu9VDVYsCZ30Yv7X2VjUDCqrz
         B4IhpL0VEq95DeFp4oLYlLAHpj4uUe3/Rx6Z8UJavemZaaWsh/tm26O0fPAY9hdaB2pQ
         HGGCX5y0dkkKn8rOXAQH++PB6dwSwYBnwLrh5H7k91CwmduOePOd4raOMEOrrWetvd8+
         YbEg==
X-Forwarded-Encrypted: i=1; AFNElJ+LT1xN7Tqa05DQeCXStXRGiulGmrgsfcH2qL54UAcvughJ5VBjiW6PTDOaNgxMqiFvWwkfcoz+efc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNacrD27ML3tTtE6RN5/1i9yPui2BdhpZ7FG+ni69K7FxsYNa
	as9itlKoL9M6tnhFf6pD7EgmFwNjBR5wpJ/vR4r3rSfQ2Ag3PTfpjXZK
X-Gm-Gg: Acq92OFQR7+MhOX9pw916c+18gnry6Y2MGhb4pxVpiwGM7jNmwACVZPNKse3tMDbkTX
	btqmr7dAMfi7J6IHQYlpiwEXOFV56wCSMfblv7QgsqQ7XYEFfyZPCFxLFgpZKC6rWV8VNYFINCc
	2nO2YKvzg+zyi9de5JDjr8Ud/Hq8M/nTI6CQDkYDAaT6+vSuVan7jR9sAgoz3iDnbv/KHb8s1CC
	eMX9r6gDItJ75gRMQO9eSKPHscXmhwQsK6QQ8elmIK5roDUbWc+hG9VGIp4kBFAmFklMykWu4gt
	ckO65gWRRcZeBlHMyCXp4UkDprf/eYeBRveNEidqC6YDN2iZgwko0BI/y2UEDQki2x6TCqM92fu
	W0YXTyCQGu3KXn7DzHAdHbh+r3j1FKLTS48Aj1EEdgZgbODH1p9JCQ2AWCZQoNjQxgGwkLBPWCZ
	fYY14kIbiVrPiQUv9eDgqrC2QhDvErlg==
X-Received: by 2002:a05:6402:5242:b0:68c:3994:45f1 with SMTP id 4fb4d7f45d1cf-68e6fa73b28mr1296617a12.6.1780482011623;
        Wed, 03 Jun 2026 03:20:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2f34asm974022a12.4.2026.06.03.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:20:11 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:20:08 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Taha Narimani <tahanarimani3443@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Use
 devm_gpiod_get_optional() for busy GPIO
Message-ID: <ah__2Fjf0MxIQLnh@stanley.mountain>
References: <20260603123333.5608-1-tahanarimani3443@gmail.com>
 <ah_zMybQBDHakXpX@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_zMybQBDHakXpX@ashevche-desk.local>

On Wed, Jun 03, 2026 at 12:26:11PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 12:33:33PM +0000, Taha Narimani wrote:
> > The driver currently utilizes devm_gpiod_get() for the 'busy' line,
> > which makes the GPIO mandatory. However, the busy pin is hardware-optional
> > depending on the specific board configuration.
> > 
> > Switch to devm_gpiod_get_optional() to allow boards that do not have
> > this pin wired up to still probe the driver successfully, and remove
> > the redundant conditional chip-ID check since the optional API handles
> > missing descriptors gracefully.
> 
> ...
> 
> > -	if (chip->id == ID_AD7817) {
> > +	if (chip->busy_pin) {
> 
> If we get GPIO optional, this check wouldn't be necessary anymore as the below
> should return 0 IIRC in this case.
> 

No, it's still necessary.  It can be NULL because of the CONFIG_
in which case, sure, gpiod_get_value() is a no-op.  But it can
also be NULL because of the device tree and in that case we need
the check to avoid a NULL pointer dereference.

> >  		while (gpiod_get_value(chip->busy_pin))
> >  			cpu_relax();
> >  	}

regards,
dan carpenter
