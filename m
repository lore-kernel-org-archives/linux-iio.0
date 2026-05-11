Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906772C11FE;
	Mon, 11 May 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509593; cv=none; b=O7m3af33dUyRAz7W0SBaCCBsmCp1zbE4leSZb2CT//+fLQZZlUJkszDgW/JXYzzAacuJKQ9gGxyBk78I/qqMMyPOsTgVUjYN9J2S5vmh1KxICuGHjjfu+qgqts0b2Vl9AmznD+rMC5CuJIZag46vWTIZpn0TOmuce0BWBoeIdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509593; c=relaxed/simple;
	bh=JzBN4RFhqD8jhedXYPyOcd1ElmbFq/NZdPybsE815Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8MMjuT7KsL69T6yIaWiLA4P0n9tCc3VfwR9WlXCX6/MV9V9B32l3hXcNchi4hPQLl0oUfPdJ5g5D3ELgc89Vg+2k7Ge4SrGPXAlk4HqfdOX7Ikw8uCDiK1C5WZ+l7aGCHvZLnxQMwWAtPt+K2bjjQnXo1KVHMxt+DOTuuvZr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUwhG0kH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUwhG0kH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2B8C2BCB0;
	Mon, 11 May 2026 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509593;
	bh=JzBN4RFhqD8jhedXYPyOcd1ElmbFq/NZdPybsE815Bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WUwhG0kH1yDSX9cV3b5Vj2wAJHJPoCqPmojHS20/xYR9PgpvlzgtYSPkonUlCWK3O
	 Gg/jR7Oq8cguELcWZpeUjzDN2FuFaswFw97v01+tx2haxQ9ezKA4szbHW1j43VVSW0
	 BBjKFXt31cG2HjsIDXHYLX1vxsUdKQgljkTAnzbjg6ObchUTH4ASMCmyK9ROkkLOZ+
	 YzNBey2CWsQkqv6WXieDo+9Ck40t8ZGgnCvthwZwyB0TQXrY1AAw7hDh5/GAuE6365
	 cFED2JjBxMvE0Yq0ln1jxto9DtuB8JLHNwpenutZKcipTx29X5ftsh1c/pLn6bxhig
	 bj3jtApw4AJxA==
Date: Mon, 11 May 2026 15:26:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, ak@it-klinger.de,
 dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <20260511152624.352058d6@jic23-huawei>
In-Reply-To: <agG9FAXXiTKDIEDf@ashevche-desk.local>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
	<20260510202657.38326-1-piyushpatle228@gmail.com>
	<agG9FAXXiTKDIEDf@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 14:27:16 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 11, 2026 at 01:56:55AM +0530, Piyush Patle wrote:
> > Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> > interface but uses trailing PD_SCK pulses to select the active mode.
> > 
> > Model the HX710B with variant-specific channel tables and IIO info,
> > track the active channel across conversions, and use the fixed gain
> > value when computing scale.
> > 
> > Also update the adjacent Kconfig text, file header, and module
> > description so the driver text matches the newly supported variant.  
> 
> ...
> 
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>  
> 
> >  #include <linux/delay.h>
> > +#include <linux/types.h>  
> 
> Seems wrong order.
> 
> And here + blank line to make linux/iio/* to be a separate group.
> 
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>  
> 
> ...
> 
> >  	/*
> >  	 * triggered buffer
> > -	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> > +	 * up to 3x32-bit channels + 64-bit naturally aligned timestamp
> > +	 *
> > +	 * aligned_s64 satisfies the 8-byte alignment requirement for the
> > +	 * timestamp. For HX711 (at most 2 active channels), iio_push_to_
> > +	 * buffers_with_timestamp() places the timestamp at offset 8
> > +	 * (scan_bytes=8, already 8-byte aligned), identical to the original
> > +	 * 2-channel layout. The extra channel slot for HX710B does not affect
> > +	 * the HX711 ABI.
> >  	 */
> >  	struct {
> > -		u32 channel[2];
> > +		u32 channel[3];
> >  		aligned_s64 timestamp;
> >  	} buffer;  
> 
> Why can't we used a recently introduced macro for this?
> IIO_DECLARE_BUFFER_WITH_TS().
Putting it more strongly - we should be using that macro.
The timestamp is only there if all 3 channels are enabled
and present on a given device.  So this structure is actively missleading
and hence the need for the complicated comment.

Just remove that implication by using the more flexible buffer declaration
macro that Andy is suggesting.  We have that macro for precisely this case!

Jonathan


> 

