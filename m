Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC373F1678
	for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336211; cv=none; b=FHS864DirKgLozvCF0Fl6Hf4Ctks+Uyp/eFS+aQeZmL79tCFUYllHYa2sCMalnKSMun8QPkMN4YYFI52mQQveieLKv5T+3KCiFkFcxGfra8/5kTNb8MMRP3hosdYHiuEM2c5hpOzrFk8+JNgBdScY2bX5Qc/y5hRHo63Eaqrvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336211; c=relaxed/simple;
	bh=fJzBEsV+r2rsxHE7wtzfpu6HLOOVOkXN/h6IJb+JkTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiIDKl7LIPShqyvgvKNNrBq1wnyPF44ImSiCV0dLA6BymlhmffLL7III9+McLIcU1aswLOHmkEhVQiUjO9CSaZB626Lg7rdwC9mN3GKsvn9dulMMy3ewf2HgjMNQkpVZeJ+luFYqSMoLdJCGq/vJmEB0MBKKEBOZh3RcDFFQXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ60eEbX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ60eEbX"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47640541585so811978f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785336208; x=1785941008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d8oryUDvqGtQsqz51BYnQBJc1k4wLZ1+2yLF7stESiM=;
        b=BQ60eEbX1kStZvMdtr89prFtjzls9ZGgzJb+qrmh1dYt6MGlzNDJh5Q3WLfu2P5aTD
         +raW87PfuKPISl/oHa2vncnm9JGowQjJpgXCrNsNDkKO5tsIOJVImfTaYZYTqnPK0dK2
         IhS1ZuDTutF0KvzUz81R3W8iAdsDJkWnJSFJ4Z8gtrQrXWDjC1Y5osBieaDgpEV5Qa8l
         ASjjjO/EQ+1KkU1Ze8VKlky854KArm4Kkj2KDZSUit/BKjnZ30qQW3IEXU7b6joItx3b
         f2ZjpFUiDgzlisbHwGzz6p3dGPkPsUKT/Wab4mP7q4Rh3/EgYvwDApdYLyr2VUf4hrG/
         SFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336208; x=1785941008;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8oryUDvqGtQsqz51BYnQBJc1k4wLZ1+2yLF7stESiM=;
        b=lb5m/sk96xh0jxF52p8FhdRPLY9C8SejL/mOy+uMl/lLk8PrYnKOWKfxZR/hI7sAVI
         s85pXyYk2lnsFE6liMa1PfWfKooO97HXgHxHiYYSth6kHhOTjgqYp8e4Ba/A188kOErQ
         Wk+/T74nnr8D00oW3+xmJODaAFp8D6eRk7DeYFgb6Y9sf0qqZTKAgrzYKEesn/A80j0H
         dXjqp4/nKqKQLpTuxuJ8L+s9A2Tx2WI3jNzA4xjY2IUvBMNbHycjRB+kbr6lbrTgDnq3
         TcMwhmCKaU9b4UU8Pj2rCnRpdJYH767EADfInJHsuSM9sIXwntmAA/cWZYVuoVMp2FJ9
         Vtqg==
X-Forwarded-Encrypted: i=1; AHgh+RrQJU3UpsamIPuCL1fBYnQDJTaKnIKG98EIsOpt8mGTq5m43RX+Z6k9USQpJeKpmyflyCDrDMcutqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWxn9UvIj8qAuluCRQdJpE5hQpeuyfKXPlw+r6wJo4zh9XJoc
	mhWDKaHshmVAjYpLNpHDXihOHe8P+6d5LswQUFxYQZQ5QHHxjOoZiWSW
X-Gm-Gg: AR+sD10iLtrhHQAHDgUPOg8TPLgQePqU5rDAgm1b0zC4YnvtEta/aKdmXJq74db2x57
	NIHYi1IAnmLp1AkZVjbXM6fLYtIOe+OxgQtfxkORMNkNu24RcMv8fudOn2ezL9fEptYrAXSZ17w
	jIUhsysNRCLSsmI5PJE93MtgQCvzjA93BPtyDXRp1n2pjlnZ0sSY4zDy9nRaoij0YnOxK1y5hPt
	WKD8ZGVmXiAZA2hb1fQX1QarEVJNP3i8NJhiDGFhlABURXHeHDl5pQ1nsKsjPbPeZuJXCLmxazP
	ZAIeVOIswRcF2bihcVHnlJJ/NjN2GtnOaPrICElunxhppIVUgRcTD2JE7OXHoZrn6aNSVDwvxZo
	yHYsUZs3o6zIlKixToDPezBJAmDz7JfxM4X3HIBMUMZMcyovoI9nSUH0tC1bGCJOtpUAsAHX5HJ
	UzZ9tNNLuMrk5E2NSByLgnwbUsyyh2zsX6z1yA0FcWdCeqZuMV8pD1K04hoxykmmxI0uhMuH8Mv
	A7ivODR9NBLEp8YSKt7jCgdsbFSiqrYXmKf0Bi4mzI6WTuuU9JS3ydTPgeE1r4yMsFhEnINYUDN
	N1BnnMBDzmsOW4OVY8WXb/NW40OXY3i1WJvmvM8FhqUVn935T/dV7wxpcpdZnAZU11qDdek53H3
	ZG6Cc0gsit+Bfaw9eZiX0sHmK0JB+LELGSa/JxwRodGeT5pOGsChhPGwIBL4uBlgF2nWa8EM=
X-Received: by 2002:a05:6000:220f:b0:47f:4e42:669 with SMTP id ffacd0b85a97d-47fb1ed964cmr8993565f8f.22.1785336207932;
        Wed, 29 Jul 2026 07:43:27 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb647a8d4sm8618890f8f.0.2026.07.29.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:43:27 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:43:26 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v3 1/6] iio: adc: xilinx-xadc: Modernize driver code
Message-ID: <20260729164326.00005c44@gmail.com>
In-Reply-To: <20260729125455.95893-2-DileepKumar.Nagavarapu@amd.com>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
	<20260729125455.95893-2-DileepKumar.Nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 18:24:50 +0530
Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com> wrote:

> Modernize the XADC driver by updating the code to follow current
> kernel development practices.
> 
> The changes include:
> - Switching to kernel integer types (u16, u32)
> - Replacing open-coded bit manipulation with GENMASK(),
>   and FIELD_GET() helpers
> - Using cleanup and guard helpers where appropriate
> - Addressing coding style issues reported by checkpatch.pl
> - Removing legacy coding patterns and simplifying the code
> - Added MAINTAINERS entry for the Xilinx XADC driver
> 
> These updates improve readability, maintainability, and consistency
> with modern kernel APIs without changing functionality.
> 
> No functional change intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
> ---

I thought I was reading a cover letter and then I realized that these
are all changes in one patch only. Please separate this into multiple
patches, I count 6 separate patches.

>  MAINTAINERS                          |   7 +
>  drivers/iio/adc/xilinx-xadc-core.c   | 351 ++++++++++++---------------
>  drivers/iio/adc/xilinx-xadc-events.c |  53 ++--
>  drivers/iio/adc/xilinx-xadc.h        |  78 +++---
>  4 files changed, 222 insertions(+), 267 deletions(-)
> 

...

> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index cab66bb8cc1c..b468179736f7 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -11,6 +11,9 @@
>   *  - AXI XADC interface: Xilinx PG019
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>

Since you're moving the driver to kernel types, include <linux/types.h>
as well.

Maybe you could do an additional patch that removes the catch-all kernel.h
header and adds used/removes unused headers in accordance with the IWYU
principle?

-- 
Kind regards,
Joshua Crofts
