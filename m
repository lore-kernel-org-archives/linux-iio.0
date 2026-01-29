Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E752441B8
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703390; cv=none; b=AuI2CziyV04090C0Vtho8ACXyBeQOgdHewN6UM66wDjhUTsfXPQtzZk/x1cGMkbJpBBh1JoeGvGZdS/xNzNKeH0tkFN7l28x4wSe/7waapEUqCbSo65HTHHnH2i+DvHeGxiMKxzfbDS8YnrY3sbJ63AKQpVGsZNvlALuqgD35hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703390; c=relaxed/simple;
	bh=WUF9ax9UdKCP1uCGy9j61UCfITg9AOXA+FPPyvtaCtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eseBp0AmgKO+3Dw/W6Q6u57JwxaG2oF9TnNho+t8VseAmzcaOcCNbU3V1ar5PnQGKg2Ob/JGrmm4x5blqX9KSsT93SgSMIfvvw5CXatyC7FL9LnZkfCbDGT5L+WI9LR0KwOQEWXyfAq/P7VJPpzfSQb2Kxyrv1+xvamMqI3PFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlBDlQ11; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlBDlQ11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE362C4CEF7;
	Thu, 29 Jan 2026 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703389;
	bh=WUF9ax9UdKCP1uCGy9j61UCfITg9AOXA+FPPyvtaCtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dlBDlQ11t1xlxYq0X/gN2SsQaVgz8Mv8v/D93QWijDSEUINPWKYSfVtGk9IpsIIlf
	 6+eivZ12c3ILq/ltS6R/MIbFkUlp80+2Kg1wqhP12/zGWJJMwajcqMGKS+LFyEN4U8
	 4t8kmTtwOwAdKHzbeXhQ4MfbwS/pYrRNMjEwSm6LYDgFaZYjSKiNIUwbxmmnpMcjwZ
	 FvWEkxOoiuDqM9UliMJVRl/fU7J3IHarrTdD0boV45Dd9tLwVZ3/bCdHBLQDWzna8k
	 skpDXcW1wxfYNW/AhqfS9eRQepN6TGRc7GHn+LqwiKCmUPIJ1RwJ3HkIp+EiA+t/5K
	 DPYWebnk9oGdg==
Date: Thu, 29 Jan 2026 16:16:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Menderes Sabaz <sabazmenderes@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, dlechner@baylibre.com,
 lars@metafoo.de, linux-iio@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v2] iio: dac: ad5360: convert to guard(mutex)
Message-ID: <20260129161621.7900dc11@jic23-huawei>
In-Reply-To: <20260128153221.327987-1-sabazmenderes@gmail.com>
References: <20260128113751.258219-1-sabazmenderes@gmail.com>
	<20260128153221.327987-1-sabazmenderes@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 18:32:21 +0300
Menderes Sabaz <sabazmenderes@gmail.com> wrote:

> Converting mutex_lock and mutex_unlock to guard(mutex)
> Simplify the locking logic by using guard(mutex).
> This removes the need for explicit unlock calls in error paths and
> simplifies the code by removing goto labels.
> 
> Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>

Hi Menderes,

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
