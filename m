Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF573E2776;
	Mon, 27 Apr 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310146; cv=none; b=ZhfVg0CjQ1l2zjUZMWC9dqTBxCk3Wa9sN+oGrsNu1DDb2Qpma6xndJgdHo9aa/wJP1IYSfN4ZD4XALA62ZepI+fxXvzT5HR43CM6aMcfd42hk2PBEC5/0KiYS/JGkl9xCEyAQeMpq20RoU3QQT7/KipJ8JBeJpRWEl2w/S6b+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310146; c=relaxed/simple;
	bh=sq1+qESM1wlT/vwSuEnbxCmoVbaCa6OozRDKCDMNaJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUF/6TGsVRRcsIaMiAWpMbqqg6yc0xz7hE26jYYC3p7G+u35QvRAGRpOyk8SHA/fs/GNIP2jePlXwsTJesEOgH2N+TkD2vPU30lErNGrCrw3pmAiyY0XkV9IzLwnosCVvf1kA/dWpV4jFgT+UXrKQxcJKivt5ui5PrmpssUbUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFRQycP/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFRQycP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEFEC2BCC6;
	Mon, 27 Apr 2026 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310146;
	bh=sq1+qESM1wlT/vwSuEnbxCmoVbaCa6OozRDKCDMNaJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AFRQycP/TI0kAFHPNQWNXin9rnss5JlxCniueDahA3tGRk5NHMC2cfaKGiHUxEnaZ
	 sLBiunrMJL9DOCI8z3HaC0A0M37K3FOID21f8BULAntPT56uXpJczpLD14cGxrpGIQ
	 4WPgFGDn2yq857zHVbMlgupj1TbLFDwmSKX0VNrUvJYKC0P+YZkjftuvmEypaX6Ws7
	 YNxj+Br3Yp+PbYDaKmmXIgRshr/sbql1Lw/K3nbyTU6ZWVLF/xiCdmwIWW3BJm7Ms+
	 RRoEMiEsrsVzr2snExWMqlR3YkJA91/UQ1IRz3Cix4GyrGQbbKBqrarSvIhB986ZyB
	 H9mAcCZmaBnVA==
Date: Mon, 27 Apr 2026 18:15:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iio: adc: mt6359: fix unchecked return value in
 mt6358_read_imp
Message-ID: <20260427181537.46c2f20a@jic23-huawei>
In-Reply-To: <ae9JFucpXBPwwGzr@pc>
References: <20260427085458.38546-1-salah.triki@gmail.com>
	<ae8pAGBGGOvsURka@ashevche-desk.local>
	<ae9JFucpXBPwwGzr@pc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 12:31:34 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> On Mon, Apr 27, 2026 at 12:14:40PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 27, 2026 at 09:54:57AM +0100, Salah Triki wrote:  
> > > In mt6358_read_imp(), the return value of regmap_read() is currently
> > > ignored. This is problematic because if the bus read fails the variable
> > > val_v remains uninitialized.
> > > 
> > > The function subsequently assigns this uninitialized stack value to
> > > *vbat, leading to incorrect measurement results being reported to
> > > the IIO subsystem without any error indication.
> > > 
> > > Update the function to check the return value of regmap_read(). Ensure
> > > that mt6358_stop_imp_conv() is still called to clean up the hardware
> > > state before returning the error code.  
> > 
> > Sounds like this deserves a Fixes tag, but the problem is that the whole driver
> > is written like this. Why does having this fixed make it special?
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   
> 
> You are right, Andy. I noticed that several other functions in this driver
> share the same issue. I will send a V2 that addresses all unchecked
> regmap_read() calls in this file and I will include the Fixes tag. Thanks
> for the feedback.
What's the bus in this case?

Whilst maybe we should be checking them, it is not uncommon to forgo those
checks in internal busses.  In general they should be more reliable than
something going over PCB tracks like spi or i2c.

I'd be tempted to fix the uninitialized variable by setting it at declaration
rather than worry too much about checking all the regmap return values.

> 
> Best Regards
> Salah Triki

