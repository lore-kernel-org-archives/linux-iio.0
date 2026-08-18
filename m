Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361D417BE9
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042217; cv=none; b=tqqT+hZZ2Gc3iB49uR3URJBhebZlFFkSa+1tGOQH3PdYdG3tDkK4kgoGmUsNiPqQIttTyZ8aQs9O8uICGsCd+Hy1iEMsuj8mUaGvCoQUSrO2+Bd1HL+6d2QwtidQxG4B8ZYoP2KbJXxUg9sOphUDM+kXgehiJSJHpURAejQ3pS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042217; c=relaxed/simple;
	bh=Dfo0Xrwp9V97ak1qpmm9XRmx3ltOhqU4Ss8r29txj2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8Xg75xOB7GueFb02H2HMDWVkxyd83LwCJgT1WnA/X/lWzh6yUX7woyFU+cWj54b9MBPnHs8MsXSs3bT+u8KbMVSsipXwcfKpncfIFFVLQi6lEpqEcqyjLsnAnsTgkgZE3ne1SFWDY3khnOFMZCjnPUb7kumDcBfRvDwB2AHZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9rjPLVm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9rjPLVm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4994c49f588so8073405e9.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787042215; x=1787647015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dfo0Xrwp9V97ak1qpmm9XRmx3ltOhqU4Ss8r29txj2U=;
        b=B9rjPLVmY9qhBVglCvWv1bEQPSvKLcav0kRZQVB/pylu/1EIicTudvubAlr8/wsoKk
         8J0IhT9wNtURdjq684HkNFYGI41OtGV5uLKfChxWpmKFZU2/B5RxKlLT0w5lJ647pIUx
         OgtWzjB2nF6sO8mXvd66a79qa1Mms+Xyhsh4g1xuu+MXSX2FdDGke9B1yD2osHe1WHb/
         O6tLHOoY82p+6Jb0izRFA/oEKWiZZ3baWM/cusvoufjcQ7NEAp4xausdAJlziRkl0WgH
         QkdgjvSzA0zr03Hix01CJR3y25IajU+jGczx4ezpXu1mfzS26C80VxC7XyuFCi8AT3dP
         sgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042215; x=1787647015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dfo0Xrwp9V97ak1qpmm9XRmx3ltOhqU4Ss8r29txj2U=;
        b=onAP5SYjN4PclFRaU3X2DKeR+kS0zQ+jYpbTe+1mV1yURs//gw7R2oj+S4FcRPlNIk
         A9wIOdb1hlAMSSoLdeiN7d4bCACURMSnb15fSiaPnsZZgd42Ej+JAQuTHv/3xlnRfLPf
         iObEMAoVay17DGbdqoEUPL1oQ/kdwl7k7GU6smzPNneerghCByhozFgG3mMNwEdgBTgq
         PfU3BbRIeoJiup1lxI2UhyeKQsVu1LZbT+EgF4ITO2+cvx8DjQsu2wK/XBmf8o1czAfT
         F8Bg4ipghZIIV+US8XVwrbUL3iRwOxu+7wlHBG/87YfmfKnl//juSIfq413nDgqxljfM
         eK3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqx+TwINQytQvB5DDQSeu5rlfyWF8swFw311bdtbk3OgK2yWQUwg0KH8z23vLSazRYfSBpN/kDWOEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfJVYg2TIxOXsFd11R6j1ooECxfYxMb8Ym4Daj7B9ew/Z4Yih
	mr6vgRyG4ljjuKM4z90leUKbS2ySa0dIjl2kRfxWwIHf11x/nA8pBexI
X-Gm-Gg: AR+sD117ddx3m5DGqzn7v58e4HPmwvC+NyNCWnfBd/j5/yHp1DpmCYm8R8WcLEZL9dI
	WlZyINxmvGKc+HhKtZ6fx0N0JL/uU0NkJ1j6p5f/u9vmWOr0ExFh0KS7UV9PQF47dpAUXt90Y1P
	MEpKvMNyaYF6GnlGL9GVMEIjmsIcH9a7ho4hpB+YqSyJNSehlQNc3hydY0r/G4GV97SrFhB6x47
	zRB/PrEGplO4bMmfW5dVmu6gmHcZ7snKRXcqB/+N/A3b02uG4qYeBZILOR5FgHq1ONuliwK+VBf
	gT1BocvmofWjAh+Mu+s+WU5MWTHuVypW/8w8zy9bmBRNgic+jqAR1sxZb+D4WaGuEoF8bt05OYJ
	Vk3DagWLwb6oOp8F4A/OZg2vTWe95P8EZyoDNoDTG9el40128fsorasGpOyBqfKyxtcSKWdknFK
	IJ930Edjo0yFxeOHRVmvSYmTEphTxGwO6xAroZEwIw4l3LXT+/wu8QZLBq0trRhgD/eAO6zTlcW
	Z2z2HTAjk/M
X-Received: by 2002:a05:600c:8b77:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499a206a553mr57451765e9.6.1787042214575;
        Tue, 18 Aug 2026 01:36:54 -0700 (PDT)
Received: from fedora ([105.71.134.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d078517sm103197425e9.5.2026.08.18.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:36:54 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 4/6] iio: dac: ad5504: introduce local lock to protect state and spi transfers
Date: Tue, 18 Aug 2026 04:36:38 -0400
Message-ID: <20260818083638.16041-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoP3wFuQBYJfEo8D@ashevche-desk.local>
References: <aoP3wFuQBYJfEo8D@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Was this message written with a help with AI?

Yes, I used AI to help with clarity and kernel mailing list
conventions. The technical content and decisions are mine, learned
from reading other drivers and review feedback. I'll keep the
messages more concise going forward.

> Always use blank line(s) to separate the guard()() from the rest of
> the code.

Will fix all guard() call sites in v5.

Best Regards,
Taha Ed-Dafili
