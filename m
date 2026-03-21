Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76993330656;
	Sat, 21 Mar 2026 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121059; cv=none; b=ay39frVM/HbnPQk9Koi3m9CE1dOgF8eZKppNrl45aw6rhVNCLi+MC9JkI67BFj1GUaIFK5dzxM67W5HuF5IoLxDYR1zx3C3O98PSxHJY/LSbNL4gTA0YYyJ++4NsShYU1DUGr09q1qD4nX9G2Nf590c0dSybnK+AgobK1v+0kEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121059; c=relaxed/simple;
	bh=bSyNnAj/hquLeV3lzSOn8ZI6h51XxH4VqAJkTAD+sBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDsLfV2Sya/hVQd+UuicVrIC6Hr9I4B5tvtrlusmU4/+Ey4/IJYTGWuPpwLh1Kn8BX8A1YRdMGL7+7T5Ms0yArK5bt5wulhHTiWtHNKIqxq1bk1HjIaL0mpUG80419JbLxjgKynfkaR9LK0QvsAzKHSgE3QFw2HILOGT7BkPBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TePaq282; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TePaq282"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B027FC19421;
	Sat, 21 Mar 2026 19:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774121058;
	bh=bSyNnAj/hquLeV3lzSOn8ZI6h51XxH4VqAJkTAD+sBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TePaq282L6JSZFDHU+lBRJv+0Zi1ODSm0PHJd8t57wDCbQ7HzTX9Sk9RisawW6PrU
	 /svBA00Iv4Aju9vPHlKnPw3Rb9FE0xcYzbL2vnPPVsKU/VOHHFGltruSdFwunbUfcP
	 KBKQywwKppQaZJNf2o+mFIU3JkcpDzRWZ6eILNOjjFaIVaQyku0uKxFbpZZTnpjGWR
	 FNHqdDD1jqJWDg43zM0jGM+Hg3LPZsXI3YqBPjdGFdt73jTRhdl7PzRisNCO6ONmjQ
	 PqkZqHrJEbWyUtqfDlbtmNWl7Op6ewwM5+ieno/CSGoiyzDfwufmn9lKSv4jD6ktgX
	 6EaIDROz5zrgA==
Date: Sat, 21 Mar 2026 19:24:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Shi Hao <i.shihao.999@gmail.com>, andriy.shevchenko@intel.com,
 andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v5 10/14] iio: test: fix typo from neeeds to needs in
 comment
Message-ID: <20260321192410.1c372b20@jic23-huawei>
In-Reply-To: <9eeedcfc-a39c-4922-bc81-a91ba51e985b@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-11-i.shihao.999@gmail.com>
	<9eeedcfc-a39c-4922-bc81-a91ba51e985b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 08:32:19 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Thanks.
> 
> On 16/03/2026 11:00, Shi Hao wrote:
> > Fix incorrect spelling from neeeds to needs.
> > 
> > Signed-off-by: Shi Hao <i.shihao.999@gmail.com>  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied.
thanks,

J
> 
> ---
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~

