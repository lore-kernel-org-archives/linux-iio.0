Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AE3D45ED
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605352; cv=none; b=D4RBf8HEhxTmt1fzq1Xzrpc9PW7XnZnzkvQ9XD+jfT3iKHmN2ShCUnXOMh/Gktb8+PNFzM8dvaE3FX5x7a4VWp4EH0XNw85wETz919xxiAgXTz+ijmjXBGVxWXVGOTdQ3CAlhxVy+M8l7mETLlw1tbj4fkgcyx0Dv6GOVmhlFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605352; c=relaxed/simple;
	bh=6zAnmJplbRJHrEYL7JhzTrhZXo7V5OFYFINtTtoTZ2w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhxEWwlz2QGXcIcdsnsp4qS09p+AARbPgBoTjB72oYHkVhfMq39JqmfaME9shrZ2LHRy7A/kd3AMRn13pLlNCTihFxdt+/H5IXREiUr2bOwCM+04Epj6x0275V1qvDvVhcuv4l31ZHidClc5By4A9yROHc8FYPfSEpIH2RwFkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k50ouChZ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k50ouChZ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a86e4b950cso4222945e87.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605349; x=1779210149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9km9X8WvuELTJi7qj+7+Noq5bB5jqawSJ9nshPfD98o=;
        b=k50ouChZSvxTZed6wqPYwc0Tt64X94W0HloH1IwzsbXRbaZCLuun2KmzIg1sMwBH+O
         QYgElNqdnQouiay3CWhPpChyGxdJQ5JfwbVOFV+vqwQ9duakW6TAf63q8lF3zQHj7Jrj
         LCkDjfzxZw4P4V3fygTPDuDbMci2mo8aaK3wCL9UWBamPbyx0P/AVlxrNYHY5DYTcJAK
         PfQe/NpnaEQD2OodCfFryrOcCMcjR/P5zgFAUlMY+mSh5Sb9LQhDNQMuXFgkA5oLWGrk
         dhCZZ1xUKwiJsJ1flAuLYZICQhaicQINrXFCgxPpCWRS02XhzA0UgyonX/vJrNFqVMvC
         CPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605349; x=1779210149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9km9X8WvuELTJi7qj+7+Noq5bB5jqawSJ9nshPfD98o=;
        b=eiKX8gTbnKkrwi6mGFe9XMIZgzdXpeuezrkUIb/XEmuo1JIz94WDC5JsRwE0U7jZ4y
         fbvZxC8inyKXET8Amq8lScj1a1KgQKIxwn02GNe3EQL1dOofyiePmhv5ilkrJMlNsmAo
         ewT1jrtZiIyTHUgsZ6WTXiqk/0M4NvlhxppA06swJEUqeIndVAmPbsoffYAmbHB+PBq0
         W7Ca4Mm1rBMXQmKnldcYZjP/i8gQ/GC+VeGyvYRjdNCX240pPCGUdLxei0UVC3vLmzZJ
         mcVBRyOBf/aLNRFyMRyh52VuutTzO4kv4M4BMz+RPuX9SOdyj1mooBD/KsL1Ko/q//I3
         HEXw==
X-Forwarded-Encrypted: i=1; AFNElJ/cb7Ixhr6wcN56EWfOjUtwfLWDx49y5+k5rbcOEJKBHUh1/6oXhI7xR9d9yGncpPNw9BxcpdcDa84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63RcjPFVE1ll58YILTFnJ4TSrqXiU82+h73zHovqO4qfpJud+
	W3rQ+y5GKZ/cMLWo3Rrup7tJrzIQCxPu3eVD/q4xM3RrrI6sTamHGqV0
X-Gm-Gg: Acq92OHPgvt4Gkra/SjVdsvmsYLIcGohvws2SSl2cnK13VoL4RHeVzFg+WsiIPkCs3l
	CF/FtCRHzvBlH8kjB9YgEJaD2cJt9Q9oDM4KhHJLoctpohQcnjzYvweGGRHZ0IiPeTDHGZWPVNf
	IW4wC0XfD8CTFkrwTtRnluRCpfZbxsE8RmkRIImNPOOd0CJMta/yr7t4BplKq6UzLXOwnDCPyUk
	llZGkyB2Zp9l19W/nbch2Zj45G/WVXaerPKVwMqNQ1YUzCH1T/t1kqm70anJxvHPNm5hCexJ0Qw
	YUeRd3MlfR9xEFzM2wvCeJFyjoXMD6HGfQkD1+YCykpXPfa5Hoa7cg1ZarN7FynAQwT6Md0Gttz
	JSXC/NjOywo7FAXb0fMVGjpGZoEx0f96n44XmTCo4YavjDx7/enzN+Qry7EM0FrRLRdywZPr8/k
	UtciXlA9+HOYlcFUyoi/N9+RwWy0eCP8iKYz2SB/vtJ+B+H+j+tXbPdRaQjZZF1eU3pZFJxeRuS
	OXsO6bwDUMfdGcOKj67b4HXda/qvWXwqm7gAoC/7tOeDjWmUQBD0cfgOQk3
X-Received: by 2002:a05:6512:31c3:b0:5a8:84a6:2e34 with SMTP id 2adb3069b0e04-5a8e30d13e6mr1353520e87.14.1778605348704;
        Tue, 12 May 2026 10:02:28 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454913049ecsm33071212f8f.19.2026.05.12.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:02:28 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 18:02:22 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 06/11] iio: test: iio-test-format: add test case for
 decimal format
Message-ID: <zugkmatjsacla7l7nguekmclfdkzsshr3gs434a3liccgokxb4@xg77y5tkts5c>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-6-34af2ed2779f@analog.com>
 <agM7CT4RjzwliKmb@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agM7CT4RjzwliKmb@ashevche-desk.local>

On 26/05/12 05:36PM, Andy Shevchenko wrote:
> On Sun, May 10, 2026 at 01:42:24PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Add iio_test_iio_format_value_decimal_64() kunit test case for decimal
> > value formatting, exploring different scales types. Also, the same
> > iio_val_s64_array_populate() macro used to populate local array is used in
> > iio_test_iio_format_value_integer_64().
> 
> ...
> 
> > +	iio_val_s64_array_populate(24, values);
> 
> You want to test this first...
> I think the previous patch needs new test cases.

This is no complex stuff.. those functions are straightforward and
goes into accordance with what the format function does... which is
the opposite, before populating the buffer. The assertion on the buffer
content accounts for that behavior.
 
-- 
Kind regards,

Rodrigo Alencar
