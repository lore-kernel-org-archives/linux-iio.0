Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDA366067
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778403063; cv=none; b=WIMlxqWYY+rCT12JGp4l7Z3tZtMtB/ZXXFOhISiiq0I2Buzv0i0WD2wiAYEw51BaYAY4QSGCRzH/zkf+IIoEsOtuonhvEx9OitgLX0QlE0rUzQ414gHpn7fubs+uSeHUAwYArAWtwmQxlE6qbbH8KskWZtHSoSeuzGcJP1yKNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778403063; c=relaxed/simple;
	bh=APsPwM7MyHrwDPyETr8QDqu7q2GGK+1JiXh2BcinVqw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3cM7MV363KzMRiql3s2slnPHP0lzmFLUeeAWf8DdEum9Mspq7gH6S+LuOFP2RiP8YhCLSP/8oAdm8BZbDo1OgfQ8ioeqlgP0KEPIl9R70B2XergAUgQs/l0pl+r5Ac2KOO7YVmzVErteJCz3R7v7Ib3HvdtEa9xKL9MaA0q6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu+7o7u8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu+7o7u8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso6936615e9.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778403060; x=1779007860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZNF7ruP6zfWaL34BGu38nOIYnKqmgSGr7rjszlXHJE=;
        b=Cu+7o7u8Z+dirRbcCaIHmbZUXXphw11ubrL6mx3C+z0YABYUvz+5LJDUgB3Eamd33M
         3ZEIQwXuj0yXdUWut7gc9fbhVglih7Tykz2KeuODi12lnakyULynCh+ClJ8rmdKGSIp+
         bQPnw5SIyTvloLcK9YaOGROWCdi7dLisTxAeAiAsi2JPIG+b0b8oSbf8oyVGkHtYFr5i
         Xk9iWs5xyCUxsnE58Mp48g56Q86p5Qdjjq/4ZHsti3/v3Rrf6eQ/8zxf+v1+uw+wuzyI
         6gEChU/uxKNsn/tfKlAv1EQv2B4wN4DRhcrJ1l0Xt2MSe9aGPnHD89Wn0n3kfskIm9Bw
         60LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778403060; x=1779007860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZNF7ruP6zfWaL34BGu38nOIYnKqmgSGr7rjszlXHJE=;
        b=mNTp2lUsyrm3i9Lj1voNQRJUUPgb4AOZiSKFjLHi/8w0f9bZ5JHZ9JrIE6x0CItMyx
         JA+wnKR55wrCifhcV0+tDqmNvUacm/l6ux0N4bBHEpPVOpr3KNp0QoA67facLX746x5r
         7KbBbFdzLgkSa78+7Tw3a1MggpKpkiqDxtSDZrn5pG9qva+3Hbr6JjfTfGX6l0OVqUk+
         hmnxrjhg+9OX21XtdYdGmQBLyqvLg/bgBfDBacEOLcBlyMti65LhkLIF7XysjBUnBmjS
         quhlI9zgoY7RcKWq27mIqrxCU7SKplx8FOUhvX+eb5Zprr7u6SEPasXn3hqcV7GSIyoM
         KN6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Suz/jB9O0Zxs8fAdWf0arRgx37gdfTaIW2CcTRBhlQ7RI7WpG92mPIHQTrEg4NoAqMDlq0TU4/gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOnWZUGS1SJ6XMREObTRJER6c13mbyZR6xU8UHXvnDSgQQKqo
	q6X4AdpAXp08fS26Pj0vW3gGq4jq0anDad81LVlriKe5DVVf00oGaXr1
X-Gm-Gg: Acq92OGDD4LO9dyzs9iu2RQO0vOXJeP0uu+cmDL8wH6DVZ9irGFqKW+OquzqRdkcdpu
	RrGQzcY7Y4zno6+h2cQxz1zkEXSyrpkIDPtK7/mn8GabiHD+4/CnE1E2J9TnZZ7JBpL/pfazYUq
	h6JRgvJ2jHGEWSZHwBaPecEOXpIDPZPmdTNx5CUUwOsNg7ac6qCvFuH6UXie7a0DMruGxKLVRyg
	nEQriUX1hapVnLBGuAPvaBw2Q0oK5VUMsTBXweE+M34xHb8fYsiSkO2EAJxUj+UF4jtZKjLsg+F
	ciDibPaWvD3+ntd+tsEymkkdsFikQztlSk1Xe43KwXzUhC6J0TuDKIZGIiqodSUQHkRHPc+vK97
	cjBq2x/1akQdj8aFGX5C6eHakqUh9FB0KfZ9lGgmuldSO+fQXuz9bSE8QSaIu03KDVyS79c/Dm6
	DTmhi/moiHg3D+rMRyDr6qWyYdwWvpYS4VqFYGewVpn92FPqCQt8YnQD8RzXND25rm6/mELJJxL
	JBo8ro7+VMG8lEVreRbJICe75YptXc0QwtivUAxaq8Iv2eG/A==
X-Received: by 2002:a05:600c:8b8b:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-48e51f3fd03mr321073295e9.23.1778403060285;
        Sun, 10 May 2026 01:51:00 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d89af2esm39629535e9.0.2026.05.10.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:50:58 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 10 May 2026 09:50:51 +0100
To: David Lechner <dlechner@baylibre.com>, rodrigo.alencar@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 00/10] AD9910 Direct Digital Synthesizer
Message-ID: <jqsr6q32kqnehzyc25vo2owv7b4xvoppnlbhrjrevahptm6pbg@pvghdgt2w4wf>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <f3bb9f64-a0ef-4862-afdd-74ee39d7bfc1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3bb9f64-a0ef-4862-afdd-74ee39d7bfc1@baylibre.com>

On 26/05/09 05:31PM, David Lechner wrote:
> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
> > This patch series adds support for the Analog Devices AD9910 DDS.
> > This is a RFC so that we can agree/discuss on the design that follows:
> > 
> > This is a follow-up of the V3 discussion. For V1, we reached into
> > this channel composition agreement where physical channels may have
> > sub-channels. That adds the flexibility necessary for this design.
> > During V2, some feedback indicated that the ABI is too device-specific,
> > so DRG/RAM destination and operating modes are configured through
> > alternate paths and profile channels are created. In V3, there was
> > further discussion on the ABI and on mode priority debug.
> > 
> What happened with the idea of adding a new attribute to show the
> relationship of the sub-channels to the actual physical output
> channels?

That's still to be done in iio core. I was still to think on how to do that,
and I am trying to get a mature ABI first.

I am not sure about the use case where a sub-channel is shared between
multiple channels, but I thought of a iio_chan_spec pointer to a parent
iio_chan_spec in the same struct. Similar to a device-tree, we have the
primary tree structure and then phandles can be used separately to create
more complex dependencies between channels. So a "channel ref" attribute
could be separate concept.

Then iio core would create the read-only attribute "subcomponent_of" or
"parent" when that is not NULL. The read function would just output the parent
channel label. Then labels would be important to create this logical dependency
between channels, and maybe that is bad, but in this context, I suppose labels
are going to be needed anyways.

-- 
Kind regards,

Rodrigo Alencar
