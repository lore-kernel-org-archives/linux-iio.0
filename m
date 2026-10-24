Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807331;
	b=ZitaY34t768N6q5oEjdykbACWFGX2ByW9sll+51RBJOWBsFEaqPX0g+VBXXM4QgYpUiy
	 R8LZEpoT68Gf7be1ZBw35Ahn14I6z0dqIU4GsCnBovHBtKcMz5MeCVdc8rIM2sftyB1OS
	 BfzKtZDBT6kpGMatoQvvCKJGI4C961lx3wAWfut6L2rA64stOPLrbZIHOVvYcZc/W6vSg
	 r0yr+FBlaAYAFUPt4VDH7wcsBx2qQQk2FA++RcZgyJS6ZFFXV14em5Dd4kmdyXeXcYaIh
	 C7DZJ3KWu9kSnWzOtAi5XaGQSgsFrUiz7lIHhjxB5s4nTqbqg8Ya9mmHgzKnBseQRKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807331;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ko8HbQkUxJ3WYE4XEMFhbEJ5Im87vvyQeBfDmnTXtAw=;
	b=x1iksKvlnnS3NTBvP0hrMk9Rod+9CsjhXKy/TlYS0BWpGFMurNW8nyy3jm5eSb3WGjDx
	 n62oREKg2+wQVSacMoO0dSlBL1oshPIL2hd53rCmbSkt5f2cyumAy6NFacP6YT0/fQ0op
	 bOa4x+NBNsGUy9iiSw0fl/ta7A1kugGO5JifuO+6ej/7mBIbiXGuz0WX9bd7UWxRb91Y8
	 gUGHnqelzlAlqi37fQ3KhsJqVWgdqhfZoUCLBDHqXUcEtFFI0ToMJdLMxq6W6t6La+q+c
	 4amuW0+tjEwkrrpd9sfjN5Ie/xK27AA0t+XT6i7mNdFE/OdRv1kqYLaT1hLSHuRZkcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgpOyvb5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30946606A31A;
	Sat, 24 Oct 2026 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgpOyvb5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4161C1F01825;
	Sat, 24 Oct 2026 02:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792807330;
	bh=Ko8HbQkUxJ3WYE4XEMFhbEJ5Im87vvyQeBfDmnTXtAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dgpOyvb58/6uYgwj1HsgLsLOf2E3ABQq2kfWt95MdOXwzKYUT/mVy5dZObWSZY5pm
	 V3qVdr0WV/kFLojIfrn+vDYC6CPWgObN1Ci6alxiME3R5lejRGAIoKN91We33XnfWu
	 WzfrhonImIs9fnHTl9Fv6ZQ+Il8pSABmZxu78kHkv8X8Uez6czjKEb9JO9K/H9mIM1
	 FDTtXJrD8yLI6HX0xcqV9hUFgNxWNPqyVY7Qyzkf1y4eCtwR/bXd7jZZQ/XPwvGa85
	 kJsgrtb3JX9N3HZJR5euYDVw1SbFWKz0Mys23LLIkRdAO1RBQ6QzfmsyD+N+2ZJ+Yj
	 M5MA+zoVIpZMg==
Date: Sat, 24 Oct 2026 03:02:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: joshua.crofts1@gmail.com, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use named initializers for temp
 in hw_info[]
Message-ID: <20261024030205.1ed973b1@jic23-hlaptop>
In-Reply-To: <20261021183823.169199-1-kapoorarnav43@gmail.com>
References: <20261018000924.758186-1-kapoorarnav43@gmail.com>
	<20261020095936.00002ff3@gmail.com>
	<20261021183823.169199-1-kapoorarnav43@gmail.com>
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

On Thu, 22 Oct 2026 00:08:00 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> On Tue, 20 Oct 2026 09:59:36 +0200, Joshua Crofts wrote:
> > Your patch fails to apply, please check it out.  
> 
> Thanks for trying it. The patch is based on iio.git fixes-togreg, on
> top of commit 2b8d4cd20ac8 ("iio: imu: inv_mpu6050: fix swapped accel
> and gyro startup times"), which changes the neighbouring .startup_time
> lines in every hw_info[] entry. It applies cleanly there, but not on
> togreg or testing, which don't have that fix yet. I should have said so
> below the ---, sorry.
> 
> Jonathan, I can resend once that fix has reached togreg, or rebase it
> however you prefer.

I'll hold it in patchwork so you shouldn't need to resend.
I tend to do a sanity check on state of patches ever few weeks that
picks up things like this.

But feel free to poke me if I seem to have lost it.

Jonathan

> 
> Thanks,
> Arnav

