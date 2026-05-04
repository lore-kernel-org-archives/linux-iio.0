Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFBF2C21FF
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885754; cv=pass; b=Ox+AYQt657DNWABCH3PNf1e1Jw0K0Jtdg+dEeW+2MAwoa4ann06MIDiv45m83LPIHmW3HtaoBTkPVFlAsM1h+V+EN3yR0suwBxbP4feyMKwWf2a4jQioRPqqtxSTaz0YO2u+GS0+Bmh1jA8X86cJFYr+gHxgWZXK3IPr3rBjX1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885754; c=relaxed/simple;
	bh=lQ8QiZbeIoqAH13k8yv9QMud0WZS/q1RaGQK7wnB0TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWZjyBYt6qyFDe9Mi2fyXeS0bNL4nE0w2WytT3CIyfN6iKcVAafrC4DpSnSMz7nGhPWJkn0Dh+cdnIQR+39PXZRsnxWymZcsDsybzeSr6nalPLz5PYKmHYPoNXHtQLuTC0Jsjh0WZAE/FlESe8GEs1qlkOeA06+MJ955GSwcuP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhbEjJuk; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhbEjJuk"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso1032107f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 02:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777885752; cv=none;
        d=google.com; s=arc-20240605;
        b=beFCAsoEWohZ1f4Ytha+6ThbOT/Tub3pJQU5fhKb5QhzOhqkVzhJnsj5k4jhzCb8r2
         /d8IBHBVEGcbT2PYTtLBmcr8sL2/JCybB4jiV2T+Z+rxdBU6isnM+21CLwIvZiAAqbVn
         QndS0qsHLWhzcuT4+w+toBjYVeGM+JswxSsf5cFUl0bUlppnzInTS1oBqqIDt4HzeAar
         pufDgHgp/4/cFCbn8+PBlBD9pE58kHTPz3Vt1lqkxCoacXLhHMdi9JUs/kiMPa3vc6Fd
         mpZnFwr3oc+LWtlRDEbfxtB8KLexXcPdL0U2x6cvEgXJT5463t6Xox9FS+8VizTGsXzD
         rvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DqJ7xbLfDSnUaaYilDBrqD9Eey/AY9d/a0O3RlNePN4=;
        fh=ak8kQ2ey6Nc+pQ25Cf+jXul16U6WGrDtcedNkyPer0I=;
        b=T/Oii+vUiZpzL7RocW7qwJHhDSck2MLOMMv05OxX7unSWqwRXMZHe4qU+UjM9Ko3hJ
         yPrCSzWjknbeQ6XI2ZMDaIzv4IbYMvKO0rrQO066MyHoIvzj0TbiknN0eJjXSdJcHKn3
         /yyR14aKBOHxsq1PVUTZfCoxOqu0OJzs+2msB3cFJbvNoMvff8A6ka4w7KZ9iOIy4tTq
         1fzBAwWJbwWB4zJrV4kUZJyiv1am27WAghn+CZGDm8NY04Q+bAd4lpnodrFl64WSsgfO
         NpZpFRhLdkF5uNnCb6FBahl3BiisgsXMiloRXhAvRB4Lexc8kumNgx/WQxiuHYyJle8I
         fF6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777885752; x=1778490552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DqJ7xbLfDSnUaaYilDBrqD9Eey/AY9d/a0O3RlNePN4=;
        b=DhbEjJuksP95yzW8qmXQcOe6PNj91GO15DG0rl7nlkgtXGSs9wLAepBzYqQNe0BJGK
         IxLTssVfQ5ENZ8TlDUhe/fVbymwawPb6TUGQ7D8WJaInZFn3zbgYVMWE0m8gCupSISpa
         ZcsQrxWHEUzqVzPG09qg5LOiARNuC2O+oFNo+sEcfGyvnIAJVYh7sMlccFbC6wQ9WGZu
         Mrpi3R4rYBT1YKZoYhmvAF/lLGFnQ/mXWheSn3GLRoJ60NYpsAgFu6UoCzhJeZSwiP7R
         QYIeZkSdcJgISEY5uE9y0Th3GBA9UGY4lcXpMHgrw3HUv3pahXFjOYuyV0cHBml90G20
         xUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885752; x=1778490552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqJ7xbLfDSnUaaYilDBrqD9Eey/AY9d/a0O3RlNePN4=;
        b=EYmWFqD/G/g6gaA8eA5JflXRgybL18rzMQQ55by/sF/ve6+yf8ovXc/Z2DyfcXYIaL
         b/ujPUIwsxsgauw24F4fATWZzNTBw0+XZLCl6ZT2+BFngCO8Z+rI4S1D7Iq/uZdu2CkC
         UINj3vIYvhrxxIctALu3C+XIk0H9Lml1vQAUsjggbP2OZo19Z+VEZ1a5fSJrR5Yi7Uj6
         D2unlwvSdZ0NPBXlmLWCJBKjQ30X2F4xh/YS5C7SfKjUo5LTP8SbUN1LhSU5cyRg57M3
         3qwvMj2izTNVfjHSsGeN72jVRFQhfKYkxKPWL9d8T+mtF8g0GfrqXSF3kUg1N5wHdYF/
         Yb3A==
X-Forwarded-Encrypted: i=1; AFNElJ/bkm/g5oWYx2/QNg7E38t/kkqGa0EDAcQ8OQGFbzrGzr7B3+rqEnlk3mdSc3FOWUraP3yytvg5ROg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinuaRTmOmWX2Ty3WPoDV+SiPJtIEuRhOY2RFMmhLBMXf6tqcJ
	x0ADF3Y1/9mPkY4qOHRxMk90ueRuNhRZnRdlSEnA9V+ri9xNF09qoRvKU/q1NMA9oKoE13oOAhm
	CWrlTGknr1FX+H7AijumsUbqtDD40LUI=
X-Gm-Gg: AeBDiesurrnkRmeAb7M4r7o0PpzVzR3XLSHaZ8cHMVhC7h0bmejPF1y9+K82QiDL/su
	m6UHFHf1tYPuGq3DnH/uVEAaulQbbz0Y7v5XJqEno9V4sZcsv3YrMfkzbiLKs/yJYKEqd8gCVZs
	3WsiupoE1H78a5b2NvLRBzSsL2TOqRSn5CqWv6kaBwMQpYxXb8XfBh/p20fgqE0vGLYtWTu4j7J
	MwdNPAu21a2OiuEuCgXDU/XbdKhrstnY3Sexl8uMbz9zMntS7kw5lLbOkuTqZ6vareFcpZkOW4p
	z5Ve2f0bKtBjMXP/9Vnh/PfVN1/UXSDxIdbE/N/2+mLDeAzteb/b/ilh6NB9Pwp8lZifmdzP1bm
	Txfzqzf1z678JeAoW2Phb82OO27NaZZIUo29vU5eWWeU9AetHg1LB2w6Nn3ZqL85u/0vsu74SOG
	pj6IHGxSP99WEvol6z
X-Received: by 2002:a05:6000:22c2:b0:43e:a70d:763c with SMTP id
 ffacd0b85a97d-44bb66d60camr14887439f8f.42.1777885751692; Mon, 04 May 2026
 02:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com> <afhfAjTShsY8AYiu@ashevche-desk.local>
In-Reply-To: <afhfAjTShsY8AYiu@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 11:09:00 +0200
X-Gm-Features: AVHnY4I7SkHz7-GbUl-gzLk0uE4NzPPJVRarn7HjpWCBHSFw16FevNsM6lajeoc
Message-ID: <CALoEA-x6hG0=L0ASVLpw798qnxWCD9U=s52SUw3ZGdgZcAMa+A@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iio: light: si1133: driver cleanup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 10:55, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 30, 2026 at 05:04:20PM +0200, Joshua Crofts via B4 Relay wrote:
> > This series deals with the cleanup and modernization of the Silicon
> > Labs SI1133 UV/Ambient light sensor.
> >
> > What seemed like a simple checkpatch cleanup turned out to be more
> > complex, therefore I've ended up doing a patch series instead.
> >
> > Changes include:
> >  - adding missing headers
> >  - removing unused macros
> >  - adding guard(mutex)() support
> >  - code style fixes
> >  - race condition fixes reported by Sashiko
>
> I'm not sure about patches 1 & 2 without testing on HW (the reports sound good
> and fixes look reasonable, but it might be some behaviour that relies on a
> [buggy] implementation). Also not sure about patch 7, however don't care much.
> For the rest feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hmm, yes, it would be better to test it on HW, too bad the chip is obsolete...

-- 
Kind regards

CJD
