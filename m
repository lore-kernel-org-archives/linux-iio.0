Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E601343887
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799269; cv=none; b=ravU6DBULRWU9t/HK08lFWovnMB1Rf3ZoXWD6kbiKvCN6f4F2zY+Z1UV+CqE26Uaw0srtmmpNpmY6u/iC9Z7aMMBRJvk93TgXdLi0xxW8S1dw2ToEHMNuM05NuYN8siTuMDoLJGaCFliLCTrklYI6rUkWdM+cvPGuUvqnA8+FFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799269; c=relaxed/simple;
	bh=R1gVtYDN5n2fZ9vAVumO58wI1lDs+qlEx2tCz1NSsPs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKmPlk24V6l8SyeVeFj71E7Ls0FTRsByy4Wb/udn7WWsqfgRlI1GSXDt1NW5o5bp5/HBiuo4RdLsNQzCpITLX+marmY1KqBZBFLyy66NZgICOx8+TN33QmOZ/uYIjKqDM9PJ0i+jbOs+RkXto6huVACu+8WYopixbzRrA1uXwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydjv7Wfc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydjv7Wfc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cdae130cso6289365e9.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781799265; x=1782404065; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0IWtEiXv9qCkFIqBuOVncrIVNf4UpfLhl+LRYC+5jmc=;
        b=Ydjv7WfcNupDygwjHKP55HyWwXE5Dja8Xerx5b5tcK9fsStG8yGcwy3ACC+5ke16/X
         VgDTGgWryNMIHP8+R2QnRPJSDbyaCyYa4OOYI1AfG4+ygzMXSdVLo3r9jxfxeCPbjlq0
         bmmkPWgwSq8M7950u0hX2u/5dk8AG4h8fihPHSKCiBOQIIY93vfoUqQ+PzHTewf/eZjm
         GiGlm5RLhj7OjjtEWTr2BlOl27CV9aQTfWCg4T8kDrHrSmXebfsvUUdBBQ1uwCYVCGII
         EMTgFcwlQ4CqRIq2utb9RhidtKJS5RXuJaItrfYwdwMppkdmgCByzGljTffUHVDOJ07h
         TY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781799265; x=1782404065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IWtEiXv9qCkFIqBuOVncrIVNf4UpfLhl+LRYC+5jmc=;
        b=bVDXNH4i6qPt/Egp7WWwG2I7idOfKNAfGsG8xJ0MXxAnZnX+OkCBX1Aw7O/xMecPCA
         7hlFbnt8EetWQfPpZBt7wbLwz029HDrXySv/cLLAL9ioUX+1HLd0yOXtLMTO3XU7KWhF
         mYGz0e4FIacC8Ga2jmVtOvekWh05s3yGNJ9iCfR/0OFS7xb0b/GRD+khYSPa7yN0XLq1
         miaOfQpXTJRCs1n04CROHXhEy5caUE8mf1NlSZSRMuHyvPeyxE4rY+bz+avg7hQIRUVY
         Ppf8M/XAERXVgH1E6+vSzFqgYrPwMw/x2bMFzzV4oHOME0bva/iWhKQiOwR2Lm47bb1X
         7xxg==
X-Gm-Message-State: AOJu0YzxGWNyk/mMO0Y4B30IqRKZe+i357Bq6hn5Wg/Uu/jC6dF4A0Do
	LuvXAQcHWPV6e1vr8PVAJKgOcbzRjeP3RP8/o/j+lJ+287UkCKbmqW38
X-Gm-Gg: AfdE7clQh67GBcN4OJdzDbGGkIXITFTG1224bFZazKTOY6GeKUsmHeGs45rQifrRdDi
	7EVvcDzcS9JqyY3ggpQyxigKkU4x3KBj/BqVzJZTOgd68JP+huuCcfTzPZg0PXx9CC1/x7dW7Tv
	LP2O61dHImXKluJOpLzv1qRdmgbAxDII+3JPcd5VWelFxZnbgg6PFuCOJAOZ2cSk2c4HERbVOdH
	ZLfbLqGpYZN9rLdwI6b/34+FBkLhp/Es2s3Gl/EsGMPIf4MPDmudUv2+t3VwgpRWSg5OrumG/hB
	g9275NWIS5NRvoNN7JsQBxboTEFY/Pe0/c8CTyJ3BokbEXj6OEerY3BrYQXCkxAtYkHqSwMLqtC
	z4czuciv/HwElPWh4rc4kD3MELQc/kvfw6vQbxsY8wh20YtsZuWI1TVgcuMlxabFQPbY4iYwjRH
	r9TBAj7ZSL0OGLaO1y/SAmkHQC1FmALrVaSCEQWo2bLKVtO9iAJOwxKOcR7Cj4EjfeSqPQOm4sm
	PaKmXH2FJXe0Xk1lxym6hP3I9d5
X-Received: by 2002:a05:600c:8b24:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-4923f439be6mr4090255e9.14.1781799265192;
        Thu, 18 Jun 2026 09:14:25 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-462236047c8sm20330838f8f.10.2026.06.18.09.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:14:24 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 18 Jun 2026 17:14:19 +0100
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	rodrigo.alencar@analog.com
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
Message-ID: <x3aijvc4buo7aqbchikuoyyrgiq3afidtkla37h2rg4tvfdbc3@h42qp3estg2s>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-6-79125ffbe430@analog.com>
 <ajQGTQ1_qcOwfzne@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQGTQ1_qcOwfzne@nsa>

On 18/06/26 16:06, Nuno Sá wrote:
> On Thu, Jun 18, 2026 at 02:27:22PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Move logic to create a channel prefix for naming attribute files into a
> > separate __iio_chan_prefix_emit() function for reuse.

...

> > +static int __iio_chan_prefix_emit(const struct iio_chan_spec *chan,
> > +				  enum iio_shared_by shared_by,
> > +				  char *buf, size_t len)
> > +{
> > +	const char *dir = iio_direction[chan->output];
> > +	const char *type = iio_chan_type_name_spec[chan->type];
> > +	int n = 0;
> > +
> > +	switch (shared_by) {
> > +	case IIO_SHARED_BY_ALL:
> > +		buf[0] = '\0'; /* empty channel prefix */
> > +		break;
> > +	case IIO_SHARED_BY_DIR:
> > +		n = scnprintf(buf, len, "%s", dir);
> > +		break;
> > +	case IIO_SHARED_BY_TYPE:
> > +		n = scnprintf(buf, len, "%s_%s", dir, type);
> > +		if (chan->differential)
> > +			n += scnprintf(buf + n, len - n, "-%s", type);
> > +		break;
> > +	case IIO_SEPARATE:
> > +		if (chan->indexed) {
> > +			n = scnprintf(buf, len, "%s_%s%d", dir, type,
> > +				      chan->channel);
> > +			if (chan->differential)
> > +				n += scnprintf(buf + n, len - n, "-%s%d", type,
> > +					       chan->channel2);
> > +		} else {
> > +			if (chan->differential) {
> > +				WARN(1, "Differential channels must be indexed\n");
> > +				return -EINVAL;
> > +			}
> > +			n = scnprintf(buf, len, "%s_%s", dir, type);
> > +		}
> > +
> > +		if (chan->modified) {
> > +			if (chan->differential) {
> > +				WARN(1, "Differential channels can not have modifier\n");
> > +				return -EINVAL;
> 
> WARN() looks too much to me. dev_error() as we're treating it as such. I
> guess you don't want to pass struct device but not really an issue IMHO.

__iio_device_attr_init() also used WARN(), probably because it didnt have
access to a dev pointer. It would not be a problem to add an extra param.
 
> 
> > +			}
> > +			n += scnprintf(buf + n, len - n, "_%s",
> > +				       iio_modifier_names[chan->channel2]);
> > +		}
> > +
> > +		if (chan->extend_name)
> > +			n += scnprintf(buf + n, len - n, "_%s", chan->extend_name);
> > +		break;
> > +	}
> > +
> > +	if (n > 0 && n < len - 1) { /* prefix termination if not empty */
> > +		buf[n++] = '_';
> > +		buf[n] = '\0';
> > +	}
> > +
> 
> Can't we handle the above in the caller on kasprintf()? Then we could
> simplify and return in place.

I felt like doing this here would get a cleaner logic in the caller, which
would have to add the '_' conditionally.

> 
> > +	return n;
> > +}
> > +
> >  /**
> >   * iio_device_id() - query the unique ID for the device
> >   * @indio_dev:		Device structure whose ID is being queried
> > @@ -1100,106 +1159,19 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
> >  						size_t len),
> >  			   enum iio_shared_by shared_by)
> >  {
> > -	int ret = 0;
> > -	char *name = NULL;
> > -	char *full_postfix;
> > +	char prefix[NAME_MAX + 1];
> > +	int ret;
> >  
> >  	sysfs_attr_init(&dev_attr->attr);
> >  
> > -	/* Build up postfix of <extend_name>_<modifier>_postfix */
> > -	if (chan->modified && (shared_by == IIO_SEPARATE)) {
> > -		if (chan->extend_name)
> > -			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
> > -						 iio_modifier_names[chan->channel2],
> > -						 chan->extend_name,
> > -						 postfix);
> > -		else
> > -			full_postfix = kasprintf(GFP_KERNEL, "%s_%s",
> > -						 iio_modifier_names[chan->channel2],
> > -						 postfix);
> > -	} else {
> > -		if (chan->extend_name == NULL || shared_by != IIO_SEPARATE)
> > -			full_postfix = kstrdup(postfix, GFP_KERNEL);
> > -		else
> > -			full_postfix = kasprintf(GFP_KERNEL,
> > -						 "%s_%s",
> > -						 chan->extend_name,
> > -						 postfix);
> > -	}
> > -	if (full_postfix == NULL)
> > +	ret = __iio_chan_prefix_emit(chan, shared_by, prefix, sizeof(prefix));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, postfix);
> > +	if (!dev_attr->attr.name)
> >  		return -ENOMEM;
> 
> I don't oppose the change. Looks like a nice cleanup. But bear in mind
> this very sensible as any subtle mistake means ABI breakage.

Yes! I tried to be careful... this is dangerous stuff!

-- 
Kind regards,

Rodrigo Alencar
