Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793884512;
	b=tsvDOm7yGRd1tjDl/6NXYdg78Q+fJgBGRfBL47gAwU7ZFEYSBgvFh1FJ+Mo2N1ZYfs5H
	 Ldt/YuyeimlPu6xWesw7rrU/GQxGZGVLR0AsPUwqFASb/9kpAVUTsTBSFKKl2f3GYzKBw
	 hoActfdRfthFcPPYnT3fJaI/vmJVIaUBAndtZ/zAFOp4pout5suLW0FB6686GYnP0qcwT
	 3YI5f43EPCayB0i0CFdhR8Ptfr3ZjZV6YjhBC+FLANxV4A/eNO+4Mej45BNAoRJLczrqf
	 hE0c2XmV3I/rdK1BD9TSkrehDMWsn+jDiS+etG1nkIl+JIvBYIMS49RcgI+K9Ljt4gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884512;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U3NzcvKV/DmCP0fJM3h+QLKjIJ0i9OejuBeqh4kQW7M=;
	b=qPxz24shwugsQ7sTXxd2BkXgWuoCROGG9bvSL17EVsDQdQwPe6sPKSRUaZxfZdPutFi1
	 2zmgTHmUXzB9bJKcAiYV5weckp0SfEAoheiDRVPm26+4BOocB4H/YzOs0u1aSLjb4YDKz
	 B7WxbcwzA2g04sRTosFNf2LkhHFcC6c/R+LKYD5B5hvi4X07FRx57JVqM/mdC7Y+SSskE
	 gxGVMmO8FIxB+FJ9dFIF5pQx+xFwS4NkTr12dRMe3swH84mVxyhLQff9M0m77oDEPrjzn
	 Qmsr5My/mZ7ltmA0sQOjR9jLynCS4LhCI2PxtxkOGNresv8r2sMPyV0UFN+q74+PYMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fNMj4N/x";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486AC606A334;
	Thu,  5 Nov 2026 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNMj4N/x
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793884511;
	b=wzK269wz1+3yZ8b4719L1WBAPL6LXz9YCFcniQSkh8b00o6i0KKO7wuma6b3ShFAhUZu
	 2nyhVmh44AhyZ7d6uP+/jhRjpsUclFTYbJSYbUSRttwqIP4YtHiJ4ftqLGLg3cemwEDAI
	 hud3eSZLb4J40Qam2c+gENmHvS0tDvJJHLmnHJGahR3+8VZdPKgxxmr7cml/GCus+78dy
	 QtFCHaOFDOi5gdct94P6514mZeXXaKaSuVs1fo0PzHavAA64kwzpqRZW/MeEIIKMKwNOi
	 w9oA9S+ykPy1LGxuWJlV/HRNFtXfvzzweGZw3jecmHg2RZMjbqsBbF0aDgnfMSfAb3w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793884511;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U3NzcvKV/DmCP0fJM3h+QLKjIJ0i9OejuBeqh4kQW7M=;
	b=raD8Bgu0fNT/RZlsqzlyQPibohBs1Fiv22Q3hxtIla3OJO4YEL56LEAkiwiOBrWZme4X
	 OGXUreLo3EPBqeIJToznCXKDZoAEnEQyx7mwrcGSKW+iXlCEHVHC2fdJ0fEN0ASlXvmUK
	 h3jvlZzEifsyP1AJa7m1x8+LLyteT3EwnlUSQmhxwhjpbl6qasTULSOBTYL+N++X0QerE
	 tyYJ6cV14jiVE1OtlzvBD8lh9K42C5HLXRntozsNAx/60DJI145FJ33ZXz13vPU/Ye8h0
	 OLyPky3vfBEchmYOmoPyBHLzXXXQWcLDP5r3P/TObs8pfhOgsq49nc9wDU337PlbyKg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 22D0B1F0093A;
	Thu,  5 Nov 2026 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884511;
	bh=U3NzcvKV/DmCP0fJM3h+QLKjIJ0i9OejuBeqh4kQW7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fNMj4N/xxNf+Q0vpNU8tnsmJT7A5YKojRVq3q/PRsQsQNz5g07STlZ1q1KgcKHHCQ
	 ydd2rh2teBlIOmhxswR++NgqciBhVHHdU5aC/XlTf0Yh24QVVd+YzXgpQJS4Z50ksW
	 f1FrudmcofTIRDE9PjRfyE76eanvs/zs7BrriUpA6ju2T644WW01affSRWFr5P7HDg
	 nEA0oUFE+M+DDt0KpNrb40FgEmCIlX2nxtqJkW1jKv1tNevrrh54YqEepwDdRROp98
	 YMXS4iape4xl/kEmyl5PcMaMUICcGjgyaa7Gb/7Sz2Hk8xYhAtZfFwzRZWg4LdkOJl
	 /C7Nl5YdYx98g==
Date: Thu, 5 Nov 2026 14:15:04 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9324: reject reserved gain values on
 read
Message-ID: <20261105141504.000009b8@kernel.org>
In-Reply-To: <20261104175920.207384-1-kapoorarnav43@gmail.com>
References: <20261104175920.207384-1-kapoorarnav43@gmail.com>
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

On Wed,  4 Nov 2026 23:29:18 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9324_read_gain() is meant to return -EINVAL for the reserved
> PROX_CTRL0 gain codes, 0 and 5 to 7. But the range check sits in the
> else branch of "if (regval)", where regval is always 0, so codes 5 to 7
> are never caught and are reported as gains of 16, 32 and 64, which the
> sensor doesn't support and which write_raw() rejects.
> 
> Check both reserved ranges before converting the code to a gain.
> 
> Fixes: 108e4d4de2b5 ("iio:proximity:sx9324: Fix hardware gain read/write")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---

Makes sense. A stable tag is probably needed.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
