Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676EC22370A
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471165; cv=pass; b=nLRLOYvhomTekEI1XzaJbP1DrxOI9scfqcGKreS4ZwvwSfy1tipg/PLr/SoZou/fgcdxQNUWSa5YWS82p6B+UU9fuj17jY1FzOcEeeWbExcB1ywdOvGYPEPsGRyFLdqo63xTjoaXdsO099SO1WBmz+yF3ECLooisl6cMdhNowyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471165; c=relaxed/simple;
	bh=SKAIwj8SOxbOUtH3oA65PL5Rortu6wc5n5U3PvPP4mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIYkHFGOSzqsKqFrqkiV9Vue8VONW7518VpUXn/Tdw7JHEkldlmp/WwgriRXv4TgX8qlOJDHvNF02HL5Nf4Oc06b7q/gndTReCo4coz9AyrQq5MgkXDSe16vp9TevdyrRw9dVXs2Zu/4WPOwCtNQ7yjGLF2DCBmO6ecI8pSvlOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE/S1tc3; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE/S1tc3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so218291005e9.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 06:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471163; cv=none;
        d=google.com; s=arc-20240605;
        b=VLY4wvOiR5MUTD/Wjw794+2nnXLJA0scGhN+bCrWRqsqQ5BVp4CKu/wbZD5URbgiYB
         pOufn9akVX0reA1QajLZlXeh0N16p5nTb3iXxjtjBC9/qjmeC0SY+ZN2L+JD9HW+BvgD
         V5AxJs/m+P7pQSVD8FLQTmNEAu+ggqRwL6nUtNOFMPMp+iuyN5MA5w4kuHswWdeXtqQ+
         quuz4cFetIs211pEijZYXlQPDwpnp7jiC5Ot7dF0DfO5OwtSEZvhLhbqGXT84CAIgulx
         xbd/TdhH+YrFNb8URA/HBFgCZ7Adwh2PXH1mElaD4FRzMGnVUpo65HGbIguVatkC8/Ok
         jCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0uJx4Nc5xjRF9MQBJkWi2zalrNj7Ig0+trNSn+2R8wg=;
        fh=mw8Y+w6XzJD4rFxcQM5926q5QZbcywixq4JqUmVlk+4=;
        b=eMuqYzF44ZazOaf8q/NU7nzB4Gvg6xIZ1L+Q9j/vzFK7OHoXPXKTsM1DFx/qSyAEe7
         UO9+XfU+m11W5fDf50A6iY5T54KbBKNKa01ax10sQDlDNpzWHKyQGTjhh7SjiFICvTVF
         g1PRzIkEUIK4Swjn/cvBttx8yCNrhYEam6OkpTYMaqqJXpq8TAbmri8LwBWhr2VyobRd
         cQ3Yb+tw67SF4KtgZdIsEHzi+az+V1fK8at54+kZvi1x9XsjJAVpphqcdipe/X6dY6H5
         fg6dn3LCcuyyN56SWnUMQVtylHALTqkXsdfF4P9CAoccQTkUZz4m3v36ITXD2UsJVRKF
         Kk8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471163; x=1778075963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0uJx4Nc5xjRF9MQBJkWi2zalrNj7Ig0+trNSn+2R8wg=;
        b=dE/S1tc3Rq45+J7CIJK57mi2c7ZgDiZn55WwgbAlv3unMz1YLm1owLz+PjMXtmvPFc
         mCxU25V8UikXF6Sai1lxYU3zwXDfk7AvFwhMqm6/VgD/n6qK/8X2THYHaZ9UnYEIiVVj
         OjLoPMGE8Fkj5PXJwg8sSU3B+a3zQLMDycwwmqqLLiUf/jSJaCbEFOmnAj9JcV+ipAF7
         p915zStThQQLuSPY8gCyjW8Y10YDyCb3+q/1mvMNw9AEk8BD5tjeSX3vKMpuaItMJ2T0
         48U5puwfBjOUeD2g1sgbLmUFPnhbFUtaDtWZwts2Bc5etJd+00XGhFvHZOtP0nW3jcaC
         7RwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471163; x=1778075963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uJx4Nc5xjRF9MQBJkWi2zalrNj7Ig0+trNSn+2R8wg=;
        b=ndcVqBNCRB8siPmcVgjJY+YddFfPYHKS5glFB3Ckafwd6fqSFOL+iYKJ2FRhqVpC/U
         XNOXZBjpeyl0GMD3SQxtUXmu2d4JDqWvBjtQifXmF4GEXhrn5esW2NnbFY/067p8NIDt
         6waePmxin/63wpbqJXRhClq8TTVZoPH8O81XnsqadI9futRHrQ3JC6+MhCujgBGM83oX
         h16AV6eBJ2fstu9R9OsYJ0DFet/jx7+wJx3KNnqyA3QgELAPxC1jkYVXgNZXfT5k2KsT
         Ub9UHTL4VSZbECGXG2BzdD1s1Y6NMhSI4WjDFYFq6M/UF/++CESjDndEfv9MqCL3A2dd
         6dfA==
X-Forwarded-Encrypted: i=1; AFNElJ9/pChh6J7cC5abq9PPLib9PK6Wji9aJpzNKeqaL/8gMGfpJSuiQsgZydPDAp1s4ffrU3X5U6IOuC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUnWgbqf4Yr+TSJIv93M9fBSF6onagnFgHs6pvLbSYTgQ43eH
	spwIt1OHU/9GdqhnjbbqNFLzHgzXgZh3pcZz93rQzDpXzmXBnqCm5y/w22fA0HEiLUjweba12D6
	BAcpRusZwSDr5gR+v2RhPji+/BQjg47IulWpz
X-Gm-Gg: AeBDiet4qyfKBOsc16baGTvrJU7dHPMgkALnnqdhYzuVzCQBV6cpOJgIGAsvfO1tBGM
	vyXtIpF+8hn2vGPCH+hvKFARwAi+uTRltmKcCnAhd6VnzWVcKU+/FHoNCCtz5E9SlUz3s+gGSPx
	QgMYd9MWjm2sp/yFjMlH/CvhvfiE/Rfqcb2mz/eTGO+Utd2eCLXoVbiapOCgrUGFNxrYL0LmTdh
	NY0MHrMvHJIAxnBcF0NhNx4ZTVz1yHYW7dG8jjwvx5OsRmLDLNaufdlTxZup0PcdhXWERBM7Mfe
	JjbJo3HeeLAJN1kGytZBuZjIA/x/QaZrPJRp5wGnF29bq/07LkpU9iJoLr7wKebvbvtCNWtMBiT
	DCHzpj85zTltA2oCjmGNRvo8ckz++xbFCsmGTy9NwhFpE561KTKJ4QPBW6XSUHBd8E3pXLHiOxl
	m7hsY7M4HGTM8z21CAiol6FWKKxYA=
X-Received: by 2002:a05:600c:a413:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48a7b546c59mr69194075e9.23.1777471162739; Wed, 29 Apr 2026
 06:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-5-andriy.shevchenko@linux.intel.com>
 <20260428172212.1e1bacd9@jic23-huawei> <afDpBGa3N8Dd1L6y@ashevche-desk.local>
In-Reply-To: <afDpBGa3N8Dd1L6y@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 29 Apr 2026 15:59:11 +0200
X-Gm-Features: AVHnY4KUpiIne_HqqmU9jIlQJPQhC7wAjlg1oyuKsfTj-rT_GdBjUUGTQTI_IcQ
Message-ID: <CALoEA-woV6r=gOfHHXgBG82+FCG6XMBcSy0=6SUiryCS9woh+w@mail.gmail.com>
Subject: Re: [PATCH v0 04/14] iio: magnetometer: ak8975: Inline timeout constants
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 19:06, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 28, 2026 at 05:22:12PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 Apr 2026 22:09:49 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > >     /* Wait for the conversion to complete. */
> > >     ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> > > -                           AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> > > -                           AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
> > > +                           10 * USEC_PER_MSEC, 500 * USEC_PER_MSEC,
> >
> > I'm not that keen on these being repeated in two places given they take the same values.
> > Perhaps we should push them up to the caller?  That is, add them as
> > parameters of wait_completion_complete_gpio() and wait_completion_polled()
> >
> > I don't mind if we have them hard coded into those two calls as they are right next
> > to each other so it should be obvious they values are the same.
> >
> > Ideally I'd like to see a comment on why these numbers next to those calls.
> >
> > Fine to pass them in msecs and do the scaling here.  Just name the variables to
> > make that clear.  poll_msecs timeout_msecs maybe?
>
> I think we are fine with _ms, so poll_ms, timeout_ms.
>
> For the completeness we may also give a timeout_ms to the third one
> (and convert it to jiffies there).

Simple enough, however should I do this as a separate patch or
just a fixup into this one?

-- 
Kind regards

CJD
