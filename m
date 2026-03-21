Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947E38D6BA;
	Sat, 21 Mar 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774108539; cv=none; b=srlsuEXWi6Yw9mL9buTpAgWtVMX8+FWv638lvu1XoQ28J2/LacelmKOD2XSWLwqr5PQbK5fOZsciXudCNSF4SMzf6+zp1VdETeJz7yT5f6F3wiM2WEgmjuvpY/97GlF/r0Qc54i8q9KetDAfs5NjuHvLWj7hnLf2cue/As1AFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774108539; c=relaxed/simple;
	bh=VaQ+jymaIkSr+qqYgvztyRfgwS1httzGJjcJpYuXUFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIlbS8yAg5Gi89P7aMSn2jZwE6omcZ+vDEBNCxJLUehN+KqrZld5ASsu9gBRwSjNCky0pC8hFXfQDp/hvJKzkzi+RnIyTOnV2JsL8a4LO5lIFaWMLeblRF8zs2p2yEPqe5i3EhIc9zu0fcJKpY2HKc0IkHrrOvy5YJt0SV620YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXNtXisl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXNtXisl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA88C19421;
	Sat, 21 Mar 2026 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774108538;
	bh=VaQ+jymaIkSr+qqYgvztyRfgwS1httzGJjcJpYuXUFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mXNtXislYpt5AgN1YT4WKzzFo17yISLzCPmblJP8xAlj5AFaPlkOw+W1EGLE6f2k3
	 ard6ObR+aIHKYPqDR3DgMAQASQSmdP0olNdZJsvfNhKoDQRVEGhn36q4dk+3DzkaPc
	 zOgxWnednT4czjId0HcRpgSv2vypjFZ8l5VorC54azriPyVSTNFynGudsHJd/e8EOJ
	 u3YHITCwGB1ldcA1HOIAlwZOo/KQAcqmbVZaWndXTFD/p5W8sj9KQ1J7+h8kpi0q1E
	 YN6EFTBYbjHdOlhiHYJScXw9eKWmYlB5jd4ceCUidcD8R1TGuFOIfLRcnRnV3mJ9RC
	 xeLWd5dhAxCgA==
Date: Sat, 21 Mar 2026 15:55:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Giarola <matheustpgiarola@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, matheusgiarola@usp.br, arthurpilone@usp.br,
 davidbtadokoro@ime.usp.br
Subject: Re: [PATCH] iio: adc: ad7280a: replace mutex_lock() with
 guard(mutex)
Message-ID: <20260321155530.27751a72@jic23-huawei>
In-Reply-To: <20260319184615.10970-1-matheusgiarola@usp.br>
References: <20260319184615.10970-1-matheusgiarola@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 15:46:15 -0300
Matheus Giarola <matheustpgiarola@gmail.com> wrote:

> Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> ensuring the mutex is released automatically when leaving
> the function scope. The change improves error handling and
> avoids issues such as missing unlocks. It also simplifies the
> code by removing 'err_unlock' label and several mutex_unlock()
> calls.
> 
> Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
Hi Matheus.


> @@ -885,13 +875,12 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
> +		guard(mutex)(&st->lock);

Scope missing...

Thanks,

Jonathan

>  		if (chan->address == AD7280A_ALL_CELLS)
>  			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>  		else
>  			ret = ad7280_read_channel(st, chan->address >> 8,
>  						  chan->address & 0xFF);
> -		mutex_unlock(&st->lock);
>  
>  		if (ret < 0)
>  			return ret;

