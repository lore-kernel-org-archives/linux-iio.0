Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FB35C18D
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796233; cv=none; b=Ldu64rGekVCcJI0V4S0uyz8yIucy8DnFRfDkkKDgFEJ5NridQVyvW+A+jd54z9jpXKAgBYOWtgFD8XUyxcHxsC5ojC/j4THQs6rTpM4JxQOmZR0TKu9stbpRKBzRYtKjPDXD1XqIZ1jWIFDxo2D+2MzBrEJyYf8UUoh2tDoiHrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796233; c=relaxed/simple;
	bh=j6w1ZqKBSf98wkhfIbCweFEmRiSxHNsz6skq7q2g9vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soQAP9NbS+hil3C7jU4wWUK89x077D/njO7YohqGttGHSUGicujvAb0muqtzxC7sLqj4GSCX1I+BrEoMEVaZjD1bLQKonTWdR3aD727i0iIxxvI7egxYzlwDfalvikZLCwKwoOia+sgU64Ur7ZDhrgITfESxMj1CZAp2GPALpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEOTtyc8; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEOTtyc8"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1270be4d125so9375904c88.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771796230; x=1772401030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4mMM5qE+qxfR6dazqNKHp062hw1pJNzveR355ArO0Y=;
        b=EEOTtyc8x3XnfA0xsSJCeW30y0ltev2Nt9gUV2kFoUTuagnigV1coM0yEsmPAGwGdG
         obpXlaVptmt0pCNp25/donCpllSkM1+IQtGnpSty/s0udjoRmHiStWqAsEAeQTanYRX/
         LctqezbKQvjrhnBdv5sZ5PtiO/GT+kzXF2f7WwVhj6dJ2IkY69iTjndP022fYIWWCI1M
         9toXbJ0cwTw7X2+9P0E4jD+C8QrvaQ3MUP69hkbxz61pS36ZKPgIomvQqoTfkXrVAAYt
         HibDvg4v6/8RWU0XipYOqDhxA1bf3pbnxkIs1pgpjpB43I+YURH8poXloNCrpFmeH9t2
         96eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771796230; x=1772401030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4mMM5qE+qxfR6dazqNKHp062hw1pJNzveR355ArO0Y=;
        b=TmRZdppvSG75hyU0Lw4UKUgQftAEodYEidrhPGUzAVXQfES5mW0vC2ivk3ovQuyWYz
         +WoN8+hycSN0di3z3EUnR/OY+79BD4ueBdolXXLvx8le37gpB/Cl+PkPv3+jFf/4oz7b
         8gHTk+GKbl5HHAgFuIi/MdjzAApW7B01Ll+TQU6PsvdpXPII3bg0k4gQVSGt8B3gWvCt
         5QkdwGlDG8wbXgsK4QnA9NIfNKLcKPC0udC1ZJnKSOxPl9zHjIGxACzVKHNUV1fLa56y
         rKM28u2HxeVaK94c/CELQ7bNta+EbJ0euZmiloX57MJulRjqA+QBzMtn+FfW8zehA9qh
         OcMA==
X-Forwarded-Encrypted: i=1; AJvYcCVplPhxaVu+D7OEVwlod2inJ5ijHlpWBFyUd+6MyvfP7lN0jXCe94NNtRUi69Ruzljij6kNMiCgJ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwquPKz7pKNJL8lkwGf/RWsR0swsfnPOqtP+BvPOLsZA0hph46R
	YxCOtE5gkT3LvNbaDTt7XH/SyGG+/leH+7ffOIHQmF9JbFWhPdkx54Le
X-Gm-Gg: AZuq6aL85ZkLKMSe2SjQyjv/CUKX9/kVaNY6aSLwS2unHMV23gLX0lR6IRnZ+w3BK5L
	vq/1yK/EAZcN6H8JHjkwe1MqRKjd9yPx86AF+YBs12U3Jaio0z0m+Af4JyC904aVC7EFD9zGCdC
	gtno5Eb+DBIfNQ1W4Xx9KWxggPzhuXioOZe4h9TSWUbx9jl6y77ac55t0vuTZzlDeQZnhoaVBEo
	fUYWW+yTygRo1sdR9u4ytN3Y+6nuba/AsCCVrBKntjW2UKBXGaDgh5pLZykgNNDp0+ngSKSXzRk
	timKv+EGzu1Pk7pBzOPvFEwKmGjIyeiTbqkDrtzRzJJKZjwDDiHtz8acTMIdioctx71G1IjXu99
	CJBrV5GHjQ0jSp6BIvDpFDo2UpXR+9zHPXzgHqFvfCzLJPdZriaaYsAl2vHkD9n4hx2c4YMM2bd
	8/iVJweZSwHCcCCVWLV8cNPIl/JuvzCnkLHUUVesDmb8ypITFfr2zZqmBa+YwZnMeRQf7liHxBi
	A==
X-Received: by 2002:a05:7022:60a5:b0:123:2d4f:ef20 with SMTP id a92af1059eb24-1276ad2ec3emr2889618c88.31.1771796230364;
        Sun, 22 Feb 2026 13:37:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe8293sm3806939eec.16.2026.02.22.13.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 13:37:10 -0800 (PST)
Date: Sun, 22 Feb 2026 13:37:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: switch to using guard()
 notation
Message-ID: <aZt1ypf6msZxc2U1@google.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
 <0b9e1c9d-9bee-4fc3-ac19-28d969f65ef2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b9e1c9d-9bee-4fc3-ac19-28d969f65ef2@baylibre.com>

On Sat, Feb 21, 2026 at 11:34:33AM -0600, David Lechner wrote:
> On 2/18/26 8:29 PM, Dmitry Torokhov wrote:
> > +	scoped_guard(mutex, &st->slock) {
> > +		error = spi_sync(st->spi, &st->ring_msg);
> > +		if (error)
> > +			break;
> 
> I'm not a fan of scoped_guard() because of the hidden for loop in it.
> It hides the fact that the break; is breaking out of that for loop.
> 
> It would be more clear/obvious written as:
> 
> 	do {
> 		guard(mutex)(&st->slock);
> 
> 		ret = spi_sync(st->spi, &st->ring_msg);
> 		if (ret)
> 			break;
> 
> 		iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
> 						   iio_get_time_ns(indio_dev));
> 	} while (0);

OK.

I could also make it

	scoped_guard(mutex, &st->slock) {
		ret = spi_sync(st->spi, &st->ring_msg);
		if (!ret)
			iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
							   iio_get_time_ns(indio_dev));
	}

to avoid using "break".

I think you will find that scoped_guard() will gain the foothold in the
kernel so having implementation that does not follow common pattern
might not be the best option.

> >  
> >  	/* If set as output, return the output */
> >  	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
> >  		state = st->cmd_settings_bitmask & BIT(offset);
> > -		goto out;
> > +		return state;
> 
> This can return directly instead of using local variable.

This will require the explicitly normalizing, which we avoided by
introducing "bool state" to begin with...

> >  
> >  	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
> > -	ret = spi_sync(st->spi, &st->scan_single_msg);
> > +	error = spi_sync(st->spi, &st->scan_single_msg);
> 
> Can just return directly here now.

I think there is benefit in explicitly calling out the error paths and
explicitly return 0 on success. It removes the doubt whether a function
can return positive value on success.

Thanks.

-- 
Dmitry
