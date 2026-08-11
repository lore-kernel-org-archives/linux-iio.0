Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7D35C6A8
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471108; cv=none; b=MvIDlrmW/VBYIMlmDE/RoPk95eWrEiAHPsDwViC/t7S76u3ixqWa56y5LpHsYu3Ay/V37/DMvWtriTmbECBQCixgmVyjbQeh1uY+1IvPrtSQUFu4xv4UWTLkz/Eectdij7DAgY+o3mAFGvAFxebDdfUR1nsJuk8k4cJz03aYvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471108; c=relaxed/simple;
	bh=iLaLXHKEjkATRvr5OTjKneeWZjXZ0fAn/Owi4lWXZhk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W9uVcmQ3Walq6qv2f7EOAfll3r2GoLJA7+21R23TV44TpCB+bQMU8Qx5LOjckhcYaf3QRD4aMMRDKfIJs+ScNcpL3ibUYFuvwXaXCwMf80XRL/4DHQgkEV9iOEq0zCVcdQGftEC9iaPPLgvP6L1a/0Ngp/+r4xl2fUPPUTtI/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvLTR1vQ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvLTR1vQ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6685001353fso241935d50.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786471106; x=1787075906; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iLaLXHKEjkATRvr5OTjKneeWZjXZ0fAn/Owi4lWXZhk=;
        b=cvLTR1vQu6qxNrqsY0h4OVUOLfsUDMNqwq8LN+bRLk/MhbKCxz3WDnEZ3g+ZRrBDvz
         6fa0hi7t6+PzhEln3RiHru3/p73FFTvxvogT+yN6Yd/MVQTbFlKA7HMWlmi914oL3TUh
         OJhy7Z6PiGHOAwP3iUsgShHEJTwMHaXCAgTUqATvOnaRgUhKlT56XDE+JxNtrqJ5X6Ta
         WSEKZaPPfEiG/gKDUS7ZTgmjcKaOi/ly6SaazJZ8ewn+Yy+GVNelBcLKo6ilc6rwJyPa
         9j2cQJgm0oLGIixH2od86ZNmH+428cdL7d4bjbrgujSsdPY5g4k1hSKb1Xse0ZsgZd67
         Y/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786471106; x=1787075906;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLaLXHKEjkATRvr5OTjKneeWZjXZ0fAn/Owi4lWXZhk=;
        b=lXfK/R2eJ8LE2mC6xcKDsvIz6w+2ndO0GEsMOPcI4mXAv4U5LPDOuk844o1nZjCtXy
         ewXwrS4sV61O5L+I6BZlqJhv8w5hMkAy75qdnP+6h4G+9PObhiT0NLHjBfAjEclWuDMr
         F9+u78U/epQpwZsb8qqEoda7tDhldcIGG/anJCpb/mnHZpINKGAZFFzil0BfmAo9qtw2
         R597IS9kzQGz1QbeideoacPAi3g1rF2W4Lx3D5ReHG06Y4MAvEiRbm+IoDWlAYLfqr9J
         6hBYQrytr+PGch5EpXzn64/OKnVGKot1W9RIEBI5HyzG9/SPj3OWu79p0RUoHT5wbZDz
         jncA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1s3+R064PgNrJTrdZu/wII9Sp3XgEGlWkidmLWLrYupolYosZOfBWcVt1x4VfOCBAnHQIfvzluq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpuHhghSkXawoG1+qm4SgudLWeFBGcjHqjwQ89t1STUkvs1Gm
	KmJef8GSG2lfLskWQXxgEJxRGbuKaHnOts1jjo7NO0afKUvUoZYF/1ROq2lWGDU=
X-Gm-Gg: AR+sD13NKGqAi+uY6OyyHrZFXRdfcifJia0/dZCkEesniCh+b0dm3uqhaLrz2WjL4Hq
	R/y2bGzUaFPfDHjAZ8ZmznX1lCT8zffPAQJ2plhYl8qq72ZOTecMX5lImMrRUNlWP67fYkmCVoT
	cdQHx+69dXBDIEl6BX/4v0GDx7QXlRKBqJJKVQYG4I389P5v6QbjG1xO7rGYqKVTDm2mi/sDz9F
	vB1R9hygh5+FkGnnrWz69XvpLaw+DvkFZxfW9AJYSPtdJgLYnwI1EUaMLKDbXCJLyY9EF4Bd0Qg
	whkIj6kVmaRncjLQeKXDlIHGqu2m7PyUaJNGVFcZjcLpBzpTZxP0n6hJ/rO7Gj1QOgWIQHwTWyK
	PlHo3lrmybl6KInqeH7HfWf7bBwrk2z2bhgGfbqnxVQjvewITJmhpY6+nbVNlGJU/HBXLWgINhl
	ujKV3PD5nsFJoFLpNvdnxBHhzAf7992PMOSQuhrjvhHYFnwCobvU7bCYIrpLpDuiRgpW7D2VBLM
	+RA9NpRjtqanREQ3FDbRkZFcXjdKm1Yg9OE7Q4lRgpHTM8=
X-Received: by 2002:a53:e015:0:b0:668:112d:d49c with SMTP id 956f58d0204a3-66b22eed4eamr2609810d50.38.1786471105735;
        Tue, 11 Aug 2026 10:58:25 -0700 (PDT)
Received: from localhost ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66b1f2843edsm1547011d50.18.2026.08.11.10.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 10:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 14:58:19 -0300
Message-Id: <DKMB5HGIEQCW.3EKGVS7GLRBOF@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andy@kernel.org>, "Brigham Campbell" <me@brighamcampbell.com>, "Jori
 Koolstra" <jkoolstra@xs4all.nl>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Marcelo Schmitt"
 <marcelo.schmitt1@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
 <anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
 <anrRkty6ugdJUGmE@ashevche-desk.local>
 <DKM7MV8J10HS.2OIM1TDHB9VHQ@gmail.com>
 <2d7dcced-47f9-4fcf-9668-30acb9e8c9b1@baylibre.com>
In-Reply-To: <2d7dcced-47f9-4fcf-9668-30acb9e8c9b1@baylibre.com>

On Tue Aug 11, 2026 at 12:49 PM -03, David Lechner wrote:
> On 8/11/26 10:12 AM, Nicol=C3=A1s Antinori wrote:
>> On Mon Aug 10, 2026 at 4:28 PM -03, David Lechner wrote:
>>> On 8/10/26 1:32 PM, Nicol=C3=A1s Antinori wrote:
>>>> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
>>>> communication protocol and measurement conversions.
>>>>
>>>> Add the "am2320" entry to the i2c_device_id table.
>>>
>>> Interesting. No devicetree bindings for this one? What kind of
>>> system is it on?
>>>
>>=20
>> I am testing this on a Raspberry Pi 3b mounted on a protoboard.
>
> How do you tell the RPi to bind the driver?
>
> Since Raspberry Pi is ARM-based, usually we would use devicetree
> overlay to do this, which would mean that we should write a
> dt-bindings .yaml file for these chips.

I do it manually.

I use that RPi for development, at the moment the kernel I am using is=20
7.2.0-rc6-v8+ with CONFIG_AM2315=3Dm. When I need to use the AM2320 I
modprobe it with:

$ sudo modprobe am2315

And then=20

$ sudo bash -c "echo am2315 0x5c > /sys/bus/i2c/devices/i2c-1/new_device"

(With the modifications I made ... echo am2320 ... works as well)
The pins for i2c I am using are GPIO 2 (SDA) and GPIO 3 (SCL).

If a dt-binding yaml is needed I can send another patch with it!


