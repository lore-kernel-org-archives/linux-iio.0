Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86040419303
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826087; cv=none; b=jd+X7G83TF7CfxCkKLV8ByN5Z1PaA/mt5nmj+P86k5B+JJO2rRPkobIuMTgA1QgEJBqRaoDoTJKMhnXoLcrY8hxAxCQcsDEsUzP910xypF1fKawzkigS06n0HfkwhfFHBTmmy8ZH8mZJiaOtybHYnelYFyR55P8dDaYqy0nFVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826087; c=relaxed/simple;
	bh=XC4U/RvjohytAMvYA3ZyJOjOfjBhi1bX8KkCsIJHQwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je3VGWRZOVRRFQ5M30sL6D4plxZNEJaLt4Avf9Tc8rxvxokoeiAKneBGxfW7X6BWeLY4Q+E47YCvaTBCCrSZ0NAdrDRVtXnUP+VSoKXXFDdZiZilQQkduwP6MyJKyqfh1mqRe55nVU9WOM6kpCXZnKr8eKHP7+lfmpUl843+J0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctuhH+71; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctuhH+71"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7387ac7d28cso594225137.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782826084; x=1783430884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63L3nK7vrBcvN1li6echQyTJBc1iw1dvXuudNEEXZeY=;
        b=ctuhH+71WOhWmNxFUZmYcddxVaRIOBFhzSVZN2zNsUoN/BSI/HRPG4I0qFzFq7OhUv
         9RoWr/udiLd3dxTlLNC9H7OiPI3nQH1U8uJ23R7iiLivkP8uPtN4DYW9ldu4tO+1xlcq
         X3+ogtCf+0mghmOpO2vtHFLJMVyOjAzSdFHpk9ncS5BKsBP2ebzK1+WaCRgU17+Yb+pp
         RG3n8XApgYkCIYuHk3hSTTj4ekFqVPGdDHXabFaCW74QIC1n7GBx4vMgY0q4q9pDPY5S
         cQpmeJH+1/azk8OLDXOl0FkfeR2uFO69rQE8bvuY/g/OJSE80FQhxTwjNQB0lKIawr5j
         ClJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826084; x=1783430884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63L3nK7vrBcvN1li6echQyTJBc1iw1dvXuudNEEXZeY=;
        b=X/D5BjuOkiFGcCfC+GTZkA8ujjAks8bywjOpalkMzx4mNO+rSwQkX+a9jplNoIfWdT
         OPMRYLsM9n0WmXDEv/NCVckH27KHsIvhCAOnIrHJfEtUkKrCWdJ4QdUwR7v8u8Bk9VyU
         J6j7fZJ38vqxmlZseB42vzj8AxN984RozxBILPZWtZ4+d50D0CiBoqv04Fm6xR4tXYf5
         5MLyV1FZJkNDBZTyuR/dGbw8MKFvJNLLiNnr1ccRwpcl5UtkrR5g7Oyr/b0fQgM80SnP
         Pwgx/PmZ3N35xN9U3rN0nOH7DHlLIL7tVe4/wle+E4o1krI5gVynbrqaMrPHvlKKnNaX
         wCxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+EOY9kK+Av7lkc4B3EFJNWrVsKtk2oqaspo0FsrRHdMy+vM3cQ2dra/OLNQld+cBhuBL/WvNm+hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKit4CWnTJf5IdI9dtfSqOZIJ9MsBTF/dOcQGsTNgmiudIQ2+v
	yahyZhXUzTqKIYJrXPHBZMD3QBsHRZIBWKbjQ58r0YvyVcoj/dSik3nc/VYXHqT40jc=
X-Gm-Gg: AfdE7cm1zFR2RwwtO30tQk60xUpXRgRESegv9Ie7o2UlnPgRENNFm/JI0lGEm5Jb9iz
	IiOQYguSHhqRTIaUKx0Wp92OrC07CTo/RJVoSEn/sHmd8Yc481eHKZ18RGMZlRRlkk/PTfrRv7i
	HLfjCT6nNTYsWQr59R21N7rDrQ/9CjR4rHKGmK1Y3HcYSxywUA7fL4FigS9z99TNhXDM2C3Fdkp
	436TVZJrFB0JXFfNN5usaLp9yYlWuZhhNMYzVtZCHhpUAUkDgOSN8MShVhYfQ4p5Bw848Ih8m9Z
	YKX1UePXy7JX2laxPZA3GTCx9DcoLTTtKhwHAd+23yF2H1jYLwNmX/XE1J0/1fLLfd9JThbS5CV
	hhxemlMBpN1WHYM2hilq/RB7QSvOo2j9UfSj6P4ZDkgEWXWt6VZIuR9I2oDAaTTpOAs7Zy5F6qN
	Le9z75
X-Received: by 2002:a05:6102:a48:b0:73a:e9b:26ec with SMTP id ada2fe7eead31-73a37f2634fmr1452767137.16.1782826083923;
        Tue, 30 Jun 2026 06:28:03 -0700 (PDT)
Received: from localhost ([74.80.182.83])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96965e6fb4esm909719241.1.2026.06.30.06.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:28:02 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:27:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832/ad9834: use div64_ul
 instead of do_div
Message-ID: <akPEXQ5JkmxYd35J@stanley.mountain>
References: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
 <20260630093931.00006eca@gmail.com>
 <akOwOpTIBFmSvquX@ashevche-desk.local>
 <20260630150755.0000266f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630150755.0000266f@gmail.com>

On Tue, Jun 30, 2026 at 03:07:55PM +0200, Joshua Crofts wrote:
> On Tue, 30 Jun 2026 15:02:02 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > Since we are getting more "fixes" in the area, perhaps it's a time to add
> > a comment in the code summarizing the mentioned discussion?
> > 
> 
> Good idea. I'd also mention Coccinelle and its false positive in the comment
> since patches trying to fix this always mention it (my attempt included).

Generally, if the code is old then someone has already looked at the
static checker warnings and decided the original code is fine.  You
should look up old static checker warnings on lore before sending a
patch.

regards,
dan carpenter

