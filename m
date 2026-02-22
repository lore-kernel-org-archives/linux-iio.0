Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA21F8AC5
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795382; cv=none; b=pgNC3B7NW1DiZyJ3j2uw1cSovwr/z3pqK57+JXvhdn+CQLA+OYDNs0m+pGKylLzxAJw6k81+KhfzTTVYHg1pDaifmyb29b89PmYVUQo9Z0OVaoKvCd4bgsUVK6IPsMWNfQtW00DSmcmToSn4U+v+UtfrJAutt/OwoliD4p+KfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795382; c=relaxed/simple;
	bh=WCdEEysCfFHilfIMREfv0nttIGQIFkVVAYeoZz7ZyS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOYRFPi3xZKeZ4KFVS2ZZCIx1oanc0KwAhhDr0xFP9LPdIF1Zpp2kfw32U5pkYIK6Y/FszQ8iAKmHd3ub11WqLrhJOJ6Ps5fCPiCNPbn/vq2+KDFfTprmCoauhK3HPfNcOioocSCuvbPTvP0zCK3PrUEg36mDjmsI3J4WPLWaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5tF5D/k; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5tF5D/k"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba94dbf739so3927705eec.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771795381; x=1772400181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldEryRDzDm8Q81a/Tw1YqMlSWTl4WRirEf7oJhSEzuY=;
        b=A5tF5D/knlBfb1INnzDUt4+CluwwHjucP+EC72xFpPDlIMyxfTrjIcYtiULjEI9aCJ
         F0MGouxBlk6CTr9SyxqsGPh6UJquwr5x4WuZp1pRKU2/IaU/b8mU89uBmbxeTbs1V47i
         5V/32AmERS64cYiLlH4UKBxbS82QyCl/TMC2bEBWaKhcNQJZPMOtOalGlKThQQUYiMk/
         PDPSxPXTlZK3Zn7s8Qm8jTgmtXwHBhaAwaJD5Zm4Q4htbYM/MQ/mqxHFov9nKWT0yRSE
         WF9wBjOwFq0mT8JM2gWQnGz6A8JwrFk18cVVbbsMVSD70DkIivvgBR4zKxfhcJEW1pMo
         t7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771795381; x=1772400181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldEryRDzDm8Q81a/Tw1YqMlSWTl4WRirEf7oJhSEzuY=;
        b=agxR44J8YKTJnH7mIuiNCD/oMCA2n6kJtvtYIqImXzxuiQKDOHCu2CQJebBiEPRWVB
         ycPkUgEUoerfU0W+gzz5CH//jDEDD/6+EJW5DbMBkxKbrEQGimO3DpAen6lYT7WZ5E4s
         v0/QtXhZT+07B1Id8NpS8z251zuGNQgKr+LB2gBAs6JY7Jj24ii0wFBJkdlJMx2Q8/5Y
         I+v61rvty/AaC++XgprcmWsY/6cmYfLlvG0+VTLPrAQiRw1KTyrrmh8VNL8gh2Qlp8u3
         BG4ZZPy2T0mKfenWMsznLOaJuKlK27NvgpUfbIp+JcbrjYsGd8x/kky89G5rFn8E9d4i
         7DtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxtjqPe9aSicO+XAW5u2seO8G40ghr8LGhoSTOCogkWrwYUUAhe8dNx7qYbw5nqMe9X0CKFvH+SEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Ph2fFcb+9CYWveFpVyrj4wpDHOxO1ylFYrCzC0GmeaBMsW+h
	iv74++VzPHN1jjUjw7imclGclTkBmdyAC1S8cjTTQJ6p9mbZlJ9+bW59QBijPA==
X-Gm-Gg: AZuq6aIWjGXf7nEXaOu/1oQOdp+GctpU/hQhbjyqrilI5gZ9M2ljDelmIi8OF1uF/Ik
	gdSUM9xdHdiocR9GZaMI7UHEvk5H5OlzaDSi4vBaK3BLtXaxtdWbOjL/dUzCpGgDodjnDbFPdjP
	SpPIiLKBAX3tzFuj9vjGJMbMjqQGirwRSJeTlL7LnaJSoekmhZ1FwC9QUBEVwoVJXmLuJ6aHiMs
	OqhdOjR8+FGgr9n+wOuYBOQBXjLC6MFPbllfaeUgIatqFPwhOvfx8Or8MhdXTaLvZMtMPHEi7sy
	Der1oOFOt7A3M5Nwk3G6iXoBkoSTjgh9uFJjUeJKEej8dFt31Z+kls4qa1tMIIv4CD04SC8Hafz
	Gi0On40Ng3zJQjAOJ6TPb5k9/3wvPJeMWYauNXBUQAeO/ZdWMTQjYx63BQxhtBV/BF46xlQ+ddc
	339E2hrQ9xlOjTNFZcaaifNtKpVFjDGvrXHO++WCBwg7n913uVw3ixC6iSkuTmHNE=
X-Received: by 2002:a05:7300:6144:b0:2ba:8961:e1a1 with SMTP id 5a478bee46e88-2bd7bd0470amr3213309eec.22.1771795380867;
        Sun, 22 Feb 2026 13:23:00 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc16203sm3727038eec.27.2026.02.22.13.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 13:23:00 -0800 (PST)
Date: Sun, 22 Feb 2026 13:22:57 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: adc: ti-ads7950: normalize return value of
 gpio_get
Message-ID: <aZtznp8ZuALzC9N2@google.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-2-dmitry.torokhov@gmail.com>
 <20260222140315.33e5e97c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222140315.33e5e97c@jic23-huawei>

On Sun, Feb 22, 2026 at 02:03:15PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Feb 2026 18:29:25 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > The GPIO get callback is expected to return 0 or 1 (or a negative error
> > code). Ensure that the value returned by ti_ads7950_get() for output
> > pins is normalized to the [0, 1] range.
> Fixes?  I'm not quite sure with something that says 'expected'

Will add a tag.

Thanks.

-- 
Dmitry
