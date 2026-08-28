Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1953E8684
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905820; cv=none; b=VNdfN84wpnc9coYe32+7HSpnXAVBEe5g87LzH6qsnBmQRUuBDjv6S31nGBe3vdcPfmS5X+N6Olqb6il5sR5iCR2JbRoqXHpls3EdYG+pYsrcvsMP6jtRjuYBccX4RC6vzlq7XEdy5l1UhAvTEFmjZFs8+Ukl/hzgIcv6/s76oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905820; c=relaxed/simple;
	bh=GLA5oKT4l4TtK6WJBIZEYUg8utU5djMOzvUMR1WxBoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoNete+bAA3ustkxwL3Cvkc7JZmEfEZI0supGWVGwrrJMwuELG5p9ggieeJBmkCmG84Edh5WCsV8Z0jPeBExAAakSqLi93hRu+NfnxM7+d7FNegoUlPxE6oAhpKsD+4hAEI9UzJ7bBxkX+355sZGqoktp+w9Nb375+Yinh5TLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sws5ycGY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sws5ycGY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso4373385e9.2
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787905817; x=1788510617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hdOFtk2wc0usZRCfuezTXZZjP4O5N5A5OTF6t81pXEo=;
        b=sws5ycGY5UZuXS9+GvUZgGpKGfn6VJ2OXjHQiYaKWfOghCIopyO2eBfuiIyeHO8Xv9
         P3eJdUAKymHGLwj5PLFMqHQvggHcACdBTWNU8k7vKazKqUos5IDKRzLMrtzLv7Q2TQ8P
         rpjgQqdPnztte+WwuAu7oiImByEKF8bCx0ytcYo4T2L94jVebieMPeMaRufNwUYjbIfA
         w1p4EmNsdnt8G/n53LT/OVIvMEtEXwlPM+vzVne+vLU0+Mxe9fyvh6Oitln9FEi7eKpF
         zRqvusBjzw1xPR9bAlNScYNW7OgcCOM3w0gasCzNzLL/LfGmiZLVv9uuKztU+K6TqKrH
         XQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787905817; x=1788510617;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hdOFtk2wc0usZRCfuezTXZZjP4O5N5A5OTF6t81pXEo=;
        b=Lj6gQKsCHXoHQqtOEpQhM0b/edsZCpx6FduXGUgWEIx2fT/PjPHhawENuAT8r7uwze
         DRXDIQUKwewcfPkzoHlZAvaBZXEDlnbDfEs1KavOYkQyisxnzqVySjCv86OFYQzLIk8/
         AlTVNRnoLv6LyeBmy+hC8Bprj5lcmoHZLyDVGuX5M2Zz11KCt57edThuC88/wGoEiO3B
         Hb0ijvEYjbbUWR7ZJXoG1D64/X5+qf9v7yCm0QrsmRh+K3qRJzMbyzAw//nd7ws/1UOF
         PAFp9FFBegUgFgqZ+NPrUmFLcBgmXaExw6NqAciP6lReb3NkzkTmWbA8mfQNcAemtUYX
         NZRw==
X-Forwarded-Encrypted: i=1; AHgh+RodF7EPLDyUb7aeWrIhHeau3Trki0A+9XM9Cygw/Jh8bvZwU+9bbIXwRw10SJZH0ayYH1WWGDegnqU=@vger.kernel.org
X-Gm-Message-State: AFuF++lVGw7OkoCm0mpBUnqnHxUbSzT+2lqZAU4m5XYVnZJAkYc2Uqdo
	Lt1CYt4yNegf2NTgbv0yUcns/cg0chQDgbxK5XwtMhcKePTw3FqFWWVR
X-Gm-Gg: AR+sD11hboN/Ik+GeBtF41AsMirLZRWnDai7RIOz6QitI/ldO655rMJ3/CMkpAmcn8o
	t+c66TV5lx0JBmabJmtbuhZBLLHGJId1nS+OkVGxMwmXEIT/e/YCxnqfWRcBMCCixvKV7rL1xDH
	+9dzkvkDqnF+itSFRHeVDS/76uuYU8WPBEcinVJmTM9tSs23nj6/1/tDDM5RpZvTbEwczotminM
	IEndKl5TsLoiuyT/uiRZHbAJv3KTGkMS1BdXe3D8YAOwSVkGR8WPMiNbrEGsI6d9fLHnyTirO2F
	5BJbKALMYmkPGBOEE40+PrATJFJ9ryMCZc+7REJXstBPlassnBgut4bePedIOZkJTjeNEhDkOxh
	kPoHsZdh4z12qVozpn1CDtVUJky3FtXXWXXhWUb31KHMmfyDzOiGZaoRCB2Q7BOIxRKjI1eJFA2
	ZHV7nEwzCLF1v69pfak6NBE4kX3FRYmMyDQbLmKRsmXt7rixgKyUp8wACMujMCoHiJt6mh7LmhU
	wgmVLtRTAnbSD2YVx2qJy5DD7Wg3IyAYP7vQmpd0NC2SgQLTFo8O4NNmMs4LQMVFz+FZT3IFtYF
	3ngxUYiu+yTGrbcjdS5cQEVcICexW0mWP7lvsD1f8TQI5edupun2vGd/7ObVDJZAuCNBpZeBvcS
	VdtQCu9FvSpBhPx3irixNAPWb1dQPxxxA+W/0UyCkikMfDhibOIHmr+nMDJxVZiU9qLue2g==
X-Received: by 2002:a05:600c:3f0b:b0:49b:9105:cdaf with SMTP id 5b1f17b1804b1-49b91c30753mr76811845e9.8.1787905815458;
        Fri, 28 Aug 2026 01:30:15 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b945816f2sm41136805e9.8.2026.08.28.01.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:30:15 -0700 (PDT)
Date: Fri, 28 Aug 2026 10:30:13 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Anshul Dalal <anshulusr@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: ltr390: Remove stale TODOs
Message-ID: <20260828103013.0000315a@gmail.com>
In-Reply-To: <apFDQhk9TUoLnEZt@gmail.com>
References: <apFDQhk9TUoLnEZt@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 01:13:54 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> Remove stale TODOs from ltr390.c. All features have already been
> implemented by Abhash Jha<abhashkumarjha123@gmail.com>'s patches:
> 
> [1] Configurable gain and resolution
> [2] Suspend/resume support
> [3] Support for reading the ALS
> [4] Interrupt support
> 
> Link: https://git.kernel.org/torvalds/c/13fad2607dad [1]
> Link: https://git.kernel.org/torvalds/c/288ce72fb5fc [2]
> Link: https://git.kernel.org/torvalds/c/14e0d914a855 [3]
> Link: https://git.kernel.org/torvalds/c/7ca4b8957066 [4]
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---

Next time, please wait at least 24 hours before sending a new
version.

-- 
Kind regards,
Joshua Crofts
