Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D862318EDB
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793054; cv=pass; b=SH3Y5mO/QtYHt/CeBWGHP2PvZDE+Exp6eilJCYVHMQGJ6ruEqdKP4A8naTSVXWUEFc9FjSi+Jl0lUG8WMtdc8TS7SSCssLpoF9bPjX5JuKfQWFzjz4/bG96LpnJm+GMpW9RqV90jAeJ+dJxquW5toseAyezEGtIZfGwebCZDBY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793054; c=relaxed/simple;
	bh=ckMGdmh/ujGaSL1u44u0Po4SxGdL8Hzj5sCke3OMI0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRUSII6N8uJzwt0GVc4L4plnsGbGoBbQjGlkpEKDTOOswkRE5rfeqa72hBfncjgrhowb3imL3hReb8F3svTqUnGaxmWvxzCV8mNk2XEXsfKYwAdoJzm0nxNs49JmrCiqn/s3pF4DSOI0edRIXzyU4Y+Vt7eEf2VVyz7a+RPRkNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4M4qCdb; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4M4qCdb"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5032e59c8d3so7598791cf.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 22:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770793052; cv=none;
        d=google.com; s=arc-20240605;
        b=cieg69glBvOmSjV9/dZF+YRlk80/zhGsMm+rEaymD6/4uBCQVSAsYM5fyM9uXTCH6J
         6+RghNgwvrqJxkWl6kUgjFYYCFwl6TJwTWVqGO+b2+oC16VWXctOhBL58Trkrw+2EkR6
         708PTyGpqoNMW+SFSO3E+D7QyfM8U2VQw4Lr4fZ+Jsrfd8S3vJKw/3zFg5xiqtp6RkCy
         OE6HEKzistwlSz7paZMykN0XsGboleP38Cqv5cfmOPWJZet/sBJG52WcBi5CusVgQurm
         EZhTtwB0wAqHc37TeCUhRQ7Lxqu9qJFl8hOgsKEHuGFAXmVz/PBj/EitUPPUPVQqihA8
         G4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2KE+eglfX/MaH2FIVLCWpx26/dB6meyChI4AHkFgLKQ=;
        fh=mdKb+oAJ7YPZEjbj4IQly/4Ch2fhhWIj5P9A5AOQKJ8=;
        b=EIlWBbiXd591zvU3gB1zh/LCOuUzw0Q5O+wlCpksYgFT1KnZ8hJKRejeI+qZexe6ix
         rYMU656QxoaIvt0SFjOAdfQrOLea9cbcG9EpyEwhLLyhOMYQ6jXJhKu1jHVyh/eQRIA0
         jIZIGJTUhctDmBHf6t9+Kcc/lRSa1BzqtNh+U6ljaGn9Qy2fz61jAp0NuqjEReZV5WNd
         AHIGV8kGIJCl92+Xixv24zyZDpViuActY2l5i4AubAysGYDvC+u74nwSvRZoH6d5CAI/
         U6F2Z93nnnC5vexu6kEDSe9SHr02pq59E7Efu+UYHtr8P8AqM5qfvOdUd1F0sAbn2+WZ
         W9Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770793052; x=1771397852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KE+eglfX/MaH2FIVLCWpx26/dB6meyChI4AHkFgLKQ=;
        b=Q4M4qCdb5HykPMsFJqmEkr2k9gHR7Qj+VXhijjfZdJFXy6pIzPC5/iCYN7NsUXe6Yb
         p8QKzFnsxpCMiDsXLPCs/gMsThH7yei/t78V+ToBv1dsCF2shdA6nX/F41KX0szG7LTI
         q6TcVVmyaLAdWNmejBQMNDpV6QjrjBZkdjx0oh16c1Jxhu/4jch6ItqSs7XBninD5paU
         BP7xkNd6wflaq8PjUkq/Px2ljMQvPzhg+gWWmTOADLyXf9R+RBbl9JcOTrBYvOI6ZLuv
         BvBLnOj1XUBcVHRhJPeO1uUVw5aACc762Zg6YiPnkqmGfylbS5zgTNMuxfUVd6wG1zN5
         Gyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770793052; x=1771397852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2KE+eglfX/MaH2FIVLCWpx26/dB6meyChI4AHkFgLKQ=;
        b=Wz/+CanA5Tyth3m3ZuMwydUBEEGWhmmHLND7dbUaR5YkcfUZPB2LJiieUPJbVgm4Q/
         mjCgq9G0gi4HEF6pY4QQQNKW7Ofyogk3WOsSthxkBRSFt35L0YbSJ5H3JMHlWfDXbL7x
         xIitapYGwa7NJMoCJkjwSJ4CfE8Vwj2nh1wDyObENaM1ZVYHDjytf6gTVSP7TP7B8aDS
         SZyp0BPu1XMG9T2do6GKl1t3kcrP1m1KhuAy7X7jdt/8HnL8wl6WczvZKN6iP2JWKu6H
         7YNqb2DoEy/Ek/xdJt8kchEXjxexkGAFFPpjazhdNQhfO8KB5ck6bz2WhEC1vyA3I2Yz
         orfw==
X-Forwarded-Encrypted: i=1; AJvYcCVQc+Zamw6qYnLDye8GXLTPJP9tU86HWMO8iyf3h+lvyQxxNrxeQmTZyvr1+MtX1yG9H1R1zkDSU2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PC1iyDv3qR1ZXGRIF669eFFiPVaQ7Q4KQmzroD3eN3Q0wysx
	HDK9HkNhXdZnbY+vfKuiqjGhRq3SaC7c2vwLmFUukaZi6a9kJpwLf3QtZC5VrF6Q52YUJdnKXWm
	IjX4M4tr56R3WchzEtDvFn3iEcZLEhGU=
X-Gm-Gg: AZuq6aK0wrg5tHFhsZgrehUsrbMg3HRZTY52373H9XpE1qDvRrGyAOKhM9R3djiWkEC
	9KiSLnNYW0Ps4SCR8THE2STQzEX5UmYbdo847Gjxdq6kcHQWaUrWwbvNqe5YHHbUcy8zydaRTbV
	ufaSLgFuTLnHYceQsh9XRWUAh4KBET+eW7OpHekUY1ZJZRPUwrVpCa1D3Mu/F7S/rveu4yDR9rA
	Ga30QxHfJf5nozfaIPjAt7CRtxe3B7sUUnqD1jEyMmAM+w3HPZCtomep2jECWtFuMbMj2YPSe4d
	Ln1mY1IX6vzXv0hNUo2IR3t04K+7LKDeb9A0IYe+HmVb8t9rQKVp8fRYl8GVXwQ58AcM29kI
X-Received: by 2002:a05:622a:41cd:b0:502:9ed4:eea3 with SMTP id
 d75a77b69052e-506839c8793mr8317091cf.9.1770793052393; Tue, 10 Feb 2026
 22:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-2-2b4d74e309d1@gmail.com> <aYme6jXNyPM_AHo-@smile.fi.intel.com>
 <CA+NOmz+KKhSAX8cEUhcS=GPCTtagyFZS4Pszj895bf-07ii7bw@mail.gmail.com> <aYtsENtoRhywTYbo@smile.fi.intel.com>
In-Reply-To: <aYtsENtoRhywTYbo@smile.fi.intel.com>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Wed, 11 Feb 2026 14:57:21 +0800
X-Gm-Features: AZwV_QjUmdXLEkJCdjBhJXQ21a8OeGDgB1TngSpiMw-IwmlgYDuJUwa2KHdF8H8
Message-ID: <CA+NOmz+JKNcY+MhbMG-oYPkxR_Ac4YFbj65zNdxBBX8AtSoDtw@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: proximity: hx9023s: Protect against division by
 zero in set_samp_freq
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 1:34=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Feb 11, 2026 at 12:29:15AM +0800, Yasin Lee wrote:
> > On Mon, Feb 9, 2026 at 4:46=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > On Mon, Feb 09, 2026 at 11:37:03AM +0800, Yasin Lee wrote:
> > > > Avoid division by zero when sampling frequency is unspecified by
> > > > falling back to a default 100ms sampling period.
> > >
> > > Fixes tag?
>
> >  This is a proactive fix for an original implementation issue I found a=
s
> >  maintainer.
>
> Cool, any objections to use Fixes tag?
>

Hi Andy,

You're absolutely right. I understand now - adding a Fixes tag is the prope=
r way
to document bug origins, even for proactively discovered issues.
I will add the Fixes tag in v2. Thanks for the correction!

> --
> With Best Regards,
> Andy Shevchenko
>
>
