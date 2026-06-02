Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD941E2834
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403695; cv=none; b=g6mOv0XhHYeGcBlBFggPkdXpDDSTo9vlZI1SuZ2kB9EELL+zkyhOLT0mCw/+TnPM1knsBnifNzAfXpdSHZZGdbBrNWb1wT1Qk5xVV2pn1SHUIzkatUohjlkamtI0jaCAbifh06ninVrx+mEdLiGoPm9xyH/a5q/SqvXsyJeaA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403695; c=relaxed/simple;
	bh=g3+PolSFTvl+Dbxqo7LBVuF4Wk/ljZfu9PhVMO+r3Uk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZkYkjwl+BE3ReZ9MIAFxAWZTQwkiiDJyMAK1KtGpmlHDwGIJ/qh5r9sF9/jjtgYd6LO3w/kA86rVCUbpzPDNcoAd3KXnMBmNBxyCY3MEvjZtha3Z9lh/LvdDOOy/0rWTHMQ6PlRQaangyIg/jDCJ4zuuiLLb1jzU+OhOLbVx67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAcko4UU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAcko4UU"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a7678b2dso21840445e9.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780403693; x=1781008493; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3+PolSFTvl+Dbxqo7LBVuF4Wk/ljZfu9PhVMO+r3Uk=;
        b=CAcko4UUMDxvlDsleuegKtUOyjZCBwIlzUUbqhHjZwbDvuSW6lDgClh8WYh8DjkrJm
         9s/jeMp5xLRNbYYHz567f8aibGlAzJ2fCLCKtn3K65Um5JhYu70uORRpazGA23jLrtd9
         w56WifPZ2Kkd9qdV2KYeK1Ojy4A0oID1OMwLBdQXu4576uoe5JP3mcDflRbat8yvIlkV
         vHBc+LQMhRe2d3e8Xp7l8OAo94GWWTX8w3Ytgps5zyqIY7Bg89PwGhcfpNgUIvImFLM4
         dliUqn5zS2AtdIXWyy0dm2vgiIgF6Gpl3gMpfvM9C07BP3/qIAlxF74/gHk98y+JcqFk
         ATzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403693; x=1781008493;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3+PolSFTvl+Dbxqo7LBVuF4Wk/ljZfu9PhVMO+r3Uk=;
        b=bZrohEcYiwbMKME6iPh7uhTP4btYbRToZQTTzrvmM3eymp0vdYIoPBt2rsBebhnG9o
         BZSvOwSKh2dEaQBLIjMGfHfutuNvsb3TwQqEFCrsnCcKkFEjGLJSd09PbwVRKBOZQ1e0
         znNmUeFB1bgkZ3uh8qVKus1o1Z2ZlYxcvxMsqGXG4WhPQ2invzrGIaEsA1xLgZrdgfYB
         +11JN5NjR7/yLfLxp1q6yvqDPdbsEPmFmReT600HG/wwtMVMbdCWk1CvlfywuPnAaJwC
         m0tmAs9j9YR8a0Vk3EFcogZ25jUc3YUfDOzep0tBEzXcWU6Npz8agysQh0yiKa89wto/
         /L7w==
X-Forwarded-Encrypted: i=1; AFNElJ+/eOniilbo5q/tQsO1Usjmz+AhHnhI9aGgsbO4WGvrZas2+9dkMcAe5YzuUTfOo+/dMiMJypUjZvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIfkkuPtC+lBT1bVWTsM+6xoes4c957EhpT/ASHLBGKwFoSNp
	cJzuLYQLsBVS6OjIzvg4lUO3ETS7hOJThEyQx60tfRZ/lhk8oPrChUNU
X-Gm-Gg: Acq92OEz499iVjM/0w8W+pvDw+dfpNH8I84ej1Ej0mfAvlzCfqad/pmlfVnNefFNJ/W
	ipHQBbtPoYZlQqwaQBQCM1NTCOsd8vrPgM7zNEH05A2jgJ+0KJ6AoIC8zll3VafC3qYQmZle725
	1scax15sBChzGajiSeDQ1fmBSGzOWY/8gxkwDrAxgxjwtX2QCSbUoIe14/9PZ5tZY+iq2QCms8O
	JgGTWhqWJgzJUwQYLhADENDAffjhnqLxryQDmL3/uisiSxZZtGRqQ6gqjlJ3NBE9Y8G+vPF1GN8
	A+sD8hhE/rLPQWdvi0rpjYf6fdsTbg2nNWLYzrz23LvR0ZAf53KsishV78VNz5dQ0GbudSC+9p3
	c25Ai5cBd5Q1qtr836zQkbN5QtBZy97mHSdqkW36DLYKQG0uA7smn9j9XqM+GTkn8cqb1K9PNaj
	rCupCmJlt1URth2YMluHGaK4QzyYuLZDcT7Ul5N1YRGkBoaoM=
X-Received: by 2002:a05:600c:8b2e:b0:490:6889:1ff with SMTP id 5b1f17b1804b1-490a2940dd2mr275892015e9.28.1780403692736;
        Tue, 02 Jun 2026 05:34:52 -0700 (PDT)
Received: from localhost ([2001:4bb8:152:df59:3b69:56ea:a39b:adb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0e8c1bsm137133085e9.3.2026.06.02.05.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 05:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 14:34:50 +0200
Message-Id: <DIYKFNVUW1RR.1KP94ER0FKNES@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>, "David
 Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Matti
 Vaittinen" <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
 <ah66ljSiIc0ywFC2@ashevche-desk.local>
 <CALoEA-wdakU-Ei2FE3WpGR+CYRDN1bjv2sZ=XJ01ZeH3NP8xeA@mail.gmail.com>
 <DIYJ5ZACTWVS.13T8L275VHTKM@gmail.com>
 <CALoEA-w3TqD=2YP36=ScmRttmmG3BBCKvtfSqeJL0PVxRxEbuQ@mail.gmail.com>
 <DIYK6APQQX6S.2KLGTD0G5GCDA@gmail.com>
 <CALoEA-wXRhiTr1gA8GdLAmt2PO29N9S9FrX4ueab7P7FJ+HOPw@mail.gmail.com>
In-Reply-To: <CALoEA-wXRhiTr1gA8GdLAmt2PO29N9S9FrX4ueab7P7FJ+HOPw@mail.gmail.com>

On Tue Jun 2, 2026 at 2:33 PM CEST, Joshua Crofts wrote:
> On Tue, 2 Jun 2026 at 14:22, Javier Carrasco
> <javier.carrasco.cruz@gmail.com> wrote:
>>
>> On Tue Jun 2, 2026 at 1:47 PM CEST, Joshua Crofts wrote:
>> > On Tue, 2 Jun 2026 at 13:35, Javier Carrasco
>> > <javier.carrasco.cruz@gmail.com> wrote:
>> >> Thank you, Joshua. One question, though: maybe you remember that your
>> >> last driver was missing one header (which I am not criticizing at all=
,
>> >> as you can see I missed some too!), and I am wondering if it was beca=
use
>> >> iwyu missed it and if so, how that could be avoided.
>> >
>> > About that - I didn't actually run iwyu on my driver, I recently migra=
ted to
>> > Fedora and forgot to set up LLVM and iywu-tool :-)
>>
>> I installed IWYU and added your mapping for a quick test, and it wants
>> to add a million headers or so:
>> If that is correct, I bet there is almost no driver prior to IWYU that
>> has all the headers :D
>
> Well, as Andy said - it's still far from ideal. It generates unnecessary =
noise.
>
> Question: did you run `make compile_commands.json` before running iwyu?
>
> iwyu_tool -p compile_commands.json drivers/iio/magnetometer/ak8975.c -- \
> -Xiwyu --no_default_mappings -Xiwyu --mapping_file=3D/home/josh/iio.imp
>
> This was the command I used when I did some cleaning up on the ak8975.

I used the compile_commands.json generated by
scripts/clang-tools/gen_compile_commands.py, which I always use to have
a better experience with clangd and Neovim.

Should it make any difference?
