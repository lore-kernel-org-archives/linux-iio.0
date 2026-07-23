Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272633F3266
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841091; cv=none; b=ZU29UMB2gRgFwFCr5rMqSB/AnyCVCX8csl3lMpNoIFOpVsxuQs4BNeaiiBC18Uh0qUC+436LuTjWepRpJUrVcedS43I9Nx5K1QwDtx8wxKupvqT5DNu3vZNLFRCKpzYiBQCmPLpHr8Kc8exJxJxBvegl7J038XAOQoCwxcUfSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841091; c=relaxed/simple;
	bh=0qDCzzA1wQNK8P5kdVDMplCnxc1foDITb3JHlh1WxqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMU3I2SAlhJhhWRgGn8br3c5hp/DvCm6JVxfomba/WYiUq9I0He/pxOv7kb92YG6OeCSe/KQChBpuY4l8Ow4SnAwhOk7JddVAgbVEYI3/NHAVfc7thmJrZeoxmUe6ZlfpS5yZiAlWI6BYMF/frCPbHCdWQGrzWtS4lGqWCLqZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0/NPxRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0/NPxRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C38D1F00AC4
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784841088;
	bh=0qDCzzA1wQNK8P5kdVDMplCnxc1foDITb3JHlh1WxqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M0/NPxRs463kWZuH0AettA/bWtVEcTBilAb6x55A9Ct/5CODgKJDYB+cIHO16J2OW
	 ApBW9CERIPb9S2LCZqhj11iTauHHt8b4GaFe+qWAZAgkvK+DGuexI6HXqdgjdfx45D
	 xnK3wxH4Ld0BSVUrsOxysd6olGuQrDj0tHDIY4SwvJSmh5IPMaIofbx1NnIJuxnvxL
	 /IfVkW09qQQBleOM+tO+ft61tkRObstOqXZBTjTuZPUUS3l7vYQ5DhzQi/cmYVIfMO
	 6psVBkxJ8iV9kujJQg9DI5ZIK8y1n2098Wd1O7LjV4bQFCdyF7Zh9M2LDhfTkGwi2t
	 rF1hROya4XQhA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeba09900bso808065e87.2
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:11:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpadwWGoPDrxGm7KuR2NPPsd/mLobU2NqgalPPNds5a3GenF7JDKJQ6VqBSuxEEmceLljhjDIEdmM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Je8leG6Qdq/709nBlDVMXwRmHJEqK1iZOR2sq8MP2TNIxN4M
	gt9BxAhBLui10zx2ts3RsQlHCOrCpw/cVD7OVa+Dnhcp2eRVooiFpGcaD8+S28KC0XOz3wIUVVa
	/k0n/i5kuisbfFms4ThWSZ4o6GV4dGPA=
X-Received: by 2002:ac2:4891:0:b0:5ae:afec:8afb with SMTP id
 2adb3069b0e04-5b2b2f707fdmr654385e87.48.1784841087191; Thu, 23 Jul 2026
 14:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com> <20260723034237.2501507-4-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-4-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Jul 2026 23:11:14 +0200
X-Gmail-Original-Message-ID: <CAD++jL=zgDkvQzmSmQK-sx00mAz8TFuH0UYOUzaDQ2hQX2+-dw@mail.gmail.com>
X-Gm-Features: AUfX_mxBmXE-SNHwf75ziYaRd14dzUzw26xbtPTL2smbxj_zM52DC8EJIFw2I4k
Message-ID: <CAD++jL=zgDkvQzmSmQK-sx00mAz8TFuH0UYOUzaDQ2hQX2+-dw@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] gpio: regmap: Apply default resource callbacks for
 regmap IRQ chip
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: andriy.shevchenko@intel.com, mwalle@kernel.org, brgl@kernel.org, 
	tychang@realtek.com, wbg@kernel.org, mathieu.dubois-briand@bootlin.com, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org, 
	bhelgaas@google.com, o-takashi@sakamocchi.jp, dlechner@baylibre.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux@analog.com, 
	linux-iio@vger.kernel.org, cy.huang@realtek.com, james.tai@realtek.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:43=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> When GPIO regmap creates an IRQ chip on behalf of the user, it also
> takes an ownership of the respective callbacks and driver data.
> With that being done, apply default resource callbacks that keep
> tracking the IRQ requests and releases.
>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
