Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19313E716D
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101060; cv=none; b=r6VjTHhnwXu0q37jGXIQdaQI54BR1TGJV/LV/uc2/cNwbgtzV+hyTWInaG6Qe7JhF0y/xQz3NfOCuIfy8Sixc0V+U8nBcpvxO1bqdKLptDUmksYtbxn0uC38m6XkyPPHJtn5RMGZAuYlYA/CYLRA3Rz1ov1RPJ7GHoEwHzO1fOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101060; c=relaxed/simple;
	bh=RhWcqJg8RgbB1MJofKvo7sLooBa12dtFpi62aR3SVlA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cblx/eGs3KwuC47UfH/IwCinKiN68nrnrN4d19H0inxPmShxrbzvs0huGnJVpA+IqcNSg+tdoml/kcSLWvdi0VZiMk+iDoP4/nmBGqGnibci5i3Np6pZidPcadp1Fh3txFjWpUR6OUFJM1tmK4DIQnAwrtlE4fthXaWtO4DQcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asZJ33ak; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asZJ33ak"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b150559bso16456845e9.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101046; x=1779705846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1TfHYXVTtFe8YaePf+Qyu1Vi9txD3OHA9vREKcQqPtk=;
        b=asZJ33ak0Vyy8BzpgsbV8W9yMbtX/3IobBUzr6evd39lgTXOwdAsjwODlfiA4IfAWV
         oN2OnFgvI2KR7G0tI39EJoC2fqB15i+Tqr9txxVJAk6KnuhLmeWYGExopq05wJAwiFJE
         Hb9JoeDGMQI2c3ucBkTa+n2oT+jPrnPBYnKg7JDpCVrBrWHVjC5OFQuEFZGq7SQXfQkP
         pvKYzzeynmi/TmhskNCTCa1nmWStYvTAvKqBS92w3opnpjZJszpcLQ7BbDsEY5o8aja7
         kPut9jURfdR2rRm+bRGJ04JxbKpKFAaoaqvUxwb8W4wnLoML7brSjDknuKjGztLjVWyG
         wJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101046; x=1779705846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TfHYXVTtFe8YaePf+Qyu1Vi9txD3OHA9vREKcQqPtk=;
        b=kVjGjKltl0PYGypNvEDuUSH3lPMsQOCExFNoWyrFNBRj4aKE/K3VMsY8ZGCtU2AlEO
         kJxkhIz8EopOsaMRQjsAzLrT6NWUuotxJZeYPxfflu1vEexlSWvPQkE/MyrAewoyfYiP
         r9wthldnMg5kz13qI1I8j1pELn6Cy3mD99BF8bxg6Mv5Op3AerqIKxOaamc05i3KJbR2
         8XfTAeE+9FNHCNUsC2sAOYlv3WfJrp5m2eRZ20VfhGXGeyaFPJGXfbQB7vNdb+gK5C2N
         tqzpNbdJqx24DbtwID+72mbz2Dk+SLqfQVEu8pJ9HftNyK960A2W5OXavLqYX/gmXquD
         uogQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ho0MQDL/3Fo/RFCvGRmFoB+oexbzJYPSHL+/6Vu5bah1ahbK5EWuc71ieRs+8O9DqN17UqRBgJjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+a41G3j5ceHTqGgf1W27lUlNu/LfW8hrRE9t6txQxudV8gYn
	z5iPEVkQGJ2DsqGSR0cdh5i59F6QsT9H7Zgk/hAsIr5WDdf8vAa/AgcJ
X-Gm-Gg: Acq92OF15JHeuy+nHrDWD1B8sQv81GWyu7HQxzp5AviWz64ozWFJOsGqN4DnLfi/oK6
	89QldRQVkLbtdObG33St7zA1RNc8a3xvkx4GcpB0B+lkYhk0CpIU/+Ki7lGK2JTbDt6EOTdiKID
	2NuJ/mnLfIT61WvU7vR6KxBTgc4TbSpZCo5Pa02JauhoPyfZcEj6XlnXUub8mYqicvauP6UHnA4
	efeZNT39GpY/srxrmUfOmo7PIjxPiYcdLe80/c/O3r5ffojuU6MNKCy+ZnVT51v+iEMxhyj0JVX
	VgJBagMxBX2UgwN+3web/QcW+dqH6Y0g/XFFZh/i3IXF461i49tPa34zgUU+3C73iObJLk1nm/A
	KtslXLx19eytmlsB2lW2RjtAn5GhyCDMlndab9QfbSi0u65jiGtR2VuC7idx99BTdjrkXm+U+Zl
	FFiflr8JGfDfar3GUvi+bRu+qLPwtSs2IeujZL6HNbGUdn0JDFRU+0UTCa8OB+3LJdKarGNTHXI
	0aXW9XkZQqcIvrbxOcQ+uz4x5uzX2eRPm2WV77vxir9hJbiJA==
X-Received: by 2002:a05:600c:13ca:b0:48f:eb8b:9988 with SMTP id 5b1f17b1804b1-48feb8b9a84mr122520795e9.23.1779101046286;
        Mon, 18 May 2026 03:44:06 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm36544342f8f.33.2026.05.18.03.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:44:05 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 18 May 2026 11:43:58 +0100
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/13] iio: core: validate file offset in
 iio_debugfs_write_reg()
Message-ID: <hr3phupisl7dc3sch64tjkpeb25z2lkxwsxumcviauvstu2b46@rba2dqhoezze>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-1-31599c88314a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517-ad9910-iio-driver-v5-1-31599c88314a@analog.com>

On 26/05/17 07:04PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The `*ppos != 0` check introduces a functional regression for sequential writes, masking the true bug which is the inappropriate use of `simple_write_to_buffer()`.
> - [High] Unpatched uninitialized stack memory reads in other IIO drivers caused by the identical anti-pattern.
> --
> 
> commit 7c5ddbc34738b9e84e226b9906348d61e3569bf4
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: core: validate file offset in iio_debugfs_write_reg()
> 
> This patch adds a check to ensure that the file offset is zero in
> iio_debugfs_write_reg() before calling simple_write_to_buffer(). This is
> intended to prevent leaving the start of the buffer uninitialized if a write
> occurs at a non-zero offset.
> 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index bd6f4f9f45330..e587aca79b8e7 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -419,7 +419,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
> >  	char buf[80];
> >  	int ret;
> >  
> > -	if (count >= sizeof(buf))
> > +	if (count >= sizeof(buf) || *ppos != 0)
> 
> Does this cause a functional regression for sequential writes?
> 
> If a user writes multiple commands to the same open file descriptor, for
> example using (echo "cmd1"; echo "cmd2") > direct_reg_access, the first
> write advances the file position. This means *ppos will be non-zero on the
> second write, causing it to fail with -EINVAL.
> 
> Before simple_write_to_buffer() was introduced, the code used
> copy_from_user() and ignored *ppos, correctly treating every write() call
> as a distinct command starting at the beginning of the buffer.
> 
> Since simple_write_to_buffer() is designed for stateful linear memory buffers
> rather than stateless command endpoints using local stack arrays, would it be
> better to revert the use of simple_write_to_buffer() entirely and use
> copy_from_user() or strndup_user() to parse each write independently?
> 
> Additionally, does this leave a similar pattern unpatched in other IIO
> drivers?
> 
> While this patch addresses the issue in iio_debugfs_write_reg(), the same
> pattern of using simple_write_to_buffer() into a local stack array still
> exists in other locations:
> 
> 1. iio_backend_debugfs_write_reg() in drivers/iio/industrialio-backend.c
> 2. ad3552r_hs_write_data_source() in drivers/iio/dac/ad3552r-hs.c
> 
> Both functions use simple_write_to_buffer() into uninitialized local stack
> arrays without checking *ppos.
> 
> Furthermore, ad9467_chan_test_mode_write() in drivers/iio/adc/ad9467.c
> uses the same pattern. While the buffer is zero-initialized there,
> sequential writes will still be functionally broken.
> 
> >  		return -EINVAL;

This was me trying to fix an issue and maybe creating another.
Probably I would just drop this, and leave this to be handled later.
At least it was good to indicate that such issue exist.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com?part=1

-- 
Kind regards,

Rodrigo Alencar

