Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833B35975;
	Sat, 22 Aug 2026 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357296; cv=none; b=iUUTnexyoA6F1XicRddX6cBe/0Q/nUp/4HaQUV4ZDc0NcwXd1dJEsqd2mVr8+Ws0VohTaEpCPdDJ0P9QgtzC2FNMsnyepaFpDTYT+HKS3r1UHdp3N5QhZMsse8GaEF2iXCY3ZXqKj37y/AwU+xUvahDRHczHPzAUK4RkuH68Hjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357296; c=relaxed/simple;
	bh=hpBe4zWzaFooGLnN928wV74ivkIUy5RkUt57kZ4oibY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twdYjGRGw0GZzF7L5uKoCKbChBl4ViSYG75N13m8m3uGbgX4p04x7kSdHBqRZY91sqQ2XDcUIG1i9e1Emalg+oD0TAs4Yof+pWhNd0pADdTTBaPM4I/AiL32AroJlz1D0o1G4/uO48Zp+9/ccqfb4X3PCcWaNpgaz4Uxa/k0aXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoGib1TM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoGib1TM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7421F000E9;
	Sat, 22 Aug 2026 00:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787357294;
	bh=OL5k7+Q5i0yFPOc61t/k3t4AN28lf8CpQ80gOwJWSnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VoGib1TMK3nD8CoIhO9wEziSdWT7K6w9CP8ujelATdoC5KK7YF2zTo4Hn/8KKWgiQ
	 +cfpZ+rRIcaBfxu3YZTbCNqeRpmVfEmad6Fq/kX6PaAwfgxXmeCPYrg/KGQUerrJSr
	 bHEdKCU5Op1PcS9bCclHGtfoQiMqUgDUjlRtYLUBvT41aeYpB+JhNdiVHkdU0SLKmp
	 DPaMO4MWawADsgPoSrakRtSlQTdhP/rnRg7J/KCkkFI+/RecjN54IBQPAGcofz7eJk
	 klm/i/fqNnfaV9XdSVm/paB56503mRFn2KwU9wLf4JjrrTSSSMjw8ags7HnupxVZai
	 ycmp0h2+pG4kQ==
Date: Sat, 22 Aug 2026 01:08:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Andreas Klinger
 <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf04: fix runtime PM autosuspend
 cleanup
Message-ID: <20260822010809.04404b4e@jic23-huawei>
In-Reply-To: <aoQGR8uSXXmOxnWI@hovoldconsulting.com>
References: <20260807141938.2491195-1-lgs201920130244@gmail.com>
	<aoQGR8uSXXmOxnWI@hovoldconsulting.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 09:14:15 +0200
Johan Hovold <johan@kernel.org> wrote:

> On Fri, Aug 07, 2026 at 10:19:37PM +0800, Guangshuo Li wrote:
> > srf04_probe() calls pm_runtime_use_autosuspend() when the optional
> > power GPIO is present, but srf04_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> > 
> > The runtime PM documentation requires pm_runtime_use_autosuspend() to
> > be balanced with pm_runtime_dont_use_autosuspend() when the driver is
> > removed. Failing to do so can leave the autosuspend usage state
> > unbalanced and may result in a usage_count leak when the autosuspend
> > delay is negative.  
> 
> I believe the term "leak" here is misleading as the usage count would be
> dropped again when the user re-enables autosuspend through sysfs, right?

A user has no reason to do that under normal circumstances.
So whilst that might work it is rather non user friendly to the extent
I think I'd consider it a bug that should be fixed.  Backport or not
is a different question.

Jonathan


> 
> That said, drivers should clean up after themselves so disabling
> autosuspend is still the right to do. But it's more of a cleanup than a
> fix (and does not need to be backported).
> 
> Johan

