Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426D244685
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206008; cv=none; b=VmL9/9U/NX9+3bbeT4NaOjdwclJYGAQ+aozJw5qJu+ZvUT4sUu8LO/pK7ebK8n6lutcjZXL5DsvldU9JoPWcdKd91FaBpb48P3pHffFj6bUelwX4GToQez4utjz3XZdCg83gqdSrd6fCpAhDuDY8ZMro0+AKyOVwYaGESVQYLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206008; c=relaxed/simple;
	bh=0Mt8K9MMFmE77LzxRrxaJYlclFNZFcdDFmhDKTkmLs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EivMiqSbJXxmwt9rwo/cq+fz4tB5HnKa8Ix0shOWUMH2CldAbbmKI0ykvzPXnNHP2tqy3hTgUIId6pGvQBxtN4W+xQAVUceIXTZeW23+Drf31vAg2seK6x4TbUuF0rzaUBufXS7fn5iWtsm1pgQXWpfTGFgMKd/ZifRXlKvME5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHIStUyL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHIStUyL"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c648bc907ebso8591024a12.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 22:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773206007; x=1773810807; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJbYP8cp7eraGSBSW0Vq/Otq0nICsguS5QRhgAYuVLY=;
        b=SHIStUyLC/e3p8rtMuwRoQbbwpXKd4YYPQqky9TTPJIq/5ycvsbAl5R7RP73Fx95fD
         r3TRBvXogWk6mtAEl2cdycgg7F1zLpkCRIANLEyjDRG0QKaBfIek+SiOMNfzEniH06Gk
         +5Wpxf8xgzI//l5ZTGx8G4S1zyxwfWlgpASboerdZQSy+YKIFmBaBMqH4qVV98U72rxp
         Y9eBfPFZ3KeKPlGHfXKOxqOMvwEvYtmA9NAwUCAcrZuZux2jVKGAF7yYEmIF8OQ4j4Z8
         Xy977ZWFSTvMQYjbM7zeGdeBxLTbvZBXLF9vrU1xKCIaEP6wibgnec70vvqXaYCBX4Ax
         HvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206007; x=1773810807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJbYP8cp7eraGSBSW0Vq/Otq0nICsguS5QRhgAYuVLY=;
        b=fPlSJRkbNPqEC0EsUUbJ+Vy62InNxcoVhzNAoXyQUQ8xiZf0sigtnuPcZVbOl0n5NT
         QwZ8QVtI+90w4gilTg8PeGdkHUbi8kLVU7ZBzS0NxnnrLdtlfJDpQGqK8hMtXTa8i6gV
         G5pje2D0/PpCv/ILAhq36vY3ckEjxAHQdK8VgPKZOfi8LSiiqMpm6JLGNyBjbWngWHFF
         X+c1WIKzBImY4cndSxfOZ6yEZ+DPnu8s1ikFluzAWsd3/h8ibzTQu9DwGA+Nm3m379kw
         PO2Z4AYOWkkVr9vxdyRhfRxAlLAeHdkbHPonZRk0KP+WiGbZL6VFt6kkeYowXwQHS7wr
         W6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWPo0Rbq2gA+zrlYj5r907bmU/Sy8UGwWXkYPOmypwm6SWmFzwOgLuGu+e2xT6qb7zBiMfZFeQ1EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB501ioQqGEqqCz0AqRRJg6/0SuLLDzyJSBA7M9JjEZXyu6edh
	CsnIAb+Kf+26l8Pju/3CMa/f8AaKHEMULKj2/wdWDwe1zNGykTbF7xh/
X-Gm-Gg: ATEYQzxylSqn4ZQxe0o544Vtf6XW+2MqFRy047D5/0/mqOI3aRarl0C+EWHDFTPgQ7+
	57kIHb8QfyC8Ttz3gQLJ5KjpA3TSy2EDfp/c37yCXnmu0DPv7udjAONUzk+40m79f25D2qbyhLf
	RKFEaxzYlKdgLoOO0xYIEiQP0WVi3AdK1KdV59OhYDQn/a5Z3lgdn1Q/TlVDDsfyop/z46iBF9L
	aSIO7mRLawqiJprI0Z3Dj2adFp3hDzc5weIQdYOS8DmZI6+ja9QjUD6Q5+LA6m67LB7/wssv5lj
	TLg8REA2XNvx40y+plmrftWYHU9iSTMIzhQ0K67f5ezyIP2o8U59Jp/ITy9XXTB866grmhJvXlw
	s/Wv+sp4LPLRGfsAFUNChQrFu/zxfCVtnyDyl38MvZBqnsjENQ7klpdoI2yovcq9ZdJAbyJz9ng
	3UjoQSFIqNcCAdDCqpnqOfux8J
X-Received: by 2002:a17:903:174e:b0:2ae:5104:571e with SMTP id d9443c01a7336-2aeae76fa46mr13435925ad.9.1773206006604;
        Tue, 10 Mar 2026 22:13:26 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:27e8:1c1d:af76:30f5:4937])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34e009sm9599435ad.46.2026.03.10.22.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:13:26 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:43:19 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ShiHao <i.shihao.999@gmail.com>, marcelo.schmitt@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	till@linux.com
Subject: Re: Request for guidence
Message-ID: <abD572bpEU8f9Uil@fedora>
References: <aapjuiq0JSVWfmWA@fedora>
 <ebb8bcb5-660c-409c-89b1-d473ba5140d3@gmail.com>
 <aa_yTUNAmkOUnN7j@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa_yTUNAmkOUnN7j@ashevche-desk.local>

On Tue, Mar 10, 2026 at 12:28:29PM +0200, Andy Shevchenko wrote:
> We are already in the relevant mailing list, so if ShiHao wants to work on IIO
> drivers, welcome!

> With Best Regards,
> Andy Shevchenko
>
>
Hello,
	First of all, thank you all for your time and responses. After
	learning that the IIO driver development project will not be
	part of this year’s GSoC, I shifted my preparation toward the
	DT binding project idea since it aligns with my driver development
	goals and Thank you, Andy, for letting me know that I can still
	work on driver development. However, I still have no clear idea
	how to get started.

	My main questions are: how should I begin, which sensors currently
	need drivers, and what happens if someone else is already working
	on a particular driver? Would it still be possible for me to
	contribute?

	Therefore, I would really appreciate some guidance on how to get
	started. Any help would be greatly appreciated. Thank you all again.

With sincere regards,
Shi Hao

