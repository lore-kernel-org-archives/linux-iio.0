Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2F3D1703
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164409; cv=none; b=LsEP2NZIfXcvl7EbuU93shc1S2Zmj9RQ2tan3GRt0h/vuyKYTymUKAoODP7sU89z8qnhUTDpYCvsSCbgQt4YTIMcd7NERSmoSjJ5XkWjod087XN0W3UDSvZ2+lEH696hlCdQf8q55kBJDXsBGPojn9aZ7dO9whHRYSpKI6mgcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164409; c=relaxed/simple;
	bh=LMn4qc23kZmbtO9digNXmsXytqt9CbR3rzjyfJC2Ql0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+JtKRuaGxFBa2exjOz+tpw1WtT73yEdn6uHVGAUYuTXKrbzDSrXY00yghkwsvC59I0HHLlCFSXQ0z4HuInT/95ROhAE8hNL3ZTGpcCUp9HSwkk3htTJjKMbQ8qJ35KlkEqFoud4KPCepe1XGGNs2xCtHHJ/kKZSyheiq7FXco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7aJXea8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7aJXea8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48541edecf9so16236865e9.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164406; x=1773769206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVxfFQImu4rmagtSPHzZv/3zF1+zO2gFWp3OTxNGBHA=;
        b=K7aJXea8If+YmJ0ry7pmff0RAVnaMIwnX02e/Vfra+1Ny0UiqmUI8W8aLSfG+QdR8Q
         /JGdPB8v7pxNQj42O5cDI4ArIcGWtfb/Pr81iuGdulgXW6hmnDCE71qTBBMMH6Lwy2c9
         HWowPS7eChTmNDybIAdCiWGK8biY774/JbAygQYAMTed09PDuUmTnoqU1Ihho/FHbup0
         49+t+Q5XI8Tbz946KC7liLv4ZXJi/4Vk/+/A4rWXXcerJC7OKfWW2Gg4MAGVSizCSiR+
         HgOCy1zuuf3MmBQ59RqKwg7aKRBcYfoSefDw7q1ikKBjFZq333Iyyg0yppg3L1nqOiUp
         fQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164406; x=1773769206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVxfFQImu4rmagtSPHzZv/3zF1+zO2gFWp3OTxNGBHA=;
        b=LfCHTPrXrQza6FuQJ/M9U053NobqBfGbqBb6O2nXdFfDyh7XbpHjI0BCqWN04A4s+C
         uZ+ZQSJcZ41u27pkMLqJlY4wtJnaOBJXggWjQ15YUuXzw29NVnDvqlV8QlDi5hA4uM0r
         k0KZ/gpcVruW0lVq9qqX9w7wNPNy/izSxZ/Q5io19n3swZ7PjhOAJyK8fAus0Dz1DAke
         QryuuSxX1YAeoGcYJo+FHrvCTZqfj98SBFfH+ysl/TMnwwOp4ho6k9dGq/dR3KXdlghZ
         0wOD0FhCQk+FVynFnVniGzGaedjObWKek2YNmHFCEMAtbZU21uWbsSJqdp+R5CZjkc05
         eD6w==
X-Forwarded-Encrypted: i=1; AJvYcCUGi9iYW1ng9d06lL2uCM2qv38AgdB27Q7iUec/DiZZCgXtx9ZYNK0ZBJVYSvig3xVjPJ0HqWYVbH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/RxjYiuVqe51Qp8HFNLWVYOvKGfkA0XNQYabHgZ761VkeEib
	eRgTZ6L9Y4cc6X9q8j/N9o6DSiVi6hWB7hAU+YRD6ggdG33tvkdRXZ8Z
X-Gm-Gg: ATEYQzxqe2bwNdyHCdMya/A0mMDXC04EEukYvyK5xgH5hDFcr8Mj1HTX2mvDICmBA2J
	lCiUyDz2P10m/BY5EZlW8TfK7Uv1C24E9uEUzB1U6rsMNbHxbRKxqdNkLoducSog9AUGvLIJg2d
	6Wx6tOeqrmYITg6ZK4Oy8BbRxio3ivM3f5ytJr3KHvAnWvnUaxPPd2ATBHcUpXKfgWOyCe4bfhN
	DFtvgOxmvF5v82mSuf62OD0qVOBvxHRwGxG4uvqRduKacM4lV8XLBsDZ4Ie+tQAj4kRQ4eUdDGZ
	98jBZSnIuG94u2V+03QpVLE6cKPFS5lWRtzIbuCic3ozdIB5LWHdbffGZ1Y6yeT3gXPhvqZXvQm
	NiIIC87wj4Qvw31k1uZ9N3t/XkZwy9iPlLfAIDM9ID3iNu5A8WaHz/D7zJpHW8KG4s66EYtlIXC
	aEULQH1jH1/YT8QaksGIG5tQPffMvnVlDeQioMri4p61ausctEPb1P2MsgIVXZim+rw9kF4T6j8
	sLcJBHg+Ho8V0cn5nhsd7ALb1hR0WoRU1+VFhElXBjiPik2fJM=
X-Received: by 2002:a05:600c:3e11:b0:485:3a22:69b9 with SMTP id 5b1f17b1804b1-4853a226f66mr135265105e9.29.1773164406109;
        Tue, 10 Mar 2026 10:40:06 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm93793475e9.8.2026.03.10.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:40:05 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 10 Mar 2026 17:40:00 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 6/8] iio: frequency: ad9910: add RAM mode support
Message-ID: <bxcybwaz3am7nrrfcjuvkbbe7yp4vwcxwwh4dafaj5dsy622s7@m4vdam6tyaht>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-6-3b264aa48a10@analog.com>
 <20260301133153.7f2f8501@jic23-huawei>
 <20260307140735.5ec2e608@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307140735.5ec2e608@jic23-huawei>

On 26/03/07 02:07PM, Jonathan Cameron wrote:
> On Sun, 1 Mar 2026 13:31:53 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 20 Feb 2026 16:46:10 +0000
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > 
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add RAM channel with support for profile-based control. This includes:
> > > - RAM data loading via binary sysfs attribute (ram_data);  
> > 
> > I'm not sure that's a long term viable path.  We either need
> > to figure out how to do it as firmware file load, or via an output buffer.
> > 
> > Firmware load would probably be too static and I'm not sure quite
> > how we map these to IIO output buffers.
> 
> We would have to carry it for ever which is very much not ideal.
> The firmware approach has the same issue, but can be thought of
> as defaults at boot time forever.  If no defaults then we use whatever
> we come up with as the long term solution.

I was thinking about the firmware approach:
- Normally a driver would request the firmware during probe and the
  filename would be pre-defined.
- Less statically, It could have an attribute that once written, it would
  request the RAM contents (e.g. under /lib/firmware/ad9910_ram.bin).
  It could be the enable attribute itself (but that would not be effective
  when the binary would not change), or a separate one (e.g. destination),
  or a new one (e.g. load_en)
- Alternatively  we can also have an attribute (like 'filename') that once written,
  loads a firmware file under /lib/firmware/<value-of-filename>.bin 

I am currently using libiio to write the sysfs binary attribute. Thus,
the downside of the firmware approach is that I would have to use something
else when changing a firmware file remotely (as libiio would not support this).
 
Also, the buffer approach has its problems, mostly because triggered buffers
are not really designed for multi-buffer support, even though it could work
along side the DMA engine one (that I am using with the parallel port).
Additionally, userspace tools are not yet ready for multi-buffer support.
Also, an IIO buffer might give a sense of data streaming capabilities,
not a one-shot load that I need here.

-- 
Kind regards,

Rodrigo Alencar
