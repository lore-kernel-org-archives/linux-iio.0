Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167705;
	b=2n5WdUNVfZ2b02ley1eOJJme5LGj3far5vkKyWLdYKwID8y6Yg+Oor4+Gm5sdcNf8MGE
	 lEfQI7vFCS7fiNqhfrp8CHeotlqmO/r2GcX0Fqpzv3fOVghh3ppnjRJJ4nl3qIeuexiG9
	 oVgRqBbq1BNeNO/JnGWfl962s6hb9zFIJx6FZRkEVQJQRPkfhu5pLX8m1ZWnMbgAxDeFE
	 z9Jjx2Vf/ydugt90U9yRxvkSg+TdpoWO3N19UumHP9PxixIfJbEqx2sZLm3qi908XPl/q
	 1p7ZEOFhcCU1whW0utBx+0kKBdtIBn4d+LInAh9G7RAFYoHuV/L3MFUAbIWbbGMuenQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167705;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iAYAWagcK2oD6IJodu37Si2OE/e/GmH1If5y70DWnJ8=;
	b=bOXruG+aWeLZaMjLf5+a2o9ukMjDdAvYS3E1ycw6/Nc8VgTASTceOekhrhE3qtFK2yUT
	 5PNZTCwTdpCx2DaZWjL0y5YHLR6L6OcN2Q+OoD6eOOxVACShAqEHhEvplI5IbnrZT400W
	 Q6n34DRkL3cnFhgvsmpssSSNjTD0LN5Uice9NC9xOxBs8nVqsy4e9birepqmyq6V1o65k
	 p8/u8U4sd8A1IysjuLG+MLgcy0Siz0PQOqURVexaA0FE5lH8Lr9W4dglzmYAcCThCMvmK
	 IFLR9V58DoxE0+46O9Jtq2sxT/t4q+8M6q1mb2ccJ6w38b8Rnqisc823Vla+40SbgJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEeHiJO2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B25606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEeHiJO2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D4B1F0089F;
	Sun,  8 Nov 2026 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167704;
	bh=iAYAWagcK2oD6IJodu37Si2OE/e/GmH1If5y70DWnJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OEeHiJO2O4d3U7R3TxROk4VXIVkMoKJVOfmF4LQfSJNyF1NW6EVoeR+MiBzRYEWnW
	 V6yTwXy1lkmSAQykxZ3KH3EoH/uY8BrI5AKDrAA0O6zRA7uxXRHvGf00OOm6sndrjz
	 ifjWCCkhn8z5jcEr/NKNU/vknG/eMhaJlV6daCb6W6nKq4ToTsXJyjQc3LfbAPhFDk
	 sHLfOCUIWM8KhrPoSCF7SR8OJ5KdPxmPbcS24rgYdlQ31nQgbe5ktKOKU9k1Xty2BV
	 bPOaRk4IMY4i58bYFkEQMbVAzquG7uIz78ssWGXm2e3d80L5lnwAk4TmR7XdIk/v2Z
	 htWoWtjTukG/Q==
Date: Sun, 8 Nov 2026 19:54:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Archit Anant <architanant5@gmail.com>, Stefano Manni
 <stefano.manni@gmail.com>
Subject: Re: [PATCH 19/39] iio: adc: ad799x: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108195458.2092cd24@jic23-hlaptop>
In-Reply-To: <auBhBYR5DOqkSEn6@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-19-8b136778eedf@oss.qualcomm.com>
	<auBhBYR5DOqkSEn6@ashevche-desk.local>
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

On Tue, 27 Oct 2026 10:29:57 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:37PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> > 
> > Move the buffer onto the stack, local to ad799x_trigger_handler(), and
> > declare it via IIO_DECLARE_BUFFER_WITH_TS().  
> 
> ...
> 
> >  	b_sent = i2c_smbus_read_i2c_block_data(st->client,
> >  						cmd, st->transfer_size,
> > -						(u8 *)st->rx_buf);
> > +						(u8 *)rx_buf);  
> 
> Indentation is broken (even in the original code). I would reformat as
> 
> 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
> 					       cmd, st->transfer_size,
> 					       (u8 *)rx_buf);
> 
> (yes, it's possible to move cmd up, but for the sake of less intrusiveness and
>  better reading the changes fixing indentation just good enough).
> 
Tweaked and applied.
Thanks,
J

