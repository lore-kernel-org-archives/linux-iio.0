Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C474503B
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771767257; cv=none; b=MeGcUWZruQ1W45sAlJtIKxUO+o1JFIOHNeQK990nPvaxjgcAz/UU3QDIORbYEumBhOfocn+7PcjyYLcmAu41Ak6KeFaDhX41FeCm498p0Y+e6OQqi2RWxKHcnb5vW/8NANPaTY3XAO6j4CUelkftuv/kRtK+dVrH3PDy5hX3oDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771767257; c=relaxed/simple;
	bh=GkNGtMg6ZdwX1mCQEVE0b6VYTTUT/12W8kwYM66BJ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmZem/jSlOx79S8Fhg38UKQl4jQ9RKiXDSdZVySIU406Um7OnNLLfJSExHB3VSDED+lkaQmCUkLcMRUrjRmxPh1UGpWz3fCWKvA4EOlxHzIriQmDs9WL+9bz5UrnZaeJi6QxS8pfFiDZZ9JzhFg6fqsQpsdt1K9qcqWBJt7d2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVVi0lsJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVVi0lsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF0FC116D0;
	Sun, 22 Feb 2026 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771767257;
	bh=GkNGtMg6ZdwX1mCQEVE0b6VYTTUT/12W8kwYM66BJ0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVVi0lsJ4RcGJ4xkdjK+xcLItEq4vYBIegT+Au273dKeYgsXijZLUfgfY/g6Hh6VB
	 WiDMzYl93f+RZImf7xLBaynfEhtI8n3nKEK5e0mvPjnetR2z7RfnDWdj6BnnalmzHz
	 zNURqFC8pg67DuCbpUFSu+SVHJCQcqhIITDQGJfHebyCmdAk185jfedVHi/6GwPlXG
	 zt6Q1zEY75iEsKLA4Qrg8yIuys+yXd5BT54o+4NBWNYs4jdFDc3VKpzZ8K9biqdZx2
	 eG1PQDAx2pcfCro2g/A3l8+fWVNA70xHokFJtQ9g8bEDTHiPmFi0PaA1X50SLzmpN1
	 SwXMsB+F9Clyg==
Date: Sun, 22 Feb 2026 13:34:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: light: zopt2201: Reorder header includes
Message-ID: <20260222133411.6e026cb7@jic23-huawei>
In-Reply-To: <20260217143157.132799-2-gabrielsousa230@gmail.com>
References: <20260217143157.132799-1-gabrielsousa230@gmail.com>
	<20260217143157.132799-2-gabrielsousa230@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 11:31:56 -0300
Gabriel Almeida <gabrielsousa230@gmail.com> wrote:

> Reorder the header includes to follow the usual kernel ordering
> conventions and improve readability.
> 
> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> ---
>  drivers/iio/light/zopt2201.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
> index 1dba1b949cc3..3192aa72a0fb 100644
> --- a/drivers/iio/light/zopt2201.c
> +++ b/drivers/iio/light/zopt2201.c
> @@ -10,15 +10,14 @@
>   * TODO: interrupt support, ALS/UVB raw mode
>   */
>  
> -#include <linux/module.h>
> -#include <linux/i2c.h>
> -#include <linux/mutex.h>
> -#include <linux/err.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
> -
> +#include <linux/err.h>
> +#include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
Actually I decided to do a bit more.  A common convetion
is to have the IIO specific headers in an IIO drive in their
own block.
> -
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/unaligned.h>
This ended up here just because of a global replace of
asm/unaligned.h with linux/unaligned.h which should really
have included moving which block it was in.

Anyhow, tweaked and applied

Thanks,

Jonathan

>  
>  #define ZOPT2201_DRV_NAME "zopt2201"

