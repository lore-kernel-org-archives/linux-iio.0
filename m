Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A7379C2C;
	Mon, 29 Jun 2026 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757122; cv=none; b=qj2ZO801LtnFZ+JApZ5G7yHOFiNEUWQgXM6vYTYbGgFR+qlSaCAurQH8Sn9RQ+XfJchjh+CTgLoS9v20pvR50t4iesWeBAWPmBF1vOeRcBYpSkPzr54vu7Kqw4Jv51b/qPZaHpf+Isnz5GbWq4I8ANu/EeHxA2aXvMLFdSKr2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757122; c=relaxed/simple;
	bh=YaYTwPK9VSSwzepj4GfEnSgg1MVFJLrruAtM52rkhlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNAw3Ois7/wJzByi4yQYQHejno2bwcZd2pScA1yGPceojOfkr7sHza8K+bRyFlWBaqrADJQNbQqaquilteOVY+FZkQvANJHUToXcRT/Xprsnm4ckN72922Jz0iJ7d7rScQ9UhoMJmfATMCJybbrEKCyrwizXs7d8MnysV9X63W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVkIQ0CV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVkIQ0CV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8453D1F000E9;
	Mon, 29 Jun 2026 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782757121;
	bh=2s+0rhdljTbKBPvKs4FVrQ/4UObODJSaX9xBvfkyyPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QVkIQ0CVX29p89bevN664jajE9aqGeMWtLG16n5LsQm/xUYXv0QIP7zTxREWhK5aZ
	 WGCbtXbRlCxkgMFSrDQUAWDiMV6W/gVMr6r3X4bKMdLs3kvLrJ9XMrvRD+RaqoDVH0
	 BsbseXR15RpfHj+XJf6kBy4ag/iZ8tHi9Ejlov9Q//yV77kSaz/wH+LrPX5LwGXJMI
	 j+dj2UZqkVtcZn2NeOOrlwiV7D2k75m268P7adz0SfMCMYiPc+Bd4oCluccWz3KwGS
	 EI51A8vy6+1NoxNWFGCW/F1uLZSDIAahzHybcK2Q1gsMl4DX8KT7UHt9mUKtYwsAq7
	 FSCjWNxpJnDcg==
Date: Mon, 29 Jun 2026 19:18:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: dac: ad3530r: Refactor setup to
 table-driven register bank approach
Message-ID: <20260629191834.38a2b8df@jic23-huawei>
In-Reply-To: <akJ5xoMvLWwNvpVN@ashevche-desk.local>
References: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
	<20260629-iio-ad3532r-support-v3-1-f6e4f4abebbe@analog.com>
	<akJ5xoMvLWwNvpVN@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 16:57:26 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jun 29, 2026 at 04:31:04PM +0800, Kim Seer Paller wrote:
> > Replace direct register calls in ad3530r_setup() with per-chip register
> > address arrays and bank helpers (ad3530r_set_reg_bank_bits,
> > ad3530r_write_reg_banks). Convert sw_ldac_trig_reg from a static  
> ad3530r_set_reg_bank_bits(),
> ad3530r_write_reg_banks().
> 
> > Convert sw_ldac_trig_reg from a static
> > register address to a function pointer for per-bank LDAC trigger
> > register selection. Switch spi_device_id to named initializers.  
> 
> Split this patch to do one thing per a change.
> 
Perhaps more relevant here is remember to update the changelog.
It doesn't do that last thing as Uwe already dealt with it.

> ...
> 
> > +static int ad3530r_set_reg_bank_bits(const struct ad3530r_state *st,
> > +				     const unsigned int *regs,
> > +				     unsigned int num_regs,
> > +				     unsigned int mask)
> > +{
> > +	int ret;
> > +
> > +	for (unsigned int i = 0; i < num_regs; i++) {
> > +		ret = regmap_update_bits(st->regmap, regs[i], mask, mask);  
> 
> _set_bits()
> 
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}  
> 

