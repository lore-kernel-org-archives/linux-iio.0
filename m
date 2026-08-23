Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6B388866;
	Sun, 23 Aug 2026 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511776; cv=none; b=Sxgk0Xy2sVisf6yXLdk1d+jvh1/n4VuScAohzsQG5ZJZlrh7hMwl2r5Y3lDaSBCypJ0trGZyq4CMAexNKRk08ei2YoJtI6tI2O5MQI5cQCO2zrbquz9YQeDtYFDZzvxGJaZQR6eWKLyrtokqGz2BAiaDnczqD2ugycLTEaZ8gJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511776; c=relaxed/simple;
	bh=zQKkI4HCnMPJgNsqQ/P/JVwWYvKeCRDDBFPn7KU9HSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofFnt2mW55pd2/jGej/gt5i3NonysYV1cjKZNmp+FuWsisqkSSgPDju8d2v78DdSr1FsL8HM7ta7EDaIsjS/WurYlMqj886j51ApyN/KelECUpO/Q+grlUBSc7Zz+fPLN4DpVbGrDetnv0Aiau7R6v9hfvH+MnrXv/YosbXDarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw1bN2Gp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw1bN2Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6581F000E9;
	Sun, 23 Aug 2026 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787511775;
	bh=vW0VLvL3CIObSQaswcgizCcXxlZWcVLyOpWpsBKm2xY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bw1bN2GpHs9wtt8WkAsEOh2bIDqzueXtizdGqm0Ke1EiwRyOt7mMRGgaiQEuyBjEg
	 KQ4bOf0erusOwG67W54Xsw4o174LTfvUPPhlwemtCZtCEBZo9+liFKvcOjF68CqsZv
	 Mj7+FvB4l3CgyXGjsfXQmxxnn0P0XaQ+9VWM4/QBGctJU3DY95Ri0tIWl45+UYmShn
	 B+YHX9UAU6PksM+2OaLoIkins6mKimBLgc0A3GjOgIFsV2kvrPJgw94aTTKUqInknZ
	 InjBfgJ9VZrNW6QnviqkvDtGLPQtlQjPzyx/5BILwdTwp78W67opVmUehIswkurhId
	 kbvV4p7pMwIzg==
Date: Sun, 23 Aug 2026 20:02:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, Chen Wang
 <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, Takashi
 Sakamoto <o-takashi@sakamocchi.jp>, u.kleine-koenig@baylibre.com, Danilo
 Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-iio@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sophgo-saradc: Handle errors from optional
 IRQ lookup
Message-ID: <20260823200249.23a02f47@jic23-huawei>
In-Reply-To: <CAABR9nFdnFH-gspxEZffAb13_vvrs+x4Ksznq5JFO1gMEmw4_Q@mail.gmail.com>
References: <20260813074810.27574-1-phucduc.bui@gmail.com>
	<20260822023959.4319f0c3@jic23-huawei>
	<CAABR9nFdnFH-gspxEZffAb13_vvrs+x4Ksznq5JFO1gMEmw4_Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 05:27:21 +0700
Bui Duc Phuc <phucduc.bui@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for your feedback.
> 
> > >
> > > platform_get_irq_optional() returns a positive IRQ number on success or
> > > a negative error code on failure. For an optional IRQ, -ENXIO indicates
> > > that no optional IRQ is available. Other errors, such as -EPROBE_DEFER
> > > and -EINVAL, should be propagated so that the caller can handle them
> > > appropriately.  
> >
> > That function is very much undocumented other than not printing a
> > message when it returns an error.  However I think you analysis is
> > correct.
> >  
> 
> Yes, I agree. The documentation for this function may not be clear enough,
> which could have led to error handling being implemented incorrectly
> in some places.
> 
> There is also an inconsistency in this driver: if devm_request_irq() fails,
> the error is returned and the probe fails. But if platform_get_irq_optional()
> fails, the error is ignored.
> I'm not sure whether the author misunderstood and assumed that any
> negative return value simply means that there is no IRQ.

If the platform irq get fails because there isn't one in firmware, we expect
to just carry on (no interrupt support).  What we are missing is failing when
there is one but we get an error anyway.

For the later devm_request_irq() that is only called if we have an irq
from firmware, but something else goes wrong. That one should definitely 
always fail probe as it indicates a probe (rather than lack of interrupt
support)

> 
> > I'm not going to rush this is because it is not known to have
> > been a problem in the wild (only odd loading orders should have
> > caused deferal).
> >  
> 
> I understand your point. However, in this case the error can be
> completely hidden:
> There is no error message or log, the error is not returned, and the
> driver falls back
> to polling:
> -----------------------------------
> if (saradc->irq < 0) {
>         u32 reg;
> 
>         return readl_poll_timeout(saradc->regs + CV1800B_ADC_STATUS_REG,
>                                                  reg, !(reg & CV1800B_ADC_BUSY),
>                                                  500, CV1800B_READ_TIMEOUT_US);
> }
> ------------------------------------
> 
> So there may never be an obvious failure for a user to report.

Without evidence that there are real setups where interrupt controller
loads late enough to result in a deferral + are used with this chip
I'm fine with the small risk of just using polling in kernels prior
to the fix.  Everything still works, just potentially less efficiently.

Jonathan

> 
> Best regards,
> Phuc

