Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059136167C;
	Tue,  3 Feb 2026 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139768; cv=none; b=hsn/Brzl8to7AK419KQQezal1fthvU6ax1tlfGnjhpCr9RRPDmWPz38q7BBWHEyZhjmw5IpkYwgkAzwUGzQeivl/Dr6gqKRA11b9NTrFJC2zwjIU4FPOArhxctcQK7cGYnOYkxhCPQ73Ou9Ozx31OhWj2emxNomhfaghAfCoo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139768; c=relaxed/simple;
	bh=/27KvDUVJ+RN0F4dVRyGVqzNXWFUbANdZeNFMknt3SI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDGJrY1CF8lvc7oJ+02JvBJfFJuG1mDC1LTDhhM1LvxqrDI5cQH6mkzHbw7nOuMNibuqSvoQB5bbV9y4ep1hVz92/rCMKpBkfFTjhCsZPjmzy/kAIQjROKB8bxqNKo7a91/7MkUb89tU8ob45UGSGZoCbQ3ESpGEMilym3pSJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+ZRHclF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+ZRHclF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770139766; x=1801675766;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/27KvDUVJ+RN0F4dVRyGVqzNXWFUbANdZeNFMknt3SI=;
  b=M+ZRHclFcL8HTu3/3OoPHvHZkJOUx2I1FEd12PG9V7BI6Jju4lUP+CA1
   IPVuy+6tFvayPh6dUjxs913lcc1Fzop+McG/TecWRWJuZQ4MyzFR1135F
   DU2p8wN/y3UuiLo3umgEd31bWdG42tRhrdAXI/Cy0Z4DNtd8wJxHyav0j
   ilnexjJFNt0wtD+tBgg0m6/rVijMOqYSDrbV7/xTafo37kflD2s1D3Zc2
   w6EvNwnElroatQhgu4VyTrUkq6La89YE5NZKfBTC/tvuyj6jIc2GO+0lq
   IGwD1KLBMw7vs3h57TmNvU35WR9g+dTTSzmUW94FvCB00qHJI8MEDqfI0
   A==;
X-CSE-ConnectionGUID: RX1D5fe/QmW+5Qo0r/mrhA==
X-CSE-MsgGUID: VBYJlAuEQlSN1vYcqEpmEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82056637"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="82056637"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:29:25 -0800
X-CSE-ConnectionGUID: SjdxNE5/SaG275IC+Pmb1g==
X-CSE-MsgGUID: fosdHngvSuafuI3fuvUJdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="232829317"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:29:25 -0800
Message-ID: <0a3433112f0bec3d5bd76c7ae9b6774b455203a6.camel@linux.intel.com>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Bert Karwatzki
	 <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jiri Kosina
	 <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 03 Feb 2026 09:29:25 -0800
In-Reply-To: <20260203083826.1gOzxrwt@linutronix.de>
References: <20260113120541.YVf2vRA3@linutronix.de>
	 <20260202232741.13380-1-spasswolf@web.de>
	 <20260203083826.1gOzxrwt@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-03 at 09:38 +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-03 00:27:40 [+0100], Bert Karwatzki wrote:
> >=20
> > The warning appears because iio_triggered_buffer_setup_ext() (in=20
> > drivers/iio/buffer/industrialio-triggered-buffer.c) is called with
> > thread =3D NULL
> > during the probe of the iio device and calls iio_alloc_pollfunc()
> > (in drivers/iio/industrialio-trigger.c) with thread =3D NULL and type
> > =3D IRQF_ONESHOT.
> >=20
> > A simple fix could be this:
> >=20
> > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > index 9bf75dee7ff8..40eea3a44724 100644
> > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev
> > *indio_dev,
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->pollfunc =3D iio_=
alloc_pollfunc(h,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threa=
d,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_ONESHO=
T,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thread ?
> > IRQF_ONESHOT : 0,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio=
_dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s_c=
onsumer%d",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio=
_dev->name,
> >=20
> >=20
> > Are there any problems with this?
>=20
> Urgh. Haven't seen those.
>=20
> Looking at all the users of of *iio_triggered_buffer_setup*() the
> primary handler is either NULL or iio_pollfunc_store_time().=20
> So IRQF_ONESHOST should work all the time.
>=20
> Then there is=20
> - drivers/iio/adc/vf610_adc.c=20
> - drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>=20
> They use iio_pollfunc_store_time() as primary and have no secondary.
> This would trigger the warning but not having a secondary handler
> while
> returning IRQF_WAKE_THREAD should create a warning of its own.
> What did I miss?
>=20

hid-sensor doesn't need a bh handler. This patch can fix.=20

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5540e2d28f4a..b2b09b544f43 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -227,6 +227,11 @@ static const struct iio_trigger_ops
hid_sensor_trigger_ops =3D {
        .set_trigger_state =3D &hid_sensor_data_rdy_trigger_set_state,
 };
=20
+static irqreturn_t triggered_buffer_handler(int irq, void *p)
+{
+        return IRQ_HANDLED;
+}
+
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char
*name,
                                struct hid_sensor_common *attrb)
 {
@@ -240,7 +245,8 @@ int hid_sensor_setup_trigger(struct iio_dev
*indio_dev, const char *name,
                fifo_attrs =3D NULL;
=20
        ret =3D iio_triggered_buffer_setup_ext(indio_dev,
-                                            &iio_pollfunc_store_time,
NULL,
+                                            &iio_pollfunc_store_time,
+                                            triggered_buffer_handler,
                                             IIO_BUFFER_DIRECTION_IN,
                                             NULL, fifo_attrs);
        if (ret) {


Or add it to industrialio-triggered-buffer.c as a common handler for
all caller with no bh, whatever Jonathan prefers.


Thanks,
Srinivas



> > Bert Karwatzki
>=20
> Sebastian
