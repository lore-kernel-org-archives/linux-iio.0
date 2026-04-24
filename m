Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E493E8C5A;
	Fri, 24 Apr 2026 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053779; cv=none; b=cbIGKTzDEBu+GLrFyHyJlB4lA4b1ALHQXD15TMQBu+cPYjDbI5yGPo9Nvk35TTVjaMWXBPITHKMo0VTUcqpOsnC0vtpxHrgzqKc62myZs7aGmD3nZRb0bKxosT+nNHbm0WXoYxCpPy10ZZipTmZy/km+LQXNwR9Ks0gjnRFJTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053779; c=relaxed/simple;
	bh=FwO/SEoaVjmOc265sbk3monW51ADDYdtTOfLOwNSPUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwIm0wapG8wm0/4YM0WCEMpJk/L6hn5LGl3hl9bKDSpLW1zS6l7QrqJXM3kVlHO9bPpfIzcdIwqNVeAgCoqvu/RyYBeh7pMrv8+Df11chCWj9XMKNnA0YRktJUQpR6IstB9hhVgJEk3jGRE9ygmuLG2y5j3C9Ou6HovvVJdLTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv0Q/SdT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv0Q/SdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D7AC19425;
	Fri, 24 Apr 2026 18:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053779;
	bh=FwO/SEoaVjmOc265sbk3monW51ADDYdtTOfLOwNSPUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nv0Q/SdTpLrb7mALD9tFSFxFsg/EppoKmlhyJ41vd3mHi4/fh6Yv1HoX22tAUZNIT
	 ZwyhRBUn9YrdAvkRxAdb0f7L0Jhzdq1bULbO1hTMJNwAemjSZuzSEaRXXaJwOdGjMK
	 ZSHZEcWfy1rUb16Dg+jZTiUNFZVAN+5QvZlwXjApEzO2mY0682YZ4ZLJy0Fl30+DoP
	 VQmEkepbs/nm4+FnJu7wljg3E+ekaHrPBV9lOgSc71iA3wfMjjFma6//PlXDtO6F8d
	 Dsescl59aYEf4xEvrarQHMMsRTsyzYo3WNgOYVLzCDR8zJkcNnewyp/+1qgJekH5mn
	 VIQmBTDsPOsaw==
Date: Fri, 24 Apr 2026 19:02:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup
 driver
Message-ID: <20260424190249.62c4bafd@jic23-huawei>
In-Reply-To: <CALoEA-zCU_Em4U0F+Kf64g9yvQupLM5fXtQo_OxnPftcDwSwgw@mail.gmail.com>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
	<aejKKKD4JdxIzlk0@ashevche-desk.local>
	<CALoEA-w=N7ch67R+DgdqCrSy+5GtbuGkiAbJtnf-9c=Q2Mb6CQ@mail.gmail.com>
	<aetDc7Cvb-_qkf3s@ashevche-desk.local>
	<CALoEA-zCU_Em4U0F+Kf64g9yvQupLM5fXtQo_OxnPftcDwSwgw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 12:23:09 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 24 Apr 2026 at 12:18, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Sorry for the delay (if you want to help, start reviewing others' patches in
> > IIO mailing list, you also learn from that). Now when I got my email pipeline
> > clean, I am about to start doing what's been promised.  
> 
> I wasn't sure that I can just start reviewing, so good to know. No worries about
> the delay.
> 

FWIW I took a look through and have nothing to add. Looking forward to v4.
How Andy manage to catch up with is backlog is beyond me :)

Jonathan
