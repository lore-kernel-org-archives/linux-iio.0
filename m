Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B81B6D08;
	Wed,  5 Aug 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890327; cv=none; b=cmI4Zq3wvFk34VhGxmgWVyNavWcX7xI742WV4OZYe2LjWrXE+kulgQ+E8T2PRWKJNepBALzp7DLaqFiFm5xQtxck4Cqd2uYiWTxZffzIkNCpJP96BgiOMDXGHFf33jn+Nm57crYvIsAjVENflWlS+2gdbfL4ILCcT6EuezD+KG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890327; c=relaxed/simple;
	bh=ePfLhaYAUCM6ZCNFauWpbuqo7Mh+s/8W/fPF6rUloO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYo11jNhVkiyM3MESMvMwUh9io/49rmj/MAdCSV5KFcL0SfcW0XesrrINa39ecwnr7hMOjun2KBxpj8iqJH0zejVhMz9WF9m4u+eP5nt+hxkDxXBg0uZvS9L7NYXIynyAQy1Im2/phJK8Q9jp7lrnm3jIMN8l12pt3XTNRfFLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOhnKpPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOhnKpPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A8B1F000E9;
	Wed,  5 Aug 2026 00:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890325;
	bh=xwWhxSFvLCrAUwUCJ+/6aXjbM/H8cn7WFr737NnKdX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kOhnKpPBPhfcceK4xplZklrx2yTbvA7rih4xFdnm1XalpUqizU54/L64dthiGTCU5
	 x+2ahrHGwJS3RppA1jIDB1obkV4xlwnBDkUgPcyEn8RpUhH3b3KsuTmIAve5CjnS1I
	 9+TBlimr84GLFij6q672vaNgQRcU2GdOxYRDyDYGuVbtLV0nxWk98NAXcmESw2yGdH
	 zsHcBFPtGBbNjcWXkoYkYLFY2/v26UC1a6wLHQYb/PD2gA6nykJlV+KEq8IzdxIeBi
	 r4iEWl4b9p48F6JesS9ozneQ0wxYQ1ugiriXjePPETEiVZ3O0upDEzpSm7Xh9aiPPo
	 iwecQpkfIdmEQ==
Date: Wed, 5 Aug 2026 01:38:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
 <joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/17] nvmem: add DEFINE_FREE for nvmem_cell_put
 cleanup
Message-ID: <20260805013839.1c4d10f9@jic23-huawei>
In-Reply-To: <20260804113338.261782-3-varshini.rajendran@microchip.com>
References: <20260804113338.261782-1-varshini.rajendran@microchip.com>
	<20260804113338.261782-3-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 17:03:23 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add cleanup.h helper for nvmem_cell_put() to enable automatic resource
> cleanup using __free(nvmem_cell_put) annotation.
> 
> Use IS_ERR_OR_NULL() since nvmem_cell_get() can return error pointers,
> and passing an ERR_PTR to nvmem_cell_put() would cause issues.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
https://sashiko.dev/#/patchset/20260804113338.261782-1-varshini.rajendran%40microchip.com
Has a question about whether this should be available when
!CONFIG_NVMEM

Seems like a reasonable suggestion to me given nvmem_cell_put() is stubbed
out.

Jonathan

> ---
>  include/linux/nvmem-consumer.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 34c0e58dfa26..35a2ea8b8957 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -9,6 +9,7 @@
>  #ifndef _LINUX_NVMEM_CONSUMER_H
>  #define _LINUX_NVMEM_CONSUMER_H
>  
> +#include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/notifier.h>
> @@ -54,6 +55,9 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
>  struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
>  void nvmem_cell_put(struct nvmem_cell *cell);
>  void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
> +
> +DEFINE_FREE(nvmem_cell_put, struct nvmem_cell *, if (!IS_ERR_OR_NULL(_T)) nvmem_cell_put(_T))
> +
>  void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
>  int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
>  int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);

