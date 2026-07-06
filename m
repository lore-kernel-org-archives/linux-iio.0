Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464341A77B
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347818; cv=none; b=RrDARP4Wa6Y44LeqRhimMMa9anwfQH9igBfZMDe75fSRb8kkvQRV1qemYbfZV1RDTPSpYn3obY9TvycfU7kpcEP3eMsXQrTBL711ZP6Am7MvLiSD1VhSUkSmqjh+7eLOa7hjwTSai6xmlQghUMfb1L5HUJzKbhiwpB2I+/nYIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347818; c=relaxed/simple;
	bh=8CbFWVtRpoJ/dg+s1T9+12n3yadu8+YmzUT3cFMlc3Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIkGuq5HeW9sY+bj3OpQ6Isb27Cd6ZIVjFmqDX9Ay/4yulk46nRNPTf9pu/BdHA2xPGEnY4gl4wUxDVig6u28GmeTof78Hq30VjXLeRu1IFzPkiEmw4hYCAuwKy0dFI327BrRM5NT67WVnxSKP+P2h7E8Em4ob6JdecQmGubS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/UmHCRC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/UmHCRC"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c126b8118afso380484166b.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783347815; x=1783952615; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rb4WFEujjXzehfKuMBJOFD79jYlgZCDeugvdupzI6Yk=;
        b=k/UmHCRClEBU8ZbQdfNAFR6+tcoJ+NIWLTd5WMlxdR6llbUVdpM75S27bNtkDIVxso
         qg2EQEt0Y3Ugs3THhOuNG7aHVFpjeTIiWXeiODkbwnax9THfl2feFi4Q+OyTAmJC0FcT
         CPxVkDiL34P2aes/GnlYFaIsS6ZTL39mFs7576cN8YtBpYQCpRKQSFP1OyRP6zqE0utr
         fdYEi0r3I3jCQrd0WRY6KDuNfNBTU6H70rqt3F1I2IBM7xcq7pC5rFfEbgm8vykC04Ce
         SzgjVPcf18nmrEQFxjnjiMByaekqN3IOgNUlRRz4ZGG1bRttp/WVeVcC3wMA2q9hx7QI
         DL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783347815; x=1783952615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rb4WFEujjXzehfKuMBJOFD79jYlgZCDeugvdupzI6Yk=;
        b=hPfUwXIbljxkOvgqxuIAGawRmcVjyWeOZUaZc/4n+k5zsb531QWnKQ+57vCDSwuRA/
         i67iwrxY2wxtQqIlNy2z8b7f2XUdIUNVJ68yZ8y+uuLJwPf6Sxh716Th8ikHywr1R37L
         ibeadIhQGgYrLWtEbZOPcEA0IQzJwAGSMouZmjYafvFC9Ugy2FijikYSPNbJ8tE9y9My
         vMx1kOoTPpGcr0+yiK1ejVz/k0g2yv6SrByHTlgA4Iffr21XlsYlvmqF6FlPaOOjSJTv
         NNEq1tmzWOELNy3+Z8IPEhpCsvm3KDc8YuuG2dDKLWMD2EJa7HJV+E4MzyuVtmfoWrfA
         KS4A==
X-Gm-Message-State: AOJu0YyTqXUKoyBjuWCnjDuwf/BhtWVyzBmAbYiLnIaRlWHxhbgso5Q+
	xtjpZc70ix5Ds1imSAjcOQqze0QlMeOtSc+HNfYRJDVENnR9uEL4sxaR
X-Gm-Gg: AfdE7cmWGSZtRu3n5yvl/sLyIHWuG5Fap9K1O2OjuDy2E00tRzBhBiE/zS9P3QzoS36
	lbhVGL9Ufou27kOnsBXQZBV4bUV5fj999rbFZwzXrHSoavu3wKFbyKhQD48FwGVgF5AmW/ChO/A
	2TJSPVIYLDWzt/+oYzPyFwjhIZ3+Z8JC/pRrteqKQihO/Z/IrqyhPJS1L/wvZ2fGF1G+CvxkFs9
	9csU94LNl8AidUie8+EeBPfFaGItGuf+fSogi/QVXSwQrVh7qLbc9X3eIeI9/R2l9xm9QJG//c/
	Tw1tXTpONceULUaExypFZC1o5xNG5XF0YBuoCJzoGIUsBN9hjEFZziUhCGr/pKI0iDT8sF5hNfQ
	YK5TOJ6rhJp2lYIqUArWbHTvOlwuSuQUOjwX74GifwX0HGHj19Ro8UXBLuCgt4grgLbe2Aio0xO
	TyDXOoRNHgOUWcWijcioCzulumeVQmWbiI1U0bXEh8TK5MyK9963tFc+Kp5WHTFWvs9GuclHceQ
	dyHlSa0byu9Hi36
X-Received: by 2002:a17:906:846b:b0:c12:45fc:c57 with SMTP id a640c23a62f3a-c15a67d8d09mr36734966b.11.1783347815101;
        Mon, 06 Jul 2026 07:23:35 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19dbedf4sm4229761a12.29.2026.07.06.07.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:23:34 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 6 Jul 2026 15:23:28 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 16/16] docs: iio: add documentation for ad9910 driver
Message-ID: <p77cvtvjmo7hr6i6jxhfxps3if6fyy5kdwxrwlcnsziixycyen@rf5zfchlxgt6>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-16-79125ffbe430@analog.com>
 <20260703193059.4deda617@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703193059.4deda617@jic23-huawei>

On 03/07/26 19:30, Jonathan Cameron wrote:
> On Thu, 18 Jun 2026 14:27:32 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > DDS modes, attributes and ABI usage examples.

...

> > +Digital ramp generator (DRG)
> > +----------------------------
> > +
> > +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> > +hardware. The active ramp target (destination) is selected by enabling the
> > +corresponding typed channel at channel number 130:
> > +
> > +- ``out_frequency130`` (label ``drg_frequency``) — ramp targets frequency
> > +- ``out_phase130`` (label ``drg_phase``) — ramp targets phase
> > +- ``out_altcurrent130`` (label ``drg_amplitude``) — ramp targets amplitude
> > +
> > +Writing ``en=1`` to one of these channels enables the DRG and switches its
> > +destination. Writing ``en=0`` disables the DRG if the channel is the current
> > +active destination; writing to an already-inactive destination is a no-op.
> > +
> > +Each destination channel also exposes a read-only ``scale`` attribute
> > +reporting the physical quantity per ramp register LSB, which allows converting
> > +raw limit codes to physical values.
> > +
> > +The two ramp channels ``out_altcurrent131`` (``drg_rising``) and
> > +``out_altcurrent132`` (``drg_falling``) configure ascending and descending
> > +ramp parameters independently.
> > +
> > +Destination channel attributes
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``en``
> > +     - boolean
> > +     - Enable the DRG with this channel as the active destination. Only one
> > +       destination can be active at a time.
> > +
> > +   * - ``scale``
> > +     - Hz/LSB, rad/LSB or mA/LSB
> > +     - Read-only. Physical quantity per raw units. Multiply a ramp
> > +       rising/falling channel ``raw`` value by this scale to get the physical
> > +       ramp target.
> > +
> > +Ramp channel attributes
> > +^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``dwell_en``
> > +     - boolean
> > +     - Enable dwell at the ramp limit. When disabled, the ramp
> > +       auto-transitions at this limit without waiting for the DRCTL pin.
> > +       Disabling both creates a bidirectional continuous ramp (triangular
> > +       pattern). Other combinations create single-shot ramps at the DRCTL
> > +       pin transition.
> > +
> > +   * - ``raw``
> > +     - integer (64-bit)
> > +     - Ramp limit expressed as a raw DRG register code in
> > +       :math:`[0, 2^{32}-1]`. The physical value is ``raw * scale`` where
> > +       ``scale`` is read from the active destination channel.
> > +
> > +   * - ``sampling_frequency``
> > +     - Hz
> > +     - Ramp clock rate. Controlled by an integer divider; the written value
> > +       is adjusted to the nearest supported rate.
> > +
> > +   * - ``raw_roc``
> > +     - /s
> > +     - Rate of change. Number of register codes advanced per second, computed
> > +       from the hardware step size and the current ramp clock. Writing
> > +       requires ``sampling_frequency`` to be configured first.
> > +
> > +Usage examples
> > +^^^^^^^^^^^^^^
> > +
> > +Configure a frequency sweep from 40 MHz to 60 MHz with a rate of change of
> > +25 GHz/s:
> > +
> > +.. code-block:: bash
> > +
> > +  # Disable dwell on both limits for a bidirectional continuous ramp
> > +  echo 0 > /sys/bus/iio/devices/iio\:device0/out_altcurrent131_dwell_en
> > +  echo 0 > /sys/bus/iio/devices/iio\:device0/out_altcurrent132_dwell_en
> > +
> > +  # Set ramp rate at 250 MHz
> > +  echo 250000000 > /sys/bus/iio/devices/iio\:device0/out_altcurrent131_sampling_frequency
> > +  echo 250000000 > /sys/bus/iio/devices/iio\:device0/out_altcurrent132_sampling_frequency
> > +
> > +  # read the frequency scale to convert physical values to raw units
> > +  cat /sys/bus/iio/devices/iio\:device0/out_frequency130_scale
> > +  0.232830643650
> > +
> > +  # 40 MHz / 0.232830643650 = 171798692
> > +  echo 171798692 > /sys/bus/iio/devices/iio\:device0/out_altcurrent131_raw
> > +  # 60 MHz / 0.232830643650 = 257698038
> > +  echo 257698038 > /sys/bus/iio/devices/iio\:device0/out_altcurrent132_raw
> 
> Why is this writing frequencies to altcurrent channels? Shouldn't this be the
> frequency ones?

All the attributes for ramp up/down channels would do the same thing in separate
channel types: sampling_frequency, raw, raw_roc and dwell_en... do we need frequency
and phase ones? For the DRG, right now I have:

* out_frequency130: en, scale
* out_phase130: en, scale
* out_altcurrent130: en: scale
	* out_altcurrent131: raw, raw_roc, dwell_en, sampling_frequency
	* out_altcurrent132: raw, raw_roc, dwell_en, sampling_frequency
 
> > +
> > +  # 25 GHz/s / 0.232830643650 = 107374182402
> > +  echo 107374182402 > /sys/bus/iio/devices/iio\:device0/out_altcurrent131_raw_roc
> > +  echo 107374182402 > /sys/bus/iio/devices/iio\:device0/out_altcurrent132_raw_roc
> > +
> > +  # Enable the DRG with frequency as the destination
> > +  echo 1 > /sys/bus/iio/devices/iio\:device0/out_frequency130_en
> > +

...

-- 
Kind regards,

Rodrigo Alencar
