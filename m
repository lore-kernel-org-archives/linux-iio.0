Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AE318ED2
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439405; cv=none; b=DYyVczLUS24yUUpp9hM8Euq72uhBSYzBAcBQDmP8XtCDcHmCrJkQ+ydQCq3URVRoE+TtrCPDXgYzWdmqllnvwjb5DUhuhzvUvVP9dD9zbCbNx0TC5u1N4jtivPWowluNMUxwSHz/kqBLewpkAh/cUiQjT+y4FkgID9TUz44+zQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439405; c=relaxed/simple;
	bh=nG8VbUCo04qNygpcvwEIwTEOiOHEpFF7Xeq5Z0lGM08=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZl7dVkTOYxOzGA2MMUJ7zNhkLdkR6l7nY3ZoJ+aZ8IZBVRFEcGQsZjK4Z+2xCVdlM6HFVoPQBr34sPVLmqnyazT8nagyFtfRb6/yTFLrTwueRBwOfFm2TJhZjAefcjqBzyx1ljsYoCcgfq9Pb2dJPzH3mNwDAmakfLO/3kXpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTzgwlf+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTzgwlf+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47edffe5540so52855285e9.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 06:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769439402; x=1770044202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+etScuCg6btjK6PPOTn2PuUBXtwzqdki48tfvDWBzM=;
        b=CTzgwlf+2RYct0ICuo552ERoav1kP2vNkBYTVIgi5a40O9XfRHToMOJiZu+7TnaJBn
         N7jwTtvjyNriQWsfd7fohv0FLaMKaG2p90zaN39DT7fMwtaAUHjPIoBTdXIQvMcXHIzu
         rGb0KQa/tFvUFf4m4FQ1j/VjwQwwaptY8cp+Kysw2AIOkZM5mIx2GKnfVY79QaBVHXFu
         MIg3HXeYEFpKK21DHfiIfCAL8EqF96DeigoMhy2CGRNMSTfzu9rWfSBcZaneKwa9egp7
         0kJKf8IFnjV/orUZW1QfnO+vK527D8XgGltL7inPuPfu3OLV6cMT67Bo/Xg8k4KDuuj6
         f1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769439402; x=1770044202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+etScuCg6btjK6PPOTn2PuUBXtwzqdki48tfvDWBzM=;
        b=a/itlwTAYQfaPXcffwI9cZXikQkuvwuIkLhEWB55fkW0A1LiGVDatDOOekg4Rm+cGW
         tVBYG8wU+4XazJfQgCTVc5SoannpFY3loCYt7XUWWh+pV3eAlVKgnovunzuoQWlfU87T
         zoijUXn6Ts0ZlMjNoDZIhV1SdGZI9QzPKaHZi6LVM8PONL3aW49habYlw0PvvxE0eMfq
         9dC+YVCVVIoaFqib7+jT8h3/2RYVizKz3khqt7BWdX/ob29UcADb+toVIF9Ii1GKMxPH
         tOcPD6Amw5OHBPsw5swWMaHI8v0sI+0Otw0LGPNYfg1fhevfN08u0hdDdgzaIeTI3VZ0
         rvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKeu73LnN7FtXGUIIeQOc3AsCmJXQZ/OWtzUT0hEa0arU2Q0oRDxS6DYJv/+f7X+YgBKDKEF8NOlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAoDJHc81VNYjJJ0KRCDVzU6TzqI6LNitN2rN6mjsLUO78irH
	3/sOb1A60bQQR5gNRxcYXf7Jla1l7D0Y2Se9TQJNCJ4sVaLH1l/F+hZC
X-Gm-Gg: AZuq6aJRKVcE7TXRFGi0hJOOVU7k3eY+5SPiI2mwJ57MnobN+P2t6N+CVCHW7R/fJdy
	wqMKHVXY+R5YVftZwNo1k7uMO1YTTrYUCGT9txTzKamObvxCfHu3HJVZjRw3BVhIVTAtTmyf1gx
	QxaBp52gvCcPHjF+sbf+QT/Usqtw+bp1X4ROTTjD2aYacmh/4XIuifAd3klKM5Jii2F6QIzDurE
	XaZXebQAU5TAPmaZL6BRR//ip64fL5kRhR0tzRGqs5skdqK4ZtSimlmBONh8zI15rYfYbq7ZdZ7
	RBZ59Zrc/fd7FkcIBNKr2pcQnfY/nm+h9qzQOnHyr2MaeG5/N5f7z0Y+oq5pHmsNweooUdKj3ag
	HJVkg/D1Uyxio8eUzw7kOoWGaCUcOfMcjGHanJfCWMVeogRhQrGMiEBdt4H3Oym0PbYa3cIgf7r
	Mu/EOp4d8B8iE9Sftfe4xA7YR/aEMBagV7OxEK5UWEMevMt3Gx0/DvQR+Y9/Rdvrjvhbvn7Rtlw
	UO8
X-Received: by 2002:a05:600c:64cf:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4805d065e43mr73015565e9.27.1769439402395;
        Mon, 26 Jan 2026 06:56:42 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbda9edsm103545855e9.19.2026.01.26.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 06:56:41 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 26 Jan 2026 14:56:34 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <udbqdpfcarcngai23u2oo5zekjzvu6dptem732rdvlsxiry2vs@aeqvxjusdx5s>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>

On 26/01/26 01:49PM, Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> > to parse numbers from a string.
> > A helper function __iio_str_to_fixpoint64() replaces
> > __iio_str_to_fixpoint() implementation, extending its usage for
> > 64-bit fixed-point parsing.
> 
> ...
> 
> > +/**
> > + * __iio_str_to_fixpoint64() - Parse a fixed-point number from a string
> > + * @str: The string to parse
> > + * @fract_mult: Multiplier for the first decimal place, should be a power of 10
> 
> > + * @integer: The integer part of the number
> > + * @fract: The fractional part of the number
> 
> Can we use struct s64_fract? (Yes, you would need to add a couple of lines into
> math.h for that, but don't worry, I will Ack such a change immediately.)

Sorry, I missed this. s64_fract would be declared as:

struct s64_fract {
	__s64 numerator;
	__s64 denominator;
};

and numerator and denominator is not really applicable here. This type seems to be
used to declare fractions.

kind regards,

Rodrigo Alencar
