Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658399;
	b=gsnB94bTPc98FlXC6jcnki0qeXte27uqVZl7LuBH1j2xRCTeG0u3948DTspJbitGgOGR
	 JEaLvSzAM6yucNCHvhJwj0CslXiz1hMfRUMMMJEF4KtEh0DNb5viNlKp2L5QuRk6I8W8C
	 cw3M4xtO7Lg/IbOPo1R7L21K2RPjPBKk1IjIbWejS+vmD6hkRx3EMkRL20Sp6MdAc3oTW
	 9tqF1YuygPgw8hqJ2S58IUrVTjtHr79gamrLJ8lCx9DyyjjOVzQk3pGewvTsX4tlARPA4
	 nH3p4Q+nPwlGs4VJSVzd7U9FiQsxIM56J+H03Q0SecULIzTBEKpEYEwu92Nd5yUe7pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658399;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ud2vRyGW32RAEy/UlibO5QmEZ60DomVO2DsT54Eh6Jo=;
	b=PTF/7gIXxZFIy1SsYB2gYMFpTCYNNPTLZXpbxzZ0hvUgxKrYJT3HSsfzvThXpDh7oVv8
	 ic/qc18eofMph1DqkTTGDA6a/K9jquYOpwpTlhzL6dXWQYNgIGkps9xInwPgPwF+TAp50
	 4K/fGF+xN5jswgEWe5AI+V4DeWAN1ftZrjOPlyAGVlETbUcDfIx1L/I+L3wpE56BxRJKi
	 ZmevEChvCOQU/gXsg0yIlYreMxxCl8PRuDUZBg4p2GJgC593xdwdeRm9XKD9RqM/1xDOQ
	 C5EZUR1pTUO9/UVpUH0DOZK06l7zaOm+VAFT6QQbTr2lHwa0SLfB8IAdcpqc55xyjuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPo0O5ok;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD65606A327;
	Mon,  2 Nov 2026 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPo0O5ok
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1371F00A17;
	Mon,  2 Nov 2026 22:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793658399;
	bh=ud2vRyGW32RAEy/UlibO5QmEZ60DomVO2DsT54Eh6Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CPo0O5okfxy0QocbpTEqYgJzbqaZ8mI79zC5qp5pzGdZ9HpaM+2r69sD9PCZ/XWfA
	 lbxu9PMo+GVzUQRPwYR6MVqLxkIZEhLf2vlztOF2OlIsNfpW+Gprv9YySGMqPyDcp2
	 xdouetr4DCCu/amKqKxe6sA/+Lr/CUgFEGEPKNamti5ukVmVM2Qduz/YBe1YbrrehI
	 UlIW5VX/jGLS7/AL+f/+OzS9eFItGy/BGrNRK37yZw5+YarcQvzy9YkpCxWiQvCYAo
	 rbNzGIyOa8cVailgJW3jj7m9T2DoaEDpCGz0s3MXfSSDBBup9X9fUlhbMVgGX+SxyW
	 VS6iiWH9tDZOA==
Date: Mon, 2 Nov 2026 22:26:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Matt
 Ranostay <mranostay@gmail.com>, Robert Eshleman <bobbyeshleman@gmail.com>,
 Leonard Crestez <cdleonard@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: light: isl29125: Report the scale list via
 read_avail()
Message-ID: <20261102222634.6531dbe5@jic23-hlaptop>
In-Reply-To: <20261102074700.63075-2-arka@arkamondal.net>
References: <20261102074700.63075-1-arka@arkamondal.net>
	<20261102074700.63075-2-arka@arkamondal.net>
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

On Mon,  2 Nov 2026 16:46:55 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> The intensity channels set IIO_CHAN_INFO_SCALE in
> info_mask_shared_by_type, so userspace reads the scale from
> in_intensity_scale. The values that attribute accepts are listed by a
> custom attribute named scale_available. That name carries no channel
> prefix, so it is registered at the device level and is never paired
> with the channel. The core would have called it
> in_intensity_scale_available, which is also the name
> Documentation/ABI/testing/sysfs-bus-iio gives, so userspace does not
> find the list where the ABI says it is.
Hi Arka

Not quite true.  The core would have done as you said if it was set in the
iio_info_mask_shared_by_type.

Now if it were in iio_info_mask_shared_by_all it would be called
scale_available and hence match the existing ABI.

The device presents 4 channels and arguably this one only applies
to 3 of them as it doesn't apply to the timestamp.

For that reason we generally only use the share_by_all mask for
things like sampling_frequency.

However, whilst less than ideal the change you are proposing here
is a userspace ABI change and it's a bit arguable whether the current
ABI is buggy or not.  So in general I'd leave this one alone,
or as a simple cleanup rather than a fix, move it to the read_avail
callback and the mask that does generate the same ABI.

Other than that patch looks good.

Thanks,

Jonathan

> 
> Report the two values through read_avail() and drop the custom
> attribute group. The values and the text they print do not change.
> 
> Fixes: 208335138001 ("iio: light: isl29125: Add scale_available information")
> Signed-off-by: Arka Mondal <arka@arkamondal.net>
>  static int isl29125_buffer_postenable(struct iio_dev *indio_dev)

