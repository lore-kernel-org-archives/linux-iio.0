Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D2399358
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877162; cv=pass; b=W9leiJDvSUPJ9F0M9eP2scQigA1NnQGNMJbmbH/YNwRQurHaziypIAae+yfn+oaNSCDrRixHJ1eisQ2vuQfTigj7XmLpDlzkRSnzcjoI098c93uIY1zGWQsSWPZtxk1cXHfd4EJIJJR3OnsYN59ndyU99YHBULbvv30UpThYhBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877162; c=relaxed/simple;
	bh=xGUvizPuVEq9S/D//hkOZzPE/Y56rvO9KY90rU8622g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BELXjgNqkZ5KmtgnJC2sNOQLLsR/THWAXTNSRiiUOT6cZ31b4aAqX2WE9CS7WZYPuRXjmGbqmz0zgjVQpWoqsJzFkiO07kn6STOhFqy71nEU0jAwOgRGHGKZv46rkeMLduyG3H+TvmIrnjwvr5nt+QLC26ZEFIGO24SyXYMlM2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbcdqQCt; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbcdqQCt"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51ca5143268so182721cf.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 00:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784877160; cv=none;
        d=google.com; s=arc-20260327;
        b=fkr7M/f205qDVeSK7OJoy4uZtuUiEEZ/Le8zv5fsuXRMct/Pa11kCq8F+8wFMVjHZy
         7QBie6y42iPTlNdisoK7sn2TmibjmNK0zgWf8YiPiXJe9/m11qVNKF9QAN+x9JpEO/B5
         P3dz7l/e5dXfs3BltNKTdJCNnplCtGVv11zPmJRvUyabji2AGn9pgohNiryqeISgJJCT
         If9sq7zkrG6wDJWBnoJj+O3woiC+MBoUp3hkFHC6BqGxhwUcSQUkftSPQeIDOxB3xP9d
         fdv0b+YIA67vkH1TOXMz2xs9ROL6Fx6apVpmXYVA6FAvWCPOju0/30OUBaS/JlBEORiS
         0y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IC1GTb3TLPTeqAoieueA9lJNkRWp5M+M/cNZOJoVguk=;
        fh=ENEHOXhs+SzRHHWC0s/xLpEqsewcGxhoUlZCEBmpc0M=;
        b=TJVRsYtsUDdKmTtxRnHgUpfc8mdfZFdywyyajbRQOYubG3GaOh0KXiYN2I7tmDxrO1
         CJXRKEulDtz7AGp5McLwTwHru2v+Lm+ck1pZosyEiu8WnTKliUeUW4pkUKVp2VCv/3VP
         Tusa8IdV4htaQurZDBrWl0IFynIlmC3Y8DiXYDGqK2cQFMu6JPdtYZEdNjMxI/M3sJzh
         DC8wKCXHm+KCZm/qOaKVHfrp8OoB/sGE3sg5xWJcooWFsFsyCrIgpDfxTAOVcnV7oEve
         G2y90wSeC1SylkmsM+nfvRbESScKwMRSnBC7MpqLVPgbPoZPwwZXibldm6jl+4eqfAv7
         3nRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784877160; x=1785481960; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IC1GTb3TLPTeqAoieueA9lJNkRWp5M+M/cNZOJoVguk=;
        b=EbcdqQCtjg1WgoH3noeyFMHyHeQp7NKEj/FP59C/d4R8MEwDtHma5KslxQv/d2p9AK
         uBh+gx9fJ6gKN1978yHo46zGQRBJbt0QIieQrAL4Q3qtZQA/9A8I5e+RvQa94b1FJcxU
         6ePG1+Hs+eH7ZjrhBzFNwylLGI7AyF5cJk8KPpu9vfMELaOA0wPa2BBqnRVcA98RwtxJ
         BddBUqWcBHM5/nMBbiY1ca/DrBsftjLoofgn91sWv3MWl/0Cjts8DJGxqnOZyfbgQ/7+
         tbO6M4rg3Wt0z5yZjuKw0KlziB1y5udoL3+rrC2m+Kg/o60B2RmmamU2MsuprjkdOo8N
         Oj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877160; x=1785481960;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IC1GTb3TLPTeqAoieueA9lJNkRWp5M+M/cNZOJoVguk=;
        b=cRb0OVjktomidiwXvRtalVGxM0xWtf6KzXtuhfu8XF0HVvZFMZFq6JinGKDSOC2493
         xLwZoc2Equ3JKoiEX1fdlLSv/rawSL97I/SsxdO63xNdpEr7EB22iibBt/m3FUvFc8L9
         ftDO+BO+E6GIZqHEXxQoGjZ4jlfjj4uAIkR4YK98/JLZY+a+OQnkPCQOhXaDtI4wAVcl
         8EpgZJzwaq//ui+o2mbsdf0PEuW5mtnNgjWaPZHUm6vrytC/DB5cKqHEbb7be4pK46Il
         4KE7P9d76rSGOd1j/GG95ZFJ0eOXHeMv0QooyyvVD40Wa4hqRbsOGSxgs9TkXrT937OM
         9xsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0RT0tIk762C052a92s3KqtxhYu/GdwDK5eTxLRS/5XKB5BuPOlwHetOsWrBscLXkIWdJtvIisvx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjyrDSg/E+wzRZ+irpfWxfgqi/VDqCfDCTpL4BVaiy+bWInAqp
	dZFXJtekPEZUJuie/yg08mlQn0/jwlKtLKvtV7voW3PqjGk7d9TbWdo76gWcDQthU/8BztdWG9V
	+3lrpHft4RELFMm8BOnh7Wr37Buhrx8rVCQY5/r2aEg==
X-Gm-Gg: AR+sD11hGyMPULQC7q3XjxRF8YDPK7zCnJ6HW1nwfIfEsels30DqDX9njXRYjxvvup6
	jA1oov767ClN1FdiwuoGuRf70EDWk0ypSCjOh57se/lNOUnOg+ooGsuigHKNdvXQp9N8PzH0mgZ
	Z1va2sHB6FY7vP5la+0iLoxJBRCQ139hS+qOZ3V9e1OTiVM1Mc5KAR68+RVBE+5bea7QM+3r+8J
	Kfb5AeqO0FvO0SD6zpBJ+rGfdOKFgAP6y9K/8XeztdZLljChyiPDph5o1tUpSR+R3ArsburFLrl
	rmuq9ydnY6ci7Or07QSbqYp3/MFOLk664xqPmcIzIaPm2rUvTJmrtNYq9CLnqirxKyItAmcg+Au
	DtzeDQMPd4V//umF4
X-Received: by 2002:ac8:7fc1:0:b0:51b:ff78:f229 with SMTP id
 d75a77b69052e-528497b70cbmr22473281cf.5.1784877159685; Fri, 24 Jul 2026
 00:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Paul Perinchery <danielpaulperinchery07012005@gmail.com>
Date: Fri, 24 Jul 2026 12:42:29 +0530
X-Gm-Features: AUfX_mx8H9gltbQgDBIO4d85xHHxI01kSyYqQrP-Ki9e9wjpNV70u7MN3JR24xM
Message-ID: <CA+8Hp=M3ynUHzcDshLup5G+HDs0XoWkav0R5k-00m+O7LbOv1w@mail.gmail.com>
Subject: hid-sensor-custom: async notification for input-report sysfs
 attributes? (human presence / attention sensors)
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been investigating why userspace can't efficiently watch a
hid-sensor-custom input-report value (specifically a human-presence
sensor, HID usage 2000e1, on an AMD Sensor Fusion Hub / amd_sfh
platform) for changes without polling, and wanted to check whether
there's interest in closing this gap before I try to write anything.

Setup: Lenovo IdeaPad Pro 5 14AKP10, AMD Ryzen AI 7 350, kernel 7.0.13
(Debian/Parrot, but this is stock hid-sensor-custom.c). Presence and
gaze/attention are exposed as separate logical sensors under the same
physical hub (HID-SENSOR-2000e1.x.auto), each with the usual
auto-generated input-N-<usage>-value sysfs attribute.

What I found tracing show_value() in hid-sensor-custom.c: for input
reports, it calls sensor_hub_input_attr_get_raw_value(..., report_id,
SENSOR_HUB_SYNC, false) -- i.e. every read of the -value file issues a
synchronous GET_REPORT to the hub and returns the live answer. There's
no cached field backing that attribute, so there's nothing for a
notify-on-change mechanism to attach to on that path.

Separately, hid_sensor_capture_sample() *is* a genuine async callback
fired on hub-pushed input reports, but as far as I can tell it only
feeds the raw kfifo behind the driver's misc-device streaming
interface (custom_dev), gated on test_bit(0,
&sensor_inst->misc_opened). It doesn't appear to update any per-field
cached value, so it isn't reachable from the sysfs show_value() path
either.

Net effect: there's no way for a userspace consumer to poll()/
select() on the -value file and be woken only on real hardware events.
The hub itself is already configured for threshold-based reporting
(property-reporting-state = 2, i.e. "Threshold Events") in my case, so
the inefficiency is entirely on the kernel/sysfs side -- userspace has
to fall back to timed re-reads of a synchronous, firmware-round-trip
attribute, which is more expensive per-read than a typical cached
sysfs value and awkward to size a safe polling interval for.

This seems like a real gap for the presence/proximity use case
specifically (walk-away lock, auto-dim, etc.), which is inherently
event-oriented and is exactly the kind of feature vendors implement
natively on Windows via push notifications from the same class of
sensor.

Before I put together a patch I wanted to ask: is there interest in
adding async caching + sysfs_notify() (or sysfs_notify_dirent(), if
attrs end up carrying a stored kernfs_node) for input-report values
specifically, sourced from hid_sensor_capture_sample()'s existing
async path? Rough shape as I see it:

  - add a cached "last input value" (+ a bool "valid") per relevant
field in struct hid_sensor_custom_field
  - in hid_sensor_capture_sample(), in addition to (or instead of,
behind a config/attr) feeding the misc-device fifo, decode and store
the value for the matching field, then sysfs_notify() its -value
attribute
  - leave show_value()'s SENSOR_HUB_SYNC path untouched for feature
reports and for any input attrs that never get an async report, so
nothing regresses for existing consumers

Happy to be told this already exists via a different interface I've
missed (I did look at whether this should just go through the IIO
buffered/trigger interface instead, given some other hid-sensor-*
drivers are IIO-backed -- but hid-sensor-custom exposes vendor/custom
usages directly via this sysfs shape rather than IIO channels, so I
wasn't sure that's the right layer to add it at). Also open to being
told the misc-device/fifo interface is meant to be the async
consumption path already and userspace tools should be using that
instead of polling -value -- if so, is there existing tooling/docs for
that path I should be pointing presence-detection use cases at?

Not attaching a patch yet since I'd rather get a read on the right
approach (and whether it's wanted at all) before writing one.

Thanks,
Daniel Paul
