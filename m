Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA31A9F85
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771128412; cv=pass; b=dAihdzA1STE3w666JtQqd5d6vdKX7wPQ4q9S/t1GyUtIdg68o2bG3ryqrAWzSeizzfiBxP5RdTWDuGLCindjuLRbGKz/DIjaa32pCqOtb97WXBBr9Q3Z8IYvDc3a1B6BlOd/Z4EKBzDzQcn+T+s+U258I6wD4/efipSuTXw846Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771128412; c=relaxed/simple;
	bh=Cg/UB636EWecP2AJFXinJ2G1jlune6FD0wjfEnUOnmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnzUF2elNdQ2iG8g7a2rXWxCzX2sH5X4M9S6ovV9GCRhJqBoGy+Zr+3q3XTcIzKh2JIEoKmxIOmSvr4GrQJ8fLNavffBSgBfXGF3B92w2QOlH5mtA88DwmVhjsTEypwqTqCDv5xWw7Xuf++vq41KMaE2a/FsocKGMLl7WuBbKRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMoww0kX; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMoww0kX"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8946d9872ebso4348536d6.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 20:06:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771128410; cv=none;
        d=google.com; s=arc-20240605;
        b=IiQ3upQlF3PAvlLIcqJHtHOeJpLJfVSRAYM2gIE0QKKt97jicYgvtFoxOJpvH5qIPp
         bXSjGkzT4rBurCh6LY9rTc445y4rEiTXoClgSUIoJFbiu9axYyATFIR9zlDBwG9ssRbO
         5T2mjeL/Kkl3L3O81QLHykabXUUz1dHvZ51BFUDk6mtEyfSJoMZADobt3uYtn281IiLo
         JVU3Cea1t+GYQhU0+80MaE03PEyhzWmYV/Z1NtN1Ps/77oNnmulEgcgEXDQFVlUwnxdM
         hjXA/pi+e9VHtaElnwalSqeAqvuqfHP2HWRc14B3lIOt0fBAUzfxRaIR1XqvJ47IoIa7
         uEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cg/UB636EWecP2AJFXinJ2G1jlune6FD0wjfEnUOnmY=;
        fh=QlRS3sL9Rp5yFP7UBjMrZ263oTB99vIJDcBQYIdXFcc=;
        b=ZqawKoRnwSu4YEfrl4aEEQbwGP+dTAGPDPoKNsG1ZPEjl+X+NgfOXqZoPuuWEvA/SV
         slUloJ8aNSeHlv40mYOZwEW4gl6oZBnk093uMDIkmKpHq11IyKiHQjdzse6dTUnl8xe/
         Qcf2XRSUnzkm4KLs83zRrH6Gyjq1wuZAYTpysUtOpIQ29Wv1Wc1v8/aiGm2haJhuXBv1
         rlWHU+ku5ex2Vj3QvnDbxx2Cdf0m+jqKJgyrt5W2QhRWzp2nCVD0ravgSUHDrLJPpV1X
         Vk/iAua/JpGufHX1Wj+oH9Ce9Ns7DAoDeDWa00qK0Z9f9KQMDFWoi9OQpIAstTHDTsSw
         g6/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771128410; x=1771733210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg/UB636EWecP2AJFXinJ2G1jlune6FD0wjfEnUOnmY=;
        b=kMoww0kXWSlb1Nnb4D9BQREmWwLMT4Z7xy9RF29WOXk77PH3Lh8iyIIfZr9+uVLNBK
         rm3oOMDgs8ErPZvVjyWzbfVA681hrkjPN0w/1+1VXCms+cU2i3z7K/sDbL1zN/y6LtA2
         qxx/kGlnhnT+CrlTcnLs/8Bh3vI+3G3BLzG4GCI4aRjMgldUXkMGsTWxiUG4PBEVRVXf
         te9nLFkLdQH91V/H2nUeZ5Ug+N1aKzB3rEySaa1WQNDBlw0dv4XtJiIlBOK1FDHVuCXG
         VVyHYxtI5x+iPMeTj/llFheSu+g4+CjAynbt8mPCwYFJN93fiM8vP+cNUkU/sWhc4ROS
         WdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771128410; x=1771733210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cg/UB636EWecP2AJFXinJ2G1jlune6FD0wjfEnUOnmY=;
        b=j2yOW7kMC3PH6U92D+0ImNi+BGtLZ5KRW5RJE/mf7U//fr5KwJ4iQ7XwhRfALp/dm4
         5nTqMXpk0nWoTadw0/u5AZRVHRCBWiZmQJMNZjGUcgFMsvEmuv6lQ4NfAsnGxfmCSgk4
         N9QVVh4RZq54L7XHZhqi0uWYZahWBy5TGj/P5A4rNmcRZ1sBH7YCASLmX8GIw8UKiIm6
         MD+gh8n7LRYSnrex6ilblt8+FJ556gaT0HlQzBhK1S5t7/J/428k+/lKOQ0Vtmtk2DOT
         f2yA3ahEHQzs1q+siZc09ZK2RG/ij+ownIhnQo5NNWLvq7KrChwBM2qhKrIgl9xNh2yS
         zQtw==
X-Forwarded-Encrypted: i=1; AJvYcCWMzF1JWViM4Y0uiz28+hn+1QwMt7OzRn8MALuisJpT+bDpT33e4WoDFrGuj/+9m5iwWexncZr5Sec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfg1wHUxg4yL0d7Re4dDb8t3erElf//u2JXy5AiJ/KqiTU7tyc
	4oG7HXdqHQdOGizaiSTefrTrA0BMbNMxvEGsNVqZDwnnorEutQv6faJV194v/HT6KrfgVGIX0/S
	mFlEiNK2alJxMJEUkTG7r5Gvg22qqxg4=
X-Gm-Gg: AZuq6aLcHAebV6b+9f4Ni5jnovBgKOiF9fFYTViABoFEcFwHbj9tHUYxUvrbJxdWk8r
	3ErY93c8/T3CG2laqeK4/cqJN1nmb5+xqCKzEtpOTAU7D72ENN+JwhZSOfo2Pps1W44LZi03mEX
	+3IGbs2jsVrH424eQIhQH3tTISVqRCIAKtdQpMRt/gPvB5gJ9Xh5AmgEzQLssKPT2HY49SWS/gE
	TlSjb/4Ce3rKYN9iIt+tLEsDe0yB3L2Z33CixZj6JvfxCYQ4cb12nr5ru98C93J5wCu2IEpr3Ot
	AwtmmBc2HFeOqNAChuz8yu+LTSuwYnCHAaXwYkCWfZBkcEl/ws41q2UYVnSZjgLfdq7LQMc5
X-Received: by 2002:ac8:594b:0:b0:4ee:87e:dedf with SMTP id
 d75a77b69052e-506a6a2d1acmr74533191cf.8.1771128410127; Sat, 14 Feb 2026
 20:06:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
 <20260213-upstream-20260219-v3-2-df9371d29f5c@gmail.com> <aY9TtJQoIyLVqqR-@smile.fi.intel.com>
 <20260214174312.7f6e299f@jic23-huawei>
In-Reply-To: <20260214174312.7f6e299f@jic23-huawei>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Sun, 15 Feb 2026 12:06:38 +0800
X-Gm-Features: AZwV_Qh7AlN2Nm6jnpkv5cFhBmD9NtGsFQfL1-LB27hQtvR_tsPptkMgUA5H0yE
Message-ID: <CA+NOmzKYv4H70axDMo3POufOW3ryTYVJ-=_rfvVaD2XkSS1FOA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: proximity: hx9023s: Protect against division
 by zero in set_samp_freq
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 1:43=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 13 Feb 2026 18:39:16 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Fri, Feb 13, 2026 at 11:14:44PM +0800, Yasin Lee wrote:
> > > Avoid division by zero when sampling frequency is unspecified.
> >
> > In case of agreement this is the desired behaviour you can add
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> It seems sensible to me as avoids undefined behaviour + is
> unlikely to make any functional difference as I assume that whatever
> we got from the undef never in practice matched a valid input.
>
> So applied patches 1 and 2 to my fixes-togreg branch. I'm not pushing
> that out just now though as I want rc1 to rebase it on first.
>
> Thanks,
>
> Jonathan
>

Hi Jonathan,

That's great! Thank you for applying the entire series, and thanks to
Andy and Krzysztof for the detailed review and guidance throughout the
process.

Best regards,
Yasin Lee

> >
>
