Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3885221739;
	Sat, 25 Jul 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785018280; cv=none; b=QOIFM8yYE8Oqe/vYJrXIqVtD2ZhQGGSpKfKNWM1Nn9FsxL9qApcFMOzkIjTks9CKcE/taGKWjUeP1ukoJAUb0bMhmNM3L2F9eMFIsXcZ2J8b7SeLO1tcUWShrcweuGEoz5G4isymJKUIQ7p8ioyaC+M8CQ4yVwN6j6KaHPtw9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785018280; c=relaxed/simple;
	bh=1lg2B1+hqw5WTlOpRbq+F9KuDJQGNbN1kQw25jbR7Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIrXs7gNEJncC0js5aYHpn4GFrhtoqYFdqhHuxe0UaZWvYQHuloOI948whl9+l8a7B8zl/akXvdDWRiTagv4+ucVzOvJ9/ybXeMYkLQjd18jr7zte/fdjXr8yGky6nDA67WjHvHr4GSbpDlNkwCJFvEW5cG3XRx/C5VRef0nHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhTqN5JR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhTqN5JR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335701F000E9;
	Sat, 25 Jul 2026 22:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785018279;
	bh=zI1Fz0os6qWy4FslM9JiAI8M6Xs9T908N+pSWxJAf5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WhTqN5JR4hfhwCUKAoPirjZ6f5SnxTfXW2Kbgv9dG2LA9dAcm7YEpKM/ce8dt1qJD
	 AlCTGZIQhu/bm2T7pfUVtYYp1GkaKjqVYK1w+sZSJb+lrGvo+8DlCbDe7ydb9HuwXf
	 fYXZP1guI+4E46ojgFVKjDly7gKLka2SCf0LFnh+BeFfWky28V9cG02FNo76xGWvXs
	 w2eRzFT20ecxO3l1b0qg+ifYvmGYwJzJ0oxtSSUaUizio2Uk91WvhX6XF8aCHfxTDX
	 l5w/Nxn6Ip0AVQNVDYJ08sNS34ThOyo0r6MnXoBZaQZMSgNiTUPYrTkPz2O6m0c4Co
	 fMGtCAdJHiylg==
Date: Sat, 25 Jul 2026 23:24:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 08/17] iio: core: add hierarchical channel
 relationships
Message-ID: <20260725232432.7a0d4292@jic23-huawei>
In-Reply-To: <20260722-ad9910-iio-driver-v9-8-459d1df5ac56@analog.com>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
	<20260722-ad9910-iio-driver-v9-8-459d1df5ac56@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 16:50:17 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add parent-child relationship between iio channels by creating a parent
> pointer field in iio_chan_spec struct and exposing a sysfs attribute that
> returns the parent channel prefix.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo.

One small thing below

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  5 +++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index aa9d6474edd9..f7e3048354b9 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -856,6 +856,22 @@ static ssize_t iio_read_channel_label(struct device *dev,
>  					 to_iio_dev_attr(attr)->c, buf);
>  }
>  
> +static ssize_t iio_read_channel_parent(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	const struct iio_chan_spec *chan = to_iio_dev_attr(attr)->c->parent;
> +	ssize_t len;
> +
> +	len = __iio_chan_prefix_emit(dev, chan, IIO_SEPARATE, buf, PAGE_SIZE);
> +	if (len < 0)
> +		return len;
> +
> +	buf[len++] = '\n';

Use sysfs_emit_at() for this rather than a direct write. I'd rather not have
to think about what happens if __iio_chan_prefix_emit() returns exactly
PAGE_SIZE().

> +
> +	return len;
> +}
> +
