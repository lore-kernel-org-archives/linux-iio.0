Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921E2D8768
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774343; cv=none; b=WkXMRxurjg1nqcH9y2akVqyYCs1nBtO1rODJgeQVcG/8JCQdDfGsI6QCpNY1lOe2VWCcQ485w41j12Ejl/2G1mYRl5uAMRZtIsyPqegrYYTJV3r/mos4+JNwUhZ9qZHzBVSU1Us/hhvoL+rbBFGWZpJYz5kuhtKxs196+DE++W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774343; c=relaxed/simple;
	bh=AfuIW5bx6NIQqFRuCYTL9YvA3iAe6YCE0/eZXP4dzlk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LHLzpc4uqHuE5yCsEgdfGgpVhJIe3TGwpeMaP5Do2tHmTRdZRFwc1gIRly/bFXZvG2xmwYauQipjqS+lwoOZDr4Nq2kuPXnPOGdwZ3e2BJ+tiO4P+ep3pIWowF4OwsK1wy7PDvADr4Iv7J3PKlRd5KhmyDKbPHDYCGmsNxXtFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3jH8YS2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3jH8YS2"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso1005076a12.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 21:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772774342; x=1773379142; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqq0nZrYLqj1ui2Q6mvv3Ic3EWgM4fz5QKW3Npt78Fs=;
        b=j3jH8YS2k0vXu04OVQTrtuZjk/XtxCc2IccWCNoDdvYuWDwcXnIKFklGtrSb8BYWGt
         XiqcGAG1pp8qiHL/s+UhsCRFnZgWtRBIo2dpaF6Z0VeySV8TRQS8Gd5/VpKYz816LV7X
         9mHAWXzBUuCm+2YYjbtTqETy4sBpqaK5pJLkimisC8FrGzIEPAqrHijzE3n9DyqIfG+1
         SkaCQjKCOtDDsI9S/D71e6M9p9pGyEYrvZxNA7HhukaeoauGt40LlTBcVo068fqHEg+P
         /T1BPGmeD53XfkoAWyL/YXsPkQgS7JPIYXMqXNynIpzHULe4Ypmt4qkz4MhH3yOG7rD2
         02tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772774342; x=1773379142;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqq0nZrYLqj1ui2Q6mvv3Ic3EWgM4fz5QKW3Npt78Fs=;
        b=EPhK3vZikHNRs8C1YEfvqWXrW+ivLPrY5dOop6KAzADcawIMA2MxkZ4iGtWvFRMhZt
         DIpjA260pzJN9I7D8JhxbpjXXQcHIID2DEKwYck9Afn/Z4UXnklo6s0iSWkltGmBiYOh
         UdJfkW6MGooT3BDVZoYaSpELWr35DW+06jZeunDMSRbYdlM+MaQ8NgT6HaxGsrc22PXV
         HeRINaEb39IY4S83EKFsuN3/rEUY5FGn0ESWX3zoKD/W8qgGPatMZCgxottRxzrOGByQ
         zwVGKQfAPuEJaV/ZTJouyM5dBZAOlu/Hhv9+EpP7dbeqi5H/T2r1HBnK+pX5teMM6D3H
         4p/w==
X-Forwarded-Encrypted: i=1; AJvYcCXh2qmVstNV7WDmVGx3Y8a5jRtPNG6M+3oEdZJZCIpovkABv3IpCvOvODHZ9x5iN2aPDXXBobficDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5WxwMdGnfVXy2ABsBRMDsOA7Ob2oyUVnPDYJGvZ0nTPHmA+Q
	9WpQbEHEUgiOGW2aDN7bpJXPSIGcuCEn1J+d7LyKt8Uo8zTpWHEl7hUz
X-Gm-Gg: ATEYQzxVzdB9AkFML/Hdr0DmKfdDnKc/LIiIHJhvtxN59WK7u+cPXgodvy/lqbTeS6a
	TFcKaAiESb7W/1LI0AEpJhEBEF3AQ+zco49J7myuuJ+kUOeGGHUdLk2VAC9yxndJgOckCqGc6H3
	Ct1kfsQxCMEkXYO9vrfSKHTrGgCxsjZhTi3Fsevnuw6KgvU6vdIjpbWUrwla1Gcdyv4VJUKfbRH
	NGnE2/HU3Oy42qe8yaateiInpRkRpJn581SzOW6iq1p2QAUYQV+CjnRk/ehhdRkYa8l28xghNnx
	yN3tfoHOyMpBhMGdoJ3IlusVftI9qH4yRNv5D24X6+DYFZ/L+1fSKSg3UxQElgewoN8GFB19ZYU
	ozPysRqfeizo7CpAn91tpFkZ6o6IhWRae1hdUfs7nzVlxpfI+dqzOK48PcpkJbVF0nadYuAMcEZ
	qu/pJeCFdGtaB9IFhrFiPfqSE=
X-Received: by 2002:a17:903:2c07:b0:2a9:2ab2:e50d with SMTP id d9443c01a7336-2ae82498a30mr10966785ad.51.1772774342130;
        Thu, 05 Mar 2026 21:19:02 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:a1a3:2df:56f1:1fc3:e6dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9d228sm5214465ad.33.2026.03.05.21.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 21:19:01 -0800 (PST)
Date: Fri, 6 Mar 2026 10:48:50 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: marcelo.schmitt@analog.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com, till@linux.com
Subject: Request for guidence
Message-ID: <aapjuiq0JSVWfmWA@fedora>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

hello,

I hope everyone is doing well and fine. Recently i have been
getting prepared for gsoc 2026 for The Linux Foundation project
idea iio AD39113 driver development however i just noticed that the
project idea has been withdrawn from the list. I wanted to ask that
whether the driver develpment is still planned or it is dropped from
project idea list.

If the driver is still needed , I would be interested in contribtuting
to its development outside gsoc as well since i have no idea whether i
would be allowed for its development or not thats is why  any help would
be appreciated thank you for your time .
