Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD471A6824
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785021388; cv=none; b=mny2t+nLZ5OLPlwzj2ZdGKodnZlQg0HDDDS2WoWO/3pqvTlWqEB8aClUPBBfdLI4u1JwldZusmP0vtecKJbb+9uYyt1dZA8E3DkkRkvjt7xnd0i8tlvjQ9he4ubjkDtNF+r7cKmLwbsyXeNdI6YbRRayIcgLmZGsVowXOknCICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785021388; c=relaxed/simple;
	bh=XvWOejc2bzwGyJUxOo43sOvPPDldX/KX9qx8Pwhw8T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgeWzXS9wNWZQuL/q6yqDS+30uHg775EI7znivpH0zT4kwkE/5xxHPEDHlg4LrJjG/rI1uqp6DTyDHN36m47sZr5IXZsZ0h5clX/NpsCNQ/h8DWxDQ1oFSb/uJZYIwwLZQvUNH+63Qk37lsCRzGDzq/SzZZSiHSqUxqMnp+vmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7kj6dwB; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7kj6dwB"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9673385b1efso613500241.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785021386; x=1785626186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n98HKdEUkcQbXRo76aiKXR6hUvPPOHvacsbRXwi7Sps=;
        b=X7kj6dwB/cmxNTr/L1jlMearMAALXmef4VuuGGuU8/06AULUVimBLtXX4R5HprXXC2
         7aLVuN1WtQ5Ee7cZTmNda/595MfuAA/Mb/hW+SV4FtYzgP5CbwdX0np8eU9UF7Kyh4UY
         tOKJxchqpqLuflL0h6QGDCHnYSCEIzLuys2E07g9Hlx17hWTGfz/e5K8P65XwD+6pHuo
         51Eqh9SjpYm1nvBCJHGZTqzX3vOGLE4RZ6ivNRscxk7oT/UZKGwPwBz243mq40NhfpN6
         i5rMNvy0HuAgutbWUUf0+IZiQh0mK7cZAMepFayGy95u5ETXM7Fh6eYfoAVJHn1H0Wlf
         gWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785021386; x=1785626186;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n98HKdEUkcQbXRo76aiKXR6hUvPPOHvacsbRXwi7Sps=;
        b=oP5bgnf0GoWEiaKHsiurSJ0utz++dJ5BcldfITgrpZL2BCqaxbyugusg2SfTRM8Mxo
         riOgXcE9ynMCn7skjXN4XhPXsqjKNQVq/5uG4LHES4BcFQ7gsJ0fGR4cxDTdsHu/WbSW
         AerriCdPESq2fPSjYbY8sayS9F7wNHpQD/HEtR9RYv6HSrCgrD7LmIBDxtvRofl65UHz
         MfrgmdKeu5KU3/2fN2KEVMLHoIk78twBLa69YJFm/EKUrlZCklPCggBjOoCTrBZu9aKM
         knCNr1a6kZk4S02pLWR+PT8fICOe7vDP312Bia9TVmlim5zUMx2D7VeZ+GphbWfq+fXs
         zYVw==
X-Forwarded-Encrypted: i=1; AHgh+Rpsu8eey/+JxmlXDPYJMyk2Tgc1nzxNu9iD+TLIYMjTYczAQqHd6nRtK/jEp2BcZAxmOYQdsjPZUkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOVhd+2JMuij5JNNM+TOVI2FCAhAZMSXWqD/CG2VU1Z3Zvpzy
	0j2EysWpFIn0cy5DzrP71NtyawWVp8UuxyOMAmgmmumQ0AuNCzmf5qPJ
X-Gm-Gg: AR+sD11cty0Je5PN0DzAD+V30XxZNqd6e1TinsuIP+z0aZ0z8HtlDTl+VKTgq+C7E2W
	yzsXl/6NDhZbE7CSBF4Wp2YWMv7arKBwn1U4ca4lcI6ka+k8hyVgCNLIOdfBJ43U/t0wc/zClQV
	+99MYNhfS6+lfWpkh4vjZaKXwkVRI2FTZmPKZLUcK9vDtzvPfcQxiy5XsLe6RUGwjQctmMMKdUv
	ai46EDw/jA05COQioOOc5yITQgmkgslnrWCt0Sda6S8jzDQp2FeRIRryxiJQ8bE+lxFkpHwKXgu
	SD5M6/oj3Xt83sE6ZD++wWc7+H+umCuPN4AmGj9rD40rYB9NFFPWXhnpTK7Z8yQ5DbcOMLD1l0U
	LJyZCwh/aIXOfQHQFWwjAJv3xrSorzbToVyingsU58IkDTpPTBJwjZJvTHa6fn7EwdiTYAbzg+e
	bZ73W9RdwDtBQ0tffxNahJfIR8QukGTOP//3BU2w==
X-Received: by 2002:a05:6102:918:b0:738:8022:d74c with SMTP id ada2fe7eead31-7503ffae2e1mr1808103137.15.1785021385687;
        Sat, 25 Jul 2026 16:16:25 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:44dd:7952:7d5f:7f15:1990])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774f12690sm2605004241.12.2026.07.25.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 16:16:24 -0700 (PDT)
Date: Sat, 25 Jul 2026 20:16:15 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>, 
	Tomasz Duszynski <tduszyns@gmail.com>, Siratul Islam <email@sirat.me>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/13] iio: chemical: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <amVAkbdREpNVZahV@archlinux>
References: <20260724030524.607185-1-panchuang@vivo.com>
 <20260724030524.607185-4-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724030524.607185-4-panchuang@vivo.com>

On Fri, Jul 24, 2026 at 11:03:38AM +0800, Pan Chuang wrote:
> Since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
> devm_request_irq() and devm_request_threaded_irq() automatically log
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() and dev_err_probe() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/iio/chemical/ccs811.c      | 4 +---
>  drivers/iio/chemical/ens160_core.c | 2 +-
>  drivers/iio/chemical/scd30_core.c  | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gustavo Silva <gustavograzs@gmail.com> # for ens160
