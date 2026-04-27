Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AD3002BD
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284539; cv=none; b=WkPjV2mQ+jLouktu9xFTI7uKsAHLS5kueWFiN3iRAFEWMtiVB/G6ZcxSSGruf8NAEz3N0kUTxSO/uuvcNB7NzvxGVVu/KkA7Mz6cmTwQZLrrN/cruOH5qSPTNaAoRnHV/Obuvj2vtGIlN1l7ClCmv3MvRHE84jEbwc1GuOJZF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284539; c=relaxed/simple;
	bh=/mPQLeHupRSRLsmcAjweHGpm/avj6Qhw5mgYiS669Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDSkU6KhZQyTA/9UtAppd1oVqWlTYxuywlJI6DYcRif7qi5zUQirTMThNfbIMhneq6b5dloERrZ8qZnAjqWvcwEDJ/ekuBpfM20qTIAUC7/3jmHD2MPKe0Ya5t4iEES0XplWbniT8whY5TMi8WPVhgeZf50RP5OPJk7AzXI6ZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwwLHypF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwwLHypF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4E8C2BCB4;
	Mon, 27 Apr 2026 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777284538;
	bh=/mPQLeHupRSRLsmcAjweHGpm/avj6Qhw5mgYiS669Nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwwLHypFL3Vu7SN74THQy72oh3hKaW60ohna3WTxkcV4aemcVBdKHiQZ9LUsA0H09
	 W6ZynK29DFaxpTcaJ5Gc7QVz2zW4o9fcHZkiVIdWJTcams8sntT2z9ycbNCl3QY4mY
	 wv0X9hM/f7YXvFFJql94zMgNIgXw41AyW1fNTG2Tdm6k3qejyqWBgQBiEjMQw/nzhM
	 KLFGAneJIP7DHwuE0dvtF32r+Xze0wPW1cwX3xEayfxfWM54V1RpTLjS1wX2VEG2w/
	 TD/Jqbn+ZYxvACqdEDN7YYH6r3XRGPya76okYZjoCWppQ5EGvSjLf2nPV3HzNcSeSR
	 sD9gjlq2xiodA==
Date: Mon, 27 Apr 2026 11:08:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Caio Morais <caiomorais@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, michal.simek@amd.com,
 nuno.sa@analog.com, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: buffer: industrialio-triggered-buffer: fix
 includes with IWYU
Message-ID: <20260427110849.44bc83b3@jic23-huawei>
In-Reply-To: <20260426211834.3318306-3-caiomorais@usp.br>
References: <20260426211834.3318306-1-caiomorais@usp.br>
	<20260426211834.3318306-3-caiomorais@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 18:18:01 -0300
Caio Morais <caiomorais@usp.br> wrote:

> From: Caio Morais <caiomorais@usp.br>
> 
> Signed-off-by: Caio Morais <caiomorais@usp.br>
> ---
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 9bf75dee7..a91d439d7 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -4,9 +4,11 @@
>   *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/export.h>

Why?  There are numerous uses of EXPORT_SYMBOL() in this file.

> +#include <linux/errno.h>
> +#include <linux/linkage.h>

Wow. That one is obscure.  What needed that?  

For these, IWYU patches, I prefer to add that info after the ---
so it's easy to review them without opening the code up to take a closer look.

>  #include <linux/module.h>
> +#include <linux/stddef.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>

