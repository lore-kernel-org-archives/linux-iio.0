Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12253335066
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737727; cv=none; b=T6r7ivLyZfchwG4mkuJpQ6hEQlr2sgkduLNLPACCTgQbE8KQU2Di/nOA24IMuq5DJ1zqwDQN5h+V0zfl9ZFm3yMOIDn3nWcTEHZ+tWAZ5r5qIOaT5j/u0nYLz+1B9EY6N3tGBqymifXGMRBitckWzyEW2xENiZy559DgPZvT3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737727; c=relaxed/simple;
	bh=6UmHivAJo2NVTGDPhn0/pk0orn6QPG82x1BaoTedUuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXlaRhXeocFzlpg+Ku1GVA5lmbWaQdZwzztNJxVJ3DOrS4TLuVDNNf5oWYLwvHXEez9YCHEGJ7ivTg+xlOcdsrWvwUFFBwY+OLBQ33BuDEB1wUmx3SdbP4sgba6/tg0FfP7TXYqacaxHx/LDfASqymizWNDI/ZIx+styAOttxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoE1mHSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoE1mHSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96951F00A3E
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 20:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737725;
	bh=6UmHivAJo2NVTGDPhn0/pk0orn6QPG82x1BaoTedUuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YoE1mHSf8etz0c12/aZAwVxVYlg0os4eb6220MeQnHd1X8FjXVL2u3tx4J5gKJntE
	 Mhs6DTkIel3C3rJPELYGP2Rj0dZJSw/Keo+ExPoC+tgbmc2AnB/pxvQa3hUJFq8yDs
	 lYPlxLAI9slHhhU0lB5FAU1yszHPwNEe+tG8iRFIA5zNdPeITMHGT/1lKMiTYM2qS8
	 rvfTSE2QP7N319ADZnz0AX+JV1LXEWL/kN5kusxzKKhCEDJdOn11HSqTzvES/DOoUe
	 vnf6SV4K23GypBVyQN6ZjO/C3wNskdp67a1F3QVAAGKQylO6W24CmaYljmdsu6cJ3R
	 wUf4lFN4Pl41w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b00d083818so2386834e87.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 13:02:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp7BAIG5BS7Fj9mVUfJMIevSlVe4dqPNT0Laj8a61YCAmY5t+haSMq5y1+JQNC1zz+7E+YoaVLzlxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/okj1fR/euBwP6zxBizUqhsT5u3wlbWUyrSmUeFJxR5arj/fS
	oN/VN804rsFcnCAMUbcBRtmhwfIuaQHa33mFu+n7O7MXQgbjbJKbqvMOzHylZGAVEKsUAjeTNo3
	7MJ90NHEjssO1Bn7gBr8FfRDzV7PcCV4=
X-Received: by 2002:a05:6512:4023:b0:5b4:5854:77f2 with SMTP id
 2adb3069b0e04-5b458f2d840mr1679726e87.3.1786737724536; Fri, 14 Aug 2026
 13:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814101845.301769-1-yashsuthar983@gmail.com> <20260814101845.301769-2-yashsuthar983@gmail.com>
In-Reply-To: <20260814101845.301769-2-yashsuthar983@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 22:01:51 +0200
X-Gmail-Original-Message-ID: <CAD++jL=NGDd9h82ZMDwWSFLA5vC2vPxCna5RD=+__AAcCaigdw@mail.gmail.com>
X-Gm-Features: AcwNN1WTjv3jbKYSzUTkPbJ6oB5T5eCeFDSjxh-zr4J4ZSKRFKgXzRk3KGjHA70
Message-ID: <CAD++jL=NGDd9h82ZMDwWSFLA5vC2vPxCna5RD=+__AAcCaigdw@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: accel: bmc150: use aligned scan buffer for both
 trigger and fifo
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, grondon@gmail.com, hexlabsecurity@proton.me, 
	sakari.ailus@linux.intel.com, srinivas.pandruvada@linux.intel.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:19=E2=80=AFPM Yash Suthar <yashsuthar983@gmail.c=
om> wrote:

> Drop buffer as duplicate and s16 is not correct we needed __le16 as littl=
e
> endian, keep scan at the end of the bmc150_accel_data struct with
> IIO_DMA_MINALIGN, and use it for both paths.
>
> Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

This is indeed a better way to achieve alignment.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
