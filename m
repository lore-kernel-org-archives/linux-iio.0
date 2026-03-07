Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9536A018
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772906708; cv=none; b=T+4omA1CMsfy9kfpjysY3dINZwAGv4kAOSfuX0p4R8OUYhjPA0ktyKTZJz9IwG3omRfy6cG9e23DEtScxyFL2EafGu37YvradFUdhceOi5MXn/bTT7twrcFqfVYhh2UECHIHRac8v9firuoIj/AY3GOqac4IMCP3WjQjRHwXdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772906708; c=relaxed/simple;
	bh=f8u9tZ5yXA+289o2fQEx5pV1hn3JxFCX2cBBveXfXT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIzPhk4V0ZTcugLYVWpTA9YJb9CftxKJ9REHS7EzCPxUrj5gdERpD1znOCiFTXAzTOWTltPPrP6S9Gvxe1wFyyYtjPXX3fPoQEi63zxmwn8AWv0/VwIrjKnE5LidNcwMBZ2ppsA2+he2ELmVgNCWLUib+lWg4u49lneiJmckfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMiU5CFM; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMiU5CFM"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdfd129c52so6876871eec.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772906707; x=1773511507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBEPXxu/ApclYFmmge/TCqJ31Oo4O40W2MKETuIb+jM=;
        b=eMiU5CFMoRFhtzH/Rb3/kqScaCuUKVmzf/6ewP7tH4l7mZvLbQfx/O+sC5GLqxVFji
         7WlNKcUuT0BuqSd4oyhha64TaWDZfJBasMIbgI9Zivoz6v3dan6W4mElrzNlPVwFJigr
         kcI041C3zappScmRHZjPF29mlC9X2/L6f4K5grWju8oLmOjU3WzwX28OCrzHxSFWr7zO
         ec7IFLp5SuRjtozEVedeqjHXgVxSnqNlgtVjQvTUpFcA5eN2GODnnNQQjtSxRvTzoCLC
         2pFYUTD/KO6qgSVskTv0oeMITmoMHGn5W+m06hZDweljdzVQYwl6adijtdS/0G76RtLI
         t/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772906707; x=1773511507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBEPXxu/ApclYFmmge/TCqJ31Oo4O40W2MKETuIb+jM=;
        b=WRxJLsjtAopRs7va/LJqH/dIb+YodK8irCIjE2yAxdlBur+pvRybof4mMzGsDd7Yn/
         /0Aj18iwk0nYP63//y1E+OB5RogfnxEh+7CXUYWZPMTRLJh1kMu510UYNpvhQtj0PEyz
         jBYEf9Mgp6WYI8MVTdbOXO1F15D7leWDrZFu1/x3x/kdbd4JRs9x42x0nWRpy1/kX6es
         YrTKSJ/yNM/nQF4+Q0EydyV2GpeQ7lM+Cs6S+vcpDPskCIy4t90lAqb2psuQn01t74xV
         I+PTz6Vel2Yr8NEX0p13+aZW6xIrwYWdsD5CYqRw6PLFoPtch79kl2/dK3ahfPL/DyJR
         kTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMdRpVYY3uugrp+wHGXbms5gs0JpRNWk+mywW1rrsq0a2k3aHuuYwzj09enAp1fpgHOVJqv/fZ0MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehGQMN1Dcek1LEFlp659u1M9PBTK3RaXUNvXUx0kUHyetArjP
	BvdNagM9kEfuuLfjCkOC1ltrVi43EYGEwrkuwt4fXCw6u2Refb8DvzyD
X-Gm-Gg: ATEYQzzT+EgEXubOjszsyul+GdSQI5HDdwW1tZBaUBbzzOmcMeW0rpaqwCAabA89wf/
	w6kkGsCPPPbucNtA2zBD3xbdmknIlTozq0CUvn9gjTOmtOibNbyYLhOLs7fDrSq6D6HLeELpayz
	/pwBwntzcZrwzkejidJ0pWBskZRWIN+bgNzJirXO0Zzm3cuijGTsrXGSoAMHD5HOTBInWjzcLjb
	FCJOZ+Lx+wetKlixPSNojUrLo4Z827Kx+mVo9Y9GihKa7c2dpKF6fG3scTvypR/KE5O+8/t7VWr
	0xV2sM62D8SyHZlbVQA2HRUXXyBWcL+GxN4nDalxwoN58vhmi0SyQI0I7vd2znx/wmf3Ll0X2Mv
	WAQy6vVSjnQohNULD0oW6xB9Q6aR2j5U38rE+mriz7XTm3dd5x/c99+EWYr6mnaokVhz7SxxqHW
	Jw18qZtkMLwB5d3Ug83w0GhV/R6FXJKD+t
X-Received: by 2002:a05:7300:ed01:b0:2ba:9cfb:2744 with SMTP id 5a478bee46e88-2be4e063ce8mr2023362eec.30.1772906706866;
        Sat, 07 Mar 2026 10:05:06 -0800 (PST)
Received: from google.com ([2601:647:5e00:4acd:6ebb:c69c:ad7e:23c9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948390sm3742223eec.22.2026.03.07.10.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 10:05:06 -0800 (PST)
Date: Sat, 7 Mar 2026 18:05:04 +0000
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 6/6] iio: adc: ti-ads7950: complete conversion to
 using managed resources
Message-ID: <aaxow6NtBjSYFVTk@google.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-6-a23fdd1a079e@gmail.com>
 <aarGrAtrVbJgxoK8@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aarGrAtrVbJgxoK8@ashevche-desk.local>

On Fri, Mar 06, 2026 at 02:21:00PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 05, 2026 at 11:21:57AM -0800, Dmitry Torokhov wrote:
> > All resources that the driver needs have managed API now. Switch to
> > using them to make code clearer and drop ti_ads7950_remove().
> 
> ...
> 
> > -	mutex_init(&st->slock);
> 
> I missed seeing the + lines WRT the above removal.
> 

Oops, will fix it up.

-- 
Dmitry
