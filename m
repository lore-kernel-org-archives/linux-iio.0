Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51153A6B8F;
	Sun,  2 Aug 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785690760; cv=none; b=ioc/78yDTXc654SoPdZDtSQAUmp4uAntvcIF4JG6P76DK6dFDntIalZ0HI0uuhDwbYNTM2j3QlU+FU6HEiAV0xaasCewingi+gZc7Fsl0UpaR/594zXWzboklc/BcftIwOP8BrOfzxDkgHtnZTwhbzFwmPm7TNrtXTBH0XcQPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785690760; c=relaxed/simple;
	bh=TAwz7zDdhrO/RO7iz0Q7zXJArhhoVVKcE2nAWH7xfeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll0vGLcPn58g0xx9WDUqhcLMe+Oip3rzD5mKZq1dfGyUZb2CSfiMbEOsen/hp89BYRbd8gVrXqwyqXnu4fFkGb4Woy7IzHqoeQ+nROvaBIeojWmtFxvnP4p1v56syYVLbCPv1rxZs+zbbqSOQqJUkmaWEeD+eFSF0VTp/CtDJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnEbhZMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnEbhZMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA14F1F000E9;
	Sun,  2 Aug 2026 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785690756;
	bh=x77TEwp1ZbLt/BvOuNsHvCp1UdV2izmSI915dF93mOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gnEbhZMAZkc0YPd4zkuj0/X00JB432hZJypTeVzdiCMvc2tvsv/Veu7qdQuv2zng2
	 q1OLlTBUeCWabr11KEBTmaH6YAgMBkeHYZB/CPYI1jHPxy3QIsG79nQRAEHJY5K0+k
	 ZPnhbqW8U3NApHNW5DneakfbQSXHFPcEQ0CYwu4Pa0cwIoNFnRQreMkla0plOvWcPF
	 L6LU0CsVI3ePrXM1h6wJbE/2DH85mWNcBYb8pSOSZlyFEgNH63J+2acWG9g/62puyE
	 Ug2aEnCb7SmfM2m49K8KNZc8/NpEc7kyzzZeeyNggfJ1rNASjs8Clwv+hknCUDTpL4
	 K30q2IM0kaJvw==
Date: Sun, 2 Aug 2026 18:12:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Adi Nata <adinata.softwareengineer@gmail.com>, lorenzo@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: hts221: Fix checkpatch blank line
 warning
Message-ID: <20260802181233.535eeb12@jic23-huawei>
In-Reply-To: <20260802173852.32b4bc52@systembl0wer>
References: <20260802020614.19732-1-adinata.softwareengineer@gmail.com>
	<20260802173852.32b4bc52@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 17:38:52 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun,  2 Aug 2026 10:06:13 +0800
> Adi Nata <adinata.softwareengineer@gmail.com> wrote:
> 
> > Checkpatch warning:
> > 
> > WARNING: Missing a blank line after declarations
> > +	struct hts221_hw *hw = iio_priv(iio_dev);
> > 
> > Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> > ---  
> 
> This seems like churn on its own, Jonathan may not apply it.
> 

True.  This highlights a broader point.  When making
a number of cleanups to a driver (and I am generally more willing
to take those than many maintainers) please group them into
a little patch series with a cover letter.

If this is one of a set and overall the seem worthwhile I might
pick them up.  Plus this driver is pretty aged so there are other
quality of code / modernization things that will make much more
of an impact than just this blank line.  Take a look at some
of the other similar cleanup series on the IIO list and see what
makes sense here. To give you a starter, dev_err_probe() and
checking which prints are actually useful + stopping the driver
rejecting Device tree falllback compatibles because of the hard
fail on a device ID mismatch.

> 
> Also, I feel like just putting checkpatch warnings directly into the
> commit message is bad practice. Much better if it were "Add a blank line
> after variable declarations per checkpatch warning."

Fully agree with this.  We really don't care what the print is, just
what is being improved and why.

Thanks

Jonathan

