Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038DF21A444;
	Thu, 29 Jan 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712036; cv=none; b=i1RTRPPpJ6YUVcMjuuI3hLyAVPYkDezfG46U+eg2S+6w5KGMl6tyfyGNejnIALLkH6iwm7PSLv2NmGmW6u6g8t2RrsGJmMIPh9UHyr4QMbm/FIfufu7irU0bpnriJ2iJMbqzchRvs3M6rOkLYWohMHq/ccb+Iu8f5LemXVp/1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712036; c=relaxed/simple;
	bh=w5ZpZFUVGwCEwUETHRongFvZUoQhcqny4z5JtF1t74k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTPZySq2VmE3j+X2qAVo3qO4h/PepJ1V9mr7I2Cy/yL3Ne2S8NewLCjB3YKMn4N6PpbOT8++F01TqOS51tsE16k0UQJGw2xy3fFWEPnz/hpuRRzDb39wpVWTbL4X9KG9vetEtDnGbCDNyYoLLNq0w9lg2IA07YZQS2O+c916FZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZWkPyXi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZWkPyXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224E9C4CEF7;
	Thu, 29 Jan 2026 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769712035;
	bh=w5ZpZFUVGwCEwUETHRongFvZUoQhcqny4z5JtF1t74k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZWkPyXi0aBhgsN5cXlQNJtckfRfXJifCq+blvMARj1gTfAmwq4hMy7T2nlC95QaR
	 4mZi27CZT8SnAvzPZoQ2FQiMYrdJyWynWKhqsvY0AUEeIELGQzL23MxFR5KPtVMeTZ
	 CxxsdFUaFF+cR9OjsY0TUpQRf0gCRne4wi0m5Zx++Coh3/H3a8wgbFTeu11QUclLa6
	 jZYuizG+B8/zytF/S8bfja/yCGUdN53AW08SzOpoQfkA1zFWZxseHLRGFwNDpx7xSr
	 caTCCf41SzvHojTqpyTao9n/y/9Pamq2Euj9qzkLP9xjN+Jpsn0xjElstSPF7WJqiR
	 zOuPJSgu8qkPQ==
Date: Thu, 29 Jan 2026 18:40:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 3/6] iio: amplifiers: ad8366: refactor device
 resource management
Message-ID: <20260129184025.4abd4fe0@jic23-huawei>
In-Reply-To: <rtu3nsjdufyhtox5uvtkoyzqtfcmq2wdfzmsr3xyvqlrdloirn@a3jdshanc7ha>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
	<20260126-iio-ad8366-update-v2-3-c9a4d31aeb01@analog.com>
	<aXkqKZELWdjrB8wN@smile.fi.intel.com>
	<rtu3nsjdufyhtox5uvtkoyzqtfcmq2wdfzmsr3xyvqlrdloirn@a3jdshanc7ha>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 09:31:10 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/01/27 11:12PM, Andy Shevchenko wrote:
> > On Mon, Jan 26, 2026 at 01:51:04PM +0000, Rodrigo Alencar via B4 Relay wrote:
> >   
> > > Adhere modern device resource management with the following:
> > > - Voltage regulator managed and enabled internally;
> > > - Proper mutex lifecycle with devm_mutex_init(), replacing mutex_init();
> > > - IIO device registration handled with devm_iio_device_register();
> > > - removal of goto's from the probe function;
> > > - ad8366_remove() removed as it is not needed anymore;
> > > 
> > > Also, dev_err_probe() is used to report probe errors with created local
> > > device pointer.  
> > 
> > And also it uses the temporary dev variable in the cases that are not covered
> > by the above.
> > 
> > So, three changes in one patch...  
> 
> I can split. Using proper devm functions allowed me to drop goto's and
> ad8366_remove(). Dropping the goto's allowed for the usage of
> dev_err_probe().

As general rule I prefer one patch one change, though just occasionally
I'll take the expedient view if a series is otherwise ready to merge
and one change is really really small.

J
> 
> I could place the temporary dev variable in a separate patch. 
> 
> > 
> > Dunno if Jonathan is okay with this. I would rather split it.
> > Code wise LGTM.  
> 
> Yeah I can now see it coming. Thanks for the review.
> 

