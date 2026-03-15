Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB13359A84;
	Sun, 15 Mar 2026 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773580083; cv=none; b=c5b3Lw0AX3dNMj2WNen5jSfetd4XBSfqSztZfweWxfJB+WcV59ZL6Bhrv3zeyBcRTnzUfAmtg4z0kOuN4AV00W89wXocFXPt2nsnCV1DQtmIrCduvoWhqf9OMohNdCoq4/Hkq86O+accWJ+M60IUeBkWO2EmmUnd5wN3Uzy+qv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773580083; c=relaxed/simple;
	bh=/5uB8PXcWGsWzcY2Ph0NSkkENzEEC4p4J3wxzeMRoH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awbfB4IJEWhy/U/rdlyDbphVcMi9R7Mpe87oDr4tZC1KrSpCpyrucIfuh/5TI3ii//Vu9FvBB4drDmVJ0v4Djih01gZfOrIwhcw0Gqrl021mdk95SEnP76saf8/bexP7CvQ2udznsphYvzVj/M+ASJZV6TmepH22WYSNjIpbqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1uieptp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1uieptp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA974C4CEF7;
	Sun, 15 Mar 2026 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773580083;
	bh=/5uB8PXcWGsWzcY2Ph0NSkkENzEEC4p4J3wxzeMRoH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p1uieptpxShKIoNf+0ktvs0S4H1N3QGe5Tf9UNMm87IZMj2g2ITETCxfs3vswSv4w
	 BkuvG7dI4mYP5EMG1+h7weGSAKhWzf+72pwdjXYFW7dNuLjWjcPFKbGv+Z6y9QU3MC
	 760SKPJ6GBu7SJ7UBEQ7RIiR+7SF6ZOgL25VOpLkmG/93GIwdS68ZvC8VY4fk0cId5
	 Z1Eq8s0k1h7iWhct7vT9u2QiuRkrOOtDuGuvb33gi8bCYXh1JjmwLsSnR9GX8urWcv
	 QMNOGNlfGDc+VPSOO914EL2XIvBSWCw3xoIqfPc4EGno+D8exhS00EUypShRwew5/j
	 kU3NDQGfYhHew==
Date: Sun, 15 Mar 2026 13:07:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Shi Hao <i.shihao.999@gmail.com>, <andriy.shevchenko@intel.com>,
 <andy@kernel.org>, <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <marcelo.schmitt@analog.com>,
 <nuno.sa@analog.com>, <mazziesaccount@gmail.com>, <daniel.baluta@nxp.com>,
 <simona.toaca@nxp.com>
Subject: Re: [PATCH v4 0/6] iio: fix spelling mistakes in comments
Message-ID: <20260315130743.0dc0aebf@jic23-huawei>
In-Reply-To: <20260311101007.gaqcner4fzamyirm@lcpd911>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
	<20260311101007.gaqcner4fzamyirm@lcpd911>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 15:40:07 +0530
Dhruva Gole <d-gole@ti.com> wrote:

> On Mar 11, 2026 at 15:09:27 +0530, Shi Hao wrote:
> > This series fixes spelling mistakes in comments across several IIO
> > subsystems to improve readability and code consistency.  
> 
> I just tried applying this series locally, on top of linux-next tag: next-20260310

Agreed. The series seems to have some corruption issues.

Linux-next is very unlikely target for pretty much anything!
Maybe it'll have the right patches at a given moment, maybe not.

> 
> Could you please make sure to use git format-patch with the option --base HEAD~N
> where N is the number of your patches?
> This will help identify what you used as the base commit for all your
> changes. Make sure it's usually on top of the latest linux-next.
> 
> I also ran checkpatch on them, and saw a bunch of errors and warnings,
> not sure if you've run it on your end and ensured it's clean?

I would very much take those warnings lightly. By all means check
them but I ran it on the first patch and it generated completely
incorrect changes because it was interpreting comment blocks
as code.

> 
> > 
> > v4:
> > 
> > - Fix commit message grammar and punctuation across patches
> > - Keep 'whilst' instead of 'while'
> > - Rephrase sentence in chemical driver comment
> > - Capitalize IIO in comments  
> 
> Also, in the changelog, please add links to your previous revisions.
> This make reviewing things and getting context much easier.
> 
> > 
> > v3:
> > 
> > - Change commit subjects as per changes
> > - Capitalize proper acronyms (IRQ) and Celsius
> > - Fix short wrap in commit body
> > 
> > v2:
> > 
> > - Split original patch into 6 commits
> > - Fixed commit message formatting and typos
> > - Added necessary tags in commits
> > - Added more fixes then previous
> > 
> > Shi Hao (6):
> >   iio: accel: fix typo celcius to Celsius
> >   iio: adc: fix spelling mistakes in comments
> >   iio: amplifiers: fix typo Curren to Current
> >   iio: cdc: fix spelling mistakes in comments
> >   iio: chemical: rephrase sentence and fix typo in comment
> >   iio: common: fix spelling mistakes in comments
> > 
> >  drivers/iio/accel/adis16201.c                          | 2 +-
> >  drivers/iio/accel/adis16209.c                          | 2 +-
> >  drivers/iio/adc/ad4030.c                               | 2 +-
> >  drivers/iio/adc/ad4170-4.c                             | 6 +++---
> >  drivers/iio/adc/ad7380.c                               | 2 +-
> >  drivers/iio/adc/ad7887.c                               | 2 +-
> >  drivers/iio/adc/ad7923.c                               | 4 ++--
> >  drivers/iio/adc/at91_adc.c                             | 4 ++--
> >  drivers/iio/adc/max1363.c                              | 2 +-
> >  drivers/iio/adc/mcp3564.c                              | 2 +-
> >  drivers/iio/adc/men_z188_adc.c                         | 2 +-
> >  drivers/iio/adc/npcm_adc.c                             | 2 +-
> >  drivers/iio/adc/palmas_gpadc.c                         | 2 +-
> >  drivers/iio/adc/rohm-bd79124.c                         | 4 ++--
> >  drivers/iio/adc/spear_adc.c                            | 2 +-
> >  drivers/iio/adc/stm32-adc-core.c                       | 2 +-
> >  drivers/iio/adc/stm32-adc.c                            | 2 +-
> >  drivers/iio/adc/sun20i-gpadc-iio.c                     | 2 +-
> >  drivers/iio/adc/ti_am335x_adc.c                        | 2 +-
> >  drivers/iio/adc/twl4030-madc.c                         | 2 +-
> >  drivers/iio/adc/twl6030-gpadc.c                        | 4 ++--
> >  drivers/iio/amplifiers/ada4250.c                       | 2 +-
> >  drivers/iio/cdc/ad7150.c                               | 2 +-
> >  drivers/iio/cdc/ad7746.c                               | 2 +-
> >  drivers/iio/chemical/bme680_core.c                     | 2 +-
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
> >  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
> >  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
> >  drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
> >  29 files changed, 35 insertions(+), 35 deletions(-)
> > 
> > --
> > 2.53.0  
> 

