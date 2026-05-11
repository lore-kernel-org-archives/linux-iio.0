Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353336D500
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507514; cv=none; b=oK1a0Vm6E2HDE/qiog7K88PV8GqQPQtU+JHV8+GGKOpDVh/2pZM4XvI8KOJbfcj4JwCe4OJIWfBpd81PniBgpVWFnR6yDKOf8GMaNeScJWnhPbCReEBiAGUjHPQ3kh0TKuhpyK28VX3hWj7Ru//BQG3CYiJthFRUtcA8A/D1tbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507514; c=relaxed/simple;
	bh=2iMdxLBMBXZOZ7V8NCf45LrUL9RPzQinwtYufDSic48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LdkQ0ciXOAR1zj8I0KhEchlkU/VAI57colVdt1OHrm4jy5c5ihCVct0U1rsYW+vBO5MRXrCDt/TUV8RrGxpkL9O0IhD0eA1tHW3HFe6l6U5hc4a8ltyEGckruUpzr4qiKqPZa/m6TxOKLBlErsgl1ZXq0uCdLZSqLmrNgM6ugA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSShJodS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSShJodS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so457891f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507512; x=1779112312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iMdxLBMBXZOZ7V8NCf45LrUL9RPzQinwtYufDSic48=;
        b=XSShJodSywv0XxU6NaV9nBXq0Oz53SuGDBCw8PshLgjb0YIGUR6eP5gONWi9+ZThYC
         YRe2trAv3BO8+6PELlhkDCb4/KryOc7FfpLYiQpQmZPZLIOyy1HlyfJ7gXcQiUfVzToB
         WIpm+AClfkby5OTKqSWgQh8QCkK5SsENhZJekdQWqtPB7rHQtZacg8PLlNx+eszg5nwl
         2EaBwL2YZrJ+NPDxxqP+iO+JtN/6/Drh3DaxdKBDyquLuxY+bm5XYqEGz+zQqCFqRFN5
         jLIMm4Z1nWRyRD+RQtEgkZESW2KFlzOuBmFQEIaFWKwlEyTpc2XDreEGw8hoZ1Hiayo9
         bgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507512; x=1779112312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iMdxLBMBXZOZ7V8NCf45LrUL9RPzQinwtYufDSic48=;
        b=lk7PcFs2gUS2RZ9eo0R/oRslLPFI0E0YEmQPzDoFb3oCJalhgMAwUkDV9jvQKRs98f
         xwHJZ8xGyS1q3BZw3c42YX4jTxud3zU/C6t+oW/8K1vneP25A/kEITXpMBT/awFDWFDC
         MIfD1yOXGhbprkt8djlu21A9i/vJrFNJz1YLVmlKOE7OGFFCrlZ+WCS9TQeduB0YxU/6
         tNp638LDNwRDvby06PCgMZfaNVf2fPL8aMQVkoyY+liNCK1PcysjL5RKeYdkfj1FObBi
         7kJ48ZUfYhoa2kSntp8t9p2dRQ2NxTpVGiqEpGj6tQrM5p7/smMaj7VXJBj3MAaMzzXx
         Ccvw==
X-Forwarded-Encrypted: i=1; AFNElJ9AXG9iJHfCOAtgyzphjSBeahJYZjYSD2MXB6lYJybAL9yU1qoXdQfbjRgPy44V9GIOdB2PZ7tdLSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0y1+kZwcVXvYuA6/jZxqSaEoy4UhsRGKM8kdWEq1rkncUg7d
	xJA57eAk/Dc42htx2HUKnSfCUbSjc4N4xUD5yhuuOJl/DlH0wrGgc9n9
X-Gm-Gg: Acq92OGE0uWlQP5SdA+xYdo9G2paFD3+oZPh1dWbzhNiuvVUSOim4vgvnXBQ+7XxN+0
	sOPbI587qjYs6nYVpl+dRyBSJx0T8ZAoIWMWFM7TFH4K7Z8OXjPAX+ae6bGqq0OkXiDY/cAuj5D
	r9/IuVsfa/wiXRC1RtdZFybZDTt4sNtLnQ4CvVw/CMguDkrEfDfV474dAVFM35Nk/gPVaq9xKt7
	vadg7C84s4mB4aMszMJ3a+Ajg+rUcWQ3xXDBhmW+XfPZG0PLRigEvY0OuBQd5phgJ2omIqW4LPH
	tR+pRQhdE0Tlb2fWSHb7nV4jKTs+jiBSNxzDd8+l/8oWNoOgD7ncxE6moqL2q3zGEjUQ/MuvtAu
	USCsWB6yuIdN9iCm3kMQUIVCLqUrOLikdzyf9lDzLUbT34rP521UiRKws1zDpPYNbDvwXOTfW1L
	UnUs4JtgA9oRS2+xS20ML8PTWivc2/A3jGLBfoHwdyoI+9
X-Received: by 2002:a05:6000:4517:b0:448:71e8:4b3b with SMTP id ffacd0b85a97d-451a71f62e6mr10427768f8f.5.1778507511730;
        Mon, 11 May 2026 06:51:51 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454916df968sm26717165f8f.25.2026.05.11.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:51:51 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andriy.shevchenko@intel.com
Cc: joshua.crofts1@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Date: Mon, 11 May 2026 11:36:28 +0500
Message-Id: <20260511063628.913-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260511060732.7728-1-sozdayvek@gmail.com>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, May 11, 2026 at 18:46, Andy Shevchenko wrote:
> Looking at this and taking into account the above, have you checked the
> - trigger lifetime versus platform device
> - parent-child relationship in the sysfs
>
> The latter might lead to interesting side-effects.

You are right -- the parent change is the real concern here, not
just the cleanup ladder.

Checked the rest of IIO: there are 26 other devm_iio_trigger_alloc()
callers in drivers/iio/, and all of them pass a non-NULL parent
(typically &client->dev, &spi->dev or &indio_dev->dev). The
iio-trig-interrupt driver with NULL parent is the only exception.

devm_iio_trigger_alloc() requires a non-NULL parent for devres
tracking, so the conversion necessarily introduces one. The
trigger then becomes a child of the platform device both in the
device tree and in sysfs, and its lifetime is tied to pdev
unbind instead of the (former) manual .remove().

If preserving the parent-less behavior is required for userspace
or for any subtle reason I have not thought of, please drop both
v1 and v2 of this patch. I do not have the IIO trigger framework
background to argue that the parent change is safe.

If the conversion is acceptable (in line with the rest of IIO),
v2 already addresses the dev_err()/local-device/commit-message
nits.

Stepan
