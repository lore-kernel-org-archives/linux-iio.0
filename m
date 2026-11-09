Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794217256;
	b=xrhFypg67Gs8MO6DDNZpY2+VS1JZv0oZ9hKLv8iot3xC5V8VNPs9ka2chyBW3enqFOdm
	 u7bnI9tuUEsJNMYeME/ufjcfrwncdAk/cdMq63lrEhWICMQJHkEC33klLanAHd8qF76Eu
	 /JSybbr5swOXdn7bMF+vnWiYZHHaLLPu9qlewdsDof84e0U21tL3P2kQSOwyLbYXB5hfB
	 Zu+pm5YPp6GajR9cEdMxAVphPTgptkLiK5XSA1UKo9VcDEHWXYqFWnIIrhQj2MAljxfO/
	 bU9IupN0pdHw88mm0xTjTQdxsrli+CMNqpR22+qpe5Qca4ggg8Ac6XPSHEUlmMt82jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217256;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aooD9EtVh9aNPZIrpb0NCRR5WbBdA2wFitbA+i9l4lg=;
	b=PbOfCrWR0o/fDOfpAq0M2k+l6fRO1k1JZcffeiUClIJuWYCmIdnhc4R1ZqqFDwfKHHUl
	 mIeqJtvP0ziiKl9727/7eTEW3+/9cwKxJ1Juv7KHh3fg8KHP/RLI3uitNnxTqidK4bG3v
	 Vph8+lyCyTEAcJO1idMuxNiM18Ge6Fl9Fn2cqDwxfnV+lL4nDEZHfIfwNritIJ+oy1oCp
	 /XQPU08OVOv+jhzPzqBPyM+1co0gcBxTlB80JgpgRNGdLlvz2a9yj9EboVpd0l1yuD2OY
	 YE2zYpxxpFOziA8xYz/l7bczRHzYZNkz56V2h1WEQSu/X/ycEi2CMRZExEld5ExjzNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tdg8eiHv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD4606A326;
	Mon,  9 Nov 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tdg8eiHv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794217255;
	b=f9vF6nbjnqT6KXqXYcTJVTXhW9/ehuq6OHNDgZEeZj0I0IEx6r8oGqib+F6X4EXwAdKt
	 kOTcMD+OaMZwGbrCUZh0ddGX0e39WkCM8zbP9NZwHCPgi0jexSOunaUvRkUAR4vujiRfx
	 5tJNCA+WatS6VyTB1VaRWvTzJWpT/XBhkjW6n2hA46RsYwAIhSZp3JivxLKJQe4t971f9
	 NKfwwitwpbR3OyNBYDBdZ/B0RF9JthoM926c/9OSA0zyuNzt6PaSzilx3DVUJXMJjPg5X
	 VjjD85sIhS4O0TUBrDgMZicZmUwoOQAbQGO7Yp546a5nwaxDS02Wizq9Pj+IG4+opGg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794217255;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aooD9EtVh9aNPZIrpb0NCRR5WbBdA2wFitbA+i9l4lg=;
	b=ZQv1MLkqBgaafn7j5LuKdEJ8XbLTCwBlNMODfIt8v2m0mG8yRQe++I7vucmhyE1hx8db
	 V58QvccoMJRTyMwF0J0jTo02cqgrETl7ALk30wQd4cqap6/1fq86X1XxIJOMg+ESQFoDF
	 rIOZOa3WymJkgcZoPHloxwjfuIV2wfIPB8tYhOFJvELWydnTLgJlPJLT0sNqXw7QjzJ/z
	 lGqfiOSDoo6QydMq711t5g+r8WsyGDOqbjcu3lC0ZqSUCeNEXcm/DVOVMT9mJJGKm9qzT
	 3XpNYmntRK/+L3E86NFl490n7+wB0SELbJ1z/VSt4ZWqC0TgNk+75O1CMJfImUHcNVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id CA9581F008A6;
	Mon,  9 Nov 2026 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794217255;
	bh=aooD9EtVh9aNPZIrpb0NCRR5WbBdA2wFitbA+i9l4lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tdg8eiHvOk+B4Qy6w+/1/ejwJTUlaN2E85GsmSxQ5Ga5UrB+Id20rjOnIx6plWPr/
	 6t2uSvfq3g+8kQ+Dt3FHlJOgvn0DiIo41bUedmLvorpcnuYUjkKqTiRtXaSPNixs91
	 2oXQo+FFb+kArcEwUTmKanUD7ZM8eHAjD9GbFIbt9UTy4TGT9iA/Bot6RK/69wSsIH
	 WbI64ZpN8X0PlyeIWoEP68ZlomPH9b2lH0DlC36x/sqgpgOHclUVgywpvSgIpib7fv
	 fNOBORsS6SDaIIDthlg8GDxQcD8snTPCTicb4TdaWD7rZAgNmE6ca7GXoB+KEpHMgR
	 8GXEqehdHtwtg==
Date: Mon, 9 Nov 2026 10:40:47 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Adi =?UTF-8?Q?Kadu=C5=A1i=C4=87?= <kadusicadi1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: use __free(kfree) for
 temporary buffers
Message-ID: <20261109104047.00003753@kernel.org>
In-Reply-To: <20261108201522.249539-1-kadusicadi1@gmail.com>
References: <20261108201522.249539-1-kadusicadi1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  8 Nov 2026 21:15:22 +0100
Adi Kadu=C5=A1i=C4=87 <kadusicadi1@gmail.com> wrote:

> Replace manual kfree() calls with the __free(kfree) cleanup attribute.
> No functional change.

I think that this is a functional change :)
This can be dropped while applying though.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

--=20
Kind regards,
Joshua Crofts
