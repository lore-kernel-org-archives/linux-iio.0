Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFF36AB4D
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702462; cv=none; b=rsXyPLX8zhsPykN7yXiJ9USPDr/wMZQVUdnOMZxYGcd67YzN8fG9fYg1dnF2AoMPiPEsCaMjO7SrWttanZX8SHGreN5X35SVbVwDJYNBjh7WddZw/6/OnWz6wefOCghrpxUolh0ze989fIbx7Zlgs3vBeyBl+nSHp8AkWeNUGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702462; c=relaxed/simple;
	bh=jI/OcbOYVD0sHS6G3h2jYDflQSErX9zgXGnhGKq7Zn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSPbcWJ4xTKL3VQRFdCIPtk+oKWMQsyLrZO+zx2F2Juhz2yVwlpBikGYR2DebaePpR0p/grICglXBwR53+TXA7HCMUiHBppF517dbmf3YJvYYhp7jnXHz051xqLDf2QrZclzp8a0DxMHBbMYumUOGg1uCmMbS9wKcMRyalYi9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey3x5DzQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey3x5DzQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so8066545e9.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783702460; x=1784307260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JRW82qDeqWbcTEIWdeHg6T9X6r+SnQDhkFtAVKzYK4Y=;
        b=ey3x5DzQoMAP/6c27gmQ1wkyDCgtjiqzHZLu0mevQjsJpQrkvPykdwmLY4dvdP7nIl
         3lPVRsA50KXSIqWWE88kyRSE1HPiRbnRR+HI48IYhNtaUP78DsohZ9HIkSffG7WwRs+/
         tnffgYrYFfIBS7xPlXZP93EFSE+30Sp9m1QuF/aCGCiGZh/TQzx7RY0ZLnF5NsbCr2sc
         4ZFPv9AZBWVmYIi1yD1ZY5np61yVTHQtv6Ey7pD7jSqP8WvvDs9hW9nSn9C9k+iuDdq9
         vt1vNg7CQ7mNv3jXJCmzewlYNu3/m0P3LTQbBep5XRUPsfTgaiMtuMnDHXopwsPc9mFK
         fPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702460; x=1784307260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRW82qDeqWbcTEIWdeHg6T9X6r+SnQDhkFtAVKzYK4Y=;
        b=IZOgR7lOZEBsiOqZQuaNoDrSm2qJmOCPZvxcqeowvVVRkk5ZAJ7EjfNwO2ZWUIwpCC
         Dnhu+BZ4eYt0Gk4JrV5jj8TGwjAxg7Du7FU6lxww/AYKtAM47MdemIpCg5AsDI1eFGS6
         B0yoYbW5I1xXKFHOPctcxRPssenHDpcnbAaM8b4yOaK20N0F6Z064YFmPquARzYMHWvx
         tN9WECjTBwDTohqTVksSklLF+gcWLYZ0mGNA5uaZZIthull+WLrXof0fi51Rs1MoL3YS
         mc/Cc3Nv/MDj10fTKp8wYPe78Sx9FWNo5QCMtxIjZfmDl/jqbRtsNnBhay18XHJ9Txa4
         wNIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqLssSXsO2cDI9fpH7BuTx/9huEj+Dk8o753bL0r34V28ADZYiV5MZhaVNOnmh+6PEUmCPSfVJJt4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqsuAoPJBx4HhW94qb49/wq3z9UVbLB3C+Z+A0in8MDtV1eXB9
	072F4uf4Rm8VomgGJ9xfaP5+je7YBB5FW/B2EsFHfQt03r7JnSsNE9Ih
X-Gm-Gg: AfdE7cnNo07pLTgRfjuAar33++hNW2PG3dV2y3fBS7W1lxdZIHG7TXyxLq0tPdVfX+g
	zGWJtweeKfY0zCO0+tynETdi4l0uDVukcK2KO44anwwlxG1VqS7cKbzlxrS4LdtmhkFeS84sGHu
	dXEWx8FNeABNtW3Gp8uegrY6vc/Yw9H9P4sVRWRq127zv9VDqkqD1HBHvQqB6lyO+KKGKjgk/Sl
	GvFnlciPeuJsCGMG1XthrlzTn+lcAUKl3SQL0dmiqNT7gGihXHIAdCmGQnETi+0WsVt6xH2H+dg
	8zeIqywNJs4p1L3oJ6OvN+KZgp5OR0iA8ckwc6GTnJrzQaafpcXlAU1MvGfgKYNQ27km4Tl1b97
	e5lrKGCtRGvPbVSMCMJwnV1eFmX+vp3DFEu7PgI97WwZVxSur52+h++Z6HL/1slfjycAKdFjHP5
	XgSLVLvzaD
X-Received: by 2002:a05:600c:1d16:b0:493:f73d:cc6d with SMTP id 5b1f17b1804b1-493f73dccd1mr17291625e9.24.1783702459655;
        Fri, 10 Jul 2026 09:54:19 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e6607fsm54696025e9.1.2026.07.10.09.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:54:18 -0700 (PDT)
Date: Fri, 10 Jul 2026 19:54:15 +0300
From: Dan Carpenter <error27@gmail.com>
To: Taha Narimani <tahanarimani3443@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: adc: ad7816: Use
 devm_gpiod_get_optional() for busy GPIO
Message-ID: <alEjtybak6T5sH7I@stanley.mountain>
References: <20260710160001.29856-1-tahanarimani3443@gmail.com>
 <20260710160001.29856-2-tahanarimani3443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710160001.29856-2-tahanarimani3443@gmail.com>

On Fri, Jul 10, 2026 at 04:00:01PM +0000, Taha Narimani wrote:
>  /*
>   * struct ad7816_chip_info - chip specific information
> @@ -48,7 +48,7 @@ struct ad7816_chip_info {
>  	struct gpio_desc *convert_pin;
>  	struct gpio_desc *busy_pin;
>  	u8  oti_data[AD7816_CS_MAX + 1];
> -	u8  channel_id;	/* 0 always be temperature */
> +	u8  channel_id; /* 0 always be temperature */

What changed here??

>  	u8  mode;
>  };
>  
> @@ -84,10 +84,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
>  
> -if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> -		while (gpiod_get_value(chip->busy_pin))
> -			cpu_relax();

This patch doesn't apply.  Not sure what went wrong but maybe it's
related to this?

> -	}
> +	while (gpiod_get_value(chip->busy_pin))
> +		cpu_relax();
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);

regards,
dan carpenter

