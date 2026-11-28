Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838186;
	b=xGURLzHioKLRTQxJzLbjRtgapjVIeHKLipxE8fK+K2uDMeyAmAvfXrW0EIDHN4xup6tS
	 1mXBvkdG0i4F4xxCkGYlbI3iy/JfcizdpYXiPYqAy1G8UG2zHgY/HjPCLr6yVRJBX9zCA
	 3DM23WvAFnbbV6Lmsmqrr9ryrGhAWjKBm4w0I7yUuyqgkBgsZ+EpLLsvqXD7Wn40/C08P
	 E3Uzya3gSdRsz0asZQdRWY/ym/zvQs02bp4g516d9/H9Ye/vujB5r6PfeCbHWeCblU7k6
	 1CyvH2oCFIevj8FC7Xj+s1DyvUtBBvW05bUxjaXCFvJptq6LmksRsaf4DzUGZSQrO4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838186;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P/MFraS/2L9mDCOI0wDYOF2006+rl3uVdKy1T9xtzpA=;
	b=IyBuhGLnWeHloVH7QbX1vjSRVPy8ByzKdGi9J0Qe1H/lx+xf6FkElJK4K1NEFjKO1XKJ
	 uHdN9om0oEFqxQO+XsLfuaINGpbcmh64Gx22ai3VvSlyEEZWfn8t6Lgnua3EJjNlQxQld
	 L2YjH8iA/fRai9RsFJgrjcM8Tl7DkJtILu9QE3zEvot0EdqgqnahAXGBNn3PmVOAUsbt8
	 Lfd8YmC3OXOgc8bQkYi1VO1RO0UrQKIkcwG6Du7XwbdUYEG7/JRLMwYVGtiss1BrbZ4xo
	 Td7yhUh8dHbzNcIEgUbHdHnfrkcjSAHdxntmygnrcg14Ll8BPSfsiY5u7p6LhT9lvzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mq8eKpjl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E69606A31C;
	Sat, 28 Nov 2026 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mq8eKpjl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3205E1F00897;
	Sat, 28 Nov 2026 03:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795838186;
	bh=P/MFraS/2L9mDCOI0wDYOF2006+rl3uVdKy1T9xtzpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mq8eKpjl7ue2dhzDNfRHhk2UrBXgopzCAWueSVNvVxA7M+FAtZgjcmKiiNgtuJYaR
	 1m0YNyBpuG/LMysXgoGgT9jJk9/W/uJEtVuGr/8FO40AeuWJ1nQSYBjBakgVIq5P/K
	 agyi7ZgZEAFVH1UMq6VM7j9XXAwUjUjbgoBEazZTu2Cc6VtEwM9sJQ1n310Bv42x2z
	 LWemmfJ/cAzhnW4E0pIAqhqIw70n6ku3Xg+p49sk8HdbU6vECZJEPPEYz/4sI8Lgfx
	 7fGYUlFLRXAvKoAq5lvm5p9IlrDOeEFlIHmug4IfT5kyP826hiH/JmV3ZzTMexzegA
	 4gFLvDA5HwDww==
Date: Sat, 28 Nov 2026 03:56:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, u.kleine-koenig@baylibre.com,
 crofts@kernel.org
Subject: Re: [PATCH v2 0/7] iio: pressure: dps310: cleanups
Message-ID: <20261128035620.686b01db@jic23-hlaptop>
In-Reply-To: <20261126121331.10438-1-zoone.rupert@gmail.com>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
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

On Thu, 26 Nov 2026 14:13:23 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> The cleanups promised in the FIFO series cover letter [1], plus the
> rest of Andy's list from his review of the ACPI fix.
> 
> Patches 1, 3, 4 and 7 build to the same object code. Patch 2 gives the
> same coefficients as the old parsing, checked on random input. Patch 5
> changes the wait after a reset from 15 to 55 ms to 20 ms. Tested on a
> DPS310 on a BeagleBone Black.

Applied to the testing branch of iio.git.

Thanks,

Jonathan
