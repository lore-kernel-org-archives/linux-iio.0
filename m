Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225004;
	b=w0q1ssbVa5E/RKGl+2/mAks+a5ippM02yZGnEX+jb+7uVDrezB2FmUS8BaY1AKXhK6vA
	 0r6INZ2UdBuO2MHW/dU13kPMfTISBKc4pQr9tRFVQ2tORDVgD4l0ycCPfR9Qp9A9Cw4+4
	 D/cz5KNnamhisbdQGeVE6kd6DtEwYNDvcHnZ3B2GWCTqmc1NuRLcITY7H0rkEaNbkJL5m
	 CMYhFp6XuobvVTxanayRGtjKYBy0s7abhdCdXZKfJVSB0t/2Rum2QjMSkFsRewpO6lT6s
	 aXCTOL2JKdJyaEUtNwXa6hEa7YQ9k2impPJgDLOO/EnVPwn+Zjriy2v0MxGjIDrnjtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225004;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wC40EZv+3NfB+qDvxR8XDUi7Rq89tU/dFa7o4BUerMs=;
	b=oPD0X0JFV0MhBykym7ehUB+DHAjXM5NJ1k8SZQVNnlTnxrFB7Z/fU+PGJpbITDxcur0n
	 txOcQ1xKz2x7b+9efz+0h8o/nzbWimV03HkLY6ALgUtvSsZwlUxRhDQWdO2ALrsOur1HA
	 fSxa46PStR33uMQrcb9o1l/whyTHwiyfnlv0ta4LkeEZFHAPnXOtjXtCbLsF8Uivb6R+y
	 7WjPuqivR4Va3Dp2T5ss94R5ljc4BeV+Zt8IYBk+Di3X7IhlKUXkoWBo22hZni00lwZbo
	 SxGMsG9X9rkH3kehBmDo34zWT9bk9vnFq1p38YhH9ukxA/yzauU/x3P24SfAdDQVkyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI+rB8Ji;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B8606A68C;
	Sat, 21 Nov 2026 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI+rB8Ji
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E161F000C0;
	Sat, 21 Nov 2026 01:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795225003;
	bh=wC40EZv+3NfB+qDvxR8XDUi7Rq89tU/dFa7o4BUerMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mI+rB8JilOXg60z6lDO7sOF6fc0qOYaOezTEqBwUqpufQuTmYuGPUnaDhYnB6/Sv5
	 jMAvkZkYfXvG54xrc+WZAKa0hvoJ2qLFV14WiIB2570z9GP3XYcR9EEmBxQMe7Wy/S
	 8yhEXik21+PZtwhcQK8iHdlF86B0gywyO4kEPzevyWqD6hFf/X8Ds3tuaDCKiaq12n
	 5fdvaamgB78nNV/vRXJs/o2Ou4A5g971KC2e7jI6XvzontIQCNz7qbi1g2gPjfdX2+
	 qXMxBeDvFd7lLo33YRd+/a8m9mCQJhMKJj5ah9vdxqBX10KFKSwj615A+rUYpQ3jQk
	 Y5RQb2aV0TnCQ==
Date: Sat, 21 Nov 2026 01:36:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 5/5] iio: sysfs: drop core-only fields from struct
 iio_dev_attr
Message-ID: <20261121013639.14e8d5bb@jic23-hlaptop>
In-Reply-To: <20261120-iio-core-attr-review-v1-5-05b41f8133c2@analog.com>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
	<20261120-iio-core-attr-review-v1-5-05b41f8133c2@analog.com>
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

On Fri, 20 Nov 2026 18:04:01 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> The list node, channel spec and buffer pointer of struct iio_dev_attr
> are now only used through struct iio_chan_attr and the types extending
> it. Remove them, so that attributes declared by drivers through
> IIO_DEVICE_ATTR*() and friends no longer carry them.
> 
> On 64-bit, without lockdep, this shrinks struct iio_dev_attr from 72 to
> 40 bytes.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Trivial but I think it would be nicer to drop each element
as it stops being used in earlier patches. That would make
it obvious how things are migrating to each level of more specific
structure.


Overall I like this set. Bringing my horrible hacky mess
into the modern world :)

Core code though so I'm not going to jump on picking it up
until folk have had a good chance to look at it.

I was tempted though as it's been a long day and nice
to see something that reduces technical debt go in!

Passing comment inline. No actual changes suggested!




> ---
>  include/linux/iio/sysfs.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> index de5bb125815c..1e4122b8c13a 100644
> --- a/include/linux/iio/sysfs.h
> +++ b/include/linux/iio/sysfs.h
> @@ -9,23 +9,14 @@
>  #ifndef _INDUSTRIAL_IO_SYSFS_H_
>  #define _INDUSTRIAL_IO_SYSFS_H_
>  
> -struct iio_buffer;
> -struct iio_chan_spec;
> -
>  /**
>   * struct iio_dev_attr - iio specific device attribute
>   * @dev_attr:	underlying device attribute
>   * @address:	associated register address
> - * @l:		list head for maintaining list of dynamically created attrs
> - * @c:		specification for the underlying channel
> - * @buffer:	the IIO buffer to which this attribute belongs to (if any)
>   */
>  struct iio_dev_attr {
>  	struct device_attribute dev_attr;
>  	u64 address;

This is close to device_attribute_ext but I checked and there are few
if any points pushed into that address. 

> -	struct list_head l;
> -	struct iio_chan_spec const *c;
> -	struct iio_buffer *buffer;
>  };
>  
>  #define to_iio_dev_attr(_dev_attr)				\
> 

