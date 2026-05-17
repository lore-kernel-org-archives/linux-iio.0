Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140B2E040E
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027297; cv=none; b=SvUIjEQ93HbfqvBeWViRVQL7CsJGFKBwUFUyilw+uXBzaPMrsw579A9+XmpsopU7mIc28IdyZzFAhwPQeZq77CPvN13jSMJ9X75wuemnmZGZz4zA+tWCgMgjzdXqUqtklxtqpaPyAQfCnz6+KAHo1nWeS/4dguug/HwCXD092JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027297; c=relaxed/simple;
	bh=JFVoWFcGerv9496HzHuqXiEQoVz2EkAAmbW/ObHGKlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJX7D3NaBmmiGGkbOgU3691aYy1hd29/j4vz0afZ9avQA5fuPhp+QGEgL7Cgiemee8/TMnlOCdo2UJ3hrD4ZKI4YUl3lYE3XngwGuelfh0YRaRDX88CgauxBte9nPixWULcgSXcomx1QJK5/LHcCBGcEFoydjx6Gv5Te2H/s4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfAIb/vg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfAIb/vg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32018C2BCB0;
	Sun, 17 May 2026 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779027297;
	bh=JFVoWFcGerv9496HzHuqXiEQoVz2EkAAmbW/ObHGKlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mfAIb/vgkY8DBiKnL3MQ5HT0lCKu+xZd9gAbTB2R9MYIluee+GQ4XrlBq4GfB1ljf
	 z2JORpMYcl/+stzDnfDpo5A7nJijUc6BcvM+2s3jJUS7dV2d9EdEBQbq5OHn3QvmZy
	 upp7GSdmlWxwe7BxjkcQljW19sm3xy/ne5DmEFRpdkgt+VPovFlv/OIHr8YgO4Vhae
	 0HyummxTnd5w408X48RaUTeJnvbIvEgqSQjy8CXbVC6QWxtKOSSqTaX+34C02GzO23
	 fyUuUhisOYsn3uteGGJrJ9VJcMZIAr2lPEdyT5zcUBDBTLpRm4VHid73hX2qxWbZ0q
	 iqN6FwpfKoIUA==
Date: Sun, 17 May 2026 15:14:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Santos <Jonathan.Santos@analog.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ad7768-1: Select GPIOLIB
Message-ID: <20260517151452.3bcf4e57@jic23-huawei>
In-Reply-To: <aWShYv4G2oFHh4Fm@smile.fi.intel.com>
References: <20260111165528.284067-1-jic23@kernel.org>
	<aWShYv4G2oFHh4Fm@smile.fi.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 09:23:14 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jan 11, 2026 at 04:55:28PM +0000, Jonathan Cameron wrote:
> 
> Thanks for fixing this, my comment below.
> 
> > This driver provides a gpio chip a some related functions are not
> > stubbed if GPIOLIB is not built.
> > 
> >    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_get':  
> > >> drivers/iio/adc/ad7768-1.c:420: undefined reference to `gpiochip_get_data'  
> >    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_set':
> >    drivers/iio/adc/ad7768-1.c:453: undefined reference to `gpiochip_get_data'
> >    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_init':  
> > >> drivers/iio/adc/ad7768-1.c:498: undefined reference to `devm_gpiochip_add_data_with_key'  
> >    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_direction_input':
> >    drivers/iio/adc/ad7768-1.c:387: undefined reference to `gpiochip_get_data'
> >    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_direction_output':
> >    drivers/iio/adc/ad7768-1.c:404: undefined reference to `gpiochip_get_data'  
> 
> We don't need these many strings, the important ones only would be enough, like
> 
>   ad7768-1.c:420: undefined reference to `gpiochip_get_data'
>   ad7768-1.c:498: undefined reference to `devm_gpiochip_add_data_with_key'
> 
> (and also no need to have a full path in this case, we can always read an email
>  from the LKP below).
> 
> > Fixes: ("d569ae0f052e iio: adc: ad7768-1: Add GPIO controller support")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202512271235.WwAmAbOa-lkp@intel.com/
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 

I'd forgotten about this one until i checked patchwork

Tweaked and applied. With silly situation that it has two different
sign-offs from me, but that correctly reflects the path so I'll leave them.
