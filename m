Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89051862;
	Mon, 29 Jun 2026 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760022; cv=none; b=B/z19WE1ztmlfdbpNqNvAm+jYRnoVFpiq+UWWpiNJ+qh+tFtyhj+DoAOI/FLUKHvfy5QlpC9C2tXlaCQmNooBs+l3jwX0Vuj3USRckHQuL5pbACIaOXgkqS1ss6ThaUMa72Ok531490KSYTbcYX/TACAFSfwFkyGgYLzR28xyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760022; c=relaxed/simple;
	bh=nhU7Djbv6tmVEyUKWvZQh0mf8KqAEoXfLhLl3F4PxNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJjB3EWv6ZMpwwfTTbNpfNL7qY44MopJtd0JVf8tqCzjRDycC67/szinUuBcYRX5q/UDR3Izb6ILs2hjz70DFEmhMR8Kno05ClduXCExkV2o+z8oHyjcXxQOWVBawXH+qEtabCHrOLdfmh8yRoSsuD+2NIdMigl4sue9/5FW2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl; spf=pass smtp.mailfrom=vdwaa.nl; dkim=pass (2048-bit key) header.d=vdwaa.nl header.i=@vdwaa.nl header.b=DypeOtQa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxp4aYKf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vdwaa.nl header.i=@vdwaa.nl header.b="DypeOtQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxp4aYKf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9EC497A0021;
	Mon, 29 Jun 2026 15:06:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 15:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdwaa.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782760018;
	 x=1782846418; bh=I9CcrgL+/WpP2YHpk8trygs1Bqb2qHms0/iSD2RKiTs=; b=
	DypeOtQaqqIsY/4m+77seCY//lxD7mYGrNtQ8Ghsi71xtQDI7XeGeR6Bh2Zw1BRF
	St4O5hIDbWxQtGyxO9MFau+WJXVmA7VTyHICx50Lg1lkWCZXTYeptEXCSDMxl7tm
	n7ndTXgRHDshastBp/LYp9pS+DTOxGKcirjBkI3DeLqviSXrkc2MuIBLUEQG8wjV
	jZQYF1AfuucU0+93JM0v4cRJi2a8mzc/ocWxf8ZwT4Z5P4aBu+Ns/Yg71RoTkwIv
	XVPzGnJvn3Yy3oXAin28cV2l4oNH78XjempgatZpCI6qJl6gJ9YAqdqGRUG01zLq
	qa5OhpW3JVX6O49QQ5S3LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782760018; x=
	1782846418; bh=I9CcrgL+/WpP2YHpk8trygs1Bqb2qHms0/iSD2RKiTs=; b=h
	xp4aYKf/G9pZn9JD3V6JVB+SxoL/0G9Zk0M+TwVCvUxZYWY98jQqgMXLgkFqLmdl
	wJJyc2O/f2PEDDt9Ud59KiAFRzHf51zZFg9OoIRq5gqaCQ1BI3rU+FBLXsT1cYqG
	5ttNxftTPYgaRWEfw7m/aqWnl9RfxJEXGbcUKca4egmnWgGRZhH+9aLA43nfKVZD
	5SYyNO9wTNhwurtBoXL5m0jl/iPrdg7FLOGadsTfGe17mb0SRsCcA69kWvkbjcg1
	QzOX7qOvh+doTdja20KqJw8tULmRB64e01xz4DRnwbLccLSHg48K2nu5XZzre3jJ
	gqxPb6shYo0yEqpff3sMg==
X-ME-Sender: <xms:UsJCarLoZzK9WTI-PFNNRu-ElGMXsU6arx_ZJ7I16anKYTzwywmBYQ>
    <xme:UsJCas8NhorXGlJlK5XyegvxuFiWYM8fqfcqW97C3jPXtcNdWIraQAnaBpxHKdXvn
    oNJUkDrynQOwbddh8v_ODCVQyR34sUgOX_KEmrf7yTZKJSe2gkRyxY>
X-ME-Received: <xmr:UsJCauIQkVXmlcW7RGYtwUw6UmZ07XPBbKl10O3sznHA-WM0I-R2fsy4LQNTX6L90Oo>
X-ME-Proxy-Cause: dmFkZTGAfCFNSTpoSyNlJUm5MKWQhotOj1Gws0l0Mfuwrza+kPSCSZO2PG5tIWftryJA76
    v1meXal0aA/LGJiqMn2Ylar6iSw2TQOVuT0wFyCxdQ6RfvtcJyRzd2vMF9XmV2Sp+LmwtQ
    TuKAlkQL/IQNKPUG+psV6xTXyj0RGuPeByNkIQkxlu+Aq1Y0wRzzUWTGU1Vq4ATcauelQH
    cxZwTHYEzKPHMYWHMKpgqTbgUt9kd6Da+x1WMBgzoLXJBKmGA5F+SL2FrsRV/g8stwvSN0
    oNEpjcmjA/poTsI5aOODjZ1Uxxexh/W8zC6JpMI+vxCevs3BGlWzOT8BbgLK7EtrJacpHh
    8JEF655Pi/2aucd0gsJpF62K+JNQaJ+UHuBFs5dPGmOY43YSf5Zkqmc8PlQGYWg1YfR30+
    zDv3aK97gksMKzgStXfntYhkBRL3OEr7/TE85AqE1L0zeGXbpkifVwE0iCPrANuumYBIXA
    ldv1d7U11NgrzpBGvnqprLCc4EiMKhEOZ/5FKadPYmLGv6n4sdnmzBJfARLHsg8SYbwVnq
    3OO7mOIlhPv8jHvwSHETMvtbvSqqwRNAo7yUWEWSkD2UzxlSVE/8Od0irAq5Pj9a8Ko0xw
    w5av4qa98i2VFHFN+uM9/jQwPSWwI//oKk+S33Gb9nyptb3PKsmAyE7uihMw
X-ME-Proxy: <xmx:UsJCahmK3Z6xg8Gzjo95A85Ly5JuXNRBdNNw4tpnuPpcrK9f1kLRrg>
    <xmx:UsJCaiNWXTOCcM5eFhen06D3v3qDkwnvhwpAzfRwQY12ZLxbN9esKA>
    <xmx:UsJCan0Fkpfh9414CMwNZL47KL-fMGp23X0ihAyzAqM3THUd9o_XBw>
    <xmx:UsJCahk3adL0ankiU5QLSNVvS2qNgP7MBYW-eWKenPSeiuiC8xSSrQ>
    <xmx:UsJCarGWRTnKajrPwCfvsIxBX-bxjGzVYGYgfTI3Ct4ZzGxNdS5fd6-A>
Feedback-ID: i2d0446dd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 15:06:56 -0400 (EDT)
Message-ID: <1235808b-34bd-4d9b-ba23-158ce3f113d2@vdwaa.nl>
Date: Mon, 29 Jun 2026 21:06:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio: accel: dmard09: in_accel_scale always returns -EINVAL
To: Mert Seftali <mertsftl@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
Content-Language: en-US
From: Jelle van der Waa <jelle@vdwaa.nl>
Autocrypt: addr=jelle@vdwaa.nl;
 keydata= xsBNBE6QLAIBCAC3O6LmF+GKvOh7IV00TG+EKAQHAwjESnHGJOW58lKK7eAYn62ZM1uy0+6h
 yCMu5PD7+ND6U1gcgTTHYwNK8AaJt7yY4FRssgdcJk59uJBwROZtllotClJ893CuB6Wgr68b
 07gIRbENYrB8rEoGfpUG//8/ep7sY8PS03jnFb4ll6mPlUE2oQVdYOlXgF4f9qkkIi4SQeE2
 MTuERaOrDuUNDlroJ7Yfx3J/rL5Qjn578/TKCAxg0pns6VIA/P9spRGmLhT4zP+OxZXeSZme
 IxcwFdJJXHr4oGaZvqe1yHlMmKR98rrIfPWhkw2Ls/XIZIxf6prT0XyczbzBnC2y1JyNABEB
 AAHNIkplbGxlIHZhbiBkZXIgV2FhIDxqZWxsZUB2ZHdhYS5ubD7CwHsEEwECACUCGwMGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJUX8WhAhkBAAoJEMBghjN8UHc+mFwH/jjN+Qob4O36
 YiieajRwVLGuYdUDt9Z655oQYU8V4qbWf2tjUtqTYXrxLnaY6xQoYouRz9yFbh9dIKZb67ir
 7AeVgCOtWVesGxAlGH6EY5JBZcsN0v0ScsivqQAv/Mv+4HK+XM57YlyRagD8tkprYskioWHg
 OwQfXAO6nlm4BJHWO9bHJUMgiGs7I190IKQG7iLBnJuGjsOFuy5KTLpnv+w7twmz0H+pkUPe
 jVHfJlJWdN4v1PigpgpjOR6ZepSIggMk7dHsa6GNLUOzi61yYVFe60+EGXhwyJIqSt56a4oR
 jMUcXaOugGr+JwC8Eq7Pg2+aFk+8fbe0oUzZJucHGnDOwE0ETpAsAgEIAK4Usb7B00WRxCZG
 HtM973F7V4OhOKv4kZKduxtu71bVUZsTuzn4h+m8guJ51uY/I2icUrN9gJG5aEzRqPuQi2L7
 KmZUjs3pscZWgUgiT8UZFDR6RuQ4k3CcWobsRCjYZdSblSZ8ccrLJE7xSbwKMXjAh2PEiaQT
 lS6wQbn6mHv4y3H9QVHs7+jXbmfHCxnVcwLqRmpuegSmezDaL5TlSc102voiXinhrWEZUvAB
 KDh6VuJ/60Y6zelCXVsEjRaApz90iXY1nifLhkHM8B2wG7Pum3V3X0Y0QTVD+z3EL1iq5mFu
 epKp//IOeeJN5iwHcRSJGy2s1oOzjRDyPv6v1AUAEQEAAcLAXwQYAQIACQUCTpAsAgIbDAAK
 CRDAYIYzfFB3PvDuB/0dI13hSYHW27c2Rq8BaGbIhXYYETtPD5B25/P1JJ5OQZkPmVq+vSHw
 uzUaDZHy3ZcwE+xFXzlkwXGdWos07JUGo74zV3HfeZxVEPv0HB9ACqQVU/JKjLZNj2SfhgzL
 4F+O4Zgdsf0YaZG09F5PbMvbhoCZLfAaKWz/4fLEfhrDJLhrphUyPDXosn0UxPkDv0iiixn4
 V+bEZ5/wd8dRWi58R/iND+gRGsBREm5SpzdhnsarwoX6YdsQ449379enDNUN7jV4C3Gkon2s
 VwI2ZZbS10cY8rFSAV/CJA2E9daRoz40DI0tgXgLBAVhy7y5HWZJsDZexU0HFKJfkDi7RUPj
In-Reply-To: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17/06/2026 17:53, Mert Seftali wrote:
> Hi,
> 
> I've been digging into IIO to learn my way around it, and the dmard09
> accelerometer driver caught my eye as I think its scale attribute has
> been broken since day one, so I wanted to flag it.
> 
> The channels advertise scale:
> 
>      .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> 
> which makes the core create in_accel_scale. The trouble is
> dmard09_read_raw() never handles IIO_CHAN_INFO_SCALE, it only does
> RAW, and SCALE drops straight into 'default: return -EINVAL'. So
> reading the scale just errors out:
> 
>      $ cat .../iio:deviceX/in_accel_scale
>      cat: in_accel_scale: Invalid argument
> 
> and userspace is left with raw counts it can't turn into m/s^2.
> 
> To be clear about how I found this: I don't have the hardware, I traced
> it through the core (iio_read_channel_info() -> read_raw() with the
> SCALE mask) rather than seeing it fail on a device. But the path looks
> unambiguous.
> 
> I went looking to fix it properly; add a SCALE case returning the
> sensitivity, the way dmard06 and dmard10 do, but I couldn't find a
> DMARD09 datasheet anywhere. Digging through the list archives, it looks
> like the scale was declared in the original 2016 submission but never
> implemented, and the driver was written from a vendor source without a
> datasheet to begin with. So I don't have a real number to use, and I'd
> rather not make one up.
Thanks for digging into this, I no longer have the device in question. 
But the vendor driver can be found on GitHub:

https://github.com/minstrelsy/mediatek/blob/1f49d8c87b839651bc89afc870277e8e0f2e2d55/custom/common/kernel/accelerometer/dmard09/dmard09.c

Greetings,

Jelle van der Waa
