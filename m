Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E84361667
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313842; cv=none; b=RZSm7T1iv0ibJwr+XL29bdOcXCjUl97jLe64zI9v82RzybprSLMAkkmTUvcDf8YphhxVlD2y4jdb5kZdH0/EITbkGIQ1OBUov0tglcoTuznPnD0CCB20QA+faBRk0tU2DKWyvP8pDUUgW319nrtWohkaNBfXqvWSshWP5Z6yUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313842; c=relaxed/simple;
	bh=Zjof0WVULYCBSZ2Pq6gQ3NRucoS9NMNzybSAd/5mwGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myfk9eUuVY5qQlqOTqz4+Pv+VUhguX0RxnYwMIa3UWufbapMAIs337pHuvep3qoX0lJt/ku36XC5k4OxwLoS65te4PHq7YiFYMYk0SPCAhz5xzYn6styDAdgeqkIsdYFMiGEAFk+3c0Z+jIf45w+oXziLMx41Wb+HpYFIH/Xw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzEMuI3I; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzEMuI3I"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68cec9f4c6cso2255199a12.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780313840; x=1780918640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y5aiob/5xwmuKj1NkLrGEbiNwQs8EGYTAf6Wpc7voc=;
        b=qzEMuI3IznZhj/mJaJMGbw+62j2CONe+W8ZAdHy6nK8t/2EWxbEVLRNap7/Vpp9Ckp
         37jt6Qk4e+A7yWpvOjgobHqVFvIftUs3AuuuOQuHTb0vpNIxIFsq32ng2YfaUkknJbY0
         SEaLUa9/XA7XAN0ZgpaemkBU0gjyUzQXe1yf0lM4Iar9tMhO53guOEmjDbFXR1BL8xT5
         7x1UpDivouBLhMzOycfqPNaYPIjyD1feLOqbkkXTAGMukFwlXLTWdbQXuK6Ezxn/Ngba
         kMIQOmZSvG48L93MiCU3wmS3dFpFzz++2F9EJz6ZAW36wrYNq7yE6kTKP4VWXTDOa2Ep
         l4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313840; x=1780918640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Y5aiob/5xwmuKj1NkLrGEbiNwQs8EGYTAf6Wpc7voc=;
        b=CVP0FFlDqW7br6nF9iCabd/ODzYS2sxiDPMJdvKnff351ABMzi2YAJ2gmfSsC4qgWD
         Yg6yVneFGIQeSq31MmcHAwK/iVwMMsZoBzph7nVbcpPJL4WQx/M7lig6e8o6H0leAh3n
         C/GGpeQsTtdTqchygLm4kFyhQIpJRKu+rQcZk4rhiGfUpzHFf2AdRG7H+GLtiesSmFpY
         U1yfkCqqp0h2AvyQuKN230fQY8V8ZAANWOhFPRYrE1GiRx1bnFrDg3PC4jn4BdARO/nu
         msRmcI5Ubyx8Qv3yLU0afNUJ3ZESnhkJcg1qaPl5a1i1dxrfFCvupWcqHPMsfCmRI4oj
         88Zg==
X-Forwarded-Encrypted: i=1; AFNElJ8OPvb/zVXWWZWDv/86WxVVrjNNkJ1pIGPq9vj6CEGWwSBphHBjF6HPeN5RsCnB1NYz6VRAUv9CGm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKbBFd5diCrgz0iC/Ly1+joSB4jLml5u8oFEdvlvh1i1WfqQd
	5U6sVlP/GU0AXIR4drUdEhoXdJSn0O46vbSLpsTOJwOLs9j75E/KCuAw
X-Gm-Gg: Acq92OHP+hI1wnkFusb4Jz9qkbX2BNfyBHL5bUbsXU97xoRKGpU7T/UzlZObJ5OpIdh
	G99fosaFEu2eMVJaN/94ZYGWa+LEtvLd5yUo+USVWuSuTKV0Zj1jZtJKngdH71Bh3IIt6yZ3aF9
	YyNN+alKhHv9ZUrKAgZanYZA/9p3xerLPVOYAVWl7wNEp+MabamUv+X3ZDW+UKrFvY8cg1aY45G
	sSwtCxawZ9svPjgtScHvbPDnSfSsu3KShLZiiIvvdzL5CnWTeTjib0U6qKOaREzlUXIASLyPOIZ
	aUCiwIfEvORDrvMfFuXzNkb9geOzdQQyq+lxIVfVVlBm/N1em+cNPMnIbacoftoYS+P4n4let4Z
	4IjD6tAwcEDavqTsWIOhMERkUu3/SUqTCaWnjAwOLBFGD7NZT4I34rN16DrmZjRZvqZbVWlGbzh
	495Jkzqn1HLbuU2KBY+1O/C15UvEQl39D5eIHiFlTQLmy3
X-Received: by 2002:a17:906:c151:b0:bee:9d02:6e7c with SMTP id a640c23a62f3a-bee9d032e8amr30809366b.10.1780313839361;
        Mon, 01 Jun 2026 04:37:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bee7bdf4438sm25754166b.55.2026.06.01.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:37:18 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:37:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: Taha Narimani <tahanarimani3443@gmail.com>,
	Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:STAGING - INDUSTRIAL IO" <linux-iio@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7816: drop busy pin requirement for
 ad7816
Message-ID: <ah1u6r2NemqKd2k7@stanley.mountain>
References: <20260530173514.56640-1-tahanarimani3443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530173514.56640-1-tahanarimani3443@gmail.com>

On Sat, May 30, 2026 at 05:35:12PM +0000, Taha Narimani wrote:
> According to the AD7816/7/8 datasheet, the AD7816 is an 8-pin device
> and does not possess a BUSY pin. The BUSY pin is exclusive to the
> 16-pin AD7817.
> 
> The driver previously requested a 'busy' GPIO unconditionally for both
> the AD7816 and AD7817. If a device tree correctly modeled the hardware
> by omitting the busy-gpios property for the AD7816, devm_gpiod_get()
> would return -ENOENT and cause the probe to fail.
> 
> Fix this by restricting the busy GPIO request strictly to the AD7817.
> 
> Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>

The patch is corrupted.

Otherwise this seems reasonable enough.  (I haven't read the datasheet
but I trust that you have).  Let's add Nishad to the CC list since he
is the one who first limitted it to not check ID_AD7818.

The other way to solve this would be to use devm_gpiod_get_optional()
in the probe() function and test for NULL in ad7816_spi_read().  I
think this would be a cleaner solution because then it works based
on the device trees instead of having to hardcode which devices
have it in the driver itself.

regards,
dan carpenter

