Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0064DEC16
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953415; cv=pass; b=KCqF0muFARN3jzURMgWddCRbNo8YCrlr2fd+2Bqqxqmg8H8Odge3/Z2Nfr0TQY6JK2WqOTwKohi0uj19HUnM1xaVygMjIUBDQy3w9HkX//+jbsRbdB7kCeL3GEHPj27eVJWk79jwvyXQXEbyqtsHpIEmVGvhSDSf7tesv1tsSJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953415; c=relaxed/simple;
	bh=MXyuGKEUfSfyI+2p8AQyIzhlojUOxHG3SgkwuZvXZfA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hfsR4CLsif7gEC2KQ8yz5f23TX1oWtAaFmr1mEzWtP1gQgasmCRD425PVaMkbZW7G8Es23T+uX485sh2FcVRz7Kt2NoN7aFNPZMjgObsHmcZhmBUCndhVa+FmsnShb7xMsofqJPT9/a8blExpMY/prJcXNsg5CISLyusGWinSi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWT8Hrwt; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWT8Hrwt"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2a99so2533fac.3
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 08:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790953412; cv=none;
        d=google.com; s=arc-20260327;
        b=sUFFXxRqr6oqDQqn4K8unhkZb9jWm3HgiUF/iB/KhD2mYNXnWom8Db7y4UVaWRI9jt
         nqhaQYLYZzXBAlejgrLVibIh9kuA950i71ijNjc0oq7/h87GBWWahNoq4IQCqlmkaRfg
         uD386M7tvyYmRd7gXtuaPFAbD7dYiEABq3qZKo2CasjsVr2CVUDG5OJTCi5mF7CZafXa
         Mgvr3m4Bn4SDnKWNIRW/m05ZhdhCxKZTzgs/k51MpC3vLtk/9zSzxfzMYq5Tw3zkPhQP
         VWwwOaOGhGOTdUJbjH17Pq0b0oI1eTZ25Nw3T5538HOxI36MDjEATAQaM0c4B6euYhGe
         iJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8lTEaWqVn4XhZj9xrbkD7eCvnZ674Kwfjo0RvvsMlAU=;
        fh=ASKZPVIdaUJkIgaZJkvbMdiNwINbxQ+wJ/J06hnm9GM=;
        b=YayJQlbMHvzgF8m8ndiIrMThhBZTe9TVuFzbRQng7fpQ4RZtRBY7EL2fDW07K6iXKj
         rVa86lktxg7zt1VjJn74AYzFR/qGIrKpUjqD/e+Dhh02hNWHLA6BI3Nr+5B6sleZJuIf
         7jfWk8aXnKqRdXpu8s8si8hbS0Q6zZ0yJeKGKdsYcFCh2ReX7lZTQKUWqYa2Rjs3cr0a
         HDM/5Ih7L8+WU5gsQ/F+olYQXBEXnSeMMpw/30J6Swn8xzrJALgSYE+EQaUlozqqjp4U
         FrZAwQD6RPk4AdYpe/E09SHaPmtau2UQ9s9BgeqhOtrlVztTyW+cZVAAyM9AKQ7SpxzJ
         r18A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790953412; x=1791558212; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lTEaWqVn4XhZj9xrbkD7eCvnZ674Kwfjo0RvvsMlAU=;
        b=qWT8Hrwt70EpGXrcRGGFyeuM9hH4ljVDMzz+3IJ4GNaeG7f2sOZDOKRQlQKFbq7Y+V
         +pi7WzxITaEYyz5p5ibyc+Y2XT7ZIczTQ+5ZRzy8pJ4k3sQ/ahVEl/2bdne9GmshL9LD
         7fxEdTzDXvw7si9RwaiJ2iUOMC8nWJCDaJN60/zgJFbI4wrbqSvYhcTg2zTC5rVXhEc0
         /P/EnCNmDfkikMgAa+Np1qb+uPcRMidDjr679M4DYtRP1u+3m6J0AubEo5a3JDXD945y
         IsS3zoyj9Bb4YPmeSbetqCU7CgiWAzlnTstm2gyao7N2d9wJ6/QiW3YkxxJefth+Mpdj
         RlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790953412; x=1791558212;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8lTEaWqVn4XhZj9xrbkD7eCvnZ674Kwfjo0RvvsMlAU=;
        b=2fXVDVfaOg3Nwgho3t4OG0MpcenoagayXYx4TiAVXIEmpyeHZRKLNrUWPtvMrAS6Lg
         foJvlvtf0aZstLO1CJ7wuqW0lLo6rsUvx3WQ7OAVQb4C+2medEjKyspdpNbwcdL7sz/n
         eI+zRn8PD15wOkuQBE4E+lHpdEWJI5umwP+rQeNNp0OGitnQ48yqaNcdInHevQPJFo+V
         1AJKTzIRdAe3cXjmza/88QVUl1oF2Ui3OLKCRREABDrcsXGwNYSfyYio2Sn4xSTkoebg
         +OgCr5oLWAOaP4QSAFGMjNoZhCYA89p5rElQtniJgr4D1za1YkjdSirpHwr4sZnZj6KQ
         ZYMQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5l228PlkQQ+LxF7B4Sk4fzQFujZ8fw6F76VZnb53hERhAUeAv5x0Ze4a2YTJ41oWexyemDehHjV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBKphTbaTbMSujxS3p0atEJMfouM6lL+k3oLlDZy150v+9xfl4
	wlZQyaBnySJq1PcnlmBqQ4TKNVxsftstzk+YQArpvg/ZagikiMOpIyNiGn8gKW1LKAAwz7b+kPs
	l9hCSzDWbZqtOwVU+OoUbiOhlaBr9Q+U=
X-Gm-Gg: AYBFou2UT5lMuuiUqo7gfp6TpAXosRCG/WbwpuQZ6sgP2ZN7AiGfTk/sdqYVuX4Y5NZ
	OZIXYnu/d8Fwj/UZWF5L0/G95Fad0anmpe2jqG0uGinbhIW/P+IG6Ji2mKsiEdYuLMLi7uqN5Pk
	lfF2RuIY3Aly/XnuFDWqkZMmuMoeRqBOtlQsTdV/NQ905ar19qRUGXO0/YV+CfMebQEx8Uh1Aul
	kZK8aM6HncDrpOxrsvsy588/7EMz/Q02/X7+m8kOUEp+ATxx5hxasP5IyGq95eZCSSjRxWbSUIY
	0a4ClHg2/fiFjFY7o2HFKUKrYKUD8YKpl0GTLOsTVjnJNcB2F0Uu90RmbBW+Sck5xFgHR0VDCEP
	KvCMaf6Uxaw==
X-Received: by 2002:a05:6870:8317:b0:48f:e3d4:d45c with SMTP id
 586e51a60fabf-49e15ecb7c3mr2560343fac.59.1790953412253; Fri, 02 Oct 2026
 08:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrej Scek <scek.andrej@gmail.com>
Date: Fri, 2 Oct 2026 17:03:21 +0200
X-Gm-Features: AclHuK9lgIwoonEzw54BF2CV4ZLaFO120r5yd1MlEhGJg1CKBsqg6KdWM4n_Kv8
Message-ID: <CADrS85612m-Hh-G4BJmOhy-y6r3Ni3kD8_GM-2QRBeWWEEZWuA@mail.gmail.com>
Subject: [REGRESSION] amd_sfh: accelerometer broken since 6.19 ("Event data
 for report 1 was too short (15 vs 14)")
To: linux-input@vger.kernel.org
Cc: Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, srinivas.pandruvada@linux.intel.com, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hardware:  Lenovo Yoga 7 14ARP8 (82YM), AMD Ryzen 7 7735U (Rembrandt),
BIOS LCCN18WW (2023-09-16)
Distro:    Fedora 43
Component: amd_sfh / hid-sensor-hub / hid_sensor_accel_3d

Working:   6.18.13-200.fc43, 6.18.16-200.fc43
Broken:    6.19.12-200.fc43, 7.2.8-100.fc43

Description:
Screen auto-rotation stopped working after updating from 6.18.16 to 6.19.12.
Since 6.19, every boot logs repeated warnings from the AMD Sensor Fusion Hub
accelerometer, and iio-sensor-proxy never receives usable orientation data.
Booting back into 6.18.16 restores rotation, with the same BIOS and userspace.

Kernel log on 6.19.12 / 7.2.8 (zero occurrences on 6.18.x):
  hid-sensor-hub 0020:1022:0001.0003: hidraw2: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
  hid-sensor-hub 0020:1022:0001.0003: Event data for report 1 was too
short (15 vs 14)
  (repeats 13-86 times per boot, whenever the device is moved)

Occurrences per boot, from the journal:
  6.18.16: 0, 0, 0
  6.19.12: 13, 31, 21, 86, 70, 39, 19, 25, 74
  7.2.8:   12

monitor-sensor output:
  6.18.16: === Has accelerometer (orientation: normal, tilt: vertical)
  -> rotates correctly
  7.2.8:   === Has accelerometer (orientation: undefined, tilt:
vertical) -> never changes

Steps to reproduce:
1. Boot 6.19 or newer on this machine
2. Run monitor-sensor and rotate the device in tablet mode
3. Orientation stays "undefined"/unchanged; dmesg shows "Event data
for report 1 was too short (15 vs 14)"

Notes:
  - Not bisected yet. From a quick look at the git history,
drivers/hid/hid-core.c
    and drivers/hid/amd-sfh-hid/ have no changes between v6.18 and
v6.19; the only
    hid-sensor-hub change in that window is b3e5bcffda37 ("HID: hid-sensor-hub:
    Use pm_ptr instead of #ifdef CONFIG_PM"). So the cause may be elsewhere.
  - iio-sensor-proxy 3.8-1.fc43, GNOME Shell 49
  - Happy to test patches or bisect between v6.18 and v6.19.

Additional info:
- iio-sensor-proxy 3.8-1.fc43, GNOME Shell 49
- Happy to test patches or bisect between 6.18 and 6.19.

Fedora bug: https://bugzilla.redhat.com/show_bug.cgi?id=2545224

#regzbot introduced: v6.18..v6.19
