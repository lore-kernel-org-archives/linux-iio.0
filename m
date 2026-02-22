Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31433ADB0
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771767070; cv=none; b=jPqJ2KsJWenLn3zz7E1TVsHT0SyGd+vMD94oHCrpPTRGE+BHtHDpM/yvVBoBzZbENuqyNT2rqO7ZrbyAZICzxSt0+SaiowEze15WgMfUALJFo+LV+32j8y1NSdS7cGAJOznnQp5NKZpRAojVoP83hhsT++YQ7StiSTrVcw99zJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771767070; c=relaxed/simple;
	bh=VVc/yeyiZtSzsOpxBkCEt0bDtzrGZy8Yuhty6sQQBSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbT9VZiYiBUqKBAvIsd/BFCpxePhihnuqt5/AdW9lu4pf+MG+EuzRrVDNyIdvGZrVYjr3uQ+0cuzgwMIRMFqkAGASppO9at5N5kJsxzYVh4JmXRT+Cq/SrFZQ7SqDtEVRhtr4OoHQ9pVwfOxghpOiDLBsu8HdvfN1PUTGcOIm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkrjeiyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkrjeiyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E954C116D0;
	Sun, 22 Feb 2026 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771767070;
	bh=VVc/yeyiZtSzsOpxBkCEt0bDtzrGZy8Yuhty6sQQBSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TkrjeiyxVVxBjEs49ijsvJZkPc4lbTMn1Yd+I5J/E2wzMRH9EDx9wVignByKij1NM
	 J7E12D9hYXKEsNCtDCJa0YCPBdZ50qIPozONFZLgmBGAYIt9yMS1E+ZcK0QxrT4QGQ
	 9au0IOP6RlaN3oUOaI1ejOnCo8t4pZ1LtPO3ZLJwT4eEkGokQetAoMDBgN87rAKzM1
	 zWkwmi8AOjVLcEPFeyOXqjDjNBviRihyG6ovuVFG3ay+YnW5fq6slfSvz7VCMuBsuz
	 UmCppSXf7jPEx9P95nMBnw+3nOpL1Vnu4S3DiHvn27hiBI8kkX79N9cDfaRrwgBxfA
	 2Lukr1W3Un5EQ==
Date: Sun, 22 Feb 2026 13:31:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: light: zopt2201: Reorder header includes
Message-ID: <20260222133102.43dd6d45@jic23-huawei>
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
I'll fix this up whilst applying to save time, but for future
reference.  This additional header is not used in patch 1 so
it should only have come in with patch 2.

I'll move it.

Thanks,

Jonathan

>  #include <linux/delay.h>
> -
> +#include <linux/err.h>
> +#include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/unaligned.h>
>  
>  #define ZOPT2201_DRV_NAME "zopt2201"

