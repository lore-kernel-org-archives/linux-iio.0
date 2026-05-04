Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C33A7852
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893213; cv=pass; b=jyYjBAJD0eg40dzM9it7Ra2sP86folCYaq2T1touIRhMU/3oehxws7/GJJIh/wmgEMxCc8xUpcZFWLC4vZaJ2XkVySe/j3vmijaOqNTlnnAVjF0RMoGpVjiqx/59vscAHxjlIQr9VzfiKM2TWgz75yyGj5iKaRePxF9pZ4jywBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893213; c=relaxed/simple;
	bh=oYKnonfmaZBau7cDmaEON2TF0MUHXDNVr4S16qH3M0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIdNFvqccrHAI/LukgxSiBcgyq4IZGPiYmoSgizTvRCGl9939+7h687vbUvbY4EBc0553zgqrB/aIMJYBTJ6n5SYn8HPCaZ1AokEJITj2AmF22YyOmzEFSz3fDSiwijsuJITrg4B9LeO7n0q0rCeVeYUt6CjI0Gnrd081k7z1S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QocniH2x; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QocniH2x"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso36878185e9.2
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 04:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777893209; cv=none;
        d=google.com; s=arc-20240605;
        b=XCSxGgTzSxgbNjrCSY84+aGiXUA5gyYcT42LotoD+bUBWtZoyexKkKIuBFvuJUKwBA
         fkFznsojBVPUafSSAsNmX8u0PeRm/7qSC9PlXj9ykdFn3yLxkGluS0o3JL3I0jj8YEBJ
         tJU9SeGsgMYbAxf7fWmAhok0xtC4FDBQBkaJ+tbiBEUC2/wI5siwVDwGIzygQIA/DJUq
         jFsgwdzI8/oZheM4WtKBfxpt5bvwXwAWARNqt6JgFuCV2JYdbRS8Pfp9JNiO0GhPP/gB
         AHZr3mGWY6ZAFt3j4BD3A8up+NvuuL9l482klXh927Opzl+jkwWVdU3tMimy8D1HWHeH
         +LAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f1RftPTz6Sb2A7zglddSxIo9ZDnyhKag5sMgvNF/OQQ=;
        fh=CXZ9Hfb6UXLyDXvgxtZ4Kdq0XdqyE0XIGaro57a5ZU4=;
        b=GGGO9Ptj2pkvudq83ummjCdYYVyWBb+UW49ykLrUcsHrhPivFSuGnxBhFp4YbB+R7p
         IFUDHFVm6WTlEYqzJE1YD245OcfyE6/j2O4KRjp5wIpKXQ7Zpo6ePv5Z2Yx4fBYGQTfH
         huZee6a3IuiKHpc8Hx6QDtolJAZcoWk1o6xJAv62fyupAB1774fU07dPMmnkxyi7Df47
         6X/H6JNR8QHILhx43WQ+iOaO357XyIAKxmGErJr4dUEmuIz9oWWkpw7lJ8iAFLSIul0K
         mmMyiTTAZb6FICGgd1XQU5HtWUj/N7hGI+3NmEN66Oqud+XBDNEsuiw0DwjudUMEPj3Z
         Z5ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777893209; x=1778498009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1RftPTz6Sb2A7zglddSxIo9ZDnyhKag5sMgvNF/OQQ=;
        b=QocniH2x+WQgEuswH9KuFE/12Rbwkufjp4lmhP2pC+Bc8w2yJFXOHeVB1ZmeYEW+80
         sPbggt02QykGYhUBlKl41Zxajib7BxfDUq3szXX1JXoiwmkfGARLg/Oh1vMGxbCwXFw9
         7uoxJqKVZhLs1Vq6cg8e+a1A69zYiJxUUkJ496UL+jd4AwwYwv65BlGQsUqCMmXWqfPP
         efvcj5cye0nwQQgk90+jq57sbV2aoDk7+uprnPI7bLwRs/Xs6z/FF4D606a3XjikIP2T
         n8AbIiN55h8LvX9+JGvt5ihYkQQ4aGdsGa7pFBE1WFEP50pMd1myeoJL6uJLcm6atf6E
         p6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777893209; x=1778498009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1RftPTz6Sb2A7zglddSxIo9ZDnyhKag5sMgvNF/OQQ=;
        b=G4+bK+uzaVVda/zGDZQnl3ZVuALolZ05kUbe5xJyErPxjP5sfEKeFcoG4UWP+QQ5KO
         Hi0JN56jfEUfj5Vl/PsoXIfp/yDtfvktLHf+svZTVREvb5eQGzsBbiRqD+YGLqBd3DVM
         GWkGfSSdAlLwMNRbeUc0vGrkEA52n0GjPeTLpxAWz1MthZHrqXXFsYfeJR69fBv5issR
         rb/rehZPzj9mJWnNLuYQCfUiIyJFKSGyE5rMs9podTDGE7W74YEdouFZowDz5FLfuHqA
         ybQJxb9f/hJPYP/WLI3Y87JFJukF/lRsw71DT9QtSqOaO1qbgxCMYruK/qhYHIi7zN4z
         dr7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9FwIa0GRSe1I8XxOjhJ1K1wEgA6XQWHeqYsufEKZlQZql1opdJojNP8pzovDUnmxJOEJVcUJEBDus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzQg2eGkHvlx8XRoeqpDOYb1oqrCpsULoeO45HNcnpsyUWqfD
	mvJMJC7Iqga4TvVWhbtCDpf/I68fFxhEFdLCYq6QNOpbqwYSEYuCCnm1Gc6jvf5PnXWVdV6llz6
	tfXzewmR675MA5T1wgyYh5kml1lPyInY=
X-Gm-Gg: AeBDieuJ/G8zkx9jxrjYqAzRPME96ZwoObpvl+4OmrIM65mUmWTLov4aQP2A60ebFhs
	rbHuzUgbJa3fAlr/2JBSsFYrzX0qJXSoHwWlFEjevrO8SrZH8vdbHT6yAmmB4UuhTYZ8f87r8pd
	i9JpzYZKEiGVJKg4uUoV3FNdGUj+f3xj8+IrOdLUPqhoM7dQ10SXrOwRVe+uZVzprR8SBVOnBUN
	oT2yLoHlNUqit7sDbdD8LWzBMLor25O/Euvi3OrKysVUZXs9KGgDWzFUA595H8UlmOSZO0rqM23
	fCt8a1ElFZSmuIEbkw/laYIOn/7Lmy1iTWV96kPMoAfPvSO14U7+t/Ike5LUs10TtjXUO7tHD1M
	MlYVJ42guFSfo7FU44TgclnMm5Z872C5kIIRR4ovXbTok1m/DXbrnK//RLxzdxfquuSCsmKbmT3
	k6sS2ECWSR7xYsyh32
X-Received: by 2002:a05:600c:800f:b0:488:ffb1:494c with SMTP id
 5b1f17b1804b1-48a9863a372mr144106885e9.12.1777893209033; Mon, 04 May 2026
 04:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com> <afh8nZ8fsyeXYbtz@ashevche-desk.local>
In-Reply-To: <afh8nZ8fsyeXYbtz@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 13:13:17 +0200
X-Gm-Features: AVHnY4L37X_YG24SXC9O6_MUrnE7LEaWVx7tyL9mkAvzg0ToRRkYve43XK4p4hk
Message-ID: <CALoEA-y4SeS8xtauxOc_w4epJ1JrNnO8KKfxBhdXMAtxQ+6onQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] iio: magnetometer: ak8975: modernize and cleanup driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 13:01, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Co-developed for those is too strong. Just use your SoB only.
> You may use my Reviewed-by though.
>
> Taking this into account, you can wait a day and send a new version with that
> and --base fixed. Also it gives me and others a chance to briefly look into
> the contents and see if everything looks okay.

Sounds good, the devm_* migration patch should be looked over especially,
since I have made some additional changes.

-- 
Kind regards

CJD
