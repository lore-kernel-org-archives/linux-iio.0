Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99E3570C8
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473497; cv=pass; b=KpUcYD0JszeJ4RfiOKAQQEvVquqb96e+DZieuFG7ks9YjonE/ijStOLZEpJOcLD1pONPfdcZnp+F4CC+2FqWBrHQXSe/H9dIQv6S7NI6dzN3wHxnKhV8sjpmRkLwmJHQlM+bNwLC/odIvyNzIkE7u5k9FKrw6moAX8o4Kt0fAhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473497; c=relaxed/simple;
	bh=+65zzP6C3ekKOLmokQkMnIxdx4GG5NM7rY1Ym6DaWh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNET8WUpBwJ+lK5f8Tx4v6CFsmtWag+wO/Lrzuhhj9je1PNVTcBpgMey69ZYlXKmGNZjagjFLS0TuvKCgONHOVhqf9NtzewzkX7qUxE2gGpCN8GwlDKLovRpAukSQdgi7TXtnOyOB6mJNIez7n1yfy1RsHxJutResCAwoAQgjbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lsz+ckls; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsz+ckls"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso68708625e9.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 07:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777473494; cv=none;
        d=google.com; s=arc-20240605;
        b=h7BYUl3UL1rhFXG8RlDajiOBI9LjPTzvQs2i2L50RS3lCO+7REzg+HrgOQmkD6sKgY
         RcmYyAPvYYzYTkJ5n30F9wdg+ZkYX30BIzYJUx6pbeW0qpQDN5mg5uHnkATlQGrrbqK/
         L8CNeOoXLpIdo0dEZ0fCM2M9wkCZ7FYk8JB+K0aQrWv+LlYXyySMVcd9pcCbC251ukum
         EQ7HQpNQ0hR09kwYOQFieOg0dKIvkREGXQTkFXhNc5lJ6ejMqf6kUyXPIBB/UdvGU/SI
         jSAZc5F8e0UM0nwgQStGaTXGeComnXryKI9Qh8qO+9FxI6geKpyL1A9xSmWXdIeyWLxR
         vd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g9Z5gnbMFbGkbMePrORqLo7WDadrFsupeF4Xg+HOdzI=;
        fh=6XjoqEKnFzi7w0KuqWYj0ItBPVh/rAjHL0vt6xeGB68=;
        b=izqKT90m7UO4zWS2E0EteHDSyGj0rSkyOpcCntIUj7BoKbQ8rgPoYgC9cEZI9uhFZP
         lN9kzCHXugN8K5WgPnKxG2WlgooGTrtzzTdoQSaUzOQ10OYdXq5PUvHxuayJsw0zFa2z
         TFOw4v7WGcKKQfRX+go1HlDryyWpS4w8DBnKHrn4U5ynX1ClXK1lA5dlIMbNaeZ8j6gx
         mItmJzNwVK64oX1IuoWOa8MoEEZiVAHVKq5L2yZwpz1PmURZC6TX9DBO2P1HQ6THkRBa
         8mgo6OuKhkJadlCUpm/hXWoLmlFqJfK+vfZoptwBRy6zwuxegaCTzqO8qSbkvvfiKuHE
         4Quw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777473494; x=1778078294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g9Z5gnbMFbGkbMePrORqLo7WDadrFsupeF4Xg+HOdzI=;
        b=Lsz+cklssWmRtAUV+T+n6K6hjHtgEo4afmE+nNs26vSqIS5RIxHIRjnFTEerjbI+Al
         Eia9x4H3SYYAC24UvxB8Jzba0Sdrahd0pACWjwkx6AiyaEiQRdcCSTNNnkda6oQP5sW2
         ubgFuM36xKs34uTUty3q+9I3fSn6uWr/HQaPKMT2sEdWTp1lTmxVHyU6l5QqItASH7FD
         siyquf4W/j0p8vV704XqlO9H8Redg2u4lGdQkrTkj2pjtFte8U0W/dU2Jn/d6s3MozQ8
         Qx8DT5rWnEs3p31S0OYAjmMlXel0YU7FlP+byd2Ub8vZBYl7Q59wPb9HrtMyb6dgmxGW
         57GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473494; x=1778078294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9Z5gnbMFbGkbMePrORqLo7WDadrFsupeF4Xg+HOdzI=;
        b=mxNvQ0MvkCGWU1doy+GMXnuPXflTM8Tt5Imok5Ai+d6AU5/RjgyRQrQlffazG5Fg3m
         e1r2kvJmZ7T81ogfEsm/QyrWUlfAB38HWYHx6qyryQas3GDvIQkGlenGCcdPenuUbJj1
         aFOZqUV4yV9FO8rwJ+iDytlEyQIL38QUnTrFe8rHQstd9ecAdwTK3ZjLVimm2Ej1FFCv
         oIRi8tevBdX0I5PRDHu7fick40I2yrp7Lfppl/LZNYv1hSbc0RBx3DYlMq+VTTGx0Jyz
         1U7A0r0xGpOUpXxrJiVwnrDEgiGBtDu568jlJYSjy9CxsxU12Gl/8i0czRE5l2ERD94x
         nvvA==
X-Forwarded-Encrypted: i=1; AFNElJ8kLmp40EY68qNjUXqoF2KJ4FWW/IGv+EKygx5hCYX1S4FOPrUs+FxRSsxarchvvCKNnn+N9+RNNwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYm3na6jIhvYZUnk0wVJME/OzkJRNwr/msWclinrtfiTv6PXr0
	Jq+XsQiy490DN5EGFH7BHTBR+/L12cydQs3m59HWLzAuF2c+CTkC/eLaL1fMPVy+e/n8U5NRAV1
	hfoLLbwKKUQRq12dbOYOIFqykdvd3bug=
X-Gm-Gg: AeBDiev068flU/a48KVe6RuueWOUk8halgewLOeakEn1vTO6SiTCp0EjQs5TgMGMiXE
	JnDZKAvM03HZ1jtarW29fj5rDRDHo79jNzLpIpt/VZa0erazdlAALefPkKQnYgHb3qM4ka9lxEg
	LBKnDhCSizwBlR5bJpUeE7LknG+nJ6Q9i4xqHqRnDWMnHokWMxwPh7BRjbBBJAUHfXLEUg/P0av
	Hyzxig1nUBitjTJWBujFRT+THNXIhsA0cKCZFAzFCQuMp2nEzi3/yOX9kZjmjnyhI2UoVDXSpHX
	+A8d2mzU7bAvSeRnkYwjMUOrHP/bfSugdR2VbYoPxCy2Du4/XP5Mpo4QmQTQbIWtNOHBP5oQCma
	+O2riDanNvHgDOgAFR5N7OiHlV7VFAxVWiOxzoaiW2W9GbZ5/PJx3ScVfKb4WwfybFkU41byxNi
	optddDW+xlDWk2AeiJ
X-Received: by 2002:a05:600c:81ca:b0:485:41c4:e2e4 with SMTP id
 5b1f17b1804b1-48a77b1c785mr132315405e9.23.1777473494045; Wed, 29 Apr 2026
 07:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com> <afIRG2S94JEn3Oqd@ashevche-desk.local>
In-Reply-To: <afIRG2S94JEn3Oqd@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 29 Apr 2026 16:38:02 +0200
X-Gm-Features: AVHnY4L3Z2kro5HITDPrZrYfsZLSrvRvxvYvqKIkSY1jd8VKZS3uVjqO7GU748w
Message-ID: <CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com>
Subject: Re: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 16:14, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> I haven't checked this deeply, but I hope at some point we will have
> more or less usable state of `iwyu` tool that may do this automatically.
> At least current result looks better than the original.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I did find a "filter" file of sorts for IWYU that Jonathan had on the
mailing list.
It does a good job of omitting reports of very low level headers but at the
same time IWYU still tells you to include things like <linux/stddef.h> and
remove anything <asm/*>  from your includes. Perhaps it needs more
tweaking?

-- 
Kind regards

CJD
