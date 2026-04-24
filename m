Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80829366046;
	Fri, 24 Apr 2026 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026969; cv=none; b=cXk6NXFvAqfjT0UyT/RuTY0pA0uKa9cJYgUmLEP4QGYhRgirFeK0yYXhmBouYD8bokp5ZkRogyGU1WpjpWLCGmLt9yri8MiqILCmxJFqB9t+DseBPPFoUMJOodwW5wtfGTtocG/aus8PS7sLmN72zZyGvrFpKYjhI4p6mlKki7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026969; c=relaxed/simple;
	bh=7Wb2Mj2wKPvYEIaFgVkG85yaU0b3IU07OjhhW6ADv5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXMglq6wdO5pQSZBtwsmfwDWxtDiwnFUSeTiR5Z7mQaTEmhrNxRi+Jd6QmKTLzjyika3vPKkIM/8wWuXqf1rHCZOprjA/QlJW3iHHEy9s22hM6g/Iv6R5RVW5mNi4AvYXKy11xUJFSWKS6Y8ChOm6oVpj4fvL5WiJp736A3oMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT1GmpXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT1GmpXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4214DC2BCB5;
	Fri, 24 Apr 2026 10:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026969;
	bh=7Wb2Mj2wKPvYEIaFgVkG85yaU0b3IU07OjhhW6ADv5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WT1GmpXqDb/yKe5krAECeDSyephEUMd1kErG8beFVZtNg+J08m1iYr0K0Be7HBAFp
	 fYP4aM2x47hZYEt6abn+x9PyzbGjXI65xrbiTT4XhHCDvcokAf9PeGk+uiTpwoOe5k
	 cG0SkuWGQvvEs/bLX32lL9iXdNzIhMJfWFPfmrn5rzm8cAsU+v869zuYbQoh817ofK
	 d+FOlkmy0dyZI95PrfhCvhP8cd5V8OrmOJzcQ064kOjrImpp64BKX/DljP95SBJUUY
	 +rINS7LTV5boKuTqjh0S0t9qUIrtD1RYCwfehxFP3jF6A22mjUuK+N5pyT9unb0w0c
	 6VX4Gs58d+p7A==
Date: Fri, 24 Apr 2026 11:36:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7138: explicitly include <linux/slab.h>
Message-ID: <20260424113600.4e76fdb7@jic23-huawei>
In-Reply-To: <aesyzOMUl2Iyjgjz@ashevche-desk.local>
References: <20260424081809.61841-2-giorgitchankvetadze1997@gmail.com>
	<aesyzOMUl2Iyjgjz@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 12:07:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Apr 24, 2026 at 12:18:10PM +0400, Giorgi Tchankvetadze wrote:
> > ti-ads7138.c uses kmalloc() and kfree(), which are provided by
> > linux/slab.h, but does not include that header directly.
> > The driver currently gets these declarations through linux/i2c.h.
> > Include linux/slab.h explicitly instead of relying on the transitive
> > include.  
> 
> If you want to make it real patch, please convert it to follow IWYU.
> What you are saying is basically comes from kernel.h (yeah, i2c.h happens
> earlier, but the kernel.h is PITA currently).
> 
> WRT to the kmalloc() use, wouldn't it be simply better to use
> i2c_master_send_dmasafe() and kill that kmalloc() dance in the driver?
> 

That sounds backwards. IIRC i2c_master_send_dmasafe() needs a heap allocation
to ensure a DMA safe buffer.  See i2c_get_dma_safe_msg_buf() and
the check on I2C_M_DMA_SAFE.

This function is just overly flexible. 
 
static int ads7138_i2c_write_block(const struct i2c_client *client, u8 reg,
				   u8 *values, u8 length)
{
	int ret;
	int len = length + 2; /* "+ 2" for OPCODE and reg */

	u8 *buf __free(kfree) = kmalloc(len, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;

	buf[0] = ADS7138_OPCODE_BLOCK_WRITE;
	buf[1] = reg;
	memcpy(&buf[2], values, length);

	ret = i2c_master_send(client, buf, len);
	if (ret < 0)
		return ret;
	if (ret != len)
		return -EIO;

	return 0;
}
But length is always 2.  You could hammer it into i2c_smbus_write_i2c_block_data()
but that would be confusing at best as it would be putting the magic block write
in where the address normally goes and the address into the first data byte.

So I'd just go with
u8 buf[4];

if (length != 2)
	return -EINVAL;

Then use buf directly.

If you want to get fancy the caller could actually pass a u16 with val << 4
in the one caller (I think) and end up with same data but then we'd need
mess around with a memcpy to land that in the right bytes so maybe not
worth it.

To me either of these last two ways would be fine.

Jonathan

