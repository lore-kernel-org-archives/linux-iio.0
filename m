Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793710870;
	b=ZyrW0kfyE5bhRPRIjqxLaw5M3prwNG8BW5dOYY+OvqPvlY2CPJu7Zl/w+nIwfqnjjtPp
	 3EjNokbr8MFG09OablJ7yzjx4Doe+Z4TWBg+QmUWmPyglN3Pn+VVXVlZyD5Wx7YAhzaxu
	 c90VwQ+n+7DSdYfTjwFZNWSLL7W03gPPtyY9Z7Y97z3onarK902ubcMC7LnBJQQqZzKwz
	 bO6B2ze5dejOKIbngz+uZCqkepuRd/tUPQ5xxmRD0m9By4g1CUzxNztFTunWInmhCzTAW
	 lL4essteqN4nwLGAgEOIeESc72toDPXghLX8M9BI547zy/FQnWBmzulzTDD+bQb54Lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710870;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tCXdSwBH2oP3ghx/QDnn7W2xUZbWzfZAqj/U/u/Gk6g=;
	b=g2EB8JKVlJrxlh5r2IXMW6KkzjKzips0amqrjZVr0LLdU/AsxUe2yNvQOWPnQb7n/7hv
	 xulm39AfQ3N50GtbJ+2lWy0N8/BoET1XXRb4sDQjoofukJwdgzDR3R74ohSM5XjNTgwEi
	 jkhIuEEjylpBqb9K6bwTHbYP4bM2Ics6oBjscp6GD6d8wYZZmHxiiVYtfT7jSjx2P0ZHY
	 B4Iy4UElSkrI915lJ3cIW3+Gu51JlMPC3/8OUMuo9vxmRjSgXIG9lTFuYyM4lk5kAdzfX
	 BLZ3F1rLdh6d3fBs3yfZcuZhEJPgDkUYHuQ21KQeSgKsi9CfeByfCVANj4kL0S9C3mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXLQP0Lj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C6606A326;
	Tue,  3 Nov 2026 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXLQP0Lj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793710869;
	b=QpYu39bDByWJh/NDYkQEWbSck0DSzTmfeTmFk5Q5ziZHW0imrG7yc7W+HcwbEF9mHAru
	 y/O30ZJtpry/F0+GJCBUrwYkEjvaH7f4B/2GCkC0GyVzVoRIe8QloRdOIC/e9oF6MBpON
	 wuaGa8Bb2qzxhDfA+QA5y7I4YpO5+kVXXXz/t0rx918cDZbOYO2YdDG4P3vmVCvWVvb3a
	 n73i8UGRwMipou+3OW14TH7aze+ILE2B9X8XQbozJg6/A/DMCbvt+/ze5xV5DjO03HS5C
	 6aLH5jh9bdTwfxRXHWSuUOx+SKvF4bafUYkbqaSIQnlaatxK6JQRZItlCt4ucE7C8Ww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793710869;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tCXdSwBH2oP3ghx/QDnn7W2xUZbWzfZAqj/U/u/Gk6g=;
	b=qG/CQ0HMTpxgs4MJnhSfYyHzrE7T6bgl83YNIjTAJ23DCzcn/gcUeKKTIbwvWif4EVFt
	 gLQTYR1LiqxXjkSUv7zeg+KYqKW+cN+Y4bdcOvCDdBmjQOg9CtVvtGQAUtCZUTjWIuNoD
	 cTXvpXShgGAUjMqvPKrhwAItE7bElOLpuikVldq2WT9sUuj3RHC8EKqqT5duH1QStOsUg
	 HBYMsqfg99ao6LIvf/NT6cPlfCjnhz+7TKw5vLa09nWQiB7ememAUaLeGyiI0Y+kORJCR
	 mlZNpioKBv7gXsawpRsddoIH319Xk5zRXAMNKLTXh2JZ3YsfuFJGDdf3mCj7u+dm09g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id EA53F1F000C1;
	Tue,  3 Nov 2026 13:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710869;
	bh=tCXdSwBH2oP3ghx/QDnn7W2xUZbWzfZAqj/U/u/Gk6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bXLQP0LjwGBla+El08CNtbpaxd7UbR+6pX/IigwdmKhGtOWFU5xTgJ8xZCf6O9qkM
	 0fXbjhoE3gxSzMy2glexp0H4VdjzFKBpotTjci5Z7iaoa52qqyxK4/OcTPHCGcXNkI
	 pu8O3l/KHFtkgiqQ88iqxB0HkeQ8BNJbuyfw8FDHqK3i0eUurhlZ9jB7ZczbMoLMsL
	 vCRLtHKnTO7bH05ICIU4ENQOnMaqvZJ9E43snxnmF5YttV2FgBbF+zM2qlRak6amMc
	 Dw7Vz4oj139PVxKF+pj4BahpaBBbcyE6VM/jmAyxhEdbJULRO/2ybMV4nsVi+/kvKN
	 frfo6S+5K0T4A==
Date: Tue, 3 Nov 2026 14:00:55 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Raffaele Tranfaglia via B4 Relay
 <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Cc: raffaele.tranfaglia@gmail.com, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Dmitry Osipenko
 <digetx@gmail.com>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: al3010: fix out-of-bounds read of the scale
 table
Message-ID: <20261103140055.00000efd@kernel.org>
In-Reply-To: <20261103-al3010-scale-bounds-v1-1-6110c2ffe3b4@gmail.com>
References: <20261103-al3010-scale-bounds-v1-1-6110c2ffe3b4@gmail.com>
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

On Tue, 03 Nov 2026 08:42:48 +0000
Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org> wrote:

> From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> The gain field read from the CONFIG register is three bits wide, so it
> can hold values from 0 to 7, but al3010_scales[] only has four entries.
> If the register holds a gain value of 4 or more, reading the scale
> attribute indexes past the end of the table and returns garbage.
> 
> Reject such values with -EINVAL instead of indexing past the end of
> the table.
> 
> Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> ---
> Found with LLM-assisted static analysis of drivers/iio, looking for
> table lookups indexed by unchecked register fields; the fix was drafted
> with the same assistant and reviewed and tested by me.
> 
> Tested on arm64 QEMU with i2c-stub and CONFIG_UBSAN_BOUNDS=y. After
> writing a gain value of 4 to CONFIG (0x10), reading
> in_illuminance_scale:
> - before: two array-index-out-of-bounds reports (al3010.c:137 and
>   :138), and the attribute reads 0.000000
> - after: the read fails with -EINVAL and no report is printed
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
