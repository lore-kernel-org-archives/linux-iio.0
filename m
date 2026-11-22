Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380737;
	b=ewyGMV28zHeS33ywtdnmtS8OcrYqBBFF2l2r2x/cTUUTwf6D62crGVjAZ0s2pmL01Kgm
	 ITy8ClZsvH/6lq1xPGS2jX6QXxzsuEZad01Lp2vabJonX5Y6/Q7MxeMUfjN8BbMzZgWSr
	 A8UQqS1SiqM+8JFgqaAZerVIF3wH8u3EZO/iRfeeR4CWz7QTeHDeBMFbDN9zQde/pG7s5
	 o5WK5dAVUcbga/yw7XvW8VZYE1R5HPMq+KDztLiuZGv+uID+fKOgZIqDZewDvT8X9yxAM
	 TYfRezSIe8iwd0kxdLDhE3Xvyps5tq+VnFdUZc/1R38rVmJFyMved/XrYs4LnKaOb9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380737;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tuig+EQ220c3fmZpeomydXlRxIvrkJI/xod76DCTEhw=;
	b=1kJaV3+pRw3AOK7MiY2Fb/8WxZ15AKjwnpmW+lFRee30ayioe/N/jDgPUSQ5LUmE5iJZ
	 8tgCJD6hfbwyhYSPYwdFF2pNq5a4tm9aNktmlg7XfFOiyZrohaGZnep9dvIf+UeOkFuzO
	 CRBuIdzrYZO++FCUggurAqu+O7wQ2wCHmPlONDbWCqgAmAnAcBGCWLjA8iylPQx7PD7nq
	 /RdW0O+ujkUVFcQ53G8SnasNnm9XTbIyJBMBRRAKsybciM6Edarfvwcmq/zsoz50iL3eX
	 JAioBe+nMXoApZZDhdWMjcBgrTkVDBrDJEzU3crfeXJxyNUWxK92+XORHPQ4SmPoHFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUfsrUeS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC5606A32C;
	Sun, 22 Nov 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUfsrUeS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30591F000C6;
	Sun, 22 Nov 2026 20:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795380737;
	bh=tuig+EQ220c3fmZpeomydXlRxIvrkJI/xod76DCTEhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZUfsrUeSrKt4g0u/yUZljTfb2NYx5jJqhnjwTXmJMSrCzitPNYeUim1UDJAyFrKB0
	 +iZIm5zz+VjHFsf5NpDPM6123aiVw7DYpJSqnt7X3YUxHNCWVi7oT85L46GG2SMYYe
	 Ij+j4ROEvvYEK2nw5x1Z2nf8vQcC1cZKcsu+9Dy8UdLqJ7pxfQZPtbJAgzt2EQbeMC
	 udG9ZD4IHT4CTPcAPioEWDVZRVuyelBCxrooh0eeoG80YIhy5yixtJWj89QWn0Y0N1
	 pjl1vqKlXXVp6zbLVwBv0Pbj0+VYOlwIDMTY3KfXNpwETrEnVHrWr8sGRSfHOwCuso
	 3IAKrnQZGbGug==
Date: Sun, 22 Nov 2026 20:52:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Frank Li <Frank.li@nxp.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: magnetometer: mmc5633: Enable the VDD
 supply
Message-ID: <20261122205211.6c46f3cc@jic23-hlaptop>
In-Reply-To: <20261122190836.66111-3-gerard@teslabs.com>
References: <20261122190836.66111-1-gerard@teslabs.com>
	<20261122190836.66111-3-gerard@teslabs.com>
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

On Sun, 22 Nov 2026 20:08:35 +0100
Gerard Marull-Paretas <gerard@teslabs.com> wrote:

> Boards may switch the supply of the sensor, so get and enable it before
> initialising the chip, and wait the 5 ms both parts need after VDD is
> valid before they can be operated.
> 
> Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
> ---
>  drivers/iio/magnetometer/mmc5633.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
> index b651f01e1b5d..79015c7984de 100644
> --- a/drivers/iio/magnetometer/mmc5633.c
> +++ b/drivers/iio/magnetometer/mmc5633.c
> @@ -27,6 +27,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/time.h>
>  #include <linux/types.h>
>  #include <linux/unaligned.h>
> @@ -64,6 +65,7 @@
>  #define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
>  
>  #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
> +#define MMC5633_POWER_ON_US		(5 * USEC_PER_MSEC)

Obviously the line above isn't great on this, but is there a spec reference
we can make for this timing?

>  
>  #define MMC5633_HDR_CTRL0_MEAS_M	0x01
>  #define MMC5633_HDR_CTRL0_MEAS_T	0x03
> @@ -472,6 +474,12 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable VDD regulator\n");
> +
> +	fsleep(MMC5633_POWER_ON_US);
> +
>  	indio_dev->info = &mmc5633_info;
>  	indio_dev->name = name;
>  	indio_dev->channels = mmc5633_channels;

