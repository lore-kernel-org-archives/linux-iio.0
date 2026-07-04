Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F640433E93;
	Sat,  4 Jul 2026 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783209490; cv=none; b=SAPo3EocNA/OuDbjPsuZ2nclk095yo99QE5Q/tBdg4qxPSqj+r4SxStbQOIcwnvB82cLYYOnYI8bwpfamKSlqnz1PdHTZQJt4cGkH0Irs73opRpBm3U5rTOC8RHnEApKGeh9aXJ3XtIznvCV4zS4DiYefh7A5xQPqIrbqhOg+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783209490; c=relaxed/simple;
	bh=C5T+qsu0lXDKOpBrxz1ctwanPsx0zsgKtDGQBucR474=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay1dck9hJEmny6AUasQ/3f6nF/a962icE7kzybp9zJKTe4KAHCnSPV3GZQJ8NTzyQ2d5UR6mdjBVZTjkxouR099CcXe/IVZZ68HGvzCFGEhM8Cnb0yUR65IEp4+SWGOkObN8egtpaILqFa6102FBb1++jPoSDbWg66IEE1ZDHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt+mJyqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt+mJyqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E101F000E9;
	Sat,  4 Jul 2026 23:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783209489;
	bh=zqTmGnBS5rCP28nRxkfnYWaNVewyb3XPZGvLPpae5J8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tt+mJyqjCpHiO5UpcBS6DTyasBK2SOQbzig4E66IihQXH9DspcWnxbziyIqMIqDtp
	 nUbBu0O3+Jrez+wG+FyChXTfmPY93k9UExQKlIhhsmeGB02/7HdwSUAqwuZaIIPZDw
	 ul4wH4/1Rsr0Pgo0/5wE2m61yfRfkUnKx9e63P0dsDb/nD8603KhCvXM5gGdUveLwq
	 u9u2BEpFPof6Cwo1Y5OlMCvyt8KMQd6soiInOZ91HjUIvtfScnhSIbxMDwlhW7Nk/2
	 j7hMoMFQ9Ll7SUoE0ywhzNSiPFzQuXejUFx8n1V2cgS/8HIm+zHI4cEqayiB/2jeLy
	 9XIjSZhSJo84Q==
Date: Sun, 5 Jul 2026 00:58:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1241: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260705005804.7a1fa734@jic23-huawei>
In-Reply-To: <akk7gf51LfKbIuur@ashevche-desk.local>
References: <20260704151633.38517-1-pengpeng@iscas.ac.cn>
	<akk7gf51LfKbIuur@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jul 2026 19:57:37 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Jul 04, 2026 at 11:16:33PM +0800, Pengpeng Hou wrote:
> > The driver has a match table for the spi bus wired into its driver
> > structure, but the table is not exported with MODULE_DEVICE_TABLE().
> > 
> > Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> > is generated for automatic module loading.
> > 
> > This is a source-level fix.  It does not claim dynamic hardware
> > reproduction; the evidence is the driver-owned match table, its use by
> > the driver registration structure, and the missing module alias
> > publication.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I'm not rushing this in given we don't have reports of it actually
causing problems for any users. Applied to the testing branch of iio.git
which means it'll go upstream in the next merge window

Thanks,

Jonathan

> 

