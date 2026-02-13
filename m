Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E30362135
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002310; cv=none; b=a7m73zkTisqSUiQFfcNuQKDCliZhOYI8uVSzsbbFyzaXTuOlr/JtCgV3bMSZ/xRKYb3WNVuPgiBnWGXoqhj2risPQt/pDfqehPZFumEE3DbWgYIpwMtZHvbUKfLV4maf0JonlEBfUtSWoZd8VguXpu3c6EYxBgw4Nr+uEEqC+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002310; c=relaxed/simple;
	bh=KwNeEzFfWpRzRcqhfUMoelVTv6pBfRhBCYE/TnDdz7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p22G4uhe4U5g2DjnMXM2/SXgBIzkQUcZGzTIy8oIM+Ty909s7cdSjyT4h+o9hWHHyXJNnNzzoLDmBhWfCluztoenYljE6pHs8fe4y6RxZv34JSnOOykAoahBvkromZo9n59lU7jyrMEtg4d2vOus722gwlL8mpxURW7+hYWyfxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3swaOtr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3swaOtr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so13091465e9.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 09:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771002308; x=1771607108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwNeEzFfWpRzRcqhfUMoelVTv6pBfRhBCYE/TnDdz7Y=;
        b=j3swaOtrWX+ICcmlGpYBGFVBPi7vYPYEOJlXoJcb075ywwrI+FZgG/mrTxSthH1D48
         cyAnDA8IiyZoYK+pcNgaBh1nXbICKVaXg/UYvmUyxMqhtUv4JsHjwHcU/tIFQcT3BtHu
         Juk6oSrP8SfW559YWFhhXiGCbx81QugVRJmMTu7XAn4hVW26KRjv3v/v97qmv5Kygw9y
         Jvz2t/3q3kjnOTXTZnVrig0gym06dc3e/ar8e8mPzXox2g222NBVzzADTmCxGR4cjWGM
         qzCniwlo0v0ZuqFuJ92lq2ePo1aYfFb4ttm2orRxxVsgkpXAlQOrjsPmUKoCaqGzM7Cu
         yPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771002308; x=1771607108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KwNeEzFfWpRzRcqhfUMoelVTv6pBfRhBCYE/TnDdz7Y=;
        b=q49mNXOvZbwjzD3MoKyPVEfGYOeF5fZHEfR4xroMoynQHY2TMLFiMjvuzNo8UhQ4Vr
         lJUkt2gr8DxQTgSQrK1FcFEU7b7m/omo4KI/eP1JTyD+BQce9/xDht7Zx95KpiJoQKbP
         3ogfY5JEUbT658/RFk5lDlEKVg68z5EmdogufTUVtd2YGC0PS54aPlJn6ql7eWx0uyx7
         s5lxq4SY3Jux3KYOjvqT7svN5mIqT7gDqt9iDMKkd0QtY/ApFTj2L7GT4JPLDILhHxoc
         Rk9ovdct8gODInxXwWk2TfRHbf3980vHfwrmpanCTxHQZT9zSRKfCcLYyfkf4lDUMexj
         8z7w==
X-Forwarded-Encrypted: i=1; AJvYcCUFD2kkmJ5CeAGxi0rrySqjbsMouZAz8dEjcHffLfEk4HV8DjVkT2HeIYQoKhwecR6QCbRxs3zu4mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCCI1+QdqL7s6QizNWOAK5bcCDDpdNflRetdYBaGRAReHsXzw
	rt24LwJviE4Vr8wC+XeE7WOlm7C2OEjBrytsZGnvmiO0yz/G3IiJVxIt
X-Gm-Gg: AZuq6aJ1ZcbH+Gpu8RHT/BEoQNcQUyytNChTQ5Cx1sYTK0tG9WikZUT0MXLZxjPB1Aj
	/VFq3wOs2ejf6Amcd/e1xrkkMKf2x3Szxae7ArGDNnukyAKOmgCLWpLIYT/PlYwzEGCDnnrmGse
	onBdIQlW3ZA+5lCJsckLauA8lQvO+iPIqtQZZuW23sv7vU7dchcxcH/eCaqqn8IBtuNMa8yqCZ5
	5judLOzcR7JwmQwdWHbDSiOfFwbnRAY199Rl8g0/dcsD618iYrv70LRD6atUhCShLFuhCnIFAyS
	iXL2IBJ3Z/iwvvjztZnuwLoZNggXHSm2xmZLW+B5ESZ9MysGIeMxv0JZMcgC4xBRyCyNmjwfWXb
	7TNR9ytUMSjEMbCWyv35vzZMkJB4dGEaW1OOryBujc3GgtHnw/5Bt83RBNDwMABQ17fmypvtirp
	GqC3k1OFkoG+wx2i0s+qyElbS9cGt4f2tYxxHz9xIjMYIwxRH0m6gRUZ8u/rxoyT6i
X-Received: by 2002:a05:600c:4f86:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-483739ff886mr38808915e9.6.1771002307427;
        Fri, 13 Feb 2026 09:05:07 -0800 (PST)
Received: from db07.UM6P.local ([196.200.180.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b4cdsm7701637f8f.8.2026.02.13.09.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 09:05:06 -0800 (PST)
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
	linux-mentees@lists.linuxfoundation.org,
	me@brighamcampbell.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v1 2/2] iio: dac: ad5504: use adi,output-range-volts for scale calculation
Date: Fri, 13 Feb 2026 18:05:02 +0100
Message-ID: <20260213170502.28465-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aY40-0v9tbXC4tPY@smile.fi.intel.com>
References: <aY40-0v9tbXC4tPY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy,

Thank you for the detailed feedback, I'll make sure to add those changes
in the upcoming v2 series.

Best regards,
Taha
