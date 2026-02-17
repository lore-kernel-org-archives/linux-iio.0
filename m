Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140E352F98
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346792; cv=pass; b=rxsbIhSLHkbHdnCyAqZWl4JjsY/90nAWMvcmGFEHFe5afKH8MWYTXtYN4wrbttdqXidOtCpJP3IaOKE68RPcw69Syit4pnXNs0QgOSzt0NRmsbfey8nWdm1mpezYAfVG2k57ypu1ADYP0x1PvHlT3aqCuvPMW+T6vhiueJ6D1OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346792; c=relaxed/simple;
	bh=Q3Gc+VZamLR6t5v10OZfNXCrhdZNMSYiclZlcFKVd6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJNw/xD3Ar7KPAi2ERDajMTC4EYDq6dcvMNKXR6KLgoQ8XQnKUcZaj28cesC1thycrdd+bA45+mJw/cGWL3pwV8rXFtut2u2VF7x5Np8h+shI/51Qtqe5Q2vbUD2y1xOgESoN5Q+yvHeh9Fsq/jFUNESWihkALQAiH1ZceJ91LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyZxFWsh; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyZxFWsh"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ad8435f46so3884028d50.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 08:46:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346791; cv=none;
        d=google.com; s=arc-20240605;
        b=eZuVPR4rPvog4WMd1AuFNXIOUwvdU53gjdYw/WLjDf/leQm8hYMg4KwKfFk94C0HFO
         AO1gE34snZjYLWvVN9UKjbBUojz3HN+SfH5CPYmgN6+OypLY3CjpPJC1oKqgX05YIyW6
         LiZSbSCHFHpJN0qc9poCZz/WzoUzDB0TPYh5c7a8djwRfQ88RH0PHFJ51DH01bfIaUx7
         msDUXxgevA0KgPSVhrIeFvQd0SIX+t5PVPOROD0g9PCf7xjHLoVmkRwqcwjh2oKHuwbc
         yEipyyGAaQIEaauTXRIgHiD7JUWPrq2DjLT5D6kaJ4GdRX8IfxQO7Rlz3W7qeFk8azl+
         bPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q3Gc+VZamLR6t5v10OZfNXCrhdZNMSYiclZlcFKVd6I=;
        fh=M6avt02E2UtnxMDaJXMI+22fav68GOrWyrqGst5o5Ts=;
        b=bxcUSHGkEewF/C/lDy+Yp7iE4S/NQHPnkWncH/OTFQ7ow1mMxehfUVyaxSkt+OYh3E
         u4IdEXznMLK+v6JRKXT27rGNzdlS9ohTbLQ4QsePqCbSXCPQfzH+eUYElIc8M0g1T9PC
         nnAtmKLiSMPNWKVQX3yCK0ZYTM9Olq25jh6kKftnvE73FCM83wxSHUYb4ey5+WMnm8T+
         tuYQTtWm9EDMg71hBV0qkdE0QU2Oxxf1k1LvDkfvcG/lT3DO/uOtILC8Nz4zmWrCiRnt
         p6aQULGJCa7c6eRcAUltkWXyRs+X+bKMn5/E/DcWtw1u80PlE+KzYoAAx1QELBLIF+nr
         TCfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771346791; x=1771951591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3Gc+VZamLR6t5v10OZfNXCrhdZNMSYiclZlcFKVd6I=;
        b=WyZxFWshD1+QntIe69OT59i3GFhWPFLUv3GfCWFuY3jA52UGUDUddP3wtT38HYfWDk
         uDRrH1Cj4ntIbiwfX4KpvCC4dDLSho1LOQym4pg1iytEjzaYh47JMYlPoAXVhaankeVX
         v911e+PUvEmOjoXjfBBNDROx+fiCmpFu50Z/HSfW3m+wjpkZ07jo+FB/x2tz35PVsLNc
         Ilv27SnavohFtw1mbBW0H4olrjSDFoJs4rdviYVoRWajS8tcRZU/qxA3YLA9+YRm1Mxw
         PBlql1mbUamF9XC2qcbK0/H6aexc7lpQQBaHklEBHl4LQieiGAaQMMersP3IYKi+5xcU
         Q6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346791; x=1771951591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q3Gc+VZamLR6t5v10OZfNXCrhdZNMSYiclZlcFKVd6I=;
        b=jH1kfj95xfSg0jcoTN3b63c40ZqaVfnZZaiEeqMzYBwBJz3IP3RLj5/pqm7tVvQI2Z
         Du3qNwP4rDvxSznPlJChLuTRQJ30kTw8nCY2YWyHErRvKNYofFrnPqsvmsTv0OtjOLK2
         IxsoCqWzbj+XYbGCAdP1UXOuBeEdpnVvkmIhRlKKoCVfCtuha3gbJFNIMRpENPMJLFoB
         u4CkaUcb5zoAftSwIK9MJy9iO15ItYPmmHD2To1seGOlQUgrtNqQRccpZVVuY61KZO+M
         em06PxsHX/DL/b6CMNxMzO4Y2KEVp9YoKwnXEnO38kV9fkh6/rUh7neLCEtZUVYS8dh0
         MTIA==
X-Forwarded-Encrypted: i=1; AJvYcCUXMXvU1S3KeBc3fPcA2TerWD+ztVqWUuYC8UkFhBhtUL8Zww/Jgphy0XslV2PKgtpXu+5WOwWijEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJQuYSaNn/rric65N7aiaHxumg3nTpRMJk6XL9Mq8p1VuUVKP
	EJfRGBczRc8eGpP2Dc+oMgTLciR2wuTpITOE6/yepkHvZQjW5/Bj3WlOWg4lF3FHZ9Cvea7rLUc
	D9f2SvRZMCGNDhjuGY4jYlaWAAum2U/o=
X-Gm-Gg: AZuq6aK2LKX02U+y1WrFFoyOB3GnYTAzR9M7CIkNCwvE7q/C7syYemrWl7k6rgCuAzR
	pmfQ8QwWN15EdVsZ2jCopM30f790HYMDpSVDPvYv5ucJeI7XvT3XDw2vJbw3qwSdloIK6aLfIRj
	uHngvsWj3e059oJFZEKLNxQ20BV5AUbhw3hsLIrrbGHmrumO5VUschK1TPC9ZCoYpofxJ7YlhwL
	TaD1bGQAKUzGUHdgkCwLqIwrX85r2Vo4IW7ypBXSnLRAtCpL05hoG2TrnZT5a9wWJUhEjelbKKN
	5nfds9KKL/S1ZSib5k71oXcAiVt1FsuUJkNtkpc=
X-Received: by 2002:a05:690e:13c8:b0:64a:d574:8390 with SMTP id
 956f58d0204a3-64c21a40fd8mr8098286d50.3.1771346790523; Tue, 17 Feb 2026
 08:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122145633.14938-1-architanant5@gmail.com>
 <aXI-ZV4uAd5GyFLz@smile.fi.intel.com> <aXI_HnvDNbX68-lq@smile.fi.intel.com>
 <CADJHxWB3b+bH2+HBP+SG0jxhGNcozstBeWeDH_3dgS-4c2G-6g@mail.gmail.com>
 <aXJmYAZ-8KkXCFI9@smile.fi.intel.com> <CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
 <b27c638e-f0fb-42af-978f-89e38dea2b23@baylibre.com> <ca488ef9-f4f1-4f7e-9656-8c5d132d0d1c@baylibre.com>
In-Reply-To: <ca488ef9-f4f1-4f7e-9656-8c5d132d0d1c@baylibre.com>
From: Archit Anant <architanant5@gmail.com>
Date: Tue, 17 Feb 2026 22:16:19 +0530
X-Gm-Features: AZwV_Qgc9JOZgqqpgqUfNDf73M-bLvXTIqoUfS_Ygpy758Vq2PGiyoJW4ZRWVyc
Message-ID: <CADJHxWDXqgpbK1+cffhPeTEz95L0zeCGGWb96_QwuxjEofBNKg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul()
 instead of do_div()
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 12:34=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
> Actually, I just saw this was in staging, so I guess not breaking userspa=
ce
> isn't the top priority if there the other way is objectively better. I wo=
uld
> assume that testing/measurement could show which is actually correct.

Since I don't have the hardware to perform those measurements and confirm
if the precision improvement is valid or a regression, I will take the
conservative
approach for v2.

I will send a v2 that only replaces do_div() with div64_ul() and uses
BIT_ULL(27), preserving the original (mclk / 4) logic to guarantee no
behavioral change.

--=20
Sincerely,
Archit Anant
