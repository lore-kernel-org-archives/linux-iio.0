Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79A2EB0F;
	Sat, 21 Mar 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774125915; cv=none; b=u28M8391fA71PPCEU0hsqHch3VfQiIUMwJI7+z3Z0ihGYhMe3Oyta67whug4VC8frxTVQtROawLBe8sMujKb/f9z1l8pWtnEtjHDfZ+s29Gx85dUvWjcNxKE22G+ZakXPr2Paaf9PAG/XsruCJnvXfQRLkTcnH4X+FR/8EJvcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774125915; c=relaxed/simple;
	bh=blGq/cFpG601EDXKpo+tYfOpQxubpuJa8epW03bcUfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nt6Ouovk1pebu+LVp5hXsM/8KZ13ukJ5qoCTpI0F91ISHsE0t3cy78uTQp4se2dSfz7HxRjP3QTX3IrBYCJ0PMvvmhPrSVofdSIaIsJlKuC09Svzal7e7L7kJvRTaWoxvu6vlSkbqIeE/x9tCQUg9jQkjwE6HXzTCplZ/RFLPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo3FNmlM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo3FNmlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4909FC19421;
	Sat, 21 Mar 2026 20:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774125914;
	bh=blGq/cFpG601EDXKpo+tYfOpQxubpuJa8epW03bcUfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eo3FNmlM4/3NWRn6Repz7C6lXnGASt+qobNHaI5VFgb/v5+As3ok7nVOfT6jKfTVG
	 kWbVShVg8wqwFh8QQyTkT/g9yPpzhI6RUYkqM8L+UrQmpG7IYGDxSgqrzYucG4lJC+
	 O/D1zjcYazT+p9ekWUzUYEMj94SJGke4cA8X7JfAIP2++1dj5Vq3JYkQQBCkAJCQu5
	 82Svwev+yv9crmrqyoiCkf+RvpPQtkvSnZ3KUOBGuzw8HeRETvoH4hs+8+sXAZnck7
	 bI/pUERmbIXtW8gmjZQCbAeBabhRoaiu7e93NrCtTFY5c1GDeXRLokpF4TGGfI886P
	 ZJIZ5QQrUTfnA==
Date: Sat, 21 Mar 2026 20:45:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matt Ranostay
 <mranostay@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <20260321204506.4b5df02a@jic23-huawei>
In-Reply-To: <abgOH5Zo6J9m8qiW@ashevche-desk.local>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
	<20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
	<abgOH5Zo6J9m8qiW@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 16:05:19 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Mar 14, 2026 at 06:13:32PM -0500, David Lechner wrote:
> > Add a DMA-safe buffer and use it for spi_read() instead of a stack
> > memory. All SPI buffers must be DMA-safe.
> > 
> > Since we only need up to 3 bytes, we just use a u8[] instead of __be16
> > and __be32 and change the conversion functions appropriately.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied and marked for stable with the following as amazingly enough I was
running a config where it didn't have this via another path so the build
failed.

Thanks,

J

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 833a636a29bb..be1cc2e77862 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
+#include <linux/unaligned.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/buffer.h>
