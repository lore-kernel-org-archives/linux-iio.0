Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D971D6BB;
	Fri,  3 Jul 2026 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042419; cv=none; b=b8ZZVXOwe5oAMj86qNb/5B/c55yISBxQehgl0xxgHu+PEysOCdALC/MGz5ePDdSg0U5UDfeBCGVaYMhsP+IKaMGhJeVpf5KGjSznQ6Q3P+lbZjF/CuqafeDhriDsuczu+Z1AlPQERDJD7g4LgMTlVcc64DPi23dVDUEvvhHOCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042419; c=relaxed/simple;
	bh=t7p6dISSVB8lnZVanH8fynJR/7IRvjvGfqNSvKTAhI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdNSxe/SNhJOuFEPgcJChqSz/ae1pg7Xze9eOFSHFaPtrY2igCoC+NGBknC8ER2Ci2+XXyz2wLsYx26yHZsHM+hjJtbLzca7BbBnMuNA9RBiZwnflJ6iHytDrqAWqjvwC+rlLmCEl3hBi11fw2neI70L1JAFREr3SRZTa/Kw7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVZDDHpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVZDDHpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572951F000E9;
	Fri,  3 Jul 2026 01:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783042417;
	bh=z1UJKnDhUjSBpg0SZM4+JMff/Bf70BA3nzIrzGyoKKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HVZDDHpCKI4pCgTI9pT+GuZNj74Hyg0B8SAIbW/bmS/iaMjHVooyN4tn5vU9ECGKC
	 C0hQIYuDAV8FiIOOeg/I2hVvEGeasHdti4sYkNohMiPeuBBKWBeuymKeYUSv4qLRTL
	 HymV57vyiTYmZMbewyRJ2eDlAxsEt88JCID+SklxRz9e08RzdsZmM6lUSGzoXdC+mR
	 TL48O54mUgZO9C0oguqFJ80OQ+iZRD19TpvgdTNCmJ3t87Af4LdAAyNLMAGjfUgsLK
	 ZDvfbhFY1Xz+zwb/d6OxRT0Ud07Ph6akvxmk1DCK6K/GN9KB3VA+ncEIa1m3wx8eDn
	 zKSSbsEVfp3JQ==
Date: Fri, 3 Jul 2026 02:33:30 +0100
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
Subject: Re: [PATCH v6 07/16] iio: core: add hierarchical channel
 relationships
Message-ID: <20260703023330.45916b4e@jic23-huawei>
In-Reply-To: <20260618-ad9910-iio-driver-v6-7-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-7-79125ffbe430@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 14:27:23 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add parent-child relationship between iio channels by creating a parent
> pointer field in iio_chan_spec struct and exposing a sysfs attribute that
> returns the parent channel label.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Generally I like this.  A couple of trivial suggestions inline.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  5 +++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 9373006235c8..3d12269f26f4 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -854,6 +854,21 @@ static ssize_t iio_read_channel_label(struct device *dev,
>  					 to_iio_dev_attr(attr)->c, buf);
>  }
>  
> +static ssize_t iio_read_channel_parent(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	const struct iio_chan_spec *parent = to_iio_dev_attr(attr)->c->parent;
> +	int len;
> +
> +	len = __iio_chan_prefix_emit(parent, IIO_SEPARATE, buf, PAGE_SIZE - 1);
> +	if (len < 0)
> +		return len;
> +
> +	buf[len - 1] = '\n'; /* replace underscore termination with newline */

That's irritating.  Can we instead make __iio_chan_prefix_emit() not include the _ ?
That might mean a wrapper to just do the last bit of logic in there.


> +	return len;
> +}
> +
>  static ssize_t iio_read_channel_info(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> @@ -1263,6 +1278,30 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
>  	return 1;
>  }
>  
> +static int iio_device_add_channel_parent(struct iio_dev *indio_dev,
> +					 struct iio_chan_spec const *chan)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	int ret;
> +
> +	if (!chan->parent)
> +		return 0;
> +
> +	ret = __iio_add_chan_devattr("parent",
> +				     chan,
> +				     &iio_read_channel_parent,
> +				     NULL,
> +				     0,
> +				     IIO_SEPARATE,
> +				     &indio_dev->dev,
> +				     NULL,
> +				     &iio_dev_opaque->channel_attr_list);

Probably younger me style, but can we group a few of those into logical
sets to reduce the number of lines?

> +	if (ret < 0)
> +		return ret;
> +
> +	return 1;

Hmm. Can we make it explicit this is about an attr in the function name.
I think that would make the positive return more something we might expect
than something that sounds like it is adding something non countable.

> +}
> +
>  static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
>  					 struct iio_chan_spec const *chan,
>  					 enum iio_shared_by shared_by,
> @@ -1401,6 +1440,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  		return ret;
>  	attrcount += ret;
>  
> +	ret = iio_device_add_channel_parent(indio_dev, chan);
> +	if (ret < 0)
> +		return ret;
> +	attrcount += ret;
> +
>  	if (chan->ext_info) {
>  		unsigned int i = 0;
>  
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 1c7d12af22da..9470ab8eb726 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -264,6 +264,10 @@ struct iio_scan_type {
>   * @ext_info:		Array of extended info attributes for this channel.
>   *			The array is NULL terminated, the last element should
>   *			have its name field set to NULL.
> + * @parent:		Optional pointer to the parent channel spec for
> + *			hierarchical channel relationships. When set, a read-only
> + *			"parent" sysfs attribute is created containing the
> + *			parent channel's sysfs name prefix (e.g. "in_voltage0").
>   * @extend_name:	Allows labeling of channel attributes with an
>   *			informative name. Note this has no effect codes etc,
>   *			unlike modifiers.
> @@ -309,6 +313,7 @@ struct iio_chan_spec {
>  	const struct iio_event_spec *event_spec;
>  	unsigned int		num_event_specs;
>  	const struct iio_chan_spec_ext_info *ext_info;
> +	const struct iio_chan_spec *parent;
>  	const char		*extend_name;
>  	const char		*datasheet_name;
>  	unsigned int		modified:1;
> 

