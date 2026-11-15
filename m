Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700834;
	b=O+ut06mx3aDc7+Ns8nsSedOa2da0WSbUXkuzwkC0fpda5Y/GW/uDK4ZMohoFaLxtZMqb
	 jgs+A5ReSIZh+YSe7Ix+0UY/cT0sAw160PLktNigqr4AmNfy+yjqlDRWYb28pNx4wE6YP
	 gvRpsmX3g9GabMmXtfsicAijcnCedHRPBf8IrYZdc+si+4/LgFpOp8V5DIOFcsZBq4yfG
	 KA7thFdHrNFNjMkzl8dkYxdbhJGWYvnup7BNxvs/PTVEBOWjf6vkSv1XRhujrKTPR+ROx
	 YhYuj5UFQxNstuiEmsKm+y4Rh8f/0FplnogR7f1fIcsc9dhE3l5SVO+G5KAhC7wKh2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700834;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hvCISij97TVvxaEJUgqz1PSrsYSe09MM5Yj1EHDwk5s=;
	b=qd8puOeB/HZznflZM2560ZwzGGbalfmUwaiSpNL+sJJDbKWlL3PFO4Cg0g5EqJUjf68H
	 dfr33fI0/RtPk/mgHLP+n5ZogcxPZViOOvO04hEoBsTubTfkiGwf28SDpsA4L9uI9+fDS
	 vfJWOpX1KF5DAWfo/l5kA/86GTpT3r9taI200oOc4Stg5MLrRJeXD7ebbkmY1HWrYjZIH
	 +wKBlGo7PEIrFk4qYcNixxKr6Ldw5e1tt4wDiDsAwpWPGOhxvyFgJYlHv3hKEGZZe5Wwe
	 AWCpS6LkeqCdQjpxviYstKGaBrSHI47rjoVv1EDmXyqHitqazNC5lja1AD0rjwYnAvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RUg/08JZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF172606A32C;
	Sun, 15 Nov 2026 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUg/08JZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D61F000C5;
	Sun, 15 Nov 2026 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794700833;
	bh=hvCISij97TVvxaEJUgqz1PSrsYSe09MM5Yj1EHDwk5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RUg/08JZPRBG9aQGRIv1rWGyUNQPOUl+Uy536DoRAcraHvdaJPZQ0nTsxOtL7+Y/x
	 xpgqQkyqq4HFH023OCRx73IG3fDE5s/E7DrJPfFR05hGsHmjQwGrq3ZNNPBCCo6bH7
	 DNYvdmRvS8wklZazVkxBsDynp627WkfAKB9uwaudwPmoDveeiz+nTmHjQloiTFjYIN
	 Z/ZhjpXMKBaJ+WeGAc7lmaESAgNLsDRTAa8tNSyCQ/1TiQNPJykkwV5wEAQZKwyQqg
	 MzhSSPfI9NvxJ7XtZ4wmp/ukcRVfj0H3MaGwgPUgeNAzc6KFxkFP50xyUgfIbDB/+S
	 GLnlKzykqaLyg==
Date: Sun, 15 Nov 2026 00:00:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: adux1020: fix interrupt clear value on
 SMBus-only adapters
Message-ID: <20261115000025.134a3705@jic23-hlaptop>
In-Reply-To: <CAJsKa+6UT2cu3HBrjif_NZ+ZUZM-UaUcKmfhptUAa-cwbJ+VzA@mail.gmail.com>
References: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
	<20261109-adux1020-measure-fixes-v1-1-fe1ba63f28bc@gmail.com>
	<avJcESOPo2nGq5wy@ashevche-desk.local>
	<CAJsKa+6JDCVLtWsfQ0gJzX185ywWiYA_FwbV52q=N7vzgRYDVA@mail.gmail.com>
	<avLvJK2SmQ5Gs9Xm@ashevche-desk.local>
	<CAJsKa+6UT2cu3HBrjif_NZ+ZUZM-UaUcKmfhptUAa-cwbJ+VzA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 22:17:44 +0000
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com> wrote:

> On Tue, 10 Nov 2026 at 10:17, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Can you give a Kunit test case? Because regmap specifies the val_bits == 16.
> > See also [3].  
> 
> I read your analysis in [3] and I agree with it for the bus it
> describes. regmap has two write paths though, selected in
> __regmap_init() by what the bus provides [4]:
> 
> - a bus with raw .write/.read (regmap_i2c, used when the adapter has
>   I2C_FUNC_I2C) goes through _regmap_bus_raw_write(), which uses
>   format_val, so regmap_format_16_be() drops everything above 16 bits,
>   as you describe;
> 
> - a bus with only .reg_write/.reg_read (regmap_smbus_word_swapped, used
>   when the adapter only has I2C_FUNC_SMBUS_WORD_DATA) skips the format
>   initialization and goes through _regmap_bus_reg_write() [5], which
>   passes val to bus->reg_write() unmodified.
>   regmap_smbus_word_write_swapped() then returns -EINVAL for
>   val > 0xffff [6].
> 
> i2c-stub is SMBus only, so adux1020 takes the second path there.
> 
> The existing regmap KUnit buses match these two paths (regmap-ram is
> reg_write only, regmap-raw-ram is formatted), so I added a test case for
> each, writing 0xffffff0f to a regmap with val_bits = 16 and expecting
> 0xff0f on the bus:
> 
>     # raw_write_wider_than_val_bits: pass:10 fail:0 skip:0 total:10
>     ok 37 raw_write_wider_than_val_bits
> 
>     # write_wider_than_val_bits: EXPECTATION FAILED at
> drivers/base/regmap/regmap-kunit.c:342
>     Expected 0xff0f == data->vals[param->from_reg], but
>         0xff0f == 65295 (0xff0f)
>         data->vals[param->from_reg] == 4294967055 (0xffffff0f)
>     # write_wider_than_val_bits: pass:0 fail:10 skip:0 total:10
>     not ok 2 write_wider_than_val_bits
> 
> I can send the test to Mark as an RFC, to ask whether regmap_write()
> should mask the value to val_bits for reg_write buses, or reject it
> consistently.

Indeed, please do that as otherwise we are going to see repeats
of the subtle issue you found here.


> 
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap.c?h=v7.4-rc1#n963
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap.c?h=v7.4-rc1#n2153
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap-i2c.c?h=v7.4-rc1#n127
> 
> > > However, even if regmap changed, the driver would still be passing a
> > > 32-bit value for a 16-bit register.  
> >
> > Is it a problem?  
> 
> Today it is on SMBus-only adapters, as above. If regmap ends up masking
> the value, patch 1 could still be used as the fix for stable releases
> since, from my understanding, small self-contained fixes are preferred
> for backporting.

I'd definitely want to know the longer term consistency fix is making
progress, but sure.  Add a little more info to the patch description
and I don't mind pickup up the fix.
> 
> Best regards,
> Raffaele

