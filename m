Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D244414;
	Mon,  9 Feb 2026 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770602456; cv=none; b=LgFYTm6jfXjGYoK5qf3fjMicqjlv+lX1ZkZbYlpF3XXUjUDH9VwD4S2JMpx59pmBz2W1mb0kQ37sOV8kIm8UUXzi2akj3jWcOiExF+Yh4aR4y1prcb3PeoK5z5nC+tJfA/N6VPN3qn9omXc0pX56LnHxNSGwlXii9J4wRSyt8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770602456; c=relaxed/simple;
	bh=7otLzrkC61uGm/9r5kJcqEAzwDUQ+4uTVyKg0uxYzrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=me083cBNEz5eaIETnOj9DRn1x6uL3ME1qpG8bJBUCPPGOr7OzlXFxyhkis9HpJeFff1zm/3oHj/MTa+iycoTkTnfSoAKPWDUOSwGWNTvobmgAiuOdtW+5U4AYfrNVjYvBQnShk9RI/aML5KAP4NuGAjb1mqSLTFnFe+84vdGljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/lx3lWi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/lx3lWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770602456; x=1802138456;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7otLzrkC61uGm/9r5kJcqEAzwDUQ+4uTVyKg0uxYzrA=;
  b=X/lx3lWiRJ2mdc2KsxITQoUMNlT7w3JNvMiW/3XzrH1PhXDKQiCIAmZ/
   3fXqbFzY0If7vAP69nJqrmMbAdUlZdN8EowLP795gbideFoA5JkyZk3TL
   Xu/+u8DtEldd/KsUdBOesXt3UgUaIY8zh/V5FMELCQQVwkKs0mInZHuI3
   MSILqQGwQLPHU2baM127Lys0W3WVP/8xFrzAoppAFTuinqQcUrxv/zxe7
   0wC5d1VZEySoTriFdo3WOEMhQ0yhzDy4aY4KDDCisJK2PtWajppoCkYUk
   ZExxtX8l7b117tpiOIxvE53Ab6onUpAbz8GKJx7D4CMjv25Hpg+OdWKBS
   Q==;
X-CSE-ConnectionGUID: HdhAl0mySHy6w5wTkC/8og==
X-CSE-MsgGUID: iZDdgg8WQkCrN6EW4xceJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71813757"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="71813757"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 18:00:55 -0800
X-CSE-ConnectionGUID: KVwL6CbDTh+w8X7BIC/Gsw==
X-CSE-MsgGUID: bz/NbrIATky9ceqMt8fY8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="210650595"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.111.220]) ([10.125.111.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 18:00:54 -0800
Message-ID: <a69abd18ea5a30fdb32478183ad16d9aaacd73a3.camel@linux.intel.com>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 08 Feb 2026 18:00:53 -0800
In-Reply-To: <20260207154638.30f3b47b@jic23-huawei>
References: <20260113120541.YVf2vRA3@linutronix.de>
		<20260202232741.13380-1-spasswolf@web.de>
		<20260203083826.1gOzxrwt@linutronix.de>
		<476cf5e072259332676c431c19ca3188705a86f1.camel@web.de>
		<20260203145856.Rc52LIS5@linutronix.de>
	 <20260207154638.30f3b47b@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-02-07 at 15:46 +0000, Jonathan Cameron wrote:
> On Tue, 3 Feb 2026 15:58:56 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>=20
> > On 2026-02-03 11:43:53 [+0100], Bert Karwatzki wrote:
> > > Yes, this should call warn_no_thread() when the interrupt is
> > > triggered, but
> > > I don't know if these sensors are actually functional on my
> > > laptop (I've never
> > > tried to use them).
> > >=20
> > > So I installed libiio-utils from debian and this is the output
> > > from
> > > iio_info:=C2=A0=20
> > =E2=80=A6
> > >=20
> > > The iio:device* sensors all report 0 for the "offset value", so
> > > these
> > > sensors are maybe non-fuctional.
> > >=20
> > > =C2=A0=20
> > > > What did I miss?=C2=A0=20
> > >=20
> > > I don't think you missed something, but the thread function being
> > > NULL here
> > > could a problem on devices where these sensors actually work. (Or
> > > perhaps these sensors
> > > need to be polled and the interrupts never trigger (?))=C2=A0=20
> >=20
> > I only found one handler where the thread handler was NULL and it
> > returned WAKE_THREAD. So this _is_ broken.
> > Was it one of the driver I mentioned? If so I suggest to fix those
> > first. I have no idea how this should work=E2=80=A6
> Both the drivers that are called out in this discussion look to
> be registering a triggered buffer, but are not using a trigger to
> fill
> it. So they should not be doing that in the first place.

Replacing with devm_iio_kfifo_buffer_setup_ext() breaks user space on
laptops as they expect current_trigger. This is not available for
INDIO_BUFFER_SOFTWARE. Using INDIO_BUFFER_TRIGGERED doesn't help
without poll function. Still breaks user space. This all works from
Linux 3.1x in this mode.

Sensors are powered off till user space writes to current_trigger which
results in call to .set_trigger_state() via
iio_trigger_attach_poll_func().=20

Here the hub is pushing data, not pulled to register a thread handler
and read.

So not sure what to add to thread handler other than dummy function.
=20

Thanks,
Srinivas

>=20
> The right fix is either to not use those helpers at all and register
> the kfifo directly (so none of the problem infrastructure is used) or
> implement a proper trigger / buffer separation by having their
> interrupt
> handlers as the trigger then moving the data reading into the
> pollfuncs.
> At that point there would be a thread here to do that read and we'd
> not have the bug.
>=20
> Jonathan
>=20
> >=20
> > > Bert Karwatzki=C2=A0=20
> >=20
> > Sebastian
