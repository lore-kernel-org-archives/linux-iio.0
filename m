Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA13E8681
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102470; cv=pass; b=JL8OxOT+zY3423gKS8FLrfbi63bcl01xS7uJcpQYSM87zmob60A0YZl4sZKLwQ8XS17p/18NWK7SocFb+YjNoumuoF3f5FgsPBEvEka0OEGRIYcpX4kZpJrUbOBSPLxwpf/3IrWy5rgmjQ7S1zHt/s7k5Ojn898XHtBv8zw1UNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102470; c=relaxed/simple;
	bh=YCrTVgxtNb3/Puhd+VuNFi+8Y/zMnTomZfUQA67oTaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r46Sg7KzTrLztmq0sp8ETfEdgGekBhybmM69GYUwiLPZGa32B8MJrRzEE+hg4KZt3/Toi2PXMsfrl0RrpMDo7rXoyCYBiiE9O9Xud4cZryEjMjRDrkAvDsdfVxkC57pNXghkdE1DC4bqK4XeJFBqQyjz/a4t55Nj6rLOkaaDLA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgfd9sSR; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgfd9sSR"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso1741779eec.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 07:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102468; cv=none;
        d=google.com; s=arc-20240605;
        b=g1yworrypcI1VeP+rAJGQNEp91gKs7l7SB/61F1gYV7yvfiDklmpTUpaXUD8mGTJDO
         8H50e7lU694PdTC9+efkEHRoTlV/Q6t9GzWdipyLvcY81Ed463508zpfNNb0imB2us+G
         CQkqI76vdtU1xnquF5NCfqchXoN5vD3wOe7DbYl5MfwH0esBfFINpGIzj6t8bjh8yiNY
         z49L+jKesqKKjAy4kFc+xx5LHTH02Thkk/j74reM/L/x/hUokMkg4ME0qzO1ZJlg3IDF
         8wNv/LeOZxMm9H6+NZ9qr0bZ47JU+ZVetpWhYaK7848+qy2ifZIOoH66c2n9ORJAQFJi
         IRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
        fh=TuQP/dLV8+/rm4a0OmMA2k92ncA6jzsEpsMRvKpM/lQ=;
        b=jRxhYruqJLDSgvsL5HSlG7HrjYq9aLtHDpg5VnXGUQhkfeKETSmwua0OI+DwqlP4Y6
         BEN/dirQM0audJMFSDUxocJZXPtSitJ9wu8h6LiuKb+6bwXDqNLltG8y8iChGslKE6Ax
         RbmcQYC9a0pjzFR/RCjK05ZfyxBfuVWJI+/+cpJHRP4L6tp5MwoSIEcOTL7b0itc4dWv
         sfzkF0/D5h8LMhgE6L5/shA4Rx1tWmf7f1jRxkH34+rTk74K7x6RRfajte412LaODhb7
         mEnK7eODfNtfGNUTZ2p0JC/Yx+XvQQYUwXFPApiYobBZ5nAUVKRm1K1jp4Fxsf5igLAm
         T/tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102468; x=1781707268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
        b=Vgfd9sSRIbk1PrSD2RgZpjXEoLqyOM46SOXwm3pspFkanQeV9n4y9HO3MvedRjXjqp
         1BEJVCKeyVVosa7InrIRhm67iKI1RCYWa3VzvMhcsCn/o+mxl+hbkJA9I35rZnf3TQqB
         E94GRyTNSV7osQqRMsmZ4gGekB25epjLVtln5NyyHQa/cDxTACpqsbMNayM3ogwSC+Qb
         wU16SIHJ5PgnE+ZYw2e7jrEvLZ/nCfJR3BwECDoUF8nZRovd1AH5ZaLjh6V8w4fR6/S8
         3qnVcvY40ulWhMRJpyG6Q+sjQjcYiGizwIq87WzPpfnVodfSbOk0aqZBSRpmZUEeD1G8
         4RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102468; x=1781707268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
        b=nYr7SSkevHDQVamtIqEj6hGCvG0Qivg1Q++IQB0KjEYMKQr79Uaf8/MjW3zMfDcrbU
         6wuC6ZU7E+oxskvw+FgD5MOlKE++aUKFdc2XK5bn1Z5Iam87zrOE1WKd6TEfcOS52EDw
         +GN+UE9GYYuSuIlkOt8ts/hwMG5Q4TPt6cLPWFoFnE3sJr2zQDno6aP0uoRA8oy6q+0J
         zelTuKLDB2FKQHb/Pd06LTsirCWZ52Xo0rvmysDzwpx/OdESwbpPz1WYBQsRsdpep6y0
         TW0hs3HQrsGZMYPIaoN6CfnG+CZV9jFBrn7ig+Qg4EIvm0LaO2dAaiVtg9BRXll6/LSx
         OHLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+N98VTBV2GqloRDwyB6Hqr6hRCjEMxnKpfx3D713JMsul1/5MOuLzI6shHi1I18rYRlbHdkjwNu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx115USeYKYKENRNeEMszgmnwwjjHevKaZfLT5LfJT5hu1CtG5q
	JeOUGG9FQs1Zi+4t0/cPJRENx0b5nCZcW4MnBQQMPzgqvTFO+vnqhlcBFFLW96CrjmqL8vLKEMK
	rsIYEbI00KNEPwtZUzd6ZIfLkNmhEDYY=
X-Gm-Gg: Acq92OFL1zWDLHSwU1Dlt3r4lIUgichIKnpesh2atSpg3qnZXeRHE6OKwi9GJVaLSvC
	e4/GI2DSfxK+Y3YiPSBk0uw1X7fA0a/qU8bwR1+qOYOfxxwIiiVxb6jVIyM4onnj+ZSYS/HVygY
	WN63XBBUpUk+GBBaoq+EcefOjYyvwQ9tVc3E7Rux/LftLIBFpmnDZ+9boeHG91zgl/54c4HkSos
	2T1SLfkgQn1HYwSugk6hWMpJXmEV5npC4kY44QQQyIImAKTNTkPURke7KHOpw05J1qnKceeuz5W
	ndZNghgN972IHrszVYI=
X-Received: by 2002:a05:7301:678e:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-3077aeef992mr17016589eec.4.1781102468242; Wed, 10 Jun 2026
 07:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-11-clamor95@gmail.com>
 <aihm315UtdqJclhh@ashevche-desk.local>
In-Reply-To: <aihm315UtdqJclhh@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:40:56 +0300
X-Gm-Features: AVVi8CcyvQrrDJA2ZF-oz3jxiSwxgRbJF6e_otLwcACmPvI2rKDir5j4hVf0fFQ
Message-ID: <CAPVz0n01ymfYGH+_MgfHvWqzg+tczLi8E-1q=rZ5cHu+uJrpdg@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:17=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:34AM +0300, Svyatoslav Ryhel wrote:
> > Missing coherent_dma_mask assigning triggers the following warning in
> > dmesg:
> >
> > [    3.287872] platform lm3533-backlight.0: DMA mask not set
> >
> > Since this warning might be elevated to an error in the future, set
> > coherent_dma_mask to zero because both the core and cells do not utiliz=
e
> > DMA.
>
> Hmm... I am not sure about this. The entire kernel has only two drivers t=
hat
> do that, and thanks to their commit messages one of them pointed out to t=
he
> commit from 2018. So, if no other devices suffer from this, I think it ha=
s to
> be a better way of achieving the same.
>

If mfd framework warns that DMA mask is not set then this must be
addressed. Why then there is such warning at the first place if mask
can be just skipped. Then warning would be just a debug message. What
is warning today can become error tomorrow.

> --
> With Best Regards,
> Andy Shevchenko
>
>
