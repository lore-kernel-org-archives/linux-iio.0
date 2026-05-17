Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C03C9EEC
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039040; cv=none; b=KjIdXOMPvJTOEShvYJgXXl+GcTOiyHZYiprpdXXHIQd0APHLRZE2wzvfO7IbWX1ATrn81I7sKePyubIPvPaNqvT7nz+bVFfLpHYGgIiN+q5XgECo77gF/VQrGDxD2tmsWnQXVbGXZKvF9EIoI4XyIpz97dK2aqy6T9Py+dDTUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039040; c=relaxed/simple;
	bh=ZN+M4Cchoa1lUZGVHkJaXVLB6ZtVvpayoDZ73oWRJAo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdIJFI0AIVH+i0g7KSBK7wEBzZmRaymtW8jcXL/X0/ybRx3UEh1JLEKysCq02gsqPBieA3G+Mbwrg6k98BdwmtVHNGxbb4KDkmSCjKSL13fmgNi7XvrbBSlWde+bJw76tgr+6s/gQBzP3wChflNkgpN7o0BwuGJT3mQYaFSnxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILn6PBvA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILn6PBvA"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso6392975e9.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779039034; x=1779643834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biN63ninIqhGSrYMwDyAgi4Qnh2QQxC8g5gMwT2w1jQ=;
        b=ILn6PBvAE4vEIn/gQKL3g1QZDQM5AH+iyz7FsTSK4GO7ra5i1V6PhR423ZdBEhEgKf
         ow+u1wM/oWnxJQZODL4IllpQ/PdI4bIBjCyTpAHOteIZcE2+4ndeC1K6dKIwpcswJMYn
         5Cib4cyH0Eel063IOE3EvRQ9Om1v5TTxs5LzGLQ0w2SzFegUKaiX7HI1BdGF0n1moeLh
         xNWpiqD5pXS920Li9HSx25DDxqovXuZP+LvueVnSmJlg2g5lSuo0sIbFYNZW81k6sYB6
         IILR+Bf/x8n67wqCxWmpRJtOnwAtvqiWgvJ0kDHxiqaQYy5feBVsjPhZdf7tqLFWK/by
         whVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039034; x=1779643834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biN63ninIqhGSrYMwDyAgi4Qnh2QQxC8g5gMwT2w1jQ=;
        b=UBhyGqieZFmXrPF5aWTSuGznPez2xdjcbCECB3DMTxRZxHcjjeonqRO1IXtT8qJRqR
         mgUM3Il058oCdQ/uaGAHS3V5lwqipuArhmS445hGJDj4enXJjroBc97jlWlEVei9bEGD
         6+3SNhuFPLLEwx5yj4UmYx0uVfsu+NlB31Fv5O/LHKTwJCAUmFBRmG0zAMq75jXURrb5
         kyPlZLbI34hsnjtMx2xPynCvVh+EnfFRZW3uzWci1lO0f70MqmSGK4Zjf2Rc8hNdqUpr
         v7eyB8kj65BK8LmkgilnAu8TgoZmWprnoU+7pvcuV6Df5DguMFRVon3HyY4ZXIYvPUMa
         zFdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9B+K9j3liokm8zOqU3V3MAGRUajakEzJ30r3catjuqJvObHi0eo+azoka9/NlzsQiBEg8QI1wuM/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/w+yJoyh4uJKWQryeRh5ue+Ncfe3FGeTklOQ4QJzqbdb4hJV2
	nW7CPmjDf4nxVS7vSCSH+6RMXlfNsD5vYqrw5M0jpB1drXPX2EtC86MI
X-Gm-Gg: Acq92OE2Wn8o0ORYEZgJyTAacG86HagGD+PTd+mAolcqMekB/vVui37uID1EONfBLMS
	uQHkYIW1QNMfIoCwcG7wgMESXRK5kl6+0TVEDL6+8V+6hOoR23monhq9yNsg96iTVfZnTpou1dO
	3BuP75+/HR+AcHZvCcVNzZYshvq4zhKX6RLny1ZmFSj4l4amYEnXUBaimP6Yl2IyQS1B1SDFE/K
	55DwqEkhB+0j7zEu6W2VdOCZBgpoFlfIQUE6WeA6iOQvxNkSQ99GZBqqYLZUhKASddU1Jor8LtI
	4DH/stjiI53fcgmV7xuyZJ+8kRN17RrOre7gTUvtgtRSGD/wFAiNizseKZ108VnRm3GAIfjXca2
	ZRJ1WsZg1lURw1MSQIbECzN0H9KmKY1lsDxUGO6pKt68A4OS4KleIRJAOd+HRp2OgSKTwx9MLM6
	MEKPbvYXoNci/IrpdCYxh32MAZizJGwL7XVj/BCduEgz4NJDTgTm2KWDe4ZGkWspa5wsbNMNqZd
	Ot9wzhcE1KeKd8BOPyMhE8T8Uz6xtU41WH+wbiY6gcKk7OJfkgCtVEjaQfTWT1L3k3cmgM=
X-Received: by 2002:a05:600d:8448:b0:48f:fb0d:8d86 with SMTP id 5b1f17b1804b1-48ffb0d8ea0mr83999885e9.32.1779039033987;
        Sun, 17 May 2026 10:30:33 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ffed68baesm35541065e9.0.2026.05.17.10.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:30:33 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 17 May 2026 18:30:27 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 09/10] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <yrabhhhdkzmiuxlqzrrj6a47ftlzwvva7r2korzeszdy4yqrin@xl6obhhnnas4>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-9-d26bfd20ee3d@analog.com>
 <20260517155843.7f833658@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517155843.7f833658@jic23-huawei>

On 26/05/17 03:58PM, Jonathan Cameron wrote:
> On Fri, 08 May 2026 18:00:25 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> > control Parallel Port, Digital Ramp Generator and OSK parameters.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> I'm fine with phase and frequency as defined, but for the scaling it made me wonder.
> For outvoltage0 channels the assumption the value is the peak voltage so if
> we know what input to be modulated by the ramp generator can we express them
> in volts (well milivolts) rather than as a scaling multiplier?

The DAC output is current-based and differential. Voltage conversion would happen
outside the device... using a resistor load or an op-amp transimpedance stage,
and I am no expert on that, but that often requires impedance matching so voltage
levels may depend on the frequency. Then, I suppose that voltage is not the right
unit to use.

The scale here controls the amplitude of the varying signal. Assuming the peak voltage
(amplitude) is constant means we have a constant envelope, but that should not mean
we can't control it or it should not mean that the hardware can have other ways to
control it. That said, scale behaves as a "gain multiplier".

> 
> That seems to me like it fits better with the overall ABI.
> 
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		For a channel that allows amplitude control through buffers, this
> > +		represents the value for a base amplitude scale. The actual output
> > +		amplitude scale is a result with the sum of this value.
> > +
> 
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc
> 
> Silly question perhaps but can work out how this related to millivolts/sec
> That might make a more intuitive interface than scaling multiplier per sec
> Perhaps the combination with offset makes this impossible though maybe that
> could be a expressed as a voltage offset?  Afterall if the amplitude being
> scaled is 5V then 5 * (offset + scale) = 5 * offset + 5 * scale
>  
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Amplitude scale rate of change in 1/s for channels that ramp
> > +		amplitude. This value may be influenced by the channel's
> > +		sampling_frequency setting.
> 
> 

-- 
Kind regards,

Rodrigo Alencar
