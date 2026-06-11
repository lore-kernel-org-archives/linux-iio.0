Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8FC3FBEB3;
	Thu, 11 Jun 2026 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183284; cv=none; b=At/AE+BPl4etAHHF7QNwpjoSW+1zxdhHQYNrlztCZPIyyAzL9+6BF73xF22gbjixxcL8LTH+CC57t3+uc0gsodqEvEQ0JzV/xt3cpTAJV6VDciQzVQ1QBT/YoCd9XwJrBoGiGGVHrBOtNDjZio9zfL9gDziWWAtkj47gOHSnRdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183284; c=relaxed/simple;
	bh=YRSxXGEdBMckTZWMiUzxt6dGytOXJeqbKrl0zoZEiLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCVsnFawLf4KgGwZJH1/Yxzl/MoFNTIf5G8Ehgjh6BwOP4v+nryjFyJXjOZFTmEc9XVOk1KKqKYGHajLgokPBdb9NL1ZHzG5r4mMPUeOViJmAOM7O09fJUKPMp+MBpRN/Li03UaXmmw0ylgXIkP7XBVv4ruPKQrvegsHou30Uuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaXShn7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaXShn7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B196E1F00893;
	Thu, 11 Jun 2026 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781183283;
	bh=P1FYUXcpGczkI76lcKKzluH/jwJAQaC7J1OAjGYdPcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MaXShn7s9AgR4EjVMsTuJiFCI6wArgzLEPjT5bVoPRgUurzF9WQsUHU16hHMr8ic+
	 AKyOQ13NpTR77DttWP/rtPqRW8aiT5XsOR/b8GsQte7FwnzlBb/QM4bA7vDFA+O7NE
	 vYoJwRUDk23A/3PJ15Nn/x98JhX2HRWZ4ExUsF2vAgXN+r47OPiECoQ4jxP1Ww5Aw6
	 4ElAVBYhAIJ0xvM9xOkK/dGnJnyStUQ8QnVJ4WmdOV5Lefqoit1dC6uQCrVPoAMy+w
	 SYvy2Z2C272qhVC+XdjdluFcnXkvwxx3cHt2w6H4IgvlNMis36/3ahNm98Cmyuk0V9
	 czDzmPT5/SQSA==
Date: Thu, 11 Jun 2026 14:07:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML
 schema
Message-ID: <20260611140753.6158ad06@jic23-huawei>
In-Reply-To: <20260610192338.GB626285-robh@kernel.org>
References: <20260610110051.1228-1-shofiqtest@gmail.com>
	<20260610165640.411c1477@jic23-huawei>
	<20260610192338.GB626285-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 14:23:38 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jun 10, 2026 at 04:56:40PM +0100, Jonathan Cameron wrote:
> > On Wed, 10 Jun 2026 14:00:51 +0300
> > Md Shofiqul Islam <shofiqtest@gmail.com> wrote:
> >   
> > > Convert the STMicroelectronics LIS302DL/LIS3LV02D accelerometer device
> > > tree binding from plain text format to YAML schema format.
> > > 
> > > The binding covers two variants matched via their respective bus drivers:
> > > - SPI: st,lis302dl-spi (drivers/misc/lis3lv02d/lis3lv02d_spi.c)
> > > - I2C: st,lis3lv02d   (drivers/misc/lis3lv02d/lis3lv02d_i2c.c)
> > > 
> > > Document all vendor-specific properties read by the driver via
> > > of_property_read_*(), including click detection, IRQ routing, free-fall/
> > > wake-up engines, high-pass filtering, axis remapping, output data rate,
> > > and self-test limits.
> > > 
> > > Also correct the click threshold property names: the driver reads
> > > "st,click-threshold-{x,y,z}" but the old .txt documented them as
> > > "st,click-thresh-{x,y,z}".
> > > 
> > > Validated with: make dt_binding_check   DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
> > > 
> > > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>  
> > 
> > Hi.
> > 
> > So the conundrum here is whether we want to keep carrying this binding
> > as it dates to a previous era.
> > 
> > The driver never made it to IIO and is still in drivers/misc.
> > The majority of what is the text document should never have been
> > in DT in the first place. I'll guess this dates all the way back
> > to the wild west days before we had regular binding review.  
> 
> Where the driver is doesn't matter for the binding. Unless the 1 
> apparent user is will to change things, we should just document what is 
> in use (and nothing more). Some of this looks like it can be droppped.

I don't mind documenting it, but with a big warning at the top to make
sure no one copies it for a newer part! 

Jonathan

> 
> Rob

