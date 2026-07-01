Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100C3B3894
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927808; cv=none; b=pY/VU4CSQ9Qli1lbYsh2NUvVNdX27/xKS9uNEqDwidhKC0vJ082TPiO8aWOXjnr05aJW0af3hoI7GSNRQrHBJdcNixa1wCiZJx3bbleaGgcMxrVRvHXKohxFiCGtT8933+K4B4OX3cW89/iH5D7CGyhO65810Xqcqi4zv+J9IAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927808; c=relaxed/simple;
	bh=0eD25zwC/0jGSUjTZAs4RmXKyQpW5L27PJRHCRdEv5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWmjOFx3ADBTUidDeqLQ8FzmhYVxMDO6fGJ8kiKD5DNwUyTlIbo4KLzFIoPbUhmI3tnMHT2lu1TWkRiVFNY+k8k06vnlOcJK89yp+Tn1YnXD83zuF/XIJJ3ZqMzKconrpyJXkkknjqiXjWEBKgch1v+/zvulMPRRuAbCxtBFib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT04Fse6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT04Fse6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B421F000E9;
	Wed,  1 Jul 2026 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782927806;
	bh=1HztUrr9riVkGU7NsYV1gwB9YG6xW23CUGC7soq18Rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gT04Fse6ehH+meUetYq3RexLgAfJSviuj+xxPfcK+uhLYnw4PPkY32OhEneEXKJbo
	 0KxA+SN2qB2KFKy5vqUW5thIpoPhIL4f3+92H7GUHtcVTEKMiFoT5YhUllWrznWtJb
	 f2qE2ZXa19u37Ro+r2luaHmzj2e35G6jP2DvleaG3ehYf0ILxvNGSxevBh0EH2jwED
	 0aD+3Jyir9tx6jXVNf0Vo/N644oSFr1HFFS/4Cdmd62VtFpz2UTo4Xc4n1Af93t1x7
	 POzbkuNnSYG1DkgrBSjA9n6q4Vap7n+8V+ADYMz3s8RTs25tQr6cKsGrvJ4zIdqpGT
	 T47REOkLqC2tg==
Date: Wed, 1 Jul 2026 18:43:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: =?UTF-8?B?4LiB4Li04LiV4LiV4Li04Lio4Lix4LiB4LiU4Li04LmMIOC4muC4uOC4jQ==?=
 =?UTF-8?B?4Lih4Liy4Lib4Liw?= <goorock.goopop@gmail.com>,
 linux-iio@vger.kernel.org
Subject: Re: [BUG] hid-sensor-trigger: poll_value sign unchecked before
 msleep_interruptible causes ~49.7 day sleep
Message-ID: <20260701184323.6d684978@jic23-huawei>
In-Reply-To: <20260701092824.000040e4@gmail.com>
References: <CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3Lfyoj3RaZ2v4dg@mail.gmail.com>
	<20260701092824.000040e4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jul 2026 09:28:24 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 1 Jul 2026 09:40:54 +0700
> =E0=B8=81=E0=B8=B4=E0=B8=95=E0=B8=95=E0=B8=B4=E0=B8=A8=E0=B8=B1=E0=B8=81=
=E0=B8=94=E0=B8=B4=E0=B9=8C =E0=B8=9A=E0=B8=B8=E0=B8=8D=E0=B8=A1=E0=B8=B2=
=E0=B8=9B=E0=B8=B0 <goorock.goopop@gmail.com> wrote:
>=20
> > KERNEL BUG REPORT
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Component : drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > Subsystem : IIO / HID Sensor
> > Severity  : High (device permanently unusable until service restart)
> > Kernel    : confirmed on 6.17.x; code path present in mainline as of 20=
25-06
> >=20
> > Summary
> > -------
> > _hid_sensor_power_state() passes the return value of
> > hid_sensor_read_poll_value() directly to msleep_interruptible()
> > without checking for a negative (error) return. When the HID
> > descriptor does not contain a Report Interval feature field the
> > function returns -EINVAL (-22). This value is implicitly converted
> > to unsigned int before being multiplied by 2 and passed to
> > msleep_interruptible(), producing a sleep duration of
> > ~4,294,967,252 ms (~49.7 days). The process enters
> > TASK_INTERRUPTIBLE state and appears permanently hung to the user.
> >=20
> >=20
> > Affected Code
> > -------------
> > drivers/iio/common/hid-sensors/hid-sensor-trigger.c:
> >=20
> >   static int _hid_sensor_power_state(struct hid_sensor_common *st, bool=
 state)
> >   {
> >       ...
> >       s32 poll_value =3D 0;
> >       ...
> >       poll_value =3D hid_sensor_read_poll_value(st);   // can return -E=
INVAL
> >       ...
> >       if (state && poll_value)                        // BUG: -22
> > passes this check
> >           msleep_interruptible(poll_value * 2);       // -22 * 2 cast
> > to uint =3D ~4.29e9 ms
> >       ...
> >   }
> >=20
> > hid_sensor_read_poll_value() (hid-sensor-attributes.c):
> >=20
> >   s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
> >   {
> >       s32 value =3D 0;
> >       int ret;
> >=20
> >       ret =3D sensor_hub_get_feature(st->hsdev,
> >                                    st->poll.report_id,   // 0xffffffff
> > if not found
> >                                    st->poll.index, sizeof(value), &valu=
e);
> >=20
> >       if (ret < 0 || value < 0) {
> >           return -EINVAL;    // returned when Report Interval not in de=
scriptor
> >       }
> >       ...
> >       return value;
> >   }
> >=20
> >=20
> > Reproduction
> > ------------
> > Hardware : Seeed XIAO nRF52840 Sense (LSM6DS3 IMU) via USB HID
> >            VID:PID 2886:8045
> > OS       : Bazzite (Fedora immutable), kernel 6.17.x
> > Drivers  : hid-sensor-hub, hid-sensor-accel-3d, iio-sensor-proxy
> >=20
> > The device implements a USB HID Sensor (Usage Page 0x20,
> > Accelerometer 3D, usage 0x200073) with Power State (0x200319),
> > Report State (0x200316) feature fields =E2=80=94 sufficient for probe to
> > succeed =E2=80=94 but without Report Interval (0x20030E).
> >=20
> > Steps:
> > 1. Plug the device.
> > 2. Allow iio-sensor-proxy to start and attempt the first read.
> > 3. Observe: iio-sensor-proxy main thread enters D/S state and
> >    never returns. 'cat in_accel_x_raw' also hangs indefinitely.
> > 4. systemctl restart iio-sensor-proxy unblocks all hung processes
> >    (SIGTERM interrupts the interruptible sleep).
> >=20
> > Kernel stack trace (captured via /proc/<pid>/task/*/stack while
> > process was hung =E2=80=94 iio-sensor-proxy PID 1011, kernel 6.17.x):
> >=20
> >   [<0>] msleep_interruptible+0x3b/0x90
> >   [<0>] _hid_sensor_power_state+0x166/0x1e0 [hid_sensor_trigger]
> >   [<0>] __rpm_callback+0x48/0x1f0
> >   [<0>] rpm_callback+0x6d/0x80
> >   [<0>] rpm_resume+0x4af/0x6d0
> >   [<0>] __pm_runtime_resume+0x52/0x90
> >   [<0>] hid_sensor_power_state+0x51/0xe0 [hid_sensor_trigger]
> >   [<0>] accel_3d_read_raw+0xa8/0x210 [hid_sensor_accel_3d]
> >   [<0>] iio_read_channel_info+0xed/0x110 [industrialio]
> >   [<0>] dev_attr_show+0x1f/0x50
> >   [<0>] sysfs_kf_seq_show+0xcc/0x120
> >   [<0>] seq_read_iter+0x128/0x480
> >   [<0>] vfs_read+0x268/0x390
> >   [<0>] ksys_read+0x73/0xf0
> >   [<0>] do_syscall_64+0x7e/0x250
> >   [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >=20
> > Note: the process is in TASK_INTERRUPTIBLE (wchan=3Dmsleep_interruptibl=
e,
> > STAT=3DS), not TASK_UNINTERRUPTIBLE =E2=80=94 it responds to signals. T=
his is
> > why a service restart (SIGTERM) unblocks it, and why it is easy to
> > mistake for a runtime PM deadlock rather than an unchecked sleep durati=
on.
> >=20
> >=20
> > Proposed Fix
> > ------------
> > drivers/iio/common/hid-sensors/hid-sensor-trigger.c:
> >=20
> >   --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> >   +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> >   @@ -143,7 +143,7 @@ static int _hid_sensor_power_state(...)
> >           poll_value =3D hid_sensor_read_poll_value(st);
> >        }
> >   -    if (state && poll_value)
> >   +    if (state && poll_value > 0)
> >            msleep_interruptible(poll_value * 2);
> >  =20
>=20
> Yes, this is something that should be fixed. Can you send a patch?

True to needing fixing, but not that fix.  Just check poll_value
at point of original assignment and error out if it is negative.

Jonathan

>=20

