Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224348;
	b=bJb8kj+C5jgSdO3jd5xqqAg6cVoV2SJ59/eQOWXgUKgmH5rsYuvBDmq3Ogh2OgOM9ynr
	 b7359GmpC1rqfkAf7frOYScRs+tbeLIpKEwH3hryRK8WKGJKyLBVgm8cfmuhJjQAV3Hfe
	 AzDo3kNq0NLZtpjc8HvmT4y9vF9ENBShQv1vjZ7NP/WdXNMfZ2+CXS8fJkcfs7NEZrygF
	 1Cxg7wig+sVi3sgf0lQwkeY5mPiKMc+7PJs3XaWHcHZ4a/F6kIIe2IZ6qbkM6SRsVUnIP
	 uxpfNazyevjBpVHeXATGFG9x5py5lsos6Md3g36pi20KRvV5cRLoXt1lmNWZFXBO13Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224348;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=52C0mGXDL8C+9F4YtYqG/JuH/nLnrJPatUebsyl9nIc=;
	b=1JrP8+vhLMrEwuzU2yK4c1179Y1i8pxuIBUYC2VXbQB31dRSPsnUQ/GQTqlZk4soL3Eg
	 tFISDO6UqxnywajGPeZo5476PnF0ZVFPc6dBJVFDMmmLQ0fgkcfBqF9oOuLI/D3V3zuUR
	 5Y9YczabjTQWMII8xOObBTfJwWT5xjlacJIMnXg6pbYpSf4WMz9Ypg7JKgYavATpXlV8e
	 XP9vx7GCxurxHpTPk9Ahcpk/uxZmGyKcIsy5SsGYqMF1iZR5AOntlmuN1NcVLCoPjOalC
	 lWiy++yy5o+y7xtmnjgwFphHHlnY555MdQ8vs8o7JD2CZtgeEKnGsWSJqaoml36ONkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwOaaJih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E66606A6AE;
	Sat, 21 Nov 2026 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwOaaJih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC271F000C6;
	Sat, 21 Nov 2026 01:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795224347;
	bh=52C0mGXDL8C+9F4YtYqG/JuH/nLnrJPatUebsyl9nIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lwOaaJihsH2JvmVbfJObnUIlT0OQqitf1Xjq2pcO9GTFNsiNF1G83XCCOw5YdStNK
	 QvbsK8XLV3EguNejPQ4QvpXZRj4uSKc3se1u0wZ1Mene9KE7CN7ejf6IYqR6FbOBWx
	 hcwilFC0JhKh3xGY/i9cpySKrY9Zai/wVELaAl5X/5dx5Q2hbTS7dubqQnV6TTwSm9
	 YSEiwUBrJHviByDvv4oIihqHAuVLThuMYQssdOPCq5IiaxvhXhdqGa4shCTEbBkyTs
	 En2lkpYUEWloHljNOcfDZPMM0QSour93th+iVo/CCaaLSiAtY1ZD9xQDNnSsmIPZlG
	 8gXEoeN43IECA==
Date: Sat, 21 Nov 2026 01:25:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/5] iio: core: add struct iio_chan_attr and split
 attribute creation
Message-ID: <20261121012542.3beee3c9@jic23-hlaptop>
In-Reply-To: <20261120-iio-core-attr-review-v1-2-05b41f8133c2@analog.com>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
	<20261120-iio-core-attr-review-v1-2-05b41f8133c2@analog.com>
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

On Fri, 20 Nov 2026 18:03:58 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Channel, event and buffer attributes are all created through
> __iio_add_chan_devattr(), which allocates a struct iio_dev_attr and its
> name, and only then walks the attribute list looking for a duplicate.
> For shared attributes (info_mask_shared_by_*, shared ext_info and shared
> event info) every channel after the first one allocates the attribute
> and its name just to find the duplicate and free both again. The
> function also takes a buffer pointer that only buffer attributes use.
> 
> Introduce struct iio_chan_attr for the attributes created by the IIO
> core. It embeds struct iio_dev_attr and adds the channel spec and the
> list node, so that the core-only state no longer needs to live in the
> structure drivers use for their own attributes. Other attribute types
> can extend it further.
> 
> Replace __iio_add_chan_devattr() with two steps:
> 
>  - iio_chan_attr_prepare() builds the full attribute name on the stack
>    and checks it against the attribute list.
>  - iio_chan_attr_add() initializes an attribute allocated by the caller
>    and adds it to the list.
> 
> The caller allocates its own attribute type in between, so the core
> needs no size or context pointer, and duplicates are detected before
> anything is allocated.
> 
> Also add iio_attr_show_t and iio_attr_store_t, so the show and store
> callback prototypes are not spelled out in every helper.
> 
> Event and buffer attributes are converted to struct iio_chan_attr, but
> otherwise keep their current behavior.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
A couple of minor comments inline.

Thanks,

Jonathan


>  int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2d7759325eb3..48fdaed6d703 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c

> @@ -1521,23 +1526,25 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
>  					      struct attribute *attr)
>  {
>  	struct device_attribute *dattr = to_dev_attr(attr);
> +	struct iio_chan_attr *chan_attr;
>  	struct iio_dev_attr *iio_attr;
>  
> -	iio_attr = kzalloc_obj(*iio_attr);
> -	if (!iio_attr)
> +	chan_attr = kzalloc_obj(*chan_attr);

Seems to be suited to
	struct iio_chan_attr *chan_attr __free(kfree) = 
		kzalloc_obj(*chan_attr);

> +	if (!chan_attr)
>  		return NULL;
>  
> +	iio_attr = &chan_attr->iio_attr;
>  	iio_attr->buffer = buffer;
>  	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
>  	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
>  	if (!iio_attr->dev_attr.attr.name) {
> -		kfree(iio_attr);
> +		kfree(chan_attr);

No need for this.

>  		return NULL;
>  	}
>  
>  	sysfs_attr_init(&iio_attr->dev_attr.attr);
>  
> -	list_add(&iio_attr->l, &buffer->buffer_attr_list);
> +	list_add(&chan_attr->l, &buffer->buffer_attr_list);

then
	list_add(&no_free_ptr(chan_attr)->l, &buffer->buffer_attr_list);

>  
>  	return &iio_attr->dev_attr.attr;
>  }

> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ed7aa7fd9391..d1f56e7f1666 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
>  
> -static
> -int __iio_device_attr_init(struct device *dev,
> -			   struct device_attribute *dev_attr,
> -			   const char *postfix,
> -			   struct iio_chan_spec const *chan,
> -			   ssize_t (*readfunc)(struct device *dev,
> -					       struct device_attribute *attr,
> -					       char *buf),
> -			   ssize_t (*writefunc)(struct device *dev,
> -						struct device_attribute *attr,
> -						const char *buf,
> -						size_t len),
> -			   enum iio_shared_by shared_by)
> +static ssize_t iio_chan_attr_name_emit(struct device *dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_shared_by shared_by,
> +				       const char *postfix,
> +				       char *buf, size_t len)
>  {
> -	char prefix[NAME_MAX + 1];
> +	struct seq_buf s;
>  	ssize_t ret;
>  
> +	ret = __iio_chan_prefix_emit(dev, chan, shared_by, buf, len);

Is it worth the pain of just passing the seq_buf in there?


> +	if (ret < 0)
> +		return ret;
> +
> +	seq_buf_init(&s, buf + ret, len - ret);
> +	seq_buf_printf(&s, ret ? "_%s" : "%s", postfix);
> +	if (seq_buf_has_overflowed(&s))
> +		return -EOVERFLOW;
> +
> +	return ret + s.len;
> +}



