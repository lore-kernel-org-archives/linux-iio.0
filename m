Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449182236FD
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873666; cv=pass; b=jgNE4aEuFBxSXGR9mFmPQCGUPiaAWunQ0YPbG3DgMn29oNATqw5e4Nhz3U2PzU90KcyAIzaGAa7Oz/oUfFDWzBNm+WJG5mNhx3MZagsrDWwLrPEF4SIti2padb31AtT5yUHoPHJYrCJL9ZUDItNaGIna4qv1NRMg3KeZujd4p+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873666; c=relaxed/simple;
	bh=qAkKtUrd9Ne1eZsEQ+WSUR/Lz7x5P6Mpavp67CMjyrY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b1lpBI7YQ5x6jui4j7m+jHjpBqN4Un+zovgkeQRDoYsY8Plx3Y6GiprQRqx968ASYk6ghNytPdCugcGazjYbwXVHI3+Z4mVNjXEsqDyF3PobEzNOhMOs5XtvA2cCMzlYrZL8LgTR7yphxss/8o4xaXc2pDgza3nmvhztkSvJIBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9YpBL+s; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9YpBL+s"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-738f3419eedso46722137.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 19:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782873664; cv=none;
        d=google.com; s=arc-20260327;
        b=WltnP8S5aUR3p3N5KPa2Syz+lxtPFlGIICHzLD3Yw0bmfxbxe3Bcwl7yzxuHeYslh+
         ztfaszSBSrbD8ejEkW4t8xFs3fmgAGD6TOmD/Ni2LzB26GWWnEHH1EqIDOsU0/rRfqo7
         LnQUg0zeeAszAVLEepZxLPB4NI4hWOuMeRNxpDVkMmmcDAXEKXAe/zzadfhCZ1cKDb7A
         j/lqQ0haY9VtkyKSy0EFe5fyT4HTwdnW4ARe9twEc1SG1OdgSDEOxbdjdCdlF/tq1DgW
         2B8l3egWGOEu1iTNE35AabNTuMykHbQ+Hdhdq2a8xtd7X7di3fxRMOwbt3kd3F9UdJ17
         Y1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ep5o/xLe9uYIP9O3ZzOCcs7QDmYAHOx9nT2aivh6N5g=;
        fh=hn8x4jt5uSzrjEa/lTYDVl/h1bMOkfsjYLyLeQLW9Pc=;
        b=P1D97wVZU913Uq0pYiuo3f+YyCvdc+e+I1SPPNs86e+XTcPHpSegGxIEyHHUzJ4JM+
         lHAgTQRh4y00nZLHuKPJy0jYsbvAStD0FSOedjmTfCjfGFt3OUxQ7RiIAiU1nsGBebNj
         eXc/LONbJFHYXfLtASFcnlNQvMDiYYer1AwoUOdRryVVJ47KrnaZhKAf/0HM6/i0a0i1
         pJqsxaK1Rx9HaMJZM6TTcHXvMmu6g7tEgAJ9yCa3R/Jwx51+/3tCZKKRVrM4R8+UAU2o
         /74mIDOeROpG93Gv39o4nV8d5JXMNBgD3Q6NwLaRtdCArbZGNTUiSWLGod+N+4SHRwg4
         7KjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782873664; x=1783478464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ep5o/xLe9uYIP9O3ZzOCcs7QDmYAHOx9nT2aivh6N5g=;
        b=K9YpBL+s0rb9IZka9eSXmB529KTIobU1Q5LFzo3bOID29Klt/pXGYmbgJa9iHYC5O7
         EL3BSDZB0if0ZTzM3qw+PAYUVWFyntBtxS0FCa/KKBQrujGNf67AUaL10AiyaCc34/GP
         hge44qek+Si+GBCzoawGhe4g41yduDSoqxtD4DchrFmQunsRXYyD2gaUNJTabBjSPC4R
         /kFApB/H+15/Y0XZuLd1GEcfATKSltnMFjPn/J4R1TqxpJRpWrp0gQ7gAbHTk0aju6+3
         sXt7chP2B5wv7SqXKps8tzf177FgkElFslT06Gl0NKIxKqEHlQtd66hYVIBOytsgeeeR
         kDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782873664; x=1783478464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep5o/xLe9uYIP9O3ZzOCcs7QDmYAHOx9nT2aivh6N5g=;
        b=hgeFw0G0uTX3smNT/sRoRJv68qX7wBVRWhtmzfPL29MsTs5EiOYTOsU6Y/vdf5cEOM
         ufJz7I2c+YZV0yEH44emwk1PKrxc8eE1eADQPdgWYZ98i6NSTMcdq92QZkUwvI2oltCN
         kPhMepTMXLLrleCylrx+O7j+5b2M3eFwQS1/JvmKwfkiVkZpYfMmRPp1upaMkuLmTF8n
         232QFUTiV2M+2LkFkHF1hnJKhsV2v9uzcYSzjWF3FsDNIjB45xsAkGQUwrLKWzoyyoFy
         9Cd8aKDzcsfE5nQEgaHq4VfxFxuiYpqKFIELGcRquIawdfI3SmSDqGK5FZw0PYaXctmz
         T+lA==
X-Gm-Message-State: AOJu0YyTUIMz9sQUCIWPv2w418ko0wjWw66uNQavi+swI71D11ilmaU/
	767OS3rdR2CGkDz12TSR3Fc80gq36aXkSiZsU75e52KEi5Fd8NlhRLVqT28YFuF+hNFxheRIONZ
	7sSrVTsi+mcaAvLG7MlnMhlqsJqtXOWv9jqnbt54=
X-Gm-Gg: AfdE7ckz6jT2knl349HEI6AwvhQtcTBPw8BhDKpJqSuXkXtbdZj9aZR2VJYLmu3lmMG
	Eq/Tv3BoIYV7tMrH5fabTcnkAtdm3wbkUGsE82NSU5AP0fBBJk1zchTnoEd/0yiODWQum9ADnA1
	j9NPELc9/h9NJGOSk4hD+6pQCW0BnLgs9tjnphXnh5Llxt3L+swwxFnFHilg7DZFAPiFx+qDgu1
	uTZ9OD6Jh7uwOq7TqLvEl4yzag3f8Kh/7UaAK8glzrKOtt1VZFd/l1Kq9zRg4JwWOTKDY9L
X-Received: by 2002:a05:6102:441c:b0:738:8022:d74c with SMTP id
 ada2fe7eead31-73cb8af98fbmr1552157137.15.1782873664172; Tue, 30 Jun 2026
 19:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?4LiB4Li04LiV4LiV4Li04Lio4Lix4LiB4LiU4Li04LmMIOC4muC4uOC4jeC4oeC4suC4m+C4sA==?= <goorock.goopop@gmail.com>
Date: Wed, 1 Jul 2026 09:40:54 +0700
X-Gm-Features: AVVi8Cf-i8AOz0QdEUxVdER49hLSidI1lwrZ9i3pDKIUZ57l-oc0LQYjgHC_7iU
Message-ID: <CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3Lfyoj3RaZ2v4dg@mail.gmail.com>
Subject: [BUG] hid-sensor-trigger: poll_value sign unchecked before
 msleep_interruptible causes ~49.7 day sleep
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

KERNEL BUG REPORT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Component : drivers/iio/common/hid-sensors/hid-sensor-trigger.c
Subsystem : IIO / HID Sensor
Severity  : High (device permanently unusable until service restart)
Kernel    : confirmed on 6.17.x; code path present in mainline as of 2025-0=
6

Summary
-------
_hid_sensor_power_state() passes the return value of
hid_sensor_read_poll_value() directly to msleep_interruptible()
without checking for a negative (error) return. When the HID
descriptor does not contain a Report Interval feature field the
function returns -EINVAL (-22). This value is implicitly converted
to unsigned int before being multiplied by 2 and passed to
msleep_interruptible(), producing a sleep duration of
~4,294,967,252 ms (~49.7 days). The process enters
TASK_INTERRUPTIBLE state and appears permanently hung to the user.


Affected Code
-------------
drivers/iio/common/hid-sensors/hid-sensor-trigger.c:

  static int _hid_sensor_power_state(struct hid_sensor_common *st, bool sta=
te)
  {
      ...
      s32 poll_value =3D 0;
      ...
      poll_value =3D hid_sensor_read_poll_value(st);   // can return -EINVA=
L
      ...
      if (state && poll_value)                        // BUG: -22
passes this check
          msleep_interruptible(poll_value * 2);       // -22 * 2 cast
to uint =3D ~4.29e9 ms
      ...
  }

hid_sensor_read_poll_value() (hid-sensor-attributes.c):

  s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
  {
      s32 value =3D 0;
      int ret;

      ret =3D sensor_hub_get_feature(st->hsdev,
                                   st->poll.report_id,   // 0xffffffff
if not found
                                   st->poll.index, sizeof(value), &value);

      if (ret < 0 || value < 0) {
          return -EINVAL;    // returned when Report Interval not in descri=
ptor
      }
      ...
      return value;
  }


Reproduction
------------
Hardware : Seeed XIAO nRF52840 Sense (LSM6DS3 IMU) via USB HID
           VID:PID 2886:8045
OS       : Bazzite (Fedora immutable), kernel 6.17.x
Drivers  : hid-sensor-hub, hid-sensor-accel-3d, iio-sensor-proxy

The device implements a USB HID Sensor (Usage Page 0x20,
Accelerometer 3D, usage 0x200073) with Power State (0x200319),
Report State (0x200316) feature fields =E2=80=94 sufficient for probe to
succeed =E2=80=94 but without Report Interval (0x20030E).

Steps:
1. Plug the device.
2. Allow iio-sensor-proxy to start and attempt the first read.
3. Observe: iio-sensor-proxy main thread enters D/S state and
   never returns. 'cat in_accel_x_raw' also hangs indefinitely.
4. systemctl restart iio-sensor-proxy unblocks all hung processes
   (SIGTERM interrupts the interruptible sleep).

Kernel stack trace (captured via /proc/<pid>/task/*/stack while
process was hung =E2=80=94 iio-sensor-proxy PID 1011, kernel 6.17.x):

  [<0>] msleep_interruptible+0x3b/0x90
  [<0>] _hid_sensor_power_state+0x166/0x1e0 [hid_sensor_trigger]
  [<0>] __rpm_callback+0x48/0x1f0
  [<0>] rpm_callback+0x6d/0x80
  [<0>] rpm_resume+0x4af/0x6d0
  [<0>] __pm_runtime_resume+0x52/0x90
  [<0>] hid_sensor_power_state+0x51/0xe0 [hid_sensor_trigger]
  [<0>] accel_3d_read_raw+0xa8/0x210 [hid_sensor_accel_3d]
  [<0>] iio_read_channel_info+0xed/0x110 [industrialio]
  [<0>] dev_attr_show+0x1f/0x50
  [<0>] sysfs_kf_seq_show+0xcc/0x120
  [<0>] seq_read_iter+0x128/0x480
  [<0>] vfs_read+0x268/0x390
  [<0>] ksys_read+0x73/0xf0
  [<0>] do_syscall_64+0x7e/0x250
  [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

Note: the process is in TASK_INTERRUPTIBLE (wchan=3Dmsleep_interruptible,
STAT=3DS), not TASK_UNINTERRUPTIBLE =E2=80=94 it responds to signals. This =
is
why a service restart (SIGTERM) unblocks it, and why it is easy to
mistake for a runtime PM deadlock rather than an unchecked sleep duration.


Proposed Fix
------------
drivers/iio/common/hid-sensors/hid-sensor-trigger.c:

  --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
  +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
  @@ -143,7 +143,7 @@ static int _hid_sensor_power_state(...)
          poll_value =3D hid_sensor_read_poll_value(st);
       }
  -    if (state && poll_value)
  +    if (state && poll_value > 0)
           msleep_interruptible(poll_value * 2);

The single-character change (> 0 instead of truthiness check) ensures
that error returns (-EINVAL =3D -22) and the value 0 are both treated as
"no sleep", which is the correct behaviour when the Report Interval
attribute is absent or unreadable.

Alternatively, hid_sensor_read_poll_value() could be changed to return
0 instead of -EINVAL for the "not found" case, since the caller at this
site treats 0 as "skip the sleep" already. Either fix is sufficient;
fixing the call site is safer as it makes the intent explicit.


Workaround (user-space)
-----------------------
Add the Report Interval feature field (usage 0x20030E, unit Millisecond
0x65 0x19) to the HID report descriptor and return a positive default
value (e.g. 50 ms) from GET_REPORT. This makes hid_sensor_read_poll_value()
return 50 instead of -EINVAL, so msleep_interruptible(100) runs instead
of ~4.29e9 ms.

This workaround confirms the root cause: once the descriptor includes
Report Interval, the hang disappears completely across cold boot,
suspend/resume, and USB re-enumeration cycles.


Additional Notes
----------------
- The bug is latent in all HID sensor drivers that share
  hid-sensor-trigger.c (_hid_sensor_power_state is generic, used by
  gyroscope, magnetometer, pressure, light, etc.) =E2=80=94 any HID sensor
  device that omits Report Interval from its descriptor will trigger
  the same hang.

- The dmesg warning "No report with id 0xffffffff found" (from
  sensor_hub_report() in hid-sensor-hub.c) is a reliable signal that
  a descriptor is missing expected feature fields. In this case it
  appeared 3 times per boot for Report Interval, Sensitivity ABS, and
  Sensitivity REL PCT. The Report Interval warning is the one with
  functional impact.

- Tested fix on: Bazzite OS (Fedora immutable), kernel 6.17.x,
  Steam Deck LCD (AMD Van Gogh SoC), iio-sensor-proxy 0.4.x,
  GNOME 46, with USB HID Sensor device (Seeed XIAO nRF52840 Sense).
