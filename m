Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E83BADAA;
	Mon, 11 May 2026 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507175; cv=none; b=M+I0ujTsGaU0Jc0Vrb7A4j8kaAbuY7rNQxvq4rEEzZaIfWCtmyrW2p+COAtPg4pXREwKZpL3OSKbh8y87N7+Euk9XC+oISVb+fIpGUfvDQuGN2AwP4PbZFS9kfhGB3yhd0UwiDIHDZRlmIcwRekjy/A37eR5SYqsb1fyektA5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507175; c=relaxed/simple;
	bh=25VRdc+FnPWnIwss0dDaNjoDISpp7CIuq52EngA8iOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRDXzzM19dQIKzS//aQDghA+7rYXLJsEhyAJexHtCtCPElx/E6h+SjrRH/ubBF1/XO5Gt2cu1isJTTC2KhNSjOpgpuf+OHA1Ah+TrPPLTpR03v2HqJZTpW4pdiLT8ENIexygxKm27Yg/SbLcjKDJwWMACJ/fBuTUzGAkSVMzlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/lY8jPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/lY8jPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E88BC2BCC9;
	Mon, 11 May 2026 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507175;
	bh=25VRdc+FnPWnIwss0dDaNjoDISpp7CIuq52EngA8iOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N/lY8jPYdErH75Htiai1+LJvJrRRe1zD0ZGOCGwLkyB7DbtKNy5vBxzTOPuClJd1r
	 3t4hHZyey6cxnpZO/pP+CpIucFldFFJxEj4s4KzDmCS7PKzYAGs+1DyJH5dRGjzU6/
	 xmIXx2ydKBVCvUMQqTVyjqjaMcy2jKC8Tn2PmJUMisDYWb08RisAjiH7qPQfHhftsN
	 /GKvGXNC06McrsvhXHtAVdxkP/IDeOKN9Zxcy6RxvD+IKv3uV4MnOyR1oLd2kkMHpR
	 +VP46RHG4XyyxTws6bGZDq/bjZRdO/J1uwBRPrV4ZY+Si6e2bqL6sUybsBgwPfDoS7
	 Z1JncbiTIOIHg==
Date: Mon, 11 May 2026 14:46:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 m32285159@gmail.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: addac: adt7316: document SPI interface
 switching sequence
Message-ID: <20260511144605.76c8ff39@jic23-huawei>
In-Reply-To: <agGtKQs0V679s6Kx@ashevche-desk.local>
References: <20260511023127.86113-1-dennylin0707@gmail.com>
	<agGtKQs0V679s6Kx@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 13:19:21 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 11, 2026 at 02:31:27AM +0000, Hungyu Lin wrote:
> > The device powers up in I2C mode. Switching to SPI mode
> > requires sending a sequence of SPI writes as described in
> > the datasheet.
> > 
> > During this sequence, the device may still be in I2C mode,
> > so SPI transactions may not be recognized and can fail.
> > Such errors are expected and are ignored.
> > 
> > Add a comment to clarify this behavior.
> > 
> > Datasheet: https://www.analog.com/en/products/adt7316.html
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>  
> 
> Thanks, almost there!
> Please, address the below and feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> to your v4 of this patch.
> 
> Also I think we don't need "staging" in the Subject, as we can deduce that,
> in any case it's up to Jonathan (and yes, I see the common use of the pattern
> in the Git history).

I think keeping staging is appropriate for a couple of reasons.

1) Affects who looks at it.  
2) Aligns with the more general pattern for most of staging that goes
   directly through Greg rather than via another tree like IIO.

> 
> ...
> 
> > Changes in v3:
> > - Add Datasheet tag
> > - Use datasheet name in code comment  
> 
> ...
> 
> > +	/*
> > +	 * The device powers up in I2C mode. Switching to SPI mode
> > +	 * requires sending a sequence of SPI writes as described in
> > +	 * the datasheet "ADT7316/ADT7317/ADT7318", Rev. B.  
> 
> Yeah, but you dropped the section title...
> 
> 	 * the datasheet "ADT7316/ADT7317/ADT7318", Rev. B in
> 	 * the section "...".

Absolutely agree on this! Can be hard to find this stuff in the bigger
datasheets :(
> 
> > +	 * During this sequence, the device may still be in I2C mode,
> > +	 * so SPI transactions may not be recognized and can fail.
> > +	 * Such errors are expected and are ignored.
> > +	 *
> > +	 * TL;DR: Do not change this!
> > +	 */  
> 

