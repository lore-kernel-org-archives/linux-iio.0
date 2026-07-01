Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89533B42EB
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890909; cv=none; b=F03xK1wy1iCnTB3HsiEvFXodSSe+w34l6PswkgLF+0H6KjR1ljDyqmatAWmg2OWqM629UU0WlEuXI+bCUC6U4Qym0vLJbEoa0MOwi1Eb22kmhI3NYd0Zjg6j+Z9KIOY3FhV42v5cRfmHpFtMUr6cxiWSmubqw+UCoioww7xlDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890909; c=relaxed/simple;
	bh=R9Hsnhb/m1MON+FkaFfjvpmk+2EaxGf1xkcCT4bPBWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYYMjOvuC5MoEJZRbAdLGPZOjsAiRFSJx0cJytmpIACgooevL9lBZ2XHNToVQof5yA1ffFQv5r79vvWHzT2tYpL2nQwqiy2m5o2eoV5cXOxYcs3kPT8bgSYA69KDvIl4uZjUl6yic6Bsqkl96qxKbG+0Qr1Q5vtQohg1rcOvrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6mmu8KZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6mmu8KZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c00f74baso1569565e9.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782890906; x=1783495706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8VjUfdfZIvWwH5/Y6PbKw+VndA5OxOoRyB1H70fxh0=;
        b=c6mmu8KZrk/Xi4C+glwcZ42mxkYIQEkE6+2obbUAaZzWpgibtwpNcAkZiGFb35MsRl
         jsTMmNy4Oh8im/1fVKWuaIz3iSD1FnJOELqNgUx9Lwvr3urzX9O4u1KE08R87tc44m15
         FYJSUao5uHiAvAt92mwRbbkD7vHfjjHAVkb3Ttk5dIkXo3w4Wi31UhIKTg50AvEmIivk
         Bnh1WBBamX71/tMgeWw4VKOKmLpik2ZHCxfca4QmlWr03D7n+7JpDZOJY4wFHuRQRW1Y
         q9Dg79TRVJQKszpWmKVuZIBDRGSluZD/Y6NV3iK21kiyz2SLa9z2cZCc/STRqU1ZMhZw
         KoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782890906; x=1783495706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8VjUfdfZIvWwH5/Y6PbKw+VndA5OxOoRyB1H70fxh0=;
        b=qDVz8AAt63VvqMDdm9VpKI1ZzHntYmhRYRIzekRsGu2iL7Re7XPM77m1DMNgQn3nov
         Ckwrl89CSE35BLdi27IvczCP6QWtr0MObiRBz8YDoWGnj7YksoMzZjh+uo0iDnNsrHup
         TpfzCbwsPtZH7p12FjZOryTRwnlHX9yXyilKuGYi5vvetCXrRDLuvLcR3cwOXThm+SX0
         9yJsjpTo4qQD9OwJ6Ppp9U9cmCcf1D4SB4qiRZBuw9MYwMCnXE4lHm80vXGoamnnTqLD
         heq3ufD8R/MPOmxGLXm3rjN3AMV/MjIdzs12WmBcGjtbWHpuJWUTWp3C9/PWNZUO/kVl
         BtrA==
X-Gm-Message-State: AOJu0YyJfbQSmLIiKNWHn8LjYj8k6MbZBErd/a2Yc8rRH/9Izpa+ZXOt
	Gn4VhsZhoDVyFH90Kk83+43L0BpK8w+SLzYWCyhUgx8HS/EJ1ovWWbCb
X-Gm-Gg: AfdE7cmjxRrCN6xkN1YG3855GQS6aL7cXA9FUO/5/cGgtOiGI1F7fF94Yz1xxk2LvMV
	pRDXNUo22d3/h5KaNrbkAQtLxJYzkKv/DDJIZue0M7AaLklcIfbUnjkzSt33nwTx8A/oAdKzegG
	2dQW6Z2nY2Kf/48V4Yx4kO44JgYuk/wMOe5KFR+yvaNrRkoATiyaooVfC2IXacH1c0ht660w9gd
	ZyJJEiJVytHJENmyHuFW/ganK9nqeM5pPtnUGcVtPlCyXWiqlkU1pWMXhZ0FUrRr8LQo4T2Z1p/
	Pg6qdaWAqw70xxEJYLH/JzVOuRv81nfbq8fK6ABHGhwnoFQrRq8icZybJr3dHXPdR87+5GYidiA
	dSrLLCMki97jWIYvWlYQcNbSli4/a1+bufvu54v7HFELMJBpKYwCyHBno4I+eXUaMKSN4ix51wa
	F2FUa/lgypML+HcwYAlr6gmGbTe3pai2AvHUs+vuqI7f49jcdZ25tPR3KyaHDz1X7uU3dPlMplB
	/cY+rLTW3Hv3NcjYBgk6utjfdlduJwIiMU70PfnVQ9hZpz9oYxSASivHZNu/9P3uy3Zn09z5br8
	+9iujIHzT+su+nmninHgPt8WSLkavl5Q2AoXGM1NxTFIGdRH9id//Iw=
X-Received: by 2002:a05:600c:6792:b0:493:bd71:6084 with SMTP id 5b1f17b1804b1-493c2b96797mr6242155e9.31.1782890905836;
        Wed, 01 Jul 2026 00:28:25 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm12805960f8f.19.2026.07.01.00.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:28:25 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:28:24 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: =?UTF-8?Q?=E0=B8=81=E0=B8=B4=E0=B8=95=E0=B8=95=E0=B8=B4=E0=B8=A8?=
 =?UTF-8?Q?=E0=B8=B1=E0=B8=81=E0=B8=94=E0=B8=B4=E0=B9=8C_=E0=B8=9A?=
 =?UTF-8?Q?=E0=B8=B8=E0=B8=8D=E0=B8=A1=E0=B8=B2=E0=B8=9B=E0=B8=B0?=
 <goorock.goopop@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [BUG] hid-sensor-trigger: poll_value sign unchecked before
 msleep_interruptible causes ~49.7 day sleep
Message-ID: <20260701092824.000040e4@gmail.com>
In-Reply-To: <CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3Lfyoj3RaZ2v4dg@mail.gmail.com>
References: <CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3Lfyoj3RaZ2v4dg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jul 2026 09:40:54 +0700
=E0=B8=81=E0=B8=B4=E0=B8=95=E0=B8=95=E0=B8=B4=E0=B8=A8=E0=B8=B1=E0=B8=81=E0=
=B8=94=E0=B8=B4=E0=B9=8C =E0=B8=9A=E0=B8=B8=E0=B8=8D=E0=B8=A1=E0=B8=B2=E0=
=B8=9B=E0=B8=B0 <goorock.goopop@gmail.com> wrote:

> KERNEL BUG REPORT
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Component : drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> Subsystem : IIO / HID Sensor
> Severity  : High (device permanently unusable until service restart)
> Kernel    : confirmed on 6.17.x; code path present in mainline as of 2025=
-06
>=20
> Summary
> -------
> _hid_sensor_power_state() passes the return value of
> hid_sensor_read_poll_value() directly to msleep_interruptible()
> without checking for a negative (error) return. When the HID
> descriptor does not contain a Report Interval feature field the
> function returns -EINVAL (-22). This value is implicitly converted
> to unsigned int before being multiplied by 2 and passed to
> msleep_interruptible(), producing a sleep duration of
> ~4,294,967,252 ms (~49.7 days). The process enters
> TASK_INTERRUPTIBLE state and appears permanently hung to the user.
>=20
>=20
> Affected Code
> -------------
> drivers/iio/common/hid-sensors/hid-sensor-trigger.c:
>=20
>   static int _hid_sensor_power_state(struct hid_sensor_common *st, bool s=
tate)
>   {
>       ...
>       s32 poll_value =3D 0;
>       ...
>       poll_value =3D hid_sensor_read_poll_value(st);   // can return -EIN=
VAL
>       ...
>       if (state && poll_value)                        // BUG: -22
> passes this check
>           msleep_interruptible(poll_value * 2);       // -22 * 2 cast
> to uint =3D ~4.29e9 ms
>       ...
>   }
>=20
> hid_sensor_read_poll_value() (hid-sensor-attributes.c):
>=20
>   s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
>   {
>       s32 value =3D 0;
>       int ret;
>=20
>       ret =3D sensor_hub_get_feature(st->hsdev,
>                                    st->poll.report_id,   // 0xffffffff
> if not found
>                                    st->poll.index, sizeof(value), &value);
>=20
>       if (ret < 0 || value < 0) {
>           return -EINVAL;    // returned when Report Interval not in desc=
riptor
>       }
>       ...
>       return value;
>   }
>=20
>=20
> Reproduction
> ------------
> Hardware : Seeed XIAO nRF52840 Sense (LSM6DS3 IMU) via USB HID
>            VID:PID 2886:8045
> OS       : Bazzite (Fedora immutable), kernel 6.17.x
> Drivers  : hid-sensor-hub, hid-sensor-accel-3d, iio-sensor-proxy
>=20
> The device implements a USB HID Sensor (Usage Page 0x20,
> Accelerometer 3D, usage 0x200073) with Power State (0x200319),
> Report State (0x200316) feature fields =E2=80=94 sufficient for probe to
> succeed =E2=80=94 but without Report Interval (0x20030E).
>=20
> Steps:
> 1. Plug the device.
> 2. Allow iio-sensor-proxy to start and attempt the first read.
> 3. Observe: iio-sensor-proxy main thread enters D/S state and
>    never returns. 'cat in_accel_x_raw' also hangs indefinitely.
> 4. systemctl restart iio-sensor-proxy unblocks all hung processes
>    (SIGTERM interrupts the interruptible sleep).
>=20
> Kernel stack trace (captured via /proc/<pid>/task/*/stack while
> process was hung =E2=80=94 iio-sensor-proxy PID 1011, kernel 6.17.x):
>=20
>   [<0>] msleep_interruptible+0x3b/0x90
>   [<0>] _hid_sensor_power_state+0x166/0x1e0 [hid_sensor_trigger]
>   [<0>] __rpm_callback+0x48/0x1f0
>   [<0>] rpm_callback+0x6d/0x80
>   [<0>] rpm_resume+0x4af/0x6d0
>   [<0>] __pm_runtime_resume+0x52/0x90
>   [<0>] hid_sensor_power_state+0x51/0xe0 [hid_sensor_trigger]
>   [<0>] accel_3d_read_raw+0xa8/0x210 [hid_sensor_accel_3d]
>   [<0>] iio_read_channel_info+0xed/0x110 [industrialio]
>   [<0>] dev_attr_show+0x1f/0x50
>   [<0>] sysfs_kf_seq_show+0xcc/0x120
>   [<0>] seq_read_iter+0x128/0x480
>   [<0>] vfs_read+0x268/0x390
>   [<0>] ksys_read+0x73/0xf0
>   [<0>] do_syscall_64+0x7e/0x250
>   [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Note: the process is in TASK_INTERRUPTIBLE (wchan=3Dmsleep_interruptible,
> STAT=3DS), not TASK_UNINTERRUPTIBLE =E2=80=94 it responds to signals. Thi=
s is
> why a service restart (SIGTERM) unblocks it, and why it is easy to
> mistake for a runtime PM deadlock rather than an unchecked sleep duration.
>=20
>=20
> Proposed Fix
> ------------
> drivers/iio/common/hid-sensors/hid-sensor-trigger.c:
>=20
>   --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>   +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>   @@ -143,7 +143,7 @@ static int _hid_sensor_power_state(...)
>           poll_value =3D hid_sensor_read_poll_value(st);
>        }
>   -    if (state && poll_value)
>   +    if (state && poll_value > 0)
>            msleep_interruptible(poll_value * 2);
>=20

Yes, this is something that should be fixed. Can you send a patch?

--=20
Kind regards

CJD
