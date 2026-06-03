Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA113A9DA9
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484080; cv=none; b=i4XmwbG2eWDQfO1yojDnWM5A5hbI54F2ONaYEJwjskpyl5DPiXHkE8k5MdKq7BsKN1cGvQ7/e4xNTNMBudFROrN+63qXCWNm5yyHJIiC3D6WqXOFrUMXm3tC+088tti8I2J16PNddYK2/lRyyyxXzopw+bxEbbC5R6dGKReXplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484080; c=relaxed/simple;
	bh=tmrf2fIck4+7Bi+IcBroQJJi4SXIIt2ivLBx+FZgzQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv4v9FYk1MzzGHMnPMDJn/4keGS1YM+RS/RIVIIdXzKyhgXwbMSBM6T6F2l6Z5JTMDE5lCbsRwEa455RyqX1GavJgAtjGGKRFnduRpTSz/+/GGzeHv53vRFBCJhBBGyfOPFo45wC/+JfmNFoC2v10xfChSfGtMin1Jc6s0PeY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiUvjH7G; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiUvjH7G"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so603919166b.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780484078; x=1781088878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8xPodyUoWJlPI7e6lU/pFf27beG/+cguIPjhg9rv9w=;
        b=JiUvjH7GwM259TOKEyjzYS/CfTyBgnggAQxCGJesWdx2pNUU5BnCnrc0Iwp6QmawKJ
         Om8cT056bKXM3JbfQwAeCtVRQN8xZ/GG2ciyxYzL+29l0n0C7vrnENxZVO8VkJNbSnv6
         tyvw+sACDSHT4Pvslf235fhHlAC/5IJcjuE7eSH1oN9AW8GxVcNQhCA68r1PLjBhOV/d
         ae4SPUGBMJheTsQ5zRF5AUXtspNphDCZAPlERJxPaRc+CWwxp7Lc/lomybh1Oie96BAi
         EZPayICirOuJmQABQZuyLnvOHJY1WJP9P//Yi5/pkAxa33xEkpcVOkSBnu9mkKZAe/zx
         vN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780484078; x=1781088878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8xPodyUoWJlPI7e6lU/pFf27beG/+cguIPjhg9rv9w=;
        b=TqanSaRohCz6n620blpUcvdW0FGWBzdayxOuzj4ovY7KqpBsVhT37qsk0SCfuxKSBp
         FDmm151lqlX5nQ1RmdZQTk4HEEeTCFkzixW5GVMILhBHTe9hPlXVrlwPua0RqTPzhT1S
         TOM7mmdHZNM/gcdadWi6jrBbtbbM3Msc+JZuaOMmB4KVvVckh2lhJK/DfO/KYHsd7DLI
         e2kSkNMZ0m5ATSTsxpY8bx0/i3wMG16Ohd+rPklmiM2qBcbJwZJVp2KgYARv7a121DEx
         PjqWBXOo3FouLrTZ92l9SIVFCELDMMpd1PS0vtL7GfQuwTHgZgUvSX6cAltj6cu4hmPe
         VsvQ==
X-Forwarded-Encrypted: i=1; AFNElJ82mhKfVoCPq2lIJdHeR7SAmLR6wtLqnCYNDgbloUDlO/Qo38rvgQ3QJCXOS+ndJrp8tafYwbGQeWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YlX4Ud0RTzYfIkm1ml0Fy7s8EUj9108DgIw0gEgpU4g/uojs
	UEnlee32MGEvOyinwFdwGG4gFkckg2Qp/S514+GbKRP8v5kKfU1N2kXS
X-Gm-Gg: Acq92OEdGu7QY/jITGoMvd0sZhnNm2vQ6cUNiWYVAuu5U/hrks5vV4z24SQV2mdFcmG
	OCPwW2jCXYzkhRl8N9/J1dS2Ef8msnr7U4yyPrRjXnNJ8fWFiBI0pUWZKJnbkAMY7X7xZfS/i2g
	askYRswnP4a0HK6tOhCm6cvV/nVoD7jb+lxO5WSK9CzGOndGPe4d/PWtTnaxkNU1Qfn5+ecARIJ
	j08XWFvQDDpScz9egtpfaGWVOZGm1iNEZEOVgQ9AqPAHjrFmUYt6J/mYWYE16lQ8sEuAfPyCcnV
	/4bO9zAvXnmcbsMuwLX7OykaGTwWxep2VEZAUuHzfDmSUXt0QGexiZyjL5GzXzLmiNVQs3+yshZ
	7DB5TpSLwa2LuiUmSpW4oWFlXruCE3Ta0eTnvbURFivwbyJ+Jku9GmD1V4NCWGRqzi3Ucxuwtja
	TpVaDSW4cGAVW1RscGILiHGOdqPH/27w==
X-Received: by 2002:a17:907:c28f:b0:bea:5cc7:95a4 with SMTP id a640c23a62f3a-bf0adceaa7dmr131107266b.0.1780484077830;
        Wed, 03 Jun 2026 03:54:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05208e897sm131534866b.25.2026.06.03.03.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:54:37 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:54:33 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Taha Narimani <tahanarimani3443@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Use
 devm_gpiod_get_optional() for busy GPIO
Message-ID: <aiAH6eonsntoHQvF@stanley.mountain>
References: <20260603123333.5608-1-tahanarimani3443@gmail.com>
 <ah_zMybQBDHakXpX@ashevche-desk.local>
 <ah__2Fjf0MxIQLnh@stanley.mountain>
 <aiAD7HRnWmSJb738@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAD7HRnWmSJb738@ashevche-desk.local>

On Wed, Jun 03, 2026 at 01:37:32PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 01:20:08PM +0300, Dan Carpenter wrote:
> > On Wed, Jun 03, 2026 at 12:26:11PM +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 03, 2026 at 12:33:33PM +0000, Taha Narimani wrote:
> 
> ...
> 
> > > > -	if (chip->id == ID_AD7817) {
> > > > +	if (chip->busy_pin) {
> > > 
> > > If we get GPIO optional, this check wouldn't be necessary anymore as the below
> > > should return 0 IIRC in this case.
> > 
> > No, it's still necessary.  It can be NULL because of the CONFIG_
> > in which case, sure, gpiod_get_value() is a no-op.  But it can
> > also be NULL because of the device tree and in that case we need
> > the check to avoid a NULL pointer dereference.
> 
> Can you elaborate on the latter more? I fail to see that.
> What I see is that the function either implemented or not is NULL-aware.
> 

Ah, yes.  You're right.  The VALIDATE_DESC() macro has a return hiding
inside.  I hadn't seen that.

regards,
dan carpenter

