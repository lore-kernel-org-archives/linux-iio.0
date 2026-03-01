Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B9322B6F;
	Sun,  1 Mar 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371437; cv=none; b=tUH8c28LLMkPsJrkIIH27wOToeFYNC1MnFqR3iPq92SImlputgstR9PBjct1YwQEYceik9Pbsjr7Z7+jU7Z1yeMpHnExAzepk171My5i7MvHYR+ZfopUEC+i3zU0r+i3/RkVJF8O19+zEFEJcLOcki0WonbvMVOJoZGtEawZZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371437; c=relaxed/simple;
	bh=EkFMPzS7WvGMVIa3sD6L9bl6IGU4LXgQUzZBGYlcDL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSnYq4gZaiJbd/3UtI6nNScQkvLbQN+CAFuK0nRuIjU35dOxF1dir5Oc7JSkXO74WxHOWrUQoUJ8/YCznzlErH5ijDwcmJHgCW1Py/SbyS03JYby++evE9cy2FZ3s4YCa4Vzn2NY9XE3E96jEYJY4KruW9PrggPckRXMAA0Dhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2R+aYzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2R+aYzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D9C116C6;
	Sun,  1 Mar 2026 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772371437;
	bh=EkFMPzS7WvGMVIa3sD6L9bl6IGU4LXgQUzZBGYlcDL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C2R+aYzcGkx2kLWuZlj5PiBovCwXwpAFwoUcizflj0R2hn1ejDou961MEAT9bJ84k
	 Ib8/1wSDiaFY77boA8rYgAPRb7VjFyRPvzpIlxYvp31hgJamo2YeHSXb6Yh8NpucBI
	 eOoj02ww7AemhByfAsPyBVAtccPj9vXj3M1qnrUnWqXsKnnFe23alGnmtlABltfLkc
	 3CrIAEgsRxJH962cREy3x4aW+10LxAuWLHjPS3l8dt9QOL7LrqSguqUlNbfMdnuKbS
	 hbP4hvoeV+13cDBcU+9zisOVo2gmjEbmlr1K7/bohD695gSgh33MGzGSybIWMb67zG
	 zZBq+J4yMoGSA==
Date: Sun, 1 Mar 2026 13:23:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 4/8] iio: frequency: ad9910: expose sysclk_frequency
 device attribute
Message-ID: <20260301132346.00ba1bdd@jic23-huawei>
In-Reply-To: <20260220-ad9910-iio-driver-v1-4-3b264aa48a10@analog.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	<20260220-ad9910-iio-driver-v1-4-3b264aa48a10@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 16:46:08 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add read-only sysclk_frequency sysfs attribute. This value is important
> for userspace to calculate values to populate the Parallel Port or the
> RAM data buffer.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Can we not use sampling_frequency (kind of backwards but IIRC we've done it
before) to provide information on what the frequency of the DAC updating is?

Jonathan

> ---
>  drivers/iio/frequency/ad9910.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> index bb280972e84c..a72e3685f676 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c
> @@ -789,10 +789,31 @@ static int ad9910_reg_access(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static ssize_t sysclk_frequency_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct ad9910_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sysfs_emit(buf, "%u\n", st->data.sysclk_freq_hz);
> +}
> +
> +static IIO_DEVICE_ATTR_RO(sysclk_frequency, 0);
> +
> +static struct attribute *ad9910_attrs[] = {
> +	&iio_dev_attr_sysclk_frequency.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ad9910_attrs_group = {
> +	.attrs = ad9910_attrs,
> +};
> +
>  static const struct iio_info ad9910_info = {
>  	.read_raw = ad9910_read_raw,
>  	.write_raw = ad9910_write_raw,
>  	.write_raw_get_fmt = ad9910_write_raw_get_fmt,
> +	.attrs = &ad9910_attrs_group,
>  	.debugfs_reg_access = &ad9910_reg_access,
>  };
>  
> 

