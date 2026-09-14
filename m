Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617B3FF1CB
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402089; cv=none; b=qIkyi+kbVy8dKOCV4L1+sLntcREcO12pxMOn3myVblYXhmLlPMVrn+QDR5dxGnHl1RYkTGfuJ05ZJiwznIsFCPv8BpS8Z4JKzFC9RKZoaN8IMbVJDtvC09d1pmCtEjL3UYg5JrYAZfBmpsHQ1zNGmMcAangf9Nnr6m5K93kBGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402089; c=relaxed/simple;
	bh=4JpqBF0U8ok2c1bU1R2ZgN0dtcOkgvd6/IXu/350qDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUL09uFAInWi6uBbRhSO6TODU5irDVIUTVHEyjxQ7ET9vJ7Suj4zZVksyue+16yoPdBIdnYPIemLD+/VcIqTBR7SstyEs9RnuYN4IkWNqpM+tNcoVkKKz26Fj8txOv7VTHu35vV3KfktANgvvh8NfPSTpvTcBcpCoYI2/gy0blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HDPwWLLp; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HDPwWLLp"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6f5fc7so1308819eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789402085; x=1790006885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhBnpIqJR8cSwH8SLHGlHrOYOv2zJDR1Rl7Ewp9l8a8=;
        b=HDPwWLLpGuYZ2na7MhghRHTLBi1EVyb9huFu2Q1Bu9Uw54EfNn78S/40m8nMU8QlWL
         TAKnhn2aJrnzwCEXuSdO0mmPh9K5I5uFcGQ6tCYcXZEwoXD1Z5YDIgtet9agxZYOn7Sq
         4oTNossulTMss2sU1BqlSsfuQVGh/l55kbFoMzH6N8J2A6oekdgZqcCyCFijqfdQNFyF
         HKYIn89clAHd6tbE1n2mAaqCKiQmlYjp1z2KN418wtS6HBsSJmB+BLEgLIEo3YSqhIDp
         dSi5pRE/n0MCzJiUL2Q5DIGa9b6xSuyftQ7GtnrZBCm5+EM85U0ccGVB34leabNXf28i
         6/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789402085; x=1790006885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhBnpIqJR8cSwH8SLHGlHrOYOv2zJDR1Rl7Ewp9l8a8=;
        b=xb9/qsa66rVY8+HOFHzfJ5QaUCUlb+CbyVJbU8q20Ospy2cx5b/U+242UydlvRR6Hd
         nXJUSY5zHyrKSlGAnehYJw/xWRHy9eGNxj17p9mqyum7xh6yxWDFs2wGS2F/qCVxuUYg
         HJpXnakNs3v1lusujEi4l4f450lA896BfE75PtYOrYH9qKyIuXoG0/QaBs2L5H0e/uN+
         VJwNSY2PRLPJvVaY2tJvWxNef1H2NifeJgwd0WPCpmnyhGwOczKkgEtbAWjKNU3bTNRz
         TYKwfA7NMgqPftXiR0oPBofGkjWZ5N9oEq03kuB1fa4ajELllq2uiIVnCcScIWgbig4S
         ssZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuP12VsweU2JzOAZbkPpV83SMlZ8PKZA1AHZRhoy4sxH/9cmoexW9sFe4Y59PT0XiQfF2Wt3U4gQU=@vger.kernel.org
X-Gm-Message-State: AFuF++nF5goQmfUn6ypXBmVVcMTieMvYRF7WNHeC9og2eiJpO1bL+CZ0
	+fKny7TUGhpsd3sY6BJH5eGJAMDKk6XoZ2EOoPXxPKDFSSX95BCw6d/QnHkv1vtejb4=
X-Gm-Gg: AYBFou3RtBzrBlnAY7fCVwVfTytjwhMUhmyQvORbIt4NYU6HmMR9N3D22knKC+QLq1p
	NULkotXzmyUsQpXlJindlW7B2a8UXZl3yNpDydSXS8nDD5EPTY/quz2L9BZuN1f+pOEDF5WiTzJ
	6NO1g58+EZJi4JavEI5+uvHJ/hUghn1wbXv971mjlowq3FlQ2q3Fe+SZO1oltSlRVkfBMuEiN+q
	2rmGMDFtMjojryohkZSU7svV5QqWibFeH1vBIbf7Tu6lQ9XarhHiedrkl0SmY6SP070UdPz9y31
	/5zksKXznf3dBb27Z6cZqut0TOSLfhVb+DSa5otlJ1grjzDuIeIi0QHdMZAl6HstQrcwviIcV7I
	T8SB76GMGxW5ouyTrUOLSgkbzj1t/BZcRdbUb7CQ4/dUIJ7yxlxdUrDKkzvFJRAD1F9BkXdLiP5
	VDIRFZk3U/gQ05KDRDT2uNVUMG9TPM1E4Nwz+xRfk96sAT0qbw8VFO+fYmdlGoPJ/q9JFQG1L9W
	tQ9MFJ9MsqqH91Z5x+AA00Z5uwzLnEefOAd5caSWI41lttrWg==
X-Received: by 2002:a05:6820:1988:b0:6c1:fd93:5292 with SMTP id 006d021491bc7-6c541d3ff08mr3216204eaf.17.1789402084949;
        Mon, 14 Sep 2026 09:08:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d8f9:ae1c:d229:aec1? ([2600:8803:e7e4:500:d8f9:ae1c:d229:aec1])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c342ec1ff5sm6543816eaf.14.2026.09.14.09.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:08:04 -0700 (PDT)
Message-ID: <feea59da-055e-4faf-999a-c275f42a99a6@baylibre.com>
Date: Mon, 14 Sep 2026 11:08:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dummy: free software device on configfs release
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260914115404.1691763-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260914115404.1691763-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/26 6:54 AM, Guangshuo Li wrote:
> iio_dummy_probe() allocates struct iio_sw_device with kzalloc_obj().
> The error paths free it, but after successful registration the normal
> removal path only frees the contained IIO device, leaving the software
> device allocation behind.
> 
> The software device embeds a config_group. device_drop_group() calls
> iio_sw_device_destroy() and then drops the config_item reference with
> config_item_put(). Therefore, freeing the software device directly from
> iio_dummy_remove() would free the embedded config_item before that
> final put.
> 
> Configfs requires dynamically allocated config_items to provide a
> release callback which frees the containing object when the reference
> count reaches zero.
> 
> Add a release callback to iio_dummy_type and free the software device
> there.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 3d85fb6f8104 ("iio: dummy: Convert IIO dummy to configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index 19fcdbbc11c6..7d2ff1d4a06e 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -23,7 +23,19 @@
>  #include <linux/iio/sw_device.h>
>  #include "iio_simple_dummy.h"
>  
> +static void iio_dummy_release(struct config_item *item)
> +{
> +	struct iio_sw_device *swd = to_iio_sw_device(item);
> +
> +	kfree(swd);
> +}
> +
> +static const struct configfs_item_operations iio_dummy_item_ops = {
> +	.release = iio_dummy_release,
> +};
> +
>  static const struct config_item_type iio_dummy_type = {
> +	.ct_item_ops = &iio_dummy_item_ops,
>  	.ct_owner = THIS_MODULE,
>  };
>  

Should we switch the alloc to a devm_ function instead to keep it
simpler?
