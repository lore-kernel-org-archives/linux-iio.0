Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138237D10C
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060981; cv=none; b=thiqRwPVV41IaqdbBFKBaCONmlEVAbPC1Zh3J06QgL+u2iAM5A7GD5kgeBQMGPiOvk+A0X5yBeVYGcz1fbRaOPsh5QeHdhcK+9OeaYOE87Qya11F7XpmBtSQ7DOejjhBToawMuYaQMBU4igzVkjCmljTW0hEzNC3RGF4hFFPAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060981; c=relaxed/simple;
	bh=Lv/QgXerDHkBYlnEgo+QNgRQf461nSCPNSQ9zeq+4Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5PDYGdEUq6MPb5H3lQrHVQoaCbH67ngUFSXZ89bc5/nC45OWQtU6rU8I1BGoix3cQ5xd4sOuiZr+N18qPGZ/176xHjfxTezm1MMW5/gI1pTbLHHe+4l3crUopVzCqJ3SloU2k2Ds6DwfX+rp76ARvhFhacHSi6X6a38ZB3tq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5cG1Fra; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5cG1Fra"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-479b7aada85so224345f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783060978; x=1783665778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v+sqymlOvxvkOi7TZXL6sHTdLLN7fEoTwyaDCo9neQ4=;
        b=D5cG1FraBR0T7TjrsVIaoo1a2AlkhqEG+LzZzAXlEygAGmdT9t8ZD1E19LS6dqPXLL
         M1SJql0DIqIlvxVWKbwHrdJWvtOlHrrhAntBxwYZxgroNgZZtakxRPhbwNxmlVFTGZ3u
         +tQIiYYrZAuRKDEbWV1LZIC3FDNpf0JbFpHVrIQHXNHvT0BXva4CG86IelZpyBSTP1qp
         yc/A+KAlZTmiVmbxVpH7djQUYBA8lF+sr9FV99GGmVEBEia1BmPrnNpmAj9wBTq591/+
         wRCQE49+/P25Qyvj1aMbbubpl0TuViOnGjwj/w0636mrPwg53rvlm+Rh4PvGi6HsLQjq
         tVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783060978; x=1783665778;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+sqymlOvxvkOi7TZXL6sHTdLLN7fEoTwyaDCo9neQ4=;
        b=olvjtrOj9wXNSIweLlZIbAeJzjAbsit25qXSat/OYFyv+dyQ+yhrFUeDdxahJXk+pI
         6A3AjTS1OpVB0ZrUZtvn512pB2ueNPzXg3yq3IzfWSAQTNQXfDbYZSLDIhTMsjitTLlu
         XFYVVwpfSQhzCOAIlOQcqUeQd+tpOQiYcy5PfoIPqfZPLZx+CE02Ip1KWuo6u2IEMrzJ
         QlDjoKBuGl3p+633jEzAXZYT3NicBsfEZNzG+4xz+CcXmKfTUTWOvo9S3V0D6qhXvzjS
         MOWfT3mATlHr7/GIPa9YkkAG9XPV1tjX26+Znmx0BQaMzDdv3JeHr0CjbJSAkQSdL8ty
         kTeg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9mUTLYi1/SAg7EQqsReyMOVTUp1WaRIN9e/F18v2EeSHXVRABX4BByaloHmFTD3buonhJNriHcWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIEeH2y8ohWMG3ZpRKG/x3f8+IQqfJfQ8bBzfj9rJ/OGn7lHd
	tFSwolHKB4pGWh3EVQmGr9KAMtC6VcE+lnnJgR+KnIlNZIHMSVk2r+zJ
X-Gm-Gg: AfdE7cm8CWxGWdWw7sMWVI8OSltOGbcoKPkqn0LfMK0ixMEo5qs/QMT9oYyVnfchjr7
	xVNWH+SKIJKnMCVwLaxb/gQZ9W4BV+TG9IkuwLG9FnC/Er+N/yFrUgCnPEbD48dnTzXc1fM10TI
	LXfnaSsbxqsHtgeKip9KDMZUg1iBUN4saj58aRyqeel2I0y0wtMbBbYN4pOOxno/F/VwPrhnoGI
	sRYV6qAxlXfmqt8LIZHbYhrpa0YgyK0kbKhfmoLBIGOBJ4UyeJCaNPgA/P1WPme9Qo2MMpsrPk6
	9zkRi2++3Oz3fSFCCM2gxf1Z6BpRDMIVNcHrjsZLoH3afu69gUx+LZE+XQb5E9W1uTDIs/tUmAp
	L0ECXLLYXjOwGGsi/0WBQ3jxvZBFf6WR9WNghkRKeIqj/XYX+QrI6tapepgmHel6vYx0Q5epr0p
	twU6/riouk2yMMeZF1bXBsyy/uKe1TdD4quK0XrY4zvEpf2uaquoeIYi9cWkfN2obE5FWOIrcxt
	njtsbVB2erLfqtqYUSUfcPENyqeP/fTugoMfNyO58BKrddkohcRzMdpsaQz6mr3mAwC068Uqp7+
	wISoFjJIsp3DM8kl+pU5sZw/vpFDNTwR+TID8pTrLrjijDYnk8iWCPA=
X-Received: by 2002:a05:6000:26d1:b0:473:6e8d:7f3 with SMTP id ffacd0b85a97d-477b34b02f8mr12884086f8f.1.1783060978076;
        Thu, 02 Jul 2026 23:42:58 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94c829sm15326806f8f.24.2026.07.02.23.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:42:57 -0700 (PDT)
Date: Fri, 3 Jul 2026 08:42:56 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "open
 list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor
 driver
Message-ID: <20260703084256.00001f7f@gmail.com>
In-Reply-To: <20260703003159.44850872@jic23-huawei>
References: <20260621004626.66629-1-m32285159@gmail.com>
	<20260621004626.66629-3-m32285159@gmail.com>
	<20260621203303.0f8c5d08@systembl0wer>
	<CAKqfh0HUih0q9PEh+5pwwMuBBkm6nsaZP9e2yPjHO3+Yccuvgw@mail.gmail.com>
	<CAKqfh0G1dcn4MLQ5jxjM8aDHVu=z-NEAR-y=xMjfOiW7M_HF-Q@mail.gmail.com>
	<20260703003159.44850872@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jul 2026 00:31:59 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 21 Jun 2026 19:09:11 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>=20
> > On Sun, Jun 21, 2026 at 7:05=E2=80=AFPM Maxwell Doose <m32285159@gmail.=
com> wrote: =20
> > >
> > > On Sun, Jun 21, 2026 at 1:33=E2=80=AFPM Joshua Crofts <joshua.crofts1=
@gmail.com> wrote:   =20
> > > >
> > > > On Sat, 20 Jun 2026 19:46:24 -0500
> > > > Maxwell Doose <m32285159@gmail.com> wrote:   =20
> > > > > +#include <linux/array_size.h>
> > > > > +#include <linux/bits.h>
> > > > > +#include <linux/cleanup.h>
> > > > > +#include <linux/crc8.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/errno.h>
> > > > > +#include <linux/export.h>
> > > > > +#include <linux/i2c.h>   =20
> > > >
> > > > I am a numpty as I also forgot to mention a missing
> > > > mod_devicetable.h header.
> > > >   =20
> > >
> > > D'oh, I ought to look at my includes a lot more closely as well.   =20
> >=20
> > Forgot to mention, I'll be away for 2 weeks starting tomorrow so it'll
> > have to wait :( =20
>=20
> Don't add mod_devicetable.h.  There is a series from Uwe that splits that=
 header
> up and puts the tables different headers. i2c.h is now enough.
> (It's causing merge conflicts)

Cool, one include less to worry about.

--=20
Kind regards

CJD
