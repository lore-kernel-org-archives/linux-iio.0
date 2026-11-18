Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794990159;
	b=XP0E9vDIzRjQwcrH5AG/WszqK3900fasI0NdIm8YHGbIvZ9SHoYT78V21HfUAZplwYjR
	 vnoBzQbohYi6RYzCB1MGV57NuzgJPpyLgV9W44LLJTHvVthoNIvQFXw0TLEHf/UW2PgYB
	 9c3KqfpJwFRCXWBdQ97gECeVo5tmn1siwDVs41Z1xwvKApGU0gOL51rkH5xXN/dMy3Jsx
	 RhFFan6jlQrOO+lMJcYCAIQyEdOFSEA6BE6qYCaeXeB5Cu0AlCHuRb9PwrH0KH9s236o4
	 IDI04Ih1Cr3/0pq0c/eZlAvLaKrTnHe8K6udF9NLk/mbfjXQK2RQk/efp5/LGNNJhKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990159;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J4ZE7vCsAhG2tmo9f0rn5//fakwxkyXyV2k3at5S3/s=;
	b=5IP6Z0x6IBIZZUdM1hRBRHOme5bbevsYp4nN2FXri5/eESs/isFmzSBOgRTnYL42aGKI
	 gRKSqDrIPlDnffq8cybMWNv0d1NgmtEMQPysC0far5AWIgXEPgn2401sjuuZXvCQPyOw7
	 NgApseJBLJlnNubynlIIUCllqHGhUGB9fMZxx4Ac9Evt54tqti1wwOmzp3klZAtmvE1ju
	 pd7TW7xjo4GYNfnZci027bt+BRG06tBsVHd30V0S5ayeP/8a6UCcYCpDqZ1xJfFnHO43F
	 /PfBxn7HXvqjcpi15yheHAKdOdP5U1M96FjyzJNXasq+k7wKtCSG55AeB/7x70ULlkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9fHU312;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD0606A31C;
	Wed, 18 Nov 2026 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9fHU312
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794990158;
	b=xCGlP1SgfiF/6gAdmvwDF+qYGoTPVikgYJLqzL7eMBRupSNz8J7pRNB4gO4J/UE44+vr
	 Gaph9flItWZV+iGbTzz0OHKRaj91BDg0DvfGkCThgQ6k+AOg/glsQNRwz9mwEtW4r1ELZ
	 jvb6PrOyp0Wwrtng8pa8iOZRgXE3S6bwUCuHtJCqq4IzvEIXhTX/GBWZkfmyWFoSvlBUJ
	 qE7vi61iDJolxR4kcXBiDqbnpMAT+HBOMYMzXl2AiaJPb5BW9sm+d5nCkZvs9lANMRx63
	 1ulVUt3rM1JCxAgt3Y0Jnx3MJOiCdqeUBHnP4/OuZzWTqOjT478fujeURTJJZxRb4qA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794990158;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J4ZE7vCsAhG2tmo9f0rn5//fakwxkyXyV2k3at5S3/s=;
	b=3nY3jBXrCug+fyQ+ZAjPJjrMSygrADZCp1OTHeNWHfrWHlfAIcRNrYcHta9tHHdQ09tZ
	 w1/m2zZ91B5YHDIyd8YgNKn8bLqQ+vuD5FYUJRWcfQgdyIbERtnlrxCixtia397wN51UO
	 MefIXBERw1fBp8Qdnf7uakE7kDzVUQH+IHzOnPO1ko9CMTmbnDywbPDjz93Qr5e23m67h
	 m7bUD4lFPK6Q7uhyALgo9LD0+WzbU29SEE9kbAJCMVUl8xVFemcc6YSTdWlObXZKIClFE
	 NxjlHXss2sPV5BxkQaSniwLUvA0vxiXX48lXMa6xbl90oY+F+ScnGD0iFtGywdvnI2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 8A22B1F000C4;
	Wed, 18 Nov 2026 08:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990158;
	bh=J4ZE7vCsAhG2tmo9f0rn5//fakwxkyXyV2k3at5S3/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I9fHU312mFw8dRB/mVNG1BZMmmzSYemzcy2nxHbnCceuoSllNqRqBKLxSkVU4daJL
	 aRTybwxeTCS5RCfFzM1IPX44PsZ5Z3okw/UfUWIyMUd366pYNKgRycYD+cEHHameK0
	 CU6lAnsWUiKtO5YCCp+q52WdRFxMj6oTITYMR91DJHq3KHaCln/j1OK8cMT2V2WwvK
	 VmVcBnT87WWOuw/f3m3U7HW/VFuK3rvK9xzBDnCAwqGBw8QsvIjh7ubwG/iE6WhG7I
	 ULzFsc66CSXeoo5GTfRG5GoQYWm4XZWxw0uDsmDPHjT2krsqK469dPYMj83aAz3gXM
	 mkbx/oa0tmD3g==
Date: Wed, 18 Nov 2026 09:22:29 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH v1 1/3] math.h: Add mult_fract() that takes struct
 __Txx_fract as argument
Message-ID: <20261118092229.000025fb@kernel.org>
In-Reply-To: <20261117091638.1463621-2-andriy.shevchenko@linux.intel.com>
References: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
	<20261117091638.1463621-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Tue, 17 Nov 2026 10:14:40 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Add mult_fract() that takes struct __Txx_fract as argument and
> calls do_div() instead of plain divisions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/math.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/math.h b/include/linux/math.h
> index 1e8fb3efbc8c..ded258df50df 100644
> --- a/include/linux/math.h
> +++ b/include/linux/math.h
> @@ -128,6 +128,10 @@ __STRUCT_FRACT(u32)
>  	q * n_ + r * n_ / d_;	\
>  })
>  
> +/* Same as above but for a struct __Txx_fract fraction */
> +#define mult_fract(x, f) 				\
> +	mult_frac(x, (f)->numerator, (f)->denominator)
> +
>  #define sector_div(a, b) do_div(a, b)

Sashiko has some remarks.

https://sashiko.dev/#/patchset/20261117091638.1463621-1-andriy.shevchenko%40linux.intel.com

-- 
Kind regards,
Joshua Crofts
