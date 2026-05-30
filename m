Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7536167E
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780144802; cv=pass; b=UQa/GHWLdP+/WBIUfrzYy7kEdjAl5CKKEOtgNbnHwXX3QD2CR7qHmxuouv2jrIe6iEL6ehXnnahDf99RIjKU3MZ4TncoDL7gJfVPLAnMTwXMmWPNgWmtjEUD89md1Dn0Pgy0f0xb0N+XLmE5HqvDAiAp6rVU+xeW6AxRzpkThhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780144802; c=relaxed/simple;
	bh=mCFQYPb0hER5/YK01K9/AMjW2Ofy75QWLf9PsPmXl1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVqnwBxKZrtl7RL8UlRpXqojCNb0ubz4u43gy6higu1Q9YpDIymceB0QxJeyEaedOmPBZkow+N1GoA4f3owtYgHWqQStF8Xu7jO7sshGFRP8TCYbp89JVDa+zd+Wmu+sVErmT8JxQ2AjwxJR+ZYriHirOLODS1Zv3At1n3M8TB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx4p5wYB; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx4p5wYB"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd8f9889a8cso1785098866b.1
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 05:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780144800; cv=none;
        d=google.com; s=arc-20240605;
        b=hDvSorpLvE9hr/UeP2PgFWqCSQdljemqqu3nptIBR+Po/wKA1xBuQ8IgY2lG/vTpcV
         weqKHxm7cYPgNyGK6gfxE4MYo5EGMH22yd+yuHmV7T3aMuWzw8LIJCrKjw4O7O4EVw+g
         LTQhoQ16JRacEUbJR2Z6nixQzRp6PF04/Txxqy1/ToF3+OxKmgkKHvmIIgWNRlbN7BQ2
         C+tWj+oudYZY9Mvudw281tRt1SakFr1DHEAOxZMRcnXxe6j/e7P/gYvkptIBmLaS1Kxn
         lGUfOofsd1K6RtUab5BR/24uIM7Rc/GetfeZkEEetS+kqU+t4GB2RC9BTlz25FsXkHZh
         bHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCFQYPb0hER5/YK01K9/AMjW2Ofy75QWLf9PsPmXl1w=;
        fh=CbEVLLuFxsbyihD7Xaa2APi/eUoCMHWgdXYP5ckTNWU=;
        b=JO+Wyfs9sYPz8mtpnrKICIRapC14V91XOrcFgB/23kbe4OVW6txJwT2ifyBW7/xLyV
         rD3u7Si9qUv9HbkXsHTLlo3Vko9e3JooyY0q7YZ3J+W0Q8JkVy1M1WMbzE3+S2ZLMpgX
         rpgDBN0BFpbNIJzSdlB6FdMzVTV25g3FdpcNdDiiw3+fIioAoJpzhFfa/go3beXUiVQJ
         loQqdWxhhn5SoHCoU4tKw8jRb91Qkho+UPw3amMJrlIYzvQ7Ldiv5CHZBADM8+w2S6k3
         WizrdGuxICoC6KzBjgc3o1Lqb7xRzbrhrpPPrp/Xgyl4ROQDfFze78OPwcrMsXPCJx/E
         lozg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780144800; x=1780749600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCFQYPb0hER5/YK01K9/AMjW2Ofy75QWLf9PsPmXl1w=;
        b=gx4p5wYB9KJC18utTD5ISKRWqXzqNWCiskVSvA2LIEQd5UwmzxHvtyzTxGWuOy0csu
         XluEXXRqIYmx0yFQhEQH12ZQkSpduS9rGBfV9AfKXaSzZYowN293nPfASeQrqDi6QeLU
         rJOAJl9h827oXJB2s5+JNSpIeIce53/vSvVRueUvHQsstbf/GVNOSArjS6QHNpSnEXld
         ODMzDbF8q1nwZ876G/WwpixO35T2X3D+tEhOqf6BBY0Nyw60XwHyZMvlk1OY1vtq8G9P
         7VSpWAvEZNjTS1BWB+C89hqnpgOj1ZMeO8HCrM87Owdm7yvpxdCKo6fSxu+PfgDOs6xe
         Px4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780144800; x=1780749600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCFQYPb0hER5/YK01K9/AMjW2Ofy75QWLf9PsPmXl1w=;
        b=VIvehoA+CwIjUnoR8393VlUEbOk8H63JtBrBGsWY9qHm25XFHvVnL6IJH9oRRVVtC9
         uud6kbnT8X+t2nlY9ViqZF6YSLh587fvC1zrPYhh+7l8ckPtoXf6hAyRmRgTa9Z9TXDS
         hX4WLivQ20VdHb6k9X8YzsFRI7+8mQ6Jut84S6uIuAtP2Enu1EBQp36mn/qjxLzU74JH
         Zuk6kcpRlsv/z/AUBVotBrxBzn7y9elMSUgau7FBIrFc5LG/TtwUhsHOT67zrxa1ZA5u
         zGlQqpof7UPQ5qux3xIQKwbLyRuMK3JXhOVWC1eADswmXxdZjgl2RZjH9RwjDZSQsDIq
         y0fA==
X-Forwarded-Encrypted: i=1; AFNElJ9a7l4bUloLIFTCPY/hIFB3IaVpNnRMx/fhDkjxh1kh/8Dqs0NqmPcl6IooqYcf40rjNHFizWlbT08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKA10jgiYUFkaELagZcHVAaDLQ1DeOi8E4sMWyUfh0TxIWjjTL
	mS9xZefdw8gDMXOa+X45scKNrDpDWHpztSOj3JP142tjwACQ+60D2GLiSUBM48tS4mc45LJJbVv
	KhprKPSUeBrq7QXSsIpoyEg1KBMQTYzQ=
X-Gm-Gg: Acq92OE72/ydgscFnB6TDCAFZOgrXWbhsK4jFKcwTSKgu2o5TBTOtG6rICFv5pjPWxh
	gAvzUKe0+GUKM2ecKpcpt5xnsKGNHAAIkTLgyvxg3IRA9d1XDV07EblwkDlsebd/tKalQNYaNtB
	+6ArltC00pov6ARmnqtogcRQOhCzXkJPlejodKO1NJvBSLe2AUX0oVfa468724aXOEVNy2AjIJA
	PohzZaO5PrQk/4sOVq4WZuvVE3Qkbw6cJRXGsoOGK8IuvTKRXrTWRbXssq4bCkPUwZfcazxdohy
	EhUmzNkUidhWQdPWfx+ND/76aZ2EmDACHQr58/JuKbE542IniGd3PenjHrNX/IgWBq0BrOuYjUc
	5cgGo4eiBOZhZKhhQ5WEaFps82FPkt50yUJWw1REpABsiuEpw+eMu6ngfgDnMS4KFk7OvbX/ldN
	3ttB68
X-Received: by 2002:a17:907:3da0:b0:bda:25eb:1893 with SMTP id
 a640c23a62f3a-beab52314c4mr187958966b.20.1780144799547; Sat, 30 May 2026
 05:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-4-suunj1331@gmail.com>
In-Reply-To: <20260530113938.171540-4-suunj1331@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 May 2026 14:39:23 +0200
X-Gm-Features: AVHnY4Lmuhtu-KybdV7Y84jYr1jUSp6SdCGizBZhIGhDG0mK6WX9DgW9jdLlhgs
Message-ID: <CAHp75VdMZ-HdJXA0SLpFrs7AZw90v+VRpbHgoiugwooG62cbhw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: pressure: mpl3115: generalize interrupt pin routing
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, apokusinski01@gmail.com, 
	me@brighamcampbell.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 1:40=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> Write CTRL_REG5 explicitly for both INT1 and INT2 rather than
> relying on power-on defaults when INT2 is selected.
>
> This avoids incorrect interrupt routing after a suspend/resume
> cycle where the register may not return to its default state.
>
> Route both DRDY and FIFO interrupts to the selected pin. The
> FIFO routing is not yet used but is required by the hardware
> FIFO support added in the following patch.
>
> Consolidate polarity configuration into a single code path
> that handles both interrupt pins uniformly.

> No functional change intended.

All the same issues in the commit message as with the previous change.

--=20
With Best Regards,
Andy Shevchenko
