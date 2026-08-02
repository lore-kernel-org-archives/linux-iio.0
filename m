Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1251EFF8D;
	Sun,  2 Aug 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691165; cv=none; b=E0xjpOqZa+KlwFqfne8EpXkEUriqt+wK46epskoBtqIg/eYzokjIfxEfS2LXIkb2CtUmir9TRd7oxSbyDQH85o3dC+7xR4C8lbwvypwzDOniE1f969B4cDoAeL8JNNKzCMIsPiCOO2s0lPrP73hJ0PQlmF6ZFFFDTeCxVaAAMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691165; c=relaxed/simple;
	bh=KfxM0vzZgS2L0DwWRH3Jzw9a7FErvPWPpzp0/aA0KYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXJgLmmMjwWv9Jl/BmKoLibVnwJZPuox2rMw4ItZHlg6mLLOEPsIicE8KUNeTjcfRgR/LPCTIP5sfqn915kl+b5QL5w4otm1Yl9A0IGToCDRS98+CfXdfz4ecGsnqpDRrSKrDwJdFa6IsMlmoXYhr2yZ9cdaBBcjCUaNRJloE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOtolxKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOtolxKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B361F00A3D;
	Sun,  2 Aug 2026 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785691164;
	bh=pFcYAtYZKTbchwM3TuHYqi661eAqwhnE15RFUm2IfoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GOtolxKAs5OjNDldCh8cutFYqtrJAPX9qtDz39dXODofGi5n0QUA2cZU4TfH+lQab
	 QIzkntEOPuL1nn/peMenvRsczSSHrNSpFMNGwlOgEWw5Yu0jIbvHcyN/qmLZEiJCQt
	 /b1HU6zUy32upD9wdlaizJQGhHWHganI7Y/jTitITcx3KxJSXdHtI71hc/da1uzX3o
	 5Tz38oQYVo5U4E2oMgsuoSGl5UDxdI3YfMsKk71doOsCDuMMmj5kyNt5NsOsxMqC8u
	 CppDrA39ViOt3VEwugoMGh6DB9B4cJpXHWnOdF/GfkF4AJh0jl138m70/WVc0VNzAx
	 s4pkk9iz+fc4A==
Date: Sun, 2 Aug 2026 18:19:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Wadim Mueller <wafgo01@gmail.com>, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 maxwell@maxwelld.cc, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com,
 455.rodrigo.alencar@gmail.com
Subject: Re: [PATCH v6 4/4] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260802181920.3cc8a259@jic23-huawei>
In-Reply-To: <1555adce-4cce-45c5-b3bc-1898d1bab46b@baylibre.com>
References: <20260728214943.29820-1-wafgo01@gmail.com>
	<20260728214943.29820-5-wafgo01@gmail.com>
	<1555adce-4cce-45c5-b3bc-1898d1bab46b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 11:07:27 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/28/26 4:49 PM, Wadim Mueller wrote:
> > Add a driver for the Sensirion SLF3S family of digital
> > liquid-flow sensors on I2C.  Currently supported variants are
> > SLF3S-0600F, SLF3S-1300F and SLF3S-4000B; they share the same
> > register map and differ only in flow-scale factor and calibrated
> > measurement range.  The variant (and therefore the scale) is
> > auto-detected from the product-information register at probe time;
> > a sensor reporting an unknown sub-type falls back to the variant
> > named in the device tree / I2C table, so a drop-in replacement part
> > keeps working on a kernel that does not know its sub-type yet.
> >   
> 
> ...
> 
> > +static bool slf3s_crc_valid(const struct slf3s_data *sf, const u8 *block)
> > +{
> > +	return crc8(sf->crc_table, block, 2, SLF3S_CRC8_INIT) == block[2];
> > +}
> > +
> > +/*
> > + * Read the product-info block and pick the matching variant.  The
> > + * sub-type byte returned by the sensor is the source of truth; a
> > + * DT-supplied compatible only seeds an initial guess and is overridden
> > + * on mismatch (with an informational message so misconfigured device
> > + * trees are easy to spot).  
> 
> In the past, Jonathan has always argued that the devicetree should be
> trusted more than what the device self-reports. This seems a departure
> from that. Why are we making an exception here?
> 
> We have to trust that the devicetree is correct for everything else
> that can't self-detect anyway.
> 
Hi David

It's a slightly fuzzy boundary and I wouldn't ask anyone to spend
effort adding support for detection of where it differs from what firmware
reports.  However, we have had a number of drivers do this in the past
and as long as it has a fallback to just believe the DT if you don't have
better info, I'm happy with this approach.

This is different from not believing firmware if the software has
no reason to believe it is wrong - i.e. the fallback compatible thing.

Jonathan

> 

