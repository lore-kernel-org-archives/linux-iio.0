Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E03F58C8
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795130; cv=none; b=GWnOmRcTTojuLs5UpVAULgu2fI2KW+Aa3HcgXPF1gZ894d3YIwgspco3QfsQLcG/pv4dFzZ079cZnpdY0yNnMBMj8Y3be/2DGEaEXaY9e7BISxtesR6D8NQNH1EjPawP1xCU1FVIer96eai0g5shecIydV11WyAvgbzjqbCWxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795130; c=relaxed/simple;
	bh=iaFPE02ZjfpwZAXrnzwWGCxlSDHcJ4IP0+XPAuuEaZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgSsE+AoluknkB5rNE3yMsRR7FG9vZy7v4ZRVGKK/rNkYwtNa+LiwVJ51pGeSSoc7bZbl9iyvwtS0Dj07Pha62FQnHMdmwCPV+75Wt4BQKFoenI1jfK8zV9owadpdIbkxWgPk+hUaPZ2pfode5WI4LICO/Y83FDUb6BOgDWxlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM/W8ZJZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM/W8ZJZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso21785955e9.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781795127; x=1782399927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WO1FdNyJzLW2jSnS++lTJL7J324nXe0APdtSCk7pTtY=;
        b=EM/W8ZJZbSLGAIr8t9lW2TTS3qMxVhC4Pv3MahLRt1w1dJqRkU3CVabTo3t/vk6ljV
         QBLiRiZXuemDLrIdrTzc8hflHhG14gPKZ+WMpkhxfrWO1xLlrWgoSa3ti1M72I4NrPqE
         TlUhTjPhghMVG3etPrWErC48N649gyVzQCkfXz90MOcKD7+V9BD+4SfOnSND7o645XIz
         bpTwDF57P7rQoIDfCTDoo6Nl5UOV7LEg9owjeiNJmdaU7bMTuvP0Fe2q2Oit9VKFw/QH
         Ciirlkhq6/Klr+LWVFpRqlW1OUrfix7utsG740tI2XrRd3v10Qvgzr1gYeRRD3qsITdj
         EZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781795127; x=1782399927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WO1FdNyJzLW2jSnS++lTJL7J324nXe0APdtSCk7pTtY=;
        b=mtmM6pSHQrI/J2ocq03wdW4pdtTVMCIlMA7VwXQ7rElx/Qnvqu/5JvyIjSAjNX0zq8
         JuEyJglJwoBRPIgNZYksmLBDybVOkBcaEITu9iSPmegXbIqTZT1GhR5Z8H2Y8KLuViPp
         chaNISBYnisdR8dMBhNo4oJLjDFJoRqoDXxWno3bSGFHLRi7bZuxmPL1/evM6nRh1jJE
         O+qP9qjapB6oHyaPoWxhNKCBm6js9y3WkZHUun1gOwN7sfAQbW/bEKdWHmDIL2Az3+0s
         1t4014m5+AW2QRh3CZKn4tEL6WnkSlaM2skYm03aj6Ig8y7pusJMi22DYIvAUtPLNWqw
         Nlow==
X-Gm-Message-State: AOJu0Yw8Jqb/PDUaRT2LFZ9TviszeZs+6Ab7U9Hpzy4F3FsxVvpazSnF
	C3NYB2C3b5zukarRvhM1LVt08BcXYUGmInS/RmcbLVlFfqCwk63ER2B2
X-Gm-Gg: AfdE7cnl2pWJOxWk65iiL+W9almBthAe0M82le+0ZU5QxtVLh8U9hDqCqVqBr7Kvg1V
	X2mUG12nUE1A4pGgTgWYHLCFRLUpJXrKYzAo1ncFxD69kZqaVgxRdVdlzzlX4K/6qMA34Lm+J5L
	2ScbBRie17RHxhzKJEOE90siu3Q1cGxZE1P4c7o5uGpYkeyIczMHylKMd442nBK39lpCNGhVUq3
	vIXxsSEUHIxY3sIiU+/e7DKlae7JwJNlx23M/tymdTwNTfCvUIsj1rKezCZt5H6GjH31abuOnnf
	SNt+83R6OwMKQJ1qI/9yQQ3Dmtr0dtF5OxV2grUcuus6Ug5Vvc/U9bxVZBasYKoBQc3u3tGevEm
	XJcSghyhTvcg+PSPFQjHuATB3Fl1ZWeclTcnP2JZJF9IZFNFXxueVUxL84u4+eyUi2+LwHNnxxU
	7jb7qa
X-Received: by 2002:a05:600c:4ec6:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-492381864b5mr60597465e9.13.1781795126415;
        Thu, 18 Jun 2026 08:05:26 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa5120esm264342055e9.8.2026.06.18.08.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:05:25 -0700 (PDT)
Date: Thu, 18 Jun 2026 16:06:27 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 06/16] iio: core: create local
 __iio_chan_prefix_emit() for reuse
Message-ID: <ajQGTQ1_qcOwfzne@nsa>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-6-79125ffbe430@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618-ad9910-iio-driver-v6-6-79125ffbe430@analog.com>

On Thu, Jun 18, 2026 at 02:27:22PM +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Move logic to create a channel prefix for naming attribute files into a
> separate __iio_chan_prefix_emit() function for reuse.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 167 ++++++++++++++++------------------------
>  1 file changed, 68 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 03019bf9327b..9373006235c8 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -26,6 +26,7 @@
>  #include <linux/property.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> +#include <linux/sprintf.h>
>  #include <linux/wait.h>
>  
>  #include <linux/iio/buffer.h>
> @@ -199,6 +200,64 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
>  	[IIO_CHAN_INFO_POWERFACTOR] = "powerfactor",
>  };
> +
> +static int __iio_chan_prefix_emit(const struct iio_chan_spec *chan,
> +				  enum iio_shared_by shared_by,
> +				  char *buf, size_t len)
> +{
> +	const char *dir = iio_direction[chan->output];
> +	const char *type = iio_chan_type_name_spec[chan->type];
> +	int n = 0;
> +
> +	switch (shared_by) {
> +	case IIO_SHARED_BY_ALL:
> +		buf[0] = '\0'; /* empty channel prefix */
> +		break;
> +	case IIO_SHARED_BY_DIR:
> +		n = scnprintf(buf, len, "%s", dir);
> +		break;
> +	case IIO_SHARED_BY_TYPE:
> +		n = scnprintf(buf, len, "%s_%s", dir, type);
> +		if (chan->differential)
> +			n += scnprintf(buf + n, len - n, "-%s", type);
> +		break;
> +	case IIO_SEPARATE:
> +		if (chan->indexed) {
> +			n = scnprintf(buf, len, "%s_%s%d", dir, type,
> +				      chan->channel);
> +			if (chan->differential)
> +				n += scnprintf(buf + n, len - n, "-%s%d", type,
> +					       chan->channel2);
> +		} else {
> +			if (chan->differential) {
> +				WARN(1, "Differential channels must be indexed\n");
> +				return -EINVAL;
> +			}
> +			n = scnprintf(buf, len, "%s_%s", dir, type);
> +		}
> +
> +		if (chan->modified) {
> +			if (chan->differential) {
> +				WARN(1, "Differential channels can not have modifier\n");
> +				return -EINVAL;

WARN() looks too much to me. dev_error() as we're treating it as such. I
guess you don't want to pass struct device but not really an issue IMHO.


> +			}
> +			n += scnprintf(buf + n, len - n, "_%s",
> +				       iio_modifier_names[chan->channel2]);
> +		}
> +
> +		if (chan->extend_name)
> +			n += scnprintf(buf + n, len - n, "_%s", chan->extend_name);
> +		break;
> +	}
> +
> +	if (n > 0 && n < len - 1) { /* prefix termination if not empty */
> +		buf[n++] = '_';
> +		buf[n] = '\0';
> +	}
> +

Can't we handle the above in the caller on kasprintf()? Then we could
simplify and return in place.

> +	return n;
> +}
> +
>  /**
>   * iio_device_id() - query the unique ID for the device
>   * @indio_dev:		Device structure whose ID is being queried
> @@ -1100,106 +1159,19 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>  						size_t len),
>  			   enum iio_shared_by shared_by)
>  {
> -	int ret = 0;
> -	char *name = NULL;
> -	char *full_postfix;
> +	char prefix[NAME_MAX + 1];
> +	int ret;
>  
>  	sysfs_attr_init(&dev_attr->attr);
>  
> -	/* Build up postfix of <extend_name>_<modifier>_postfix */
> -	if (chan->modified && (shared_by == IIO_SEPARATE)) {
> -		if (chan->extend_name)
> -			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
> -						 iio_modifier_names[chan->channel2],
> -						 chan->extend_name,
> -						 postfix);
> -		else
> -			full_postfix = kasprintf(GFP_KERNEL, "%s_%s",
> -						 iio_modifier_names[chan->channel2],
> -						 postfix);
> -	} else {
> -		if (chan->extend_name == NULL || shared_by != IIO_SEPARATE)
> -			full_postfix = kstrdup(postfix, GFP_KERNEL);
> -		else
> -			full_postfix = kasprintf(GFP_KERNEL,
> -						 "%s_%s",
> -						 chan->extend_name,
> -						 postfix);
> -	}
> -	if (full_postfix == NULL)
> +	ret = __iio_chan_prefix_emit(chan, shared_by, prefix, sizeof(prefix));
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, postfix);
> +	if (!dev_attr->attr.name)
>  		return -ENOMEM;

I don't oppose the change. Looks like a nice cleanup. But bear in mind
this very sensible as any subtle mistake means ABI breakage.

- Nuno Sá

>  
> -	if (chan->differential) { /* Differential can not have modifier */
> -		switch (shared_by) {
> -		case IIO_SHARED_BY_ALL:
> -			name = kasprintf(GFP_KERNEL, "%s", full_postfix);
> -			break;
> -		case IIO_SHARED_BY_DIR:
> -			name = kasprintf(GFP_KERNEL, "%s_%s",
> -						iio_direction[chan->output],
> -						full_postfix);
> -			break;
> -		case IIO_SHARED_BY_TYPE:
> -			name = kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
> -					    iio_direction[chan->output],
> -					    iio_chan_type_name_spec[chan->type],
> -					    iio_chan_type_name_spec[chan->type],
> -					    full_postfix);
> -			break;
> -		case IIO_SEPARATE:
> -			if (!chan->indexed) {
> -				WARN(1, "Differential channels must be indexed\n");
> -				ret = -EINVAL;
> -				goto error_free_full_postfix;
> -			}
> -			name = kasprintf(GFP_KERNEL,
> -					    "%s_%s%d-%s%d_%s",
> -					    iio_direction[chan->output],
> -					    iio_chan_type_name_spec[chan->type],
> -					    chan->channel,
> -					    iio_chan_type_name_spec[chan->type],
> -					    chan->channel2,
> -					    full_postfix);
> -			break;
> -		}
> -	} else { /* Single ended */
> -		switch (shared_by) {
> -		case IIO_SHARED_BY_ALL:
> -			name = kasprintf(GFP_KERNEL, "%s", full_postfix);
> -			break;
> -		case IIO_SHARED_BY_DIR:
> -			name = kasprintf(GFP_KERNEL, "%s_%s",
> -						iio_direction[chan->output],
> -						full_postfix);
> -			break;
> -		case IIO_SHARED_BY_TYPE:
> -			name = kasprintf(GFP_KERNEL, "%s_%s_%s",
> -					    iio_direction[chan->output],
> -					    iio_chan_type_name_spec[chan->type],
> -					    full_postfix);
> -			break;
> -
> -		case IIO_SEPARATE:
> -			if (chan->indexed)
> -				name = kasprintf(GFP_KERNEL, "%s_%s%d_%s",
> -						    iio_direction[chan->output],
> -						    iio_chan_type_name_spec[chan->type],
> -						    chan->channel,
> -						    full_postfix);
> -			else
> -				name = kasprintf(GFP_KERNEL, "%s_%s_%s",
> -						    iio_direction[chan->output],
> -						    iio_chan_type_name_spec[chan->type],
> -						    full_postfix);
> -			break;
> -		}
> -	}
> -	if (name == NULL) {
> -		ret = -ENOMEM;
> -		goto error_free_full_postfix;
> -	}
> -	dev_attr->attr.name = name;
> -
>  	if (readfunc) {
>  		dev_attr->attr.mode |= 0444;
>  		dev_attr->show = readfunc;
> @@ -1210,10 +1182,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>  		dev_attr->store = writefunc;
>  	}
>  
> -error_free_full_postfix:
> -	kfree(full_postfix);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static void __iio_device_attr_deinit(struct device_attribute *dev_attr)
> 
> -- 
> 2.43.0
> 
> 
