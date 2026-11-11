Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794366705;
	b=RARus8GbWzSIqQg1PDR9XL4hb/eo/t4sPWZRALH3Sn4XfHQW9OImUI77dyj7N7ny4gBB
	 N6zN5LrMeRy14hTRY/YFxfn6Wtu0epKEm/ghmetMECk1ZgBefUo+efvdfF+UMDfYZQ0Ml
	 gjEU7FHROweY5SST43fAh7P+Xg41hW3uraw2akvJ8aRgNuXr0D+LDCK86hXTBJ8f4SJAr
	 vMetQwTN5WbfLxRJvtFcCI4Z8OCQsmbo/+CA4B+jDVaco3MRDg11qfhpk1/wRDG+5BhVv
	 fSRlaxSl/tIyu9lKQvz72ODHIawxXvoSBjM1AthNVL+WR8Bouqgw9p52nmXLmKQqzuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r+temhaowl0XJ/anU239LQ8gF9cvIIzxMmHoQ4oEdHg=;
	b=2bfRk0siW0wNcgIhYlaE7g3nMktMORoBERs/Ew1LTBo54d8Dwij0gx7RKdAbuY3iB3wm
	 9pP6+OvS3WZxoploKVoUE0t1kDXQF1qQfiGmmwnU1sfzyRBplzmddE2ClOiWuuXU2LOIU
	 3vNMhDwMlPeDWyn8BTKbZ3CQFE/KWN41Bu5jW0vLmnjtf7HyeKh0khOW2ipvVJ5pckhw6
	 rsrVUxcvIC3kCGunWhS5xtlPUu1H9N6p0okaNc+rUXgsIJ/PIeVaGyA0VMbBRiV7JccsZ
	 KasVlR4UJwvVCqOHiuMk0KqguGMAXQYCcT/TrnbgSHaElBFeJbC0ApqGLgZz5FxUZFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=murgatroid.com;
	spf=pass smtp.mailfrom=murgatroid.com;
	dkim=pass header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=ahr0TwL5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E1606A31C
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 03:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C26E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=ahr0TwL5
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36dbde64409so5697631eec.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 19:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794366704; cv=none;
        d=google.com; s=arc-20260327;
        b=V3BCQpRGXETAo8dAzmXYktmc7/mYnvV9k3jUcsaOjhDtLANkxag+LyCSfBr6tFQ0/G
         ayPECnM0usdp5QOpEvX50lEbwrhjlgf9VT87qPl8Bdm3GJSYpXJOezBKxZNsfAgH0jlr
         J9WyU0mJiJu66cPVLujN1vsjZ/CGDMiFKDoypE4u6MAmxpDRVKtRQ2xgnjRc+crc6kzH
         Q314WRTLrxMKaOoAMtsFECWcfyIZLVwhBkSS2R5Q2rwKhKJhc+lbgSe+N3fnHlXnPI4q
         AwD/2YikBpSWEjQIZ1nYnifAwyLMObCwMYYar7OhZFZlrl/pexiiFWVk1UwRS3myBs7s
         bXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+temhaowl0XJ/anU239LQ8gF9cvIIzxMmHoQ4oEdHg=;
        fh=oru9F0de6WN03s1T9mi0AG+hr2ZrUBNEv1LBLNlFQWE=;
        b=LdGO27ulX5IlFz/UHKwIyGZDSg7AI6EXyUxO3DDnhdVzQbWB/FqFZTjwV/+tucDRze
         qp+OEv9gbkHiR7W4PVwNy/JsaqDoMz823mRGcdxZeuTo95ReoKd/jDUlz3QWn1Q+wh8I
         o3/uoGPm1Wm+xGgI7aYE0wAX8JfQnwwY6fyQz+XPIxoWIUih1hNQyR3WGqeJVDX5mFtn
         9TYRlXiGaY6NHgQPyoHcB8JXWNfl1iA+Lx6ZNq4GfpWveOJvwS4rMLf+8sfzOwGz6Rbk
         RRCF4nbbx0jKBr9XQdIyFKCbkbYex1OAkh9g6QTGQRGPpR65n0p/ueep1fsOsCaiYHzR
         lLnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=murgatroid.com; s=google; t=1794366704; x=1794971504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+temhaowl0XJ/anU239LQ8gF9cvIIzxMmHoQ4oEdHg=;
        b=ahr0TwL5sXnss274qbskTXY5FmMPs2iFVD9HrT9uVudzZC/sj3d3unabJNQluhywMS
         IvwccBvLRok01eX2qO82HTDDomSYhoyPMh4DVYh4JUEedevvW4Q7zJF2roHE4t6Oggb+
         27lTmfSdauf3vipbuS5bHQ30aln7L9wdI/2ml8wSBxrFMZ4e4jmTtlLd9UQsn7CjCPiZ
         cczTGkTBsnontIFnTY2gMoVLM//Iu+c9ehsJLjsSFQTi+3SLn6n2jQteNUXruqMrPmGg
         dM64JYzmtir8m3mD5NZpr6HrHxJ5/OO63w0zFiRg/p884P3aPhqo58cOA6hdMpDB87l4
         ex3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366704; x=1794971504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+temhaowl0XJ/anU239LQ8gF9cvIIzxMmHoQ4oEdHg=;
        b=1FGrgYUQ99gKjiXcp87HPJRUfCcUjE8pf8nPCf0krOFfcwV7sudt9HoM1MMf7p3u2X
         NF6axowtX5dnLc9CmWuzDldwHFEf/R3W+faGTUBHSM8oDUsMKr4b8+qvyIyQtV/ktdwq
         sS02kgTDpeLhl01/PPLrKTjomBZB6CLKjAr8nrpvYxqnhyI3dNW2pa0YnsJDR6msZ1vA
         +jifo762OTdARu6Ec+/hoItp+1/TzLVVmlJGsUID5DNiQ5bgctd0gAfXXuogFS310cVH
         VesGMtzF25JBnaCpCcDo2kV7Kkj3fBZE+mRJbE+7wcxYkGDXgyU0e+x2bvpA8MDRxYBI
         CjZQ==
X-Forwarded-Encrypted: i=1; AL+hErHrDlpZgBDmyBuh20D00P7zOpavlUZiFbaqHmDS7rufNhgJE1y+Kmyawm88qgK1b0K0EJ5SVMIf4ZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BLPtqkyC2HEp2QSrYDOzIixhpNOCwi80GnFAXMvXLoEKjwYwM
	s0Q+DiJ6Y2ix0IbutGlcpFvgyyDibCbHU65ZleNPgzimvXdj7d3F5yZn1lbODmhdP7gxRDkuGhr
	Gw1qYZwigGZJV7/U6SZx5tc50tvK0izCBZrmfWvR/
X-Gm-Gg: AYBFou2UDmVEI6GLGbuFxxq+wYGP6A0bsa3Hsf1HIL8ql+LKJWiyJ6I1+crbTtR6kDW
	NMpX/uXnaBOfWNZ5KkODPnAnD7+bHji4wQ86dz+Y5RP9J3YHGmaZ5NualfXBMevY71VD2rm6P6u
	sdYsgepJmqrGHwWMmohqpHNtvaxE9Wi3cWKZWmzQgss4FukgFVrHlFBylvi+o/Y1rHI8ZiDpxge
	j+oOLKevXEuzJ7dGHED01szjFxbIPBb3RqR/UcoMmNmN6gD8jjSQNIuo+AQVlOjm2tWUwGjrkXA
	qtOhis1DsTGilVTsk0QYor7WazKqaeeNjR7SC6oEEBea/Si68CIyMu36y1EiAacIBy67T3swmBs
	T0tVDIeHaIrOgMOQ9rH+CSYUDZz8JZm/wTZMDXW1IuyBzleeksrEJsqETm4wGsGNaPIaNeQbMx9
	afXSfkAegD3DlAH30xGr1Q4LU9fOQFP76BMBiI6DpWMHxjQSXrCW+AWjnj
X-Received: by 2002:a05:693c:42d1:b0:36e:c9e5:33aa with SMTP id
 5a478bee46e88-376854ba4b9mr1792132eec.13.1794366703578; Tue, 10 Nov 2026
 19:11:43 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019023420.83976-1-ch@murgatroid.com> <20261102215606.5e36a2a2@jic23-hlaptop>
 <20261111025336.051fbbcb@jic23-hlaptop>
In-Reply-To: <20261111025336.051fbbcb@jic23-hlaptop>
From: Christopher Hoover <ch@murgatroid.com>
Date: Tue, 10 Nov 2026 19:11:31 -0800
X-Gm-Features: AclHuK-SGhvKm-m3dPF7X4f2O9KsRDzR0B5VWRGLdjPvi8wmwehWFpB8zvORHv4
Message-ID: <CACw0PsZ43YAQUcPuP7ec6gjd03Srn5QYUWp74SMZ0gzPLUp71A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lixu Zhang <lixu.zhang@intel.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> Dropped patch 1, that should go via the hid tre

Do i need to do that ?    Sorry for the possibly dumb question -- I'm
well out of practice with the process.

-ch

On Tue, Nov 10, 2026 at 6:53=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 2 Nov 2026 21:56:06 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Sun, 18 Oct 2026 19:34:17 -0700
> > Christopher Hoover <ch@murgatroid.com> wrote:
> >
> > > hid-sensor-temperature and hid-sensor-humidity share one static
> > > struct hid_sensor_hub_callbacks across instances and overwrite its pd=
ev
> > > on every probe. With two temperature sensors, reports for one go to
> > > the other's pdev; once that device is removed,
> > > temperature_capture_sample() dereferences NULL. I hit this on 7.0
> > > with two uhid-created sensors.
> > >
> > > Patches 2-3 make the callbacks per instance, as the other HID sensor
> > > drivers do. Patch 1 makes sensor_hub_remove_callback() take
> > > pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> > > unbind cannot call through the freed callbacks.
> > Applied to the fixes-togreg branch of iio.git with the ordering tweaks =
Andy suggested.
>
> One day I'll remember some bits of this driver are in hid.
>
> Dropped patch 1, that should go via the hid tree.
>
> Sorry Jiri / Christopher.
>
> I only seem to notice I've done this whilst writing pull requests :(
>
> Jonathan
>
>
>
> >
> > Thanks,
> >
> > Jonathan
> > >
> > > Changes in v3:
> > > - Patches 2-3: set the callbacks with one compound literal (Jonathan)=
.
> > > - Kept Joshua's Reviewed-by on all three; patches 2-3 changed only in
> > >   style.
> > > - Rebased onto v7.3.
> > > - Sent as a new thread, not a reply to v2.
> > >
> > > Changes in v2:
> > > - New patch 1, for the use-after-free on unbind found by the Sashiko
> > >   review of v1.
> > >
> > > v2: https://lore.kernel.org/all/20261007184423.622445-1-ch@murgatroid=
.com/
> > >
> > > Christopher Hoover (3):
> > >   HID: hid-sensor-hub: Synchronize callback removal with raw events
> > >   iio: temperature: hid-sensor-temperature: Use per-instance callback=
s
> > >   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> > >
> > >  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
> > >  drivers/iio/humidity/hid-sensor-humidity.c       | 14 +++++++-------
> > >  drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
> > >  3 files changed, 24 insertions(+), 16 deletions(-)
> > >
> > >
> > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> >
> >
>
