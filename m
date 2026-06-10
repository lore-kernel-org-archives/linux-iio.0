Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9A3002D1;
	Wed, 10 Jun 2026 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119420; cv=none; b=MEoao5eMOR0Spc7NPCjLILlsrwsOdOgAUUmhQ5iuLS4CgUxiVHmUH86ONVbP0lC/8O7A+yNKCd1LoPXQDAmgI2YT0PS2oUaz9reAJ2jpodq06O1UKOlEGf32X8cWdPy7iDo0V7IhMa0/I6SGbK+YLm4Ye+Vb7j5DnqKoAzmmNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119420; c=relaxed/simple;
	bh=Puy0+WDhFG/hdKVJlVU0FESwrANh4+pb2K1oMmWZSJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuZFg77R4eFnuZgn3Rmny0GIGNLYWUJmFTLhyTYifKXq6uAsF7B3ovGG26CK3JYzI8yFCOLb9yziaotCnbhu6+OJ4l8SbDrHDbKTjFELrfI+xnafzaxmRJ/TGMYly59/Ve03x7qNL/H7XfrGm/f+t1ixCQRt3uOXSy1FnqQSRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMINs6Nk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMINs6Nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A901F00893;
	Wed, 10 Jun 2026 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781119419;
	bh=Ludsmq8Y6EgdyGWD/SlqPssF53N5QdGs0zpEsNTeonM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GMINs6Nk+wuYHh3dcKxXPTXvLojkj3LuvWhiC+WKK+7puuhorMX3Pz7/tm6Xiqfr0
	 qzcMvTa2BOng8W7ztb7w5pdpLN2Eb64Q38UBvKZMTjJcbzTa6U0aE8n+mtdT1XjRZe
	 VHpHpmd9/reef+zdGgicC0yGWHCkhu0lKqQEU3zw81nzCeHNnSe8voJ8iRfWsDye/l
	 ZOFA5gzb5GO71nkc0fsByMvrtlC3NG9NvpiZBYlO3hXcrKlOFH1oRrjO/sP51/z0On
	 nvQhIwmy02YlOuzgy/huyyAtXX7uwYjhEvkVx322QG429DUadySx7lvkKeW2xRn8cF
	 3l1fMCXl1SPog==
Date: Wed, 10 Jun 2026 14:23:38 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, krzk@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML
 schema
Message-ID: <20260610192338.GB626285-robh@kernel.org>
References: <20260610110051.1228-1-shofiqtest@gmail.com>
 <20260610165640.411c1477@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610165640.411c1477@jic23-huawei>

On Wed, Jun 10, 2026 at 04:56:40PM +0100, Jonathan Cameron wrote:
> On Wed, 10 Jun 2026 14:00:51 +0300
> Md Shofiqul Islam <shofiqtest@gmail.com> wrote:
> 
> > Convert the STMicroelectronics LIS302DL/LIS3LV02D accelerometer device
> > tree binding from plain text format to YAML schema format.
> > 
> > The binding covers two variants matched via their respective bus drivers:
> > - SPI: st,lis302dl-spi (drivers/misc/lis3lv02d/lis3lv02d_spi.c)
> > - I2C: st,lis3lv02d   (drivers/misc/lis3lv02d/lis3lv02d_i2c.c)
> > 
> > Document all vendor-specific properties read by the driver via
> > of_property_read_*(), including click detection, IRQ routing, free-fall/
> > wake-up engines, high-pass filtering, axis remapping, output data rate,
> > and self-test limits.
> > 
> > Also correct the click threshold property names: the driver reads
> > "st,click-threshold-{x,y,z}" but the old .txt documented them as
> > "st,click-thresh-{x,y,z}".
> > 
> > Validated with: make dt_binding_check   DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
> > 
> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> 
> Hi.
> 
> So the conundrum here is whether we want to keep carrying this binding
> as it dates to a previous era.
> 
> The driver never made it to IIO and is still in drivers/misc.
> The majority of what is the text document should never have been
> in DT in the first place. I'll guess this dates all the way back
> to the wild west days before we had regular binding review.

Where the driver is doesn't matter for the binding. Unless the 1 
apparent user is will to change things, we should just document what is 
in use (and nothing more). Some of this looks like it can be droppped.

Rob
