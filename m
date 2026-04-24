Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3433A6E9;
	Fri, 24 Apr 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049883; cv=none; b=JDkfx8BKEd499VYCvzr6KRDpgsz7LBo8f6AKnzxl2KxbrjqQ4phIAhp71hkU5KGqayRi+WdnWyS50nAXbVJpcSATW++MoNEW+cpMWjjNIMZSXz5kH0c4XK1ufGXxXE5BuCleBkTd15HGoqmwyu5+dbFrxJislqC2DaVZuXFzDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049883; c=relaxed/simple;
	bh=VodKwR9jVIU9sdfAyHWYY+LZlI+j2qz89Ku2fyQCjRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JloEeoRqsonJ97WP4zTZ8Tc0Sj/Cv2q6as8oJGC/srgynSjs6Q1ZcxWYbd1Zc9MhnNywLD3n+2F9vHEkp7GPhpVudDn7eDcS7vYAy/UX4EkSFnWa+Vu5d0Gf3iQJ58LOWz6K4mbllkQTo7yOgwsj6RWi6q2NXzJJQ/HQN0KUeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUT4RQno; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUT4RQno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D298DC19425;
	Fri, 24 Apr 2026 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049882;
	bh=VodKwR9jVIU9sdfAyHWYY+LZlI+j2qz89Ku2fyQCjRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUT4RQno4oVpnOP6dQ2PFTWD1lPQgS7jF96LrH1rpaX4yrGCoS+tYiDJ6ESXhT8Gd
	 i49lS9IL2m9P4121xF7Tl/Q9nE4WBOvdikUQnKZYWnVlGwf2ud10uNqN9ek8nxjQ22
	 NfPNzmrWvRPPuafZJIb0MPwU668e4EpsFGF6lo4LKd5Ca29rcsP3gppebI235AefJf
	 wivLaPb4tufqKHiS5lfKY8L4Qgz/QWpX9I1RGltYMvmzTJylx0iOpQqPKxKNz6w9q2
	 N/3hkael8u5CQ2d/6de1RHqEWTcQa4AlEyir8fK4nWOF6wcrCyId1ia/UzUPXn1SPk
	 aO3QC2ZonCs3Q==
Date: Fri, 24 Apr 2026 17:57:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7138: explicitly include <linux/slab.h>
Message-ID: <20260424175753.2d0ca494@jic23-huawei>
In-Reply-To: <aetVGYQcq1NAJb7k@ashevche-desk.local>
References: <20260424081809.61841-2-giorgitchankvetadze1997@gmail.com>
	<aesyzOMUl2Iyjgjz@ashevche-desk.local>
	<20260424113600.4e76fdb7@jic23-huawei>
	<aetVGYQcq1NAJb7k@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 14:33:45 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Apr 24, 2026 at 11:36:00AM +0100, Jonathan Cameron wrote:
> > On Fri, 24 Apr 2026 12:07:24 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Fri, Apr 24, 2026 at 12:18:10PM +0400, Giorgi Tchankvetadze wrote:  
> 
> ...
> 
> > > WRT to the kmalloc() use, wouldn't it be simply better to use
> > > i2c_master_send_dmasafe() and kill that kmalloc() dance in the driver?  
> > 
> > That sounds backwards. IIRC i2c_master_send_dmasafe() needs a heap allocation
> > to ensure a DMA safe buffer.  See i2c_get_dma_safe_msg_buf() and
> > the check on I2C_M_DMA_SAFE.  
> 
> Ah, I thought it's opposite, but looking at the usage it seems like it's host
> controller driver responsibility to use DMA or not for the transfer.
> 
> Why do we need to have kmalloc() here at all? I don't understand that.
Absolutely.  Locally it looks like length might be large and therefore
the array not suitable to be on the stack, but that's not the case.
length == 2 so the array only has 4 elements and can go on the stack.

> 
> > This function is just overly flexible.  
> 

