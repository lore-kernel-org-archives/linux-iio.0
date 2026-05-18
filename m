Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE843EC2E0;
	Mon, 18 May 2026 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118061; cv=none; b=TzxgW52xRemVe8Jl47Vd2S/1mITe8Ly4HKKwyRl1LfrHI/3TtBRFZ6uFSHP+foE4Eg0uBuz/Gf4U/T88Cat6ZPoyF74H5YnwEK7ISGj2RxY51cGxGqHbF3egiF/TkE395Jx9OC3fcRC2COY5R+gVNOzrjRCnfTpsHrixySegeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118061; c=relaxed/simple;
	bh=mUOK6qmHacv/qcvxc6UUxpjl/FviIVmhdOdQykrCChM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktPoxMKPBD3Igu+9Km7V9a0dZdxxbMkX5pmmIKMq/rAYrb13tDpwUL5vtw2rkKVPcoqNgj4PFUQ8ulCyLWi57+AXTIF4ddgBK7m2AnGRFhPDQa8y20LCo6p+j1F+P1oIdPK69dcWyO9bT5miWW8oqxvsgW5Kh1Pr01eGUQrV6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcsVXK6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcsVXK6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8A4C2BCC7;
	Mon, 18 May 2026 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779118060;
	bh=mUOK6qmHacv/qcvxc6UUxpjl/FviIVmhdOdQykrCChM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IcsVXK6iAFKZ73Aohq05zz10Ybwz3YcV02aHKP7U11h4p6cPqh4Q3+TdMWnJ6wxVF
	 RzHmtg5k4Zw+TIS5CgqBGxe36xCoiYZlYZMZA3QreBLncDWOpFdEpJhgFknptlp2Mf
	 i9hKHSIC1d86hGvxGAX8RmtfGPAOFILFs8soyRIy/xxt8/n9CVFg0bqknqGDUzEpX6
	 2cz/zMFTqJ697uKuM0L//2r60mDiDO5RudT25Zb38u0Ofhh8YHb2ADZ+D+zA2Il6HD
	 CsNklNP6tIJyUha4P4X4VKbPZCXx6Ndtgp24IgKrkRQFSw+Kw5m4kzHbU5tBwsiJds
	 ZsOqWOcrIRbzw==
Date: Mon, 18 May 2026 16:27:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, Radu Sabau <radu.sabau@analog.com>,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in ANALOG DEVICES INC
 AD4691 DRIVER
Message-ID: <20260518162730.7bacf931@jic23-huawei>
In-Reply-To: <CALoEA-yikL+PRDys2tXY5GKZhZtWRYdfhsczrgUWrr+rrbZqBQ@mail.gmail.com>
References: <20260518114502.219375-1-lukas.bulwahn@redhat.com>
	<CALoEA-yikL+PRDys2tXY5GKZhZtWRYdfhsczrgUWrr+rrbZqBQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 14:50:55 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 18 May 2026 at 13:45, Lukas Bulwahn <lbulwahn@redhat.com> wrote:
> >
> > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> >
> > Commit 963d07535e77 ("docs: iio: adc: ad4691: add driver documentation")
> > adds a file entry in the MAINTAINERS section ANALOG DEVICES INC AD4691
> > DRIVER referring to the non-existing file drivers/iio/adc/ad4691.rst. This
> > commit however adds Documentation/iio/ad4691.rst; so likely, the file entry
> > intends to refer to that newly added file.
> >
> > Correct the file entry to refer to the intended file.
> >
> > Fixes: 963d07535e77 ("docs: iio: adc: ad4691: add driver documentation")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > ---  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

Applied.

Thanks,

Jonathan
