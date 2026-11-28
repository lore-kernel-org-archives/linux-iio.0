Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795826650;
	b=XVra9ZxoC9gXIa0yzOawSXZC+zKPb/Kl/bqgLoEj77Z74O74ugSMB9X7XbobUifVdLkY
	 gp1JeYUlMzbri70RHfA+eSPbx7Q63EurfYqcbWt+xbuUbK69h0usAdzxiyLs/Puv3hV1l
	 PIj99NIriPZMoV2sWlcTX3w7R5o++nfNmRe6lq+1/6KgVRwefCdHaOYV6Q/aRvRMR79/U
	 +kPRY7lmAK3H2+WUbsof2mnC0nPhKvjZyxJWoLmN2hcVsDbCtuayzUrwnEc4DZCTuHNnu
	 wxuAxErc7ft0KvmkwHZiDXeLBcCsxPyb5U+axsWrJzCPtzIZd0VknsmIFqdFW0n12sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795826650;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WKpKDGJ5bqwi4+onnFhdjWoyhLzJc7goF1DBibD6Ljk=;
	b=EL8VvawDngDpakH3+0Nnuk/0d24JnebK+Af0lZp5DCNcmijV/uHTm+R914n37eItB8Px
	 CAJcqvUTgZEayYuRTkB34P0LtzmfLxLDcExlk1zNYnv2K0ZbbzZQF46jzVR7f7GUqYqMp
	 4qOmjUOqtgJ9mSWFDnY/GIg/ztFQPdkkIYsDP2wogzcTban8SbbE8960dwmfFrVbuKaBH
	 ZCjXUHdB2okpBalMrVlVUsQr6Fnw8tXyIjqIG5mJJr9ExyMCVaY4x+TYkKOmebqRSxPj3
	 K45Q1VOkmLXAm0EpibgGT6KSqANiF+HUs9q0cXoA1eFDB2L0UoxVVI5XE/gjw5V6o3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUf+rSFB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14073606A31C;
	Sat, 28 Nov 2026 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUf+rSFB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B481F00893;
	Sat, 28 Nov 2026 00:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795826649;
	bh=WKpKDGJ5bqwi4+onnFhdjWoyhLzJc7goF1DBibD6Ljk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jUf+rSFBfdpCWacexF+RZ1nP/EOuMN/0YorUG/G8Yuy5kIcjCl5EzoWQsOAVXgmas
	 ND/myrjwfYomKY2yxty7Hgcb6RoKSWZ13RDfyVd4qyDP4mO5vKDX/0tzObNl9m1VLn
	 ICjKbT6/yAb6iJ+c5uhkM2JeES7OSJo3/Tj2q9Se4DCoFjRASqLb5zFyqomAvKyXwu
	 lYTMEq1afrRiCySGnSvLnMq1XtwNFNfZVLbhGFD1UGaOD6Fi7W7OB+qJzCN7UHvgiT
	 OakJ8PyfltVlAXXEmFzFerzJcOFhtM/qCd/1xqzuJJGt7xIeuPhd1ee23LwUNarEBp
	 +6I9TLMoSWYtQ==
Date: Sat, 28 Nov 2026 00:44:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Chen <marcochen.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, pmeerw@pmeerw.net,
 matt@ranostay.sg, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 0/2] iio: health: max30102: fifo_ready() rename and I2C
 error propagation
Message-ID: <20261128004403.08596c50@jic23-hlaptop>
In-Reply-To: <20261127182636.83803-1-marcochen.dev@gmail.com>
References: <20261127182636.83803-1-marcochen.dev@gmail.com>
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

On Fri, 27 Nov 2026 13:26:34 -0500
Marco Chen <marcochen.dev@gmail.com> wrote:

> Patch 1 follows up on Jonathan's comment on the NULL-dereference fix
> and patch 2 returns the actual I2C error from max30102_read_measurement().
> 
> All patches were tested on a Raspberry Pi 4 running the IIO subsystem tree
> testing branch with the max30102. The module was reloaded and buffered data
> was correctly read, with no errors.

Applied to the testing branch of iio.git

Thanks,

Jonathan

> 
> Marco Chen (2):
>   iio: health: max30102: rename fifo_count() to fifo_ready()
>   iio: health: max30102: propagate I2C read errors
> 
>  drivers/iio/health/max30102.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d

