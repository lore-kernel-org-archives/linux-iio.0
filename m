Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795298627;
	b=B7GbB2w185pOp2lgXDhLP0U0Gx4IkEBBTqnlCSmpAstp4WwMDlpM+B2q6xIi8H1XM/L9
	 b9B/tdHh1nAe2kZA3HXdNZXzyKS6QX+1H+J13/wG9WzEqYKYwAUmREwBdOu/uOoNlFsor
	 bx5tdkqHtQXE+fPF+Z7xYLPKWcNFOOs9lLDosn45zj8tcAj2CksXKIiREmPfCJY3HjcCs
	 aFfBhcQGfu/m/3+ht+Cw25po5H2l08bynaHkX4BgBaSJNiyWVqFEoWOD7HmEWYBqxQMVk
	 rSi68U8FZN2G0FnxXs3BhLwKyGqiJH9Vfpbf3Wicupd770bkSZ/jnjB2mcL7uuT3gMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795298627;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K54RN0g3ALCE6A23+y6+sSj/LArtjLvL+zgPgDjkwas=;
	b=cSJJYiyhQ1B/c+eJdpc6mPwEIvWQBLRZxkbkqlSZGHkgbS/8/XmEMS8c5jXoZ1nlz/na
	 02nVF45elfnpuarBTZmP6dtRpMGmV1qGCcrrV7DyGgz2nXLRBYNzugxL3W/Gradn8ZsjU
	 SuccuvKSB6+ktcB+d1vzR00wpHWeAB4J+SuMoRps+Sex+1YHV0cCscecCmfcOb5LCUOb2
	 WVTZMe0Hh1XSB+OfFG0hW4P//sUttyaGbtKcD4VXrKtXuL1dA7XNIjQNqfr6CI6JvAYye
	 0wdd7+MPntRBKqLLPLFkOKPCoCH75tA20+WnA6TazRJLY0ZsCXkbfng1i6PcSNB7BgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsE+nitq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A9606A320;
	Sat, 21 Nov 2026 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsE+nitq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64CB1F000C4;
	Sat, 21 Nov 2026 22:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795298626;
	bh=K54RN0g3ALCE6A23+y6+sSj/LArtjLvL+zgPgDjkwas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LsE+nitqdxu4cAxbovGUhYL+1gHa6wr2/i4KfG+wDItXAAqsFdIXhgk7Ckl+/BAdD
	 lHDL/qb/DyOInFSECfH5fPIeFA3HD7JTzOJKbDYObl5ONfpVtHtV9c2Sd9J8u9K/ck
	 VkrxHcpyQvJZWjKrjRZHeeR8Je8DZcKG4lz7lTmwRL6O4nhmLoUtyjEWnLCjOJv8Bm
	 E+oSfSgwoXFtwjG0phVCN5wFafyfsryAoZE6xguMCTSOvD/5hCN/nzp3BnWDPAC0Kd
	 qL3Mg0+74tOYfsNAsVQQqUP9U8bEu/mduGYNxcUQ42MYO3CABpB0lF4JKdSuE3R9XP
	 RezsK+si/QJCg==
Date: Sat, 21 Nov 2026 22:03:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Siqi Chen <chensiqi@uniontech.com>, nish.malpani25@gmail.com,
 crofts@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: adxrs290: propagate chip ID read errors
Message-ID: <20261121220340.28e27b3a@jic23-hlaptop>
In-Reply-To: <awAVgtU29mPK_10d@ashevche-desk.local>
References: <20261120025754.4075038-1-chensiqi@uniontech.com>
	<awAVgtU29mPK_10d@ashevche-desk.local>
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

On Fri, 20 Nov 2026 11:40:18 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 20, 2026 at 10:57:54AM +0800, Siqi Chen wrote:
> > spi_w8r8() returns either an unsigned 8-bit value or a negative error.
> > The probe function stores its return value in a u8, truncating errors and
> > treating them as unexpected chip IDs. Consequently, an SPI transfer failure
> > is reported as -ENODEV instead of the actual error.
> > 
> > Store each result in an int and return negative errors before validating
> > the chip IDs.  
> 
> ...
> 
> > - Move the OpenCode disclosure and testing information below the
> >   separator.  
> 
> It's interesting that the other patch without this amendment was sent just
> a half an hour before this one. If you get a comment against one, check all
> the rest (at least for the same subsystem). Always.
> 

Applied to the testing branch of iio.git.

Thanks,

Jonathan
